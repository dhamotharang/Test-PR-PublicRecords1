//build Hogan main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_Hogan_Main,
                       '~thor_data400::base::Liens::Main::Hogan',bld_hogan_main, 2);
				  
ut.MAC_SF_BuildProcess(liensV2.Mapping_Hogan_Party,
                       '~thor_data400::base::Liens::party::Hogan', bld_hogan_party, 2);

export proc_build_Hogan_base := sequential(bld_hogan_main,bld_hogan_party);