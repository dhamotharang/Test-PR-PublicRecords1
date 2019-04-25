EXPORT CapitalOne_ITA_V3_BATCH_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, RiskProcessing ;
IMPORT scoring, risk_indicators, riskwise, ut;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

newlayout := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
	

inputData1 := dataset(ut.foreign_prod_boca +  infile_name, newlayout,CSV(HEADING(0), QUOTE('"')));
f_all := DISTRIBUTE(inputData1, RANDOM());




// Versions Available: 1, 3 and 4
version := 3;

// new internal fields for debugging, set to false so they are excluded from the layout by default
include_internal_extras := true;

// Boca Shell Version
bocaShellVersion := 3;  //version 3 is for LI attributes 3, 4 for Li attributes version 4

// Set to TRUE to run the ADL Based Boca Shell, FALSE to skip it
runADL := TRUE;

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/

f := IF(no_of_records = 0, f_all, CHOOSEN(f_all, no_of_records));


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
	SELF.old_account_number := (string)le.AccountNumber;
	SELF.Accountnumber := (STRING)le.Accountnumber;	
	SELF.DPPAPurpose := 0;
	SELF.GLBPurpose := 5;
	SELF.adl_based_shell := true;
	SELF.DataRestrictionMask := '000000000000010000000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	SELF.HistoryDateYYYYMM := 999999;
	SELF.Version := bocaShellVersion;
	SELF := le;
	
	self.wuid := thorlib.wuid();
	self.jobowner := thorlib.jobowner();

	SELF := [];
END;
//DPPAPurpose,GLBPurpose and HistoryDateYYYYMM  matches to leadintegrity (07/15/2014)

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




// OUTPUT(shell_input); //ssns should be blank
//***********************************************************************
appended_ssns := JOIN(shell_input, adlappendshell, (UNSIGNED)LEFT.accountnumber=RIGHT.seq,
					TRANSFORM(layout_soap_boca, SELF.ssn := RIGHT.shell_input.ssn, SELF := LEFT));

//**********************************************************************
// OUTPUT(appended_ssns); //most ssns should not be blank





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




ds_input_ssnappend:=join(f,adlappendshell,left.firstname=right.shell_input.fname and 
	                                               left.lastname=right.shell_input.lname and 
	                                               left.zip=right.shell_input.z5,
	                         																								
               			transform(recordof(f),               			
               			self.ssn 	:= right.shell_input.ssn ;  
								  
						
      							self:=left;
               	),left outer);


layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion3;
	INTEGER Version;
	INTEGER HistoryDateYYYYMM;
	BOOLEAN ADL_Based_Shell;
	
	//BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input_ssnappend le, integer c) := TRANSFORM
	self.seq :=le.AccountNumber;
	SELF.acctno := (string)le.AccountNumber;
	SELF.Name_First := le.firstname;
	SELF.Name_Middle := le.middlename;
	SELF.Name_Last := le.lastname;
	SELF.street_addr := le.streetaddress;
	SELF.p_City_name := le.city;
	SELF.St := le.state;
	SELF.z5 := le.zip;
	// SELF.Home_Phone := le.HPhone;
	SELF.SSN := le.ssn;
	// SELF.DOB := le.dob;
	// SELF.Work_Phone := le.WPhone;
	self.historydateyyyymm := 999999 ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input_ssnappend le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', roxieIP}], risk_indicators.layout_gateways_in);
	// SELF.IsPreScreen := true;		
	self.IncludeVersion3 := true;
	SELF.Version := bocaShellVersion;
	SELF.adl_based_shell := true;
  SELF.DataRestrictionMask := '000000000000010000000000000000' ;  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	SELF.HistoryDateYYYYMM := 999999 ; //IF(histDateYYYYMM=0, le.historydateyyyymm, histDateYYYYMM);
	END;
	
	soap_in := DISTRIBUTE(PROJECT(ds_input_ssnappend, make_rv_in(LEFT, counter)), RANDOM());
	
	

//End added by chad

// op := output(soap_in, named('capital_soap'));

LeadIntegrityoutput := RECORD
	unsigned6 did;
  // models.layouts.layout_LeadIntegrity_attributes_batch ;
	Models.layouts.layout_LeadIntegrity_attributes_batch_flattened;
	STRING errorcode;
END;

