	.text
	.file	"terra"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:
	push	rbx
	sub	rsp, 16
	lea	rdi, [rip + .L$string2]
	lea	rsi, [rsp + 12]
	xor	eax, eax
	call	scanf@PLT
	cmp	dword ptr [rsp + 12], 3
	jne	.LBB0_5
	lea	rdi, [rip + .L$string2]
	lea	rsi, [rsp + 12]
	xor	eax, eax
	call	scanf@PLT
	cmp	dword ptr [rsp + 12], 4
	jne	.LBB0_4
	lea	rdi, [rip + .Lstr8]
	call	puts@PLT
	lea	rdi, [rip + .L$string6]
	mov	esi, 3
	xor	eax, eax
	jmp	.LBB0_3
.LBB0_4:
	lea	rdi, [rip + .Lstr]
	call	puts@PLT
	lea	rdi, [rip + .Lstr8]
	call	puts@PLT
.LBB0_5:
	lea	rdi, [rip + .L$string5]
	xor	eax, eax
	call	printf@PLT
	lea	rbx, [rip + .L$string6]
	mov	esi, 4
	xor	eax, eax
	mov	rdi, rbx
	call	printf@PLT
	mov	esi, 3
	xor	eax, eax
	mov	rdi, rbx
.LBB0_3:
	call	printf@PLT
	add	rsp, 16
	pop	rbx
	ret
.Ltmp0:
	.size	main, .Ltmp0-main

	.globl	__makeeverythinginclanglive_0
	.align	16, 0x90
	.type	__makeeverythinginclanglive_0,@function
__makeeverythinginclanglive_0:
	ret
.Ltmp1:
	.size	__makeeverythinginclanglive_0, .Ltmp1-__makeeverythinginclanglive_0

	.section	.text.vprintf,"axG",@progbits,vprintf,comdat
	.weak	vprintf
	.align	16, 0x90
	.type	vprintf,@function
vprintf:
	mov	rax, rsi
	mov	rcx, rdi
	mov	rdx, qword ptr [rip + stdout@GOTPCREL]
	mov	rdi, qword ptr [rdx]
	mov	rsi, rcx
	mov	rdx, rax
	jmp	vfprintf@PLT
.Ltmp2:
	.size	vprintf, .Ltmp2-vprintf

	.section	.text.getchar,"axG",@progbits,getchar,comdat
	.weak	getchar
	.align	16, 0x90
	.type	getchar,@function
getchar:
	mov	rax, qword ptr [rip + stdin@GOTPCREL]
	mov	rdi, qword ptr [rax]
	jmp	_IO_getc@PLT
.Ltmp3:
	.size	getchar, .Ltmp3-getchar

	.section	.text.getc_unlocked,"axG",@progbits,getc_unlocked,comdat
	.weak	getc_unlocked
	.align	16, 0x90
	.type	getc_unlocked,@function
getc_unlocked:
	mov	rax, qword ptr [rdi + 8]
	cmp	rax, qword ptr [rdi + 16]
	jb	.LBB4_1
	jmp	__uflow@PLT
.LBB4_1:
	lea	rcx, [rax + 1]
	mov	qword ptr [rdi + 8], rcx
	movzx	eax, byte ptr [rax]
	ret
.Ltmp4:
	.size	getc_unlocked, .Ltmp4-getc_unlocked

	.section	.text.getchar_unlocked,"axG",@progbits,getchar_unlocked,comdat
	.weak	getchar_unlocked
	.align	16, 0x90
	.type	getchar_unlocked,@function
getchar_unlocked:
	mov	rax, qword ptr [rip + stdin@GOTPCREL]
	mov	rdi, qword ptr [rax]
	mov	rax, qword ptr [rdi + 8]
	cmp	rax, qword ptr [rdi + 16]
	jb	.LBB5_1
	jmp	__uflow@PLT
.LBB5_1:
	lea	rcx, [rax + 1]
	mov	qword ptr [rdi + 8], rcx
	movzx	eax, byte ptr [rax]
	ret
.Ltmp5:
	.size	getchar_unlocked, .Ltmp5-getchar_unlocked

	.section	.text.fgetc_unlocked,"axG",@progbits,fgetc_unlocked,comdat
	.weak	fgetc_unlocked
	.align	16, 0x90
	.type	fgetc_unlocked,@function
