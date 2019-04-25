#workunit('name','RV 3Score');


import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP;

eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V3_Global_Layout;  //V3 or V4

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

basefilename := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_'+b1;      //V3 or V4
testfilename := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_'+a1; 
    
pii_name := scoring_project_pip.Input_Sample_Names.RV_V3_Generic_infile; 					  //V3 or V4   XML or Batch


ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, prii_layout, thor);


	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	output(count(ds_baseline(errorcode <> '')),named('base_errors'));
	output(count(ds_new(errorcode <> '')),named('prop_errors'));


ab := ave( clean_ds_baseline, (integer)RV_score_auto);
ap := ave( clean_ds_new, (integer)RV_score_auto);

ap - ab;

gb := ave( clean_ds_baseline, (integer)RV_score_money);
gp := ave( clean_ds_new, (integer)RV_score_money);

gp - gb;


bb := ave( clean_ds_baseline, (integer)RV_score_bank);
bp := ave( clean_ds_new, (integer)RV_score_bank);

bp - bb;

tb := ave( clean_ds_baseline, (integer)RV_score_telecom);
tp := ave( clean_ds_new, (integer)RV_score_telecom);

tp - tb;

pb := ave( clean_ds_baseline, (integer)RV_score_prescreen);
pp := ave( clean_ds_new, (integer)RV_score_prescreen);

pp - pb;

rb := ave( clean_ds_baseline, (integer)rv_score_retail);
rp := ave( clean_ds_new, (integer)rv_score_retail);

rp - rb;

// OUTPUT(COUNT(ds_new(RV_score_prescreen = '222')) - COUNT(clean_ds_baseline(RV_score_prescreen = '222')), NAMED('diff_count_222'));

//**** Join PII to results **************

join_lay := RECORD
	input_layout results;
	prii_layout pii;
END;


ds_join_baseline := JOIN( clean_ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( clean_ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));


cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(input_layout, SELF.acctno := '-', SELF := []));


 j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.RV_score_prescreen	 <> RIGHT.results.RV_score_prescreen	
					// AND LEFT.results.did	= RIGHT.results.did	
					AND LEFT.results.RV_score_prescreen	 < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

OUTPUT(count(j1), NAMED('from_default_count'));
OUTPUT(CHOOSEN(j1, all), named('from_default'));


 j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.RV_score_prescreen	 <> RIGHT.results.RV_score_prescreen	
					// AND LEFT.results.did	 = RIGHT.results.did	
					AND RIGHT.results.RV_score_prescreen	 < '300',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

OUTPUT(count(j2), NAMED('to_default_count'));
 OUTPUT(CHOOSEN(j2, all), named('to_default'));

 j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND abs((integer)LEFT.results.RV_score_auto	 - (integer)RIGHT.results.RV_score_auto) > 70
					AND LEFT.results.did	<> RIGHT.results.did,
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

OUTPUT(count(j3), NAMED('did_not_equal_count'));
 OUTPUT(CHOOSEN(j3, 25), named('did_not_equal'));

 j4 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.RV_score_prescreen	<>  RIGHT.results.RV_score_prescreen
					AND LEFT.results.rv_prescreen_reason	= '95',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

OUTPUT(count(j4), NAMED('default_to_score_count'));
 OUTPUT(CHOOSEN(j4, 25), named('default_to_score'));


		 j5 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.RV_score_prescreen	<>  RIGHT.results.RV_score_prescreen
					AND right.results.rv_prescreen_reason	= '95',
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

OUTPUT(count(j5), NAMED('score_to_default_count'));
 OUTPUT(CHOOSEN(j5, 25), named('score_to_default'));


scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['acctNo'], 0);
// scoring_project_pip.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 'RV_score_auto');


