EXPORT PRCT_PROD_KeyFiles := module 
 import Seed_Files ,Data_Services, Doxie, ut,Risk_Indicators, Business_Risk_BIP,FCRA,Foreclosure_Vacancy,LNSmallBusiness;

//Export Attribute instantid //


d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_instantid',seed_files.Layout_InstantID,csv(maxlength(8192),quote('"')) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname,d.lname,d.ssn,'',d.zipcode,d.phone10,'');
	d;
end;

newtable := table(d,newrec);

 key_InstantID := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::instantid');


//Seed_Files.Key_InstantID
Export Key_Instantid1 := key_InstantID;


//Seed File Riskview
baseFile := DATASET(Data_Services.foreign_prod+ 'thor_data400::base::testseed_riskview2', Seed_Files.Layout_RiskView2, CSV(HEADING(2), separator(','), QUOTE('"')), OPT);

testSeedLayout := RECORD
	DATA16 HashValue := Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(baseFile.Name_First, LEFT, RIGHT)), StringLib.StringToUpperCase(TRIM(baseFile.Name_Last, LEFT, RIGHT)), TRIM(baseFile.SSN, LEFT, RIGHT), Risk_Indicators.nullstring, TRIM(baseFile.Zip5[1..5], LEFT, RIGHT), TRIM(baseFile.Home_Phone, LEFT, RIGHT), Risk_Indicators.nullstring);
	baseFile;
END;
testseedTable := TABLE(baseFile, testSeedLayout);

EXPORT Key_RiskView2 := INDEX(testseedTable, {TestDataTableName, HashValue}, 
																{testseedTable}, 
																// ut.foreign_dataland + 'thor_data400::key::testseed::qa::riskview2');
																Data_Services.foreign_prod+'thor_data400::key::testseed::qa::riskview2');


// Export Key_RiskView2 := Seed_Files.Key_RiskView2; 

//Seed File Fraud Point
d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_fraudpoint', Seed_Files.Layout_FraudPoint, csv);

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_FraudPoint := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::fraudpoint');




//Seed File BIID

d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_binstantid',seed_files.Layout_Bus_InstantID,csv(maxlength(15000), quote('"')) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.rep_fname,d.rep_lname,'',d.fein,d.z5,d.phone10,d.company);
	d;
end;

newtable := table(d,newrec);

export key_BInstantID := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::binstantid');
																	
				
				
// Flexid

d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_flexid', seed_files.Layout_FlexID, csv);		


newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname,d.lname,d.ssn,'',d.zipcode,d.phone10,'');
	d;
end;
newtable := table(d,newrec);

export Key_FlexID := index(newtable,{dataset_name,hashvalue},
									{newtable},
									Data_Services.foreign_prod+'thor_data400::key::testseed::qa::flexid');		
									
									
				
				
//Leed

d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_leadintegrityattributes', seed_files.Layout_LeadIntegrityAttributes, CSV(HEADING(single), QUOTE('"'), MAXLENGTH(32768)));

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_LeadIntegrityAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, 

																																						Data_Services.foreign_prod+'thor_data400::key::testseed::qa::leadintegrityattributes');


//Small business analytics


baseFile := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_smallbusinessanalytics', Seed_Files.layout_SmallBusinessAnalytics, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);

appendHashValue := RECORD
	DATA16 HashValue := Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(baseFile.Authorized_Rep_1_FName)), 
																								StringLib.StringToUpperCase(TRIM(baseFile.Authorized_Rep_1_LName)), 
																								'', 
																								TRIM(baseFile.FEIN), 
																								TRIM(baseFile.Company_ZIP5), 
																								TRIM(baseFile.Bus_Phone), 
																								StringLib.StringToUpperCase(TRIM(baseFile.Company_Name)));
	baseFile;
END;

withHashValue := TABLE(baseFile, appendHashValue);

