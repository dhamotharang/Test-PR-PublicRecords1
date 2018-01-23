// #workunit('name','nonfcra-bnk4');
// #option ('hthorMemoryLimit', 1000);

EXPORT Chase_BNK4_XML_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro



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



/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.bus_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;

f := IF(no_of_records = 0, dataset(ut.foreign_prod + Infile_name, layout_input,  CSV(HEADING(single), QUOTE('"'))), ChooseN(dataset(ut.foreign_prod + infile_name, layout_input,  CSV(HEADING(single), QUOTE('"'))), no_of_records));
  
op1 := output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));

//mapping
sghatti.Layout_BC1O_soapcall into_BC1O_input(f le) := transform
   SELF.acctno := (string)le.accountnumber;
	 self.account := (string)le.accountnumber;
	 SELF.first := le.firstname;
	SELF.last := le.lastname;
	SELF.addr := le.streetaddress;
	SELF.city:= le.CITY;
	SELF.state := le.st_2;
	SELF.zip := le.ZIP;
	SELF.hphone := le.homephone;
	SELF.socs := le.ssn;
	SELF.dob := le.dateofbirth;
	self.historydateyyyymm := le.historydateyyyymm ;
		
	self.cmpy := le.name_company;
	self.cmpyaddr := le.street_addr2;
	self.cmpycity := le.p_city_name_2;
	self.cmpystate := le.st_2;
	self.cmpyzip := le.z5_2;
	self.cmpyphone := le.phoneno;
	self.fin := le.fein;
	 
	self.tribcode := 'bnk4';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM:=(integer)'200607';
	self.dppapurpose := 3;
	self.glbpurpose := 1;
//	self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := DISTRIBUTE(project(f,into_BC1O_input(LEFT)), RANDOM());
op2:=output(CHOOSEN(soap_in, eyeball), named('sample_soap_in'));

xlayout := RECORD

  RiskWise.Layout_BC1O;
	STRING errorcode;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	// self.acctno:=le.acctno;
	SELF := le;
	SELF := [];
END;

s_o := SOAPCALL(soap_in, roxieIP,
				'RiskWise.RiskWiseMainBC1O', {soap_in}, 
				DATASET(xlayout),
        RETRY(retry), TIMEOUT(timeout), LITERAL,
        XPATH('RiskWise.RiskWiseMainBC1OResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));


s := project(s_o, transform(recordof(s_o),
             self.acctno := left.account,
						 self := left));

op_final := output(s,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);

fin_out := sequential(op1,op2, op_final );

return fin_out;
endmacro;
