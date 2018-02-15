EXPORT LI_Attributes_V4_BATCH_Macro (roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

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




// Versions Available: 1, 3 and 4
version := 3;

// new internal fields for debugging, set to false so they are excluded from the layout by default
include_internal_extras := true;

// Boca Shell Version
bocaShellVersion := 4;

// Set to TRUE to run the ADL Based Boca Shell, FALSE to skip it
runADL := TRUE;

//*********custom settings**********

DRM:=Scoring_Project_PIP.User_Settings_Module.LI_Attributes_V4_BATCH_Generic_msn1106_0_settings.DRM;
IncludeVersion4:=if(Scoring_Project_PIP.User_Settings_Module.LI_Attributes_V4_BATCH_Generic_msn1106_0_settings.IncludeVersion4= true,4,3);
isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.LI_Attributes_V4_BATCH_Generic_msn1106_0_settings.isFCRA=true,'FCRA','NONFCRA');

HistoryDate := 999999;

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
// histDateYYYYMM := 0;

//**********************************
/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
prii_layout := RECORD
	STRING AccountNumber;
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
	STRING DLNumber;
	STRING DLState;
	STRING BALANCE; 
	STRING CHARGEOFFD;  
	STRING FormerName;
	STRING EMAIL;  
	STRING COMPANY;
	INTEGER historydateyyyymm;
	unsigned did := 0;
END;

layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
	
f_all := DATASET(infile_name, layout_input,thor);
f := IF(no_of_records = 0, f_all, CHOOSEN(f_all, no_of_records));
// OUTPUT(CHOOSEN(f, eyeball), NAMED('customer_file'));

layout_soap := record
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	string PrimRange;
	string PreDir;
	string Primname;
	string AddrSuffix;
	string PostDir;
	string UnitDesignation;
	string SecRange;
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
	string DataRestrictionMask;
	integer HistoryDateYYYYMM;
	string neutral_gateway := '';	
	dataset(Models.Layout_Score_Chooser) scores;
	
	boolean OfacOnly;
	integer OFACversion;
	boolean IncludeOfac;
	boolean IncludeAdditionalWatchLists;
	real GlobalWatchlistThreshold;
	boolean PoBoxCompliance;
	boolean IncludeMSoverride;
	boolean IncludeCLoverride;
	boolean IncludeDLVerification;
	string44 PassportUpperLine;
	string44 PassportLowerLine;
	string6 Gender;
	integer DOBradius;
  boolean usedobfilter;
	
	boolean ExactFirstNameMatch;
	boolean ExactFirstNameMatchAllowNicknames;
	boolean ExactLastNameMatch;
	boolean ExactPhoneMatch;
	boolean ExactSSNMatch;

	boolean IncludeAllRiskIndicators;
	
	dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions;

end;

l := RECORD
	STRING old_account_number;
	layout_soap;
END;


parms := dataset ([],models.Layout_Parameters);

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := (string)le.AccountNumber;
	SELF.Accountnumber := (STRING)le.AccountNumber;	
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;
	
	self.DataRestrictionMask := DRM;	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

	self.PoBoxCompliance := false;
	self.IncludeMSoverride := false;
	self.IncludeCLoverride := false;
	self.usedobfilter := false;
  self.DOBradius := 2;

	self.OfacOnly := false;
	self.OFACversion := 2;
	self.IncludeOfac := true;
	self.IncludeAdditionalWatchLists := false;
	self.GlobalWatchlistThreshold := 0.84;
	
	self.IncludeDLVerification := false;
	self.PassportUpperLine := '';
	self.PassportLowerLine := '';
	self.Gender := '';
	
self.HistoryDateYYYYMM := HistoryDate;

	self.ExactFirstNameMatch := false;
	self.ExactFirstNameMatchAllowNicknames := false;
	self.ExactLastNameMatch := false;
	self.ExactPhoneMatch := false;
	self.ExactSSNMatch := false;

	self.IncludeAllRiskIndicators := false;
	
	// possible input options 'FuzzyCCYYMMDD','FuzzyCCYYMM''ExactCCYYMMDD''ExactCCYYMM''RadiusCCYY', if using the radius, then 0-3 is the range
	// self.DOBMatchOptions := dataset([{'RadiusCCYY','3'}], risk_indicators.layouts.Layout_DOB_Match_Options);

	SELF := le;
	self := [];
end;

p_f2 := project(f, t_f(left, counter));
//output(p_f2, named('CIID_Input'));

dist_dataset2 := distribute(PROJECT(p_f2,TRANSFORM(layout_soap,SELF := LEFT)), random());

xlayout2 := RECORD
	// (risk_indicators.Layout_InstandID_NuGen)
	STRING30 AcctNo;
// new field:
	unsigned6 did;
	STRING errorcode;
END;

xlayout2 myFail3(dist_dataset2 le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.AcctNo := le.AccountNumber;
	SELF := le;
	SELF := [];
END;

iid_output :=  soapcall(dist_dataset2, roxieIP,
				'risk_indicators.InstantID', {dist_dataset2}, 
				DATASET(xlayout2), RETRY(3), TIMEOUT(120),
				PARALLEL(threads), onFail(myFail3(LEFT)));
 					

//added by Chad
ds_input := IF (no_of_records = 0, f, CHOOSEN (f , no_of_records));

layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	// boolean IncludeVersion4;
	INTEGER Version;
	INTEGER HistoryDateYYYYMM;
	BOOLEAN ADL_Based_Shell;
	
	//BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno := (string)le.accountnumber;
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
	self.historydateyyyymm := HistoryDate ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{isFCRA, roxieIP}], risk_indicators.layout_gateways_in);
	// SELF.IsPreScreen := true;		
	// self.IncludeVersion4 := true;
	SELF.Version := IncludeVersion4;
	SELF.adl_based_shell := true;
  SELF.DataRestrictionMask := DRM;  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
self.HistoryDateYYYYMM := HistoryDate;
	END;
	
	soap_in := distribute(PROJECT(ds_input, make_rv_in(LEFT, counter)), random());

//End added by chad


