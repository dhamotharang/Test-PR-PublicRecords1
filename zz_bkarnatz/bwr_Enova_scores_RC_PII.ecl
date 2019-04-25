#workunit('name','Enova Scores');   //ENOVA XML Scores
import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;
eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_ENOVA_rvg1103_0_V4_Global_Layout;

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_xml_enova_rvg1103_0_v4_20150223_1';    
testfilename := '~scoringqa::out::fcra::riskview_xml_enova_rvg1103_0_v4_20150224_1';  
pii_name := scoring_project_pip.Input_Sample_Names.RV_V3_ENOVA_XML_Scores_infile_name;

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor); 
ds_pii := dataset(pii_name, pii_layout, thor); ;


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


ds_join_baseline := JOIN( ds_baseline, ds_pii, LEFT.acctno = (string30)RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, LEFT.acctno = (string30)RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

// output (CHOOSEN(ds_join_baseline, eyeball), NAMED('ds_join_baseline'));
// output (COUNT(ds_join_baseline), NAMED('ds_join_baseline_cnt'));
// output (CHOOSEN(ds_join_second, eyeball), NAMED('ds_join_second'));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

		
j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.rv_score_money <> RIGHT.results.rv_score_money, 
					// AND Left.results.rv_score_telecom < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// ashirey.Diff(ds_baseline, ds_new, ['accountnumber'], j1, 'LIA4' );

j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.rv_score_money > RIGHT.results.rv_score_money, 
					// AND RIGHT.results.rv_score_telecom < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.rv_score_money < RIGHT.results.rv_score_money, 
					// AND RIGHT.results.rv_score_telecom < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));



// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
//OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
OUTPUT(count(j1), NAMED('Differences_count'));
OUTPUT(count(j2), NAMED('decrease_count'));
OUTPUT(count(j3), NAMED('Increase_count'));
OUTPUT(CHOOSEN(j1, 25), named('Differences'));
OUTPUT(CHOOSEN(j2, 25), named('decrease'));
OUTPUT(CHOOSEN(j3, 25), named('increase'));
