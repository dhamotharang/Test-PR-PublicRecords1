﻿EXPORT proc_build_all(string filedate) := FUNCTION

  spray_files     :=fspray;	
	
	build_base_file	:=	proc_build_base;
	
	build_keys :=	proc_build_keys(filedate);

	return_val := 	sequential(spray_files,build_base_file, build_keys,) ;
	
	return return_val;

END;