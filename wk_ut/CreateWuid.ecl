import tools,ut,_control;
EXPORT CreateWuid(

   string  pEcl
  ,string  pcluster
  ,string  pESP               = _constants.LocalEsp
  ,string  pESPPort           = '8010'

) := 
wk_ut.CreateWuid_Raw(pEcl,pcluster,pESP,pESPPort) : independent;
