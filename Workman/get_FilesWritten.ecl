import std,WsWorkunits;
EXPORT get_FilesWritten(
   string pWorkunitID = ''
  ,string pesp        = _Config.LocalEsp
) :=
  if(pesp in _Config.LocalEsps  and WorkMan.Is_Valid_Wuid(pWorkunitID) ,STD.System.Workunit.WorkunitFilesWritten (pWorkunitID        )
                                                                       ,WsWorkunits.get_FilesWritten             (pWorkunitID  ,pesp )
  );