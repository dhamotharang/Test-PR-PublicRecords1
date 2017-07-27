IMPORT Inquiry_AccLogs;

EXPORT layouts := module

export slim_ssn := RECORD
	
	string9 ssn;
	string10 prim_range;
	string28 prim_name;
	string5 zip;
	string2 src;  
	unsigned6 Did;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_vendor_last_reported;


END;
export temp_ssn := record
string9 ssn;
string10 prim_range;
	string28 prim_name;
	string5 zip;
	string2 src;  
	unsigned6 Did;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_vendor_last_reported;
	string8 log_date;
	boolean good_fraudsearch_inquiry;
	unsigned3 dt_first_deceased;
	unsigned3 dt_first_seen_DIDcnt;
	unsigned3 dt_first_seen_DIDcnt_c6;
	unsigned3 dt_first_seen_multiple_use;
	unsigned3 dt_first_seen_non_relative_multiple_use;
	unsigned3 dt_first_seen_not_in_bearue;
	unsigned3 dt_first_seen_official;
	//unsigned3 dt_first_seen_SRCcnt;
  unsigned3 dt_first_seen_minors;
  unsigned3 dt_first_seen_recentADDRcnt;
  unsigned3 dt_first_seen_SearchCountYear;
  unsigned3 dt_first_seen_SearchCountMonth;
	unsigned3 dt_last_deceased;
	unsigned3 dt_last_seen_DIDcnt;
	unsigned3 dt_last_seen_DIDcnt_c6;
	unsigned3 dt_last_seen_multiple_use;
	unsigned3 dt_last_seen_non_relative_multiple_use;
	unsigned3 dt_last_seen_not_in_bearue;
	unsigned3 dt_last_seen_official;
	//unsigned3 dt_last_seen_SRCcnt;
  unsigned3 dt_last_seen_minors;
  unsigned3 dt_last_seen_recentADDRcnt;
  unsigned3 dt_last_seen_SearchCountYear;
  unsigned3 dt_last_seen_SearchCountMonth;
	
	end;

export slim_address := RECORD
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 city_name;
	string2 st;
	string5 zip;
	unsigned6 Did;
	unsigned6 BDID;
  unsigned8 address_id;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_vendor_last_reported;
	string8 log_date;
	boolean good_fraudsearch_inquiry;
	string1		Address_Vacancy_Indicator		;
  string1		Seasonal_Delivery_Indicator		;
   string1		Address_Type					;
	 string  comments;
  unsigned3 dt_first_seen_transient;
  unsigned3 dt_first_seen_uspishotlist;
  unsigned3 dt_first_seen_searchcountyear;
  unsigned3 dt_first_seen_searchcountmonth;
  unsigned3 dt_first_seen_vacant;
  unsigned3 dt_first_seen_didcnt;
  unsigned3 dt_first_seen_educational_institution;
  unsigned3 dt_first_seen_not_personal_property;
  unsigned3 dt_first_seen_bdidcnt;
  unsigned3 dt_first_seen_prison;
  unsigned3 dt_first_seen_cmra;
  unsigned3 dt_first_seen_pobox_vacant;
  unsigned3 dt_last_seen_transient;
  unsigned3 dt_last_seen_uspishotlist;
  unsigned3 dt_last_seen_searchcountyear;
  unsigned3 dt_last_seen_searchcountmonth;
  unsigned3 dt_last_seen_vacant;
  unsigned3 dt_last_seen_didcnt;
  unsigned3 dt_last_seen_educational_institution;
  unsigned3 dt_last_seen_not_personal_property;
  unsigned3 dt_last_seen_bdidcnt;
  unsigned3 dt_last_seen_prison;
  unsigned3 dt_last_seen_cmra;
  unsigned3 dt_last_seen_pobox_vacant;
	
  string2 src;  

END;

export slim_name := RECORD
	
	string20 fname;
	string1  mname;
	string20 lname;
  string8 log_date;
	boolean good_fraudsearch_inquiry;
  unsigned3 dt_first_seen_searchcountyear;
  unsigned3 dt_first_seen_searchcountmonth;
	unsigned3 dt_last_seen_searchcountyear;
  unsigned3 dt_last_seen_searchcountmonth;



END;


export slim_email := record

	string50 email;
  string8 log_date;
	boolean good_fraudsearch_inquiry;
	unsigned3 dt_first_seen_DIDcnt;
  unsigned3 dt_first_seen_searchcountyear;
  unsigned3 dt_first_seen_searchcountmonth;
	unsigned3 dt_last_seen_DIDcnt;
	unsigned3 dt_last_seen_searchcountyear;
  unsigned3 dt_last_seen_searchcountmonth;

