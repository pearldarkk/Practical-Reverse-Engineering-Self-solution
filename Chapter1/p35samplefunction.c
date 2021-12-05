#include <Windows.h>
#include <intrin.h> 

BOOL __stdcall DllMain(HINSTANCE hinstDll, DWORD fdwReason, LPVOID lpvReserved) {
    __sidt(ebp - 08h);
}