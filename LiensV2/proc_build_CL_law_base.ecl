import ut;

//build chicage law main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_chicago_law_Main,
                       '~thor_data400::base::Liens::Main::chicago_law',bld_CL_main, 2);

	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_party 	:= LiensV2.Chicago_Law_DID;
	ds_main 	:= liensV2.Mapping_chicago_law_Main;
	ds_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_party, ds_main);										 
				   
ut.MAC_SF_BuildProcess(ds_fix,
                       '~thor_data400::base::Liens::party::chicago_law', bld_CL_party,2);
											 
export proc_build_CL_law_base := sequential(bld_CL_main, bld_CL_party);