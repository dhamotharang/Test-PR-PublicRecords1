#workunit('name','Chase_cbbl');
#option ('hthorMemoryLimit', 1000)

/* **This process was set up for Chase.  Many output fields have been redefined and the 
     Field names may not match   */

import riskwise, Scoring, risk_indicators, ut, sghatti;
recordsToRun := 0;
eyeball := 50;

threads := 1;


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


unsigned1 parallel_threads := 30;  //max number of parallel threads = 30


f := dataset('~sghatti::in::Chase_CBBL_data', Layout, thor );
outputFileName := '~nkoubsky::out::Chase_CBBL_Cust_Rec_dev196_' + thorlib.wuid();;

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

soap_in := project(f,into_BC1O_input(LEFT));
// output(soap_in, named('soap_in'));

// roxieIP:=riskwise.shortcuts.staging_neutral_roxieIP;  // Roxiebatch
roxieIP := RiskWise.shortcuts.Dev196 ;//dev196


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
        RETRY(3), TIMEOUT(120), LITERAL,
        XPATH('RiskWise.RiskWiseMainBC1OResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(1), onFail(myFail(LEFT)));




s := project(s_o, transform(recordof(s_o),
             self.acctno := left.account,
						 self := left));



EXPORT Chase_Cbbl_XML_Dev196 := output(s,, outputFileName, CSV(HEADING(single), QUOTE('"')));