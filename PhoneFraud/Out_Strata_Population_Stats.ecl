EXPORT Out_Strata_Population_Stats (pOTP    	// OTP File
																		,pSpoof   // Spoofing File
																		,pVersion // Version of Strat Stats
																		,zOut)    // Output of Population Stats
:= MACRO

IMPORT Strata;

	#uniquename(dPopulationStats_pOTP);
	#uniquename(zRunOTPStats);
	
	#uniquename(dPopulationStats_pSpoof);
	#uniquename(zRunSpoofStats);
	
	//OTP File Population Stats	
	%dPopulationStats_pOTP% := strata.macf_pops(pOTP,
																							'otp_type',
																							,
																							,
																							,
																							,
																							TRUE,
																							['otp_type']);	// remove these fields from population stats
	
	strata.createXMLStats(%dPopulationStats_pOTP%, 'PhoneFraud', 'OTP', pVersion, 'Population', %zRunOTPStats%);

	//Spoofing File Population Stats
	%dPopulationStats_pSpoof% := strata.macf_pops(pSpoof,
																								'vendor,phone_origin',
																								,
																								,
																								,
																								,
																								TRUE,
																								['phone_origin','spoofed_phone_number','destination_number','source_phone_number','vendor','user_added','date_changed','user_changed']);	// remove these fields from population stats																		
		
	strata.createXMLStats(%dPopulationStats_pSpoof%, 'PhoneFraud', 'Spoofing', pVersion, 'Population', %zRunSpoofStats%);
	
	zOut := parallel(%zRunOTPStats%, %zRunSpoofStats%);
	
ENDMACRO;