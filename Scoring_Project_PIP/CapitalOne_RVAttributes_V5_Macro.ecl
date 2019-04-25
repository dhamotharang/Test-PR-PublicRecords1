EXPORT CapitalOne_RVAttributes_V5_Macro(fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO
//test
IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT, Gateway, scoring_project_pip, riskview, Gateway, Address, DidVille;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String neutralroxieIP := neutralroxie_IP ; 
		String fcraroxieIP := fcraroxie_IP ;
		Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name;
    gateways := Gateway;
		
dt := ut.getdate;
		// *********** SETTINGS ********************************

		DataRestrictionMask:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V5_BATCH_Prescreen_Capone_settings.DRM;
		DataPermissionMask:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V5_BATCH_Prescreen_Capone_settings.DPM;
		fuzzy_wuzzy_was_a_bear := 'ALL';
		GLB_Didville := 1;
		GLB_data := true;
		patriotproc := true;
		// AttributesVersion := 'riskviewattrv5';
    intendedPurpose := 'PRESCREENING';// Turn on the PRESCREENING intended purpose if this customer will be running in prescreen mode 
		
    // models		
		model1 := ''; //  Prescreen model not implemented yet in RV5.
		model2 := ''; 
		model3 := ''; 
		model4 := ''; 
		
		HistoryDate := 999999;
		
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	

		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

		ds_raw_input := IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records));
			
// output(	ds_raw_input, named('ds_raw_input'));		
			
		//*********** RV Attributes V5 XML SETUP AND SOAPCALL ******************
soapLayout_didville := RECORD
    String acctno;
	String did;
	String  ssn;
	String  dob;
	String phoneno;
	String  title;
	String name_first;
	String name_middle;
	String name_last;
	String  name_suffix;
	String prim_range;
	String  predir;
	String prim_name;
	String  suffix;
	String  postdir;
	String unit_desig;
	String  sec_range;
	String p_city_name;
	String  st;
	String  z5;
	String  zip4;
  
end;

soap_inrec_didville := record

string120 append_l ;
string120 verify_l ;
string120 fuzzy_l ;
boolean   dedup_results_l := true ;
string3   thresh_val;
boolean   GLB_data;
unsigned1 glb_purpose_value;

boolean   patriotproc := true;
boolean include_minors 	:= false;
unsigned1 soap_xadl_version_value;
unsigned8 MaxResultsPerAcct;
boolean IncludeRanking;
	dataset(soapLayout_didville) did_batch_in;
end;



soap_inrec_didville t_f_didville(ds_raw_input le, integer c) := transform
	self.fuzzy_l := fuzzy_wuzzy_was_a_bear;
	self.GLB_data := GLB_data;
	self.glb_purpose_value := GLB_Didville;
	self.patriotproc := patriotproc;
	self.did_batch_in := project(le, transform(soapLayout_didville,
																					self.acctno := (string)le.AccountNumber;

																					self.name_first := le.firstname;
																					self.name_middle := le.middlename;
																					self.name_last := le.lastname;
																					self.ssn := le.ssn;
																clean_addr := risk_indicators.MOD_AddressClean.clean_addr(le.StreetAddress, le.City, le.State, le.Zip) ;																												
																					SELF.prim_range := Address.CleanFields(clean_addr).prim_range;
																					SELF.predir := Address.CleanFields(clean_addr).predir;
																					SELF.prim_name := Address.CleanFields(clean_addr).prim_name;
																					SELF.suffix := Address.CleanFields(clean_addr).addr_suffix;
																					SELF.postdir := Address.CleanFields(clean_addr).postdir;
																					SELF.unit_desig := Address.CleanFields(clean_addr).unit_desig;
																					SELF.sec_range := Address.CleanFields(clean_addr).sec_range;
																					SELF.p_city_name := Address.CleanFields(clean_addr).p_city_name;
																					SELF.st := Address.CleanFields(clean_addr).st;
																					SELF.z5 := Address.CleanFields(clean_addr).zip;
																					self := [];
																					));
self := [];																					
end;
		

soap_input_didville := project(ds_raw_input, t_f_didville(left, counter));
		
		// output(soap_input_didville,named('soap_input_didville'));


		//Soap output layout		
