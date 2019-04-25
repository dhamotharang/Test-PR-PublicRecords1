#workunit('name','RV 3 Scores');
// #workunit('name','RV 4 Scores');


import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V4_Global_Layout;  //V3 or V4

prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
 
 
basefilename := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_20160201_crim_exp_phase3_fcra_baseline';        //V3 or V4
testfilename := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_20160201_crim_exp_phase3_fcra_second';      
pii_name := scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile; 					  //V3 or V4   XML or Batch


ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, prii_layout, thor);

ds_baseline_noerrors := ds_baseline(errorcode = '');
ds_new_noerrors := ds_new(errorcode = '');


output(count(ds_baseline_noerrors));
output(count(ds_new_noerrors));


OUTPUT(COUNT(ds_baseline(rv_score_prescreen = '222')), NAMED('base_count_222'));
OUTPUT(COUNT(ds_new(rv_score_prescreen = '222')), NAMED('new_count_222'));
OUTPUT(COUNT(ds_new(rv_score_prescreen = '222')) - COUNT(ds_baseline(rv_score_prescreen = '222')), NAMED('diff_count_222'));


//**** Join PII to results **************

join_lay := RECORD
	input_layout results;
	prii_layout pii;
END;


ds_join_baseline := JOIN( ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));


cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(input_layout, SELF.acctno := '-', SELF := []));


 j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.rv_score_prescreen <> RIGHT.results.rv_score_prescreen
					AND LEFT.results.rv_score_prescreen < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));


 j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.rv_score_prescreen <> RIGHT.results.rv_score_prescreen
					AND RIGHT.results.rv_score_prescreen < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
					
 // j3:= join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.rv_score_telecom <> RIGHT.results.rv_score_telecom,
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
					
 // j4:= join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.rv_score_auto < RIGHT.results.rv_score_auto
					// AND LEFT.results.rv_auto_reason <> RIGHT.results.rv_auto_reason
					// AND LEFT.results.rv_auto_reason = '9Q' , 
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
					
					
// j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					// AND LEFT.results.rv_score_prescreen <> RIGHT.results.rv_score_prescreen
					// AND LEFT.results.rv_score_prescreen = '200'
					// AND RIGHT.results.rv_score_prescreen = '222',
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

					
 OUTPUT(count(j1), NAMED('From_Default_count'));
 OUTPUT(count(j2), NAMED('To_Default_count'));
 // OUTPUT(count(j3), NAMED('Change_rv_score_telecom_count'));
 // OUTPUT(count(j4), NAMED('Increase_rv_auto_reason_rc_9Q'));

 OUTPUT(CHOOSEN(j1, 25), named('From_Default'));
 OUTPUT(CHOOSEN(j2, 25), named('To_Default'));
 // OUTPUT(CHOOSEN(j3, 25), named('rv_score_telecom'));
 // OUTPUT(CHOOSEN(j4, 25), named('Incr_rv_auto_reason_9Q'));

ashirey.flatten(ds_baseline, flatten_baseline);
ashirey.flatten(ds_new, flatten_second);
scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['acctno'], 0);
scoring_project_pip.CROSSTAB_MACRO( flatten_baseline, flatten_second, ['acctno'], 'rv_score_telecom');