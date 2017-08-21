import wk_ut;
EXPORT GetFileLayout(
   string pfilename
  ,string pesp          = wk_ut._constants.LocalEsp
) :=
WsDFU.soapcall_DFUInfo(pfilename,'',false,'','',pesp)[1].Ecl;
