.386
.model flat, stdcall
option casemap: none

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\user32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\user32.lib

.data
	buf	    db	'First try!', 0
	chr	    db	'x'

.code 
main PROC
    ; before
    push    offset buf
    call    StdOut

    movzx   eax, chr
    push    eax             ; x86 masm dont support push a byte onto stack
    push    offset buf
    call    func 

    ; after
    push    offset buf
    call    StdOut
main ENDP

func PROC
    push    ebp
    mov     ebp, esp
    ; start code
    mov     edi, [ebp + 8]  ; move offset buf into edi register
    mov     edx, edi        ; move to edx to keep the base value
    xor     eax, eax        ; eax = 0
    or      ecx, 0FFFFFFFFh ; ecx = 0FFFFFFFFh
    repne scasb             ; while (di != al) ++di --ecx
    add     ecx, 2          ; ecx += 2
    neg     ecx             ; ecx*-1. After this line ecx = strlen(buf)
    mov     al, [ebp + 0Ch]  
    mov     edi, edx        ; edi holds offset buf
    rep stosb               ; while (ecx--) do *di++ = al
    mov     eax, edx        ; mov offset buf to eax to return
    ; end code
    mov     esp, ebp
    pop     ebp
    ret     8               ; clear the stack
func ENDP
end main