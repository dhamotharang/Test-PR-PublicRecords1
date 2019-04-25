EXPORT PRCT_PROD_ParentFiles := Module

import Seed_Files ,Data_Services, Doxie, ut, Risk_Indicators,lib_stringlib, Business_Risk_BIP,FCRA,Foreclosure_Vacancy,LNSmallBusiness;

isDev := true;

//InstantID Base file 
d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_instantid',seed_files.Layout_InstantID,csv(maxlength(8192),quote('"')) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname,d.lname,d.ssn,'',d.zipcode,d.phone10,'');
	d;
end;
Export ParentFile_Keyprct_instantid := table(d,newrec);


//RiskView2
baseFile := DATASET(Data_Services.foreign_prod+ 'thor_data400::base::testseed_riskview2', Seed_Files.Layout_RiskView2, CSV(HEADING(2), separator(','), QUOTE('"')), OPT);

testSeedLayout := RECORD
	DATA16 HashValue := Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(baseFile.Name_First, LEFT, RIGHT)), StringLib.StringToUpperCase(TRIM(baseFile.Name_Last, LEFT, RIGHT)), TRIM(baseFile.SSN, LEFT, RIGHT), Risk_Indicators.nullstring, TRIM(baseFile.Zip5[1..5], LEFT, RIGHT), TRIM(baseFile.Home_Phone, LEFT, RIGHT), Risk_Indicators.nullstring);
	baseFile;
END;
Export ParentFile_Keyprct_RiskView2 := TABLE(baseFile, testSeedLayout);


//FraudPoint

d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_fraudpoint', seed_files.Layout_FraudPoint, csv);

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
Export ParentFile_Keyprct_FraudPoint := table(d, newrec);



//BIID

d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_binstantid',seed_files.Layout_Bus_InstantID,csv(maxlength(15000), quote('"')) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.rep_fname,d.rep_lname,'',d.fein,d.z5,d.phone10,d.company);
	d;
end;

Export ParentFile_Keyprct_Binstantid := table(d,newrec);



//Flexid
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_flexid', seed_files.Layout_FlexID, csv);	

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname,d.lname,d.ssn,'',d.zipcode,d.phone10,'');
	d;
end;
newtable := table(d,newrec);

export ParentFile_Keyprct_FlexID := newtable;



//LeadIntegrityAttributes;
d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_leadintegrityattributes', seed_files.Layout_LeadIntegrityAttributes, CSV(HEADING(single), QUOTE('"'), MAXLENGTH(32768)));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
export ParentFile_Keyprct_LeadIntegrityAttributes := table(d, newrec);



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

export ParentFile_keyPRCT_SmallBusinessAnalytics := TABLE(baseFile, appendHashValue);


// AML Risk Business

d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_amlriskattributesBusnV2', Seed_Files.layout_AMLRiskAttributesV2, CSV(HEADING(single), QUOTE('"')));

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID('', '', '', d.Business_TIN, d.zip, d.phone, d.Business_Name);
	d;
end;
export ParentFile_keyPRCT_AMLRiskAttributesBusnV2 := table(d, newrec);



//profile booster
d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_profilebooster', Seed_Files.layout_ProfileBooster, CSV(HEADING(single), QUOTE('"')), OPT);

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zipcode, d.phone10, '');
	d;
end;
export ParentFile_KeyPRCT_ProfileBooster := table(d, newrec);



//RV attributes
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_rvattributes', Seed_Files.Layout_RVAttributes, csv(heading(single),maxlength(100000)));

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
export ParentFile_KeyPRCT_RVAttributes := table(d, newrec);



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

export ParentFile_KeyPRCT_SmallBusFinancialExchange := TABLE(baseFile, appendHashValue);



//AMLRisk
d  := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_amlriskattributesV2', Seed_Files.layout_AMLRiskAttributesV2, CSV(HEADING(single), QUOTE('"')));;

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.FIRST_NM, d.LAST_NM, d.Individual_SSN, '',  d.zip, d.phone,'');
	d;
end;
export ParentFile_KeyPRCT_AMLRiskAttributesV2 := table(d, newrec);



//AMLriskattributesV1

d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_amlriskattributes', KeyValidation.TestSeedLayout, CSV(HEADING(single), QUOTE('"')));

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.FIRST_NM, d.LAST_NM, d.Individual_TIN, '',  d.zip, d.phone,'');
	d;
end;


export ParentFile_KeyPRCT_AMLRiskAttributes := table(d,newrec);



//AML Risk attributes Busn V1
d :=  DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_amlriskattributesbusn', KeyValidation.TestSeedLayout, CSV(HEADING(single), QUOTE('"')));

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID('', '', '', d.Business_TIN, d.zip, d.phone, d.Business_Name);
	d;
end;


export ParentFile_KeyPRCT_AMLRiskAttributesBusn := table(d,newrec);



//BusinessDefender

