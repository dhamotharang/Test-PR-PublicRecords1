

//***********spray for Patriot_preprocess.Mapping_Bank_of_England
spray1 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/bank_of_england/'+file_date.BANK_OF_ENGLAND_DATE+'.sanctionsconlist.txt', //RemoteLoc + remoteFileName,
														, 
														';',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::bank_of_england::' + file_date.BANK_OF_ENGLAND_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
									

//***********spray for Patriot_preprocess.Mapping_Dept_of_Commerce_Unverified 
spray2 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/unverified/'+file_date.UNVERIFIED_DATE+'.unverified.txt', //RemoteLoc + remoteFileName,
														, 
														'\t',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::dept::of::commerce::unverified::' + file_date.UNVERIFIED_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
//***********spray for Patriot_preprocess.Mapping_Directorate_Defense_Trade_Controls_Debarred_Parties
spray3 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/debarred_parties/'+file_date.DEBARRED_PARTIES_DATE+'.debarred_parties.txt', //RemoteLoc + remoteFileName,
														, 
														'\t;',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::directorate::defense::trade::controls::debarred::parties::' + file_date.DEBARRED_PARTIES_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
//***********spray for Patriot_preprocess.Mapping_EU_Terrorist_Org_And_Ind   xls to csv
spray4 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/eu_terrorist_list/'+file_date.EUROPEAN_UNION_DESIGNATED_TERRORISTS+'_data/'+file_date.EUROPEAN_UNION_DESIGNATED_TERRORISTS+'_text_output_persons.csv', //RemoteLoc + remoteFileName,
														, 
														'\t',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::eu:terrorists::persons::'+ file_date.EUROPEAN_UNION_DESIGNATED_TERRORISTS + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
													
spray5 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/eu_terrorist_list/'+file_date.EUROPEAN_UNION_DESIGNATED_TERRORISTS+'_data/'+ file_date.EUROPEAN_UNION_DESIGNATED_TERRORISTS+'_text_output_Groups.csv', //RemoteLoc + remoteFileName,
														, 
														'|',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::eu:terrorists::groups::'+file_date.EUROPEAN_UNION_DESIGNATED_TERRORISTS + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
																												
//***********spray for Patriot_preprocess.Mapping_Export_Admin_Reg_Entity_Licensing
spray6 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/denied_entity/'+file_date.DENIED_ENTITY_DATE+'_text_output_Sheet1.csv', //RemoteLoc + remoteFileName,
														, 
														'|',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::denied_entity::' + file_date.DENIED_ENTITY_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
//***********spray for Patriot_preprocess.Mapping_Foreign_Agents_Registration


reformat_date := file_date.FOREIGN_AGENT_REGISTRATIONS_DATE[5..6] +'_'+ 
                 file_date.FOREIGN_AGENT_REGISTRATIONS_DATE[7..8] +'_'+ 
			           file_date.FOREIGN_AGENT_REGISTRATIONS_DATE[1..4];

spray7 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/foreign_agents_registration/'+file_date.FOREIGN_AGENT_REGISTRATIONS_DATE+'/active_foreign_principals_for_all_countries_locations__as_of_'+reformat_date+'.csv', //RemoteLoc + remoteFileName,
														, 
														',',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::far::active::foreign::principals::'+file_date.FOREIGN_AGENT_REGISTRATIONS_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
spray8 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/foreign_agents_registration/'+file_date.FOREIGN_AGENT_REGISTRATIONS_DATE+'/active_registrants_as_of_'+reformat_date+'.csv', //RemoteLoc + remoteFileName,
														, 
														',',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::far::active::registrants::'+file_date.FOREIGN_AGENT_REGISTRATIONS_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);

spray9 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/foreign_agents_registration/'+file_date.FOREIGN_AGENT_REGISTRATIONS_DATE+'/active_short_form_registrants__as_of_'+reformat_date+'.csv', //RemoteLoc + remoteFileName,
														, 
														',',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::far::active::short::form::registrants::'+file_date.FOREIGN_AGENT_REGISTRATIONS_DATE + '_' + file_date.process_date, //OPFileName,
														-1,
														,
														,
														true,
														true);		

//***********spray for Patriot_preprocess.Mapping_Innovative_OFAC_Enhanced
//fix length

