EXPORT get_Sandboxed_Attributes(
   string pWorkunitID = ''
  ,string pesp        = _Config.localEsp
) :=
function

  results           := WsWorkunits.soapcall_WUInfo(pWorkunitID  ,pesp);
  dnormECLException := normalize(results,left.Exceptions ,transform(recordof(left.Exceptions ),self := right));
  sort_sandboxes    := sort(dnormECLException(regexfind('(Definition is sandboxed|Definition is modified)',message,nocase)),FileName);

  return sort_sandboxes;
  
end;