LeadIntegrityoutput myFail2(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

// LeadIntegrity_attributes := SOAPCALL(LeadIntegrity_input, roxieIP,
				// 'Models.LeadIntegrity_Batch_Service', {LeadIntegrity_input}, 
				// DATASET(LeadIntegrityoutput),
				// PARALLEL(threads), onFail(myFail2(LEFT)));
				
LeadIntegrity_attributes := SOAPCALL(soap_in, roxieIP,
				'Models.ITA_Batch_Service', {soap_in}, 
				DATASET(LeadIntegrityoutput),
				PARALLEL(threads), onFail(myFail2(LEFT)));				
				
// op1 := output(LeadIntegrity_attributes, named('capital_soap_output'));	


input_lay := RECORD
		// Models.layouts.layout_LeadIntegrity_attributes_batch;
		unsigned6 did;
		Models.layouts.layout_LeadIntegrity_attributes_batch_flattened;
		string errorcode;
END;





input_lay_1:= record

	string20 seq;
  string30 acctno;
	Models.Layouts.layout_LeadIntegrity_attributes_batch_v3;
	string errorcode;
end;

  input_lay_1 v3_trans( input_lay le,unsigned6 c) := TRANSFORM

  	// SELF.did := le.did;
		SELF.seq := (string)c;
		SELF.acctno := le.acctno;
	
		SELF.AgeOldestRecord := le.Version3__AgeOldestRecord;
		SELF.AgeNewestRecord := le.Version3__AgeNewestRecord;
		SELF.SrcsConfirmIDAddrCount := le.Version3__SrcsConfirmIDAddrCount;
		SELF.CreditBureauRecord := le.Version3__CreditBureauRecord;
		SELF.InvalidSSN := le.Version3__InvalidSSN;
		SELF.InvalidPhone := le.Version3__InvalidPhone;
		SELF.InvalidAddr := le.Version3__InvalidAddr;

		SELF.SSNDeceased := le.Version3__SSNDeceased;
		SELF.SSNIssued := le.Version3__SSNIssued;
		SELF.VerificationFailure := le.Version3__VerificationFailure;
		SELF.SSNNotFound := le.Version3__SSNNotFound;
		SELF.SSNFoundOther := le.Version3__SSNFoundOther;
		SELF.PhoneOther := le.Version3__PhoneOther;


		SELF.VerifiedName := le.Version3__VerifiedName;
		SELF.VerifiedSSN := le.Version3__VerifiedSSN;
		SELF.VerifiedPhone := le.Version3__VerifiedPhone;
		SELF.VerifiedPhoneFullName := le.Version3__VerifiedPhoneFullName;
		SELF.VerifiedPhoneLastName := le.Version3__VerifiedPhoneLastName;
		SELF.VerifiedAddress := le.Version3__VerifiedAddress;
		SELF.VerifiedDOB := le.Version3__VerifiedDOB;

		SELF.SubjectSSNCount := le.Version3__SubjectSSNCount;
		SELF.SubjectAddrCount := le.Version3__SubjectAddrCount;
		SELF.SubjectPhoneCount := le.Version3__SubjectPhoneCount;
		SELF.SubjectSSNRecentCount := le.Version3__SubjectSSNRecentCount;
		SELF.SubjectAddrRecentCount := le.Version3__SubjectAddrRecentCount;
		SELF.SubjectPhoneRecentCount := le.Version3__SubjectPhoneRecentCount;
		SELF.SSNIdentitiesCount := le.Version3__SSNIdentitiesCount;
		SELF.SSNAddrCount := le.Version3__SSNAddrCount;
		SELF.SSNIdentitiesRecentCount := le.Version3__SSNIdentitiesRecentCount;
		SELF.SSNAddrRecentCount := le.Version3__SSNAddrRecentCount;
		SELF.InputAddrIdentitiesCount := le.Version3__InputAddrIdentitiesCount;
		SELF.InputAddrSSNCount := le.Version3__InputAddrSSNCount;
		SELF.InputAddrPhoneCount := le.Version3__InputAddrPhoneCount;
		SELF.InputAddrIdentitiesRecentCount := le.Version3__InputAddrIdentitiesRecentCount;
		SELF.InputAddrSSNRecentCount := le.Version3__InputAddrSSNRecentCount;
		SELF.InputAddrPhoneRecentCount := le.Version3__InputAddrPhoneRecentCount;
		SELF.PhoneIdentitiesCount := le.Version3__PhoneIdentitiesCount;
		SELF.PhoneIdentitiesRecentCount := le.Version3__PhoneIdentitiesRecentCount;

		SELF.SSNLastNameCount := le.Version3__SSNLastNameCount;
		SELF.SubjectLastNameCount := le.Version3__SubjectLastNameCount;
		SELF.LastNameChangeCount01 := le.Version3__LastNameChangeCount01;
		SELF.LastNameChangeCount03 := le.Version3__LastNameChangeCount03;
		SELF.LastNameChangeCount06 := le.Version3__LastNameChangeCount06;
		SELF.LastNameChangeCount12 := le.Version3__LastNameChangeCount12;
		SELF.LastNameChangeCount24 := le.Version3__LastNameChangeCount24;
		SELF.LastNameChangeCount36 := le.Version3__LastNameChangeCount36;
		SELF.LastNameChangeCount60 := le.Version3__LastNameChangeCount60;
		SELF.SFDUAddrIdentitiesCount := le.Version3__SFDUAddrIdentitiesCount;
		SELF.SFDUAddrSSNCount := le.Version3__SFDUAddrSSNCount;


		SELF.SSNRecent := le.Version3__SSNRecent;
		SELF.SSNNonUS := le.Version3__SSNNonUS;
		SELF.SSN3Years := le.Version3__SSN3Years;
		SELF.SSNAfter5 := le.Version3__SSNAfter5;
		SELF.SSNIssuedPriorDOB := le.Version3__SSNIssuedPriorDOB;
		SELF.RelativesCount := le.Version3__RelativesCount;
		SELF.RelativesBankruptcyCount := le.Version3__RelativesBankruptcyCount;
		SELF.RelativesFelonyCount := le.Version3__RelativesFelonyCount;
		SELF.RelativesPropOwnedCount := le.Version3__RelativesPropOwnedCount;
		SELF.RelativesPropOwnedTaxTotal := le.Version3__RelativesPropOwnedTaxTotal;
		SELF.RelativesDistanceClosest := le.Version3__RelativesDistanceClosest;
		SELF.InputAddrDwellType := le.Version3__InputAddrDwellType;
		SELF.InputAddrLandUseCode := le.Version3__InputAddrLandUseCode;
		SELF.InputAddrApplicantOwned := le.Version3__InputAddrApplicantOwned;
		SELF.InputAddrFamilyOwned := le.Version3__InputAddrFamilyOwned;
		SELF.InputAddrOccupantOwned := le.Version3__InputAddrOccupantOwned;
		SELF.InputAddrAgeLastSale := le.Version3__InputAddrAgeLastSale;
		SELF.InputAddrNotPrimaryRes := le.Version3__InputAddrNotPrimaryRes;
		SELF.InputAddrActivePhoneList := le.Version3__InputAddrActivePhoneList;
		SELF.CurrAddrDwellType := le.Version3__CurrAddrDwellType;
		SELF.CurrAddrLandUseCode := le.Version3__CurrAddrLandUseCode;
		SELF.CurrAddrApplicantOwned := le.Version3__CurrAddrApplicantOwned;
		SELF.CurrAddrFamilyOwned := le.Version3__CurrAddrFamilyOwned;
		SELF.CurrAddrOccupantOwned := le.Version3__CurrAddrOccupantOwned;
		SELF.CurrAddrAgeLastSale := le.Version3__CurrAddrAgeLastSale;
		SELF.CurrAddrActivePhoneList := le.Version3__CurrAddrActivePhoneList;
		SELF.PrevAddrDwellType := le.Version3__PrevAddrDwellType;
		SELF.PrevAddrLandUseCode := le.Version3__PrevAddrLandUseCode;
		SELF.PrevAddrApplicantOwned := le.Version3__PrevAddrApplicantOwned;
		SELF.PrevAddrFamilyOwned := le.Version3__PrevAddrFamilyOwned;
		SELF.PrevAddrOccupantOwned := le.Version3__PrevAddrOccupantOwned;
		SELF.PrevAddrAgeLastSale := le.Version3__PrevAddrAgeLastSale;
		SELF.PrevAddrActivePhoneList := le.Version3__PrevAddrActivePhoneList;
		SELF.InputCurrAddrMatch := le.Version3__InputCurrAddrMatch;
		SELF.InputCurrAddrStateDiff := le.Version3__InputCurrAddrStateDiff;
		SELF.InputPrevAddrMatch := le.Version3__InputPrevAddrMatch;
		SELF.CurrPrevAddrStateDiff := le.Version3__CurrPrevAddrStateDiff;
		SELF.EducationAttendedCollege := le.Version3__EducationAttendedCollege;
		SELF.EducationProgram2Yr := le.Version3__EducationProgram2Yr;
		SELF.EducationProgram4Yr := le.Version3__EducationProgram4Yr;
		SELF.EducationProgramGraduate := le.Version3__EducationProgramGraduate;
		SELF.EducationInstitutionPrivate := le.Version3__EducationInstitutionPrivate;
		SELF.EducationInstitutionRating := le.Version3__EducationInstitutionRating;
		SELF.EducationFieldofStudyType := le.Version3__EducationFieldofStudyType;
		SELF.StatusMostRecent := le.Version3__StatusMostRecent;
		SELF.StatusPrevious := le.Version3__StatusPrevious;
		SELF.StatusNextPrevious := le.Version3__StatusNextPrevious;

		SELF.AddrChangeCount01 := le.Version3__AddrChangeCount01;
		SELF.AddrChangeCount03 := le.Version3__AddrChangeCount03;
		SELF.AddrChangeCount06 := le.Version3__AddrChangeCount06;
		SELF.AddrChangeCount12 := le.Version3__AddrChangeCount12;
		SELF.AddrChangeCount24 := le.Version3__AddrChangeCount24;
		SELF.AddrChangeCount36 := le.Version3__AddrChangeCount36;
		SELF.AddrChangeCount60 := le.Version3__AddrChangeCount60;
		SELF.PropOwnedCount := le.Version3__PropOwnedCount;
		SELF.PropOwnedHistoricalCount := le.Version3__PropOwnedHistoricalCount;

		SELF.PredictedAnnualIncome := le.Version3__PredictedAnnualIncome;
		SELF.PropAgeOldestPurchase := le.Version3__PropAgeOldestPurchase;
		SELF.PropAgeNewestPurchase := le.Version3__PropAgeNewestPurchase;
		SELF.PropAgeNewestSale := le.Version3__PropAgeNewestSale;

		SELF.PropPurchasedCount01 := le.Version3__PropPurchasedCount01;
		SELF.PropPurchasedCount03 := le.Version3__PropPurchasedCount03;
		SELF.PropPurchasedCount06 := le.Version3__PropPurchasedCount06;
		SELF.PropPurchasedCount12 := le.Version3__PropPurchasedCount12;
		SELF.PropPurchasedCount24 := le.Version3__PropPurchasedCount24;
		SELF.PropPurchasedCount36 := le.Version3__PropPurchasedCount36;
		SELF.PropPurchasedCount60 := le.Version3__PropPurchasedCount60;
		SELF.PropSoldCount01 := le.Version3__PropSoldCount01;
		SELF.PropSoldCount03 := le.Version3__PropSoldCount03;
		SELF.PropSoldCount06 := le.Version3__PropSoldCount06;
		SELF.PropSoldCount12 := le.Version3__PropSoldCount12;
		SELF.PropSoldCount24 := le.Version3__PropSoldCount24;
		SELF.PropSoldCount36 := le.Version3__PropSoldCount36;
		SELF.PropSoldCount60 := le.Version3__PropSoldCount60;
		SELF.WatercraftCount := le.Version3__WatercraftCount;
		SELF.WatercraftCount01 := le.Version3__WatercraftCount01;
		SELF.WatercraftCount03 := le.Version3__WatercraftCount03;
		SELF.WatercraftCount06 := le.Version3__WatercraftCount06;
		SELF.WatercraftCount12 := le.Version3__WatercraftCount12;
		SELF.WatercraftCount24 := le.Version3__WatercraftCount24;
		SELF.WatercraftCount36 := le.Version3__WatercraftCount36;
		SELF.WatercraftCount60 := le.Version3__WatercraftCount60;
		SELF.AircraftCount := le.Version3__AircraftCount;
		SELF.AircraftCount01 := le.Version3__AircraftCount01;
		SELF.AircraftCount03 := le.Version3__AircraftCount03;
		SELF.AircraftCount06 := le.Version3__AircraftCount06;
		SELF.AircraftCount12 := le.Version3__AircraftCount12;
		SELF.AircraftCount24 := le.Version3__AircraftCount24;
		SELF.AircraftCount36 := le.Version3__AircraftCount36;
		SELF.AircraftCount60 := le.Version3__AircraftCount60;
		SELF.DerogCount := le.Version3__DerogCount;
		SELF.FelonyCount := le.Version3__FelonyCount;
		SELF.FelonyCount01 := le.Version3__FelonyCount01;
		SELF.FelonyCount03 := le.Version3__FelonyCount03;
		SELF.FelonyCount06 := le.Version3__FelonyCount06;
		SELF.FelonyCount12 := le.Version3__FelonyCount12;
		SELF.FelonyCount24 := le.Version3__FelonyCount24;
		SELF.FelonyCount36 := le.Version3__FelonyCount36;
		SELF.FelonyCount60 := le.Version3__FelonyCount60;
		SELF.ArrestCount := le.Version3__ArrestCount;
		SELF.ArrestCount01 := le.Version3__ArrestCount01;
		SELF.ArrestCount03 := le.Version3__ArrestCount03;
		SELF.ArrestCount06 := le.Version3__ArrestCount06;
		SELF.ArrestCount12 := le.Version3__ArrestCount12;
		SELF.ArrestCount24 := le.Version3__ArrestCount24;
		SELF.ArrestCount36 := le.Version3__ArrestCount36;
		SELF.ArrestCount60 := le.Version3__ArrestCount60;
		SELF.LienCount := le.Version3__LienCount;
		SELF.LienFiledCount := le.Version3__LienFiledCount;
		SELF.LienFiledCount01 := le.Version3__LienFiledCount01;
		SELF.LienFiledCount03 := le.Version3__LienFiledCount03;
		SELF.LienFiledCount06 := le.Version3__LienFiledCount06;
		SELF.LienFiledCount12 := le.Version3__LienFiledCount12;
		SELF.LienFiledCount24 := le.Version3__LienFiledCount24;
		SELF.LienFiledCount36 := le.Version3__LienFiledCount36;
		SELF.LienFiledCount60 := le.Version3__LienFiledCount60;
		SELF.LienReleasedCount := le.Version3__LienReleasedCount;
		SELF.LienReleasedCount01 := le.Version3__LienReleasedCount01;
		SELF.LienReleasedCount03 := le.Version3__LienReleasedCount03;
		SELF.LienReleasedCount06 := le.Version3__LienReleasedCount06;
		SELF.LienReleasedCount12 := le.Version3__LienReleasedCount12;
		SELF.LienReleasedCount24 := le.Version3__LienReleasedCount24;
		SELF.LienReleasedCount36 := le.Version3__LienReleasedCount36;
		SELF.LienReleasedCount60 := le.Version3__LienReleasedCount60;
		SELF.BankruptcyCount := le.Version3__BankruptcyCount;
		SELF.BankruptcyCount01 := le.Version3__BankruptcyCount01;
		SELF.BankruptcyCount03 := le.Version3__BankruptcyCount03;
		SELF.BankruptcyCount06 := le.Version3__BankruptcyCount06;
		SELF.BankruptcyCount12 := le.Version3__BankruptcyCount12;
		SELF.BankruptcyCount24 := le.Version3__BankruptcyCount24;
		SELF.BankruptcyCount36 := le.Version3__BankruptcyCount36;
		SELF.BankruptcyCount60 := le.Version3__BankruptcyCount60;
		SELF.EvictionCount := le.Version3__EvictionCount;
		SELF.EvictionCount01 := le.Version3__EvictionCount01;
		SELF.EvictionCount03 := le.Version3__EvictionCount03;
		SELF.EvictionCount06 := le.Version3__EvictionCount06;
		SELF.EvictionCount12 := le.Version3__EvictionCount12;
		SELF.EvictionCount24 := le.Version3__EvictionCount24;
		SELF.EvictionCount36 := le.Version3__EvictionCount36;
		SELF.EvictionCount60 := le.Version3__EvictionCount60;
		SELF.NonDerogCount := le.Version3__NonDerogCount;
		SELF.NonDerogCount01 := le.Version3__NonDerogCount01;
		SELF.NonDerogCount03 := le.Version3__NonDerogCount03;
		SELF.NonDerogCount06 := le.Version3__NonDerogCount06;
		SELF.NonDerogCount12 := le.Version3__NonDerogCount12;
		SELF.NonDerogCount24 := le.Version3__NonDerogCount24;
		SELF.NonDerogCount36 := le.Version3__NonDerogCount36;
		SELF.NonDerogCount60 := le.Version3__NonDerogCount60;
		SELF.ProfLicCount := le.Version3__ProfLicCount;
		SELF.ProfLicCount01 := le.Version3__ProfLicCount01;
		SELF.ProfLicCount03 := le.Version3__ProfLicCount03;
		SELF.ProfLicCount06 := le.Version3__ProfLicCount06;
		SELF.ProfLicCount12 := le.Version3__ProfLicCount12;
		SELF.ProfLicCount24 := le.Version3__ProfLicCount24;
		SELF.ProfLicCount36 := le.Version3__ProfLicCount36;
		SELF.ProfLicCount60 := le.Version3__ProfLicCount60;
		SELF.ProfLicExpireCount01 := le.Version3__ProfLicExpireCount01;
		SELF.ProfLicExpireCount03 := le.Version3__ProfLicExpireCount03;
		SELF.ProfLicExpireCount06 := le.Version3__ProfLicExpireCount06;
		SELF.ProfLicExpireCount12 := le.Version3__ProfLicExpireCount12;
		SELF.ProfLicExpireCount24 := le.Version3__ProfLicExpireCount24;
		SELF.ProfLicExpireCount36 := le.Version3__ProfLicExpireCount36;
		SELF.ProfLicExpireCount60 := le.Version3__ProfLicExpireCount60;



		SELF.PropNewestSalePurchaseIndex := le.Version3__PropNewestSalePurchaseIndex;
		SELF.SubPrimeSolicitedCount := le.Version3__SubPrimeSolicitedCount;
		SELF.SubPrimeSolicitedCount01 := le.Version3__SubPrimeSolicitedCount01;
		SELF.SubprimeSolicitedCount03 := le.Version3__SubprimeSolicitedCount03;
		SELF.SubprimeSolicitedCount06 := le.Version3__SubprimeSolicitedCount06;
		SELF.SubPrimeSolicitedCount12 := le.Version3__SubPrimeSolicitedCount12;
		SELF.SubPrimeSolicitedCount24 := le.Version3__SubPrimeSolicitedCount24;
		SELF.SubPrimeSolicitedCount36 := le.Version3__SubPrimeSolicitedCount36;
		SELF.SubPrimeSolicitedCount60 := le.Version3__SubPrimeSolicitedCount60;
		SELF.DerogSeverityIndex := le.Version3__DerogSeverityIndex;
		SELF.DerogAge := le.Version3__DerogAge;
		SELF.FelonyAge := le.Version3__FelonyAge;
		SELF.ArrestAge := le.Version3__ArrestAge;
		SELF.LienFiledAge := le.Version3__LienFiledAge;
		SELF.LienReleasedAge := le.Version3__LienReleasedAge;
		SELF.BankruptcyAge := le.Version3__BankruptcyAge;
		SELF.BankruptcyType := le.Version3__BankruptcyType;
		SELF.EvictionAge := le.Version3__EvictionAge;
		SELF.ProfLicAge := le.Version3__ProfLicAge;
		SELF.ProfLicTypeCategory := le.Version3__ProfLicTypeCategory;
		SELF.PRSearchCollectionCount := le.Version3__PRSearchCollectionCount;
		SELF.PRSearchCollectionCount01 := le.Version3__PRSearchCollectionCount01;
		SELF.PRSearchCollectionCount03 := le.Version3__PRSearchCollectionCount03;
		SELF.PRSearchCollectionCount06 := le.Version3__PRSearchCollectionCount06;
		SELF.PRSearchCollectionCount12 := le.Version3__PRSearchCollectionCount12;
		SELF.PRSearchCollectionCount24 := le.Version3__PRSearchCollectionCount24;
		SELF.PRSearchCollectionCount36 := le.Version3__PRSearchCollectionCount36;
		SELF.PRSearchCollectionCount60 := le.Version3__PRSearchCollectionCount60;
		SELF.PRSearchIDVFraudCount := le.Version3__PRSearchIDVFraudCount;
		SELF.PRSearchIDVFraudCount01 := le.Version3__PRSearchIDVFraudCount01;
		SELF.PRSearchIDVFraudCount03 := le.Version3__PRSearchIDVFraudCount03;
		SELF.PRSearchIDVFraudCount06 := le.Version3__PRSearchIDVFraudCount06;
		SELF.PRSearchIDVFraudCount12 := le.Version3__PRSearchIDVFraudCount12;
		SELF.PRSearchIDVFraudCount24 := le.Version3__PRSearchIDVFraudCount24;
		SELF.PRSearchIDVFraudCount36 := le.Version3__PRSearchIDVFraudCount36;
		SELF.PRSearchIDVFraudCount60 := le.Version3__PRSearchIDVFraudCount60;
		SELF.PRSearchOtherCount := le.Version3__PRSearchOtherCount;
		SELF.PRSearchOtherCount01 := le.Version3__PRSearchOtherCount01;
		SELF.PRSearchOtherCount03 := le.Version3__PRSearchOtherCount03;
		SELF.PRSearchOtherCount06 := le.Version3__PRSearchOtherCount06;
		SELF.PRSearchOtherCount12 := le.Version3__PRSearchOtherCount12;
		SELF.PRSearchOtherCount24 := le.Version3__PRSearchOtherCount24;
		SELF.PRSearchOtherCount36 := le.Version3__PRSearchOtherCount36;
		SELF.PRSearchOtherCount60 := le.Version3__PRSearchOtherCount60;
		SELF.InputPhoneStatus := le.Version3__InputPhoneStatus;
		SELF.InputPhonePager := le.Version3__InputPhonePager;
		SELF.InputPhoneMobile := le.Version3__InputPhoneMobile;
		SELF.InputPhoneType := le.Version3__InputPhoneType;
		SELF.InputAreaCodeChange := le.Version3__InputAreaCodeChange;
		SELF.PhoneOtherAgeOldestRecord := le.Version3__PhoneOtherAgeOldestRecord;
		SELF.PhoneOtherAgeNewestRecord := le.Version3__PhoneOtherAgeNewestRecord;
		SELF.InvalidPhoneZip := le.Version3__InvalidPhoneZip;
		SELF.InputAddrValidation := le.Version3__InputAddrValidation;
		SELF.InputAddrHighRisk := le.Version3__InputAddrHighRisk;
		SELF.InputPhoneHighRisk := le.Version3__InputPhoneHighRisk;
		SELF.InputAddrPrison := le.Version3__InputAddrPrison;
		SELF.CurrAddrPrison := le.Version3__CurrAddrPrison;
		SELF.PrevAddrPrison := le.Version3__PrevAddrPrison;
		SELF.HistoricalAddrPrison := le.Version3__HistoricalAddrPrison;
		SELF.InputZipPOBox := le.Version3__InputZipPOBox;
		SELF.InputZipCorpMil := le.Version3__InputZipCorpMil;
			SELF.errorcode := le.errorcode;
		
		// SELF := le;
		SELF := [];
END;




ds_slim := PROJECT(LeadIntegrity_attributes, v3_trans(LEFT,counter));

//*******************************************************
interalextras_lay := RECORD
	input_lay_1;
	RiskProcessing.layout_internal_extras;
END;


// OUTPUT(CHOOSEN(ds_slim,10), NAMED('ds_slim'));
// OUTPUT(CHOOSEN(adlappendshell,10), NAMED('adlappendshell'));

ds_with_extras := JOIN(ds_slim, adlappendshell, LEFT.acctno = (STRING)RIGHT.Shell_Input.seq,
													TRANSFORM(interalextras_lay,
													SELF.DID := RIGHT.DID;
													SELF.historydate:=(string) RIGHT.historydate;
													SELF.FNamePop:=right.Shell_Input.fname<>'';
													SELF.LNamePop:= right.Shell_Input.lname<>'';
													SELF.AddrPop:= right.Shell_Input.in_streetaddress<>'';
													SELF.SSNLength:= (string)(length(trim(right.Shell_Input.ssn))) ;
													SELF.DOBPop:= right.Shell_Input.dob<>'';
													// SELF.EmailPop;
													// SELF.IPAddrPop;
													SELF.HPhnPop:= right.Shell_Input.phone10<>'';
													SELF := LEFT;
													SELF := []
													));
										
// OUTPUT(CHOOSEN(ds_with_extras,10), NAMED('ds_with_extras'));


	// final_output:=join(res,f,left.acctno=(string)right.accountnumber ,xform1(left, right));		
	
		op_final1 := output(ds_with_extras,, outfile_name,thor,overwrite);

fin_out := sequential( op_final1);


return fin_out;

endmacro;