import std,WsWorkunits;
EXPORT get_FilesRead(
   string   pWorkunitID = ''
  ,string   pesp        = _Config.LocalEsp
  ,boolean  pUseGlobal  = true
) :=
  if(pesp in _Config.LocalEsps and WorkMan.Is_Valid_Wuid(pWorkunitID)   ,global(STD.System.Workunit.WorkunitFilesRead(pWorkunitID),few)//can't trust this to flag superfiles
                                                                        ,WsWorkunits.get_FilesRead            (pWorkunitID,pesp,pUseGlobal)
  );
