import
	 acf
	,amidir
	,bbb2
	,corp2
	,dca
	,ebr
	,fcc  
	,govdata
	,lib_fileservices
	,liquor_licenses
	,ln_property
	,lobbyists
	,martindale_hubbell
	,sda_sdaa
	,uccv2
	,vehLic
	,watercraft
	,yellowPages
	,zoom
	;
////////////////////////////////////////////////////////////////////////////////////
// -- Record Layouts used in process
////////////////////////////////////////////////////////////////////////////////////
inforecord := lib_fileservices.FsLogicalFileInfoRecord;
namerecord := lib_fileservices.FsLogicalFileNameRecord;

////////////////////////////////////////////////////////////////////////////////////
// -- Get list of filenames of the sub files contained in the superfiles
// -- used in the business header build
////////////////////////////////////////////////////////////////////////////////////
Update_super_files_list := DATASET([
    (acf.Cluster.cluster_in+'Base::ACF'      								)
   ,('~thor_Data400::base::fl_fbn_base'         						)
   ,('~thor_data400::base::DDCA_All'                  			)
   ,('~thor_data400::base::atf_firearms_explosives'      		)
   ,('~thor_data400::base::bankruptcy::main'           			)     
   ,('~thor_data400::base::bankruptcy::search'         			)
   ,('~thor_data400::base::bh_super_group'               		)
   ,('~thor_data400::base::business_contacts'            		)
   ,('~thor_data400::base::business_header'           			)
   ,('~thor_data400::base::business_relatives'           		)
   ,('~thor_data400::base::business_relatives_group'     		)
   ,('~thor_data400::base::busreg_company'               		)
   ,('~thor_data400::base::busreg_contact'               		)
   ,('~thor_data400::base::ca_sales_tax_bdid'            		)
   ,('~thor_data400::base::credit_unions'             			)
   ,('~thor_data400::base::dea'                    					)
   ,('~thor_data400::base::dnb_companies'             			)
   ,('~thor_data400::base::dnb_contacts'              			)
   ,('~thor_data400::base::dnb_fein'                  			)
   ,('~thor_data400::base::edgar_company'             			)
   ,('~thor_data400::base::edgar_contacts'               		)
   ,('~thor_data400::base::faa_aircraft_reg_built'       		)
   ,('~thor_data400::base::gong'                   					)
   ,('~thor_data400::base::gong_history'              			)
   ,('~thor_data400::base::gov_phones'                			)
   ,('~thor_data400::base::govdata_fdic_bdid'            		)
   ,('~thor_data400::base::irs5500'                					)
   ,('~thor_data400::base::irs_nonprofit'             			)
   ,('~thor_data400::base::liens'                     			)
   ,('~thor_data400::base::liens::party::CA_federal'     		)
   ,('~thor_data400::base::liens::party::Hogan'       			)
   ,('~thor_data400::base::liens::party::ILFDLN'         		)
   ,('~thor_data400::base::liens::party::NYC'            		)
   ,('~thor_data400::base::liens::party::NYFDLN'         		)
   ,('~thor_data400::base::liens::party::SA'          			)
   ,('~thor_data400::base::liens::party::chicago_law'    		)
   ,('~thor_data400::base::ln_propassessheader_building' 		)
   ,('~thor_data400::base::ln_propdeedheader_building'      )
   ,('~thor_data400::base::ms_workers'                			)
   ,('~thor_data400::base::ms_workers_comp'           			)
   ,('~thor_data400::base::or_workers_comp'           			)
   ,('~thor_data400::base::prof_licenses'             			)
   ,('~thor_data400::base::sec_bd_info'               			)
   ,('~thor_data400::base::sec_broker_dealer'            		)
   ,('~thor_data400::base::ska'                    					)
   ,('~thor_data400::base::ska_a'                     			)
   ,('~thor_data400::base::ska_nixie'                 			)
   ,('~thor_data400::base::ska_verified'              			)
   ,('~thor_data400::base::vehicles_prod'             			)
   ,('~thor_data400::base::vickers_13d13g_base'       			)
   ,('~thor_data400::base::vickers_insider_filing_base'  		)
   ,('~thor_data400::base::whois'                     			)
   ,('~thor_data400::in::abius_combined_data'            		)
   ,('~thor_data400::in::dea'                      					)
   ,('~thor_data400::in::ia::sprayed::sales_tax'         		)
   ,('~thor_data400::in::infousa_deadco'              			)
   ,('~thor_data400::in::infousa_fbn_new'             			)
   ,('~thor_data400::in::infousa_idexec'              			)
   ,('~thor_data400::in::vickers::sprayed::13d13g'          )
   ,('~thor_data400::in::vickers::sprayed::insider_filing'	)
   ,('~thor_data400::in::vickers::sprayed::insider_security')
   ,(AMIDIR.Cluster + 'base::amidir'                  			)
   ,(BBB2.Filenames.Input.Member.Used                 			)
   ,(BBB2.Filenames.Input.NonMember.Used              			)
   ,(bbb2.Filenames.Base.Member.QA                    			)
   ,(bbb2.Filenames.Base.NonMember.QA                 			)
   ,(corp2.Filenames('').Base_xtnd.Corp.Prod	           		)
   ,(corp2.Filenames('').Base_xtnd.Cont.Prod	            	)
   ,(ebr.FileName_0010_Header_Base                    			)
   ,(ebr.FileName_0010_Header_In + '_father'          			)
   ,(ebr.FileName_5610_Demographic_Data_Base          			)
   ,(ebr.FileName_5610_Demographic_Data_In + '_father'      )
   ,(FCC.Filename_FCC_Licenses_In											      )
   ,(liquor_licenses.filenames().base.CA.qa		              )
   ,(liquor_licenses.filenames().base.OH.qa   		          )
   ,(liquor_licenses.filenames().base.PA.qa       	        )
   ,(liquor_licenses.filenames().base.TX.qa         	      )
   ,(ln_property.fileNames.builtAssessor              			)
   ,(ln_property.fileNames.builtDeeds                 			)
   ,(ln_property.filenames.builtSearch                			)
   ,(martindale_hubbell.filenames('').base.organizations.qa	)
   ,(sda_sdaa.Cluster.cluster_in+'Base::SDA'          			)
   ,(sda_sdaa.Cluster.cluster_in+'Base::SDAA'            		)
   ,(uccv2.cluster.cluster_out+'base::ucc::party'        		)
   ,(yellowpages.Filenames.Base.QA                    			)
   ,(yellowpages.Filenames.Input.Used                 			)
   ,(zoom.filenames('').base.qa                    					)
                                   
], namerecord);

