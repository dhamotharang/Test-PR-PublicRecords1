import digssoff;

docCreate_SuperFile       := Parallel(
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_DEFENDANT'),
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_OFFENSE'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_CHARGE'),
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_ALIAS'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_SENTENCE'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_PRIOR'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_ADDRESS_HISTORY'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_PHONE_HISTORY'),
																			digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_OTHER')
																	   );
																		 

docCreate_SuperFile_2     := Parallel(
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_DEFENDANT_FATHER'),
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_OFFENSE_FATHER'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_CHARGE_FATHER'),
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_ALIAS_FATHER'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_SENTENCE_FATHER'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_PRIOR_FATHER'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_ADDRESS_HISTORY_FATHER'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_PHONE_HISTORY_FATHER'),
																			digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_OTHER_FATHER')
																	   );

aocCreate_SuperFile     := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_DEFENDANT_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_OFFENSE_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_CHARGE_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_ALIAS_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_SENTENCE_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_OTHER_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_ADDRESS_HISTORY_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_PHONE_HISTORY_FATHER')
																		 );	
																		 
aocCreate_SuperFile_2    := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_DEFENDANT'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_OFFENSE'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_CHARGE'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_ALIAS'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_SENTENCE'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_OTHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_ADDRESS_HISTORY'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_PHONE_HISTORY')
																		 );																			 
county_Create_SuperFile    := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_DEFENDANT'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_OFFENSE'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_CHARGE'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_ALIAS'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_SENTENCE'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_OTHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_ADDRESS_HISTORY'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_PHONE_HISTORY')
																		 );		
																		 
county_Create_SuperFile_2  := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_DEFENDANT_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_OFFENSE_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_CHARGE_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_ALIAS_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_SENTENCE_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_OTHER_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_ADDRESS_HISTORY_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_PHONE_HISTORY_FATHER')
																		 );		
arrestCreate_SuperFile    := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_DEFENDANT'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_OFFENSE'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_CHARGE'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_ALIAS'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_SENTENCE'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_OTHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_ADDRESS_HISTORY'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_PHONE_HISTORY'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_PRIORS_HISTORY')
																		 );																			 
arrestCreate_SuperFile_2  := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_DEFENDANT_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_OFFENSE_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_CHARGE_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_ALIAS_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_SENTENCE_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_OTHER_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_ADDRESS_HISTORY_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_PHONE_HISTORY_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_PRIORS_HISTORY_FATHER')
																		 );	
///////////////////////Crimwise///////////////////////////
cwdocCreate_SuperFile       := Parallel(
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_DEFENDANT_CW'),
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_OFFENSE_CW'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_CHARGE_CW'),
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_ALIAS_CW'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_SENTENCE_CW'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_PRIOR_CW'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_ADDRESS_HISTORY_CW'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_PHONE_HISTORY_CW'),
																			digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_OTHER_CW')
																	   );
																		 

cwdocCreate_SuperFile_2     := Parallel(
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_DEFENDANT_CW_FATHER'),
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_OFFENSE_CW_FATHER'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_CHARGE_CW_FATHER'),
	                                    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_ALIAS_CW_FATHER'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_SENTENCE_CW_FATHER'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_PRIOR_CW_FATHER'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_ADDRESS_HISTORY_CW_FATHER'),
																	    digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_PHONE_HISTORY_CW_FATHER'),
																			digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::crim::HD::DOC_OTHER_CW_FATHER')
																	   );

cwaocCreate_SuperFile     := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_DEFENDANT_CW_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_OFFENSE_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_CHARGE_CW_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_ALIAS_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_SENTENCE_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_OTHER_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_ADDRESS_HISTORY_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_PHONE_HISTORY_CW_FATHER')
																		 );	
																		 
cwaocCreate_SuperFile_2    := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_DEFENDANT_CW'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_OFFENSE_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_CHARGE_CW'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_ALIAS_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_SENTENCE_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_OTHER_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_ADDRESS_HISTORY_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::AOC_PHONE_HISTORY_CW')
																		 );																			 
cwcounty_Create_SuperFile    := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_DEFENDANT_CW'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_OFFENSE_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_CHARGE_CW'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_ALIAS_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_SENTENCE_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_OTHER_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_ADDRESS_HISTORY_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_PHONE_HISTORY')
																		 );		
																		 
cwcounty_Create_SuperFile_2  := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_DEFENDANT_CW_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_OFFENSE_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_CHARGE_CW_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_ALIAS_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_SENTENCE_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_OTHER_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_ADDRESS_HISTORY_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::COUNTY_PHONE_HISTORY_CW_FATHER')
																		 );		
cwarrestCreate_SuperFile    := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_DEFENDANT_CW'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_OFFENSE_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_CHARGE_CW'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_ALIAS_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_SENTENCE_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_OTHER_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_ADDRESS_HISTORY_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_PHONE_HISTORY_CW'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_PRIORS_HISTORY_CW')
																		 );																			 
cwarrestCreate_SuperFile_2  := Parallel(
		                                 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_DEFENDANT_CW_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_OFFENSE_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_CHARGE_CW_FATHER'),
	                                   digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_ALIAS_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_SENTENCE_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_OTHER_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_ADDRESS_HISTORY_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_PHONE_HISTORY_CW_FATHER'),
																		 digssoff.SuperFile_Functions .Fun_createSuperfile('~thor_200::in::crim::HD::ARREST_PRIORS_HISTORY_CW_FATHER')
																		 );	
																		 
export Create_superfile := sequential(
	                                   docCreate_SuperFile,
																		 aocCreate_SuperFile,
																		 county_Create_SuperFile,
																		 arrestCreate_SuperFile,
																		 docCreate_SuperFile_2,
																		 aocCreate_SuperFile_2,
																		 county_Create_SuperFile_2,
																		 arrestCreate_SuperFile_2,																		 
																		 cwdocCreate_SuperFile,
																		 cwaocCreate_SuperFile,														 
                                     cwcounty_Create_SuperFile,
                                     cwarrestCreate_SuperFile,
                                     cwdocCreate_SuperFile_2,
                                     cwaocCreate_SuperFile_2,
                                     cwcounty_Create_SuperFile_2,
                                     cwarrestCreate_SuperFile_2);