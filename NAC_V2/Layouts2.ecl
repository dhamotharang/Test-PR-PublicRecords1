IMPORT	address, Std;

EXPORT Layouts2 := MODULE

// Address Record – AD01
export rAddress := RECORD
	string4			RecordCode;
	string2			ProgramState;
	string1			ProgramCode;
	string20		CaseID;
	string20		ClientId;
	string1			AddressType;			// P=Physical, M=Mailing, B=Both
	string1			AddressCategory;	// O=Other(Rehab, shelter, etc.), T=Temporary, H=homeless
	string65		Street1;
	string65		Street2;
	string30		City;
	string2			State;
	string9			ZipCode;
END;

// State Contact Record – SC01
export rStateContact := RECORD
	string4			RecordCode;
	string2			ProgramState;
	string1			ProgramCode;
	string3			ProgramRegion;
	string3			ProgramCounty;
	string20		CaseID;
	string20		ClientId;
	string1			UpdateType;			// U = Add/Update, D = Delete, O = Override
	string50		ContactName;
	string10		ContactPhone;
	string10		ContactExt;
	string256		ContactEmail;
END;

// Case Record – CA01
export rCase := RECORD
	string4			RecordCode;
	string2			ProgramState;
	string1			ProgramCode;
	string20		CaseID;
	string10		MonthlyAllotment;	// whole dollar
	string3			RegionCode;
	string3			CountyCode;
	string25		CountyName;
	string10		Phone1;
	string10		Phone2;
	string256		Email;
END;

// Client/Individual Record – CL01
export rClient := RECORD
	string4			RecordCode;
	string2			ProgramState;
	string1			ProgramCode;
	string20		CaseID;
	string20		ClientId;
	string1			HHIndicator;			// head of household indicator Y or N
	string1			Relationship;			// H - Head of Household, P - Parent,  M - Mother, F - Father,
																// G - Guardian,  T - Grandparent,  A - Aunt, U - Uncle, C - Cousin, D - Child, O - Other (etc versus Y/N)
	string1			ABAWDIndicator := 'U';		// Yes, No, Unavailable
	string30		LastName;
	string25		FirstName;
	string25		MiddleName;
	string5			NameSuffix;
	string1			Gender;						// F=Female; M=Male; U=Unknown
	string1			Race;							// A=Asian; B=Black; H=Hispanic/Latino; I=North American Indian/Native American; N=Negro; O=Other; U=Unknown; W=White/Caucasian;
																// P = Pacific Islander/Native Hawaiian (SVES Codes with slight verbiage modification).
	string1			Ethnicity;				// H=Hispanic; N=Non Hispanic; U=Unknown
	string9			ssn;
	string1			ssnType;					// A=Actual; P=Pseudo; D=Default
	string8			dob;							// CCYYMMDD
	string1			dobType;					// A=Actual; P=Pseudo; D=Default
	string20		Certificate;
	string10		MonthlyAllotment := '0';	// whole dollar
	string1			Eligibility;			// E=Elibible, I=Ineligible Alien, D=Disqualified, N=Not Eligible, A=Applicant
	string8			EffectiveDate;		// CCYYMMDD
	string8			PeriodType;				// M=Month, D=Date
	string5			HistoricalBenefitCount;
	string8			StartDate;
	string8			EndDate;
	string10		Phone;
	string256		Email;
END;

// Exception Record – EX01
export rException := RECORD
	string4			RecordCode;
	string1			UpdateType;			// U = Add/Update, D = Delete
	string2			SourceProgramState;
	string1			SourceProgramCode;
	string20		SourceClientId;
	string2			MatchedState;
	string1			MatchedProgramCode;
	string20		MatchedClientId;
	string3			ReasonCode;			// A=Confirmed Multiple birth sibling, B=LexID Overlinking
	string50		Comments;
END;

EXPORT rNac2 := RECORD
	string4			RecordCode;
	IFBLOCK(self.RecordCode = 'CA01')
	  rCase - RecordCode			CaseRec;
	END;
	IFBLOCK(self.RecordCode = 'CL01')
	  rClient - RecordCode		ClientRec;
	END;
	IFBLOCK(self.RecordCode = 'AD01')
	  rAddress - RecordCode		AddressRec;
	END;
	IFBLOCK(self.RecordCode = 'SC01')
	  rStateContact - RecordCode	StateContactRec;
	END;
	IFBLOCK(self.RecordCode = 'EX01')
	  rException - RecordCode		ExceptionRec;
	END;
	IFBLOCK(self.RecordCode NOT IN ['CA01','CL01','AD01','SC01','EX01'])
		string		BadRecord {maxlength(256)};
	END;
	string	eol := '\n';
END;

// extended records
	export rAddressEx := RECORD
		rAddress - RecordCode;
		STD.Date.Date_t		created := 0;
		STD.Date.Date_t		updated := 0;
		STD.Date.Date_t		replaced := 0;
		unsigned8					errors := 0;
		unsigned4					warnings := 0;

		String60  Prepped_addr1:='';
		String45  Prepped_addr2:=''

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
		;
	END;

	export rClientEx := RECORD
		rClient - RecordCode;
		STD.Date.Date_t		created := 0;
		STD.Date.Date_t		updated := 0;
		STD.Date.Date_t		replaced := 0;
		unsigned8					errors := 0;
		unsigned4					warnings := 0;

		String75  Prepped_name:=''
			,address.Layout_Clean_Name.title
			,typeof(address.Layout_Clean_Name.fname) prefname:=''
			,address.Layout_Clean_Name.fname
			,address.Layout_Clean_Name.mname
			,address.Layout_Clean_Name.lname
			,address.Layout_Clean_Name.name_suffix
		,unsigned6 did:=0
		,unsigned  did_score:=0
		,string9   clean_ssn:=''
		,string9   best_ssn:=''
		,integer4  clean_dob:=0
		,integer4  age:=0
		,integer4  best_dob:=0
		;
	END;
	
	export rCaseEx := RECORD
		rCase - RecordCode;
		STD.Date.Date_t		created := 0;
		STD.Date.Date_t		updated := 0;
		STD.Date.Date_t		replaced := 0;
		unsigned8					errors := 0;
		unsigned4					warnings := 0;
	END;

	export rStateContactEx := RECORD
		rStateContact - RecordCode;
		STD.Date.Date_t		created := 0;
		STD.Date.Date_t		updated := 0;
		STD.Date.Date_t		replaced := 0;
		unsigned8					errors := 0;
		unsigned4					warnings := 0;
	END;
	
	export rExceptionEx := RECORD
		rException - [RecordCode];
		STD.Date.Date_t		created := 0;
		STD.Date.Date_t		updated := 0;
		STD.Date.Date_t		replaced := 0;
		unsigned8					errors := 0;
		unsigned4					warnings := 0;
	END;

END;