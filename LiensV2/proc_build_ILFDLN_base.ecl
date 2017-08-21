import ut;

//build ILFDLN main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_ILFDLN_Main,
                       '~thor_data400::base::Liens::Main::ILFDLN',bld_ILFDLN_main, 2);
											 
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_party 	:= liensV2.ILfederal_DID;
	ds_main 	:= liensV2.Mapping_ILFDLN_Main;
	ds_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_party, ds_main);
				   
ut.MAC_SF_BuildProcess(ds_fix,
                       '~thor_data400::base::Liens::party::ILFDLN', bld_ILFDLN_party,2);
					 
export proc_build_ILFDLN_base := sequential(bld_ILFDLN_main, bld_ILFDLN_party);
