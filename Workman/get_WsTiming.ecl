import WsWorkunits;

EXPORT get_WsTiming(

   string   pWuid
  ,string   pesp           = _Config.localEsp
  
) :=
function

  get_timers := WsWorkunits.get_Timers(pWuid,pesp);
  
  ds_Wstiming := project(get_timers  ,transform(Layouts.WsTiming 
    ,self.count    := (unsigned4)left.count
    ,self.duration := 0//map(regexfind('ms'  ,left.Value ,nocase)  => 
    ,self.max      := 0
    ,self.name     := left.name
  )); 

  return ds_Wstiming;

end;