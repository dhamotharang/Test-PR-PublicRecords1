//build NYFDLN main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_NYFDLN_Main,
                       '~thor_data400::base::Liens::Main::NYFDLN',bld_NYFDLN_main, 2);
				   
ut.MAC_SF_BuildProcess(liensV2.Mapping_NYFDLN_Party,
                       '~thor_data400::base::Liens::party::NYFDLN', bld_NYFDLN_party,2);
					   
					 
export proc_build_NYFDLN_base := sequential(bld_NYFDLN_main, bld_NYFDLN_party);
