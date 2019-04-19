import Workman;
EXPORT get_FilesRead(
   pWorkunitID = '\'\''
  ,pesp        = 'wk_ut._Constants.LocalEsp'
  ,pUseGlobal  = 'true'
) :=
functionmacro
 import Workman;
 return Workman.get_FilesRead(pWorkunitID,pesp,pUseGlobal);
 
endmacro;