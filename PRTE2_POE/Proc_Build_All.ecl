IMPORT PRTE2_POE;

EXPORT proc_build_all(string filedate) := FUNCTION
#workunit('name','PRTE POE Build');

	build_base_file	:=	PRTE2_POE.proc_build_base(filedate);

	build_keys :=	PRTE2_POE.proc_build_keys(filedate);

	return_val := 	sequential(PRTE2_POE.fspray, build_base_file, build_keys) ;

	return return_val;

END;