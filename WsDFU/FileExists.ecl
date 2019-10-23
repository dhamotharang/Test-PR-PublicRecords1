EXPORT FileExists(
   string   pfilename           = ''
  ,string   pesp                = _Config.LocalEsp
) := 
  regexfind('cannot find file',WsDFU.soapcall_DFUInfo(pfilename,,,,pesp)[1].exception_msg,nocase) = false;