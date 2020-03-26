// *****************************************************************************************************************
// RUN THIS SCRIPT ON 400 WAY THOR TO OPTIMIZE PERFORMANCE
// 1.  COPY ALL PUBLIC RECORD KEYS THAT PROFILE BOOSTER USES TO THE THOR400_STA CLUSTER
// 2.  MAKE SURE UT.FOREIGN_PROD IS SANDBOXED TO '~' SO YOU'RE READING ALL DATA LOCALLY
// 3.  onThor is set in _Control.Environment.onThor -- toggle this value as necessary.
// 4.  VehicleV2.Key_Vehicle_linkids needs to be sandboxed to BIPV2.IDmacros.mac_IndexWithXLinkIDs(BipParty, k, VehicleV2.Constant.str_linkid_keyname + 'QA');
// 5.  doxie.Version_SuperKey needs to be sandboxed to 'PB'
// *****************************************************************************************************************
// This script appends ProfileBooster1.1 attributes to end of a ProfileBooster1.0 file that has already run.
// -- Update file with input file name.  Update pb10file with ProfileBooster1.0 output file name.

EXPORT Proc_ProfileBooster11_THOR_append := Function
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
	wuName := 'profile booster 11 ' + 	if(onThor, 'thor ', 'roxie ') + 	
	map(
	UT.FOREIGN_PROD<>'~' => ERROR('Sandbox Setting UT.Foreign_Prod to ~'), 
	_Control.Environment.OnThor=false => ERROR('Toggle Setting OnThor'), 
	_Control.Environment.OnVault=true => ERROR('Toggle Setting OnVault'), 
	doxie.Version_SuperKey='QA' => ERROR('Sandbox doxie.Version_SuperKey from QA to PB'), 
	reIndex=true => ERROR('Need to run ProfileBooster.ProfileBoosterV2_KEL.BWR_BuildAll_Compile.ecl '), 
	'' );
	pretest := output(wuName);

#WORKUNIT('name', 'profile booster 11 ' + 	if(onThor, 'thor ', 'roxie ')	);

#stored('did_add_force', if(onThor, 'thor', 'roxi') );  // this option is the stored parameter used inside the DID append macro to determine which version of the macro to use
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
	pb10file := '~jfrancis::out::profilebooster10_sample_ironhorse__w20200227-160956';	
	
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

	ds_in := DATASET(file, layout_file_input, CSV(QUOTE('"')));	
	dist_ds := DISTRIBUTE(ds_in, HASH64(Account));

  PB10_pre := OUTPUT(ds_in);

  batch_in_pre := PROJECT(dist_ds, TRANSFORM(ProfileBooster.Layouts.Layout_PB_In, 
      SELF.HistoryDate := (UNSIGNED3)LEFT.historydate[1..6];  
      SELF.AcctNo := LEFT.Account;
      SELF := [];
      ), LOCAL);
 
  batch_in := DEDUP(batch_in_pre, AcctNo, HistoryDate, LOCAL);
  PB_wseq := PROJECT( batch_in, TRANSFORM( ProfileBooster.Layouts.Layout_PB_In, 
                                  SELF.seq := COUNTER; 
                                  SELF.AcctNo := LEFT.AcctNo;
                                  SELF.HistoryDate := LEFT.HistoryDate;
                                  SELF := LEFT ), LOCAL);
    
  search_function_with_acctno_pre := DATASET(pb10file,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(single), QUOTE('"')));	
  search_function_with_acctno := DISTRIBUTE(search_function_with_acctno_pre, HASH64(AcctNo));

  PB10_output := OUTPUT(search_function_with_acctno);   	

  mod_transforms := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Transforms;
 
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
Proc_ProfileBooster11_THOR_append