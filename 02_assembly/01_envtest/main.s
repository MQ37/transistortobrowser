.global _start
.section .text

_start:
    /* print message */
    mov r0, #1
    ldr r1, =message
    ldr r2, =len
    mov r7, #4
    swi 0

    /* exit 0 */
    mov r7, #1
    mov r0, #0
    swi 0

.section .data
message:
    .asciz "hello world\n"
len = .-message

