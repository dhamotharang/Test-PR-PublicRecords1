#workunit('name','FraudPoint 3 Scores');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip,scoring_qa;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout;

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;

 

model := 'FLA';
// model := 'FLAD';
// model := 'FLAP';
// model := 'FLAPD';
// model := 'FLAPS';
// model := 'FLAPSD';
// model := 'FLAS';
// model := 'FLASD';
// model := 'FLPS';
// model := 'FLPSD';
// model := 'FLS';
// model := 'FLSD';

 
basefilename := '~scoringqa::out::nonfcra::fraudpoint_xml_generic_fp31505_0_v3_20160621_196_experianvin_baseline' + model + '_20160621_1';
testfilename := '~scoringqa::out::nonfcra::fraudpoint_xml_generic_fp31505_0_v3_20160621_196_experianvin_second' + model + '_20160621_1';

pii_name := scoring_project_pip.Input_Sample_Names.FP_V3_Generic_FP31505_0_infile;

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, pii_layout, thor);

ds_baseline_NoErrors := ds_baseline(errorcode = '');
ds_new_NoErrors := ds_new(errorcode = '');


// OUTPUT(CHOOSEN(ds_new, eyeball), NAMED('ds_new'));
// OUTPUT(CHOOSEN(ds_pii, eyeball), NAMED('ds_pii'));

//**** Join PII to results **************

join_lay := RECORD
	input_layout results;
	pii_layout pii;
END;


ds_join_baseline := JOIN( ds_baseline_NoErrors, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new_NoErrors, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));


// output (CHOOSEN(ds_join_baseline, eyeball), NAMED('ds_join_baseline'));
// output (COUNT(ds_join_baseline), NAMED('ds_join_baseline_cnt'));
// output (COUNT(ds_join_second), NAMED('ds_join_second_cnt'));
// output (CHOOSEN(ds_join_second, eyeball), NAMED('ds_join_second'));


cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

						
			
j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno,
					// AND LEFT.results.fp_score > RIGHT.results.fp_score,
					// AND LEFT.results.fp_score < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.fp_score <> RIGHT.results.fp_score,
					// AND RIGHT.results.fp_score < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));


j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.fp_score <> RIGHT.results.fp_score
					AND LEFT.pii.state IN ['AR','AZ','DE','GA','IA','KS','NC','RI','SC','SD','VT','WA'],
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j4 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.fp_score > RIGHT.results.fp_score
					// AND LEFT.pii.state IN ['AR','AZ','DE','GA','IA','KS','NC','RI','SC','SD','VT','WA'],
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno,
					// AND LEFT.results.sourceassets = '0',
					// TRANSFORM(cmpr, SELF.res := LEFT));
					
	// j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno,
					// AND LEFT.results.sourceassets = '1',
					// TRANSFORM(cmpr, SELF.res := RIGHT));				

// Output(ave(ds_join_baseline, (integer)ds_join_baseline.results.fp_score), named('base_avg')); 
// Output(ave(ds_join_second, (integer)ds_join_second.results.fp_score), named('second_avg')); 


	// j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.sourceassets Not in['0', '1'],
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));				
					
	// j4 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND RIGHT.results.sourceassets = '0',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					
	// j5 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND RIGHT.results.sourceassets = '1',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));				
					
	// j6 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND RIGHT.results.sourceassets Not in['0', '1'],
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));							
					

// j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.rv_score_telecom <> RIGHT.results.rv_score_telecom 
					// AND Left.results.rv_score_telecom = '200',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.rv_score_telecom <> RIGHT.results.rv_score_telecom 
					// AND RIGHT.results.rv_score_telecom = '200',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));


// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
//OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));


// OUTPUT(count(j1), NAMED('Base_SourceAssets_0_Count'));
// OUTPUT(count(j2), NAMED('Base_SourceAssets_1_Count'));
// OUTPUT(count(j3), NAMED('Base_SourceAssets_default_Count'));
// OUTPUT(count(j4), NAMED('Test_SourceAssets_0_Count'));
// OUTPUT(count(j5), NAMED('Test_SourceAssets_1_Count'));
// OUTPUT(count(j6), NAMED('Test_SourceAssets_default_Count'));



OUTPUT(COUNT(j1), named('Total_' + model + '_count'));
OUTPUT(CHOOSEN(j1, 25), named('All_' + model));
 OUTPUT(COUNT(j2), named('Diff_' + model + '_count'));
 OUTPUT(CHOOSEN(j2, 25), named('Diff_' + model));
 OUTPUT(COUNT(j3), named('Diff_12_State_' + model + '_count'));
 OUTPUT(CHOOSEN(j3, 25), named('Diff_12_State_' + model));
 // OUTPUT(COUNT(j4), named('Decrease_FP_Score_in12States_count'));
 // OUTPUT(CHOOSEN(j4, 25), named('Decrease_FP_Score_in12States')); 
// OUTPUT(count(j3), NAMED('Source_Asset_Diff_count'));
// OUTPUT(CHOOSEN(j3, 25), named('Source_Asset_Diff'));


// scoring_project_pip.COMPARE_DSETS_MACRO(ds_baseline_NoErrors, ds_new_NoErrors, ['acctno'], 0);
// scoring_qa.CROSSTAB_MACRO(ds_baseline_NoErrors, ds_new_NoErrors, ['acctno'], 'fp_score');