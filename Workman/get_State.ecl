import std,WsWorkunits;
EXPORT get_State(string wuid,string pesp = _Config.LocalEsp) := 
if(pesp in WorkMan._Config.LocalEsps and WorkMan.Is_Valid_Wuid(wuid) and trim(wuid) not in ['','[undefined]'] and trim(STD.System.Workunit.WorkunitList (wuid,wuid)[1].state) != ''
  ,STD.System.Workunit.WorkunitList (wuid,wuid)[1].state
  ,WsWorkunits.Get_State            (wuid,pesp)
);