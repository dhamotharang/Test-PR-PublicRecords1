export limits := MODULE
  export unsigned2 DEFAULT := 10000; // last resort to get rid of warnings on key reads/joins
	
	// Maximum 16 bdids in Ingenix Business Sanctions file; Value set to 50 for considering exceptions/variations.  
	export unsigned2 Max_Business_Sanctions := 50; 
	
	export unsigned2 Max_GSA_Results := 50;  //actual 28

  // Business Header limits	
  export unsigned2 BHEADER_PER_BDID	:= 5000;  // Rough estimate, actual TBD
  export unsigned2 BHEADER_PER_GID	:= 10000; // Rough estimate, actual TBD
  export unsigned2 SICS_PER_GID	    := 100;   // doxie_cbrs.BRS uses Max_IndustryInfo_val = 100
	
	// header fetch limits
	export unsigned2 FETCH_KEYED := 100000;
	export unsigned2 FETCH_UNKEYED := 3000;
	export unsigned2 FETCH_LEV2_UNKEYED := 4500;
	export unsigned2 FETCH_JUST_ADDR := 1000;
	export unsigned2 FETCH_JUST_NAME := 1000;

  export unsigned2 HEADER_PER_DID	:= 1000; // if more dids than this limit, it is not a person, probably	
  // do not use the following anymore:
  export unsigned2 DID_PER_PERSON := HEADER_PER_DID; //TODO: remove it eventually
  export unsigned2 DID_PER_SSN := 100;
  export unsigned2 RID_PER_PERSON := 10;  // record id per person (should be 1?)

  export unsigned2 HEADER_BATCH_LIMIT := 12000;

  //TODO: change to HOUSEHOLD_PER_PERSON
  export unsigned2 HHID_PER_PERSON := 50;// number of housholds (more than enough, 3 as of 08.2014)

  export unsigned2 PHONE_PER_PERSON := 300; // unlikely more phone numbers associated with a person
  // phone numbers at a given address
  // actual stat is: ~1700; for daily_add: ~700 (office buildings in both cases);
  export unsigned2 PHONE_PER_ADDRESS := 500;

	export unsigned2 PHONE7_LIMIT := 1000;

  export unsigned2 RELATIVES_PER_PERSON := 200; // unlikely more relatives' records

  export unsigned2 GONG_PER_DID := 200; // actual stat: <100
  export unsigned2 GONG_PER_HHID := 300; // actual stat: ~100
  export unsigned2 GONG_DAILY_MAX := 300; // daily add records per did/hhid ~100 for both, varies
  export unsigned2 GONG_HISTORY_MAX := 5000; // actual stat: ~3500

  export unsigned2 TELCORDIA_MAX := 300; // actual count: ~237

  export unsigned1 MAX_DEATH_RECORDS := 5; // this is application dependent, might be better defined in application module

  //TODO: change to DEATH_RECORDS_MAX
  export unsigned2 DEATH_PER_DID := 100;   // actual stat ~10

  // maximum overall and datatype-specific number of correction records per person
  export unsigned2 OVERRIDES_PER_PERSON := 500;

  export unsigned2 HUNTERS_PER_DID := 350; //curent max is 308
  export unsigned2 VOTERS_PER_DID := 100; //~25
  //number of years we have voting history for (per vtid); should be changed in a few years
  export unsigned2 VOTERS_HISTORY_MAX := 20; //~10 
  export unsigned2 CCW_PER_DID :=50; //~10

  export unsigned2 MARRIAGEDIVORCE_PER_DID := 100; // 86 as of 2012.10, including multiple "same" license records 
  export unsigned2 MARRIAGEDIVORCE_PER_LNUM := 3000; // ~2000 as of 2012.10, (same license from different bureaus and states)
  export unsigned2 MARRIAGEDIVORCE_PARTY_PER_RECORD := 4; // P1, P2, P1A, P2A
  
  //professional license
  export unsigned2 PROFLICENSE_PER_DID  := 500; //~186
  export unsigned2 PROFLICENSE_PER_BDID := 10000; //~4386

  //watercrafts
  export unsigned2 WATERCRAFT_PER_HULL := 1000; // (reasonably below)
  export unsigned2 WATERCRAFT_PER_OFFNUM := 1000;
  export unsigned2 WATERCRAFT_PER_NAME := 2000; //~826
	export unsigned2 WATERCRAFT_PER_DID  := 50;
	export unsigned2 WATERCRAFT_PER_BDID := 50;
	EXPORT UNSIGNED2 MAX_WATERCRAFT_OWNERS := 20;
	EXPORT UNSIGNED2 MAX_WATERCRAFT_ENGINES := 20;
	EXPORT UNSIGNED2 MAX_WATERCRAFT_LH := 20;
	EXPORT UNSIGNED2 MAX_COASTGUARD_PER_WATERCRAFT := 50;
	EXPORT UNSIGNED2 MAX_DETAILS_PER_WATERCRAFT := 50;
	EXPORT UNSIGNED2 OWNERS_PER_WATERCRAFT := 100;
	
  //dea
  export unsigned2 DEA_PER_DID  := 100; //~30
  export unsigned2 DEA_PER_BDID := 200; //~70
  export unsigned2 DEA_MAX      := 50;  //~20 -- maximum records per registration number

	//Foreclosures
  export unsigned2 Foreclosure_PER_DID  := 300; //~255
  export unsigned2 Foreclosure_PER_BDID := 300; //~231
  export unsigned2 Foreclosure_MAX      := 1000;  //~721 -- maximum records per Foreclosure ID (FID)
	
  //firearms
  export unsigned2 FIREARMS_PER_DID  := 100; //~27
  export unsigned2 FIREARMS_PER_BDID := 500; //~133 (key-attribute has "_trad" postfix, not _bdid)
  export unsigned2 FIREARMS_LICENSE_MAX := 100; //~6

  //bankruptcy
  export unsigned2 BANKRUPT_MAX := 500; //~250 records per case, used for key_bkrupt_full, key_bkrupt_casenum 
  export unsigned2 BANKRUPT_PER_DID  := 500; //~139
  export unsigned2 BANKRUPT_PER_BDID :=	500; //~118

  // domains
  export unsigned2 DOMAINS_PER_DID_LIMIT  := 10000; //~16763
  export unsigned2 DOMAINS_PER_BDID_LIMIT := 10000; //~556570
  export unsigned2 DOMAINS_MAX := 100; //~21
		
  // fl crash
  export unsigned2 ACCIDENTS_PER_DID := 1000; //<1000
  export unsigned2 ACCIDENTS_MAX     := 1000; //<1000	//for all fl_crash keys
	
	//property search by fares id
	export unsigned2 RECORDS_PER_FARES_ID := 200;

  // aircrafts
  export unsigned2 AIRCRAFTS_PER_DID  := 1000;  //~311
  export unsigned2 AIRCRAFTS_PER_BDID := 10000; //~11284
  export unsigned2 REG_PER_AIRCRAFT := 100;     //~29

  //airmen
  export unsigned2 AIRMAN_PER_DID := 200;       //~100 as of 2012.06
  export unsigned2 AIRMAN_CERTIFICATES_MAX := 100; //~30 as of 2012.06
  export unsigned2 REGISTRATIONS_PER_AIRMAN := 100; //~30 as of 2012.06

  // offenders
  export unsigned2 OFFENDERS_PER_DID := 1000; //~500
  export unsigned2 OFFENDERS_MAX     := 1000; // for docnum, ooffender_key and alike
  export unsigned2 ACTIVITY_LIMIT    := 5000; //~15,000

  // for key_sexoffender_did, key_sexoffender_spk, Key_SexOffender_fdid, key_sexoffender_offenses
  export unsigned2 SOFFENDER_MAX := 100; //all < 50
  export unsigned2 SOFFENDER_ENHANCED := 1000; //~600  Key_SexOffender_SPK_Enh

  // InfoUSA (DEADCO, USABIZ)
  export unsigned2 DEADCO_PER_BDID := 50; //max ~ 10
  export unsigned2 USABIZ_PER_ABI  := 5000; //max ~ 800
  export unsigned2 USABIZ_CONTACTS_MAX := 200; //max ~ 100
  export unsigned2 USABIZ_ABI_PER_BDID := 2000; //max ~ 1200, declines very fast to ~500
	
	// HRI limits
	export unsigned2 HRI_MAX := 50;  // macros accept an input parameter; this will provide a ceiling on the amount requested


  // phones feedback records per {DID, phone}
  export unsigned2 FEEDBACK_PER_PHONE := 1000; // max > 600, declines very fast to < 100
	
	export unsigned2 PAW_PER_CONTACTID := 100; // max 25 per contactid

  //====================================================================
  //================  OVERRIDES (CORRECTION RECORDS) ===================
  //====================================================================
  export unsigned2 FLAG_RECORDS_PER_PERSON := 500; // upper limit for ssn and/or did flag records
  
  // limit on number of override records for each particular datatype: bankruptcy, property, etc.
  export unsigned2 OVERRIDE_LIMIT := 100; //potentially can go higher than that


  //====================================================================
  //============  SOURCE COUNTING IN COMPREHENSIVE REPORT  =============
  //====================================================================
  // So far default is used for limiting number of records to count;
  // define corresponding constant here if default is not suitable for particular data type
  // (See #18874 and #18891)
  EXPORT CRS_SOURCE_COUNT := MODULE
    export unsigned2 DEFAULT := 100;
  END;

  //====================================================================
  //=======  GENERAL, NOT RELEVANT TO ANY PARTICULAR DATATYPE  =========
  //====================================================================
  EXPORT CENSUS := MODULE
    export unsigned2 COUNTY_PER_STATE_MAX := 300; // current maximum TX: 254 counties
    export unsigned2 ZIP_PER_COUNTY_MAX := 800; // current maximum Los Angeles county: 526 zip codes
    export unsigned1 COUNTY_NAME_MAX := 50; // 31 WASHINGTON counties across the states
  END;

  EXPORT integer MAX_DCA_PER_BDID := 100; // actual count is ~25
  EXPORT integer MAX_DCA_CHILDREN_PER_LEVEL := 1000; // actual count is ~800

END;