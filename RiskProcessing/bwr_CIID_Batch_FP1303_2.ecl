#workunit('name','CIID_Batch_FP1303_2');

import ut, Risk_Indicators, riskwise, models;


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
    string COMPANY;
    integer historydateyyyymm;
  END;

// CHANGE TO ZERO TO PROCESS ALL RECORDS IN THE FILE
unsigned8 no_of_records := 5;
unsigned1 eyeball := 100;
string DataRestriction := '00000000000000';

// CHANGE INPUT FILE NAME ACCORDINGLY
infile_name :=  '~jpyon::in::sprint_867_input_f_s_in';
// CHANGE OUTPUT FILE NAME ACCORDINGLY
outfile_name := '~mlwtemp::out::FP1303_2_custFile_IIDBatch_';

ds_input := if(no_of_records = 0 , dataset ( Infile_name, layout_input, csv(quote('"'), heading(1))), choosen(dataset ( Infile_name, layout_input, csv(quote('"'),heading(1))), no_of_records));


in_format := record
	risk_indicators.Layout_Batch_In;
	string6 Gender := '';
	string44 PassportUpperLine := '';
	string44 PassportLowerLine := '';
	STRING5 Grade := '';
	string16 Channel := '';
	string8 Income := '';
	string16 OwnOrRent := '';
	string16 LocationIdentifier := '';
	string16 OtherApplicationIdentifier := '';
	string16 OtherApplicationIdentifier2 := '';
	string16 OtherApplicationIdentifier3 := '';
	string8 DateofApplication := '';
	string8 TimeofApplication := '';
	string50 email := '';
end;

layoutSoap := record
		string orig_account;
		dataset(in_format) batch_in;
		unsigned1 DPPAPurpose := 1;   //CHANGE ACCORDINGLY
		unsigned1 GLBPurpose := 1;    //CHANGE ACCORDINGLY
		STRING5 IndustryClass := '';
		boolean LnBranded  := false;
		boolean OfacOnly := FALSE ;
		unsigned3 HistoryDateYYYYMM := 999999;
		boolean PoBoxCompliance := false;

		boolean ExcludeWatchLists := false;
		unsigned1 OFACversion :=1 ;
		boolean IncludeAdditionalWatchlists := FALSE;
		boolean IncludeOfac := FALSE;
		real GlobalWatchlistThreshold :=.84 ;
		boolean IncludeFraudScores := True;
		boolean IncludeRiskIndices := false ;
		boolean UseDobFilter := FALSE;
		integer2 DobRadius := 2 ;
		unsigned1 RedFlag_version := 0 ;
		boolean RedFlagsOnly := false ;
		string Model := 'fp1303_2' ;
		boolean IncludeTargusE3220 := false ;
		string50 DataRestrictionMask :=   '0000000000000000'; // byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

		boolean ExactFirstNameMatch := false;
		boolean ExactLastNameMatch := false ;
		boolean ExactAddrMatch := false ;
		boolean ExactPhoneMatch := false;
		boolean ExactSSNMatch := false;
		boolean ExactDOBMatch := false ;
		boolean ExactDriverLicenseMatch := false;
		boolean ExactFirstNameMatchAllowNicknames  := false;

		string10 ExactMatchLevel := 	false;
												
		boolean   IncludeAllRiskIndicators := true;
		unsigned1 NumReturnCodes :=  risk_indicators.iid_constants.DefaultNumCodes;

// DOB options
			string15  DOBMatchType := '';
			unsigned1 DOBMatchYearRadius := 0	;
// DOBMatchOptions := dataset([{DOBMatchType, DOBMatchYearRadius}], risk_indicators.layouts.Layout_DOB_Match_Options);


// constants
			boolean suppressNearDups := false;
			boolean require2ele := false;
			boolean fromBiid := false;
			boolean isFCRA := false;
			boolean	nugen := true;
			boolean	inCalif := false;
			boolean	fdReasonsWith38 := false;
			boolean OFAC := true;  // this was previously hardcoded when calling the cviScore, so will do that up here now

			boolean Include_ALL_Watchlist:= false ;
			boolean Include_BES_Watchlist:= false ;
			boolean Include_CFTC_Watchlist:= false ;
			boolean Include_DTC_Watchlist:= false;
			boolean Include_EUDT_Watchlist:= false ;
			boolean Include_FBI_Watchlist:= false ;
			boolean Include_FCEN_Watchlist:= false;
			boolean Include_FAR_Watchlist:= false ;
			boolean Include_IMW_Watchlist:= false;
			boolean Include_OFAC_Watchlist:= false ;
			boolean Include_OCC_Watchlist:= false ;
			boolean Include_OSFI_Watchlist:= false ;
			boolean Include_PEP_Watchlist:= false ;
			boolean Include_SDT_Watchlist:= false;
			boolean Include_BIS_Watchlist:= false ;
			boolean Include_UNNT_Watchlist:= false ;
			boolean Include_WBIF_Watchlist:= false ;
End;

l := RECORD
	STRING old_account_number;
	layoutSoap;
END;



roxieIP := riskwise.shortcuts.prod_batch_analytics_roxie;  //roxie batch


in_format make_batch_in(ds_input le, integer c) := TRANSFORM
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
	self.historydateyyyymm := le.historydateyyyymm;
	SELF := le;
	SELF := [];
END;

layoutSoap make_rv_in(ds_input le, integer c) := TRANSFORM
	self.orig_account := le.account;
	batch := PROJECT(le, make_batch_in(LEFT, c));
		
	SELF.batch_in := batch;
	// SELF.gateways := DATASET([], risk_indicators.layout_gateways_in);
	// SELF.Model := 'fp1303_2' ;
	// self.IncludeFraudScores := True;
	self := le;
	
END;

soap_in := Distribute(PROJECT(ds_input, make_rv_in(LEFT, counter)));

xlayout := RECORD
	(risk_indicators.Layout_InstantID_NuGen_Denorm)
	STRING errorcode;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	// self.seq := (unsigned)le.orig_account;
	SELF := [];
END;

soap_results := soapcall(soap_in, roxieIP,
				'risk_indicators.InstantID_batch', 
				{soap_in}, 
				DATASET(xlayout),
				PARALLEL(1), 
				onFail(myFail(LEFT)));
				

				
output(choosen(soap_results, eyeball), named('soap_results'));
output(choosen(soap_in,eyeball), named('soap_in'));
output(soap_results,,outfile_name, csv(quote('"'), heading(single)), overwrite );





