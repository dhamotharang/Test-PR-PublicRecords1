EXPORT Runway_FCRA_Macro( bs_version, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= functionmacro

IMPORT Risk_Indicators, ut, models, Scoring_Project_Macros;

unsigned8 no_of_records := records_ToRun;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;
integer version := bs_version;

String neutralroxieIP := neutralroxie_IP ; 
// String roxieIP := neutralroxie_IP ;

Input_file :=  Input_file_name;
// Input_file := 'nmontpetit::out::bs_41_tracking_full_nonfcra_140513_999999';
String Output_file :=  Output_file_name ;

string archive_date := '999999';


//==================  input file layout  ========================
layout_input := Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;
// layout_input := zz_bbraaten2.Boca_41_Non_Cert_lay_new;



//====================================================
//=============  Main Execution ======================
//====================================================

// ds_in_prep := dataset (Input_file, layout_input, csv(quote('"')));//commenting out as Frank has changed the CSV layouts to thor and the layout_input is throwing errors
ds_in_prep := dataset (Input_file,Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, thor);
// ds_in_prep := dataset (Input_file, zz_bbraaten2.Boca_50_Cert_NonFCRA, thor);
		clean_ds_baseline := ds_in_prep(errorcode='');


ds_in := project(clean_ds_baseline, TRANSFORM(layout_input, self.historydate := (Integer)archive_date, self:= LEFT));

fcra_ds_input := IF (no_of_records = 0, ds_in, CHOOSEN (ds_in, no_of_records));

// output(ds_input,named('ds_input'));

layout_soap_in := record
	integer model_environment;
	boolean excludeReasons;
	dataset(risk_indicators.Layout_Boca_Shell - LnJ_datasets - ConsumerStatements -bk_chapters) shell;
	// dataset( zz_bbraaten2.Boca_50_Cert_NonFCRA) shell;
end;

layout_soap_in create_soap_in(Layout_input le) := transform
	self.shell := project(le, transform(risk_indicators.Layout_Boca_Shell - LnJ_datasets - ConsumerStatements -bk_chapters, self := left));
	// self.shell := project(le, transform( zz_bbraaten2.Boca_50_Cert_NonFCRA, self := left));
	// self.model_environment := 3;  // nonfcra only
	self.model_environment := 2;  // fcra only
	// self.model_environment := 1;  // run all models
	self.excludeReasons := false;
end;

fcra_p_f := distribute(PROJECT (fcra_ds_input, create_soap_in(LEFT)), random());


xlayout := RECORD
  models.Layout_Runway;
	STRING errorcode;
END;

xlayout myFail(layout_soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

fcra_results := SOAPCALL(fcra_p_f,
					neutralroxieIP,
					'Models.Runway_Service',
					{fcra_p_f}, 
					DATASET(xlayout),
					RETRY(retry),
					TIMEOUT(timeout),
					PARALLEL(threads),
					onFail(myFail(LEFT)));

// output(fcra_ds_input,named('fcra_ds_input'));
// output(fcra_p_f, named('fcra_p_f'));
// output(fcra_results, named('fcra_runway_results'));

output(fcra_results, , Output_file, thor, overwrite);

final := fcra_results ;
return final;

EndMacro;