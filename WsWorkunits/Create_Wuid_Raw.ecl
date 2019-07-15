EXPORT Create_Wuid_Raw(

   string                                     pECLText
  ,string                                     pcluster
  ,string                                     pESP               = WsWorkunits._Config.LocalEsp
  ,string                                     pESPPort           = '8010'
  ,dataset(WsWorkunits.Layouts.DebugValues)   pDebugValues       = dataset([],WsWorkunits.Layouts.DebugValues)

) := 
function

  // -- add parent wuid link for all wuids created by another wuid
  eclcode     := 'output(\'<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary">Parent Workunit</a>\' ,named(\'Parent_Wuid__html\'));\n'
                + pECLText
                ;


  lcreate_wuid  :=  WsWorkunits.soapcall_WUUpdate(eclcode                   ,pESP,pESPPort,pDebugValues);
  lsubmit_wuid  :=  WsWorkunits.soapcall_WUSubmit(lcreate_wuid.WUID,pcluster,pESP,pESPPort);
  string  wuid  :=  if(lsubmit_wuid.Code = '' 
                      ,lcreate_wuid.WUID        //no errors
                      ,''                       //errors
                    ) 
                    // : global
                    ;
  return  wuid;

end;