fgetc_unlocked:
	mov	rax, qword ptr [rdi + 8]
	cmp	rax, qword ptr [rdi + 16]
	jb	.LBB6_1
	jmp	__uflow@PLT
.LBB6_1:
	lea	rcx, [rax + 1]
	mov	qword ptr [rdi + 8], rcx
	movzx	eax, byte ptr [rax]
	ret
.Ltmp6:
	.size	fgetc_unlocked, .Ltmp6-fgetc_unlocked

	.section	.text.putchar,"axG",@progbits,putchar,comdat
	.weak	putchar
	.align	16, 0x90
	.type	putchar,@function
putchar:
	mov	rax, qword ptr [rip + stdout@GOTPCREL]
	mov	rsi, qword ptr [rax]
	jmp	_IO_putc@PLT
.Ltmp7:
	.size	putchar, .Ltmp7-putchar

	.section	.text.fputc_unlocked,"axG",@progbits,fputc_unlocked,comdat
	.weak	fputc_unlocked
	.align	16, 0x90
	.type	fputc_unlocked,@function
fputc_unlocked:
	mov	rax, qword ptr [rsi + 40]
	cmp	rax, qword ptr [rsi + 48]
	jb	.LBB8_1
	movzx	eax, dil
	mov	rdi, rsi
	mov	esi, eax
	jmp	__overflow@PLT
.LBB8_1:
	lea	rcx, [rax + 1]
	mov	qword ptr [rsi + 40], rcx
	mov	byte ptr [rax], dil
	movzx	eax, dil
	ret
.Ltmp8:
	.size	fputc_unlocked, .Ltmp8-fputc_unlocked

	.section	.text.putc_unlocked,"axG",@progbits,putc_unlocked,comdat
	.weak	putc_unlocked
	.align	16, 0x90
	.type	putc_unlocked,@function
putc_unlocked:
	mov	rax, qword ptr [rsi + 40]
	cmp	rax, qword ptr [rsi + 48]
	jb	.LBB9_1
	movzx	eax, dil
	mov	rdi, rsi
	mov	esi, eax
	jmp	__overflow@PLT
.LBB9_1:
	lea	rcx, [rax + 1]
	mov	qword ptr [rsi + 40], rcx
	mov	byte ptr [rax], dil
	movzx	eax, dil
	ret
.Ltmp9:
	.size	putc_unlocked, .Ltmp9-putc_unlocked

	.section	.text.putchar_unlocked,"axG",@progbits,putchar_unlocked,comdat
	.weak	putchar_unlocked
	.align	16, 0x90
	.type	putchar_unlocked,@function
putchar_unlocked:
	mov	rax, qword ptr [rip + stdout@GOTPCREL]
	mov	rax, qword ptr [rax]
	mov	rcx, qword ptr [rax + 40]
	cmp	rcx, qword ptr [rax + 48]
	jb	.LBB10_1
	movzx	esi, dil
	mov	rdi, rax
	jmp	__overflow@PLT
.LBB10_1:
	lea	rdx, [rcx + 1]
	mov	qword ptr [rax + 40], rdx
	mov	byte ptr [rcx], dil
	movzx	eax, dil
	ret
.Ltmp10:
	.size	putchar_unlocked, .Ltmp10-putchar_unlocked

	.section	.text.feof_unlocked,"axG",@progbits,feof_unlocked,comdat
	.weak	feof_unlocked
	.align	16, 0x90
	.type	feof_unlocked,@function
feof_unlocked:
	mov	eax, 260
	bextr	eax, dword ptr [rdi], eax
	ret
.Ltmp11:
	.size	feof_unlocked, .Ltmp11-feof_unlocked

	.section	.text.ferror_unlocked,"axG",@progbits,ferror_unlocked,comdat
	.weak	ferror_unlocked
	.align	16, 0x90
	.type	ferror_unlocked,@function
ferror_unlocked:
	mov	eax, 261
	bextr	eax, dword ptr [rdi], eax
	ret
.Ltmp12:
	.size	ferror_unlocked, .Ltmp12-ferror_unlocked

	.section	.text.atof,"axG",@progbits,atof,comdat
	.weak	atof
	.align	16, 0x90
	.type	atof,@function
atof:
	xor	esi, esi
	jmp	strtod@PLT
.Ltmp13:
	.size	atof, .Ltmp13-atof

	.section	.text.atoi,"axG",@progbits,atoi,comdat
	.weak	atoi
	.align	16, 0x90
	.type	atoi,@function