spray10 := FileServices.SprayFixed( 'edata12.br.seisint.com',//sourceIP , 
                         '/data_999/sanctions/data/innovative_systems/'+file_date.POLITICALLY_EXPOSED_PERSONS+'_data/'+file_date.POLITICALLY_EXPOSED_PERSONS+'.PEP_825_parsed_orig.dat', 
												 15680, 
												 'thor400_20', //destinationgroup,
                         '~thor::in::patriot::innovative::ofac::enhanced::pep::'+file_date.POLITICALLY_EXPOSED_PERSONS + '_' + file_date.process_date, 
												 -1,  //[,timeout] 
												 ,  //[, espserverIPport ]
                         ,  //[, maxConnections ] 
												 true,  //[, allowoverwrite ] 
												 ,  //[, replicate ]
                         ,);  //[, compress ])
												 
spray11 := FileServices.SprayFixed( 'edata12.br.seisint.com',//sourceIP , 
                         '/data_999/sanctions/data/innovative_systems/'+file_date.OFAC_SANCTIONED_COUNTRIES+'_data/'+file_date.OFAC_SANCTIONED_COUNTRIES+'.OSC_825_parsed_orig.dat', 
												 15680, 
												 'thor400_20', //destinationgroup,
                         '~thor::in::patriot::Innovative::ofac::Enhanced::OSC::'+file_date.OFAC_SANCTIONED_COUNTRIES + '_' + file_date.process_date, 
												 -1,  //[,timeout] 
												 ,  //[, espserverIPport ]
                         ,  //[, maxConnections ] 
												 true,  //[, allowoverwrite ] 
												 ,  //[, replicate ]
                         ,);  //[, compress ])
												 
// spray12 := FileServices.SprayFixed( 'edata12.br.seisint.com',//sourceIP , 
                         // '/data_999/sanctions/data/innovative_systems/'+file_date.OFFICE_OF_THE_COMPTROLLER_OF_CURRENCY+'_data/'+file_date.OFFICE_OF_THE_COMPTROLLER_OF_CURRENCY+'.OCC_825_parsed_orig.dat', 
												 // 15680, 
												 // 'thor400_20', //destinationgroup,
                         // '~thor::in::patriot::innovative::ofac::enhanced::OCC::'+file_date.OFFICE_OF_THE_COMPTROLLER_OF_CURRENCY + '_' + file_date.process_date, 
												 // -1,  //[,timeout] 
												 // ,  //[, espserverIPport ]
                         // ,  //[, maxConnections ] 
												 // true,  //[, allowoverwrite ] 
												 // ,  //[, replicate ]
                         // ,);  //[, compress ])
												 
spray13 := FileServices.SprayFixed( 'edata12.br.seisint.com',//sourceIP , 
                         '/data_999/sanctions/data/innovative_systems/'+file_date.FBI_MOST_WANTED+'_data/'+file_date.FBI_MOST_WANTED+'.FBI_825_parsed_orig.dat', 
												 15680, 
												 'thor400_20', //destinationgroup,
                         '~thor::in::patriot::innovative::ofac::enhanced::FBI::'+file_date.FBI_MOST_WANTED + '_' + file_date.process_date, 
												 -1,  //[,timeout] 
												 ,  //[, espserverIPport ]
                         ,  //[, maxConnections ] 
												 true,  //[, allowoverwrite ] 
												 ,  //[, replicate ]
                         ,);  //[, compress ])
												 
spray14 := FileServices.SprayFixed( 'edata12.br.seisint.com',//sourceIP , 
                         '/data_999/sanctions/data/innovative_systems/'+file_date.UNITED_NATIONS_SANCTIONS+'_data/'+file_date.UNITED_NATIONS_SANCTIONS+'.UNS_825_parsed_orig.dat', 
												 15680, 
												 'thor400_20', //destinationgroup,
                         '~thor::in::patriot::innovative::ofac::enhanced::UNS::'+patriot_preprocess.file_date.UNITED_NATIONS_SANCTIONS + '_' + file_date.process_date, 
												 -1,  //[,timeout] 
												 ,  //[, espserverIPport ]
                         ,  //[, maxConnections ] 
												 true,  //[, allowoverwrite ] 
												 ,  //[, replicate ]
                         ,);  //[, compress ])												 

