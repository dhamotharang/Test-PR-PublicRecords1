
IMPORT Data_Services, ut, doxie, risk_indicators;

 
EXPORT BusinessCreditReport_keys := MODULE

  shared BUILD_KEY_TEST := FALSE;

	shared middle_name := 'testseed::' + doxie.Version_SuperKey + '::businesscreditreport::';
	
//==========================================
//===  configuration variables  for test === 
//========================================== 
	shared file_prefix_Test := '~LaureF3'; 
  shared locat_Test := ut.foreign_dataland + file_prefix_Test + '::key::' + middle_name;
//==========================================
//===  configuration variables  for prod === 
//==========================================  
	shared file_prefix_Prod := 'thor_data400';	
	shared locat_Prod := Data_Services.Data_location.Prefix('BCRTestSeed') + file_prefix_Prod + '::key::' + middle_name;

//==========================================================
//===           Input Echo Key - Section 1               ===
//==========================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section1;
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
	export InputEcho := index(newtable,{dataset_name,hashvalue}, {newtable}, 
	         #if(BUILD_KEY_TEST)
							locat_Test + 'InputEcho_' + thorlib.wuid());                            //build for Testing 
					 #else
							locat_Prod + 'InputEcho');		                                          //build for Production
					 #end

//==========================================================
//===           Best Info  Key - Section 2               ===
//==========================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section2;
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
	export BestInfo := index(newtable,{dataset_name,hashvalue}, {newtable}, 
	          #if(BUILD_KEY_TEST)
							 locat_Test + 'BestInfo_' + thorlib.wuid());                          //for Testing 
						#else
							 locat_Prod + 'BestInfo');                                             //for Production  									
            #end
											
//==========================================================
//===           Scoring  Key - Section 3                 ===
//==========================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section3;
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
	export Scoring := index(newtable,{dataset_name,hashvalue}, {newtable}, 
	          #if(BUILD_KEY_TEST)
							 locat_Test + 'Scoring_' + thorlib.wuid());                            //for Testing  
						#else
							 locat_Prod + 'Scoring');		                                           //for Production							
						#end
						
//==========================================================
//===           Summary  Key - Section 4                 ===
//==========================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section4;
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
	export Summary := index(newtable,{dataset_name,hashvalue}, {newtable}, 
	          #if(BUILD_KEY_TEST)
								locat_Test + 'Summary_' + thorlib.wuid());                            //for Testing 
						#else
							  locat_Prod + 'Summary');                         		                  //for Production							
						#end 					  

//==========================================================
//===   Owner Guarantor  Key - Section 5                 ===
//==========================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section5;
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
	export OwnGuartor := index(newtable,{dataset_name,hashvalue}, {newtable}, 
	           #if(BUILD_KEY_TEST)
								 locat_Test + 'OwnGuartor_' + thorlib.wuid());                         //for Testing 
						 #else
								 locat_Prod + 'OwnGuartor');			                                       //for Production 						
						 #end  					  
 
//==========================================================
//===   Top Business Bankrupcy  Key - Section 6          ===
//==========================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section6;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(
		                    StringLib.StringToUpperCase(trim(seed.authrep_first)),   // fname,
		                    StringLib.StringToUpperCase(trim(seed.authrep_last)),    // lname,
		                    risk_indicators.nullstring,                              // ssn -- not used in business products,
		                    StringLib.StringToUpperCase(trim(seed.company_fein)),    // fein,
		                    StringLib.StringToUpperCase(trim(seed.company_zip)),     // zip,
		                    StringLib.StringToUpperCase(trim(seed.company_phone)),   // phone,
		                    StringLib.StringToUpperCase(trim(seed.company_name)));    // company_name
	  seed;
	end;
	newtable := table(seed, newrec);
	export TopBusBankr := index(newtable,{dataset_name,hashvalue}, {newtable},
	          #if(BUILD_KEY_TEST)
								locat_Test + 'Bankruptcy_' + thorlib.wuid());                          //for Testing 
						#else
								locat_Prod + 'Bankruptcy');                          			             //for Production	
						#end 

 
//=======================================================
//===   Top Bus Liens   Key - Section 7               ===
//=======================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section7;
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
	export TopBusLiens := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusLiens_' + thorlib.wuid());                          //for Testing 
						#else
								locat_Prod + 'TopBusLiens');			                                        //for Production	
						#end 

											  											  
 
