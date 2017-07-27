import std;
EXPORT get_FilesWritten(
   string pWorkunitID = ''
  ,string pesp        = _constants.LocalEsp
) :=
  if(pesp in _constants.LocalEsps  and wk_ut.Is_Valid_Wuid(pWorkunitID) ,STD.System.Workunit.WorkunitFilesWritten(pWorkunitID)
                                                                        ,wk_ut.get_WUInfo(pWorkunitID,pesp).FilesWritten
  );