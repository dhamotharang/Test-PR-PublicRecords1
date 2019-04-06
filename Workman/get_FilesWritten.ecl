import std,WsWorkunits;
EXPORT get_FilesWritten(
   pWorkunitID = '\'\''
  ,pesp        = '_Config.LocalEsp'
  ,pUseGlobal  = 'true'
) :=
functionmacro

  import std;
  
  #IF(pUseGlobal = true and pesp in _Config.LocalEsps)
    returnresult := global(nothor(STD.System.Workunit.WorkunitFilesWritten(pWorkunitID)),few);
  #ELSIF(pUseGlobal = false and pesp in _Config.LocalEsps)
    returnresult := STD.System.Workunit.WorkunitFilesWritten(pWorkunitID);
  #ELSE
    returnresult := WsWorkunits.get_FilesWritten            (pWorkunitID,pesp,pUseGlobal);
  #END

  return returnresult;
  
endmacro;