//=======================================================
//===   Top Bus UCC   Key - Section 8                 ===
//=======================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section8;
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
	export TopBusUCC := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusUCC_' + thorlib.wuid());                          //for Testing 
						#else
								locat_Prod + 'TopBusUCC');			                                        //for Production	
						#end 

 
//=======================================================
//===  Top Bus Property    Key - Section 9            ===
//=======================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section9;
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
	export TopBusProp := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusProp_' + thorlib.wuid());                           //for Testing 
						#else
								locat_Prod + 'TopBusProp');	                          		              //for Production	
						#end 	 

//=======================================================
//===  Top Bus Motor Vehicle    Key - Section 10      ===
//=======================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section10;
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
	export TopBusMV := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusmvehicle_' + thorlib.wuid());                           //for Testing 
						#else
								locat_Prod + 'TopBusmvehicle');	                          		              //for Production	
						#end 	 

	
//====================================================
//===   Top Bus Watercraft   Key - Section 11      ===
//====================================================
	seed := Seed_Files.BusinessCreditReports_files.Section11;
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
	export TopBusWCraft := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusWCraft_' + thorlib.wuid());                           //for Testing 
						#else
								locat_Prod + 'TopBusWCraft');			                                        //for Production	
						#end 	

	
//=======================================================
//===   Top Bus Aircraft   Key - Section 12           ===
//=======================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section12;
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
	export TopBusACraft := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusACraft_' + thorlib.wuid());                           //for Testing 
						#else
								locat_Prod + 'TopBusACraft');			                                        //for Production	
						#end 	
						
	
//==================================================
//===   Top Bus License   Key - Section 13       ===
//==================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section13;
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
	export TopBusLic := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusLicense_' + thorlib.wuid());                          //for Testing 
						#else
								locat_Prod + 'TopBusLicense');			                                        //for Production	
						#end 				 
											
											
//=====================================================
//===    Top Bus Incorporation   Key - Section 14   ===
//=====================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section14;
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
	export TopBusIncorp := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusIncorp_' + thorlib.wuid());                          //for Testing 
						#else
								locat_Prod + 'TopBusIncorp');			                                       //for Production	
						#end 				 


//=====================================================
//=== Top Bus Operations Sites   Key - Section 15   ===
//=====================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section15;
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
	export TopBusOperSites := index(newtable,{dataset_name,hashvalue}, {newtable}, 	
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusOper_' + thorlib.wuid());                          //for Testing 
						#else
								locat_Prod + 'TopBusOper');			                                       //for Production	
						#end 				 


//=====================================================
//===   Top Bus Parent   Key - Section 16   ===
//=====================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section16;
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
	export TopBusParent := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusParent_' + thorlib.wuid());                           //for Testing 
						#else
								locat_Prod + 'TopBusParent');			                                        //for Production	
						#end 		

//=====================================================
//===   Top Business Connected    Key - Section 17  ===
//=====================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section17;
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
	export TopBusConnected := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusConnect_' + thorlib.wuid());                           //for Testing 
						#else
								locat_Prod + 'TopBusConnect');			                                         //for Production	
						#end 		

		
//=====================================================
//===  Top Bus Contactst   Key - Section 18         === 
//=====================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section18;
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
	export TopBusContacts := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusContact_' + thorlib.wuid());                           //for Testing 
						#else
								locat_Prod + 'TopBusContact');			                                         //for Production	
						#end 		

//=====================================================
//===  Other   Key - Section 19                     ===
//=====================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section19;
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
	export FinalSect := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'TopBusActivity_' + thorlib.wuid());                           //for Testing 
						#else
								locat_Prod + 'TopBusActivity');			                                        //for Production	
						#end 		

//=====================================================
//===  Other   Key - Section 20                     ===
//=====================================================	
	seed := Seed_Files.BusinessCreditReports_files.Section20;
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
	export MatchInfo := index(newtable,{dataset_name,hashvalue}, {newtable}, 
						#if(BUILD_KEY_TEST)
								locat_Test + 'MatchInfo_' + thorlib.wuid());                           //for Testing 
						#else
								locat_Prod + 'MatchInfo');			                                        //for Production	
						#end 								
	
	
END;
 
