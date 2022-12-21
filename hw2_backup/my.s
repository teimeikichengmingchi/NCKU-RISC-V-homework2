	.file	"linked_list_cycle.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_a2p1_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	initListNode
	.type	initListNode, @function
initListNode:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	li	a0,8
	call	malloc
	mv	a5,a0
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sw	zero,0(a5)
	lw	a5,-28(s0)
	sw	a5,-20(s0)
	li	a5,1
	sw	a5,-24(s0)
	j	.L2
.L3:
	li	a0,8
	call	malloc
	mv	a5,a0
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	lw	a4,-24(s0)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	lw	a4,-32(s0)
	sw	a4,4(a5)
	lw	a5,-20(s0)
	lw	a5,4(a5)
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L2:
	lw	a4,-24(s0)
	lw	a5,-36(s0)
	blt	a4,a5,.L3
	lw	a5,-20(s0)
	sw	zero,4(a5)
	lw	a5,-28(s0)
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	initListNode, .-initListNode
	.align	1
	.globl	initErrorList
	.type	initErrorList, @function
initErrorList:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	sw	a0,-52(s0)
	sw	a1,-56(s0)
	li	a0,8
	call	malloc
	mv	a5,a0
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	sw	zero,0(a5)
	lw	a5,-32(s0)
	sw	a5,-24(s0)
	li	a5,1
	sw	a5,-28(s0)
	j	.L6
.L8:
	li	a0,8
	call	malloc
	mv	a5,a0
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	lw	a4,-28(s0)
	sw	a4,0(a5)
	lw	a5,-24(s0)
	lw	a4,-36(s0)
	sw	a4,4(a5)
	lw	a5,-24(s0)
	lw	a5,4(a5)
	sw	a5,-24(s0)
	lw	a4,-28(s0)
	lw	a5,-56(s0)
	bne	a4,a5,.L7
	lw	a5,-24(s0)
	sw	a5,-20(s0)
.L7:
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-28(s0)
.L6:
	lw	a4,-28(s0)
	lw	a5,-52(s0)
	blt	a4,a5,.L8
	lw	a5,-24(s0)
	lw	a4,-20(s0)
	sw	a4,4(a5)
	lw	a5,-32(s0)
	mv	a0,a5
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	initErrorList, .-initErrorList
	.align	1
	.globl	hasCycle
	.type	hasCycle, @function
hasCycle:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	lw	a5,-36(s0)
	sw	a5,-20(s0)
	lw	a5,-36(s0)
	sw	a5,-24(s0)
	j	.L11
.L14:
	lw	a5,-20(s0)
	lw	a5,4(a5)
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	lw	a5,4(a5)
	lw	a5,4(a5)
	sw	a5,-24(s0)
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	bne	a4,a5,.L11
	li	a5,1
	j	.L12
.L11:
	lw	a5,-24(s0)
	beq	a5,zero,.L13
	lw	a5,-24(s0)
	lw	a5,4(a5)
	bne	a5,zero,.L14
.L13:
	li	a5,0
.L12:
	mv	a0,a5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	hasCycle, .-hasCycle
	.section	.rodata
	.align	2
.LC0:
	.string	"%d\n"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	li	a1,2
	li	a0,5
	call	initErrorList
	sw	a0,-20(s0)
	li	a0,5
	call	initListNode
	sw	a0,-24(s0)
	li	a0,10
	call	initListNode
	sw	a0,-28(s0)
	lw	a0,-20(s0)
	call	hasCycle
	mv	a5,a0
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	lw	a0,-24(s0)
	call	hasCycle
	mv	a5,a0
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	lw	a0,-28(s0)
	call	hasCycle
	mv	a5,a0
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	li	a5,0
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC x86_64) 12.2.0"
