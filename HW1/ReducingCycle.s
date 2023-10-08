.data
str1:  .string "Overflow!"
num_1: .dword 0x01000000 
num_2: .dword 0x00000015
num_3: .dword 0x00000130
num_4: .dword 0xA0000000
_EOL: .string "\n"

.text
#s0=product
#s1=exp_x
#s2=exp_y
#s3=ctz_x
#s4=i
#a6=function result
main:
    
    add s0,zero,zero #product=0
    add s1,zero,zero #exp_x=0
    add s2,zero,zero #exp_y=0
    add s3,zero,zero #ctz_x=0
    lw a0,num_2
    lw a1,num_4
    
    addi t1,zero,1 #if x,y=1 ? y:x
    add s0,a0,zero
    beq a1,t1,product
    add s0,a1,zero
    beq a0,t1,product
    add s0,zero,zero
    add a1,zero,a0
    jal ra,CLZ
    add s2,zero,a6
    lw a0,num_4
    jal ra,CLZ
    add s1,zero,a6
    addi t0,zero,32
    add  t1,s1,s2
    blt t1,t0,overflow
    jal ra,CTZ
    add s3,zero,a6 #ctz_x =ctz(x);
    srl a0,a0,s3 #x = x >> ctz_x;
    add s4,zero,zero #i=0
    addi t0,zero,32
    add t1,s1,s3
    sub t0,t0,t1
    add t4,zero,a0 #t4=x
    add t5,zero,a1 #t5=y

loop:
    bgt s4,t0,product  #i>t0
    andi t2,t4,1
    beq t2,zero,next_i
    add s0,s0,t5
next_i:   
    slli t5,t5,1 
    srli t4,t4,1 #x=x>>1;
    addi s4,s4,1 #i++
    j loop
product:
    sll s0,s0,s3
    mv a0, s0
    li a7, 1
    ecall
    li a7, 10
    ecall
overflow:
    la a0, str1
    li a7, 4
    ecall
    li a7, 10
    ecall
CLZ:
    addi sp,sp,-12
    sw ra,8(sp)
    sw a0,4(sp)
    sw s0,0(sp)
    
    add s0,a0,zero
    # x |= (x >> 1)
    srli t0,s0,1
    or s0,s0,t0
    
    # x |= (x >> 2)
    srli t0,s0,2
    or s0,s0,t0

    # x |= (x >> 4)
    srli t0,s0,4
    or s0,s0,t0

    # x |= (x >> 8)
    srli t0,s0,8
    or s0,s0,t0

    # x |= (x >> 16)
    srli t0,s0,16
    or s0,s0,t0
         
    jal ra,count_ones
    add a6,zero,a0
    lw ra,8(sp)
    lw a0,4(sp)
    lw s0,0(sp)
    addi sp,sp,12
    jr ra

CTZ:
    addi sp,sp,-12
    sw ra,8(sp)
    sw a0,4(sp)
    sw s0,0(sp)
    
    add s0,a0,zero
    # x |= (x << 1)
    slli t0,s0,1
    or s0,s0,t0

    # x |= (x << 2)
    slli t0,s0,2
    or s0,s0,t0

    # x |= (x << 4)
    slli t0,s0,4
    or s0,s0,t0

    # x |= (x << 8)
    slli t0,s0,8
    or s0,s0,t0

    # x |= (x << 16)
    slli t0,s0,16
    or s0,s0,t0
    
    jal ra,count_ones
    add a6,zero,a0
    lw ra,8(sp)
    lw a0,4(sp)
    lw s0,0(sp)
    addi sp,sp,12
    jr ra
    
count_ones:
    srli t0,s0,1
    li t1,0x55555555
    and t0,t0,t1
    sub s0,s0,t0

    srli t0,s0,2
    li t1,0x33333333
    and t0,t0,t1
    and s0,s0,t1
    add s0,s0,t0

    srli t0,s0,4
    add t0,s0,t0
    li t1,0x0f0f0f0f
    and s0,t0,t1

    srli t0,s0,8
    add s0,s0,t0

    srli t0,s0,16
    add s0,s0,t0

    andi t0,s0,0x3f
    addi t1,zero,32
    sub a0,t1,t0
    jr ra