EXPORT get_Errors(
   string pWorkunitID = ''
  ,string pesp        = WsWorkunits._Config.localEsp
) :=
function

  wuinfo := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);

  dnormECLException := normalize(wuinfo,left.Exceptions ,transform(recordof(left.Exceptions ),self := right));  //
  dexcepfilt        := dnormECLException(severity = 'Error');

  dexcepttransform := project(dexcepfilt  ,transform({string line},self.line := 
      left.source + ': '
    + trim(left.fileName)  + ' ('
    + left.LineNo + ',' + left.Column + ') : '
    + left.Code + ': '
    + left.Message
    + '\n'
  ));
  
  dexceptrollup := rollup(dexcepttransform,true,transform(recordof(left),self.line := left.line + right.line));

  return dexceptrollup[1].line;

end;