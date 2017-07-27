import ut;

//build CA_federal main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_CA_federal_Main,
                       '~thor_data400::base::Liens::Main::CA_federal',bld_CA_federal_main, 2);
				   
ut.MAC_SF_BuildProcess(liensV2.Mapping_CA_federal_Party,
                       '~thor_data400::base::Liens::party::CA_federal', bld_CA_federal_party,2);
					   
					 
export proc_build_CA_federal_base := sequential(bld_CA_federal_main, bld_CA_federal_party);
