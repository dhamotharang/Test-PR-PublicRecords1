#workunit('name','RV 5 Scores');


import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP, zz_bbraaten;

eyeball := 30;

input_layout := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout;

prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
 
 	a:= ut.GetDate;
	
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);
b1:=b +'_1'; 
	
	a1:= a +'_1';

basefilename := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_attributes_v5_' + b1;        //V3 or V4
testfilename := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_attributes_v5_' + a1;   
pii_name := scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile; 					  //V3 or V4   XML or Batch


ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, prii_layout, thor);


		clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	output(count(ds_baseline(errorcode <> '')),named('base_errors'));
	output(count(ds_new(errorcode <> '')),named('prop_errors'));




a3 := ave( clean_ds_baseline, (integer)auto_score);
b3 := ave( clean_ds_new, (integer)auto_score);

output((b3-a3), named('ave_auto'));

a4 := ave( clean_ds_baseline, (integer)short_term_lending_score);
b4 := ave( clean_ds_new, (integer)short_term_lending_score);

output((b4-a4), named('ave_money'));


a5 := ave( clean_ds_baseline, (integer)bankcard_score);
b5 := ave( clean_ds_new, (integer)bankcard_score);

output((b5-a5), named('ave_bank'));


a6 := ave( clean_ds_baseline, (integer)telecommunications_score);
b6 := ave( clean_ds_new, (integer)telecommunications_score);


output((b6-a6), named('ave_telecom'));


join_lay := RECORD
	input_layout results;
	prii_layout pii;
END;


ds_join_baseline := JOIN( clean_ds_baseline, ds_pii, (integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( clean_ds_new, ds_pii, (integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));



cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.accountnumber := '-', SELF := []));


j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.EducationEvidence <> RIGHT.results.EducationEvidence,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
		
OUTPUT(count(j1), NAMED('EducationEvidence_count'));
	OUTPUT(CHOOSEN(j1, 25), named('EducationEvidence'));
	

scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['acctNo'], 0);
// scoring_project_pip.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 'businessassociationtimeoldest');


