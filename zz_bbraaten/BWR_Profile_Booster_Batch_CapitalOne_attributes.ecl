#workunit('name','Profile Booster Capone');

import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP;
eyeball := 25;

input_layout := Scoring_Project_Macros.Global_Output_Layouts.ProfileBooster_layout;  // v3 or v4

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
  

basefilename := '~ScoringQA::out::NONFCRA::Profile_Booster_Batch_CapitalOne_attributes_v1_20180320_1';    // v3 or v4   XML or Batch
testfilename := '~ScoringQA::out::NONFCRA::Profile_Booster_Batch_CapitalOne_attributes_v1_20180323_1';
pii_name := scoring_project_pip.Input_Sample_Names.Profile_booster_Capone_infile;     

ds_baseline := dataset(basefilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40113');
ds_new := dataset(testfilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40114');
ds_pii := dataset(pii_name, pii_layout, thor);

	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');

// end;

join_lay := RECORD
	input_layout results;
	// slim results;
	pii_layout pii;
END;

ds_join_baseline := JOIN( clean_ds_baseline, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( clean_ds_new, ds_pii, (integer)LEFT.acctno = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));



cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

// blank := DATASET(1, TRANSFORM(join_lay, SELF.results.acctno := '-', SELF := []));

				
j1 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
			  AND (integer)LEFT.results.v1_rescurravmvalue	 > (integer)RIGHT.results.v1_rescurravmvalue	,
				TRANSFORM(cmpr, SELF.res := LEFT + RIGHT ));


OUTPUT(count(j1), NAMED('v1_rescurravmvalue_count'));
OUTPUT(CHOOSEN(j1, eyeball), named('v1_rescurravmvalue'));

// j2 := join(ds_join_baseline, ds_join_second, left.results.acctno = right.results.acctno
			  // AND LEFT.results.v1_ResInputAVMValue > RIGHT.results.v1_ResInputAVMValue,
				
				// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));


// OUTPUT(count(j2), NAMED('v1_ResInputAVMValue_2c'));
// OUTPUT(CHOOSEN(j2, eyeball), named('v1_ResInputAVMValu2e'));



scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 0);
// scoring_project_pip.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 'v1_PropEverSoldCnt');