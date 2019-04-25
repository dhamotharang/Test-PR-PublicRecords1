#workunit('name','FraudPoint 3');

import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP, zz_bbraaten2;

eyeball := 25;

input_layout := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout;

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
   	a:= ut.GetDate;
	
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);
	
	
b1:=b +'_1'; 
	
	a1:= a +'_1';

basefilename := '~scoringqa::out::nonfcra::fraudpoint_xml_generic_fp31505_0_v3_FLAPSD_'+b1;    //XML or Batch
testfilename := '~scoringqa::out::nonfcra::fraudpoint_xml_generic_fp31505_0_v3_FLAPSD_'+a1; 

pii_name := scoring_project_pip.Input_Sample_Names.FP_V3_Generic_FP31505_0_infile;          //XML or Batch

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, pii_layout, thor);

	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	output(ds_baseline(errorcode <> ''),named('base_errors'));
	output(ds_new(errorcode <> ''),named('prop_errors'));





ave(clean_ds_baseline, (integer)fp_score);
ave(clean_ds_new, (integer)fp_score);


join_lay := RECORD
	input_layout results;
	pii_layout pii;
END;


ds_join_baseline := JOIN( clean_ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( clean_ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));


cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));


j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					and abs((integer)LEFT.results.fp_score -(integer)RIGHT.results.fp_score) > 100	,	

					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					
										OUTPUT(count(j1), NAMED('fp_score'));
					OUTPUT(CHOOSEN(j1, 25), named('fp_score_diff'));


j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND (integer)LEFT.results.did		<> (integer)RIGHT.results.did	,	
TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));


					OUTPUT(count(j2), NAMED('did_count'));
					 OUTPUT(CHOOSEN(j2, 25), named('did'));


Scoring_Project_PIP.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 0);
