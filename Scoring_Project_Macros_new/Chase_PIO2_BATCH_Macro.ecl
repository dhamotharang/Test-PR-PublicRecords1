EXPORT Chase_PIO2_BATCH_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT Models, Risk_Indicators, RiskWise, UT;
/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * isFCRA: Set to TRUE for the FCRA product, FALSE for non-FCRA.      *
 * fcraRoxie: IP Address of the FCRA roxie.                           *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


//isFCRA := FALSE;


fcraroxie := riskwise.shortcuts.staging_fcra_roxieIP; 


/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
	


f1 := IF(no_of_records <= 0, dataset(ut.foreign_prod + infile_name, layout_input,  CSV(HEADING(single), QUOTE('"'))), 
CHOOSEN(DATASET(ut.foreign_prod+ infile_name, layout_input,  CSV(HEADING(single), QUOTE('"'))), no_of_records));

f := f1;  

// output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));
// output(count(f), NAMED('Number_Of_Records_On_Input'));


//mapping

layout_soap_input := RECORD
  string tribcode := '';	
	DATASET(RiskWise.Layout_PB1O_BatchIn) batch_in;
	unsigned1	DPPAPurpose:= '';
  unsigned1	GLBPurpose:= '';
	STRING DataRestrictionMask := '';
	integer	HistoryDateyyyymm := '';
	string Gateways := '';
	end;
	
sghatti.Layout_PB1O_BatchIn make_batch_in(f le, integer c) := transform
	  // !! replace the tribcode here !!
  SELF.acctno :=(string) le.accountnumber;	
	
	SELF.name_first := le.firstname;
	SELF.name_last := le.lastname;
	SELF.street_addr := le.streetaddress;
	SELF.p_city_name:= le.CITY;
	SELF.st := le.STATE;
	SELF.z5 := le.ZIP;
	SELF.home_phone := le.homephone;
	SELF.ssn := le.ssn;
	SELF.DOB := le.dateofbirth;
	self.historydateyyyymm := le.historydateyyyymm ;
	self := le;
	self := [];
end;

layout_soap_input make_Chase_in(f le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.tribcode := 'pi02';
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;
	SELF.DataRestrictionMask := Risk_Indicators.iid_constants.default_DataRestriction;
	SELF.HistoryDateYYYYMM := le.historydateyyyymm;
END;

soap_in := DISTRIBUTE(project(f,make_Chase_in(LEFT, counter)));
// output(soap_in, named('Sample_soap_in'));



// ip := if(isFCRA, fcraRoxie, roxieIP);

xlayout := RECORD
  Riskwise.Layout_PRIO;
	STRING errorcode;
END;

xlayout myFail(soap_in l) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	// self.account := l.batch_in[1].account;
	SELF := [];
END;

s := SOAPCALL(soap_in, roxieIP,
				'RiskWise.PRIO_Batch_Service', {soap_in}, 
				DATASET(xlayout),
        RETRY(retry), TIMEOUT(timeout),
        PARALLEL(threads), onFail(myFail(LEFT)));



op_final := output(s,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);

fin_out := sequential(op_final);

return fin_out;
endmacro;