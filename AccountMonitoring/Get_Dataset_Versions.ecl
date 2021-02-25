// This output for this function is the product, subfile name and the version number 
// It also always returns the three (header, quick header & Daily utility) key versions 
// The output can be limited to a particular product or products by passing a product mask in.
// Only when valid despray information passed into the funtion, will files be written, otherwise the
// information is just output to a workunit display.     

EXPORT Get_Dataset_Versions(
	UNSIGNED1 pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT,
	STRING    despray_ip_address = '',  // the IP address of the server receiving the completed file
	STRING    despray_path = '',        // the /path including filename of the destination file
	UNSIGNED8 product_mask = AccountMonitoring.types.productMask.allProducts  // by default everything is returned
	) :=
	FUNCTION
	
		Final_Layout := RECORD
			string25 product;
			string25 subfile;
			string12 version;
		END;
		
		RECURSE := TRUE;

		// Header Keys
		header_key := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_doxie_key_header_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'HEADER_KEY',
				SELF.subfile := '',
				SELF.version := REGEXFIND(
					'thor_data400::key::header::(.*)::data',
					LEFT.name,1,NOCASE)));
		
		quick_header_key := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_quick_header_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'QUICK_HEADER_KEY',
				SELF.subfile := '',
				SELF.version := REGEXFIND(
					'thor_data400::key::headerquick::(.*)::did',
					LEFT.name,1,NOCASE)));
		
		daily_utility_key := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_daily_utility_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'DAILY_UTILITY_KEY',
				SELF.subfile := '',
				SELF.version := REGEXFIND(
					'thor_data400::key::utility::(.*)::daily.did',
					LEFT.name,1,NOCASE)));
		
		header_keys := 
			header_key +
			quick_header_key +
			daily_utility_key;
		
		// Deceased
		Deceased := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.deceased.base_superfilename),
			TRANSFORM(Final_Layout,
				SELF.product := 'DECEASED',
				SELF.subfile := '',
				SELF.version := REGEXFIND(
					AccountMonitoring.product_files.deceased.base_superfilename_raw + '_(.*)$',
					LEFT.name,1,NOCASE)));
		
		// Bankruptcy
		Bankruptcy_Search := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.bankruptcy.search_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'BANKRUPTCY',
				SELF.subfile := 'SEARCH',
				SELF.version := REGEXFIND(
					AccountMonitoring.product_files.bankruptcy.search_filename_raw + '_(.*)$',
					LEFT.name,1,NOCASE)));
		
		Bankruptcy_Main := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.bankruptcy.main_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'BANKRUPTCY',
				SELF.subfile := 'MAIN',
				SELF.version := REGEXFIND(
					AccountMonitoring.product_files.bankruptcy.main_filename_raw + '_(.*)$',
					LEFT.name,1,NOCASE)));
	
		Bankruptcy :=
			Bankruptcy_Search +
			Bankruptcy_Main;
		
		// Address
//		Address_Person_Best := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.address.person_best_filename),
//			TRANSFORM(Final_Layout,
//				SELF.product := 'ADDRESS',
//				SELF.subfile := 'PERSON BEST',
//				SELF.version := REGEXFIND(
//					AccountMonitoring.product_files.address.person_best_filename_raw + '_(.*)$',
//					LEFT.name,1,NOCASE)));
		
		Address_Business_Best := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.address.business_best_filename,RECURSE),
			TRANSFORM(Final_Layout,
				SELF.product := 'ADDRESS',
				SELF.subfile := 'BUSINESS BEST',
				SELF.version := REGEXFIND(
					'base::business_header::(.*)::best$',
					LEFT.name,1,NOCASE)));

		Address_Person_Header := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_doxie_key_header_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'ADDRESS',
				SELF.subfile := 'PERSON HEADER',
				SELF.version := REGEXFIND(
					'key::header(.*)$',
					LEFT.name,1,NOCASE)));
		
		Address_Quick_Header := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_quick_header_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'ADDRESS',
				SELF.subfile := 'QUICK HEADER',
				SELF.version := REGEXFIND(
					'key::headerquick(.*)$',
					LEFT.name,1,NOCASE)));
		
		Address_Daily_Utility := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_daily_utility_superkeyname,RECURSE),
			TRANSFORM(Final_Layout,
				SELF.product := 'ADDRESS',
				SELF.subfile := 'DAILY UTILITY',
				SELF.version := REGEXFIND(
					'key::utility::(.*)::daily_did$',
					LEFT.name,1,NOCASE)));
					
		Address :=