// Now run the LeadIntegrity attributes
LeadIntegrityoutput := RECORD
	// unsigned6 did;
  // models.layouts.layout_LeadIntegrity_attributes_batch ;
	Models.layouts.layout_LeadIntegrity_attributes_batch_flattened;
	STRING errorcode;
END;

LeadIntegrityoutput myFail2(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno:=le.batch_in[1].acctno;
	SELF := le;
	SELF := [];
END;


				
LeadIntegrity_attributes := SOAPCALL(soap_in, roxieIP,
				'Models.LeadIntegrity_Batch_Service', {soap_in}, 
				DATASET(LeadIntegrityoutput),
				PARALLEL(threads), onFail(myFail2(LEFT)));				
				


		//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout;			 
END;

	Global_output_lay slim_v4( LeadIntegrity_attributes le ) := TRANSFORM
		self.accountnumber := le.acctno ; // original account number not available here...
		SELF.seq := le.Seq; // ...so hang onto the seq

				self.AgeOldestRecord                      	      :=  le.v4_AgeOldestRecord                ; 
				self.AgeNewestRecord                      	      :=  le.v4_AgeNewestRecord                 ; 
				self.RecentUpdate                         	      :=  le.v4_RecentUpdate                   ; 
				self.SrcsConfirmIDAddrCount               	      :=  le.v4_SrcsConfirmIDAddrCount         ;
	  		self.CreditBureauRecord                   	      :=  le.v4_CreditBureauRecord             ;
    		self.VerificationFailure                  	      :=  le.v4_VerificationFailure            ;
	  		self.SSNNotFound                          	      :=  le.v4_SSNNotFound                     ;
    		self.SSNFoundOther                        	      :=  le.v4_SSNFoundOther                   ;
		    self.VerifiedName                         	      :=  le.v4_VerifiedName                    ;
    		self.VerifiedSSN                          	      :=  le.v4_VerifiedSSN                     ;
    		self.VerifiedPhone                        	      :=  le.v4_VerifiedPhone                   ;
    		self.VerifiedAddress                      	      :=  le.v4_VerifiedAddress                 ;
    		self.VerifiedDOB                          	      :=  le.v4_VerifiedDOB                     ;
    		self.AgeRiskIndicator                     	      :=  le.v4_AgeRiskIndicator                ;
    		self.SubjectSSNCount                      	      :=  le.v4_SubjectSSNCount                 ;
    		self.SubjectAddrCount                     	      :=  le.v4_SubjectAddrCount                ;
    		self.SubjectPhoneCount                    	      :=  le.v4_SubjectPhoneCount               ;
    		self.SubjectSSNRecentCount                	      :=  le.v4_SubjectSSNRecentCount           ;
    		self.SubjectAddrRecentCount               	      :=  le.v4_SubjectAddrRecentCount          ;
    		self.SubjectPhoneRecentCount              	      :=  le.v4_SubjectPhoneRecentCount         ;
    		self.SSNIdentitiesCount                   	      :=  le.v4_SSNIdentitiesCount              ;
    		self.SSNAddrCount                         	      :=  le.v4_SSNAddrCount                    ;
    		self.SSNIdentitiesRecentCount             	      :=  le.v4_SSNIdentitiesRecentCount        ;
    		self.SSNAddrRecentCount                   	      :=  le.v4_SSNAddrRecentCount              ;
    		self.InputAddrPhoneCount                  	      :=  le.v4_InputAddrPhoneCount             ;
    		self.InputAddrPhoneRecentCount            	      :=  le.v4_InputAddrPhoneRecentCount       ;
    		self.PhoneIdentitiesCount                 	      :=  le.v4_PhoneIdentitiesCount            ;
    		self.PhoneIdentitiesRecentCount           	      :=  le.v4_PhoneIdentitiesRecentCount      ;
    		self.PhoneOther                           	      :=  le.v4_PhoneOther                      ;
    		self.SSNLastNameCount                     	      :=  le.v4_SSNLastNameCount                ;
    		self.SubjectLastNameCount                 	      :=  le.v4_SubjectLastNameCount            ;
    		self.LastNameChangeAge                    	      :=  le.v4_LastNameChangeAge               ;
    		self.LastNameChangeCount01                	      :=  le.v4_LastNameChangeCount01           ;
    		self.LastNameChangeCount03                	      :=  le.v4_LastNameChangeCount03           ;
    		self.LastNameChangeCount06                	      :=  le.v4_LastNameChangeCount06           ;
    		self.LastNameChangeCount12                	      :=  le.v4_LastNameChangeCount12           ;
    		self.LastNameChangeCount24                	      :=  le.v4_LastNameChangeCount24           ;
    		self.LastNameChangeCount60                	      :=  le.v4_LastNameChangeCount60           ;
    		self.SFDUAddrIdentitiesCount              	      :=  le.v4_SFDUAddrIdentitiesCount         ;
    		self.SFDUAddrSSNCount                     	      :=  le.v4_SFDUAddrSSNCount                ;
    		self.SSNAgeDeceased                       	      :=  le.v4_SSNAgeDeceased                  ;
    		self.SSNRecent                            	      :=  le.v4_SSNRecent                       ;
    		self.SSNLowIssueAge                       	      :=  le.v4_SSNLowIssueAge                  ;
    		self.SSNHighIssueAge                      	      :=  le.v4_SSNHighIssueAge                 ;
    		self.SSNIssueState                        	      :=  le.v4_SSNIssueState                   ;
    		self.SSNNonUS                             	      :=  le.v4_SSNNonUS                        ;
    		self.SSN3Years                            	      :=  le.v4_SSN3Years                       ;
    		self.SSNAfter5                            	      :=  le.v4_SSNAfter5                       ;
    		self.SSNProblems                          	      :=  le.v4_SSNProblems                     ;
    		self.RelativesCount                       	      :=  le.v4_RelativesCount                  ;
    		self.RelativesBankruptcyCount             	      :=  le.v4_RelativesBankruptcyCount        ;
    		self.RelativesFelonyCount                 	      :=  le.v4_RelativesFelonyCount            ;
    		self.RelativesPropOwnedCount              	      :=  le.v4_RelativesPropOwnedCount         ;
    		self.RelativesPropOwnedTaxTotal           	      :=  le.v4_RelativesPropOwnedTaxTotal      ;
    		self.RelativesDistanceClosest             	      :=  le.v4_RelativesDistanceClosest        ;
    		self.InputAddrAgeOldestRecord             	      :=  le.v4_InputAddrAgeOldestRecord        ;
    		self.InputAddrAgeNewestRecord             	      :=  le.v4_InputAddrAgeNewestRecord        ;
    		self.InputAddrHistoricalMatch             	      :=  le.v4_InputAddrHistoricalMatch        ;
    		self.InputAddrLenOfRes                    	      :=  le.v4_InputAddrLenOfRes               ;
    		self.InputAddrDwellType                   	      :=  le.v4_InputAddrDwellType              ;
    		self.InputAddrDelivery                    	      :=  le.v4_InputAddrDelivery               ;
    		self.InputAddrApplicantOwned              	      :=  le.v4_InputAddrApplicantOwned         ;
    		self.InputAddrFamilyOwned                 	      :=  le.v4_InputAddrFamilyOwned            ;
    		self.InputAddrOccupantOwned               	      :=  le.v4_InputAddrOccupantOwned          ;
    		self.InputAddrAgeLastSale                 	      :=  le.v4_InputAddrAgeLastSale           ;
    		self.InputAddrLastSalesPrice              	      :=  le.v4_InputAddrLastSalesPrice         ;
    		self.InputAddrMortgageType                	      :=  le.v4_InputAddrMortgageType           ;
    		self.InputAddrNotPrimaryRes               	      :=  le.v4_InputAddrNotPrimaryRes          ;
    		self.InputAddrActivePhoneList             	      :=  le.v4_InputAddrActivePhoneList        ;
    		self.InputAddrTaxValue                    	      :=  le.v4_InputAddrTaxValue               ;
    		self.InputAddrTaxYr                       	      :=  le.v4_InputAddrTaxYr                  ;
    		self.InputAddrTaxMarketValue              	      :=  le.v4_InputAddrTaxMarketValue         ;
    		self.InputAddrAVMValue                    	      :=  le.v4_InputAddrAVMValue               ;
    		self.InputAddrAVMValue12                  	      :=  le.v4_InputAddrAVMValue12             ;
    		self.InputAddrAVMValue60                  	      :=  le.v4_InputAddrAVMValue60             ;
    		self.InputAddrCountyIndex                 	      :=  le.v4_InputAddrCountyIndex            ;
    		self.InputAddrTractIndex                  	      :=  le.v4_InputAddrTractIndex             ;
    		self.InputAddrBlockIndex                  	      :=  le.v4_InputAddrBlockIndex             ;
    		self.InputAddrMedianIncome                	      :=  le.v4_InputAddrMedianIncome           ;
    		self.InputAddrMedianValue                 	      :=  le.v4_InputAddrMedianValue            ;
    		self.InputAddrMurderIndex                 	      :=  le.v4_InputAddrMurderIndex            ;
    		self.InputAddrCarTheftIndex               	      :=  le.v4_InputAddrCarTheftIndex          ;
    		self.InputAddrBurglaryIndex               	      :=  le.v4_InputAddrBurglaryIndex          ;
    		self.InputAddrCrimeIndex                  	      :=  le.v4_InputAddrCrimeIndex             ;
    		self.InputAddrMobilityIndex               	      :=  le.v4_InputAddrMobilityIndex          ;
    		self.InputAddrVacantPropCount             	      :=  le.v4_InputAddrVacantPropCount        ;
    		self.InputAddrBusinessCount               	      :=  le.v4_InputAddrBusinessCount          ;
    		self.InputAddrSingleFamilyCount           	      :=  le.v4_InputAddrSingleFamilyCount      ;
    		self.InputAddrMultiFamilyCount            	      :=  le.v4_InputAddrMultiFamilyCount       ;
    		self.CurrAddrAgeOldestRecord              	      :=  le.v4_CurrAddrAgeOldestRecord         ;
    		self.CurrAddrAgeNewestRecord              	      :=  le.v4_CurrAddrAgeNewestRecord         ;
    		self.CurrAddrLenOfRes                     	      :=  le.v4_CurrAddrLenOfRes               ;
    		self.CurrAddrDwellType                    	      :=  le.v4_CurrAddrDwellType               ;
    		self.CurrAddrApplicantOwned               	      :=  le.v4_CurrAddrApplicantOwned          ;
    		self.CurrAddrFamilyOwned                  	      :=  le.v4_CurrAddrFamilyOwned             ;
    		self.CurrAddrOccupantOwned                	      :=  le.v4_CurrAddrOccupantOwned           ;
    		self.CurrAddrAgeLastSale                  	      :=  le.v4_CurrAddrAgeLastSale            ;
    		self.CurrAddrLastSalesPrice               	      :=  le.v4_CurrAddrLastSalesPrice          ;
    		self.CurrAddrMortgageType                 	      :=  le.v4_CurrAddrMortgageType            ;
    		self.CurrAddrActivePhoneList              	      :=  le.v4_CurrAddrActivePhoneList         ;
    		self.CurrAddrTaxValue                     	      :=  le.v4_CurrAddrTaxValue                ;
    		self.CurrAddrTaxYr                        	      :=  le.v4_CurrAddrTaxYr                   ;
    		self.CurrAddrTaxMarketValue               	      :=  le.v4_CurrAddrTaxMarketValue          ;
    		self.CurrAddrAVMValue                     	      :=  le.v4_CurrAddrAVMValue                ;
    		self.CurrAddrAVMValue12                   	      :=  le.v4_CurrAddrAVMValue12              ;
    		self.CurrAddrAVMValue60                   	      :=  le.v4_CurrAddrAVMValue60              ;
    		self.CurrAddrCountyIndex                  	      :=  le.v4_CurrAddrCountyIndex             ;
    		self.CurrAddrTractIndex                   	      :=  le.v4_CurrAddrTractIndex              ;
    		self.CurrAddrBlockIndex                   	      :=  le.v4_CurrAddrBlockIndex              ;
    		self.CurrAddrMedianIncome                 	      :=  le.v4_CurrAddrMedianIncome            ;
    		self.CurrAddrMedianValue                  	      :=  le.v4_CurrAddrMedianValue             ;
    		self.CurrAddrMurderIndex                  	      :=  le.v4_CurrAddrMurderIndex             ;
    		self.CurrAddrCarTheftIndex                	      :=  le.v4_CurrAddrCarTheftIndex           ;
    		self.CurrAddrBurglaryIndex                	      :=  le.v4_CurrAddrBurglaryIndex           ;
    		self.CurrAddrCrimeIndex                   	      :=  le.v4_CurrAddrCrimeIndex              ;
    		self.PrevAddrAgeOldestRecord              	      :=  le.v4_PrevAddrAgeOldestRecord         ;
    		self.PrevAddrAgeNewestRecord              	      :=  le.v4_PrevAddrAgeNewestRecord         ;
    		self.PrevAddrLenOfRes                     	      :=  le.v4_PrevAddrLenOfRes                ;
    		self.PrevAddrDwellType                    	      :=  le.v4_PrevAddrDwellType               ;
    		self.PrevAddrApplicantOwned               	      :=  le.v4_PrevAddrApplicantOwned          ;
    		self.PrevAddrFamilyOwned                  	      :=  le.v4_PrevAddrFamilyOwned             ;
    		self.PrevAddrOccupantOwned                	      :=  le.v4_PrevAddrOccupantOwned           ;
    		self.PrevAddrAgeLastSale                  	      :=  le.v4_PrevAddrAgeLastSale            ;
    		self.PrevAddrLastSalesPrice               	      :=  le.v4_PrevAddrLastSalesPrice          ;
    		self.PrevAddrTaxValue                     	      :=  le.v4_PrevAddrTaxValue                ;
    		self.PrevAddrTaxYr                        	      :=  le.v4_PrevAddrTaxYr                   ;
    		self.PrevAddrTaxMarketValue               	      :=  le.v4_PrevAddrTaxMarketValue          ;
    		self.PrevAddrAVMValue                     	      :=  le.v4_PrevAddrAVMValue                ;
    		self.PrevAddrCountyIndex                  	      :=  le.v4_PrevAddrCountyIndex             ;
    		self.PrevAddrTractIndex                   	      :=  le.v4_PrevAddrTractIndex              ;
    		self.PrevAddrBlockIndex                   	      :=  le.v4_PrevAddrBlockIndex              ;
    		self.PrevAddrMedianIncome                 	      :=  le.v4_PrevAddrMedianIncome            ;
    		self.PrevAddrMedianValue                  	      :=  le.v4_PrevAddrMedianValue             ;
    		self.PrevAddrMurderIndex                  	      :=  le.v4_PrevAddrMurderIndex             ;
    		self.PrevAddrCarTheftIndex                	      :=  le.v4_PrevAddrCarTheftIndex           ;
    		self.PrevAddrBurglaryIndex                	      :=  le.v4_PrevAddrBurglaryIndex           ;
    		self.PrevAddrCrimeIndex                   	      :=  le.v4_PrevAddrCrimeIndex              ;
    		self.AddrMostRecentDistance               	      :=  le.v4_AddrMostRecentDistance          ;
    		self.AddrMostRecentStateDiff              	      :=  le.v4_AddrMostRecentStateDiff         ;
    		self.AddrMostRecentTaxDiff                	      :=  le.v4_AddrMostRecentTaxDiff           ;
    		self.AddrMostRecentMoveAge                	      :=  le.v4_AddrMostRecentMoveAge           ;
    		self.AddrMostRecentIncomeDiff             	      :=  le.v4_AddrMostRecentIncomeDiff        ;
    		self.AddrMostRecentValueDIff              	      :=  le.v4_AddrMostRecentValueDIff         ;
    		self.AddrMostRecentCrimeDiff              	      :=  le.v4_AddrMostRecentCrimeDiff         ;
    		self.AddrRecentEconTrajectory             	      :=  le.v4_AddrRecentEconTrajectory        ;
    		self.AddrRecentEconTrajectoryIndex        	      :=  le.v4_AddrRecentEconTrajectoryIndex   ;
    		self.EducationAttendedCollege             	      :=  le.v4_EducationAttendedCollege       ;
    		self.EducationProgram2Yr                  	      :=  le.v4_EducationProgram2Yr             ;
    		self.EducationProgram4Yr                  	      :=  le.v4_EducationProgram4Yr             ;
    		self.EducationProgramGraduate             	      :=  le.v4_EducationProgramGraduate        ;
    		self.EducationInstitutionPrivate          	      :=  le.v4_EducationInstitutionPrivate     ;
    		self.EducationInstitutionRating           	      :=  le.v4_EducationInstitutionRating      ;
    		self.EducationFieldofStudyType            	      :=  le.v4_EducationFieldofStudyType       ;
    		self.AddrStability                        	      :=  le.v4_AddrStability                   ;
    		self.StatusMostRecent                     	      :=  le.v4_StatusMostRecent                ;
    		self.StatusPrevious                       	      :=  le.v4_StatusPrevious                  ;
    		self.StatusNextPrevious                   	      :=  le.v4_StatusNextPrevious              ;
    		self.AddrChangeCount01                    	      :=  le.v4_AddrChangeCount01               ;
    		self.AddrChangeCount03                    	      :=  le.v4_AddrChangeCount03               ;
    		self.AddrChangeCount06                    	      :=  le.v4_AddrChangeCount06               ;
    		self.AddrChangeCount12                    	      :=  le.v4_AddrChangeCount12               ;
    		self.AddrChangeCount24                    	      :=  le.v4_AddrChangeCount24               ;
    		self.AddrChangeCount60                    	      :=  le.v4_AddrChangeCount60               ;
    		self.EstimatedAnnualIncome                	      :=  le.v4_EstimatedAnnualIncome           ;
    		self.AssetOwner                           	      :=  le.v4_AssetOwner                      ;
    		self.PropertyOwner                        	      :=  le.v4_PropertyOwner                   ;
    		self.PropOwnedCount                       	      :=  le.v4_PropOwnedCount                  ;
    		self.PropOwnedTaxTotal                    	      :=  le.v4_PropOwnedTaxTotal               ;
    		self.PropOwnedHistoricalCount             	      :=  le.v4_PropOwnedHistoricalCount        ;
    		self.PropAgeOldestPurchase                	      :=  le.v4_PropAgeOldestPurchase           ;
    		self.PropAgeNewestPurchase                	      :=  le.v4_PropAgeNewestPurchase           ;
    		self.PropAgeNewestSale                    	      :=  le.v4_PropAgeNewestSale             ;
    		self.PropNewestSalePrice                  	      :=  le.v4_PropNewestSalePrice             ;
    		self.PropNewestSalePurchaseIndex          	      :=  le.v4_PropNewestSalePurchaseIndex     ;
    		self.PropPurchasedCount01                 	      :=  le.v4_PropPurchasedCount01            ;
    		self.PropPurchasedCount03                 	      :=  le.v4_PropPurchasedCount03            ;
    		self.PropPurchasedCount06                 	      :=  le.v4_PropPurchasedCount06            ;
    		self.PropPurchasedCount12                 	      :=  le.v4_PropPurchasedCount12            ;
    		self.PropPurchasedCount24                 	      :=  le.v4_PropPurchasedCount24            ;
    		self.PropPurchasedCount60                 	      :=  le.v4_PropPurchasedCount60            ;
    		self.PropSoldCount01                      	      :=  le.v4_PropSoldCount01                 ;
    		self.PropSoldCount03                      	      :=  le.v4_PropSoldCount03                 ;
    		self.PropSoldCount06                      	      :=  le.v4_PropSoldCount06                 ;
    		self.PropSoldCount12                      	      :=  le.v4_PropSoldCount12                 ;
    		self.PropSoldCount24                      	      :=  le.v4_PropSoldCount24                 ;
    		self.PropSoldCount60                      	      :=  le.v4_PropSoldCount60                 ;
    		self.WatercraftOwner                      	      :=  le.v4_WatercraftOwner                 ;
    		self.WatercraftCount                      	      :=  le.v4_WatercraftCount                 ;
    		self.WatercraftCount01                    	      :=  le.v4_WatercraftCount01               ;
    		self.WatercraftCount03                    	      :=  le.v4_WatercraftCount03               ;
    		self.WatercraftCount06                    	      :=  le.v4_WatercraftCount06               ;
    		self.WatercraftCount12                    	      :=  le.v4_WatercraftCount12               ;
    		self.WatercraftCount24                    	      :=  le.v4_WatercraftCount24               ;
    		self.WatercraftCount60                    	      :=  le.v4_WatercraftCount60               ;
    		self.AircraftOwner                        	      :=  le.v4_AircraftOwner                   ;
    		self.AircraftCount                        	      :=  le.v4_AircraftCount                   ;
    		self.AircraftCount01                      	      :=  le.v4_AircraftCount01                 ;
    		self.AircraftCount03                      	      :=  le.v4_AircraftCount03                 ;
    		self.AircraftCount06                      	      :=  le.v4_AircraftCount06                 ;
    		self.AircraftCount12                      	      :=  le.v4_AircraftCount12                 ;
    		self.AircraftCount24                      	      :=  le.v4_AircraftCount24                 ;
    		self.AircraftCount60                      	      :=  le.v4_AircraftCount60                 ;
    		self.WealthIndex                          	      :=  le.v4_WealthIndex                     ;
    		self.BusinessActiveAssociation            	      :=  le.v4_BusinessActiveAssociation       ;
    		self.BusinessInactiveAssociation          	      :=  le.v4_BusinessInactiveAssociation     ;
    		self.BusinessAssociationAge               	      :=  le.v4_BusinessAssociationAge          ;
    		self.BusinessTitle                        	      :=  le.v4_BusinessTitle                  ;
    		self.BusinessInputAddrCount               	      :=  le.v4_BusinessInputAddrCount          ;
    		self.DerogSeverityIndex                   	      :=  le.v4_DerogSeverityIndex              ;
    		self.DerogCount                           	      :=  le.v4_DerogCount                      ;
    		self.DerogRecentCount                     	      :=  le.v4_DerogRecentCount                ;
    		self.DerogAge                             	      :=  le.v4_DerogAge                        ;
    		self.FelonyCount                          	      :=  le.v4_FelonyCount                     ;
    		self.FelonyAge                            	      :=  le.v4_FelonyAge                       ;
    		self.FelonyCount01                        	      :=  le.v4_FelonyCount01                   ;
    		self.FelonyCount03                        	      :=  le.v4_FelonyCount03                   ;
    		self.FelonyCount06                        	      :=  le.v4_FelonyCount06                   ;
    		self.FelonyCount12                        	      :=  le.v4_FelonyCount12                   ;
    		self.FelonyCount24                        	      :=  le.v4_FelonyCount24                   ;
    		self.FelonyCount60                        	      :=  le.v4_FelonyCount60                   ;
    		self.ArrestCount                          	      :=  le.v4_ArrestCount                     ;
    		self.ArrestAge                            	      :=  le.v4_ArrestAge                       ;
    		self.ArrestCount01                        	      :=  le.v4_ArrestCount01                   ;
    		self.ArrestCount03                        	      :=  le.v4_ArrestCount03                   ;
    		self.ArrestCount06                        	      :=  le.v4_ArrestCount06                   ;
    		self.ArrestCount12                        	      :=  le.v4_ArrestCount12                   ;
    		self.ArrestCount24                        	      :=  le.v4_ArrestCount24                   ;
    		self.ArrestCount60                        	      :=  le.v4_ArrestCount60                   ;
    		self.LienCount                            	      :=  le.v4_LienCount                       ;
    		self.LienFiledCount                       	      :=  le.v4_LienFiledCount                  ;
    		self.LienFiledTotal                       	      :=  le.v4_LienFiledTotal                  ;
    		self.LienFiledAge                         	      :=  le.v4_LienFiledAge                    ;
    		self.LienFiledCount01                     	      :=  le.v4_LienFiledCount01                ;
    		self.LienFiledCount03                     	      :=  le.v4_LienFiledCount03                ;
    		self.LienFiledCount06                     	      :=  le.v4_LienFiledCount06                ;
    		self.LienFiledCount12                     	      :=  le.v4_LienFiledCount12                ;
    		self.LienFiledCount24                     	      :=  le.v4_LienFiledCount24                ;
    		self.LienFiledCount60                     	      :=  le.v4_LienFiledCount60                ;
    		self.LienReleasedCount                    	      :=  le.v4_LienReleasedCount               ;
    		self.LienReleasedTotal                    	      :=  le.v4_LienReleasedTotal               ;
    		self.LienReleasedAge                      	      :=  le.v4_LienReleasedAge                 ;
    		self.LienReleasedCount01                  	      :=  le.v4_LienReleasedCount01             ;
    		self.LienReleasedCount03                  	      :=  le.v4_LienReleasedCount03             ;
    		self.LienReleasedCount06                  	      :=  le.v4_LienReleasedCount06             ;
    		self.LienReleasedCount12                  	      :=  le.v4_LienReleasedCount12             ;
    		self.LienReleasedCount24                  	      :=  le.v4_LienReleasedCount24             ;
    		self.LienReleasedCount60                  	      :=  le.v4_LienReleasedCount60             ;
    		self.BankruptcyCount                      	      :=  le.v4_BankruptcyCount                 ;
    		self.BankruptcyAge                        	      :=  le.v4_BankruptcyAge                   ;
    		self.BankruptcyType                       	      :=  le.v4_BankruptcyType                  ;
    		self.BankruptcyStatus                     	      :=  le.v4_BankruptcyStatus                ;
    		self.BankruptcyCount01                    	      :=  le.v4_BankruptcyCount01               ;
    		self.BankruptcyCount03                    	      :=  le.v4_BankruptcyCount03               ;
    		self.BankruptcyCount06                    	      :=  le.v4_BankruptcyCount06               ;
    		self.BankruptcyCount12                    	      :=  le.v4_BankruptcyCount12               ;
    		self.BankruptcyCount24                    	      :=  le.v4_BankruptcyCount24               ;
    		self.BankruptcyCount60                    	      :=  le.v4_BankruptcyCount60               ;
    		self.EvictionCount                        	      :=  le.v4_EvictionCount                   ;
    		self.EvictionAge                          	      :=  le.v4_EvictionAge                     ;
    		self.EvictionCount01                      	      :=  le.v4_EvictionCount01                 ;
    		self.EvictionCount03                      	      :=  le.v4_EvictionCount03                 ;
    		self.EvictionCount06                      	      :=  le.v4_EvictionCount06                 ;
    		self.EvictionCount12                      	      :=  le.v4_EvictionCount12                 ;
    		self.EvictionCount24                      	      :=  le.v4_EvictionCount24                 ;
    		self.EvictionCount60                      	      :=  le.v4_EvictionCount60                 ;
    		self.AccidentCount                        	      :=  le.v4_AccidentCount                   ;
    		self.AccidentAge                          	      :=  le.v4_AccidentAge                     ;
    		self.RecentActivityIndex                  	      :=  le.v4_RecentActivityIndex             ;
    		self.NonDerogCount                        	      :=  le.v4_NonDerogCount                   ;
    		self.NonDerogCount01                      	      :=  le.v4_NonDerogCount01                 ;
    		self.NonDerogCount03                      	      :=  le.v4_NonDerogCount03                 ;
    		self.NonDerogCount06                      	      :=  le.v4_NonDerogCount06                 ;
    		self.NonDerogCount12                      	      :=  le.v4_NonDerogCount12                 ;
    		self.NonDerogCount24                      	      :=  le.v4_NonDerogCount24                 ;
    		self.NonDerogCount60                      	      :=  le.v4_NonDerogCount60                 ;
    		self.VoterRegistrationRecord              	      :=  le.v4_VoterRegistrationRecord         ;
    		self.ProfLicCount                         	      :=  le.v4_ProfLicCount                    ;
    		self.ProfLicAge                           	      :=  le.v4_ProfLicAge                      ;
    		self.ProfLicTypeCategory                  	      :=  le.v4_ProfLicTypeCategory             ;
    		self.ProfLicExpired                       	      :=  le.v4_ProfLicExpired                  ;
    		self.ProfLicCount01                       	      :=  le.v4_ProfLicCount01                  ;
    		self.ProfLicCount03                       	      :=  le.v4_ProfLicCount03                  ;
    		self.ProfLicCount06                       	      :=  le.v4_ProfLicCount06                  ;
    		self.ProfLicCount12                       	      :=  le.v4_ProfLicCount12                  ;
    		self.ProfLicCount24                       	      :=  le.v4_ProfLicCount24                  ;
    		self.ProfLicCount60                       	      :=  le.v4_ProfLicCount60                  ;
    		self.PRSearchLocateCount                  	      :=  le.v4_PRSearchLocateCount             ;
    		self.PRSearchLocateCount01                	      :=  le.v4_PRSearchLocateCount01           ;
    		self.PRSearchLocateCount03                	      :=  le.v4_PRSearchLocateCount03           ;
    		self.PRSearchLocateCount06                	      :=  le.v4_PRSearchLocateCount06           ;
    		self.PRSearchLocateCount12                	      :=  le.v4_PRSearchLocateCount12           ;
    		self.PRSearchLocateCount24                	      :=  le.v4_PRSearchLocateCount24           ;
    		self.PRSearchPersonalFinanceCount         	      :=  le.v4_PRSearchPersonalFinanceCount    ;
    		self.PRSearchPersonalFinanceCount01       	      :=  le.v4_PRSearchPersonalFinanceCount01  ;
    		self.PRSearchPersonalFinanceCount03       	      :=  le.v4_PRSearchPersonalFinanceCount03  ;
    		self.PRSearchPersonalFinanceCount06       	      :=  le.v4_PRSearchPersonalFinanceCount06  ;
    		self.PRSearchPersonalFinanceCount12       	      :=  le.v4_PRSearchPersonalFinanceCount12  ;
    		self.PRSearchPersonalFinanceCount24       	      :=  le.v4_PRSearchPersonalFinanceCount24  ;
    		self.PRSearchOtherCount                   	      :=  le.v4_PRSearchOtherCount              ;
    		self.PRSearchOtherCount01                 	      :=  le.v4_PRSearchOtherCount01            ;
    		self.PRSearchOtherCount03                 	      :=  le.v4_PRSearchOtherCount03            ;
    		self.PRSearchOtherCount06                 	      :=  le.v4_PRSearchOtherCount06            ;
    		self.PRSearchOtherCount12                 	      :=  le.v4_PRSearchOtherCount12            ;
    		self.PRSearchOtherCount24                 	      :=  le.v4_PRSearchOtherCount24            ;
    		self.PRSearchIdentitySSNs                 	      :=  le.v4_PRSearchIdentitySSNs            ;
    		self.PRSearchIdentityAddrs                	      :=  le.v4_PRSearchIdentityAddrs           ;
    		self.PRSearchIdentityPhones               	      :=  le.v4_PRSearchIdentityPhones          ;
    		self.PRSearchSSNIdentities                	      :=  le.v4_PRSearchSSNIdentities           ;
    		self.PRSearchAddrIdentities               	      :=  le.v4_PRSearchAddrIdentities          ;
    		self.PRSearchPhoneIdentities              	      :=  le.v4_PRSearchPhoneIdentities         ;
    		self.SubPrimeOfferRequestCount            	      :=  le.v4_SubPrimeOfferRequestCount       ;
    		self.SubPrimeOfferRequestCount01          	      :=  le.v4_SubPrimeOfferRequestCount01     ;
    		self.SubPrimeOfferRequestCount03          	      :=  le.v4_SubPrimeOfferRequestCount03     ;
    		self.SubPrimeOfferRequestCount06          	      :=  le.v4_SubPrimeOfferRequestCount06     ;
    		self.SubPrimeOfferRequestCount12          	      :=  le.v4_SubPrimeOfferRequestCount12     ;
    		self.SubPrimeOfferRequestCount24          	      :=  le.v4_SubPrimeOfferRequestCount24     ;
    		self.SubPrimeOfferRequestCount60          	      :=  le.v4_SubPrimeOfferRequestCount60     ;
    		self.InputPhoneMobile                     	      :=  le.v4_InputPhoneMobile              ;
    		self.InputPhoneType                       	      :=  le.v4_InputPhoneType                  ;
    		self.InputPhoneServiceType                	      :=  le.v4_InputPhoneServiceType           ;
    		self.InputAreaCodeChange                  	      :=  le.v4_InputAreaCodeChange             ;
    		self.PhoneEDAAgeOldestRecord              	      :=  le.v4_PhoneEDAAgeOldestRecord         ;
    		self.PhoneEDAAgeNewestRecord              	      :=  le.v4_PhoneEDAAgeNewestRecord         ;
    		self.PhoneOtherAgeOldestRecord            	      :=  le.v4_PhoneOtherAgeOldestRecord       ;
    		self.PhoneOtherAgeNewestRecord            	      :=  le.v4_PhoneOtherAgeNewestRecord       ;
    		self.InputPhoneHighRisk                   	      :=  le.v4_InputPhoneHighRisk              ;
    		self.InputPhoneProblems                   	      :=  le.v4_InputPhoneProblems             ;
    		self.OnlineDirectory                      	      :=  le.v4_OnlineDirectory                 ;
    		self.InputAddrSICCode                     	      :=  le.v4_InputAddrSICCode                ;
    		self.InputAddrValidation                  	      :=  le.v4_InputAddrValidation             ;
    		self.InputAddrErrorCode                   	      :=  le.v4_InputAddrErrorCode              ;
    		self.InputAddrHighRisk                    	      :=  le.v4_InputAddrHighRisk               ;
    		self.CurrAddrCorrectional                 	      :=  le.v4_CurrAddrCorrectional            ;
    		self.PrevAddrCorrectional                 	      :=  le.v4_PrevAddrCorrectional            ;
    		self.HistoricalAddrCorrectional           	      :=  le.v4_HistoricalAddrCorrectional      ;
    		self.InputAddrProblems                    	      :=  le.v4_InputAddrProblems               ;
    		self.DoNotMail                            	      :=  le.v4_DoNotMail                       ;
    		// 4.1 Attributes (Part of 4.0)			      // 4.1 Attributes (Part of 4.0) ;
    		SELF.IdentityRiskLevel                    	      :=  le.v4_IdentityRisklevel               ;
    		SELF.IDVerRiskLevel                       	      :=  le.v4_IDVerRisklevel                  ;
    		SELF.IDVerAddressAssocCount 			      :=  le.v4_IDVerAddressAssocCount 		 ;
    		SELF.IDVerSSNCreditBureauCount 			      :=  le.v4_IDVerSSNCreditBureauCount 		 ;
    		SELF.IDVerSSNCreditBureauDelete 		      :=  le.v4_IDVerSSNCreditBureauDelete 	 ;
    		SELF.SourceRiskLevel 				      :=  le.v4_SourceRisklevel 			 ;
    		SELF.SourceWatchList 				      :=  le.v4_SourceWatchList 			 ;
    		SELF.SourceOrderActivity 			      :=  le.v4_SourceOrderActivity 		 ;
    		SELF.SourceOrderSourceCount 			      :=  le.v4_SourceOrderSourceCount 		 ;
    		SELF.SourceOrderAgeLastOrder 			      :=  le.v4_SourceOrderAgeLastOrder 		 ;
    		SELF.VariationRiskLevel 			      :=  le.v4_VariationRisklevel 		 ;
    		SELF.VariationIdentityCount 			      :=  le.v4_VariationIdentityCount 		 ;
    		SELF.VariationMSourcesSSNCount 			      :=  le.v4_VariationMSourcesSSNCount 		 ;
    		SELF.VariationMSourcesSSNUnrelCount 		      :=  le.v4_VariationMSourcesSSNUnrelCount  ;
    		SELF.VariationDOBCount 				      :=  le.v4_VariationDOBCount 			 ;
    		SELF.VariationDOBCountNew 			      :=  le.v4_VariationDOBCountNew 		 ;
    		SELF.SearchVelocityRiskLevel 			      :=  le.v4_SearchVelocityRisklevel 		 ;
    		SELF.SearchUnverifiedSSNCountYear 		      :=  le.v4_SearchUnverifiedSSNCountYear  ;
    		SELF.SearchUnverifiedAddrCountYear 		      :=  le.v4_SearchUnverifiedAddrCountYear  ;
    		SELF.SearchUnverifiedDOBCountYear 		      :=  le.v4_SearchUnverifiedDOBCountYear  ;
    		SELF.SearchUnverifiedPhoneCountYear 		      :=  le.v4_SearchUnverifiedPhoneCountYear  ;
    		SELF.AssocRiskLevel 				      :=  le.v4_AssocRisklevel 			 ;
    		SELF.AssocSuspicousIdentitiesCount 		      :=  le.v4_AssocSuspicousIdentitiesCount  ;
    		SELF.AssocCreditBureauOnlyCount 		      :=  le.v4_AssocCreditBureauOnlyCount 	 ;
    		SELF.AssocCreditBureauOnlyCountNew 		      :=  le.v4_AssocCreditBureauOnlyCountNew  ;
    		SELF.AssocCreditBureauOnlyCountMonth 		      :=  le.v4_AssocCreditBureauOnlyCountMonth ;
    		SELF.AssocHighRiskTopologyCount 		      :=  le.v4_AssocHighRiskTopologyCount 	 ;
    		SELF.ValidationRiskLevel 			      :=  le.v4_ValidationRisklevel 		 ;
    		SELF.CorrelationRiskLevel 			      :=  le.v4_CorrelationRisklevel 		 ;
    		SELF.DivRiskLevel 				      :=  le.v4_DivRisklevel 			 ;
    		SELF.DivSSNIdentityMSourceCount 		      :=  le.v4_DivSSNIdentityMSourceCount 	 ;
    		SELF.DivSSNIdentityMSourceUrelCount 		      :=  le.v4_DivSSNIdentityMSourceUrelCount  ;
    		SELF.DivSSNLNameCountNew 			      :=  le.v4_DivSSNLNameCountNew 		 ;
    		SELF.DivSSNAddrMSourceCount 			      :=  le.v4_DivSSNAddrMSourceCount 		 ;
    		SELF.DivAddrIdentityCount 			      :=  le.v4_DivAddrIdentityCount 		 ;
    		SELF.DivAddrIdentityCountNew 			      :=  le.v4_DivAddrIdentityCountNew 		 ;
    		SELF.DivAddrIdentityMSourceCount 		      :=  le.v4_DivAddrIdentityMSourceCount  ;
    		SELF.DivAddrSuspIdentityCountNew 		      :=  le.v4_DivAddrSuspIdentityCountNew  ;
    		SELF.DivAddrSSNCount 				      :=  le.v4_DivAddrSSNCount 			 ;
    		SELF.DivAddrSSNCountNew 			      :=  le.v4_DivAddrSSNCountNew 		 ;
    		SELF.DivAddrSSNMSourceCount 			      :=  le.v4_DivAddrSSNMSourceCount 		 ;
    		SELF.DivSearchAddrSuspIdentityCount 		      :=  le.v4_DivSearchAddrSuspIdentityCount  ;
    		SELF.SearchComponentRiskLevel 			      :=  le.v4_SearchComponentRisklevel 		 ;
    		SELF.SearchSSNSearchCount 			      :=  le.v4_SearchSSNSearchCount 		 ;
    		SELF.SearchAddrSearchCount 			      :=  le.v4_SearchAddrSearchCount 		 ;
    		SELF.SearchPhoneSearchCount 			      :=  le.v4_SearchPhoneSearchCount 		 ;
    		SELF.ComponentCharRiskLevel 			      :=  le.v4_ComponentCharRisklevel 		 ;
			  SELF.errorcode := le.errorcode; 
				
						  self := [];
		 
	END;

	slim_attr := project( LeadIntegrity_attributes, slim_v4(left) );
	

/* did_append_lay := RECORD
   	recordof(slim_attr);
   		unsigned6 did;
   	// RiskProcessing.layout_internal_extras;
   END;
*/


did_append_ds:=JOIN(slim_attr, iid_output, LEFT.accountnumber = (STRING)RIGHT.AcctNo,
   													TRANSFORM(Global_output_lay,
   													SELF.DID := RIGHT.DID;   									
   													SELF := LEFT;   						
   													), left outer);
// interalextras_lay := RECORD
	// recordof(slim_attr);		
	// RiskProcessing.layout_internal_extras;
// END;
 ds_with_extras := JOIN(did_append_ds, soap_in, LEFT.accountnumber = (STRING)RIGHT.batch_in[1].acctno,
   													TRANSFORM(Global_output_lay,
   												  self.historydate := (string)right.batch_in[1].HistoryDateYYYYMM;
				                    self.FNamePop := right.batch_in[1].Name_First<>'';
			                     	self.LNamePop := right.batch_in[1].Name_Last<>'';
				                    self.AddrPop := right.batch_in[1].street_addr<>'';
			                    	self.SSNLength := (string)(length(trim(right.batch_in[1].ssn,left,right))) ;
			                    	self.DOBPop := right.batch_in[1].dob<>'';
	                      			// self.EmailPop := right.batch_in[1].email<>'';
			                     	self.IPAddrPop := right.batch_in[1].ip_addr<>''; 
			                    	self.HPhnPop := right.batch_in[1].Home_Phone<>'';
   													   SELF := LEFT;
   												   	 SELF := []
   													));


	
	
	op_final := output(ds_with_extras,, outfile_name, thor,compressed, OVERWRITE);

return op_final;

endmacro;