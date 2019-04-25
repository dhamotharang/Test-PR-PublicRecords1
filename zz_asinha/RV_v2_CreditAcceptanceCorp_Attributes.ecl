#workunit('name','RV V2 Credit Acceptance Corp Attributes');
import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;

eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_CreditAcceptancecorp_Attributes_V2_Global_Layout;

prii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


basefilename := '~scoringqa::out::fcra::riskview_xml_creditacceptancecorp_attributes_v2_20160201_crim_exp_phase3_fcra_baseline';        
testfilename := '~scoringqa::out::fcra::riskview_xml_creditacceptancecorp_attributes_v2_20160201_crim_exp_phase3_fcra_second';       
pii_name := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CreditAcceptance_infile;


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


ds_join_baseline := JOIN( ds_baseline, ds_pii, (Integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));



cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;

blank := DATASET(1, TRANSFORM(join_lay, SELF.results.accountnumber := '-', SELF := []));


 j1 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
   					AND (integer)LEFT.results.felonies <> (integer)RIGHT.results.felonies,
   				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
						
  j2 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
   					AND (integer)LEFT.results.felonies30 <> (integer)RIGHT.results.felonies30,
   				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));  
						
	 j3 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
   					AND (integer)LEFT.results.total_number_derogs <> (integer)RIGHT.results.total_number_derogs,
   				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));  
						
						
	 j4 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
   					AND (integer)LEFT.results.date_last_conviction <> (integer)RIGHT.results.date_last_conviction,
   				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank)); 
						
    j5 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
   					AND (integer)LEFT.results.date_last_derog <> (integer)RIGHT.results.date_last_derog,
   				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
   				  
   					
    // j3 := join(ds_join_baseline, ds_join_second, left.results.accountnumber = right.results.accountnumber
   					// AND (integer)LEFT.results.bankruptcy_count <> (integer)RIGHT.results.bankruptcy_count,
   				   // TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
   				
   					
   OUTPUT(count(j1), NAMED('change_felonies_count'));
   OUTPUT(count(j2), NAMED('change_felonies30_count'));
   OUTPUT(count(j3), NAMED('change_total_number_derogs_count'));
   OUTPUT(count(j4), NAMED('date_last_conviction_count'));
   OUTPUT(count(j5), NAMED('date_last_derog_count'));
	 
   OUTPUT(CHOOSEN(j1, 25), named('change_felonies'));
   OUTPUT(CHOOSEN(j2, 25), named('felonies30'));
   OUTPUT(CHOOSEN(j3, 25), named('total_number_derogs'));
   OUTPUT(CHOOSEN(j4, 25), named('date_last_conviction'));
   OUTPUT(CHOOSEN(j5, 25), named('date_last_derog'));
   
ashirey.flatten(ds_baseline, flatten_baseline);
ashirey.flatten(ds_new, flatten_second);
scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['accountnumber'], 0);
// scoring_project_pip.CROSSTAB_MACRO( flatten_baseline, flatten_second, ['accountnumber'], 'felonies');
// scoring_project_pip.CROSSTAB_MACRO( flatten_baseline, flatten_second, ['accountnumber'], 'date_last_conviction');
scoring_project_pip.CROSSTAB_MACRO( flatten_baseline, flatten_second, ['accountnumber'], 'felonies');


