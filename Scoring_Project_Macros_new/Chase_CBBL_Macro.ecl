EXPORT Chase_CBBL_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

import riskwise, Scoring, risk_indicators, ut;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


layout:= record
	string	account	;
	string	cmpy	;
	string	AlternateCompanyName	;
	string	cmpyaddr	;
	string	cmpycity	;
	string	cmpystate	;
	string	cmpyzip	;
	string	cmpyphone	;
	string	fin	;
	string	ipaddr ;
	string	first	;
	string	RepresentativeMiddleName ;
	string	last	;
	string	RepresentativeNameSuffix  ;
	string	addr	;
	string	city	;
	string	state	;
	string	zip	;
	string	socs	;
	string	dob	;
	string  RepresentativeAge   ;
	string	drlc	;
	string	drlcstate	;
	string	hphone	;
	string	emailaddr	;
	string  RepresentativeFormerLastName ;
	integer	HistoryDateYYYYMM;
end;

f := IF(no_of_records <= 0, dataset(ut.foreign_prod + infile_name, Layout, thor ),
                            CHOOSEN(DATASET(ut.foreign_prod + infile_name, Layout, thor), no_of_records));
														



// output(f);


//mapping
sghatti.Layout_BC1O_soapcall into_BC1O_input(f le) := transform
  SELF.acctno := le.account;	
	self.tribcode := 'cbbl';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM:=(integer)'200607';
	self.dppapurpose := 3;
	self.glbpurpose := 1;

	self.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products

	self := le;
	self := [];
end;

soap_in := DISTRIBUTE(project(f,into_BC1O_input(LEFT)), Random());
// output(soap_in, named('soap_in'));


xlayout := RECORD
  RiskWise.Layout_BC1O;
	STRING errorcode;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
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

fin_out := sequential(op_final);

return fin_out;

endmacro;