namerecord tgetLogicalSubFiles(namerecord l, unsigned4 cnt) :=
transform
	allcontents := fileservices.superfilecontents(l.name,true);
	
	self.name := allcontents[cnt].name;

end;
Update_superfiles_list :=  normalize(Update_super_files_list, count(fileservices.superfilecontents(left.name,true)), tgetLogicalSubFiles(left, counter));


////////////////////////////////////////////////////////////////////////////////////
// -- Get the thor clusters that the lobbyist and watercraft files are on
// -- removing the '~' from the beginning because fileservices.LogicalFileList 
// -- does not work with the '~'
////////////////////////////////////////////////////////////////////////////////////
lobby_thor := lobbyists.lobbyist_thor_cluster[2..];
water_cluster := watercraft.cluster[2..];

////////////////////////////////////////////////////////////////////////////////////
// -- Inline dataset of the filenames of the regular files
// -- used in the business header build
////////////////////////////////////////////////////////////////////////////////////
Update_logical_files_list := DATASET([
	 ('thor_data400::base::vehicles_' + VehLic.Version_Production											)
	,('thor_data400::in::aca_internet_march_success_20040629'													)
	,('thor_data400::in::ace_check_serv_20040629'																			)
	,('thor_data400::in::ace_icsp_20040629'																						)
	,('thor_data400::in::ace_international_20040629'																	)
	,('thor_data400::in::card_tech_securtech_20040629'																)
	,('thor_data400::in::customer_info_system_20040629'																)
	,('thor_data400::in::factoring_conference_20040629'																)
	,('thor_data400::in::factory_conference_20040629'																	)
	,('thor_data400::in::fl::sprayed::fbn'																						) // may need to modify these each time
	,('thor_data400::in::fl::sprayed::fbn_events'																			) // may need to modify these each time
	,('thor_data400::in::ins_fraud_manage_20040629'																		)
	,('thor_data400::in::las_vegas_recruit_expo_20040629'															)
	,('thor_data400::in::non_profit_orgs_clean_' + govdata.versions.FL_Non_Profit			)
	,('thor_data400::in::who_is_20040504'																							)
	,('thor_data400::in::wither_and_die_20050214'																			)
	,('thor_data400::in::wither_and_die_20050314'																			)
	,('thor_data400::out::macro_clean_contactnames'																		)
	,(lobby_thor + '::in::lobbyist_ca_20060914_lobbyist'															)
	,(lobby_thor + '::in::lobbyist_co_20060417_lobbyist_discl_inc'										)
	,(lobby_thor + '::in::lobbyist_fl_20060322_llob'																	)
	,(lobby_thor + '::in::lobbyist_ga_20060323_lobbyist_2006'													)
	,(lobby_thor + '::in::lobbyist_ia_20060323_lobbyist_client_2006'									)
	,(lobby_thor + '::in::lobbyist_id_20060323_lobbyist_2006'													)
	,(lobby_thor + '::in::lobbyist_in_20060410_update_2006'														)
	,(lobby_thor + '::in::lobbyist_ks_20060428_lobbyist_directory_april_28'						)
	,(lobby_thor + '::in::lobbyist_la_20060428_loblist'																)
	,(lobby_thor + '::in::lobbyist_ma_20060427_lobbyist_division_extract'							)
	,(lobby_thor + '::in::lobbyist_mi_20060323_lobby'																	)
	,(lobby_thor + '::in::lobbyist_mn_20060328_active_lobbyists_w_address'						)
	,(lobby_thor + '::in::lobbyist_mo_20060323_lobbyist_principal_report_03_23_2006'	)
	,(lobby_thor + '::in::lobbyist_nd_20060118_lobbyist_2003-2005'										)
	,(lobby_thor + '::in::lobbyist_nh_20060406_full_file_update'											)
	,(lobby_thor + '::in::lobbyist_nj_20060323_request_ferris_robin'									)
	,(lobby_thor + '::in::lobbyist_oh_20060327_agents_march_2006'											)
	,(lobby_thor + '::in::lobbyist_ok_20050201_loblist1-31-05.csv'										)
	,(lobby_thor + '::in::lobbyist_or_20060710_lobbyist_list'													)
	,(lobby_thor + '::in::lobbyist_ri_20060323_full_report_by_entity'									)
	,(lobby_thor + '::in::lobbyist_sd_20060414_list'																	)
	,(lobby_thor + '::in::lobbyist_ut_20051229_lobbyists'															)
	,(lobby_thor + '::in::lobbyist_vt_employer_listing_3_30_2005_csv'									)
	,(lobby_thor + '::in::lobbyist_wv_20060328_lobby'																	)
	,(lobby_thor + '::in::lobbyists::ga_20050307_initial.csv'													)
	,(lobby_thor + '::in::lobbyists::hi_20050405_initial'															)
	,(lobby_thor + '::in::lobbyists::ia_2002'																					)
	,(lobby_thor + '::in::lobbyists::ia_2003'																					)
	,(lobby_thor + '::in::lobbyists::ia_2004'																					)
	,(lobby_thor + '::in::lobbyists::id_1992_2005_lobbyist'														)
	,(lobby_thor + '::in::lobbyists::ky_20050202_all_eal_mailing_list.csv'						)
	,(lobby_thor + '::in::lobbyists::me_20050307_initial.csv'													)
	,(lobby_thor + '::in::lobbyists::mn_20050203'																			)
	,(lobby_thor + '::in::lobbyists::mo_2000_2005'																		)
	,(lobby_thor + '::in::lobbyists::nc_20050307_initial.csv'													)
	,(lobby_thor + '::in::lobbyists::nh_20050324_initial.csv'													)
	,(lobby_thor + '::in::lobbyists::nj_20050216_request_1999_2005.csv'								)
	,(lobby_thor + '::in::lobbyists::nv_20050413_initial_mod.csv'											)
	,(lobby_thor + '::in::lobbyists::ny_20050308_initial_mod.csv'											)
	,(lobby_thor + '::in::lobbyists::oh_20050202_initial.csv'													)
	,(lobby_thor + '::in::lobbyists::ri_20050217_full_report_entity.csv'							)
	,(lobby_thor + '::in::lobbyists::sd_20050308_initial.csv'													)
	,(lobby_thor + '::in::lobbyists_ak_2005_lobdir.csv'																)
	,(lobby_thor + '::in::lobbyists_al_12_03_04.csv'																	)
	,(lobby_thor + '::in::lobbyists_al_5_05_05.csv'																		)
	,(lobby_thor + '::in::lobbyists_ar_20050131_sep13.csv'														)
	,(lobby_thor + '::in::lobbyists_az_lobexport_1.csv'																)
	,(lobby_thor + '::in::lobbyists_ca_20050624_lobbyists.csv'												)
	,(lobby_thor + '::in::lobbyists_co_curr_lobby.csv'																)
	,(lobby_thor + '::in::lobbyists_dc_20050412_initial.csv'													)
	,(lobby_thor + '::in::lobbyists_fl_20050412_llob.txt'															)
	,(lobby_thor + '::in::lobbyists_in_20050408_initial_mod.csv'											)
	,(lobby_thor + '::in::lobbyists_la_20050819_alllobs.csv'													)
	,(lobby_thor + '::in::lobbyists_ma_20050411_initial_csv'													)
	,(lobby_thor + '::in::lobbyists_ms_20050321_initial.csv'													)
	,(lobby_thor + '::in::lobbyists_mt_2000_2002_irr_lb_pr1.csv'											)
	,(lobby_thor + '::in::lobbyists_mt_2003_2004_irr_lb_pr1.csv'											)
	,(lobby_thor + '::in::lobbyists_mt_2005_2006_irr_lb_pr1.csv'											)
	,(lobby_thor + '::in::lobbyists_or_20050207_lobbyist_mod.csv'											)
	,(lobby_thor + '::in::lobbyists_tx_lobcon01.csv'																	)
	,(lobby_thor + '::in::lobbyists_tx_lobcon02.csv'																	)
	,(lobby_thor + '::in::lobbyists_tx_lobcon03.csv'																	)
	,(lobby_thor + '::in::lobbyists_tx_lobcon04.csv'																	)
	,(lobby_thor + '::in::lobbyists_tx_lobcon05.csv'																	)
	,(lobby_thor + '::in::lobbyists_tx_lobted00.csv'																	)
	,(lobby_thor + '::in::lobbyists_tx_lobted97.csv'																	)
	,(lobby_thor + '::in::lobbyists_tx_lobted98.csv'																	)
	,(lobby_thor + '::in::lobbyists_tx_lobted99.csv'																	)
	,(lobby_thor + '::in::lobbyists_va_2005'																					)
	,(lobby_thor + '::in::lobbyists_wy_20050413_initial.csv'													)
	,(lobby_thor + '::in::tn_lobbyists_2001.csv'																			)
	,(lobby_thor + '::in::tn_lobbyists_2002.csv'																			)
	,(lobby_thor + '::in::tn_lobbyists_2003.csv'																			)
	,(lobby_thor + '::in::tn_lobbyists_2004.csv'																			)
	,(lobby_thor + '::in::tn_lobbyists_2005.csv'																			)
	,(lobby_thor + '::in::wv_20050209.lobby_names.csv'																)
	,(water_cluster + 'base::watercraft_search_' + watercraft.version_production			) // no superfile yet
], namerecord);

////////////////////////////////////////////////////////////////////////////////////
// -- Get file information for filenames
////////////////////////////////////////////////////////////////////////////////////
inforecord getinfo(namerecord l) := 
transform
	fileinfo := fileservices.LogicalFileList(l.name)[1];

	self.name				:= fileinfo.name																								 ;
	self.superfile	:= fileinfo.superfile																						 ;
	self.size				:= if(fileinfo.size			> 744073709500000, 0, fileinfo.size			);
	self.rowcount		:= if(fileinfo.rowcount > 744073709500000, 0, fileinfo.rowcount	);
	self.modified		:= fileinfo.modified																						 ;
	self.owner			:= fileinfo.owner																								 ;
	self.cluster		:= fileinfo.cluster																							 ;
end;


fileinfo := project(Update_superfiles_list + Update_logical_files_list, getinfo(left));

export Query_Count_Business_Header_Components := 
	output(sort(fileinfo,name),named('Business_Header_Input_File_List'),all);