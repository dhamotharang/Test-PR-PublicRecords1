IMPORT Phone_Shell, RiskWise, UT, STD;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Gather_Attributes (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) Input,
																																									UNSIGNED1 GLBPurpose,
																																									UNSIGNED1 DPPAPurpose,
																																									STRING50 DataRestrictionMask,
																																									UNSIGNED3 InsuranceVerificationAgeLimit,
																																									STRING30 IndustryClass,
                                         UNSIGNED2 PhoneShellVersion = 10 // default to PhoneShell V1.0, use 20 (for version 2.0) and so on for other versions
																																								) := FUNCTION
	/* ******************************************************************************
   ********************************************************************************
	 ** This function gathers attributes for all of the discovered phone numbers.  **
	 ********************************************************************************
	 ****************************************************************************** */

	 /* ***************************************************************
		* 			Gather all of the attributes for these phones						*
	  *************************************************************** */
	EDA := Phone_Shell.Get_Attributes_EDA(Input, PhoneShellVersion);
		
	Inquiries := Phone_Shell.Get_Attributes_Inquiries(Input, PhoneShellVersion);
	
	InternalCorroboration := Phone_Shell.Get_Attributes_Internal_Corroboration(Input, InsuranceVerificationAgeLimit);
	
	PhoneFeedback := Phone_Shell.Get_Attributes_Phone_Feedback(Input);
	
	PhonesPlus := Phone_Shell.Get_Attributes_Phones_Plus(Input, GLBPurpose, DPPAPurpose, IndustryClass, DataRestrictionMask);
	
	RawPhone := Phone_Shell.Get_Attributes_Raw_Phone(Input);
	
	SubjectLevel := Phone_Shell.Get_Attributes_Subject_Level(Input);
	
	 /* ***************************************************************
		* 				Merge all of the attributes back together							*
	  *************************************************************** */
	withEDA := JOIN(Input, EDA, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																			SELF.EDA_Characteristics := RIGHT.EDA_Characteristics,
																																																			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																																																																																				
	withInquiries := JOIN(withEDA, Inquiries, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																			SELF.Inquiries := RIGHT.Inquiries,
																																																			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));	
																																																			
	withInternalCorroboration := JOIN(withInquiries, InternalCorroboration, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																			SELF.Internal_Corroboration := RIGHT.Internal_Corroboration,
																																																			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));	
																																																			
	withPhoneFeedback := JOIN(withInternalCorroboration, PhoneFeedback, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																			SELF.Phone_Feedback := RIGHT.Phone_Feedback,
																																																			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));			
																																																			
	withPhonesPlus := JOIN(withPhoneFeedback, PhonesPlus, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																			SELF.PhonesPlus_Characteristics := RIGHT.PhonesPlus_Characteristics,
																																																			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																																			
	withRawPhone := JOIN(withPhonesPlus, RawPhone, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																			SELF.Raw_Phone_Characteristics := RIGHT.Raw_Phone_Characteristics,
																																																			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																																			
	withSubjectLevel := JOIN(withRawPhone, SubjectLevel, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																			SELF.Subject_Level := RIGHT.Subject_Level,
																																																			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																														
	final_temp := PROJECT(SORT(withSubjectLevel, Clean_Input.seq, -LENGTH(TRIM(Sources.Source_List)), Raw_Phone_Characteristics.Phone_Subject_Level, Gathered_Phone), TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																			SELF := LEFT));
	
	// For some attributes if we don't find any information on the phone we want to return a value other than blank or 0's.  For these, clean them up
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus cleanBlanks(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
		SELF.Raw_Phone_Characteristics.Phone_Switch_Type := IF(TRIM(le.Raw_Phone_Characteristics.Phone_Switch_Type) = '', 'U', le.Raw_Phone_Characteristics.Phone_Switch_Type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Listing_Name := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Listing_Name) IN ['\'', '"', ','], '', le.PhonesPlus_Characteristics.PhonesPlus_Listing_Name);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigName := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigName) IN ['\'', '"', ','], '', le.PhonesPlus_Characteristics.PhonesPlus_OrigName);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigConfScore := IF(le.PhonesPlus_Characteristics.PhonesPlus_OrigConfScore = 0, 5, le.PhonesPlus_Characteristics.PhonesPlus_OrigConfScore);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match) = '', ut.IntegerToBinaryString(0), le.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt) = '', '0', le.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Rules := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Rules) = '', ut.IntegerToBinaryString(0), le.PhonesPlus_Characteristics.PhonesPlus_Rules);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src_All := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Src_All) = '', ut.IntegerToBinaryString(0), le.PhonesPlus_Characteristics.PhonesPlus_Src_All);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src_Rule := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Src_Rule) = '', ut.IntegerToBinaryString(0), le.PhonesPlus_Characteristics.PhonesPlus_Src_Rule);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Match := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Match) = '', ut.IntegerToBinaryString(0), le.PhonesPlus_Characteristics.PhonesPlus_EDA_Match);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match) = '', ut.IntegerToBinaryString(0), le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score := IF(le.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score = 0, 5, le.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score := IF(le.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score = 0, 5, le.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score := IF(le.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score = 0, 5, le.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone = 0, 8, le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID = 0, 8, le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr = 0, 8, le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match) = '', ut.IntegerToBinaryString(0), le.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match);
		SELF.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) = '' AND STD.Str.Find(le.Sources.Source_List, 'Util', 1) > 0, 'U', le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag);
		// If we got the phone from a Phones Plus source - make sure the Type is populated, even if we populate with an Unknown ('U')
		SELF.PhonesPlus_Characteristics.PhonesPlus_Type := MAP(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Type) <> ''	=> le.PhonesPlus_Characteristics.PhonesPlus_Type,
																													 STD.Str.Find(le.Sources.Source_List, 'PPFA', 1) > 0 OR 
																													 STD.Str.Find(le.Sources.Source_List, 'PPLA', 1) > 0 OR 
																													 STD.Str.Find(le.Sources.Source_List, 'PPFLA', 1) > 0 OR 
																													 STD.Str.Find(le.Sources.Source_List, 'PPLFA', 1) > 0 OR 
																													 STD.Str.Find(le.Sources.Source_List, 'PPCA', 1) > 0 OR 
																													 STD.Str.Find(le.Sources.Source_List, 'PPDID', 1) > 0 OR 
																													 STD.Str.Find(le.Sources.Source_List, 'PPTH', 1) > 0
																																																											=> 'U',
																																																													'');
		SELF.Phone_Feedback.Phone_Feedback_Result := IF(le.Phone_Feedback.Phone_Feedback_Result = 0, 9, le.Phone_Feedback.Phone_Feedback_Result);
		SELF.Phone_Feedback.Phone_Feedback_RP_Result := IF(le.Phone_Feedback.Phone_Feedback_RP_Result = 0, 9, le.Phone_Feedback.Phone_Feedback_RP_Result);
	
		SELF.EDA_Characteristics.EDA_pfrd_address_ind := IF(TRIM(le.EDA_Characteristics.EDA_pfrd_address_ind) = '', 'XX', le.EDA_Characteristics.EDA_pfrd_address_ind);
		SELF.EDA_Characteristics.EDA_Listing_Name := IF(TRIM(le.EDA_Characteristics.EDA_Listing_Name) IN ['\'', '"', ','], '', le.EDA_Characteristics.EDA_Listing_Name);
		SELF.Inquiries.Inq_Num := IF(TRIM(le.Inquiries.Inq_Num) = '', '0', le.Inquiries.Inq_Num);
		SELF.Inquiries.Inq_Num_06 := IF(TRIM(le.Inquiries.Inq_Num_06) = '', '0', le.Inquiries.Inq_Num_06);
		SELF.Inquiries.Inq_Num_Addresses := IF(TRIM(le.Inquiries.Inq_Num_Addresses) = '', '0', le.Inquiries.Inq_Num_Addresses);
		SELF.Inquiries.Inq_Num_Addresses_06 := IF(TRIM(le.Inquiries.Inq_Num_Addresses_06) = '', '0', le.Inquiries.Inq_Num_Addresses_06);
		SELF.Inquiries.Inq_Num_ADLs := IF(TRIM(le.Inquiries.Inq_Num_ADLs) = '', '0', le.Inquiries.Inq_Num_ADLs);
		SELF.Inquiries.Inq_Num_ADLs_06 := IF(TRIM(le.Inquiries.Inq_Num_ADLs_06) = '', '0', le.Inquiries.Inq_Num_ADLs_06);
		
		SELF := le;
	END;
	
	final := PROJECT(final_temp, cleanBlanks(LEFT));
																																																			
	 /* ***************************************************************
		*      DEBUGGING SECTION -- COMMENT OUT FOR PRODUCTION		    	*
	  *************************************************************** */
	 // OUTPUT(withEDA, NAMED('withEDA'));
	 // OUTPUT(withInquiries, NAMED('withInquiries'));
	 // OUTPUT(withInternalCorroboration, NAMED('withInternalCorroboration'));
	 // OUTPUT(withPhoneFeedback, NAMED('withPhoneFeedback'));
	 // OUTPUT(withPhonesPlus, NAMED('withPhonesPlus'));
	 // OUTPUT(withRawPhone, NAMED('withRawPhone'));
	 // OUTPUT(withSubjectLevel, NAMED('withSubjectLevel'));
	 
	 /* ***************************************************************
		* 									Return Final Result 												*
	  *************************************************************** */
		
	RETURN(final);
END;