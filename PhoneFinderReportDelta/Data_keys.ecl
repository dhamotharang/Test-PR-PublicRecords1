IMPORT Std, $;

EXPORT Data_keys(STRING version  = (STRING8)Std.Date.Today(), BOOLEAN pIsDeltaBuild = FALSE) := MODULE

	//DF-27859:DELTA UPDATES
	//THE KEY IS NOW BUILT DIRECTLY FROM A BASE FILE, INSTEAD OF FROM THE INPUT FILE.	
	//DELTA KEYS BY FILTERING ON DATE_FILE_LOADED	
	
	Identities_Main      			:= $.File_PhoneFinder.Identities_Main;
	Identities_Delta     			:= Identities_Main(date_file_loaded = version[1..8]);
															
	EXPORT i_Identities 			:= IF(pIsDeltaBuild, Identities_Delta, Identities_Main);
	EXPORT i_Identities_LexId := i_Identities((unsigned)lexid != 0);

	OtherPhones_Main     			:= $.File_PhoneFinder.OtherPhones_Main;
	OtherPhones_Delta     		:= OtherPhones_Main(date_file_loaded = version[1..8]);

	EXPORT i_OtherPhones 			:= IF(pIsDeltaBuild, OtherPhones_Delta, OtherPhones_Main);

	RiskIndicators_Main   		:= $.File_PhoneFinder.RiskIndicators_Main;
	RiskIndicators_Delta  		:= RiskIndicators_Main(date_file_loaded = version[1..8]);

	EXPORT i_RiskIndicators 	:= IF(pIsDeltaBuild, RiskIndicators_Delta, RiskIndicators_Main);

	Transactions_Main     		:= $.File_PhoneFinder.Transactions_Main;
	Transactions_Delta    		:= Transactions_Main(date_file_loaded = version[1..8]);

	EXPORT i_Transactions                 := IF(pIsDeltaBuild, Transactions_Delta, Transactions_Main);
	EXPORT i_Transactions_Phone           := i_Transactions(phonenumber != '');
	EXPORT i_Transactions_CompanyId       := i_Transactions(company_id != '');
	EXPORT i_Transactions_UserId          := i_Transactions(user_id != '');
	EXPORT i_Transactions_CompanyRefCode  := i_Transactions(~(company_id = '' and reference_code = ''));
	EXPORT i_Transactions_RefCode         := i_Transactions(reference_code != '');
	
	Sources_Main      				:= $.File_PhoneFinder.Sources_Main;
	Sources_Delta     				:= Sources_Main(date_file_loaded = version[1..8]);

	EXPORT i_Sources 					:= IF(pIsDeltaBuild, Sources_Delta, Sources_Main);	
		
END;