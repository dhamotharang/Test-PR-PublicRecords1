import std,WsWorkunits;
EXPORT get_State(string wuid,string pesp = _Config.LocalEsp) := 
map(  // -- local wuid
      pesp in WorkMan._Config.LocalEsps 
  and WorkMan.Is_Valid_Wuid(wuid) 
  and trim(wuid) not in ['','[undefined]'] 
  and trim(STD.System.Workunit.WorkunitList (wuid,wuid)[1].state) != '' 
  and trim(STD.System.Workunit.WorkunitList (wuid,wuid)[1].state) = trim(WsWorkunits.Get_State(wuid,pesp))  => STD.System.Workunit.WorkunitList (wuid,wuid)[1].state
      // -- remote wuid
 ,    pesp not in WorkMan._Config.LocalEsps                                                                     
  and WorkMan.Is_Valid_Wuid(wuid) 
  and trim(wuid) not in ['','[undefined]']                                                                  => WsWorkunits.Get_State            (wuid,pesp)
      // -- bad wuid
  ,''
);