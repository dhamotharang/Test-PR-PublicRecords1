import ut, doxie, header, AddrBest;

EXPORT Constants := MODULE
	EXPORT ValidPhoneMatches := ['2','4','6','8'];
	EXPORT UNSIGNED DEFAULT_YYMM_VALUE := 5000;
	// CY	Certegy
	// EN	Experian Credit Header
	// EQ	Equifax
	// LT	Lexis Transunion
	// TS	TUCS_Ptrack
	// TU	Transunion
	EXPORT HdrSrcs := ['CY','EN','EQ','LT','TS','TU'];
	//should be sorted desc (8 being the best)
	EXPORT SortSourceEnum := ENUM (UNSIGNED2, 
																UNK  = 0,
																CERTEGY = 1,
																UTILITY = 2,	
																CLUE = 3,
																CHDR_EXPERIAN_GW = 4,
																CHDR = 5,
																VOTR = 6,
																MVR  = 7,
																DMV  = 8);

	EXPORT STRING2 DISPLAY_SOURCENAME_BLANK := '  ';
	EXPORT STRING2 DISPLAY_SOURCENAME_ORIGINALDATA_CERTEGY := 'RT';
	EXPORT STRING2 DISPLAY_SOURCENAME_ORIGINALDATA_EXPERIAN_GW  := 'RD';	
	EXPORT STRING2 DISPLAY_SOURCENAME_ORIGINALDATA_UTILITY := 'UL';
	EXPORT STRING2 DISPLAY_SOURCENAME_ORIGINALDATA_CLUE := 'CL';
	EXPORT STRING2 DISPLAY_SOURCENAME_ORIGINALDATA_CHDR := 'CH';
	EXPORT STRING2 DISPLAY_SOURCENAME_ORIGINALDATA_VOTR := 'VT';
	EXPORT STRING2 DISPLAY_SOURCENAME_ORIGINALDATA_MVR  := 'MV';
	EXPORT STRING2 DISPLAY_SOURCENAME_ORIGINALDATA_DMV  := 'DL';
	
	EXPORT STRING2 DISPLAY_SOURCENAME_DERIVEDDATA_EXPERIAN_GW     := 'CX';
	EXPORT STRING2 DISPLAY_SOURCENAME_DERIVEDDATA_CERTEGY := 'CR';	
	EXPORT STRING2 DISPLAY_SOURCENAME_DERIVEDDATA_UTILITY := 'CU';
	EXPORT STRING2 DISPLAY_SOURCENAME_DERIVEDDATA_CLUE := 'CP';
	EXPORT STRING2 DISPLAY_SOURCENAME_DERIVEDDATA_CHDR := 'CC';
	EXPORT STRING2 DISPLAY_SOURCENAME_DERIVEDDATA_VOTR := 'CV';
	EXPORT STRING2 DISPLAY_SOURCENAME_DERIVEDDATA_MVR  := 'CM';
	EXPORT STRING2 DISPLAY_SOURCENAME_DERIVEDDATA_DMV  := 'CD';

	EXPORT FUZZY_MATCHING_LAST_MATCHING_PCTG := 80.0;
	EXPORT FUZZY_MATCHING_FIRST_MATCHING_PCTG := 80.0;
	EXPORT FUZZY_MATCHING_LASTFIRST_DOB68_MATCHING_PCTG := 85.0;
	EXPORT FUZZY_MATCHING_LASTFIRST_DOB4_MATCHING_PCTG := 90.0;
	
	//should be sorted asc
	EXPORT SortSearchPassEnum := ENUM (UNSIGNED2,
																			INPUT_SSN		      = 01,
																			PRIMARY           = 10,																			
																			DERIVED           = 20,																			
																			NAMEFLIP_PRIMARY  = 30,
																			NAMEFLIP_DERIVED  = 40,
																			FIRSTINITIAL      = 50,
																			FUZZY1_F          = 60,
																			FUZZY1_L          = 61,
																			FUZZY1_LF         = 62,
																			FUZZY2_F          = 63,
																			FUZZY2_L          = 64,
																			FUZZY2_LF         = 65,
																			FUZZYX_LF         = 66,
																			FUZZY_INSTRING    = 67,
																			IGNOREHOUSENUMBER = 70,
																			INPUT_SSN_IGNORE_LAST = 71,
																			DERIVED_IGNORE_LAST = 72,																			
																			MISS		          = 200,
																			MISS_DERIVE_FUZZY = 300,
																			SSN4EXPANSION = 1000);
	
	//should be sorted desc
	EXPORT SortAgeMatchTypeEnum := ENUM (UNSIGNED2,
																NONE = 0,
																YYYY = 4,
																YYYYMM = 6,
																YYYYMMDD = 8);
	
	//these are mostly used for online non-batch, PAVER, and USSTC
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_SSN              := 'S';
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_SSN_IGNORE_LAST  := 'L';
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_ADDRESS_GIID     := 'G';
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_ADDRESS_CURRENT  := 'C';
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_ADDRESS_PREVIOUS := 'P';
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_ADDRESS_ERROR    := 'E';
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_ADDRESS_GIID_ROBUST_OR_INSTRING     := 'X';
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_ADDRESS_CURRENT_ROBUST_OR_INSTRING  := 'Y';
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_ADDRESS_PREVIOUS_ROBUST_OR_INSTRING := 'Z';			
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_ADDRESS_MISS     := '';
	EXPORT STRING2 DISPLAY_INPUTMATCHCODE_ADDRESS_DERIVED    := 'D';
	
	EXPORT QSTRING5 DEFAULT_CHANNEL_IDENTIFIER     := 'BATCH';
	
	EXPORT UNSIGNED2 DEFAULT_UNDERAGE_VALUE := 21;
	
	EXPORT AddressTypeEnum := ENUM (UNSIGNED2,
													GIID = 1,
													CURRENT = 2,
													PREVIOUS = 3,
													UNK = 100);	
	
	EXPORT SSNSourceEnum := ENUM(UNSIGNED2,
												SSN_SOURCE_INPUT = 1,
												SSN_SOURCE_DERIVED = 2,
												SSN_SOURCE_UNKNOWN = 3);
												
	EXPORT STRING1 DISPLAY_YES := 'Y';
	EXPORT STRING1 DISPLAY_NO := 'N';
	EXPORT STRING1 DISPLAY_UNDEFINED_OR_BLANK := '';
	
	EXPORT QString50 SOURCETYPE_NAME_UNKNOWN := Q'UNKNOWN';
	EXPORT QString50 SOURCETYPE_NAME_BANKRUPTCY := Q'BANKRUPTCY';
	EXPORT QString50 SOURCETYPE_NAME_CERTEGY := Q'CERTEGY';
	EXPORT QString50 SOURCETYPE_NAME_CHARITY := Q'CHARITY';
	EXPORT QString50 SOURCETYPE_NAME_CREDITHEADER := Q'CREDIT HEADER';
	EXPORT QString50 SOURCETYPE_NAME_COMPOSITEID := Q'COMPOSITE ID';
	EXPORT QString50 SOURCETYPE_NAME_DEATHMASTER := Q'DEATH MASTER';
	EXPORT QString50 SOURCETYPE_NAME_EXPERIANGATEWAY := Q'EXPERIAN GATEWAY';
	EXPORT QString50 SOURCETYPE_NAME_INFOUSAPHONE := Q'INFOUSA PHONE';
	EXPORT QString50 SOURCETYPE_NAME_LICENSE := Q'LICENSE';
	EXPORT QString50 SOURCETYPE_NAME_QSENT := Q'QSENT GATEWAY';
	EXPORT QString50 SOURCETYPE_NAME_REFSSN := Q'REF SSN';
	EXPORT QString50 SOURCETYPE_NAME_TELSVC := Q'TELSVC QSENT';
	EXPORT QString50 SOURCETYPE_NAME_UTILITY := Q'UTILITY';
	EXPORT QString50 SOURCETYPE_NAME_VOTERREGISTRATION := Q'VOTER REGISTRATION';
	EXPORT QString50 SOURCETYPE_NAME_DLS := Q'FL TX CERTIGY DL';
	EXPORT QString50 SOURCETYPE_NAME_VOTN := Q'VEHICLES OF THE NATION';
	
	EXPORT MAX_NUM_RECORDS_TO_KEEP_PM := ut.limits.FETCH_KEYED;
	EXPORT MAX_NUM_RECORDS_TO_KEEP_PM_ADDR_ONLY:=  ut.limits.FETCH_JUST_ADDR;
	EXPORT MAX_NUM_RECORDS_PER_DID := ut.limits.HEADER_PER_DID;
	
	EXPORT MAX_NUM_RECORDS_PER_INPUT_TO_MOVE_TO_NEXT_STEP := 20;
	EXPORT MAX_NUM_OF_DERIVED_SSNS_PER_INPUT := 100;
	
	EXPORT ALPHABET := ut.alphabet + ' ';
	
	EXPORT NOMATCHFAILURECODE := ENUM(UNSIGNED2,
																		FAILURECODE_UNK = 0,
																		FAILURECODE_REJECT = 1,
																		FAILURECODE_HIT = 2,
																		FAILURECODE_FAILUNDERAGE = 3,
																		FAILURECODE_FIRSTLASTNOTFOUND = 4,
																		FAILURECODE_FIRSTLASTSTATENOTFOUND = 5,
																		FAILURECODE_FIRSTLASTZIPNOTFOUND = 6,
																		FAILURECODE_NOADDRFULLNAME = 7,
																		FAILURECODE_NODOBWITHADDRFULLNAME = 8,
																		FAILURECODE_DIFFERENTDOBWITHADDRFULLNAME = 9,
																		FAILURECODE_PREVIOUSFAILNOWHIT = 10);

END;