import ut;

//build NYFDLN main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_NYFDLN_Main,
                       '~thor_data400::base::Liens::Main::NYFDLN',bld_NYFDLN_main, 2);
											 
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_party 	:= liensV2.NYfederal_DID;
	ds_main 	:= liensV2.Mapping_NYFDLN_Main;
	ds_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_party, ds_main);
				   
ut.MAC_SF_BuildProcess(ds_fix,
                       '~thor_data400::base::Liens::party::NYFDLN', bld_NYFDLN_party,2);				   
					 
export proc_build_NYFDLN_base := sequential(bld_NYFDLN_main, bld_NYFDLN_party);
