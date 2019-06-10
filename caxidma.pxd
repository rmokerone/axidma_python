cdef extern from "libaxidma/libgpio.h":
    void gpio_reset();

cdef extern from "libaxidma/libaxidma.h":
    cdef struct dma_transfer:
        int output_channel
        int output_size
        void *output_buf
    cdef struct axidma_dev:
        pass
    ctypedef axidma_dev *axidma_dev_t

    cdef struct array:
        int len
        int *data
    ctypedef array array_t

    axidma_dev *axidma_init();

    array_t *axidma_get_dma_rx(axidma_dev_t dev);

    void axidma_destroy(axidma_dev_t dev);

    void *axidma_malloc(axidma_dev_t dev, size_t size);

    int axidma_oneway_transfer(axidma_dev_t dev, int channel, void *buf, size_t len, bint wait);

    void axidma_free(axidma_dev_t dev, void *addr, size_t size)
