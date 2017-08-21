 IMPORT prte2_VotersV2;

 EXPORT proc_build_all(string filedate) := FUNCTION

	build_base_file	:=	prte2_VotersV2.proc_build_base(filedate);

	build_keys :=	prte2_VotersV2.proc_build_keys(filedate);

  return sequential(build_base_file, build_keys) ;

	END;

