// EXPORT BWR_Runway_Core_Stats := 'todo';
eyeball := 20;


IMPORT zz_bbraaten2, ashirey,RiskWise;

basefilename := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20180612_1';          
testfilename := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20180613_1'; 


// Layout2 := zz_bbraaten2.Boca_50_Cert_FCRA;  //FCRA
Layout2 := Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;  //FCRA

ds_baseline := dataset(basefilename, Layout2 , thor);
ds_new := dataset(testfilename, Layout2 , thor);


Output_file1 := '~bbraaten::41anrs_base_test';  //output file names - change
Output_file2 := '~bbraaten::41anrs_second_test' ;//output file names - change

// integer type_ := 2; //fcra
integer type_ := 3; //non

output(choosen(ds_baseline, 5));
output(choosen(ds_new, 5));
ashirey.flatten(ds_baseline,clean_ds_1_flat);
ashirey.flatten(ds_new,clean_ds_2_flat);


IMPORT Risk_Indicators, ut, models, Scoring_Project, zz_bbraaten2;

unsigned8 no_of_records := 0;
integer retry := 3;
integer timeout := 25;
integer threads := 2;

String neutralroxieIP := RiskWise.shortcuts.staging_neutral_roxieIP ; 
// String neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral ; 

Input_file1 :=  ds_baseline;
Input_file2 :=  ds_new;

string archive_date := '999999';

//==================  input file layout  ========================
layout_input3 := RECORD
	unsigned8 time_ms := 0;
	STRING30 AccountNumber;
	risk_indicators.Layout_Boca_Shell -LnJ_datasets;
	STRING200 errorcode;
END;


//====================================================
//=============  Main Execution ======================
//====================================================



ds_in_base := project(Input_file1, TRANSFORM(Layout2, self.historydate := (Integer)archive_date, self:= LEFT));
ds_in_prop := project(Input_file2, TRANSFORM(Layout2, self.historydate := (Integer)archive_date, self:= LEFT));
nonfcra_ds_input_base := IF (no_of_records = 0, ds_in_base, CHOOSEN (ds_in_base, no_of_records));
nonfcra_ds_input_prop := IF (no_of_records = 0, ds_in_prop, CHOOSEN (ds_in_prop, no_of_records));

// output(ds_input,named('ds_input'));

layout_soap_in := record
	integer model_environment;
	boolean excludeReasons;
	dataset(Layout2) shell;
end;

layout_soap_in create_soap_in(Layout2 le) := transform
	self.shell := project(le, transform(Layout2, self := left));
	self.model_environment := type_;  // fcra only
	self.excludeReasons := false;
end;

nonfcra_base := distribute(PROJECT (nonfcra_ds_input_base, create_soap_in(LEFT)), random());
nonfcra_prop:= distribute(PROJECT (nonfcra_ds_input_prop, create_soap_in(LEFT)), random());


xlayout := RECORD
  models.Layout_Runway;
	STRING errorcode;
END;

