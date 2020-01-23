// EXPORT NonFCRA_Shell_54 := 'todo';

#workunit('name','nonfcrashell 5.4');
// #workunit('name','nonfcrashell 5.4');
IMPORT Risk_Indicators, riskprocessing, RiskWise, data_services, _control, gateway;

integer bsversion := 54;	
// unsigned record_limit :=   0;    //number of records to read from input file; 0 means ALL
unsigned record_limit :=   5;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 3;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
boolean RemoveFares := false;	// change this to TRUE for FARES filtering
boolean LeadIntegrityMode := false;  // change this to TRUE for LeadIntegrity modeling

string DataRestrictionMask := '0000000000000000000000000';	// No Restrictions
// string DataRestrictionMask := '101000000000000000000000000'; //No Fares or Experian Business Reports

// string DataPermissionMask  := '0000000001101';	// 10 is SSA, 11 is FDN test fraud/contributory fraud, 13 is Insurance DL
string DataPermissionMask  := '100000000000000000000';	//  Matching with the PhoneShell Permissions
string IntendedPurpose := '';  // leave blank in nonfcra
unsigned3 LastSeenThreshold := 365;	//Phoneshell uses default of 365.  # of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all)
unsigned1 glba := 1;
unsigned1 dppa := 3;
boolean RetainInputDID := FALSE; //Change to TRUE to retain the input LexID


//===================  input-output files  ======================

// infile_name := '~scoringqa::phoneshell::in::jul18_pii.csv';
// infile_name := '~scoringqa::in::shell_2_0_testfile_may_july_2018_input.csv';
infile_name := '~scoringqa::in::phoneshell_testsample_jul_sep19_im.csv';               //Newest Sample subset From Blake/Ben W  3k
// infile_name := '~scoringqa::in::phoneshell_testsample_nov18_jan19_input_3k_4of4.csv';               //Newest Sample subset From Blake/Ben W  3k


// outfile_name := '~Scoring::out::phoneshell_project_bocashell_54_nonFCRA_May_July_NoRestrictions' + '_PhonesPlusv2_Gong_Base_' + thorlib.wuid();          //Run with No Restrictions
// outfile_name := '~Scoring::out::phoneshell_project_bocashell_54_nonFCRA_May_July_Restrictions' + '_PhonesPlusv2_Gong_Base_' + thorlib.wuid();           //Run with Restrictions
// outfile_name := '~Scoring::out::phoneshell_project_bocashell_54_nonFCRA_May_July_Restrictions' + '_PhonesPlusv2_Gong_Base_' + thorlib.wuid();           //Run with Restrictions
outfile_name := '~ScoringQA::out::phoneshell_project_bocashell_54_nonFCRA_jul_sep_PSMatch_' + thorlib.wuid();           //Run with Restrictions
// outfile_name := '~ScoringQA::out::bocashell_54_nonFCRA_' + 'Timing' + '_' + 'Restrictions' + '_' + '3k_subset3_Production' + '_' + thorlib.wuid();           //Run with Restrictions

//==================  input file layout  ========================

layout_input := RECORD
  string account;
  string firstname;
  string middlename;
  string lastname;
  string suffixname;
  string streetaddress;
  string city;
  string state;
  string zip;
  string ssn;
  string did;
END;

//====================================================
//=============  Service settings ====================
//====================================================
// Regular BocaShell service
// bs_service := 'risk_indicators.boca_shell.58';
bs_service := 'risk_indicators.boca_shell';
// roxieIP := RiskWise.Shortcuts.dev194;
// roxieIP := RiskWise.Shortcuts.QA_neutral_roxieIP; 
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP;  // Staging/Cert Roxie
// roxieIP := RiskWise.Shortcuts.Dev156;              // Dev156 Fusion Roxie
// RoxieIP := Riskwise.shortcuts.core_97_roxieIP;  // Core Roxie
roxieIP := RiskWise.Shortcuts.prod_batch_analytics_roxie; // Production Roxie


//====================================================
//=====================  R U N  ======================
//====================================================
ds_in := DATASET(infile_name, layout_input, CSV(HEADING(single), QUOTE('"')));// use this for a CSV file
 
