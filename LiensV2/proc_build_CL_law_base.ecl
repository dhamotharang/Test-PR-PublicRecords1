import ut;

//build chicage law main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_chicago_law_Main,
                       '~thor_data400::base::Liens::Main::chicago_law',bld_CL_main, 2);
				   
ut.MAC_SF_BuildProcess(liensV2.Mapping_chicago_law_Party,
                       '~thor_data400::base::Liens::party::chicago_law', bld_CL_party,2);
export proc_build_CL_law_base := sequential(bld_CL_main, bld_CL_party);