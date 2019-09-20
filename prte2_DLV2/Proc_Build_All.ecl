IMPORT prte2_DLV2;

EXPORT proc_build_all(string filedate) := FUNCTION

  spray_file :=prte2_DLV2.fspray;

	build_base_files	:=	prte2_DLV2.proc_build_base(filedate);

	build_keys :=	prte2_DLV2.proc_build_keys(filedate);

	return_val := 	sequential(spray_file, build_base_files, build_keys,) ;

	return return_val;

END;