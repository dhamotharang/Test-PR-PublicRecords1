
IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT, Scoring_Project_Macros, Scoring_Project_Refresh_Samples, zz_Koubsky_SALT, SALT23;

EXPORT FCRA_New_Samples_Logs := module
shared eyeball := 100;


shared Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure Rearrange(Scoring_Project_Refresh_Samples.New_Samples_layouts.output_structure l, integer c) := TRANSFORM
	self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  	
	self.zip := l.zip[1..5];
	self.homephone := if(l.homephone[1] = '0', '', l.homephone);
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self := l;
  self := [];
END;


//RV experain v3 xml*********************************************************************************************

EXPORT FCRA_New_Samples_Logs_experian (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout) experianv3, dataset(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure) OriginalDataExperian, string FileoutExperian) := FUNCTION 

FindMaxAccountExperian := choosen(sort(OriginalDataExperian, -accountnumber), 5);
MaxAccounExperian := max(FindMaxAccountExperian, accountnumber);

filteredSSNExperian := experianv3(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));

filteredzipExperian := filteredSSNExperian(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));


goodinfoExperian := filteredzipExperian(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and ssn != '0000' and ssn[1..8] != '00000000' and ssn[1..7] != '0000000' and ssn[1..6] != '000000');										

DedupedDataExperian := dedup(goodinfoExperian, SSN, all); //sorted by ssn since all blank ssn's have been removed;


keepers0Experian := OriginalDataExperian(perm_flag = 0);
keepers1Experian := OriginalDataExperian(perm_flag = 1);
keepers2Experian := OriginalDataExperian(perm_flag = 2);
keepers3Experian := OriginalDataExperian(perm_flag = 3);
keepers4Experian := OriginalDataExperian(perm_flag = 4);

keepersExperian := sort(keepers0Experian+keepers2Experian+keepers3Experian+keepers4Experian, accountnumber);

Reflagged_LogsExperian := project(keepersExperian, Rearrange(left, counter));


Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure format_themExperian(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout l, integer c) := Transform
	self.Date_added := (Integer)ut.getdate;
	self.streetaddress := l.Address;
		self.customer := 'Experian';
	self.source_info := 'Riskview_XML_Logs';
	self.dateofbirth := l.dob;
	self.Perm_Flag := 4;
	// self.AccountNumber := c + (integer)MaxAccounExperian;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
		self:=[];
End;

Formatted_NewExperian := project(DedupedDataExperian, format_themExperian(left, counter));

