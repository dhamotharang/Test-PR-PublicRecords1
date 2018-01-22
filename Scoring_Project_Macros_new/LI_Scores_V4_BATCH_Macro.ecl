EXPORT LI_Scores_V4_BATCH_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, RiskProcessing ;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


model := 'msn1106_0' ;   // Flagship Score




// Versions Available: 1, 3 and 4
version := 3;

// new internal fields for debugging, set to false so they are excluded from the layout by default
include_internal_extras := true;

// Boca Shell Version
bocaShellVersion := 4;

// Set to TRUE to run the ADL Based Boca Shell, FALSE to skip it
runADL := TRUE;

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
prii_layout := RECORD
  unsigned8 date_added;
  string customer;
  string source_info;
  integer1 perm_flag;
  integer3 accountnumber;
  string firstname;
  string middlename;
  string lastname;
  string streetaddress;
  string city;
  string state;
  string zip;
  string homephone;
  string ssn;
  string dateofbirth;
  string workphone;
  string income;
  string dlnumber;
  string dlstate;
  string balance;
  string chargeoffd;
  string formername;
  string email;
  string company;
  integer8 historydateyyyymm;
  string placeholder_1;
  string placeholder_2;
  string placeholder_3;
  string placeholder_4;
  string placeholder_5;
  string dppa;
  string glb;
  string drm;
  integer8 history_date;
  string other1;
  string other2;
  string other3;
  string other4;
 END;


f_all := DATASET(ut.foreign_prod+ infile_name, prii_layout, CSV(HEADING(single), QUOTE('"')));
f := IF(no_of_Records = 0, f_all, CHOOSEN(f_all, no_of_Records));


// Run the ADL based bocashell with that history date to append the SSN if it's missing
layout_soap_boca := RECORD
	STRING old_account_number;
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Country;
	STRING SSN;
	STRING DateOfBirth;
	STRING Age;
	STRING DLNumber;
	STRING DLState;
	STRING Email;
	STRING IPAddress;
	STRING HomePhone;
	STRING WorkPhone;
	STRING EmployerName;
	STRING FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	STRING DataRestrictionMask;	
	INTEGER Version;
	INTEGER HistoryDateYYYYMM;
	BOOLEAN ADL_Based_Shell;
	
	
	unsigned did;
	string wuid;
	string jobowner;
END;

layout_soap_boca transform_input_boca(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number :=  (STRING)le.accountnumber;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 0;
	SELF.GLBPurpose := 5;
	SELF.adl_based_shell := true;
	SELF.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	SELF.HistoryDateYYYYMM := IF(histDateYYYYMM=0, le.historydateyyyymm, histDateYYYYMM);
	SELF.Version := bocaShellVersion;
	SELF := le;
	
	self.wuid := thorlib.wuid();
	self.jobowner := thorlib.jobowner();

	SELF := [];
END;

p_f := PROJECT(f, transform_input_boca(LEFT, COUNTER));
// OUTPUT(CHOOSEN(p_f, eyeball), NAMED('original_input'));
// OUTPUT(COUNT(p_f(ssn<>'')), NAMED('records_with_ssn_originally'));

shell_input := DISTRIBUTE(p_f(ssn=''), RANDOM());

xlayout := RECORD
	risk_indicators.Layout_Boca_Shell;
	STRING errorcode;
END;

xlayout myFail(shell_input le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.seq := (UNSIGNED)le.AccountNumber;
	SELF := le;
	SELF := [];
END;

adlappendshell := SOAPCALL(shell_input, roxieIP,
				'Risk_Indicators.Boca_Shell', {shell_input}, 
				DATASET(xlayout),
				RETRY(retry), TIMEOUT(timeout),
				PARALLEL(threads), onFail(myFail(LEFT)));

// output(adlappendshell, named ('adlappendshell'));

appended_ssns := JOIN(shell_input, adlappendshell, (UNSIGNED)LEFT.accountnumber=RIGHT.seq,
					TRANSFORM(layout_soap_boca, SELF.ssn := RIGHT.shell_input.ssn, SELF := LEFT));

// version 4 attributes append best ssn internally if not present, so it should not run the adl shell
LeadIntegrity_input_temp := IF(runADL and version != 4, appended_ssns + p_f(ssn<>''), p_f);  // add back the records that already had the SSN on the customer file if TRUE, skip if FALSE

layout_soap := RECORD
	DATASET(iesp.leadintegrity.t_LeadIntegrityRequest) LeadIntegrityRequest;
	unsigned DID;
	UNSIGNED3 HistoryDateYYYYMM;
	string old_account_number;
	string wuid;
	string jobowner;
END;

layout_soap transform_input_request( LeadIntegrity_input_temp le) := TRANSFORM
	u := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User, SELF.AccountNumber := le.accountnumber; SELF.DLPurpose := '0'; SELF.GLBPurpose := '5'; SELF.DataRestrictionMask := '000000000000'; SELF := []));
	o := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegrityOptions, SELF.AttributesVersionRequest := (STRING)VERSION; SELF := []));
	
	n := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name, SELF.First := le.FirstName; SELF.Middle := le.MiddleName; SELF.Last := le.LastName; SELF := []));
	a := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, SELF.StreetAddress1 := le.StreetAddress; SELF.City := le.City; SELF.State := le.State; SELF.Zip5 := le.Zip; SELF := []));
	d := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, SELF.Year := (INTEGER)le.DateOfBirth[1..4]; SELF.Month := (INTEGER)le.DateOfBirth[5..6]; SELF.Day := (INTEGER)le.DateOfBirth[7..8]; SELF := []));
	s := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegritySearchBy, SELF.Seq := le.AccountNumber; 
																																											SELF.Name := n[1]; 
																																											SELF.Address := a[1]; 
																																											SELF.DOB := d[1]; 
																																											SELF.SSN := le.SSN; 
																																											SELF.HomePhone := le.HomePhone; 
																																											SELF.WorkPhone := le.WorkPhone;
																																											SELF.DriverLicenseNumber := le.DLNumber;
																																											SELF.DriverLicenseState := le.DLState;
																																											SELF := []));
	r := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegrityRequest, SELF.User := u[1]; SELF.Options := o[1]; SELF.SearchBy := s[1]; SELF := []));
	SELF.LeadIntegrityRequest := r[1];
	self.did := le.did;
	SELF.HistoryDateYYYYMM := IF(histDateYYYYMM=0, le.historydateyyyymm, histDateYYYYMM);
	self.old_account_number := le.old_account_number;
	self.wuid := thorlib.wuid();
	self.jobowner := thorlib.jobowner();
	SELF := [];
