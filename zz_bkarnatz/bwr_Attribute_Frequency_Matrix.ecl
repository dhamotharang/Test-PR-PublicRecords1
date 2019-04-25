#workunit('name','LIA v4');

import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip, scoring_qa;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout;  // v3 or v4

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
  
basefilename := '~scoringqa::out::nonfcra::leadintegrity_batch_generic_attributes_v4_20160707_1';    // v3 or v4   XML or Batch
testfilename := '~scoringqa::out::nonfcra::leadintegrity_batch_generic_attributes_v4_20160708_1';
pii_name := scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;   
   

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor); 
ds_pii := dataset(pii_name, pii_layout, thor);

ds_baseline_NoErrors := ds_baseline(errorcode = '');
ds_second_NoErrors := ds_new(errorcode = '');
	

new_layout := record
	   string30 AccountNumber;
		 integer base_OnlineDirectory;
		 integer test_OnlineDirectory;
		 end;
		 
new_layout quick_trans(input_layout le, input_layout ri) :=	transform
			self.AccountNumber := le.AccountNumber;
			self.base_OnlineDirectory := (integer)trim(le.OnlineDirectory, left, right);
			self.test_OnlineDirectory := (integer)trim(ri.OnlineDirectory, left, right);
end;	 
		 
		 j20 := join(ds_baseline_NoErrors, ds_second_NoErrors, left.AccountNumber = right.AccountNumber,
										quick_trans(left, right));

f1(dataset (new_layout) le, integer val) := function
	filterset := le(test_OnlineDirectory = val);
	t20 := table(filterset, {base_OnlineDirectory, integer _count := count(group)}, base_OnlineDirectory);
	sorttable := sort(t20, base_OnlineDirectory);

	return sorttable;

end;

	Output(f1(j20, -1), NAMED('OnlineDirectory_Second_Minus1'));
	Output(f1(j20, 0), NAMED('OnlineDirectory_Second_0'));
	Output(f1(j20, 1), NAMED('OnlineDirectory_Second_1'));
	Output(f1(j20, 2), NAMED('OnlineDirectory_Second_2'));
	Output(f1(j20, 3), NAMED('OnlineDirectory_Second_3'));
	Output(f1(j20, 4), NAMED('OnlineDirectory_Second_4'));
	Output(f1(j20, 5), NAMED('OnlineDirectory_Second_5'));
	Output(f1(j20, 6), NAMED('OnlineDirectory_Second_6'));
	Output(f1(j20, 7), NAMED('OnlineDirectory_Second_7'));
	Output(f1(j20, 8), NAMED('OnlineDirectory_Second_8'));
	Output(f1(j20, 9), NAMED('OnlineDirectory_Second_9'));

