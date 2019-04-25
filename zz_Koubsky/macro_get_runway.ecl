EXPORT macro_get_runway( bs_version, nonfcraroxie_IP, neutralroxie_IP, Thread, Timeouts, Retrys, Input_dataset, Output_file_name, records_ToRun):= functionmacro

IMPORT Risk_Indicators, ut, models;

unsigned8 no_of_records := (unsigned8) records_ToRun;
integer retry := (integer)retrys;
integer timeout := (integer)timeouts;
integer threads := (integer)Thread;
integer version := (integer)bs_version;

String neutralroxieIP := (String)neutralroxie_IP ; 
String roxieIP := (String)nonfcraroxie_IP ;

// Input_file :=  Input_file_name;
// Input_file := 'nmontpetit::out::bs_41_tracking_full_nonfcra_140513_999999';
String Output_file := (String)Output_file_name ;

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

// ds_in_prep := dataset (Input_file, layout_input, csv(quote('"')));
ds_in_prep := Input_dataset;
ds_in := project(ds_in_prep, TRANSFORM(layout_input, self.historydate := (Integer)archive_date; self:= LEFT));
ds_input := IF (no_of_records = 0, ds_in, CHOOSEN (ds_in, no_of_records));

// output(ds_input,named('ds_input'));

layout_soap_in := record
	integer model_environment;
	boolean excludeReasons;
	dataset(risk_indicators.Layout_Boca_Shell) shell;
end;

layout_soap_in create_soap_in(Layout_input le) := transform
	self.shell := project(le, transform(risk_indicators.Layout_Boca_Shell, self := left));
	// self.model_environment := 3;  // nonfcra only
	// self.model_environment := 2;  // fcra only
	self.model_environment := 1;  // run all models
	self.excludeReasons := false;
end;

p_f := PROJECT (ds_input, create_soap_in(LEFT));


xlayout := RECORD
  models.Layout_Runway;
	STRING errorcode;
END;

xlayout myFail(layout_soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

results := SOAPCALL(p_f,
					roxieIP,
					'Models.Runway_Service',
					{p_f}, 
					DATASET(xlayout),
					RETRY(retry),
					TIMEOUT(timeout),
					PARALLEL(threads),
					onFail(myFail(LEFT)));

// output(ds_input,named('ds_input'));
// output(p_f, named('p_f'));
// output(results, named('soap_results'));

// R1 := output(results, , Output_file, csv(heading(single), quote('"')), overwrite);
// return R1;
return results;

EndMacro;