xlayout myFail(layout_soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

nonfcra_results_base := SOAPCALL(nonfcra_base,
					neutralroxieIP,
					'Models.Runway_Service',
					{nonfcra_base}, 
					DATASET(xlayout),
					RETRY(retry),
					TIMEOUT(timeout),
					PARALLEL(threads),
					onFail(myFail(LEFT)));
					
nonfcra_results_prop := SOAPCALL(nonfcra_prop,
					neutralroxieIP,
					'Models.Runway_Service',
					{nonfcra_prop}, 
					DATASET(xlayout),
					RETRY(retry),
					TIMEOUT(timeout),
					PARALLEL(threads),
					onFail(myFail(LEFT)));


output(nonfcra_results_base, , Output_file1, thor, overwrite);
output(nonfcra_results_prop, , Output_file2, thor, overwrite);

lay := RECORD
 unsigned8 seq;
  unsigned8 did;
  string2 nap;
  string2 nas;
  string2 cvi_score;
  string2 cvi_reason1;
  string2 cvi_reason2;
  string2 cvi_reason3;
  string2 cvi_reason4;
  string3 aid605_1_0_score;
  string2 aid605_1_0_reason1;
  string2 aid605_1_0_reason2;
  string2 aid605_1_0_reason3;
  string2 aid605_1_0_reason4;
  string3 aid606_0_0_score;
  string2 aid606_0_0_reason1;
  string2 aid606_0_0_reason2;
  string2 aid606_0_0_reason3;
  string2 aid606_0_0_reason4;
  string3 aid606_1_0_score;
  string2 aid606_1_0_reason1;
  string2 aid606_1_0_reason2;
  string2 aid606_1_0_reason3;
  string2 aid606_1_0_reason4;
  string3 aid607_0_0_score;
  string2 aid607_0_0_reason1;
  string2 aid607_0_0_reason2;
  string2 aid607_0_0_reason3;
  string2 aid607_0_0_reason4;
  string3 aid607_1_0_score;
  string2 aid607_1_0_reason1;
  string2 aid607_1_0_reason2;
  string2 aid607_1_0_reason3;
  string2 aid607_1_0_reason4;
  string3 aid607_2_0_score;
  string2 aid607_2_0_reason1;
  string2 aid607_2_0_reason2;
  string2 aid607_2_0_reason3;
  string2 aid607_2_0_reason4;
  string3 ain509_0_0_score;
  string2 ain509_0_0_reason1;
  string2 ain509_0_0_reason2;
  string2 ain509_0_0_reason3;
  string2 ain509_0_0_reason4;
  string3 ain602_1_0_score;
  string2 ain602_1_0_reason1;
  string2 ain602_1_0_reason2;
  string2 ain602_1_0_reason3;
  string2 ain602_1_0_reason4;
  string3 ain605_1_0_score;
  string2 ain605_1_0_reason1;
  string2 ain605_1_0_reason2;
  string2 ain605_1_0_reason3;
  string2 ain605_1_0_reason4;
  string3 ain605_2_0_score;
  string2 ain605_2_0_reason1;
  string2 ain605_2_0_reason2;
  string2 ain605_2_0_reason3;
  string2 ain605_2_0_reason4;
  string3 ain605_3_0_score;
  string2 ain605_3_0_reason1;
  string2 ain605_3_0_reason2;
  string2 ain605_3_0_reason3;
  string2 ain605_3_0_reason4;
  string3 ain801_1_0_score;
  string2 ain801_1_0_reason1;
  string2 ain801_1_0_reason2;
  string2 ain801_1_0_reason3;
  string2 ain801_1_0_reason4;
  string3 anmk909_0_1_score;
  string3 awd605_0_0_score;
  string2 awd605_0_0_reason1;
  string2 awd605_0_0_reason2;
  string2 awd605_0_0_reason3;
  string2 awd605_0_0_reason4;
  string3 awd605_2_0_score;
  string2 awd605_2_0_reason1;
  string2 awd605_2_0_reason2;
  string2 awd605_2_0_reason3;
  string2 awd605_2_0_reason4;
  string3 awd606_10_0_score;
  string2 awd606_10_0_reason1;
  string2 awd606_10_0_reason2;
  string2 awd606_10_0_reason3;
  string2 awd606_10_0_reason4;
  string3 awd606_11_0_score;
  string2 awd606_11_0_reason1;
  string2 awd606_11_0_reason2;
  string2 awd606_11_0_reason3;
  string2 awd606_11_0_reason4;
  string3 awd606_1_0_score;
  string2 awd606_1_0_reason1;
  string2 awd606_1_0_reason2;
  string2 awd606_1_0_reason3;
  string2 awd606_1_0_reason4;
  string3 awd606_2_0_score;
  string2 awd606_2_0_reason1;
  string2 awd606_2_0_reason2;
  string2 awd606_2_0_reason3;
  string2 awd606_2_0_reason4;
  string3 awd606_3_0_score;
  string2 awd606_3_0_reason1;
  string2 awd606_3_0_reason2;
  string2 awd606_3_0_reason3;
  string2 awd606_3_0_reason4;
  string3 awd606_4_0_score;
  string2 awd606_4_0_reason1;
  string2 awd606_4_0_reason2;
  string2 awd606_4_0_reason3;
  string2 awd606_4_0_reason4;
  string3 awd606_6_0_score;
  string2 awd606_6_0_reason1;
  string2 awd606_6_0_reason2;
  string2 awd606_6_0_reason3;
  string2 awd606_6_0_reason4;
  string3 awd606_7_0_score;
  string2 awd606_7_0_reason1;
  string2 awd606_7_0_reason2;
  string2 awd606_7_0_reason3;
  string2 awd606_7_0_reason4;
  string3 awd606_8_0_score;
  string2 awd606_8_0_reason1;
  string2 awd606_8_0_reason2;
  string2 awd606_8_0_reason3;
  string2 awd606_8_0_reason4;
  string3 awd606_9_0_score;
  string2 awd606_9_0_reason1;
  string2 awd606_9_0_reason2;
  string2 awd606_9_0_reason3;
  string2 awd606_9_0_reason4;
  string3 awd710_1_0_score;
  string2 awd710_1_0_reason1;
  string2 awd710_1_0_reason2;
  string2 awd710_1_0_reason3;
  string2 awd710_1_0_reason4;
  string3 awn510_0_0_score;
  string2 awn510_0_0_reason1;
  string2 awn510_0_0_reason2;
  string2 awn510_0_0_reason3;
  string2 awn510_0_0_reason4;
  string3 awn603_1_0_score;
  string2 awn603_1_0_reason1;
  string2 awn603_1_0_reason2;
  string2 awn603_1_0_reason3;
  string2 awn603_1_0_reason4;
  string3 bd3605_0_0_score;
  string2 bd3605_0_0_reason1;
  string2 bd3605_0_0_reason2;
  string2 bd3605_0_0_reason3;
  string2 bd3605_0_0_reason4;
  string3 bd5605_0_0_score;
  string2 bd5605_0_0_reason1;
  string2 bd5605_0_0_reason2;
  string2 bd5605_0_0_reason3;
  string2 bd5605_0_0_reason4;
  string3 bd5605_1_0_score;
  string2 bd5605_1_0_reason1;
  string2 bd5605_1_0_reason2;
  string2 bd5605_1_0_reason3;
  string2 bd5605_1_0_reason4;
  string3 bd5605_2_0_score;
  string2 bd5605_2_0_reason1;
  string2 bd5605_2_0_reason2;
  string2 bd5605_2_0_reason3;
  string2 bd5605_2_0_reason4;
  string3 bd5605_3_0_score;
  string2 bd5605_3_0_reason1;
  string2 bd5605_3_0_reason2;
  string2 bd5605_3_0_reason3;
  string2 bd5605_3_0_reason4;
  string3 bd9605_0_0_score;
  string2 bd9605_0_0_reason1;
  string2 bd9605_0_0_reason2;
  string2 bd9605_0_0_reason3;
  string2 bd9605_0_0_reason4;
  string3 bd9605_1_0_score;
  string2 bd9605_1_0_reason1;
  string2 bd9605_1_0_reason2;
  string2 bd9605_1_0_reason3;
  string2 bd9605_1_0_reason4;
  string3 cdn1109_1_0_score;
  string2 cdn1109_1_0_reason1;
  string2 cdn1109_1_0_reason2;
  string2 cdn1109_1_0_reason3;
  string2 cdn1109_1_0_reason4;
  string3 cdn1205_1_0_score;
  string2 cdn1205_1_0_reason1;
  string2 cdn1205_1_0_reason2;
  string2 cdn1205_1_0_reason3;
  string2 cdn1205_1_0_reason4;
  string3 cdn1305_1_0_score;
  string2 cdn1305_1_0_reason1;
  string2 cdn1305_1_0_reason2;
  string2 cdn1305_1_0_reason3;
  string2 cdn1305_1_0_reason4;
  string3 cdn1404_1_0_score;
  string2 cdn1404_1_0_reason1;
  string2 cdn1404_1_0_reason2;
  string2 cdn1404_1_0_reason3;
  string2 cdn1404_1_0_reason4;
  string3 cdn1410_1_0_score;
  string2 cdn1410_1_0_reason1;
  string2 cdn1410_1_0_reason2;
  string2 cdn1410_1_0_reason3;
  string2 cdn1410_1_0_reason4;
  string3 cdn1506_1_0_score;
  string2 cdn1506_1_0_reason1;
  string2 cdn1506_1_0_reason2;
  string2 cdn1506_1_0_reason3;
  string2 cdn1506_1_0_reason4;
  string3 cdn1508_1_0_score;
  string2 cdn1508_1_0_reason1;
  string2 cdn1508_1_0_reason2;
  string2 cdn1508_1_0_reason3;
  string2 cdn1508_1_0_reason4;
  string2 cdn1508_1_0_reason5;
  string2 cdn1508_1_0_reason6;
  string3 osn1504_0_0_score;
  string2 osn1504_0_0_reason1;
  string2 osn1504_0_0_reason2;
  string2 osn1504_0_0_reason3;
  string2 osn1504_0_0_reason4;
  string2 osn1504_0_0_reason5;
  string2 osn1504_0_0_reason6;
  string3 osn1608_1_0_score;
  string2 osn1608_1_0_reason1;
  string2 osn1608_1_0_reason2;
  string2 osn1608_1_0_reason3;
  string2 osn1608_1_0_reason4;
  string2 osn1608_1_0_reason5;
  string2 osn1608_1_0_reason6;
  string3 cdn604_0_0_score;
  string2 cdn604_0_0_reason1;
  string2 cdn604_0_0_reason2;
  string2 cdn604_0_0_reason3;
  string2 cdn604_0_0_reason4;
  string3 cdn604_1_0_score;
  string3 cdn604_2_0_score;
  string2 cdn604_2_0_reason1;
  string2 cdn604_2_0_reason2;
  string2 cdn604_2_0_reason3;
  string2 cdn604_2_0_reason4;
  string3 cdn604_3_0_score;
  string2 cdn604_3_0_reason1;
  string2 cdn604_3_0_reason2;
  string2 cdn604_3_0_reason3;
  string2 cdn604_3_0_reason4;
  string3 cdn604_4_0_score;
  string2 cdn604_4_0_reason1;
  string2 cdn604_4_0_reason2;
  string2 cdn604_4_0_reason3;
  string2 cdn604_4_0_reason4;
  string3 cdn605_1_0_score;
  string2 cdn605_1_0_reason1;
  string2 cdn605_1_0_reason2;
  string2 cdn605_1_0_reason3;
  string2 cdn605_1_0_reason4;
  string3 cdn606_2_0_score;
  string2 cdn606_2_0_reason1;
  string2 cdn606_2_0_reason2;
  string2 cdn606_2_0_reason3;
  string2 cdn606_2_0_reason4;
  string3 cdn706_1_0_score;
  string2 cdn706_1_0_bt_reason1;
  string2 cdn706_1_0_bt_reason2;
  string2 cdn706_1_0_bt_reason3;
  string2 cdn706_1_0_bt_reason4;
  string2 cdn706_1_0_st_reason1;
  string2 cdn706_1_0_st_reason2;
  string2 cdn706_1_0_st_reason3;
  string2 cdn706_1_0_st_reason4;
  string3 cdn707_1_0_score;
  string2 cdn707_1_0_reason1;
  string2 cdn707_1_0_reason2;
  string2 cdn707_1_0_reason3;
  string2 cdn707_1_0_reason4;
  string3 cdn712_0_0_score;
  string2 cdn712_0_0_reason1;
  string2 cdn712_0_0_reason2;
  string2 cdn712_0_0_reason3;
  string2 cdn712_0_0_reason4;
  string3 cdn806_1_0_score;
  string2 cdn806_1_0_reason1;
  string2 cdn806_1_0_reason2;
  string2 cdn806_1_0_reason3;
  string2 cdn806_1_0_reason4;
  string3 cdn908_1_0_score;
  string2 cdn908_1_0_reason1;
  string2 cdn908_1_0_reason2;
  string2 cdn908_1_0_reason3;
  string2 cdn908_1_0_reason4;
  string3 cen509_0_0_score;
  string3 csn1007_0_0_score;
  string3 fd3510_0_0_score;
  string2 fd3510_0_0_reason1;
  string2 fd3510_0_0_reason2;
  string2 fd3510_0_0_reason3;
  string2 fd3510_0_0_reason4;
  string3 fd3606_0_0_score;
  string2 fd3606_0_0_reason1;
  string2 fd3606_0_0_reason2;
  string2 fd3606_0_0_reason3;
  string2 fd3606_0_0_reason4;
  string3 fd5510_0_0_score;
  string2 fd5510_0_0_reason1;
  string2 fd5510_0_0_reason2;
  string2 fd5510_0_0_reason3;
  string2 fd5510_0_0_reason4;
  string3 fd5603_1_0_score;
  string2 fd5603_1_0_reason1;
  string2 fd5603_1_0_reason2;
  string2 fd5603_1_0_reason3;
  string2 fd5603_1_0_reason4;
  string3 fd5603_2_0_score;
  string2 fd5603_2_0_reason1;
  string2 fd5603_2_0_reason2;
  string2 fd5603_2_0_reason3;
  string2 fd5603_2_0_reason4;
  string3 fd5603_3_0_score;
  string2 fd5603_3_0_reason1;
  string2 fd5603_3_0_reason2;
  string2 fd5603_3_0_reason3;
  string2 fd5603_3_0_reason4;
  string3 fd5607_1_0_score;
  string2 fd5607_1_0_reason1;
  string2 fd5607_1_0_reason2;
  string2 fd5607_1_0_reason3;
  string2 fd5607_1_0_reason4;
  string3 fd5609_1_0_score;
  string2 fd5609_1_0_reason1;
  string2 fd5609_1_0_reason2;
  string2 fd5609_1_0_reason3;
  string2 fd5609_1_0_reason4;
  string3 fd5609_2_0_score;
  string2 fd5609_2_0_reason1;
  string2 fd5609_2_0_reason2;
  string2 fd5609_2_0_reason3;
  string2 fd5609_2_0_reason4;
  string3 fd5709_1_0_score;
  string2 fd5709_1_0_reason1;
  string2 fd5709_1_0_reason2;
  string2 fd5709_1_0_reason3;
  string2 fd5709_1_0_reason4;
  string3 fd9510_0_0_score;
  string2 fd9510_0_0_reason1;
  string2 fd9510_0_0_reason2;
  string2 fd9510_0_0_reason3;
  string2 fd9510_0_0_reason4;
  string3 fd9603_1_0_score;
  string2 fd9603_1_0_reason1;
  string2 fd9603_1_0_reason2;
  string2 fd9603_1_0_reason3;
  string2 fd9603_1_0_reason4;
  string3 fd9603_2_0_score;
  string2 fd9603_2_0_reason1;
  string2 fd9603_2_0_reason2;
  string2 fd9603_2_0_reason3;
  string2 fd9603_2_0_reason4;
  string3 fd9603_3_0_score;
  string2 fd9603_3_0_reason1;
  string2 fd9603_3_0_reason2;
  string2 fd9603_3_0_reason3;
  string2 fd9603_3_0_reason4;
  string3 fd9603_4_0_score;
  string2 fd9603_4_0_reason1;
  string2 fd9603_4_0_reason2;
  string2 fd9603_4_0_reason3;
  string2 fd9603_4_0_reason4;
  string3 fd9604_1_0_score;
  string2 fd9604_1_0_reason1;
  string2 fd9604_1_0_reason2;
  string2 fd9604_1_0_reason3;
  string2 fd9604_1_0_reason4;
  string3 fd9606_0_0_score;
  string2 fd9606_0_0_reason1;
  string2 fd9606_0_0_reason2;
  string2 fd9606_0_0_reason3;
  string2 fd9606_0_0_reason4;
  string3 fd9607_1_0_score;
  string2 fd9607_1_0_reason1;
  string2 fd9607_1_0_reason2;
  string2 fd9607_1_0_reason3;
  string2 fd9607_1_0_reason4;
  string3 fp1109_0_0_score;
  string2 fp1109_0_0_reason1;
  string2 fp1109_0_0_reason2;
  string2 fp1109_0_0_reason3;
  string2 fp1109_0_0_reason4;
  string3 fp1210_1_0_score;
  string3 fp1303_1_0_score;
  string2 fp1303_1_0_reason1;
  string2 fp1303_1_0_reason2;
  string2 fp1303_1_0_reason3;
  string2 fp1303_1_0_reason4;
  string3 fp1401_1_0_score;
  string2 fp1401_1_0_reason1;
  string2 fp1401_1_0_reason2;
  string2 fp1401_1_0_reason3;
  string2 fp1401_1_0_reason4;
  string2 fp1401_1_0_reason5;
  string2 fp1401_1_0_reason6;
  string3 fp1310_1_0_score;
  string2 fp1310_1_0_reason1;
  string2 fp1310_1_0_reason2;
  string2 fp1310_1_0_reason3;
  string2 fp1310_1_0_reason4;
  string2 fp1310_1_0_reason5;
  string2 fp1310_1_0_reason6;
  string3 fp1307_1_0_score;
  string2 fp1307_1_0_reason1;
  string2 fp1307_1_0_reason2;
  string2 fp1307_1_0_reason3;
  string2 fp1307_1_0_reason4;
  string2 fp1307_1_0_reason5;
  string2 fp1307_1_0_reason6;
  string3 fp1303_2_0_score;
  string3 fp1403_1_0_score;
  string3 fp1409_2_0_score;
  string3 fp1403_2_0_score;
  string2 fp1403_2_0_reason1;
  string2 fp1403_2_0_reason2;
  string2 fp1403_2_0_reason3;
  string2 fp1403_2_0_reason4;
  string2 fp1403_2_0_reason5;
  string2 fp1403_2_0_reason6;
  string3 fp1404_1_0_score;
  string2 fp1404_1_0_reason1;
  string2 fp1404_1_0_reason2;
  string2 fp1404_1_0_reason3;
  string2 fp1404_1_0_reason4;
  string2 fp1404_1_0_reason5;
  string2 fp1404_1_0_reason6;
  string3 fp1407_1_0_score;
  string2 fp1407_1_0_reason1;
  string2 fp1407_1_0_reason2;
  string2 fp1407_1_0_reason3;
  string2 fp1407_1_0_reason4;
  string2 fp1407_1_0_reason5;
  string2 fp1407_1_0_reason6;
  string3 fp1407_2_0_score;
  string2 fp1407_2_0_reason1;
  string2 fp1407_2_0_reason2;
  string2 fp1407_2_0_reason3;
  string2 fp1407_2_0_reason4;
  string2 fp1407_2_0_reason5;
  string2 fp1407_2_0_reason6;
  string3 fp1406_1_0_score;
  string2 fp1406_1_0_reason1;
  string2 fp1406_1_0_reason2;
  string2 fp1406_1_0_reason3;
  string2 fp1406_1_0_reason4;
  string2 fp1406_1_0_reason5;
  string2 fp1406_1_0_reason6;
  string3 fp1506_1_0_score;
  string2 fp1506_1_0_reason1;
  string2 fp1506_1_0_reason2;
  string2 fp1506_1_0_reason3;
  string2 fp1506_1_0_reason4;
  string2 fp1506_1_0_reason5;
  string2 fp1506_1_0_reason6;
  string3 fp1509_1_0_score;
  string2 fp1509_1_0_reason1;
  string2 fp1509_1_0_reason2;
  string2 fp1509_1_0_reason3;
  string2 fp1509_1_0_reason4;
  string2 fp1509_1_0_reason5;
  string2 fp1509_1_0_reason6;
  string3 fp1509_2_0_score;
  string2 fp1509_2_0_reason1;
  string2 fp1509_2_0_reason2;
  string2 fp1509_2_0_reason3;
  string2 fp1509_2_0_reason4;
  string2 fp1509_2_0_reason5;
  string2 fp1509_2_0_reason6;
  string3 fp1510_2_0_score;
  string2 fp1510_2_0_reason1;
  string2 fp1510_2_0_reason2;
  string2 fp1510_2_0_reason3;
  string2 fp1510_2_0_reason4;
  string2 fp1510_2_0_reason5;
  string2 fp1510_2_0_reason6;
  string3 fp1511_1_0_score;
  string2 fp1511_1_0_reason1;
  string2 fp1511_1_0_reason2;
  string2 fp1511_1_0_reason3;
  string2 fp1511_1_0_reason4;
  string2 fp1511_1_0_reason5;
  string2 fp1511_1_0_reason6;
  string3 fp1512_1_0_score;
  string2 fp1512_1_0_reason1;
  string2 fp1512_1_0_reason2;
  string2 fp1512_1_0_reason3;
  string2 fp1512_1_0_reason4;
  string2 fp1512_1_0_reason5;
  string2 fp1512_1_0_reason6;
  string3 fp1609_1_0_score;
  string2 fp1609_1_0_reason1;
  string2 fp1609_1_0_reason2;
  string2 fp1609_1_0_reason3;
  string2 fp1609_1_0_reason4;
  string2 fp1609_1_0_reason5;
  string2 fp1609_1_0_reason6;
  string3 fp1606_1_0_score;
  string2 fp1606_1_0_reason1;
  string2 fp1606_1_0_reason2;
  string2 fp1606_1_0_reason3;
  string2 fp1606_1_0_reason4;
  string2 fp1606_1_0_reason5;
  string2 fp1606_1_0_reason6;
  string3 fp1610_1_0_score;
  string2 fp1610_1_0_reason1;
  string2 fp1610_1_0_reason2;
  string2 fp1610_1_0_reason3;
  string2 fp1610_1_0_reason4;
  string2 fp1610_1_0_reason5;
  string2 fp1610_1_0_reason6;
  string3 fp1610_2_0_score;
  string2 fp1610_2_0_reason1;
  string2 fp1610_2_0_reason2;
  string2 fp1610_2_0_reason3;
  string2 fp1610_2_0_reason4;
  string2 fp1610_2_0_reason5;
  string2 fp1610_2_0_reason6;
  string3 fp1611_1_0_score;
  string2 fp1611_1_0_reason1;
  string2 fp1611_1_0_reason2;
  string2 fp1611_1_0_reason3;
  string2 fp1611_1_0_reason4;
  string2 fp1611_1_0_reason5;
  string2 fp1611_1_0_reason6;
  string3 fp1702_2_0_score;
  string2 fp1702_2_0_reason1;
  string2 fp1702_2_0_reason2;
  string2 fp1702_2_0_reason3;
  string2 fp1702_2_0_reason4;
  string2 fp1702_2_0_reason5;
  string2 fp1702_2_0_reason6;
  string3 fp1702_1_0_score;
  string2 fp1702_1_0_reason1;
  string2 fp1702_1_0_reason2;
  string2 fp1702_1_0_reason3;
  string2 fp1702_1_0_reason4;
  string2 fp1702_1_0_reason5;
  string2 fp1702_1_0_reason6;
  string3 fp1706_1_0_score;
  string2 fp1706_1_0_reason1;
  string2 fp1706_1_0_reason2;
  string2 fp1706_1_0_reason3;
  string2 fp1706_1_0_reason4;
  string2 fp1706_1_0_reason5;
  string2 fp1706_1_0_reason6;
  string3 fp1609_2_0_score;
  string2 fp1609_2_0_reason1;
  string2 fp1609_2_0_reason2;
  string2 fp1609_2_0_reason3;
  string2 fp1609_2_0_reason4;
  string2 fp1609_2_0_reason5;
  string2 fp1609_2_0_reason6;
  string3 fp1607_1_0_score;
  string2 fp1607_1_0_reason1;
  string2 fp1607_1_0_reason2;
  string2 fp1607_1_0_reason3;
  string2 fp1607_1_0_reason4;
  string2 fp1607_1_0_reason5;
  string2 fp1607_1_0_reason6;
  string3 fp31105_1_0_score;
  string2 fp31105_1_0_reason1;
  string2 fp31105_1_0_reason2;
  string2 fp31105_1_0_reason3;
  string2 fp31105_1_0_reason4;
  string3 fp31203_1_0_score;
  string2 fp31203_1_0_reason1;
  string2 fp31203_1_0_reason2;
  string2 fp31203_1_0_reason3;
  string2 fp31203_1_0_reason4;
  string3 fp31310_2_0_score;
  string2 fp31310_2_0_reason1;
  string2 fp31310_2_0_reason2;
  string2 fp31310_2_0_reason3;
  string2 fp31310_2_0_reason4;
  string2 fp31310_2_0_reason5;
  string2 fp31310_2_0_reason6;
  string3 fp31505_0_0_score;
  string2 fp31505_0_0_reason1;
  string2 fp31505_0_0_reason2;
  string2 fp31505_0_0_reason3;
  string2 fp31505_0_0_reason4;
  string2 fp31505_0_0_reason5;
  string2 fp31505_0_0_reason6;
  string3 fp31604_0_0_score;
  string2 fp31604_0_0_reason1;
  string2 fp31604_0_0_reason2;
  string2 fp31604_0_0_reason3;
  string2 fp31604_0_0_reason4;
  string2 fp31604_0_0_reason5;
  string2 fp31604_0_0_reason6;
  string3 fp3fdn1505_0_0_score;
  string2 fp3fdn1505_0_0_reason1;
  string2 fp3fdn1505_0_0_reason2;
  string2 fp3fdn1505_0_0_reason3;
  string2 fp3fdn1505_0_0_reason4;
  string2 fp3fdn1505_0_0_reason5;
  string2 fp3fdn1505_0_0_reason6;
  string3 fp3710_0_0_score;
  string2 fp3710_0_0_reason1;
  string2 fp3710_0_0_reason2;
  string2 fp3710_0_0_reason3;
  string2 fp3710_0_0_reason4;
  string3 fp3904_1_0_score;
  string2 fp3904_1_0_reason1;
  string2 fp3904_1_0_reason2;
  string2 fp3904_1_0_reason3;
  string2 fp3904_1_0_reason4;
  string3 fp3905_1_0_score;
  string2 fp3905_1_0_reason1;
  string2 fp3905_1_0_reason2;
  string2 fp3905_1_0_reason3;
  string2 fp3905_1_0_reason4;
  string3 fp5812_1_0_score;
  string2 fp5812_1_0_reason1;
  string2 fp5812_1_0_reason2;
  string2 fp5812_1_0_reason3;
  string2 fp5812_1_0_reason4;
  string3 hcp1206_0_0_score;
  string2 hcp1206_0_0_reason1;
  string2 hcp1206_0_0_reason2;
  string2 hcp1206_0_0_reason3;
  string2 hcp1206_0_0_reason4;
  string3 idn605_1_0_score;
  string2 idn605_1_0_reason1;
  string2 idn605_1_0_reason2;
  string2 idn605_1_0_reason3;
  string2 idn605_1_0_reason4;
  unsigned8 ie912_0_0_score;
  string2 ie912_0_0_reason1;
  string2 ie912_0_0_reason2;
  string2 ie912_0_0_reason3;
  string2 ie912_0_0_reason4;
  string3 ie912_1_0_score;
  string2 ie912_1_0_reason1;
  string2 ie912_1_0_reason2;
  string2 ie912_1_0_reason3;
  string2 ie912_1_0_reason4;
  string3 ied1106_1_0_score;
  unsigned3 ien1006_0_1_score;
  real8 mnc21106_0_0_score;
  real8 mpx1211_0_0_score;
  unsigned3 msd1010_0_0_score;
  string3 msn1106_0_0_score;
  string2 msn1106_0_0_reason1;
  string2 msn1106_0_0_reason2;
  string2 msn1106_0_0_reason3;
  string2 msn1106_0_0_reason4;
  string3 msn1210_1_0_score;
  string2 msn1210_1_0_reason1;
  string2 msn1210_1_0_reason2;
  string2 msn1210_1_0_reason3;
  string2 msn1210_1_0_reason4;
  string2 msn1210_1_0_reason5;
  string2 msn1210_1_0_reason6;
  string3 msn605_1_0_score;
  string3 msn610_0_0_score;
  real8 mv361006_0_0_score;
  real8 mv361006_1_0_score;
  unsigned3 mx361006_0_0_score;
  real8 mx361006_1_0_score;
  string3 rsb801_1_0_score;
  string3 rsn1001_1_0_score;
  string3 rsn1009_1_0_score;
  string3 rsn1010_1_0_score;
  string3 rsn1103_1_0_score;
  string3 rsn1105_1_0_score;
  string3 rsn1105_2_0_score;
  string3 rsn1105_3_0_score;
  string3 rsn1108_1_0_score;
  string3 rsn1108_2_0_score;
  string3 rsn1108_3_0_score;
  string3 rsn508_1_0_score;
  string3 rsn509_1_0_score;
  string3 rsn509_2_0_score;
  string3 rsn604_2_0_score;
  string3 rsn607_0_0_score;
  string3 rsn607_1_0_score;
  string3 rsn702_1_0_score;
  string3 rsn704_0_0_score;
  string3 rsn704_1_0_score;
  string3 rsn802_1_0_score;
  string3 rsn803_1_0_score;
  string3 rsn803_2_0_score;
  string3 rsn804_1_0_score;
  string3 rsn807_0_0_score;
  string3 rsn810_1_0_score;
  string3 rsn912_1_0_score;
  string3 rva1003_0_0_score;
  string2 rva1003_0_0_reason1;
  string2 rva1003_0_0_reason2;
  string2 rva1003_0_0_reason3;
  string2 rva1003_0_0_reason4;
  string3 rva1007_1_0_score;
  string2 rva1007_1_0_reason1;
  string2 rva1007_1_0_reason2;
  string2 rva1007_1_0_reason3;
  string2 rva1007_1_0_reason4;
  string3 rva1007_2_0_score;
  string2 rva1007_2_0_reason1;
  string2 rva1007_2_0_reason2;
  string2 rva1007_2_0_reason3;
  string2 rva1007_2_0_reason4;
  string3 rva1007_3_0_score;
  string2 rva1007_3_0_reason1;
  string2 rva1007_3_0_reason2;
  string2 rva1007_3_0_reason3;
  string2 rva1007_3_0_reason4;
  string3 rva1008_1_0_score;
  string2 rva1008_1_0_reason1;
  string2 rva1008_1_0_reason2;
  string2 rva1008_1_0_reason3;
  string2 rva1008_1_0_reason4;
  string3 rva1008_2_0_score;
  string2 rva1008_2_0_reason1;
  string2 rva1008_2_0_reason2;
  string2 rva1008_2_0_reason3;
  string2 rva1008_2_0_reason4;
  string3 rva1104_0_0_score;
  string2 rva1104_0_0_reason1;
  string2 rva1104_0_0_reason2;
  string2 rva1104_0_0_reason3;
  string2 rva1104_0_0_reason4;
  string3 rva1304_1_0_score;
  string2 rva1304_1_0_reason1;
  string2 rva1304_1_0_reason2;
  string2 rva1304_1_0_reason3;
  string2 rva1304_1_0_reason4;
  string3 rva1304_2_0_score;
  string2 rva1304_2_0_reason1;
  string2 rva1304_2_0_reason2;
  string2 rva1304_2_0_reason3;
  string2 rva1304_2_0_reason4;
  string3 rva1305_1_0_score;
  string2 rva1305_1_0_reason1;
  string2 rva1305_1_0_reason2;
  string2 rva1305_1_0_reason3;
  string2 rva1305_1_0_reason4;
  string3 rva1306_1_0_score;
  string2 rva1306_1_0_reason1;
  string2 rva1306_1_0_reason2;
  string2 rva1306_1_0_reason3;
  string2 rva1306_1_0_reason4;
  string3 rva1309_1_0_score;
  string2 rva1309_1_0_reason1;
  string2 rva1309_1_0_reason2;
  string2 rva1309_1_0_reason3;
  string2 rva1309_1_0_reason4;
  string3 rva1310_1_0_score;
  string2 rva1310_1_0_reason1;
  string2 rva1310_1_0_reason2;
  string2 rva1310_1_0_reason3;
  string2 rva1310_1_0_reason4;
  string3 rva1310_2_0_score;
  string2 rva1310_2_0_reason1;
  string2 rva1310_2_0_reason2;
  string2 rva1310_2_0_reason3;
  string2 rva1310_2_0_reason4;
  string3 rva1310_3_0_score;
  string2 rva1310_3_0_reason1;
  string2 rva1310_3_0_reason2;
  string2 rva1310_3_0_reason3;
  string2 rva1310_3_0_reason4;
  string3 rva1311_1_0_score;
  string2 rva1311_1_0_reason1;
  string2 rva1311_1_0_reason2;
  string2 rva1311_1_0_reason3;
  string2 rva1311_1_0_reason4;
  string3 rva1311_2_0_score;
  string2 rva1311_2_0_reason1;
  string2 rva1311_2_0_reason2;
  string2 rva1311_2_0_reason3;
  string2 rva1311_2_0_reason4;
  string3 rva1311_3_0_score;
  string2 rva1311_3_0_reason1;
  string2 rva1311_3_0_reason2;
  string2 rva1311_3_0_reason3;
  string2 rva1311_3_0_reason4;
  string3 rva1503_0_0_score;
  string3 rva1503_0_0_reason1;
  string3 rva1503_0_0_reason2;
  string3 rva1503_0_0_reason3;
  string3 rva1503_0_0_reason4;
  string3 rva1504_1_0_score;
  string2 rva1504_1_0_reason1;
  string2 rva1504_1_0_reason2;
  string2 rva1504_1_0_reason3;
  string2 rva1504_1_0_reason4;
  string3 rva1504_2_0_score;
  string2 rva1504_2_0_reason1;
  string2 rva1504_2_0_reason2;
  string2 rva1504_2_0_reason3;
  string2 rva1504_2_0_reason4;
  string3 rva1601_1_0_score;
  string3 rva1601_1_0_reason1;
  string3 rva1601_1_0_reason2;
  string3 rva1601_1_0_reason3;
  string3 rva1601_1_0_reason4;
  string3 rva1603_1_0_score;
  string3 rva1603_1_0_reason1;
  string3 rva1603_1_0_reason2;
  string3 rva1603_1_0_reason3;
  string3 rva1603_1_0_reason4;
  string3 rva1605_1_0_score;
  string3 rva1605_1_0_reason1;
  string3 rva1605_1_0_reason2;
  string3 rva1605_1_0_reason3;
  string3 rva1605_1_0_reason4;
  string3 rva1607_1_0_score;
  string3 rva1607_1_0_reason1;
  string3 rva1607_1_0_reason2;
  string3 rva1607_1_0_reason3;
  string3 rva1607_1_0_reason4;
  string3 rva611_0_0_score;
  string2 rva611_0_0_reason1;
  string2 rva611_0_0_reason2;
  string2 rva611_0_0_reason3;
  string2 rva611_0_0_reason4;
  string3 rva707_0_0_score;
  string2 rva707_0_0_reason1;
  string2 rva707_0_0_reason2;
  string2 rva707_0_0_reason3;
  string2 rva707_0_0_reason4;
  string3 rva707_1_0_score;
  string2 rva707_1_0_reason1;
  string2 rva707_1_0_reason2;
  string2 rva707_1_0_reason3;
  string2 rva707_1_0_reason4;
  string3 rva709_1_0_score;
  string2 rva709_1_0_reason1;
  string2 rva709_1_0_reason2;
  string2 rva709_1_0_reason3;
  string2 rva709_1_0_reason4;
  string3 rva711_0_0_score;
  string2 rva711_0_0_reason1;
  string2 rva711_0_0_reason2;
  string2 rva711_0_0_reason3;
  string2 rva711_0_0_reason4;
  string3 rva1611_1_0_score;
  string3 rva1611_1_0_reason1;
  string3 rva1611_1_0_reason2;
  string3 rva1611_1_0_reason3;
  string3 rva1611_1_0_reason4;
  string3 rva1611_2_0_score;
  string3 rva1611_2_0_reason1;
  string3 rva1611_2_0_reason2;
  string3 rva1611_2_0_reason3;
  string3 rva1611_2_0_reason4;
  string3 rvb1003_0_0_score;
  string2 rvb1003_0_0_reason1;
  string2 rvb1003_0_0_reason2;
  string2 rvb1003_0_0_reason3;
  string2 rvb1003_0_0_reason4;
  string3 rvb1104_0_0_score;
  string2 rvb1104_0_0_reason1;
  string2 rvb1104_0_0_reason2;
  string2 rvb1104_0_0_reason3;
  string2 rvb1104_0_0_reason4;
  string3 rvb1104_1_0_score;
  string2 rvb1104_1_0_reason1;
  string2 rvb1104_1_0_reason2;
  string2 rvb1104_1_0_reason3;
  string2 rvb1104_1_0_reason4;
  string3 rvb1310_1_0_score;
  string2 rvb1310_1_0_reason1;
  string2 rvb1310_1_0_reason2;
  string2 rvb1310_1_0_reason3;
  string2 rvb1310_1_0_reason4;
  string3 rvb1402_1_0_score;
  string2 rvb1402_1_0_reason1;
  string2 rvb1402_1_0_reason2;
  string2 rvb1402_1_0_reason3;
  string2 rvb1402_1_0_reason4;
  string3 rvb1503_0_0_score;
  string3 rvb1503_0_0_reason1;
  string3 rvb1503_0_0_reason2;
  string3 rvb1503_0_0_reason3;
  string3 rvb1503_0_0_reason4;
  string3 rvb609_0_0_score;
  string2 rvb609_0_0_reason1;
  string2 rvb609_0_0_reason2;
  string2 rvb609_0_0_reason3;
  string2 rvb609_0_0_reason4;
  string3 rvb703_1_0_score;
  string2 rvb703_1_0_reason1;
  string2 rvb703_1_0_reason2;
  string2 rvb703_1_0_reason3;
  string2 rvb703_1_0_reason4;
  string3 rvb705_1_0_score;
  string2 rvb705_1_0_reason1;
  string2 rvb705_1_0_reason2;
  string2 rvb705_1_0_reason3;
  string2 rvb705_1_0_reason4;
  string3 rvb711_0_0_score;
  string2 rvb711_0_0_reason1;
  string2 rvb711_0_0_reason2;
  string2 rvb711_0_0_reason3;
  string2 rvb711_0_0_reason4;
  string3 rvb1610_1_0_score;
  string3 rvb1610_1_0_reason1;
  string3 rvb1610_1_0_reason2;
  string3 rvb1610_1_0_reason3;
  string3 rvb1610_1_0_reason4;
  string3 rvc1110_1_0_score;
  string2 rvc1110_1_0_reason1;
  string2 rvc1110_1_0_reason2;
  string2 rvc1110_1_0_reason3;
  string2 rvc1110_1_0_reason4;
  string3 rvc1110_2_0_score;
  string2 rvc1110_2_0_reason1;
  string2 rvc1110_2_0_reason2;
  string2 rvc1110_2_0_reason3;
  string2 rvc1110_2_0_reason4;
  string3 rvc1112_0_0_score;
  string2 rvc1112_0_0_reason1;
  string2 rvc1112_0_0_reason2;
  string2 rvc1112_0_0_reason3;
  string2 rvc1112_0_0_reason4;
  string3 rvc1208_1_0_score;
  string2 rvc1208_1_0_reason1;
  string2 rvc1208_1_0_reason2;
  string2 rvc1208_1_0_reason3;
  string2 rvc1208_1_0_reason4;
  string3 rvc1210_1_0_score;
  string2 rvc1210_1_0_reason1;
  string2 rvc1210_1_0_reason2;
  string2 rvc1210_1_0_reason3;
  string2 rvc1210_1_0_reason4;
  string3 rvc1301_1_0_score;
  string2 rvc1301_1_0_reason1;
  string2 rvc1301_1_0_reason2;
  string2 rvc1301_1_0_reason3;
  string2 rvc1301_1_0_reason4;
  string3 rvc1307_1_0_score;
  string2 rvc1307_1_0_reason1;
  string2 rvc1307_1_0_reason2;
  string2 rvc1307_1_0_reason3;
  string2 rvc1307_1_0_reason4;
  string3 rvc1405_1_0_score;
  string2 rvc1405_1_0_reason1;
  string2 rvc1405_1_0_reason2;
  string2 rvc1405_1_0_reason3;
  string2 rvc1405_1_0_reason4;
  string3 rvc1405_2_0_score;
  string2 rvc1405_2_0_reason1;
  string2 rvc1405_2_0_reason2;
  string2 rvc1405_2_0_reason3;
  string2 rvc1405_2_0_reason4;
  string3 rvc1405_3_0_score;
  string2 rvc1405_3_0_reason1;
  string2 rvc1405_3_0_reason2;
  string2 rvc1405_3_0_reason3;
  string2 rvc1405_3_0_reason4;
  string3 rvc1405_4_0_score;
  string2 rvc1405_4_0_reason1;
  string2 rvc1405_4_0_reason2;
  string2 rvc1405_4_0_reason3;
  string2 rvc1405_4_0_reason4;
  string3 rvc1412_1_0_score;
  string2 rvc1412_1_0_reason1;
  string2 rvc1412_1_0_reason2;
  string2 rvc1412_1_0_reason3;
  string2 rvc1412_1_0_reason4;
  string3 rvc1412_2_0_score;
  string2 rvc1412_2_0_reason1;
  string2 rvc1412_2_0_reason2;
  string2 rvc1412_2_0_reason3;
  string2 rvc1412_2_0_reason4;
  string3 rvc1602_1_0_score;
  string2 rvc1602_1_0_reason1;
  string2 rvc1602_1_0_reason2;
  string2 rvc1602_1_0_reason3;
  string2 rvc1602_1_0_reason4;
  string3 rvc1609_1_0_score;
  string2 rvc1609_1_0_reason1;
  string2 rvc1609_1_0_reason2;
  string2 rvc1609_1_0_reason3;
  string2 rvc1609_1_0_reason4;
  string3 rvc1703_1_0_score;
  string2 rvc1703_1_0_reason1;
  string2 rvc1703_1_0_reason2;
  string2 rvc1703_1_0_reason3;
  string2 rvc1703_1_0_reason4;
  string3 rvd1010_0_0_score;
  string2 rvd1010_0_0_reason1;
  string2 rvd1010_0_0_reason2;
  string2 rvd1010_0_0_reason3;
  string2 rvd1010_0_0_reason4;
  string3 rvd1010_1_0_score;
  string2 rvd1010_1_0_reason1;
  string2 rvd1010_1_0_reason2;
  string2 rvd1010_1_0_reason3;
  string2 rvd1010_1_0_reason4;
  string3 rvd1010_2_0_score;
  string2 rvd1010_2_0_reason1;
  string2 rvd1010_2_0_reason2;
  string2 rvd1010_2_0_reason3;
  string2 rvd1010_2_0_reason4;
  string3 rvd1110_1_0_score;
  string2 rvd1110_1_0_reason1;
  string2 rvd1110_1_0_reason2;
  string2 rvd1110_1_0_reason3;
  string2 rvd1110_1_0_reason4;
  string3 rvg812_0_0_score;
  string2 rvg812_0_0_reason1;
  string2 rvg812_0_0_reason2;
  string2 rvg812_0_0_reason3;
  string2 rvg812_0_0_reason4;
  string3 rvg903_1_0_score;
  string3 rvg904_1_0_score;
  string2 rvg904_1_0_reason1;
  string2 rvg904_1_0_reason2;
  string2 rvg904_1_0_reason3;
  string2 rvg904_1_0_reason4;
  string3 rvg1003_0_0_score;
  string2 rvg1003_0_0_reason1;
  string2 rvg1003_0_0_reason2;
  string2 rvg1003_0_0_reason3;
  string2 rvg1003_0_0_reason4;
  string3 rvg1103_0_0_score;
  string2 rvg1103_0_0_reason1;
  string2 rvg1103_0_0_reason2;
  string2 rvg1103_0_0_reason3;
  string2 rvg1103_0_0_reason4;
  string3 rvg1106_1_0_score;
  string2 rvg1106_1_0_reason1;
  string2 rvg1106_1_0_reason2;
  string2 rvg1106_1_0_reason3;
  string2 rvg1106_1_0_reason4;
  string3 rvg1201_1_0_score;
  string2 rvg1201_1_0_reason1;
  string2 rvg1201_1_0_reason2;
  string2 rvg1201_1_0_reason3;
  string2 rvg1201_1_0_reason4;
  string3 rvg1302_1_0_score;
  string2 rvg1302_1_0_reason1;
  string2 rvg1302_1_0_reason2;
  string2 rvg1302_1_0_reason3;
  string2 rvg1302_1_0_reason4;
  string3 rvg1304_1_0_score;
  string2 rvg1304_1_0_reason1;
  string2 rvg1304_1_0_reason2;
  string2 rvg1304_1_0_reason3;
  string2 rvg1304_1_0_reason4;
  string3 rvg1304_2_0_score;
  string2 rvg1304_2_0_reason1;
  string2 rvg1304_2_0_reason2;
  string2 rvg1304_2_0_reason3;
  string2 rvg1304_2_0_reason4;
  string3 rvg1401_1_0_score;
  string2 rvg1401_1_0_reason1;
  string2 rvg1401_1_0_reason2;
  string2 rvg1401_1_0_reason3;
  string2 rvg1401_1_0_reason4;
  string3 rvg1401_2_0_score;
  string2 rvg1401_2_0_reason1;
  string2 rvg1401_2_0_reason2;
  string2 rvg1401_2_0_reason3;
  string2 rvg1401_2_0_reason4;
  string3 rvg1310_1_0_score;
  string2 rvg1310_1_0_reason1;
  string2 rvg1310_1_0_reason2;
  string2 rvg1310_1_0_reason3;
  string2 rvg1310_1_0_reason4;
  string3 rvg1404_1_0_score;
  string2 rvg1404_1_0_reason1;
  string2 rvg1404_1_0_reason2;
  string2 rvg1404_1_0_reason3;
  string2 rvg1404_1_0_reason4;
  string3 rvg1502_0_0_score;
  string3 rvg1502_0_0_reason1;
  string3 rvg1502_0_0_reason2;
  string3 rvg1502_0_0_reason3;
  string3 rvg1502_0_0_reason4;
  string3 rvg1511_1_0_score;
  string3 rvg1511_1_0_reason1;
  string3 rvg1511_1_0_reason2;
  string3 rvg1511_1_0_reason3;
  string3 rvg1511_1_0_reason4;
  string3 rvg1601_1_0_score;
  string3 rvg1601_1_0_reason1;
  string3 rvg1601_1_0_reason2;
  string3 rvg1601_1_0_reason3;
  string3 rvg1601_1_0_reason4;
  string3 rvg1601_1_0_reason5;
  string3 rvg1605_1_0_score;
  string3 rvg1605_1_0_reason1;
  string3 rvg1605_1_0_reason2;
  string3 rvg1605_1_0_reason3;
  string3 rvg1605_1_0_reason4;
  string3 rvg1605_1_0_reason5;
  string3 rvg1702_1_0_score;
  string2 rvg1702_1_0_reason1;
  string2 rvg1702_1_0_reason2;
  string2 rvg1702_1_0_reason3;
  string2 rvg1702_1_0_reason4;
  string3 rvg1705_1_0_score;
  string2 rvg1705_1_0_reason1;
  string2 rvg1705_1_0_reason2;
  string2 rvg1705_1_0_reason3;
  string2 rvg1705_1_0_reason4;
  string3 rvg1706_1_0_score;
  string3 rvg1706_1_0_reason1;
  string3 rvg1706_1_0_reason2;
  string3 rvg1706_1_0_reason3;
  string3 rvg1706_1_0_reason4;
  string3 rvp804_0_0_score;
  string2 rvp804_0_0_reason1;
  string3 rvp1003_0_0_score;
  string2 rvp1003_0_0_reason1;
  string3 rvp1012_1_0_score;
  string2 rvp1012_1_0_reason1;
  string3 rvp1104_0_0_score;
  string2 rvp1104_0_0_reason1;
  string3 rvp1208_1_0_score;
  string2 rvp1208_1_0_reason1;
  string3 rvp1401_1_0_score;
  string2 rvp1401_1_0_reason1;
  string3 rvp1401_2_0_score;
  string2 rvp1401_2_0_reason1;
  string3 rvp1503_1_0_score;
  string2 rvp1503_1_0_reason1;
  string3 rvp1605_1_0_score;
  string2 rvp1605_1_0_reason1;
  string3 rvr1003_0_0_score;
  string2 rvr1003_0_0_reason1;
  string2 rvr1003_0_0_reason2;
  string2 rvr1003_0_0_reason3;
  string2 rvr1003_0_0_reason4;
  string3 rvr1008_1_0_score;
  string2 rvr1008_1_0_reason1;
  string2 rvr1008_1_0_reason2;
  string2 rvr1008_1_0_reason3;
  string2 rvr1008_1_0_reason4;
  string3 rvr1103_0_0_score;
  string2 rvr1103_0_0_reason1;
  string2 rvr1103_0_0_reason2;
  string2 rvr1103_0_0_reason3;
  string2 rvr1103_0_0_reason4;
  string3 rvr1104_2_0_score;
  string2 rvr1104_2_0_reason1;
  string2 rvr1104_2_0_reason2;
  string2 rvr1104_2_0_reason3;
  string2 rvr1104_2_0_reason4;
  string3 rvr1210_1_0_score;
  string2 rvr1210_1_0_reason1;
  string2 rvr1210_1_0_reason2;
  string2 rvr1210_1_0_reason3;
  string2 rvr1210_1_0_reason4;
  string3 rvr1303_1_0_score;
  string2 rvr1303_1_0_reason1;
  string2 rvr1303_1_0_reason2;
  string2 rvr1303_1_0_reason3;
  string2 rvr1303_1_0_reason4;
  string3 rvr1311_1_0_score;
  string2 rvr1311_1_0_reason1;
  string2 rvr1311_1_0_reason2;
  string2 rvr1311_1_0_reason3;
  string2 rvr1311_1_0_reason4;
  string3 rvr1410_1_0_score;
  string2 rvr1410_1_0_reason1;
  string2 rvr1410_1_0_reason2;
  string2 rvr1410_1_0_reason3;
  string2 rvr1410_1_0_reason4;
  string3 rvr611_0_0_score;
  string2 rvr611_0_0_reason1;
  string2 rvr611_0_0_reason2;
  string2 rvr611_0_0_reason3;
  string2 rvr611_0_0_reason4;
  string3 rvr704_1_0_score;
  string2 rvr704_1_0_reason1;
  string2 rvr704_1_0_reason2;
  string2 rvr704_1_0_reason3;
  string2 rvr704_1_0_reason4;
  string3 rvr711_0_0_score;
  string2 rvr711_0_0_reason1;
  string2 rvr711_0_0_reason2;
  string2 rvr711_0_0_reason3;
  string2 rvr711_0_0_reason4;
  string3 rvr803_1_0_score;
  string2 rvr803_1_0_reason1;
  string2 rvr803_1_0_reason2;
  string2 rvr803_1_0_reason3;
  string2 rvr803_1_0_reason4;
  string3 rvs811_0_0_score;
  string2 rvs811_0_0_reason1;
  string2 rvs811_0_0_reason2;
  string2 rvs811_0_0_reason3;
  string2 rvs811_0_0_reason4;
  string3 rvs1706_0_score;
  string2 rvs1706_0_reason1;
  string2 rvs1706_0_reason2;
  string2 rvs1706_0_reason3;
  string2 rvs1706_0_reason4;
  string3 rvt1003_0_0_score;
  string2 rvt1003_0_0_reason1;
  string2 rvt1003_0_0_reason2;
  string2 rvt1003_0_0_reason3;
  string2 rvt1003_0_0_reason4;
  string3 rvt1006_1_0_score;
  string2 rvt1006_1_0_reason1;
  string2 rvt1006_1_0_reason2;
  string2 rvt1006_1_0_reason3;
  string2 rvt1006_1_0_reason4;
  string3 rvt1104_0_0_score;
  string2 rvt1104_0_0_reason1;
  string2 rvt1104_0_0_reason2;
  string2 rvt1104_0_0_reason3;
  string2 rvt1104_0_0_reason4;
  string3 rvt1104_1_0_score;
  string2 rvt1104_1_0_reason1;
  string2 rvt1104_1_0_reason2;
  string2 rvt1104_1_0_reason3;
  string2 rvt1104_1_0_reason4;
  string3 rvt1204_1_score;
  string2 rvt1204_1_reason1;
  string2 rvt1204_1_reason2;
  string2 rvt1204_1_reason3;
  string2 rvt1204_1_reason4;
  string3 rvt1210_1_0_score;
  string2 rvt1210_1_0_reason1;
  string2 rvt1210_1_0_reason2;
  string2 rvt1210_1_0_reason3;
  string2 rvt1210_1_0_reason4;
  string3 rvt1212_1_0_score;
  string2 rvt1212_1_0_reason1;
  string2 rvt1212_1_0_reason2;
  string2 rvt1212_1_0_reason3;
  string2 rvt1212_1_0_reason4;
  string3 rvt612_0_score;
  string2 rvt612_0_reason1;
  string2 rvt612_0_reason2;
  string2 rvt612_0_reason3;
  string2 rvt612_0_reason4;
  string3 rvt1307_3_0_score;
  string2 rvt1307_3_0_reason1;
  string2 rvt1307_3_0_reason2;
  string2 rvt1307_3_0_reason3;
  string2 rvt1307_3_0_reason4;
  string3 rvt1402_1_0_score;
  string2 rvt1402_1_0_reason1;
  string2 rvt1402_1_0_reason2;
  string2 rvt1402_1_0_reason3;
  string2 rvt1402_1_0_reason4;
  string3 rvt1503_0_0_score;
  string3 rvt1503_0_0_reason1;
  string3 rvt1503_0_0_reason2;
  string3 rvt1503_0_0_reason3;
  string3 rvt1503_0_0_reason4;
  string3 rvt1601_1_0_score;
  string3 rvt1601_1_0_reason1;
  string3 rvt1601_1_0_reason2;
  string3 rvt1601_1_0_reason3;
  string3 rvt1601_1_0_reason4;
  string3 rvt711_0_0_score;
  string2 rvt711_0_0_reason1;
  string2 rvt711_0_0_reason2;
  string2 rvt711_0_0_reason3;
  string2 rvt711_0_0_reason4;
  string3 rvt711_1_0_score;
  string2 rvt711_1_0_reason1;
  string2 rvt711_1_0_reason2;
  string2 rvt711_1_0_reason3;
  string2 rvt711_1_0_reason4;
  string3 rvt803_1_0_score;
  string2 rvt803_1_0_reason1;
  string2 rvt803_1_0_reason2;
  string2 rvt803_1_0_reason3;
  string2 rvt803_1_0_reason4;
  string3 rvt809_1_0_score;
  string2 rvt809_1_0_reason1;
  string2 rvt809_1_0_reason2;
  string2 rvt809_1_0_reason3;
  string2 rvt809_1_0_reason4;
  string3 rvt1605_1_0_score;
  string2 rvt1605_1_0_reason1;
  string2 rvt1605_1_0_reason2;
  string2 rvt1605_1_0_reason3;
  string2 rvt1605_1_0_reason4;
  string3 rvt1605_2_0_score;
  string2 rvt1605_2_0_reason1;
  string2 rvt1605_2_0_reason2;
  string2 rvt1605_2_0_reason3;
  string2 rvt1605_2_0_reason4;
  string3 rvt1608_1_0_score;
  string2 rvt1608_1_0_reason1;
  string2 rvt1608_1_0_reason2;
  string2 rvt1608_1_0_reason3;
  string2 rvt1608_1_0_reason4;
  string2 rvt1608_1_0_reason5;
  string3 rvt1608_2_score;
  string2 rvt1608_2_reason1;
  string2 rvt1608_2_reason2;
  string2 rvt1608_2_reason3;
  string2 rvt1608_2_reason4;
  string2 rvt1608_2_reason5;
  string3 tbd605_0_0_score;
  string2 tbd605_0_0_reason1;
  string2 tbd605_0_0_reason2;
  string2 tbd605_0_0_reason3;
  string2 tbd605_0_0_reason4;
  string3 tbd609_1_0_score;
  string2 tbd609_1_0_reason1;
  string2 tbd609_1_0_reason2;
  string2 tbd609_1_0_reason3;
  string2 tbd609_1_0_reason4;
  string3 tbd609_2_0_score;
  string2 tbd609_2_0_reason1;
  string2 tbd609_2_0_reason2;
  string2 tbd609_2_0_reason3;
  string2 tbd609_2_0_reason4;
  string3 tbn509_0_0_score;
  string2 tbn509_0_0_reason1;
  string2 tbn509_0_0_reason2;
  string2 tbn509_0_0_reason3;
  string2 tbn509_0_0_reason4;
  string3 tbn604_1_0_score;
  string2 tbn604_1_0_reason1;
  string2 tbn604_1_0_reason2;
  string2 tbn604_1_0_reason3;
  string2 tbn604_1_0_reason4;
  string3 trd605_0_0_score;
  string2 trd605_0_0_reason1;
  string2 trd605_0_0_reason2;
  string2 trd605_0_0_reason3;
  string2 trd605_0_0_reason4;
  string3 trd609_1_0_score;
  string2 trd609_1_0_reason1;
  string2 trd609_1_0_reason2;
  string2 trd609_1_0_reason3;
  string2 trd609_1_0_reason4;
  unsigned3 win704_0_0_score;
  real8 womv002_0_0_score;
  string3 wwn604_1_0_score;
  string2 wwn604_1_0_reason1;
  string2 wwn604_1_0_reason2;
  string2 wwn604_1_0_reason3;
  string2 wwn604_1_0_reason4;
  string errorcode;
	END;				



ds_base := Distribute(dataset(Output_file1, lay, thor), seq);
ds_prop := Distribute(dataset(Output_file2, lay, thor), seq);

ds_base_clean := ds_base(seq <>0 and errorcode = '');
ds_prop_clean := ds_prop(seq <>0 and errorcode = '');

// scoring_project_pip.COMPARE_DSETS_MACRO(ds_base_clean, ds_prop_clean, ['seq'], -1);

Base_stats := zz_bbraaten2.compare_results_macro(ds_base_clean);
Prop_stats := zz_bbraaten2.compare_results_macro(ds_prop_clean);


trans_lay2 := record
		string30 name;
		Decimal7_3 Base_mean;
		Decimal7_3 prop_mean;
		Decimal7_3 mean_diff;
		Decimal7_3 Base_std_dev;
		Decimal7_3 prop_std_dev;		
		Decimal7_3 std_dev_diff;
end;

trans_lay2 j_trans2(base_stats le, Prop_stats ri) := transform
		self.name  := le.name;
		self.Base_mean := le.mean;
		self.prop_mean  := ri.mean;
		self.mean_diff  := (real)ri.mean - (real)le.mean;
		self.Base_std_dev := le.std_dev;
		self.prop_std_dev := ri.std_dev;		
		self.std_dev_diff  := (real)ri.std_dev - (real)le.std_dev;
end;		
		
j1 := join(base_stats, Prop_stats, 
						left.name = right.name ,
						j_trans2(left, right));		
						
			
output(choosen(j1, all), named('ds_join8'));
				

				


rec_temp := record
		lay;
		String score_name;
		decimal7_4 diff;
		decimal7_4 abs_diff;
end;
	out_rec := record
		String score_name;
		decimal7_4 pct_diff := 0;
		decimal7_4 pct_up := 0;
		decimal7_4 pct_down := 0;
		decimal7_4 delta_mean := 0;
		decimal7_4 delta_median := 0;
end;
	
macro_stats(ds1, ds2, at_name) := FUNCTIONMACRO

		rec_temp calc_results(lay rec1, lay rec2) := transform
				self.diff := (decimal7_4) rec2.#expand(at_name) - (decimal7_4) rec1.#expand(at_name);
				self.abs_diff := abs((decimal7_4) rec1.#expand(at_name) - (decimal7_4) rec2.#expand(at_name) );
				self.score_name := at_name;
				self := rec1;
		end;
		
		ds_temp := join(ds1, ds2, left.seq = right.seq, calc_results(left, right));
		
		ds_temp2 := ds_temp(abs_diff <> 0);
		ds_temp_up := ds_temp(diff > 0);
		ds_temp_down := ds_temp(diff < 0);

		decimal7_4 d_mean := if(count(ds_temp2) <> 0, ave(ds_temp, abs_diff), 0);
		decimal7_4 d_median := if(count(ds_temp2) <> 0, sort(ds_temp2, abs_diff)[(integer)((count(ds_temp2)+1)/2)].abs_diff, 0);
		decimal7_4 per_diff := if(count(ds_temp2) <> 0, count(ds_temp2)/count(ds_temp), 0);
		decimal7_4 per_up := if(count(ds_temp_up) <> 0, count(ds_temp_up)/count(ds_temp), 0);
		decimal7_4 per_down := if(count(ds_temp_down) <> 0, count(ds_temp_down)/count(ds_temp), 0);
		return dataset([{at_name, per_diff, per_up, per_down, d_mean, d_median}], out_rec);		
ENDMACRO;
	
	
//will need to update if new models have been added.	
dataset median_calc :=		
// macro_stats(ds_base_clean, ds_prop_clean, 'cvi_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'aid605_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'aid606_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'aid606_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'aid607_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'aid607_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'aid607_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'ain509_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'ain602_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'ain605_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'ain605_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'ain605_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'ain801_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'anmk909_0_1_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd605_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd605_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd606_10_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd606_11_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd606_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd606_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd606_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd606_4_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd606_6_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd606_7_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd606_8_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd606_9_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awd710_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awn510_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'awn603_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'bd3605_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'bd5605_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'bd5605_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'bd5605_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'bd5605_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'bd9605_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'bd9605_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn1109_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn1205_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn1305_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn1404_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn1410_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn1506_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn1508_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'osn1504_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'osn1608_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn604_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn604_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn604_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn604_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn604_4_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn605_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn606_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn706_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn707_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn712_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn806_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cdn908_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'cen509_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'csn1007_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd3510_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd3606_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd5510_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd5603_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd5603_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd5603_3_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd5607_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd5609_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd5609_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd5709_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd9510_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd9603_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd9603_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd9603_3_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd9603_4_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd9604_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd9606_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fd9607_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1109_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1210_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1303_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1401_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1310_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1307_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1303_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1403_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1409_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1403_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1404_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1407_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1407_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1406_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1506_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1509_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1509_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1510_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1511_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1512_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1609_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1606_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1610_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1610_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1611_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1702_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1702_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1706_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp1609_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp31105_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp31203_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp31310_2_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp31505_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp31604_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp3fdn1505_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp3710_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp3904_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp3905_1_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'fp5812_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'hcp1206_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'idn605_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'ie912_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'ie912_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'ied1106_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'ien1006_0_1_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'mnc21106_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'mpx1211_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'msd1010_0_0_score')+
macro_stats(ds_base_clean, ds_prop_clean, 'msn1106_0_0_score');
// macro_stats(ds_base_clean, ds_prop_clean, 'msn1210_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'msn605_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'msn610_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'mv361006_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'mx361006_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'mv361006_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'mx361006_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsb801_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn1001_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn1009_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn1010_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn1103_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn1105_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn1105_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn1105_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn1108_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn1108_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn1108_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn508_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn509_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn509_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn604_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn607_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn607_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn702_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn704_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn704_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn802_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn803_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn803_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn804_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn807_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn810_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rsn912_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1003_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1007_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1007_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1007_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1008_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1008_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1104_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1304_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1304_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1305_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1306_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1309_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1310_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1310_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1310_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1311_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1311_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1311_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1503_0_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1504_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1504_2_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1601_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1603_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1605_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1607_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1611_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1611_2_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rva707_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva707_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva709_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva711_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1611_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rva1611_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb1003_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb1104_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb1104_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb1310_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb1402_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb1503_0_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb609_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb703_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb705_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb711_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvb1610_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1110_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1110_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1112_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1208_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1210_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1301_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1307_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1405_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1405_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1405_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1405_4_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1412_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1412_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1602_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1609_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvc1703_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvd1010_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvd1010_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvd1010_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvd1110_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg812_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg903_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg904_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1003_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1103_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1106_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1201_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1302_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1304_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1304_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1401_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1401_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1310_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1404_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1502_0_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1511_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1601_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1605_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1702_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1705_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvg1706_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvp804_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvp1003_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvp1012_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvp1104_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvp1208_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvp1401_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvp1401_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvp1503_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvp1605_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr1003_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr1008_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr1103_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr1104_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr1210_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr1303_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr1311_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr1410_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr611_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr704_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr711_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvr803_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvs811_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvs1706_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1003_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1006_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1104_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1104_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1204_1_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1210_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1212_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt612_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1307_3_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1402_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1503_0_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1601_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt711_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt711_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt803_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt809_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1605_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1605_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1608_1_0_score')+//50
// macro_stats(ds_base_clean, ds_prop_clean, 'rvt1608_2_score');//50
// macro_stats(ds_base_clean, ds_prop_clean, 'tbd605_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'tbd609_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'tbd609_2_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'tbn509_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'tbn604_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'trd605_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'trd609_1_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'win704_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'womv002_0_0_score')+
// macro_stats(ds_base_clean, ds_prop_clean, 'wwn604_1_0_score');



trans_lay3 := record
		string30 name;
		Decimal7_3 Base_mean;
		Decimal7_3 prop_mean;
		Decimal7_3 mean_diff;
		Decimal7_3 Base_std_dev;
		Decimal7_3 prop_std_dev;		
		Decimal7_3 std_dev_diff;
		decimal7_4 pct_diff := 0;
		decimal7_4 pct_up := 0;
		decimal7_4 pct_down := 0;
		decimal7_4 delta_mean;
		decimal7_4 delta_median ;
end;


trans_lay3 j_trans3(j1 le, median_calc ri) := transform
		// self.score_name := ri.score_name;
		self.pct_diff := ri.pct_diff* 100;
		self.pct_up := ri.pct_up * 100;
		self.pct_down := ri.pct_down* 100;
		self.delta_mean := ri.delta_mean;
		self.delta_median := ri.delta_median;
		self := le;
end;



j2 := join(j1, median_calc, 
						left.name = right.score_name ,
						j_trans3(left, right));		
				
	
output(choosen(j2, all), named('ds_join_end8'));
