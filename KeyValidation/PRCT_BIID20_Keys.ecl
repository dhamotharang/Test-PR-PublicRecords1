
IMPORT Data_Services, ut, doxie, risk_indicators,Seed_Files ,doxie, iesp, BusinessInstantID20_Services;

 
EXPORT PRCT_BIID20_Keys := MODULE

SHARED max15k := 15000;
	SHARED max25k := 25000;
	 
//===============================================
//===   set the prefix and middle name of the ===
//===   super file name of the test seed files===
//===============================================

//==========================================================
//===           Layout section 1 part1              ===
//==========================================================	
	
	export BIID2testseedspart1 := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_part1_biid_v2', 
        Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout1, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max15k)));


//==========================================================
//===        Layout section 2 part2              ===
//==========================================================	
	
	export BIID2testseedspart2 := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_part2_biid_v2', 
        Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout2, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max25k)));


//==========================================================
//===            Layout section 3 part3              ===
//==========================================================	
	
	export BIID2testseedspart3 := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_part3_biid_v2', 
        Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout3, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max15k)));








	shared middle_name := 'testseed::' + doxie.Version_SuperKey;
	
//==========================================
//===  configuration variables  for prod === 
//==========================================  
	shared file_prefix_Prod := 'thor_data400';
	// shared locat_Prod := '~' + file_prefix_Prod + '::key::' + middle_name;
	shared locat_Prod := Data_Services.foreign_prod + file_prefix_Prod + '::key::' + middle_name;

//==========================================================
//===           Input Echo Key - Section 1               ===
//==========================================================	
	seed := BIID2testseedspart1;
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


seed := BIID2testseedspart1;
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

	export BIID20parentpart1 := table(seed, newrec);
	
//==========================================================
//===           Input Echo Key - Section 2               ===
//==========================================================	
	seed := BIID2testseedspart2;
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
	seed := BIID2testseedspart2;
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
	export BIID20parentpart2 :=  table(seed, newrec);

//==========================================================
//===           Input Echo Key - Section 3               ===
//==========================================================	
	seed := BIID2testseedspart3;
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
		export BIID20parentpart3 := table(seed, newrec);
	seed := BIID2testseedspart3;
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