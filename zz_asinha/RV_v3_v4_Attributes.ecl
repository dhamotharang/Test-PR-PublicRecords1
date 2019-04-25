#workunit('name','RV v3 Attributes');
// #workunit('name','RV v4 Attributes');


import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 30;

// input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_Attributes_V3_Global_Layout;         //V3
input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_xml_Generic_Attributes_V4_Global_Layout;      //V4  XML or Batch

prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_xml_generic_attributes_v4_20160201_crim_exp_phase3_fcra_baseline';        // v3 or v4   XML or Batch
testfilename := '~scoringqa::out::fcra::riskview_xml_generic_attributes_v4_20160201_crim_exp_phase3_fcra_second';        
pii_name := scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;        //V3 or V4    XML or Batch


ds_baseline := dataset(basefilename,input_layout, thor); 
ds_new := dataset(testfilename,input_layout, thor); 
ds_pii := dataset(pii_name, prii_layout, thor);

ds_baseline_noerrors := ds_baseline(errorcode = '');
ds_new_noerrors := ds_new(errorcode = '');


output(count(ds_baseline_noerrors));
output(count(ds_new_noerrors));


join_lay := RECORD
	input_layout results;
	prii_layout pii;
END;

//sghatti.RVScores

ds_join_baseline := JOIN( ds_baseline, ds_pii, (integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));

// OUTPUT(ds_join_baseline(results.acctno = '110826U148949'), NAMED('join_results'));


cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.accountnumber := '-', SELF := []));


 j1 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
					AND LEFT.results.recentactivityindex <> RIGHT.results.recentactivityindex,
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					
 
   
   	 // j2 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
   					// AND LEFT.results.felonies <> RIGHT.results.felonies,
   				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));		

   					
    // j3 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
   					// AND LEFT.results.predictedannualincome <> RIGHT.results.predictedannualincome,
   				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));			
    
    // j4 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
   					// AND LEFT.results.total_number_derogs <> RIGHT.results.total_number_derogs,                          
   				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));					

    // j5 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
   					// AND LEFT.results.felonyage <> RIGHT.results.felonyage,
   				  // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
					
OUTPUT(count(j1), NAMED('recentactivityindex_count'));
OUTPUT(CHOOSEN(j1, 25), named('recentactivityindex'));


// OUTPUT(count(j2), NAMED('felonies_count'));
// OUTPUT(CHOOSEN(j2, 25), named('felonies'));


// OUTPUT(count(j3), NAMED('predictedannualincome_count'));
// OUTPUT(CHOOSEN(j3, 25), named('predictedannualincome'));

// OUTPUT(count(j4), NAMED('total_number_derogs_count'));
// OUTPUT(CHOOSEN(j4, 25), named('total_number_derogs'));

// OUTPUT(count(j5), NAMED('change_felonyage_count'));
// OUTPUT(CHOOSEN(j5, 25), named('felonyage'));

ashirey.flatten(ds_baseline, flatten_baseline);
ashirey.flatten(ds_new, flatten_second);
scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['accountnumber'], 0);
scoring_project_pip.CROSSTAB_MACRO( flatten_baseline, flatten_second, ['accountnumber'], 'recentactivityindex');