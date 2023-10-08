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
    addi sp,sp,-16
    sw ra,12(sp)
    sw a0,8(sp)
    sw s0,4(sp)
    sw s1,0(sp)
    
    add s0,a0,zero #s0=x
    addi,s1,zero,32 #s1=n
    beq s0,zero,exit_CLZ
    add s1,zero,zero
    li t3,0x80000000
    and t3,s0,t3
    bne t3,zero,exit_CLZ #first bit detect
    addi t1,zero,0xFF 
    addi t2,zero,8 #shift bit
    sll t3,t1,t2
    or t3,t1,t3
    slli t2,t2,1 
loopCLZ:
    beq t2,zero,exit_CLZ
    bgt s0,t3,next_bs #x>t3
    add s1,s1,t2
    sll s0,s0,t2
next_bs:
    srli t2,t2,1 #shift/2
    sll t3,t3,t2
    or t3,t1,t3
    j loopCLZ

exit_CLZ:
    add a6,zero,s1
    lw ra,12(sp)
    lw a0,8(sp)
    lw s0,4(sp)
    lw s1,0(sp)
    addi sp,sp,16
    jr ra

CTZ:
    addi sp,sp,-16
    sw ra,12(sp)
    sw a0,8(sp)
    sw s0,4(sp)
    sw s1,0(sp)
    
    add s0,a0,zero #s0=x
    add s1,zero,zero #s1=n
    addi,s1,zero,32
    beq s0,zero,exit_CTZ
    add s1,zero,zero
    addi t1,zero,0xFF 
    addi t2,zero,8 #shift bit
    sll t3,t1,t2
    or t3,t1,t3
    slli t2,t2,1 
loopCTZ:
    beq t2,zero,exit_CTZ
    and t4,s0,t3
    bne t4,zero,next_bs1 #x>t3
    add s1,s1,t2
    srl s0,s0,t2
next_bs1:
    srli t2,t2,1 #shift/2
    srl t3,t3,t2
    j loopCTZ

exit_CTZ:
    add a6,zero,s1
    lw ra,12(sp)
    lw a0,8(sp)
    lw s0,4(sp)
    lw s1,0(sp)
    addi sp,sp,16
    jr ra