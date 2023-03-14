.global _start

.section .text
_start:
    mov r0, #0
    mov r1, #1
    mov r2, #2
    add r0, r1, r2
    swi 0
