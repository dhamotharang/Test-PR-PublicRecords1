EXPORT get_StringFilesRead(

   string   pWuid       = workunit
  ,string   pFileRegex  = ''
  ,unsigned pIndex      = 0         // 0 = the last record in the Workunits Result Dataset.  Otherwise, it takes the index you pass in

) := 
function

  getwuids    := global(iff((unsigned)wk_ut.get_DS_Count(pWuid,'Workunits') > 0 ,wk_ut.get_DS_Result(pWuid,'Workunits',wk_ut.layouts.wks_slim)  ,dataset([{'','',pWuid,'','','','','','','',0}],wk_ut.layouts.wks_slim)));
  countwuids  := count(getwuids);
  recindex    := if(pIndex  = 0 ,countwuids ,pIndex);
  wuid        := getwuids[recindex].wuid;
  
  filesAsString := wk_ut.Rollup_FilesRead(wuid,pFileRegex);
  
  return filesAsString[1].name;

end;