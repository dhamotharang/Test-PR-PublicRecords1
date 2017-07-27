//build ILFDLN main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_ILFDLN_Main,
                       '~thor_data400::base::Liens::Main::ILFDLN',bld_ILFDLN_main, 2);
				   
ut.MAC_SF_BuildProcess(liensV2.Mapping_ILFDLN_Party,
                       '~thor_data400::base::Liens::party::ILFDLN', bld_ILFDLN_party,2);
					   
					 
export proc_build_ILFDLN_base := sequential(bld_ILFDLN_main, bld_ILFDLN_party);
