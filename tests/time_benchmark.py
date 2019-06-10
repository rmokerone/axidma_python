import time
from axidma import axidma

read_times = 1000
dma = axidma()
#dma.set_times(8)
dma.reset()
start_time = time.time()
for i in range(read_times):
    l = dma.read()
end_time = time.time()
print("cost " , (end_time - start_time) * 1000 / read_times, "ms per read") 
