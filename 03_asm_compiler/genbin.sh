#!/bin/sh

arm-none-eabi-as -o main.o main.s
arm-none-eabi-ld -o main.elf main.o
arm-none-eabi-objcopy -O binary main.elf main.bin

