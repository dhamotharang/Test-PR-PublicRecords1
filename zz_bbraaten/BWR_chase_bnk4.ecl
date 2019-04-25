#workunit('name','chase bnk4 Attributes');
import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP;


eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_Chase_BNK4_Global_Layout;

prii_layout := RECORD
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
// b1:='20171208_1';
	
	a1:= a +'_1';
	// a1:= '20170904_1';


// basefilename := '~scoringqa::out::nonfcra::ita_batch_capitalone_attributes_v3_20151215_1';        // Only Batch
// testfilename := '~scoringqa::out::nonfcra::ita_batch_capitalone_attributes_v3_20151216_1';        //

basefilename := '~scoringqa::out::nonfcra::bnk4_xml_chase_bd3605_0_'+b1;        // Only Batch
testfilename := '~scoringqa::out::nonfcra::bnk4_xml_chase_bd3605_0_'+a1;

pii_name := scoring_project_pip.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, prii_layout, thor);


	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	
//**** Join PII to results **************
join_lay := RECORD
	input_layout results;
	prii_layout pii;
END;


ds_join_baseline := JOIN( clean_ds_baseline, ds_pii, (Integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( clean_ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

// OUTPUT(ds_join_baseline(results.acctno = '110826U148949'), NAMED('join_results'));

	// clean_ds_baseline := ds_baseline(errorcode='');
	// clean_ds_new := ds_new(errorcode='');
	
	// output(count(ds_baseline(errorcode <> '')),named('base_errors'));
	// output(count(ds_new(errorcode <> '')),named('prop_errors'));

cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

// clean_baseline := join(ds_baseline, ds_new, left.acctno = right.acctno
					// AND LEFT.errorcode + RIGHT.errorcode = '',
					// AND LEFT.rv_score_prescreen <> RIGHT.rv_score_prescreen
					// AND LEFT.rv_score_auto = '27'
					// AND LEFT.rv_score_prescreen < '300',
					// TRANSFORM(input_layout, SELF := LEFT));

// clean_second := join(ds_baseline, ds_new, left.acctno = right.acctno
					// AND LEFT.errorcode + RIGHT.errorcode = '',
					// AND LEFT.rv_score_prescreen <> RIGHT.rv_score_prescreen
					// AND right.rv_score_prescreen < '300',
					// TRANSFORM(input_layout, SELF := RIGHT));
					
j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND (integer)LEFT.results.ecovariables < (integer)RIGHT.results.ecovariables,
										// AND LEFT.results.v3__nonderogcount01 < '10',
					// AND LEFT <> RIGHT,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT ));

// ashirey.Diff(ds_baseline, ds_new, ['accountnumber'], j1, 'LIA4' );

 // j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND LEFT.v4_prescreenoptout <> RIGHT.v4_prescreenoptout
					// AND LEFT.v4_prescreenoptout = '0',
					// AND (integer)LEFT.results.v3__prsearchcollectioncount < (integer)RIGHT.results.v3__prsearchcollectioncount,
					// AND Left.results.inputaddridentitiesrecentcount = '',
					// AND LEFT.results.rv_score_prescreen < '300',
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));

 // j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					// AND (integer)LEFT.results.v3__nonderogcount01 > (integer)RIGHT.results.v3__nonderogcount01,
					// AND LEFT.results.v3__nonderogcount01 > '255',
					// AND LEFT.v4_prescreenoptout = '0',
					// AND (integer)LEFT.results.v3__prsearchcollectioncount > (integer)RIGHT.results.v3__prsearchcollectioncount,
					// AND Left.results.inputaddridentitiescount = '',
					// AND LEFT.results.rv_score_prescreen < '300',
				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));
					
 // j3 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
					 // AND LEFT.results.firstname = RIGHT.results.firstname
					 // AND LEFT.results.firstname = '',
					// AND LEFT.results.numsources <> '2'
					// AND RIGHT.results.numsources = '2',
					// AND LEFT.results.rv_score_prescreen < '300',
				   // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
				  // TRANSFORM(cmpr, SELF.res := LEFT ));					
					
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
			
 // OUTPUT(CHOOSEN(clean_baseline,eyeball));
 // OUTPUT(COUNT(clean_baseline), NAMED('base_count'));
 // OUTPUT(CHOOSEN(clean_second,eyeball));
 // OUTPUT(COUNT(clean_second), NAMED('second_count'));

