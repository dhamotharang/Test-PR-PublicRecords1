import Workman,wk_ut;

EXPORT get_FilesWritten(
   pWorkunitID = '\'\''
  ,pesp        = 'wk_ut._Constants.LocalEsp'
  ,pUseGlobal  = 'true'
) :=
functionmacro

  import Workman;
  
  return Workman.get_FilesWritten(pWorkunitID ,pesp ,pUseGlobal);

endmacro;