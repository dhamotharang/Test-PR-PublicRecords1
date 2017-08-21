IMPORT Emdeon, ut;

EXPORT append_consolidated_file (STRING pVersion, BOOLEAN pUseProd) := FUNCTION
	
	EXPORT prev_consol	:= DATASET(Emdeon.Filenames(pVersion,pUseProd).orig_lInputHistTemplate,
																Emdeon.Layouts.raw.orig_file,
																CSV(terminator(['\r\n','\n']), separator(['|']), quote([''])),
																__compressed__);
	
	EXPORT new_consol		:= DATASET(Emdeon.Filenames(pVersion,pUseProd).orig_lInputTemplate,
																Emdeon.layouts.raw.orig_file,
																CSV(terminator(['\r\n','\n']), separator(['|']), quote([''])),
																__compressed__);
																
	EXPORT append_consol	:= prev_consol + new_consol;
	
	Emdeon.MAC_SF_BuildProcess_Mod(append_consol
																		,Emdeon.Filenames(pVersion,pUseProd).orig_lInputHistTemplate
																		,build_it
																		,2
																		,TRUE
																		,TRUE
																		,pVersion
																		,'|'
																		);
	
	build_and_clear	:= SEQUENTIAL(
						build_it,
						FileServices.StartSuperFileTransaction(),
						FileServices.ClearSuperFile(Filenames(pVersion,pUseProd).orig_lInputTemplate),
						FileServices.FinishSuperFileTransaction();
				);

	RETURN build_and_clear;
	
END;