export key_SmallBusinessAnalytics := index(withHashValue, {TestDataTableName, HashValue},
																	{withHashValue},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::smallbusinessanalytics');



// AML Risk

d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_amlriskattributesBusnV2', Seed_Files.layout_AMLRiskAttributesV2, CSV(HEADING(single), QUOTE('"')));

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID('', '', '', d.Business_TIN, d.zip, d.phone, d.Business_Name);
	d;
end;
newtable := table(d, newrec);

export key_AMLRiskAttributesBusnV2 := index(newtable,{dataset_name,hashvalue}, {newtable}, 
																																													Data_Services.foreign_prod+'thor_data400::key::testseed::qa::amlriskattributesBusnV2');



// BIID_v2 keys
 export key_BIID20keypart1 := Keyvalidation.PRCT_BIID20_keys.BIID20keypart1;
 
 export key_BIID20keypart2 := Keyvalidation.PRCT_BIID20_keys.BIID20keypart2;
 
 export key_BIID20keypart3 := Keyvalidation.PRCT_BIID20_keys.BIID20keypart3;
 



//profile booster
d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_profilebooster', Seed_Files.layout_ProfileBooster, CSV(HEADING(single), QUOTE('"')), OPT);

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zipcode, d.phone10, '');
	d;
end;
newtable := table(d, newrec);

export Key_ProfileBooster := index(newtable,{dataset_name,hashvalue}, {newtable}, 
																																					Data_Services.foreign_prod+'thor_data400::key::testseed::qa::profilebooster');



//RV attributes
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_rvattributes', Seed_Files.Layout_RVAttributes, csv(heading(single),maxlength(100000)));

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_RVAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, 
																																			Data_Services.foreign_prod+'thor_data400::key::testseed::qa::rvattributes');


//Small business Financial Exchange

baseFile := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_smallbusfinancialexchange', Seed_Files.layout_SmallBusFinancialExchange, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);

appendHashValue := RECORD
	DATA16 HashValue := Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(baseFile.Authorized_Rep_1_FName)), 
																								StringLib.StringToUpperCase(TRIM(baseFile.Authorized_Rep_1_LName)), 
																								'', 
																								TRIM(baseFile.FEIN), 
																								TRIM(baseFile.Company_ZIP5), 
																								TRIM(baseFile.Bus_Phone), 
																								StringLib.StringToUpperCase(TRIM(baseFile.Company_Name)));
	baseFile;
END;

withHashValue := TABLE(baseFile, appendHashValue);

export key_SmallBusFinancialExchange := index(withHashValue, {TestDataTableName, HashValue},
																	{withHashValue},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::smallbusfinancialexchange'); 
 
 
 
//AMLRiskAttributesv2

 
d :=  DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_amlriskattributesV2', Seed_Files.layout_AMLRiskAttributesV2, CSV(HEADING(single), QUOTE('"')));;

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.FIRST_NM, d.LAST_NM, d.Individual_SSN, '',  d.zip, d.phone,'');
	d;
end;
newtable := table(d, newrec);

export key_AMLRiskAttributesV2 := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::amlriskattributesV2');



//AMLriskattributesV1

d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_amlriskattributes', KeyValidation.TestSeedLayout, CSV(HEADING(single), QUOTE('"')));

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.FIRST_NM, d.LAST_NM, d.Individual_TIN, '',  d.zip, d.phone,'');
	d;
end;
newtable := table(d, newrec);

export Key_AMLRiskAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::amlriskattributes');



//AML Risk attributes Busn V1
d :=  DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_amlriskattributesbusn', KeyValidation.TestSeedLayout, CSV(HEADING(single), QUOTE('"')));

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID('', '', '', d.Business_TIN, d.zip, d.phone, d.Business_Name);
	d;
end;
newtable := table(d, newrec);

export Key_AMLRiskAttributesBusn := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::amlriskattributesbusn');



//BusinessDefender

d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_businessdefender',seed_files.Layout_BusinessDefender,csv);

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.rep_fname,d.rep_lname,'',d.fein,d.z5,d.phone10,d.company_name);
	d;
end;

newtable := table(d,newrec);

export key_BusinessDefender := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::businessdefender');


// redflags

d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_redflags',seed_files.Layout_RedFlags,csv);

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID((string20)d.fname,(string20)d.lname,
																								 (string9)d.ssn,Risk_Indicators.nullstring,
																								 (string5)d.zipcode,(string10)d.phone10,Risk_Indicators.nullstring);
	d;
