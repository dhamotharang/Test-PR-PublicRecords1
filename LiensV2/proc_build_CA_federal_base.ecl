import ut;

//build CA_federal main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_CA_federal_Main,
                       '~thor_data400::base::Liens::Main::CA_federal',bld_CA_federal_main, 2);

	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_party 	:= liensV2.CA_federal_DID;
	ds_main 	:= liensV2.Mapping_CA_federal_Main;
	ds_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_party, ds_main);
				   
ut.MAC_SF_BuildProcess(ds_fix,
                       '~thor_data400::base::Liens::party::CA_federal', bld_CA_federal_party,2);				   
					 
export proc_build_CA_federal_base := sequential(bld_CA_federal_main, bld_CA_federal_party);
