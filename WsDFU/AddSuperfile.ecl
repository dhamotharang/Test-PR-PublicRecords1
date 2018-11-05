EXPORT AddSuperfile(
   string                psuperfile           = ''    //superfile to modify     
  ,string                psubfile             = ''    //subfile to add or delete           
  ,string                pesp                 = _Config.LocalEsp
  ,string                pbefore              = ''    //add the subfile before this file in the superfile
) :=
  WsDFU.soapcall_SuperfileAction('add'  ,psuperfile,psubfile,pbefore,,,pesp);
