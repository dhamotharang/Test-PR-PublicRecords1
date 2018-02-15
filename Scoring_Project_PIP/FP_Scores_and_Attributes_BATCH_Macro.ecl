﻿EXPORT FP_Scores_and_Attributes_BATCH_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT ut, Risk_Indicators,iESP, riskwise, models, RiskProcessing, doxie, scoring;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 10;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
    String roxieIP := roxie_ip ; 
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;
  	Gateway := DATASET([], Gateway.Layouts.Config);

		//*********** SETTINGS ********************************

		DPPA:=Scoring_Project_PIP.User_Settings_Module.FP_V2_BATCH_Generic_FP1109_0_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.FP_V2_BATCH_Generic_FP1109_0_settings.GLB;
		DRM:=Scoring_Project_PIP.User_Settings_Module.FP_V2_BATCH_Generic_FP1109_0_settings.DRM;
		IncludeVersion2:=Scoring_Project_PIP.User_Settings_Module.FP_V2_BATCH_Generic_FP1109_0_settings.IncludeVersion2;
    HistoryDate := 999999;

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	
	
    layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

		ds_raw_input := IF(no_of_records = 0, dataset(Infile_name, layout_input, thor), choosen(dataset ( Infile_name, layout_input, thor), no_of_records));
	    
		//*********** FP Scores and Attributes BATCH SETUP AND SOAPCALL ******************														 
		
		fp_batch_in := RECORD
			risk_indicators.Layout_Batch_In;
			string5 Grade := '';
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
		END;

		layout_soap_input := RECORD
			string30 orig_account;
			dataset(fp_batch_in) batch_in;
			INTEGER GLBPurpose;
			INTEGER DPPAPurpose;
			string DataRestrictionMask;		
			boolean IncludeVersion2;
			string ModelName;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
		END;

		fp_batch_in make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			self.AcctNo := (string)le.accountnumber;
			self.SSN := le.SSN;
			self.Name_First := le.FirstName ;
			self.Name_Middle := le.MiddleName ;
			self.Name_Last := le.LastName ;
			self.DOB := le.DateOfBirth ;
			self.street_addr := le.StreetAddress ;
			self.p_City_name := le.CITY ;
			self.St := le.STATE ;
			self.Z5 := le.ZIP ;
			self.DL_Number := le.DLNumber ;
			self.DL_State := le.DLState ;
			self.Home_Phone := le.HomePhone ;
			self.Work_Phone := le.WorkPhone ;
			self.HistoryDateYYYYMM := HistoryDate;
			self := [];
		END;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			self.orig_account :=(string) le.accountnumber;
			self.batch_in := project(le, make_batch_in(left, c));
			SELF.DPPAPurpose := DPPA;
			SELF.GLBPurpose := GLB;
			self.DataRestrictionMask := DRM;  
		  self.ModelName := 'fp1109_0'; 
			self.IncludeVersion2 := true;
			self.gateways := dataset([{'', ''}], risk_indicators.Layout_Gateways_In);
			SELF := le;
			self := [];
		END;
		
		Input_all := project(ds_raw_input, append_settings(left, counter));

	  Input_trim := Input_all( trim(batch_in[1].name_first)<>'' and 
								trim(batch_in[1].name_last)<>'' and
								(trim(batch_in[1].ssn)<>'' or 
								(trim(batch_in[1].street_addr)<>'' and trim(batch_in[1].Z5)<>'') ));
		
		 //ds_soap_in
		 soap_in := distribute(Input_trim, random());

		//Soap output layout
		layout_Soap_output := RECORD
			models.Layout_FD_Batch_Out;
			string200 errorcode;
		END;

		layout_Soap_output myFail1(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF.acctno := le.orig_account;
			SELF := le;
			SELF := [];
		END;

		//*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		Soap_output := soapcall(soap_in, roxieIP,
						'Models.FraudAdvisor_Batch_Service', {soap_in}, 
						DATASET(layout_Soap_output),
						PARALLEL(threads), 
						RETRY(retry), TIMEOUT(timeout),
						onFail(myFail1(LEFT)));
						
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
				
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout;			 
		END;

		ds_slim := join(Soap_output, soap_in, left.acctno=right.batch_in[1].acctno,
	  	TRANSFORM(Global_output_lay,
				self.AcctNo := right.orig_account;
				self.historydate := (string)right.batch_in[1].historydateyyyymm;
				self.FP_score := left.score1 ;
				self.FP_reason := left.reason1 ;
				self.FP_reason2 := left.reason2 ;
				self.FP_reason3 := left.reason3 ;
				self.FP_reason4 := left.reason4 ;
				self.FP_reason5 := left.reason5 ;
				self.FP_reason6 := left.reason6 ;
				self.IdentityRiskLevel := left.v2_IdentityRiskLevel     ;
				self.IdentityAgeOldest := left.v2_IdentityAgeOldest     ;
				self.IdentityAgeNewest := left.v2_IdentityAgeNewest     ;
				self.IdentityRecentUpdate := left.v2_IdentityRecentUpdate     ;
				self.IdentityRecordCount := left.v2_IdentityRecordCount     ;
				self.IdentitySourceCount := left.v2_IdentitySourceCount     ;
				self.IdentityAgeRiskIndicator := left.v2_IdentityAgeRiskIndicator     ;
				self.IDVerRiskLevel := left.v2_IDVerRiskLevel     ;
				self.IDVerSSN := left.v2_IDVerSSN     ;
				self.IDVerName := left.v2_IDVerName     ;
				self.IDVerAddress := left.v2_IDVerAddress     ;
				self.IDVerAddressNotCurrent := left.v2_IDVerAddressNotCurrent     ;
				self.IDVerAddressAssocCount := left.v2_IDVerAddressAssocCount     ;
				self.IDVerPhone := left.v2_IDVerPhone     ;
				self.IDVerDriversLicense  := left.v2_IDVerDriversLicense     ;
				self.IDVerDOB := left.v2_IDVerDOB     ;
				self.IDVerSSNSourceCount := left.v2_IDVerSSNSourceCount     ;
				self.IDVerAddressSourceCount := left.v2_IDVerAddressSourceCount     ;
				self.IDVerDOBSourceCount := left.v2_IDVerDOBSourceCount     ;
        self.IDVerSSNCreditBureauCount := if(trim(left.v2_IDVerSSNCreditBureauCount)='-', '-1', left.v2_IDVerSSNCreditBureauCount);
			  self.IDVerSSNCreditBureauDelete     := left.v2_IDVerSSNCreditBureauDelete     ;
				self.IDVerAddrCreditBureauCount     := left.v2_IDVerAddrCreditBureauCount     ;
				self.SourceRiskLevel     := left.v2_SourceRiskLevel     ;
				self.SourceFirstReportingIdentity     := left.v2_SourceFirstReportingIdentity     ;
				self.SourceCreditBureau     := left.v2_SourceCreditBureau     ;
				self.SourceCreditBureauCount     := left.v2_SourceCreditBureauCount     ;
				self.SourceCreditBureauAgeOldest     := left.v2_SourceCreditBureauAgeOldest     ;
				self.SourceCreditBureauAgeNewest     := left.v2_SourceCreditBureauAgeNewest     ;
				self.SourceCreditBureauAgeChange     := left.v2_SourceCreditBureauAgeChange     ;
				self.SourcePublicRecord     := left.v2_SourcePublicRecord     ;
				self.SourcePublicRecordCount     := left.v2_SourcePublicRecordCount     ;
				self.SourcePublicRecordCountYear     := left.v2_SourcePublicRecordCountYear     ;
				self.SourceEducation     := left.v2_SourceEducation     ;
				self.SourceOccupationalLicense     := left.v2_SourceOccupationalLicense     ;
				self.SourceVoterRegistration     := left.v2_SourceVoterRegistration     ;
				self.SourceOnlineDirectory     := left.v2_SourceOnlineDirectory     ;
				self.SourceDoNotMail     := left.v2_SourceDoNotMail     ;
				self.SourceAccidents     := left.v2_SourceAccidents     ;
				self.SourceBusinessRecords     := left.v2_SourceBusinessRecords     ;
				self.SourceProperty     := left.v2_SourceProperty     ;
				self.SourceAssets     := left.v2_SourceAssets     ;
				self.SourcePhoneDirectoryAssistance     := left.v2_SourcePhoneDirectoryAssistance     ;
				self.SourcePhoneNonPublicDirectory     := left.v2_SourcePhoneNonPublicDirectory     ;
				self.VariationRiskLevel     := left.v2_VariationRiskLevel     ;
				self.VariationIdentityCount     := left.v2_VariationIdentityCount     ;
				self.VariationSSNCount     := left.v2_VariationSSNCount     ;
				self.VariationSSNCountNew     := left.v2_VariationSSNCountNew     ;
				self.VariationMSourcesSSNCount     := left.v2_VariationMSourcesSSNCount     ;
				self.VariationMSourcesSSNUnrelCount     := left.v2_VariationMSourcesSSNUnrelCount     ;
				self.VariationLastNameCount     := left.v2_VariationLastNameCount     ;
				self.VariationLastNameCountNew     := left.v2_VariationLastNameCountNew     ;
				self.VariationAddrCountYear     := left.v2_VariationAddrCountYear     ;
				self.VariationAddrCountNew     := left.v2_VariationAddrCountNew     ;
				self.VariationAddrStability     := left.v2_VariationAddrStability     ;
				self.VariationAddrChangeAge     := left.v2_VariationAddrChangeAge     ;
				self.VariationDOBCount     := left.v2_VariationDOBCount     ;
				self.VariationDOBCountNew     := left.v2_VariationDOBCountNew     ;
				self.VariationPhoneCount     := left.v2_VariationPhoneCount     ;
				self.VariationPhoneCountNew     := left.v2_VariationPhoneCountNew     ;
				self.VariationSearchSSNCount     := left.v2_VariationSearchSSNCount     ;
				self.VariationSearchAddrCount     := left.v2_VariationSearchAddrCount     ;
				self.VariationSearchPhoneCount     := left.v2_VariationSearchPhoneCount     ;
				self.SearchVelocityRiskLevel     := left.v2_SearchVelocityRiskLevel     ;
				self.SearchCount     := left.v2_SearchCount     ;
				self.SearchCountYear     := left.v2_SearchCountYear     ;
				self.SearchCountMonth     := left.v2_SearchCountMonth     ;
				self.SearchCountWeek     := left.v2_SearchCountWeek     ;
				self.SearchCountDay     := left.v2_SearchCountDay     ;
				self.SearchUnverifiedSSNCountYear     := left.v2_SearchUnverifiedSSNCountYear     ;
				self.SearchUnverifiedAddrCountYear     := left.v2_SearchUnverifiedAddrCountYear     ;
				self.SearchUnverifiedDOBCountYear     := left.v2_SearchUnverifiedDOBCountYear     ;
				self.SearchUnverifiedPhoneCountYear     := left.v2_SearchUnverifiedPhoneCountYear     ;
				self.SearchBankingSearchCount     := left.v2_SearchBankingSearchCount     ;
				self.SearchBankingSearchCountYear     := left.v2_SearchBankingSearchCountYear     ;
				self.SearchBankingSearchCountMonth     := left.v2_SearchBankingSearchCountMonth     ;
				self.SearchBankingSearchCountWeek     := left.v2_SearchBankingSearchCountWeek     ;
				self.SearchBankingSearchCountDay     := left.v2_SearchBankingSearchCountDay     ;
				self.SearchHighRiskSearchCount     := left.v2_SearchHighRiskSearchCount     ;
				self.SearchHighRiskSearchCountYear     := left.v2_SearchHighRiskSearchCountYear     ;
				self.SearchHighRiskSearchCountMonth     := left.v2_SearchHighRiskSearchCountMonth     ;
				self.SearchHighRiskSearchCountWeek     := left.v2_SearchHighRiskSearchCountWeek     ;
				self.SearchHighRiskSearchCountDay     := left.v2_SearchHighRiskSearchCountDay     ;
				self.SearchFraudSearchCount     := left.v2_SearchFraudSearchCount     ;
				self.SearchFraudSearchCountYear     := left.v2_SearchFraudSearchCountYear     ;
				self.SearchFraudSearchCountMonth     := left.v2_SearchFraudSearchCountMonth     ;
				self.SearchFraudSearchCountWeek     := left.v2_SearchFraudSearchCountWeek     ;
				self.SearchFraudSearchCountDay     := left.v2_SearchFraudSearchCountDay     ;
				self.SearchLocateSearchCount     := left.v2_SearchLocateSearchCount     ;
				self.SearchLocateSearchCountYear     := left.v2_SearchLocateSearchCountYear     ;
				self.SearchLocateSearchCountMonth     := left.v2_SearchLocateSearchCountMonth     ;
				self.SearchLocateSearchCountWeek     := left.v2_SearchLocateSearchCountWeek     ;
				self.SearchLocateSearchCountDay     := left.v2_SearchLocateSearchCountDay     ;
				self.AssocRiskLevel     := left.v2_AssocRiskLevel     ;
				self.AssocCount     := left.v2_AssocCount     ;
				self.AssocDistanceClosest     := left.v2_AssocDistanceClosest     ;
				self.AssocSuspicousIdentitiesCount     := left.v2_AssocSuspicousIdentitiesCount     ;
				self.AssocCreditBureauOnlyCount     := left.v2_AssocCreditBureauOnlyCount     ;
				self.AssocCreditBureauOnlyCountNew     := left.v2_AssocCreditBureauOnlyCountNew     ;
				self.AssocCreditBureauOnlyCountMonth     := left.v2_AssocCreditBureauOnlyCountMonth     ;
				self.AssocHighRiskTopologyCount     := left.v2_AssocHighRiskTopologyCount     ;
				self.ValidationRiskLevel     := left.v2_ValidationRiskLevel     ;
				self.ValidationSSNProblems     := left.v2_ValidationSSNProblems     ;
				self.ValidationAddrProblems     := left.v2_ValidationAddrProblems     ;
				self.ValidationPhoneProblems     := left.v2_ValidationPhoneProblems     ;
				self.ValidationDLProblems     := left.v2_ValidationDLProblems     ;
				self.ValidationIPProblems     := left.v2_ValidationIPProblems     ;
				self.CorrelationRiskLevel     := left.v2_CorrelationRiskLevel     ;
				self.CorrelationSSNNameCount     := left.v2_CorrelationSSNNameCount     ;
				self.CorrelationSSNAddrCount     := left.v2_CorrelationSSNAddrCount     ;
				self.CorrelationAddrNameCount     := left.v2_CorrelationAddrNameCount     ;
				self.CorrelationAddrPhoneCount     := left.v2_CorrelationAddrPhoneCount     ;
				self.CorrelationPhoneLastNameCount     := left.v2_CorrelationPhoneLastNameCount     ;
				self.DivRiskLevel     := left.v2_DivRiskLevel     ;
				self.DivSSNIdentityCount     := left.v2_DivSSNIdentityCount     ;
				self.DivSSNIdentityCountNew     := left.v2_DivSSNIdentityCountNew     ;
				self.DivSSNIdentityMSourceCount     := left.v2_DivSSNIdentityMSourceCount     ;
				self.DivSSNIdentityMSourceUrelCount     := left.v2_DivSSNIdentityMSourceUrelCount     ;
				self.DivSSNLNameCount     := left.v2_DivSSNLNameCount     ;
				self.DivSSNLNameCountNew     := left.v2_DivSSNLNameCountNew     ;
				self.DivSSNAddrCount     := left.v2_DivSSNAddrCount     ;
				self.DivSSNAddrCountNew     := left.v2_DivSSNAddrCountNew     ;
				self.DivSSNAddrMSourceCount     := left.v2_DivSSNAddrMSourceCount     ;
				self.DivAddrIdentityCount     := left.v2_DivAddrIdentityCount     ;
				self.DivAddrIdentityCountNew     := left.v2_DivAddrIdentityCountNew     ;
				self.DivAddrIdentityMSourceCount     := left.v2_DivAddrIdentityMSourceCount     ;
				self.DivAddrSuspIdentityCountNew     := left.v2_DivAddrSuspIdentityCountNew     ;
				self.DivAddrSSNCount     := left.v2_DivAddrSSNCount     ;
				self.DivAddrSSNCountNew     := left.v2_DivAddrSSNCountNew     ;
				self.DivAddrSSNMSourceCount     := left.v2_DivAddrSSNMSourceCount     ;
				self.DivAddrPhoneCount     := left.v2_DivAddrPhoneCount     ;
				self.DivAddrPhoneCountNew     := left.v2_DivAddrPhoneCountNew     ;
				self.DivAddrPhoneMSourceCount     := left.v2_DivAddrPhoneMSourceCount     ;
				self.DivPhoneIdentityCount     := left.v2_DivPhoneIdentityCount     ;
				self.DivPhoneIdentityCountNew     := left.v2_DivPhoneIdentityCountNew     ;
				self.DivPhoneIdentityMSourceCount     := left.v2_DivPhoneIdentityMSourceCount     ;
				self.DivPhoneAddrCount     := left.v2_DivPhoneAddrCount     ;
				self.DivPhoneAddrCountNew     := left.v2_DivPhoneAddrCountNew     ;
				self.DivSearchSSNIdentityCount     := left.v2_DivSearchSSNIdentityCount     ;
				self.DivSearchAddrIdentityCount     := left.v2_DivSearchAddrIdentityCount     ;
				self.DivSearchAddrSuspIdentityCount     := left.v2_DivSearchAddrSuspIdentityCount     ;
				self.DivSearchPhoneIdentityCount     := left.v2_DivSearchPhoneIdentityCount     ;
				self.SearchComponentRiskLevel     := left.v2_SearchComponentRiskLevel     ;
				self.SearchSSNSearchCount     := left.v2_SearchSSNSearchCount     ;
				self.SearchSSNSearchCountYear     := left.v2_SearchSSNSearchCountYear     ;
				self.SearchSSNSearchCountMonth     := left.v2_SearchSSNSearchCountMonth     ;
				self.SearchSSNSearchCountWeek     := left.v2_SearchSSNSearchCountWeek     ;
				self.SearchSSNSearchCountDay     := left.v2_SearchSSNSearchCountDay     ;
				self.SearchAddrSearchCount     := left.v2_SearchAddrSearchCount     ;
				self.SearchAddrSearchCountYear     := left.v2_SearchAddrSearchCountYear     ;
				self.SearchAddrSearchCountMonth     := left.v2_SearchAddrSearchCountMonth     ;
				self.SearchAddrSearchCountWeek     := left.v2_SearchAddrSearchCountWeek     ;
				self.SearchAddrSearchCountDay     := left.v2_SearchAddrSearchCountDay     ;
				self.SearchPhoneSearchCount     := left.v2_SearchPhoneSearchCount     ;
				self.SearchPhoneSearchCountYear     := left.v2_SearchPhoneSearchCountYear     ;
				self.SearchPhoneSearchCountMonth     := left.v2_SearchPhoneSearchCountMonth     ;
				self.SearchPhoneSearchCountWeek     := left.v2_SearchPhoneSearchCountWeek     ;
				self.SearchPhoneSearchCountDay     := left.v2_SearchPhoneSearchCountDay     ;
				self.ComponentCharRiskLevel     := left.v2_ComponentCharRiskLevel     ;
				self.SSNHighIssueAge     := left.v2_SSNHighIssueAge     ;
				self.SSNLowIssueAge     := left.v2_SSNLowIssueAge     ;
				self.SSNIssueState     := left.v2_SSNIssueState     ;
				self.SSNNonUS     := left.v2_SSNNonUS     ;
				self.InputPhoneType     := left.v2_InputPhoneType     ;
				self.IPState    := left.v2_IPState    ;
				self.IPCountry    := left.v2_IPCountry    ;
				self.IPContinent    := left.v2_IPContinent    ;
				self.InputAddrAgeOldest     := left.v2_InputAddrAgeOldest     ;
				self.InputAddrAgeNewest     := left.v2_InputAddrAgeNewest     ;
				self.InputAddrType     := left.v2_InputAddrType     ;
				self.InputAddrLenOfRes     := left.v2_InputAddrLenOfRes     ;
				self.InputAddrDwellType     := left.v2_InputAddrDwellType     ;
				self.InputAddrDelivery     := left.v2_InputAddrDelivery     ;
				self.InputAddrActivePhoneList     := left.v2_InputAddrActivePhoneList     ;
				self.InputAddrOccupantOwned     := left.v2_InputAddrOccupantOwned     ;
				self.InputAddrBusinessCount     := left.v2_InputAddrBusinessCount     ;
				self.InputAddrNBRHDBusinessCount     := left.v2_InputAddrNBRHDBusinessCount     ;
				self.InputAddrNBRHDSingleFamilyCount     := left.v2_InputAddrNBRHDSingleFamilyCount     ;
				self.InputAddrNBRHDMultiFamilyCount     := left.v2_InputAddrNBRHDMultiFamilyCount     ;
				self.InputAddrNBRHDMedianIncome     := left.v2_InputAddrNBRHDMedianIncome     ;
				self.InputAddrNBRHDMedianValue     := left.v2_InputAddrNBRHDMedianValue     ;
				self.InputAddrNBRHDMurderIndex     := left.v2_InputAddrNBRHDMurderIndex     ;
				self.InputAddrNBRHDCarTheftIndex     := left.v2_InputAddrNBRHDCarTheftIndex     ;
				self.InputAddrNBRHDBurglaryIndex     := left.v2_InputAddrNBRHDBurglaryIndex     ;
				self.InputAddrNBRHDCrimeIndex     := left.v2_InputAddrNBRHDCrimeIndex     ;
				self.InputAddrNBRHDMobilityIndex     := left.v2_InputAddrNBRHDMobilityIndex     ;
				self.InputAddrNBRHDVacantPropCount     := left.v2_InputAddrNBRHDVacantPropCount     ;
				self.AddrChangeDistance     := left.v2_AddrChangeDistance     ;
				self.AddrChangeStateDiff     := left.v2_AddrChangeStateDiff     ;
				self.AddrChangeIncomeDiff     := left.v2_AddrChangeIncomeDiff     ;
				self.AddrChangeValueDiff     := left.v2_AddrChangeValueDiff     ;
				self.AddrChangeCrimeDiff     := left.v2_AddrChangeCrimeDiff     ;
				self.AddrChangeEconTrajectory     := left.v2_AddrChangeEconTrajectory     ;
				self.AddrChangeEconTrajectoryIndex     := left.v2_AddrChangeEconTrajectoryIndex     ;
				self.CurrAddrAgeOldest     := left.v2_CurrAddrAgeOldest     ;
				self.CurrAddrAgeNewest     := left.v2_CurrAddrAgeNewest     ;
				self.CurrAddrLenOfRes     := left.v2_CurrAddrLenOfRes     ;
				self.CurrAddrDwellType     := left.v2_CurrAddrDwellType     ;
				self.CurrAddrStatus     := left.v2_CurrAddrStatus     ;
				self.CurrAddrActivePhoneList     := left.v2_CurrAddrActivePhoneList     ;
				self.CurrAddrMedianIncome     := left.v2_CurrAddrMedianIncome     ;
				self.CurrAddrMedianValue     := left.v2_CurrAddrMedianValue     ;
				self.CurrAddrMurderIndex     := left.v2_CurrAddrMurderIndex     ;
				self.CurrAddrCarTheftIndex     := left.v2_CurrAddrCarTheftIndex     ;
				self.CurrAddrBurglaryIndex     := left.v2_CurrAddrBurglaryIndex     ;
				self.CurrAddrCrimeIndex     := left.v2_CurrAddrCrimeIndex     ;
				self.PrevAddrAgeOldest     := left.v2_PrevAddrAgeOldest     ;
				self.PrevAddrAgeNewest     := left.v2_PrevAddrAgeNewest     ;
				self.PrevAddrLenOfRes     := left.v2_PrevAddrLenOfRes     ;
				self.PrevAddrDwellType     := left.v2_PrevAddrDwellType     ;
				self.PrevAddrStatus     := left.v2_PrevAddrStatus     ;
				self.PrevAddrOccupantOwned     := left.v2_PrevAddrOccupantOwned     ;
				self.PrevAddrMedianIncome     := left.v2_PrevAddrMedianIncome     ;
				self.PrevAddrMedianValue     := left.v2_PrevAddrMedianValue     ;
				self.PrevAddrMurderIndex     := left.v2_PrevAddrMurderIndex     ;
				self.PrevAddrCarTheftIndex     := left.v2_PrevAddrCarTheftIndex     ;
				self.PrevAddrBurglaryIndex     := left.v2_PrevAddrBurglaryIndex     ;
				self.PrevAddrCrimeIndex     := left.v2_PrevAddrCrimeIndex     ;
				self := left;
		    self:= []));

    fdInput_errors := join(Input_all, Input_trim, left.batch_in[1].acctno=right.batch_in[1].acctno, transform(Global_output_lay,
																																																								self.errorcode := doxie.ErrorCodes(301);
																																																								self.AcctNo := left.orig_account;
																																																								self.historydate := (string)left.batch_in[1].historydateyyyymm;
																																																								self := [];
																																																						 ), left only);


    final := sort(ungroup(ds_slim + fdInput_errors), AcctNo);
    
		// calling IID macro to capture DID for appending to final output 	
		did_results :=  Scoring_Project_PIP.IID_macro(ds_raw_input,threads,roxieIP,DPPA,GLB,DRM,HistoryDate); 
				
		//**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS *************************** 
		did_append_ds:=JOIN(final, did_results, LEFT.AcctNo = (STRING)RIGHT.AcctNo,
																TRANSFORM(Global_output_lay,
																						SELF.DID := RIGHT.DID;   									
																						SELF := LEFT;   						
																          ),left outer);

		//Appeding additional internal extras to Soap output file 
		ds_with_extras := JOIN(did_append_ds, soap_in, LEFT.AcctNo = (STRING)RIGHT.batch_in[1].acctno,
																TRANSFORM(Global_output_lay,
																						self.historydate := (string)RIGHT.batch_in[1].HistoryDateYYYYMM;
																						self.FNamePop := RIGHT.batch_in[1].Name_First<>'';
																						self.LNamePop := RIGHT.batch_in[1].Name_Last<>'';
																						self.AddrPop := RIGHT.batch_in[1].street_addr<>'';
																						self.SSNLength := (string)(length(trim(RIGHT.batch_in[1].ssn,left,right))) ;
																						self.DOBPop := RIGHT.batch_in[1].dob<>'';
																						self.IPAddrPop := RIGHT.batch_in[1].ip_addr<>''; 
																						self.HPhnPop := RIGHT.batch_in[1].Home_Phone<>'';
																					 self := left;
																					 self := []
																         ));
			 
	  //final file out to thor
		final_output := output(ds_with_extras,, outfile_name, thor, compressed, OVERWRITE);
   
	  RETURN final_output;

ENDMACRO;