layout_Soap_output2 := RECORD
		DidVille.Layout_Did_OutBatch_Raw;

			STRING errorcode;
END;

layout_Soap_output2 myFail_didville(soap_inrec_didville le) := TRANSFORM
			// self.acctno := le
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF := le;
			SELF := [];
END;

	  //*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		didville_Soap_output := SOAPCALL(soap_input_didville, 
						neutralroxieIP,
						// 'riskview.batch_service', 
						'didville.did_batch_service_raw', 
						{soap_input_didville}, 
						DATASET(layout_Soap_output2),
						RETRY(RETRY), TIMEOUT(timeout),
						PARALLEL(threads), onFail(myFail_didville(LEFT)));
		
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************


	
soapLayout := RECORD
			Models.layouts.Layout_CaponeRV5_Batch_In;
end;

soap_inrec := record
	string Bankcard_model_name;
	string prescreen_score_threshold;
	string DataRestrictionMask;
	string DataPermissionMask;

	dataset(Gateway.Layouts.Config) gateways;
	dataset(Models.layouts.Layout_CaponeRV5_Batch_In) batch_in;
end;

soap_inrec t_f(didville_Soap_output le, integer c) := transform
		self.Bankcard_model_name := '';
	self.prescreen_score_threshold := '';
	
	SELF.Gateways := PROJECT(ut.ds_oneRecord, TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := 'neutralroxie'; SELF.URL := NeutralRoxieIP; SELF := []));

	self.DataRestrictionMask := DataRestrictionMask;
	self.DataPermissionMask := DataPermissionMask;

	self.batch_in := project(le, transform(Models.layouts.Layout_CaponeRV5_Batch_In,
																					self.AcctNo:= (string)(unsigned)le.acctno;
buildaddr := Address.Addr1FromComponents(le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);

																					self.RX_unparsedfullname := if(le.name_first <> '', le.name_first + ' ' + le.name_middle + ' ' + le.name_last, le.name_first + ' '+ le.name_last) ;
																					self.LexID := (string)le.did;
																					self.RX_SSN := le.ssn;
																					self.Address1 := buildaddr;
																					self.city := le.p_city_name;
																					self.State := le.st;
																					self.Zip5 := le.z5;
																					self := [];
																					));
end;
		

soap_input := project(didville_Soap_output, t_f(left, counter));
		// output(soap_input,named('prescreen_soap_in'));

