.global _start

.section .text
_start:

    // Print prompt
    ldr r1, =msg
    ldr r2, =msglen
    bl print

    // Get number from user
    ldr r1, =input
    mov r2, #2
    bl readn
    // Validate
    ldr r3, =input
    bl validate
    // Convert
    ldr r3, =input
    ldr r4, =num1
    bl convert_from_ascii

    // Print prompt
    ldr r1, =msg
    ldr r2, =msglen
    bl print

    // Get number from user
    ldr r1, =input
    mov r2, #2
    bl readn
    // Validate
    ldr r3, =input
    bl validate
    // Convert
    ldr r3, =input
    ldr r4, =num2
    bl convert_from_ascii

    // Add numbers to R5
    ldr r1, =num1
    ldrb r2, [r1]
    ldr r3, =num2
    ldrb r4, [r3]
    add r5, r2, r4
    str r5, [r1]
    ldr r3, =num1
    ldr r4, =input
    bl convert_to_ascii
    //add r5, r5, #48

    // Store
    ldr r6, =input
    strb r5, [r6]

    // Print sum msg
    ldr r1, =summsg
    ldr r2, =summsglen
    bl print

    // Print output
    ldr r1, =input
    mov r2, #2
    bl print

    b exit

// input address in r3
// destination address in r4
convert_to_ascii:
    ldrb r5, [r3]
    add r5, r5, #48
    strb r5, [r4]
    mov pc, lr

// input address in r3
// destination address in r4
convert_from_ascii:
    ldrb r5, [r3]
    sub r5, r5, #48
    strb r5, [r4]
    mov pc, lr

// address in r3
validate:
    ldrb r4, [r3]
    mov r3, #48
    cmp r4, r3
    blt print_invalid
    mov r3, #57
    cmp r4, r3
    bgt print_invalid
    mov pc, lr

print_invalid:
    ldr r1, =invalidmsg
    ldr r2, =invalidmsglen
    bl print
    b exit

// addr in r1
// size in r2
readn:
    // read
    mov r7, #3
    // stdin
    mov r0, #0
    swi 0
    mov pc, lr

// msg in r1
// len in r2
print:
    // write
    mov r7, #4
    // stdout
    mov r0, #1
    swi 0
    mov pc, lr

exit:
    // exit
    mov r7, #1
    // status 0
    mov r0, #0
    swi 0

.section .data
msg:
    .asciz "Enter number: "
msglen = . - msg

invalidmsg:
    .asciz "Invalid input\n"
invalidmsglen = . - invalidmsg

summsg:
    .asciz "Sum: "
summsglen = . - summsg

var:
    .byte 0

// 2 bytes
input:
    .byte 0, 0

num1:
    .byte 0

num2:
    .byte 0