//***********spray for Patriot_preprocess.Mapping_Interpol_Most_Wanted
spray15 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/interpol_most_wanted/'+file_date.INTERPOL_DATE+'_data/interpol.txt', //RemoteLoc + remoteFileName,
														, 
														'|',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::interpol_most_wanted::'+file_date.INTERPOL_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
// fix length
spray16 := FileServices.SprayFixed( 'edata12.br.seisint.com',//sourceIP , 
                         '/data_999/sanctions/data/innovative_systems/'+file_date.INTERPOL_MOST_WANTED_RED_NOTICE+'_data/'+file_date.INTERPOL_MOST_WANTED_RED_NOTICE+'.INT_825_parsed_orig.dat', 
												 15680, 
												 'thor400_20', //destinationgroup,
                         '~thor::in::patriot::interpol_most_wanted::int::'+file_date.INTERPOL_MOST_WANTED_RED_NOTICE + '_' + file_date.process_date, 
												 -1,  //[,timeout] 
												 ,  //[, espserverIPport ]
                         ,  //[, maxConnections ] 
												 true,  //[, allowoverwrite ] 
												 ,  //[, replicate ]
                         ,);  //[, compress ])
														
//***********spray for Patriot_preprocess.Mapping_OFAC_PLC_Officials
spray17 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/ofac/'+file_date.OFAC_PLC_DATE+'_data/new_plc.txt', //RemoteLoc + remoteFileName,
														, 
														'|',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::ofac::plc::officials::'+file_date.OFAC_PLC_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
//***********spray for Patriot_preprocess.Mapping_OFAC_Specially_Designated_Nationals
spray18 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/ofac/'+file_date.OFAC_DATE+'_data/new_sdn.txt', //RemoteLoc + remoteFileName,
														, 
														'|',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::ofac::specially::designated::nationals::'+file_date.OFAC_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
//***********spray for Patriot_preprocess.Mapping_OSFI_Canada_Entities_of_Concern
spray19 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/osfi_canada/'+file_date.OSFI_CANADA_ENTITIES_DATE+'.entstld_e.txt', //RemoteLoc + remoteFileName,
														, 
														'\t',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::osfi_canada::entites::'+file_date.OSFI_CANADA_ENTITIES_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
spray20 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/osfi_canada/'+file_date.OSFI_CANADA_INDIVIDUALS_DATE+'.indstld_e.txt', //RemoteLoc + remoteFileName,
														, 
														'\t',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::osfi_canada::individuals::'+file_date.OSFI_CANADA_INDIVIDUALS_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
//***********spray for Patriot_preprocess.Mapping_State_Dept_Foreign_Terrorist_Orgs   xls to csv
spray21 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/state_department/'+file_date.STATE_DEPARTMENT_FOREIGN_TERRORIST_ORGANIZATIONS+'_data/'+file_date.STATE_DEPARTMENT_FOREIGN_TERRORIST_ORGANIZATIONS+'.foreign_terrorists.csv', //RemoteLoc + remoteFileName,
														, 
														'|',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::state::department::foreign::terrorist::organizations::'+file_date.STATE_DEPARTMENT_FOREIGN_TERRORIST_ORGANIZATIONS + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
//***********spray for Patriot_preprocess.Mapping_State_Dept_Terrorist_Exclusions xls to csv
spray22 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/state_department/'+file_date.STATE_DEPARTMENT_TERRORIST_EXCLUSIONS+'_data/'+file_date.STATE_DEPARTMENT_TERRORIST_EXCLUSIONS+'.Terrorists.csv', //RemoteLoc + remoteFileName,
														, 
														'|',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::state::department::terrorist::exclusions::'+file_date.STATE_DEPARTMENT_TERRORIST_EXCLUSIONS + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
//***********spray for Patriot_preprocess.Mapping_US_Bureau_of_Industry_And_Security_Denied_Persons
spray23 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/denied_persons/'+file_date.DENIED_PERSONS_DATE+'.Denied_Persons_List.txt', //RemoteLoc + remoteFileName,
														, 
														'\t',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::denied_persons::'+file_date.DENIED_PERSONS_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);
														
