EXPORT Insurview_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

import risk_indicators, riskwise, ut, iesp,  iss, scoring_project_PIP, gateway, RiskProcessing, models, STD ;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 100;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String neutralroxieIP := neutralroxie_IP ; 
		String fcraroxieIP := fcraroxie_IP ;
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;
		
		
		dt1_1 := ut.getdate;
		// dt1_1 := c_file_name1[length(c_file_name1)-9.. length(c_file_name1)-2];

		// PCG_Dev := 'http://delta_dempers_dev:g0n0l3s!@10.176.68.149:7720/WsSupport/?ver_=2.0'; //-- testing on DEV servers
		// PCG_Cert := 'http://ln_api_dempsey_dev:g0n0l3s!@10.176.68.149:7720/WsSupport/?ver_=2.0'; //-- testing on DEV servers
		// integer FFD := 1;	

		//*********** SETTINGS ********************************

		DPM:=Scoring_Project_PIP.User_Settings_Module.Insurview_FCRA_settings.DPM;
		DRM:=Scoring_Project_PIP.User_Settings_Module.Insurview_FCRA_settings.DRM;

			
		//*****************************************************

	  // ************** INPUT FILE GENERATION ****************	

		layout_input := RECORD
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
  string dpm;
  string other2;
  string other3;
  string other4;
		END;

		ds_raw_input := distribute(IF(no_of_records = 0, dataset( Infile_name, layout_input,  thor), ChooseN(dataset( infile_name, layout_input,  thor), no_of_records)), (integer)accountnumber);


// ds_raw_input := IF(no_of_records = 0, dataset( Infile_name, layout_input,  thor), ChooseN(dataset( infile_name, layout_input,  thor), no_of_records));
Input := distribute(IF(no_of_records <= 0, DATASET(Input_file_name, layout_input, thor),
                            CHOOSEN(DATASET(Input_file_name, layout_input,thor), no_of_records)), (integer)accountnumber);

layout_input Getseq(layout_input le, integer c) := transform
	self.accountnumber := c;
	self.placeholder_1 := (string) le.accountnumber;
	self := le;
end;

SeqInput := PROJECT(Input, Getseq(LEFT, COUNTER));


// output(SeqInput, named('SeqInput'));


	//iss.FcraInsurView_Service
soapLayout := RECORD
	DATASET(iesp.fcrainsurviewattributes.t_FCRAInsurViewAttributesRequest) FCRAInsurViewAttributesRequest := DATASET([], iesp.fcrainsurviewattributes.t_FCRAInsurViewAttributesRequest);
	INTEGER HistoryDateYYYYMM := 999999;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
END;


soapLayout intoSOAP(Input le, UNSIGNED4 c) := TRANSFORM

	SearchBy := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.fcrainsurviewattributes.t_FCRAInsurViewAttributesSearchBy,
						SELF.Name.first  := LE.firstname;
						SELF.Name.middle  := LE.middlename;
						SELF.Name.Last  := le.lastname;
						SELF.Address.StreetAddress1 := (trim(le.streetaddress));
						SELF.Address.city := le.city;
						SELF.Address.State := le.State;
						SELF.Address.Zip5 := le.Zip;
						self.Email := le.email;
						self.HomePhone  := le.homephone;
						self.WorkPhone  := le.workphone;
						self.DriverLicenseNumber  := le.DLnumber;
						self.DriverLicenseState  := le.DLstate;
						self.SSN  := le.ssn;
						//self.IPAddress := if(le.ipaddress != '', le.ipaddress, ''); //pOPULATE FOR NET ACUITY
						self.DOB.Year := (integer)le.dateofbirth[1..4];
						SELF.DOB.Month := (integer)le.dateofbirth[5..6];
						SELF.DOB.Day := (integer)le.dateofbirth[7..8];
						SELF := []))[1];
	
	option := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.fcrainsurviewattributes.t_FCRAInsurViewAttributesOptions,
						SELF.IntendedPurpose := '';					
						SELF.RequestedAttributeGroups := dataset([{'version4'}], iesp.share.t_StringArrayItem);			
						// self.FFDOptionsMask := (string)FFD;

						SELF := []));
	
	users := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User,
						SELF.DataRestrictionMask := DRM;
						SELF.DataPermissionMask := DPM;
						SELF.AccountNumber := (string) le.accountnumber;
						// SELF.GLBPurpose := (string)glba;
						// SELF.DLPurpose := (string) dppa;
						SELF.TestDataEnabled := FALSE;
						SELF.OutcomeTrackingOptOut := TRUE;
						SELF := []));
	
	SELF.FCRAInsurViewAttributesRequest := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.fcrainsurviewattributes.t_FCRAInsurViewAttributesRequest, 
						SELF.SearchBy := SearchBy;			
						SELF.Options := option[1];
						SELF.User := users[1];
						SELF := []));

  self.HistoryDateYYYYMM := (unsigned) le.historydateyyyymm;
	SELF.Gateways := riskwise.shortcuts.gw_FCRA;
	// SELF.Gateways := DATASET([{'neutralroxie', NeutralRoxieIP}, // TransUnion Gateway
					// {'delta_personcontext', PCG_Dev}], Risk_Indicators.Layout_Gateways_In);
END;
soapInput := PROJECT(SeqInput, intoSOAP(LEFT, COUNTER));//DISTRIBUTE(PROJECT(Input, intoSOAP(LEFT, COUNTER)), RANDOM());


xlayout := RECORD
		ISS.FCRAInsurView_Layouts.FCRAInsurViewAttributesResponseWAcct;
	STRING errorcode;
END;

