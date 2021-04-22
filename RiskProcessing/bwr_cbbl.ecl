#workunit('name','nonfcra-cbbl');
#option ('hthorMemoryLimit', 1000)

/* **This process was set up for Chase.  Many output fields have been redefined and the 
     Field names may not match   */

import riskwise, Scoring, risk_indicators;

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

// f := dataset('~tfuerstenberg::in::chase_1275_cbbl_bnk4_in', Layout, csv(QUOTE('"')));
f := choosen(dataset('~tfuerstenberg::in::chase_1275_cbbl_bnk4_in', Layout, csv(QUOTE('"'))),10);

output(f);


//mapping
Scoring.Layout_BC1O_soapcall into_BC1O_input(f le) := transform
	self.tribcode := 'cbbl';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM:=(integer)'200607';
	self.dppapurpose := 3;
	self.glbpurpose := 1;

	self.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products

	self := le;
	self := [];
end;

soap_in := project(f,into_BC1O_input(LEFT));
output(soap_in, named('soap_in'));

roxieIP:='http://roxiethorvip.hpcc.risk.regn.net:9856';  // Roxiebatch

Scoring.MAC_PROD_Soapcall(soap_in, RiskWise.Layout_BC1O, roxieIP, 'RiskWise.RiskWiseMainBC1O',s_f, parallel_threads);

//try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_SDBO_Soapcall,SELF := LEFT));
//Scoring.MAC_PROD_Soapcall(try_2, RiskWise.Layout_SDBO, roxieIP, 'RiskWiseFCRA.RiskWiseMainSDBO',s_f2, parallel_threads);

s := s_f(errorcode=''); //+ s_f2;

output(s, named('results'));
output(s,,'~tfuerstenberg::out::chase_1275_bnk4_out3', CSV(heading(single), QUOTE('"')), overwrite);
output(s_f(errorcode<>''),,'~tfuerstenberg::out::chase_1275_bnk4_error',CSV(heading(single), QUOTE('"')), overwrite);