atoi:
	xor	esi, esi
	mov	edx, 10
	jmp	strtol@PLT
.Ltmp14:
	.size	atoi, .Ltmp14-atoi

	.section	.text.atol,"axG",@progbits,atol,comdat
	.weak	atol
	.align	16, 0x90
	.type	atol,@function
atol:
	xor	esi, esi
	mov	edx, 10
	jmp	strtol@PLT
.Ltmp15:
	.size	atol, .Ltmp15-atol

	.section	.text.atoll,"axG",@progbits,atoll,comdat
	.weak	atoll
	.align	16, 0x90
	.type	atoll,@function
atoll:
	xor	esi, esi
	mov	edx, 10
	jmp	strtoll@PLT
.Ltmp16:
	.size	atoll, .Ltmp16-atoll

	.section	.text.gnu_dev_major,"axG",@progbits,gnu_dev_major,comdat
	.weak	gnu_dev_major
	.align	16, 0x90
	.type	gnu_dev_major,@function
gnu_dev_major:
	mov	eax, 3080
	bextr	eax, edi, eax
	shr	rdi, 32
	and	edi, -4096
	or	eax, edi
	ret
.Ltmp17:
	.size	gnu_dev_major, .Ltmp17-gnu_dev_major

	.section	.text.gnu_dev_minor,"axG",@progbits,gnu_dev_minor,comdat
	.weak	gnu_dev_minor
	.align	16, 0x90
	.type	gnu_dev_minor,@function
gnu_dev_minor:
	movzx	eax, dil
	shr	rdi, 12
	and	edi, -256
	or	eax, edi
	ret
.Ltmp18:
	.size	gnu_dev_minor, .Ltmp18-gnu_dev_minor

	.section	.text.gnu_dev_makedev,"axG",@progbits,gnu_dev_makedev,comdat
	.weak	gnu_dev_makedev
	.align	16, 0x90
	.type	gnu_dev_makedev,@function
gnu_dev_makedev:
	movzx	eax, sil
	mov	ecx, edi
	shl	ecx, 8
	and	ecx, 1048320
	or	ecx, eax
	and	esi, -256
	shl	rsi, 12
	and	edi, -4096
	shl	rdi, 32
	or	rdi, rsi
	lea	rax, [rdi + rcx]
	ret
.Ltmp19:
	.size	gnu_dev_makedev, .Ltmp19-gnu_dev_makedev

	.section	.text.bsearch,"axG",@progbits,bsearch,comdat
	.weak	bsearch
	.align	16, 0x90
	.type	bsearch,@function
bsearch:
	push	rbp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 24
	mov	qword ptr [rsp + 16], r8
	mov	qword ptr [rsp + 8], rcx
	mov	r15, rdx
	mov	r12, rsi
	mov	r13, rdi
	xor	r14d, r14d
.LBB20_1:
	mov	rbx, r15
	.align	16, 0x90
.LBB20_2:
	mov	r15, rbx
	mov	ebp, 0
	cmp	r14, r15
	jae	.LBB20_5
	lea	rbx, [r15 + r14]
	shr	rbx
	mov	rbp, rbx
	imul	rbp, qword ptr [rsp + 8]
	add	rbp, r12
	mov	rdi, r13
	mov	rsi, rbp
	call	qword ptr [rsp + 16]
	test	eax, eax
	js	.LBB20_2
	add	rbx, 1
	mov	r14, rbx
	test	eax, eax
	jg	.LBB20_1
.LBB20_5:
	mov	rax, rbp
	add	rsp, 24
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
.Ltmp20:
	.size	bsearch, .Ltmp20-bsearch

	.type	.L$string2,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L$string2:
	.asciz	"%d"
	.size	.L$string2, 3

	.type	.L$string5,@object
.L$string5:
	.asciz	"ay"
	.size	.L$string5, 3

	.type	.L$string6,@object
.L$string6:
	.asciz	"%d\n"
	.size	.L$string6, 4

	.type	.Lstr,@object
.Lstr:
	.asciz	"no"
	.size	.Lstr, 3

	.type	.Lstr8,@object
.Lstr8:
	.asciz	"lol"
	.size	.Lstr8, 4


	.ident	"clang version 3.6.2 (tags/RELEASE_362/final)"
	.section	".note.GNU-stack","",@progbits
