main.o: main.s
	arm-none-eabi-as main.s -o main.o

main.elf: main.o
	arm-none-eabi-ld main.o -o main.elf

clean:
	rm main.o main.elf

run: all
	qemu-arm main.elf

all: main.elf
