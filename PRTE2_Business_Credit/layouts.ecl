import BIPV2, Address, Business_Credit, prte2;

EXPORT layouts := module

export input := record
		STRING process_date;
		business_credit.layouts.AccountBaseSegment;		//	AB
	//MasterAccountContractSegment
		STRING2		MasterAccount_Segment_Identifier;
		STRING12	MasterAccount_File_Sequence_Number;
		STRING12	MasterAccount_Parent_Sequence_Number;
		STRING12	MasterAccount_Account_Base_Number;
		STRING50	Master_Account_Or_Contract_Number_Identifier;
	//AddressSegment
		STRING2		Address_Segment_Identifier;
		STRING12	Address_File_Sequence_Number;
		STRING12	Address_Parent_Sequence_Number;
		STRING12	Address_Account_Base_Number;
		STRING100	Address_Line_1;
		STRING100	Address_Line_2;
		STRING50	City;
		STRING2		State;
		STRING6		Zip_Code_or_CA_Postal_Code;
		STRING4		Postal_Code;
		STRING2		Country_Code;
		STRING1		Primary_Address_Indicator;
		STRING3		Address_Classification;
	//AccountModificationHistorySegment
		STRING2		History_Segment_Identifier;
		STRING12	History_File_Sequence_Number;
		STRING12	History_Parent_Sequence_Number;
		STRING12	History_Account_Base_Number;
		STRING30	Previous_Member_ID;
		STRING50	Previous_Account_Number;
		STRING3		Previous_Account_Type;
		STRING3		Type_Of_Conversion_Maintenance;
		STRING8		Date_Account_Converted;
	//PhoneNumberSegment
		STRING2		PhoneNumber_Segment_Identifier;
		STRING12	PhoneNumber_File_Sequence_Number;
		STRING12	PhoneNumber_Parent_Sequence_Number;
		STRING12	PhoneNumber_Account_Base_Number;
		STRING3		Area_Code;
		STRING7		Phone_Number;
		STRING10	Phone_Extension;
		STRING1		Primary_Phone_Indicator;
		STRING3		Published_Unlisted_Indicator;
		STRING3		Phone_Type;
	//TaxID_SSNSegment
		STRING2		TaxID_SSN_Segment_Identifier;
		STRING12	TaxID_SSN_File_Sequence_Number;
		STRING12	TaxID_SSN_Parent_Sequence_Number;
		STRING12	TaxID_SSN_Account_Base_Number;
		STRING9		Federal_TaxID_SSN;
		STRING3		Federal_TaxID_SSN_Identifier;		
	//IndividualOwnerLayout
		STRING2		IndividualOwner_Segment_Identifier;
		STRING12	IndividualOwner_File_Sequence_Number;
		STRING12	IndividualOwner_Parent_Sequence_Number;
		STRING12	IndividualOwner_Account_Base_Number;
		STRING50	Original_fname;
		STRING50	Original_mname;
		STRING50	Original_lname;
		STRING5		Original_suffix;
		STRING100	E_Mail_Address;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_To_Business_Indicator;
		STRING150	Business_Title;
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership;
	//IndividualOwner Address
		STRING2		IndividualOwner_Address_Segment_Identifier;
		STRING12	IndividualOwner_Address_File_Sequence_Number;
		STRING12	IndividualOwner_Address_Parent_Sequence_Number;
		STRING12	IndividualOwner_Address_Account_Base_Number;
		STRING100	IndividualOwner_Address_Line_1;
		STRING100	IndividualOwner_Address_Line_2;
		STRING50	IndividualOwner_Address_City;
		STRING2		IndividualOwner_Address_State;
		STRING6		IndividualOwner_Address_Zip_Code_or_CA_Postal_Code;
		STRING4		IndividualOwner_Address_Postal_Code;
		STRING2		IndividualOwner_Address_Country_Code;
		STRING1		IndividualOwner_Address_Primary_Address_Indicator;
		STRING3		IndividualOwner_Address_Address_Classification;
	//IndividualOwner Phone	
		STRING2		IndividualOwner_PhoneNumber_Segment_Identifier;
		STRING12	IndividualOwner_PhoneNumber_File_Sequence_Number;
		STRING12	IndividualOwner_PhoneNumber_Parent_Sequence_Number;
		STRING12	IndividualOwner_PhoneNumber_Account_Base_Number;
		STRING3		IndividualOwner_PhoneNumber_Area_Code;
		STRING7		IndividualOwner_PhoneNumber_Phone_Number;
		STRING10	IndividualOwner_PhoneNumber_Phone_Extension;
		STRING1		IndividualOwner_PhoneNumber_Primary_Phone_Indicator;
		STRING3		IndividualOwner_PhoneNumber_Published_Unlisted_Indicator;
		STRING3		IndividualOwner_PhoneNumber_Phone_Type;
	//IndividualOwner TaxID_SSN
		STRING2		IndividualOwner_TaxID_SSN_Segment_Identifier;
		STRING12	IndividualOwner_TaxID_SSN_File_Sequence_Number;
		STRING12	IndividualOwner_TaxID_SSN_Parent_Sequence_Number;
		STRING12	IndividualOwner_TaxID_SSN_Account_Base_Number;
		STRING9		IndividualOwner_Federal_TaxID_SSN;
		STRING3		IndividualOwner_Federal_TaxID_SSN_Identifier;	
	//IndividualOwner MemberSpecific
		STRING2		IndividualOwner_MemberSpecific_Segment_Identifier;
		STRING12	IndividualOwner_MemberSpecific_File_Sequence_Number;
		STRING12	IndividualOwner_MemberSpecific_Parent_Sequence_Number;
		STRING12	IndividualOwner_MemberSpecific_Account_Base_Number;
		STRING20	IndividualOwner_MemberSpecific_Name_Of_Value;
		STRING250	IndividualOwner_MemberSpecific_Value_String;
		STRING1		IndividualOwner_MemberSpecific_Privacy_Indicator;
	//BusinessOwnerLayout
		STRING2		BusinessOwner_Segment_Identifier;
		STRING12	BusinessOwner_File_Sequence_Number;
		STRING12	BusinessOwner_Parent_Sequence_Number;
		STRING12	BusinessOwner_Account_Base_Number;
		STRING250	BusinessOwner_Business_Name;
		STRING250	BusinessOwner_Web_Address;
		STRING3		BusinessOwner_Guarantor_Owner_Indicator;
		STRING3		BusinessOwner_Relationship_To_Business_Indicator;
		STRING3		BusinessOwner_Percent_Of_Liability;
		STRING3		BusinessOwner_Percent_Of_Ownership_If_Owner_Principal;
	//BusinessOwner Address
		STRING2		BusinessOwner_Address_Segment_Identifier;
		STRING12	BusinessOwner_Address_File_Sequence_Number;
		STRING12	BusinessOwner_Address_Parent_Sequence_Number;
		STRING12	BusinessOwner_Address_Account_Base_Number;
		STRING100	BusinessOwner_Address_Line_1;
		STRING100	BusinessOwner_Address_Line_2;
		STRING50	BusinessOwner_Address_City;
		STRING2		BusinessOwner_Address_State;
		STRING6		BusinessOwner_Address_Zip_Code_or_CA_Postal_Code;
		STRING4		BusinessOwner_Address_Postal_Code;
		STRING2		BusinessOwner_Address_Country_Code;
		STRING1		BusinessOwner_Address_Primary_Address_Indicator;
		STRING3		BusinessOwner_Address_Address_Classification;
	//BusinessOwner Phone	
		STRING2		BusinessOwner_PhoneNumber_Segment_Identifier;
		STRING12	BusinessOwner_PhoneNumber_File_Sequence_Number;
		STRING12	BusinessOwner_PhoneNumber_Parent_Sequence_Number;
		STRING12	BusinessOwner_PhoneNumber_Account_Base_Number;
		STRING3		BusinessOwner_PhoneNumber_Area_Code;
		STRING7		BusinessOwner_PhoneNumber_Phone_Number;
		STRING10	BusinessOwner_PhoneNumber_Phone_Extension;
		STRING1		BusinessOwner_PhoneNumber_Primary_Phone_Indicator;
		STRING3		BusinessOwner_PhoneNumber_Published_Unlisted_Indicator;
		STRING3		BusinessOwner_PhoneNumber_Phone_Type;
	//BusinessOwner BusinessIndusty
		STRING2		BusinessOwner_BusinessIndusty_Segment_Identifier;
		STRING12	BusinessOwner_BusinessIndusty_File_Sequence_Number;
		STRING12	BusinessOwner_BusinessIndusty_Parent_Sequence_Number;
		STRING12	BusinessOwner_BusinessIndusty_Account_Base_Number;
		STRING3		BusinessOwner_BusinessIndusty_Classification_Code_Type;
		STRING25	BusinessOwner_BusinessIndusty_Classification_Code;
		STRING1		BusinessOwner_BusinessIndusty_Primary_Industry_Code_Indicator;
		STRING1		BusinessOwner_BusinessIndusty_Privacy_Indicator;
	//BusinessOwner TaxID_SSN
		STRING2		BusinessOwner_TaxID_SSN_Segment_Identifier;
		STRING12	BusinessOwner_TaxID_SSN_File_Sequence_Number;
		STRING12	BusinessOwner_TaxID_SSN_Parent_Sequence_Number;
		STRING12	BusinessOwner_TaxID_SSN_Account_Base_Number;
		STRING9		BusinessOwner_Federal_TaxID_SSN;
		STRING3		BusinessOwner_Federal_TaxID_SSN_Identifier;	
	//BusinessOwner MemberSpecific
		STRING2		BusinessOwner_MemberSpecific_Segment_Identifier;
		STRING12	BusinessOwner_MemberSpecific_File_Sequence_Number;
		STRING12	BusinessOwner_MemberSpecific_Parent_Sequence_Number;
		STRING12	BusinessOwner_MemberSpecific_Account_Base_Number;
		STRING20	BusinessOwner_MemberSpecific_Name_Of_Value;
		STRING250	BusinessOwner_MemberSpecific_Value_String;
		STRING1		BusinessOwner_MemberSpecific_Privacy_Indicator;
	//BusinessIndustryIdentifierSegment
		STRING2		BusinessIndustry_Segment_Identifier;
		STRING12	BusinessIndustry_File_Sequence_Number;
		STRING12	BusinessIndustry_Parent_Sequence_Number;
		STRING12	BusinessIndustry_Account_Base_Number;
		STRING3		BusinessIndustry_Classification_Code_Type;
		STRING25	BusinessIndustry_Classification_Code;
		STRING1		BusinessIndustry_Primary_Industry_Code_Indicator;
		STRING1		BusinessIndustry_Privacy_Indicator;
	//CollateralSegment
		STRING2		Collateral_Segment_Identifier;
		STRING12	Collateral_File_Sequence_Number;
		STRING12	Collateral_Parent_Sequence_Number;
		STRING12	Collateral_Account_Base_Number;
		STRING1		Collateral_Indicator;
		STRING3		Collateral_Type_Of_Collateral_Secured_For_This_Account;
		STRING250	Collateral_Description;
		STRING50	Collateral_UCC_Filing_Number;
		STRING3		Collateral_UCC_Filing_Type;
		STRING8		Collateral_UCC_Filing_Date;
		STRING8		Collateral_UCC_Filing_Expiration_Date;
		STRING100	Collateral_UCC_Filing_Jurisdiction;
		STRING250	Collateral_UCC_Filing_Description;
	//MemberSpecificSegment
		STRING2		MemberSpecific_Segment_Identifier;
		STRING12	MemberSpecific_File_Sequence_Number;
		STRING12	MemberSpecific_Parent_Sequence_Number;
		STRING12	MemberSpecific_Account_Base_Number;
		STRING20	MemberSpecific_Name_Of_Value;
		STRING250	MemberSpecific_Value_String;
		STRING1		MemberSpecific_Privacy_Indicator;
	//HeaderSegment
		STRING2		Header_Segment_Identifier;
		STRING12	Header_File_Sequence_Number;
		STRING30	Header_Sbfe_Contributor_Number;
		STRING8		Header_Extracted_Date;
		STRING8		Header_Cycle_End_Date;
		STRING2		Header_Cycle_Number;
		STRING3		Header_Cycle_Length;
		STRING3		Header_File_Correction_Indicator;
		STRING4		Header_Overall_File_Format_Version;
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
	//FileHeaderSegment
		STRING2		FileHeader_Segment_Identifier;
		STRING12	FileHeader_File_Sequence_Number;
		STRING3		FileHeader_Test_or_Production_Indicator;
		STRING3		FileHeader_File_Type_Indicator;
	
		STRING50		Original_Contract_Account_Number:='';
		UNSIGNED8		sbfe_id:=0;
		BOOLEAN			active:=TRUE;
		STRING			filename:='';
		STRING1			correction_type:='';
		STRING8			correction_date:='';
		STRING			original_process_date:='';
		string9			link_ssn;
		string8			link_dob;
		string9			link_fein;
		string8			link_inc_date;
		string10		cust_name;
		string10		bug_num;
		unsigned6		did;
