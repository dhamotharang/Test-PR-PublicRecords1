import ut;
// Get the prod header version from production environment
boolean_value := ut.IsNewProdHeaderVersion('bk_search') : stored('boolean_value');
bboolean_value := ut.IsNewProdHeaderVersion('bk_search','bheader_file_version') : stored('bboolean_value');

ut.MAC_SF_BuildProcess(BankruptcyV2.proc_build_base_main_supp(BankruptcyV2.Mapping_BK_Main(boolean_value)),
                       '~thor_data400::base::Bankruptcy::Main_v3',bld_bk_main, 2,,true);
				   
ut.MAC_SF_BuildProcess(BankruptcyV2.BK_DidAndBdid(boolean_value),
                       '~thor_data400::base::Bankruptcy::search_v3', bld_bk_search,2,,true);
					   
ut.MAC_SF_BuildProcess(BankruptcyV2.Map_BK_V3_V2_Main,
                       '~thor_data400::base::Bankruptcy::Main',bld_bk_main_v2, 2,,true);
				   
ut.MAC_SF_BuildProcess(BankruptcyV2.Map_BK_V3_V2_Search,
                       '~thor_data400::base::Bankruptcy::search', bld_bk_search_v2,2,,true);					   
					   					 
export proc_build_base := sequential(
										bld_bk_main, 
										bld_bk_search,
										bld_bk_main_v2,					
										bld_bk_search_v2,
										// If new prod header version, update the flag file.
						
										if ( (boolean_value or bboolean_value)and 
												(ut.Weekday((integer)ut.GetDate) = 'SATURDAY' or ut.Weekday((integer)ut.GetDate) = 'SUNDAY')
													,sequential(
																	ut.PostDID_HeaderVer_Update('bk_search'),
																	ut.PostDID_HeaderVer_Update('bk_search','bheader_file_version'),
																	output('Full re-did was successful')
																),
													output('No Full re-did')
											),
										notify('BANKRUPTCY BASE BUILD COMPLETE','*')
										);