// prescreen_clean_pre_soapcall := '~scoringqa::out::fcra::RV_v5_capone_didville_return_' + dt +'_1';
		// check_point_output := output(soap_input ,,prescreen_clean_pre_soapcall, thor, compressed, overwrite, expire(30));
	 // output(soap_input ,,prescreen_clean_pre_soapcall, thor, compressed, overwrite);

		//Soap output layout		
		layout_Soap_output := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
		
		riskview.layouts.layout_RV5capOneBatch_searchResults-seq;
			STRING errorcode;
		END;

		layout_Soap_output myFail(soap_inrec le) := TRANSFORM
			self.AcctNo := le.batch_in[1].AcctNo;
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF := le;
			SELF := [];
		END;

	  //*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		prescreen_Soap_output := SOAPCALL(soap_input, 
						FCRARoxieIP,
						// 'riskview.batch_service', 
						'riskview.riskview5_capone_batch_service', 
						{soap_input}, 
						DATASET(layout_Soap_output),
						RETRY(RETRY), TIMEOUT(timeout),
						PARALLEL(threads), onFail(myFail(LEFT)));
		
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
	 // output(prescreen_Soap_output, named('prescreen_Soap_output'));
	




	  // GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Capone_allflagships_Attributes_V5_Batch_Layout ;	
		END;
				
				flattened_result := project(prescreen_Soap_output, transform(Global_output_lay ,
			self.time_ms := left.time_ms;
			self.acctno := (string)(unsigned)left.acctno, //has leading zeros, this  removes them
			self.lexid := left.lexid;
		
			// self.Bankcard_Index := '';	
			self.BankCard_Score_Name := left.BankCard_Score_Name;
			self.BankCard_score := left.BankCard_score;
			self.BankCard_reason1 := left.BankCard_reason1;
			self.BankCard_reason2 := left.BankCard_reason2;
			self.BankCard_reason3 := left.BankCard_reason3;
			self.BankCard_reason4 := left.BankCard_reason4;
			self.BankCard_reason5 := left.BankCard_reason5;
			
	
			self.Attribute_Index := '0';  // initial version of the attributes is index 0
			self.InputProvidedFirstName := left.InputProvidedFirstName;
			self.InputProvidedLastName := left.InputProvidedLastName;
			self.InputProvidedStreetAddress := left.InputProvidedStreetAddress;
			self.InputProvidedCity := left.InputProvidedCity;
			self.InputProvidedState := left.InputProvidedState;
			self.InputProvidedZipCode := left.InputProvidedZipCode;
			self.InputProvidedSSN := left.InputProvidedSSN;
			self.InputProvidedDateofBirth := left.InputProvidedDateofBirth;
			self.InputProvidedPhone := left.InputProvidedPhone;
			self.InputProvidedLexID := left.InputProvidedLexID;
			self.SubjectRecordTimeOldest := left.SubjectRecordTimeOldest;
			self.SubjectRecordTimeNewest := left.SubjectRecordTimeNewest;
			self.SubjectNewestRecord12Month := left.SubjectNewestRecord12Month;
			self.SubjectActivityIndex03Month := left.SubjectActivityIndex03Month;
			self.SubjectActivityIndex06Month := left.SubjectActivityIndex06Month;
			self.SubjectActivityIndex12Month := left.SubjectActivityIndex12Month;
			self.SubjectAge := left.SubjectAge;
			self.SubjectDeceased := left.SubjectDeceased;
			self.SubjectSSNCount := left.SubjectSSNCount;
			self.SubjectStabilityIndex := left.SubjectStabilityIndex;
			self.SubjectStabilityPrimaryFactor := left.SubjectStabilityPrimaryFactor;
			self.SubjectAbilityIndex := left.SubjectAbilityIndex;
			self.SubjectAbilityPrimaryFactor := left.SubjectAbilityPrimaryFactor;
			self.SubjectWillingnessIndex := left.SubjectWillingnessIndex;
			self.SubjectWillingnessPrimaryFactor := left.SubjectWillingnessPrimaryFactor;
			self.ConfirmationSubjectFound := left.ConfirmationSubjectFound;
			self.ConfirmationInputName := left.ConfirmationInputName;
			self.ConfirmationInputDOB := left.ConfirmationInputDOB;
			self.ConfirmationInputSSN := left.ConfirmationInputSSN;
			self.ConfirmationInputAddress := left.ConfirmationInputAddress;
			self.SourceNonDerogProfileIndex := left.SourceNonDerogProfileIndex;
			self.SourceNonDerogCount := left.SourceNonDerogCount;
			self.SourceNonDerogCount03Month := left.SourceNonDerogCount03Month;
			self.SourceNonDerogCount06Month := left.SourceNonDerogCount06Month;
			self.SourceNonDerogCount12Month := left.SourceNonDerogCount12Month;
			self.SourceCredHeaderTimeOldest := left.SourceCredHeaderTimeOldest;
			self.SourceCredHeaderTimeNewest := left.SourceCredHeaderTimeNewest;
			self.SourceVoterRegistration := left.SourceVoterRegistration;
			self.EducationAttendance := left.EducationAttendance;
			self.EducationEvidence := left.EducationEvidence;
			self.EducationProgramAttended := left.EducationProgramAttended;
			self.EducationInstitutionPrivate := left.EducationInstitutionPrivate;
			self.EducationInstitutionRating := left.EducationInstitutionRating;
			self.ProfLicCount := left.ProfLicCount;
			self.ProfLicTypeCategory := left.ProfLicTypeCategory;
			self.BusinessAssociation := left.BusinessAssociation;
			self.BusinessAssociationIndex := left.BusinessAssociationIndex;
			self.BusinessAssociationTimeOldest := left.BusinessAssociationTimeOldest;
			self.BusinessTitleLeadership := left.BusinessTitleLeadership;
			self.AssetIndex := left.AssetIndex;
			self.AssetIndexPrimaryFactor := left.AssetIndexPrimaryFactor;
			self.AssetOwnership := left.AssetOwnership;
			self.AssetProp := left.AssetProp;
			self.AssetPropIndex := left.AssetPropIndex;
			self.AssetPropEverCount := left.AssetPropEverCount;
			self.AssetPropCurrentCount := left.AssetPropCurrentCount;
			self.AssetPropCurrentTaxTotal := left.AssetPropCurrentTaxTotal;
			self.AssetPropPurchaseCount12Month := left.AssetPropPurchaseCount12Month;
			self.AssetPropPurchaseTimeOldest := left.AssetPropPurchaseTimeOldest;
			self.AssetPropPurchaseTimeNewest := left.AssetPropPurchaseTimeNewest;
			self.AssetPropNewestMortgageType := left.AssetPropNewestMortgageType;
			self.AssetPropEverSoldCount := left.AssetPropEverSoldCount;
			self.AssetPropSoldCount12Month := left.AssetPropSoldCount12Month;
			self.AssetPropSaleTimeOldest := left.AssetPropSaleTimeOldest;
			self.AssetPropSaleTimeNewest := left.AssetPropSaleTimeNewest;
			self.AssetPropNewestSalePrice := left.AssetPropNewestSalePrice;
			self.AssetPropSalePurchaseRatio := left.AssetPropSalePurchaseRatio;
			self.AssetPersonal := left.AssetPersonal;
			self.AssetPersonalCount := left.AssetPersonalCount;
			self.PurchaseActivityIndex := left.PurchaseActivityIndex;
			self.PurchaseActivityCount := left.PurchaseActivityCount;
			self.PurchaseActivityDollarTotal := left.PurchaseActivityDollarTotal;
			self.DerogSeverityIndex := left.DerogSeverityIndex;
			self.DerogCount := left.DerogCount;
			self.DerogCount12Month := left.DerogCount12Month;
			self.DerogTimeNewest := left.DerogTimeNewest;
			self.CriminalFelonyCount := left.CriminalFelonyCount;
			self.CriminalFelonyCount12Month := left.CriminalFelonyCount12Month;
			self.CriminalFelonyTimeNewest := left.CriminalFelonyTimeNewest;
			self.CriminalNonFelonyCount := left.CriminalNonFelonyCount;
			self.CriminalNonFelonyCount12Month := left.CriminalNonFelonyCount12Month;
			self.CriminalNonFelonyTimeNewest := left.CriminalNonFelonyTimeNewest;
			self.EvictionCount := left.EvictionCount;
			self.EvictionCount12Month := left.EvictionCount12Month;
			self.EvictionTimeNewest := left.EvictionTimeNewest;
			self.LienJudgmentSeverityIndex := left.LienJudgmentSeverityIndex;
			self.LienJudgmentCount := left.LienJudgmentCount;
			self.LienJudgmentCount12Month := left.LienJudgmentCount12Month;
			self.LienJudgmentSmallClaimsCount := left.LienJudgmentSmallClaimsCount;
			self.LienJudgmentCourtCount := left.LienJudgmentCourtCount;
			self.LienJudgmentTaxCount := left.LienJudgmentTaxCount;
			self.LienJudgmentForeclosureCount := left.LienJudgmentForeclosureCount;
			self.LienJudgmentOtherCount := left.LienJudgmentOtherCount;
			self.LienJudgmentTimeNewest := left.LienJudgmentTimeNewest;
			self.LienJudgmentDollarTotal := left.LienJudgmentDollarTotal;
			self.BankruptcyCount := left.BankruptcyCount;
			self.BankruptcyCount24Month := left.BankruptcyCount24Month;
			self.BankruptcyTimeNewest := left.BankruptcyTimeNewest;
			self.BankruptcyChapter := left.BankruptcyChapter;
			self.BankruptcyStatus := left.BankruptcyStatus;
			self.BankruptcyDismissed24Month := left.BankruptcyDismissed24Month;
			self.ShortTermLoanRequest := left.ShortTermLoanRequest;
			self.ShortTermLoanRequest12Month := left.ShortTermLoanRequest12Month;
			self.ShortTermLoanRequest24Month := left.ShortTermLoanRequest24Month;
			self.InquiryAuto12Month := left.InquiryAuto12Month;
			self.InquiryBanking12Month := left.InquiryBanking12Month;
			self.InquiryTelcom12Month := left.InquiryTelcom12Month;
			self.InquiryNonShortTerm12Month := left.InquiryNonShortTerm12Month;
			self.InquiryShortTerm12Month := left.InquiryShortTerm12Month;
			self.InquiryCollections12Month := left.InquiryCollections12Month;
			self.SSNSubjectCount := left.SSNSubjectCount;
			self.SSNDeceased := left.SSNDeceased;
			self.SSNDateLowIssued := left.SSNDateLowIssued;
			self.SSNProblems := left.SSNProblems;
			self.AddrOnFileCount := left.AddrOnFileCount;
			self.AddrOnFileCorrectional := left.AddrOnFileCorrectional;
			self.AddrOnFileCollege := left.AddrOnFileCollege;
			self.AddrOnFileHighRisk := left.AddrOnFileHighRisk;
			self.AddrInputTimeOldest := left.AddrInputTimeOldest;
			self.AddrInputTimeNewest := left.AddrInputTimeNewest;
			self.AddrInputLengthOfRes := left.AddrInputLengthOfRes;
			self.AddrInputSubjectCount := left.AddrInputSubjectCount;
			self.AddrInputMatchIndex := left.AddrInputMatchIndex;
			self.AddrInputSubjectOwned := left.AddrInputSubjectOwned;
			self.AddrInputDeedMailing := left.AddrInputDeedMailing;
			self.AddrInputOwnershipIndex := left.AddrInputOwnershipIndex;
			self.AddrInputPhoneService := left.AddrInputPhoneService;
			self.AddrInputPhoneCount := left.AddrInputPhoneCount;
			self.AddrInputDwellType := left.AddrInputDwellType;
			self.AddrInputDwellTypeIndex := left.AddrInputDwellTypeIndex;
			self.AddrInputDelivery := left.AddrInputDelivery;
			self.AddrInputTimeLastSale := left.AddrInputTimeLastSale;
			self.AddrInputLastSalePrice := left.AddrInputLastSalePrice;
			self.AddrInputTaxValue := left.AddrInputTaxValue;
			self.AddrInputTaxYr := left.AddrInputTaxYr;
			self.AddrInputTaxMarketValue := left.AddrInputTaxMarketValue;
			self.AddrInputAVMValue := left.AddrInputAVMValue;
			self.AddrInputAVMValue12Month := left.AddrInputAVMValue12Month;
			self.AddrInputAVMRatio12MonthPrior := left.AddrInputAVMRatio12MonthPrior;
			self.AddrInputAVMValue60Month := left.AddrInputAVMValue60Month;
			self.AddrInputAVMRatio60MonthPrior := left.AddrInputAVMRatio60MonthPrior;
			self.AddrInputCountyRatio := left.AddrInputCountyRatio;
			self.AddrInputTractRatio := left.AddrInputTractRatio;
			self.AddrInputBlockRatio := left.AddrInputBlockRatio;
			self.AddrInputProblems := left.AddrInputProblems;
			self.AddrCurrentTimeOldest := left.AddrCurrentTimeOldest;
			self.AddrCurrentTimeNewest := left.AddrCurrentTimeNewest;
			self.AddrCurrentLengthOfRes := left.AddrCurrentLengthOfRes;
			self.AddrCurrentSubjectOwned := left.AddrCurrentSubjectOwned;
			self.AddrCurrentDeedMailing := left.AddrCurrentDeedMailing;
			self.AddrCurrentOwnershipIndex := left.AddrCurrentOwnershipIndex;
			self.AddrCurrentPhoneService := left.AddrCurrentPhoneService;
			self.AddrCurrentDwellType := left.AddrCurrentDwellType;
			self.AddrCurrentDwellTypeIndex := left.AddrCurrentDwellTypeIndex;
			self.AddrCurrentTimeLastSale := left.AddrCurrentTimeLastSale;
			self.AddrCurrentLastSalesPrice := left.AddrCurrentLastSalesPrice;
			self.AddrCurrentTaxValue := left.AddrCurrentTaxValue;
			self.AddrCurrentTaxYr := left.AddrCurrentTaxYr;
			self.AddrCurrentTaxMarketValue := left.AddrCurrentTaxMarketValue;
			self.AddrCurrentAVMValue := left.AddrCurrentAVMValue;
			self.AddrCurrentAVMValue12Month := left.AddrCurrentAVMValue12Month;
			self.AddrCurrentAVMRatio12MonthPrior := left.AddrCurrentAVMRatio12MonthPrior;
			self.AddrCurrentAVMValue60Month := left.AddrCurrentAVMValue60Month;
			self.AddrCurrentAVMRatio60MonthPrior := left.AddrCurrentAVMRatio60MonthPrior;
			self.AddrCurrentCountyRatio := left.AddrCurrentCountyRatio;
			self.AddrCurrentTractRatio := left.AddrCurrentTractRatio;
			self.AddrCurrentBlockRatio := left.AddrCurrentBlockRatio;
			self.AddrCurrentCorrectional := left.AddrCurrentCorrectional;
			self.AddrPreviousTimeOldest := left.AddrPreviousTimeOldest;
			self.AddrPreviousTimeNewest := left.AddrPreviousTimeNewest;
			self.AddrPreviousLengthOfRes := left.AddrPreviousLengthOfRes;
			self.AddrPreviousSubjectOwned := left.AddrPreviousSubjectOwned;
			self.AddrPreviousOwnershipIndex := left.AddrPreviousOwnershipIndex;
			self.AddrPreviousDwellType := left.AddrPreviousDwellType;
			self.AddrPreviousDwellTypeIndex := left.AddrPreviousDwellTypeIndex;
			self.AddrPreviousCorrectional := left.AddrPreviousCorrectional;
			self.AddrStabilityIndex := left.AddrStabilityIndex;
			self.AddrChangeCount03Month := left.AddrChangeCount03Month;
			self.AddrChangeCount06Month := left.AddrChangeCount06Month;
			self.AddrChangeCount12Month := left.AddrChangeCount12Month;
			self.AddrChangeCount24Month := left.AddrChangeCount24Month;
			self.AddrChangeCount60Month := left.AddrChangeCount60Month;
			self.AddrLastMoveTaxRatioDiff := left.AddrLastMoveTaxRatioDiff;
			self.AddrLastMoveEconTrajectory := left.AddrLastMoveEconTrajectory;
			self.AddrLastMoveEconTrajectoryIndex := left.AddrLastMoveEconTrajectoryIndex;
			self.PhoneInputProblems := left.PhoneInputProblems;
			self.PhoneInputSubjectCount := left.PhoneInputSubjectCount;
			self.PhoneInputMobile := left.PhoneInputMobile;
			self.AlertRegulatoryCondition := left.AlertRegulatoryCondition;
			self.Alert1 := left.Alert1;
			self.Alert2 := left.Alert2;
			self.Alert3 := left.Alert3;
			self.Alert4 := left.Alert4;
			self.Alert5 := left.Alert5;
			self.Alert6 := left.Alert6;
			self.Alert7 := left.Alert7;
			self.Alert8 := left.Alert8;
			self.Alert9 := left.Alert9;
			self.Alert10 := left.Alert10;
			// self.errorcode := left.errorcode;
			self := left;
			self := []));		
			
		// output(flattened_result, named('flattened'));


	  //Appeding internal extras to Soap output file 
Global_output_lay normit(flattened_result L, soap_input R) := TRANSFORM
			self.did := (integer)l.lexid; 
			self.FNamePop := r.batch_in[1].RX_unparsedfullname<>'';
			self.LNamePop := r.batch_in[1].RX_unparsedfullname<>'';
			self.AddrPop := r.batch_in[1].Address1<>'';
			self.SSNLength := (STRING)(length(trim(r.batch_in[1].RX_SSN,left,right))) ;

		  self := L;
			self := [];
END;
				
		ds_with_extras := JOIN(flattened_result,soap_input,LEFT.acctno=(STRING)(unsigned)RIGHT.batch_in[1].acctno,normit(LEFT,RIGHT)); //has leading zeros, this  removes them
output(didville_Soap_output, named('didville_Soap_output'));

		// final file out to thor
		output(ds_with_extras ,,outfile_name, thor, compressed, overwrite);
	// final_output :=	sequential(check_point_output, final);
		// output(ds_with_extras,named('ds_with_extras'));
		
		RETURN 0;
		// return check_point_output;
ENDMACRO; 


