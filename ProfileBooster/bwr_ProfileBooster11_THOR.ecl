// *****************************************************************************************************************
// RUN THIS SCRIPT ON 400 WAY THOR TO OPTIMIZE PERFORMANCE
// 1.  COPY ALL PUBLIC RECORD KEYS THAT PROFILE BOOSTER USES TO THE THOR400_STA CLUSTER
// 2.  MAKE SURE UT.FOREIGN_PROD IS SANDBOXED TO '~' SO YOU'RE READING ALL DATA LOCALLY
// 3.  IF YOU ALREADY HAVE A ProfileBooster 1.0 FILE, THEN JUST RUN bwr_ProfileBooster11_THOR_append.ecl instead
// 4.  onThor is set in _Control.Environment.onThor -- toggle this value as necessary.
// 5.  VehicleV2.Key_Vehicle_linkids needs to be sandboxed to BIPV2.IDmacros.mac_IndexWithXLinkIDs(BipParty, k, VehicleV2.Constant.str_linkid_keyname + 'QA');
// 6.  doxie.Version_SuperKey needs to be sandboxed from 'QA' to 'PB'
// *****************************************************************************************************************
// This script runs ProfileBooster1.0 and appends ProfileBooster1.1 attributes to end.
// -- Update file with input file name.

EXPORT Proc_ProfileBooster11_THOR := Function
import ProfileBooster, ProfileBooster.ProfileBoosterV2_KEL, _Control, Address, Risk_Indicators, STD, doxie, UT;
onThor := _Control.Environment.onThor;

// Throw an error here if the controls aren't set correctly for running files
	kelkey := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.KEL_KEY;
	doesKelKeyExist := STD.File.FileExists(kelkey);
	kelkeydate := IF(doesKelKeyExist,STD.File.GetLogicalFileAttribute(kelkey,'workunit')[2..9],(STRING)STD.Date.Today());
	pbwatchdogkey := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.PB_WATCHDOG_KEY;
	doesPbKeyExist := STD.File.FileExists(pbwatchdogkey);
	pbkeydate := IF(doesPbKeyExist,STD.File.GetLogicalFileAttribute(pbwatchdogkey,'workunit')[2..9],(STRING)STD.Date.Today());
	daysSinceRun := STD.Date.DaysBetween((integer)pbkeydate,(integer)kelkeydate);
	reIndex := daysSinceRun < 0 OR NOT doesKelKeyExist OR NOT doesPbKeyExist;
	wuName := 'profile booster 11 ' + 	IF(onThor, 'thor ', 'roxie ') + 	
	MAP(
	UT.FOREIGN_PROD<>'~' => ERROR('Toggle Setting UT.Foreign_Prod'), 
	_Control.Environment.OnThor=false => ERROR('Toggle Setting OnThor'), 
	_Control.Environment.OnVault=true => ERROR('Toggle Setting OnVault'), 
	doxie.Version_SuperKey='QA' => ERROR('Change doxie.Version_SuperKey from QA to PB'), 
	reIndex=true => ERROR('Need to run ProfileBooster.ProfileBoosterV2_KEL.BWR_BuildAll_Compile.ecl '), 
	'' );
	pretest := output(wuName);

