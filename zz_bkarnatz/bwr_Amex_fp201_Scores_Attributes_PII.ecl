#workunit('name','Amex FraudPoint v201 Attributes');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V201_AmericanExpress_Global_Layout;

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;

 
basefilename := '~scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_20170118_proflic_20161206_baseline';
testfilename := '~scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_20170118_proflic_20161206a_second';
pii_name := scoring_project_pip.Input_Sample_Names.FP_V2_American_Express_FP1109_0_infile;

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, pii_layout, thor);


//**** Join PII to results **************

join_lay := RECORD
	input_layout results;
	pii_layout pii;
END;


ds_join_baseline := JOIN( ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

// output (CHOOSEN(ds_join_baseline, eyeball), NAMED('ds_join_baseline'));
// output (COUNT(ds_join_baseline), NAMED('ds_join_baseline_cnt'));
// output (COUNT(ds_join_second), NAMED('ds_join_second_cnt'));
// output (CHOOSEN(ds_join_second, eyeball), NAMED('ds_join_second'));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));


j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.sourcerisklevel <> RIGHT.results.sourcerisklevel,
					// AND LEFT.results.fp_score < '300',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.fp_score < RIGHT.results.fp_score,
					// AND RIGHT.results.fp_score < '300',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// output (CHOOSEN(ds_join_baseline, eyeball));
// output (CHOOSEN(ds_join_second, eyeball));


OUTPUT(count(j1), NAMED('Diff_sourcerisklevel_Count'));
// OUTPUT(count(j2), NAMED('Increase_FP_Score_count'));
OUTPUT(CHOOSEN(j1, 25), named('Diff_sourcerisklevel'));
 // OUTPUT(CHOOSEN(j2, 25), named('Increase_FP_Score'));


// scoring_project_pip.COMPARE_DSETS_MACRO(ds_baseline, ds_new, ['acctno'], 0 );
// scoring_project_pip.CROSSTAB_MACRO(ds_baseline, ds_new, ['acctno'], 'AgeNewestRecord');