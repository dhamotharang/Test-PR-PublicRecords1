#workunit('name','Experian RV v3 Attributes');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip;
eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout;

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


basefilename := '~scoringqa::out::fcra::riskview_xml_experian_attributes_v3_'+b1;        // Can change xml to Batch
testfilename := '~scoringqa::out::fcra::riskview_xml_experian_attributes_v3_'+a1;    
pii_name := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_XML_Experian_infile;        //XML or Batch


ds_baseline := dataset(basefilename,input_layout, thor); 
ds_new := dataset(testfilename,input_layout, thor); 
ds_pii := dataset(pii_name, prii_layout, thor); 


	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	output(count(ds_baseline(errorcode <> '')),named('base_errors'));
	output(count(ds_new(errorcode <> '')),named('prop_errors'));


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
					AND LEFT.results.lientaxotherreleasedcount <> RIGHT.results.lientaxotherreleasedcount,
				  TRANSFORM(cmpr, SELF.res := LEFT + RIGHT + blank));
	

OUTPUT(count(j1), NAMED('lientaxotherreleasedcount_count'));
OUTPUT(CHOOSEN(j1, 25), named('lientaxotherreleasedcount'));
					

					



		
		scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['AccountNumber'], 0 );
// Scoring_Project_PIP.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['AccountNumber'],'highissuedate');
