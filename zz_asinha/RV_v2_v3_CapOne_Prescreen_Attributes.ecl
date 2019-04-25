#workunit('name','CapitalOne Prescreen Attributes RV V3');
// #workunit('name','CapitalOne Prescreen Attributes RV V2');
import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Capitalone_Attributes_V2_Global_Layout;  //V2 or V3

pii_lay := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_batch_capitalone_attributes_v2_20160201_crim_exp_phase3_fcra_baseline';      //v2 or v3
testfilename := '~scoringqa::out::fcra::riskview_batch_capitalone_attributes_v2_20160201_crim_exp_phase3_fcra_second';  
pii_name := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;        //v2 or v3


ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, pii_lay, thor);


ds_baseline_noerrors := ds_baseline(errorcode = '');
ds_new_noerrors := ds_new(errorcode = '');


output(count(ds_baseline_noerrors));
output(count(ds_new_noerrors));


join_lay := RECORD
	input_layout results;
	pii_lay pii;
END;


ds_join_baseline := JOIN( ds_baseline, ds_pii, (integer)LEFT.AccountNumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.AccountNumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.AccountNumber := '-', SELF := []));

j1 := join(ds_join_baseline, ds_join_second, left.results.AccountNumber = right.results.AccountNumber
					AND LEFT.results.felonies30 <> RIGHT.results.felonies30,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
		
j2 := join(ds_join_baseline, ds_join_second, left.results.AccountNumber = right.results.AccountNumber
					AND LEFT.results.felonies <> RIGHT.results.felonies,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j3 := join(ds_join_baseline, ds_join_second, left.results.AccountNumber = right.results.AccountNumber
					// AND LEFT.results.cb_score <> RIGHT.results.cb_score,
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
		
	

OUTPUT(count(j1), NAMED('Diff_felonies30_Count'));
OUTPUT(CHOOSEN(j1, 25), named('felonies30'));

OUTPUT(count(j2), NAMED('Diff_felonies_Count'));
OUTPUT(CHOOSEN(j2, 25), named('felonies'));

// OUTPUT(count(j3), NAMED('Diff_ssndeceased_Count'));
// OUTPUT(CHOOSEN(j3, 25), named('Diff_ssndeceased'));

 
ashirey.flatten(ds_baseline, flatten_baseline);
ashirey.flatten(ds_new, flatten_second);
scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['accountnumber'], 0);
scoring_project_pip.CROSSTAB_MACRO( flatten_baseline, flatten_second, ['accountnumber'], 'felonies30'); 