END;

export slim_IPaddress := record

	string45 ipaddr;//was 50, all others updated to 45 approx. OCT/2016
  string8 log_date;
	boolean good_fraudsearch_inquiry;
  unsigned3 dt_first_seen_searchcountyear;
  unsigned3 dt_first_seen_searchcountmonth;
	unsigned3 dt_last_seen_searchcountyear;
  unsigned3 dt_last_seen_searchcountmonth;

END;

export slim_phone := record
  string10 phone10;
	unsigned6 Did;
	Boolean iscurrent;
	string2 hriskphoneflag;
  string2 hphonetypeflag;	
	string  lname;
	string2 append_phone_type;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_vendor_last_reported;
	string8 log_date;
	boolean good_fraudsearch_inquiry;
	unsigned3 dt_first_seen_pager;
  unsigned3 dt_first_seen_transient_commercial;
  unsigned3 dt_first_seen_SearchCountYear;
  unsigned3 dt_first_seen_SearchCountMonth;
	unsigned3 dt_first_seen_disconnect;
	unsigned3 dt_first_seen_payphone;
	unsigned3 dt_first_seen_DIDcnt;
  unsigned3 dt_last_seen_pager;
  unsigned3 dt_last_seen_transient_commercial;
  unsigned3 dt_last_seen_SearchCountYear;
  unsigned3 dt_last_seen_SearchCountMonth;
	unsigned3 dt_last_seen_disconnect;
	unsigned3 dt_last_seen_payphone;
	unsigned3 dt_last_seen_DIDcnt;	
	end;


export extract_SSN:= record

string9 SSN;
string100 suspicious_risk_code;
unsigned3 dt_first_seen;
unsigned3 dt_last_seen;


end;

export layout_uspis_comments := record, maxlength(10000)

string comments := '';

end;

export extract_address_final := record
string10 prim_range;
	string28 prim_name;
	string4 suffix;
	string8 sec_range;
	string5 zip;
	string2 predir;
	string2 postdir;
	string10 unit_desig;
	string80  street_address;
	string25 city_name;
	string2 st;
unsigned8 address_id;
string100 suspicious_risk_code;
unsigned3 dt_first_seen;
unsigned3 dt_last_seen;
dataset(layout_uspis_comments) uspis_comments;

end;
export extract_address := record
string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string80  street_address;
	string25 city_name;
	string2 st;
	string5 zip;
	//unsigned8 address_id;
string100 suspicious_risk_code;
unsigned3 dt_first_seen;
unsigned3 dt_last_seen;
dataset(layout_uspis_comments) uspis_comments;

end;

export extract_name := record

string20 fname;
string1  mname;
string20 lname;
string100 suspicious_risk_code;
unsigned3 dt_first_seen;
unsigned3 dt_last_seen;


end;

export extract_email := record

string50 email;
string10 suspicious_risk_code;
unsigned3 dt_first_seen;
unsigned3 dt_last_seen;


end;

export extract_IPaddress := record

string45 ipaddr;//was 50, all others updated to 45 approx. OCT/2016
string10 suspicious_risk_code;
unsigned3 dt_first_seen;
unsigned3 dt_last_seen;


end;


export extract_phone := record

string10 phone;
string100 suspicious_risk_code;
unsigned3 dt_first_seen;
unsigned3 dt_last_seen;


end;


EXPORT Layout_Batch_In := RECORD
	STRING30 ReferenceCode								:= '';
	STRING30 UniqueRecordValue						:= '';
	STRING30 QueryID											:= '';
	UNSIGNED8 LexID												:= 0;
	STRING30 AcctNo												:= '';
	STRING20 FirstName										:= '';
	STRING20 MiddleName										:= '';
	STRING20 LastName											:= '';
	STRING120 StreetAddress1							:= '';
	STRING120 StreetAddress2							:= '';
	STRING25 City													:= '';
	STRING2 State													:= '';
	STRING5 Zip5													:= '';
	STRING8 DateOfBirth										:= '';
	STRING9 SSN														:= '';
	STRING10 Phone10											:= '';
	STRING45 IPAddress										:= '';
	STRING100 Email												:= '';
	STRING15 DriverLicenseNumber					:= '';
	STRING2 DriverLicenseState						:= '';
	STRING100 DeviceID										:= '';
	UNSIGNED4 ArchiveDate									:= 0;
