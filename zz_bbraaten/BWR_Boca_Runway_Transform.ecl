// EXPORT BWR_Boca_Runway_Transform := 'todo';

// import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP, zz_bbraaten2, Scoring_Project_Macros;
eyeball := 20;

// basefilename := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20170321_1';          
// testfilename := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20170321_1'; 

// basefilename := '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'scoringqa::out::fcra::bocashell_41_historydate_999999_prod_20170815_1';          
// testfilename := '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'scoringqa::out::fcra::bocashell_41_historydate_999999_prod_20170816_1'; 

basefilename := '~scoringqa::out::nonfcra::bocashell_50_historydate_999999_cert_20180626_1';          
testfilename := '~scoringqa::out::nonfcra::bocashell_50_historydate_999999_cert_20180627_1'; 




Layout2 := Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;  //FCRA


ds_baseline := dataset(basefilename, Layout2 , thor);
ds_new := dataset(testfilename, Layout2 , thor);


Output_file1 := '~bbraaten::50acc_logs_test3';  //output file names - change
Output_file2 := '~bbraaten::50acc_logs_second3' ;//output file names - change



// integer type_ := 2; //fcra
integer type_ := 3; //non

layout2 trans(ds_baseline le, ds_new ri) := transform
 self.acc_logs := ri.acc_logs;
 self.fdattributesv2 := ri.fdattributesv2;//ri change only for new

	 self := le; //else is old
		end;
	
// test_new := project(ds_new, trans(left, right));
// test_new := project(ds_baseline, trans(left, right));

		test_new := join(ds_baseline, ds_new, 
			left.AccountNumber = right.AccountNumber ,
			trans(left, right));		

output(choosen(ds_baseline, 5));
output(choosen(test_new, 5));
ashirey.flatten(ds_baseline,clean_ds_1_flat);
ashirey.flatten(test_new,clean_ds_2_flat);

scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_1_flat, clean_ds_2_flat, ['seq'], -1);


IMPORT Risk_Indicators, ut, models, Scoring_Project, zz_bbraaten2;

unsigned8 no_of_records := 0;
integer retry := 3;
integer timeout := 25;
integer threads := 1;

String neutralroxieIP := RiskWise.shortcuts.staging_neutral_roxieIP ; 
// String neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral ; 
// String roxieIP := nonfcraroxie_IP ;

Input_file1 :=  ds_baseline;
Input_file2 :=  test_new;


string archive_date := '999999';


//==================  input file layout  ========================
layout_input := RECORD
	unsigned8 time_ms := 0;
	STRING30 AccountNumber;
	risk_indicators.Layout_Boca_Shell -LnJ_datasets;
	STRING200 errorcode;
END;


//====================================================
//=============  Main Execution ======================
//====================================================

// ds_in_prep := dataset (Input_file, layout_input, csv(quote('"')));//commenting out as Frank has changed the CSV layouts to thor and the layout_input is throwing errors
// ds_in_base := dataset (Input_file1, Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout		 , thor);
// ds_in_prop := dataset (Input_file2, Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout		 , thor);

ds_in_base := project(Input_file1, TRANSFORM(Layout2, self.historydate := (Integer)archive_date, self:= LEFT));
ds_in_prop := project(Input_file2, TRANSFORM(Layout2, self.historydate := (Integer)archive_date, self:= LEFT));
nonfcra_ds_input_base := IF (no_of_records = 0, ds_in_base, CHOOSEN (ds_in_base, no_of_records));
nonfcra_ds_input_prop := IF (no_of_records = 0, ds_in_prop, CHOOSEN (ds_in_prop, no_of_records));

// output(ds_input,named('ds_input'));

layout_soap_in := record
	integer model_environment;
	boolean excludeReasons;
	dataset(Layout2) shell;
end;

layout_soap_in create_soap_in(Layout2 le) := transform
	self.shell := project(le, transform(Layout2, self := left));
	// self.model_environment := 3;  // nonfcra only
	self.model_environment := type_;  // fcra only
	// self.model_environment := 1;  // run all models
	self.excludeReasons := false;
end;

nonfcra_base := distribute(PROJECT (nonfcra_ds_input_base, create_soap_in(LEFT)), random());
nonfcra_prop:= distribute(PROJECT (nonfcra_ds_input_prop, create_soap_in(LEFT)), random());


xlayout := RECORD
  models.Layout_Runway;
	STRING errorcode;
END;

xlayout myFail(layout_soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

nonfcra_results_base := SOAPCALL(nonfcra_base,
					neutralroxieIP,
					'Models.Runway_Service',
					{nonfcra_base}, 
					DATASET(xlayout),
					RETRY(retry),
					TIMEOUT(timeout),
					PARALLEL(threads),
					onFail(myFail(LEFT)));
					
nonfcra_results_prop := SOAPCALL(nonfcra_prop,
					neutralroxieIP,
					'Models.Runway_Service',
					{nonfcra_prop}, 
					DATASET(xlayout),
					RETRY(retry),
					TIMEOUT(timeout),
					PARALLEL(threads),
					onFail(myFail(LEFT)));

// output(nonfcra_ds_input,named('nonfcra_ds_input'));
// output(nonfcra_p_f, named('nonfcra_p_f'));
// output(nonfcra_results, named('nonfcra_runway_results'));

output(nonfcra_results_base, , Output_file1, thor, overwrite);
output(nonfcra_results_prop, , Output_file2, thor, overwrite);
