import std;
EXPORT get_FilesWritten(
   string pWorkunitID = ''
  ,string pesp        = WsWorkunits._Config.localEsp
) :=
function

  wuinfo          := WsWorkunits.soapcall_WUInfo(pWorkunitID,pesp);

  ds_normresults  := normalize(wuinfo,left.results    ,transform(recordof(left.results    ),self := right));
  
  ds_filesread    := WsWorkunits.get_FilesRead(pWorkunitID ,pesp);
  
  FilesWritten1   := project(ds_normresults,transform({unsigned rid,layouts.WsFileWritten} ,self.rid := counter,self.name := left.filename,self.graph := '',self.cluster := '',self.kind := 0));
  FilesWritten2   := sort(join(FilesWritten1(name != ''),ds_filesread,left.name = right.name,transform(recordof(left),self.cluster := right.cluster,self := left),left outer),rid); 
  FilesWritten    := project(global(FilesWritten2,few),layouts.WsFileWritten); 
  
  // return FilesWritten;
  return if(pesp in WsWorkunits._Config.LocalEsps  and WsWorkunits.Is_Valid_Wuid(pWorkunitID)   ,STD.System.Workunit.WorkunitFilesWritten(pWorkunitID)
                                                                                                ,FilesWritten
  ); 
end;