end;	

	
	EXPORT base := record
		input;
		UNSIGNED1	did_score;
		unsigned8	bdid;
	  STRING2		source;
		prte2.Layouts.DEFLT_CPA;		
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
	//Clean Name	
		STRING5		Clean_title;
		STRING20	Clean_fname;
		STRING20	Clean_mname;
		STRING20	Clean_lname;
		STRING5		Clean_suffix;
		UNSIGNED8	rawaid				:=	0;
		Address.Layout_Clean182_fips;
		UNSIGNED8	indvowner_rawaid	:=	0;
		Address.Layout_Clean182_fips clean_indvowner;
		UNSIGNED8	busowner_rawaid		:=	0;
		Address.Layout_Clean182_fips clean_busowner;
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned8 source_record_id;
	end;	
		
export BIClassification	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		STRING2		record_type;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		STRING3		Classification_Code_Type;
		STRING25	Classification_Code;
		STRING1		Primary_Industry_Code_Indicator;
		STRING1		Privacy_Indicator;
	END;


export BusinessInformation	:=	RECORD	
		STRING		Version;
		STRING		Original_Version;
		STRING2		record_type;
		BIPV2.IDlayouts.l_xlink_ids;	//	Added for BIP project
		UNSIGNED6	did;
		UNSIGNED1	did_score;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
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
		STRING1		Primary_Address_Indicator;
		STRING3		Address_Classification;
		Address.Layout_Clean182_fips;
		UNSIGNED8	rawaid				:=	0;
		STRING3		Original_Area_Code;
		STRING7		Original_Phone_Number;
		STRING10	Phone_Extension;
		STRING1		Primary_Phone_Indicator;
		STRING3		Published_Unlisted_Indicator;
		STRING3		Phone_Type;
		STRING10	Phone_Number;
		STRING9		Federal_TaxID_SSN;
		STRING3		Federal_TaxID_SSN_Identifier;
		STRING2		source;
		prte2.Layouts.DEFLT_CPA;
	END;
	
	
