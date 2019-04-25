#workunit('name','Experian RV v3 Attributes');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;
eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout;

prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_xml_experian_attributes_v3_20160201_crim_exp_phase3_fcra_baseline';        // Can change xml to Batch
testfilename := '~scoringqa::out::fcra::riskview_xml_experian_attributes_v3_20160201_crim_exp_phase3_fcra_second';        
pii_name := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_XML_Experian_infile;        //XML or Batch


ds_baseline := dataset(basefilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40113');
ds_new := dataset(testfilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40114');
ds_pii := dataset(pii_name, prii_layout, thor); // : PERSIST('nkoubsky::persist::RVA40114');


ds_baseline_noerrors := ds_baseline(errorcode = '');
ds_new_noerrors := ds_new(errorcode = '');


output(count(ds_baseline_noerrors));
output(count(ds_new_noerrors));


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

// OUTPUT(ds_join_baseline(results.acctno = '110826U148949'), NAMED('join_results'));


cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.accountnumber := '-', SELF := []));



 j1 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
					AND LEFT.results.felonies30 <> RIGHT.results.felonies30,
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
	

 j2 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
					AND LEFT.results.felonies <> RIGHT.results.felonies,
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

					

OUTPUT(count(j1), NAMED('Change_felonies30_count'));
OUTPUT(count(j2), NAMED('Change_felonies_count'));

OUTPUT(CHOOSEN(j1, 25), named('felonies30'));
OUTPUT(CHOOSEN(j2, 25), named('felonies'));


ashirey.flatten(ds_baseline, flatten_baseline);
ashirey.flatten(ds_new, flatten_second);
scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['accountnumber'], 0);
scoring_project_pip.CROSSTAB_MACRO( flatten_baseline, flatten_second, ['accountnumber'], 'felonies30');