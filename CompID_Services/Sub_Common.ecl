IMPORT Insurance_iesp, ut;

EXPORT Sub_Common := MODULE

	// Layouts
	SHARED Layout_CompId_Order 		:= CompId_Services.Layouts.CompId_Order;
	SHARED Layout_CompIdResult 		:= CompId_Services.Layouts.Layout_CompId_Result;
	SHARED Layout_CompId_Address	:= CompId_Services.Layouts.Layout_Address;
	
	SHARED Layout_Request 				:= Insurance_iesp.DataEnhanceOrder.t_DataEnhanceRequest;
	SHARED Layout_Response				:= Insurance_iesp.DataEnhanceReport.t_DataEnhanceResponse;
	SHARED Layout_ReportId				:= Insurance_iesp.DataEnhanceReport.t_ReportIdSection;
	SHARED Layout_Recap						:= Insurance_iesp.DataEnhanceReport.t_RecapProcessingSection;
	
	SHARED Layout_SearchInfo			 		:= Insurance_iesp.DataEnhanceReport.t_SearchInfoSection;
	SHARED Layout_DataEnhancement 		:= Insurance_iesp.DataEnhanceReport.t_DataEnhancementResultsSection;
	SHARED Layout_PersonalIdResults		:= Insurance_iesp.DataEnhanceReport.t_PersonalIdResultsSubset;
	SHARED Layout_AddressIdResults		:= Insurance_iesp.DataEnhanceReport.t_AddressIdResultsSubset;
	
	// Subject Section Layouts
	SHARED Layout_RI51		:= Insurance_iesp.EDITSReport.t_ReportRequestIdRecordReport;
	SHARED Layout_RI52		:= Insurance_iesp.EDITSReport.t_ReportIdSupplementARecordReport;
	SHARED Layout_RP51		:= Insurance_iesp.EDITSReport.t_RequestorProducerRecordReport;
	SHARED Layout_SH51		:= Insurance_iesp.EDITSReport.t_ReportSectionHeaderRecordReport;
	SHARED Layout_RC51		:= Insurance_iesp.EDITSReport.t_RecapProcessingRecordReport;
	SHARED Layout_PI51		:= Insurance_iesp.EDITSReport.t_PersonRecordReport;
	SHARED Layout_DL51		:= Insurance_iesp.EDITSReport.t_DriverLicenseRecordReport;
	SHARED Layout_AL51		:= Insurance_iesp.EDITSReport.t_AddressRecordReport;
	
	// Temp Layouts
	SHARED Layout_Request_Temp := RECORD
		Layout_Request;
		UNSIGNED1 Id := 1;
	END;
	
	SHARED Layout_CompIdResult_Temp := RECORD
		Layout_CompIdResult;
		UNSIGNED1 Id := 1;
	END;
	
	SHARED Constants	:= CompId_Services.Constants;
	SHARED Layout_Date := Insurance_iesp.EDITS_Share.t_Date;
	
	// Date Conversion Utilities
	SHARED Layout_Date DateMMDDYYYY(STRING L) := FUNCTION
		RETURN DATASET ([{L[1..2], L[3..4], L[5..8], false}], Layout_Date);
	END;
	SHARED Layout_Date DateYYYYMMDD(STRING L) := FUNCTION
		RETURN DATASET ([{L[5..6], L[7..8], L[1..4], false}], Layout_Date);
	END;
		
	/* Call General */
	EXPORT DATASET(Layout_CompIdResult) getGenResult(Layout_CompId_Order CompId_Order, boolean UseNoEQBest) := FUNCTION
	
		UNSIGNED4 seq_value := 0;
		STRING120 name_value	:= ''; 
		UNSIGNED  min_score := 75; 
		UNSIGNED4 maxrecordstoreturn := 0;
		
		// Validate input parameter
		isValidParameter := (trim(CompId_Order.FirstName) <> '') AND (trim(CompId_Order.LastName) <> '');		
		
		// Run general search
		tntResult := CompID_Services.Search_TNT.getGenResult(seq_value, CompId_Order.SsnNum,  CompId_Order.BirthDate,  CompId_Order.StrName,  '',  
																													CompId_Order.FirstName,	CompId_Order.LastName, CompId_Order.MidName,  CompId_Order.SufName, 
																													CompId_Order.StateCode,  CompId_Order.CityName,  CompId_Order.ZipNum,
																													'', CompId_Order.DLStateCode,  CompId_Order.LicNum,  
																													CompId_Order.HouseNum,  CompId_Order.AptNum,	'', 
																													name_value, min_score, maxrecordstoreturn, UseNoEQBest);
    Result := if(isValidParameter, tntResult);																														
		RETURN Result;
	END;

	/* Call SSN */
	EXPORT DATASET(Layout_CompIdResult) getSSNResult(Layout_CompId_Order CompId_Order) := FUNCTION
		
		// Validate input parameter 
		isSSNExist := (trim(CompId_Order.SsnNum) <> '');	
		
		// Retrieve SSN
		ssnValue := CompId_Order.SsnNum;
		
		// Set SSN Global var
		#stored('ssn', ssnValue);
		
		// Call SSN Search
		DATASET(Layout_CompIdResult) SSNResult := CompID_Services.Search_SSN.getResultForSSNInquiry(ssnValue);
		Result := if(isSSNExist, SSNResult);
		RETURN Result;
	END;
	
	/* Call DL */
	EXPORT DATASET(Layout_CompIdResult) getDLResult(Layout_CompId_Order CompId_Order) := FUNCTION
		
		// Validate input parameter 
		isDLNExist := (trim(CompId_Order.LicNum) <> '') AND (trim(CompId_Order.DLStateCode) <> '');	
		
		// Retrieve DL and State
		DL_No := CompId_Order.LicNum;
		State := CompId_Order.DLStateCode;
		
		// Call DL Search
		DATASET(Layout_CompIdResult) DLResult := CompID_Services.Search_DLN.getResultForDLNInquiry(DL_No, State);
		Result := if(isDLNExist, DLResult);
		RETURN Result;
	END;

	/* Call General/SSN/DL Search based on the RI01's ReportUseCode */
	EXPORT DATASET(Layout_CompIdResult) callCompIdFeature(DATASET(Layout_CompId_Order) CompId_Orders) := FUNCTION
		// Consider only the first CompId Order (... hack)
		Layout_CompId_Order CompId_Order := CompId_Orders[1];
		
		// Get ReportUseCode to call the desired search feature
		Result := MAP(
								CompId_Order.ReportUseCode = Constants.DL_SEARCH OR
								CompId_Order.ReportUseCode = Constants.LM_SEARCH  => getDLResult(CompId_Order),
								CompId_Order.ReportUseCode = Constants.SSN_SEARCH => getSSNResult(CompId_Order),
																																		 getGenResult(CompId_Order, true));
		
		// Roxie is not able to output a row (as opposed to a dataset with a single row in it).
		// output(CHOOSEN(CompId_Orders, 1), NAMED('CompId_Order'));
		RETURN Result;
		
	END;
	
	/* RI51 */
	SHARED Layout_RI51 GetRI51(Layout_Request_Temp L, Layout_CompIdResult_Temp CompIdResult) := TRANSFORM
		SELF.UnitNumber 						:= Constants.UNIT_NUM_DEFAULT;
		SELF.GroupSequenceNumber		:= Constants.SEQ_NUM_DEFAULT;
		SELF.RecordCode 						:= Constants.RI51_IND;
		SELF.RecordOccurrA					:= Constants.OCCR_NUM_DEFAULT;
		SELF.RecordOccurrB					:= Constants.SEC_OCCR_NUM_DEFAULT;
		
		SELF.Quoteback		 					:= L.InquiryIdSection.InquiryRequestId.Quoteback;
		SELF.ReportCode 						:= L.InquiryIdSection.InquiryRequestId.ReportCode;
		SELF.ReportType 						:= L.InquiryIdSection.InquiryRequestId.ReportType;
		SELF.AccountNumber 					:= L.InquiryIdSection.InquiryRequestId.AccountNumber;
		SELF.AccountSuffix 					:= L.InquiryIdSection.InquiryRequestId.AccountSuffix;
		SELF.SpecialBillId					:= L.InquiryIdSection.InquiryRequestId.SpecialBillId;
		
		// Fix date format. Defect Id: 2255
		SELF.DateOfOrder 				:= DateYYYYMMDD(ut.GetDate)[1]; // today's date
		SELF.DateOfReceipt 			:= IF (LENGTH(TRIM(L.InquiryIdSection.InquiryRequestId.DateOfOrder.Year)) > 0, 
																										L.InquiryIdSection.InquiryRequestId.DateOfOrder, 
																										DateYYYYMMDD(ut.GetDate)[1]);
		SELF.DateOfCompletion		:= DateYYYYMMDD(ut.GetDate)[1];
		
		// 1-No Hit, 2-Hit
		SELF.ProcessingcompletionStatus := (String)if(CompIdResult.score = 0, Constants.NO_HIT_IND, Constants.HIT_IND);
		
		SELF.ReportUsage	 					:= L.InquiryIdSection.InquiryRequestId.ReportUsage;
		SELF.TimeOfReport						:= ut.getTime()[1..4];	// current time: hhmm
		
		SELF.ProductGroup						:= ''; // Do not send the Permissible Purpose back. DefectId: 2246
		SELF.RecordVersionNumber		:= L.InquiryIdSection.InquiryRequestId.RecordVersion;
		
		SELF := [];
	END;

	/* RI52 */
	SHARED Layout_RI52 GetRI52(Layout_Request_Temp L) := TRANSFORM
		SELF.UnitNumber 						:= Constants.UNIT_NUM_DEFAULT;
		SELF.GroupSequenceNumber		:= Constants.SEQ_NUM_DEFAULT;
		SELF.RecordCode							:= Constants.RI52_IND;
		SELF.RecordOccurrA					:= Constants.OCCR_NUM_DEFAULT;
		SELF.RecordOccurrB					:= Constants.SEC_OCCR_NUM_DEFAULT;

		SELF.CustOrgCodeLevel1 			:= L.InquiryIdSection.InquiryIdSupplementA.CustOrgCodeLevel1;
		SELF.CustOrgCodeLevel2 			:= L.InquiryIdSection.InquiryIdSupplementA.CustOrgCodeLevel2;
		SELF.CustOrgCodeLevel3 			:= L.InquiryIdSection.InquiryIdSupplementA.CustOrgCodeLevel3;
		SELF.CustOrgCodeLevel4 			:= L.InquiryIdSection.InquiryIdSupplementA.CustOrgCodeLevel4;

		SELF.SpecialField1 					:= L.InquiryIdSection.InquiryIdSupplementA.SpecialField1;
		SELF.SpecialField2 					:= L.InquiryIdSection.InquiryIdSupplementA.SpecialField2;
		SELF.SpecialField3 					:= L.InquiryIdSection.InquiryIdSupplementA.SpecialField3;
		SELF.SpecialFieldA 					:= L.InquiryIdSection.InquiryIdSupplementA.SpecialFieldA;
		SELF.SpecialFieldB 					:= L.InquiryIdSection.InquiryIdSupplementA.SpecialFieldB;
		SELF.SpecialFieldC 					:= L.InquiryIdSection.InquiryIdSupplementA.SpecialFieldC;
		SELF.SpecialNumericField1 	:= L.InquiryIdSection.InquiryIdSupplementA.SpecialNumericField1;
		
		SELF := [];
	END;

	/* RP51 */
	SHARED Layout_RP51 GetRP51(Layout_Request_Temp L) := TRANSFORM
		SELF.UnitNumber 					:= Constants.UNIT_NUM_DEFAULT;
		SELF.GroupSequenceNumber	:= Constants.SEQ_NUM_DEFAULT;
		SELF.RecordCode						:= Constants.RP51_IND;
		SELF.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
		SELF.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;
		SELF.Name			   					:= L.InquiryIdSection.RequestorProducer.Name;
	END;
	
	/* ReportId Section (RI51, RI52, RP51) */
	SHARED GetReportId(Layout_CompIdResult_Temp CompIdResult, Layout_Request_Temp Request) := FUNCTION

		Layout_ReportId xformReportId(Layout_Request_Temp L) := TRANSFORM
			// RI51
			SELF.ReportRequestId := PROJECT(L, GetRI51(L, CompIdResult));
			
			// RI52 (Include RI52 only when there is RI02)
			SELF.InquiryIdSupplementA := IF (L.InquiryIdSection.InquiryIdSupplementA.RecordCode = 'RI02',
																				PROJECT(L, GetRI52(L)));
			
			// RP51 (Include RP51 only when there is RP01)
			SELF.Requestor := IF (L.InquiryIdSection.RequestorProducer.RecordCode = 'RP01',
														PROJECT(L, GetRP51(L)));
		END;
		
		RETURN PROJECT(Request, xformReportId(LEFT));
	END;
	
	/* Recap Section (RC51) */
	SHARED GetRecap(Layout_CompIdResult_Temp CompIdResult, Layout_Request_Temp Request) := FUNCTION
		
		Layout_Recap xformRecap(Layout_Request_Temp L) := TRANSFORM
			SELF.RecapProcessing.UnitNumber						:= Constants.UNIT_NUM_DEFAULT;
			SELF.RecapProcessing.GroupSequenceNumber 	:= Constants.SEQ_NUM_DEFAULT;
			SELF.RecapProcessing.RecordCode						:= Constants.RC51_IND;
			SELF.RecapProcessing.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
			SELF.RecapProcessing.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;
			SELF.RecapProcessing.Classification				:= 'IN';
			SELF.RecapProcessing.SpecialField1Type		:= 'IR';
			SELF.RecapProcessing.SpecialField1Count		:= INTFORMAT((INTEGER)(if(CompIdResult.score = 0, 0, 1)), 7, 1); // Pad Zeroes
			
			SELF := [];
		END;
		
		RETURN PROJECT(Request, xformRecap(LEFT));
	END;
	
	/* Inquiry Section (SH51) */
	SHARED GetInqSH51(Layout_Request_Temp Request) := FUNCTION
		
		Layout_SH51 xformSH51(Layout_Request_Temp L) := TRANSFORM
			SELF.UnitNumber						:= Constants.UNIT_NUM_DEFAULT;
			SELF.GroupSequenceNumber 	:= Constants.SEQ_NUM_DEFAULT;
			SELF.RecordCode						:= Constants.SH51_IND;
			SELF.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
			SELF.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;
			SELF.SectionIdentifier		:= Constants.INQUIRY;
			
			SELF := [];
		END;
		
		RETURN PROJECT(Request, xformSH51(LEFT));
	END;

	/* Inquiry Section (PI51) */
	SHARED GetInqPI51(Layout_Request_Temp Request) := FUNCTION
		
		Layout_PI51 xformPI51(Layout_Request_Temp L) := TRANSFORM
			SELF.GroupSequenceNumber	:= Constants.SEQ_NUM_DEFAULT;
			SELF.RecordCode 					:= Constants.PI51_IND;
			SELF.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
			SELF.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;
			
			// Assign from input
			SELF 											:= L.SubjectIdSection.Subject;
			
			SELF := [];
		END;
		
		RETURN PROJECT(Request, xformPI51(LEFT));
	END;

	/* Inquiry Section (DL51) */
	SHARED GetInqDL51(Layout_Request_Temp Request) := FUNCTION
		
		Layout_DL51 xformDL51(Layout_Request_Temp L) := TRANSFORM
			SELF.GroupSequenceNumber	:= Constants.SEQ_NUM_DEFAULT;
			SELF.RecordCode 					:= Constants.DL51_IND;
			SELF.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
			SELF.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;
			
			// Assign from input
			SELF 											:= L.SubjectIdSection.CurrentLicense;
			
			SELF := [];
		END;
		
		RETURN PROJECT(Request, xformDL51(LEFT));
	END;

	/* Inquiry Section (AL51) */
	SHARED GetInqAL51(Layout_Request_Temp Request) := FUNCTION
		
		Layout_AL51 xformAL51(Layout_Request_Temp L) := TRANSFORM
			SELF.GroupSequenceNumber	:= Constants.SEQ_NUM_DEFAULT;
			SELF.RecordCode 					:= Constants.AL51_IND;
			SELF.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
			SELF.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;

			// Assign from input
			SELF 											:= L.SubjectIdSection.CurrentAddress;
			
			SELF := [];
		END;
		
		RETURN PROJECT(Request, xformAL51(LEFT));
	END;

	/* Inquiry Section (SH51, PI51, AL51, DL51) */
	SHARED GetSearchInfo(Layout_CompIdResult_Temp CompIdResult, Layout_Request_Temp Request) := FUNCTION
		Layout_SearchInfo xformSearchInfo(Layout_Request_Temp L) := TRANSFORM
			// SH51
			SELF.ReportSectionHeader := GetInqSH51(L);
			
			// PI51 (Include PI51 only when there is PI01)
			SELF.Subject := IF (L.SubjectIdSection.Subject.RecordCode = 'PI01',
													GetInqPI51(L));
			
			// DL51 (Include DL51 only when there is DL01)
			SELF.CurrentLicense := IF (L.SubjectIdSection.CurrentLicense.RecordCode = 'DL01', 
																	GetInqDL51(L));
			
			// AL51 (Include AL51 only when there is AL01)
			SELF.CurrentAddress := IF (L.SubjectIdSection.CurrentAddress.RecordCode = 'AL01',
																	GetInqAL51(L));
			
			// AL51 (Priors)
			SELF.PriorAddresses := [];
		END;
		
		RETURN PROJECT(Request, xformSearchInfo(LEFT));
	END;

	/* Subject Section (DL51) */
	SHARED GetDL51(Layout_CompIdResult_Temp CompIdResult) := FUNCTION
		
		Layout_DL51 xformDL51(Layout_CompIdResult_Temp L) := TRANSFORM
			SELF.UnitNumber 					:= Constants.UNIT_NUM_DEFAULT;
			SELF.GroupSequenceNumber	:= Constants.SEQ_NUM_DEFAULT;
			SELF.RecordCode 					:= Constants.DL51_IND;
			SELF.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
			SELF.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;
			SELF.Classification				:= 'CP';
			
			SELF.LicenseNumber				:= L.CurrentDL.dl_number;
			SELF.State								:= L.CurrentDL.dlState;
			SELF.Restriction					:= L.CurrentDL.restrictions;
			
			SELF.IssueDate						:= DateMMDDYYYY(INTFORMAT(L.CurrentDL.lic_issue_date, 8, 1))[1];
			SELF.ExpDatev							:= DateMMDDYYYY(INTFORMAT(L.CurrentDL.expiration_date, 8, 1))[1];
			
			SELF := [];
		END;
		
		RETURN PROJECT(CompIdResult, xformDL51(LEFT));
	END;
	
	/* PI51, DL51 */
	SHARED GetPersonalData(Layout_CompIdResult_Temp CompIdResult) := FUNCTION
		DATASET(Layout_PersonalIdResults) xformPersonal(Layout_CompIdResult_Temp L) := TRANSFORM
		
			// --- PI51 (begin) ---
			SELF.Subject.UnitNumber 					:= Constants.UNIT_NUM_DEFAULT;
			SELF.Subject.GroupSequenceNumber	:= Constants.SEQ_NUM_DEFAULT;
			SELF.Subject.RecordCode 					:= Constants.PI51_IND;
			SELF.Subject.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
			SELF.Subject.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;
			SELF.Subject.Classification				:= 'RS';
			
			SELF.Subject.Last 		:= L.Name_Last;
			SELF.Subject.First		:= L.Name_First;
			SELF.Subject.Middle		:= L.Name_Middle;
			SELF.Subject.Suffix		:= L.Name_Suffix;
			
			// Date Of Birth
			SELF.Subject.DateOfBirth := DateMMDDYYYY(INTFORMAT(L.DOB, 8, 1))[1];
			
			SELF.Subject.SSN			:= L.SSN;
			SELF.Subject.Sex			:= L.Gender;
			SELF.Subject.RelationshipDesc := L.Remarks;
			// --- PI51 (end) ---
			
			// DL51 (Include DL only when a DL is found)
			SELF.License					:= IF (TRIM(L.CurrentDL.dl_number) != '', GetDL51(L));
			
			SELF := [];
		END;
		
		RETURN PROJECT(CompIdResult, xformPersonal(LEFT));
	END;
	
	/* Convert Address */
	SHARED Layout_AL51 PopulateAddress(Layout_CompId_Address L, STRING2 Classification) := TRANSFORM
		SELF.HouseNumber		:= L.Prim_Range;
		SELF.StreetName			:= L.Addr;
		SELF.AptNumber 			:= L.Unit;
		SELF.City 					:= L.City;
		SELF.State 					:= L.State;
		SELF.Zip 						:= L.Zip;
		SELF.Zip4 					:= L.Zip4;
		SELF.Classification	:= Classification;
	
	  SELF.DateLastSeen		:= if(SELF.Classification=Constants.CURRENT_ADDR,
	       DateYYYYMMDD(INTFORMAT(L.dt_max_seen  , 6, 1))[1],
	       DateYYYYMMDD(INTFORMAT((integer6)  0  , 6, 1))[1]);
	
	  SELF.DateFirstSeen 	:= if(SELF.Classification=Constants.CURRENT_ADDR,
	       DateYYYYMMDD(INTFORMAT(L.dt_first_seen, 6, 1))[1],
				 DateYYYYMMDD(INTFORMAT((integer6)    0, 6, 1))[1]);
				 
		SELF.UnitNumber 					:= Constants.UNIT_NUM_DEFAULT;
		SELF.GroupSequenceNumber	:= Constants.SEQ_NUM_DEFAULT;
		SELF.RecordCode 					:= Constants.AL51_IND;
		SELF.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
		SELF.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;
		
		SELF := [];
	END;
	
	/* AL51 (Current and Prior) */
	SHARED GetAL51(Layout_CompIdResult_Temp CompIdResult) := FUNCTION
	
		DATASET(Layout_AddressIdResults) xformAddress(Layout_CompIdResult_Temp L) := TRANSFORM
			// Current
			SELF.CurrentAddress := PROJECT(L.CurrentAddress, PopulateAddress(LEFT, Constants.CURRENT_ADDR));
			
			// Priors
			Temp := L.priorAddress1 + L.priorAddress2 + L.priorAddress3;
			SELF.PriorAddresses := PROJECT(Temp(TRIM(addr) != ''), PopulateAddress(LEFT, Constants.PRIOR_ADDR));
		END;
		
		RETURN PROJECT(CompIdResult, xformAddress(LEFT));
	END;
	
	/* Subject Section: SH51 (Section Header) */
	SHARED GetSH51(Layout_CompIdResult_Temp CompIdResult) := FUNCTION
		
		Layout_SH51 xformSectionHeader(Layout_CompIdResult_Temp L) := TRANSFORM
			SELF.UnitNumber						:= Constants.UNIT_NUM_DEFAULT;
			SELF.GroupSequenceNumber 	:= Constants.SEQ_NUM_DEFAULT;
			SELF.RecordCode						:= Constants.SH51_IND;
			SELF.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
			SELF.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;
			SELF.SectionIdentifier		:= Constants.SUBJECT;
			
			SELF := [];
		END;
		
		RETURN PROJECT(CompIdResult, xformSectionHeader(LEFT));
	END;
	
	/* Subject Section: RC51 */
	SHARED GetRC51(Layout_CompIdResult_Temp CompIdResult, Layout_Request_Temp Request) := FUNCTION
		
		Layout_RC51 xformSectionHeader(Layout_CompIdResult_Temp L) := TRANSFORM
			SELF.UnitNumber						:= Constants.UNIT_NUM_DEFAULT;
			SELF.GroupSequenceNumber 	:= Constants.SEQ_NUM_DEFAULT;
			SELF.RecordCode						:= Constants.RC51_IND;
			SELF.RecordOccurrA				:= Constants.OCCR_NUM_DEFAULT;
			SELF.RecordOccurrB				:= Constants.SEC_OCCR_NUM_DEFAULT;
			
			SELF.Classification				:= 'ST';
			SELF.SpecialField1Count		:= INTFORMAT((INTEGER)(if(CompIdResult.score = 0, 0, 25)), 7, 1); // Pad Zeroes
			
			SELF := [];
		END;
		
		RETURN PROJECT(CompIdResult, xformSectionHeader(LEFT));
	END;
	
	/* Subject Section (SH51, RC51, PI51, AL51, DL51) */
	SHARED GetDataEnhancementResults(Layout_CompIdResult_Temp CompIdResult, Layout_Request_Temp Request) := FUNCTION
		Layout_DataEnhancement xformDataEnhancement(Layout_CompIdResult_Temp L) := TRANSFORM
			// SH51
			SELF.ReportSectionHeader := GetSH51(L);
			
			// RC51
			SELF.IdSet.RecapProcessing := GetRC51(L, Request);
			
			// PI51, DL51
			SELF.IdSet.PersonalIdResultsSets := GetPersonalData(L);
			
			// AL51 (Current and Prior)
			SELF.IdSet.AddressIdResultsSets := GetAL51(L);
		END;
		
		RETURN PROJECT(CompIdResult, xformDataEnhancement(LEFT));
	END;
	
	/* Convert CompId Result to Generic Response */
	EXPORT convertCompIdToGeneric(DATASET(Layout_Request) Request, DATASET(Layout_CompIdResult) CompIdResult) := FUNCTION
		
		Request_Temp 			:= PROJECT(Request, TRANSFORM(Layout_Request_Temp, SELF := LEFT));
		CompIdResult_Temp := PROJECT(CompIdResult, TRANSFORM(Layout_CompIdResult_Temp, SELF := LEFT));
		
		Layout_Response InferResponse(Layout_CompIdResult_Temp L, Layout_Request_Temp R) := TRANSFORM
			// ReportId Section: RI51, RI52, RP51
			SELF.ReportIdSection := GetReportId(L, R);
			
			// Recap: RC51
			SELF.RecapProcessingSection := GetRecap(L, R);
			
			// Inquiry Section: SH51, PI51, AL51, DL51
			SELF.SearchInfoSection := GetSearchInfo(L, R);
			
			// Subject Section: SH51, RC51, PI51, AL51, DL51
			SELF.DataEnhancementResults := IF(L.score != 0,GetDataEnhancementResults(L, R));
		END;
		Response := JOIN(CompIdResult_Temp, Request_Temp, LEFT.Id=RIGHT.Id, InferResponse(LEFT, RIGHT));
		
		RETURN Response;
	END;
END;
