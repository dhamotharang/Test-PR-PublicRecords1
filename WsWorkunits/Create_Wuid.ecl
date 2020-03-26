EXPORT Create_Wuid(

   string  pEcl
  ,string  pcluster
  ,string  pESP               = WsWorkunits._Config.LocalEsp
  ,string  pESPPort           = '8010'
  ,dataset(WsWorkunits.Layouts.DebugValues)   pDebugValues       = dataset([],WsWorkunits.Layouts.DebugValues)

) := 
WsWorkunits.Create_Wuid_Raw(pEcl,pcluster,pESP,pESPPort,pDebugValues) : independent;
