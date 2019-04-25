#workunit('name','businessShell Test');
// #workunit('name','AddressShell Test');
import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP, zz_bbraaten2;
eyeball := 20;


basefilename := '~scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_20170522_1';
testfilename := '~scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_20170525_1';
// basefilename := '~scoringqa::out::nonfcra::addressshell_batch_generic_attributes_v1_20170407_1';
// testfilename := '~scoringqa::out::nonfcra::addressshell_batch_generic_attributes_v1_20170407_2';




layout := Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout;		

// layout := Scoring_Project_Macros.Global_Output_Layouts.AddressShell_Attributes_V1_BATCH_Generic_Global_Layout;		


ds_baseline := dataset(basefilename, layout , thor);
ds_new := dataset(testfilename, layout , thor);


	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	
	// output(count(clean_ds_baseline(errorcode <> '')),named('base_errors_count'));
	// output(count(clean_ds_new(errorcode <> '')),named('prop_errors_count'));
	
	
	// output(clean_ds_baseline ,named('Base_no_errors'));
	// output(clean_ds_new ,named('prop_no_errors'));

// ashirey.flatten(clean_ds_baseline,clean_ds_1_flat);
// ashirey.flatten(clean_ds_new,clean_ds_2_flat);

output(choosen(clean_ds_baseline,5));
output(choosen(clean_ds_new,5));

// j3 := join(clean_ds_baseline, clean_ds_new, 
				// left.AccountNumber = right.AccountNumber
					// AND left.verification.inputidmatchconfidence <> RIGHT.verification.inputidmatchconfidence,
				// transform({dataset(Layout2) res}, self.res := left + right));

// output(choosen(j3, 10), named('verification__inputidmatchconfidence')); 
// output(count(j3));

// Scoring_Project_PIP.COMPARE_DSETS_MACRO(clean_ds_1_flat, clean_ds_2_flat, ['acctno'], 0);
// Scoring_Project_PIP.CROSSTAB_MACRO(clean_ds_1_flat, clean_ds_2_flat, ['acctno'], 'acc_logs__inquiryperaddr');