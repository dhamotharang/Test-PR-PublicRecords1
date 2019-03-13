EXPORT GetOwner(
   string pfilename
  ,string pesp          = _Config.LocalEsp
) :=
WsDFU.soapcall_DFUInfo(pfilename,'',false,'',pesp)[1].Owner;
