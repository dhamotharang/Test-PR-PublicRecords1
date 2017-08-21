import wk_ut;
EXPORT DeleteLogicalFile(
   string     pFile                                             //file to delete.  doesn't need ~          
  ,boolean    premoveFromSuperfiles = false                     //remove it from superfiles first?
  ,boolean    premoveRecursively    = false                     //i think this is recursively from superfiles
  ,string     pesp                  = wk_ut._constants.LocalEsp
) :=                    
  WsDFU.soapcall_DFUArrayAction('Delete',pFile,premoveFromSuperfiles,premoveRecursively,pesp);