end;


newtable := table(d,newrec);

export key_redflags := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::redflags');	
																	


// RV_Scores
d :=  dataset(Data_Services.foreign_prod+ 'thor_data400::base::testseed_riskview', seed_files.Layout_RiskView, csv(quote('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_RiskView := index(newtable,{dataset_name,hashvalue}, {newtable},Data_Services.foreign_prod+'thor_data400::key::testseed::qa::riskview');



// SBFE Models

baseFile := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_smallbusmodels', Seed_Files.layout_SmallBusModels, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);

appendHashValue := RECORD
	DATA16 HashValue := Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(baseFile.authrepfirst)), 
																								StringLib.StringToUpperCase(TRIM(baseFile.authreplast)), 
																								'', 
																								TRIM(baseFile.fein), 
																								TRIM(baseFile.cmpyzip5), 
																								TRIM(baseFile.cmpyphone), 
																								StringLib.StringToUpperCase(TRIM(baseFile.companyname)));
	baseFile;
END;

withHashValue := TABLE(baseFile, appendHashValue);

export key_SmallBusModels := index(withHashValue, {tablename, HashValue},
																	{withHashValue},
																	Data_Services.foreign_prod+ 'thor_data400::key::testseed::qa::smallbusmodels');
																	// UT.foreign_dataland + 'thor_data400::key::testseed::qa::smallbusmodels');



// OrderScoring
d :=  dataset( Data_Services.foreign_prod+'thor_data400::base::testseed_OS', Seed_Files.Layout_OS, csv(quote('"')) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.social, ''/*fein*/, d.zip, d.homephone, ''/*cmpy name*/);
	d;
end;

newtable := table(d, newrec);

export Key_OS := index(newtable,{table_name, hashvalue}, {newtable}, 
	Data_Services.foreign_prod +'thor_data400::key::testseed::qa::os');



// OrderScoring_Att
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_OSAttributes', Seed_Files.Layout_OSAttributes, csv(maxlength(20000)));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.social, '', d.zip, d.homephone, '');
	d;
end;

newtable := table(d, newrec);

export Key_OSAttributes := index(newtable,{table_name,hashvalue}, {newtable}, 
	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::osattributes');



// ChargeBackDefender
d :=  dataset( Data_Services.foreign_prod+'thor_data400::base::testseed_cbd', Seed_Files.layout_cbd, csv(quote('"')) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.first, d.last, d.social, ''/*fein*/, d.zip, d.homephone, ''/*cmpy name*/);
	d;
end;

newtable := table(d, newrec);

export Key_CBD := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::cbd');



// ChargeBackDefender_Attr
d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_cbdattributes', Seed_Files.Layout_CBDAttributes, csv(maxlength(20000)));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;

newtable := table(d, newrec);

export Key_CBDAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::cbdattributes');



// BS_SvcsAddrHistory
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_bs_services_iid_address_history', seed_files.Layout_BS_Services, csv(quote('"'), maxlength(10000)) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname,d.lname,d.ssn,'',d.zipcode,d.phone10,'');
	d;
end;
 
newtable := table(d,newrec);

export Key_BS_Services := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::bs_services_iid_address_history');
																	// ut.foreign_dataland + 'thor_data400::key::testseed::qa::bs_services_iid_address_history');



// PhoneHistoryRpt
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_fcra_gonghistory', fcra.GongHistoryLayouts.Layout_TestSeed, csv(heading(single), quote('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;

newtable := table(d, newrec);

export Key_FCRA_GongHistory := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::fcragonghistory');



// ForeClosureVacancy_Interactive
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_FOVInteractive', Foreclosure_Vacancy.layouts.Final_Interactive_seed, csv(heading(1), separator(',')) );

newrec := record
	data16 hashvalue := foreclosure_vacancy.functions.Hash_FOV(d.first_name_in, d.last_name_in, d.street_address_in, d.zip_in);
	d;
end;

newtable := table(d, newrec);

export Key_FOVInteractive :=index(newtable,{hashvalue,dataset_name},
																	{newtable},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::FOV_Interactive');




// ForeClosureVacancy_Renewal
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_FOVRenewal', Foreclosure_Vacancy.layouts.Final_Renewal_seed, csv(heading(1), separator(',')) );

newrec := record
	data16 hashvalue := foreclosure_vacancy.functions.Hash_FOV(d.first_name_in, d.last_name_in, d.street_address_in, d.zip_in);
	d;
end;

newtable := table(d, newrec);

export Key_FOVRenewal :=index(newtable,{hashvalue,dataset_name},
																	{newtable},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::FOV_Renewal');



// FraudDefender
d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_frauddefender',seed_files.Layout_FraudDefender,csv);

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID((string20)d.fname,(string20)d.lname,
																								 (string9)d.ssn,Risk_Indicators.nullstring,
																								 (string5)d.zipcode,(string10)d.phone10,Risk_Indicators.nullstring);
	d;
end;

newtable := table(d, newrec);

export Key_frauddefender :=index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::frauddefender');



// HealthCareAttributes
d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_healthcareattributes', KeyValidation.HealthCareAttributesLayout, CSV(HEADING(single), QUOTE('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zipcode, d.phone10, '');
	d;
end;

newtable := table(d, newrec);

export Key_HealthCareAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::healthcareattributes');



// Identifier2
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_identifier2', seed_files.layout_identifier2, csv(quote('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.name_first,d.name_last,d.ssn,'',d.zip5,d.home_phone,'');
	d;
end;

newtable := table(d, newrec);

export Key_Identifier2 := index(newtable,{table_name,hashvalue},
                                  {newtable},
																	Data_Services.foreign_prod+'thor_data400::key::testseed::qa::identifier2');
																	


// Fraud Attributes 
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_fdattributes', seed_files.Layout_FDAttributes, csv(heading(single), maxlength(12000)));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;

newtable := table(d, newrec);
export Key_FDAttributes := index(newtable,{dataset_name,hashvalue}, {newtable},Data_Services.foreign_prod+'thor_data400::key::testseed::qa::fdattributes');



// IID Intl GG2
d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_intliid_gg2',
	seed_files.Layout_IntlIID_GG2,csv(separator('\t'),heading(1), quote('\"'), maxlength(10000), unicode))(DatasetName!='Table_name');

newRec := RECORD,MAXLENGTH(10000)
	DATA16 hashvalue := seed_files.Hash_IntlIID(d.hashFirstName,d.hashLastName,d.hashNationalID,d.hashPostalCode,d.hashTelephone);
	d;
END;

newtable := table(d, newrec);

export Key_IntlIID_GG2 := INDEX(newTable,{DatasetName,hashvalue},{newTable},
													Data_Services.foreign_prod+'thor_data400::key::testseed::qa::intliid_gg2');



// LNSamllBusinessScore
d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_LNSmallBusiness', LNSmallBusiness.Layouts.Testseeds, csv);

seed_layout := record
	data16 hashvalue := seed_files.Hash_InstantID(
		StringLib.StringToUpperCase(trim(d.rep_first)),   // fname,
		StringLib.StringToUpperCase(trim(d.rep_last)),    // lname,
		'',                  // ssn -- not used in business products,
		StringLib.StringToUpperCase(trim(d.bus_fein)),    // fein,
		StringLib.StringToUpperCase(trim(d.bus_zip5)),    // zip,
		StringLib.StringToUpperCase(trim(d.bus_phone10)), // phone,
		StringLib.StringToUpperCase(trim(d.bus_name))     // company_name
	);  
	d;
end;

withHash := table(d, seed_layout);

export Key_LNSmallBusiness :=index(withHash,{hashvalue}, {withHash}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::lnsmallbusiness');


// RiskviewDerogsReport
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_riskview_derogs', fcra.RiskView_Derogs_Module.seed_layout, csv(heading(single), quote('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_RVderogs := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::rvderogs');


// Verification of Occupancy
d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_verificationofoccupancy', Seed_Files.layout_VerificationOfOccupancy, CSV(HEADING(single), QUOTE('"')), OPT);

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zipcode, d.phone10, '');
	d;
end;

newtable := table(d, newrec);
export Key_VerificationOfOccupancy :=index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_prod+'thor_data400::key::testseed::qa::verificationofoccupancy');
		
		
 end;