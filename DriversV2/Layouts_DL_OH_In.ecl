export Layouts_DL_OH_In := module

	export Layout_OH_Raw := record
		string1000 blob;
	end;
	//All dates are in MMDDYYYY format
	export Layout_OH_Update := record
		string9			Key_Number;
		string8			License_Number;
		string9			SSN;
		string2			License_Class;
		string1			Donor_Flag;
		string3			Hair_Color;
		string3			Eye_Color;
		string3			Weight_L;
		string1			Height_Feet;
		string2			Height_Inches;
		string1			Sex_Gender;
		string8			Permanent_License_Issue_Date;
		string1			Is_Medical_Two_Part_License;
		string8			License_Expiration_Date;
		string4			Deputy_Registrar_Agency;
		string1			CDLIS_Flag;
		string1			Is_on_PDPS;
		string8			License_App_Ctrl;
		string1			Is_Temporary;
		string3			License_App_Transaction_Type;
		string8			Motorcycle_Novice_Date;
		string42		Restriction_Codes;
		string10		Endorsement_Codes;
		string1			Is_Ohio_Resident;
		string1			Has_Warrant_Blocks;
		string1			Is_Fraud;
		string1			TSA_Threat_Assessment_Code;
		string8			TSA_Notification_Date;
		string8			TSA_Expiration_Date;
		string1			Med_Certificate_Self_Cert_Code;
		string8			Med_Certificate_Expiration_Date;
		string40		First_Name;
		string40		Middle_Name;
		string40		Last_Name;
		string5		  Suffix;
		string30		Street_Address;
		string20		City;
		string2		  State;
		string11		Zip_Code;
		string2		  County_Number;
		string8		  Birth_Date;
	end;

	export Layout_OH_Cleaned := record	
		string8   process_date;
		Layout_OH_Update;
		string5   clean_name_prefix;
		string20  clean_fname;
		string20  clean_mname;
		string20  clean_lname;
		string5   clean_name_suffix;
		string3   clean_name_score;
	end;	

	export Layout_OH_CP := record
		string500 blob;		
	end;
	
	export Layout_OH_CP_PDate:= record	
		string8 process_date;
	  Layout_OH_CP;	
	end;
	
	export Header_Raw_Pdate := RECORD
		STRING9  Key_Number;
		STRING2  Record_Type_Code;
		Layout_OH_CP_PDate;
	END;

	EXPORT Viol_Accident_Raw := RECORD
		Header_Raw_Pdate-Layout_OH_CP;
		string2	  County_Number	;
		string2  	Jurisdiction_Code	;
		string1	  Accident_Severity_Indicator	;
		string8	  Accident_Date	;
		string1	  Is_Commercial_Vehicle	;
		string1	  Has_Hazardous_Materials	;
		string18	Reference_Locator_Number	;
		string8	  Create_Date	;
		string8	  Accident_to_Line_of_Duty_Date	;
		string10	Patrol_Crash_ID	;
		STRING5   NCIC_Code;
	END;
	
	EXPORT Viol_Withdrawal_Raw := RECORD
		Header_Raw_Pdate-Layout_OH_CP;
		string2		Suspension_Type_Code	;
		string8		Offense_Violation_Date	;
		string8		Clear_Date	;
		string8		Proof_Filing_Shown_Date	;
		string8		Action_Date	;
		string8		Start_Date	;
		string8		End_Date	;
		string10	BMV_Case_Number	;
		string6		Court_Code	;
		string3		Ohio_Offense_Code	;
		string1		Is_Commercial_Vehicle	;
		string1		Had_Hazardous_Material	;
		string2		Jurisdiction_Code	;
		string8		Fee_Paid_Date	;
		string8		Plate_Number	;
		string3		CDL_Disqualification_Reason_Code	;
		string3		CDL_Out_of_State_Disqualification_Type	;
		string1		Disqualification_Extent_Flag	;
		string8		Disqualification_Reason_Reference	;
		string18	Reference_Locator_Number	;
		string6		School_District_Number	;
		string1		Clearance_Reason	;
		string8		Cleared_for_Restricted_Driving_Date	;
		string3		Withdrawal_Reason_Code	;
		string8		Remedial_Driving_Course_Date	;
		string8		License_Exam_Date	;
		string3		ACD_Offense_Code	;
		string1		Withdrawal_Status_Code	;
		string8		Modified_Driving_Date	;
		string8		Settlement_Agreement_Date	;
		string2		Restriction_Code	;
		string8		Conviction_Date	;
		string8		Appeal_Filed_Date	;
		string8		Appeal_Denied_Date	;
		string8		Appeal_Granted_Date	;
		string1		Conviction_Plea_Flag	;
		string1		Is_Revocation	;
		string2		County_Number	;
		string8		Create_Date	;
		string8		License_Received_Date	;
		string8		Plate_Received_Date	;
		string8		FRA_Start_Date	;
		string8		FRA_End_Date	;
		string8		Accident_Date	;
		string10	Primary_Related_BMV_Case	;
		string1		Narrative_Literal_Code	;
		string1		Is_Fee_Required	;
		string1		Is_Vehicle_Owner	;
		string8		SOA_Conviction_Or_Withdrawal_Offense_Code	;
		string8		Modified_Driving_End_Date	;
		string1		Is_Appeal_Stay	;
		string3		Withdrawal_Type_Detail_Code	;
		string10	BMV_Related_DL_Case	;
		string10	Additional_Related_BMV_Case	;
		string8		Fine_Paid_Date	;
		string8		Mail_by_Date	;
		string4		CSEA_Number	;
		string10	CSEA_Case_Number	;
		string17	CSEA_Order_Number	;
		string12	CSEA_Agency_Participant_Number	;
		string8		Appeal_or_Hearing_Deadline_Date	;
		string6		Remedial_Driving_Course_G_Number	;
		string8		Court_Appearance_Effective_Date	;
		string1		Suspension_Class_Code	;
	END;

	EXPORT Viol_Cancellation_Raw := RECORD
		Header_Raw_Pdate-Layout_OH_CP;
		STRING2 cancelRecordType;
		STRING8 dateEntered;   
		STRING8 effectiveDate;
		STRING10 BMVcaseNum;  
		STRING16 courtCaseNum;
		STRING6 courtCode;
		STRING2 newStateCode1;
		STRING2 newStateCode2;
		STRING8 newStateIssueDate; 
	END;

	EXPORT Viol_OOS_Issuance_Raw := RECORD
		Header_Raw_Pdate-Layout_OH_CP;
		STRING8   OOState_RecCreationDate;
		STRING8		OutOfStateIssueDate; 
		STRING2		NewSPCOfRecord;
		STRING25	OutOfStateDLN;
	END;

	EXPORT Viol_Remedial_Course_Raw := RECORD
		Header_Raw_Pdate-Layout_OH_CP;
		STRING8 RecCreationDate;
		STRING8 RemedialReqCompletionDate;
		STRING8 requirementsDeniedDate;
		STRING6 drivingSchoolGNum;
		STRING1 remedialCourtOrderedInd;
	END;

	EXPORT Viol_Fee_Payment_Raw := RECORD
		Header_Raw_Pdate-Layout_OH_CP;
		STRING1   PaymentPlanCode;
		STRING8   PaymentPlanStartDate;
		STRING8   PaymentPlanEndDate;
		STRING8   ModifiedDrivingDate;
		STRING8   ModifiedDrivingAndDate;
		STRING8   paymentPlanTerminationDate;
	END;	

	EXPORT Viol_Financial_Resp_Raw := RECORD
		Header_Raw_Pdate-Layout_OH_CP;
		string8	  Proof_Filing_Start_Date	;
		string8	  Proof_Filing_End_Date	;
		string16	Insurance_Policy	;
		string8	  Proof_Filing_Cancellation_Date	;
		string8	  Proof_Filing_Late_Start_Date	;
		string8	  Proof_Filing_Cancelled_Posted_Date	;
		string8	  Proof_Filing_Posted_Date	;
	END;

	export Viol_Cosigners_Info_Raw := record		
		Header_Raw_Pdate-Layout_OH_CP;
		string8	  record_type_action_date;
		string1	  drivers_cosigners_relationship;
		string35  drivers_cosigners_name;
		string8	  cosigners_drivers_license_nbr;
		string8	  database_record_create_date;
	END;	

	export Viol_Warrant_Blocks_Raw:= record		
		Header_Raw_Pdate-Layout_OH_CP;
		string8        Create_Date	;
		string10       BMV_Case_Number	;
		string6        Court_Code	;
		string8        Clear_Date	;
		string8        Warrant_Block_Effective_Date	;
		string1        Is_Fee_Required	;
		string8        Fee_Paid_Date	;
		string8        Release_Date	;
		string1        Is_Bankruptcy	;
	END;	
	
	export Viol_Suspensions_Raw := record
		Header_Raw_Pdate-Layout_OH_CP;
		string2		Suspension_Type_Code	;
		string8		Offense_Violation_Date	;
		string8		Clear_Date	;
		string8		Proof_Filing_Shown_Date	;
		string8		Action_Date	;
		string8		Start_Date	;
		string8		End_Date	;
		string10	BMV_Case_Number	;
		string6		Court_Code	;
		string3		Ohio_Offense_Code	;
		string1		Is_Commercial_Vehicle	;
		string1		Had_Hazardous_Material	;
		string2		Jurisdiction_Code	;
		string8		Fee_Paid_Date	;
		string8		Plate_Number	;
		string3		CDL_Disqualification_Reason_Code	;
		string3		CDL_Out_of_State_Disqualification_Type	;
		string1		Disqualification_Extent_Flag	;
		string8		Disqualification_Reason_Reference	;
		string18	Reference_Locator_Number	;
		string6		School_District_Number	;
		string1		Clearance_Reason	;
		string8		Cleared_for_Restricted_Driving_Date	;
		string3		Withdrawal_Reason_Code	;
		string8		Remedial_Driving_Course_Date	;
		string8		License_Exam_Date	;
		string3		ACD_Offense_Code	;
		string1		Withdrawal_Status_Code	;
		string8		Modified_Driving_Date	;
		string8		Settlement_Agreement_Date	;
		string2		Restriction_Code	;
		string8		Conviction_Date	;
		string8		Appeal_Filed_Date	;
		string8		Appeal_Denied_Date	;
		string8		Appeal_Granted_Date	;
		string1		Conviction_Plea_Flag	;
		string1		Is_Revocation	;
		string2		County_Number	;
		string8		Create_Date	;
		string8		License_Received_Date	;
		string8		Plate_Received_Date	;
		string8		FRA_Start_Date	;
		string8		FRA_End_Date	;
		string8		Accident_Date	;
		string10	Primary_Related_BMV_Case	;
		string1		Narrative_Literal_Code	;
		string1		Is_Fee_Required	;
		string1		Is_Vehicle_Owner	;
		string8		SOA_ConvWithOffense_Code	;//SOA_Conviction_Or_Withdrawal_Offense_Code
		string8		Modified_Driving_End_Date	;
		string1		Is_Appeal_Stay	;
		string3		Withdrawal_Type_Detail_Code	;
		string10	BMV_Related_DL_Case	;
		string10	Additional_Related_BMV_Case	;
		string8		Fine_Paid_Date	;
		string8		Mail_by_Date	;
		string4		CSEA_Number	;
		string10	CSEA_Case_Number	;
		string17	CSEA_Order_Number	;
		string12	CSEA_Agency_Participant_Number	;
		string8		Appeal_or_Hearing_Deadline_Date	;
		string6		Remedial_Driving_Course_G_Number	;
		string8		Court_Appearance_Effective_Date	;
		string1		Suspension_Class_Code	;
	end;
	
	export Viol_Convictions_Raw := record 
		Header_Raw_Pdate-Layout_OH_CP;
		string2	  Conviction_Type_Code;
		string8	  Offense_Violation_Date;
		string8	  Plate_Number;
		string8	  Conviction_Date;
		string6	  Court_Code;
		string2	  Ohio_Offense_Code;
		string1	  Sentence_Code;
		string2	  Court_Assessed_Points;
		string1	  Had_Hazardous_Materials;
		string6	  Batch_Number;
		string1	  Conviction_Plea;
		string16	Court_Case_Number;
		string3 	ACD_Offense_Code;
		string2	  Posted_Speed;
		string3	  Actual_Speed;
		string5	  Blood_Alcohol_Content;
		string1	  Is_Commercial_Vehicle;
		string18	Reference_Locator_Number;
		string3	  Offense_Reduced_From_Code;
		string8	  Create_Date;
		string10	S1_Case_Number;
		string10	P2_Case_Number;
		string10	P3_Case_Number;
		string10	DL_Case_Number;
		string10	Habitual_Case_Number;
		string2	  Jurisdiction_Code;
		string8	  SOA_ConvWithOffense_Code; //SOA_Conviction_or_Withdrawal_Offense_Code;
		string4	  Court_Type_Code;
		string10	SP_Case_Number;
		string25	Out_of_State_Lic_Nbr;     //Out_of_State_License_Number;
		string2	  State_of_Origin;
		string1	  Suspension_Class;
		string1	  Is_CourtOrdRemed_Driving; //Is_Court_Ordered_Remedial_Driving;
		string1	  Is_CDL_Conviction;
		string1	  Did_Show_Proof_of_Insu;   //Did_Show_Proof_of_Insurance;
		string1	  Parent_Guardian_RestCode; //Parent_Guardian_Restriction_Code;
		string8	  Parent_Guardian_RestDate; //Parent_Guardian_Restriction_Date;
		string2	  Related_Record_Type_Code;
		string1	  Is_Bus;
		string1	  Has_Fatalities;
	end;
	
	export Viol_Accidents_Raw := record		
		Header_Raw_Pdate-Layout_OH_CP;
		string2	  County_Number	;
		string2  	Jurisdiction_Code	;
		string1	  Accident_Severity_Indicator	;
		string8	  Accident_Date	;
		string1	  Is_Commercial_Vehicle	;
		string1	  Has_Hazardous_Materials	;
		string18	Reference_Locator_Number	;
		string8	  Create_Date	;
		string8	  Accident_to_Line_of_Duty_Date	;
		string10	Patrol_Crash_ID	;
		STRING5   NCIC_Code;
	end;

	export Viol_FRA_Insurance_Raw := record
		Header_Raw_Pdate-Layout_OH_CP;
		string8	  Proof_Filing_Start_Date	;
		string8	  Proof_Filing_End_Date	;
		string16	Insurance_Policy	;
		string8	  Proof_Filing_Cancellation_Date	;
		string8	  Proof_Filing_Late_Start_Date	;
		string8	  Proof_Filing_Cancelled_Posted_Date	;
		string8	  Proof_Filing_Posted_Date	;
  end;
	
	export Temp_Combined_RecLayout4_DrInfo := RECORD   	
   	Viol_cosigners_info_Raw;
   	Viol_Warrant_Blocks_Raw;
   	Viol_Remedial_Course_Raw;
   	Viol_OOS_Issuance_Raw;   			
  end;

end;