IMPORT $;

EXPORT proc_build_all(string filedate) := FUNCTION
  
	build_base_file	:=	PRTE2_ECrash.proc_build_base;

	build_keys :=	PRTE2_ECrash.proc_build_keys(filedate);

	return_val := 	sequential(	PRTE2_ECrash.fspray, build_base_file, build_keys) ;

	return return_val;

END;