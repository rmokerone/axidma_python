# cython: language_level=3
# distutils: include_dirs=./libaxidma
cimport caxidma
from libc.stdlib cimport malloc, free

cdef class axidma:
    cdef caxidma.axidma_dev_t _axidma_dev
    cdef caxidma.array_t *_rx_chans
    cdef caxidma.dma_transfer _trans
    cdef unsigned char * _buf_rx
    # cdef bint _flag
    def __cinit__(self):
        # self._flag = 1
        # 设置默认采集次数
        self.set_times()
        self.dma_init()

    def dma_init(self):
        self._axidma_dev = caxidma.axidma_init()
        if self._axidma_dev is NULL:
            raise Exception("Error: Failed to initialize the AXI DMA device.")

        self._rx_chans = caxidma.axidma_get_dma_rx(self._axidma_dev)
        if self._rx_chans.len < 1:
            self._destroy_axidma()
            raise Exception("Error: No transmit channels were found.")
        self._trans.output_channel = self._rx_chans.data[0]

        print("Receive Channel: ", self._trans.output_channel)
        print("Output File size: ", self._trans.output_size, "Byte")

        self._trans.output_buf = caxidma.axidma_malloc(self._axidma_dev, self._trans.output_size);
        if self._trans.output_buf is NULL:
            self._destroy_axidma();
            raise Exception("Error: Failed to allocate the output buffer.")
        self._buf_rx = <unsigned char *>self._trans.output_buf


    def reset(self):
        caxidma.gpio_reset()

    def set_times(self, times=16):
        if times <= 0 or times > 16:
            raise Exception("Error: times out of range.")
        self._trans.output_size = 0x10000 * times

    def read(self):
        rc = caxidma.axidma_oneway_transfer(self._axidma_dev, self._trans.output_channel, self._buf_rx, \
                                            self._trans.output_size, True)
        if rc < 0:
            self._free_buffer()
            raise Exception("Error: DMA read transaction failed.")
        else:
            return self._buf_rx[:self._trans.output_size]

    def _free_buffer(self):
        caxidma.axidma_free(self._axidma_dev, self._trans.output_buf, self._trans.output_size)
        self._destroy_axidma()

    def _destroy_axidma(self):
        caxidma.axidma_destroy(self._axidma_dev)