export	BusinessOwner	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		STRING250	Business_Name;
		STRING250	Web_Address;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_To_Business_Indicator;
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership_If_Owner_Principal;
		UNSIGNED6 did;
		prte2.Layouts.DEFLT_CPA;
	END;

export Collateral	:=	RECORD
  string30 sbfe_contributor_number;
  string50 contract_account_number;
  string3 account_type_reported;
  string version;
  string original_version;
  string50 original_contract_account_number;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_datawarehouse_first_reported;
  unsigned4 dt_datawarehouse_last_reported;
  string1 collateral_indicator;
  string3 type_of_collateral_secured_for_this_account;
  string250 collateral_description;
  string50 ucc_filing_number;
  string3 ucc_filing_type;
  string8 ucc_filing_date;
  string8 ucc_filing_expiration_date;
  string100 ucc_filing_jurisdiction;
  string250 ucc_filing_description;
  unsigned8 __internal_fpos__;
 END;

export 	HistorySlim	:=	RECORD
		STRING		Version;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		STRING30	Previous_Sbfe_Contributor_Number;
		STRING50	Previous_Contract_Account_Number;
		STRING3		Previous_Account_Type;
		STRING8		change_date;
	END;
	
export IndividualOwner	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		STRING50	Original_fname;
		STRING50	Original_mname;
		STRING50	Original_lname;
		STRING5		Original_suffix;
		STRING100	E_Mail_Address;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_to_Business_Indicator;
		STRING150	Business_Title;
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership;
		UNSIGNED6 did;
		prte2.Layouts.DEFLT_CPA;
	END;
	
