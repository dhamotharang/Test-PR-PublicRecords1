IMPORT		Address, STD;


EXPORT Layout_Payload := RECORD
	unsigned6 PrepRecSeq := 0;
// case info
	string2			case_Program_State;
	string1			case_Program_Code;
	string4			nac_GroupId;
	string20		Case_Identifier;
	string10		case_Monthly_Allotment := '0';	// whole dollar
	string30		case_Last_Name;
	string25		case_First_Name;
	string25		case_Middle_Name;
	string5			case_Suffix_Name;
	string3			case_Region_Code;
	string3			case_county_parish_code;
	string25		case_county_parish_name;
	string10		case_Phone_1;
	string10		case_Phone_2;
	string256		case_Email;
// case addresses
	string1			case_Physical_Address_Category;	
	string65		case_Physical_Address_Street_1;
	string65		case_Physical_Address_Street_2;
	string30		case_Physical_Address_City;
	string2			case_Physical_Address_State;
	string9			case_Physical_Address_Zip;
	string1			case_Mailing_Address_Category;	
	string65		case_Mailing_Address_Street_1;
	string65		case_Mailing_Address_Street_2;
	string30		case_Mailing_Address_City;
	string2			case_Mailing_Address_State;
	string9			case_Mailing_Address_Zip;
// client data
	string20		Client_Identifier;
	string30		Client_Last_Name;
	string25		Client_First_Name;
	string25		Client_Middle_Name;
	string5			Client_Suffix_Name;
	string1			Client_HoH_Indicator;			// head of household indicator Y or N
	string1			Client_ABAWD_Indicator := 'U';		// Yes, No, Unavailable
	string1			Client_Relationship_Indicator;			// H - Head of Household, P - Parent,  M - Mother, F - Father,
																// G - Guardian,  T - Grandparent,  A - Aunt, U - Uncle, C - Cousin, D - Child, O - Other (etc versus Y/N)
	string1			Client_Gender;						// F=Female; M=Male; U=Unknown
	string1			Client_Race;							// A=Asian; B=Black; H=Hispanic/Latino; I=North American Indian/Native American; N=Negro; O=Other; U=Unknown; W=White/Caucasian;
																// P = Pacific Islander/Native Hawaiian (SVES Codes with slight verbiage modification).
	string1			Client_Ethnicity;				// H=Hispanic; N=Non Hispanic; U=Unknown
	string9			Client_ssn;
	string1			Client_ssn_Type_Indicator;					// A=Actual; P=Pseudo; D=Default
	string8			Client_dob;							// CCYYMMDD
	string1			Client_dob_Type_Indicator;					// A=Actual; P=Pseudo; D=Default
	string20		Client_Certificate_id_type;
	string10		Client_Monthly_Allotment := '0';	// whole dollar
	
	string1			Client_Period_Type;				// M=Month, D=Date
	string5			Client_Historical_Benefit_Count;
	string10		client_Phone;
	string256		client_Email;
	
	string1			eligibility_status_indicator;
	string8			eligibility_status_date;
	string8			eligibility_period_start_raw;
	string8			eligibility_period_end_raw;
	Std.Date.Date_t		eligibility_period_start;
	Std.Date.Date_t		eligibility_period_end;
	integer4		eligible_period_count_days;
	integer4		eligible_period_count_months;
		
	// aggregate fields
	integer4					RecordCount := 0;
	string8						earliestStart := '';
	string8						latestEnd := '';
	integer4					TotalMonths := 0;
	integer4					TotalDays := 0;

// contact information
	string50		state_Contact_Name;
	string10		state_Contact_Phone;
	string10		state_Contact_Phone_Extension;
	string256		state_Contact_Email;
// derived fields	
		unsigned6 did:=0
		,unsigned8  did_score:=0
		,string9   clean_ssn:=''
		,string9   best_ssn:=''
		,integer4  clean_dob:=0
		,integer4  age:=0
		,integer4  best_dob:=0;

		address.Layout_Clean_Name.title
		,typeof(address.Layout_Clean_Name.fname) prefname:=''
		,address.Layout_Clean_Name.fname
		,address.Layout_Clean_Name.mname
		,address.Layout_Clean_Name.lname
		,address.Layout_Clean_Name.name_suffix

		,address.Layout_Clean182.prim_range
		,address.Layout_Clean182.predir
		,address.Layout_Clean182.prim_name
		,address.Layout_Clean182.addr_suffix
		,address.Layout_Clean182.postdir
		,address.Layout_Clean182.unit_desig
		,address.Layout_Clean182.sec_range
		,address.Layout_Clean182.p_city_name
		,address.Layout_Clean182.v_city_name
		,address.Layout_Clean182.st
		,address.Layout_Clean182.zip
		,address.Layout_Clean182.zip4
		,address.Layout_Clean182.cart
		,address.Layout_Clean182.cr_sort_sz
		,address.Layout_Clean182.lot
		,address.Layout_Clean182.lot_order
		,address.Layout_Clean182.dbpc
		,address.Layout_Clean182.chk_digit
		,address.Layout_Clean182.rec_type
		,string2		fips_state:=''
		,string3		fips_county:=''
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat;
		
		unsigned1 zero := 0;
		string1 blank := '';		
END;