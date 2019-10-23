import WsWorkunits;
EXPORT CreateWuid(

   string                                     pEcl
  ,string                                     pcluster
  ,string                                     pESP               = _Config.LocalEsp
  ,string                                     pESPPort           = '8010'
  ,dataset(WsWorkunits.Layouts.DebugValues)   pDebugValues       = dataset([],WsWorkunits.Layouts.DebugValues)

) := 
WorkMan.CreateWuid_Raw(pEcl,pcluster,pESP,pESPPort,pDebugValues) : independent;
