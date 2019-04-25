#workunit('name','Chase PI02 Attributes');   //

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout;

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
// b1:='20171208_1';
	
	a1:= a +'_1';
	// a1:= '20171024_1';



basefilename := '~scoringqa::out::nonfcra::pi02_xml_chase_fp3710_0_'+b1;   // Can change xml to batch
testfilename := '~scoringqa::out::nonfcra::pi02_xml_chase_fp3710_0_'+a1;  
pii_name := scoring_project_pip.Input_Sample_Names.PRIO_Scores_Chase_PIO2_infile;  //XML or Batch

ds_baseline := dataset(basefilename,input_layout, thor); 
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, pii_layout, thor); 
	
	
	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	output(count(ds_baseline(errorcode <> '')),named('base_errors'));
	output(count(ds_new(errorcode <> '')),named('prop_errors'));


ave( clean_ds_baseline, (integer)estincome);
ave( clean_ds_new, (integer)estincome);


scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 0);

// slim := record
// string acctno;
// string verfirst;
// string verlast;
// end;

// slim trans( clean_ds_baseline le) := transform
// self.acctno := le.acctno;
// self.verfirst := le.verfirst;
// self.verlast := le.verlast;
// self := [];
// end;

// slim trans2( clean_ds_new le) := transform
// self.acctno := le.acctno;
// self.verfirst := le.verfirst;
// self.verlast := le.verlast;
// self := [];
// end;
// slim_base := project(clean_ds_baseline, trans(left));
// slim_test := project(clean_ds_new, trans2(left));

//**** Join PII to results **************

join_lay := RECORD
	input_layout results;
	pii_layout pii;
END;


ds_join_baseline := JOIN( clean_ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( clean_ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := right));

// output (CHOOSEN(ds_join_baseline, eyeball), NAMED('ds_join_baseline'));
// output (COUNT(ds_join_baseline), NAMED('ds_join_baseline_cnt'));
// output (CHOOSEN(ds_join_second, eyeball), NAMED('ds_join_second'));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));
/*
clean_baseline := join(ds_baseline, ds_new, left.acctno = right.acctno
				  AND LEFT.errorcode + RIGHT.errorcode = '',
					AND LEFT.rv_score_telecom <> RIGHT.rv_score_telecom 
					AND Left.rv_score_telecom < '300',
					TRANSFORM(input_layout, SELF := LEFT));

clean_second := join(ds_baseline, ds_new, left.acctno = right.acctno
				  AND LEFT.errorcode + RIGHT.errorcode = '',
					AND LEFT.rv_score_telecom <> RIGHT.rv_score_telecom 
					AND RIGHT.rv_score_telecom < '300',
					TRANSFORM(input_layout, SELF := RIGHT));
		*/			
j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND (string)LEFT.results.did <> (string)RIGHT.results.did, 
					// and abs( (integer)LEFT.results.estincome - (integer)RIGHT.results.estincome) >50,
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

OUTPUT(count(j1), NAMED('did_Count'));

OUTPUT(CHOOSEN(j1, 25), named('did'));


// a2 := j5((integer)res[1].results.date added	 = 22430);


RiskView3Table := table(j1,
	{
		res[1].PII.date_added	,
		Total := count(group)
	},
	res[1].PII.date_added	
);
output(choosen(RiskView3Table,all), named('dates'));


// j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND (string)LEFT.results.did <> (string)RIGHT.results.did ,
					// AND RIGHT.results.score < '300',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// OUTPUT(count(j2), NAMED('did_Count'));

// OUTPUT(CHOOSEN(j2, 25), named('did'));


// ashirey.Diff(ds_baseline, ds_new, ['accountnumber'], j1, 'LIA4' );

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


// j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.rv_score_telecom <> RIGHT.results.rv_score_telecom 
					// AND Left.results.rv_score_telecom = '200',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.rv_score_telecom <> RIGHT.results.rv_score_telecom 
					// AND RIGHT.results.rv_score_telecom = '200',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// output (CHOOSEN(ds_join_baseline, eyeball));
// output (CHOOSEN(ds_join_second, eyeball));

 // OUTPUT(CHOOSEN(clean_baseline,eyeball));
 // OUTPUT(COUNT(clean_baseline), NAMED('base_count'));
 // OUTPUT(CHOOSEN(clean_second,eyeball));
 // OUTPUT(COUNT(clean_second), NAMED('second_count'));

// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
//OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));

// OUTPUT(CHOOSEN(j2, 25), named('Died'));
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