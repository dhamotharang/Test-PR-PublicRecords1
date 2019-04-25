#workunit('name','RiskView Batch RVC1805_2');

IMPORT riskwise, ut, risk_indicators, models;

unsigned record_limit :=   10;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
  DataRestrictionMask := '10000100010101000000000000000000000000000'; 
//DataRestrictionMask := '10000100010001000000000000000000000000000'; // to restrict fares, experian and transunion -- returns liens and judgments
// DataRestrictionMask := '10000100010001000000000000000000000000001';//to restrict fares, LIENS/Jdgmts, experian and transunion 

//===================  input-output files  ======================
// infile_name :=  '~evanheel::in::dmservices_8481_in.csv';
infile_name := '~rbao::in::philips_co_8938_result_in_.csv';
outfile_name := '~dvstemp::out::philips_co_8938_rvc1805_2_result_';

//==================  input file layout  ========================
layout_input := RECORD 
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
 
 
//====================================================
//=============  Service settings ====================
//====================================================
// Neutral service ip
roxie_IP := RiskWise.Shortcuts.prod_batch_analytics_roxie;    // Roxiebatch

// FCRA service settings
roxieIP := RiskWise.Shortcuts.prod_batch_fcra; 		// This needs to point to where the service is deployed
// roxieIP := RiskWise.Shortcuts.staging_fcra_roxieIP;  


//====================================================
//=====================  R U N  ======================
//====================================================

ds_in := dataset (infile_name, layout_input, csv(quote('"')));

// ds_in := choosen(dataset (infile_name, layout_input, csv(quote('"'))),500000);
// ds_in := choosen(dataset (infile_name, layout_input, csv(quote('"'))),500000,500001);
// ds_in := choosen(dataset (infile_name, layout_input, csv(quote('"'))),500000,1000001);
// ds_in := choosen(dataset (infile_name, layout_input, csv(quote('"'))),500000,1500001);
// ds_in := choosen(dataset (infile_name, layout_input, csv(quote('"'))),500000,2000001);

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input, eyeball), NAMED ('input'));

layout_soap_input := RECORD
	string orig_account;
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING AlternateModel;
	BOOLEAN IsPreScreen;		
	STRING DataRestrictionMask;
	BOOLEAN IncludeAllScores;
	BOOLEAN IncludeAllAttributes;
	BOOLEAN IncludePrescreen;
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
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
	SELF.DL_Number := le.DLNumber;
	SELF.DL_State := le.DLState;
	self.historydateyyyymm := le.historydateyyyymm;	//to run with archive date from input file
	// self.historydateyyyymm := 999999;	//to run with current date
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	self.orig_account := le.account;
	batch := PROJECT(le, make_batch_in(LEFT, c));
	
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'neutralroxie', roxie_IP}], risk_indicators.layout_gateways_in);
	SELF.AlternateModel := 'rvc1805_2';
	SELF.IsPreScreen := false;		
	SELF.DataRestrictionMask := DataRestrictionMask;  
	SELF.IncludeAllScores := false;
	SELF.IncludeAllAttributes := false;	
	SELF.IncludePrescreen := false;	//must be true to get this prescreen score
END;
	
soap_in := PROJECT(ds_input, make_rv_in(LEFT, counter));
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('soap_in'));

dist_dataset := PROJECT(soap_in,TRANSFORM(layout_soap_input,SELF := LEFT));

roxie_output_layout := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	Models.Layout_RiskView_Batch_Out;
	STRING errorcode;
END;
       
roxie_output_layout myfail(soap_in L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno := l.batch_in[1].acctno;
	self := [];
end;

soap_results := soapcall(dist_dataset, roxieIP ,
										'models.RiskView_Batch_Service', 
										{dist_dataset},
                    dataset(roxie_output_layout), 
										parallel(parallel_calls) ,
										onfail(myfail(LEFT)));

output(choosen(soap_results, eyeball), named('soap_results'));
output(soap_results,,outfile_name + thorlib.wuid(), csv(heading(single), quote('"') ) );

errors := soap_results(errorcode<>'');
output(choosen(errors, eyeball), named('errors'));
output(count(errors), named('error_count'));
