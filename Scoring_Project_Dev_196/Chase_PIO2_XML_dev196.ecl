#workunit('name','NonFCRA-pi02 Process');
#option ('hthorMemoryLimit', 1000)


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

isFCRA := FALSE;

fcraRoxie  := riskwise.shortcuts.staging_fcra_roxieIP; 
// 'http://fcrabatch.sc.seisint.com:9876';

//roxieIP := RiskWise.shortcuts.prod_batch_neutral; // Production
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
roxieIP := RiskWise.shortcuts.Dev196 ;//dev196


// inputFile := '~cgrinsteiner::in::Chase_PIO2';
inputFile := '~sghatti::in::Chase_PIO2_data';

outfile_name := '~nkoubsky::out::Chase_PI02_cust_rec_dev196_' + thorlib.wuid();

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
layout_prii := record
    STRING Account;
    STRING First;
    STRING MiddleName;
    STRING Last;
    STRING addr;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HPhone;
    STRING socs;
    STRING dob;
    STRING WorkPhone;
    STRING income;  
    string Drlc;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    integer historydateyyyymm;
end;

f := IF(recordsToRun <= 0, dataset(inputFile, layout_prii, thor), CHOOSEN(DATASET(inputFile, layout_prii, thor), recordsToRun));

// output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));
// output(count(f), NAMED('Number_Of_Records_On_Input'));


//mapping
sghatti.Layout_PRIO_Soapcall into_PRIO_input(f le) := transform
 	self.acctno := le.account;
	self.tribcode := 'pi02';  // !! replace the tribcode here !!
//	self.HistoryDateYYYYMM :='200607';
//	self.run_Seed:=false ;
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
        RETRY(3), TIMEOUT(120), LITERAL,
        XPATH(serviceName + 'Response/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(1), onFail(myFail(LEFT)));

// output(CHOOSEN(s, eyeball), named('Sample_results'));

//output(s,, outputFile, CSV(heading(single), quote('"')), overwrite);
//output(s(errorcode<>''),, outputFile + '_error', CSV(heading(single), QUOTE('"')), overwrite);

s := project(s_o, transform(recordof(s_o),
             self.acctno := left.account,
						 self := left));
						 

EXPORT Chase_PIO2_XML_dev196 := output(s,, outfile_name, CSV(HEADING(single), QUOTE('"')));