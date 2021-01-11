EXPORT LI_Score_Attributes_V4_Batch_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name1_score, Output_file_name2_attr, records_ToRun):= FUNCTIONMacro

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := Retry;
		integer timeout := Timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		model := 'msn1106_0' ;
		gateways := Gateway_dummy;
		Infile_name :=  Input_file_name;
		String outfile_name1 :=  Output_file_name1_score ;
		String outfile_name2 :=  Output_file_name2_attr ;

	DRM:=Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.DRM;
		DPPA:=Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.GLB;
		isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.isFCRA=true,'FCRA','NONFCRA');
		IncludeVersion4:=if(Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_BATCH_Generic_msn1106_0_settings.IncludeVersion4,4,3);
		HistoryDate := 999999;

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************

	
		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;
	
		ds_raw_input := distribute(IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records)),(integer)accountnumber);
    //*********** LI Scores V4 BATCH SETUP AND SOAPCALL ******************

		layout_soap_input := RECORD
			DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
			DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
			STRING DataRestrictionMask;
			INTEGER Version;
			INTEGER HistoryDateYYYYMM;
			BOOLEAN ADL_Based_Shell;
			STRING ModelName:= '';
		END;

		Risk_Indicators.Layout_Batch_In make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			SELF.seq := c;
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
			SELF.historydateyyyymm := 999999 ;
			SELF := le;
			SELF := [];
		END;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			SELF.batch_in := batch;
			SELF.gateways := DATASET([{isFCRA, roxieIP}], risk_indicators.layout_gateways_in);
			SELF.Version := IncludeVersion4;
			SELF.adl_based_shell := true;
			SELF.ModelName:= model ;
			SELF.DataRestrictionMask := DRM;  
		  SELF.HistoryDateYYYYMM := HistoryDate;
			END;
			
		//ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
		
    //Soap output layout
		layout_Soap_output := RECORD
			unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 		
			models.layouts.layout_LeadIntegrity_attributes_batch_flattened 	;
			STRING errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF.acctno:=le.batch_in[1].acctno;
			SELF := le;
			SELF := [];
		END;
					
		//*********** PERFORMING SOAPCALL TO ROXIE ************ 
		 
		Soap_output := SOAPCALL(soap_in, roxieIP,
						'Models.LeadIntegrity_Batch_Service', {soap_in}, 
						DATASET(layout_Soap_output),
						PARALLEL(threads), onFail(myFail(LEFT)));				
		
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
											
	  //GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout;			 
		END;

			Global_output_lay v4_trans(Soap_output le ) := TRANSFORM
				self.time_ms := le.time_ms;
				self.seq    := le.seq;
				self.acctno := le.acctno ;
				self.score  := le.score1;
				self.rc1    := le.reason1;
				self.rc2    := le.reason2;
				self.rc3    := le.reason3;
				self.rc4    := le.reason4;	
					self.did		:= (integer)le.did;
				self:=le;
				self:=[];								
			END;

		ds_slim := project(Soap_output, v4_trans(left));

	  // calling IID macro to capture DID for appending to final output 		
	  // did_results:=Scoring_Project_PIP.IID_macro(ds_raw_input,threads,roxieIP,DPPA,GLB,DRM,HistoryDate);  
	
	  //**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS *************************** 
		
		// res:=JOIN(ds_slim, Soap_output, LEFT.acctno = (STRING)RIGHT.AcctNo,
																// TRANSFORM(Global_output_lay,
																// SELF.DID := RIGHT.DID;   									
																// SELF := LEFT;   						
																// ), left outer);

		//Appeding additional internal extras to Soap output file 
		ds_with_extras := JOIN(ds_slim, soap_in, LEFT.acctno = (STRING)RIGHT.batch_in[1].acctno,
																TRANSFORM(Global_output_lay,
																self.historydate := (string)right.batch_in[1].HistoryDateYYYYMM;
																self.FNamePop := right.batch_in[1].Name_First<>'';
																self.LNamePop := right.batch_in[1].Name_Last<>'';
																self.AddrPop := right.batch_in[1].street_addr<>'';
																self.SSNLength := (string)(length(trim(right.batch_in[1].ssn,left,right))) ;
																self.DOBPop := right.batch_in[1].dob<>'';
																self.IPAddrPop := right.batch_in[1].ip_addr<>''; 
																self.HPhnPop := right.batch_in[1].Home_Phone<>'';
																self := left;
																self := []
																));
										
		//final file out to thor
		// final_output := output(ds_with_extras);

