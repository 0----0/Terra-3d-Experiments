	.text
	.file	"defertestcpp2.cpp"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushq	%rax
.Ltmp0:
	.cfi_def_cfa_offset 16
	leaq	4(%rsp), %rsi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	scanf
	cmpl	$3, 4(%rsp)
	jne	.LBB0_6
# BB#1:
	leaq	4(%rsp), %rsi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	scanf
	movl	4(%rsp), %eax
	cmpl	$5, %eax
	jne	.LBB0_2
# BB#4:
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	jmp	.LBB0_7
.LBB0_2:
	cmpl	$4, %eax
	jne	.LBB0_5
# BB#3:
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	jmp	.LBB0_8
.LBB0_5:
	movl	$.L.str2, %edi
	xorl	%eax, %eax
	callq	printf
.LBB0_6:
	movl	$.L.str3, %edi
	callq	puts
.LBB0_7:
	movl	$.L.str, %edi
	movl	$4, %esi
	xorl	%eax, %eax
	callq	printf
.LBB0_8:
	movl	$.L.str, %edi
	movl	$3, %esi
	xorl	%eax, %eax
	callq	printf
	xorl	%eax, %eax
	popq	%rdx
	retq
.Ltmp1:
	.size	main, .Ltmp1-main
	.cfi_endproc

	.section	.text.startup,"ax",@progbits
	.align	16, 0x90
	.type	_GLOBAL__sub_I_defertestcpp2.cpp,@function
_GLOBAL__sub_I_defertestcpp2.cpp:       # @_GLOBAL__sub_I_defertestcpp2.cpp
	.cfi_startproc
# BB#0:
	pushq	%rax
.Ltmp2:
	.cfi_def_cfa_offset 16
	movl	$_ZStL8__ioinit, %edi
	callq	_ZNSt8ios_base4InitC1Ev
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	movl	$_ZStL8__ioinit, %esi
	movl	$__dso_handle, %edx
	popq	%rax
	jmp	__cxa_atexit            # TAILCALL
.Ltmp3:
	.size	_GLOBAL__sub_I_defertestcpp2.cpp, .Ltmp3-_GLOBAL__sub_I_defertestcpp2.cpp
	.cfi_endproc

	.type	_ZStL8__ioinit,@object  # @_ZStL8__ioinit
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d"
	.size	.L.str, 3

	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	"lol"
	.size	.L.str1, 4

	.type	.L.str2,@object         # @.str2
.L.str2:
	.asciz	"no"
	.size	.L.str2, 3

	.type	.L.str3,@object         # @.str3
.L.str3:
	.asciz	"ay"
	.size	.L.str3, 3

	.section	.init_array,"aw",@init_array
	.align	8
	.quad	_GLOBAL__sub_I_defertestcpp2.cpp

	.ident	"clang version 3.6.2 (tags/RELEASE_362/final)"
	.section	".note.GNU-stack","",@progbits
