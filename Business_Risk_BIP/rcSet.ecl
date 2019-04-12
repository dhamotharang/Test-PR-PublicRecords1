IMPORT Business_Risk_BIP, models, STD, ut;

todays_date := (STRING)STD.Date.Today ();

EXPORT rcSet(Business_Risk_BIP.Layouts.Shell le, BOOLEAN useSBFE = FALSE, STRING4 bvi_desc_key = '0') := MODULE

	SHARED pop_bus_name                  := (INTEGER)le.Input.InputCheckBusName;
	SHARED pop_bus_altname               := (INTEGER)le.Input.InputCheckBusAltName;
	SHARED pop_bus_addr                  := (INTEGER)le.Input.InputCheckBusAddr;
	SHARED pop_bus_city                  := (INTEGER)le.Input.InputCheckBusCity;
	SHARED pop_bus_state                 := (INTEGER)le.Input.InputCheckBusState;
	SHARED pop_bus_zip                   := (INTEGER)le.Input.InputCheckBusZip;
	SHARED pop_bus_fein                  := (INTEGER)le.Input.InputCheckBusFEIN;
	SHARED pop_bus_phone                 := (INTEGER)le.Input.InputCheckBusPhone;
	
	SHARED name_input_watchlist          := (INTEGER)le.Verification.VerWatchlistNameMatch;
	SHARED altnm_input_watchlist         := (INTEGER)le.Verification.VerWatchlistAltNameMatch;
	
	SHARED bankruptcy_chapter            := (INTEGER)le.Bankruptcy.BankruptcyChapter;
	
	SHARED sos_standing                  := (INTEGER)le.SOS.SOSStanding;
	SHARED sos_inc_filing_count          := (INTEGER)le.SOS.SOSIncorporationCount;
	SHARED sos_state_input_match         := (INTEGER)le.SOS.SOSIncorporationStateInput;

	SHARED fein_input_contradictory_in   := (INTEGER)le.Verification.FEINAddrNameMismatch;
	SHARED fein_on_file                  := (INTEGER)le.Verification.FEINOnFile;
	
	SHARED ver_fein_src_count            := (INTEGER)le.Verification.FEINMatchSourceCount;
	SHARED ver_name_src_count            := (INTEGER)le.Verification.NameMatchSourceCount;
	SHARED ver_altnm_src_count           := (INTEGER)le.Verification.AltNameMatchSourceCount;
	SHARED ver_addr_src_count            := (INTEGER)le.Verification.AddrVerificationSourceCount;
	
	SHARED sbfe_name_input_mth_since_fs  := (INTEGER)le.SBFE.SBFENameMatchMonthsFirstSeen;
	SHARED sbfe_altnm_input_mth_since_fs := (INTEGER)le.SBFE.SBFEAltNameMatchMonthsFirstSeen;
	
	SHARED ver_src_id_mth_since_fs       := (INTEGER)le.Business_Activity.SourceBusinessRecordTimeOldestID;
	SHARED ver_src_id_mth_since_ls       := (INTEGER)le.Business_Activity.SourceBusinessRecordTimeNewestID;
	SHARED sbfe_mth_since_fs             := (INTEGER)le.SBFE.SBFETimeOldestCycle;
	SHARED sbfe_mth_since_ls             := (INTEGER)le.SBFE.SBFETimeNewestCycle;
	
	SHARED addr_input_not_most_recent    := (INTEGER)le.Verification.InputAddrNotMostRecent;
	SHARED addr_input_zipcode_mismatch   := (INTEGER)le.Verification.AddrZipMismatch;
	SHARED addr_input_vacancy            := le.Verification.InputAddrVacancyNoID;       // alpha character
	SHARED addr_input_type_advo          := le.Input_Characteristics.InputAddrTypeNoID; // alpha character
	
	SHARED phn_input_disconnected        := (INTEGER)le.Verification.phonedisconnected;
	SHARED phn_input_contradictory       := (INTEGER)le.Verification.PhoneNameMismatch;
	SHARED phn_input_type                := (INTEGER)le.Input_Characteristics.InputPhoneMobile;
	SHARED phn_input_residential         := (INTEGER)le.Verification.PhoneResidential;
	SHARED phn_input_distance_addr       := (INTEGER)le.Verification.PhoneDistance;
	SHARED ver_phn_src_count             := (INTEGER)le.Verification.PhoneMatchSourceCount;
	SHARED ver_phn_src_id_count          := (INTEGER)le.Verification.PhoneMatchSourceCountID;
	
	SHARED addr_input_pobox              := (INTEGER)le.Verification.AddrPOBox;
	SHARED addr_input_zipcode_type       := (INTEGER)le.Verification.AddrZipType;
		
	SHARED vel_proxid_per_seleid         := (INTEGER)le.Organizational_Structure.OrgLocationCount;
	SHARED gov_debarred                  := (INTEGER)le.Public_Record.GovernmentDebarred;
	
	SHARED addr_input_valid              := (INTEGER)le.Verification.InputAddrValidNoID;
	SHARED phn_input_valid               := (INTEGER)le.Verification.InputPhoneValidNoID;
	SHARED fein_input_valid              := (INTEGER)le.Verification.InputFEINValidNoID;
	
	SHARED altnm_input_match_in_bus_name := (INTEGER)le.Verification.AltNameMatchName;

	SHARED name_input_miskey             := (INTEGER)le.Verification.VerNameMiskey;
	SHARED altnm_input_miskey            := (INTEGER)le.Verification.VerAltNameMiskey;
	SHARED addr_input_miskey             := (INTEGER)le.Verification.AddrMiskey;
	SHARED phn_input_miskey              := (INTEGER)le.Verification.PhoneInputMiskey;
	SHARED fein_input_miskey             := (INTEGER)le.Verification.FEINInputMiskey;

	SHARED l_bvi_desc_key                := bvi_desc_key;
	
	SHARED BOOLEAN hri_nam := ( pop_bus_name = 1 OR pop_bus_altname = 1 ) AND l_bvi_desc_key IN [ 
			'417','416','414','413','412','411','403','402',
			'323','322','313','312','311',
			'223','222','204','202','201',
			'124','122','121','102',
			'000','0' ];

	SHARED BOOLEAN hri_add := pop_bus_addr = 1 AND l_bvi_desc_key IN [
			'419','418','415','414','412','411','405','404','401',
			'325','324','321','313','311',
			'223','221','204','203','201',
			'124','123','121','102',
			'000','0' ];

	SHARED BOOLEAN hri_phn := pop_bus_phone = 1 AND l_bvi_desc_key IN [
			'523','521',
			'421','418','416','412','411','404','402',
			'324','322','311',
			'221','204','203','202',
			'124','123','122','102',
			'000','0' ];
	
	SHARED BOOLEAN hri_tin := pop_bus_fein = 1 AND l_bvi_desc_key IN [
			'522','521',
			'421','415','413','412','411','401',
			'321','312','311',
			'222','221','203','202','201',
			'123','122','121','102',
			'000','0' ];
	
	SHARED BOOLEAN hri_none := hri_nam AND hri_add AND hri_phn AND hri_tin;

	SHARED hri_nam_prm := 
		IF( useSBFE, 
			IF( pop_bus_name = 1 AND ver_name_src_count <= 0 AND sbfe_name_input_mth_since_fs <= 0, 1, 0 ),
			IF( pop_bus_name = 1 AND ver_name_src_count <= 0, 1, 0 )
		);
		
	SHARED hri_nam_alt := 
		IF( useSBFE, 
			IF( pop_bus_altname = 1 AND ver_altnm_src_count <= 0 AND sbfe_altnm_input_mth_since_fs <= 0, 1, 0 ),
			IF( pop_bus_altname = 1 AND ver_altnm_src_count <= 0, 1, 0 )
		);

	// =================================================================
	
	// The input business name matches OFAC file.
	EXPORT isCode10 := 
		(pop_bus_name = 1 AND name_input_watchlist IN [2,3]) OR
		(pop_bus_altname = 1 AND altnm_input_watchlist IN [2,3]);

	// The input business name matches non-OFAC global watchlist(s).
	EXPORT isCode11 := 
		(pop_bus_name = 1 AND name_input_watchlist IN [1,3]) OR
		(pop_bus_altname = 1 AND altnm_input_watchlist IN [1,3]);
  
	// Bankruptcy on record suggests the business may be defunct.	
	EXPORT isCode12 := bankruptcy_chapter IN [7,13];

	// Business not in good standing according to Secretary of State.
	EXPORT isCode13 := sos_standing = 1;

	// Business inactive according to Secretary of State.
	EXPORT isCode14 := sos_standing = 2;

	// Business is not registered at Secretary of State of input business state.
	EXPORT isCode15 := pop_bus_state = 1 AND sos_inc_filing_count > 0 AND sos_state_input_match = 0;
	
	// The input business TIN is associated with a different business name and address.
	EXPORT isCode16 := 
		pop_bus_name = 1 AND pop_bus_addr = 1 AND pop_bus_fein = 1 AND fein_input_contradictory_in = 4 AND 
		( ver_fein_src_count < 1 OR ( ver_name_src_count < 1 AND ver_altnm_src_count < 1 AND ver_addr_src_count < 1 ) );

	// Unable to verify business name, address, TIN and phone on business records.
	EXPORT isCode17 := hri_none;
	
	// Unable to verify business name on business records, but alternate business name found in business records.
	EXPORT isCode18 := NOT hri_nam AND hri_nam_prm = 1 AND hri_nam_alt = 0 AND pop_bus_altname = 1;
	
	// Unable to verify business name on business records.
	EXPORT isCode19 := hri_nam AND NOT isCode17;

	// Unable to verify business address on business records.
	EXPORT isCode20 := hri_add AND NOT isCode17;
	
	// Unable to verify business TIN on business records.
	EXPORT isCode21 := hri_tin AND NOT isCode17;

	// Unable to verify business phone number on business records.
	EXPORT isCode22 := hri_phn AND NOT isCode17;

	// Business first reported in last 12 months.
	EXPORT isCode23 := 
		IF( useSBFE,
			( ((INTEGER)ver_src_id_mth_since_fs BETWEEN 0 AND 12) AND ((INTEGER)sbfe_mth_since_fs BETWEEN 0 AND 12) ) OR 
			( ((INTEGER)ver_src_id_mth_since_fs BETWEEN 0 AND 12) AND sbfe_mth_since_fs = -99 ) OR
			( ver_src_id_mth_since_fs = -1 AND ((INTEGER)sbfe_mth_since_fs BETWEEN 0 AND 12) ),
			// else
			((INTEGER)ver_src_id_mth_since_fs BETWEEN 0 AND 12) );

	// Business first reported in last 24 months.
	EXPORT isCode24 := 
		IF( useSBFE,
			( ((INTEGER)ver_src_id_mth_since_fs BETWEEN 0 AND 24) AND ((INTEGER)sbfe_mth_since_fs BETWEEN 0 AND 24) ) OR 
			( ((INTEGER)ver_src_id_mth_since_fs BETWEEN 0 AND 24) AND sbfe_mth_since_fs = -99 ) OR
			( ver_src_id_mth_since_fs = -1 AND ((INTEGER)sbfe_mth_since_fs BETWEEN 0 AND 24) ),
			// else
			((INTEGER)ver_src_id_mth_since_fs BETWEEN 0 AND 24) );

	// The input business address may be a previous address.
	EXPORT isCode25 := pop_bus_addr = 1 and addr_input_not_most_recent = 1;

	// Address mismatch between the input business city/state and zip code.
	EXPORT isCode26 := pop_bus_city = 1 and pop_bus_state = 1 and pop_bus_zip = 1 and addr_input_zipcode_mismatch = 1;

	// The input business address is a vacant address.
	EXPORT isCode27 := pop_bus_addr = 1 and addr_input_vacancy = 'Y';
	
	// The input business phone number may be disconnected.
  EXPORT isCode28 := pop_bus_phone = 1 and phn_input_disconnected = 1;
	
	// The input phone number is associated with a different name and address.
	EXPORT isCode29 := 
			pop_bus_name = 1 AND pop_bus_addr = 1 AND pop_bus_phone = 1 AND phn_input_contradictory = 4 AND 
			( 
				( ver_phn_src_count < 1 AND ver_phn_src_id_count < 1 ) OR 
				( ver_name_src_count < 1 AND ver_altnm_src_count < 1 AND ver_addr_src_count < 1 ) 
			);
	
	// The input business may be associated with a post office box.
	EXPORT isCode30 := ( pop_bus_addr = 1 AND addr_input_pobox = 1 ) OR ( pop_bus_zip = 1 AND addr_input_zipcode_type = 1 );
	
	// The input business phone number is a mobile number.
	EXPORT isCode31 := pop_bus_phone = 1 and phn_input_type = 1;

	// The input business zip code has a prison within the zip code area.
	EXPORT isCode32 := pop_bus_zip = 1 and addr_input_zipcode_type = 3;
	
	// The input business zip code is a military only zip code.
	EXPORT isCode33 := pop_bus_zip = 1 and addr_input_zipcode_type = 2;

	// The input business address may be a residential address (single family dwelling).
	EXPORT isCode34 := pop_bus_addr = 1 and addr_input_type_advo = 'A';
	
	// The input business phone number may be associated with a residential listing.
	EXPORT isCode35 := pop_bus_phone = 1 and phn_input_residential = 1;
	
	// The input business phone number and business address on record are geographically 
	// distant (greater than 10 miles).
	EXPORT isCode36 := pop_bus_phone = 1 and phn_input_distance_addr > 10;
	
	// The input business TIN is not found.
	EXPORT isCode37 := pop_bus_fein = 1 and fein_on_file = 0;
	
	EXPORT isCode38 := // No updates to business record in the past 36 months.
		IF( useSBFE,
			( ver_src_id_mth_since_ls > 36 AND sbfe_mth_since_ls > 36 ) OR
			( ver_src_id_mth_since_ls > 36 AND sbfe_mth_since_ls = -99 ) OR             
			( ver_src_id_mth_since_ls = -1 AND sbfe_mth_since_ls > 36 ),
			// else 
			ver_src_id_mth_since_ls > 36 );

	EXPORT isCode39 := // No updates to business record in the past 24 months.
		IF( useSBFE,
			( ver_src_id_mth_since_ls > 24 AND sbfe_mth_since_ls > 24 ) OR
			( ver_src_id_mth_since_ls > 24 AND sbfe_mth_since_ls = -99 ) OR             
			( ver_src_id_mth_since_ls = -1 AND sbfe_mth_since_ls > 24 ),
			// else 
			ver_src_id_mth_since_ls > 24 );
			
	EXPORT isCode40 := // No updates to business record in the past 12 months.
		IF( useSBFE,
			( ver_src_id_mth_since_ls > 12 AND sbfe_mth_since_ls > 12 ) OR
			( ver_src_id_mth_since_ls > 12 AND sbfe_mth_since_ls = -99 ) OR             
			( ver_src_id_mth_since_ls = -1 AND sbfe_mth_since_ls > 12 ),
			// else 
			ver_src_id_mth_since_ls > 12 );
			
	// Business operates or has operated at multiple locations.
	EXPORT isCode41 := vel_proxid_per_seleid > 1;
	
	// Business has been banned from doing business with the government.
	EXPORT isCode42 := gov_debarred = 1;

	// The input business address may be invalid according to postal specifications.
	EXPORT isCode43 := pop_bus_addr = 1 AND addr_input_valid = 0;
	
	// The input business phone number is potentially invalid.
	EXPORT isCode44 := pop_bus_phone = 1 AND phn_input_valid = 0;

	// The input business TIN is potentially invalid.
	EXPORT isCode45 := pop_bus_fein = 1 AND fein_input_valid = 0;

	// The input business name matches the input alternate business name.
	EXPORT isCode46 := pop_bus_name = 1 AND pop_bus_altname = 1 AND altnm_input_match_in_bus_name = 1;

	// The input business name may have been miskeyed.
	EXPORT isCode47 := ( pop_bus_name = 1 AND name_input_miskey = 1 ) OR ( pop_bus_altname = 1 AND altnm_input_miskey = 1 );
	
	// The input business address may have been miskeyed.
	EXPORT isCode48 := pop_bus_addr = 1 AND addr_input_miskey = 1;

	// The input business phone number may have been miskeyed.
	EXPORT isCode49 := pop_bus_phone = 1 AND phn_input_miskey = 1;
	
	// The input business TIN may have been miskeyed.
	EXPORT isCode50 := pop_bus_fein = 1 AND fein_input_miskey = 1;
  
	// The input business name was missing.
	EXPORT isCode51 := pop_bus_name = 0 AND pop_bus_altname = 0;
	
	// The input business address was missing.
	EXPORT isCode52 := 
			pop_bus_addr = 0 OR 
			( pop_bus_addr = 1 AND ( pop_bus_city = 0 AND pop_bus_state = 0 AND pop_bus_zip = 0 ) ) OR
			( pop_bus_addr = 1 AND ( ( pop_bus_city = 0 OR pop_bus_state = 0 ) AND pop_bus_zip = 0 ) );

	// The input business phone was missing or incomplete.
	EXPORT isCode53 := pop_bus_phone = 0;

	// The input business TIN was missing or incomplete.
	EXPORT isCode54 := pop_bus_fein = 0;

END;