END;

EXPORT Layout_Cleaned_Batch_In := RECORD
	UNSIGNED8 DID													:= 0;
	STRING30 AccountNumber								:= '';
	STRING20 FirstName										:= '';
	STRING20 MiddleName										:= '';
	STRING1 MiddleInitial									:= '';
	STRING20 LastName											:= '';
	STRING120 StreetAddress1							:= '';
	STRING120	StreetAddress2							:= '';
	STRING25 City													:= '';
	STRING2 State													:= '';
	STRING9 Zip														:= '';
	STRING5 Zip5													:= '';
	STRING4 Zip4													:= '';
	STRING10 Prim_Range										:= '';
	STRING2 Predir												:= '';
	STRING28 Prim_Name										:= '';
	STRING4 Addr_Suffix										:= '';
	STRING2 Postdir												:= '';
	STRING10 Unit_Desig										:= '';
	STRING8 Sec_Range											:= '';
	STRING10 Lat													:= '';
	STRING11 Long													:= '';
	STRING3 County												:= '';
	STRING7 Geo_Block											:= '';
	STRING1 Addr_Type											:= '';
	STRING4 Addr_Status										:= '';
	STRING8 DateOfBirth										:= '';
	STRING9 SSN														:= '';
	STRING10 Phone10											:= '';
	STRING45 IPAddress										:= '';
	STRING100 Email												:= '';
	STRING15 DriverLicenseNumber					:= '';
	STRING2 DriverLicenseState						:= '';
	STRING100 DeviceID										:= '';
	UNSIGNED4 ArchiveDate									:= 0;
END;


EXPORT Layout_Suspicious_SSN_Batch := RECORD
	STRING1 SSN_Hit												:= '';
	STRING80 SSN_Message									:= '';
	STRING12 Data_Source									:= ''; // Internal, Customer, or Third Party
	STRING105 SuspiciousRiskCodes					:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 21 total codes
	STRING8 DateFirstSeenInFile						:= '';
	UNSIGNED3 InquiryCount								:= 0;
	UNSIGNED2 InquiryCountHour						:= 0;
	UNSIGNED2 InquiryCountDay							:= 0;
	UNSIGNED2 InquiryCountWeek						:= 0;
	UNSIGNED2 InquiryCountMonth						:= 0;
	UNSIGNED2 InquiryCountYear						:= 0;
END;

EXPORT Layout_Suspicious_Address_Batch := RECORD
	STRING1 Address_Hit										:= '';
	STRING80 Address_Message							:= '';
	STRING12 Data_Source									:= ''; // Internal, Customer, or Third Party
	STRING165 SuspiciousRiskCodes					:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 33 total codes
	STRING45 USPISHotListDateAdded 				:= ''; // Delimited list of USPIS Dates, 8 bytes for the date, 1 byte for delimiter = 5 total dates
	STRING380 USPISHotListReason					:= ''; // Delimited list of USPIS Reasons, 75 bytes for the reason, 1 byte for the delimiter = 5 total reasons
	STRING8 DateFirstSeenInFile						:= '';
	UNSIGNED3 InquiryCount								:= 0;
	UNSIGNED2 InquiryCountHour						:= 0;
	UNSIGNED2 InquiryCountDay							:= 0;
	UNSIGNED2 InquiryCountWeek						:= 0;
	UNSIGNED2 InquiryCountMonth						:= 0;
	UNSIGNED2 InquiryCountYear						:= 0;
END;

EXPORT Layout_Suspicious_Email_Batch := RECORD
	STRING1 Email_Hit											:= '';
	STRING80 Email_Message								:= '';
	STRING12 Data_Source									:= ''; // Internal, Customer, or Third Party
	STRING30 SuspiciousRiskCodes					:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 6 total codes
	STRING8 DateFirstSeenInFile						:= '';
	UNSIGNED3 InquiryCount								:= 0;
	UNSIGNED2 InquiryCountHour						:= 0;
	UNSIGNED2 InquiryCountDay							:= 0;
	UNSIGNED2 InquiryCountWeek						:= 0;
	UNSIGNED2 InquiryCountMonth						:= 0;
	UNSIGNED2 InquiryCountYear						:= 0;
END;

