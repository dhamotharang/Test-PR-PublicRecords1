EXPORT Rollup_FilesRead(

   string pWuid
  ,string pFileRegex  = ''

) :=
function

  dfilesread    := sort(global(nothor(wk_ut.get_FilesRead(pWuid)),few)(issuper = false,(pFileRegex = '' or regexfind(pFileRegex,name,nocase))),name);
  dslim         := table(dfilesread,{string name := name},name);
  drollupemail  := rollup(dslim,true,transform(recordof(left),self.name := left.name + '\n' + right.name));

  return drollupemail;
  
end;