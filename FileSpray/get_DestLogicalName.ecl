EXPORT get_DestLogicalName(
   string  pWorkunitID   
  ,string  pESp         = _Config.LocalEsp
) :=
function


  ds_dfuwuid := FileSpray.soapcall_GetDFUWorkunit(pWorkunitID,pESp);
  
  DestLogicalName := ds_dfuwuid[1].DestLogicalName;
  
  return DestLogicalName;

end;