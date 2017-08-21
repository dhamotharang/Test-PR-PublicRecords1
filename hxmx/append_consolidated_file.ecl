IMPORT hxmx, ut;

EXPORT append_consolidated_file := MODULE

	EXPORT hx (STRING pVersion, BOOLEAN pUseProd):= FUNCTION
		
		EXPORT prev_hx_consol	:= DATASET(hxmx.Filenames(pVersion,pUseProd).hx_consol_lInputHistTemplate,
																	hxmx.Layouts.consolidated.hx_record,
																	CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),
																	__compressed__);

		EXPORT new_hx_consol	:= DATASET(hxmx.Filenames(pVersion,pUseProd).hx_consol_lInputTemplate,
																	hxmx.layouts.consolidated.hx_record,
																	CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),
																	__compressed__);
																
		EXPORT append_hx_consol	:= prev_hx_consol + new_hx_consol;
		
		// ut.MAC_SF_BuildProcess(append_hx_consol,'~thor_data400::in::hxmx_claims::hx_consolidated::history', build_hx,2,,TRUE);
		
		hxmx.MAC_SF_BuildProcess_Mod(append_hx_consol
																		,hxmx.Filenames(pVersion,pUseProd).hx_consol_lInputHistTemplate
																		,build_hx
																		,2
																		,TRUE
																		,TRUE
																		,pVersion
																		,'|'
																			);
																			
		build_and_clear	:= SEQUENTIAL(
							build_hx,
							FileServices.StartSuperFileTransaction(),
							FileServices.ClearSuperFile(hxmx.Filenames(pVersion,pUseProd).hx_lInputHistTemplate),
							FileServices.AddSuperFile(hxmx.Filenames(pVersion,pUseProd).hx_consol_lInputHistDelete,hxmx.Filenames(pVersion,pUseProd).hx_consol_lInputTemplate,addcontents := true),
							FileServices.ClearSuperFile(hxmx.Filenames(pVersion,pUseProd).hx_consol_lInputTemplate),
							FileServices.FinishSuperFileTransaction());

		RETURN build_and_clear;
		
	END;

	EXPORT mx (STRING pVersion, BOOLEAN pUseProd):= FUNCTION
		
		EXPORT prev_mx_consol	:= DATASET(hxmx.Filenames(pVersion,pUseProd).mx_consol_lInputHistTemplate,
																	hxmx.Layouts.consolidated.mx_record,
																	CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),
																	__compressed__);

		EXPORT new_mx_consol	:= DATASET(hxmx.Filenames(pVersion,pUseProd).mx_consol_lInputTemplate,
																	hxmx.layouts.consolidated.mx_record,
																	CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),
																	__compressed__);
																
		EXPORT append_mx_consol	:= prev_mx_consol + new_mx_consol;

		// ut.MAC_SF_BuildProcess(append_mx_consol,'~thor_data400::in::hxmx_claims::mx_consolidated::history', build_mx,2,,TRUE);
		
		hxmx.MAC_SF_BuildProcess_Mod(append_mx_consol
																		,hxmx.Filenames(pVersion,pUseProd).mx_consol_lInputHistTemplate
																		,build_mx
																		,2
																		,TRUE
																		,TRUE
																		,pVersion
																		,'|'
																			);
																			
		build_and_clear	:= SEQUENTIAL(
							build_mx,
							FileServices.StartSuperFileTransaction(),
							FileServices.ClearSuperFile(hxmx.Filenames(pVersion,pUseProd).mx_lInputHistTemplate),
							FileServices.AddSuperFile(hxmx.Filenames(pVersion,pUseProd).mx_consol_lInputHistDelete,hxmx.Filenames(pVersion,pUseProd).mx_consol_lInputTemplate,addcontents := true),
							FileServices.ClearSuperFile(hxmx.Filenames(pVersion,pUseProd).mx_consol_lInputTemplate),
							FileServices.FinishSuperFileTransaction());

		RETURN build_and_clear;
		
	END;

END;