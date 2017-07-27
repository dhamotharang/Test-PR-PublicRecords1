import ut, liensV2;

//build Hogan main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_Hogan_Main,
                       '~thor_data400::base::Liens::Main::Hogan',bld_hogan_main, 2);
				  
ut.MAC_SF_BuildProcess(liensV2.Mapping_Hogan_Party,
                       '~thor_data400::base::Liens::party::Hogan', bld_hogan_party, 2);

//build ILFDLN main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_ILFDLN_Main,
                       '~thor_data400::base::Liens::Main::ILFDLN',bld_ILFDLN_main, 2);
				   
ut.MAC_SF_BuildProcess(liensV2.Mapping_ILFDLN_Party,
                       '~thor_data400::base::Liens::party::ILFDLN', bld_ILFDLN_party,2);

//build NYC main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_NYC_Main,
                       '~thor_data400::base::Liens::Main::NYC',bld_NYC_main, 2);
				  
ut.MAC_SF_BuildProcess(liensV2.Mapping_NYC_Party,
                       '~thor_data400::base::Liens::party::NYC', bld_NYC_party, 2);

//build NYFDLN main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_NYFDLN_Main,
                       '~thor_data400::base::Liens::Main::NYFDLN',bld_NYFDLN_main, 2);
				   
ut.MAC_SF_BuildProcess(liensV2.Mapping_NYFDLN_Party,
                       '~thor_data400::base::Liens::party::NYFDLN', bld_NYFDLN_party,2);

//build service abstract main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_Service_ABSTRACT_Main,
                       '~thor_data400::base::Liens::Main::SA',bld_SA_main, 2);
				  
ut.MAC_SF_BuildProcess(liensV2.Mapping_Service_abstract_Party,
                       '~thor_data400::base::Liens::party::SA', bld_SA_party, 2);

//build chicage law main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_chicago_law_Main,
                       '~thor_data400::base::Liens::Main::chicago_law',bld_CA_main, 2);
				   
ut.MAC_SF_BuildProcess(liensV2.Mapping_chicago_law_Party,
                       '~thor_data400::base::Liens::party::chicago_law', bld_CA_party,2);


export proc_build_liens_base := parallel(bld_hogan_main,bld_hogan_party,bld_ILFDLN_main,bld_ILFDLN_party,
                                          bld_NYC_main,bld_NYC_party,bld_NYFDLN_main,bld_NYFDLN_party,
										  bld_SA_main,bld_SA_party,bld_CA_main,bld_CA_party) ;