import std,WsWorkunits,Workman;
EXPORT get_FilesWritten(
   pWorkunitID = '\'\''
  ,pesp        = 'Workman._Config.LocalEsp'
  ,pUseGlobal  = 'true'
) :=
functionmacro

  import std,Workman,wk_ut;
  
  #IF(pUseGlobal = true and pesp in Workman._Config.LocalEsps)
    returnresult := global(nothor(STD.System.Workunit.WorkunitFilesWritten(pWorkunitID)),few);
  #ELSIF(pUseGlobal = false and pesp in Workman._Config.LocalEsps)
    returnresult := STD.System.Workunit.WorkunitFilesWritten(pWorkunitID);
  #ELSE
    returnresult := WsWorkunits.get_FilesWritten            (pWorkunitID,pesp,pUseGlobal);
  #END

  return returnresult;
  
endmacro;