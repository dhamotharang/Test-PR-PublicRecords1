import MDR;

export WorkPlace_Constants := module

	export Limits := module
	  export unsigned2 DID_LIMIT            := 1;
	  export unsigned1 KEEP_LIMIT           := 1;
    export unsigned4 JOIN_LIMIT           := 10000;
    export unsigned4 KEYED_JOIN_UNLIMITED := 0;
	  export unsigned1 KEEP_HIST            := 4;
	  export unsigned1 KEEP_EMAIL           := 3;
	end;

 // A set of all the royalty source codes.
 export WP_ROYALTY_SOURCE_SET := [MDR.sourceTools.src_One_Click_Data, 
	                                 MDR.sourceTools.src_Teletrack,
																	 MDR.sourceTools.src_SalesChannel,
																	 MDR.sourceTools.src_Thrive_LT,
		                               MDR.sourceTools.src_Thrive_PD
																 ];

  // For use when joining to corp key file Current records.
	export string1 CURRENT := 'C';

  // For use when retreiving parent company info from DCA
	export integer DCA_RETREIVE_PARENT := 1;

  // For use when determining the "best candidate" from all recs within a 14 day window of dates
  export integer1 DAYS_WINDOW := 14;
	
	// PSS (Accutrac Phone Status Service) constants
	export	unsigned1				PSS_DAYS_WINDOW		:=	30;
	export	set	of	string	PSS_PHONE_STATUS	:=	['A'];

  // For use when retreiving records from the gong history bdid kety file
	export string1 GONG_HIST_BUSINESS := 'B';
	export string1 GONG_HIST_CURRENT  := 'Y';
	
  //  A set of observed invalid company_name values to be removed
	export INVALID_COMPANY_NAMES_SET := [
																			 'NA',
  	                                   'N/A',
  	                                   'NONE',
  	                                   'NOT APPLICABLE'
  	                                   ];
																	
	//  A set of names to return if the option to return self-reported income is TRUE
	EXPORT SELF_REP_COMPANY_NAMES_SET := [
                                       'BENEFITS',
	                                     'BENEFITS SOCIAL SECURITY',
																			 'DISABLED',
																			 'DISABILITY',
																			 'LOCAL',
																			 'NO EMPLOYMENT INFO GIVEN',
  	                                   'RETIRED',
  	                                   'RETIRED FEDERAL GOVE',
  	                                   'RETIRED FEDERAL GOVERMENT',
  	                                   'RETIRED FEDERAL GOVERNMENT', //not in new list?
  	                                   'SOC SEC',
  	                                   'SOCIAL SECURITY',
																			 'SOCIAL SECURITY DISA', 
   	                                   'SOCIALSECURITY',
																			 'S.S.',
																			 'SS DISABILIT',
	                                     'SS DISABILITY',
	                                     'SSI',
																			 'SSI/DISABILITY',
	                                     'UNEMPLOYED',
	                                     'UNEMPLOYED DISABLED',
																			 'UNEMPLOYED DISABILIT',
																			 'UNEMPLOYED_DISABILIT',
	                                     'UNEMPLOYMENT'];
																			 																					
	PERSONAL_EMAIL_DOMAIN_SET := DATASET([{'GMAIL.COM'},
																				{'AOL.COM'},
																				{'HOTMAIL.COM'},
																				{'YAHOO.COM'},
																				{'MAIL.COM'},
																				{'OUTLOOK.COM'},
																				{'ICLOUD.COM'},
																				{'INBOX.COM'},
																				{'ZOHO.COM'},
																				{'PROTONMAIL.COM'},
																				{'COMCAST.NET'},
																				{'LIVE.COM'},
																				{'COX.NET'},
																				{'VERIZON.NET'},
																				{'GOOGLEMAIL.COM'},
																				{'ATT.NET'},
																				{'FACEBOOK.COM'},
																				{'EARTHLINK.NET'},
																				{'SKY.COM'},
																				{'CHARTER.NET'},
																				{'JUNO.COM'},
																				{'MAC.COM'},
																				{'REDIFFMAIL.COM'},
																				{'YMAIL.COM'},
																				{'SBCGLOBAL.NET'},
																				{'ROCKETMAIL.COM'},
																				{'FRONTIERNET.NET'},
																				{'ME.COM'},
																				{'BELLSOUTH.NET'},
																				{'PRODIGY.NET'},
																				{'PEOPLEPC.COM'},
																				{'MINDSPRING.COM'}], {STRING domain});

	EXPORT PERSONAL_EMAIL_DOMAIN_DCT  := DICTIONARY(PERSONAL_EMAIL_DOMAIN_SET,{domain});
	
	EXPORT UNSIGNED1 DEFAULT_SOURCE_ORDER:=255;
																			 
end;
