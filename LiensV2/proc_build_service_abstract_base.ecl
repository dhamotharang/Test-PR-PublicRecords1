//build service_abstract main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_service_abstract_Main,
                       '~thor_data400::base::Liens::Main::SA',bld_service_abstract_main, 2);
				   
ut.MAC_SF_BuildProcess(liensV2.Mapping_service_abstract_Party,
                       '~thor_data400::base::Liens::party::SA', bld_service_abstract_party,2);
					   
					 
export proc_build_service_abstract_base := sequential(bld_service_abstract_main, bld_service_abstract_party);
