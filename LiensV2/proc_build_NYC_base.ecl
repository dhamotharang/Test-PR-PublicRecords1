import ut;

//build NYC main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_NYC_Main,
                       '~thor_data400::base::Liens::Main::NYC',bld_NYC_main, 2);

	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_party 	:= liensV2.NYC_DID;
	ds_main 	:= liensV2.Mapping_NYC_Main;
	ds_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_party, ds_main);
				   
ut.MAC_SF_BuildProcess(ds_fix,
                       '~thor_data400::base::Liens::party::NYC', bld_NYC_party,2);
					   
export proc_build_NYC_base := sequential(bld_NYC_main, bld_NYC_party);
