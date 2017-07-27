EXPORT Restore_Workunit(

   string wuid
  ,string pesp                     = _constants.LocalEsp

) :=
function
  dme := dataset([{wuid}],layouts.WuidItems);
  lesp := pesp;
  return do_WUAction(dme,'Restore',pesp := lesp);

end;