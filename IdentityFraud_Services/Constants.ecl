import iesp, header;

export Constants := MODULE

  export unsigned1 MAX_SOURCETYPES := 100;

  export unsigned2 MAX_DL_RECORDS := 500;
  // iesp.DL.MaxCountDL = 20
  // actual stat: 
  //   367 by did for DID=2639244541
  //   252 by license for s_dl=L160135011 (W20100421-181425, prod)

  export unsigned2 MAX_SAME_ADDRESS := 100;

  // by spec up to phones' indicators must be returned
  export unsigned1 MAX_PHONES_INDICATORS := min (2, iesp.Constants.IFR.MaxIndicators);

	// Number of fraud attributes
	export	unsigned1	MAX_FRAUD_ATTRIBUTES	:=	22;

  // in case of search, we want closer than usual match
  export integer1 MAX_PENALTY_SCORE := 5;

  export unsigned1 MAX_HRI := 10;

  // indicators' types
  export ITYPES := MODULE
    export unsigned1 T_DID := 0;
    export unsigned1 T_SSN := 1;
    export unsigned1 T_DOB := 2;
    export unsigned1 T_NAME := 3;
    export unsigned1 T_ADDRESS := 4;
    export unsigned1 T_PHONE := 5;
  end;

  // General description for USPIS match (used in summary and for descriptions absent from the index):
  export string USPIS_INDICATOR_TEXT := 'Address matches the USPIS Hot List';

  export Color := module
    export unsigned1 RED := 1;
    export unsigned1 YELLOW := 2;
    export unsigned1 BLUE := 3;
  end;

  export string GetColorDescription (unsigned1 cl) := map (
     cl = Color.RED => 'Red',
     cl = Color.YELLOW => 'Yellow',
     cl = Color.BLUE => 'Blue', '');

  // Risk Indicators providers: an entity producing it or the reason "why" or any other descriptor
  export Providers := module
    //! don't use blanks: it'll be used as a delimeter in case of multiple providers
    export string EQUIFAX    := '1';
    export string EXPERIAN   := '2';
    export string TRANSUNION := '3';
    export string USPIS := 'USPIS';
  end;

  SSN_BITMAP := module
    unsigned2 IS_VALID              := 0; //only for use in direct comparisons, not inclusions!
    unsigned2 IS_PARTIAL            := header.constants.ssn_indicators.is_partial;            //   1 (1b)
    unsigned2 IS_ITIN               := header.constants.ssn_indicators.is_itin;               //   2 (10b)
    unsigned2 IS_666                := header.constants.ssn_indicators.is_666;                //   4 (100b)
    unsigned2 IS_EAE                := header.constants.ssn_indicators.is_eae;                //   8 (1000b)
    unsigned2 IS_ADVERTISING        := header.constants.ssn_indicators.is_advertising;        //  16 (10000b)
    unsigned2 IS_WOOLWORTH          := header.constants.ssn_indicators.is_woolworth;          //  32 (100000b)
    unsigned2 IS_INVALID_AREA       := header.constants.ssn_indicators.is_invalid_area;       //  64 (1000000b)
    unsigned2 IS_INVALID_GROUP      := header.constants.ssn_indicators.is_invalid_group;      // 128 (10000000b)
    unsigned2 AREA_GROUP_NOT_ISSUED := header.constants.ssn_indicators.area_group_not_issued; // 256 (100000000b)
    unsigned2 IS_INVALID_SERIAL     := header.constants.ssn_indicators.is_invalid_serial;     // 512 (1000000000b)
  end;

  // ============================================================================
  // ============================================================================
  // Risk Indicators' codes specific for this service;
  // IMPORTANT: all indicators must have distinctive numbers across all groups;
  //            it is also much safer to have distinctive interval per group 
  // ============================================================================
  // ============================================================================
  export RiskCodes  := MODULE 
    // [1 - 99]
    export SSN := module
      export unsigned2 INVALID     :=  1; // Red The SSN is invalid or not yet issued
      export unsigned2 IMPOSTERS   :=  2; // Red Multiple identities associated with SSN
      // export unsigned2 MULTIPLE    :=  3; // Red  Multiple SSNs reported with identity
      export unsigned2 LASTYEARS_3 :=  4; // Red  The SSN was issued within the last three years
      export unsigned2 AFTERAGE_5  :=  5; // Red  The SSN was issued after age five (post-1990)
      export unsigned2 DECEASED    :=  6; // Red  The SSN is reported as deceased
      export unsigned2 PRIOR_DOB   :=  7; // Red  The SSN was issued prior to the  Date of Birth
      export unsigned2 ENUMERATION :=  9; // Yellow  The SSN is an Enumeration at Entry
      export unsigned2 ITIN        := 10; // Yellow  SSN is an ITIN
      export unsigned2 SPOUSE      := 11; // Yellow  SSN belongs to spouse
      export unsigned2 RELATIVE    := 12; // Yellow  SSN belongs to Relative
      // export unsigned2 MINNESOTA   := 13; // Blue SSN masked per Minnesota legislation
      export unsigned2 RANDOMIZED  := 14; // Blue
      export unsigned2 RANDOMIZED_INVALID := 15; // Yellow
			
      export unsigned2 EXCESSIVE_SEARCHES_YEAR  := 16;	// Yellow
      export unsigned2 EXCESSIVE_SEARCHES_MONTH := 17;	// Yellow
      export unsigned2 EXCESSIVE_SEARCHES_WEEK  := 18;	// Yellow
      export unsigned2 EXCESSIVE_SEARCHES_DAY   := 19;	// Yellow
    end;

    // [101 - 199]
    export Address := module
      export unsigned2 INVALID        := 101;
      export unsigned2 ZIP2POBOX      := 102;
      export unsigned2 COMMERCIAL     := 103;
      export unsigned2 MILITARY       := 104;
      export unsigned2 HOTEL          := 105;
      export unsigned2 LETTER         := 106;
      export unsigned2 CORRECTIONAL   := 107;
      export unsigned2 COLLEGE        := 108;
      export unsigned2 PHOTOCOPYING   := 109;
      export unsigned2 PACKAGING      := 110;
      export unsigned2 SCHOOL         := 111;
      export unsigned2 JUNIORCOLLEGE  := 112;
      export unsigned2 LIBRARY        := 113;
      export unsigned2 NEWSPAPER      := 114;
      export unsigned2 MULTIUNIT      := 115;
      export unsigned2 TRAILER_COURT  := 116;
      export unsigned2 TRAILER_PARK   := 117;
      export unsigned2 NURSING        := 118;
      export unsigned2 SKILLED_NURSING:= 119;
      export unsigned2 RETIREMENT     := 120;
      export unsigned2 HOSPITAL       := 121;
      export unsigned2 PSYCHIATRIC    := 122;
      export unsigned2 TELEGRAPH      := 123;
      export unsigned2 USPS           := 124;
      export unsigned2 RRZIP          := 125;
      export unsigned2 MOBILE_HOME    := 126;
      export unsigned2 BOARDING       := 127;
      export unsigned2 SPORTING       := 128;
      export unsigned2 NTLSECURITY    := 129;
      export unsigned2 TAXPREP        := 130;
      export unsigned2 CREDIT         := 131;
      export unsigned2 HUNTING        := 132;
      export unsigned2 SOCIAL_SERVICE := 133;
      export unsigned2 SHIPPING_AGENT := 134;
      export unsigned2 PACKING_CRATING   := 135;
      export unsigned2 RESIDENTIAL_CARE  := 136;
      export unsigned2 HOMEHEALTH_CARE   := 137;
      export unsigned2 INTERMEDIATE_CARE := 138;
      export unsigned2 GENERAL_DELIVERY  := 139;

      export unsigned2 MORE_RECENT := 140;
			export unsigned2 MULTIPLE    :=	141;	// Address is assciated with multiple identities

      // Valassis (ADVO)
      export unsigned2 ADVO_VACANT    := 150; // Address is reported as vacant
      export unsigned2 ADVO_SEASONAL  := 151; // Address is a seasonal address
      export unsigned2 ADVO_CMRA      := 152; // Address is a Commercial Mail Receiving Agency (CMRA)
      export unsigned2 ADVO_IDA       := 153; // Internal Drop Address (IDA)
      export unsigned2 ADVO_VACANT_PO := 154; // ... this is the same as ADVO_VACANT, only for PO Boxes

      //? export unsigned2 ADVO_COLLEGE  := ; // Address is College
      export unsigned2 ADVO_GENERAL      := 169;//'GENERAL DELIVERY',
      export unsigned2 ADVO_CALLER       := 170;// Caller Service Box
      export unsigned2 ADVO_REMITTANCE   := 171;// Remittance Box
      export unsigned2 ADVO_CONTEST      := 172;// Contest Box
      export unsigned2 ADVO_POBOX        := 173;// P.O.Box

      // (see history for defnition of the following indicators separately for residence and business)
      export unsigned2 ADVO_CURB     := 180;
      export unsigned2 ADVO_NDCBU    := 181; //RESIDENTIAL NEIGHBORHOOD DELIVERY AND COLLECTION BOX UNITS
      export unsigned2 ADVO_CENTRAL  := 182;
      export unsigned2 ADVO_OTHER    := 183;
      export unsigned2 ADVO_FACILITY := 184;
      export unsigned2 ADVO_CONTRACT := 185;
      export unsigned2 ADVO_DETACHED := 186;
      export unsigned2 ADVO_NPU      := 187;

      // ADVO address type
      export unsigned2 ADVO_RESIDENTIAL      := 190;
      export unsigned2 ADVO_BUSINESS         := 191;
      export unsigned2 ADVO_RESIDENTIAL_PRIM := 192; //primarily residential with a possible business
      export unsigned2 ADVO_BUSINESS_PRIM    := 193; //primarily business with a possible residence

      export unsigned2 USPIS          := 199; // common for all USPIS
    end;

    // [201 - 299]
    export Phone := module
      export unsigned2 INVALID      :=  201;
      export unsigned2 NUMBER_ZIP   :=  202;
      export unsigned2 TRANSIENT    :=  203;
      export unsigned2 DISCONNECTED :=  204;
      export unsigned2 MOBILE       :=  205;
      export unsigned2 PAGER        :=  206;
      export unsigned2 DISTANT      :=  207;
    end;

    // [301 - 399]
    export Name := module
      export unsigned2 OFAC    :=  301;
      export unsigned2 DERIVED :=  302;
    end;

		// [401 - 499]
		export	Identity	:=
		module
			export	unsigned2	NO_UPDATES								:=	401;
			export	unsigned2	MULTIPLE_SSNs							:=  402;	// Red  Multiple SSNs associaed with identity
			export	unsigned2	ADDRESS_CHANGES						:=	403;
			export	unsigned2	MULTIPLE_PHONES						:=	404;	// Yellow	Multiple phones associated with identity
			export	unsigned2	EXCESSIVE_SSNS						:=	405;
			export	unsigned2	EXCESSIVE_ADDRESSES				:=	406;
			export	unsigned2	EXCESSIVE_PHONES					:=	407;
			export	unsigned2	EXCESSIVE_SEARCHES_YEAR		:=	408;
			export	unsigned2	EXCESSIVE_SEARCHES_MONTH	:=	409;
			export	unsigned2	EXCESSIVE_SEARCHES_WEEK		:=	410;
			export	unsigned2	EXCESSIVE_SEARCHES_DAY		:=	411;
		end;
		
    // no longer reported by a creadit bureau
    // [901 - 999]
    export NLR := module
      export unsigned2 DID_EQ     := 901;
      export unsigned2 SSN_EQ     := 902;
      export unsigned2 NAME_EQ    := 903;
      export unsigned2 ADDRESS_EQ := 904;
      export unsigned2 PHONE_EQ   := 905;
      export unsigned2 DOB_EQ     := 906;
      export unsigned2 LNAME_EQ   := 907;

      export unsigned2 DID_EN     := 921;
      export unsigned2 SSN_EN     := 922;
      export unsigned2 NAME_EN    := 923;
      export unsigned2 ADDRESS_EN := 924;
      export unsigned2 PHONE_EN   := 925;
      export unsigned2 DOB_EN     := 926;
      export unsigned2 LNAME_EN   := 927;

      export unsigned2 DID_TU     := 931;
      export unsigned2 SSN_TU     := 932;
      export unsigned2 NAME_TU    := 933;
      export unsigned2 ADDRESS_TU := 934;
      export unsigned2 PHONE_TU   := 935;
      export unsigned2 DOB_TU     := 936;
      export unsigned2 LNAME_TU   := 937;

      // this are to represent bureau-neutral indicator, like "Identity has address no longer reported"
      export unsigned2 DID     := 981;
      export unsigned2 SSN     := 982;
      export unsigned2 NAME    := 983;
      export unsigned2 ADDRESS := 984;
      export unsigned2 PHONE   := 985;
      export unsigned2 DOB     := 986;
      export unsigned2 LNAME   := 987;
    end;

    export unsigned2 UNKNOWN     := 1000;
    export unsigned2 NO_RISK     := 0;	//no risk indicators
  end;

  // keepeng separate individual sets would be a little better, but I want to keep it simple
  export set of integer No_LONGER_SET := [
    RiskCodes.NLR.SSN_EQ,     RiskCodes.NLR.SSN_EN,     RiskCodes.NLR.SSN_TU,
    RiskCodes.NLR.NAME_EQ,    RiskCodes.NLR.NAME_EN,    RiskCodes.NLR.NAME_TU,
    RiskCodes.NLR.ADDRESS_EQ, RiskCodes.NLR.ADDRESS_EN, RiskCodes.NLR.ADDRESS_TU,
    RiskCodes.NLR.LNAME_EQ,   RiskCodes.NLR.LNAME_EN,   RiskCodes.NLR.LNAME_TU,
    RiskCodes.NLR.DOB_EQ,     RiskCodes.NLR.DOB_EN,     RiskCodes.NLR.DOB_TU];

  // this is translation from Doxie codes to the codes specific for this service.
  // (see also Codes@VARIOUS_HRI_FILES)
  // returned "0" will not generate any IdentityFraud risk indicator
	export unsigned4 GetComplianceCode (string code) := MAP (	
    code='0002' => RiskCodes.SSN.DECEASED,//'SSN belongs to a person reported as deceased.',  
    code='0003' => RiskCodes.SSN.PRIOR_DOB, //'SSN issued prior to the input date-of-birth.',  
    code='0007' => RiskCodes.Phone.DISCONNECTED, //'phone number may be disconnected.',  
    code='0008' => RiskCodes.Phone.INVALID, //'phone number is potentially invalid.',  
    code='0009' => RiskCodes.Phone.PAGER, //'phone number is a pager number.',  
    code='0010' => RiskCodes.Phone.MOBILE, //'phone number is a mobile number.',  
    code='0011' => RiskCodes.Address.INVALID, //'address may be invalid according to postal specifications.',  
    code='0012' => RiskCodes.Address.ZIP2POBOX, //'zip code belongs to a post office box.',  
    code='0014' => RiskCodes.Address.COMMERCIAL, //'transient commercial or institutional address.',  
    code='0015' => RiskCodes.Phone.TRANSIENT, //'phone number matches a transient commercial or institutional address.',  
    code='0016' => RiskCodes.Phone.NUMBER_ZIP, //'phone number and zip code combination is invalid.',  
    code='0039' => RiskCodes.SSN.LASTYEARS_3, //'SSN is recently issued.',  
    code='0040' => RiskCodes.Address.MILITARY, //'zip code is a corporate-only, military zip code.',  
    code='0046' => RiskCodes.Phone.PAGER, //'work phone is a pager number.',  
    code='0049' => RiskCodes.Phone.DISTANT, //'phone and address are geographically distant (greater than 10 miles).',  
    code='0050' => RiskCodes.Address.CORRECTIONAL, //'address matches a prison address.',  
    code='0055' => RiskCodes.Phone.INVALID, //'work phone is potentially invalid.',  
    code='0056' => RiskCodes.Phone.DISCONNECTED, //'work phone is potentially disconnected.',  
    code='0057' => RiskCodes.Phone.MOBILE, //'work phone is a mobile number.',  
    code='0089' => RiskCodes.SSN.LASTYEARS_3, //'SSN was issued within the last three years.',  
    code='0090' => RiskCodes.SSN.AFTERAGE_5, //'SSN was issued after age five (post-1990).',  
    code='0115' => RiskCodes.SSN.RELATIVE, //'SSN is a Relative\'s SSN.',
    code='0155' => RiskCodes.SSN.RANDOMIZED, //'SSN is potentially randomized.',
    code='0160' => RiskCodes.SSN.RANDOMIZED_INVALID, //'SSN is potentially randomized, but invalid when first associated with the consumer.',
    code='2210' => RiskCodes.Address.HOTEL, //'Hotel or motel.',
    code='2215' => RiskCodes.Address.TRAILER_PARK, //'Trailer park or campsite.',  
    code='2220' => RiskCodes.Address.LETTER, //'Addressing or letter service.', 
    code='2225' => RiskCodes.Address.CORRECTIONAL, //'Correctional institution.',
    code='2230' => RiskCodes.Address.BOARDING, //'Rooming or boarding house.',  
    code='2235' => RiskCodes.Address.MULTIUNIT, //'Multi-unit dwelling.',  
    code='2245' => RiskCodes.Address.GENERAL_DELIVERY, //'General delivery.',  
    code='2250' => RiskCodes.Address.NURSING, //'Nursing home.',  
    code='2255' => RiskCodes.Address.RETIREMENT, //'Retirement home.',  
    code='2260' => RiskCodes.Address.HOSPITAL, //'General medical or surgical hospital.',  
    code='2265' => RiskCodes.Address.USPS, //'US Postal Service.',  
    code='2270' => RiskCodes.Address.COLLEGE, //'College or university.', 
    code='2275' => RiskCodes.Address.SKILLED_NURSING, //'Skilled nursing care facility.',  
    code='2280' => RiskCodes.Address.PHOTOCOPYING, //'Photocopy or duplication service.', 
    code='2285' => RiskCodes.Address.MOBILE_HOME, //'Mobile home site operator.',  
    code='2290' => RiskCodes.Address.SPORTING, //'Sporting or recreational camp.',  
    code='2295' => RiskCodes.Address.NTLSECURITY, //'National Security.',  
    code='2300' => RiskCodes.Address.TELEGRAPH, //'Telegraph or other communication service.',  
    code='2305' => RiskCodes.Address.CREDIT, //'Credit reporting service.',  
    code='2310' => RiskCodes.Address.PACKING_CRATING, //'Packing or crating service.',  
    code='2315' => RiskCodes.Address.PSYCHIATRIC, //'Psychiatric hospital.',  
    code='2320' => RiskCodes.Address.PACKAGING, //'Packaging service.',
    code='2325' => RiskCodes.Address.SHIPPING_AGENT, //'Shipping agent.',  
    code='2330' => RiskCodes.Address.HUNTING, //'Hunting, trapping, & game service.',  
    code='2335' => RiskCodes.Address.NEWSPAPER, //'Newspaper facility.',  
    code='2340' => RiskCodes.Address.TAXPREP, //'Tax return preparation service.',  
    code='2345' => RiskCodes.Address.SCHOOL, //'Elementary or secondary school.',  
    code='2350' => RiskCodes.Address.JUNIORCOLLEGE, //'Junior college or technical institute.',
    code='2355' => RiskCodes.Address.LIBRARY, //'Library.',
    code='2360' => RiskCodes.Address.TRAILER_COURT, //'Trailer court.',  
    code='2365' => RiskCodes.Address.RRZIP, //'Rural route zip.',  
    code='2380' => RiskCodes.Address.RESIDENTIAL_CARE, //'Residential Care facility.', //"2718 JOHNSON ST APT 7, HOLLYWOOD FL 33020 3824" 
    code='2381' => RiskCodes.Address.NURSING, //'Nursing and Personal Care Facility.',
    code='2382' => RiskCodes.Address.HOMEHEALTH_CARE, //'Home Health Care Facility.',
	  code='2383' => RiskCodes.Address.SOCIAL_SERVICE, //'Social Services Facility.',
    code='2384' => RiskCodes.Address.INTERMEDIATE_CARE, //'Intermediate Care Facility.',
    // code='2386' => RiskCodes.SSN.MINNESOTA, //'SSN masked per Minnesota legislation.', // deprecated
    code='2387' => RiskCodes.SSN.INVALID, //'SSN is incomplete.',
    0);
    
		EXPORT	unsigned1	FraudAttributes	:=	ENUM(	unsigned1,
																								IDENTITY_RECENT_UPDATE,
																								VARIATION_ADDR_STABILITY,
																								VARIATION_PHONE_COUNT,
																								VARIATION_SEARCH_SSN_COUNT,
																								VARIATION_SEARCH_ADDR_COUNT,
																								VARIATION_SEARCH_PHONE_COUNT,
																								SEARCH_COUNT_YEAR,
																								SEARCH_COUNT_MONTH,
																								SEARCH_COUNT_WEEK,
																								SEARCH_COUNT_DAY,
																								DIV_ADDR_SUSP_IDENTITY_COUNT_NEW,
																								SEARCH_SSN_SEARCH_COUNT_YEAR,
																								SEARCH_SSN_SEARCH_COUNT_MONTH,
																								SEARCH_SSN_SEARCH_COUNT_WEEK,
																								SEARCH_SSN_SEARCH_COUNT_DAY,
																								TOTAL_SEARCH_COUNT_YEAR,
																								TOTAL_SEARCH_COUNT_MONTH,
																								TOTAL_SEARCH_COUNT_WEEK,
																								TOTAL_SEARCH_COUNT_DAY,
																								IDENTITY_RISK_LEVEL,
																								SOURCE_RISK_LEVEL,
																								VELOCITY_RISK_LEVEL
																							);
		
		EXPORT	string IdentityRiskLevel	:=	'IDENTITY RISK LEVEL';
		EXPORT	string SourceRiskLevel		:=	'SOURCE RISK LEVEL';
		EXPORT	string VelocityRiskLevel	:=	'VELOCITY RISK LEVEL';

		EXPORT	string	EmailDataFamily	:=	'EMAIL';
