import Standard;

EXPORT Layouts := MODULE

	export Layout_Address := RECORD
		STRING10		prim_range;
		STRING36    addr;
		STRING18    unit;
		STRING25    city;
		STRING2     state;
		STRING5     zip;
		STRING4     zip4;
		// Brad0813
		//UNSIGNED3		dt_first_seen	:= 0;
		//UNSIGNED3		dt_max_seen	:= 0;
	  UNSIGNED4		dt_first_seen	:= 0;
		UNSIGNED4		dt_max_seen	:= 0;
	END;

	export Layout_AHist := RECORD
		UNSIGNED6   seq := 0;
		UNSIGNED6   did;
		STRING20    fname;
		STRING20    mname;
		STRING20    lname;
		STRING5     name_suffix;
		STRING9  		ssn;
		INTEGER4 		dob;
		STRING1			gender; //This is not being supported now and we should get as used by COMPID
		UNSIGNED3   dt_nonglb_last_seen;
		STRING2     src;
		UNSIGNED3   dt_first_seen; 
		UNSIGNED3   dt_last_seen;
		UNSIGNED3   dt_max_seen;	
		STRING10		prim_range;
		STRING36    addr;
		STRING18    unit;
		STRING25    city;
		STRING2     state;
		STRING5     zip;
		STRING4     zip4;
		UNSIGNED4		dod;
		STRING64    addr1;
		UNSIGNED3 	score; // Store score in case we need to research.
		STRING1     tnt := ' ';
	END;

	EXPORT Layout_ControlData := RECORD
		INTEGER4 	lastUpdateDate;
		STRING4		soundexKey;
		STRING6		sourceMatrixCode;
	END;
	
	// Use by DLN Search
	export Layout_History := RECORD
		UNSIGNED6   seq := 0;
		UNSIGNED6   did;
		STRING20    fname;
		STRING20    mname;
		STRING20    lname;
		STRING5     name_suffix;
		STRING9  		ssn;
		INTEGER4 		dob;
		STRING1			gender; //This is not being supported now and we should get as used by COMPID
		STRING2     src;
		UNSIGNED3   dt_first_seen	:= 0; 
		UNSIGNED3   dt_last_seen	:= 0;
		UNSIGNED3   dt_max_seen		:= 0;	
		STRING10		prim_range;
		STRING25    city;
		STRING2     state;
		STRING5     zip;
		STRING4     zip4;
		UNSIGNED4		dod;
		UNSIGNED3 	score; // Store score in case we need to research.
		STRING1     tnt := ' ';
		BOOLEAN			bestRec	:= FALSE;
		STRING2			predir;
		STRING28		prim_name;
		STRING4			suffix;
		STRING2			postdir;
		STRING10		unit_desig;
		STRING36    addr;
		STRING8			sec_range;
	END;
	
	// Extract of the DL V2 data
	EXPORT Layout_License := RECORD
		STRING2		dlState;							// issue state, orig_state
		UNSIGNED4	lic_issue_date := 0;
		UNSIGNED4 expiration_date := 0;
		STRING42  restrictions := '';
		STRING6   license_class := ''; 	
		STRING4   license_type;	  		 	
		STRING14  dl_number;           	
	END;	
	
	export Layout_PersonalID := RECORD
		Standard.Name_Slim;			// Names
		Standard.DOB;						// Date of Birth
		Standard.SSN;						// SSN
		STRING1		gender;				// Gender
	END;	

		// use by DLN Search
	EXPORT Layout_CompId_Result := RECORD
		UNSIGNED6 seq;
		UNSIGNED6 did;

		Layout_PersonalID;							// This stores either best names and at most one name only
		Standard.DOD;										// Date of Death Record

		Layout_Address 	currentAddress;	// Current Address
		Layout_Address 	priorAddress1;	// Prior Address 1
		Layout_Address 	priorAddress2;	// Prior Address 2
		Layout_Address 	priorAddress3;	// Prior Address 3
		Layout_License 	currentDL; 			// Most Recent License to be retrieved
		UNSIGNED4 			score; 					// Store score in case we need to research.
		STRING1					resType	:='';		// For BVC results
		STRING70				remarks	:='';		// For researching results may contains last_seen_date, did, ssn and dob counts
	END;	
	// The Personal Id data used by Address Search or ADD
	EXPORT Layout_Add_PersonalID := RECORD
		UNSIGNED6 did;
		Standard.Name_Slim;												// Names
		Standard.DOB;															// Date of Birth
		Standard.SSN;															// SSN
		STRING1		gender;													// Gender
		Standard.DOD;															// Date of Death Record
		UNSIGNED3						dt_first_seen	:= 0; 	// Do not know if those will be used 
		UNSIGNED3						dt_max_seen		:= 0;		// Do not know if those will be used 
		Layout_License 	    currentDL; 						// Most Recent License to be retrieved
	END;	
	// The final result for use by Address Search or ADD
	EXPORT Layout_Add_Result := RECORD
		UNSIGNED6 														seq;
		DATASET(Layout_Add_PersonalID) namesList{MAXCOUNT(Constants.MAX_CANDIDATES_ON_ADDRESS)};
		Layout_Address 										    currentAddress;		// Current Address
		UNSIGNED4 														score; 						// Store score in case we need to research.
		STRING1																resType	:='';			// For BVC results
		STRING70															remarks	:='';			// For research results may contains last_seen_date, did
	END;	

	// CompId_Order mapped from Edits Inquiry
	EXPORT CompId_Order := RECORD
		// RI01
		STRING2  ReportUseCode;
		
		// PI01
		STRING4  PrefName;
		STRING28 LastName;
		STRING20 FirstName;
		STRING15 MidName;
		STRING3  SufName;
		
		STRING8  BirthDate;
		STRING9  SsnNum;
		
		// AL01
		STRING9  HouseNum;
		STRING20 StrName;
		STRING5  AptNum;
		
		STRING20 CityName;
		STRING2  StateCode;
		STRING5  ZipNum;
		STRING4  ZipSufNum;
		
		// DL01
		STRING25 LicNum;
		STRING2  DLStateCode;

	END;
END;