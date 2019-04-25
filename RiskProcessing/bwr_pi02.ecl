#workunit('name','NonFCRA-pi02 Process');
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

isFCRA := FALSE;

fcraRoxie := 'http://fcrabatch.sc.seisint.com:9876';

roxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie; // Production
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

inputFile := '~jpyon::in::choice_1432_p1_in';
outputFile := '~tsteil::out::test_pi02_out';

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
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
     string DRLCST;
     string BALANCE;
     string CHARGEOFFD;
     string FORMERLAST;
     string EMAIL;
     string COMPANY;
     integer HistoryDateYYYYMM;
end;

f := IF(recordsToRun <= 0, dataset(inputFile, layout_prii, csv(QUOTE('"'))), CHOOSEN(DATASET(inputFile, layout_prii, CSV(QUOTE('"'))), recordsToRun));

output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));
output(count(f), NAMED('Number_Of_Records_On_Input'));


//mapping
Scoring.Layout_PRIO_Soapcall into_PRIO_input(f le) := transform
	self.tribcode := 'pi02';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM :='200607';
//	self.run_Seed:=false ;
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self := le;
	self := [];
end;

soap_in := DISTRIBUTE(project(f,into_PRIO_input(LEFT)), RANDOM());
output(CHOOSEN(soap_in,eyeball), named('Sample_soap_in'));

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

s := SOAPCALL(soap_in, ip,
				serviceName, {soap_in}, 
				DATASET(xlayout),
        RETRY(5), TIMEOUT(500), LITERAL,
        XPATH(serviceName + 'Response/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

output(CHOOSEN(s, eyeball), named('Sample_results'));

output(s,, outputFile, CSV(heading(single), quote('"')), overwrite);
output(s(errorcode<>''),, outputFile + '_error', CSV(heading(single), QUOTE('"')), overwrite);