EXPORT Layout_Suspicious_IPAddress_Batch := RECORD
	STRING1 IPAddress_Hit									:= '';
	STRING80 IPAddress_Message						:= '';
	STRING12 Data_Source									:= ''; // Internal, Customer, or Third Party
	STRING30 SuspiciousRiskCodes					:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 6 total codes
	STRING8 DateFirstSeenInFile						:= '';
	UNSIGNED3 InquiryCount								:= 0;
	UNSIGNED2 InquiryCountHour						:= 0;
	UNSIGNED2 InquiryCountDay							:= 0;
	UNSIGNED2 InquiryCountWeek						:= 0;
	UNSIGNED2 InquiryCountMonth						:= 0;
	UNSIGNED2 InquiryCountYear						:= 0;
	UNSIGNED2	Royalty_NAG									:= 0; // internal, for royalty tracking	
END;

EXPORT Layout_Suspicious_Name_Batch := RECORD
	STRING1 Name_Hit											:= '';
	STRING80 Name_Message									:= '';
	STRING12 Data_Source									:= ''; // Internal, Customer, or Third Party
	STRING25 SuspiciousRiskCodes					:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 5 total codes
	STRING8 DateFirstSeenInFile						:= '';
	UNSIGNED3 InquiryCount								:= 0;
	UNSIGNED2 InquiryCountHour						:= 0;
	UNSIGNED2 InquiryCountDay							:= 0;
	UNSIGNED2 InquiryCountWeek						:= 0;
	UNSIGNED2 InquiryCountMonth						:= 0;
	UNSIGNED2 InquiryCountYear						:= 0;
END;

EXPORT Layout_Suspicious_Phone_Batch := RECORD
	STRING1 Phone_Hit											:= '';
	STRING80 Phone_Message								:= '';
	STRING12 Data_Source									:= ''; // Internal, Customer, or Third Party
	STRING70 SuspiciousRiskCodes					:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 14 total codes
	STRING8 DateFirstSeenInFile						:= '';
	UNSIGNED3 InquiryCount								:= 0;
	UNSIGNED2 InquiryCountHour						:= 0;
	UNSIGNED2 InquiryCountDay							:= 0;
	UNSIGNED2 InquiryCountWeek						:= 0;
	UNSIGNED2 InquiryCountMonth						:= 0;
	UNSIGNED2 InquiryCountYear						:= 0;
END;

EXPORT Layout_Suspicious_Combination_Batch := RECORD
	STRING1 Combination_Search_Hit				:= '';
	STRING80 Combination_Search_Message		:= '';
	STRING12 Data_Source									:= ''; // Internal, Customer, or Third Party
	STRING1450 SuspiciousRiskCodes				:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 290 total codes
	STRING8 DateFirstSeenInFile						:= '';
	UNSIGNED3 InquiryCount								:= 0;
	UNSIGNED2 InquiryCountHour						:= 0;
	UNSIGNED2 InquiryCountDay							:= 0;
	UNSIGNED2 InquiryCountWeek						:= 0;
	UNSIGNED2 InquiryCountMonth						:= 0;
	UNSIGNED2 InquiryCountYear						:= 0;
END;

EXPORT Layout_Batch_Out := RECORD
	Layout_Batch_In												Input_Echo;
	Layout_Suspicious_SSN_Batch						Suspicious_SSN;
	Layout_Suspicious_Address_Batch				Suspicious_Address;
	Layout_Suspicious_Email_Batch					Suspicious_Email;
	Layout_Suspicious_IPAddress_Batch			Suspicious_IPAddress;
	Layout_Suspicious_Name_Batch					Suspicious_Name;
	Layout_Suspicious_Phone_Batch					Suspicious_Phone;
	Layout_Suspicious_Combination_Batch		Suspicious_Combination;
END;

