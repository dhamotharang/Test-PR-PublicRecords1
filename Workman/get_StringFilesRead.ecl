EXPORT get_StringFilesRead(

   string   pWuid       = workunit
  ,string   pFileRegex  = ''
  ,unsigned pIndex      = 0         // 0 = the last record in the Workunits Result Dataset.  Otherwise, it takes the index you pass in

) := 
function

  getwuids    := global(iff((unsigned)WorkMan.get_DS_Count(pWuid,'Workunits') > 0 ,WorkMan.get_DS_Result(pWuid,'Workunits',WorkMan.layouts.wks_slim)  ,dataset([{'',pWuid,'','','','','','',0}],WorkMan.layouts.wks_slim)));
  countwuids  := count(getwuids);
  recindex    := if(pIndex  = 0 ,countwuids ,pIndex);
  wuid        := getwuids[recindex].wuid;
  
  filesAsString := WorkMan.Rollup_FilesRead(wuid,pFileRegex);
  
  return filesAsString[1].name;

end;