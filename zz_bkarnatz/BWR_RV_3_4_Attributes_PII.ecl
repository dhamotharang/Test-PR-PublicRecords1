#workunit('name','RV v3 Attributes');
// #workunit('name','RV v4 Attributes');


import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip, scoring_qa;

eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_Attributes_V3_Global_Layout;         //V3
// input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Generic_Attributes_V4_Global_Layout;      //V4  XML or Batch

prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_xml_generic_attributes_v3_20150224_1';        // v3 or v4   XML or Batch
testfilename := '~scoringqa::out::fcra::riskview_xml_generic_attributes_v3_20150225_1';        
pii_name := scoring_project_pip.Input_Sample_Names.RV_V3_Generic_infile;        //V3 or V4    XML or Batch


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

//sghatti.RVScores

ds_join_baseline := JOIN( ds_baseline, ds_pii, (integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

// OUTPUT(ds_join_baseline(results.acctno = '110826U148949'), NAMED('join_results'));


cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.accountnumber := '-', SELF := []));

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
					
// j1 := join(clean_baseline, clean_second, left.accountnumber = right.accountnumber
					// AND LEFT.seq <> RIGHT.seq
					// AND LEFT <> RIGHT,
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// ashirey.Diff(ds_baseline, ds_new, ['accountnumber'], j1, 'LIA4' );

 j1 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					AND LEFT.results.numsources > RIGHT.results.numsources,
					// AND LEFT.results.rv_score_prescreen < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));

 j2 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					AND LEFT.results.numsources < RIGHT.results.numsources,
					// AND LEFT.results.rv_score_prescreen < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));
					
 j3 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					AND LEFT.results.numsources <> '2'
					AND RIGHT.results.numsources = '2',
					// AND LEFT.results.rv_score_prescreen < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));					
					
					
 // OUTPUT(CHOOSEN(clean_baseline,eyeball));
 // OUTPUT(COUNT(clean_baseline), NAMED('base_count'));
 // OUTPUT(CHOOSEN(clean_second,eyeball));
 // OUTPUT(COUNT(clean_second), NAMED('second_count'));

// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
OUTPUT(count(j1), NAMED('decrease_numsources_count'));
//OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
OUTPUT(count(j2), NAMED('Increase_numsources_count'));
OUTPUT(count(j3), NAMED('decrease_numsourcesTo2_count'));
OUTPUT(CHOOSEN(j1, 25), named('decrease_num_sources'));
OUTPUT(CHOOSEN(j2, 25), named('Increase_num_sources'));


scoring_project_pip.COMPARE_DSETS_MACRO(ds_baseline, ds_new, ['accountnumber'], 0);
scoring_qa.CROSSTAB_MACRO(ds_baseline, ds_new, ['accountnumber'], 'numsources');