END;

LeadIntegrity_input := DISTRIBUTE(PROJECT(LeadIntegrity_input_temp, transform_input_request(LEFT)), RANDOM());

// OUTPUT(CHOOSEN(LeadIntegrity_input, eyeball), NAMED('LeadIntegrity_input'));  
// OUTPUT(COUNT(LeadIntegrity_input (LeadIntegrityRequest[1].SearchBy.SSN <> '')), NAMED('records_with_ssn_after_appending_it')); // double check that this one has ssns

//added by Chad
ds_input := IF (no_of_records = 0, f, CHOOSEN (f , no_of_records));

// ds_input;

layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	// boolean IncludeVersion4;
	INTEGER Version;
	INTEGER HistoryDateYYYYMM;
	BOOLEAN ADL_Based_Shell;
	string ModelName:= '';
	
	//BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno := (STRING)le.accountnumber;
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
	self.historydateyyyymm := 999999 ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', roxieIP}], risk_indicators.layout_gateways_in);
	// SELF.IsPreScreen := true;		
	// self.IncludeVersion4 := true;
	SELF.Version := bocaShellVersion;
	SELF.adl_based_shell := true;
	SELF.ModelName:= model ;
  SELF.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	SELF.HistoryDateYYYYMM := IF(histDateYYYYMM=0, le.historydateyyyymm, histDateYYYYMM);
	END;
	
	soap_in := PROJECT(ds_input, make_rv_in(LEFT, counter));

//End added by chad
// soap_in;


// Now run the LeadIntegrity attributes
LeadIntegrityoutput := RECORD
	// unsigned6 did;
  // models.layouts.layout_LeadIntegrity_attributes_batch ;
	// Models.layouts.layout_LeadIntegrity_attributes_batch_flattened;
     models.layouts.layout_LeadIntegrity_attributes_batch 	;
	STRING errorcode;
END;

LeadIntegrityoutput myFail2(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;


				
LeadIntegrity_attributes := SOAPCALL(soap_in, roxieIP,
				'Models.LeadIntegrity_Batch_Service', {soap_in}, 
				DATASET(LeadIntegrityoutput),
				PARALLEL(threads), onFail(myFail2(LEFT)));				
				
// OUTPUT(CHOOSEN(LeadIntegrity_attributes(errorcode=''), eyeball), NAMED('LeadIntegrity_results'));
// OUTPUT(CHOOSEN(LeadIntegrity_attributes(errorcode<>''), eyeball), NAMED('LeadIntegrity_errors'));

// op_final := output(LeadIntegrity_attributes,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);


	layout_slimmed := RECORD
	STRING20 seq;
	STRING30 acctno;
	// string name;
	string3 score;
	string2 rc1;
	string2 rc2;
	string2 rc3;
	string2 rc4;
//	string2 rc5;
//	string2 rc6;
	#if(include_internal_extras)
		RiskProcessing.layout_internal_extras;
	#end
END;
	
	layout_slimmed slim_v4( LeadIntegrity_attributes le ) := TRANSFORM
		// self.accountnumber := le.acctno ; // original account number not available here...
		// SELF.seq := le.Seq; // ...so hang onto the seq
    	
	  self.seq    := le.seq;
		self.acctno := le.acctno ;
		self.score  := le.score1;
		self.rc1    := le.reason1;
		self.rc2    := le.reason2;
		self.rc3    := le.reason3;
		self.rc4    := le.reason4;		
				
				#if(include_internal_extras)
			// self.DID := le.did; 
			  self := [];
		   #end;
	END;

	slim_attr := project( LeadIntegrity_attributes, slim_v4(left) );
	
	op_final := output(slim_attr,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);

fin_out := sequential(op_final);

return fin_out;

endmacro;