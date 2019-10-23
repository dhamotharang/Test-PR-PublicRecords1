import WsWorkunits;
EXPORT get_Errors(string wuid,string pesp = _Config.LocalEsp) := 
  if(WorkMan.Is_Valid_Wuid(wuid) and trim(wuid) not in ['','[undefined]'] 
    ,WsWorkunits.get_Errors(wuid,pesp)
    ,''
  );