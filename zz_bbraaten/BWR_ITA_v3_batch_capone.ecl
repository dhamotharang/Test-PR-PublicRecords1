#workunit('name','CapOne ITA v3 Attributes');
import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP;


eyeball := 20;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout;

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
// b1:='20180328_1';
	
	a1:= a +'_1';
	// a1:= '20180330_1';



// basefilename := '~scoringqa::out::nonfcra::ita_batch_prod_capitalone_attributes_v3_20171127_1';         // Only Batch
basefilename := '~scoringqa::out::nonfcra::ita_batch_capitalone_attributes_v3_'+b1;         // Only Batch
testfilename := '~scoringqa::out::nonfcra::ita_batch_capitalone_attributes_v3_'+a1;  
// testfilename := '~scoringqa::out::nonfcra::ita_batch_prod_capitalone_attributes_v3_20171128_1';  

pii_name := scoring_project_pip.Input_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_infile;

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, prii_layout, thor);


	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
		output(count(ds_baseline(errorcode <> '')),named('base_errors'));
	output(choosen(ds_new(errorcode <> ''),25),named('prop_errors'));




//**** Join PII to results **************
join_lay := RECORD
	input_layout results;
	prii_layout pii;
END;


ds_join_baseline := JOIN( clean_ds_baseline, ds_pii, (Integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( clean_ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));



cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

output(choosen(clean_ds_baseline(sic = '2225'),25));


 j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
					AND LEFT.results.datessndeceased <>RIGHT.results.datessndeceased ,
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
	
OUTPUT(count(j1), NAMED('datessndeceased_count'));
OUTPUT(CHOOSEN(j1, 25), named('datessndeceased'));




scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 0);
// scoring_project_pip.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 'v3__derogcount');

