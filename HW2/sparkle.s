.org 0
.global sparkle_asm

/* newlib system calls */
.set SYSEXIT,  93
.set SYSWRITE, 64


.data
test0: .word 255, 0, 128, 1
       .set arr_size1, .-test0
test1: .word 167, 133, 111, 144, 140, 135, 159, 154, 148
       .set arr_size2, .-test1
test2: .word 50, 100, 150, 200, 250, 255
       .set arr_size3, .-test2
testStr: .ascii  "Test "
         .set str_test, .-testStr
colonStr: .ascii  ": "
          .set str_colon, .-colonStr
nextline:    .ascii  "\n"
             .set str_next_len, .-nextline
blank:      .ascii  " "
             .set str_blank_len, .-blank
Max:      .ascii  "255 "
             .set str_Max_len, .-Max
Min:      .ascii  "0 "
             .set str_Min_len, .-Min
fail:     .ascii  " Fail "
             .set str_fail_len, .-fail
.text
# a0: array base address
# a1: array size
# a2: caseNum
# a3: return value

# s0: max=-1
# s1: i(index of loop)
# s2: LZ
# s3: MSB
# s4: array[i]

# t0: x>>1 x>>2 x>>4 x>>8 x>>16
# t1: 0x55555555 0x33333333 0x0f0f0f0f 0x7f
# t2: array offset 

sparkle_asm:
    addi sp, sp, -4
    sw ra, 0(sp)
    la a0, test0          # a0: the base address of test0
    addi a1, x0, 4        # a1: the size of test0
    addi a2, x0, 0        # a2: caseNum = 0
    jal x1, .bit_plane_slicing
    
    la a0, test1          # a0: the base address of test1
    addi a1, x0, 9        # a1: the size of test1
    addi a2, x0, 1        # a2: caseNum = 1
    jal x1, .bit_plane_slicing

    la a0, test2          # a0: the base address of test2
    addi a1, x0, 6        # a1: the size of test2
    addi a2, x0, 2        # a2: caseNum = 2
    jal x1, .bit_plane_slicing

    # exit and return 0
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
.bit_plane_slicing:
    addi sp, sp, -4
    sw ra, 0(sp)
    addi s0, x0, -1       # s0: max = -1
    add s1, x0, x0        # s1: i = 0
    add t6,x0,a1          # t6: size
clzLoop:
    
    slli t2, s1, 2        # t2: array offset = i*4
    add t2, t2, a0        # t2: base addr + offset
    lw s4, 0(t2)          # s4: arr[i]
    
    addi sp, sp, -8
    sw ra, 0(sp)
    sw a0, 4(sp)
    add a0, x0, s4        # load arr[i] to parameter register a0
    jal x1, .count_leading_zeros    
    lw ra, 0(sp)
    lw a0, 4(sp)
    addi sp, sp, 8
    
    add s2, x0, a3        # s2: LZ
    addi t1, x0, 31       # t1: 32 - 1
    sub s3, t1, s2        # s3: MSB = 32 - 1 - LZ 
    sw s3, 0(t2)          # arr[i] = MSB
    bge s3, s0, isGreater # if(MSB > max)
goOn:
    addi s1, s1, 1        # i = i + 1
    blt s1, a1, clzLoop
  
    addi sp, sp, -8
    sw ra, 0(sp)
    sw a0, 4(sp)
    jal x1, .printLoopOutside    # printf("Test %d: ", caseNum) || printf("\n")
    lw ra, 0(sp)
    lw a0, 4(sp)
    addi sp, sp, 8
    add s1, x0, x0        # s1: i = 0
    
reconLoop:
    slli t2, s1, 2        # t2: array offset = i*4
    add t2, t2, a0        # t2: base addr + offset
    lw s4, 0(t2)          # s4: arr[i]
    beq s4, s0, isEqual   # if(arr[i] == max)
    add s4, x0, x0        # arr[i] = 0
goOn2:     
    addi sp, sp, -12
    sw ra, 0(sp)
    sw a0, 4(sp)
    sw a1, 8(sp)
    addi t6,t6,-1
    jal ra, .printLoopInside    # printf("%u ", arr[i])
    lw ra, 0(sp)
    lw a0, 4(sp)
    lw a1, 8(sp)
    addi sp, sp, 12
    
    addi s1, s1, 1        # i = i + 1
    blt s1, a1, reconLoop 
    jr ra
isGreater: 
    add s0, x0, s3        # max = MSB
    j goOn

isEqual:
    addi s4, x0, 255      # arr[i] = 255
    j goOn2
    
.count_leading_zeros:

    srli t0, a0, 1        # t0: x >> 1
    or a0, a0, t0         # a0: x |= (x >> 1)
    
    srli t0, a0, 2        # t0: x >> 2
    or a0, a0, t0
    
    srli t0, a0, 4        # t0: x >> 4
    or a0, a0, t0
    
    srli t0, a0, 8        # t0: x >> 8
    or a0, a0, t0
    
    srli t0, a0, 16       # t0: x >> 16
    or a0, a0, t0
    
    srli t0, a0, 1        # t0: x >> 1
    lui t1, 0x55555       # t1: 0x55555555
    ori t1, t1, 0x555
    and t0, t0, t1        # t0: (x >> 1) & 0x55555555
    sub a0, a0, t0
    
    srli t0, a0, 2        # t0: x >> 2
    lui t1, 0x33333       # t1: 0x33333333
    ori t1, t1, 0x333
    and t0, t0, t1        # t0: (x >> 2) & 0x33333333
    and t4, a0, t1        # t4: x & 0x33333333
    add a0, t0, t4
    
    srli t0, a0, 4        # t0: x >> 4
    add t0, t0, a0        # t0: (x >> 4) + x
    lui t1, 0x0f0f0       # t1: 0x0f0f0f0f
    ori t1, t1, 0x787
    addi t1, t1, 0x788
    and a0, t0, t1        # a0: ((x >> 4) + x) & 0x0f0f0f0f
    
    srli t0, a0, 8        # t0: x >> 8
    add a0, a0, t0
    
    srli t0, a0, 16       # t0: x >> 16
    add a0, a0, t0
    
    andi t0, a0, 0x7f     # t0: x & 0x7f
    addi t1, x0, 32       # t1: 32
    sub  a3, t1, t0       # a3: return (32 - (x & 0x7f))
    jr ra
         
.printLoopOutside:
    addi a2,a2,48
    addi t0,sp,-4
    sw a2 ,0(t0)
    # printf("\n");
    li  a7, SYSWRITE
    li  a0, 1
    la  a1, nextline
    li  a2, 1
    ecall
    li  a7, SYSWRITE
    la  a1, testStr
    li a2, str_test
    ecall
    add a1,x0,t0
    li a0, 1
    li a2, 4
    li a7, SYSWRITE
    ecall
    li a7, SYSWRITE
    li a0, 1
    la a1, colonStr
    li a2,str_colon
    ecall
    jr ra
    
.printLoopInside:
    blt  t6,x0,re
    addi t5,x0,0xff
    beq s4,t5,Wmax
    beq s4,x0,Wmin
Wmax:
    li  a7, SYSWRITE
    la  a1, Max
    li a0,1
    li a2, str_Max_len
    ecall
    jr ra    
Wmin:
    li  a7, SYSWRITE
    la  a1, Min
    li a0,1
    li a2, str_Min_len
    ecall
    jr ra
re:
    jr ra
    
    
    
    sparkle_asm
    
