import emdeon, ut;

EXPORT append_consolidated_file (string pversion, boolean pUseProd) := FUNCTION
	
	export prev_consol	:= dataset('~thor_data400::in::emdeon_claims::orig_consolidated::history',
																emdeon.Layouts.raw.orig_file,
																csv(terminator(['\r\n', '\n']), separator(['|']), quote([''])),
																__compressed__);
	
	export new_consol		:= dataset('~thor_data400::in::emdeon_claims::orig_consolidated',
																emdeon.layouts.raw.orig_file,
																csv(terminator(['\r\n', '\n']), separator(['|']), quote([''])),
																__compressed__);
																
	export append_consol	:= prev_consol + new_consol;
	
	ut.MAC_SF_BuildProcess(append_consol,'~thor_data400::in::emdeon_claims::orig_consolidated::history', build_it,2,,true);
	
	build_and_clear	:= sequential(
						build_it,
						FileServices.StartSuperFileTransaction(),
						FileServices.ClearSuperFile(emdeon.Filenames(pversion,pUseProd).orig_lInputTemplate),
						FileServices.FinishSuperFileTransaction());

	RETURN build_and_clear;
END;
