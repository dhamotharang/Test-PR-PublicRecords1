// *****************************************************************************************************************
// RUN THIS SCRIPT ON 400 WAY THOR TO OPTIMIZE PERFORMANCE
// 1.  COPY ALL PUBLIC RECORD KEYS THAT PROFILE BOOSTER USES TO THE THOR400_STA CLUSTER
// 2.  MAKE SURE UT.FOREIGN_PROD IS SANDBOXED TO '~' SO YOU'RE READING ALL DATA LOCALLY
// 3.  IF YOU'RE RUNNING A FILE LESS THAN 1 MILLION RECORDS, JUST RUN THE BATCH SERVICE INSTEAD OF THIS THOR JOB
// 4.  onThor is set in _Control.Environment.onThor -- toggle this value as necessary.
// 5.  VehicleV2.Key_Vehicle_linkids needs to be sandboxed to BIPV2.IDmacros.mac_IndexWithXLinkIDs(BipParty, k, VehicleV2.Constant.str_linkid_keyname + 'QA');
// *****************************************************************************************************************
// This script appends ProfileBooster1.1 attributes to end of a ProfileBooster1.0 file that has already run
// Make sure you run with the same HistoryDate that was run on the PB1.0 file

import ProfileBooster, _Control, Address, Risk_Indicators, STD;
onThor := _Control.Environment.onThor;

#workunit('name', 'profile booster 11 ' + 	if(onThor, 'thor ', 'roxie ') );
#stored('did_add_force', if(onThor, 'thor', 'roxi') );  // this option is the stored parameter used inside the DID append macro to determine which version of the macro to use
#OPTION('multiplePersistInstances', FALSE); // doesn't rename the persist files for each job
// The following options are for running KEL on THOR
#OPTION('expandSelectCreateRow', true);
#OPTION('outputLimit', 2000);
#OPTION('outputLimitMb', 1000);
#OPTION('splitterSpill', 1);
#OPTION('multiplePersistInstances',FALSE);
#OPTION('defaultSkewError', 1);


	eyeball_count := 10;
	history_dateYYYYMM  := 201901; // Make sure you run with the same HistoryDate that was run on the PB1.0 file YYYYMM
  history_dateYYYYMMDD := (STRING6)history_dateYYYYMM+'01';	
	
	string5 	IndustryClassVal 					:= '';
	STRING50 	DataRestriction						:= '00000000000000000000000000000000000000000000000000';
	string50 	DataPermission 						:= '11111111111111111111111111111111111111111111111111';
	string9   AttributesVersionRequest	:= 'PBATTRV1'; 
	
	test_file_name := 'carshield_9358_mailfile_input.csv';
	pb10file := '~thor400::out::profile_booster10_attributes_thor_ln_new_attribute_test_12112019.csv_w20191217-132335';
	search_function_with_acctno := DATASET(pb10file,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,csv(heading(single), quote('"')))(seq<>0);	
	output(choosen(search_function_with_acctno, eyeball_count), named('pb10result'));
	//RUN KEL Profile Booster v11 Attributes and append to file
	finalResult := ProfileBooster.getProfileBooster11Attrs(search_function_with_acctno, 
																history_dateYYYYMMDD, 
																80,
																1,
																2,
																DataRestriction,
																DataPermission																
																);
	output(choosen(finalResult, eyeball_count), named('finalResult'));
	output(finalResult,, '~thor400::out::profile_booster11_attributes_' + if(onThor, 'thor_', 'roxie_') + test_file_name + '_' + thorlib.wuid(),csv(heading(single), quote('"')));