//			Address_Person_Best +
			Address_Business_Best +
			Address_Person_Header +
			Address_Quick_Header +
			Address_Daily_Utility;
		
		// Phone
		Phone_Gong := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phone.gong_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONE',
				SELF.subfile := 'GONG',
				SELF.version := REGEXFIND(
					AccountMonitoring.product_files.phone.gong_filename_nocluster + '(.*)$',
					LEFT.name,1,NOCASE)));
		
		Phone_Plus := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phone.plus_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONE',
				SELF.subfile := 'PLUS',
				SELF.version := REGEXFIND(
					AccountMonitoring.product_files.phone.plus_filename_subfile + '_(.*)$',
					LEFT.name,1,NOCASE)));
		
		Phone_Person_Header := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_doxie_key_header_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONE',
				SELF.subfile := 'PERSON HEADER',
				SELF.version := REGEXFIND(
					'key::header(.*)$',
					LEFT.name,1,NOCASE)));
		
		Phone_Quick_Header := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_quick_header_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONE',
				SELF.subfile := 'QUICK HEADER',
				SELF.version := REGEXFIND(
					'key::headerquick(.*)$',
					LEFT.name,1,NOCASE)));
		
		Phone_Daily_Utility := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_daily_utility_superkeyname,RECURSE),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONE',
				SELF.subfile := 'DAILY UTILITY',
				SELF.version := REGEXFIND(
					'key::utility::(.*)::daily_did$',
					LEFT.name,1,NOCASE)));

		Phone_Person_Best := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phone.person_best_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONE',
				SELF.subfile := 'PERSON BEST',
				SELF.version := REGEXFIND(
					AccountMonitoring.product_files.phone.person_best_filename_raw + '_(.*)$',
					LEFT.name,1,NOCASE)));
		
		Phone_PAW := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.people_at_work.main_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONE',
				SELF.subfile := 'PAW',
				SELF.version := REGEXFIND(
					'base::paw::(.*)::data$',
					LEFT.name,1,NOCASE)));

		Phones_Type := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phone.phones_type_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONE',
				SELF.subfile := 'Phones_type',
				SELF.version := REGEXFIND(
				'thor_data400::key::(.*)::phones_type',
				LEFT.name,1,NOCASE)));

		Phones_Lerg6 := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phone.phones_lerg6_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONE',
				SELF.subfile := 'phones_lerg6',
				SELF.version := REGEXFIND(
				'thor_data400::key::(.*)::phones_lerg6',
				LEFT.name,1,NOCASE)));					

		carrier_reference := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phone.carrier_reference_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONE',
				SELF.subfile := 'carrier_reference',
				SELF.version := REGEXFIND(
				'thor_data400::key::(.*)::phonesmetadata::carrier_reference',
				LEFT.name,1,NOCASE)));

		Phone :=
			Phone_Gong +
			Phone_Plus +
			Phone_Person_Header +
			Phone_Quick_Header +
			Phone_Daily_Utility +
			Phone_Person_Best +
			Phone_PAW +
			Phones_Type+
			Phones_Lerg6+
			carrier_reference;
		
		// Liens

		// Liens--Main
		Liens_Main_HOGAN_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.main_HOGAN_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'MAIN HOGAN',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.main_HOGAN_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Main_ILFDLN_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.main_ILFDLN_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'MAIN ILFDLN',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.main_ILFDLN_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Main_NYC_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.main_NYC_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'MAIN NYC',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.main_NYC_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Main_NYFDLN_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.main_NYFDLN_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'MAIN NYFDLN',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.main_NYFDLN_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Main_SA_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.main_SA_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'MAIN SA',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.main_SA_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Main_chicago_law_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.main_chicago_law_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'MAIN CHICAGO LAW',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.main_chicago_law_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Main_CA_federal_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.main_CA_federal_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'MAIN CA FEDERAL',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.main_CA_federal_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Main_superior_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.main_superior_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'MAIN SUPERIOR',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.main_superior_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Main_MA_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.main_MA_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'MAIN MA',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.main_MA_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		// Liens--Party
		Liens_Party_HOGAN_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.party_HOGAN_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'PARTY HOGAN',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.party_HOGAN_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Party_ILFDLN_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.party_ILFDLN_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'PARTY ILFDLN',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.party_ILFDLN_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Party_NYC_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.party_NYC_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'PARTY NYC',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.party_NYC_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Party_NYFDLN_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.party_NYFDLN_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'PARTY NYFDLN',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.party_NYFDLN_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Party_SA_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.party_SA_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'PARTY SA',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.party_SA_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Party_chicago_law_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.party_chicago_law_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'PARTY CHICAGO LAW',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.party_chicago_law_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Party_CA_federal_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.party_CA_federal_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'PARTY CA FEDERAL',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.party_CA_federal_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Party_superior_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.party_superior_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'PARTY SUPERIOR',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.party_superior_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));

		Liens_Party_MA_file := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.liens.party_MA_filename),
					TRANSFORM(Final_Layout,
						SELF.product := 'LIENS',
						SELF.subfile := 'PARTY MA',
						SELF.version := REGEXFIND(
							AccountMonitoring.product_files.liens.party_MA_filename_raw + '_(.*)$',
							LEFT.name,1,NOCASE)));
						
		Liens :=
			Liens_Main_HOGAN_file + 
			Liens_Main_ILFDLN_file + 
			Liens_Main_NYC_file + 
			Liens_Main_NYFDLN_file + 
			Liens_Main_SA_file + 
			Liens_Main_chicago_law_file + 
			Liens_Main_CA_federal_file + 
			Liens_Main_superior_file + 
			Liens_Main_MA_file + 
			Liens_Party_HOGAN_file + 
			Liens_Party_ILFDLN_file + 
			Liens_Party_NYC_file + 
			Liens_Party_NYFDLN_file + 
			Liens_Party_SA_file + 
			Liens_Party_chicago_law_file + 
			Liens_Party_CA_federal_file + 
			Liens_Party_superior_file + 
			Liens_Party_MA_file;
		
		// Criminal 
		Criminal_Offenders := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.criminal.offender_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'CRIMINAL',
				SELF.subfile := 'OFFENDERS',
				SELF.version := REGEXFIND(
					'base::corrections_offenders_public_(.*)$',
					LEFT.name,1,NOCASE)));


		Criminal_Offenses := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.criminal.offenses_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'CRIMINAL',
				SELF.subfile := 'OFFENSES',
				SELF.version := REGEXFIND(
					'base::corrections_offenses_public_(.*)$',
					LEFT.name,1,NOCASE)));


		Criminal_Punishments := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.criminal.punishments_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'CRIMINAL',
				SELF.subfile := 'PUNISHMENTS',
				SELF.version := REGEXFIND(
					'base::corrections_punishment_public_(.*)$',
					LEFT.name,1,NOCASE)));

		Criminal :=
			Criminal_Offenders + 
			Criminal_Offenses + 
			Criminal_Punishments;
			
		// Property
		Property_Search := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.property.Property_search_superkey_monitor),
			TRANSFORM(Final_Layout,
				SELF.product := 'PROPERTY',
				SELF.subfile := 'SEARCH',
				SELF.version := REGEXFIND(
					'thor_data400::key::ln_propertyv2::(.*)::search.fid',
					LEFT.name,1,NOCASE)));

		Property_Deeds := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.property.Property_deed_superkey_monitor),
			TRANSFORM(Final_Layout,
				SELF.product := 'PROPERTY',
				SELF.subfile := 'DEEDS',
				SELF.version := REGEXFIND(
					'thor_data400::key::ln_propertyv2::(.*)::addlfaresdeed.fid',
					LEFT.name,1,NOCASE)));
	
		Property_SearchLinkid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.property.Property_SearchLinkid_superkey_monitor),
			TRANSFORM(Final_Layout,
				SELF.product := 'PROPERTY',
				SELF.subfile := 'LINKID',
				SELF.version := REGEXFIND(
					'thor_data400::key::ln_propertyv2::(.*)::search.linkids',
					LEFT.name,1,NOCASE)));
					
		Property :=
			Property_Search +
			Property_Deeds  +
			Property_SearchLinkid;
			
		// PAW
		PAW := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.people_at_work.main_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'PAW',
				SELF.subfile := '',
				SELF.version := REGEXFIND(
					'base::paw::(.*)::data$',
					LEFT.name,1,NOCASE)));

		// Possible Litigious Debtors
		PossLitDebt := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.litigiousdebtor.litigiousdebtor_superkey),
			TRANSFORM(Final_Layout,
				SELF.product := 'POSSLITDEBT',
				SELF.subfile := '',
				SELF.version := REGEXFIND(
					'thor_data400::key::courtlink::(.*)::courtid_docket',
					LEFT.name,1,NOCASE)));
		
		// Phones Feedback
		PhoneFeedback := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phonefeedback.PhonesFeedback_superkey),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONEFEEDBACK',
				SELF.subfile := '',
			SELF.version := REGEXFIND(
					'thor_data400::key::phonesFeedback::(.*)::phone',
					LEFT.name,1,NOCASE)));

		// Foreclosure
		Foreclosure := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.foreclosure.base_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'FORECLOSURE',
				SELF.subfile := '',
				SELF.version := REGEXFIND(
					AccountMonitoring.product_files.foreclosure.base_filename_raw + '_(.*)$',
					LEFT.name,1,NOCASE)));
					
		// Workplace
		Workplace := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.workplace.base_filename),
			TRANSFORM(Final_Layout,
				SELF.product := 'WORKPLACE',
				SELF.subfile := '',
				SELF.version := REGEXFIND(
					'base::poe::(.*)::data$',
					LEFT.name,1,NOCASE)));
		
		// DIDUpdate
		rid_did_key := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_doxie_key_rid_did_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'DIDUPDATE',
				SELF.subfile := 'RID_DID',
				SELF.version := REGEXFIND(
					'thor_data400::key::header::(.*)::rid_did',
					LEFT.name,1,NOCASE)));
		
		rid_did_split_key := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_doxie_key_rid_did_split_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'DIDUPDATE',
				SELF.subfile := 'RID_DID_SPLIT',
				SELF.version := REGEXFIND(
					'thor_data400::key::header::(.*)::rid_did_split',
					LEFT.name,1,NOCASE)));
		
		DIDUpdate := 
			rid_did_key +
			rid_did_split_key;
			
		// BDIDUpdate
		BDIDUpdate := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_business_header_rcid_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'BDIDUPDATE',
				SELF.subfile := '',
				SELF.version := REGEXFIND(
					'thor_data400::key::business_header::(.*)::search::rcid',
					LEFT.name,1,NOCASE)));
		
		// Phone Ownership

		Phones_transaction := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phoneownership.phones_transaction_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONEOWNERSHIP',
				SELF.subfile := 'phones_transaction',
				SELF.version := REGEXFIND(
				'thor_data400::key::(.*)::phones_transaction',
				LEFT.name,1,NOCASE)));	

		PPhones_Type := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phone.phones_type_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONEOWNERSHIP',
				SELF.subfile := 'Phones_type',
				SELF.version := REGEXFIND(
				'thor_data400::key::(.*)::phones_type',
				LEFT.name,1,NOCASE)));

		PPhones_Lerg6 := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phone.phones_lerg6_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONEOWNERSHIP',
				SELF.subfile := 'phones_lerg6',
				SELF.version := REGEXFIND(
				'thor_data400::key::(.*)::phones_lerg6',
				LEFT.name,1,NOCASE)));

		pcarrier_reference := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.phone.carrier_reference_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONEOWNERSHIP',
				SELF.subfile := 'carrier_reference',
				SELF.version := REGEXFIND(
				'thor_data400::key::(.*)::phonesmetadata::carrier_reference',
				LEFT.name,1,NOCASE)));

		Phones_WDNC := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.PhoneOwnership.phones_WDNC_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'PHONEOWNERSHIP',
				SELF.subfile := 'Phone_TCPA',
				SELF.version := REGEXFIND(
				'thor_data400::key::tcpa::(.*)::phone_history',
				LEFT.name,1,NOCASE)));



		PhoneOwnership := 
		PPhones_Type +
		PPhones_Lerg6 +
		Phones_transaction +
		pcarrier_reference +
		Phones_WDNC;


		
		// BipBest Update
		BipBestUpdate := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.header_files.r_bipbest_header_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'BIPBESTUPDATE',
				SELF.subfile := '',
				SELF.version := REGEXFIND(
					'thor_data400::key::bipv2_best::(.*)::linkids',
					LEFT.name,1,NOCASE)));
		
		// SBFE
		Sbfe_Linkid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.sbfe.r_sbfeLinkid_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'SBFE',
				SELF.subfile := 'LINKID',
				SELF.version := REGEXFIND(
					'thor_data400::key::sbfe::(.*)::linkids',
					LEFT.name,1,NOCASE)));
					
		Sbfe_Trade := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.sbfe.r_sbfeTrade_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'SBFE',
				SELF.subfile := 'TRADE',
				SELF.version := REGEXFIND(
					'thor_data400::key::sbfe::(.*)::tradeline',
					LEFT.name,1,NOCASE)));
		
		Sbfe_Score := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.sbfe.r_sbfeScore_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'SBFE',
				SELF.subfile := 'SCORE',
				SELF.version := REGEXFIND(
					'thor_data400::key::sbfescoring::(.*)::scoringindex',
					LEFT.name,1,NOCASE)));
		
		SBFE :=
			Sbfe_Linkid + 
			Sbfe_Trade + 
			Sbfe_Score;
		
		// UCC
		Ucc_Linkid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.ucc.uccLinkid_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'UCC',
				SELF.subfile := 'LINKID',
				SELF.version := REGEXFIND(
					'thor_data400::key::ucc::(.*)::linkids',
					LEFT.name,1,NOCASE)));
					
		Ucc_Main := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.ucc.uccMain_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'UCC',
				SELF.subfile := 'MAIN',
				SELF.version := REGEXFIND(
					'thor_data400::key::ucc::(.*)::main_rmsid',
					LEFT.name,1,NOCASE)));
		
		UCC :=
			Ucc_Linkid + 
			Ucc_Main; 
		
		// Govt Debarred
		govtdebarred_Linkid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.govtdebarred.govtLinkid_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'GOVTDEBARRED',
				SELF.subfile := 'LINKID',
				SELF.version := REGEXFIND(
					'thor_data400::key::sam::(.*)::linkids',
					LEFT.name,1,NOCASE)));
			
		govtDebarred := govtdebarred_Linkid;
		
		// Inquiry
		Inquiry_Linkid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.inquiry.inquiryLinkid_superkey),
			TRANSFORM(Final_Layout,
				SELF.product := 'INQUIRY',
				SELF.subfile := 'LINKID',
				SELF.version := REGEXFIND(
					'thor_data400::key::inquiry::(.*)::linkids',
					LEFT.name,1,NOCASE)));
					
		InquiryUpdate_Linkid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.inquiry.inquiryUpdLinkid_superkey),
			TRANSFORM(Final_Layout,
				SELF.product := 'INQUIRY',
				SELF.subfile := 'LINKID_UPDATE',
				SELF.version := REGEXFIND(
					'thor_data400::key::inquiry::(.*)::linkids_update',
					LEFT.name,1,NOCASE)));
		
		Inquiry :=
			Inquiry_Linkid + 
			InquiryUpdate_Linkid; 
		
		// Corp
		Corp_Linkid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.corp.corpLinkid_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'CORP',
				SELF.subfile := 'LINKID',
				SELF.version := REGEXFIND(
					'thor_data400::key::corp2::(.*)::corp::linkids',
					LEFT.name,1,NOCASE)));
					
		Corp_corpKey := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.corp.corpKey_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'CORP',
				SELF.subfile := 'CORP_KEY',
				SELF.version := REGEXFIND(
					'thor_data400::key::corp2::(.*)::corp::corp_key.record_type',
					LEFT.name,1,NOCASE)));
		
		Corp :=
			Corp_Linkid + 
			Corp_corpKey; 
		
		// Mvr
		Mvr_Linkid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.mvr.mvrLinkid_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'MVR',
				SELF.subfile := 'LINKID',
				SELF.version := REGEXFIND(
					'thor_data400::key::vehiclev2::(.*)::linkids',
					LEFT.name,1,NOCASE)));
					
		Mvr_MainKey := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.mvr.main_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'MVR',
				SELF.subfile := 'MAIN_KEY',
				SELF.version := REGEXFIND(
					'thor_data400::key::vehiclev2::(.*)::main_key',
					LEFT.name,1,NOCASE)));
		
		Mvr :=
			Mvr_Linkid + 
			Mvr_MainKey; 
		
		// Aircraft
		aircraft_Linkid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.aircraft.airLinkid_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'AIRCRAFT',
				SELF.subfile := 'LINKID',
				SELF.version := REGEXFIND(
					'thor_data400::key::faa::(.*)::aircraft_linkids',
					LEFT.name,1,NOCASE)));
		
		aircraft := aircraft_Linkid;
		
		// watercraft
		watercraft_Linkid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.watercraft.waterLinkid_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'WATRERCRAFT',
				SELF.subfile := 'LINKID',
				SELF.version := REGEXFIND(
					'thor_data400::key::watercraft::(.*)::linkids',
					LEFT.name,1,NOCASE)));
			
		watercraft := watercraft_Linkid;
		
		// email
		email_Lexid := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.email.emailLexid_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'EMAIL',
				SELF.subfile := 'LEXID',
				SELF.version := REGEXFIND(
					'thor_200::key::email_datav2::(.*)::did',
					LEFT.name,1,NOCASE)));
			
		email_addr := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.email.emailaddr_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'EMAIL',
				SELF.subfile := 'EMAILADDR',
				SELF.version := REGEXFIND(
					'thor_200::key::email_datav2::(.*)::email_addresses',
					LEFT.name,1,NOCASE)));
			
		email_main := PROJECT(FileServices.SuperFileContents(AccountMonitoring.product_files.email.emailmain_superkeyname),
			TRANSFORM(Final_Layout,
				SELF.product := 'EMAIL',
				SELF.subfile := 'MAIN',
				SELF.version := REGEXFIND(
					'thor_200::key::email_datav2::(.*)::payload',
					LEFT.name,1,NOCASE)));
			
		email_lf := email_Lexid + email_addr + email_main;
		
		All_Records :=
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_address)
					OR
					AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_reverseaddress), header_keys ) +
      IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_bankruptcy), Bankruptcy ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_deceased), Deceased ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_phone), Phone ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_address), Address ) +  
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_paw), PAW ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_property), Property ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_litigiousdebtor), PossLitDebt ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_liens), Liens ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_criminal), Criminal ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_phoneFeedback), PhoneFeedback ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_foreclosure), Foreclosure ) +
      IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_workplace), Workplace ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_didupdate), DIDUpdate ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_bdidupdate), BDIDUpdate ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_phoneownership), PhoneOwnership ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_bipbestupdate), BipBestUpdate ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_sbfe), SBFE ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_ucc), UCC ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_govtdebarred), govtDebarred ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_inquiry), Inquiry ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_corp), Corp ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_mvr), Mvr ) +
			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_aircraft), Aircraft ) +
      // watercraft?  
      // Header might needed to be added here once all the CGMs start using the roxie-version of the superkey as created by updateSuperfiles

			IF( AccountMonitoring.types.testPMBits (product_mask, AccountMonitoring.Constants.pm_email), email_lf );
			
 		valid_despray_criteria := despray_ip_address != '' AND despray_path != '';
		ALLOW_OVERWRITE        := TRUE;
		superfile_stem_name    := AccountMonitoring.constants.filename_cluster + 'base::Account_Monitoring::' + AccountMonitoring.constants.pseudo_ext(pseudo_environment) + 'versions';
		logical_file_name      := superfile_stem_name + thorlib.wuid();

      save_file := OUTPUT(All_Records,,logical_file_name,CSV(HEADING(1),SEPARATOR('|'),TERMINATOR('\n')),OVERWRITE);
		
		despray_file  := FileServices.DeSpray(logical_file_name, despray_ip_address, despray_path, -1, , , ALLOW_OVERWRITE);

		delete_file := FileServices.DeleteLogicalFile(logical_file_name);

		RETURN SEQUENTIAL(
			IF( pseudo_environment = AccountMonitoring.constants.pseudo.DEFAULT or pseudo_environment not in AccountMonitoring.constants.all_pseudo,
					FAIL('Must provide valid pseudo-environment.') ),
			IF( NOT valid_despray_criteria, // which would be the case for debug/testing
					OUTPUT( All_Records, ALL ), // just display results
					SEQUENTIAL( // otherwise it's production; write to file
						save_file,
						despray_file,
						delete_file
					)
				)
			);
			
	END;
	
