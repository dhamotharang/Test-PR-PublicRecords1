import ut;

//build service_abstract main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_service_abstract_Main,
                       '~thor_data400::base::Liens::Main::SA',bld_service_abstract_main, 2);

	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_party 	:= liensV2.Service_Abstract_DID;
	ds_main 	:= liensV2.Mapping_service_abstract_Main;
	ds_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_party, ds_main);
				   
ut.MAC_SF_BuildProcess(ds_fix,
                       '~thor_data400::base::Liens::party::SA', bld_service_abstract_party,2);
					   
export proc_build_service_abstract_base := sequential(bld_service_abstract_main, bld_service_abstract_party);
