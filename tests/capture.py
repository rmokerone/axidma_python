import time
from axidma import axidma

read_times = 1
dma = axidma()
#dma.set_times(8)
dma.reset()
with open('python.dat', 'wb') as f:
    start_time = time.time()
    l = dma.read()
    f.write(l)
    end_time = time.time()
    print("cost " , (end_time - start_time) * 1000 / read_times, "ms per read") 
