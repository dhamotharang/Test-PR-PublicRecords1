import std;
EXPORT get_FilesRead(
   string pWorkunitID = ''
  ,string pesp        = _constants.LocalEsp
) :=
  if(pesp in _constants.LocalEsps and wk_ut_dev.Is_Valid_Wuid(pWorkunitID),STD.System.Workunit.WorkunitFilesRead(pWorkunitID)
                                                                      ,wk_ut_dev.get_WUInfo(pWorkunitID,pesp).FilesRead
  );