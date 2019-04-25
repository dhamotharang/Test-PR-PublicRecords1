// #workunit('name','FraudPoint 201 Attributes');

import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V201_AmericanExpress_Global_Layout;

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
// b1:='20180306_1';
	
	a1:= a +'_1';
	// a1:= '20180208_exphone_test3_second';



// basefilename := '~scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_20171109_experian_phone_base';    //XML or Batch
basefilename := '~scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_' +b1;    //XML or Batch
testfilename := '~scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_' + a1;  
// testfilename := '~	scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_20171109_experian_phone_second';  


pii_name := scoring_project_pip.Input_Sample_Names.FP_V2_American_Express_FP1109_0_infile;          //XML or Batch
// pii_name := '~bbraaten::Keep::FP_bocashell_score_sample';          //XML or Batch
// pii_name := scoring_project_pip.Input_Sample_Names.FP_V2_Generic_FP1109_0_infile;          //XML or Batch

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, pii_layout, thor);

clean_ds_baseline := ds_baseline(errorcode='');
clean_ds_new := ds_new(errorcode='');

output(choosen(ds_new, 25));

output(count(ds_baseline(errorcode <> '')),named('base_errors'));
output(count(ds_new(errorcode <> '')),named('prop_errors'));


// RiskView3Table1 := table(ds_baseline,
	// {
		// sourcecreditbureau,
		// Total := count(group)
	// },
	// sourcecreditbureau
// );
// output(RiskView3Table1, named('sourcecreditbureau_base'));


// RiskView3Table2 := table(ds_new,
	// {
		// sourcecreditbureau,
		// Total := count(group)
	// },
	// sourcecreditbureau
// );
// output(RiskView3Table2, named('sourcecreditbureau_test'));


// ashirey.flatten(clean_ds_baseline,clean_ds_1_flat);
// ashirey.flatten(clean_ds_new,clean_ds_2_flat);

Avescorebase := clean_ds_baseline(fp_score >= '300');
Avescorenew := clean_ds_new(fp_score >= '300');

aa := ave(Avescorebase, (integer)fp_score);
output(aa);
ba := ave(Avescorenew, (integer)fp_score);
output(ba);

output(ba-aa);



// **** Join PII to results **************

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
							AND (integer)LEFT.results.idverphone <> (integer)RIGHT.results.idverphone,
						// and abs((integer)left.results.assoccount - (integer)right.results.assoccount) > 45,
								TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));


OUTPUT(count(j1), NAMED('idverphone_count'));
OUTPUT(CHOOSEN(j1, 25), named('idverphone'));




// j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
							// AND abs((integer)LEFT.results.fp_score -(integer)RIGHT.results.fp_score) >100,
							// AND (integer)LEFT.results.did = (integer)RIGHT.results.did,
								// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));


// OUTPUT(count(j2), NAMED('fp_score2'));
// OUTPUT(CHOOSEN(j2, 25), named('idverdriverslicense_count'));


// j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
							// AND (integer)LEFT.results.idverdriverslicensetype <> (integer)RIGHT.results.idverdriverslicensetype,
							// AND (integer)LEFT.results.did = (integer)RIGHT.results.did,
								// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));


// OUTPUT(count(j3), NAMED('idverdriverslicensetype'));
// OUTPUT(CHOOSEN(j3, 25), named('idverdriverslicensetype_count'));

// j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.results.fp_score < RIGHT.results.fp_score,
					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
		
// OUTPUT(count(j1), NAMED('fp_score_count'));
	// OUTPUT(CHOOSEN(j1, 25), named('fp_score'));
	
	// j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
		// AND LEFT.results.fp_score <> RIGHT.results.fp_score,
		// AND LEFT.results.divsearchaddridentitycount <> RIGHT.results.divsearchaddridentitycount,

					// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
		
// OUTPUT(count(j3), NAMED('fp_score_count'));
	// OUTPUT(CHOOSEN(j3, 25), named('fp_score'));

		
		
	
// Avescorebase2 := j3(res[1].results.fp_score >= '300');
// Avescorenew2 := j3(res[1].results.fp_score >= '300');

// aa := ave(Avescorebase2, (integer)res[1].results.fp_score);
// output(aa);
// ba := ave(Avescorenew2, (integer)res[2].results.fp_score);
// output(ba);

// output(ba-aa);

// j3 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
										// AND (integer)left.results.inputaddrbusinesscount <> (integer)right.results.inputaddrbusinesscount, 
// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));

// OUTPUT(count(j3), NAMED('inputaddrbusinesscount'));
// OUTPUT(CHOOSEN(j3, 25), named('inputaddrbusinesscount_count'));


Scoring_Project_PIP.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 0);
// Scoring_Project_PIP.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 'fp_score');