export 	IOInformation	:=	RECORD	
		STRING		Version;
		STRING		Original_Version;
		STRING2		record_type;
		BIPV2.IDlayouts.l_xlink_ids;	//	Added for BIP project
		UNSIGNED6	did;
		UNSIGNED1	did_score;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		STRING250	Account_Holder_Business_Name;
		STRING250	Clean_Account_Holder_Business_Name;
		STRING250	DBA;
		STRING250	Clean_DBA;
		STRING250	Business_Name;
		STRING250	Clean_Business_Name;
		STRING250	Company_Website;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_To_Business_Indicator;
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership;
		STRING50	Original_fname;
		STRING50	Original_mname;
		STRING50	Original_lname;
		STRING5		Original_suffix;
		STRING100	E_Mail_Address;
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
		STRING1		Primary_Address_Indicator;
		STRING3		Address_Classification;
		Address.Layout_Clean182_fips;
		UNSIGNED8	rawaid				:=	0;
		STRING3		Original_Area_Code;
		STRING7		Original_Phone_Number;
		STRING10	Phone_Extension;
		STRING1		Primary_Phone_Indicator;
		STRING3		Published_Unlisted_Indicator;
		STRING3		Phone_Type;
		STRING10	Phone_Number;
		STRING9		Federal_TaxID_SSN;
		STRING3		Federal_TaxID_SSN_Identifier;
		STRING2		source;
		prte2.Layouts.DEFLT_CPA;
	END;
	
	
