#workunit('name','Lead Integrity v4 Scores');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout;

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
  

basefilename := '~scoringqa::out::nonfcra::leadintegrity_batch_generic_msn1106_0_v4_20150603_1';    // XML or Batch
testfilename := '~scoringqa::out::nonfcra::leadintegrity_batch_generic_msn1106_0_v4_20150604_1';
pii_name := scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;

ds_baseline := dataset(basefilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40113');
ds_new := dataset(testfilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40114');
ds_pii := dataset(pii_name, pii_layout, thor);

join_lay := RECORD
	input_layout results;
	pii_layout pii;
END;

ds_join_baseline := JOIN( ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

OUTPUT(COUNT(ds_baseline(score = '210')), NAMED('base_count_210'));
OUTPUT(COUNT(ds_new(score = '210')), NAMED('new_count_210'));
// OUTPUT(COUNT(ds_new(score < '300')) - COUNT(ds_baseline(score < '300')), NAMED('diff_count_222'));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

				
j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
				//AND LEFT.seq = RIGHT.seq
			  AND LEFT.results.score <> RIGHT.results.score
				AND LEFT.results.score < '300',
				TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

//ashirey.Diff(ds_baseline, ds_new, ['accountnumber'], j1, 'LIA4' );

j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					 AND LEFT.results.score <> RIGHT.results.score
					 AND RIGHT.results.score < '300',
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					 AND LEFT.results.score < RIGHT.results.score,
					 // AND LEFT.results.score = '200',
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j4 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.score > RIGHT.results.score,
					 // AND RIGHT.results.score = '200',
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

 // OUTPUT(CHOOSEN(ds_baseline,eyeball));
 // OUTPUT(COUNT(ds_baseline), NAMED('base_count'));
 // OUTPUT(CHOOSEN(ds_new,eyeball));
 // OUTPUT(COUNT(ds_new), NAMED('second_count'));
 // OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
 // OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
 //OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
OUTPUT(count(j1), NAMED('From_default_count'));
OUTPUT(count(j2), NAMED('To_default_count'));
OUTPUT(count(j3), NAMED('Increase_Count'));
OUTPUT(count(j4), NAMED('Decrease_count'));
OUTPUT(CHOOSEN(j1, 25), named('From_default'));
OUTPUT(CHOOSEN(j2, 25), named('To_default'));
OUTPUT(CHOOSEN(j3, 25), named('Increases'));
OUTPUT(CHOOSEN(j4, 25), named('Decreases'));

// scoring_project_pip.COMPARE_DSETS_MACRO(ds_baseline, ds_new, ['AccountNumber'], 1 );
// Scoring_Project_PIP.CROSSTAB_MACRO(ds_baseline, ds_new, ['AccountNumber'],'did');
