#workunit('name','NonFCRA-ivp1');
#option ('hthorMemoryLimit', 1000);

/* *** Note that Neticuity is turned ON *** needs to use Cert gateway  */

import riskwise, Scoring, risk_indicators;

Layout_IPVO := record
	string  ipaddr;
	string  account;
end;

unsigned1 parallel_threads := 30;  //max number of parallel threads = 30
integer records_to_run := 5; //number of records to run from the input file, set to 0 to run the full file

f := if(records_to_run > 0, choosen(dataset('~tfuerstenberg::in::ln_5963_tris_acct_ipaddr_in', Layout_IPVO, csv(QUOTE('"'),heading(single))),records_to_run),
														dataset('~tfuerstenberg::in::ln_5963_tris_acct_ipaddr_in', Layout_IPVO, csv(QUOTE('"'),heading(single))));

output(f);

//mapping
Scoring.Layout_IPVO_Soapcall into_IPVO_input(f le) := transform
	self.tribcode := 'ipv1';  // !! replace the tribcode here !!
	self.HistoryDateYYYYMM:=(integer)'999999';
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.gateways := dataset([{'fcra', 'http://roxiethorvip.hpcc.risk.regn.net:9856'},
						{'netacuity', 'http://rw_score_dev:Password01@rwgatewaycert.sc.seisint.com:7726/WsGateway'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_IPVO_input(LEFT));
output(soap_in, named('soap_in'));

dist_dataset := distribute(soap_in, random());

roxieIP := riskwise.shortcuts.prod_batch_neutral;	// roxie batch

Layout_IPVO_Out := record
	RiskWise.Layout_IPVO;
	string errorcode;
end;

Layout_IPVO_Out myFail(dist_dataset le) := TRANSFORM
	SELF.account := le.account;
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	
	SELF := le;
	SELF := [];
END;

s_f := soapcall(dist_dataset, roxieIP,
				'RiskWise.RiskWiseMainIPVO', {dist_dataset}, 
				DATASET(Layout_IPVO_Out),LITERAL,
        XPATH('RiskWise.RiskWiseMainIPVOResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(parallel_threads), 
				retry(10),
				onFail(myFail(LEFT)));
				
output(choosen(s_f, 100), named('roxie_result'));

//try_2 := JOIN(soap_in, s_f(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(Scoring.Layout_IPVO_Soapcall,SELF := LEFT));
//Scoring.MAC_PROD_Soapcall(try_2, RiskWise.Layout_IPVO, roxieIP, 'RiskWiseFCRA.RiskWiseMainIPVO',s_f2, parallel_threads);

s := s_f(errorcode=''); //+ s_f2;
s2 := s_f(errorcode<>'');

output(s, named('results'));
output(s2, named('result_errors'));

output(s,,'~tfuerstenberg::out::ln_5963_tris_acct_ipaddr_out', CSV(heading(single), QUOTE('"')), overwrite);
output(s2,,'~tfuerstenberg::out::test_error',CSV(heading(single), QUOTE('"')), overwrite);
