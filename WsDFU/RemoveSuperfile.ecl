import wk_ut;
EXPORT RemoveSuperfile(
   string                psuperfile           = ''    //superfile to modify     
  ,string                psubfile             = ''    //subfile to add or delete           
  ,string                pesp                 = wk_ut._constants.LocalEsp
) :=
  WsDFU.soapcall_SuperfileAction('remove'  ,psuperfile,psubfile,'',,,pesp);
