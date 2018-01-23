EXPORT RV_Attributes_V2_BATCH_Macro (fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

unsigned8 no_of_records := records_ToRun;
integer eyeball := 50;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String neutralroxieIP := neutralroxie_IP ; 
String fcraroxieIP := fcraroxie_IP ;

Infile_name :=  Input_file_name;

String outfile_name :=  Output_file_name ;

archive_date := (integer) ut.getdate ;
// today         := ut.GetDate[3..];

string DataRestrictionMask  := '10000100010001 '; // to restrict fares, experian, transunion and experian FCRA

//==================  input file layout  ========================
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;


f1 := IF(no_of_records <= 0, dataset( infile_name, layout_input,thor),
                            CHOOSEN(DATASET( infile_name, layout_input, thor), no_of_records));
														
ds_input := distribute(f1, hash64(accountnumber));

// infile_name   := '~nmontpetit::in::rva_prescreen_tracking_pii';

//====================================================
//=============  Service settings ====================
//====================================================


// FCRA service settings
// fcraroxieIP := RiskWise.Shortcuts.prod_batch_fcra; 		// FCRAbatch Roxie







layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion2;
	BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno :=(string) le.accountnumber;
	SELF.Name_First := le.FirstName;
	SELF.Name_Middle := le.MiddleName;
	SELF.Name_Last := le.LastName;
	SELF.street_addr := le.StreetAddress;
	SELF.p_City_name := le.CITY;
	SELF.St := le.STATE;
	SELF.z5 := le.ZIP;
	SELF.Home_Phone := le.HomePhone;
	SELF.SSN := le.SSN;
	SELF.DOB := le.DateOfBirth;
	SELF.Work_Phone := le.WorkPhone;
	self.historydateyyyymm :=  999999;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', neutralroxieIP}], risk_indicators.layout_gateways_in);
	SELF.IsPreScreen := true;		
	self.IncludeVersion2 := true;
	SELF.DataRestrictionMask := DataRestrictionMask;
END;
	
soap_in := PROJECT(ds_input, make_rv_in(LEFT, counter));
op := OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('soap_in'));

roxie_out_layout := RECORD
	models.Layout_RiskView_Batch_Out;
	string200 errorcode;
END;
       
roxie_out_layout myfail(soap_in L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno := l.batch_in[1].acctno;
	self := [];
end;

soap_results := soapcall(soap_in, fcraroxieIP ,
										'models.RiskView_Batch_Service', 
										{soap_in},
                    dataset(roxie_out_layout), 
										RETRY(retry), TIMEOUT(timeout),
										parallel(threads) ,
										onfail(myfail(LEFT)));

// output(choosen(soap_results, eyeball), named('soap_results'));
errors := soap_results(errorcode<>'');
op1 := output(choosen(errors, eyeball), named('batch20_errors'));
op2 := output(count(errors), named('batch20_error_count'));


//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Generic_Attributes_V2_Global_Layout;			 
END;


rv_attributes_v2 := project(soap_results, 
	transform(Global_output_lay, 
		self.accountnumber := left.acctno;
		self.history_date := (string6)archive_date;
		self := left;
		));	
		

op_final := output(rv_attributes_v2 ,,outfile_name,thor,compressed, overwrite);


return op_final;

endmacro;