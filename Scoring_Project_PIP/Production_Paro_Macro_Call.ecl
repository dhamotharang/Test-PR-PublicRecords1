import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking,sghatti,Gateway,scoring_qa,ut,STD;

//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 1;
Timeout := 25;
Retry_time := 3;
no_of_recs_to_run :=1000;
// roxieIP_Prod :=  'http://10.173.154.' + (STRING)(thorlib.node() % 20 + 1) + ':9876';
roxieIP_Prod := 'http://roxiebatch.sc.seisint.com:9856'; //  prod
// roxieIP_cert := RiskWise.shortcuts.QA_neutral_roxieIP;  //  cert for testing 


filetag_prod1 := ut.GetDate  +'_Prod1'; 
filetag_prod2 := ut.GetDate  +'_Prod2'; 
/* 
	**** PROD COMPARE ****
	**** Steps:	Run two parallel files against production
							Check if any similar transactions had a score shift of more than 45 points
							If more than 10% of scores meet the criteria, send an alert
							Historically 20% - 100% of records have a significant shift when the cleaner is down
*/

IT61_Scores_Paro_msn605_infile  := scoring_project_pip.Input_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_infile;                       //Added 4/6/2016
IT61_Scores_Paro_msn605_out1 := scoring_project_pip.Output_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_outfile + filetag_prod1  ;    //Added 4/6/2016
IT61_Scores_Paro_msn605_out2 := scoring_project_pip.Output_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_outfile + filetag_prod2  ;    //Added 4/6/2016
layout := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_IT61_Paro_Global_Layout;

// Two parallel data collections to Production running the same input file.  Results are stored under names for prod1 and prod2
// Runs 61 change trib code in macro not 60
IT61_Scores_Paro_msn605_Prod_macro1 := Scoring_Project_PIP.Paro_IT60_Batch_Prod_Macro(roxieIP_Prod, gateway_ip,no_of_threads,Timeout,Retry_time,IT61_Scores_Paro_msn605_infile,IT61_Scores_Paro_msn605_out1,no_of_recs_to_run);
IT61_Scores_Paro_msn605_Prod_macro2 := Scoring_Project_PIP.Paro_IT60_Batch_Prod_Macro(roxieIP_Prod, gateway_ip,no_of_threads,Timeout,Retry_time,IT61_Scores_Paro_msn605_infile,IT61_Scores_Paro_msn605_out2,no_of_recs_to_run);

IT61_Scores_Paro_msn605_Prod_macro1;
IT61_Scores_Paro_msn605_Prod_macro2;

string prod1 := IT61_Scores_Paro_msn605_out1;
string prod2 := IT61_Scores_Paro_msn605_out2;

file1 := dataset(prod1, layout, thor);
file2 := dataset(prod2, layout, thor);

// Removing any records that errored out
clean_ds_baseline := file1(errorcode='');
clean_ds_new := file2(errorcode='');

// Keep any results that had a score change by more than 45 points
j1 := join(file1, file2, left.acctno = right.acctno
						and abs((integer)left.score - (integer)right.score) > 45,
						// and abs((integer)left.score - (integer)right.score) > 1, //change for testing
					 transform({dataset(layout) res}, self.res := left + right));
					 
j1_cnt := count(j1);
output(j1_cnt);

Percent := (j1_cnt / no_of_recs_to_run)*100;

boolean flag := if(Percent > 10, 1, 0);

output(if(flag = true, 'Potential Paro Issue: Investigate TomTom Cleaner!', 'Good: No Significant Shifts'), named('Final_TomTom_Cleaner_result'));
if(flag = true, output(choosen(j1, 25), named('Score_Diff_Greater_45_PTS')));
/* **** END OF PROD COMPARE **** */


/*
	**** PRODDATA CHECK - verify that all 4 cleaners are not down ****
	**** Steps:	Run a file against proddata in production
							See if lat, long, and geoblk are appended
							Send an alert if more than 19% are blank
							Historically when we've had an issue with the cleaner, we don't get lat, long, or geoblk on transactions that hit the bad cleaner
*/

pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;

dsin := dataset(IT61_Scores_Paro_msn605_infile, pii_layout, thor);
pdin := choosen(dsin, no_of_recs_to_run);

