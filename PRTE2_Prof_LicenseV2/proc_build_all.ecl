
#workunit('name','prolicv2 PRTE Build');

IMPORT ut, roxiekeybuild, tools;

EXPORT proc_build_all(string filedate) := FUNCTION

	build_base_file	:=	Prte2_Prof_LicenseV2.proc_build_base(filedate);
						
	build_prolicv2_keys :=	Prte2_Prof_LicenseV2.proc_build_keys(filedate);

	return_val := 	sequential(	build_base_file, build_prolicv2_keys,) ;

	return return_val;

END;