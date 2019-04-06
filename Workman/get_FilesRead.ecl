import std,WsWorkunits;
EXPORT get_FilesRead(
   string   pWorkunitID = ''
  ,string   pesp        = _Config.LocalEsp
  ,boolean  pUseGlobal  = true
) :=
  map(pesp in _Config.LocalEsps and WorkMan.Is_Valid_Wuid(pWorkunitID) and pUseGlobal = true  => global(nothor(STD.System.Workunit.WorkunitFilesRead(pWorkunitID)),few)
     ,pesp in _Config.LocalEsps and WorkMan.Is_Valid_Wuid(pWorkunitID) and pUseGlobal = false =>               STD.System.Workunit.WorkunitFilesRead(pWorkunitID)
     ,                                                                                                         WsWorkunits.get_FilesRead            (pWorkunitID,pesp,pUseGlobal)
  );
