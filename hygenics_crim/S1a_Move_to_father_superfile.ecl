

doc := parallel(FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_DEFENDANT_FATHER'      ,'~thor_200::in::crim::HD::DOC_DEFENDANT'      ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_OFFENSE_FATHER'        ,'~thor_200::in::crim::HD::DOC_OFFENSE'        ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_CHARGE_FATHER'         ,'~thor_200::in::crim::HD::DOC_CHARGE'         ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_ALIAS_FATHER'          ,'~thor_200::in::crim::HD::DOC_ALIAS'          ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_SENTENCE_FATHER'       ,'~thor_200::in::crim::HD::DOC_SENTENCE'       ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_PRIOR_FATHER'          ,'~thor_200::in::crim::HD::DOC_PRIOR'          ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_ADDRESS_HISTORY_FATHER','~thor_200::in::crim::HD::DOC_ADDRESS_HISTORY',,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_PHONE_HISTORY_FATHER'  ,'~thor_200::in::crim::HD::DOC_PHONE_HISTORY'  ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_OTHER_FATHER'          ,'~thor_200::in::crim::HD::DOC_OTHER'          ,,1)
              );

aoc    := parallel( FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_DEFENDANT_FATHER'      ,'~thor_200::in::crim::HD::AOC_DEFENDANT'      ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_OFFENSE_FATHER'        ,'~thor_200::in::crim::HD::AOC_OFFENSE'        ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_CHARGE_FATHER'         ,'~thor_200::in::crim::HD::AOC_CHARGE'         ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_ALIAS_FATHER'          ,'~thor_200::in::crim::HD::AOC_ALIAS'          ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_SENTENCE_FATHER'       ,'~thor_200::in::crim::HD::AOC_SENTENCE'       ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_ADDRESS_HISTORY_FATHER','~thor_200::in::crim::HD::AOC_ADDRESS_HISTORY',,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_PHONE_HISTORY_FATHER'  ,'~thor_200::in::crim::HD::AOC_PHONE_HISTORY'  ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_OTHER_FATHER'          ,'~thor_200::in::crim::HD::AOC_OTHER'          ,,1)
									);
									
cty    := parallel(FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_DEFENDANT_FATHER'      ,'~thor_200::in::crim::HD::COUNTY_DEFENDANT'      ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_OFFENSE_FATHER'        ,'~thor_200::in::crim::HD::COUNTY_OFFENSE'        ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_CHARGE_FATHER'         ,'~thor_200::in::crim::HD::COUNTY_CHARGE'         ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_ALIAS_FATHER'          ,'~thor_200::in::crim::HD::COUNTY_ALIAS'          ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_SENTENCE_FATHER'       ,'~thor_200::in::crim::HD::COUNTY_SENTENCE'       ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_ADDRESS_HISTORY_FATHER','~thor_200::in::crim::HD::COUNTY_ADDRESS_HISTORY',,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_OTHER_FATHER'          ,'~thor_200::in::crim::HD::COUNTY_OTHER'          ,,1)
									);
arrest   := parallel(FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_DEFENDANT_FATHER'     ,'~thor_200::in::crim::HD::ARREST_DEFENDANT'      ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_OFFENSE_FATHER'         ,'~thor_200::in::crim::HD::ARREST_OFFENSE'        ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_CHARGE_FATHER'          ,'~thor_200::in::crim::HD::ARREST_CHARGE'         ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_ALIAS_FATHER'           ,'~thor_200::in::crim::HD::ARREST_ALIAS'          ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_SENTENCE_FATHER'        ,'~thor_200::in::crim::HD::ARREST_SENTENCE'       ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_ADDRESS_HISTORY_FATHER' ,'~thor_200::in::crim::HD::ARREST_ADDRESS_HISTORY',,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_PHONE_HISTORY_FATHER'   ,'~thor_200::in::crim::HD::ARREST_PHONE_HISTORY'  ,,1),
									 // FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_OTHER_FATHER'           ,'~thor_200::in::crim::HD::ARREST_OTHER'          ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_PRIORS_HISTORY_FATHER'  ,'~thor_200::in::crim::HD::ARREST_PRIORS_HISTORY' ,,1)
									 );										

									
