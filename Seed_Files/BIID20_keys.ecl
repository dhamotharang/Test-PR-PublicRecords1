IMPORT Data_Services, ut, doxie, risk_indicators;

 
EXPORT BIID20_keys := MODULE

	shared middle_name := 'testseed::' + doxie.Version_SuperKey;
	
//==========================================
//===  configuration variables  for prod === 
//==========================================  
	shared file_prefix_Prod := 'thor_data400';
	// shared locat_Prod := '~' + file_prefix_Prod + '::key::' + middle_name;
	shared locat_Prod := Data_Services.Data_location.Prefix('BIID20TestSeed') + file_prefix_Prod + '::key::' + middle_name;

//==========================================================
//===           Input Echo Key - Section 1               ===
//==========================================================	
	seed := Seed_Files.BIID20_files.BIID2testseedspart1;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(
		                    StringLib.StringToUpperCase(trim(seed.authrep_first)),   // fname,
		                    StringLib.StringToUpperCase(trim(seed.authrep_last)),    // lname,
		                    risk_indicators.nullstring,                              // ssn -- not used in business products,
		                    StringLib.StringToUpperCase(trim(seed.company_fein)),    // fein,
		                    StringLib.StringToUpperCase(trim(seed.company_zip)),     // zip,
		                    StringLib.StringToUpperCase(trim(seed.company_phone)),   // phone,
		                    StringLib.StringToUpperCase(trim(seed.company_name)));   // company_name
	  seed;
	end;
	newtable := table(seed, newrec);
	export BIID20keypart1 := index(newtable,{dataset_name,hashvalue}, {newtable}, 
							locat_Prod + '::Part1::BIID_V2');	// Need to build a superkey to read this key!  //build for Production

//==========================================================
//===           Input Echo Key - Section 2               ===
//==========================================================	
	seed := Seed_Files.BIID20_files.BIID2testseedspart2;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(
		                    StringLib.StringToUpperCase(trim(seed.authrep_first)),   // fname,
		                    StringLib.StringToUpperCase(trim(seed.authrep_last)),    // lname,
		                    risk_indicators.nullstring,                              // ssn -- not used in business products,
		                    StringLib.StringToUpperCase(trim(seed.company_fein)),    // fein,
		                    StringLib.StringToUpperCase(trim(seed.company_zip)),     // zip,
		                    StringLib.StringToUpperCase(trim(seed.company_phone)),   // phone,
		                    StringLib.StringToUpperCase(trim(seed.company_name)));   // company_name
	  seed;
	end;
	newtable := table(seed, newrec);
	export BIID20keypart2 := index(newtable,{dataset_name,hashvalue}, {newtable}, 
							locat_Prod + '::Part2::BIID_V2');		                                          //build for Production

//==========================================================
//===           Input Echo Key - Section 3               ===
//==========================================================	
	seed := Seed_Files.BIID20_files.BIID2testseedspart3;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(
		                    StringLib.StringToUpperCase(trim(seed.authrep_first)),   // fname,
		                    StringLib.StringToUpperCase(trim(seed.authrep_last)),    // lname,
		                    risk_indicators.nullstring,                              // ssn -- not used in business products,
		                    StringLib.StringToUpperCase(trim(seed.company_fein)),    // fein,
		                    StringLib.StringToUpperCase(trim(seed.company_zip)),     // zip,
		                    StringLib.StringToUpperCase(trim(seed.company_phone)),   // phone,
		                    StringLib.StringToUpperCase(trim(seed.company_name)));   // company_name
	  seed;
	end;
	newtable := table(seed, newrec);
	export BIID20keypart3 := index(newtable,{dataset_name,hashvalue}, {newtable}, 
							locat_Prod + '::Part3::BIID_V2');		                                          //build for Production

END;