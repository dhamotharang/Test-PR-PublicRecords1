EXPORT Runway_Cert_NonFCRA_Macro( bs_version, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= functionmacro

IMPORT Risk_Indicators, ut, models, Scoring_Project;

unsigned8 no_of_records := records_ToRun;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;
integer version := bs_version;

String neutralroxieIP := neutralroxie_IP ; 
// String roxieIP := nonfcraroxie_IP ;

Input_file :=  Input_file_name;
// Input_file := 'nmontpetit::out::bs_41_tracking_full_nonfcra_140513_999999';
String Output_file :=  Output_file_name ;

string archive_date := '999999';


//==================  input file layout  ========================
layout_input := RECORD
	unsigned8 time_ms := 0;
	STRING30 AccountNumber;
	risk_indicators.Layout_Boca_Shell;
	STRING200 errorcode;
END;


//====================================================
//=============  Main Execution ======================
//====================================================

// ds_in_prep := dataset (Input_file, layout_input, csv(quote('"')));//commenting out as Frank has changed the CSV layouts to thor and the layout_input is throwing errors
ds_in_prep := dataset (Input_file, test_apaar.BS_41_Cert_Layout, thor);

ds_in := project(ds_in_prep, TRANSFORM(layout_input, self.historydate := (Integer)archive_date, self:= LEFT));
nonfcra_ds_input := IF (no_of_records = 0, ds_in, CHOOSEN (ds_in, no_of_records));

// output(ds_input,named('ds_input'));

layout_soap_in := record
	integer model_environment;
	boolean excludeReasons;
	dataset(risk_indicators.Layout_Boca_Shell) shell;
end;

layout_soap_in create_soap_in(Layout_input le) := transform
	self.shell := project(le, transform(risk_indicators.Layout_Boca_Shell, self := left));
	self.model_environment := 3;  // nonfcra only
	// self.model_environment := 2;  // fcra only
	// self.model_environment := 1;  // run all models
	self.excludeReasons := false;
end;

nonfcra_p_f := distribute(PROJECT (nonfcra_ds_input, create_soap_in(LEFT)), random());


xlayout := RECORD
  models.Layout_Runway;
	STRING errorcode;
END;

xlayout myFail(layout_soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

nonfcra_results := SOAPCALL(nonfcra_p_f,
					neutralroxieIP,
					'Models.Runway_Service',
					{nonfcra_p_f}, 
					DATASET(xlayout),
					RETRY(retry),
					TIMEOUT(timeout),
					PARALLEL(threads),
					onFail(myFail(LEFT)));

// output(nonfcra_ds_input,named('nonfcra_ds_input'));
// output(nonfcra_p_f, named('nonfcra_p_f'));
// output(nonfcra_results, named('nonfcra_runway_results'));

output(nonfcra_results, , Output_file, thor, overwrite);

final := nonfcra_results;
return final;

EndMacro;