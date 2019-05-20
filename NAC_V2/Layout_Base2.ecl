import	Std,Address;

EXPORT Layout_Base2 := RECORD

	string2			ProgramState;
	string1			ProgramCode;
	string4			GroupId;
	string20		CaseID;
	string20		ClientId;
	Std.Date.Date_t			StartDate;
	Std.Date.Date_t			EndDate;
	string8			StartDate_Raw;		// as received from client
	string8			EndDate_Raw;
	string30		LastName;
	string25		FirstName;
	string25		MiddleName;
	string5			NameSuffix;
	string1			Gender;						// F=Female; M=Male; U=Unknown
	string1			Race;							// A=Asian; B=Black; H=Hispanic/Latino; I=North American Indian/Native American; N=Negro; O=Other; U=Unknown; W=White/Caucasian;
																// P = Pacific Islander/Native Hawaiian (SVES Codes with slight verbiage modification).
	string1			Ethnicity;				// H=Hispanic; N=Non Hispanic; U=Unknown
	string9			ssn;
	string1			ssn_Type_indicator;					// A=Actual; P=Pseudo; D=Default
	string8			dob;							// CCYYMMDD
	string1			dob_Type_indicator;					// A=Actual; P=Pseudo; D=Default
	string20		Certificate_id_type;
	string1			HoH_Indicator;			// head of household indicator Y or N
	string1			Relationship;			// H - Head of Household, P - Parent,  M - Mother, F - Father,
																// G - Guardian,  T - Grandparent,  A - Aunt, U - Uncle, C - Cousin, D - Child, O - Other (etc versus Y/N)
	string1			ABAWDIndicator := 'U';		// Yes, No, Unavailable
	string10		MonthlyAllotment := '0';	// whole dollar
	string1			eligibility_status_indicator;			// E=Elibible, I=Ineligible Alien, D=Disqualified, N=Not Eligible, A=Applicant
	string8			eligibility_status_date;		// CCYYMMDD
	string1			PeriodType;				// M=Month, D=Date
	string5			HistoricalBenefitCount;
	string10		client_Phone;
	string256		client_Email;
	// case data
	string30		case_Last_Name;
	string25		case_First_Name;
	string25		case_Middle_Name;
	string5			case_Name_Suffix;
	string3			RegionCode;
	string3			CountyCode;
	string25		CountyName;
	string10		case_Phone1;
	string10		case_Phone2;
	string256		case_Email;
	string10		case_Monthly_Allotment := '0';	// whole dollar
	// address data
	string1			Physical_AddressCategory;	
	string65		Physical_Street1;
	string65		Physical_Street2;
	string30		Physical_City;
	string2			Physical_State;
	string9			Physical_Zip;
	string1			Mailing_AddressCategory;	
	string65		Mailing_Street1;
	string65		Mailing_Street2;
	string30		Mailing_City;
	string2			Mailing_State;
	string9			Mailing_Zip;
	string50		ContactName;
	string10		ContactPhone;
	string10		ContactExt;
	string256		ContactEmail;
	
		String75  Prepped_name:=''
		,String60  Prepped_addr1:=''
		,String45  Prepped_addr2:=''
		,unsigned6 did:=0
		,unsigned  did_score:=0
		,unsigned4 ProcessDate:=0
		,unsigned4 NCF_FileDate:=0
		,string6 NCF_FileTime:=''
		,unsigned6 PrepRecSeq:=0
		,string9   clean_ssn:=''
		,string9   best_ssn:=''
		,integer4  clean_dob:=0
		,integer4  age:=0
		,integer4  best_dob:=0
		,address.Layout_Clean_Name.title
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
		,address.Layout_Clean182.err_stat
		,string32 FileName := ''
;


END;