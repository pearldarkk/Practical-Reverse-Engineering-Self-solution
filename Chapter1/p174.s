	.file	"p174.c"
	.intel_syntax noprefix
# GNU C17 (Debian 10.3.0-9) version 10.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.0, isl version isl-0.23-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  -imultilib 32 -imultiarch i386-linux-gnu p174.c
# -masm=intel -m32 -mtune=generic -march=i686 -auxbase-strip p174.s -O0
# -fverbose-asm -fasynchronous-unwind-tables
# options enabled:  -fPIC -fPIE -faggressive-loop-optimizations
# -fallocation-dce -fasynchronous-unwind-tables -fauto-inc-dec
# -fdelete-null-pointer-checks -fdwarf2-cfi-asm -fearly-inlining
# -feliminate-unused-debug-symbols -feliminate-unused-debug-types
# -ffp-int-builtin-inexact -ffunction-cse -fgcse-lm -fgnu-unique -fident
# -finline-atomics -fipa-stack-alignment -fira-hoist-pressure
# -fira-share-save-slots -fira-share-spill-slots -fivopts
# -fkeep-static-consts -fleading-underscore -flifetime-dse -fmath-errno
# -fmerge-debug-strings -fpcc-struct-return -fpeephole -fplt
# -fprefetch-loop-arrays -fsched-critical-path-heuristic
# -fsched-dep-count-heuristic -fsched-group-heuristic -fsched-interblock
# -fsched-last-insn-heuristic -fsched-rank-heuristic -fsched-spec
# -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-fusion
# -fsemantic-interposition -fshow-column -fshrink-wrap-separate
# -fsigned-zeros -fsplit-ivs-in-unroller -fssa-backprop -fstdarg-opt
# -fstrict-volatile-bitfields -fsync-libcalls -ftrapping-math -ftree-cselim
# -ftree-forwprop -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
# -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop
# -ftree-reassoc -ftree-scev-cprop -funit-at-a-time -funwind-tables
# -fverbose-asm -fzero-initialized-in-bss -m32 -m80387 -m96bit-long-double
# -malign-stringops -mavx256-split-unaligned-load
# -mavx256-split-unaligned-store -mfancy-math-387 -mfp-ret-in-387 -mglibc
# -mieee-fp -mlong-double-80 -mno-red-zone -mno-sse4 -mpush-args -msahf
# -mstv -mtls-direct-seg-refs -mvzeroupper

	.text
	.globl	data
	.bss
	.align 4
	.type	data, @object
	.size	data, 12
data:
	.zero	12
	.text
	.globl	func
	.type	func, @function
func:
.LFB6:
	.cfi_startproc
	push	ebp	#
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp	#,
	.cfi_def_cfa_register 5
	call	__x86.get_pc_thunk.ax	#
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_	# tmp82,
# p174.c:11:     ++obj.x;
	mov	eax, DWORD PTR 12[ebp]	# _1, obj.x
# p174.c:11:     ++obj.x;
	add	eax, 1	# _2,
	mov	DWORD PTR 12[ebp], eax	# obj.x, _2
# p174.c:12:     obj.y = 5;
	mov	DWORD PTR 16[ebp], 5	# obj.y,
# p174.c:13:     return obj;
	mov	eax, DWORD PTR 8[ebp]	# tmp85, .result_ptr
	mov	edx, DWORD PTR 12[ebp]	# tmp86, obj
	mov	DWORD PTR [eax], edx	# <retval>, tmp86
	mov	edx, DWORD PTR 16[ebp]	# tmp87, obj
	mov	DWORD PTR 4[eax], edx	# <retval>, tmp87
	mov	edx, DWORD PTR 20[ebp]	# tmp88, obj
	mov	DWORD PTR 8[eax], edx	# <retval>, tmp88
# p174.c:14: }
	mov	eax, DWORD PTR 8[ebp]	#, .result_ptr
	pop	ebp	#
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	4		#
	.cfi_endproc
.LFE6:
	.size	func, .-func
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	lea	ecx, 4[esp]	#,
	.cfi_def_cfa 1, 0
	and	esp, -16	#,
	push	DWORD PTR -4[ecx]	#
	push	ebp	#
	mov	ebp, esp	#,
	.cfi_escape 0x10,0x5,0x2,0x75,0
	push	ecx	#
	.cfi_escape 0xf,0x3,0x75,0x7c,0x6
	sub	esp, 36	#,
	call	__x86.get_pc_thunk.ax	#
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_	# tmp82,
# p174.c:18:     dat.x = 2;
	mov	DWORD PTR -20[ebp], 2	# dat.x,
# p174.c:19:     func(dat);
	lea	eax, -40[ebp]	# tmp85,
	push	DWORD PTR -12[ebp]	# dat
	push	DWORD PTR -16[ebp]	# dat
	push	DWORD PTR -20[ebp]	# dat
	push	eax	# tmp85
	call	func	#
	add	esp, 12	#,
# p174.c:21:     return 0;
	mov	eax, 0	# _4,
# p174.c:22: }
	mov	ecx, DWORD PTR -4[ebp]	#,
	.cfi_def_cfa 1, 0
	leave	
	.cfi_restore 5
	lea	esp, -4[ecx]	#,
	.cfi_def_cfa 4, 4
	ret	
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB8:
	.cfi_startproc
	mov	eax, DWORD PTR [esp]	#,
	ret	
	.cfi_endproc
.LFE8:
	.ident	"GCC: (Debian 10.3.0-9) 10.3.0"
	.section	.note.GNU-stack,"",@progbits