EXPORT Layout_Batch_Flat_Out := RECORD
	Layout_Batch_In;
	STRING1 SSN_Hit												:= '';
	STRING80 SSN_Message									:= '';
	STRING12 SSN_Data_Source							:= ''; // Internal, Customer, or Third Party
	STRING105 SSN_SuspiciousRiskCodes			:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 21 total codes
	STRING8 SSN_DateFirstSeenInFile				:= '';
	UNSIGNED3 SSN_InquiryCount						:= 0;
	UNSIGNED2 SSN_InquiryCountHour				:= 0;
	UNSIGNED2 SSN_InquiryCountDay					:= 0;
	UNSIGNED2 SSN_InquiryCountWeek				:= 0;
	UNSIGNED2 SSN_InquiryCountMonth				:= 0;
	UNSIGNED2 SSN_InquiryCountYear				:= 0;
	STRING1 Address_Hit										:= '';
	STRING80 Address_Message							:= '';
	STRING12 Address_Data_Source					:= ''; // Internal, Customer, or Third Party
	STRING165 Address_SuspiciousRiskCodes	:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 33 total codes
	STRING45 Address_USPISHotListDateAdded:= ''; // Delimited list of USPIS Dates, 8 bytes for the date, 1 byte for delimiter = 5 total dates
	STRING380 Address_USPISHotListReason	:= ''; // Delimited list of USPIS Reasons, 75 bytes for the reason, 1 byte for the delimiter = 5 total reasons
	STRING8 Address_DateFirstSeenInFile		:= '';
	UNSIGNED3 Address_InquiryCount				:= 0;
	UNSIGNED2 Address_InquiryCountHour		:= 0;
	UNSIGNED2 Address_InquiryCountDay			:= 0;
	UNSIGNED2 Address_InquiryCountWeek		:= 0;
	UNSIGNED2 Address_InquiryCountMonth		:= 0;
	UNSIGNED2 Address_InquiryCountYear		:= 0;
	STRING1 Email_Hit											:= '';
	STRING80 Email_Message								:= '';
	STRING12 Email_Data_Source						:= ''; // Internal, Customer, or Third Party
	STRING30 Email_SuspiciousRiskCodes		:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 6 total codes
	STRING8 Email_DateFirstSeenInFile			:= '';
	UNSIGNED3 Email_InquiryCount					:= 0;
	UNSIGNED2 Email_InquiryCountHour			:= 0;
	UNSIGNED2 Email_InquiryCountDay				:= 0;
	UNSIGNED2 Email_InquiryCountWeek			:= 0;
	UNSIGNED2 Email_InquiryCountMonth			:= 0;
	UNSIGNED2 Email_InquiryCountYear			:= 0;
	STRING1 IPAddress_Hit									:= '';
	STRING80 IPAddress_Message						:= '';
	STRING12 IPAddress_Data_Source				:= ''; // Internal, Customer, or Third Party
	STRING30 IPAddress_SuspiciousRiskCodes:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 6 total codes
	STRING8 IPAddress_DateFirstSeenInFile	:= '';
	UNSIGNED3 IPAddress_InquiryCount			:= 0;
	UNSIGNED2 IPAddress_InquiryCountHour	:= 0;
	UNSIGNED2 IPAddress_InquiryCountDay		:= 0;
	UNSIGNED2 IPAddress_InquiryCountWeek	:= 0;
	UNSIGNED2 IPAddress_InquiryCountMonth	:= 0;
	UNSIGNED2 IPAddress_InquiryCountYear	:= 0;
	STRING1 Name_Hit											:= '';
	STRING80 Name_Message									:= '';
	STRING12 Name_Data_Source							:= ''; // Internal, Customer, or Third Party
	STRING25 Name_SuspiciousRiskCodes			:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 5 total codes
	STRING8 Name_DateFirstSeenInFile			:= '';
	UNSIGNED3 Name_InquiryCount						:= 0;
	UNSIGNED2 Name_InquiryCountHour				:= 0;
	UNSIGNED2 Name_InquiryCountDay				:= 0;
	UNSIGNED2 Name_InquiryCountWeek				:= 0;
	UNSIGNED2 Name_InquiryCountMonth			:= 0;
	UNSIGNED2 Name_InquiryCountYear				:= 0;
	STRING1 Phone_Hit											:= '';
	STRING80 Phone_Message								:= '';
	STRING12 Phone_Data_Source						:= ''; // Internal, Customer, or Third Party
	STRING70 Phone_SuspiciousRiskCodes		:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 14 total codes
	STRING8 Phone_DateFirstSeenInFile			:= '';
	UNSIGNED3 Phone_InquiryCount					:= 0;
	UNSIGNED2 Phone_InquiryCountHour			:= 0;
	UNSIGNED2 Phone_InquiryCountDay				:= 0;
	UNSIGNED2 Phone_InquiryCountWeek			:= 0;
	UNSIGNED2 Phone_InquiryCountMonth			:= 0;
	UNSIGNED2 Phone_InquiryCountYear			:= 0;
	STRING1 Combination_Search_Hit				:= '';
	STRING80 Combination_Search_Message		:= '';
	STRING12 Combination_Search_Data_Source						:= ''; // Internal, Customer, or Third Party
	STRING1450 Combination_Search_SuspiciousRiskCodes	:= ''; // Delimited list of Suspicious Risk Codes, 4 bytes for code, 1 byte for delimiter = 290 total codes
	STRING8 Combination_Search_DateFirstSeenInFile		:= '';
	UNSIGNED3 Combination_Search_InquiryCount					:= 0;
	UNSIGNED2 Combination_Search_InquiryCountHour			:= 0;
	UNSIGNED2 Combination_Search_InquiryCountDay			:= 0;
	UNSIGNED2 Combination_Search_InquiryCountWeek			:= 0;
	UNSIGNED2 Combination_Search_InquiryCountMonth		:= 0;
	UNSIGNED2 Combination_Search_InquiryCountYear			:= 0;
