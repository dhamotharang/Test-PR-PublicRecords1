#workunit('name','RV 3 Scores');
// #workunit('name','RV 4 Scores');


import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V3_Global_Layout;  //V3 or V4

prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
 
 
basefilename := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_20150423_1';        //V3 or V4
testfilename := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_20150424_1';      
pii_name := scoring_project_pip.Input_Sample_Names.RV_V3_Generic_infile; 					  //V3 or V4   XML or Batch


ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, prii_layout, thor);

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

//j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					// AND LEFT.results.rv_score_prescreen <> RIGHT.results.rv_score_prescreen
		//			AND LEFT.results.rv_score_prescreen = '200'
		//			AND RIGHT.results.rv_score_prescreen = '222',
		//		  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

					
OUTPUT(count(j1), NAMED('From_Default_count'));
// OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
 OUTPUT(count(j2), NAMED('To_Default_count'));
//OUTPUT(count(j2), NAMED('Dead_to_222_count'));
OUTPUT(CHOOSEN(j1, 25), named('From_Default'));
 OUTPUT(CHOOSEN(j2, 25), named('To_Default'));
//OUTPUT(CHOOSEN(j3, 25), named('Dead_to_222'));

scoring_project_pip.COMPARE_DSETS_MACRO(ds_baseline, ds_new, ['acctno'], 1 );
