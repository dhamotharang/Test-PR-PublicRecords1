import std;
EXPORT get_FilesRead(
   string pWorkunitID = ''
  ,string pesp        = _constants.LocalEsp
) :=
  if(pesp in _constants.LocalEsps and wk_ut.Is_Valid_Wuid(pWorkunitID),wk_ut.get_WUInfo(pWorkunitID,pesp).FilesRead//STD.System.Workunit.WorkunitFilesRead(pWorkunitID)//can't trust this to flag superfiles
                                                                      ,wk_ut.get_WUInfo(pWorkunitID,pesp).FilesRead
  );