.386
.model flat, stdcall
option casemap: none
include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib

.code
main proc
	call	func
	mov		ebx, 5	; anything to help us set a breakpoint to test our idea
main endp

func proc
	mov		eax, [esp]
	ret
func endp
end main