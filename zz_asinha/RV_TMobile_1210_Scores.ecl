#workunit('name','T-Mobile 1210 Score');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_T_mobile_RVT1210_1_V4_Global_Layout;

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_xml_t_mobile_rvt1210_1_v4_20160201_crim_exp_phase3_fcra_baseline';
testfilename := '~scoringqa::out::fcra::riskview_xml_t_mobile_rvt1210_1_v4_20160201_crim_exp_phase3_fcra_second';  
pii_name := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1210_1_infile;


ds_baseline := dataset(basefilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40113');
ds_new := dataset(testfilename,input_layout,thor); // : PERSIST('nkoubsky::persist::RVA40114');
ds_pii := dataset(pii_name, pii_layout, thor); // : PERSIST('nkoubsky::persist::RVA40114');


ds_baseline_noerrors := ds_baseline(errorcode = '');
ds_new_noerrors := ds_new(errorcode = '');


output(count(ds_baseline_noerrors));
output(count(ds_new_noerrors));


Rec := RECORD
	STRING30 		acctno;
	unsigned6   did;
	integer			RV_score_telecom;
END;


Rec Score_Trans(input_layout le) := TRANSFORM
	self.acctno := le.acctno;
	self.did := le.did;
	self.RV_score_telecom := (integer)le.RV_score_telecom
END; 


new_baseline := join(ds_baseline_noerrors, ds_new_noerrors, left.acctno = right.acctno, Score_Trans(left));
new_test := join(ds_baseline_noerrors, ds_new_noerrors, left.acctno = right.acctno, Score_Trans(right));


// ds_baseline := ds_baseline1(acctno IN ['10175', '10190', '10195', '10540']);
// ds_new := ds_new1(acctno IN ['10175', '10190', '10195', '10540']);

// OUTPUT(COUNT(ds_baseline (rv_score_telecom = '222')), NAMED('ds_baseline'));
// OUTPUT(COUNT(ds_new (rv_score_telecom = '222')), NAMED('ds_new'));
// OUTPUT(CHOOSEN(ds_new, eyeball), NAMED('ds_new'));
// OUTPUT(CHOOSEN(ds_pii, eyeball), NAMED('ds_pii'));

//**** Join PII to results **************

join_lay := RECORD
	input_layout results;
	pii_layout pii;
END;


ds_join_baseline := JOIN( ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

// output (CHOOSEN(ds_join_baseline, eyeball), NAMED('ds_join_baseline'));
output (COUNT(ds_join_baseline), NAMED('ds_join_baseline_cnt'));
output (COUNT(ds_join_second), NAMED('ds_join_second_cnt'));
// output (CHOOSEN(ds_join_second, eyeball), NAMED('ds_join_second'));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

clean_baseline := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno,
				  // AND LEFT.errorcode + RIGHT.errorcode = '',
					// AND LEFT.rv_score_telecom <> RIGHT.rv_score_telecom 
					// AND Left.rv_score_telecom < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
	
output (COUNT(clean_baseline), NAMED('clean_baseline_Second_join_cnt'));				
					
/*
clean_second := join(ds_baseline, ds_new, left.acctno = right.acctno
				  AND LEFT.errorcode + RIGHT.errorcode = '',
					AND LEFT.rv_score_telecom <> RIGHT.rv_score_telecom 
					AND RIGHT.rv_score_telecom < '300',
					TRANSFORM(input_layout, SELF := RIGHT));
		*/			
j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.rv_score_telecom <> RIGHT.results.rv_score_telecom 
					AND LEFT.results.rv_score_telecom < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.rv_score_telecom <> RIGHT.results.rv_score_telecom 
					AND RIGHT.results.rv_score_telecom < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));


j8 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.rv_score_telecom < RIGHT.results.rv_score_telecom,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j9 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.rv_score_telecom > RIGHT.results.rv_score_telecom,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.rv_score_telecom <> RIGHT.results.rv_score_telecom 
					// AND Left.results.rv_score_telecom = '200',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.rv_score_telecom <> RIGHT.results.rv_score_telecom 
					// AND RIGHT.results.rv_score_telecom = '200',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));


OUTPUT(count(j1), NAMED('Decrease_default_Count'));
OUTPUT(count(j2), NAMED('Increase_default_count'));
// OUTPUT(count(j3), NAMED('death_count'));
OUTPUT(CHOOSEN(j1, 25), named('Decrease_default'));
 OUTPUT(CHOOSEN(j2, 25), named('Increase_default'));
// OUTPUT(CHOOSEN(j3, 25), named('Died'));

OUTPUT(count(j8), NAMED('Increase_Score_Count'));
OUTPUT(count(j9), NAMED('Decrease_Score_Count'));

OUTPUT(CHOOSEN(j8, 25), named('Increase_Score'));
OUTPUT(CHOOSEN(j9, 25), named('Decrease_Score'));


ashirey.flatten(ds_baseline, flatten_baseline);
ashirey.flatten(ds_new, flatten_second);
scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['acctno'], 0);
scoring_project_pip.CROSSTAB_MACRO( new_baseline, new_test, ['acctno'], 'rv_score_telecom');