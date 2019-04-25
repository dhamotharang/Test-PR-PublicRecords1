#workunit('name','Best Buy CBD');
import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_BestBuy_CDS_CDN1109_1_Global_Layout;

pii_lay :=RECORD
  Scoring_Project_Macros.Regression.global_layout;
  Scoring_Project_Macros.Regression.pii_layout pii1;
  Scoring_Project_Macros.Regression.pii_layout pii2;
 Scoring_Project_Macros.Regression.runtime_layout;
	// BTSTCustomIn;
 END;


basefilename := '~scoringqa::out::nonfcra::chargebackdefender_xml_bestbuy_cdn1109_1_20160616_1';
testfilename := '~scoringqa::out::nonfcra::chargebackdefender_xml_bestbuy_cdn1109_1_20160617_1';  
pii_name := scoring_project_pip.Input_Sample_Names.ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile;


ds_baseline := dataset(basefilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40113');
ds_new := dataset(testfilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40114');
ds_pii := dataset(pii_name, pii_lay, thor);

join_lay := RECORD
	input_layout results;
	pii_lay pii;
END;


ds_join_baseline := JOIN( ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.cb_score <> RIGHT.results.cb_score,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
		
j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.cb_score > RIGHT.results.cb_score,
					// AND LEFT.results.cb_score = '222',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.cb_score < RIGHT.results.cb_score,
					// AND RIGHT.results.cb_score = '222',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
		
	
//ashirey.Diff(ds_baseline, ds_new, ['account'], j1, 'LIA4' );


 // OUTPUT(CHOOSEN(clean_baseline,eyeball));
 // OUTPUT(COUNT(clean_baseline), NAMED('base_count'));
 // OUTPUT(CHOOSEN(clean_second,eyeball));
 // OUTPUT(COUNT(clean_second), NAMED('second_count'));
 
 
OUTPUT(count(j1), NAMED('Diff_Score_Count'));
OUTPUT(count(j2), NAMED('Decrease_Score_Count'));
OUTPUT(count(j3), NAMED('Increase_Score_count'));
OUTPUT(CHOOSEN(j1, 25), named('Diff_Score'));
OUTPUT(CHOOSEN(j2, 25), named('Decrease_Score'));
OUTPUT(CHOOSEN(j3, 25), named('Increase_Score'));
 
 
// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
// OUTPUT(count(j1), NAMED('difference_count'));
//OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
// OUTPUT(count(j2), NAMED('valid_to_optout_count'));
// OUTPUT(CHOOSEN(j1, 25), named('differences'));


scoring_project_pip.COMPARE_DSETS_MACRO(ds_baseline, ds_new, ['acctno'], 0);