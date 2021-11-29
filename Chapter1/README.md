# Chapter 1 x86 and x64

| Exercise | Status | 
| --- | --- |
| [Page 11](#exercise-page-11) | :heavy_check_mark: |
| [Page 11](#exercise-page-11) |  |

## Exercise page 11

```
01: 8B 7D 08    mov     edi, [ebp+8]
02: 8B D7       mov     edx, edi
03: 33 C0       xor     eax, eax
04: 83 C9 FF    or      ecx, 0FFFFFFFFh
05: F2 AE       repne scasb
06: 83 C1 02    add     ecx, 2
07: F7 D9       neg     ecx
08: 8A 45 0C    mov     al, [ebp+0Ch]
09: 8B FA       mov     edi, edx
10: F3 AA       rep stosb
11: 8B C2       mov     eax, edx
```

`[ebp + 8]` appeared to be a byte sequence of size 0FFFFFFFFh. Speaking C way, this is a null-terminated string.  
`[ebp + 0Ch]` appeared to be a byte. In C, it is a character.

This snippet first loop through the sequence until it meets a NULL. Then it replace all bytes of the sequence with the value of `[ebp + 0Ch]`.

I took some extra steps to get a compilable x86 MASM [file](). I have left comment after each line of code.