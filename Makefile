all:
	python3 setup.py build_ext --inplace
	./down.sh
clean:
	rm -rf axidma.cpython*
	rm -rf axidma.c
	rm -rf build
