IMPORT PRTE2_MFind;

EXPORT proc_build_all(string filedate) := FUNCTION

	build_base_file	:=	PRTE2_MFind.proc_build_base(filedate);

	build_keys :=	PRTE2_MFind.proc_build_keys(filedate);

	return_val := 	sequential(	build_base_file, build_keys) ;

	return return_val;

END;