d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_businessdefender',seed_files.Layout_BusinessDefender,csv);

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.rep_fname,d.rep_lname,'',d.fein,d.z5,d.phone10,d.company_name);
	d;
end;


export ParentFile_KeyPRCT_BusinessDefender := table(d,newrec);


// redflags

d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_redflags',seed_files.Layout_RedFlags,csv);

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID((string20)d.fname,(string20)d.lname,
																								 (string9)d.ssn,Risk_Indicators.nullstring,
																								 (string5)d.zipcode,(string10)d.phone10,Risk_Indicators.nullstring);
	d;
end;

export ParentFile_KeyPRCT_redflags := table(d,newrec);



// RV_Attributes
// d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_rvattributes', seed_files.Layout_RVAttributes, csv(heading(single),maxlength(100000)));

// newrec := record
	// data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	// d;
// end;

// export ParentFile_keyPRCT_RVAttributes  := table(d,newrec);



// RV_Scores

d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_riskview', seed_files.Layout_RiskView, csv(quote('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;

export ParentFile_keyPRCT_RiskView := table(d, newrec);



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

export ParentFile_keyPRCT_SmallBusModels := TABLE(baseFile, appendHashValue);



//BIIDV2 part 1
baseFile := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_part1_biid_v2', Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout1,  CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);
newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(
											StringLib.StringToUpperCase(trim(baseFile.authrep_first)),   // fname,
											StringLib.StringToUpperCase(trim(baseFile.authrep_last)),    // lname,
											risk_indicators.nullstring,                              // ssn -- not used in business products,
											StringLib.StringToUpperCase(trim(baseFile.company_fein)),    // fein,
											StringLib.StringToUpperCase(trim(baseFile.company_zip)),     // zip,
											StringLib.StringToUpperCase(trim(baseFile.company_phone)),   // phone,
											StringLib.StringToUpperCase(trim(baseFile.company_name)));   // company_name
	baseFile;
end;
export ParentFile_keyPRCT_BIID20keypart1 := table(baseFile, newrec);


//BIIDV2 part 2
baseFile := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_part2_biid_v2', Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout2,  CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);
newrec2 := record
	data16 hashvalue := seed_files.Hash_InstantID(
											StringLib.StringToUpperCase(trim(baseFile.authrep_first)),   // fname,
											StringLib.StringToUpperCase(trim(baseFile.authrep_last)),    // lname,
											risk_indicators.nullstring,                              // ssn -- not used in business products,
											StringLib.StringToUpperCase(trim(baseFile.company_fein)),    // fein,
											StringLib.StringToUpperCase(trim(baseFile.company_zip)),     // zip,
											StringLib.StringToUpperCase(trim(baseFile.company_phone)),   // phone,
											StringLib.StringToUpperCase(trim(baseFile.company_name)));   // company_name
	baseFile;
end;
export ParentFile_keyPRCT_BIID20keypart2:= table(baseFile, newrec2);


//BIIDV2 part 3
baseFile := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_part3_biid_v2', Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout3,  CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);
newrec3 := record
	data16 hashvalue := seed_files.Hash_InstantID(
											StringLib.StringToUpperCase(trim(baseFile.authrep_first)),   // fname,
											StringLib.StringToUpperCase(trim(baseFile.authrep_last)),    // lname,
											risk_indicators.nullstring,                              // ssn -- not used in business products,
											StringLib.StringToUpperCase(trim(baseFile.company_fein)),    // fein,
											StringLib.StringToUpperCase(trim(baseFile.company_zip)),     // zip,
											StringLib.StringToUpperCase(trim(baseFile.company_phone)),   // phone,
											StringLib.StringToUpperCase(trim(baseFile.company_name)));   // company_name
	baseFile;
end;
export ParentFile_keyPRCT_BIID20keypart3:= table(baseFile, newrec3);




// SBFE Attributes

baseFile := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_smallbusfinancialexchange', Seed_Files.layout_SmallBusFinancialExchange, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);
// appendHashValue := RECORD
	// DATA16 HashValue := Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(baseFile.Authorized_Rep_1_FName)), 
																								// StringLib.StringToUpperCase(TRIM(baseFile.Authorized_Rep_1_LName)), 
																								// '', 
																								// TRIM(baseFile.FEIN), 
																								// TRIM(baseFile.Company_ZIP5), 
																								// TRIM(baseFile.Bus_Phone), 
																								// StringLib.StringToUpperCase(TRIM(baseFile.Company_Name)));
	// baseFile;
// END;

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

export ParentFile_key_SBFEAttributes := TABLE(baseFile, appendHashValue);





// OrderScoring
d :=  dataset( Data_Services.foreign_prod+'thor_data400::base::testseed_OS', Seed_Files.Layout_OS, csv(quote('"')) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.social, ''/*fein*/, d.zip, d.homephone, ''/*cmpy name*/);
	d;
end;

export ParentFile_keyPRCT_OS := table(d, newrec);



