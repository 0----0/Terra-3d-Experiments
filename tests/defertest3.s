	.text
	.file	"terra"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:
	push	rbx
	sub	rsp, 16
	lea	rdi, qword ptr [rip + .L$string14]
	lea	rsi, qword ptr [rsp + 12]
	xor	eax, eax
	call	scanf@PLT
	cmp	dword ptr [rsp + 12], 3
	jne	.LBB0_3
	lea	rdi, qword ptr [rip + .L$string15]
	mov	esi, 3
	xor	eax, eax
	jmp	.LBB0_2
.LBB0_3:
	lea	rdi, qword ptr [rip + .L$string14]
	lea	rsi, qword ptr [rsp + 12]
	xor	eax, eax
	call	scanf@PLT
	cmp	dword ptr [rsp + 12], 3
	jne	.LBB0_6
	lea	rbx, qword ptr [rip + .L$string15]
	jmp	.LBB0_5
.LBB0_6:
	lea	rdi, qword ptr [rip + .L$string14]
	lea	rsi, qword ptr [rsp + 12]
	xor	eax, eax
	call	scanf@PLT
	cmp	dword ptr [rsp + 12], 3
	jne	.LBB0_9
	lea	rbx, qword ptr [rip + .L$string15]
	jmp	.LBB0_8
.LBB0_9:
	lea	rdi, qword ptr [rip + .L$string14]
	lea	rsi, qword ptr [rsp + 12]
	xor	eax, eax
	call	scanf@PLT
	cmp	dword ptr [rsp + 12], 3
	jne	.LBB0_12
	lea	rbx, qword ptr [rip + .L$string15]
	jmp	.LBB0_11
.LBB0_12:
	lea	rdi, qword ptr [rip + .L$string14]
	lea	rsi, qword ptr [rsp + 12]
	xor	eax, eax
	call	scanf@PLT
	cmp	dword ptr [rsp + 12], 3
	jne	.LBB0_15
	lea	rbx, qword ptr [rip + .L$string15]
	jmp	.LBB0_14
.LBB0_15:
	lea	rdi, qword ptr [rip + .L$string14]
	lea	rsi, qword ptr [rsp + 12]
	xor	eax, eax
	call	scanf@PLT
	cmp	dword ptr [rsp + 12], 3
	jne	.LBB0_18
	lea	rbx, qword ptr [rip + .L$string15]
	jmp	.LBB0_17
.LBB0_18:
	lea	rdi, qword ptr [rip + .L$string14]
	lea	rsi, qword ptr [rsp + 12]
	xor	eax, eax
	call	scanf@PLT
	cmp	dword ptr [rsp + 12], 3
	jne	.LBB0_21
	lea	rbx, qword ptr [rip + .L$string15]
	jmp	.LBB0_20
.LBB0_21:
	lea	rdi, qword ptr [rip + .L$string14]
	lea	rsi, qword ptr [rsp + 12]
	xor	eax, eax
	call	scanf@PLT
	lea	rbx, qword ptr [rip + .L$string15]
	mov	esi, 3
	xor	eax, eax
	mov	rdi, rbx
	call	printf@PLT
.LBB0_20:
	mov	esi, 3
	xor	eax, eax
	mov	rdi, rbx
	call	printf@PLT
.LBB0_17:
	mov	esi, 3
	xor	eax, eax
	mov	rdi, rbx
	call	printf@PLT
.LBB0_14:
	mov	esi, 3
	xor	eax, eax
	mov	rdi, rbx
	call	printf@PLT
.LBB0_11:
	mov	esi, 3
	xor	eax, eax
	mov	rdi, rbx
	call	printf@PLT
.LBB0_8:
	mov	esi, 3
	xor	eax, eax
	mov	rdi, rbx
	call	printf@PLT
.LBB0_5:
	mov	esi, 3
	xor	eax, eax
	mov	rdi, rbx
	call	printf@PLT
	mov	esi, 3
	xor	eax, eax
	mov	rdi, rbx
.LBB0_2:
	call	printf@PLT
	add	rsp, 16
	pop	rbx
	ret
.Ltmp0:
	.size	main, .Ltmp0-main

	.type	.L$string14,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L$string14:
	.asciz	"%d"
	.size	.L$string14, 3

	.type	.L$string15,@object
.L$string15:
	.asciz	"%d\n"
	.size	.L$string15, 4


	.section	".note.GNU-stack","",@progbits
