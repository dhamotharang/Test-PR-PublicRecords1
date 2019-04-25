#workunit('name','Chase CBBL');   //this is XML only and covers Attributes and FPScore/FDScore in KS

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_Chase_CBBL_Global_Layout;

pii_layout := RECORD
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.bus_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
   	a:= ut.GetDate;
	
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);
	
b1:=b +'_1'; 
// b1:='20180403_1';
	
	a1:= a +'_test';
	// a1:= '20180404_1';


basefilename := '~scoringqa::out::nonfcra::cbbl_xml_chase_'+b1;
testfilename := '~scoringqa::out::nonfcra::cbbl_xml_chase_'+a1;
pii_name := scoring_project_pip.Input_Sample_Names.CBBL_Scores_XML_Chase_infile;


ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, pii_layout, thor);



	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	// output(count(ds_baseline(errorcode <> '')),named('base_errors'));
	// output(count(ds_new(errorcode <> '')),named('prop_errors'));



ave( clean_ds_baseline, (integer)ecovariables);
ave( clean_ds_new, (integer)ecovariables);

// scoring_project_pip.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 'cmpyaddrscore');


// ds_baseline := ds_baseline1(acctno IN ['10175', '10190', '10195', '10540']);
// ds_new := ds_new1(acctno IN ['10175', '10190', '10195', '10540']);

// OUTPUT(COUNT(ds_baseline (rv_score_telecom = '222')), NAMED('ds_baseline'));
// OUTPUT(COUNT(ds_new (rv_score_telecom = '222')), NAMED('ds_new'));
// OUTPUT(CHOOSEN(ds_new, eyeball), NAMED('ds_new'));
// OUTPUT(CHOOSEN(ds_pii, eyeball), NAMED('ds_pii'));

//**** Join PII to results **************
slim := record
string acctno;
string zipname;
string ecovariables;
string a;
string b;
string c;
string d;
string e;
string f;
string g;
string h;
string i;
string j;
string k;
string l;
string m;
end;

slim trans(recordof(ds_baseline) le) := transform
self.acctno := le.acctno;
self.zipname := le.zipname;
self.ecovariables := le.ecovariables;
self.a := le.zipname[1..2];
self.b := le.zipname[3..4];
self.c := le.zipname[5..6];
self.d := le.zipname[7..8];
self.e := le.zipname[9..10];
self.f := le.zipname[11..12];
self.g := le.zipname[13..14];
self.h := le.zipname[15..16];
self.i := le.zipname[17..18];
self.j := le.zipname[19..20];
self.k := le.zipname[21..22];
self.l := le.zipname[23..24];
self.m := le.zipname[25..26];
end;

slimbase := project(ds_baseline, trans(left));
output(choosen(slimbase, 10));

slimsecond := project(ds_new, trans(left));
scoring_project_pip.COMPARE_DSETS_MACRO(slimbase, slimsecond, ['acctno'], 0);

join_lay := RECORD
	slim results;
pii_layout pii;
END;

join_lay_full := RECORD
	input_layout results;
pii_layout pii;
END;

ds_join_baseline := JOIN( slimbase, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( slimsecond, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := right));

ds_join_baseline_full := JOIN( clean_ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay_full, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second_full := JOIN( clean_ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay_full, SELF.results := LEFT; SELF.pii := right));



// output (CHOOSEN(ds_join_baseline, eyeball), NAMED('ds_join_baseline'));
// output (COUNT(ds_join_baseline), NAMED('ds_join_baseline_cnt'));
// output (CHOOSEN(ds_join_second, eyeball), NAMED('ds_join_second'));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

cmpr_full := record, maxlength(50000)
	DATASET(join_lay_full) res;
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
// j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND (integer)LEFT.results.cmpyscore > (Integer)RIGHT.results.cmpyscore,
					// AND (integer)LEFT.results.cmpyscore = '300',
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

j2 := join(ds_join_baseline_full, ds_join_second_full, left.results.acctno = right.results.acctno
					AND (integer)LEFT.results.ecovariables < (integer)RIGHT.results.ecovariables
										AND abs((integer)LEFT.results.ecovariables - (integer)RIGHT.results.ecovariables) > 5,

					TRANSFORM(cmpr_full, SELF.res := LEFT + RIGHT));

OUTPUT(CHOOSEN(j2, all), named('ecovariables_full'));
OUTPUT(count(j2), NAMED('ecovariables_count_full'));

b66 := j2((integer)res[1].results.acctno = 1017);
b67 := j2((integer)res[1].results.acctno = 102);
b68 := j2((integer)res[1].results.acctno = 1028);
output(b66+b67+b68);


j5 := join(ds_join_baseline_full, ds_join_second_full, left.results.acctno = right.results.acctno
					AND (integer)LEFT.results.ecovariables < (integer)RIGHT.results.ecovariables
										AND abs((integer)LEFT.results.ecovariables - (integer)RIGHT.results.ecovariables)> 5,

					TRANSFORM(cmpr_full, SELF.res := LEFT + RIGHT));

OUTPUT(CHOOSEN(j5, all), named('ecovariables_clena'));
OUTPUT(count(j5), NAMED('ecovariables_count_clean'));


j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno,
					// AND (integer)LEFT.results.ecovariables < (integer)RIGHT.results.ecovariables
					// and left.results.zipname <> right.results.zipname,
					// AND LEFT.results.did > 0
					// AND RIGHT.results.did > 0, 
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT ));
					
// a66 := j3((integer)res[1].results.acctno = 1009);
// a67 := j3((integer)res[1].results.acctno = 1157);
// a68 := j3((integer)res[1].results.acctno = 1586);
// output(a66+a67+a68);


OUTPUT(CHOOSEN(j3, all), named('ecovariables'));
OUTPUT(count(j3), NAMED('ecovariables_count'));
