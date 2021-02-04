IMPORT Data_Services, doxie, risk_indicators, Seed_Files, STD;

 
EXPORT BIID20_keys := MODULE

	SHARED middle_name := 'testseed::' + doxie.Version_SuperKey;
	
//==========================================
//===  configuration variables  for prod === 
//==========================================  
	SHARED file_prefix_Prod := 'thor_data400';
	// shared locat_Prod := '~' + file_prefix_Prod + '::key::' + middle_name;
	SHARED locat_Prod := Data_Services.Data_location.Prefix('BIID20TestSeed') + file_prefix_Prod + '::key::' + middle_name;

//==========================================================
//===           Input Echo Key - Section 1               ===
//==========================================================	
	seed := Seed_Files.BIID20_files.BIID2testseedspart1;
	newrec := RECORD
		DATA16 hashvalue := seed_files.Hash_InstantID(
		                    STD.Str.ToUpperCase(TRIM(seed.authrep_first)),   // fname,
		                    STD.Str.ToUpperCase(TRIM(seed.authrep_last)),    // lname,
		                    risk_indicators.nullstring,                              // ssn -- not used in business products,
		                    STD.Str.ToUpperCase(TRIM(seed.company_fein)),    // fein,
		                    STD.Str.ToUpperCase(TRIM(seed.company_zip)),     // zip,
		                    STD.Str.ToUpperCase(TRIM(seed.company_phone)),   // phone,
		                    STD.Str.ToUpperCase(TRIM(seed.company_name)));   // company_name
	  seed;
	END;
	newtable := TABLE(seed, newrec);
	EXPORT BIID20keypart1 := INDEX(newtable,{dataset_name,hashvalue}, {newtable}, 
							locat_Prod + '::Part1::BIID_V2');	// Need to build a superkey to read this key!  //build for Production

//==========================================================
//===           Input Echo Key - Section 2               ===
//==========================================================	
	seed := Seed_Files.BIID20_files.BIID2testseedspart2;
	newrec := RECORD
		DATA16 hashvalue := Seed_Files.Hash_InstantID(
		                    STD.Str.ToUpperCase(TRIM(seed.authrep_first)),   // fname,
		                    STD.Str.ToUpperCase(TRIM(seed.authrep_last)),    // lname,
		                    risk_indicators.nullstring,                              // ssn -- not used in business products,
		                    STD.Str.ToUpperCase(TRIM(seed.company_fein)),    // fein,
		                    STD.Str.ToUpperCase(TRIM(seed.company_zip)),     // zip,
		                    STD.Str.ToUpperCase(TRIM(seed.company_phone)),   // phone,
		                    STD.Str.ToUpperCase(TRIM(seed.company_name)));   // company_name
	  seed;
	END;
	newtable := TABLE(seed, newrec);
	EXPORT BIID20keypart2 := INDEX(newtable,{dataset_name,hashvalue}, {newtable}, 
							locat_Prod + '::Part2::BIID_V2');		                                          //build for Production

//==========================================================
//===           Input Echo Key - Section 3               ===
//==========================================================	
	seed := Seed_Files.BIID20_files.BIID2testseedspart3;
	newrec := RECORD
		DATA16 hashvalue := Seed_Files.Hash_InstantID(
		                    STD.Str.ToUpperCase(TRIM(seed.authrep_first)),   // fname,
		                    STD.Str.ToUpperCase(TRIM(seed.authrep_last)),    // lname,
		                    risk_indicators.nullstring,                              // ssn -- not used in business products,
		                    STD.Str.ToUpperCase(TRIM(seed.company_fein)),    // fein,
		                    STD.Str.ToUpperCase(TRIM(seed.company_zip)),     // zip,
		                    STD.Str.ToUpperCase(TRIM(seed.company_phone)),   // phone,
		                    STD.Str.ToUpperCase(TRIM(seed.company_name)));   // company_name
	  seed;
	END;
	newtable := TABLE(seed, newrec);
	EXPORT BIID20keypart3 := INDEX(newtable,{dataset_name,hashvalue}, {newtable}, 
							locat_Prod + '::Part3::BIID_V2');		                                          //build for Production

END;