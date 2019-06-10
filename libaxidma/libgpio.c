#include <sys/types.h>//提供类型pid_t的定义
#include <sys/stat.h>
#include <fcntl.h>
#include <stdint.h>
#include <unistd.h>
#include "libgpio.h"

void gpio_reset(){
    int fd_gp = 0;
    uint32_t write_buff[2] = {0};
    fd_gp = open("/dev/xilinx_gp0_driver", O_RDWR | O_SYNC);
    write_buff[1] = 0x0;
    write(fd_gp, write_buff, sizeof(write_buff));
    usleep(10);
    write_buff[1] = 0x1;
    write(fd_gp, write_buff, sizeof(write_buff));
    close(fd_gp);
}
