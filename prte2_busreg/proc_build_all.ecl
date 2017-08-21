IMPORT prte2_busreg;

EXPORT proc_build_all(string filedate) := FUNCTION

	build_base_file	:=	prte2_busreg.proc_build_base(filedate);

	build_dea_keys :=	prte2_busreg.proc_build_keys (filedate);
	
  return sequential(	build_base_file, build_dea_keys,) ;

END;