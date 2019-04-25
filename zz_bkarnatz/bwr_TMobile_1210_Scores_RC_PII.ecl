#workunit('name','T-Mobile 1210 Score');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_T_mobile_RVT1210_1_V4_Global_Layout;

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_xml_t_mobile_rvt1210_1_v4_20141118_1';
testfilename := '~scoringqa::out::fcra::riskview_xml_t_mobile_rvt1210_1_v4_20141119_1';  
pii_name := scoring_project_pip.Input_Sample_Names.T_Mobile_RVT1210_infile_name;


ds_baseline := dataset(basefilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40113');
ds_new := dataset(testfilename,input_layout,thor); // : PERSIST('nkoubsky::persist::RVA40114');
ds_pii := dataset(pii_name, pii_layout, thor); // : PERSIST('nkoubsky::persist::RVA40114');


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

// ashirey.Diff(ds_baseline, ds_new, ['accountnumber'], j1, 'LIA4' );

j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.did <> RIGHT.results.did
					AND LEFT.results.did > 0
					AND RIGHT.results.did > 0, 
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j4 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.did > 0
					AND RIGHT.results.did = 0, 
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j5 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.did = 0
					AND RIGHT.results.did > 0, 
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j6 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.did = 0
					AND RIGHT.results.did = 0, 
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j7 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.did = RIGHT.results.did
					AND Left.results.did <> 0, 
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

// output (CHOOSEN(ds_join_baseline, eyeball));
// output (CHOOSEN(ds_join_second, eyeball));

 // OUTPUT(CHOOSEN(clean_baseline,eyeball));
 // OUTPUT(COUNT(clean_baseline), NAMED('base_count'));
 // OUTPUT(CHOOSEN(clean_second,eyeball));
 // OUTPUT(COUNT(clean_second), NAMED('second_count'));

// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
//OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
OUTPUT(count(j1), NAMED('Decrease_default_Count'));
OUTPUT(count(j2), NAMED('Increase_default_count'));
// OUTPUT(count(j3), NAMED('death_count'));
OUTPUT(CHOOSEN(j1, 25), named('Decrease_default'));
 OUTPUT(CHOOSEN(j2, 25), named('Increase_default'));
// OUTPUT(CHOOSEN(j3, 25), named('Died'));
OUTPUT(count(j3), NAMED('Valid_to_valid_changed_count'));
OUTPUT(count(j4), NAMED('valid_to_zero_Lost_count'));
OUTPUT(count(j5), NAMED('zero_to_valid_gained_count'));
OUTPUT(count(j6), NAMED('No_Hit_count'));
OUTPUT(count(j7), NAMED('Valid_to_valid_unchanged_count'));
OUTPUT(count(j8), NAMED('Increase_Score_Count'));
OUTPUT(count(j9), NAMED('Decrease_Score_Count'));
OUTPUT(CHOOSEN(j3, 25), named('Valid_to_valid_changed'));
OUTPUT(CHOOSEN(j4, 25), named('valid_to_zero_Lost'));
OUTPUT(CHOOSEN(j5, 25), named('zero_to_valid_gained'));
OUTPUT(CHOOSEN(j6, 25), named('No_Hit'));
OUTPUT(CHOOSEN(j7, 25), named('Valid_to_valid_unchanged'));
OUTPUT(CHOOSEN(j8, 25), named('Increase_Score'));
OUTPUT(CHOOSEN(j9, 25), named('Decrease_Score'));