xlayout myFail(soapInput le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	
	SELF := [];
END;

// OUTPUT(CHOOSEN(soapInput, eyeball), NAMED('Sample_SOAP_Input'));

soapResults_raw := SOAPCALL(soapInput, 
				fcra_roxieIP,
				'ISS.FcraInsurView_Service', 
				{soapInput}, 
				DATASET(xlayout),
        RETRY(5), TIMEOUT(500), //literal,
        XPATH('ISS.FcraInsurView_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

soap_Results := soapResults_raw(errorcode='');  // filter out the intermediate logging rows from the response


xlayoutSeq := RECORD
	ISS.FCRAInsurView_Layouts.FCRAInsurViewAttributesResponseWAcct.Accountnumber;
							STRING errorcode;
							integer seq;
							string ssn;
            	string3 AgeOldestRecord                               ;
            	string3 AgeNewestRecord                               ;
            	string1 RecentUpdate                                  ;
            	string3 SrcsConfirmIDAddrCount                        ;
            	string2 InvalidDL                                     ;
            	string1 VerificationFailure                           ;
            	string2 SSNNotFound                                   ;
            	string1 VerifiedName                                  ;
            	string2 VerifiedSSN                                   ;
            	string2 VerifiedPhone                                 ;
            	string2 VerifiedAddress                               ;
            	string2 VerifiedDOB                                   ;
            	string3 InferredMinimumAge                            ;
            	string3 BestReportedAge                               ;
            	string3 SubjectSSNCount                               ;
            	string3 SubjectAddrCount                              ;
            	string3 SubjectPhoneCount                             ;
            	string3 SubjectSSNRecentCount                         ;
            	string3 SubjectAddrRecentCount                        ;
            	string3 SubjectPhoneRecentCount                       ;
            	string3 SSNIdentitiesCount                            ;
            	string3 SSNAddrCount                                  ;
            	string3 SSNIdentitiesRecentCount                      ;
            	string3 SSNAddrRecentCount                            ;
            	string3 InputAddrPhoneCount                           ;
            	string3 InputAddrPhoneRecentCount                     ;
            	string3 PhoneIdentitiesCount                          ;
            	string3 PhoneIdentitiesRecentCount                    ;
            	string3 SSNAgeDeceased                                ;
            	string2 SSNRecent                                     ;
            	string3 SSNLowIssueAge                                ;
            	string3 SSNHighIssueAge                               ;
            	string2 SSNIssueState                                 ;
            	string2 SSNNonUS                                      ;
            	string2 SSN3Years                                     ;
            	string2 SSNAfter5                                     ;
            	string2 SSNProblems                                   ;
            	string3 InputAddrAgeOldestRecord                      ;
            	string3 InputAddrAgeNewestRecord                      ;
            	string2 InputAddrHistoricalMatch                      ;
            	string3 InputAddrLenOfRes                             ;
            	string2 InputAddrDwellType                            ;
            	string2 InputAddrDelivery                             ;
            	string2 InputAddrApplicantOwned                       ;
            	string2 InputAddrFamilyOwned                          ;
            	string2 InputAddrOccupantOwned                        ;
            	string3 InputAddrAgeLastSale                          ;
            	string10 InputAddrLastSalesPrice                      ;
            	string2 InputAddrMortgageType                         ;
            	string2 InputAddrNotPrimaryRes                        ;
            	string2 InputAddrActivePhoneList                      ;
            	string10 InputAddrTaxValue                            ;
            	string4 InputAddrTaxYr                                ;
            	string10 InputAddrTaxMarketValue                      ;
            	string10 InputAddrAVMValue                            ;
            	string10 InputAddrAVMValue12                          ;
            	string10 InputAddrAVMValue60                          ;
            	string5 InputAddrCountyIndex                          ;
            	string5 InputAddrTractIndex                           ;
            	string5 InputAddrBlockIndex                           ;
            	string3 CurrAddrAgeOldestRecord                       ;
            	string3 CurrAddrAgeNewestRecord                       ;
            	string3 CurrAddrLenOfRes                              ;
            	string2 CurrAddrDwellType                             ;
            	string2 CurrAddrApplicantOwned                        ;
            	string2 CurrAddrFamilyOwned                           ;
            	string2 CurrAddrOccupantOwned                         ;
            	string3 CurrAddrAgeLastSale                           ;
            	string10 CurrAddrLastSalesPrice                       ;
            	string2 CurrAddrMortgageType                          ;
            	string2 CurrAddrActivePhoneList                       ;
            	string10 CurrAddrTaxValue                             ;
            	string4 CurrAddrTaxYr                                 ;
            	string10 CurrAddrTaxMarketValue                       ;
            	string10 CurrAddrAVMValue                             ;
            	string10 CurrAddrAVMValue12                           ;
            	string10 CurrAddrAVMValue60                           ;
            	string5 CurrAddrCountyIndex                           ;
            	string5 CurrAddrTractIndex                            ;
            	string5 CurrAddrBlockIndex                            ;
            	string3 PrevAddrAgeOldestRecord                       ;
            	string3 PrevAddrAgeNewestRecord                       ;
            	string3 PrevAddrLenOfRes                              ;
            	string2 PrevAddrDwellType                             ;
            	string2 PrevAddrApplicantOwned                        ;
            	string2 PrevAddrFamilyOwned                           ;
            	string2 PrevAddrOccupantOwned                         ;
            	string3 PrevAddrAgeLastSale                           ;
            	string10 PrevAddrLastSalesPrice                       ;
            	string10 PrevAddrTaxValue                             ;
            	string4 PrevAddrTaxYr                                 ;
            	string10 PrevAddrTaxMarketValue                       ;
            	string10 PrevAddrAVMValue                             ;
            	string5 PrevAddrCountyIndex                           ;
            	string5 PrevAddrTractIndex                            ;
            	string5 PrevAddrBlockIndex                            ;
            	string4 AddrMostRecentDistance                        ;
            	string2 AddrMostRecentStateDiff                       ;
            	string11 AddrMostRecentTaxDiff                        ;
            	string3 AddrMostRecentMoveAge                         ;
            	string2 AddrRecentEconTrajectory                      ;
            	string2 AddrRecentEconTrajectoryIndex                 ;
            	string1 EducationAttendedCollege                      ;
            	string2 EducationProgram2Yr                           ;
            	string2 EducationProgram4Yr                           ;
            	string2 EducationProgramGraduate                      ;
            	string2 EducationInstitutionPrivate                   ;
            	string2 EducationFieldofStudyType                     ;
            	string2 EducationInstitutionRating                    ;
            	string1 AddrStability                                 ;
            	string2 StatusMostRecent                              ;
            	string2 StatusPrevious                                ;
            	string2 StatusNextPrevious                            ;
            	string3 AddrChangeCount01                             ;
            	string3 AddrChangeCount03                             ;
            	string3 AddrChangeCount06                             ;
            	string3 AddrChangeCount12                             ;
            	string3 AddrChangeCount24                             ;
            	string3 AddrChangeCount60                             ;
            	string10 EstimatedAnnualIncome                        ;
            	string1 PropertyOwner                                 ;
            	string3 PropOwnedCount                                ;
            	string10 PropOwnedTaxTotal                            ;
            	string3 PropOwnedHistoricalCount                      ;
            	string3 PropAgeOldestPurchase                         ;
            	string3 PropAgeNewestPurchase                         ;
            	string3 PropAgeNewestSale                             ;
            	string10 PropNewestSalePrice                          ;
            	string5 PropNewestSalePurchaseIndex                   ;
            	string3 PropPurchasedCount01                          ;
            	string3 PropPurchasedCount03                          ;
            	string3 PropPurchasedCount06                          ;
            	string3 PropPurchasedCount12                          ;
            	string3 PropPurchasedCount24                          ;
            	string3 PropPurchasedCount60                          ;
            	string3 PropSoldCount01                               ;
            	string3 PropSoldCount03                               ;
            	string3 PropSoldCount06                               ;
            	string3 PropSoldCount12                               ;
            	string3 PropSoldCount24                               ;
            	string3 PropSoldCount60                               ;
            	string1 AssetOwner                                    ;
            	string1 WatercraftOwner                               ;
            	string3 WatercraftCount                               ;
            	string3 WatercraftCount01                             ;
            	string3 WatercraftCount03                             ;
            	string3 WatercraftCount06                             ;
            	string3 WatercraftCount12                             ;
            	string3 WatercraftCount24                             ;
            	string3 WatercraftCount60                             ;
            	string1 AircraftOwner                                 ;
            	string3 AircraftCount                                 ;
            	string3 AircraftCount01                               ;
            	string3 AircraftCount03                               ;
            	string3 AircraftCount06                               ;
            	string3 AircraftCount12                               ;
            	string3 AircraftCount24                               ;
            	string3 AircraftCount60                               ;
            	string2 WealthIndex                                   ;
            	string2 BusinessActiveAssociation                     ;
            	string2 BusinessInactiveAssociation                   ;
            	string3 BusinessAssociationAge                        ;
            	string100 BusinessTitle                               ;
            	string1 DerogSeverityIndex                            ;
            	string3 DerogCount                                    ;
            	string3 DerogRecentCount                              ;
            	string3 DerogAge                                      ;
            	string3 FelonyCount                                   ;
            	string3 FelonyAge                                     ;
            	string3 FelonyCount01                                 ;
            	string3 FelonyCount03                                 ;
            	string3 FelonyCount06                                 ;
            	string3 FelonyCount12                                 ;
            	string3 FelonyCount24                                 ;
            	string3 FelonyCount60                                 ;
            	string3 LienCount                                     ;
            	string3 LienFiledCount                                ;
            	string3 LienFiledAge                                  ;
            	string3 LienFiledCount01                              ;
            	string3 LienFiledCount03                              ;
            	string3 LienFiledCount06                              ;
            	string3 LienFiledCount12                              ;
            	string3 LienFiledCount24                              ;
            	string3 LienFiledCount60                              ;
            	string3 LienReleasedCount                             ;
            	string3 LienReleasedAge                               ;
            	string3 LienReleasedCount01                           ;
            	string3 LienReleasedCount03                           ;
            	string3 LienReleasedCount06                           ;
            	string3 LienReleasedCount12                           ;
            	string3 LienReleasedCount24                           ;
            	string3 LienReleasedCount60                           ;
            	string10 LienFiledTotal                               ;
            	string10 LienFederalTaxFiledTotal                     ;
            	string10 LienTaxOtherFiledTotal                       ;
            	string10 LienForeclosureFiledTotal                    ;
            	string10 LienLandlordTenantFiledTotal                 ;
            	string10 LienJudgmentFiledTotal                       ;
            	string10 LienSmallClaimsFiledTotal                    ;
            	string10 LienOtherFiledTotal                          ;
            	string10 LienReleasedTotal                            ;
            	string10 LienFederalTaxReleasedTotal                  ;
            	string10 LienTaxOtherReleasedTotal                    ;
            	string10 LienForeclosureReleasedTotal                 ;
            	string10 LienLandlordTenantReleasedTotal              ;
            	string10 LienJudgmentReleasedTotal                    ;
            	string10 LienSmallClaimsReleasedTotal                 ;
            	string10 LienOtherReleasedTotal                       ;
            	string3 LienFederalTaxFiledCount                      ;
            	string3 LienTaxOtherFiledCount                        ;
            	string3 LienForeclosureFiledCount                     ;
            	string3 LienLandlordTenantFiledCount                  ;
            	string3 LienJudgmentFiledCount                        ;
            	string3 LienSmallClaimsFiledCount                     ;
            	string3 LienOtherFiledCount                           ;
            	string3 LienFederalTaxReleasedCount                   ;
            	string3 LienTaxOtherReleasedCount                     ;
            	string3 LienForeclosureReleasedCount                  ;
            	string3 LienLandlordTenantReleasedCount               ;
            	string3 LienJudgmentReleasedCount                     ;
            	string3 LienSmallClaimsReleasedCount                  ;
            	string3 LienOtherReleasedCount                        ;
            	string3 BankruptcyCount                               ;
            	string3 BankruptcyAge                                 ;
            	string3 BankruptcyType                                ;
            	string35 BankruptcyStatus                             ;
            	string3 BankruptcyCount01                             ;
            	string3 BankruptcyCount03                             ;
            	string3 BankruptcyCount06                             ;
            	string3 BankruptcyCount12                             ;
            	string3 BankruptcyCount24                             ;
            	string3 BankruptcyCount60                             ;
            	string3 EvictionCount                                 ;
            	string3 EvictionAge                                   ;
            	string3 EvictionCount01                               ;
            	string3 EvictionCount03                               ;
            	string3 EvictionCount06                               ;
            	string3 EvictionCount12                               ;
            	string3 EvictionCount24 ;
            	string3 EvictionCount60 ;
            	string2 RecentActivityIndex ;
            	string3 NonDerogCount                                 ;
            	string3 NonDerogCount01                               ;
            	string3 NonDerogCount03                               ;
            	string3 NonDerogCount06                               ;
            	string3 NonDerogCount12                               ;
            	string3 NonDerogCount24                               ;
            	string3 NonDerogCount60                               ;
            	string1 VoterRegistrationRecord                       ;
            	string3 ProfLicCount                                  ;
            	string3 ProfLicAge                                    ;
            	string60 ProfLicType                                  ;
            	string2 ProfLicTypeCategory                           ;
            	string2 ProfLicExpired                                ;
            	string3 ProfLicCount01                                ;
            	string3 ProfLicCount03                                ;
            	string3 ProfLicCount06                                ;
            	string3 ProfLicCount12                                ;
            	string3 ProfLicCount24                                ;
            	string3 ProfLicCount60                                ;
            	string1 InquiryCollectionsRecent                      ;
            	string1 InquiryPersonalFinanceRecent                  ;
            	string1 InquiryOtherRecent                            ;
            	string1 HighRiskCreditActivity                        ;
            	string3 SubPrimeOfferRequestCount                     ;
            	string3 SubPrimeOfferRequestCount01                   ;
            	string3 SubPrimeOfferRequestCount03                   ;
            	string3 SubPrimeOfferRequestCount06                   ;
            	string3 SubPrimeOfferRequestCount12                   ;
            	string3 SubPrimeOfferRequestCount24                   ;
            	string3 SubPrimeOfferRequestCount60                   ;
            	string2 InputPhoneMobile                              ;
            	string3 PhoneEDAAgeOldestRecord                       ;
            	string3 PhoneEDAAgeNewestRecord                       ;
            	string3 PhoneOtherAgeOldestRecord                     ;
            	string3 PhoneOtherAgeNewestRecord                     ;
            	string2 InputPhoneHighRisk                            ;
            	string2 InputPhoneProblems                            ;
            	string2 EmailAddress                                  ;
            	string2 InputAddrHighRisk                             ;
            	string2 CurrAddrCorrectional                          ;
            	string2 PrevAddrCorrectional                          ;
            	string2 HistoricalAddrCorrectional                    ;
            	string2 InputAddrProblems                             ;
            	string1 SecurityFreeze                                ;
            	string1 SecurityAlert                                 ;
            	string1 IDTheftFlag                                   ;
            	string1 ConsumerStatement                             ;
            	string2 PrescreenOptOut                               ;
            	string16 CS_UniqueId ;                     
            	STRING CS_DATETIME  ;          
            	unsigned CS_StatementID     ;              
            	string5 CS_StatementType    ;             
            	string20 CS_DataGroup    ;                 
            	string3000 CS_Content ;
END;

// OUTPUT(CHOOSEN(soap_Results, eyeball), NAMED('Sample_SOAP_Results'));

soapResults := JOIN(SeqInput, soap_Results, 
	(integer)left.accountnumber = (integer)right.AccountNumber,
	transform(xlayoutSeq, 
		self.seq := (integer) right.accountnumber, 
		self.accountnumber := left.placeholder_1,
		self.ssn := left.ssn;
		self.AgeOldestRecord 						:= right.Result.InsurViewAttributes.Version4.IdentityManipulation.AgeOldestRecord;                            
   	self.AgeNewestRecord            := right.Result.InsurViewAttributes.Version4.IdentityManipulation.AgeNewestRecord                          ;
   	self.RecentUpdate               := right.Result.InsurViewAttributes.Version4.IdentityManipulation.RecentUpdate                              ;
   	self.SrcsConfirmIDAddrCount     := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SrcsConfirmIDAddrCount                    ;
   	self.InvalidDL                  := right.Result.InsurViewAttributes.Version4.IdentityManipulation.InvalidDL                                 ;
   	self.VerificationFailure        := right.Result.InsurViewAttributes.Version4.IdentityManipulation.VerificationFailure                       ;
   	self.SSNNotFound                := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SSNNotFound                               ;
   	self.VerifiedName               := right.Result.InsurViewAttributes.Version4.IdentityManipulation.VerifiedName                              ;
   	self.VerifiedSSN                := right.Result.InsurViewAttributes.Version4.IdentityManipulation.VerifiedSSN                               ;
   	self.VerifiedPhone              := right.Result.InsurViewAttributes.Version4.IdentityManipulation.VerifiedPhone                             ;
   	self.VerifiedAddress            := right.Result.InsurViewAttributes.Version4.IdentityManipulation.VerifiedAddress                           ;
   	self.VerifiedDOB                := right.Result.InsurViewAttributes.Version4.IdentityManipulation.VerifiedDOB                               ;
   	self.InferredMinimumAge         := right.Result.InsurViewAttributes.Version4.IdentityManipulation.InferredMinimumAge                        ;
   	self.BestReportedAge            := right.Result.InsurViewAttributes.Version4.IdentityManipulation.BestReportedAge                           ;
   	self.SubjectSSNCount            := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SubjectSSNCount                           ;
   	self.SubjectAddrCount           := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SubjectAddrCount                          ;
   	self.SubjectPhoneCount          := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SubjectPhoneCount                         ;
   	self.SubjectSSNRecentCount      := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SubjectSSNRecentCount                     ;
   	self.SubjectAddrRecentCount     := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SubjectAddrRecentCount                    ;
   	self.SubjectPhoneRecentCount    := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SubjectPhoneRecentCount                   ;	// self := right.Result.InsurViewAttributes.Version4.SSNCharacteristics   ;   
   	self.SSNIdentitiesCount          := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SSNIdentitiesCount                           ;
   	self.SSNAddrCount                := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SSNAddrCount                                 ;
   	self.SSNIdentitiesRecentCount    := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SSNIdentitiesRecentCount                     ;
   	self.SSNAddrRecentCount          := right.Result.InsurViewAttributes.Version4.IdentityManipulation.SSNAddrRecentCount                           ;
   	self.InputAddrPhoneCount         := right.Result.InsurViewAttributes.Version4.IdentityManipulation.InputAddrPhoneCount                          ;
   	self.InputAddrPhoneRecentCount   := right.Result.InsurViewAttributes.Version4.IdentityManipulation.InputAddrPhoneRecentCount                    ;
   	self.PhoneIdentitiesCount        := right.Result.InsurViewAttributes.Version4.IdentityManipulation.PhoneIdentitiesCount                         ;
   	self.PhoneIdentitiesRecentCount  := right.Result.InsurViewAttributes.Version4.IdentityManipulation.PhoneIdentitiesRecentCount                   ;
   	self.SSNAgeDeceased              := right.Result.InsurViewAttributes.Version4.SSNCharacteristics.SSNAgeDeceased                               ;
   	self.SSNRecent                   := right.Result.InsurViewAttributes.Version4.SSNCharacteristics.SSNRecent                                    ;
   	self.SSNLowIssueAge              := right.Result.InsurViewAttributes.Version4.SSNCharacteristics.SSNLowIssueAge                               ;
   	self.SSNHighIssueAge             := right.Result.InsurViewAttributes.Version4.SSNCharacteristics.SSNHighIssueAge                              ;
   	self.SSNIssueState               := right.Result.InsurViewAttributes.Version4.SSNCharacteristics.SSNIssueState                                ;
   	self.SSNNonUS                    := right.Result.InsurViewAttributes.Version4.SSNCharacteristics.SSNNonUS                                     ;
   	self.SSN3Years                   := right.Result.InsurViewAttributes.Version4.SSNCharacteristics.SSN3Years                                    ;
   	self.SSNAfter5                   := right.Result.InsurViewAttributes.Version4.SSNCharacteristics.SSNAfter5                                    ;
   	self.SSNProblems                 := right.Result.InsurViewAttributes.Version4.SSNCharacteristics.SSNProblems                                  ;
   	self.InputAddrAgeOldestRecord  := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrAgeOldestRecord                     ;
   	self.InputAddrAgeNewestRecord  := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrAgeNewestRecord                     ;
   	self.InputAddrHistoricalMatch  := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrHistoricalMatch                     ;
   	self.InputAddrLenOfRes         := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrLenOfRes                            ;
   	self.InputAddrDwellType        := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrDwellType                           ;
   	self.InputAddrDelivery         := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrDelivery                            ;
   	self.InputAddrApplicantOwned   := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrApplicantOwned                      ;
   	self.InputAddrFamilyOwned      := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrFamilyOwned                         ;
   	self.InputAddrOccupantOwned    := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrOccupantOwned                       ;
   	self.InputAddrAgeLastSale      := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrAgeLastSale                         ;
   	self.InputAddrLastSalesPrice  := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrLastSalesPrice                     ;
   	self.InputAddrMortgageType     := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrMortgageType                        ;
   	self.InputAddrNotPrimaryRes    := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrNotPrimaryRes                       ;
   	self.InputAddrActivePhoneList  := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrActivePhoneList                     ;
   	self.InputAddrTaxValue        := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrTaxValue                           ;
   	self.InputAddrTaxYr            := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrTaxYr                               ;
   	self.InputAddrTaxMarketValue  := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrTaxMarketValue                     ;
   	self.InputAddrAVMValue        := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrAVMValue                           ;
   	self.InputAddrAVMValue12      := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrAVMValue12                         ;
   	self.InputAddrAVMValue60      := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrAVMValue60                         ;
   	self.InputAddrCountyIndex      := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrCountyIndex                         ;
   	self.InputAddrTractIndex       := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrTractIndex                          ;
   	self.InputAddrBlockIndex       := right.Result.InsurViewAttributes.Version4.InputAddress.InputAddrBlockIndex                          ;
   	self.CurrAddrAgeOldestRecord := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrAgeOldestRecord                       ;
   	self.CurrAddrAgeNewestRecord := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrAgeNewestRecord                       ;
   	self.CurrAddrLenOfRes        := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrLenOfRes                              ;
   	self.CurrAddrDwellType       := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrDwellType                             ;
   	self.CurrAddrApplicantOwned  := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrApplicantOwned                        ;
   	self.CurrAddrFamilyOwned     := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrFamilyOwned                           ;
   	self.CurrAddrOccupantOwned   := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrOccupantOwned                         ;
   	self.CurrAddrAgeLastSale     := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrAgeLastSale                           ;
   	self.CurrAddrLastSalesPrice  := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrLastSalesPrice                        ;
   	self.CurrAddrMortgageType    := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrMortgageType                          ;
   	self.CurrAddrActivePhoneList := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrActivePhoneList                       ;
   	self.CurrAddrTaxValue        := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrTaxValue                              ;
   	self.CurrAddrTaxYr           := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrTaxYr                                 ;
   	self.CurrAddrTaxMarketValue  := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrTaxMarketValue                        ;
   	self.CurrAddrAVMValue        := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrAVMValue                              ;
   	self.CurrAddrAVMValue12      := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrAVMValue12                            ;
   	self.CurrAddrAVMValue60      := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrAVMValue60                            ;
   	self.CurrAddrCountyIndex     := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrCountyIndex                           ;
   	self.CurrAddrTractIndex      := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrTractIndex                            ;
   	self.CurrAddrBlockIndex      := right.Result.InsurViewAttributes.Version4.CurrentAddress.CurrAddrBlockIndex                            ;
   		self.PrevAddrAgeOldestRecord   := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrAgeOldestRecord                      ;
   	self.PrevAddrAgeNewestRecord   := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrAgeNewestRecord                      ;
   	self.PrevAddrLenOfRes          := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrLenOfRes                             ;
   	self.PrevAddrDwellType         := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrDwellType                            ;
   	self.PrevAddrApplicantOwned    := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrApplicantOwned                       ;
   	self.PrevAddrFamilyOwned       := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrFamilyOwned                          ;
   	self.PrevAddrOccupantOwned     := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrOccupantOwned                        ;
   	self.PrevAddrAgeLastSale       := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrAgeLastSale                          ;
   	self.PrevAddrLastSalesPrice    := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrLastSalesPrice                      ;
   	self.PrevAddrTaxValue          := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrTaxValue                            ;
   	self.PrevAddrTaxYr             := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrTaxYr                                ;
   	self.PrevAddrTaxMarketValue    := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrTaxMarketValue                      ;
   	self.PrevAddrAVMValue          := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrAVMValue                            ;
   	self.PrevAddrCountyIndex       := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrCountyIndex                          ;
   	self.PrevAddrTractIndex        := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrTractIndex                           ;
   	self.PrevAddrBlockIndex        := right.Result.InsurViewAttributes.Version4.PreviousAddress.PrevAddrBlockIndex                           ;
   	self.AddrMostRecentDistance    := right.Result.InsurViewAttributes.Version4.MostRecentAddress.AddrMostRecentDistance                       ;
   	self.AddrMostRecentStateDiff   := right.Result.InsurViewAttributes.Version4.MostRecentAddress.AddrMostRecentStateDiff                      ;
   	self.AddrMostRecentTaxDiff     := right.Result.InsurViewAttributes.Version4.MostRecentAddress.AddrMostRecentTaxDiff                       ;
   	self.AddrMostRecentMoveAge     := right.Result.InsurViewAttributes.Version4.MostRecentAddress.AddrMostRecentMoveAge                        ;
   	self.AddrRecentEconTrajectory       := right.Result.InsurViewAttributes.Version4.MostRecentAddress.AddrRecentEconTrajectory                    ;
   	self.AddrRecentEconTrajectoryIndex  := right.Result.InsurViewAttributes.Version4.MostRecentAddress.AddrRecentEconTrajectoryIndex               ;
   	self.EducationAttendedCollege       := right.Result.InsurViewAttributes.Version4.Education.EducationAttendedCollege                    ;  
   		self.EducationProgram2Yr           := right.Result.InsurViewAttributes.Version4.Education.EducationProgram2Yr                        ;
   	self.EducationProgram4Yr            := right.Result.InsurViewAttributes.Version4.Education.EducationProgram4Yr                        ;
   	self.EducationProgramGraduate       := right.Result.InsurViewAttributes.Version4.Education.EducationProgramGraduate                   ;
   	self.EducationInstitutionPrivate    := right.Result.InsurViewAttributes.Version4.Education.EducationInstitutionPrivate                ;
   	self.EducationFieldofStudyType      := right.Result.InsurViewAttributes.Version4.Education.EducationFieldofStudyType                  ;
   	self.EducationInstitutionRating     := right.Result.InsurViewAttributes.Version4.Education.EducationInstitutionRating                 ;
     	self.AddrStability          :=  right.Result.InsurViewAttributes.Version4.AddressStability.AddrStability                            ;
   	self.StatusMostRecent       :=  right.Result.InsurViewAttributes.Version4.AddressStability.StatusMostRecent                         ;
   	self.StatusPrevious         :=  right.Result.InsurViewAttributes.Version4.AddressStability.StatusPrevious                           ;
   	self.StatusNextPrevious     :=  right.Result.InsurViewAttributes.Version4.AddressStability.StatusNextPrevious                       ;
   	self.AddrChangeCount01      :=  right.Result.InsurViewAttributes.Version4.AddressStability.AddrChangeCount01                        ;
   	self.AddrChangeCount03      :=  right.Result.InsurViewAttributes.Version4.AddressStability.AddrChangeCount03                        ;
   	self.AddrChangeCount06      :=  right.Result.InsurViewAttributes.Version4.AddressStability.AddrChangeCount06                        ;
   	self.AddrChangeCount12      :=  right.Result.InsurViewAttributes.Version4.AddressStability.AddrChangeCount12                        ;
   	self.AddrChangeCount24      :=  right.Result.InsurViewAttributes.Version4.AddressStability.AddrChangeCount24                        ;
   	self.AddrChangeCount60      :=  right.Result.InsurViewAttributes.Version4.AddressStability.AddrChangeCount60                        ;
   	self.EstimatedAnnualIncome            := right.Result.InsurViewAttributes.Version4.IncomeAsset.EstimatedAnnualIncome                   ;
   	self.PropertyOwner                    := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropertyOwner                            ;
   	self.PropOwnedCount                   := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropOwnedCount                           ;
   	self.PropOwnedTaxTotal                := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropOwnedTaxTotal                       ;
   	self.PropOwnedHistoricalCount         := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropOwnedHistoricalCount                 ;
   	self.PropAgeOldestPurchase            := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropAgeOldestPurchase                    ;
   	self.PropAgeNewestPurchase            := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropAgeNewestPurchase                    ;
   	self.PropAgeNewestSale                := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropAgeNewestSale                        ;
   	self.PropNewestSalePrice              := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropNewestSalePrice                     ;
   	self.PropNewestSalePurchaseIndex      := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropNewestSalePurchaseIndex              ;
   	self.PropPurchasedCount01             := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropPurchasedCount01                     ;
   	self.PropPurchasedCount03             := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropPurchasedCount03                     ;
   	self.PropPurchasedCount06             := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropPurchasedCount06                     ;
   	self.PropPurchasedCount12             := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropPurchasedCount12                     ;
   	self.PropPurchasedCount24             := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropPurchasedCount24                     ;
   	self.PropPurchasedCount60             := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropPurchasedCount60                     ;
   	self.PropSoldCount01                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropSoldCount01                          ;
   	self.PropSoldCount03                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropSoldCount03                          ;
   	self.PropSoldCount06                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropSoldCount06                          ;
   	self.PropSoldCount12                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropSoldCount12                          ;
   	self.PropSoldCount24                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropSoldCount24                          ;
   	self.PropSoldCount60                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.PropSoldCount60                          ;
   	self.AssetOwner                       := right.Result.InsurViewAttributes.Version4.IncomeAsset.AssetOwner                               ;
   	self.WatercraftOwner                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.WatercraftOwner                          ;
   	self.WatercraftCount                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.WatercraftCount                          ;
   	self.WatercraftCount01                := right.Result.InsurViewAttributes.Version4.IncomeAsset.WatercraftCount01                        ;
   	self.WatercraftCount03                := right.Result.InsurViewAttributes.Version4.IncomeAsset.WatercraftCount03                        ;
   	self.WatercraftCount06                := right.Result.InsurViewAttributes.Version4.IncomeAsset.WatercraftCount06                        ;
   	self.WatercraftCount12                := right.Result.InsurViewAttributes.Version4.IncomeAsset.WatercraftCount12                        ;
   	self.WatercraftCount24                := right.Result.InsurViewAttributes.Version4.IncomeAsset.WatercraftCount24                        ;
   	self.WatercraftCount60                := right.Result.InsurViewAttributes.Version4.IncomeAsset.WatercraftCount60                        ;
   	self.AircraftOwner                    := right.Result.InsurViewAttributes.Version4.IncomeAsset.AircraftOwner                            ;
   	self.AircraftCount                    := right.Result.InsurViewAttributes.Version4.IncomeAsset.AircraftCount                            ;
   	self.AircraftCount01                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.AircraftCount01                          ;
   	self.AircraftCount03                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.AircraftCount03                          ;
   	self.AircraftCount06                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.AircraftCount06                          ;
   	self.AircraftCount12                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.AircraftCount12                          ;
   	self.AircraftCount24                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.AircraftCount24                          ;
   	self.AircraftCount60                  := right.Result.InsurViewAttributes.Version4.IncomeAsset.AircraftCount60                          ;
   	self.WealthIndex                      := right.Result.InsurViewAttributes.Version4.IncomeAsset.WealthIndex                              ;
   	self.BusinessActiveAssociation   := right.Result.InsurViewAttributes.Version4.BusinessAssociation.BusinessActiveAssociation                      ;
   	self.BusinessInactiveAssociation := right.Result.InsurViewAttributes.Version4.BusinessAssociation.BusinessInactiveAssociation                  ;
   	self.BusinessAssociationAge      := right.Result.InsurViewAttributes.Version4.BusinessAssociation.BusinessAssociationAge                       ;
   	self.BusinessTitle               := right.Result.InsurViewAttributes.Version4.BusinessAssociation.BusinessTitle                              ;
    	self.DerogSeverityIndex   := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.DerogSeverityIndex                           ;
   	self.DerogCount           := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.DerogCount                                   ;
   	self.DerogRecentCount     := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.DerogRecentCount                             ;
   	self.DerogAge             := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.DerogAge                                     ;
   	self.FelonyCount          := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.FelonyCount                                  ;
   	self.FelonyAge            := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.FelonyAge                                    ;
   	self.FelonyCount01        := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.FelonyCount01                                ;
   	self.FelonyCount03        := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.FelonyCount03                                ;
   	self.FelonyCount06        := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.FelonyCount06                                ;
   	self.FelonyCount12        := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.FelonyCount12                                ;
   	self.FelonyCount24        := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.FelonyCount24                                ;
   	self.FelonyCount60        := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.FelonyCount60                                ;
   	self.LienCount            := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienCount                                    ;
   	self.LienFiledCount       := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFiledCount                               ;
   	self.LienFiledAge         := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFiledAge                                 ;
   	self.LienFiledCount01     := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFiledCount01                             ;
   	self.LienFiledCount03     := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFiledCount03                             ;
   	self.LienFiledCount06     := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFiledCount06                             ;
   	self.LienFiledCount12     := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFiledCount12                             ;
   	self.LienFiledCount24     := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFiledCount24                             ;
   	self.LienFiledCount60     := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFiledCount60                             ;
   	self.LienReleasedCount    := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienReleasedCount                            ;
   	self.LienReleasedAge      := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienReleasedAge                              ;
   	self.LienReleasedCount01  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienReleasedCount01                          ;
   	self.LienReleasedCount03  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienReleasedCount03                          ;
   	self.LienReleasedCount06  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienReleasedCount06                          ;
   	self.LienReleasedCount12  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienReleasedCount12                          ;
   	self.LienReleasedCount24  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienReleasedCount24                          ;
   	self.LienReleasedCount60  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienReleasedCount60                          ;
   	self.LienFiledTotal                 :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFiledTotal                             ;
   	self.LienFederalTaxFiledTotal       :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFederalTaxFiledTotal                   ;
   	self.LienTaxOtherFiledTotal         :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienTaxOtherFiledTotal                     ;
   	self.LienForeclosureFiledTotal      :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienForeclosureFiledTotal                  ;
   	self.LienLandlordTenantFiledTotal   :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienLandlordTenantFiledTotal               ;
   	self.LienJudgmentFiledTotal         :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienJudgmentFiledTotal                     ;
   	self.LienSmallClaimsFiledTotal      :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienSmallClaimsFiledTotal                  ;
   	self.LienOtherFiledTotal            :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienOtherFiledTotal                        ;
   	self.LienReleasedTotal              :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienReleasedTotal                          ;
   	self.LienFederalTaxReleasedTotal    :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFederalTaxReleasedTotal                ;
   	self.LienTaxOtherReleasedTotal      :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienTaxOtherReleasedTotal                  ;
   	self.LienForeclosureReleasedTotal   :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienForeclosureReleasedTotal               ;
   	self.LienLandlordTenantReleasedTotal:=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienLandlordTenantReleasedTotal            ;
   	self.LienJudgmentReleasedTotal      :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienJudgmentReleasedTotal                  ;
   	self.LienSmallClaimsReleasedTotal   :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienSmallClaimsReleasedTotal               ;
   	self.LienOtherReleasedTotal         :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienOtherReleasedTotal                     ;
   	self.LienFederalTaxFiledCount       :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFederalTaxFiledCount                    ;
   	self.LienTaxOtherFiledCount         :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienTaxOtherFiledCount                      ;
   	self.LienForeclosureFiledCount      :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienForeclosureFiledCount                   ;
   	self.LienLandlordTenantFiledCount   :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienLandlordTenantFiledCount                ;
   	self.LienJudgmentFiledCount         :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienJudgmentFiledCount                      ;
   	self.LienSmallClaimsFiledCount      :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienSmallClaimsFiledCount                   ;
   	self.LienOtherFiledCount            :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienOtherFiledCount                         ;
   	self.LienFederalTaxReleasedCount    :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienFederalTaxReleasedCount                 ;
   	self.LienTaxOtherReleasedCount      :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienTaxOtherReleasedCount                   ;
   	self.LienForeclosureReleasedCount   :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienForeclosureReleasedCount                ;
   	self.LienLandlordTenantReleasedCount:=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienLandlordTenantReleasedCount             ;
   	self.LienJudgmentReleasedCount      :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienJudgmentReleasedCount                   ;
   	self.LienSmallClaimsReleasedCount   :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienSmallClaimsReleasedCount                ;
   	self.LienOtherReleasedCount         :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.LienOtherReleasedCount                      ;
   	self.BankruptcyCount                :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.BankruptcyCount                             ;
   	self.BankruptcyAge                  :=  right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.BankruptcyAge                               ;
   	SELF.BankruptcyType     := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.BankruptcyType                              ;
   	SELF.BankruptcyStatus   := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.BankruptcyStatus                           ;
   	SELF.BankruptcyCount01  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.BankruptcyCount01                           ;
   	SELF.BankruptcyCount03  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.BankruptcyCount03                           ;
   	SELF.BankruptcyCount06  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.BankruptcyCount06                           ;
   	SELF.BankruptcyCount12  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.BankruptcyCount12                           ;
   	SELF.BankruptcyCount24  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.BankruptcyCount24                           ;
   	SELF.BankruptcyCount60  := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.BankruptcyCount60                           ;
   	SELF.EvictionCount      := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.EvictionCount                               ;
   	SELF.EvictionAge        := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.EvictionAge                                 ;
   	SELF.EvictionCount01    := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.EvictionCount01                             ;
   	SELF.EvictionCount03    := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.EvictionCount03                             ;
   	SELF.EvictionCount06    := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.EvictionCount06                             ;
   	SELF.EvictionCount12    := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.EvictionCount12                             ;
   	SELF.EvictionCount24 := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.EvictionCount24                             ;
   	SELF.EvictionCount60 := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.EvictionCount60                             ;
   	SELF.RecentActivityIndex := right.Result.InsurViewAttributes.Version4.DerogatoryPublicRecord.RecentActivityIndex                             ;
   	SELF.NonDerogCount      := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.NonDerogCount                               ;
   	SELF.NonDerogCount01    := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.NonDerogCount01                             ;
   	SELF.NonDerogCount03    := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.NonDerogCount03                             ;
   	SELF.NonDerogCount06    := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.NonDerogCount06                             ;
   	SELF.NonDerogCount12    := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.NonDerogCount12                             ;
   	SELF.NonDerogCount24    := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.NonDerogCount24                             ;
   	SELF.NonDerogCount60    := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.NonDerogCount60                             ;
   	SELF.VoterRegistrationRecord     := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.VoterRegistrationRecord                   ;
   	SELF.ProfLicCount                := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicCount                              ;
   	SELF.ProfLicAge                  := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicAge                                ;
   	SELF.ProfLicType                 := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicType                              ;
   	SELF.ProfLicTypeCategory         := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicTypeCategory                       ;
   	SELF.ProfLicExpired              := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicExpired                            ;
   	SELF.ProfLicCount01              := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicCount01                            ;
   	SELF.ProfLicCount03              := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicCount03                            ;
   	SELF.ProfLicCount06              := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicCount06                            ;
   	SELF.ProfLicCount12              := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicCount12                            ;
   	SELF.ProfLicCount24              := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicCount24                            ;
   	SELF.ProfLicCount60              := right.Result.InsurViewAttributes.Version4.ProfessionalLicense.ProfLicCount60                            ;
   	SELF.InquiryCollectionsRecent     := right.Result.InsurViewAttributes.Version4.InquiryEvents.InquiryCollectionsRecent                        ;
   	SELF.InquiryPersonalFinanceRecent := right.Result.InsurViewAttributes.Version4.InquiryEvents.InquiryPersonalFinanceRecent                    ;
   	SELF.InquiryOtherRecent           := right.Result.InsurViewAttributes.Version4.InquiryEvents.InquiryOtherRecent                              ;
   	SELF.HighRiskCreditActivity       := right.Result.InsurViewAttributes.Version4.InquiryEvents.HighRiskCreditActivity                          ;
   	SELF.SubPrimeOfferRequestCount    := right.Result.InsurViewAttributes.Version4.InquiryEvents.SubPrimeOfferRequestCount                       ;
   	SELF.SubPrimeOfferRequestCount01  := right.Result.InsurViewAttributes.Version4.InquiryEvents.SubPrimeOfferRequestCount01                     ;
   	SELF.SubPrimeOfferRequestCount03  := right.Result.InsurViewAttributes.Version4.InquiryEvents.SubPrimeOfferRequestCount03                     ;
   	SELF.SubPrimeOfferRequestCount06  := right.Result.InsurViewAttributes.Version4.InquiryEvents.SubPrimeOfferRequestCount06                     ;
   	SELF.SubPrimeOfferRequestCount12  := right.Result.InsurViewAttributes.Version4.InquiryEvents.SubPrimeOfferRequestCount12                     ;
   	SELF.SubPrimeOfferRequestCount24  := right.Result.InsurViewAttributes.Version4.InquiryEvents.SubPrimeOfferRequestCount24                     ;
   	SELF.SubPrimeOfferRequestCount60  := right.Result.InsurViewAttributes.Version4.InquiryEvents.SubPrimeOfferRequestCount60                     ; 
   	SELF.InputPhoneMobile           := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.InputPhoneMobile                              ;
   	SELF.PhoneEDAAgeOldestRecord    := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.PhoneEDAAgeOldestRecord                       ;
   	SELF.PhoneEDAAgeNewestRecord    := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.PhoneEDAAgeNewestRecord                       ;
   	SELF.PhoneOtherAgeOldestRecord  := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.PhoneOtherAgeOldestRecord                     ;
   	SELF.PhoneOtherAgeNewestRecord  := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.PhoneOtherAgeNewestRecord                     ;
   	SELF.InputPhoneHighRisk         := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.InputPhoneHighRisk                            ;
   	SELF.InputPhoneProblems         := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.InputPhoneProblems                            ;
   	SELF.EmailAddress               := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.EmailAddress                                  ;
   	SELF.InputAddrHighRisk          := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.InputAddrHighRisk                             ;
   	SELF.CurrAddrCorrectional       := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.CurrAddrCorrectional                          ;
   	SELF.PrevAddrCorrectional       := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.PrevAddrCorrectional                          ;
   	SELF.HistoricalAddrCorrectional := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.HistoricalAddrCorrectional                    ;
   	SELF.InputAddrProblems          := right.Result.InsurViewAttributes.Version4.PhoneAndAddressRisk.InputAddrProblems                             ;   
   	SELF.SecurityFreeze             := right.Result.InsurViewAttributes.Version4.ConsumerReportedFlags.SecurityFreeze                        ;
   	SELF.SecurityAlert              := right.Result.InsurViewAttributes.Version4.ConsumerReportedFlags.SecurityAlert                         ;
   	SELF.IDTheftFlag                := right.Result.InsurViewAttributes.Version4.ConsumerReportedFlags.IDTheftFlag                           ;
   	SELF.ConsumerStatement          := right.Result.InsurViewAttributes.Version4.ConsumerReportedFlags.ConsumerStatement                     ;
   	SELF.PrescreenOptOut            := right.Result.InsurViewAttributes.Version4.ConsumerReportedFlags.PrescreenOptOut                       ;
   	SELF.CS_UniqueId          := right.Result.ConsumerStatements[1].UniqueId;            
   	SELF.CS_DATETIME  := '';// LE.Result.ConsumerStatements[1].UniqueId;             
   	SELF.CS_StatementID     := right.Result.ConsumerStatements[1].StatementID;                
   	SELF.CS_StatementType   := right.Result.ConsumerStatements[1].StatementType;                
   	SELF.CS_DataGroup     := right.Result.ConsumerStatements[1].DataGroup;                  
   	SELF.CS_Content      := right.Result.ConsumerStatements[1].Content;      
		self := []),
		left outer);

   
   // output(soapResults_raw(errorcode !=''), named('errors'));
   // output(SeqInput, named('SeqInput'));
   
   // output(choosen(soapResults,10), named('soapResults'));
   // output(soap_out, named('soap_out'));

filtered_final_result := output(soapResults,,outfile_name, CSV(heading(single), quote('"')), overwrite);   
   
dfuwuid := STD.File.Despray(outfile_name, '10.48.72.34', 'c:\\qa\\insurview\\Insurview_' + dt1_1 + '_CSV',,,,true);
// dfuwuid := STD.File.Despray(outfile_name, '10.48.72.34', '\\\\risk.regn.net\\bus\\consolidatedqcregression\\Alp-Regression\\WsInsuranceRisk-FCRA\\InsurView\\RiskView 4.0\\Insurview_' + dt1_1 + '_Csv',,,,true);

run := sequential(filtered_final_result,dfuwuid);

RETURN run;

ENDMACRO; 