END;

EXPORT Risk_Indicators := RECORD
	STRING4 SuspiciousRiskCode						:= ''; // 4-Byte Risk Code
	STRING175 SuspiciousRiskIndicator			:= ''; // Risk Code Description
END;

EXPORT USPISHotListRecs := RECORD
	STRING8 DateAdded											:= '';
	STRING75 ReasonAdded									:= '';
END;

EXPORT Layout_Batch_Plus := RECORD
	UNSIGNED8 Seq													:= 0; // Unique Input
	Layout_Cleaned_Batch_In								Clean_Input;
	DATASET(Risk_Indicators)							RiskCode_SSN;
	DATASET(Risk_Indicators)							RiskCode_Address;
	DATASET(USPISHotListRecs)							USPISHotListRecords;
	DATASET(Risk_Indicators)							RiskCode_Email;
	DATASET(Risk_Indicators)							RiskCode_IPAddress;
	DATASET(Risk_Indicators)							RiskCode_Name;
	DATASET(Risk_Indicators)							RiskCode_Phone;
	DATASET(Risk_Indicators)							RiskCode_Combination;
	Layout_Batch_Out;
END;

EXPORT Layout_Inquiries_Common := RECORD
	UNSIGNED8 Seq := 0; // Used to join back to Input
	BOOLEAN Inquiry_Hit := FALSE; // Indicates that the inquiry passes the Industry/Function Description/Age rules
	BOOLEAN Name_Match := FALSE; // Indicates that the name on the Inquiry passes the Name Match rules for our input - This only applies to Search_Inquiries_Name
	BOOLEAN SuspiciousFraudFunction := FALSE; // Indicates the Inquiry came from a Suspicious Fraud Function
	STRING75 Transaction_ID := '';
	STRING75 Sequence_Number := '';
	STRING8 LogDate := '';
	STRING10 LogTime := '';
	STRING75 Industry := '';
	STRING75 Vertical := '';
	STRING75 Sub_Market := '';
	STRING75 Func := '';
	STRING3 Product_Code := '';
	UNSIGNED1 AgeInYears := 0; // Age of the inquiry in years (Can hold ~255 years)
	UNSIGNED2 AgeInMonths := 0; // Age of the inquiry in months (Can hold ~5,400 years)
	UNSIGNED2 AgeInWeeks := 0; // Age of the inquiry in weeks (Can hold ~1,200 years)
	UNSIGNED3 AgeInDays := 0; // Age of the inquiry in days (Can hold ~45,000 years)
	UNSIGNED3 AgeInHours := 0; // Age of the inquiry in hours (Can hold ~1,900 years)
	UNSIGNED4 AgeInMinutes := 0; // Age of the inquiry in minutes (Can hold ~2,000 years)
	UNSIGNED6 AgeInSeconds := 0; // Age of the inquiry in seconds (Can hold ~6,000 years)
END;

EXPORT Layout_Address_Inquiries := RECORD
	Layout_Inquiries_Common;
	RECORDOF(Inquiry_AccLogs.Key_Inquiry_Address);
END;

EXPORT Layout_Email_Inquiries := RECORD
	Layout_Inquiries_Common;
	RECORDOF(Inquiry_AccLogs.Key_Inquiry_Email);
END;

EXPORT Layout_IPAddress_Inquiries := RECORD
	Layout_Inquiries_Common;
	RECORDOF(Inquiry_AccLogs.Key_Inquiry_IPAddr);
END;

EXPORT Layout_Name_Inquiries := RECORD
	Layout_Inquiries_Common;
	RECORDOF(Inquiry_AccLogs.Key_Inquiry_Name);
END;

EXPORT Layout_Phone_Inquiries := RECORD
	Layout_Inquiries_Common;
	RECORDOF(Inquiry_AccLogs.Key_Inquiry_Phone);
END;

EXPORT Layout_SSN_Inquiries := RECORD
	Layout_Inquiries_Common;
	RECORDOF(Inquiry_AccLogs.Key_Inquiry_SSN);
END;

end;