#WORKUNIT('name', 'profile booster 11 ' + 	IF(onThor, 'thor ', 'roxie ')	);
#stored('did_add_force', IF(onThor, 'thor', 'roxi') );  // this option is the stored parameter used inside the DID append macro to determine which version of the macro to use
// The following options are for running KEL on THOR
#OPTION('multiplePersistInstances', TRUE); // TRUE - to allow multiple files/jobs to run at same time
#OPTION('expandSelectCreateRow', TRUE);
#OPTION('outputLimit', 2000);
#OPTION('outputLimitMb', 1000);
#OPTION('splitterSpill', 1);
#OPTION('defaultSkewError', 1);
#OPTION('globalAutoHoist', FALSE);

	INTEGER		eyeball_count 						:= 10;
	STRING50 	DataRestriction						:= '0000010001001100000000000';//Risk_Indicators.iid_constants.default_DataRestriction;
	STRING50 	DataPermission 						:= '0000000000000';//Risk_Indicators.iid_constants.default_DataPermission;
	STRING9   AttributesVersionRequest	:= 'PBATTRV1'; 

	file := '~jfrancis::in::sample_iron_9396_list2_fs.csv';
	file_name := file[(STD.Str.Find(file,'::',STD.Str.FindCount(file,'::'))+2)..LENGTH(file)];

	layout_file_input := RECORD
		STRING Account;
		STRING FirstName;
		STRING MiddleName;
		STRING LastName;
		STRING StreetAddress;
		STRING City;
		STRING State;
		STRING Zip;
		STRING HomePhone;
		STRING SSN;
		STRING DateOfBirth;
		STRING WorkPhone;
		STRING income;  
		string DLNumber;
		string DLState;													
		string BALANCE; 
		string CHARGEOFFD;  
		string FormerName;
		string EMAIL;  
		string employername;
		string historydate;
		// unsigned did;
	END;
						
	ds_in := DATASET(file, layout_file_input, csv(quote('"')));
	dist_ds := DISTRIBUTE(ds_in, HASH64(Account));

  PB10_pre := OUTPUT(ds_in);

	batch_in := PROJECT(dist_ds, transform(ProfileBooster.Layouts.Layout_PB_In, 
			self.HistoryDate := (unsigned3)left.historydate[1..6];  
			self.AcctNo := left.Account;
			self.SSN := left.ssn;
			self.Name_First := left.firstname;
			self.Name_Last := left.lastname;
			self.DOB := left.DateOfBirth;
			self.street_addr := TRIM(left.streetaddress);
			self.City_name := left.city;	
			self.St := left.state;
			self.Z5 := left.zip;
			self.phone10 := left.homephone;
			// self.LexID := left.did;  // pass in the DID to shorten up the workunit processing time
			self := [];
			), LOCAL);

	PB_wseq := PROJECT( batch_in, transform( ProfileBooster.Layouts.Layout_PB_In, 
																	self.seq := counter; 
																	cleaned_name := address.CleanPerson73(left.Name_Full);
																	boolean valid_cleaned := left.Name_Full <> '';
																	self.Name_First  := STRINGlib.STRINGtouppercase(if(left.Name_First='' AND valid_cleaned, cleaned_name[6..25], left.Name_First));
																	self.Name_Last 	 := STRINGlib.STRINGtouppercase(if(left.Name_Last='' AND valid_cleaned, cleaned_name[46..65], left.Name_Last));
																	self.Name_Middle := STRINGlib.STRINGtouppercase(if(left.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], left.Name_Middle));
																	self.Name_Suffix := STRINGlib.STRINGtouppercase(if(left.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], left.Name_Suffix));	
																	self.Name_Title  := STRINGlib.STRINGtouppercase(if(valid_cleaned, cleaned_name[1..5],''));
																	street_address := risk_indicators.MOD_AddressClean.street_address(left.street_addr, left.streetnumber, left.streetpredirection, left.streetname, left.streetsuffix, left.streetpostdirection, left.unitdesignation, left.unitnumber);
																	self.street_addr := street_address;
																	self.AcctNo := left.AcctNo;
																	self.SSN := IF(left.SSN='999999999','',left.SSN);
																	self.HistoryDate := left.HistoryDate;
																	self := left ), LOCAL );
                                  
	attributes_pre := ProfileBooster.Search_Function_THOR(PB_wseq, DataRestriction, DataPermission, AttributesVersionRequest, false, '', 'PB11_1');// : PERSIST('~PROFILEBOOSTER::with_PB10::' + 'PB11_1', EXPIRE(10)) ;  
  attributes := DISTRIBUTE(attributes_pre, HASH64(AcctNo));
	
	mod_transforms := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Transforms;
	
	search_function_with_acctno := JOIN(attributes, PB_wSeq, LEFT.acctno = RIGHT.AcctNo, mod_transforms.xfm_PB10_addAcct(left,right), LOCAL); 
	
  PB10_output := OUTPUT(search_function_with_acctno);   	

  //Prepare input to KEL function
  PB11_input := JOIN(search_function_with_acctno, PB_wSeq, 
                     LEFT.acctno = RIGHT.AcctNo, 
                     mod_transforms.xfm_PB10_addHistoryDateFlat(LEFT, RIGHT), LOCAL);
  
  //RUN KEL Profile Booster v11 Attributes and append to file
  pb11result := ProfileBooster.getProfileBooster11Attrs(PB11_input);
  
  PB11_output := OUTPUT(pb11result);   	

  PreFinalResult := JOIN(search_function_with_acctno, pb11result, 
                    LEFT.acctno = RIGHT.P_InpAcct, 
                    mod_transforms.xfm_MergePB10toPB11(LEFT, RIGHT), LOCAL);												 
  
  //PB11 Modifications
  Xfm1Result := PROJECT(PreFinalResult, mod_transforms.xfm_PB11_mod1(LEFT), LOCAL);	
  Xfm2Result := PROJECT(Xfm1Result, mod_transforms.xfm_PB11_mod2(LEFT), LOCAL);	
  Xfm3Result := PROJECT(Xfm2Result, mod_transforms.xfm_PB11_mod3(LEFT), LOCAL);	
  Xfm4Result := PROJECT(Xfm3Result, mod_transforms.xfm_PB11_mod4(LEFT), LOCAL);
 
  //Apply new defaults for missing LexIDs
  PB11 := Xfm4Result(lexid<>0);
  PB11Corrected := PROJECT(Xfm4Result(lexid=0),mod_transforms.xfm_PB11_mod5(LEFT), LOCAL);
  
  finalResult := PB11+PB11Corrected;
 
  //DEBUGGING
  // output(choosen(ds_in, eyeball_count), NAMED('sample1_input_records'));
  // output(count(ds_in), NAMED('file_input_count'));
  // output(choosen(finalResult, eyeball_count), NAMED('finalResult'));
  // output(choosen(batch_in, eyeball_count), NAMED('batch_in_sample'));
  // output(choosen(PB_wseq, eyeball_count), NAMED('PB_wseq'));
  // output(choosen(search_function_with_acctno, eyeball_count), NAMED('search_function_with_acctno'));
  // output(choosen(PB11_input, eyeball_count), NAMED('PB11_input'));
  // output(choosen(pb11result, eyeball_count), NAMED('pb11result'));
  // output(choosen(PreFinalResult, eyeball_count), NAMED('PreFinalResult'));
  // output(count(search_function_with_acctno),NAMED('search_function_with_acctno_cnt'));
  // output(count(PB11_input),NAMED('PB11_input_cnt'));
  // output(count(pb11result),NAMED('pb11result_cnt'));
  // output(count(PreFinalResult),NAMED('PreFinalResult_cnt'));
  // output(count(PB11),NAMED('PB11_cnt'));
  // output(count(PB11Corrected),NAMED('PB11Corrected_cnt'));
  // output(count(finalResult),NAMED('finalResult_cnt'));
  
  PB11_Final := OUTPUT(finalResult,, '~thor400::out::profile_booster11_attributes_' + IF(onThor, 'thor_', 'roxie_') + file_name + '_' + thorlib.wuid(),CSV(HEADING(single), QUOTE('"')));
  LOCAL PBOUT := SEQUENTIAL(pretest,PB10_pre,PB10_output,PB11_output,PB11_Final);	
  RETURN PBOUT;
END;
Proc_ProfileBooster11_THOR