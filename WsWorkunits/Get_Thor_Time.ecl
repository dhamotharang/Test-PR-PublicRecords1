﻿EXPORT Get_Thor_Time(
   string pWorkunitID = ''
  ,string pesp        = WsWorkunits._Config.localEsp
) :=
function

 wuinfo := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);

 return wuinfo[1].TotalThorTime;

end;