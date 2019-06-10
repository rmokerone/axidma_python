import time
from axidma import axidma

import queue
data_queue = queue.Queue(maxsize = 50)
read_times = 1000
dma = axidma()
#dma.set_times(8)
dma.reset()
start_time = time.time()
for i in range(read_times):
    l = dma.read()
    try:
        #data_queue.put(l, False)
        pass
    except Exception as e:
        pass
end_time = time.time()
print("cost " , (end_time - start_time) * 1000 / read_times, "ms per read") 
