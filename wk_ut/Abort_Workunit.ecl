EXPORT Abort_Workunit(

  string wuid

) :=
function
  dme := dataset([{wuid}],layouts.WuidItems);
  
  return do_WUAction(dme,'Abort');

end;