//////////////////Crimwise//////////////
cwdoc := parallel(FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_DEFENDANT_CW_FATHER'    ,'~thor_200::in::crim::HD::DOC_DEFENDANT_CW'      ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_OFFENSE_CW_FATHER'        ,'~thor_200::in::crim::HD::DOC_OFFENSE_CW'        ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_CHARGE_CW_FATHER'         ,'~thor_200::in::crim::HD::DOC_CHARGE_CW'         ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_ALIAS_CW_FATHER'          ,'~thor_200::in::crim::HD::DOC_ALIAS_CW'          ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_SENTENCE_CW_FATHER'       ,'~thor_200::in::crim::HD::DOC_SENTENCE_CW'       ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_PRIOR_CW_FATHER'          ,'~thor_200::in::crim::HD::DOC_PRIOR_CW'          ,,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_ADDRESS_HISTORY_CW_FATHER','~thor_200::in::crim::HD::DOC_ADDRESS_HISTORY_CW',,1),
								FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_PHONE_HISTORY_CW_FATHER'  ,'~thor_200::in::crim::HD::DOC_PHONE_HISTORY_CW'  ,,1)
								// FileServices.AddSuperFile( '~thor_200::in::crim::HD::DOC_OTHER_CW_FATHER'          ,'~thor_200::in::crim::HD::DOC_OTHER_CW'          ,,1)
              );

cwaoc    := parallel( FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_DEFENDANT_CW_FATHER'    ,'~thor_200::in::crim::HD::AOC_DEFENDANT_CW'      ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_OFFENSE_CW_FATHER'        ,'~thor_200::in::crim::HD::AOC_OFFENSE_CW'        ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_CHARGE_CW_FATHER'         ,'~thor_200::in::crim::HD::AOC_CHARGE_CW'         ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_ALIAS_CW_FATHER'          ,'~thor_200::in::crim::HD::AOC_ALIAS_CW'          ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_SENTENCE_CW_FATHER'       ,'~thor_200::in::crim::HD::AOC_SENTENCE_CW'       ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_ADDRESS_HISTORY_CW_FATHER','~thor_200::in::crim::HD::AOC_ADDRESS_HISTORY_CW',,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_PHONE_HISTORY_CW_FATHER'  ,'~thor_200::in::crim::HD::AOC_PHONE_HISTORY_CW'  ,,1),
										FileServices.AddSuperFile( '~thor_200::in::crim::HD::AOC_OTHER_CW_FATHER'          ,'~thor_200::in::crim::HD::AOC_OTHER_CW'          ,,1)
									);
									
cwcty    := parallel(FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_DEFENDANT_CW_FATHER'    ,'~thor_200::in::crim::HD::COUNTY_DEFENDANT_CW'      ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_OFFENSE_CW_FATHER'        ,'~thor_200::in::crim::HD::COUNTY_OFFENSE_CW'        ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_CHARGE_CW_FATHER'         ,'~thor_200::in::crim::HD::COUNTY_CHARGE_CW'         ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_ALIAS_CW_FATHER'          ,'~thor_200::in::crim::HD::COUNTY_ALIAS_CW'          ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_SENTENCE_CW_FATHER'       ,'~thor_200::in::crim::HD::COUNTY_SENTENCE_CW'       ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_ADDRESS_HISTORY_CW_FATHER','~thor_200::in::crim::HD::COUNTY_ADDRESS_HISTORY_CW',,1)
									 // FileServices.AddSuperFile( '~thor_200::in::crim::HD::COUNTY_OTHER_CW_FATHER'          ,'~thor_200::in::crim::HD::COUNTY_OTHER_CW'          ,,1)
									);
									
	
cwarrest:= parallel(FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_DEFENDANT_CW_FATHER'      ,'~thor_200::in::crim::HD::ARREST_DEFENDANT_CW'      ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_OFFENSE_CW_FATHER'         ,'~thor_200::in::crim::HD::ARREST_OFFENSE_CW'        ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_CHARGE_CW_FATHER'          ,'~thor_200::in::crim::HD::ARREST_CHARGE_CW'         ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_ALIAS_CW_FATHER'           ,'~thor_200::in::crim::HD::ARREST_ALIAS_CW'          ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_SENTENCE_CW_FATHER'        ,'~thor_200::in::crim::HD::ARREST_SENTENCE_CW'       ,,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_ADDRESS_HISTORY_CW_FATHER' ,'~thor_200::in::crim::HD::ARREST_ADDRESS_HISTORY_CW',,1),
									 FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_PHONE_HISTORY_CW_FATHER'   ,'~thor_200::in::crim::HD::ARREST_PHONE_HISTORY_CW'  ,,1),
									 // FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_OTHER_CW_FATHER'           ,'~thor_200::in::crim::HD::ARREST_OTHER_CW'          ,,1),
									 // FileServices.AddSuperFile( '~thor_200::in::crim::HD::ARREST_PRIORS_HISTORY_CW_FATHER'  ,'~thor_200::in::crim::HD::ARREST_PRIORS_HISTORY_CW' ,,1)
									);									 

export S1a_Move_to_father_superfile :=   sequential(
	                                   
										   FileServices.StartSuperFileTransaction(),																	                                    
											 doc,
											 aoc,
											 cty,
											 arrest,
											 cwdoc,
											 cwaoc,
											 cwcty,
											 cwarrest,
										   FileServices.FinishSuperFileTransaction()
											);
														