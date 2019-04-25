#workunit('name','Fraudpoint-fp1210');
#option ('hthorMemoryLimit', 1000);

import models, Risk_Indicators, Riskwise, ut;

//aside from these options here, only roxieIP and historydateyyyymm may need adjusting below
//===================  options  ==============================================================
unsigned 	recordsToRun 		:= 10;  	//number of records to read from input file (0 means ALL)
unsigned1 parallel_calls 	:= 2;  		//number of parallel soap calls to make [1..30]
unsigned1 eyeball 				:= 10;		//number of records to output for viewing
boolean 	includeV1 			:= false;  //set to 'true' to request version 1 attributes, else set to 'false'
boolean   includeV2 			:= false;	//set to 'true' to request version 2 attributes, else set to 'false'
unsigned1 redflags 				:= 0;			//set to 1 to request red flags, else set to 0

//===================  input-output files  ======================
inputFile :=  ut.foreign_prod+'tfuerstenberg::in::state_of_ga_3505_npi_in';  // 

//==================  input file layout  ========================
prii_layout := RECORD //This is the standard PII layout for batch
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    integer historydateyyyymm;
  END;
 
roxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie; // Production
//roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

f := IF(recordsToRun <= 0, DATASET(inputFile, prii_layout, CSV(QUOTE('"'))),
                          CHOOSEN(DATASET(inputFile, prii_layout, csv(quote('"'))), recordsToRun));

output(CHOOSEN(f, eyeball), named('sample_original_input'));

layout_soap_input := RECORD
	string orig_account;
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING ModelName;
	STRING DataRestrictionMask;
	INTEGER DPPAPurpose;
	INTEGER GLBPURPOSE;
	BOOLEAN IncludeVersion1;
	BOOLEAN IncludeVersion2;
	UNSIGNED1 RedFlag_version;
END;

Risk_Indicators.Layout_Batch_In make_batch_in(f le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno := le.account;
	SELF.Name_First := le.FirstName;
	SELF.Name_Middle := le.MiddleName;
	SELF.Name_Last := le.LastName;
	SELF.street_addr := le.StreetAddress;
	SELF.p_City_name := le.CITY;
	SELF.St := le.STATE;
	SELF.z5 := le.ZIP;
	SELF.Home_Phone := le.HomePhone;
	SELF.SSN := le.SSN;
	SELF.DOB := le.DateOfBirth;
	SELF.Work_Phone := le.WorkPhone;
	SELF.DL_Number := '';
	SELF.DL_State := '';
	self.historydateyyyymm := le.historydateyyyymm;  //to run in archive mode
	// self.historydateyyyymm := 999999;  //to run with current date
	SELF := le;
	SELF := [];
END;

layout_soap_input make_fp_in(f le, integer c) := TRANSFORM
	self.orig_account := le.account;
	batch := PROJECT(le, make_batch_in(LEFT, c));
	
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', riskwise.shortcuts.staging_neutral_roxieIP}], risk_indicators.layout_gateways_in);
	SELF.ModelName := 'FP1210_1';
	SELF.DataRestrictionMask := '000000000000000'; 
	SELF.DPPAPurpose := 1;
	SELF.GLBPURPOSE := 1;
	SELF.IncludeVersion1 := includeV1;   
	SELF.IncludeVersion2 := includeV2;		
	SELF.RedFlag_version := redflags;			
END;
	
soap_in := PROJECT(f, make_fp_in(LEFT, counter));
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('soap_in'));

Layout_FPScores := record
		models.Layout_FD_Batch_Out;
		string200 errorcode;
	END;
       
Layout_FPScores myfail(soap_in L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := [];
end;

soap_results := soapcall(soap_in, roxieIP ,
										'Models.FraudAdvisor_Batch_Service', 
										{soap_in},
                    dataset(Layout_FPScores), 
										parallel(parallel_calls) ,
										onfail(myfail(LEFT)));

output(choosen(soap_results, eyeball), named('soap_results'));
output(soap_results,,'~jpyon::out::test_fp1210_1_0', CSV(heading(single), quote('"')));
//output(soap_results,,'~kvhtemp::out::FP1210_soap_results_' + thorlib.wuid(), csv(quote('"')) );
errors := soap_results(errorcode<>'');
output(choosen(errors, eyeball), named('errors'));
output(count(errors), named('error_count'));
