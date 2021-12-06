.386
.model flat, stdcall
option casemap: none
include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib

.data
    val     db      'A'
    char    db      '*'
    iSize   dd      5

.data?
    buf     db  30  dup(?)
    buf2    db  30  dup(?)
    chr     db      ?     
.code
main proc
    ; Get buffer from user
    push    30
    push    offset buf
    call    StdIn

    ; Get str to compare
    push    30
    push    offset buf2
    call    StdIn

    ; Get char to find in buffer
    push    1
    push    offset chr
    call    StdIn

    push    offset buf
    call    strlen
    
    movzx   eax, chr
    push    eax
    push    offset buf
    call    strchr

    push    offset buf2
    push    offset buf
    call    strcmp

    push    offset buf
    push    iSize
    movzx   eax, val
    push    eax
    push    offset buf
    call    memset

    movzx   eax, char
    push    eax
    push    offset buf
    call    strset

    push    eax
main endp

strlen proc
    push    ebp
    mov     ebp, esp
    mov     edi, [ebp + 8]
    mov     ecx, 0ffffffffh
    xor     al, al
    repne   scasb
    sub     edi, [ebp + 8]
    dec     edi
    mov     eax, edi
    mov     esp, ebp
    pop     ebp
    ret     4
strlen endp

strchr proc
    push    ebp
    mov     ebp, esp
    mov     edi, [ebp + 8]
    mov     al, byte ptr [ebp + 0ch]
    mov     ah, 0
    compare:
    cmp     byte ptr [edi], ah
    jz      fail
    scasb
    jne     compare  
    sub     edi, [ebp + 8]
    mov     eax, edi
    mov     esp, ebp
    pop     ebp
    ret     8
    fail:
    mov     eax, 0
    mov     esp, ebp
    pop     ebp
    ret     8
strchr endp

memset proc
    push    ebp
    mov     ebp, esp
    mov     edi, [ebp + 8]
    mov     al, byte ptr [ebp + 0ch]
    mov     ecx, [ebp + 10h]
    rep     stosb
    mov     eax, [ebp + 8]
    mov     esp, ebp
    pop     ebp
    ret     0ch
memset endp

strcmp proc
    push    ebp
    mov     ebp, esp
    mov     ecx, 0ffffffffh
    mov     esi, [ebp + 8]
    ; calc strlen to count loops
    mov     edi, [ebp + 0ch]
    mov     ecx, 0ffffffffh
    xor     al, al
    repne   scasb
    sub     edi, [ebp + 0ch]
    dec     edi
    mov     ecx, edi

    mov     edi, [ebp + 0ch]
    compare:
    repe    cmpsb
    jg      greater
    jl      less
    test    ecx, ecx
    jnz     greater
    cmp     byte ptr [esi], 0
    jnz     greater
    mov     eax, 0
    mov     esp, ebp
    pop     ebp
    ret     8    

    greater:
    mov     eax, 1
    mov     esp, ebp
    pop     ebp
    ret     8

    less:
    mov     eax, 0ffffffffh
    mov     esp, ebp
    pop     ebp
    ret     8
strcmp endp

strset proc
    push    ebp
    mov     ebp, esp

    ; calc strlen
    mov     edi, [ebp + 8]
    mov     al, 0
    mov     ecx, 0ffffffffh
    repne   scasb
    sub     edi, [ebp +8]
    dec     edi
    mov     ecx, edi        ; set timer
    mov     edi, [ebp + 8]
    mov     al, [ebp + 0ch]
    rep     stosb
    mov     eax, [ebp + 8]
    mov     esp, ebp
    pop     ebp
    ret     8
strset endp
end main
