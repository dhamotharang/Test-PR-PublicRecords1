#workunit('name','BIID');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;
eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantId_Global_Layout;


prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::nonfcra::businessinstantid_xml_generic_20150221';  //can use xml or batch
testfilename := '~scoringqa::out::nonfcra::businessinstantid_xml_generic_20150222_1';
pii_name := scoring_project_pip.Input_Sample_Names.biid_xml_inFile_name;     //XML or Batch

ds_baseline := dataset(basefilename,input_layout, thor); 
ds_new := dataset(testfilename,input_layout, thor); 
ds_pii := dataset(pii_name, prii_layout, thor); 

// OUTPUT(COUNT(ds_baseline(rv_score_prescreen = '222')), NAMED('base_count_222'));
// OUTPUT(COUNT(ds_new(rv_score_prescreen = '222')), NAMED('new_count_222'));
// OUTPUT(COUNT(ds_baseline(rv_score_prescreen = '222')) - COUNT(ds_new(rv_score_prescreen = '222')), NAMED('diff_count_222'));

//**** Join PII to results **************
// OUTPUT(ds_baseline(acctno = '110826U148949'), NAMED('baseline_results'));
// OUTPUT(ds_new(acctno = '110826U148949'), NAMED('ds_new_results'));
// OUTPUT(ds_pii(account = '110826U148949'), NAMED('ds_pii_results'));

join_lay := RECORD
	input_layout results;
	prii_layout pii;
END;


ds_join_baseline := JOIN( ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

// Output(Count(ds_join_baseline(results.bnap = '1')), NAMED('bnap_equals1_baseline_count'));
// Output(Count(ds_join_second(results.bnap = '1')), NAMED('bnap_equals1_test_count'));
// OUTPUT(ds_join_baseline(results.bnap = '1'), NAMED('bnap_equals1_baseline_results'));
// OUTPUT(ds_join_second(results.bnap = '1'), NAMED('bnap_equals1_test_results'));
// OUTPUT(Choosen(ds_join_baseline,25), NAMED('join_baseline_output'));


cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

// clean_baseline := join(ds_baseline, ds_new, left.acctno = right.acctno
					// AND LEFT.errorcode + RIGHT.errorcode = '',
					// AND LEFT.rv_score_prescreen <> RIGHT.rv_score_prescreen
					// AND LEFT.rv_score_auto = '27'
					// AND LEFT.rv_score_prescreen < '300',
					// TRANSFORM(input_layout, SELF := LEFT));

// clean_second := join(ds_baseline, ds_new, left.acctno = right.acctno
					// AND LEFT.errorcode + RIGHT.errorcode = '',
					// AND LEFT.rv_score_prescreen <> RIGHT.rv_score_prescreen
					// AND right.rv_score_prescreen < '300',
					// TRANSFORM(input_layout, SELF := RIGHT));
					
// ashirey.Diff(ds_baseline, ds_new, ['accountnumber'], j1, 'LIA4' );

 j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					AND LEFT.results.bnap = RIGHT.results.bnap,
					// AND LEFT.results.rv_score_prescreen < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

 j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					AND LEFT.results.bnap < RIGHT.results.bnap,
					// AND LEFT.results.rv_score_prescreen < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					
 j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					AND LEFT.results.bnap > RIGHT.results.bnap,
					// AND LEFT.results.rv_score_prescreen < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
		
// j4 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					// AND LEFT.results.bvi = RIGHT.results.bvi,
					// AND LEFT.results.rv_score_prescreen < '300',
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					
 // OUTPUT(CHOOSEN(clean_baseline,eyeball));
 // OUTPUT(COUNT(clean_baseline), NAMED('base_count'));
 // OUTPUT(CHOOSEN(clean_second,eyeball));
 // OUTPUT(COUNT(clean_second), NAMED('second_count'));

// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
OUTPUT(count(j1), NAMED('BNAP_count'));
//OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
OUTPUT(count(j2), NAMED('BNAP_Increase_count'));
OUTPUT(count(j3), NAMED('BNAP_Decrease_count'));
// OUTPUT(count(j4), NAMED('BVI_Equal_count'));
OUTPUT(CHOOSEN(j1, 25), named('BNAP_Equal'));
OUTPUT(CHOOSEN(j2, 25), named('BNAP_Increase'));
OUTPUT(CHOOSEN(j3, 25), named('BNAP_Decrease'));
// OUTPUT(CHOOSEN(j4, 25), named('BVI_Equal'));