import std,WsWorkunits;
EXPORT get_FilesWritten(
   string   pWorkunitID = ''
  ,string   pesp        = _Config.LocalEsp
  ,boolean  pUseGlobal  = true
) :=
  map(pesp in _Config.LocalEsps  and WorkMan.Is_Valid_Wuid(pWorkunitID) and pUseGlobal = true  => global(nothor(STD.System.Workunit.WorkunitFilesWritten (pWorkunitID        )),few)
     ,pesp in _Config.LocalEsps  and WorkMan.Is_Valid_Wuid(pWorkunitID) and pUseGlobal = false =>               STD.System.Workunit.WorkunitFilesWritten (pWorkunitID        )
     ,                                                                                                          WsWorkunits.get_FilesWritten             (pWorkunitID  ,pesp ,pUseGlobal) //done use global in rewind, but use it other places
  );