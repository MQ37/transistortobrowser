.global _start

.section .text
_start:
    mov r1, #1
    mov r2, #2
    subs r3, r1, r2

    /* if carry (underflow) exit status is 0 */
    movcc r0, #0
    /* if not carry (underflow) exit status is 1 */
    movcs r0, #1
    mov r7, #1
    swi 0
