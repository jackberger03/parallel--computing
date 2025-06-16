# Makefile for CSCE 435 HW2

CC = icx
CFLAGS = -O2 -Wall
LIBS = -lpthread -lc -lrt -lm

# Default target
all: list_minimum.exe barrier.exe list_statistics.exe

# Problem 1: List minimum
list_minimum.exe: list_minimum.c
	$(CC) $(CFLAGS) -o $@ $< $(LIBS)

# Problem 4: Barrier
barrier.exe: barrier.c csce435.h
	$(CC) $(CFLAGS) -o $@ $< $(LIBS)

# Problem 7: List statistics
list_statistics.exe: list_statistics.c
	$(CC) $(CFLAGS) -o $@ $< $(LIBS)

# Run minimum experiments
run-minimum: list_minimum.exe
	@echo "Running minimum experiments..."
	@for k in 0 1 2 3 4 5 6 7 8 9 10 11 12 13; do \
		p=$$((2**$$k)); \
		echo -n "$$p,"; \
		./list_minimum.exe 200000000 $$p | awk -F'=' '{print $$NF}' | awk '{print $$1}'; \
	done

# Run barrier experiments
run-barrier: barrier.exe
	@echo "Running barrier experiments..."
	@for k in 1 2 3 4 5 6 7 8 9 10 11 12 13 14; do \
		p=$$((2**$$k)); \
		echo -n "$$p,"; \
		./barrier.exe $$p | awk -F'=' '{print $$NF}' | awk '{print $$1}'; \
	done

# Test programs with small inputs
test: all
	@echo "Testing list_minimum..."
	./list_minimum.exe 10000 4
	@echo "\nTesting barrier..."
	./barrier.exe 4
	@echo "\nTesting list_statistics..."
	./list_statistics.exe 10000 4

# Clean up
clean:
	rm -f *.exe *.o

.PHONY: all clean test run-minimum run-barrier
