# Chapter 1 x86 and x64

| Exercise | Status | 
| --- | --- |
| [Page 11](#exercise-page-11) | :heavy_check_mark: |
| [Page 17](#exercise-page-17) | :heavy_check_mark: |

## Exercise page 11

`[ebp + 8]` appeared to be a byte sequence of size unknown (but not greater than 0FFFFFFFFh). Speaking C way, this is a null-terminated string.  
`[ebp + 0Ch]` appeared to be a byte. In C, it is a character.

This snippet first loop through the sequence until it meets a NULL. Then it replace all bytes of the sequence with the value of `[ebp + 0Ch]`.

I took some extra steps to get a compilable x86 MASM [file](p11.asm). I have left comment after each line of code.

## Exercise page 17  
1. Since `eip` is not a general purpose register, it doesn't support `mov eax, eip`.
We know `call` put the offset about to be executed after the call (value of EIP after the call) on top of the stack, and we can access value on the stack, maybe this [code](/p171.asm) would do the trick?  
Setting 2 breakpoints at line 11, 12 and debug, I realize that right before execute line 12, we got the right value of `eip` in our register `eax`! We can see the value of `eip` after the call is 5 bytes greater than the value before the call, since the `call` instruction size is 5 bytes (could be seen by looking at Memory view when  debug).  
  
2.  We can't just simply do `mov eip, 0xAABBCCDD` or similar since `eip` is not a GPR.  
- Knowing `ret` just pops the value on top of the stack to `eip` to execute, I came up with [this](p1721.asm) idea...  
You might face an *Frame not in module* error while running but don't worry. Now `eip` has pointed to our offset!
- Another trick is using [`call`](p1723.asm) or [`jmp`](p1722.asm) family. Try calling it with our offset, but in masm we can't do it directly so I put our value in `eax`.
`call` is just a `jmp` and a `push` onto the stack.  

3. In general, if we don't re-align the stack before calling `ret`, `eip` might receive the wrong value to execute and therefore cause much trouble.  
But in this example, since the function `addme` didn't make any `push` or `pop` instruction, the `esp` was not modified at all, so, even if we did not restore it, nothing would go wrong.    

4. Write [a simple C program](p174.c) to experiment. After compiling with MS C++ Compiler, we have an [listing file](p174.cod) here.  
Look at line 77:
```
; 19   :     func(dat);

  0002c	83 ec 0c	 sub	 esp, 12			; 0000000cH
  0002f	8b c4		 mov	 eax, esp
  00031	8b 4d f0	 mov	 ecx, DWORD PTR _dat$[ebp]
  00034	89 08		 mov	 DWORD PTR [eax], ecx
  00036	8b 55 f4	 mov	 edx, DWORD PTR _dat$[ebp+4]
  00039	89 50 04	 mov	 DWORD PTR [eax+4], edx
  0003c	8b 4d f8	 mov	 ecx, DWORD PTR _dat$[ebp+8]
  0003f	89 48 08	 mov	 DWORD PTR [eax+8], ecx
  00042	8d 95 1c ff ff
	ff		 lea	 edx, DWORD PTR $T1[ebp]
  00048	52		 push	 edx
  00049	e8 00 00 00 00	 call	 _func
  0004e	83 c4 10	 add	 esp, 16			; 00000010H
```
I created a struct of 3 ints (3 double-words). The compiler first copied the value to a new offset, then push the base address onto the stack to pass to my function `func`. On the function, the `return` part which started from line 167 was:
```
; 13   :     return obj;

  00031	8b 45 08	 mov	 eax, DWORD PTR $T1[ebp]
  00034	8b 4d 0c	 mov	 ecx, DWORD PTR _obj$[ebp]
  00037	89 08		 mov	 DWORD PTR [eax], ecx
  00039	8b 55 10	 mov	 edx, DWORD PTR _obj$[ebp+4]
  0003c	89 50 04	 mov	 DWORD PTR [eax+4], edx
  0003f	8b 4d 14	 mov	 ecx, DWORD PTR _obj$[ebp+8]
  00042	89 48 08	 mov	 DWORD PTR [eax+8], ecx
  00045	8b 45 08	 mov	 eax, DWORD PTR $T1[ebp]
```
In short, it stores the base address in `eax` to return. In case my C program has only 2 ints in the struct, it would return in `eax` and `edx`.
I tried compiling it with GCC to get [this file](p174.s):
```
$ gcc -fverbose-asm -S p174.c -o p174.s -O0 -masm=intel -m32
```
Take a look at `main` function and we can see the arguments was passed to function by stack at line 97:
```
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
```
One more `cdecl` call and it pushed all 3 values onto the stack. In the `func` function, our `return` was implemented at line 63:
```
# p174.c:13:     return obj;
	mov	eax, DWORD PTR 8[ebp]	# tmp85, .result_ptr
	mov	edx, DWORD PTR 12[ebp]	# tmp86, obj
	mov	DWORD PTR [eax], edx	# <retval>, tmp86
	mov	edx, DWORD PTR 16[ebp]	# tmp87, obj
	mov	DWORD PTR 4[eax], edx	# <retval>, tmp87
	mov	edx, DWORD PTR 20[ebp]	# tmp88, obj
	mov	DWORD PTR 8[eax], edx	# <retval>, tmp88
```
In this `return` progress, the compiler store the base address of the struct onto the `eax` register to be the return value.

So, by some experiment on MS C++ Compiler and GCC compiler, we can say the mechanism doesn't vary between compilers.