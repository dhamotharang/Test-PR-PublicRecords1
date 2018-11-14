EXPORT SetFileDescription(
   string pfilename
  ,string pdescription
  ,string pesp          = _Config.LocalEsp
) :=
WsDFU.soapcall_DFUInfo(pfilename,'',true,pdescription,pesp);