Global_output_lay2:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout;			 
		END;

		Global_output_lay2 v4_trans2(Soap_output le ) := TRANSFORM
			self.time_ms := le.time_ms;
		self.accountnumber := le.acctno ; 
			self.seq := le.Seq; 
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
			self.identityrisklevel                    	      :=  le.v4_identityrisklevel               ;
			self.idverrisklevel                       	      :=  le.v4_idverrisklevel                  ;
			self.idveraddressassoccount 			      :=  le.v4_idveraddressassoccount 		 ;
			self.idverssncreditbureaucount 			      :=  le.v4_idverssncreditbureaucount 		 ;
			self.idverssncreditbureaudelete 		      :=  le.v4_idverssncreditbureaudelete 	 ;
			self.sourcerisklevel 				      :=  le.v4_sourcerisklevel 			 ;
			self.sourcewatchlist 				      :=  le.v4_sourcewatchlist 			 ;
			self.sourceorderactivity 			      :=  le.v4_sourceorderactivity 		 ;
			self.sourceordersourcecount 			      :=  le.v4_sourceordersourcecount 		 ;
			self.sourceorderagelastorder 			      :=  le.v4_sourceorderagelastorder 		 ;
			self.variationrisklevel 			      :=  le.v4_variationrisklevel 		 ;
			self.variationidentitycount 			      :=  le.v4_variationidentitycount 		 ;
			self.variationmsourcesssncount 			      :=  le.v4_variationmsourcesssncount 		 ;
			self.variationmsourcesssnunrelcount 		      :=  le.v4_variationmsourcesssnunrelcount  ;
			self.variationdobcount 				      :=  le.v4_variationdobcount 			 ;
			self.variationdobcountnew 			      :=  le.v4_variationdobcountnew 		 ;
			self.searchvelocityrisklevel 			      :=  le.v4_searchvelocityrisklevel 		 ;
			self.searchunverifiedssncountyear 		      :=  le.v4_searchunverifiedssncountyear  ;
			self.searchunverifiedaddrcountyear 		      :=  le.v4_searchunverifiedaddrcountyear  ;
			self.searchunverifieddobcountyear 		      :=  le.v4_searchunverifieddobcountyear  ;
			self.searchunverifiedphonecountyear 		      :=  le.v4_searchunverifiedphonecountyear  ;
			self.assocrisklevel 				      :=  le.v4_assocrisklevel 			 ;
			self.assocsuspicousidentitiescount 		      :=  le.v4_assocsuspicousidentitiescount  ;
			self.assoccreditbureauonlycount 		      :=  le.v4_assoccreditbureauonlycount 	 ;
			self.assoccreditbureauonlycountnew 		      :=  le.v4_assoccreditbureauonlycountnew  ;
			self.assoccreditbureauonlycountmonth 		      :=  le.v4_assoccreditbureauonlycountmonth ;
			self.assochighrisktopologycount 		      :=  le.v4_assochighrisktopologycount 	 ;
			self.validationrisklevel 			      :=  le.v4_validationrisklevel 		 ;
			self.correlationrisklevel 			      :=  le.v4_correlationrisklevel 		 ;
			self.divrisklevel 				      :=  le.v4_divrisklevel 			 ;
			self.divssnidentitymsourcecount 		      :=  le.v4_divssnidentitymsourcecount 	 ;
			self.divssnidentitymsourceurelcount 		      :=  le.v4_divssnidentitymsourceurelcount  ;
			self.divssnlnamecountnew 			      :=  le.v4_divssnlnamecountnew 		 ;
			self.divssnaddrmsourcecount 			      :=  le.v4_divssnaddrmsourcecount 		 ;
			self.divaddridentitycount 			      :=  le.v4_divaddridentitycount 		 ;
			self.divaddridentitycountnew 			      :=  le.v4_divaddridentitycountnew 		 ;
			self.divaddridentitymsourcecount 		      :=  le.v4_divaddridentitymsourcecount  ;
			self.divaddrsuspidentitycountnew 		      :=  le.v4_divaddrsuspidentitycountnew  ;
			self.divaddrssncount 				      :=  le.v4_divaddrssncount 			 ;
			self.divaddrssncountnew 			      :=  le.v4_divaddrssncountnew 		 ;
			self.divaddrssnmsourcecount 			      :=  le.v4_divaddrssnmsourcecount 		 ;
			self.divsearchaddrsuspidentitycount 		      :=  le.v4_divsearchaddrsuspidentitycount  ;
			self.searchcomponentrisklevel 			      :=  le.v4_searchcomponentrisklevel 		 ;
			self.searchssnsearchcount 			      :=  le.v4_searchssnsearchcount 		 ;
			self.searchaddrsearchcount 			      :=  le.v4_searchaddrsearchcount 		 ;
			self.searchphonesearchcount 			      :=  le.v4_searchphonesearchcount 		 ;
			self.componentcharrisklevel 			      :=  le.v4_componentcharrisklevel 		 ;
			self.did																:= (integer)le.did;
			self.errorcode := le.errorcode; 
      self := [];
		END;

	  ds_slim2 := project( Soap_output, v4_trans2(left) );


		 ds_with_extras2 := JOIN(ds_slim2,soap_in, LEFT.accountnumber =(STRING)RIGHT.batch_in[1].acctno,
																TRANSFORM(Global_output_lay2,
																						self.did := left.did;
																						self.historydate := (string)right.batch_in[1].HistoryDateYYYYMM;
																						self.FNamePop := right.batch_in[1].Name_First<>'';
																						self.LNamePop := right.batch_in[1].Name_Last<>'';
																						self.AddrPop := right.batch_in[1].street_addr<>'';
																						self.SSNLength := (string)(length(trim(right.batch_in[1].ssn,left,right))) ;
																						self.DOBPop := right.batch_in[1].dob<>'';
																						self.IPAddrPop := right.batch_in[1].ip_addr<>''; 
																						self.HPhnPop := right.batch_in[1].Home_Phone<>'';
																					  self := left;
																					  self := []
																           ));

    //final file out to thor
output(ds_with_extras,, outfile_name1, thor, compressed, OVERWRITE);
output(ds_with_extras2,, outfile_name2, thor, compressed, OVERWRITE);

		RETURN 0;



ENDMACRO;