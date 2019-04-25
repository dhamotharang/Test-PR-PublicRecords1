#workunit('name','RV V2 Credit Acceptance Corp Attributes');
import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_CreditAcceptancecorp_Attributes_V2_Global_Layout;

prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_xml_creditacceptancecorp_attributes_v2_20150211_1';        
testfilename := '~scoringqa::out::fcra::riskview_xml_creditacceptancecorp_attributes_v2_20150212_1';       
pii_name := scoring_project_pip.Input_Sample_Names.CreditAcceptanceCorp_RV2_BATCH_infile_name;


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

ds_join_baseline := JOIN( ds_baseline, ds_pii, (Integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

OUTPUT(AVE(ds_join_baseline, (integer)ds_join_baseline.results.assesseddiff2), NAMED('AVE_Baseline_assesseddiff2'));
OUTPUT(AVE(ds_join_second, (integer)ds_join_second.results.assesseddiff2), NAMED('AVE_Test_assesseddiff2'));


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
					
// ashirey.Diff(ds_baseline, ds_new, ['accountnumber'], j1, 'Credit_Acceptance_RV_V2' );

 j1 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
					AND (integer)LEFT.results.assesseddiff2 < (integer)RIGHT.results.assesseddiff2,
					// AND Left.results.inputaddridentitiesrecentcount = '',
					// AND LEFT.results.rv_score_prescreen < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));

 j2 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
					AND (integer)LEFT.results.assesseddiff2 > (integer)RIGHT.results.assesseddiff2,
					// AND Left.results.inputaddridentitiescount = '',
					// AND LEFT.results.rv_score_prescreen < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));
					
 // j3 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
					 // AND LEFT.results.firstname = RIGHT.results.firstname
					 // AND LEFT.results.firstname = '',
					// AND LEFT.results.numsources <> '2'
					// AND RIGHT.results.numsources = '2',
					// AND LEFT.results.rv_score_prescreen < '300',
				   // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));					
					

// j4 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.did > 0
					// AND RIGHT.results.did = 0, 
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j5 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.did = 0
					// AND RIGHT.results.did > 0, 
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j6 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.did = 0
					// AND RIGHT.results.did = 0, 
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j7 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.did = RIGHT.results.did
					// AND Left.results.did <> 0, 
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));								
			
 // OUTPUT(CHOOSEN(clean_baseline,eyeball));
 // OUTPUT(COUNT(clean_baseline), NAMED('base_count'));
 // OUTPUT(CHOOSEN(clean_second,eyeball));
 // OUTPUT(COUNT(clean_second), NAMED('second_count'));

// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
OUTPUT(count(j1), NAMED('Increase_assesseddiff2_count'));
//OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
OUTPUT(count(j2), NAMED('Decrease_assesseddiff2_count'));
// OUTPUT(count(j3), NAMED('decrease_numsourcesTo2_count'));
OUTPUT(CHOOSEN(j1, 25), named('Increase_assesseddiff2'));
OUTPUT(CHOOSEN(j2, 25), named('Decrease_assesseddiff2'));

// OUTPUT(count(j3), NAMED('Valid_to_valid_changed_count'));
// OUTPUT(count(j4), NAMED('valid_to_zero_Lost_count'));
// OUTPUT(count(j5), NAMED('zero_to_valid_gained_count'));
// OUTPUT(count(j6), NAMED('No_Hit_count'));
// OUTPUT(count(j7), NAMED('Valid_to_valid_unchanged_count'));
// OUTPUT(CHOOSEN(j3, 25), named('Valid_to_valid_changed'));
// OUTPUT(CHOOSEN(j4, 25), named('valid_to_zero_Lost'));
// OUTPUT(CHOOSEN(j5, 25), named('zero_to_valid_gained'));
// OUTPUT(CHOOSEN(j6, 25), named('No_Hit'));
// OUTPUT(CHOOSEN(j7, 25), named('Valid_to_valid_unchanged'));