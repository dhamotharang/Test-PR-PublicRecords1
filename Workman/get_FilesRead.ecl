import std,WsWorkunits;
EXPORT get_FilesRead(
   string pWorkunitID = ''
  ,string pesp        = _Config.LocalEsp
) :=
  if(pesp in _Config.LocalEsps and WorkMan.Is_Valid_Wuid(pWorkunitID),WsWorkunits.get_FilesRead(pWorkunitID,pesp) //STD.System.Workunit.WorkunitFilesRead(pWorkunitID)//can't trust this to flag superfiles
                                                                        ,WsWorkunits.get_FilesRead(pWorkunitID,pesp)
  );
