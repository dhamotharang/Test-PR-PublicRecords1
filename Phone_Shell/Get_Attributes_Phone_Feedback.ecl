/* ************************************************************************
 * 			 This function gathers the Phone_Feedback attributes.							*
 ************************************************************************ */

IMPORT PhonesFeedback, Phone_Shell, RiskWise, UT, doxie, Suppress;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Get_Attributes_Phone_Feedback (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
	{Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, unsigned4 global_sid} getFeedback(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, PhonesFeedback.Key_PhonesFeedback_phone ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		// These attributes were already calculated in Phone_Shell.Search_PhonesFeedback
		SELF.Phone_Feedback.Phone_Feedback_Date := le.Phone_Feedback.Phone_Feedback_Date;
		SELF.Phone_Feedback.Phone_Feedback_Result := le.Phone_Feedback.Phone_Feedback_Result;
		SELF.Phone_Feedback.Phone_Feedback_First := le.Phone_Feedback.Phone_Feedback_First;
		SELF.Phone_Feedback.Phone_Feedback_Middle := le.Phone_Feedback.Phone_Feedback_Middle;
		SELF.Phone_Feedback.Phone_Feedback_Last := le.Phone_Feedback.Phone_Feedback_Last;
		SELF.Phone_Feedback.Phone_Feedback_Last_RPC_Date := le.Phone_Feedback.Phone_Feedback_Last_RPC_Date;

		// Only look for the reverse phone information if the DID based Phones Feedback attributes were not found
		reversePhoneLookup := TRIM(le.Phone_Feedback.Phone_Feedback_Date) = '' AND le.Phone_Feedback.Phone_Feedback_Result = 0 AND
														TRIM(le.Phone_Feedback.Phone_Feedback_First) = '' AND TRIM(le.Phone_Feedback.Phone_Feedback_Middle) = '' AND
														TRIM(le.Phone_Feedback.Phone_Feedback_Last) = '' AND TRIM(le.Phone_Feedback.Phone_Feedback_Last_RPC_Date) = '';
														
		date := Phone_Shell.Common.parseDate(ut.DateTimeToYYYYMMDD(ri.date_time_added), TRUE);
		SELF.Phone_Feedback.Phone_Feedback_RP_Date := IF(reversePhoneLookup, date, '');
		SELF.Phone_Feedback.Phone_Feedback_RP_Result := IF(reversePhoneLookup, CASE(TRIM(ri.phone_contact_type),
																											'1' => 1,
																											'2' => 2,
																											'3' => 3,
																											'4' => 4,
																														 9), 9);
		SELF.Phone_Feedback.Phone_Feedback_RP_First := IF(reversePhoneLookup, TRIM(ri.fname), '');
		SELF.Phone_Feedback.Phone_Feedback_RP_Middle := IF(reversePhoneLookup, TRIM(ri.mname), '');
		SELF.Phone_Feedback.Phone_Feedback_RP_Last := IF(reversePhoneLookup, TRIM(ri.lname), '');
		SELF.Phone_Feedback.Phone_Feedback_RP_Last_RPC_Date := IF(reversePhoneLookup, date, '');
		
		SELF := le;
	END;
	
	feedback_unsuppressed := JOIN(Input, PhonesFeedback.Key_PhonesFeedback_phone, TRIM(LEFT.Gathered_Phone) <> '' AND
																	KEYED(LEFT.Gathered_Phone = RIGHT.phone_number),
																	getFeedback(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
	feedback := Suppress.Suppress_ReturnOldLayout(feedback_unsuppressed, mod_access, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus);
	// We want to keep the most recent record
	feedbackSorted := SORT(feedback, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, -Phone_Feedback.Phone_Feedback_RP_Last_RPC_Date, -Phone_Feedback.Phone_Feedback_RP_Date);
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus rollFeedback(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM
		SELF.Phone_Feedback.Phone_Feedback_Date := le.Phone_Feedback.Phone_Feedback_Date;
		SELF.Phone_Feedback.Phone_Feedback_Result := le.Phone_Feedback.Phone_Feedback_Result;
		SELF.Phone_Feedback.Phone_Feedback_First := le.Phone_Feedback.Phone_Feedback_First;
		SELF.Phone_Feedback.Phone_Feedback_Middle := le.Phone_Feedback.Phone_Feedback_Middle;
		SELF.Phone_Feedback.Phone_Feedback_Last := le.Phone_Feedback.Phone_Feedback_Last;
		SELF.Phone_Feedback.Phone_Feedback_Last_RPC_Date := le.Phone_Feedback.Phone_Feedback_Last_RPC_Date;
		
		// We can potential have multiple phone feedback results, fill in as much data as possible
		SELF.Phone_Feedback.Phone_Feedback_RP_Date := IF(TRIM(le.Phone_Feedback.Phone_Feedback_RP_Date) NOT IN ['', '0'], le.Phone_Feedback.Phone_Feedback_RP_Date, ri.Phone_Feedback.Phone_Feedback_RP_Date);
		SELF.Phone_Feedback.Phone_Feedback_RP_Result := IF(le.Phone_Feedback.Phone_Feedback_RP_Result <> 0, le.Phone_Feedback.Phone_Feedback_RP_Result, ri.Phone_Feedback.Phone_Feedback_RP_Result);
		SELF.Phone_Feedback.Phone_Feedback_RP_First := IF(TRIM(le.Phone_Feedback.Phone_Feedback_RP_First) <> '', le.Phone_Feedback.Phone_Feedback_RP_First, ri.Phone_Feedback.Phone_Feedback_RP_First);
		SELF.Phone_Feedback.Phone_Feedback_RP_Middle := IF(TRIM(le.Phone_Feedback.Phone_Feedback_RP_Middle) <> '', le.Phone_Feedback.Phone_Feedback_RP_Middle, ri.Phone_Feedback.Phone_Feedback_RP_Middle);
		SELF.Phone_Feedback.Phone_Feedback_RP_Last := IF(TRIM(le.Phone_Feedback.Phone_Feedback_RP_Last) <> '', le.Phone_Feedback.Phone_Feedback_RP_Last, ri.Phone_Feedback.Phone_Feedback_RP_Last);
		SELF.Phone_Feedback.Phone_Feedback_RP_Last_RPC_Date := IF(TRIM(le.Phone_Feedback.Phone_Feedback_RP_Last_RPC_Date) <> '', le.Phone_Feedback.Phone_Feedback_RP_Last_RPC_Date, ri.Phone_Feedback.Phone_Feedback_RP_Last_RPC_Date);
	
		SELF := le;
	END;
	
	final := ROLLUP(feedbackSorted, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
															rollFeedback(LEFT, RIGHT));
															
	RETURN(final);
END;