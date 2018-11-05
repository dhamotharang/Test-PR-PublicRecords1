EXPORT Rollup_FilesRead(

   string pWuid
  ,string pFileRegex  = ''

) :=
function

  dfilesread    := sort(global(nothor(WorkMan.get_FilesRead(pWuid)),few)(issuper = false,(pFileRegex = '' or regexfind(pFileRegex,name,nocase))),name);
  dslim         := sort(table(dfilesread,{string name := name},name),-(unsigned)regexfind('[[:digit:]]{8}',name,0));
  drollupemail  := rollup(dslim,true,transform(recordof(left),self.name := left.name + '\n' + right.name));

  return drollupemail;
  
end;