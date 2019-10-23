EXPORT RemoveSuperfile(
   string                psuperfile           = ''    //superfile to modify     
  ,string                psubfile             = ''    //subfile to add or delete           
  ,string                pesp                 = _Config.LocalEsp
) :=
  WsDFU.soapcall_SuperfileAction('remove'  ,psuperfile,psubfile,'',,,pesp);
