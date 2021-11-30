.386
.model flat, stdcall
option casemap: none
include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib

.code
main proc
	push	0AABBCCDDh	; now top of stack holds our value
	ret	
	mov		ebx, 5	; just to set a breakpoint 
main endp
end main