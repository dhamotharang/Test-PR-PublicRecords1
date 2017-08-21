import ut;

ut.MAC_SF_BuildProcess(LiensV2.Mapping_Superior_Liens_main,
                       '~thor_data400::base::Liens::Main::superior',bld_superior_main, 2);
											 
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_party 	:= LiensV2.Superior_DID;
	ds_main 	:= LiensV2.Mapping_Superior_Liens_main;
	ds_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_party, ds_main);
				   
ut.MAC_SF_BuildProcess(ds_fix,
                       '~thor_data400::base::Liens::party::superior', bld_superior_party,2);					   
					 
export proc_build_Superior_base := sequential(bld_superior_main, bld_superior_party);