END;

// ============================================================================
//        THESE ARE "STANDARD" INDICATORS NOT USED IN IDENTYTY REPORT
// ============================================================================
// Note: SSN indicators disabled: 0006, 0029, 0042, 0125, 0135, 0150


    // code='0001' => 0, //'Important Application Data Missing.',  
    // code='0004' => 0, //'name and SSN are verified, but at a different address.',  
    // code='0005' => 0, //'bill-to and ship-to addresses are geographically distant (greater than 50 miles).',  
    // code='0006' => 0, //'SSN invalid or not yet issued.',  
    // code='0017' => , //'bill-to and ship-to phone numbers are geographically distant (greater than 50 miles).',  
    // code='0018' => 0, //'Express shipping requested.',  
    // code='0019' => 0, //'Unable to verify name, address, SSN/TIN and phone.',  
    // code='0020' => 0, //'Unable to verify applicant name, address and phone number.',  
    // code='0021' => 0, //'Unable to verify applicant name and phone number.',  
    // code='0022' => 0, //'Unable to verify applicant name and address.',  
    // code='0023' => 0, //'Unable to verify applicant name and SSN.',  
    // code='0024' => 0, //'Unable to verify applicant address and SSN.',  
    // code='0025' => 0, //'Unable to verify address.',  
    // code='0026' => 0, //'Unable to verify SSN / TIN.',  
    // code='0027' => 0, //'Unable to verify phone number.',  
    // code='0028' => 0, //'Unable to verify date-of-birth.',  
    // code='0029' => 0, //'SSN may have been miskeyed.',  
    // code='0030' => 0, //'address may have been miskeyed.',  
    // code='0031' => 0, //'phone number may have been miskeyed.',  
    // code='0032' => 0, //'name matches the OFAC file.',  
    // code='0033' => 0, //'address is not associated with the business name or telephone.',  
    // code='0034' => 0, //'Incomplete verification.',  
    // code='0035' => 0, //'Insufficient verification to return a score under CA law.',  
    // code='0036' => 0, //'Identity elements not fully verified on all available sources.',  
    // code='0037' => 0, //'Unable to verify name.',  
    // code='0038' => 'SSN is associated with different first and last name.',  
    // code='0013' => , //'invalid apartment designation.',  
    // code='0041' => 'driver\'s license number is invalid for the input DL State.',  
    // code='0042' => 0, //'SSN matches bankruptcy file.',  
    // code='0043' => 0, //'name and address match the bankruptcy file.',  
    // code='0044' => 0, //'phone area code is changing.',  
    // code='0045' => 0, //'SSN and address are not associated with the input last name or phone.',  
    // code='0047' => 0, //'phone is associated with a different business name or address.',  
    // code='0048' => 0, //'Unable to verify first name.',  
    // code='0051' => 'last name is not associated with SSN.',  
    // code='0052' => 'first name is not associated with SSN.',  
    // code='0053' => 'home phone and work phone are geographically distant (greater than 100 miles).',  
    // code='0054' => 0, //'business name and address match a different TIN, not the input TIN.',  
    // code='0058' => 0, //'business TIN was missing or incomplete.',  
    // code='0059' => 0, //'business name was missing.',  
    // code='0060' => 0, //'Unable to verify business name, address and phone number.',  
    // code='0061' => 0, //'Unable to verify business name and phone number.',  
    // code='0062' => 0, //'Unable to verify business name and address.',  
    // code='0063' => 0, //'business name may have been miskeyed.',  
    // code='0064' => 0, //'address returns a different phone number.',  
    // code='0065' => 0, //'Unable to verify business address.',  
    // code='0066' => 'SSN is associated with a different last name, same first name.',  
    // code='0067' => 0, //'Unable to verify business telephone number.',  
    // code='0068' => 0, //'Unable to verify business facsimile number.',  
    // code='0069' => 'business phone number is associated with a residential listing.',  
    // code='0070' => 'business address may be a residential address (single family dwelling).',  
    // code='0071' => 'SSN is not found in the public record databases.',  
    // code='0072' => 'SSN is associated with a different First Name, Last Name and Address.',  
    // code='0073' => 0, //'Telephone Number is not found in the public record databases.',  
    // code='0074' => 0, //'phone number is associated with a different name and address.',  
    // code='0075' => 'name and address are associated with an unlisted/non-published phone number.',  
    // code='0076' => 'name may have been miskeyed.',  
    // code='0077' => 0, //'name was missing.',  
    // code='0078' => 0, //'address was missing.',  
    // code='0079' => 0, //'SSN/TIN was missing or incomplete.',  
    // code='0080' => 0, //'phone was missing or incomplete.',  
    // code='0081' => 'date-of-birth was missing or incomplete.',  
    // code='0082' => 'name and address return a different phone number.',  
    // code='0083' => 'date-of-birth may have been miskeyed.',  
    // code='0084' => 0, //'Business Name, Address and Telephone number are not found together.',  
    // code='0085' => 'SSN was issued to a non-US citizen.',  
    // code='0086' => 0, //'business name was verified; alternate business name found.',  
    // code='0087' => 0, //'business name and address return a different phone number.',  
    // code='0088' => 0, //'business name was not verified; alternate business name found.',  
    // code='0091' => 0, //'Security Freeze (CRA corrections database).',  
    // code='0092' => 0, //'Security Alert (CRA corrections database).',  
    // code='0093' => 0, //'Identity Theft Alert (CRA corrections database).',  
    // code='0094' => 0, //'Dispute On File (CRA corrections database).',  
    // code='0095' => 0, //'Negative File Alert (CRA corrections database).',  
    // code='0096' => 0, //'Corrections Database Information Utilized (CRA corrections database).',  
    // code='0097' => 0, //'Held for future Consumer Report use.',  
    // code='0098' => 0, //'Held for future Consumer Report use.',  
    // code='0099' => 0, //'Held for future Consumer Report use.',  
    // code='0100' => 0, //'business address was verified using consumer public sources.',  
    // code='0101' => 0, //'business name was verified using consumer public sources.',  
    // code='0102' => 0, //'business TIN was verified using consumer public sources.',  
    // code='0103' => 0, //'TIN is associated with a different business name and address (future use).',  
    // code='0104' => 0, //'business is not in good standing per the Secretary of State (future use).',  
    // code='0105' => 'Property search finds a different name listed as owner.',  
    // code='0106' => 'driver\'s license number was issued to a different full name and address.',  
    // code='0107' => 'driver\'s license number was issued to a different last name and address.',  
    // code='0108' => 0, //'IP address is not assigned to the United States.',  
    // code='0109' => 0, //'IP address may be foreign.',  
    // code='0110' => 0, //'IP address is assigned to a different State than the bill-to State.',  
    // code='0111' => 0, //'IP address is assigned to a different zip code than the bill-to zip code.',  
    // code='0112' => 0, //'IP address is assigned to a different area code than the Bill-to phone number.',  
    // code='0113' => 0, //'IP address second-level domain is unknown.',  
    // code='0114' => 0, //'IP address is unknown.',
    // code='0120' => 0, //RiskCodes.SSN.IMPOSTERS, //'SSN was linked to multiple people.',
    // code='0125' => 0, // RiskCodes.SSN.IMPOSTERS, //'SSN was linked to more than 2 people.',
    // code='0130' => 0, //'SSN was created by LexisNexis.',
    // code='0135' => 'SSN is not the best SSN for subject.',
    // code='0140' => 0, //'SSN is the most likely SSN for subject.',
    // code='0145' => 'No best known SSN for subject.',
    // code='0150' => 0, //'SSN not recently reported for subject.',    
    // code='0911' => 'Mail service suspended in zip code due to natural disaster.',
    // code='1100' => 'Dedicated to Paging.',  
    // code='1105' => 'Dedicated to Cellular.',  
    // code='1110' => 0, //'Shared between 3 or more (Pots, Cellular, Paging, Mobile or Miscellaneous).',  
    // code='1115' => 0, //'Shared between POTS and Mobile.',  
    // code='1120' => 0, //'Shared between POTS and Paging.',  
    // code='1125' => 0, //'Shared between POTS and Cellular.',  
    // code='1130' => 0, //'Special Billing Options - Cellular.',  
    // code='1135' => 0, //'Special Billing Options - Paging.',  
    // code='1140' => 0, //'Special Billing Options - Mobile.',  
    // code='1145' => 0, //'Special Billing Options shared between 2 or more (Cellular, Paging, Mobile).',  
    // code='1150' => 0, //'Service provider requests SELECTIVE Local Exchange Company IntraLATA Special Billing Option - Cellular.',  
    // code='1155' => 0, //'Service provider requests SELECTIVE Local Exchange Company IntraLATA Special Billing Option - Paging.',  
    // code='1160' => 0, //'Service provider requests SELECTIVE Local Exchange Company IntraLATA Special Billing Option - Mobile.',  
    // code='1165' => 0, //'Service provider requests SELECTIVE Local Exchange Company IntraLATA Special Billing Option shared between 2 or more (Cellular, Paging, Mobile).',  
    // code='1170' => 'Personal Communications Services (NPA 500).',  
    // code='1175' => 'Miscellaneous Service (non-500 PCS, etc).',  
    // code='1180' => 'Shared Between POTS and Miscellaneous service.',  
    // code='1185' => 'Special Billing Option - PCS / Miscellaneous service.',  
    // code='1190' => 0, //'POTS number.',
    // code='1195' => 0, //'Non-POTS number.',
    // code='1200' => 'phone number is associated with a different last name than phone data.',
    // code='1205' => 'phone number is associated with a different address than phone data.',
    // code='1210' => 'phone number is not found in phone data.',
    // code='2240' => 'Business.',  
    // code='2370' => 0, //'See Vehicle Information.',
    // code='2371' => 0, //'See Vehicle Description and Title Branding.',
    // code='2372' => 0, //'The Vehicle has a commercial vehicle registration.',
    // code='2373' => 0, //'Registered Vehicle Owner doesn\'t match the input name - see Vehicle Info.',                                                                                                                                                                                                                                                          
    // code='2374' => 0, //'Results are a Name + Address Match only.',
    // code='2375' => 0, //'Results are a Name + DOB match only.',
    // code='2376' => 0, //'Results are a Name + SSN match only.',
    // code='2377' => 'Driver License is registered to a different name than input name.',
    // code='2378' => 'Applicant is associated with more than one SSN.',
    // code='2379' => 'Applicant provided telephone number is associated with a business.',
    // code='2390' => 0, //'Results last name is different than input last name.',
    // code='2391' => 0, //'Reverse phone name does not match input name.',
    // code='2392' => 0, //'Number of vehicles does not match number of licensed drivers at address.',
    // code='2393'	=> 0, //'Branded title found.',
