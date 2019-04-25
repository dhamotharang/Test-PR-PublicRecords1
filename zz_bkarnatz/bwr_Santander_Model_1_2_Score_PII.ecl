#workunit('name','Santander Score');   // Santander Score 1 and 2
import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip, scoring_qa;
eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Santander_RVA1304_1_V3_Global_Layout;   // change 1 for score 1, 2 for score 2

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_xml_santander_rva1304_1_v3_20151020_1';   // 1 for score 1, 2 for score 2
testfilename := '~scoringqa::out::fcra::riskview_xml_santander_rva1304_1_v3_20151021_1';  
pii_name := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Santander_1304_1_infile;  //1 for score 1, 2 for score 2

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor); 
ds_pii := dataset(pii_name, pii_layout, thor); ;


//**** Join PII to results **************

join_lay := RECORD
	input_layout results;
	pii_layout pii;
END;


ds_join_baseline := JOIN( ds_baseline, ds_pii, LEFT.acctno = (string30)RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, LEFT.acctno = (string30)RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

// output (CHOOSEN(ds_join_baseline, eyeball), NAMED('ds_join_baseline'));
output (COUNT(ds_join_baseline), NAMED('ds_join_baseline_cnt'));
output (COUNT(ds_join_second), NAMED('ds_join_second_cnt'));
output (COUNT(ds_join_baseline(results.RV_score_auto = '200')), NAMED('ds_join_baseline_200_cnt'));
output (COUNT(ds_join_second(results.RV_score_auto = '200')), NAMED('ds_join_second_200_cnt'));
// output (CHOOSEN(ds_join_second, eyeball), NAMED('ds_join_second'));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

		
j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.RV_score_auto <> RIGHT.results.RV_score_auto
					AND Left.results.RV_score_auto < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// ashirey.Diff(ds_baseline, ds_new, ['accountnumber'], j1, 'LIA4' );

j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.RV_score_auto <> RIGHT.results.RV_score_auto 
					AND RIGHT.results.RV_score_auto < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.RV_score_auto < RIGHT.results.RV_score_auto, 
					// AND RIGHT.results.RV_score_auto < '300',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));



// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
//OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
OUTPUT(count(j1), NAMED('From_Default_count'));
OUTPUT(count(j2), NAMED('To_default_count'));
// OUTPUT(count(j3), NAMED('Increase_count'));
OUTPUT(CHOOSEN(j1, 25), named('From_Default'));
OUTPUT(CHOOSEN(j2, 25), named('To_default'));
// OUTPUT(CHOOSEN(j3, 25), named('increase'));

// scoring_project_pip.COMPARE_DSETS_MACRO(ds_baseline, ds_new, ['acctno'], 0);
// scoring_qa.CROSSTAB_MACRO(ds_baseline, ds_new, ['acctno'], 'RV_score_auto');