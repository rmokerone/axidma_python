axidma_python
===========
python bindings for libaxidma.

### Demo
```Python
from axidma import axidma

dma = axidma()
#dma.set_times(8) # set read times, every read have 16384 point, every point 32bit
dma.reset() #must reset when first start
for i in range(10):
    data = dma.read() #read data, reture bytes type
    print(len(data))
```
