import avm, ln_property;

/*Bug 23122*/

export Proc_Build_File_and_Keys := function

 do_all := sequential(avm.File_AVM,avm.buildKey(ln_property.version_build));
 
return do_all;

end;