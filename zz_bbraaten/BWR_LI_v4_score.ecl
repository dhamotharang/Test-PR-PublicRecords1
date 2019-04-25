#workunit('name','Lead Integrity v4 Scores');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout;

pii_layout := RECORD
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
	
	a1:= '20171031_1';





basefilename := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_msn1106_0_v4_'+b1;    // XML or Batch
testfilename := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_msn1106_0_v4_'+a1;
pii_name := scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;

ds_baseline := dataset(basefilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40113');
ds_new := dataset(testfilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40114');
ds_pii := dataset(pii_name, pii_layout, thor);

	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	output(count(ds_baseline(errorcode <> '')),named('base_errors'));
	output(count(ds_new(errorcode <> '')),named('prop_errors'));

ave(clean_ds_baseline, (integer)score);
ave(clean_ds_new, (integer)score);




join_lay := RECORD
	input_layout results;
	pii_layout pii;
END;

ds_join_baseline := JOIN( clean_ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( clean_ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));



cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;



blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));


		
j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
			  AND LEFT.results.score <> RIGHT.results.score
				AND LEFT.results.score = '200',
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
OUTPUT(count(j1), NAMED('from_dead_count'));
OUTPUT(CHOOSEN(j1, 25), named('from_dead'));

j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
			  AND LEFT.results.score <> RIGHT.results.score
				AND RIGHT.results.score =  '200',
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
OUTPUT(count(j2), NAMED('to_dead_count'));
OUTPUT(CHOOSEN(j2, 25), named('to_dead'));


j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
			  AND LEFT.results.score <> RIGHT.results.score
				AND LEFT.results.score = '210',
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
OUTPUT(count(j3), NAMED('From_securety_freeze_count'));
OUTPUT(CHOOSEN(j3, 25), named('From_securety_freeze'));

j4 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
			  AND LEFT.results.score <> RIGHT.results.score
				AND RIGHT.results.score = '210',
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
OUTPUT(count(j4), NAMED('to_securety_freeze_count'));
OUTPUT(CHOOSEN(j4, 25), named('to_securety_freeze'));

j5 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
			  AND LEFT.results.did <> RIGHT.results.did
				and left.results.did <> 0 and right.results.did <> 0,
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
OUTPUT(count(j5), NAMED('linking_change_count'));
OUTPUT(CHOOSEN(j5, 25), named('linking_change'));


j6 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
			  AND LEFT.results.did <> RIGHT.results.did
				and left.results.did = 0,
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
OUTPUT(count(j6), NAMED('Gained_link_count'));
OUTPUT(CHOOSEN(j6, 25), named('Gained_link'));

j7 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
			  AND LEFT.results.did <> RIGHT.results.did
				and right.results.did = 0,
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
OUTPUT(count(j7), NAMED('lost_link_count'));
OUTPUT(CHOOSEN(j7, 25), named('Lost_link'));

scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 0 );
// Scoring_Project_PIP.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'],'score');
