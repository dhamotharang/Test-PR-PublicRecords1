#workunit('name','NonFCRA-idp1-process');
#option ('hthorMemoryLimit', 1000)


import riskwise, Scoring, risk_indicators;

layout_prii := record
     string ACCOUNT;
     string FIRST;
     string MIDDLEINI;
     string LAST;
     string ADDR;
     string CITY;
     string STATE;
     string ZIP;
     string HPHONE;
     string SOCS;
     string DOB;
     string WPHONE;
     string INCOME;
     string DRLC;
     string drlcstate;  //DRLCST;
     string BALANCE;
     string CHARGEOFFD;
     string FORMERLAST;
     string EMAIL;
     string COMPANY;
     Integer HistoryDateYYYYMM;
end;

unsigned1 parallel_threads := 30;  //max number of parallel threads = 30

f := dataset('~tfuerstenberg::in::icici_1075_ciid_fp', layout_prii, csv(QUOTE('"')));
// f := choosen(dataset('~tfuerstenberg::in::icici_1075_ciid_fp', layout_prii, csv(QUOTE('"'))),5);
output(f);

//mapping
Scoring.Layout_IDPO_Soapcall into_IDPO_input(f le) := transform
	self.tribcode := 'idp1';  // !! replace the tribcode here !!
    self.HistoryDateYYYYMM:=(integer)'999999';
	self.runSeed:=false ;
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	
	self.DataRestrictionMask := '000000000001';  // just ADVO restricted like GE is getting in production
	
	self.gateways := dataset([{'neutralroxie', 'http://roxiethorvip.hpcc.risk.regn.net:9856'}], risk_indicators.Layout_Gateways_In);

// *** with Targus Gateway "ON" ***
//	self.gateways := dataset([{'neutralroxie', 'http://roxiethorvip.hpcc.risk.regn.net:9856'},
//						{'targus','http://rw_data_prod:Password01@gatewayprodesp.sc.seisint.com:7726/wsGateway/?ver_=1.70'}], risk_indicators.Layout_Gateways_In);

	self := le;
	self := [];
end;

soap_in := project(f,into_IDPO_input(LEFT));
output(soap_in, named('soap_in'));

ox := record
   riskwise.layout_idpo - ri - billing;
end;

roxieIP :='http://roxiethorvip.hpcc.risk.regn.net:9856';  // Roxiebatch


xlayout := RECORD
	STRING errorcode;
	ox;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

s_f := soapcall(soap_in, roxieIP,
				'RiskWise.RiskWiseMainIDPO', {soap_in}, 
				DATASET(xlayout), 
				RETRY(2), TIMEOUT(500), LITERAL,
				XPATH('RiskWise.RiskWiseMainIDPOResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(parallel_threads), onFail(myFail(LEFT)));

s := s_f(errorcode=''); 

output(s, named('results'));
output(s,,'~tfuerstenberg::out::icici_1075_ipd1_out',csv(heading(single), quote('"')), overwrite);
output(s(errorcode<>''),,'~tfuerstenberg::icici_1075_ipd1_error',csv(heading(single), quote('"')), overwrite);


