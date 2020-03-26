EXPORT get_Slim_FilesRead(
   string pWuid
  ,string pFileRegex  = ''
) :=
function
  dfilesread    := sort(global(Workman.get_FilesRead(pWuid),few)(issuper = false,(pFileRegex = '' or regexfind(pFileRegex,name,nocase))),name);
  dslim         := sort(table(dfilesread,{string name := name},name),-(unsigned)regexfind('[[:digit:]]{8}',name,0));
  return dslim;
  
end;
