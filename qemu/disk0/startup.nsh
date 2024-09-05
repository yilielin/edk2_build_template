#Put this nsh and bin files to root of USB
@echo -off

for %a run (0 255 1)
  set -v FsIndex %a
  if exist FS%FsIndex%:\NvVars then
	FS%FsIndex%:
	goto FsCheckEnd
  endif
endfor

:FsCheckEnd


:script_start
ls



:script_done

