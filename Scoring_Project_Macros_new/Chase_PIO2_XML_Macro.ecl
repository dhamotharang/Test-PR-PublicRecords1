EXPORT Chase_PIO2_XML_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT Models, Risk_Indicators, RiskWise, Scoring, UT;
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

isFCRA := FALSE;

fcraRoxie  := riskwise.shortcuts.staging_fcra_roxieIP; 




/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
	


f := IF(no_of_records <= 0, dataset(ut.foreign_prod + infile_name, layout_input, CSV(HEADING(single), QUOTE('"'))), CHOOSEN(DATASET(ut.foreign_prod + infile_name, layout_input, CSV(HEADING(single), QUOTE('"'))), no_of_records));

// output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));
// output(count(f), NAMED('Number_Of_Records_On_Input'));


//mapping
sghatti.Layout_PRIO_Soapcall into_PRIO_input(f le) := transform
 	self.acctno := (string)le.accountnumber;
	self.account := (string)le.accountnumber;
	self.tribcode := 'pi02';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM :='200607';
//	self.run_Seed:=false ;

	
	SELF.first := le.firstname;
	SELF.last := le.lastname;
	SELF.addr := le.streetaddress;
	SELF.city:= le.CITY;
	SELF.state := le.STATE;
	SELF.zip := le.ZIP;
	SELF.hphone := le.homephone;
	SELF.socs := le.ssn;
	SELF.dob := le.dateofbirth;
	self.HistoryDateYYYYMM := le.historydateyyyymm ;
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self := le;
	self := [];
end;

soap_in := DISTRIBUTE(project(f,into_PRIO_input(LEFT)), RANDOM());
// output(CHOOSEN(soap_in,eyeball), named('Sample_soap_in'));

serviceName := if(isFCRA, 'RiskWiseFCRA.RiskWiseMainPRIO', 'RiskWise.RiskWiseMainPRIO');
ip := if(isFCRA, fcraRoxie, roxieIP);

xlayout := RECORD
  Riskwise.Layout_PRIO;
	STRING errorcode;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

s_o := SOAPCALL(soap_in, ip,
				serviceName, {soap_in}, 
				DATASET(xlayout),
        RETRY(retry), TIMEOUT(timeout), LITERAL,
        XPATH(serviceName + 'Response/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

// output(CHOOSEN(s, eyeball), named('Sample_results'));

//output(s,, outputFile, CSV(heading(single), quote('"')), overwrite);
//output(s(errorcode<>''),, outputFile + '_error', CSV(heading(single), QUOTE('"')), overwrite);

s := project(s_o, transform(recordof(s_o),
             self.acctno := left.account,
						 self := left));
						 
op_final := output(s,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);

fin_out := sequential(op_final);

return fin_out;

endmacro;