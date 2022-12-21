.org 0
.global _start

.set SYSEXIT,  93
.set SYSWRITE, 64
.set SYSBRK, 214

.data
len1: .word 10
len2: .word 5
len3: .word 5
len4: .word 2

tab: .word 9
nline: .word 10

fff: .string "t1: "
.set fff_size, .-fff

ddd:  .string "t2: "
.set ddd_size, .-ddd

Cycle: .string "1\n"
.set Cycle_size, .-Cycle
NoCycle:  .string "0\n"
.set NoCycle_size, .-NoCycle

first: .string "=========first=========\n "
.set first_size, .-first
second: .string "=========second=========\n "
.set second_size, .-second
third:  .string "=========third=========\n "
.set third_size, .-third

.text
_start:
    
    # first
    li a7, SYSWRITE
    li a0, 1
    la a1, first
    li a2, first_size
    ecall
    
    lw a1, len1                 # a1 = arr_len
    jal ra, initNormalList      # a0 = return value = struct ListNode head
    jal ra, start_cycle
 
    # second
    li a7, SYSWRITE
    li a0, 1
    la a1, second
    li a2, second_size
    ecall

    lw a1, len2                 # a1 = arr_len
    jal ra, initNormalList      # a0 = return value = struct ListNode head
    jal ra, start_cycle
    
    # third
    li a7, SYSWRITE
    li a0, 1
    la a1, third
    li a2, third_size
    ecall
    
    lw a1, len3                # a1 = arr_len
    lw a2, len4
    jal ra, initErrorList      # a0 = return value = struct ListNode head
    jal ra, start_cycle
    j exit

start_cycle:
    # prologue
    addi sp, sp, -8   # push stack pointer to the bottom
    sw ra, 0(sp)
    sw a0, 4(sp)

    # body
    mv t1, a0        # t1 = list head
    mv t6, a0
#    li a7, 4
#    ecall
    
    jal ra, has_cycle   # unit test
    
    # epilogue
    lw ra, 0(sp)        # back to main
    lw a0, 4(sp)
    addi sp, sp, 8
    jr ra

initNormalList:
    # prologue
    addi sp, sp, -8      # push stack pointer to the bottom
    sw ra, 0(sp)
    
    # body
    addi t0, a1, -1     # t0 = len
    li s0, 0x20000000   # s0 will handle the address of each list node
    sw s0, 4(sp)        # store list head to stack
       
    jal ra, malloc       # for - malloc
    addi s1, x0, 0      # head->val = 0, 
    addi t3, s0, 0    # ListNode head
    
    addi s0, s0, 8
    li s1, 0            # i == 0
loop:
    jal ra, malloc       # struct ListNode *next = malloc    
    addi t4, s1, 1      # for i 0 
    sw t4, 0(s0)        # next->val = s0
    sw s0, 4(t3)        # c -> next = next
    addi t3, t3, 8      # push heap 8 byte
    
    addi s1, s1, 1      # i++

    addi s0,s0, 8       # push new ListNode
    
    
    bne s1, t0, loop     # for-loop condition
    
    sw x0, 4(t3)
    
    lw ra, 0(sp)        # load return address
    lw a0, 4(sp)        # get back list head
    addi sp, sp, 8
    
    jr ra



initErrorList:
    # prologue
    addi sp, sp, -8      # push stack pointer to the bottom
    sw ra, 0(sp)
    
    # body
    addi t5, a2, -1
    addi t0, a1, -1     # t0 = len
    li s0, 0x20000000   # s0 will handle the address of each list node
    sw s0, 4(sp)        # store list head to stack
       
    jal ra, malloc       # for - malloc
    addi s1, zero, 0    # head->val = 0, 
    addi t3, s0  , 0    # ListNode head
    
    addi s0, s0, 8
    li s1, 0            # i == 0
loop_error:
    jal ra, malloc       # struct ListNode *next = malloc    
    addi t4, s1, 1      # value + 1 (for varify) 
    sw t4, 0(s0)        # next->val = s0
    sw s0, 4(t3)        # c -> next = next
    
    addi t3, t3, 8      # push heap 8 byte
    addi s1, s1, 1      # i++
    addi s0, s0, 8      # push new ListNode
    
    beq s1, t5, StorageCycle
    bne s1, t0, loop_error     # for loop condition
    
    sw t6, 4(t3)
    
    lw ra, 0(sp)        # load return address
    lw a0, 4(sp)        # get back list head
    addi sp, sp, 8
    
    jr ra
    
StorageCycle: 
    addi t6, t3, 0
    ecall
    jr ra
has_cycle:
    li a0, 1
    la a1, fff
    li a2, fff_size
    li a7, SYSWRITE
    ecall
    
    li a7, SYSWRITE
    li a0, 0xfff
    mv a1, t1        # load value to a0
    li a2, 4            # system call: print int
    ecall
    
    li a7, SYSWRITE
    li a0, 1
    la a1, tab            # tab
    li a2, 1           # print char
    ecall
    
    li a7, SYSWRITE
    li a0, 1
    la a1, ddd
    li a2, ddd_size
    ecall
    
    li a7, SYSWRITE
    li a0, 0xfff
    mv a1, t6        # load value to a0
    li a2, 4            # system call: print int
    ecall
    
    li a7, SYSWRITE
    li a0, 1
    la a1, tab            # tab
    li a2, 1           # print char
    ecall
     
    lw t1, 4(t1)        # t1 = t1->next
    
    lw t6, 4(t6)
    lw t6, 4(t6)
  
    li a7, SYSWRITE
    li a0, 1
    la a1, nline            # next line
    li a2, 1           # print char
    ecall 
    
    beq t1, x0, NoCycleEnd
    beq t1, t6, CycleEnd
    bne t1, x0, has_cycle
EndTest:
    jr ra

CycleEnd:
    li a7, SYSWRITE
    li a0, 1
    la a1, Cycle
    li a2, Cycle_size
    ecall
    
    li a7, SYSWRITE
    li a0, 1
    la a1, nline            # next line
    li a2, 1           # print char
    ecall
    
    j EndTest
NoCycleEnd:
    li a7, SYSWRITE
    li a0, 1
    la a1, NoCycle
    li a2, NoCycle_size
    ecall
    
    li a7, SYSWRITE
    li a0, 1
    la a1, nline            # next line
    li a2, 1           # print char
    ecall
    
    j EndTest

malloc:
    li a7, SYSBRK         # brk
    ecall
    jr ra
    
exit:
    li a0, 0
    li a7, SYSEXIT           # end
    ecall
