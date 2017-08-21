#workunit('name','DEA PRTE Build');

IMPORT ut, roxiekeybuild, tools,PRTE2_DEA;

EXPORT proc_build_all(string filedate) := FUNCTION

	build_base_file	:=	prte2_dea.proc_build_base(filedate);
						
	build_dea_keys :=	prte2_dea.proc_build_key(filedate);

	return_val := 	sequential(	build_base_file, build_dea_keys,) ;

	return return_val;

END;
