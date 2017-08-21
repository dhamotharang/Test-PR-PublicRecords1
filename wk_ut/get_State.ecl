import std;
EXPORT get_State(string wuid,string pesp = _constants.LocalEsp) := 
if(pesp in wk_ut._Constants.LocalEsps
  ,STD.System.Workunit.WorkunitList (wuid,wuid)[1].state
  ,wk_ut.get_WUInfo(wuid,pesp).State
);