#workunit('name','LIA v4');

import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP;
eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout;  // v3 or v4

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
	
	a1:= a +'_1';

basefilename := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v4_'+b1;    // v3 or v4   XML or Batch
testfilename := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v4_'+a1;
pii_name := scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;     

ds_baseline := dataset(basefilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40113');
ds_new := dataset(testfilename,input_layout, thor); // : PERSIST('nkoubsky::persist::RVA40114');
ds_pii := dataset(pii_name, pii_layout, thor);

		clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	output(count(ds_baseline(errorcode <> '')),named('base_errors'));
	output(count(ds_new(errorcode <> '')),named('prop_errors'));
	

join_lay := RECORD
	input_layout results;
	pii_layout pii;
END;

ds_join_baseline := JOIN( clean_ds_baseline, ds_pii, (integer)LEFT.AccountNumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := RIGHT));
ds_join_second := JOIN( clean_ds_new, ds_pii, (integer)LEFT.AccountNumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF.results := LEFT; SELF.pii := []));


cmpr := record, maxlength(50000)
	DATASET(join_lay) res;
end;


				
j1 := join(ds_join_baseline, ds_join_second, left.results.AccountNumber = right.results.AccountNumber
					AND LEFT.results.InputAddrTaxYr > right.results.InputAddrTaxYr,
				
				 TRANSFORM(cmpr, SELF.res := LEFT + RIGHT ));

OUTPUT(count(j1), NAMED('InputAddrTaxYr_count'));
OUTPUT(CHOOSEN(j1, 25), named('InputAddrTaxYr'));



scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_baseline, clean_ds_new, ['AccountNumber'], 0);
// scoring_project_pip.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['AccountNumber'], 'inputaddrvacantpropcount');

