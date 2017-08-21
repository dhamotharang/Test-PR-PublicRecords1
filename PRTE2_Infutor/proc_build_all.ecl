IMPORT PRTE2_Infutor;

EXPORT proc_build_all(string filedate) := FUNCTION

	build_base :=	PRTE2_Infutor.proc_build_base(filedate);
	build_keys :=	PRTE2_Infutor.proc_build_keys(filedate);

	return_val := 	sequential(	 build_base, build_keys) ;

	return return_val;

END;