// OrderScoring_Att
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_OSAttributes', Seed_Files.Layout_OSAttributes, csv(maxlength(20000)));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.social, '', d.zip, d.homephone, '');
	d;
end;
export ParentFile_keyPRCT_OSAttributes :=table(d, newrec);



// ChargeBackDefender
d :=  dataset( Data_Services.foreign_prod+'thor_data400::base::testseed_cbd', Seed_Files.layout_cbd, csv(quote('"')) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.first, d.last, d.social, ''/*fein*/, d.zip, d.homephone, ''/*cmpy name*/);
	d;
end;

export ParentFile_keyPRCT_CBD :=table(d, newrec);



// ChargeBackDefender_Attr
d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_cbdattributes', Seed_Files.Layout_CBDAttributes, csv(maxlength(20000)));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;

export ParentFile_keyPRCT_CBDAttributes :=table(d, newrec);



// BS_SvcsAddrHistory
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_bs_services_iid_address_history', seed_files.Layout_BS_Services, csv(quote('"'), maxlength(10000)) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname,d.lname,d.ssn,'',d.zipcode,d.phone10,'');
	d;
end;
 
export ParentFile_keyPRCT_BS_Services :=table(d,newrec);



// PhoneHistoryRpt
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_fcra_gonghistory', fcra.GongHistoryLayouts.Layout_TestSeed, csv(heading(single), quote('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;

export ParentFile_keyPRCT_FCRA_GongHistory :=table(d, newrec);



// ForeClosureVacancy_Interactive
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_FOVInteractive', Foreclosure_Vacancy.layouts.Final_Interactive_seed, csv(heading(1), separator(',')) );

newrec := record
	data16 hashvalue := foreclosure_vacancy.functions.Hash_FOV(d.first_name_in, d.last_name_in, d.street_address_in, d.zip_in);
	d;
end;

export ParentFile_keyPRCT_FOVInteractive :=table(d,newrec);



// ForeClosureVacancy_Renewal
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_FOVRenewal', Foreclosure_Vacancy.layouts.Final_Renewal_seed, csv(heading(1), separator(',')) );

newrec := record
	data16 hashvalue := foreclosure_vacancy.functions.Hash_FOV(d.first_name_in, d.last_name_in, d.street_address_in, d.zip_in);
	d;
end;

export ParentFile_keyPRCT_FOVRenewal :=table(d,newrec);



// FraudDefender
d :=  dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_frauddefender',seed_files.Layout_FraudDefender,csv);

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID((string20)d.fname,(string20)d.lname,
																								 (string9)d.ssn,Risk_Indicators.nullstring,
																								 (string5)d.zipcode,(string10)d.phone10,Risk_Indicators.nullstring);
	d;
end;

export ParentFile_keyPRCT_frauddefender :=table(d,newrec);



// HealthCareAttributes
d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_healthcareattributes', KeyValidation.HealthCareAttributesLayout, CSV(HEADING(single), QUOTE('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zipcode, d.phone10, '');
	d;
end;

export ParentFile_keyPRCT_HealthCareAttributes :=  table(d, newrec);



// Identifier2
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_identifier2', seed_files.layout_identifier2, csv(quote('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.name_first,d.name_last,d.ssn,'',d.zip5,d.home_phone,'');
	d;
end;

export ParentFile_keyPRCT_Identifier2 := table(d,newrec);



// Fraud Attributes 
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_fdattributes', seed_files.Layout_FDAttributes, csv(heading(single), maxlength(12000)));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
export ParentFile_keyPRCT_FDAttributes := table(d, newrec);



// IID Intl GG2
d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_intliid_gg2',
	seed_files.Layout_IntlIID_GG2,csv(separator('\t'),heading(1), quote('\"'), maxlength(10000), unicode))(DatasetName!='Table_name');

newRec := RECORD,MAXLENGTH(10000)
	DATA16 hashvalue := seed_files.Hash_IntlIID(d.hashFirstName,d.hashLastName,d.hashNationalID,d.hashPostalCode,d.hashTelephone);
	d;
END;
export ParentFile_keyPRCT_IntlIID_GG2 :=table(d, newrec);



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

export ParentFile_keyPRCT_LNSmallBusiness :=table(d, seed_layout);



// RiskviewDerogsReport
d := dataset(Data_Services.foreign_prod+'thor_data400::base::testseed_riskview_derogs', fcra.RiskView_Derogs_Module.seed_layout, csv(heading(single), quote('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
export ParentFile_keyPRCT_RVderogs :=table(d, newrec);



// Verification of Occupancy
d := DATASET(Data_Services.foreign_prod+'thor_data400::base::testseed_verificationofoccupancy', Seed_Files.layout_VerificationOfOccupancy, CSV(HEADING(single), QUOTE('"')), OPT);

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zipcode, d.phone10, '');
	d;
end;
export ParentFile_keyPRCT_VerificationOfOccupancy :=table(d, newrec);

end;