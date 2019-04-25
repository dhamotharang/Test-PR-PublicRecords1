#workunit('name','CapitalOne Prescreen Attributes RV V5');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Capone_allflagships_Attributes_V5_Batch_Layout;

pii_lay := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_batch_capitalone_attributes_v5_20161130_emaildata20161025_impulseemail20160804_baseline';  
testfilename := '~scoringqa::out::fcra::riskview_batch_capitalone_attributes_v5_20161130_emaildata20161104_impulseemail20161129_second';
pii_name := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;        //v2 used for V5


ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, pii_lay, thor);

ds_baseline_NoErrors := ds_baseline(errorcode= '');
ds_new_NoErrors := ds_new(errorcode='');


join_lay := RECORD
	input_layout results;
	pii_lay pii;
END;


ds_join_baseline := JOIN( ds_baseline_NoErrors, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new_NoErrors, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.shorttermloanrequest <> RIGHT.results.shorttermloanrequest,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
		
j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.subjectwillingnessindex <> RIGHT.results.subjectwillingnessindex,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.subjectwillingnessprimaryfactor <> RIGHT.results.subjectwillingnessprimaryfactor,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
		
 
// OUTPUT(count(j1), NAMED('Diff_shorttermloanrequest_Count'));
// OUTPUT(count(j2), NAMED('Diff_subjectwillingnessindex_Count'));
// OUTPUT(count(j3), NAMED('Diff_subjectwillingnessprimaryfactor_Count'));
// OUTPUT(CHOOSEN(j1, 25), named('Diff_shorttermloanrequest'));
// OUTPUT(CHOOSEN(j2, 25), named('Diff_subjectwillingnessindex'));
// OUTPUT(CHOOSEN(j3, 25), named('Diff_subjectwillingnessprimaryfactor'));
 
 
// table1 := table(ds_baseline_NoErrors, {liencount;namedcount :=count(group)},liencount, sorted);
// table2 := table(ds_new_NoErrors, {liencount;namedcount :=count(group)},liencount, sorted);
// table3 := table(ds_baseline_NoErrors, {derogcount;namedcount :=count(group)},derogcount, sorted);
// table4 := table(ds_new_NoErrors, {derogcount;namedcount :=count(group)},derogcount, sorted);
// table5 := table(ds_baseline_NoErrors, {evictioncount;namedcount :=count(group)},evictioncount, sorted);
// table6 := table(ds_new_NoErrors, {evictioncount;namedcount :=count(group)},evictioncount, sorted);

// output(table1, Named('base_liencount'));
// output(table2, Named('second_liencount'));

// output(table3, Named('base_derogcount'));
// output(table4, Named('second_derogcount'));

// output(table5, Named('base_evictioncount'));
// output(table6, Named('second_evictioncount'));

// j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.did <> RIGHT.results.did
					// AND LEFT.results.did > 0
					// AND RIGHT.results.did > 0, 
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

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

scoring_project_pip.COMPARE_DSETS_MACRO(ds_baseline_NoErrors, ds_new_NoErrors, ['acctno'], 0);
// scoring_qa.CROSSTAB_MACRO(ds_baseline, ds_new, ['acctno'], 'shorttermloanrequest');
