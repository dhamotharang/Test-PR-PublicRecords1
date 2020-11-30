

import prte2_doc,prte2,ut,std, PromoteSupers;

filename:= constants.lookup_file;

base_file := index({ 
	string150 offensecharge
  
  }, layouts.key_layout, constants.lookup_file);

PromoteSupers.Mac_SF_BuildProcess(base_file,Constants.base_name,base_out,,,true);

EXPORT proc_build_base :=   base_out;	



	