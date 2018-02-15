#workunit('name','nonfcra-bnk4');
#option ('hthorMemoryLimit', 1000);

IMPORT Models, Risk_Indicators, RiskWise, Scoring, UT, sghatti;
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

threads := 1;

//roxieIP := RiskWise.shortcuts.prod_batch_neutral; // Production
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
roxieIP := RiskWise.shortcuts.Dev196 ;//dev196
// inputFile := '~cgrinsteiner::in::Chase_BNK4';

inputFile := '~sghatti::in::Chase_BNK4_data';

outfile_name := '~nkoubsky::out::Chase_BNK4_cust_rec_dev196_' + thorlib.wuid();

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
Layout_BC1O_soapcall := RECORD
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

f := IF(recordsToRun <= 0, dataset(inputFile, Layout_BC1O_soapcall, thor ),
                            CHOOSEN(DATASET(inputFile, Layout_BC1O_soapcall, thor), recordsToRun));

// output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));

//mapping
sghatti.Layout_BC1O_soapcall into_BC1O_input(f le) := transform
   SELF.acctno := le.account;
	self.tribcode := 'bnk4';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM:=(integer)'200607';
	self.dppapurpose := 3;
	self.glbpurpose := 1;
//	self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := DISTRIBUTE(project(f,into_BC1O_input(LEFT)), RANDOM());
// output(CHOOSEN(soap_in, eyeball), named('sample_soap_in'));

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

// s := s_f (TRIM(errorcode) = '');

// output(CHOOSEN(s, eyeball), named('sample_results'));
//output(s,, outputFile, CSV(heading(single), QUOTE('"')), overwrite);
//output(s_f(errorcode<>''),, outputFile + '_error', CSV(heading(single), QUOTE('"')), overwrite);

s := project(s_o, transform(recordof(s_o),
             self.acctno := left.account,
						 self := left));



EXPORT Chase_BNK4_XML_dev196 := output(s,, outfile_name, CSV(HEADING(single), QUOTE('"')));