export MasterAccount	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		STRING50	Master_Account_Or_Contract_Number_Identifier;
	END;

export 	MemberSpecific	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		STRING20	Name_Of_Value;
		STRING250	Value_String;
		STRING1		Privacy_Indicator;
	END;

export ReleaseDates := RECORD
  string9 version;
  string8 cert_date;
  string8 cert_time;
  string8 prod_date;
  string8 prod_time;
  string1 update_type;
  string8 first_date;
  string8 last_date;
  unsigned8 __internal_fpos__;
 END;

export Tradelines	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
		Business_Credit.Layouts.rAccountBase AND NOT [active];
		STRING3		DBT;
	END;

export LinkedBase	:=	RECORD	
		BIPV2.IDlayouts.l_key_ids ;	//	Added for BIP project
		STRING		Version;
		STRING		Original_Version;
		STRING2		Record_Type;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		UNSIGNED6	did;
		UNSIGNED1	did_score;
		prte2.Layouts.DEFLT_CPA;
   	STRING2		source;
	END;


export BOInformation	:=	RECORD	
		BIPV2.IDlayouts.l_key_ids;	//	Added for BIP project
		STRING		Version;
		STRING		Original_Version;
		STRING2		record_type;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		STRING250	Account_Holder_Business_Name;
		STRING250	Clean_Account_Holder_Business_Name;
		STRING250	DBA;
		STRING250	Clean_DBA;
		STRING250	Business_Name;
		STRING250	Clean_Business_Name;
		STRING250	Company_Website;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_To_Business_Indicator;
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership_If_Owner_Principal;
		STRING100	Original_Address_Line_1;
		STRING100	Original_Address_Line_2;
		STRING50	Original_City;
		STRING2		Original_State;
		STRING6		Original_Zip_Code_or_CA_Postal_Code;
		STRING4		Original_Postal_Code;
		STRING2		Original_Country_Code;
		STRING1		Primary_Address_Indicator;
		STRING3		Address_Classification;
		Address.Layout_Clean182_fips;
		UNSIGNED8	rawaid				:=	0;
		STRING3		Original_Area_Code;
		STRING7		Original_Phone_Number;
		STRING10	Phone_Extension;
		STRING1		Primary_Phone_Indicator;
		STRING3		Published_Unlisted_Indicator;
		STRING3		Phone_Type;
		STRING10	Phone_Number;
		STRING9		Federal_TaxID_SSN;
		STRING3		Federal_TaxID_SSN_Identifier;
		prte2.Layouts.DEFLT_CPA;
		unsigned6 did;
  	STRING2		source;
		integer1 fp;
	END;

