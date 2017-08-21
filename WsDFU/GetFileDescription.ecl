import wk_ut;
EXPORT GetFileDescription(
   string pfilename
  ,string pesp          = wk_ut._constants.LocalEsp
) :=
WsDFU.soapcall_DFUInfo(pfilename,'',false,'','',pesp)[1].Description;