// OUTPUT(COUNT(clean_baseline(v4_prescreenoptout = '1')), NAMED('base_optout_count'));
// OUTPUT(COUNT(clean_second(v4_prescreenoptout = '1')), NAMED('second_optout_count'));
OUTPUT(count(j1), NAMED('phonecount_count'));
//OUTPUT((REAL) ((count(j1) / COUNT(clean_second))*100), NAMED('difference_percent'));
// OUTPUT(count(j2), NAMED('Decrease_v3__nonderogcount01_count'));
// OUTPUT(count(j3), NAMED('decrease_numsourcesTo2_count'));
OUTPUT(CHOOSEN(j1, 25), named('phonecount'));
// OUTPUT(CHOOSEN(j2, 25), named('Decrease_v3__nonderogcount01'));

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


scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 0);
// scoring_project_pip.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 'tciaddr');


// ave(clean_ds_baseline, (integer)v3__nonderogcount01);
// ave(clean_ds_new, (integer)v3__nonderogcount01);


// trans_lay2 := record

  // string30 acctno;
	 // string12 l_v3__nonderogcount01;
  // string12 r_v3__nonderogcount01;
  // integer3 score_diffv3__nonderogcount01;
 	// unsigned6 did;
	
// end;

// trans_lay2 j_trans2(clean_ds_baseline le, clean_ds_new ri) := transform
	// self.acctno  := le.acctno;
	// self.r_v3__nonderogcount01  := ri.v3__nonderogcount01	;
	// self.l_v3__nonderogcount01  := le.v3__nonderogcount01	;
	

	
	// self.score_diffv3__nonderogcount01  := (integer)ri.v3__nonderogcount01	 - (integer)le.v3__nonderogcount01	;
	
	// self.did := le.did;
	
	
// end;		
		
		// ds_join5 := join(clean_ds_baseline, clean_ds_new, 
			// left.acctno = right.acctno 
			// and (integer)left.v3__nonderogcount01	 <> (integer)right.v3__nonderogcount01	,

			// j_trans2(left, right));
			
			
			
				// ds_join4 := join(clean_ds_baseline, clean_ds_new, 
			// left.acctno = right.acctno 
			// and (integer)left.v3__nonderogcount01	 > (integer)right.v3__nonderogcount01	,

			// j_trans2(left, right));
			
				// ds_join3 := join(clean_ds_baseline, clean_ds_new, 
			// left.acctno = right.acctno 
			// and (integer)left.v3__nonderogcount01	 < (integer)right.v3__nonderogcount01,	

			// j_trans2(left, right));
			
		// output(ds_join3);
		// count(ds_join3);
		// ave(ds_join3, score_diffv3__nonderogcount01);
		// average increase;
		// output(ds_join4);
		// count(ds_join4);
		// ave(ds_join4, score_diffv3__nonderogcount01);
		// average decrease;
		// output(ds_join5);
		// count(ds_join5);
		// ave(ds_join5, score_diffv3__nonderogcount01);
		// count(ds_join5( score_diffv3__nonderogcount01 = 1));
		// count(ds_join5( score_diffv3__nonderogcount01 = 2));
		// count(ds_join5( score_diffv3__nonderogcount01 = 3));
		// count(ds_join5( score_diffv3__nonderogcount01 = 4));
		// max(ds_join5, score_diffv3__nonderogcount01);
		// min(ds_join5, score_diffv3__nonderogcount01);
		
		
		
		
		// count(ds_join3( score_diffv3__bankruptcycount06 <> score_diffprsearchcollectioncount));
	// output(ds_join3( score_diffv3__bankruptcycount06 <> score_diffprsearchcollectioncount));
//********outputs the difference in scores along with baseline and test file scores******************;		
		
		// output((ds_join5((string)score_diff <> '0' and (string)r_score <> '')), named('Change_in_scores'));