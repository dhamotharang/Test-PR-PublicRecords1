import Workman;
EXPORT get_FilesRead(
   pWorkunitID = '\'\''
  ,pesp        = 'wk_ut._Constants.LocalEsp'
  ,pUseGlobal  = 'true'
) :=
functionmacro
 
 return Workman.get_FilesRead(pWorkunitID,pesp,pUseGlobal);
 
endmacro;