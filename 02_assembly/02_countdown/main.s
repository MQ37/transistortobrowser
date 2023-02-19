.global _start
.section .text

_start:
    /* load address of num into R3 */
    ldr r2, =start
    ldr r3, =end
    /* load value of num into R1 */
    ldr r0, [r2]
    ldr r1, [r3]

    /* if R0 > R1 decrement in loop */
    loop:
        /* compare R0, R1 */
        cmp r0, r1
        /* decrement R0 if R0 > R1 */
        subgt r0, #1
        /* compare R0, R1 */
        cmp r0, r1
    /* jump back to loop if R0 > R1 */
    bgt loop

    /* exit with R0 as exit code */
    mov r7, #1
    swi 0


.section .data
start:
    .word 12
end:
    .word 6

