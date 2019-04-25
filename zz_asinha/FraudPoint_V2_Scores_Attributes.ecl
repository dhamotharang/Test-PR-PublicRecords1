#workunit('name','FraudPoint 2 Attributes');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout;

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;

 
basefilename := '~scoringqa::out::nonfcra::fraudpoint_xml_generic_fp1109_0_v2_20160201_crim_exp_phase3_fcra_baseline';    //XML or Batch
testfilename := '~scoringqa::out::nonfcra::fraudpoint_xml_generic_fp1109_0_v2_20160201_crim_exp_phase3_fcra_second';  
pii_name := scoring_project_pip.Input_Sample_Names.FP_V2_Generic_FP1109_0_infile;          //XML or Batch

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, pii_layout, thor);


ds_baseline_noerrors := ds_baseline(errorcode = '');
ds_new_noerrors := ds_new(errorcode = '');

ds_baseline_errors := ds_baseline(errorcode <> '');
ds_new_errors := ds_new(errorcode <> '');

output(count(ds_baseline_noerrors));
output(count(ds_new_noerrors));

output(count(ds_baseline_errors));
output(count(ds_new_errors));

output(choosen(ds_baseline_errors, 25), named('Errors_in_baseline'));
output(choosen(ds_new_errors, 25), named('Errors_in_test'));

input_layout trans_noerror(input_layout le) := Transform
	self.acctno := le.acctno;
	self.did := le.did;
	self := le;
End;


ds_baseline_new := join(ds_baseline_noerrors, ds_new_noerrors, left.acctno = right.acctno, trans_noerror(Left) );
ds_test_new := join(ds_baseline_noerrors, ds_new_noerrors, left.acctno = right.acctno, trans_noerror(Right) );

Output(count(ds_baseline_new), named('Count_baseline_after_noerrors_and_join'));
Output(count(ds_test_new), named('Count_test_after_noerrors_and_join'));

join_lay := RECORD
	input_layout results;
	pii_layout pii;
END;


ds_join_baseline := JOIN( ds_baseline_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_test_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));



cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));


j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.fp_score > RIGHT.results.fp_score,
					// AND LEFT.results.fp_score < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.fp_score < RIGHT.results.fp_score,
					// AND RIGHT.results.fp_score < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));


joinedrec := Record
	input_layout.acctno;
	Integer diff;
End;
			
			
joinedrec dojoin(input_layout le, input_layout ri) := transform
	self.diff := (integer)ri.fp_score - (integer)le.fp_score;
	self := le;
End;

j6 := join(ds_baseline_new, ds_test_new, left.acctno = right.acctno, dojoin(left,right));

t_1 := table(j6, {diff; total := count(group)}, diff);

t_2 := sort(t_1, diff);

Output(choosen(t_2,800), named('Table'));


OUTPUT(count(j1), NAMED('Decrease_FP_Score_Count'));
OUTPUT(count(j2), NAMED('Increase_FP_Score_count'));

OUTPUT(CHOOSEN(j1, 25), named('Decrease_FP_Score'));
OUTPUT(CHOOSEN(j2, 25), named('Increase_FP_Score'));

ashirey.flatten(ds_baseline_new, flatten_baseline);
ashirey.flatten(ds_test_new, flatten_second);
scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['acctno'], 0);
scoring_project_pip.CROSSTAB_MACRO( flatten_baseline, flatten_second, ['acctno'], 'fp_score ');