export TradelineBase	:=	RECORD
		LinkedBase;																								//	AB & IS
		DATASET(BIPV2.IDlayouts.l_xlink_ids)	businessOwnerLinkIds;	//	BS
		integer1 fp;
	END;
	
	

//SFBEScoring
rscorereason := RECORD
    integer8 sequence;
    string5 reasoncode;
    string150 description;
   END;

rscoring := RECORD
   string25 score_name;
   integer8 min_score_range;
   integer8 max_score_range;
   integer8 score;
   string25 model_name;
   DATASET(rscorereason) scorereasons{maxcount(6)};
  END;

export ScoringIndex  := RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  string version;
  string8 date_scored;
  string25 classification_code;
  string250 classification_code_description;
  string3 industry_score_avg;
  integer8 min_dbt_range;
  integer8 max_dbt_range;
  string3 dbt;
  string3 industry_dbt_avg;
  DATASET(rscoring) scores;
	prte2.Layouts.DEFLT_CPA;
  string2 source;
  integer1 fp;
 END;


	
//BIPV2 Best Keys	
shared source := RECORD
    string2 source;
    unsigned8 source_record_id;
    string34 vl_id;
   END;

shared company_name_case_layout := RECORD
   string120 company_name;
   unsigned2 company_name_data_permits;
   unsigned1 company_name_method;
   unsigned4 dt_first_seen;
   unsigned4 dt_last_seen;
   DATASET(source) sources;
  END;

shared company_address_case_layout := RECORD
   string10 company_prim_range;
   string2 company_predir;
   string28 company_prim_name;
   string4 company_addr_suffix;
   string2 company_postdir;
   string10 company_unit_desig;
   string8 company_sec_range;
   string25 company_p_city_name;
   string25 address_v_city_name;
   string2 company_st;
   string5 company_zip5;
   string4 company_zip4;
   string18 county_name;
   unsigned2 company_address_data_permits;
   unsigned1 company_address_method;
  END;

shared company_phone := RECORD
   string10 company_phone;
   unsigned2 company_phone_data_permits;
   unsigned1 company_phone_method;
  END;

shared company_fein_case_layout := RECORD
   string9 company_fein;
   unsigned2 company_fein_data_permits;
   unsigned1 company_fein_method;
   DATASET(source) sources;
  END;

shared company_url := RECORD
   string80 company_url;
   unsigned2 company_url_data_permits;
   unsigned1 company_url_method;
  END;

shared company_incorporation_date_layout := RECORD
   unsigned4 company_incorporation_date;
   unsigned2 company_incorporation_date_permits;
   unsigned1 company_incorporation_date_method;
   DATASET(source) sources;
  END;

shared duns_number := RECORD
   string9 duns_number;
   unsigned2 duns_number_data_permits;
   unsigned1 duns_number_method;
  END;

shared sic_code_case_layout := RECORD
   string8 company_sic_code1;
   unsigned2 company_sic_code1_data_permits;
   unsigned1 company_sic_code1_method;
  END;

shared naics_code_case_layout := RECORD
   string6 company_naics_code1;
   unsigned2 company_naics_code1_data_permits;
   unsigned1 company_naics_code1_method;
  END;

shared dba_name := RECORD
   string120 dba_name;
   unsigned2 dba_name_data_permits;
   unsigned1 dba_name_method;
  END;

export BestKey := RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  boolean isactive;
  boolean isdefunct;
  unsigned6 company_bdid;
  DATASET(company_name_case_layout) company_name;
  DATASET(company_address_case_layout) company_address;
  DATASET(company_phone) company_phone;
  DATASET(company_fein_case_layout) company_fein;
  DATASET(company_url) company_url;
  DATASET(company_incorporation_date_layout) company_incorporation_date;
  DATASET(duns_number) duns_number;
  DATASET(sic_code_case_layout) sic_code;
  DATASET(naics_code_case_layout) naics_code;
	DATASET(dba_name) dba_name;
	prte2.Layouts.DEFLT_CPA;
  integer1 fp;
 END;
 
 END;