import std,WsWorkunits;

EXPORT get_FilesRead(
   pWorkunitID = '\'\''
  ,pesp        = '_Config.LocalEsp'
  ,pUseGlobal  = 'true'
) :=
functionmacro

  import std;
  
  #IF(pUseGlobal = true and pesp in _Config.LocalEsps)
    returnresult := global(nothor(STD.System.Workunit.WorkunitFilesRead(pWorkunitID)),few);
  #ELSIF(pUseGlobal = false and pesp in _Config.LocalEsps)
    returnresult := STD.System.Workunit.WorkunitFilesRead(pWorkunitID);
  #ELSE
    returnresult := WsWorkunits.get_FilesRead            (pWorkunitID,pesp,pUseGlobal);
  #END

  return returnresult;
  
endmacro;