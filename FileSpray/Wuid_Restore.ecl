EXPORT Wuid_Restore(

   string wuid
  ,string pesp                     = _Config.LocalEsp

) :=
function
  dme := dataset([{wuid}],layouts.WuidItems);
  lesp := pesp;
  return FileSpray.soapcall_DFUWorkunitsAction(dme,'Restore',pesp := lesp);

end;