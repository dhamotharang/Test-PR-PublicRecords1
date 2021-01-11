 IMPORT	Address, BIPV2;

EXPORT	Layouts	:=	MODULE
	EXPORT	FileHeaderSegment	:=	RECORD	// (FA)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING3		Test_or_Production_Indicator;
		STRING3		File_Type_Indicator;
	END;
	EXPORT	FA	:=	RECORD
		FileHeaderSegment;
	END;
	EXPORT	FA_Virtual	:=	RECORD
		FileHeaderSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	HeaderSegment	:=	RECORD// (AA)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING30	Sbfe_Contributor_Number;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		STRING2		Cycle_Number;
		STRING3		Cycle_Length;
		STRING3		File_Correction_Indicator;
		STRING4		Overall_File_Format_Version;
		STRING2		Major_AA_Segment_Version;
		STRING2		Minor_AA_Segment_Version;
		STRING2		Major_AB_Segment_Version;
		STRING2		Minor_AB_Segment_Version;
		STRING2		Major_MA_Segment_Version;
		STRING2		Minor_MA_Segment_Version;
		STRING2		Major_AD_Segment_Version;
		STRING2		Minor_AD_Segment_Version;
		STRING2		Major_PN_Segment_Version;
		STRING2		Minor_PN_Segment_Version;
		STRING2		Major_TI_Segment_Version;
		STRING2		Minor_TI_Segment_Version;
		STRING2		Major_IS_Segment_Version;
		STRING2		Minor_IS_Segment_Version;
		STRING2		Major_BS_Segment_Version;
		STRING2		Minor_BS_Segment_Version;
		STRING2		Major_BI_Segment_Version;
		STRING2		Minor_BI_Segment_Version;
		STRING2		Major_CL_Segment_Version;
		STRING2		Minor_CL_Segment_Version;
		STRING2		Major_MS_Segment_Version;
		STRING2		Minor_MS_Segment_Version;
		STRING2		Major_AH_Segment_Version;
		STRING2		Minor_AH_Segment_Version;
		STRING2		Major_ZZ_Segment_Version;
		STRING2		Minor_ZZ_Segment_Version;
		STRING2		Major_DF_Segment_Version;
		STRING2		Minor_DF_Segment_Version;
		STRING2		Major_MD_Segment_Version;
		STRING2		Minor_MD_Segment_Version;
		STRING2		Major_CT_Segment_Version;
		STRING2		Minor_CT_Segment_Version;
		STRING2		Major_MT_Segment_Version;
		STRING2		Minor_MT_Segment_Version;
		STRING2		Major_MR_Segment_Version;
		STRING2		Minor_MR_Segment_Version;
		STRING2		Major_MC_Segment_Version;
		STRING2		Minor_MC_Segment_Version;
		STRING2		Major_DM_Segment_Version;
		STRING2		Minor_DM_Segment_Version;
	END;
	EXPORT	AA	:=	RECORD
		HeaderSegment;
	END;
	EXPORT	AA_Virtual	:=	RECORD
		HeaderSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	AccountBaseSegment	:=	RECORD	// (AB)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING250	Account_Holder_Business_Name;
		STRING250	DBA;
		STRING250	Company_Website;
		STRING3		Legal_Business_Structure;
		STRING8		Business_Established_Date;
		STRING50	Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING3		Account_Status_1;//Changed in V5
		STRING3		Account_Status_2;//Changed in V5
		STRING8		Date_Account_Opened;
		STRING8		Date_Account_Closed;
		STRING2		Account_Closure_Basis;//Changed in V5
		STRING8		Account_Expiration_Date;
		STRING8		Last_Activity_Date;//Changed in V5 - new field uses this field
		STRING3		Last_Activity_Type;//Changed in V5
		STRING1		Recent_Activity_Indicator;
		STRING12	Original_Credit_Limit;//Changed in V5
		STRING12	Highest_Credit_Used;//Changed in V5 Deprecated
		STRING12	Current_Credit_Limit;
		STRING3		Reporting_Indicator_Length;//Changed in V5 Deprecated
		STRING2		Payment_Interval;//Changed in V5
		STRING3		Payment_Status_Category;//Changed in V5
		STRING3		Term_Of_Account_In_Months;
		STRING8		First_Payment_Due_Date;
		STRING8		Final_Payment_Due_Date;
		STRING10	Original_Rate;
		STRING10	Floating_Rate;
		STRING4		Grace_Period;//Changed in V5
		STRING3		Payment_Category;//Changed in V5
		STRING12	Payment_History_Profile_12_Months;
		STRING12	Payment_History_Profile_13_24_Months;
		STRING12	Payment_History_Profile_25_36_Months;
		STRING12	Payment_History_Profile_37_48_Months;
		STRING4		Payment_History_Length;
		STRING12	Year_To_Date_Purchases_Count;
		STRING12	Lifetime_To_Date_Purchases_Count;
		STRING20	Year_To_Date_Purchases_Sum_Amount;
		STRING20	Lifetime_To_Date_Purchases_Sum_Amount;
		STRING12	Payment_Amount_Scheduled;
		STRING12	Recent_Payment_Amount;
		STRING8		Recent_Payment_Date;
		STRING12	Remaining_Balance;
		STRING12	Carried_Over_Amount;
		STRING12	New_Applied_Charges;
		STRING12	Balloon_Payment_Due;
		STRING8		Balloon_Payment_Due_Date;
		STRING8		Delinquency_Date;
		STRING8		Days_Delinquent;
		STRING12	Past_Due_Amount;
		STRING3		Maximum_Number_Of_Past_Due_Aging_Amounts_Buckets_Provided;
		STRING3		Past_Due_Aging_Bucket_Type;//Changed in V5
		STRING12	Past_Due_Aging_Amount_Bucket_1;
		STRING12	Past_Due_Aging_Amount_Bucket_2;
		STRING12	Past_Due_Aging_Amount_Bucket_3;
		STRING12	Past_Due_Aging_Amount_Bucket_4;
		STRING12	Past_Due_Aging_Amount_Bucket_5;
		STRING12	Past_Due_Aging_Amount_Bucket_6;
		STRING12	Past_Due_Aging_Amount_Bucket_7;
		STRING3		Maximum_Number_Of_Payment_Tracking_Cycle_Periods_Provided;
		STRING3		Payment_Tracking_Cycle_Type;//Changed in V5
		STRING4		Payment_Tracking_Cycle_0_Current;
		STRING4		Payment_Tracking_Cycle_1_1_To_30_days;
		STRING4		Payment_Tracking_Cycle_2_31_To_60_days;
		STRING4		Payment_Tracking_Cycle_3_61_To_90_days;
		STRING4		Payment_Tracking_Cycle_4_91_To_120_days;
		STRING4		Payment_Tracking_Cycle_5_121_To_150days;
		STRING4		Payment_Tracking_Number_Of_Times_Cycle_6_151_To_180_days;
		STRING4		Payment_Tracking_Number_Of_Times_Cycle_7_181_Or_greater_days;
		STRING8		Date_Account_Was_Charged_Off;
		STRING12	Amount_Charged_Off_By_Creditor;
		STRING3		Charge_Off_Type_Indicator;//Changed in V5
		STRING12	Total_Charge_Off_Recoveries_To_Date;
		STRING1		Government_Guarantee_Flag;
		STRING3		Government_Guarantee_Category;//Changed in V5
		STRING3		Portion_Of_Account_Guaranteed_By_Government;
		STRING1		Guarantors_Indicator;
		STRING2		Number_Of_Guarantors;
		STRING1		Owners_Indicator;
		STRING2		Number_Of_Principals;
		STRING3		Account_Update_Deletion_Indicator;
	END;
	EXPORT	AB	:=	RECORD
		AccountBaseSegment;
	END;
	EXPORT	AB_Virtual	:=	RECORD
		AccountBaseSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	MasterAccountContractSegment	:=	RECORD	// (MA)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING50	Master_Account_Or_Contract_Number_Identifier;
	END;
	EXPORT	MA	:=	RECORD
		MasterAccountContractSegment;
	END;
	EXPORT	MA_Virtual	:=	RECORD
		MasterAccountContractSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	AddressSegment	:=	RECORD	// (AD)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING100	Address_Line_1;
		STRING100	Address_Line_2;
		STRING50	City;
		STRING2		State;
		STRING6		Zip_Code_or_CA_Postal_Code;
		STRING4		Postal_Code;
		STRING2		Country_Code;
		STRING1		Primary_Address_Indicator;
		STRING3		Address_Classification;
	END;
	EXPORT	AD	:=	RECORD
		AddressSegment;
	END;
	EXPORT	AD_Virtual	:=	RECORD
		AddressSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	PhoneNumberSegment	:=	RECORD	// (PN)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING3		Area_Code;
		STRING7		Phone_Number;
		STRING10	Phone_Extension;
		STRING1		Primary_Phone_Indicator;
		STRING3		Published_Unlisted_Indicator;
		STRING3		Phone_Type;
	END;
	EXPORT	PN	:=	RECORD
		PhoneNumberSegment;
	END;
	EXPORT	PN_Virtual	:=	RECORD
		PhoneNumberSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	TaxID_SSNSegment	:=	RECORD	// (TI)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING9		Federal_TaxID_SSN;
		STRING3		Federal_TaxID_SSN_Identifier		
	END;
	EXPORT	TI	:=	RECORD
		TaxID_SSNSegment;
	END;
	EXPORT	TI_Virtual	:=	RECORD
		TaxID_SSNSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	IndividualGuarantorOwnerSegment	:=	RECORD	// (IS)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING50	Original_fname;
		STRING50	Original_mname;
		STRING50	Original_lname;
		STRING5		Original_suffix;
		STRING100	E_Mail_Address;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_To_Business_Indicator;//Changed in V5
		STRING150	Business_Title;
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership;
	END;
	EXPORT	IS	:=	RECORD
		IndividualGuarantorOwnerSegment;
	END;
	EXPORT	IS_Virtual	:=	RECORD
		IndividualGuarantorOwnerSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	BusinessGuarantorOwnerSegment	:=	RECORD	// (BS)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING250	Business_Name;
		STRING250	Web_Address;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_To_Business_Indicator;//Changed in V5
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership_If_Owner_Principal;
	END;
	EXPORT	BS	:=	RECORD
		BusinessGuarantorOwnerSegment;
	END;
	EXPORT	BS_Virtual	:=	RECORD
		BusinessGuarantorOwnerSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	BusinessIndustryIdentifierSegment	:=	RECORD	// (BI)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING3		Classification_Code_Type;//Changed in V5
		STRING25	Classification_Code;
		STRING1		Primary_Industry_Code_Indicator;
		STRING1		Privacy_Indicator;
	END;
	EXPORT	BI	:=	RECORD
		BusinessIndustryIdentifierSegment;
	END;
	EXPORT	BI_Virtual	:=	RECORD
		BusinessIndustryIdentifierSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	CollateralSegment	:=	RECORD	// (CL)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING1		Collateral_Indicator;
		STRING3		Type_Of_Collateral_Secured_For_This_Account;
		STRING250	Collateral_Description;
		STRING50	UCC_Filing_Number;//Changed in V5 Deprecated
		STRING3		UCC_Filing_Type;//Changed in V5 Deprecated
		STRING8		UCC_Filing_Date;//Changed in V5 Deprecated
		STRING8		UCC_Filing_Expiration_Date;//Changed in V5 Deprecated
		STRING100	UCC_Filing_Jurisdiction;//Changed in V5 Deprecated
		STRING250	UCC_Filing_Description;//Changed in V5 Deprecated
	END;
	EXPORT	CL	:=	RECORD
		CollateralSegment;
	END;
	EXPORT	CL_Virtual	:=	RECORD
		CollateralSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	MemberSpecificSegment	:=	RECORD	// (MS)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING20	Name_Of_Value;
		STRING250	Value_String;
		STRING1		Privacy_Indicator;
	END;
	EXPORT	MS	:=	RECORD
		MemberSpecificSegment;
	END;
	EXPORT	MS_Virtual	:=	RECORD
		MemberSpecificSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	AccountModificationHistorySegment	:=	RECORD	// (AH)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING30	Previous_Member_ID;
		STRING50	Previous_Account_Number;
		STRING3		Previous_Account_Type;
		STRING3		Type_Of_Conversion_Maintenance;
		STRING8		Date_Account_Converted;
	END;
	EXPORT	AH	:=	RECORD
		AccountModificationHistorySegment;
	END;
	EXPORT	AH_Virtual	:=	RECORD
		AccountModificationHistorySegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	DigitalFootPrintSegment	:=	RECORD	// (DF)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING50	InformationTypeDescription;
		STRING250	InformationValue;
		STRING2		InformationValueType;
	END;
	EXPORT	DF	:=	RECORD
		DigitalFootPrintSegment;
	END;
	EXPORT	DF_Virtual	:=	RECORD
		DigitalFootPrintSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;
	
	EXPORT	MerchantProcessingDataSegment	:=	RECORD	// (MD)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		string9		Total_Transaction_Count;
		string12	Total_Transaction_Amount;
		string2		Merchant_Account_Status;
		string9		Total_Processing_Rejects_Count;
		string12	Total_Processing_Rejects_Amount;
		string9		Total_Chargeback_Adjustment_Count;
		string12	Total_Chargeback_Adjustment_Amount;
		string9		Total_Processing_Refund_Count_;
		string12	Total__Processing_Refund_Amount_;
		string12	Total_Amount_Unpaid;
		string12	Total_Amount_Settled;
		string4		Average_Days_to_Deliver;
		string12	Merchant_Reserve_Amount;
	END;
	EXPORT	MD	:=	RECORD
		MerchantProcessingDataSegment;
	END;
	EXPORT	MD_Virtual	:=	RECORD
		MerchantProcessingDataSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;
	
	EXPORT	MerchantCardTransaction	:=	RECORD	// (CT)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING2		Card_Transaction_Type;
		STRING9		Total_Card_Transaction_Type_Count;
		STRING12	Total_Card_Transaction_Type_Amount;

	END;
	EXPORT	CT	:=	RECORD
		MerchantCardTransaction;
	END;
	EXPORT	CT_Virtual	:=	RECORD
		MerchantCardTransaction;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	MerchantChargeback	:=	RECORD	// (MT)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING2		Chargeback_Code;
		STRING9		Total_Chargeback_Count;
		STRING12	Total_Chargeback_Amount;

	END;
	EXPORT	MT	:=	RECORD
		MerchantChargeback;
	END;
	EXPORT	MT_Virtual	:=	RECORD
		MerchantChargeback;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	MerchantRefund	:=	RECORD	// (MR)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING2		Refund_Code;
		STRING9		Total_Refund_Count;
		STRING12	Total_Refund_Amount;

	END;
	EXPORT	MR	:=	RECORD
		MerchantRefund;
	END;
	EXPORT	MR_Virtual	:=	RECORD
		MerchantRefund;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	MerchantClassificationCode	:=	RECORD	// (MC)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		string4		Merchant_Classification_Code;
		string9		Total_Merchant_Classification_Code_Count;
		string12	Total_Merchant_Classification_Code_Amount;
		string4		Average_Days_to_Deliver_by_MCC;
		string9		Total_Chargeback_Count_by_MCC;
		string12	Total_Chargeback_Amount_by_MCC;
		string9		Total_Refund_Count_by_MCC;
		string12	Total_Refund_Amount_by_MCC;
		string1		Privacy_Indicator;

	END;
	EXPORT	MC	:=	RECORD
		MerchantClassificationCode;
	END;
	EXPORT	MC_Virtual	:=	RECORD
		MerchantClassificationCode;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;
	
	EXPORT	MerchantDestinationMedia	:=	RECORD	// (DM)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING12	Account_Base_Number;
		STRING2		Destination_Media_Code;
		STRING9		Total_Destination_Media_Code;
		STRING12	Total_Destination_Media_Amount;

	END;
	EXPORT	DM	:=	RECORD
		MerchantDestinationMedia;
	END;
	EXPORT	DM_Virtual	:=	RECORD
		MerchantDestinationMedia;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	TrailerSegment	:=	RECORD	// (ZZ)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Parent_Sequence_Number;
		STRING9		Total_AB_Segments;
		STRING9		Total_MA_Segments;
		STRING9		Total_AD_Segments;
		STRING9		Total_PN_Segments;
		STRING9		Total_TI_Segments;
		STRING9		Total_IS_Segments;
		STRING9		Total_BS_Segments;
		STRING9		Total_BI_Segments;
		STRING9		Total_CL_Segments;
		STRING9		Total_MS_Segments;
		STRING9		Total_AH_Segments;
		STRING20	Sum_Of_Balance_Amounts;
		STRING9		Total_DF_Segments;
		STRING9		Total_MD_Segments;
		STRING9		Total_CT_Segments;
		STRING9		Total_MT_Segments;
		STRING9		Total_MR_Segments;
		STRING9		Total_MC_Segments;
		STRING9		Total_DM_Segments;
	END;
	EXPORT	ZZ	:=	RECORD
		TrailerSegment;
	END;
	EXPORT	ZZ_Virtual	:=	RECORD
		TrailerSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	FileFooterTrailerSegment	:=	RECORD	//(FZ)
		STRING2		Segment_Identifier;
		STRING12	File_Sequence_Number;
		STRING12	Total_AA_Segments;
		STRING12	Total_ZZ_Segments;
		STRING12	Total_Record_Count;
	END;
	EXPORT	FZ	:=	RECORD
		FileFooterTrailerSegment;
	END;
	EXPORT	FZ_Virtual	:=	RECORD
		FileFooterTrailerSegment;
		STRING		__filename 				{ VIRTUAL(logicalfilename)};
	END;

	EXPORT	IndividualOwnerLayout	:=	RECORD
		IndividualGuarantorOwnerSegment;
		DATASET(AddressSegment)					address{MAXCOUNT(100)};
		DATASET(PhoneNumberSegment)			phone{MAXCOUNT(100)};
		DATASET(TaxID_SSNSegment)				taxID{MAXCOUNT(100)};
		DATASET(MemberSpecificSegment)	memberSpecific{MAXCOUNT(100)};
		DATASET(DigitalFootPrintSegment)		DigitalFootprint{MAXCOUNT(100)};
	END;

	EXPORT	IndividualOwnerLayout_Virtual	:=	RECORD
		IS_Virtual;
		DATASET(AD_Virtual)							address{MAXCOUNT(100)};
		DATASET(PN_Virtual)							phone{MAXCOUNT(100)};
		DATASET(TI_Virtual)							taxID{MAXCOUNT(100)};
		DATASET(MS_Virtual)							memberSpecific{MAXCOUNT(100)};
		DATASET(DF_Virtual)							DigitalFootprint{MAXCOUNT(100)};
	END;

	EXPORT	BusinessOwnerLayout	:=	RECORD
		BusinessGuarantorOwnerSegment;
		DATASET(AddressSegment)											address{MAXCOUNT(100)};
		DATASET(PhoneNumberSegment)									phone{MAXCOUNT(100)};
		DATASET(BusinessIndustryIdentifierSegment)	businessIndustryClassification{MAXCOUNT(25)};
		DATASET(TaxID_SSNSegment)										taxID{MAXCOUNT(100)};
		DATASET(MemberSpecificSegment)							memberSpecific{MAXCOUNT(100)};
		DATASET(DigitalFootPrintSegment)			DigitalFootprint{MAXCOUNT(100)};
	END;

	EXPORT	BusinessOwnerLayout_Virtual	:=	RECORD
		BS_Virtual;
		DATASET(AD_Virtual)													address{MAXCOUNT(100)};
		DATASET(PN_Virtual)													phone{MAXCOUNT(100)};
		DATASET(BI_Virtual)													businessIndustryClassification{MAXCOUNT(25)};
		DATASET(TI_Virtual)													taxID{MAXCOUNT(100)};
		DATASET(MS_Virtual)													memberSpecific{MAXCOUNT(100)};
		DATASET(DF_Virtual)													DigitalFootprint{MAXCOUNT(100)};
	END;

	Export MemberProcessingDataLayout:=RECORD
		MerchantProcessingDataSegment;
		DATASET(MerchantCardTransaction)							MerchantCTSegment{MAXCOUNT(100)};						//	CT
		DATASET(MerchantChargeback)							MerchantChargebackSegment{MAXCOUNT(100)};						//	MT
		DATASET(MerchantRefund)							MerchantRefundSegment{MAXCOUNT(100)};								//	MR
		DATASET(MerchantClassificationCode)							MemberMCSegment{MAXCOUNT(500)};							//	MC
		DATASET(MerchantDestinationMedia)							MemberDMSegment{MAXCOUNT(100)};							//	DM
	END;

	Export MemberProcessingDataLayout_Virtual:=RECORD
		MD_Virtual;
		DATASET(CT_Virtual)							MerchantCTSegment{MAXCOUNT(100)};								//	CT
		DATASET(MT_Virtual)							MerchantChargebackSegment{MAXCOUNT(100)};						//	MT
		DATASET(MR_Virtual)							MerchantRefundSegment{MAXCOUNT(100)};							//	MR
		DATASET(MC_Virtual)							MemberMCSegment{MAXCOUNT(500)};									//	MC
		DATASET(DM_Virtual)							MemberDMSegment{MAXCOUNT(100)};									//	DM
	END;

	EXPORT	AccountDataLayout	:=	RECORD
		STRING												process_date;
		AccountBaseSegment;
		DATASET(MasterAccountContractSegment)				masterAccount{MAXCOUNT(1)};											//	MA
		DATASET(AddressSegment)											address{MAXCOUNT(100)};													//	AD
		DATASET(AccountModificationHistorySegment)	history{MAXCOUNT(1000)};													//	AH
		DATASET(PhoneNumberSegment)									phone{MAXCOUNT(100)};														//	PN
		DATASET(TaxID_SSNSegment)										taxID{MAXCOUNT(100)};														//	TI
		DATASET(IndividualOwnerLayout)							individualOwner{MAXCOUNT(200)};									//	IS
		DATASET(BusinessOwnerLayout)								businessOwner{MAXCOUNT(100)};										//	BS
		DATASET(BusinessIndustryIdentifierSegment)	businessIndustryClassification{MAXCOUNT(25)};		//	BI
		DATASET(CollateralSegment)									collateral{MAXCOUNT(1000)};											//	CL
		DATASET(MemberSpecificSegment)							memberSpecific{MAXCOUNT(100)};									//	MS
		DATASET(DigitalFootPrintSegment)							DigitalFootPrint{MAXCOUNT(100)};									//	DF
		DATASET(MemberProcessingDataLayout)							MerchantProcessingData{MAXCOUNT(100)};									//	MD
		HeaderSegment																portfolioHeader;																//	AA
		FileHeaderSegment														fileHeader;																			//	FA
		STRING50																		Original_Contract_Account_Number:='';
		UNSIGNED8																		sbfe_id:=0;
		BOOLEAN																			active:=TRUE;
		STRING																			__filename:='';
		STRING1																			correction_type:='';
		STRING8																			correction_date:='';
		STRING																			original_process_date:='';
	END;

	EXPORT	AccountDataLayout_Virtual	:=	RECORD
		STRING																			process_date;
		AB_Virtual;																																									//	AB
		DATASET(MA_Virtual)													masterAccount{MAXCOUNT(1)};											//	MA
		DATASET(AD_Virtual)													address{MAXCOUNT(100)};													//	AD
		DATASET(AH_Virtual)													history{MAXCOUNT(1000)};													//	AH
		DATASET(PN_Virtual)													phone{MAXCOUNT(100)};														//	PN
		DATASET(TI_Virtual)													taxID{MAXCOUNT(100)};														//	TI
		DATASET(IndividualOwnerLayout_Virtual)			individualOwner{MAXCOUNT(200)};									//	IS
		DATASET(BusinessOwnerLayout_Virtual)				businessOwner{MAXCOUNT(100)};										//	BS
		DATASET(BI_Virtual)													businessIndustryClassification{MAXCOUNT(25)};		//	BI
		DATASET(CL_Virtual)													collateral{MAXCOUNT(1000)};											//	CL
		DATASET(MS_Virtual)													memberSpecific{MAXCOUNT(100)};									//	MS
		DATASET(DF_Virtual)							DigitalFootPrint{MAXCOUNT(100)};									//	MS
		DATASET(MemberProcessingDataLayout_Virtual)							MerchantProcessingData{MAXCOUNT(100)};									//	MS
		AA_Virtual																	portfolioHeader;																//	AA
		FA_Virtual																	fileHeader;																			//	FA
		STRING50																		Original_Contract_Account_Number:='';
		UNSIGNED8																		sbfe_id:=0;
		BOOLEAN																			active:=TRUE;
	END;

	EXPORT	LayoutTradeline	:=	RECORD
		AccountBaseSegment AND NOT
		[
			Segment_Identifier,
			File_Sequence_Number,
			Parent_Sequence_Number
		];
	END;


	EXPORT	SBFEAccountPreLayout	:=	RECORD	
		STRING													process_date;
		STRING2													Record_Type;
		STRING30												Sbfe_Contributor_Number;
		STRING50												Contract_Account_Number;
		STRING50												Original_Contract_Account_Number;
		STRING3													Account_Type_Reported;
		STRING8													Extracted_Date;
		STRING8													Cycle_End_Date;
		STRING250												Account_Holder_Business_Name;
		STRING250												Clean_Account_Holder_Business_Name;
		STRING250												DBA;
		STRING250												Clean_DBA;
		STRING250												Business_Name;
		STRING250												Clean_Business_Name;
		STRING250												Company_Website;
		STRING50												Original_fname;
		STRING50												Original_mname;
		STRING50												Original_lname;
		STRING5													Original_suffix;
		STRING100												E_Mail_Address;
		STRING3													Guarantor_Owner_Indicator;
		STRING3													Relationship_To_Business_Indicator;
		STRING3													Percent_Of_Liability;
		STRING3													Percent_Of_Ownership;
		STRING150												Business_Title;
		STRING100												Original_Address_Line_1;
		STRING100												Original_Address_Line_2;
		STRING50												Original_City;
		STRING2													Original_State;
		STRING6													Original_Zip_Code_or_CA_Postal_Code;
		STRING4													Original_Postal_Code;
		STRING2													Original_Country_Code;
		STRING1													Primary_Address_Indicator;
		STRING3													Address_Classification;
		STRING3													Original_Area_Code;
		STRING7													Original_Phone_Number;
		STRING10												Phone_Extension;
		STRING1													Primary_Phone_Indicator;
		STRING3													Published_Unlisted_Indicator;
		STRING3													Phone_Type;
		STRING10												Phone_Number;
		STRING9													Federal_TaxID_SSN;
		STRING3													Federal_TaxID_SSN_Identifier;
		LayoutTradeline									Tradeline;	//	Tradeline Data
		DATASET(AddressSegment)					address{MAXCOUNT(100)};
		DATASET(PhoneNumberSegment)			phone{MAXCOUNT(100)};
		DATASET(TaxID_SSNSegment)				taxID{MAXCOUNT(100)};
		DATASET(IndividualOwnerLayout)	individualOwner{MAXCOUNT(200)};
		DATASET(BusinessOwnerLayout)		businessOwner{MAXCOUNT(100)};
		DATASET(DigitalFootPrintSegment)		DigitalFootprint{MAXCOUNT(100)};
		UNSIGNED8												persistent_record_ID;				//	Added for BIP project
		UNSIGNED8												sbfe_id;										//	Added for BIP project
		STRING2													source:=Constants().source;	//	Added for BIP project
		BOOLEAN													active;
		STRING1													correction_type;
		STRING8													correction_date;
		STRING													original_process_date;
	END;

	EXPORT	SBFEAccountLayout	:=	RECORD
		STRING12	timestamp;
		STRING		process_date;
		STRING2		Record_Type;
		UNSIGNED6	did;
		UNSIGNED1	did_score;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		STRING250	Account_Holder_Business_Name;
		STRING250	Clean_Account_Holder_Business_Name;
		STRING250	DBA;
		STRING250	Clean_DBA;
		STRING250	Business_Name;
		STRING250	Clean_Business_Name;
		STRING250	Company_Website;
		STRING50	Original_fname;
		STRING50	Original_mname;
		STRING50	Original_lname;
		STRING5		Original_suffix;
		STRING100	E_Mail_Address;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_To_Business_Indicator;
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership;
		STRING150	Business_Title;
		STRING5		Clean_title;
		STRING20	Clean_fname;
		STRING20	Clean_mname;
		STRING20	Clean_lname;
		STRING5		Clean_suffix;
		STRING100	Original_Address_Line_1;
		STRING100	Original_Address_Line_2;
		STRING50	Original_City;
		STRING2		Original_State;
		STRING6		Original_Zip_Code_or_CA_Postal_Code;
		STRING4		Original_Postal_Code;
		STRING2		Original_Country_Code;
		Address.Layout_Clean182_fips;
		UNSIGNED8	rawaid				:=	0;
		STRING1		Primary_Address_Indicator;
		STRING3		Address_Classification;
		STRING3		Original_Area_Code;
		STRING7		Original_Phone_Number;
		STRING10	Phone_Extension;
		STRING1		Primary_Phone_Indicator;
		STRING3		Published_Unlisted_Indicator;
		STRING3		Phone_Type;
		STRING10	Phone_Number;
		STRING9		Federal_TaxID_SSN;
		STRING3		Federal_TaxID_SSN_Identifier;
		LayoutTradeline		Tradeline;		//	Tradeline Data
		BIPV2.IDlayouts.l_xlink_ids;		//	Added for BIP project
		UNSIGNED8	persistent_record_ID;	//	Added for BIP project
		UNSIGNED8	sbfe_id;							//	Added for BIP project
		STRING2		source:=Constants().source;					//	Added for BIP project
		BOOLEAN		active;
		STRING1		correction_type;
		STRING8		correction_date;
		STRING		original_process_date;
		//DF-26180 Add CCPA fields to . thor_data400::key::sbfe::qa::businessownerinformation
		UNSIGNED4	global_sid 			:= 0;
		UNSIGNED8   record_sid 			:= 0;
	END;
	
	EXPORT	rAccountBase	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING4		Overall_File_Format_Version;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		AB;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
	END;

	EXPORT	rTradelineKey	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		rAccountBase;
        string     Raw_DBT_V5;
        string     DBT_V5;
		STRING3	   DBT;
    END;
	
	EXPORT	rBIClassification	:=	RECORD
		STRING2		Record_Type;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		BI;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
	END;

	EXPORT	rBusinessOwner	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		BS;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
		//DF-26180 Add CCPA fields to thor_data400::key::sbfe::qa::businessowner
		UNSIGNED6	did					:= 0;
		UNSIGNED4	global_sid 			:= 0;
		UNSIGNED8   record_sid 			:= 0;
	END;
	
	EXPORT	rCollateral	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		CL;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
	END;

	EXPORT	rHistory	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		AH;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
	END;

	EXPORT	rIndividualOwner	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		IS;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
		//DF-26180 Add CCPA fields to  thor_data400::key::sbfe::qa::individualowner
		UNSIGNED6	did					:= 0;
		UNSIGNED4	global_sid 			:= 0;
		UNSIGNED8   record_sid 			:= 0;
	END;
	
	EXPORT	rMasterAccount	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		MA;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
	END;
	
	EXPORT	rDigitalFootprint	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		DF;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
	END;

	EXPORT	rPreMerchantProcessing	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		string9		Total_Transaction_Count;
		string12	Total_Transaction_Amount;
		string2		Merchant_Account_Status;
		string9		Total_Processing_Rejects_Count;
		string12	Total_Processing_Rejects_Amount;
		string9		Total_Chargeback_Adjustment_Count;
		string12	Total_Chargeback_Adjustment_Amount;
		string9		Total_Processing_Refund_Count_;
		string12	Total__Processing_Refund_Amount_;
		string12	Total_Amount_Unpaid;
		string12	Total_Amount_Settled;
		string4		Average_Days_to_Deliver;
		string12	Merchant_Reserve_Amount;
		STRING2		Card_Transaction_Type;
		STRING9		Total_Card_Transaction_Type_Count;
		STRING12	Total_Card_Transaction_Type_Amount;
		STRING2		Chargeback_Code;
		STRING9		Total_Chargeback_Count;
		STRING12	Total_Chargeback_Amount;
		STRING2		Refund_Code;
		STRING9		Total_Refund_Count;
		STRING12	Total_Refund_Amount;
		string4		Merchant_Classification_Code;
		string9		Total_Merchant_Classification_Code_Count;
		string12	Total_Merchant_Classification_Code_Amount;
		string4		Average_Days_to_Deliver_by_MCC;
		string9		Total_Chargeback_Count_by_MCC;
		string12	Total_Chargeback_Amount_by_MCC;
		string9		Total_Refund_Count_by_MCC;
		string12	Total_Refund_Amount_by_MCC;
		string1		Privacy_Indicator;
		STRING2		Destination_Media_Code;
		STRING9		Total_Destination_Media_Code;
		STRING12	Total_Destination_Media_Amount;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
		DATASET(MerchantCardTransaction)							MerchantCTSegment{MAXCOUNT(100)};						//	CT
		DATASET(MerchantChargeback)							MerchantChargebackSegment{MAXCOUNT(100)};						//	MT
		DATASET(MerchantRefund)							MerchantRefundSegment{MAXCOUNT(100)};								//	MR
		DATASET(MerchantClassificationCode)							MemberMCSegment{MAXCOUNT(500)};							//	MC
		DATASET(MerchantDestinationMedia)							MemberDMSegment{MAXCOUNT(100)};							//	DM
	end;

	EXPORT	rMerchantProcessing	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		string9		Total_Transaction_Count;
		string12	Total_Transaction_Amount;
		string2		Merchant_Account_Status;
		string9		Total_Processing_Rejects_Count;
		string12	Total_Processing_Rejects_Amount;
		string9		Total_Chargeback_Adjustment_Count;
		string12	Total_Chargeback_Adjustment_Amount;
		string9		Total_Processing_Refund_Count_;
		string12	Total__Processing_Refund_Amount_;
		string12	Total_Amount_Unpaid;
		string12	Total_Amount_Settled;
		string4		Average_Days_to_Deliver;
		string12	Merchant_Reserve_Amount;
		STRING2		Card_Transaction_Type;
		STRING9		Total_Card_Transaction_Type_Count;
		STRING12	Total_Card_Transaction_Type_Amount;
		STRING2		Chargeback_Code;
		STRING9		Total_Chargeback_Count;
		STRING12	Total_Chargeback_Amount;
		STRING2		Refund_Code;
		STRING9		Total_Refund_Count;
		STRING12	Total_Refund_Amount;
		string4		Merchant_Classification_Code;
		string9		Total_Merchant_Classification_Code_Count;
		string12	Total_Merchant_Classification_Code_Amount;
		string4		Average_Days_to_Deliver_by_MCC;
		string9		Total_Chargeback_Count_by_MCC;
		string12	Total_Chargeback_Amount_by_MCC;
		string9		Total_Refund_Count_by_MCC;
		string12	Total_Refund_Amount_by_MCC;
		string1		Privacy_Indicator;
		STRING2		Destination_Media_Code;
		STRING9		Total_Destination_Media_Code;
		STRING12	Total_Destination_Media_Amount;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
	END;

	
	EXPORT	rMemberSpecific	:=	RECORD
		STRING2		Record_Type;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING		process_date;
		STRING		original_process_date;
		STRING8		Extracted_Date;
		STRING8		Cycle_End_Date;
		MS;
		STRING2		source:=Constants().source;
		BOOLEAN		active;
	END;

	EXPORT	rSBFEIDCache	:=	RECORD
		STRING30	Sbfe_Contributor_Number;
		STRING50	Original_Contract_Account_Number;
		UNSIGNED8	sbfe_id;
	END;
	
	EXPORT	rCleanAddrCache	:=	RECORD
		STRING	prep_address1;
		STRING	prep_address2;
		STRING	Clean_address1;
		STRING	Clean_address2;
		AddressSegment;
		STRING182	clean;
	END;
	
	EXPORT	rReleasedate	:=	RECORD
		STRING9	version;
		STRING8	cert_date;
		STRING8	cert_time;
		STRING8	prod_date;
		STRING8	prod_time;
		STRING1	update_type;
		STRING8	first_date;
		STRING8	last_date;
	END;
	
	EXPORT	rMapSBFEContributorNumber	:=	RECORD
		STRING30	Old_Sbfe_Contributor_Number;
		STRING30	New_Sbfe_Contributor_Number;
	END;
	
END;