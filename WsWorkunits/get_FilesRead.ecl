EXPORT get_FilesRead(
   string   pWorkunitID = ''
  ,string   pesp        = WsWorkunits._Config.localEsp
  ,boolean  pUseGlobal  = true
  ,boolean  pDebug      = false
) :=
function

  wuinfo := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);

  dnormSourceFiles  := normalize(wuinfo,left.SourceFiles,transform(recordof(left.SourceFiles),self := right));

  WsFileRead := record  string name{maxlength(256)}; string cluster{maxlength(64)}; boolean isSuper; unsigned4 usage; end;
  FilesRead1 := normalize(dnormSourceFiles,count(left.Subfiles) + 1  ,transform(WsFileRead//STD.System.Workunit.WsFileRead
    ,self.name    := if(counter = 1 ,left.name          ,left.Subfiles[counter - 1].Name  )
    ,self.cluster := left.FileCluster
    ,self.isSuper := if(counter = 1 ,left.IsSuperFile   ,false                            )
    ,self.usage   := left.Count 
  ));
  FilesRead  := if(pUseGlobal = true
                  ,project(global(FilesRead1,few),WsFileRead)
                  ,project(FilesRead1,WsFileRead)
                );

  output_debug := parallel(
     output(wuinfo            ,named('wuinfo'           ),all)
    ,output(dnormSourceFiles  ,named('dnormSourceFiles' ),all)
    ,output(FilesRead1        ,named('FilesRead1'       ),all)
    ,output(FilesRead         ,named('FilesRead'        ),all)
  
  );

  return when(FilesRead ,if(pDebug = true ,output_debug));
  
end;