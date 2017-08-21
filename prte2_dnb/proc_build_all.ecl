IMPORT prte2_dnb;

EXPORT proc_build_all(string filedate) := FUNCTION

	build_base_file	:=	prte2_dnb.proc_build_base(filedate);

	build_dnb_keys :=	prte2_dnb.proc_build_keys(filedate);

	return_val := 	sequential(	build_base_file, build_dnb_keys,) ;

	return return_val;

END;