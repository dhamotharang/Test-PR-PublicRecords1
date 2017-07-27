//build NYC main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_NYC_Main,
                       '~thor_data400::base::Liens::Main::NYC',bld_NYC_main, 2);
				   
ut.MAC_SF_BuildProcess(liensV2.Mapping_NYC_Party,
                       '~thor_data400::base::Liens::party::NYC', bld_NYC_party,2);
					   
					 
export proc_build_NYC_base := sequential(bld_NYC_main, bld_NYC_party);