//*****************************************************

pd_layout_in := record
		unsigned6	did;
		string first;
		string last;
		unsigned dob;
		string10 phone;
		string10 socs;
		string addr;
		string city;
		string state;
		string zip;
end;

pd_layout_in trans(pdin le) := transform
		self.first := le.firstname;
		self.last := le.lastname;
		self.dob := (integer)le.dateofbirth;
		self.phone := le.homephone;
		self.socs := le.ssn;
		self.addr := le.streetaddress;
		self.city := le.city;
		self.state := le.state;
		self.zip := le.zip;
		self := [];
END;

pd_soap_in := project(pdin, trans(LEFT));

// form of the output layout for the indata_tomtom dataset
input_rec := record
	risk_indicators.Layouts.layout_input_plus_overrides;
	unsigned glb;
	unsigned dppa;
	string apn;
	unsigned bdid;
	string fein;
	string errorcode;
end;

	input_rec myFail(pd_soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			// SELF.Result.InputEcho.Seq:=(string)le.AccountNumber;
			SELF.dob := (string)le.dob;
			SELF := le;
			SELF := [];
		END;

Soap_output_prod := soapcall(pd_soap_in, roxieIP_Prod,
												'riskWise.ProdData', {pd_soap_in}, 
												// 'riskWise.ProdData', {pd_soap_in}, 
												DATASET(input_rec), 
												RETRY(Retry_time), TIMEOUT(Timeout),
												XPATH('*/Results/Result/Dataset[@name=\'indata_tomtom\']/Row'),
												PARALLEL(no_of_threads), onFail(myFail(LEFT)));
//remove errors
clean := Soap_output_prod(errorcode='');

// output any records that didn't get a geo_blk returned from the cleaner
output(clean(geo_blk = ''));

lat_count := count(clean(lat = ''));
long_count := count(clean(long = ''));
geo_blk_count := count(clean(geo_blk = ''));


lat_PCT := (lat_count/no_of_recs_to_run)*100;
long_PCT := (long_count/no_of_recs_to_run)*100;
geo_PCT := (geo_blk_count/no_of_recs_to_run)*100;

// the percent of records without the appends from the cleaner.  Note that there may be bad address on input that don't get the append though there is not an issue with the clearner
output(lat_PCT, named('lat_PCT_blank'));
output(long_PCT, named('long_PCT_blank'));
output(geo_PCT, named('geo_PCT_blank'));


flag2 := if(geo_PCT > 10, true, false); //change for testing 0.2

/* **** END OF PRODDATA CHECK **** */


list := 'Praveen.Maruvekere@lexisnexisrisk.com,Nick.Metianu@lexisnexisrisk.com,Lavinia.Ricketts@lexisnexisrisk.com,Nathan.Koubsky@lexisnexisrisk.com,Becki.Wilken@lexisnexisrisk.com,Brian.Knowles@lexisnexisrisk.com,RIS-GLONOC@risk.lexisnexis.com, isabel.ma@lexisnexisrisk.com';
list_formatted := STD.str.FindReplace(list, ',','\n');
subject := 'Potential Paro Issue: Investigate TomTom Cleaner!';
message1 := 'Percent of records with score shift greater than 45 pts: ' + Percent +'%'  + '\n\n' + 'Please see boca dataland workunit output *Score Diff Greater 45 PTS* for examples ' + ThorLib.wuid();
message2 := 'Proddata Alert: Check the TomTom Cleaners. '+ '\n\n' + 'Percent of GeoCodes with blanks ' + geo_PCT +'%'  + '\n\n' +'Please see boca dataland workunit output '  + ThorLib.wuid(); 
error_message := 'ALERT EXCEPTION: There was an error with this alert and not necessarily a production issue.  Scoring QA please review.';
contacts := 'Please reach out to the following:\n' + list_formatted;

alert_message := if(flag and flag2 ,	message1 + '\n\n' + message2 + '\n\n' + contacts,
										if(flag	,message1 + '\n\n' + contacts,
										if(flag2	,	message2 + '\n\n' + contacts,
												error_message )));
												
if(flag or flag2, FileServices.SendEmail(list, Subject, alert_message));

EXPORT Production_Paro_Macro_Call := 'todo';
