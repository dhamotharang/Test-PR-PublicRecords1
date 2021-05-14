#workunit('name','nonfcra-bnk4');
#option ('hthorMemoryLimit', 1000)

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
recordsToRun := 0;
eyeball := 50;

threads := 25;

roxieIP := RiskWise.shortcuts.prod_batch_neutral; // Production
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

inputFile := '~jpyon::in::chase_1275_bnk4_dob_in_in';
outputFile := '~jpyon::out::chase_1275_bnk4_out';

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
Layout_BC1O_soapcall := record
	string account ;	
	string first;     
	string last ;
	string addr ; 
	string city ; 
	string state ;    
	string zip ;     
	string socs ;   
	string dob ; 
	string hphone ;
	string drlc ;  
	string drlcstate ;	
	string income ;  
	string cmpy ;  
//	string dbaname ;  
	string cmpyaddr ;   
	string cmpycity ;  
	string cmpystate ;    
	string cmpyzip ;     
	string cmpyphone ;     
	string fin ;     
	string internetcommflag ;   
	string emailaddr ;    
	string emailheadr ;   
	string ipaddr ;    
	integer  HistoryDateyyyymm ;	
	string apptime ;
end;

f := IF(recordsToRun <= 0, dataset(inputFile, Layout_BC1O_soapcall, csv(QUOTE('"'))),
                            CHOOSEN(DATASET(inputFile, Layout_BC1O_soapcall, CSV(QUOTE('"'))), recordsToRun));

output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));

//mapping
Scoring.Layout_BC1O_soapcall into_BC1O_input(f le) := transform
	self.tribcode := 'bnk4';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM:=(integer)'200607';
	self.dppapurpose := 3;
	self.glbpurpose := 1;
//	self.gateways := dataset([{'neutralroxie', 'http://roxiethorvip.hpcc.risk.regn.net:9856'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := DISTRIBUTE(project(f,into_BC1O_input(LEFT)), RANDOM());
output(CHOOSEN(soap_in, eyeball), named('sample_soap_in'));

xlayout := RECORD
  RiskWise.Layout_BC1O;
	STRING errorcode;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

s_f := SOAPCALL(soap_in, roxieIP,
				'RiskWise.RiskWiseMainBC1O', {soap_in}, 
				DATASET(xlayout),
        RETRY(5), TIMEOUT(500), LITERAL,
        XPATH('RiskWise.RiskWiseMainBC1OResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

s := s_f (TRIM(errorcode) = '');

output(CHOOSEN(s, eyeball), named('sample_results'));
output(s,, outputFile, CSV(heading(single), QUOTE('"')), overwrite);
output(s_f(errorcode<>''),, outputFile + '_error', CSV(heading(single), QUOTE('"')), overwrite);