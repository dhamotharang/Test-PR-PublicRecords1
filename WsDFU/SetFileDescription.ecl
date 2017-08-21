import wk_ut;
EXPORT SetFileDescription(
   string pfilename
  ,string pdescription
  ,string pesp          = wk_ut._constants.LocalEsp
) :=
WsDFU.soapcall_DFUInfo(pfilename,'',true,'',pdescription,pesp);
