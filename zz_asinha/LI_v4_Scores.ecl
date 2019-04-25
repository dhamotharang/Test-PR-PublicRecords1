#workunit('name','Lead Integrity v4 Scores');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout;

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
  

basefilename := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_msn1106_0_v4_20160201_crim_exp_phase3_fcra_baseline';    // XML or Batch
testfilename := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_msn1106_0_v4_20160201_crim_exp_phase3_fcra_second';
pii_name := scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;

ds_baseline := dataset(basefilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40113');
ds_new := dataset(testfilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40114');
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

OUTPUT(COUNT(ds_baseline(score = '210')), NAMED('base_count_210'));
OUTPUT(COUNT(ds_new(score = '210')), NAMED('new_count_210'));
// OUTPUT(COUNT(ds_new(score < '300')) - COUNT(ds_baseline(score < '300')), NAMED('diff_count_222'));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

				
j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
			  AND LEFT.results.score <> RIGHT.results.score
				AND LEFT.results.score < '300',
				TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));



j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					 AND LEFT.results.score <> RIGHT.results.score
					 AND RIGHT.results.score < '300',
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					 AND LEFT.results.score <> RIGHT.results.score,
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));



OUTPUT(count(j1), NAMED('From_default_count'));
OUTPUT(count(j2), NAMED('To_default_count'));
OUTPUT(count(j3), NAMED('Change_Score_Count'));

OUTPUT(CHOOSEN(j1, 25), named('From_default'));
OUTPUT(CHOOSEN(j2, 25), named('To_default'));
OUTPUT(CHOOSEN(j3, 25), named('Change_Score'));


ashirey.flatten(ds_baseline, flatten_baseline);
ashirey.flatten(ds_new, flatten_second);
scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['acctno'], 0);
scoring_project_pip.CROSSTAB_MACRO( flatten_baseline, flatten_second, ['acctno'], 'score ');
