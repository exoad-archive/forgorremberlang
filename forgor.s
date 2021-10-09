	.file	"rh.c"
	.text
	.globl	lines
	.bss
	.align 8
lines:
	.space 8
	.globl	queues
	.align 8
queues:
	.space 8
	.globl	last
	.align 8
last:
	.space 8
	.globl	current
	.align 8
current:
	.space 8
	.globl	skip
	.align 4
skip:
	.space 4
	.section .rdata,"dr"
.LC0:
	.ascii "Error: \0"
	.text
	.globl	error
	.def	error;	.scl	2;	.type	32;	.endef
	.seh_proc	error
error:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	leaq	48(%rsp), %rbp
	.seh_setframe	%rbp, 48
	.seh_endprologue
	movq	%rcx, 32(%rbp)
	movq	%rdx, 40(%rbp)
	movq	%r8, 48(%rbp)
	movq	%r9, 56(%rbp)
	leaq	40(%rbp), %rax
	movq	%rax, -16(%rbp)
	call	__getreent
	movq	24(%rax), %rax
	movq	%rax, %r9
	movl	$7, %r8d
	movl	$1, %edx
	leaq	.LC0(%rip), %rax
	movq	%rax, %rcx
	call	fwrite
	movq	-16(%rbp), %rbx
	call	__getreent
	movq	24(%rax), %rax
	movq	%rbx, %r8
	movq	32(%rbp), %rdx
	movq	%rax, %rcx
	call	vfprintf
	call	__getreent
	movq	24(%rax), %rax
	movq	%rax, %rdx
	movl	$10, %ecx
	call	fputc
	movq	queues(%rip), %rax
	testq	%rax, %rax
	je	.L2
	movq	queues(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L3
	movq	queues(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	call	free
.L3:
	movq	queues(%rip), %rax
	movq	%rax, %rcx
	call	free
.L2:
	movq	lines(%rip), %rax
	testq	%rax, %rax
	je	.L4
	movq	lines(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L5
	movq	lines(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	jmp	.L6
.L9:
	cmpq	$0, -8(%rbp)
	je	.L7
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L8
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	call	free
.L8:
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	free
.L7:
	addq	$24, -8(%rbp)
.L6:
	movq	lines(%rip), %rax
	movq	(%rax), %rdx
	movq	lines(%rip), %rax
	movl	12(%rax), %eax
	cltq
	addq	%rdx, %rax
	cmpq	%rax, -8(%rbp)
	jb	.L9
	movq	lines(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	call	free
.L5:
	movq	lines(%rip), %rax
	movq	%rax, %rcx
	call	free
.L4:
	movq	current(%rip), %rax
	testq	%rax, %rax
	je	.L10
	movq	last(%rip), %rax
	movq	$0, 32(%rax)
	jmp	.L11
.L12:
	movq	current(%rip), %rax
	movq	%rax, last(%rip)
	movq	current(%rip), %rax
	movq	32(%rax), %rax
	movq	%rax, current(%rip)
	movq	last(%rip), %rax
	movq	%rax, %rcx
	call	free
.L11:
	movq	current(%rip), %rax
	testq	%rax, %rax
	jne	.L12
.L10:
	movl	$1, %ecx
	call	exit
	nop
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Memory allocation error on new_buf()\0"
	.text
	.globl	buf_new
	.def	buf_new;	.scl	2;	.type	32;	.endef
	.seh_proc	buf_new
buf_new:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	cmpq	$0, 24(%rbp)
	jne	.L14
	movl	$24, %ecx
	call	malloc
	movq	%rax, -8(%rbp)
	jmp	.L15
.L14:
	movq	24(%rbp), %rax
	movq	%rax, -8(%rbp)
.L15:
	cmpq	$0, -8(%rbp)
	jne	.L16
	leaq	.LC1(%rip), %rax
	movq	%rax, %rcx
	call	error
.L16:
	movq	-8(%rbp), %rax
	movq	$0, (%rax)
	movq	-8(%rbp), %rax
	movl	16(%rbp), %edx
	movl	%edx, 8(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 16(%rax)
	movq	-8(%rbp), %rax
	movl	16(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 12(%rax)
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	buf_empty
	.def	buf_empty;	.scl	2;	.type	32;	.endef
	.seh_proc	buf_empty
buf_empty:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	cmpq	$0, 16(%rbp)
	jne	.L19
	movl	$1, %eax
	jmp	.L20
.L19:
	movq	16(%rbp), %rax
	movl	12(%rax), %eax
	testl	%eax, %eax
	jne	.L21
	movl	$1, %eax
	jmp	.L20
.L21:
	movl	$0, %eax
.L20:
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC2:
	.ascii "Memory allocation error on buf_expand()\0"
	.text
	.globl	buf_expand
	.def	buf_expand;	.scl	2;	.type	32;	.endef
	.seh_proc	buf_expand
buf_expand:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	cmpq	$0, 16(%rbp)
	je	.L29
	movq	16(%rbp), %rax
	movl	12(%rax), %edx
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	%eax, %edx
	jne	.L25
	movq	16(%rbp), %rax
	movl	16(%rax), %ecx
	movq	16(%rbp), %rax
	movl	8(%rax), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%rcx,%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	movslq	%eax, %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	call	realloc
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L26
	leaq	.LC2(%rip), %rax
	movq	%rax, %rcx
	call	error
.L26:
	movq	16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, (%rax)
.L25:
	cmpq	$0, 24(%rbp)
	jne	.L27
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	movslq	%eax, %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rcx
	movq	16(%rbp), %rax
	movl	12(%rax), %eax
	cltq
	addq	%rcx, %rax
	movq	%rdx, %r8
	movl	$0, %edx
	movq	%rax, %rcx
	call	memset
	jmp	.L28
.L27:
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	movslq	%eax, %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rcx
	movq	16(%rbp), %rax
	movl	12(%rax), %eax
	cltq
	addq	%rax, %rcx
	movq	24(%rbp), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	call	memcpy
.L28:
	movq	16(%rbp), %rax
	movl	12(%rax), %edx
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	addl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 12(%rax)
	jmp	.L22
.L29:
	nop
.L22:
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	buf_last
	.def	buf_last;	.scl	2;	.type	32;	.endef
	.seh_proc	buf_last
buf_last:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	cmpq	$0, 16(%rbp)
	jne	.L31
	movl	$0, %eax
	jmp	.L32
.L31:
	movq	16(%rbp), %rax
	movl	12(%rax), %eax
	testl	%eax, %eax
	jne	.L33
	movl	$0, %eax
	jmp	.L32
.L33:
	movq	16(%rbp), %rax
	movq	(%rax), %rcx
	movq	16(%rbp), %rax
	movl	12(%rax), %eax
	movslq	%eax, %rdx
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cltq
	subq	%rax, %rdx
	leaq	(%rcx,%rdx), %rax
.L32:
	popq	%rbp
	ret
	.seh_endproc
	.globl	buf_get
	.def	buf_get;	.scl	2;	.type	32;	.endef
	.seh_proc	buf_get
buf_get:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movl	%edx, 24(%rbp)
	cmpq	$0, 16(%rbp)
	jne	.L35
	movl	$0, %eax
	jmp	.L36
.L35:
	cmpl	$0, 24(%rbp)
	jns	.L37
	movl	$0, %eax
	jmp	.L36
.L37:
	movq	16(%rbp), %rax
	movl	12(%rax), %eax
	movq	16(%rbp), %rdx
	movl	8(%rdx), %ecx
	cltd
	idivl	%ecx
	cmpl	%eax, 24(%rbp)
	jl	.L38
	movl	$0, %eax
	jmp	.L36
.L38:
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	imull	24(%rbp), %eax
	cltq
	addq	%rdx, %rax
.L36:
	popq	%rbp
	ret
	.seh_endproc
	.globl	read_file
	.def	read_file;	.scl	2;	.type	32;	.endef
	.seh_proc	read_file
read_file:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movl	$0, %edx
	movl	$24, %ecx
	call	buf_new
	movq	%rax, lines(%rip)
	movl	$0, %edx
	movl	$216, %ecx
	call	buf_new
	movq	%rax, queues(%rip)
	movl	$0, -16(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.L40
.L44:
	movzbl	-25(%rbp), %eax
	cmpb	$10, %al
	jne	.L41
	movq	lines(%rip), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	buf_expand
	movq	lines(%rip), %rax
	movq	%rax, %rcx
	call	buf_last
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdx
	movl	$1, %ecx
	call	buf_new
	movl	$0, -12(%rbp)
	addl	$1, -16(%rbp)
	jmp	.L40
.L41:
	movq	lines(%rip), %rax
	movq	%rax, %rcx
	call	buf_empty
	testl	%eax, %eax
	je	.L42
	movq	lines(%rip), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	buf_expand
	movq	lines(%rip), %rax
	movq	%rax, %rcx
	call	buf_last
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdx
	movl	$1, %ecx
	call	buf_new
.L42:
	movzbl	-25(%rbp), %eax
	cmpb	$81, %al
	jne	.L43
	movq	queues(%rip), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	buf_expand
	movq	queues(%rip), %rax
	movq	%rax, %rcx
	call	buf_last
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$200, %r8d
	movl	$0, %edx
	movq	%rax, %rcx
	call	memset
	movq	-24(%rbp), %rax
	movl	$0, 204(%rax)
	movq	-24(%rbp), %rax
	movl	204(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 200(%rax)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, 208(%rax)
	movq	-24(%rbp), %rax
	movl	-16(%rbp), %edx
	movl	%edx, 212(%rax)
.L43:
	leaq	-25(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	buf_expand
	addl	$1, -12(%rbp)
.L40:
	movq	16(%rbp), %rcx
	call	getc
	movb	%al, -25(%rbp)
	movzbl	-25(%rbp), %eax
	cmpb	$-1, %al
	jne	.L44
	nop
	nop
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	get_at
	.def	get_at;	.scl	2;	.type	32;	.endef
	.seh_proc	get_at
get_at:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movl	%edx, 24(%rbp)
	movq	lines(%rip), %rax
	movl	24(%rbp), %edx
	movq	%rax, %rcx
	call	buf_get
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L46
	movl	$32, %eax
	jmp	.L47
.L46:
	movq	-8(%rbp), %rax
	movl	16(%rbp), %edx
	movq	%rax, %rcx
	call	buf_get
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L48
	movl	$32, %eax
	jmp	.L47
.L48:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
.L47:
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC3:
	.ascii "You forgot to set a queue!\0"
	.text
	.globl	pop
	.def	pop;	.scl	2;	.type	32;	.endef
	.seh_proc	pop
pop:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	cmpq	$0, 16(%rbp)
	jne	.L50
	leaq	.LC3(%rip), %rax
	movq	%rax, %rcx
	call	error
.L50:
	movq	16(%rbp), %rax
	movl	204(%rax), %eax
	testl	%eax, %eax
	jne	.L51
	movl	$0, %eax
	jmp	.L52
.L51:
	movq	16(%rbp), %rax
	movl	200(%rax), %eax
	movq	16(%rbp), %rdx
	cltq
	movzbl	(%rdx,%rax), %eax
	movb	%al, -1(%rbp)
	movq	16(%rbp), %rax
	movl	200(%rax), %eax
	leal	1(%rax), %edx
	movslq	%edx, %rax
	imulq	$1374389535, %rax, %rax
	shrq	$32, %rax
	sarl	$6, %eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	imull	$200, %eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	movq	16(%rbp), %rdx
	movl	%eax, 200(%rdx)
	movq	16(%rbp), %rax
	movl	204(%rax), %eax
	leal	-1(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 204(%rax)
	movzbl	-1(%rbp), %eax
.L52:
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC4:
	.ascii "Tried to push too much into the queue\0"
	.text
	.globl	push
	.def	push;	.scl	2;	.type	32;	.endef
	.seh_proc	push
push:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movl	%edx, %eax
	movb	%al, 24(%rbp)
	cmpq	$0, 16(%rbp)
	jne	.L54
	leaq	.LC3(%rip), %rax
	movq	%rax, %rcx
	call	error
.L54:
	movq	16(%rbp), %rax
	movl	204(%rax), %eax
	cmpl	$200, %eax
	jne	.L55
	leaq	.LC4(%rip), %rax
	movq	%rax, %rcx
	call	error
.L55:
	movq	16(%rbp), %rax
	movl	200(%rax), %r8d
	movq	16(%rbp), %rax
	movl	204(%rax), %eax
	leal	1(%rax), %ecx
	movq	16(%rbp), %rdx
	movl	%ecx, 204(%rdx)
	leal	(%r8,%rax), %edx
	movslq	%edx, %rax
	imulq	$1374389535, %rax, %rax
	shrq	$32, %rax
	sarl	$6, %eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	imull	$200, %eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	movq	16(%rbp), %rdx
	cltq
	movzbl	24(%rbp), %ecx
	movb	%cl, (%rdx,%rax)
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	inc_dir
	.def	inc_dir;	.scl	2;	.type	32;	.endef
	.seh_proc	inc_dir
inc_dir:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	16(%rbp), %rax
	movl	(%rax), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	cmpl	%eax, %edx
	jne	.L57
	movq	16(%rbp), %rax
	movl	$0, (%rax)
	jmp	.L60
.L57:
	movq	16(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L59
	movq	16(%rbp), %rax
	movl	(%rax), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, (%rax)
	jmp	.L60
.L59:
	movq	16(%rbp), %rax
	movl	4(%rax), %edx
	movq	16(%rbp), %rax
	movl	(%rax), %eax
	addl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 4(%rax)
.L60:
	nop
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC5:
	.ascii "Buffer Memory Location returned NULL\0"
	.text
	.globl	split_ip
	.def	split_ip;	.scl	2;	.type	32;	.endef
	.seh_proc	split_ip
split_ip:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movq	current(%rip), %rax
	movl	8(%rax), %eax
	movl	%eax, -24(%rbp)
	movq	current(%rip), %rax
	movl	12(%rax), %eax
	movl	%eax, -20(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L62
.L65:
	leaq	-24(%rbp), %rax
	movq	%rax, %rcx
	call	inc_dir
	movq	current(%rip), %rax
	movl	4(%rax), %edx
	movl	-20(%rbp), %eax
	addl	%eax, %edx
	movq	current(%rip), %rax
	movl	(%rax), %ecx
	movl	-24(%rbp), %eax
	addl	%ecx, %eax
	movl	%eax, %ecx
	call	get_at
	cmpb	$32, %al
	je	.L63
	movl	$40, %ecx
	call	malloc
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L64
	leaq	.LC5(%rip), %rax
	movq	%rax, %rcx
	call	error
.L64:
	movq	current(%rip), %rax
	movq	16(%rax), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, 16(%rax)
	movq	current(%rip), %rax
	movzbl	24(%rax), %edx
	movq	-16(%rbp), %rax
	movb	%dl, 24(%rax)
	movq	current(%rip), %rax
	movl	(%rax), %edx
	movl	-24(%rbp), %eax
	addl	%eax, %edx
	movq	-16(%rbp), %rax
	movl	%edx, (%rax)
	movq	current(%rip), %rax
	movl	4(%rax), %edx
	movl	-20(%rbp), %eax
	addl	%eax, %edx
	movq	-16(%rbp), %rax
	movl	%edx, 4(%rax)
	movl	-24(%rbp), %edx
	movq	-16(%rbp), %rax
	movl	%edx, 8(%rax)
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rax
	movl	%edx, 12(%rax)
	movq	current(%rip), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, 32(%rax)
	movq	last(%rip), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 32(%rax)
	movq	-16(%rbp), %rax
	movq	%rax, last(%rip)
.L63:
	addl	$1, -4(%rbp)
.L62:
	cmpl	$6, -4(%rbp)
	jle	.L65
	nop
	nop
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	parse
	.def	parse;	.scl	2;	.type	32;	.endef
	.seh_proc	parse
parse:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	leaq	48(%rsp), %rbp
	.seh_setframe	%rbp, 48
	.seh_endprologue
	movl	%ecx, %eax
	movb	%al, 32(%rbp)
	cmpb	$47, 32(%rbp)
	jle	.L67
	cmpb	$57, 32(%rbp)
	jg	.L67
	movzbl	32(%rbp), %eax
	subl	$48, %eax
	movzbl	%al, %edx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	push
	jmp	.L66
.L67:
	movsbl	32(%rbp), %eax
	subl	$33, %eax
	cmpl	$82, %eax
	ja	.L66
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L70(%rip), %rax
	movl	(%rdx,%rax), %eax
	cltq
	leaq	.L70(%rip), %rdx
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L70:
	.long	.L84-.L70
	.long	.L66-.L70
	.long	.L83-.L70
	.long	.L82-.L70
	.long	.L81-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L80-.L70
	.long	.L79-.L70
	.long	.L66-.L70
	.long	.L78-.L70
	.long	.L66-.L70
	.long	.L77-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L76-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L74-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L73-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L72-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L71-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L66-.L70
	.long	.L69-.L70
	.text
.L74:
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L85
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movl	208(%rax), %edx
	movq	current(%rip), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jne	.L85
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movl	212(%rax), %edx
	movq	current(%rip), %rax
	movl	4(%rax), %eax
	cmpl	%eax, %edx
	je	.L90
.L85:
	movq	queues(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	jmp	.L86
.L89:
	movq	-8(%rbp), %rax
	movl	208(%rax), %edx
	movq	current(%rip), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jne	.L87
	movq	-8(%rbp), %rax
	movl	212(%rax), %edx
	movq	current(%rip), %rax
	movl	4(%rax), %eax
	cmpl	%eax, %edx
	jne	.L87
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L88
	movq	current(%rip), %rax
	movzbl	24(%rax), %eax
	movzbl	%al, %edx
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	push
.L88:
	movq	current(%rip), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 16(%rax)
.L87:
	addq	$216, -8(%rbp)
.L86:
	movq	queues(%rip), %rax
	movq	(%rax), %rdx
	movq	queues(%rip), %rax
	movl	12(%rax), %eax
	cltq
	addq	%rdx, %rax
	cmpq	%rax, -8(%rbp)
	jb	.L89
	jmp	.L66
.L76:
	call	split_ip
	jmp	.L66
.L73:
	call	getchar
	movzbl	%al, %edx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	push
	jmp	.L66
.L71:
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	pop
	movsbl	%al, %eax
	movl	%eax, %ecx
	call	putchar
	jmp	.L66
.L72:
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	current(%rip), %rbx
	movq	%rax, %rcx
	call	pop
	movb	%al, 24(%rbx)
	jmp	.L66
.L69:
	movq	current(%rip), %rax
	movzbl	24(%rax), %eax
	movzbl	%al, %edx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	push
	jmp	.L66
.L79:
	movq	current(%rip), %rax
	movzbl	24(%rax), %ebx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	pop
	addl	%ebx, %eax
	movzbl	%al, %edx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	push
	jmp	.L66
.L78:
	movq	current(%rip), %rax
	movzbl	24(%rax), %ebx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	pop
	movl	%eax, %edx
	movl	%ebx, %eax
	subl	%edx, %eax
	movzbl	%al, %edx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	push
	jmp	.L66
.L80:
	movq	current(%rip), %rax
	movzbl	24(%rax), %ebx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	pop
	movl	%eax, %edx
	movl	%ebx, %eax
	imull	%edx, %eax
	movzbl	%al, %edx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	push
	jmp	.L66
.L77:
	movq	current(%rip), %rax
	movzbl	24(%rax), %ebx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	pop
	movl	%eax, %edx
	movzbl	%bl, %eax
	divb	%dl
	movzbl	%al, %edx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	push
	jmp	.L66
.L81:
	movq	current(%rip), %rax
	movzbl	24(%rax), %ebx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	pop
	movl	%eax, %edx
	movzbl	%bl, %eax
	divb	%dl
	movzbl	%ah, %eax
	movzbl	%al, %edx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	push
	jmp	.L66
.L84:
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	pop
	testb	%al, %al
	sete	%al
	movzbl	%al, %edx
	movq	current(%rip), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	push
	jmp	.L66
.L83:
	movl	$1, skip(%rip)
	jmp	.L66
.L82:
	movl	$2, skip(%rip)
	jmp	.L66
.L90:
	nop
.L66:
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.globl	change_dir
	.def	change_dir;	.scl	2;	.type	32;	.endef
	.seh_proc	change_dir
change_dir:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	$0, -24(%rbp)
	movl	$0, -8(%rbp)
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	negl	%eax
	movl	%eax, -16(%rbp)
	movq	16(%rbp), %rax
	movl	12(%rax), %eax
	negl	%eax
	movl	%eax, -12(%rbp)
	leaq	-16(%rbp), %rax
	movq	%rax, %rcx
	call	inc_dir
	movl	$1, -4(%rbp)
	jmp	.L92
.L94:
	movq	16(%rbp), %rax
	movl	4(%rax), %edx
	movl	-12(%rbp), %eax
	addl	%eax, %edx
	movq	16(%rbp), %rax
	movl	(%rax), %ecx
	movl	-16(%rbp), %eax
	addl	%ecx, %eax
	movl	%eax, %ecx
	call	get_at
	cmpb	$32, %al
	je	.L93
	movl	-4(%rbp), %eax
	cltq
	movb	$1, -24(%rbp,%rax)
	addl	$1, -8(%rbp)
.L93:
	leaq	-16(%rbp), %rax
	movq	%rax, %rcx
	call	inc_dir
	addl	$1, -4(%rbp)
.L92:
	cmpl	$7, -4(%rbp)
	jle	.L94
	cmpl	$0, -8(%rbp)
	jne	.L95
	movl	$0, %eax
	jmp	.L100
.L95:
	cmpl	$1, -8(%rbp)
	jle	.L97
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, %rcx
	call	pop
	movzbl	%al, %eax
	cltd
	idivl	-8(%rbp)
	movl	%edx, %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
.L97:
	movl	$0, -4(%rbp)
	jmp	.L98
.L99:
	leaq	-16(%rbp), %rax
	movq	%rax, %rcx
	call	inc_dir
	addl	$1, -4(%rbp)
	movl	-4(%rbp), %eax
	cltq
	movzbl	-24(%rbp,%rax), %eax
	testb	%al, %al
	je	.L98
	subl	$1, -8(%rbp)
.L98:
	cmpl	$0, -8(%rbp)
	jg	.L99
	movl	-16(%rbp), %edx
	movq	16(%rbp), %rax
	movl	%edx, 8(%rax)
	movl	-12(%rbp), %edx
	movq	16(%rbp), %rax
	movl	%edx, 12(%rax)
	movl	$1, %eax
.L100:
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC6:
	.ascii "Memory allocation error while preparing to run\0"
	.text
	.globl	run
	.def	run;	.scl	2;	.type	32;	.endef
	.seh_proc	run
run:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	$40, %ecx
	call	malloc
	movq	%rax, current(%rip)
	movq	current(%rip), %rax
	testq	%rax, %rax
	jne	.L102
	leaq	.LC6(%rip), %rax
	movq	%rax, %rcx
	call	error
.L102:
	movq	current(%rip), %rax
	movq	current(%rip), %rdx
	movq	%rdx, 32(%rax)
	movq	32(%rax), %rax
	movq	%rax, last(%rip)
	movq	current(%rip), %rax
	movl	$0, 4(%rax)
	movq	current(%rip), %rdx
	movl	4(%rax), %eax
	movl	%eax, (%rdx)
	movq	current(%rip), %rax
	movl	$1, 12(%rax)
	movq	current(%rip), %rdx
	movl	12(%rax), %eax
	movl	%eax, 8(%rdx)
	movq	current(%rip), %rax
	movq	$0, 16(%rax)
	movq	current(%rip), %rax
	movb	$0, 24(%rax)
	movl	$0, skip(%rip)
	jmp	.L103
.L109:
	movl	skip(%rip), %eax
	cmpl	$2, %eax
	jne	.L104
	movq	current(%rip), %rax
	movl	4(%rax), %edx
	movq	current(%rip), %rax
	movl	(%rax), %eax
	movl	%eax, %ecx
	call	get_at
	cmpb	$36, %al
	je	.L104
	movl	$0, skip(%rip)
.L104:
	movl	skip(%rip), %eax
	testl	%eax, %eax
	jne	.L105
	movq	current(%rip), %rax
	movl	4(%rax), %edx
	movq	current(%rip), %rax
	movl	(%rax), %eax
	movl	%eax, %ecx
	call	get_at
	movsbl	%al, %eax
	movl	%eax, %ecx
	call	parse
.L105:
	movl	skip(%rip), %eax
	cmpl	$1, %eax
	jne	.L106
	movl	$0, skip(%rip)
.L106:
	movq	current(%rip), %rax
	movq	%rax, %rcx
	call	change_dir
	testl	%eax, %eax
	je	.L107
	movq	current(%rip), %rax
	movl	(%rax), %ecx
	movq	current(%rip), %rax
	movl	8(%rax), %edx
	movq	current(%rip), %rax
	addl	%ecx, %edx
	movl	%edx, (%rax)
	movq	current(%rip), %rax
	movl	4(%rax), %ecx
	movq	current(%rip), %rax
	movl	12(%rax), %edx
	movq	current(%rip), %rax
	addl	%ecx, %edx
	movl	%edx, 4(%rax)
	movq	current(%rip), %rax
	movq	%rax, last(%rip)
	movq	current(%rip), %rax
	movq	32(%rax), %rax
	movq	%rax, current(%rip)
	jmp	.L103
.L107:
	movq	last(%rip), %rdx
	movq	current(%rip), %rax
	cmpq	%rax, %rdx
	jne	.L108
	movq	current(%rip), %rax
	movq	%rax, %rcx
	call	free
	movq	$0, current(%rip)
	jmp	.L103
.L108:
	movq	current(%rip), %rdx
	movq	last(%rip), %rax
	movq	32(%rdx), %rdx
	movq	%rdx, 32(%rax)
	movq	current(%rip), %rax
	movq	%rax, %rcx
	call	free
	movq	last(%rip), %rax
	movq	32(%rax), %rax
	movq	%rax, current(%rip)
.L103:
	movq	current(%rip), %rax
	testq	%rax, %rax
	jne	.L109
	nop
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC7:
	.ascii "Missing filename\0"
.LC8:
	.ascii "r\0"
.LC9:
	.ascii "Cannot open %s for reading\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	call	__main
	cmpl	$2, 16(%rbp)
	je	.L111
	leaq	.LC7(%rip), %rax
	movq	%rax, %rcx
	call	error
.L111:
	movq	24(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC8(%rip), %rdx
	movq	%rax, %rcx
	call	fopen
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L112
	movq	24(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdx
	leaq	.LC9(%rip), %rax
	movq	%rax, %rcx
	call	error
.L112:
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	read_file
	call	run
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (GNU) 11.2.0"
	.def	__getreent;	.scl	2;	.type	32;	.endef
	.def	fwrite;	.scl	2;	.type	32;	.endef
	.def	vfprintf;	.scl	2;	.type	32;	.endef
	.def	fputc;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	exit;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	realloc;	.scl	2;	.type	32;	.endef
	.def	memset;	.scl	2;	.type	32;	.endef
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	getc;	.scl	2;	.type	32;	.endef
	.def	getchar;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