// load sample data
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
// OUTPUT (choosen(ds_input,eyeball), NAMED ('input'));

l := RECORD
	string old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;


l assignAccount (ds_input le, INTEGER c) := TRANSFORM
	self.old_account_number := le.Account;
  SELF.AccountNumber := (string)c;
  SELF.StreetAddress := le.StreetAddress;
  // Self.Zip := le.zip[1..5] + le.zip[7..10];	   // dropping a space.  iid layout can only take string9, but input file is 10 char. (11111 1111)
  Self.Zip := le.zip[1..5] ;	   // Looks like bocashell only takes zip5, so dropping the last 4 to make things match
  SELF.GLBPurpose  := glba;
  SELF.DPPAPurpose := dppa;
	
	// self.retainInputDID := RetainInputDID;         //Removing so it sets to default and guarantees it matches Phoneshell
	// self.did := (string)le.DID; 

  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  

	self.historydateyyyymm := 999999;  
  self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  

  // self.historydateyyyymm := map(
			// regexfind('^\\d{8} \\d{8}$', (string)le.HistoryDateYYYYMM) => (string)le.HistoryDateYYYYMM[..6],
			// regexfind('^\\d{8}$',        (string)le.HistoryDateYYYYMM) => (string)le.HistoryDateYYYYMM[..6],
			                                                // (string)le.HistoryDateYYYYMM
	// );
	
  // self.historyDateTimeStamp := map(
      // le.HistoryDateYYYYMM in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			// regexfind('^\\d{8} \\d{8}$', le.HistoryDateYYYYMM) => le.HistoryDateYYYYMM,
			// regexfind('^\\d{8}$',        le.HistoryDateYYYYMM) => le.HistoryDateYYYYMM +   ' 00000100',
			// regexfind('^\\d{6}$',        le.HistoryDateYYYYMM) => le.HistoryDateYYYYMM + '01 00000100',		                                                
			                                                // le.HistoryDateYYYYMM
	// );
	
 
  SELF.IncludeScore := true;         //
  SELF.datarestrictionmask := datarestrictionmask;
  SELF.datapermissionmask := datapermissionmask;
  // SELF.RemoveFares := RemoveFares;                 //Removing so it sets to default and guarantees it matches Phoneshell
  // SELF.LeadIntegrityMode := LeadIntegrityMode;     //Removing so it sets to default and guarantees it matches Phoneshell
  SELF.LastSeenThreshold := LastSeenThreshold;     
	self.bsversion := bsversion;	
	// if you are running realtime mode with today's date and you need realtime inquiries turn on deltabase searching
	// self.gateways := project(riskwise.shortcuts.gw_delta_dev, transform(Gateway.Layouts.Config, self := left, self := []) );   //dev deltabase
	// self.gateways := project(riskwise.shortcuts.gw_delta_prod, transform(Gateway.Layouts.Config, self := left, self := []) );   // production deltabase
	SELF := le;
  SELF := [];
END;
p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
// output(choosen(p_f,eyeball), named('BSInput'));
// OUTPUT(p_f,, outfile_name + '_BSInputSample', thor, OVERWRITE);
								
s := Risk_Indicators.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);

riskprocessing.layouts.layout_internal_shell getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;

res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

// OUTPUT (choosen(res, eyeball), NAMED ('result'));
// OUTPUT (choosen(res_err, eyeball), NAMED ('res_err'));
// output(count(res_err), named('error_count'));

OUTPUT (res, , outfile_name, thor, __compressed__, overwrite);

// the conversion portion-----------------------------------------------------------------------

f := dataset(outfile_name, riskprocessing.layouts.layout_internal_shell, thor);
// OUTPUT(CHOOSEN(f, eyeball), NAMED('infile'));

isFCRA := false;
edina := Risk_Indicators.ToEdina_54(f, isFCRA, DataRestrictionMask, IntendedPurpose);
// OUTPUT(edina,, outfile_name + 'ModelingLayout'+ '_thor_copy', thor, OVERWRITE);

// OUTPUT(CHOOSEN(edina,eyeball), NAMED('edina'));
// OUTPUT(edina,, outfile_name+'_edina_v54',CSV(HEADING(single), QUOTE('"'))); // Write to disk.
