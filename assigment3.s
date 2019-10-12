/******************************************************************************
* file: assigment3.s
* author: Basant Kumar
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/


@ BSS section
    .bss

@ DATA SECTION
    .data
data_start: .word 0x205A15E3  ;(0010 0000 0101 1010 0001 0101 1101 0011 – 13)
            .word 0x256C8700  ;(0010 0101 0110 1100 1000 0111 0000 0000 – 11)
data_end:   .word 0x295468F2  ;(0010 1001 0101 0100 0110 1000 1111 0010 – 14)

;Output
NUM: .word 0
WEIGHT: .word 0

@ TEXT section
    .text

.globl _main

_main:
  ldr r4, =data_start ;load addr of data_start in r4
  ldr r5, =data_end   ;load addr of data_end in r5
  ldr r6, =NUM        ;load addr of NUM in r6
  ldr r7, =WEIGHT     ;load addr of WEIGHT in r7

count_next:
  ldr r0, [r4]        ;read element
  str r0,[sp,#4]      ;push to stack as r0 will be modified
  mov r1, #0          ;init set bit count with zero
  b find_set_bit      ;take input as NUM(r0) and return num of set bits(r1)

update_weigth:
  ldr r2, [r7]        ;read WEIGHT
  cmp r1, r2          ;compare current element weigth (r1) with last saved WEIGHT(r2)
  bmi next            ;if r1>r2 then update weigth
  str r1, [r7]        ;update WEIGHT
  ldr r0, [sp,#4]     ;pop from stack to retrive element
  str r0, [r6]        ;store corresponding element at NUM
  b next

find_set_bit:
  cmp r0, #0          ;if element == zero then come out of loop
  beq update_weigth
  add r1, r1, #1      ;incremet num of set bit by 1
  sub r2, r0, #1      ;get n-1
  and r0, r0, r2      ;clear last set bit of element (n & (n-1))
  b find_set_bit      ;loop

next:
  add r4, r4, #4      ;jump to addr of next element
  cmp r4, r5          ;cmpare start and end address
  ble count_next      ;signed less than equal to 

.end