//***********spray for Patriot_preprocess.Mapping_Worldbank_Debarred		
spray24 := FileServices.SprayVariable(
													  'edata12.br.seisint.com',  // srcIP,
														'/data_999/sanctions/data/world_bank/'+file_date.WORLD_BANK_DATE+'.Worldbank_Debarred_Firms.txt', //RemoteLoc + remoteFileName,
														, 
														';',   //sourceCsvSeparater,
														'\\n,\\r\\n',  //sourceCsvTeminater,
														'"', //sourceCsvQuote,
                            'thor400_20',  //targetGrp,
                            '~thor::in::patriot::world_bank::'+file_date.WORLD_BANK_DATE + '_' + file_date.process_date, //OPFileName,
														-1,,,
														true,
														true);					

Fun_superfiles_management(String basename,string raw_file) := 		
                                 sequential(FileServices.StartSuperFileTransaction( ),
                                            FileServices.ClearSuperFile(basename	+	'_father'),
                                            FileServices.AddSuperFile(basename	+	'_father',basename,,true),
                                            FileServices.ClearSuperFile(basename),
                                            FileServices.AddSuperFile(basename,raw_file),
                                            FileServices.FinishSuperFileTransaction( ));	 
	 
sf1 := Fun_superfiles_management('~thor::in::patriot::bank_of_england','~thor::in::patriot::bank_of_england::' + file_date.BANK_OF_ENGLAND_DATE+ '_' + file_date.process_date);																	
sf2 := Fun_superfiles_management('~thor::in::patriot::dept::of::commerce::unverified', '~thor::in::patriot::dept::of::commerce::unverified::' + file_date.UNVERIFIED_DATE+ '_' + file_date.process_date);
sf3 := Fun_superfiles_management('~thor::in::directorate::defense::trade::controls::debarred::parties','~thor::in::directorate::defense::trade::controls::debarred::parties::' + file_date.DEBARRED_PARTIES_DATE+ '_' + file_date.process_date);
sf4 := Fun_superfiles_management('~thor::in::patriot::eu:terrorists::persons','~thor::in::patriot::eu:terrorists::persons::'+ file_date.EUROPEAN_UNION_DESIGNATED_TERRORISTS+ '_' + file_date.process_date);
sf5 := Fun_superfiles_management('~thor::in::patriot::eu:terrorists::groups','~thor::in::patriot::eu:terrorists::groups::'+file_date.EUROPEAN_UNION_DESIGNATED_TERRORISTS+ '_' + file_date.process_date);
sf6 := Fun_superfiles_management('~thor::in::patriot::denied_entity','~thor::in::patriot::denied_entity::' + file_date.DENIED_ENTITY_DATE+ '_' + file_date.process_date);
sf7 := Fun_superfiles_management('~thor::in::patriot::far::active::foreign::principals','~thor::in::patriot::far::active::foreign::principals::'+file_date.FOREIGN_AGENT_REGISTRATIONS_DATE+ '_' + file_date.process_date);
sf8 := Fun_superfiles_management('~thor::in::patriot::far::active::registrants','~thor::in::patriot::far::active::registrants::'+file_date.FOREIGN_AGENT_REGISTRATIONS_DATE+ '_' + file_date.process_date);
sf9 := Fun_superfiles_management('~thor::in::patriot::far::active::short::form::registrants','~thor::in::patriot::far::active::short::form::registrants::'+file_date.FOREIGN_AGENT_REGISTRATIONS_DATE+ '_' + file_date.process_date);
sf10 := Fun_superfiles_management('~thor::in::patriot::innovative::ofac::enhanced::pep','~thor::in::patriot::innovative::ofac::enhanced::pep::'+file_date.POLITICALLY_EXPOSED_PERSONS+ '_' + file_date.process_date);
sf11 := Fun_superfiles_management('~thor::in::patriot::Innovative::ofac::Enhanced::OSC','~thor::in::patriot::Innovative::ofac::Enhanced::OSC::'+file_date.OFAC_SANCTIONED_COUNTRIES+ '_' + file_date.process_date);
//sf12 := Fun_superfiles_management('~thor::in::patriot::Innovative::ofac::Enhanced::OCC','~thor::in::patriot::innovative::ofac::enhanced::OCC::'+file_date.OFFICE_OF_THE_COMPTROLLER_OF_CURRENCY+ '_' + file_date.process_date);
sf13 := Fun_superfiles_management('~thor::in::patriot::Innovative::ofac::Enhanced::FBI','~thor::in::patriot::innovative::ofac::enhanced::FBI::'+file_date.FBI_MOST_WANTED+ '_' + file_date.process_date);
sf14 := Fun_superfiles_management('~thor::in::patriot::Innovative::ofac::Enhanced::UNS','~thor::in::patriot::innovative::ofac::enhanced::UNS::'+patriot_preprocess.file_date.UNITED_NATIONS_SANCTIONS+ '_' + file_date.process_date);
sf15 := Fun_superfiles_management('~thor::in::patriot::interpol_most_wanted','~thor::in::patriot::interpol_most_wanted::'+file_date.INTERPOL_DATE+ '_' + file_date.process_date);
sf16 := Fun_superfiles_management('~thor::in::patriot::interpol_most_wanted::int','~thor::in::patriot::interpol_most_wanted::int::'+file_date.INTERPOL_MOST_WANTED_RED_NOTICE+ '_' + file_date.process_date);													 
sf17 := Fun_superfiles_management('~thor::in::patriot::ofac::plc::officials','~thor::in::patriot::ofac::plc::officials::'+file_date.OFAC_PLC_DATE+ '_' + file_date.process_date);
sf18 := Fun_superfiles_management('~thor::in::patriot::ofac::specially::designated::nationals', '~thor::in::patriot::ofac::specially::designated::nationals::'+file_date.OFAC_DATE+ '_' + file_date.process_date);
sf19 := Fun_superfiles_management('~thor::in::patriot::osfi_canada::entites','~thor::in::patriot::osfi_canada::entites::'+file_date.OSFI_CANADA_ENTITIES_DATE+ '_' + file_date.process_date);
sf20 := Fun_superfiles_management('~thor::in::patriot::osfi_canada::individuals','~thor::in::patriot::osfi_canada::individuals::'+file_date.OSFI_CANADA_INDIVIDUALS_DATE+ '_' + file_date.process_date);
sf21 := Fun_superfiles_management('~thor::in::patriot::state::department::foreign::terrorist::organizations','~thor::in::patriot::state::department::foreign::terrorist::organizations::'+file_date.STATE_DEPARTMENT_FOREIGN_TERRORIST_ORGANIZATIONS+ '_' + file_date.process_date);																																			 
sf22 := Fun_superfiles_management('~thor::in::patriot::state::department::terrorist::exclusions','~thor::in::patriot::state::department::terrorist::exclusions::'+file_date.STATE_DEPARTMENT_TERRORIST_EXCLUSIONS+ '_' + file_date.process_date);                                                                                                                                                                    																																					
sf23 := Fun_superfiles_management('~thor::in::patriot::denied_persons','~thor::in::patriot::denied_persons::'+file_date.DENIED_PERSONS_DATE+ '_' + file_date.process_date);
sf24 := Fun_superfiles_management('~thor::in::patriot::world_bank','~thor::in::patriot::world_bank::'+file_date.WORLD_BANK_DATE+ '_' + file_date.process_date);																	
 
 
process_sprays := parallel(spray1, 
														spray2,
														spray3,
														spray4,
														spray5,
														spray6,
														spray7,
														spray8,
														spray9,
														spray10,
														spray11,
													//	spray12,
														spray13,
														spray14,
														spray15,
														spray16,
														spray17,
														spray18,
														spray19,
														spray20,
														spray21,
														spray22,
														spray23,
														spray24);
														
process_superfiles_management:=  parallel(sf1,			
																					sf2,
																					sf3,
																					sf4,
																					sf5,
																					sf6,
																					sf7,
																					sf8,
																					sf9,
																					sf10,
																					sf11,
																				//	sf12,
																					sf13,
																					sf14,
																					sf15,
																					sf16,
																					sf17,
																					sf18,
																					sf19,
																					sf20,
																					sf21,
																					sf22,
																					sf23,
																					sf24);
																					
EXPORT _spray_raw := sequential(process_sprays,process_superfiles_management);																					
																					
																					