New_rightExperian := join(Reflagged_LogsExperian, Formatted_NewExperian,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
new_large_sampleExperian := Reflagged_LogsExperian + New_rightExperian; //add "new_right" to old dataset;

sort_large_sampleExperian := Sort(new_large_sampleExperian, ssn, Date_added); //sort by date added for dedup


deduped_newExperian := sort_large_sampleExperian(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
dedupoldExperian:= sort_large_sampleExperian(Date_added <> (Integer)ut.getdate);

ut.MAC_Pick_Random(deduped_newExperian,New_5000Experian,5000);   //grabs 5000 of new deduped rocrods;

Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure add_acctBExperian(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccounExperian;
	self:= le;
	self:= [];
End;

Formatted_acct_NewExperian := project(New_5000Experian, add_acctBExperian(left, counter));

New_Test_SampleExperian := dedupoldExperian + Formatted_acct_NewExperian ;


Sorted_SampleExperian := Sort(New_Test_SampleExperian, perm_flag, date_added);
// finalExperian := OUTPUT(choosen(Sorted_SampleExperian, all));


finalExperian := OUTPUT(choosen(Sorted_SampleExperian, 25000),,FileoutExperian, thor, overwrite);
finalExperian_salt := choosen(Sorted_SampleExperian, 25000);

zz_Koubsky_SALT.mac_profile(finalExperian_salt); 
return finalExperian;

end;

//RV generic v3 v4 v5 sample*************************************************************************************

EXPORT FCRA_New_Samples_Logs_RVGeneric (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout) fullinputRVGeneric, 
dataset(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure) OriginalDataRVGeneric, string FileoutRVGeneric) := FUNCTION 

FindMaxAccountRVGeneric := choosen(sort(OriginalDataRVGeneric, -accountnumber), 5);
MaxAccountRVGeneric := max(FindMaxAccountRVGeneric, accountnumber);

filteredSSNRVGeneric := fullinputRVGeneric(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzipRVGeneric := filteredSSNRVGeneric(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));


goodinfoRVGeneric := filteredzipRVGeneric(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											and state != '' and zip != '' and zip != '00000'  and ssn != '000000000' and ssn != '0000' and ssn <> '' and dob != '' );

// filter_generic := goodinfoRVGeneric();

DedupedDataRVGeneric := dedup(goodinfoRVGeneric, SSN, all); //sorted by ssn since all blank ssn's have been removed;

// rv3_base := DedupedDataRVGeneric(StringLib.StringContains(attributeversion , 'VERSION3' , true )); //want to add to look for rv3 to get 1/2 sample consitently rvv3
rv4_base := DedupedDataRVGeneric(StringLib.StringContains(attributeversion , 'VERSION4' , true)); //want to add to look for rv4 to get 1/2 sample consitently rvv4 
rv5_base := DedupedDataRVGeneric(StringLib.StringContains(attributeversion , 'RISKVIEWATTRV5' , true )); //want to add to look for rv3 to get 1/2 sample consitently rvv3


// ut.MAC_Pick_Random(rv3_base,RV_full_3,15000); //sliming down some of the transform work
ut.MAC_Pick_Random(rv4_base,RV_full_4,15000); //sliming down some of the transform work
ut.MAC_Pick_Random(rv5_base,RV_full_5,15000); //sliming down some of the transform work

// output(RV_full_3);
output(RV_full_4);
output(RV_full_5);


// RV_full := RV_full_3+ RV_full_4+RV_full_5;
RV_full :=  RV_full_4+RV_full_5;

keepers_1_0RVGeneric := OriginalDataRVGeneric(perm_flag = 0);
keepers_1_1RVGeneric := OriginalDataRVGeneric(perm_flag = 1);
keepers_1_2RVGeneric := OriginalDataRVGeneric(perm_flag = 2);
keepers_1_3RVGeneric := OriginalDataRVGeneric(perm_flag = 3);
keepers_1_4RVGeneric := OriginalDataRVGeneric(perm_flag = 4);

keepersRVGeneric := sort(keepers_1_0RVGeneric + keepers_1_2RVGeneric + keepers_1_3RVGeneric + keepers_1_4RVGeneric, date_added);

Reflagged_LogsRVGeneric := project(keepersRVGeneric, Rearrange(left, counter));

models := ['RVA1503_0','RVB1503_0','RVG1502_0','RVT1503_0','RVS1706_0'];


Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure format_themRVGeneric(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout l, integer c) := Transform
	self.Date_added := (Integer)ut.getdate;
	self.Customer := 'Generic';
self.source_info := if(l.auto = 'RVA1104_0', 'RV4_Auto', '')  + 
						if(l.auto = 'RVA1104_0' and (l.Bank = 'RVB1104_0' or l.Money = 'RVG1103_0' or l.prescreen = 'RVP1104_0' or l.retail = 'RVR1103_0' or l.telecom = 'RVT1104_0'), ',', '') +
						if(l.Bank = 'RVB1104_0', 'RV4_Bank', '')  +
						if(l.Bank = 'RVB1104_0' and (l.Money = 'RVG1103_0' or l.prescreen = 'RVP1104_0' or l.retail = 'RVR1103_0' or l.telecom = 'RVT1104_0'), ',', '') +
						if(l.Money = 'RVG1103_0', 'RV4_Money', '')  +
						if(l.Money = 'RVG1103_0' and (l.Prescreen = 'RVP1104_0' or l.retail = 'RVR1103_0' or l.telecom = 'RVT1104_0'), ',', '') +
						if(l.Prescreen = 'RVP1104_0', 'RV4_Prescreen', '')  +
						if(l.Prescreen = 'RVP1104_0' and (l.Retail = 'RVR1103_0' or l.telecom = 'RVT1104_0'), ',', '') +
						if(l.Retail = 'RVR1103_0', 'RV4_Retail', '')  +
						if(l.Retail = 'RVR1103_0' and (l.telecom = 'RVT1104_0'), ',', '') +
						if(l.telecom = 'RVT1104_0', 'RV4_Telecom', '') 
						
						// if(l.auto = 'RVA1003_0', 'RV3_Auto', '')  + 
						// if(l.auto = 'RVA1003_0' and (l.Bank = 'RVB1003_0' or l.Money = 'RVG1003_0' or l.prescreen = 'RVP1003_0' or l.retail = 'RVR1003_0' or l.telecom = 'RVT1003_0'), ',', '') +
						// if(l.Bank = 'RVB1003_0', 'RV3_Bank', '')  +
						// if(l.Bank = 'RVB1003_0' and (l.Money = 'RVG1003_0' or l.prescreen = 'RVP1003_0' or l.retail = 'RVR1003_0' or l.telecom = 'RVT1003_0'), ',', '') +
						// if(l.Money = 'RVG1003_0', 'RV3_Money', '')  +
						// if(l.Money = 'RVG1003_0' and (l.Prescreen = 'RVP1003_0' or l.retail = 'RVR1003_0' or l.telecom = 'RVT1003_0'), ',', '') +
						// if(l.Prescreen = 'RVP1003_0', 'RV3_Prescreen', '')  +
						// if(l.Prescreen = 'RVP1003_0' and (l.Retail = 'RVR1003_0' or l.telecom = 'RVT1003_0'), ',', '') +
						// if(l.Retail = 'RVR1003_0', 'RV3_Retail', '')  +
						// if(l.Retail = 'RVR1003_0' and (l.telecom = 'RVT1003_0'), ',', '') +
						// if(l.telecom = 'RVT1003_0', 'RV3_Telecom', '')
						
+					if(l.auto in models, 'RVv5','')	;
						
	self.dateofbirth := l.dob;
	self.Perm_Flag := 4;
	// self.AccountNumber := c + MaxAccountRVGeneric;
	self.streetaddress := l.address;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;



Formatted_NewRVGeneric := project(RV_full, format_themRVGeneric(left, counter));
OUTPUT(CHOOSEN(Formatted_NewRVGeneric, eyeball), NAMED('Formatted_NewRVGeneric'));


New_rightRVGeneric := join(Reflagged_LogsRVGeneric, Formatted_NewRVGeneric,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
new_large_sampleRVGeneric := Reflagged_LogsRVGeneric + New_rightRVGeneric; //add "new_right" to old dataset;

sort_large_sampleRVGeneric := Sort(new_large_sampleRVGeneric, ssn, Date_added); //sort by date added for dedup

deduped_newRVGeneric := sort_large_sampleRVGeneric(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
dedupoldRVGeneric := sort_large_sampleRVGeneric(Date_added <> (Integer)ut.getdate);

rv5 := deduped_newRVGeneric(StringLib.StringContains(source_info , 'RVv5' , true)); //want to add to look for rv4 to get 1/2 sample consitently rvv4 
rv4 := deduped_newRVGeneric(StringLib.StringContains(source_info , 'RV4' , true)); //want to add to look for rv4 to get 1/2 sample consitently rvv4 
// rv3 := deduped_newRVGeneric(StringLib.StringContains(source_info , 'RV3' , true )); //want to add to look for rv3 to get 1/2 sample consitently rvv3

ut.MAC_Pick_Random(rv5,New_5000RV5,5000);   //grabs 5000 rvv4 of new deduped rocrods;
ut.MAC_Pick_Random(rv4,New_5000RV4,5000);   //grabs 5000 rvv4 of new deduped rocrods;
// ut.MAC_Pick_Random(rv3,New_5000RV3,3333);   //grabs 5000 rvv3 of new deduped rocrods;

// New_5000RVGeneric := New_5000RV5 + New_5000RV4 + New_5000RV3;
New_5000RVGeneric := New_5000RV5 + New_5000RV4 ;


Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure add_acctRVGeneric(Scoring_Project_Refresh_Samples.New_Samples_layouts.Output_structure le, integer c) := Transform
	self.AccountNumber := c + (integer)MaxAccountRVGeneric;
	self:= le;
	self:= [];
End;

Formatted_acct_NewRVGeneric := project(New_5000RVGeneric, add_acctRVGeneric(left, counter));


New_Test_SampleRVGeneric := dedupoldRVGeneric + Formatted_acct_NewRVGeneric;


Sorted_SampleRVGeneric := Sort(New_Test_SampleRVGeneric, accountnumber);
// finalRVGeneric := OUTPUT(choosen(Sorted_SampleRVGeneric, all));

finalRVGeneric := OUTPUT(choosen(Sorted_SampleRVGeneric, 50000),,FileoutRVGeneric, thor, overwrite);
finalRVGeneric_salt := choosen(Sorted_SampleRVGeneric, 50000);

zz_Koubsky_SALT.mac_profile(finalRVGeneric_salt); 
return finalRVGeneric;

end;

//Code for old input samples is below****************************************************************************

//***************************************************************************************************************
//***************************************************************************************************************
// shared fileoldExperian := '~scoring_project::in::riskview_v3_xml_experian_attributes_20160419';
// shared FileoutExperian := '~bbraaten::in::test_RVv3Experian_new_20160422_test2';

// shared OriginalDataExperian := DATASET(fileoldExperian, Output_structure, thor);

// shared FindMaxAccountExperian := choosen(sort(OriginalDataExperian, -accountnumber), 5);
// shared MaxAccounExperian := max(FindMaxAccountExperian, accountnumber);

//***************************************************************************************************************

// shared fileoldcreditacceptanc := '~scoring_project::in::riskview_v2_xml_creditacceptance_attributes_20160419';
// shared fileoutcreditacceptanc := '~bbraaten::in::test_creditacceptancev2_new_20160422_test2';

// shared OriginalDatacreditacceptanc := DATASET(fileoldcreditacceptanc, Output_structure, thor);

// shared FindMaxAccountcreditacceptanc := choosen(sort(OriginalDatacreditacceptanc, -accountnumber), 5);
// shared MaxAccountcreditacceptanc := max(FindMaxAccountcreditacceptanc, accountnumber);

//***************************************************************************************************************

// shared fileoldRVGeneric := '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20160419';
// shared FileoutRVGeneric := '~bbraaten::in::test_RVGeneric_new_20160422_test2'; 

// shared OriginalDataRVGeneric := DATASET(fileoldRVGeneric, Output_structure, thor);

// shared FindMaxAccountRVGeneric := choosen(sort(OriginalDataRVGeneric, -accountnumber), 5);
// shared MaxAccountRVGeneric := max(FindMaxAccountRVGeneric, accountnumber);

//***************************************************************************************************************

// shared fileoldSantander1 := '~scoring_project::in::riskview_xml_santander_1304_1_20160419';
// shared FileoutSantander1 := '~bbraaten::in::test_RVA1304_1_santander1_20160422_test2'; 

// shared OriginalDataSantander1 := DATASET(fileoldsantander1, Output_structure, thor);

// shared FindMaxAccountSantander1 := choosen(sort(OriginalDataSantander1, -accountnumber), 5);
// shared MaxAccountSantander1 := max(FindMaxAccountSantander1, accountnumber);

//***************************************************************************************************************

// shared fileoldsantander2 := '~scoring_project::in::riskview_xml_santander_1304_2_20160419';
// shared Fileoutsantander2 := '~bbraaten::in::test_RVA1304_2_santander2_20160422_test2'; 

// shared OriginalDataSantander2 := DATASET(fileoldsantander2, Output_structure, thor);

// shared FindMaxAccountSantander2 := choosen(sort(OriginalDataSantander2, -accountnumber), 5);
// shared MaxAccountSantander2 := max(FindMaxAccountSantander2, accountnumber);

//***************************************************************************************************************

// shared fileoldEnova := '~scoring_project::in::riskview_v4_xml_enova_attributes_20160419';
// shared FileoutEnova := '~bbraaten::in::test_RV_Enova_20160422_test2'; 

// shared OriginalDataEnova := DATASET(fileoldEnova, Output_structure, thor);

// shared FindMaxAccountEnova := choosen(sort(OriginalDataEnova, -accountnumber), 5);
// shared MaxAccountEnova := max(FindMaxAccountEnova, accountnumber);

//***************************************************************************************************************

// shared fileoldRegionalAcceptance := '~scoring_project::in::riskview_xml_regionalacceptance_rva1008_1_20160419';
// shared FileoutRegionalAcceptance := '~bbraaten::in::test_RV_regionalacceptance_20160422_test2'; 

// shared OriginalDataRegionalAcceptance := DATASET(fileoldRegionalAcceptance, Output_structure, thor);

// shared FindMaxAccountRegionalAcceptance := choosen(sort(OriginalDataRegionalAcceptance, -accountnumber), 5);
// shared MaxAccountRegionalAcceptance := max(FindMaxAccountRegionalAcceptance, accountnumber);

//***************************************************************************************************************

// shared fileoldTmobile1210 := '~scoring_project::in::riskview_xml_tmobile_rvt1210_1_20160419';
// shared FileoutTmobile1210 := '~bbraaten::in::test_RV_tmobile_rvt1210_1_20160422_test2'; 

// shared OriginalDataTmobile1210 := DATASET(fileoldTmobile1210, Output_structure, thor);

// shared FindMaxAccountTmobile1210 := choosen(sort(OriginalDataTmobile1210, -accountnumber), 5);
// shared MaxAccountTmobile1210 := max(FindMaxAccountTmobile1210, accountnumber);

//***************************************************************************************************************

// shared fileoldTmobile1212 := '~scoring_project::in::riskview_xml_tmobile_rvt1212_1_20160419';
// shared FileoutTmobile1212 := '~bbraaten::in::test_RV_tmobile_rvt1212_1_20160422_test2'; 

// shared OriginalDataTmobile1212 := DATASET(fileoldTmobile1212, Output_structure, thor);

// shared FindMaxAccountTmobile1212 := choosen(sort(OriginalDataTmobile1212, -accountnumber), 5);
// shared MaxAccountTmobile1212 := max(FindMaxAccountTmobile1212, accountnumber);


//***************************************************************************************************************
//RV creditacceptance********************************************************************************************

// EXPORT FCRA_New_Samples_Logs_creditacceptance (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout) creditacceptancev2) := FUNCTION 

// filteredSSNcreditacceptanc := creditacceptancev2(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));

// filteredzipcreditacceptanc := filteredSSNcreditacceptanc(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));

// goodinfocreditacceptanc := filteredzipcreditacceptanc(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											// and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != ''  and ssn != '0000' and ssn[1..8] != '00000000' and ssn[1..7] != '0000000' and ssn[1..6] != '000000');																		

// DedupedDatacreditacceptanc := dedup(goodinfocreditacceptanc, SSN, all); //sorted by ssn since all blank ssn's have been removed;

// keepers0creditacceptanc := OriginalDatacreditacceptanc(perm_flag = 0);
// keepers1creditacceptanc := OriginalDatacreditacceptanc(perm_flag = 1);
// keepers2creditacceptanc := OriginalDatacreditacceptanc(perm_flag = 2);
// keepers3creditacceptanc := OriginalDatacreditacceptanc(perm_flag = 3);
// keepers4creditacceptanc := OriginalDatacreditacceptanc(perm_flag = 4);

// keeperscreditacceptanc := sort(keepers0creditacceptanc+keepers2creditacceptanc+keepers3creditacceptanc+keepers4creditacceptanc, accountnumber);


// Reflagged_Logscreditacceptanc := project(keeperscreditacceptanc, Rearrange(left, counter));


// Output_structure format_them(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout l, integer c) := Transform
	// self.Date_added := (Integer)ut.getdate;
	// self.streetaddress := l.Address;
		// self.customer := 'Credit Acceptance';
	// self.source_info := 'RiskView_Saot_Logs';
	// self.dateofbirth := l.dob;
	// self.Perm_Flag := 4;
	// self.AccountNumber := c + (integer)MaxAccountcreditacceptanc;
	// self.history_date := 999999;
	// self.historydateyyyymm := 999999;
	// self:=l;
		// self:=[];
// End;

// Formatted_Newcreditacceptanc := project(DedupedDatacreditacceptanc, format_them(left, counter));
// OUTPUT(CHOOSEN(Formatted_Newcreditacceptanc, eyeball), NAMED('Formatted_Newcreditacceptanc'));

// New_rightcreditacceptanc := join(Reflagged_Logscreditacceptanc, Formatted_Newcreditacceptanc,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
// new_large_samplecreditacceptanc := Reflagged_Logscreditacceptanc + New_rightcreditacceptanc; //add "new_right" to old dataset;

// sort_large_samplecreditacceptanc := Sort(new_large_samplecreditacceptanc, ssn, Date_added); //sort by date added for dedup

// deduped_newcreditacceptanc := sort_large_samplecreditacceptanc(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
// dedupoldcreditacceptanc:= sort_large_samplecreditacceptanc(Date_added <> (Integer)ut.getdate);

// ut.MAC_Pick_Random(deduped_newcreditacceptanc,New_5000creditacceptanc,5000);   //grabs 5000 of new deduped rocrods;
// New_Test_Samplecreditacceptanc := dedupoldcreditacceptanc + New_5000creditacceptanc ;


// Sorted_Samplecreditacceptanc := Sort(New_Test_Samplecreditacceptanc, perm_flag, date_added);

// finalcreditacceptanc := OUTPUT(choosen(Sorted_Samplecreditacceptanc, 25000),,Fileoutcreditacceptanc, thor, overwrite);

// return finalcreditacceptanc;

// end;
//***************************************************************************************************************

//RV Santander1 sample*******************************************************************************************

// EXPORT FCRA_New_Samples_Logs_Santander1 (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout) Santander1) := FUNCTION 

// filteredSSNSantander1 := Santander1(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
// filteredzipSantander1 := filteredSSNSantander1(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));

// goodinfoSantander1 := filteredzipSantander1(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											// and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != '' );
											
											
// DedupedDataSantander1 := dedup(goodinfoSantander1, SSN, all); //sorted by ssn since all blank ssn's have been removed;


// keepers0Santander1 := OriginalDataSantander1(perm_flag = 0);
// keepers1Santander1 := OriginalDataSantander1(perm_flag = 1);
// keepers2Santander1 := OriginalDataSantander1(perm_flag = 2);
// keepers3Santander1 := OriginalDataSantander1(perm_flag = 3);
// keepers4Santander1 := OriginalDataSantander1(perm_flag = 4);

// keepersSantander1 := sort(keepers0Santander1+keepers2Santander1+keepers3Santander1+keepers4Santander1, accountnumber);

// Reflagged_LogsSantander1 := project(keepersSantander1, Rearrange(left, counter));

// Output_structure format_themSantander1(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout l, integer c) := Transform
	// self.Date_added := (Integer)ut.getdate;
	// self.Customer := 'Santander';
	// self.Source_Info := 'RiskView_Saot_Logs';
	// self.Perm_Flag := 4;
	// self.AccountNumber := c + MaxAccountSantander1;
	// self.dateofbirth := l.dob;
	// self.history_date := 999999;
	// self.historydateyyyymm := 999999;
	// self:=l;
	// self:=[];
// End;

// Formatted_NewSantander1 := project(DedupedDataSantander1, format_themSantander1(left, counter));

// New_rightSantander1 := join(Reflagged_LogsSantander1, Formatted_NewSantander1,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
// new_large_sampleSantander1 := Reflagged_LogsSantander1 + New_rightSantander1; //add "new_right" to old dataset;

// sort_large_sampleSantander1 := Sort(new_large_sampleSantander1, ssn, Date_added); //sort by date added for dedup

// deduped_newSantander1 := sort_large_sampleSantander1(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
// dedupoldSantander1 := sort_large_sampleSantander1(Date_added <> (Integer)ut.getdate);


// ut.MAC_Pick_Random(deduped_newSantander1,New_5000Santander1,5000);   //grabs 5100 of new deduped rocrods;

// New_Test_SampleSantander1 := dedupoldSantander1 + New_5000Santander1 ;

// Sorted_SampleSantander1 := Sort(New_Test_SampleSantander1, accountnumber);

// finalSantander1 := OUTPUT(choosen(Sorted_SampleSantander1, 25000),,FileoutSantander1, thor, overwrite);
// return finalSantander1;

// end;

//***************************************************************************************************************
//RV Santander2 sample*******************************************************************************************

// EXPORT FCRA_New_Samples_Logs_Santander2 (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout) Santander2) := FUNCTION 

// filteredSSNSantander2 := Santander2(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
// filteredzipSantander2 := filteredSSNSantander2(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));

// goodinfoSantander2 := filteredzipSantander2(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											// and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != '' );
											
											
// DedupedDataSantander2 := dedup(goodinfoSantander2, SSN, all); //sorted by ssn since all blank ssn's have been removed;


// keepers0Santander2 := OriginalDataSantander2(perm_flag = 0);
// keepers1Santander2 := OriginalDataSantander2(perm_flag = 1);
// keepers2Santander2 := OriginalDataSantander2(perm_flag = 2);
// keepers3Santander2 := OriginalDataSantander2(perm_flag = 3);
// keepers4Santander2 := OriginalDataSantander2(perm_flag = 4);

// keepersSantander2 := sort(keepers0Santander2+keepers2Santander2+keepers3Santander2+keepers4Santander2, accountnumber);

// Reflagged_LogsSantander2 := project(keepersSantander2, Rearrange(left, counter));


// Output_structure format_themSantander2(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout l, integer c) := Transform
	// self.Date_added := (Integer)ut.getdate;
	// self.Customer := 'Santander';
	// self.Source_Info := 'RiskView_Saot_Logs';
	// self.Perm_Flag := 4;
	// self.AccountNumber := c + MaxAccountSantander2;
	// self.dateofbirth := l.dob;
	// self.history_date := 999999;
	// self.historydateyyyymm := 999999;
	// self:=l;
	// self:=[];
// End;

// Formatted_NewSantander2 := project(DedupedDataSantander2, format_themSantander2(left, counter));

// New_rightSantander2 := join(Reflagged_LogsSantander2, Formatted_NewSantander2,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
// new_large_sampleSantander2 := Reflagged_LogsSantander2 + New_rightSantander2; //add "new_right" to old dataset;

// sort_large_sampleSantander2 := Sort(new_large_sampleSantander2, ssn, Date_added); //sort by date added for dedup

// deduped_newSantander2 := sort_large_sampleSantander2(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
// dedupoldSantander2 := sort_large_sampleSantander2(Date_added <> (Integer)ut.getdate);


// ut.MAC_Pick_Random(deduped_newSantander2,New_5000Santander2,5000);   //grabs 5100 of new deduped rocrods;

// New_Test_SampleSantander2 := dedupoldSantander2 + New_5000Santander2 ;

// Sorted_SampleSantander2 := Sort(New_Test_SampleSantander2, accountnumber);

// finalSantander2 := OUTPUT(choosen(Sorted_SampleSantander2, 25000),,FileoutSantander2, thor, overwrite);
// return finalSantander2;

// end;

//***************************************************************************************************************
//RV Enova sample************************************************************************************************

// export FCRA_New_Samples_Logs_Enova (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout) Enova) := FUNCTION 

// filteredSSNEnova := Enova(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
// filteredzipEnova := filteredSSNEnova(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));


// goodinfoEnova := filteredzipEnova(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											// and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != '');
											
// DedupedDataEnova := dedup(goodinfoEnova, SSN, all); //sorted by ssn since all blank ssn's have been removed;

// keepers0Enova := OriginalDataEnova(perm_flag = 0);
// keepers1Enova := OriginalDataEnova(perm_flag = 1);
// keepers2Enova := OriginalDataEnova(perm_flag = 2);
// keepers3Enova := OriginalDataEnova(perm_flag = 3);
// keepers4Enova := OriginalDataEnova(perm_flag = 4);

// keepersEnova := sort(keepers0Enova+keepers2Enova+keepers3Enova+keepers4Enova, accountnumber);

// Reflagged_LogsEnova := project(keepersEnova, Rearrange(left, counter));

// Output_structure format_themEnova(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout l, integer c) := Transform
	// self.Date_added := (Integer)ut.getdate;
	// self.Customer := 'Enova';
	// self.Source_Info := 'RiskView_Saot_Logs';
	// self.Perm_Flag := 4;
	// self.AccountNumber := c + MaxAccountEnova;
	// self.history_date := 999999;
	// self.historydateyyyymm := 999999;
	// self:=l;
	// self:=[];
// End;

// Formatted_NewEnova := project(DedupedDataEnova, format_themEnova(left, counter));

// New_rightEnova := join(Reflagged_LogsEnova, Formatted_NewEnova,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
// new_large_sampleEnova := Reflagged_LogsEnova + New_rightEnova; //add "new_right" to old dataset;

// sort_large_sampleEnova := Sort(new_large_sampleEnova, ssn, Date_added); //sort by date added for dedup

// deduped_newEnova := sort_large_sampleEnova(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
// dedupoldEnova := sort_large_sampleEnova(Date_added <> (Integer)ut.getdate);


// ut.MAC_Pick_Random(deduped_newEnova,New_5000Enova,5000);   //grabs 5100 of new deduped rocrods;

// New_Test_SampleEnova := dedupoldEnova + New_5000Enova ;

// Sorted_SampleEnova := Sort(New_Test_SampleEnova, accountnumber);

// finalEnova := OUTPUT(choosen(Sorted_SampleEnova, 25000),,FileoutEnova, thor, overwrite);

// return finalEnova;

// end;

//***************************************************************************************************************
//RV RegionalAcceptance sample************************************************************************************************

// export FCRA_New_Samples_Logs_RegionalAcceptance (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout) RegionalAcceptance) := FUNCTION 

// filteredSSNRegionalAcceptance := RegionalAcceptance(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
// filteredzipRegionalAcceptance := filteredSSNRegionalAcceptance(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));


// goodinfoRegionalAcceptance := filteredzipRegionalAcceptance(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											// and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != '');
											
// DedupedDataRegionalAcceptance := dedup(goodinfoRegionalAcceptance, SSN, all); //sorted by ssn since all blank ssn's have been removed;

// keepers0RegionalAcceptance := OriginalDataRegionalAcceptance(perm_flag = 0);
// keepers1RegionalAcceptance := OriginalDataRegionalAcceptance(perm_flag = 1);
// keepers2RegionalAcceptance := OriginalDataRegionalAcceptance(perm_flag = 2);
// keepers3RegionalAcceptance := OriginalDataRegionalAcceptance(perm_flag = 3);
// keepers4RegionalAcceptance := OriginalDataRegionalAcceptance(perm_flag = 4);

// keepersRegionalAcceptance := sort(keepers0RegionalAcceptance+keepers2RegionalAcceptance+keepers3RegionalAcceptance+keepers4RegionalAcceptance, accountnumber);

// Reflagged_LogsRegionalAcceptance := project(keepersRegionalAcceptance, Rearrange(left, counter));

// Output_structure format_themRegionalAcceptance(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout l, integer c) := Transform
	// self.Date_added := (Integer)ut.getdate;
	// self.Customer := 'RegionalAcceptance';
	// self.Source_Info := 'RiskView_Saot_Logs';
	// self.Perm_Flag := 4;
	// self.AccountNumber := c + MaxAccountRegionalAcceptance;
	// self.history_date := 999999;
	// self.historydateyyyymm := 999999;
	// self:=l;
	// self:=[];
// End;

// Formatted_NewRegionalAcceptance := project(DedupedDataRegionalAcceptance, format_themRegionalAcceptance(left, counter));

// New_rightRegionalAcceptance := join(Reflagged_LogsRegionalAcceptance, Formatted_NewRegionalAcceptance,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
// new_large_sampleRegionalAcceptance := Reflagged_LogsRegionalAcceptance + New_rightRegionalAcceptance; //add "new_right" to old dataset;

// sort_large_sampleRegionalAcceptance := Sort(new_large_sampleRegionalAcceptance, ssn, Date_added); //sort by date added for dedup

// deduped_newRegionalAcceptance := sort_large_sampleRegionalAcceptance(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
// dedupoldRegionalAcceptance := sort_large_sampleRegionalAcceptance(Date_added <> (Integer)ut.getdate);


// ut.MAC_Pick_Random(deduped_newRegionalAcceptance,New_5000RegionalAcceptance,5000);   //grabs 5100 of new deduped rocrods;

// New_Test_SampleRegionalAcceptance := dedupoldRegionalAcceptance + New_5000RegionalAcceptance ;

// Sorted_SampleRegionalAcceptance := Sort(New_Test_SampleRegionalAcceptance, accountnumber);

// finalRegionalAcceptance := OUTPUT(choosen(Sorted_SampleRegionalAcceptance, 25000),,FileoutRegionalAcceptance, thor, overwrite);

// return finalRegionalAcceptance;

// end;

//***************************************************************************************************************
//RV Tmobile1210 RVT1210_1 sample************************************************************************************************

// export FCRA_New_Samples_Logs_Tmobile1210 (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout) Tmobile1210) := FUNCTION 

// filteredSSNTmobile1210 := Tmobile1210(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
// filteredzipTmobile1210 := filteredSSNTmobile1210(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));


// goodinfoTmobile1210 := filteredzipTmobile1210(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											// and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != '');
											
// DedupedDataTmobile1210 := dedup(goodinfoTmobile1210, SSN, all); //sorted by ssn since all blank ssn's have been removed;

// keepers0Tmobile1210 := OriginalDataTmobile1210(perm_flag = 0);
// keepers1Tmobile1210 := OriginalDataTmobile1210(perm_flag = 1);
// keepers2Tmobile1210 := OriginalDataTmobile1210(perm_flag = 2);
// keepers3Tmobile1210 := OriginalDataTmobile1210(perm_flag = 3);
// keepers4Tmobile1210 := OriginalDataTmobile1210(perm_flag = 4);

// keepersTmobile1210 := sort(keepers0Tmobile1210+keepers2Tmobile1210+keepers3Tmobile1210+keepers4Tmobile1210, accountnumber);

// Reflagged_LogsTmobile1210 := project(keepersTmobile1210, Rearrange(left, counter));

// Output_structure format_themTmobile1210(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout l, integer c) := Transform
	// self.Date_added := (Integer)ut.getdate;
	// self.Customer := 'T-Mobile';
	// self.Source_Info := 'RiskView_Saot_Logs';
	// self.Perm_Flag := 4;
	// self.AccountNumber := c + MaxAccountTmobile1210;
	// self.history_date := 999999;
	// self.historydateyyyymm := 999999;
	// self:=l;
	// self:=[];
// End;

// Formatted_NewTmobile1210 := project(DedupedDataTmobile1210, format_themTmobile1210(left, counter));

// New_rightTmobile1210 := join(Reflagged_LogsTmobile1210, Formatted_NewTmobile1210,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
// new_large_sampleTmobile1210 := Reflagged_LogsTmobile1210 + New_rightTmobile1210; //add "new_right" to old dataset;

// sort_large_sampleTmobile1210 := Sort(new_large_sampleTmobile1210, ssn, Date_added); //sort by date added for dedup

// deduped_newTmobile1210 := sort_large_sampleTmobile1210(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
// dedupoldTmobile1210 := sort_large_sampleTmobile1210(Date_added <> (Integer)ut.getdate);


// ut.MAC_Pick_Random(deduped_newTmobile1210,New_5000Tmobile1210,5000);   //grabs 5100 of new deduped rocrods;

// New_Test_SampleTmobile1210 := dedupoldTmobile1210 + New_5000Tmobile1210 ;

// Sorted_SampleTmobile1210 := Sort(New_Test_SampleTmobile1210, accountnumber);

// finalTmobile1210 := OUTPUT(choosen(Sorted_SampleTmobile1210, 25000),,FileoutTmobile1210, thor, overwrite);

// return finalTmobile1210;

// end;

//***************************************************************************************************************
//RV Tmobile1210 RVT1212_1 sample************************************************************************************************

// export FCRA_New_Samples_Logs_Tmobile1212 (DATASET(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout) Tmobile1212) := FUNCTION 

// filteredSSNTmobile1212 := Tmobile1212(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
// filteredzipTmobile1212 := filteredSSNTmobile1212(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));


// goodinfoTmobile1212 := filteredzipTmobile1212(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and Address != '' and city != ''
											// and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dob != '');
											
// DedupedDataTmobile1212 := dedup(goodinfoTmobile1212, SSN, all); //sorted by ssn since all blank ssn's have been removed;

// keepers0Tmobile1212 := OriginalDataTmobile1212(perm_flag = 0);
// keepers1Tmobile1212 := OriginalDataTmobile1212(perm_flag = 1);
// keepers2Tmobile1212 := OriginalDataTmobile1212(perm_flag = 2);
// keepers3Tmobile1212 := OriginalDataTmobile1212(perm_flag = 3);
// keepers4Tmobile1212 := OriginalDataTmobile1212(perm_flag = 4);

// keepersTmobile1212 := sort(keepers0Tmobile1212+keepers2Tmobile1212+keepers3Tmobile1212+keepers4Tmobile1212, accountnumber);

// Reflagged_LogsTmobile1212 := project(keepersTmobile1212, Rearrange(left, counter));

// Output_structure format_themTmobile1212(Scoring_Project_Refresh_Samples.New_Samples_layouts.RiskView_Layout l, integer c) := Transform
	// self.Date_added := (Integer)ut.getdate;
	// self.Customer := 'T-Mobile';
	// self.Source_Info := 'RiskView_Saot_Logs';
	// self.Perm_Flag := 4;
	// self.AccountNumber := c + MaxAccountTmobile1212;
	// self.history_date := 999999;
	// self.historydateyyyymm := 999999;
	// self:=l;
	// self:=[];
// End;

// Formatted_NewTmobile1212 := project(DedupedDataTmobile1212, format_themTmobile1212(left, counter));

// New_rightTmobile1212 := join(Reflagged_LogsTmobile1212, Formatted_NewTmobile1212,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
// new_large_sampleTmobile1212 := Reflagged_LogsTmobile1212 + New_rightTmobile1212; //add "new_right" to old dataset;

// sort_large_sampleTmobile1212 := Sort(new_large_sampleTmobile1212, ssn, Date_added); //sort by date added for dedup

// deduped_newTmobile1212 := sort_large_sampleTmobile1212(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
// dedupoldTmobile1212 := sort_large_sampleTmobile1212(Date_added <> (Integer)ut.getdate);


// ut.MAC_Pick_Random(deduped_newTmobile1212,New_5000Tmobile1212,5000);   //grabs 5100 of new deduped rocrods;

// New_Test_SampleTmobile1212 := dedupoldTmobile1212 + New_5000Tmobile1212 ;

// Sorted_SampleTmobile1212 := Sort(New_Test_SampleTmobile1212, accountnumber);

// finalTmobile1212 := OUTPUT(choosen(Sorted_SampleTmobile1212, 25000),,FileoutTmobile1212, thor, overwrite);

// return finalTmobile1212;

// end;


end;