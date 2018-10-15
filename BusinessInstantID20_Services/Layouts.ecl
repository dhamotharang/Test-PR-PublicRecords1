IMPORT BIPV2, Risk_Indicators, SALT28;

EXPORT Layouts := MODULE

	EXPORT InputCompanyInfo := RECORD
		// BIP Link IDs
		SALT28.UIDType PowID := 0;
		SALT28.UIDType ProxID := 0;
		SALT28.UIDType SeleID := 0;
		SALT28.UIDType OrgID := 0;
		SALT28.UIDType UltID := 0;
		// Company Information
		STRING120 CompanyName := '';
		STRING120 AltCompanyName := '';
		STRING120 StreetAddress1 := '';
		STRING120 StreetAddress2 := '';
		STRING25  City := '';
		STRING2   State := '';
		STRING9   Zip := '';
		STRING9   FEIN := '';
		STRING10  Phone10 := '';
		STRING10  Fax_Number := '';
		STRING16  IPAddr := '';
		STRING120 CompanyURL := '';	
	END;

	EXPORT BatchInput := RECORD
		UNSIGNED4  Seq    := 0;
		STRING30   AcctNo := '';
		UNSIGNED6 HistoryDate := 0;
		InputCompanyInfo;
		// Authorized Representative 1 Information
		STRING5   Rep1_NameTitle := '';
		STRING120 Rep1_FullName := '';
		STRING20  Rep1_FirstName := '';
		STRING20  Rep1_MiddleName := '';
		STRING20  Rep1_LastName := '';
		STRING5   Rep1_NameSuffix := '';
		STRING20  Rep1_FormerLastName := '';
		STRING120 Rep1_StreetAddress1 := '';
		STRING120 Rep1_StreetAddress2 := '';
		STRING25  Rep1_City := '';
		STRING2   Rep1_State := '';
		STRING9   Rep1_Zip := '';
		STRING9   Rep1_SSN := '';
		STRING8   Rep1_DateOfBirth := '';
		STRING3   Rep1_Age := '';
		STRING25  Rep1_DLNumber := '';
		STRING2   Rep1_DLState := '';
		STRING10  Rep1_Phone10 := '';
		STRING100 Rep1_Email := '';
		UNSIGNED6 Rep1_LexID := 0;
		// Authorized Representative 2 Information
		STRING5   Rep2_NameTitle := '';
		STRING120 Rep2_FullName := '';
		STRING20  Rep2_FirstName := '';
		STRING20  Rep2_MiddleName := '';
		STRING20  Rep2_LastName := '';
		STRING5   Rep2_NameSuffix := '';
		STRING20  Rep2_FormerLastName := '';
		STRING120 Rep2_StreetAddress1 := '';
		STRING120 Rep2_StreetAddress2 := '';
		STRING25  Rep2_City := '';
		STRING2   Rep2_State := '';
		STRING9   Rep2_Zip := '';
		STRING9   Rep2_SSN := '';
		STRING8   Rep2_DateOfBirth := '';
		STRING3   Rep2_Age := '';
		STRING25  Rep2_DLNumber := '';
		STRING2   Rep2_DLState := '';
		STRING10  Rep2_Phone10 := '';
		STRING100 Rep2_Email := '';
		UNSIGNED6 Rep2_LexID := 0;
		// Authorized Representative 3 Information
		STRING5   Rep3_NameTitle := '';
		STRING120 Rep3_FullName := '';
		STRING20  Rep3_FirstName := '';
		STRING20  Rep3_MiddleName := '';
		STRING20  Rep3_LastName := '';
		STRING5   Rep3_NameSuffix := '';
		STRING20  Rep3_FormerLastName := '';
		STRING120 Rep3_StreetAddress1 := '';
		STRING120 Rep3_StreetAddress2 := '';
		STRING25  Rep3_City := '';
		STRING2   Rep3_State := '';
		STRING9   Rep3_Zip := '';
		STRING9   Rep3_SSN := '';
		STRING8   Rep3_DateOfBirth := '';
		STRING3   Rep3_Age := '';
		STRING25  Rep3_DLNumber := '';
		STRING2   Rep3_DLState := '';
		STRING10  Rep3_Phone10 := '';
		STRING100 Rep3_Email := '';
		UNSIGNED6 Rep3_LexID := 0;
		// Authorized Representative 4 Information
		STRING5   Rep4_NameTitle := '';
		STRING120 Rep4_FullName := '';
		STRING20  Rep4_FirstName := '';
		STRING20  Rep4_MiddleName := '';
		STRING20  Rep4_LastName := '';
		STRING5   Rep4_NameSuffix := '';
		STRING20  Rep4_FormerLastName := '';
		STRING120 Rep4_StreetAddress1 := '';
		STRING120 Rep4_StreetAddress2 := '';
		STRING25  Rep4_City := '';
		STRING2   Rep4_State := '';
		STRING9   Rep4_Zip := '';
		STRING9   Rep4_SSN := '';
		STRING8   Rep4_DateOfBirth := '';
		STRING3   Rep4_Age := '';
		STRING25  Rep4_DLNumber := '';
		STRING2   Rep4_DLState := '';
		STRING10  Rep4_Phone10 := '';
		STRING100 Rep4_Email := '';
		UNSIGNED6 Rep4_LexID := 0;
		// Authorized Representative 5 Information
		STRING5   Rep5_NameTitle := '';
		STRING120 Rep5_FullName := '';
		STRING20  Rep5_FirstName := '';
		STRING20  Rep5_MiddleName := '';
		STRING20  Rep5_LastName := '';
		STRING5   Rep5_NameSuffix := '';
		STRING20  Rep5_FormerLastName := '';
		STRING120 Rep5_StreetAddress1 := '';
		STRING120 Rep5_StreetAddress2 := '';
		STRING25  Rep5_City := '';
		STRING2   Rep5_State := '';
		STRING9   Rep5_Zip := '';
		STRING9   Rep5_SSN := '';
		STRING8   Rep5_DateOfBirth := '';
		STRING3   Rep5_Age := '';
		STRING25  Rep5_DLNumber := '';
		STRING2   Rep5_DLState := '';
		STRING10  Rep5_Phone10 := '';
		STRING100 Rep5_Email := '';
		UNSIGNED6 Rep5_LexID := 0;
	END;
	
	EXPORT CleanAddrFields := RECORD
		STRING10 Prim_Range  := '';
		STRING2  PreDir      := '';
		STRING28 Prim_Name   := '';
		STRING4  Addr_Suffix := '';
		STRING2  PostDir     := '';
		STRING10 Unit_Desig  := '';
		STRING8  Sec_Range   := '';
		STRING25 P_City_Name := '';
		STRING25 V_City_Name := '';
		STRING2  St          := '';
		STRING5  Zip5        := '';
		STRING4  Zip4        := '';
		STRING10 Lat         := '';
		STRING11 Long        := '';
		STRING1  Addr_Type   := ''; 
		STRING4  Addr_Status := '';
		STRING3  County      := '';
		STRING7  Geo_Block   := '';	
	END;

	EXPORT InputCompanyInfoClean := RECORD
		InputCompanyInfo;
		CleanAddrFields;
	END;
	
	EXPORT InputAuthRepInfo := RECORD
		// Authorized Representative Information
		UNSIGNED1 Rep_WhichOne   := 0;
		STRING5   NameTitle      := '';
		STRING120 FullName       := '';
		STRING20  FirstName      := '';
		STRING20  MiddleName     := '';
		STRING20  LastName       := '';
		STRING5   NameSuffix     := '';
		STRING20  FormerLastName := '';
		STRING120 StreetAddress1 := '';
		STRING120 StreetAddress2 := '';
		STRING25  City           := '';
		STRING2   State          := '';
		STRING9   Zip            := '';
		STRING9   SSN            := '';
		STRING8   DateOfBirth    := '';
		STRING3   Age            := '';
		STRING25  DLNumber       := '';
		STRING2   DLState        := '';
		STRING10  Phone10        := '';
		STRING100 Email          := '';
		UNSIGNED6 LexID          := 0;	
	END;

	EXPORT InputAuthRepInfoClean := RECORD
		InputAuthRepInfo;
		CleanAddrFields;
	END;
	
	EXPORT InputCompanyAndAuthRepInfo := RECORD
		UNSIGNED4  Seq := 0;
		STRING30   AcctNo := '';		
		UNSIGNED6 HistoryDate := 0;
		InputCompanyInfo;
		DATASET(InputAuthRepInfo) AuthReps;
	END;

	EXPORT InputCompanyAndAuthRepInfoClean := RECORD
		UNSIGNED4  Seq := 0;
		STRING30   AcctNo := '';		
		UNSIGNED6 HistoryDate := 0;
		InputCompanyInfoClean;
		DATASET(InputAuthRepInfoClean) AuthReps;
	END;
	
	// -----[ output layouts ]-----

	EXPORT InputEchoLayout := RECORD // InputEcho
		// Record identifiers
		UNSIGNED4 seq;
		STRING30 acctno;
		UNSIGNED6 transaction_id;
		UNSIGNED1 NumberValidAuthRepsInput;
		UNSIGNED6 HistoryDate;
		// BIPIDs 
		UNSIGNED6 ultid;
		UNSIGNED6 orgid;
		UNSIGNED6 seleid;
		UNSIGNED6 proxid;
		UNSIGNED6 powid;
		// Business input information (BII)
		STRING120 in_bus_name;
		STRING120 in_bus_alternatename;
		STRING120 in_bus_streetaddress1;
		STRING120 in_bus_streetaddress2;
		STRING25 in_bus_city;
		STRING2 in_bus_state;
		STRING9 in_bus_zip;		
		STRING9 in_bus_fein;
		STRING10 in_bus_phone10;
		STRING10 in_bus_fax;
		STRING16 in_bus_ipaddr;
		STRING120 in_bus_url;
		// Authorized Rep 1 input information
		UNSIGNED6 rep1_lexid;
		STRING5 in_rep1_title;
		STRING120 in_rep1_full;
		STRING20 in_rep1_first;
		STRING20 in_rep1_middle;
		STRING20 in_rep1_last;
		STRING120 in_rep1_streetaddress1;
		STRING120 in_rep1_streetaddress2;
		STRING25 in_rep1_city;
		STRING2 in_rep1_state;
		STRING9 in_rep1_zip;
		STRING9 in_rep1_ssn;
		STRING8 in_rep1_dob;
		STRING3 in_rep1_age;
		STRING10 in_rep1_phone10;
		STRING25 in_rep1_dlnumber;
		STRING2 in_rep1_dlstate;
		STRING100 in_rep1_email;
		// Authorized Rep 2 input information
		UNSIGNED6 rep2_lexid;
		STRING5 in_rep2_title;
		STRING120 in_rep2_full;
		STRING20 in_rep2_first;
		STRING20 in_rep2_middle;
		STRING20 in_rep2_last;
		STRING120 in_rep2_streetaddress1;
		STRING120 in_rep2_streetaddress2;
		STRING25 in_rep2_city;
		STRING2 in_rep2_state;
		STRING9 in_rep2_zip;
		STRING9 in_rep2_ssn;
		STRING8 in_rep2_dob;
		STRING3 in_rep2_age;
		STRING10 in_rep2_phone10;
		STRING25 in_rep2_dlnumber;
		STRING2 in_rep2_dlstate;
		STRING100 in_rep2_email;
		// Authorized Rep 3 input information
		UNSIGNED6 rep3_lexid;
		STRING5 in_rep3_title;
		STRING120 in_rep3_full;
		STRING20 in_rep3_first;
		STRING20 in_rep3_middle;
		STRING20 in_rep3_last;
		STRING120 in_rep3_streetaddress1;
		STRING120 in_rep3_streetaddress2;
		STRING25 in_rep3_city;
		STRING2 in_rep3_state;
		STRING9 in_rep3_zip;
		STRING9 in_rep3_ssn;
		STRING8 in_rep3_dob;
		STRING3 in_rep3_age;
		STRING10 in_rep3_phone10;
		STRING25 in_rep3_dlnumber;
		STRING2 in_rep3_dlstate;
		STRING100 in_rep3_email;
		// Authorized Rep 4 input information
		UNSIGNED6 rep4_lexid;
		STRING5 in_rep4_title;
		STRING120 in_rep4_full;
		STRING20 in_rep4_first;
		STRING20 in_rep4_middle;
		STRING20 in_rep4_last;
		STRING120 in_rep4_streetaddress1;
		STRING120 in_rep4_streetaddress2;
		STRING25 in_rep4_city;
		STRING2 in_rep4_state;
		STRING9 in_rep4_zip;
		STRING9 in_rep4_ssn;
		STRING8 in_rep4_dob;
		STRING3 in_rep4_age;
		STRING10 in_rep4_phone10;
		STRING25 in_rep4_dlnumber;
		STRING2 in_rep4_dlstate;
		STRING100 in_rep4_email;
		// Authorized Rep 5 input information
		UNSIGNED6 rep5_lexid;
		STRING5 in_rep5_title;
		STRING120 in_rep5_full;
		STRING20 in_rep5_first;
		STRING20 in_rep5_middle;
		STRING20 in_rep5_last;
		STRING120 in_rep5_streetaddress1;
		STRING120 in_rep5_streetaddress2;
		STRING25 in_rep5_city;
		STRING2 in_rep5_state;
		STRING9 in_rep5_zip;
		STRING9 in_rep5_ssn;
		STRING8 in_rep5_dob;
		STRING3 in_rep5_age;
		STRING10 in_rep5_phone10;
		STRING25 in_rep5_dlnumber;
		STRING2 in_rep5_dlstate;
		STRING100 in_rep5_email;
	END;

	EXPORT BatchInputEchoLayout := RECORD // InputEcho
		// Record identifiers
		UNSIGNED4 seq;
		STRING30 acctno;
		UNSIGNED6 transaction_id;
		UNSIGNED1 NumberValidAuthRepsInput;
		UNSIGNED6 HistoryDate;
		// Business input information (BII)
		STRING120 bus_company_name; // in_bus_name;
		STRING120 bus_alt_company_name; // in_bus_alternatename
		STRING120 bus_addr1; // in_bus_streetaddress1
		STRING120 bus_addr2; // in_bus_streetaddress2
		STRING25 bus_city_name; // in_bus_city
		STRING2 bus_st; // in_bus_state
		STRING9 bus_z5; // in_bus_zip
		STRING9 bus_fein; // in_bus_fein
		STRING10 bus_phone10; // in_bus_phone10
		STRING10 bus_fax; // in_bus_fax
		STRING16 bus_ipaddr; // in_bus_ipaddr
		STRING120 bus_url; // in_bus_url
		// Authorized Rep 1 input information
		STRING5 rep1_titlename; // in_rep1_title
		STRING120 rep1_fullname; // in_rep1_full
		STRING20 rep1_firstname; // in_rep1_first
		STRING20 rep1_middlename; // in_rep1_middle
		STRING20 rep1_lastname; // in_rep1_last
		STRING120 rep1_addr1; // in_rep1_streetaddress1
		STRING120 rep1_addr2; // in_rep1_streetaddress2
		STRING25 rep1_city_name; // in_rep1_city
		STRING2 rep1_st; // in_rep1_state
		STRING9 rep1_z5; // in_rep1_zip
		STRING9 rep1_ssn; // in_rep1_ssn
		STRING8 rep1_dob; // in_rep1_dob
		STRING3 rep1_age; // in_rep1_age
		STRING10 rep1_phone10; // in_rep1_phone10
		STRING25 rep1_dlnumber; // in_rep1_dlnumber
		STRING2 rep1_dlstate; // in_rep1_dlstate
		STRING100 rep1_email; // in_rep1_email
    UNSIGNED6 rep1_lexID;
		// Authorized Rep 2 input information
		STRING5 rep2_titlename; // in_rep2_title
		STRING120 rep2_fullname; // in_rep2_full
		STRING20 rep2_firstname; // in_rep2_first
		STRING20 rep2_middlename; // in_rep2_middle
		STRING20 rep2_lastname; // in_rep2_last
		STRING120 rep2_addr1; // in_rep2_streetaddress1
		STRING120 rep2_addr2; // in_rep2_streetaddress2
		STRING25 rep2_city_name; // in_rep2_city
		STRING2 rep2_st; // in_rep2_state
		STRING9 rep2_z5; // in_rep2_zip
		STRING9 rep2_ssn; // in_rep2_ssn
		STRING8 rep2_dob; // in_rep2_dob
		STRING3 rep2_age; // in_rep2_age
		STRING10 rep2_phone10; // in_rep2_phone10
		STRING25 rep2_dlnumber; // in_rep2_dlnumber
		STRING2 rep2_dlstate; // in_rep2_dlstate
		STRING100 rep2_email; // in_rep2_email
    UNSIGNED6 rep2_lexID;
		// Authorized Rep 3 input information
		STRING5 rep3_titlename; // in_rep3_title
		STRING120 rep3_fullname; // in_rep3_full
		STRING20 rep3_firstname; // in_rep3_first
		STRING20 rep3_middlename; // in_rep3_middle
		STRING20 rep3_lastname; // in_rep3_last
		STRING120 rep3_addr1; // in_rep3_streetaddress1
		STRING120 rep3_addr2; // in_rep3_streetaddress2
		STRING25 rep3_city_name; // in_rep3_city
		STRING2 rep3_st; // in_rep3_state
		STRING9 rep3_z5; // in_rep3_zip
		STRING9 rep3_ssn; // in_rep3_ssn
		STRING8 rep3_dob; // in_rep3_dob
		STRING3 rep3_age; // in_rep3_age
		STRING10 rep3_phone10; // in_rep3_phone10
		STRING25 rep3_dlnumber; // in_rep3_dlnumber
		STRING2 rep3_dlstate; // in_rep3_dlstate
		STRING100 rep3_email; // in_rep3_email
    UNSIGNED6 rep3_lexID;
		// Authorized Rep 4 input information
		STRING5 rep4_titlename; // in_rep4_title
		STRING120 rep4_fullname; // in_rep4_full
		STRING20 rep4_firstname; // in_rep4_first
		STRING20 rep4_middlename; // in_rep4_middle
		STRING20 rep4_lastname; // in_rep4_last
		STRING120 rep4_addr1; // in_rep4_streetaddress1
		STRING120 rep4_addr2; // in_rep4_streetaddress2
		STRING25 rep4_city_name; // in_rep4_city
		STRING2 rep4_st; // in_rep4_state
		STRING9 rep4_z5; // in_rep4_zip
		STRING9 rep4_ssn; // in_rep4_ssn
		STRING8 rep4_dob; // in_rep4_dob
		STRING3 rep4_age; // in_rep4_age
		STRING10 rep4_phone10; // in_rep4_phone10
		STRING25 rep4_dlnumber; // in_rep4_dlnumber
		STRING2 rep4_dlstate; // in_rep4_dlstate
		STRING100 rep4_email; // in_rep4_email
    UNSIGNED6 rep4_lexID;
		// Authorized Rep 5 input information
		STRING5 rep5_titlename; // in_rep5_title
		STRING120 rep5_fullname; // in_rep5_full
		STRING20 rep5_firstname; // in_rep5_first
		STRING20 rep5_middlename; // in_rep5_middle
		STRING20 rep5_lastname; // in_rep5_last
		STRING120 rep5_addr1; // in_rep5_streetaddress1
		STRING120 rep5_addr2; // in_rep5_streetaddress2
		STRING25 rep5_city_name; // in_rep5_city
		STRING2 rep5_st; // in_rep5_state
		STRING9 rep5_z5; // in_rep5_zip
		STRING9 rep5_ssn; // in_rep5_ssn
		STRING8 rep5_dob; // in_rep5_dob
		STRING3 rep5_age; // in_rep5_age
		STRING10 rep5_phone10; // in_rep5_phone10
		STRING25 rep5_dlnumber; // in_rep5_dlnumber
		STRING2 rep5_dlstate; // in_rep5_dlstate
		STRING100 rep5_email; // in_rep5_email
    UNSIGNED6 rep5_lexID;
	END;
	
	EXPORT CleanInputLayout := RECORD // CleanInput
		// Business
		STRING120 out_bus_company_name;    // not required
		STRING120 out_bus_alt_companyname; // not required
		STRING120 out_bus_street_address1; // not required
		STRING120 out_bus_street_address2; // not required
		STRING25 out_bus_city;             // not required
		STRING2 out_bus_state;             // not required
		STRING9 out_bus_zip;               // not required
		STRING10 out_bus_prim_range;
		STRING2 out_bus_predir;
		STRING28 out_bus_prim_name;
		STRING4 out_bus_addr_suffix;
		STRING2 out_bus_postdir;
		STRING10 out_bus_unit_desig;
		STRING8 out_bus_sec_range;
		STRING5 out_bus_zip5;
		STRING4 out_bus_zip4;
		STRING10 out_bus_lat;
		STRING11 out_bus_long;
		STRING1 out_bus_addr_type;
		STRING4 out_bus_addr_status;
		STRING30 out_bus_county;
		STRING7 out_bus_geo_block;
		STRING9 out_bus_fein;     // not required
		STRING10 out_bus_Phone10; // not required
		// Authorized Rep 1
		STRING5 out_rep1_name_title; // not required
		STRING120 out_rep1_full_name; // not required
		STRING20 out_rep1_first_name; // not required
		STRING20 out_rep1_middle_name; // not required
		STRING20 out_rep1_last_name; // not required
		STRING5 out_rep1_name_suffix; // not required
		STRING20 out_rep1_former_lastName; // not required
		STRING120 out_rep1_street_address_1; // not required
		STRING120 out_rep1_street_address_2;	 // not required
		STRING25 out_rep1_city; // not required
		STRING2 out_rep1_state; // not required
		STRING9 out_rep1_zip;			 // not required
		STRING10 out_rep1_prim_range;
		STRING2 out_rep1_predir;
		STRING28 out_rep1_prim_name;
		STRING4 out_rep1_addr_suffix;
		STRING2 out_rep1_postdir;
		STRING10 out_rep1_unit_desig;
		STRING8 out_rep1_sec_range;
		STRING5 out_rep1_zip5;
		STRING4 out_rep1_zip4;
		STRING10 out_rep1_lat;
		STRING11 out_rep1_long;
		STRING1 out_rep1_addr_type;
		STRING4 out_rep1_addr_status;
		STRING30 out_rep1_county;
		STRING7 out_rep1_geo_block;
		STRING9 out_rep1_ssn; // not required
		STRING10 out_rep1_phone10; // not required
		// Authorized Rep 2
		STRING5 out_rep2_name_title; // not required
		STRING120 out_rep2_full_name; // not required
		STRING20 out_rep2_first_name; // not required
		STRING20 out_rep2_middle_name; // not required
		STRING20 out_rep2_last_name; // not required
		STRING5 out_rep2_name_suffix; // not required
		STRING20 out_rep2_former_lastName; // not required
		STRING120 out_rep2_street_address_1; // not required
		STRING120 out_rep2_street_address_2; // not required
		STRING25 out_rep2_city; // not required
		STRING2 out_rep2_state; // not required
		STRING9 out_rep2_zip; // not required
		STRING10 out_rep2_prim_range;
		STRING2 out_rep2_predir;
		STRING28 out_rep2_prim_name;
		STRING4 out_rep2_addr_suffix;
		STRING2 out_rep2_postdir;
		STRING10 out_rep2_unit_desig;
		STRING8 out_rep2_sec_range;
		STRING5 out_rep2_zip5;
		STRING4 out_rep2_zip4;
		STRING10 out_rep2_lat;
		STRING11 out_rep2_long;
		STRING1 out_rep2_addr_type;
		STRING4 out_rep2_addr_status;
		STRING30 out_rep2_county;
		STRING7 out_rep2_geo_block;
		STRING9 out_rep2_ssn; // not required
		STRING10 out_rep2_phone10; // not required
		// Authorized Rep 3
		STRING5 out_rep3_name_title; // not required
		STRING120 out_rep3_full_name; // not required
		STRING20 out_rep3_first_name; // not required
		STRING20 out_rep3_middle_name; // not required
		STRING20 out_rep3_last_name; // not required
		STRING5 out_rep3_name_suffix; // not required
		STRING20 out_rep3_former_lastName; // not required
		STRING120 out_rep3_street_address_1; // not required
		STRING120 out_rep3_street_address_2; // not required
		STRING25 out_rep3_city; // not required
		STRING2 out_rep3_state; // not required
		STRING9 out_rep3_zip; // not required
		STRING10 out_rep3_prim_range;
		STRING2 out_rep3_predir;
		STRING28 out_rep3_prim_name;
		STRING4 out_rep3_addr_suffix;
		STRING2 out_rep3_postdir;
		STRING10 out_rep3_unit_desig;
		STRING8 out_rep3_sec_range;
		STRING5 out_rep3_zip5;
		STRING4 out_rep3_zip4;
		STRING10 out_rep3_lat;
		STRING11 out_rep3_long;
		STRING1 out_rep3_addr_type;
		STRING4 out_rep3_addr_status;
		STRING30 out_rep3_county;
		STRING7 out_rep3_geo_block;
		STRING9 out_rep3_ssn; // not required
		STRING10 out_rep3_phone10; // not required
		// Authorized Rep 4
		STRING5 out_rep4_name_title; // not required
		STRING120 out_rep4_full_name; // not required
		STRING20 out_rep4_first_name; // not required
		STRING20 out_rep4_middle_name; // not required
		STRING20 out_rep4_last_name; // not required
		STRING5 out_rep4_name_suffix; // not required
		STRING20 out_rep4_former_lastName; // not required
		STRING120 out_rep4_street_address_1; // not required
		STRING120 out_rep4_street_address_2; // not required
		STRING25 out_rep4_city; // not required
		STRING2 out_rep4_state; // not required
		STRING9 out_rep4_zip; // not required
		STRING10 out_rep4_prim_range;
		STRING2 out_rep4_predir;
		STRING28 out_rep4_prim_name;
		STRING4 out_rep4_addr_suffix;
		STRING2 out_rep4_postdir;
		STRING10 out_rep4_unit_desig;
		STRING8 out_rep4_sec_range;
		STRING5 out_rep4_zip5;
		STRING4 out_rep4_zip4;
		STRING10 out_rep4_lat;
		STRING11 out_rep4_long;
		STRING1 out_rep4_addr_type;
		STRING4 out_rep4_addr_status;
		STRING30 out_rep4_county;
		STRING7 out_rep4_geo_block;
		STRING9 out_rep4_ssn; // not required
		STRING10 out_rep4_phone10; // not required
		// Authorized Rep 5
		STRING5 out_rep5_name_title; // not required
		STRING120 out_rep5_full_name; // not required
		STRING20 out_rep5_first_name; // not required
		STRING20 out_rep5_middle_name; // not required
		STRING20 out_rep5_last_name; // not required
		STRING5 out_rep5_name_suffix; // not required
		STRING20 out_rep5_former_lastName; // not required
		STRING120 out_rep5_street_address_1; // not required
		STRING120 out_rep5_street_address_2; // not required
		STRING25 out_rep5_city; // not required
		STRING2 out_rep5_state; // not required
		STRING9 out_rep5_zip; // not required
		STRING10 out_rep5_prim_range;
		STRING2 out_rep5_predir;
		STRING28 out_rep5_prim_name;
		STRING4 out_rep5_addr_suffix;
		STRING2 out_rep5_postdir;
		STRING10 out_rep5_unit_desig;
		STRING8 out_rep5_sec_range;
		STRING5 out_rep5_zip5;
		STRING4 out_rep5_zip4;
		STRING10 out_rep5_lat;
		STRING11 out_rep5_long;
		STRING1 out_rep5_addr_type;
		STRING4 out_rep5_addr_status;
		STRING30 out_rep5_county;
		STRING7 out_rep5_geo_block;
		STRING9 out_rep5_ssn; // not required
		STRING10 out_rep5_phone10; // not required
	END;
	
	EXPORT BatchBestInfoLayout := RECORD // BestEcho
		UNSIGNED4 Seq;
		STRING120	bestcompanyname; // best_bus_name
		STRING120	bestaddr; // best_bus_addr
		STRING25	bestcity; // best_bus_city
		STRING2	beststate; // best_bus_state
		STRING5	bestzip; // best_bus_zip
		STRING4	bestzip4; // best_bus_zip4;
		STRING10 bestphone; // best_bus_phone
		STRING9 bestfein; // best_bus_fein
	END;

	EXPORT BatchLinkIDsLayout := RECORD
		UNSIGNED4 Seq;
		UNSIGNED6 ultid;
		UNSIGNED6 orgid;
		UNSIGNED6 seleid;
		UNSIGNED6 proxid;
		UNSIGNED6 powid;	
	END;
	
	EXPORT BestInfoLayout := RECORD // BestEcho
		UNSIGNED4 Seq;
		BOOLEAN isactive;
		BOOLEAN isdefunct;
		STRING120	best_bus_name;
		INTEGER dt_first_seen;
		INTEGER dt_last_seen;
		STRING10 best_bus_prim_range;
		STRING2 best_bus_predir;
		STRING28 best_bus_prim_name;
		STRING4 best_bus_addr_suffix;
		STRING2 best_bus_postdir;
		STRING10 best_bus_unit_desig;
		STRING8 best_bus_sec_range;
		STRING120	best_bus_addr;
		STRING25	best_bus_city;
		STRING30 best_bus_county;
		STRING2	best_bus_state;
		STRING5	best_bus_zip;
		STRING4	best_bus_zip4;
		STRING10 best_bus_phone;	
		STRING9 best_bus_fein;
		STRING8 best_sic_code;
		STRING120 best_sic_desc;
		STRING6 best_naics_code;
		STRING120 best_naics_desc;
	END;

	EXPORT BatchVerifiedLayout := RECORD // VerifiedEcho
		UNSIGNED4 Seq;
		STRING120 vercmpy; // bus_ver_name
		STRING50 veraddr; // bus_ver_addr
		STRING30 vercity; // bus_ver_city
		STRING2 verstate; // bus_ver_state
		STRING5 verzip; // bus_ver_zip
		STRING10 verphone; // bus_ver_phone
		STRING9 verfein; // bus_ver_tin
	END;
	
	EXPORT VerifiedLayout := RECORD // VerifiedEcho
		UNSIGNED4 Seq;
		STRING120 bus_ver_name;
		STRING120 bus_ver_altname;
		STRING50 bus_ver_addr;
		STRING30 bus_ver_city;
		STRING2 bus_ver_state;
		STRING5 bus_ver_zip;
		STRING4 bus_ver_zip4;
		STRING20 bus_ver_county;
		STRING9 bus_ver_tin;
		STRING10 bus_ver_phone;		
	END;

	EXPORT BatchVerificationLayout := RECORD // Verification
		UNSIGNED4 Seq;
		STRING1 cnamematchflag; // ver_name_indicator
		STRING1 addrmatchflag; // ver_streetaddr_indicator
		STRING1 citymatchflag; // ver_city_indicator
		STRING1 statematchflag; // ver_state_indicator
		STRING1 zipmatchflag; // ver_zip_indicator
		STRING1 phonematchflag; // ver_phone_indicator
		STRING1 feinmatchflag; // ver_tin_indicator
	END;
	
	EXPORT VerificationLayout := RECORD // Verification
		UNSIGNED4 Seq;
		STRING1 ver_name_indicator;
		STRING1 ver_altname_indicator;
		STRING1 ver_streetaddr_indicator;
		STRING1 ver_city_indicator;
		STRING1 ver_state_indicator;
		STRING1 ver_zip_indicator;
		STRING1 ver_phone_indicator;
		STRING1 ver_tin_indicator;
	END;
	
	EXPORT ResidentialBusLayout := RECORD // SoleProp
		UNSIGNED4 Seq;
		STRING1 residential_bus_indicator;
		STRING30 residential_bus_desc;
	END;

	EXPORT BatchFirmographicLayout := RECORD // Firmographic
		UNSIGNED4 Seq;
		STRING50  LN_Status;
		STRING10  sos_status;
		STRING120 sos_filing_name;
		STRING5   time_on_sos;
		STRING8   SIC;
		STRING120  SIC_desc;
		STRING6   NAICS;		
		STRING120  NAICS_desc;
		STRING4   Bus_firstseen_YYYY;
		STRING5   time_on_publicrecord;
		STRING120 bus_description;
		STRING25  bus_county;
	END;
	
	EXPORT FirmographicLayout := RECORD // Firmographic
		UNSIGNED4 Seq;
		STRING120 sos_filing_name;
		STRING10  sos_status;
		STRING5   time_on_sos;
		STRING5   time_on_publicrecord;
		STRING120 bus_description;
		STRING25  bus_county;
		STRING4   Bus_firstseen_YYYY;
		STRING50  LN_Status;
	END;

	EXPORT BatchParentLayout := RECORD // Parent
		UNSIGNED4 Seq;
		UNSIGNED6 parent_seleid;
		STRING120 parent_best_bus_name;		
	END;
	
	EXPORT ParentLayout := RECORD // Parent
		UNSIGNED4 Seq;
		UNSIGNED6 parent_ultid;
		UNSIGNED6 parent_orgid;
		UNSIGNED6 parent_seleid;
		UNSIGNED6 parent_proxid;
		UNSIGNED6 parent_powid;
		UNSIGNED6 parent_empid;
		UNSIGNED6 parent_dotid;
		STRING120 parent_best_bus_name;		
	END;

	EXPORT BusinessByPhoneLayout := RECORD
		UNSIGNED4 Seq;
		STRING120 bus_phone_match_company_1;
		STRING10  bus_phone_match_prim_range_1;
		STRING2   bus_phone_match_predir_1;
		STRING28  bus_phone_match_prim_name_1;
		STRING4   bus_phone_match_suffix_1;
		STRING2   bus_phone_match_postdir_1;
		STRING10  bus_phone_match_unit_desig_1;
		STRING8   bus_phone_match_sec_range_1;
		STRING50  bus_phone_match_addr_1;
		STRING30  bus_phone_match_city_1;
		STRING2   bus_phone_match_state_1;
		STRING5   bus_phone_match_zip_1;
		STRING4   bus_phone_match_zip4_1;
		UNSIGNED6 bus_phone_match_ultid_1;
		UNSIGNED6 bus_phone_match_orgid_1;
		UNSIGNED6 bus_phone_match_seleid_1;
		UNSIGNED6 bus_phone_match_proxid_1;
		UNSIGNED6 bus_phone_match_powid_1;	
				
		STRING120 bus_phone_match_company_2;
		STRING10  bus_phone_match_prim_range_2;
		STRING2   bus_phone_match_predir_2;
		STRING28  bus_phone_match_prim_name_2;
		STRING4   bus_phone_match_suffix_2;
		STRING2   bus_phone_match_postdir_2;
		STRING10  bus_phone_match_unit_desig_2;
		STRING8   bus_phone_match_sec_range_2;
		STRING50  bus_phone_match_addr_2;
		STRING30  bus_phone_match_city_2;
		STRING2   bus_phone_match_state_2;
		STRING5   bus_phone_match_zip_2;
		STRING4   bus_phone_match_zip4_2;
		UNSIGNED6 bus_phone_match_ultid_2;
		UNSIGNED6 bus_phone_match_orgid_2;
		UNSIGNED6 bus_phone_match_seleid_2;
		UNSIGNED6 bus_phone_match_proxid_2;
		UNSIGNED6 bus_phone_match_powid_2;	

		STRING120 bus_phone_match_company_3;
		STRING10  bus_phone_match_prim_range_3;
		STRING2   bus_phone_match_predir_3;
		STRING28  bus_phone_match_prim_name_3;
		STRING4   bus_phone_match_suffix_3;
		STRING2   bus_phone_match_postdir_3;
		STRING10  bus_phone_match_unit_desig_3;
		STRING8   bus_phone_match_sec_range_3;
		STRING50  bus_phone_match_addr_3;
		STRING30  bus_phone_match_city_3;
		STRING2   bus_phone_match_state_3;
		STRING5   bus_phone_match_zip_3;
		STRING4   bus_phone_match_zip4_3;		
		UNSIGNED6 bus_phone_match_ultid_3;
		UNSIGNED6 bus_phone_match_orgid_3;
		UNSIGNED6 bus_phone_match_seleid_3;
		UNSIGNED6 bus_phone_match_proxid_3;
		UNSIGNED6 bus_phone_match_powid_3;	
	END;

	EXPORT PhonesByAddressLayout := RECORD
		UNSIGNED4 Seq;
		STRING10 bus_addr_match_phone_1;
		STRING10 bus_addr_match_phone_2;
		STRING10 bus_addr_match_phone_3;
	END;

	EXPORT BusinessByFEINLayout := RECORD
		UNSIGNED4 Seq;
		STRING120 bus_fein_match_company_1;
		STRING10  bus_fein_match_prim_range_1;
		STRING2   bus_fein_match_predir_1;
		STRING28  bus_fein_match_prim_name_1;
		STRING4   bus_fein_match_suffix_1;
		STRING2   bus_fein_match_postdir_1;
		STRING10  bus_fein_match_unit_desig_1;
		STRING8   bus_fein_match_sec_range_1;
		STRING50  bus_fein_match_addr_1;
		STRING30  bus_fein_match_city_1;
		STRING2   bus_fein_match_state_1;
		STRING5   bus_fein_match_zip_1;
		STRING4   bus_fein_match_zip4_1;
		UNSIGNED6 bus_fein_match_ultid_1;
		UNSIGNED6 bus_fein_match_orgid_1;
		UNSIGNED6 bus_fein_match_seleid_1;
		UNSIGNED6 bus_fein_match_proxid_1;
		UNSIGNED6 bus_fein_match_powid_1;
				
		STRING120 bus_fein_match_company_2;
		STRING10  bus_fein_match_prim_range_2;
		STRING2   bus_fein_match_predir_2;
		STRING28  bus_fein_match_prim_name_2;
		STRING4   bus_fein_match_suffix_2;
		STRING2   bus_fein_match_postdir_2;
		STRING10  bus_fein_match_unit_desig_2;
		STRING8   bus_fein_match_sec_range_2;
		STRING50  bus_fein_match_addr_2;
		STRING30  bus_fein_match_city_2;
		STRING2   bus_fein_match_state_2;
		STRING5   bus_fein_match_zip_2;
		STRING4   bus_fein_match_zip4_2;
		UNSIGNED6 bus_fein_match_ultid_2;
		UNSIGNED6 bus_fein_match_orgid_2;
		UNSIGNED6 bus_fein_match_seleid_2;
		UNSIGNED6 bus_fein_match_proxid_2;
		UNSIGNED6 bus_fein_match_powid_2;	
				
		STRING120 bus_fein_match_company_3;
		STRING10  bus_fein_match_prim_range_3;
		STRING2   bus_fein_match_predir_3;
		STRING28  bus_fein_match_prim_name_3;
		STRING4   bus_fein_match_suffix_3;
		STRING2   bus_fein_match_postdir_3;
		STRING10  bus_fein_match_unit_desig_3;
		STRING8   bus_fein_match_sec_range_3;
		STRING50  bus_fein_match_addr_3;
		STRING30  bus_fein_match_city_3;
		STRING2   bus_fein_match_state_3;
		STRING5   bus_fein_match_zip_3;
		STRING4   bus_fein_match_zip4_3;
		UNSIGNED6 bus_fein_match_ultid_3;
		UNSIGNED6 bus_fein_match_orgid_3;
		UNSIGNED6 bus_fein_match_seleid_3;
		UNSIGNED6 bus_fein_match_proxid_3;
		UNSIGNED6 bus_fein_match_powid_3;	
	END;			

	EXPORT BatchBusinessVerificationLayout := RECORD
		STRING3   bvi; // Business Verification Index
		STRING150 bvi_desc;	
	END;

	EXPORT RiskIndicatorLayout := RECORD // Risk Indicators
		UNSIGNED4 Seq;
		STRING4 bus_ri_1;
		STRING110 bus_ri_desc_1;
		STRING4 bus_ri_2;
		STRING110 bus_ri_desc_2;
		STRING4 bus_ri_3;
		STRING110 bus_ri_desc_3;
		STRING4 bus_ri_4;
		STRING110 bus_ri_desc_4;
		STRING4 bus_ri_5;
		STRING110 bus_ri_desc_5;
		STRING4 bus_ri_6;
		STRING110 bus_ri_desc_6;
		STRING4 bus_ri_7;
		STRING110 bus_ri_desc_7;
		STRING4 bus_ri_8;
		STRING110 bus_ri_desc_8;	
	END;

	EXPORT BatchVerificationSummariesLayout := RECORD // Verification Summaries
		UNSIGNED4 Seq;
		UNSIGNED1 Phone_Verification; // ver_phone_src_index
		STRING60  Phone_Ver_Desc;  // ver_phone_desc
		UNSIGNED1 Bureau_Verification; // ver_bureau_src_index
		STRING60  Bureau_Ver_Desc; // ver_bureau_desc
		UNSIGNED1 Govt_Reg_Verification; // ver_govt_reg_src_index
		STRING60  Govt_Reg_Ver_Desc; // ver_govt_reg_desc
		UNSIGNED1 PubRec_Filings_Verification; // ver_pubrec_filing_src_index
		STRING60  PubRec_Filings_Ver_desc; // ver_pubrec_filing_desc
		UNSIGNED1 Bus_Directories_Verification; // ver_bus_directories_src_index
		STRING60  Bus_Directories_Ver_desc; // ver_bus_directories_desc
	END; 
	
	EXPORT VerificationSummariesLayout := RECORD // Verification Summaries
		UNSIGNED4 Seq;
		UNSIGNED1 ver_phone_src_index;
		STRING60  ver_phone_desc; 
		UNSIGNED1 ver_bureau_src_index;
		STRING60  ver_bureau_desc;
		UNSIGNED1 ver_govt_reg_src_index;
		STRING60  ver_govt_reg_desc;
		UNSIGNED1 ver_pubrec_filing_src_index;
		STRING60  ver_pubrec_filing_desc;
		UNSIGNED1 ver_bus_directories_src_index;
		STRING60  ver_bus_directories_desc;
		STRING3   bvi; // Business Verification Index
		STRING3   bvi_desc_key; // three-digit index key
		STRING150 bvi_desc;
	END; 
	
	EXPORT OFACLayoutFlat := RECORD
		UNSIGNED4 Seq;
		//ofac
		STRING60 bus_ofac_table_1;
		STRING120 bus_ofac_program_1;
		STRING10 bus_ofac_record_number_1;
		STRING120 bus_ofac_companyname_1;
		STRING20 bus_ofac_firstname_1;
		STRING20 bus_ofac_lastname_1;
		STRING50 bus_ofac_address_1;
		STRING30 bus_ofac_city_1;
		STRING2 bus_ofac_state_1;
		STRING9 bus_ofac_zip_1;
		STRING30 bus_ofac_country_1;
		STRING200 bus_ofac_entity_name_1;
		STRING4 bus_ofac_sequence_1;
		STRING60 bus_ofac_table_2;
		STRING120 bus_ofac_program_2;
		STRING10 bus_ofac_record_number_2;
		STRING120 bus_ofac_companyname_2;
		STRING20 bus_ofac_firstname_2;
		STRING20 bus_ofac_lastname_2;
		STRING50 bus_ofac_address_2;
		STRING30 bus_ofac_city_2;
		STRING2 bus_ofac_state_2;
		STRING9 bus_ofac_zip_2;
		STRING30 bus_ofac_country_2;
		STRING200 bus_ofac_entity_name_2;
		STRING4 bus_ofac_sequence_2;
		STRING60 bus_ofac_table_3;
		STRING120 bus_ofac_program_3;
		STRING10 bus_ofac_record_number_3;
		STRING120 bus_ofac_companyname_3;
		STRING20 bus_ofac_firstname_3;
		STRING20 bus_ofac_lastname_3;
		STRING50 bus_ofac_address_3;
		STRING30 bus_ofac_city_3;
		STRING2 bus_ofac_state_3;
		STRING9 bus_ofac_zip_3;
		STRING30 bus_ofac_country_3;
		STRING200 bus_ofac_entity_name_3;
		STRING4 bus_ofac_sequence_3;
		STRING60 bus_ofac_table_4;
		STRING120 bus_ofac_program_4;
		STRING10 bus_ofac_record_number_4;
		STRING120 bus_ofac_companyname_4;
		STRING20 bus_ofac_firstname_4;
		STRING20 bus_ofac_lastname_4;
		STRING50 bus_ofac_address_4;
		STRING30 bus_ofac_city_4;
		STRING2 bus_ofac_state_4;
		STRING9 bus_ofac_zip_4;
		STRING30 bus_ofac_country_4;
		STRING200 bus_ofac_entity_name_4;
		STRING4 bus_ofac_sequence_4;
		STRING60 bus_ofac_table_5;
		STRING120 bus_ofac_program_5;
		STRING10 bus_ofac_record_number_5;
		STRING120 bus_ofac_companyname_5;
		STRING20 bus_ofac_firstname_5;
		STRING20 bus_ofac_lastname_5;
		STRING50 bus_ofac_address_5;
		STRING30 bus_ofac_city_5;
		STRING2 bus_ofac_state_5;
		STRING9 bus_ofac_zip_5;
		STRING30 bus_ofac_country_5;
		STRING200 bus_ofac_entity_name_5;
		STRING4 bus_ofac_sequence_5;
		STRING60 bus_ofac_table_6;
		STRING120 bus_ofac_program_6;
		STRING10 bus_ofac_record_number_6;
		STRING120 bus_ofac_companyname_6;
		STRING20 bus_ofac_firstname_6;
		STRING20 bus_ofac_lastname_6;
		STRING50 bus_ofac_address_6;
		STRING30 bus_ofac_city_6;
		STRING2 bus_ofac_state_6;
		STRING9 bus_ofac_zip_6;
		STRING30 bus_ofac_country_6;
		STRING200 bus_ofac_entity_name_6;
		STRING4 bus_ofac_sequence_6;
		STRING60 bus_ofac_table_7;
		STRING120 bus_ofac_program_7;
		STRING10 bus_ofac_record_number_7;
		STRING120 bus_ofac_companyname_7;
		STRING20 bus_ofac_firstname_7;
		STRING20 bus_ofac_lastname_7;
		STRING50 bus_ofac_address_7;
		STRING30 bus_ofac_city_7;
		STRING2 bus_ofac_state_7;
		STRING9 bus_ofac_zip_7;
		STRING30 bus_ofac_country_7;
		STRING200 bus_ofac_entity_name_7;
		STRING4 bus_ofac_sequence_7;	
	END;
	
	EXPORT WatchlistLayoutFlat := RECORD
		UNSIGNED4 Seq;
		// other watchlists
		STRING60 bus_watchlist_table_1;
		STRING120 bus_watchlist_program_1;
		STRING10 bus_watchlist_record_number_1;
		STRING120 bus_watchlist_companyname_1;
		STRING20 bus_watchlist_firstname_1;
		STRING20 bus_watchlist_lastname_1;
		STRING50 bus_watchlist_address_1;
		STRING30 bus_watchlist_city_1;
		STRING2 bus_watchlist_state_1;
		STRING9 bus_watchlist_zip_1;
		STRING30 bus_watchlist_country_1;
		STRING200 bus_watchlist_entity_name_1;
		STRING4 bus_watchlist_sequence_1;
		STRING60 bus_watchlist_table_2;
		STRING120 bus_watchlist_program_2;
		STRING10 bus_watchlist_record_number_2;
		STRING120 bus_watchlist_companyname_2;
		STRING20 bus_watchlist_firstname_2;
		STRING20 bus_watchlist_lastname_2;
		STRING50 bus_watchlist_address_2;
		STRING30 bus_watchlist_city_2;
		STRING2 bus_watchlist_state_2;
		STRING9 bus_watchlist_zip_2;
		STRING30 bus_watchlist_country_2;
		STRING200 bus_watchlist_entity_name_2;
		STRING4 bus_watchlist_sequence_2;
		STRING60 bus_watchlist_table_3;
		STRING120 bus_watchlist_program_3;
		STRING10 bus_watchlist_record_number_3;
		STRING120 bus_watchlist_companyname_3;
		STRING20 bus_watchlist_firstname_3;
		STRING20 bus_watchlist_lastname_3;
		STRING50 bus_watchlist_address_3;
		STRING30 bus_watchlist_city_3;
		STRING2 bus_watchlist_state_3;
		STRING9 bus_watchlist_zip_3;
		STRING30 bus_watchlist_country_3;
		STRING200 bus_watchlist_entity_name_3;
		STRING4 bus_watchlist_sequence_3;
		STRING60 bus_watchlist_table_4;
		STRING120 bus_watchlist_program_4;
		STRING10 bus_watchlist_record_number_4;
		STRING120 bus_watchlist_companyname_4;
		STRING20 bus_watchlist_firstname_4;
		STRING20 bus_watchlist_lastname_4;
		STRING50 bus_watchlist_address_4;
		STRING30 bus_watchlist_city_4;
		STRING2 bus_watchlist_state_4;
		STRING9 bus_watchlist_zip_4;
		STRING30 bus_watchlist_country_4;
		STRING200 bus_watchlist_entity_name_4;
		STRING4 bus_watchlist_sequence_4;
		STRING60 bus_watchlist_table_5;
		STRING120 bus_watchlist_program_5;
		STRING10 bus_watchlist_record_number_5;
		STRING120 bus_watchlist_companyname_5;
		STRING20 bus_watchlist_firstname_5;
		STRING20 bus_watchlist_lastname_5;
		STRING50 bus_watchlist_address_5;
		STRING30 bus_watchlist_city_5;
		STRING2 bus_watchlist_state_5;
		STRING9 bus_watchlist_zip_5;
		STRING30 bus_watchlist_country_5;
		STRING200 bus_watchlist_entity_name_5;
		STRING4 bus_watchlist_sequence_5;
		STRING60 bus_watchlist_table_6;
		STRING120 bus_watchlist_program_6;
		STRING10 bus_watchlist_record_number_6;
		STRING120 bus_watchlist_companyname_6;
		STRING20 bus_watchlist_firstname_6;
		STRING20 bus_watchlist_lastname_6;
		STRING50 bus_watchlist_address_6;
		STRING30 bus_watchlist_city_6;
		STRING2 bus_watchlist_state_6;
		STRING9 bus_watchlist_zip_6;
		STRING30 bus_watchlist_country_6;
		STRING200 bus_watchlist_entity_name_6;
		STRING4 bus_watchlist_sequence_6;
		STRING60 bus_watchlist_table_7;
		STRING120 bus_watchlist_program_7;
		STRING10 bus_watchlist_record_number_7;
		STRING120 bus_watchlist_companyname_7;
		STRING20 bus_watchlist_firstname_7;
		STRING20 bus_watchlist_lastname_7;
		STRING50 bus_watchlist_address_7;
		STRING30 bus_watchlist_city_7;
		STRING2 bus_watchlist_state_7;
		STRING9 bus_watchlist_zip_7;
		STRING30 bus_watchlist_country_7;
		STRING200 bus_watchlist_entity_name_7;
		STRING4 bus_watchlist_sequence_7;	
	END;
	
	EXPORT OFACAndWatchlistLayoutFlat := RECORD // OFAC
		UNSIGNED4 Seq;
		OFACLayoutFlat AND NOT [Seq];
		WatchlistLayoutFlat AND NOT [Seq];
	END;
	
	EXPORT Business2ExecLayout := RECORD // Bus2Exec
		UNSIGNED4 Seq;
		STRING2 bus2exec_index_rep1;
		STRING150 bus2exec_desc_rep1;
		STRING2 bus2exec_index_rep2;
		STRING150 bus2exec_desc_rep2;
		STRING2 bus2exec_index_rep3;
		STRING150 bus2exec_desc_rep3;
		STRING2 bus2exec_index_rep4;
		STRING150 bus2exec_desc_rep4;
		STRING2 bus2exec_index_rep5;
		STRING150 bus2exec_desc_rep5;
	END;	

	EXPORT BatchPersonRoleLayout := RECORD // PersonRoleAuthRep
		UNSIGNED4 Seq;
		STRING100 Rep1_title;
		STRING100 Rep2_title;
		STRING100 Rep3_title;
		STRING100 Rep4_title;
		STRING100 Rep5_title;		
	END;	
	
	EXPORT PersonRoleLayout := RECORD // PersonRoleAuthRep
		UNSIGNED4 Seq;
		STRING100 person_role_rep1;
		STRING100 person_role_rep2;
		STRING100 person_role_rep3;
		STRING100 person_role_rep4;
		STRING100 person_role_rep5;		
	END;	

	EXPORT SBFEVerificationLayout := RECORD 
		UNSIGNED4 Seq;
		STRING3 time_on_sbfe;
		STRING3 last_seen_sbfe;
		STRING3 count_of_trades_sbfe;
	END;

	EXPORT ConsumerIIDFlatSingleLayout := RECORD
		UNSIGNED4 Seq;
		// AuthRep1
		STRING20 verfirst;
		STRING20 verlast;
		STRING50 veraddr;
		STRING30 vercity;
		STRING2 verstate;
		STRING5 verzip;
		STRING4 verzip4;
		STRING20 vercounty;
		STRING9 verssn;
		STRING8 verdob;
		STRING10 verhphone;
		STRING25 verdl;
		STRING1 verify_addr;
		STRING1 verify_dob;
		STRING1 valid_ssn;
		STRING3 nas_summary;
		STRING3 nap_summary;
		STRING1 nap_type;
		STRING1 nap_status;
		STRING3 cvi;
		STRING8 deceaseddate;
		STRING8 deceaseddob;
		STRING20 deceasedfirst;
		STRING20 deceasedlast;
		STRING1 dobmatchlevel;
		STRING4 hri_1;
		STRING100 hri_desc_1;
		STRING4 hri_2;
		STRING100 hri_desc_2;
		STRING4 hri_3;
		STRING100 hri_desc_3;
		STRING4 hri_4;
		STRING100 hri_desc_4;
		STRING4 hri_5;
		STRING100 hri_desc_5;
		STRING4 hri_6;
		STRING100 hri_desc_6;
		STRING4 hri_7;
		STRING100 hri_desc_7;
		STRING4 hri_8;
		STRING100 hri_desc_8;
		STRING4 hri_9;
		STRING100 hri_desc_9;
		STRING4 hri_10;
		STRING100 hri_desc_10;
		STRING4 fua_1;
		STRING150 fua_desc_1;
		STRING4 fua_2;
		STRING150 fua_desc_2;
		STRING4 fua_3;
		STRING150 fua_desc_3;
		STRING4 fua_4;
		STRING150 fua_desc_4;
		STRING20 corrected_lname;
		STRING8 corrected_dob;
		STRING10 corrected_phone;
		STRING9 corrected_ssn;
		STRING65 corrected_address;
		STRING3  area_code_split;			
		STRING8  area_code_split_date;
		STRING20 phone_fname;
		STRING20 phone_lname;
		STRING65 phone_address;
		STRING25 phone_city;
		STRING2 phone_st;
		STRING5 phone_zip;
		STRING10 name_addr_phone;
		STRING6 ssa_date_first;
		STRING6 ssa_date_last;
		STRING2 ssa_state;
		STRING20 ssa_state_name;
		STRING20 current_fname;
		STRING20 current_lname;
		STRING65 chron_Address_1;
		STRING25 chron_City_1;
		STRING2 chron_St_1;
		STRING5 chron_Zip_1;
		STRING4 chron_Zip4_1;
		STRING50 chron_phone_1;
		STRING6 chron_dt_first_seen_1;
		STRING6 chron_dt_last_seen_1;
		STRING65 chron_Address_2;
		STRING25 chron_City_2;
		STRING2 chron_St_2;
		STRING5 chron_Zip_2;
		STRING4 chron_Zip4_2;
		STRING50 chron_phone_2;
		STRING6 chron_dt_first_seen_2;
		STRING6 chron_dt_last_seen_2;
		STRING65 chron_Address_3;
		STRING25 chron_City_3;
		STRING2 chron_St_3;
		STRING5 chron_Zip_3;
		STRING4 chron_Zip4_3;
		STRING50 chron_phone_3;
		STRING6 chron_dt_first_seen_3;
		STRING6 chron_dt_last_seen_3;
		STRING20 additional_fname_1;
		STRING20 additional_lname_1;
		STRING8 additional_lname_date_last_1;
		STRING20 additional_fname_2;
		STRING20 additional_lname_2;
		STRING8 additional_lname_date_last_2;
		STRING20 additional_fname_3;
		STRING20 additional_lname_3;
		STRING8 additional_lname_date_last_3;
		BOOLEAN ADVODoNotDeliver;
		STRING1 ADVODropIndicator;
		BOOLEAN ADVOAddressVacancyIndicator;
		STRING1 ADVOResidentialOrBusinessInd;
		BOOLEAN USPISHotList;
		BOOLEAN addressPOBox;
		BOOLEAN addressCMRA;
		UNSIGNED1 DIDCount;
		UNSIGNED6 DID2;
		UNSIGNED6 DID3;
		BOOLEAN EmergingID;
		STRING1 AddressSecondaryRangeMismatch;
		BOOLEAN StandardizedAddress;
		STRING65 StreetAddress1;
		STRING65 StreetAddress2;
		STRING20 CountyName;
		STRING60 watchlist_table;
		STRING120 watchlist_program;
		STRING10 watchlist_record_number;
		STRING20 watchlist_fname;
		STRING20 watchlist_lname;
		STRING65 watchlist_address;
		STRING25 watchlist_city;
		STRING2 watchlist_state;
		STRING5 watchlist_zip;
		STRING30 watchlist_country;
		STRING200 watchlist_entity_name;
		STRING60 watchlist_table_2;
		STRING120 watchlist_program_2;
		STRING10 watchlist_record_number_2;
		STRING20 watchlist_fname_2;
		STRING20 watchlist_lname_2;
		STRING65 watchlist_address_2;
		STRING25 watchlist_city_2;
		STRING2 watchlist_state_2;
		STRING5 watchlist_zip_2;
		STRING30 watchlist_country_2;
		STRING200 watchlist_entity_name_2;
		STRING60 watchlist_table_3;
		STRING120 watchlist_program_3;
		STRING10 watchlist_record_number_3;
		STRING20 watchlist_fname_3;
		STRING20 watchlist_lname_3;
		STRING65 watchlist_address_3;
		STRING25 watchlist_city_3;
		STRING2 watchlist_state_3;
		STRING5 watchlist_zip_3;
		STRING30 watchlist_country_3;
		STRING200 watchlist_entity_name_3;
		STRING60 watchlist_table_4;
		STRING120 watchlist_program_4;
		STRING10 watchlist_record_number_4;
		STRING20 watchlist_fname_4;
		STRING20 watchlist_lname_4;
		STRING65 watchlist_address_4;
		STRING25 watchlist_city_4;
		STRING2 watchlist_state_4;
		STRING5 watchlist_zip_4;
		STRING30 watchlist_country_4;
		STRING200 watchlist_entity_name_4;
		STRING60 watchlist_table_5;
		STRING120 watchlist_program_5;
		STRING10 watchlist_record_number_5;
		STRING20 watchlist_fname_5;
		STRING20 watchlist_lname_5;
		STRING65 watchlist_address_5;
		STRING25 watchlist_city_5;
		STRING2 watchlist_state_5;
		STRING5 watchlist_zip_5;
		STRING30 watchlist_country_5;
		STRING200 watchlist_entity_name_5;
		STRING60 watchlist_table_6;
		STRING120 watchlist_program_6;
		STRING10 watchlist_record_number_6;
		STRING20 watchlist_fname_6;
		STRING20 watchlist_lname_6;
		STRING65 watchlist_address_6;
		STRING25 watchlist_city_6;
		STRING2 watchlist_state_6;
		STRING5 watchlist_zip_6;
		STRING30 watchlist_country_6;
		STRING200 watchlist_entity_name_6;
		STRING60 watchlist_table_7;
		STRING120 watchlist_program_7;
		STRING10 watchlist_record_number_7;
		STRING20 watchlist_fname_7;
		STRING20 watchlist_lname_7;
		STRING65 watchlist_address_7;
		STRING25 watchlist_city_7;
		STRING2 watchlist_state_7;
		STRING5 watchlist_zip_7;
		STRING30 watchlist_country_7;
		STRING200 watchlist_entity_name_7;
	END;
	
	EXPORT ConsumerIIDFlatLayout := RECORD 
		UNSIGNED4 Seq;
		// AuthRep1
		STRING20 rep1_verfirst;
		STRING20 rep1_verlast;
		STRING50 rep1_veraddr;
		STRING30 rep1_vercity;
		STRING2 rep1_verstate;
		STRING5 rep1_verzip;
		STRING4 rep1_verzip4;
		STRING20 rep1_vercounty;
		STRING9 rep1_verssn;
		STRING8 rep1_verdob;
		STRING10 rep1_verhphone;
		STRING25 rep1_verdl;
		STRING1 rep1_verify_addr;
		STRING1 rep1_verify_dob;
		STRING1 rep1_valid_ssn;
		STRING3 rep1_nas_summary;
		STRING3 rep1_nap_summary;
		STRING1 rep1_nap_type;
		STRING1 rep1_nap_status;
		STRING3 rep1_cvi;
		STRING8 rep1_deceaseddate;
		STRING8 rep1_deceaseddob;
		STRING20 rep1_deceasedfirst;
		STRING20 rep1_deceasedlast;
		STRING1 rep1_dobmatchlevel;
		STRING4 rep1_hri_1;
		STRING100 rep1_hri_desc_1;
		STRING4 rep1_hri_2;
		STRING100 rep1_hri_desc_2;
		STRING4 rep1_hri_3;
		STRING100 rep1_hri_desc_3;
		STRING4 rep1_hri_4;
		STRING100 rep1_hri_desc_4;
		STRING4 rep1_hri_5;
		STRING100 rep1_hri_desc_5;
		STRING4 rep1_hri_6;
		STRING100 rep1_hri_desc_6;
		STRING4 rep1_hri_7;
		STRING100 rep1_hri_desc_7;
		STRING4 rep1_hri_8;
		STRING100 rep1_hri_desc_8;
		STRING4 rep1_hri_9;
		STRING100 rep1_hri_desc_9;
		STRING4 rep1_hri_10;
		STRING100 rep1_hri_desc_10;
		STRING4 rep1_fua_1;
		STRING150 rep1_fua_desc_1;
		STRING4 rep1_fua_2;
		STRING150 rep1_fua_desc_2;
		STRING4 rep1_fua_3;
		STRING150 rep1_fua_desc_3;
		STRING4 rep1_fua_4;
		STRING150 rep1_fua_desc_4;
		STRING20 rep1_corrected_lname;
		STRING8 rep1_corrected_dob;
		STRING10 rep1_corrected_phone;
		STRING9 rep1_corrected_ssn;
		STRING65 rep1_corrected_address;
		STRING3  rep1_area_code_split;			
		STRING8  rep1_area_code_split_date;
		STRING20 rep1_phone_fname;
		STRING20 rep1_phone_lname;
		STRING65 rep1_phone_address;
		STRING25 rep1_phone_city;
		STRING2 rep1_phone_st;
		STRING5 rep1_phone_zip;
		STRING10 rep1_name_addr_phone;
		STRING6 rep1_ssa_date_first;
		STRING6 rep1_ssa_date_last;
		STRING2 rep1_ssa_state;
		STRING20 rep1_ssa_state_name;
		STRING20 rep1_current_fname;
		STRING20 rep1_current_lname;
		STRING65 rep1_chron_Address_1;
		STRING25 rep1_chron_City_1;
		STRING2 rep1_chron_St_1;
		STRING5 rep1_chron_Zip_1;
		STRING4 rep1_chron_Zip4_1;
		STRING50 rep1_chron_phone_1;
		STRING6 rep1_chron_dt_first_seen_1;
		STRING6 rep1_chron_dt_last_seen_1;
		STRING65 rep1_chron_Address_2;
		STRING25 rep1_chron_City_2;
		STRING2 rep1_chron_St_2;
		STRING5 rep1_chron_Zip_2;
		STRING4 rep1_chron_Zip4_2;
		STRING50 rep1_chron_phone_2;
		STRING6 rep1_chron_dt_first_seen_2;
		STRING6 rep1_chron_dt_last_seen_2;
		STRING65 rep1_chron_Address_3;
		STRING25 rep1_chron_City_3;
		STRING2 rep1_chron_St_3;
		STRING5 rep1_chron_Zip_3;
		STRING4 rep1_chron_Zip4_3;
		STRING50 rep1_chron_phone_3;
		STRING6 rep1_chron_dt_first_seen_3;
		STRING6 rep1_chron_dt_last_seen_3;
		STRING20 rep1_addl_fname_1;
		STRING20 rep1_addl_lname_1;
		STRING8 rep1_addl_lname_date_last_1;
		STRING20 rep1_addl_fname_2;
		STRING20 rep1_addl_lname_2;
		STRING8 rep1_addl_lname_date_last_2;
		STRING20 rep1_addl_fname_3;
		STRING20 rep1_addl_lname_3;
		STRING8 rep1_addl_lname_date_last_3;
		BOOLEAN rep1_addressPOBox;
		BOOLEAN rep1_addressCMRA;
		STRING60 rep1_watchlist_table;
		STRING120 rep1_watchlist_program;
		STRING10 rep1_watchlist_record_number;
		STRING20 rep1_watchlist_fname;
		STRING20 rep1_watchlist_lname;
		STRING65 rep1_watchlist_address;
		STRING25 rep1_watchlist_city;
		STRING2 rep1_watchlist_state;
		STRING5 rep1_watchlist_zip;
		STRING30 rep1_watchlist_country;
		STRING200 rep1_watchlist_entity_name;
		STRING60 rep1_watchlist_table_2;
		STRING120 rep1_watchlist_program_2;
		STRING10 rep1_watchlist_record_number_2;
		STRING20 rep1_watchlist_fname_2;
		STRING20 rep1_watchlist_lname_2;
		STRING65 rep1_watchlist_address_2;
		STRING25 rep1_watchlist_city_2;
		STRING2 rep1_watchlist_state_2;
		STRING5 rep1_watchlist_zip_2;
		STRING30 rep1_watchlist_country_2;
		STRING200 rep1_watchlist_entity_name_2;
		STRING60 rep1_watchlist_table_3;
		STRING120 rep1_watchlist_program_3;
		STRING10 rep1_watchlist_record_number_3;
		STRING20 rep1_watchlist_fname_3;
		STRING20 rep1_watchlist_lname_3;
		STRING65 rep1_watchlist_address_3;
		STRING25 rep1_watchlist_city_3;
		STRING2 rep1_watchlist_state_3;
		STRING5 rep1_watchlist_zip_3;
		STRING30 rep1_watchlist_country_3;
		STRING200 rep1_watchlist_entity_name_3;
		STRING60 rep1_watchlist_table_4;
		STRING120 rep1_watchlist_program_4;
		STRING10 rep1_watchlist_record_number_4;
		STRING20 rep1_watchlist_fname_4;
		STRING20 rep1_watchlist_lname_4;
		STRING65 rep1_watchlist_address_4;
		STRING25 rep1_watchlist_city_4;
		STRING2 rep1_watchlist_state_4;
		STRING5 rep1_watchlist_zip_4;
		STRING30 rep1_watchlist_country_4;
		STRING200 rep1_watchlist_entity_name_4;
		STRING60 rep1_watchlist_table_5;
		STRING120 rep1_watchlist_program_5;
		STRING10 rep1_watchlist_record_number_5;
		STRING20 rep1_watchlist_fname_5;
		STRING20 rep1_watchlist_lname_5;
		STRING65 rep1_watchlist_address_5;
		STRING25 rep1_watchlist_city_5;
		STRING2 rep1_watchlist_state_5;
		STRING5 rep1_watchlist_zip_5;
		STRING30 rep1_watchlist_country_5;
		STRING200 rep1_watchlist_entity_name_5;
		STRING60 rep1_watchlist_table_6;
		STRING120 rep1_watchlist_program_6;
		STRING10 rep1_watchlist_record_number_6;
		STRING20 rep1_watchlist_fname_6;
		STRING20 rep1_watchlist_lname_6;
		STRING65 rep1_watchlist_address_6;
		STRING25 rep1_watchlist_city_6;
		STRING2 rep1_watchlist_state_6;
		STRING5 rep1_watchlist_zip_6;
		STRING30 rep1_watchlist_country_6;
		STRING200 rep1_watchlist_entity_name_6;
		STRING60 rep1_watchlist_table_7;
		STRING120 rep1_watchlist_program_7;
		STRING10 rep1_watchlist_record_number_7;
		STRING20 rep1_watchlist_fname_7;
		STRING20 rep1_watchlist_lname_7;
		STRING65 rep1_watchlist_address_7;
		STRING25 rep1_watchlist_city_7;
		STRING2 rep1_watchlist_state_7;
		STRING5 rep1_watchlist_zip_7;
		STRING30 rep1_watchlist_country_7;
		STRING200 rep1_watchlist_entity_name_7;
		
		// Authrep2
		STRING20 rep2_verfirst;
		STRING20 rep2_verlast;
		STRING50 rep2_veraddr;
		STRING30 rep2_vercity;
		STRING2 rep2_verstate;
		STRING5 rep2_verzip;
		STRING4 rep2_verzip4;
		STRING20 rep2_vercounty;
		STRING9 rep2_verssn;
		STRING8 rep2_verdob;
		STRING10 rep2_verhphone;
		STRING25 rep2_verdl;
		STRING1 rep2_verify_addr;
		STRING1 rep2_verify_dob;
		STRING1 rep2_valid_ssn;
		STRING3 rep2_nas_summary;
		STRING3 rep2_nap_summary;
		STRING1 rep2_nap_type;
		STRING1 rep2_nap_status;
		STRING3 rep2_cvi;
		STRING8 rep2_deceaseddate;
		STRING8 rep2_deceaseddob;
		STRING20 rep2_deceasedfirst;
		STRING20 rep2_deceasedlast;
		STRING1 rep2_dobmatchlevel;
		STRING4 rep2_hri_1;
		STRING100 rep2_hri_desc_1;
		STRING4 rep2_hri_2;
		STRING100 rep2_hri_desc_2;
		STRING4 rep2_hri_3;
		STRING100 rep2_hri_desc_3;
		STRING4 rep2_hri_4;
		STRING100 rep2_hri_desc_4;
		STRING4 rep2_hri_5;
		STRING100 rep2_hri_desc_5;
		STRING4 rep2_hri_6;
		STRING100 rep2_hri_desc_6;
		STRING4 rep2_hri_7;
		STRING100 rep2_hri_desc_7;
		STRING4 rep2_hri_8;
		STRING100 rep2_hri_desc_8;
		STRING4 rep2_hri_9;
		STRING100 rep2_hri_desc_9;
		STRING4 rep2_hri_10;
		STRING100 rep2_hri_desc_10;
		STRING4 rep2_fua_1;
		STRING150 rep2_fua_desc_1;
		STRING4 rep2_fua_2;
		STRING150 rep2_fua_desc_2;
		STRING4 rep2_fua_3;
		STRING150 rep2_fua_desc_3;
		STRING4 rep2_fua_4;
		STRING150 rep2_fua_desc_4;
		STRING20 rep2_corrected_lname;
		STRING8 rep2_corrected_dob;
		STRING10 rep2_corrected_phone;
		STRING9 rep2_corrected_ssn;
		STRING65 rep2_corrected_address;
		STRING3  rep2_area_code_split;			
		STRING8  rep2_area_code_split_date;
		STRING20 rep2_phone_fname;
		STRING20 rep2_phone_lname;
		STRING65 rep2_phone_address;
		STRING25 rep2_phone_city;
		STRING2 rep2_phone_st;
		STRING5 rep2_phone_zip;
		STRING10 rep2_name_addr_phone;
		STRING6 rep2_ssa_date_first;
		STRING6 rep2_ssa_date_last;
		STRING2 rep2_ssa_state;
		STRING20 rep2_ssa_state_name;
		STRING20 rep2_current_fname;
		STRING20 rep2_current_lname;
		STRING65 rep2_chron_Address_1;
		STRING25 rep2_chron_City_1;
		STRING2 rep2_chron_St_1;
		STRING5 rep2_chron_Zip_1;
		STRING4 rep2_chron_Zip4_1;
		STRING50 rep2_chron_phone_1;
		STRING6 rep2_chron_dt_first_seen_1;
		STRING6 rep2_chron_dt_last_seen_1;
		STRING65 rep2_chron_Address_2;
		STRING25 rep2_chron_City_2;
		STRING2 rep2_chron_St_2;
		STRING5 rep2_chron_Zip_2;
		STRING4 rep2_chron_Zip4_2;
		STRING50 rep2_chron_phone_2;
		STRING6 rep2_chron_dt_first_seen_2;
		STRING6 rep2_chron_dt_last_seen_2;
		STRING65 rep2_chron_Address_3;
		STRING25 rep2_chron_City_3;
		STRING2 rep2_chron_St_3;
		STRING5 rep2_chron_Zip_3;
		STRING4 rep2_chron_Zip4_3;
		STRING50 rep2_chron_phone_3;
		STRING6 rep2_chron_dt_first_seen_3;
		STRING6 rep2_chron_dt_last_seen_3;
		STRING20 rep2_addl_fname_1;
		STRING20 rep2_addl_lname_1;
		STRING8 rep2_addl_lname_date_last_1;
		STRING20 rep2_addl_fname_2;
		STRING20 rep2_addl_lname_2;
		STRING8 rep2_addl_lname_date_last_2;
		STRING20 rep2_addl_fname_3;
		STRING20 rep2_addl_lname_3;
		STRING8 rep2_addl_lname_date_last_3;
		BOOLEAN rep2_addressPOBox;
		BOOLEAN rep2_addressCMRA;
		STRING60 rep2_watchlist_table;
		STRING120 rep2_watchlist_program;
		STRING10 rep2_watchlist_record_number;
		STRING20 rep2_watchlist_fname;
		STRING20 rep2_watchlist_lname;
		STRING65 rep2_watchlist_address;
		STRING25 rep2_watchlist_city;
		STRING2 rep2_watchlist_state;
		STRING5 rep2_watchlist_zip;
		STRING30 rep2_watchlist_country;
		STRING200 rep2_watchlist_entity_name;
		STRING60 rep2_watchlist_table_2;
		STRING120 rep2_watchlist_program_2;
		STRING10 rep2_watchlist_record_number_2;
		STRING20 rep2_watchlist_fname_2;
		STRING20 rep2_watchlist_lname_2;
		STRING65 rep2_watchlist_address_2;
		STRING25 rep2_watchlist_city_2;
		STRING2 rep2_watchlist_state_2;
		STRING5 rep2_watchlist_zip_2;
		STRING30 rep2_watchlist_country_2;
		STRING200 rep2_watchlist_entity_name_2;
		STRING60 rep2_watchlist_table_3;
		STRING120 rep2_watchlist_program_3;
		STRING10 rep2_watchlist_record_number_3;
		STRING20 rep2_watchlist_fname_3;
		STRING20 rep2_watchlist_lname_3;
		STRING65 rep2_watchlist_address_3;
		STRING25 rep2_watchlist_city_3;
		STRING2 rep2_watchlist_state_3;
		STRING5 rep2_watchlist_zip_3;
		STRING30 rep2_watchlist_country_3;
		STRING200 rep2_watchlist_entity_name_3;
		STRING60 rep2_watchlist_table_4;
		STRING120 rep2_watchlist_program_4;
		STRING10 rep2_watchlist_record_number_4;
		STRING20 rep2_watchlist_fname_4;
		STRING20 rep2_watchlist_lname_4;
		STRING65 rep2_watchlist_address_4;
		STRING25 rep2_watchlist_city_4;
		STRING2 rep2_watchlist_state_4;
		STRING5 rep2_watchlist_zip_4;
		STRING30 rep2_watchlist_country_4;
		STRING200 rep2_watchlist_entity_name_4;
		STRING60 rep2_watchlist_table_5;
		STRING120 rep2_watchlist_program_5;
		STRING10 rep2_watchlist_record_number_5;
		STRING20 rep2_watchlist_fname_5;
		STRING20 rep2_watchlist_lname_5;
		STRING65 rep2_watchlist_address_5;
		STRING25 rep2_watchlist_city_5;
		STRING2 rep2_watchlist_state_5;
		STRING5 rep2_watchlist_zip_5;
		STRING30 rep2_watchlist_country_5;
		STRING200 rep2_watchlist_entity_name_5;
		STRING60 rep2_watchlist_table_6;
		STRING120 rep2_watchlist_program_6;
		STRING10 rep2_watchlist_record_number_6;
		STRING20 rep2_watchlist_fname_6;
		STRING20 rep2_watchlist_lname_6;
		STRING65 rep2_watchlist_address_6;
		STRING25 rep2_watchlist_city_6;
		STRING2 rep2_watchlist_state_6;
		STRING5 rep2_watchlist_zip_6;
		STRING30 rep2_watchlist_country_6;
		STRING200 rep2_watchlist_entity_name_6;
		STRING60 rep2_watchlist_table_7;
		STRING120 rep2_watchlist_program_7;
		STRING10 rep2_watchlist_record_number_7;
		STRING20 rep2_watchlist_fname_7;
		STRING20 rep2_watchlist_lname_7;
		STRING65 rep2_watchlist_address_7;
		STRING25 rep2_watchlist_city_7;
		STRING2 rep2_watchlist_state_7;
		STRING5 rep2_watchlist_zip_7;
		STRING30 rep2_watchlist_country_7;
		STRING200 rep2_watchlist_entity_name_7;
		
		// Authrep3
		STRING20 rep3_verfirst;
		STRING20 rep3_verlast;
		STRING50 rep3_veraddr;
		STRING30 rep3_vercity;
		STRING2 rep3_verstate;
		STRING5 rep3_verzip;
		STRING4 rep3_verzip4;
		STRING20 rep3_vercounty;
		STRING9 rep3_verssn;
		STRING8 rep3_verdob;
		STRING10 rep3_verhphone;
		STRING25 rep3_verdl;
		STRING1 rep3_verify_addr;
		STRING1 rep3_verify_dob;
		STRING1 rep3_valid_ssn;
		STRING3 rep3_nas_summary;
		STRING3 rep3_nap_summary;
		STRING1 rep3_nap_type;
		STRING1 rep3_nap_status;
		STRING3 rep3_cvi;
		STRING8 rep3_deceaseddate;
		STRING8 rep3_deceaseddob;
		STRING20 rep3_deceasedfirst;
		STRING20 rep3_deceasedlast;
		STRING1 rep3_dobmatchlevel;
		STRING4 rep3_hri_1;
		STRING100 rep3_hri_desc_1;
		STRING4 rep3_hri_2;
		STRING100 rep3_hri_desc_2;
		STRING4 rep3_hri_3;
		STRING100 rep3_hri_desc_3;
		STRING4 rep3_hri_4;
		STRING100 rep3_hri_desc_4;
		STRING4 rep3_hri_5;
		STRING100 rep3_hri_desc_5;
		STRING4 rep3_hri_6;
		STRING100 rep3_hri_desc_6;
		STRING4 rep3_hri_7;
		STRING100 rep3_hri_desc_7;
		STRING4 rep3_hri_8;
		STRING100 rep3_hri_desc_8;
		STRING4 rep3_hri_9;
		STRING100 rep3_hri_desc_9;
		STRING4 rep3_hri_10;
		STRING100 rep3_hri_desc_10;
		STRING4 rep3_fua_1;
		STRING150 rep3_fua_desc_1;
		STRING4 rep3_fua_2;
		STRING150 rep3_fua_desc_2;
		STRING4 rep3_fua_3;
		STRING150 rep3_fua_desc_3;
		STRING4 rep3_fua_4;
		STRING150 rep3_fua_desc_4;
		STRING20 rep3_corrected_lname;
		STRING8 rep3_corrected_dob;
		STRING10 rep3_corrected_phone;
		STRING9 rep3_corrected_ssn;
		STRING65 rep3_corrected_address;
		STRING3  rep3_area_code_split;			
		STRING8  rep3_area_code_split_date;
		STRING20 rep3_phone_fname;
		STRING20 rep3_phone_lname;
		STRING65 rep3_phone_address;
		STRING25 rep3_phone_city;
		STRING2 rep3_phone_st;
		STRING5 rep3_phone_zip;
		STRING10 rep3_name_addr_phone;
		STRING6 rep3_ssa_date_first;
		STRING6 rep3_ssa_date_last;
		STRING2 rep3_ssa_state;
		STRING20 rep3_ssa_state_name;
		STRING20 rep3_current_fname;
		STRING20 rep3_current_lname;
		STRING65 rep3_chron_Address_1;
		STRING25 rep3_chron_City_1;
		STRING2 rep3_chron_St_1;
		STRING5 rep3_chron_Zip_1;
		STRING4 rep3_chron_Zip4_1;
		STRING50 rep3_chron_phone_1;
		STRING6 rep3_chron_dt_first_seen_1;
		STRING6 rep3_chron_dt_last_seen_1;
		STRING65 rep3_chron_Address_2;
		STRING25 rep3_chron_City_2;
		STRING2 rep3_chron_St_2;
		STRING5 rep3_chron_Zip_2;
		STRING4 rep3_chron_Zip4_2;
		STRING50 rep3_chron_phone_2;
		STRING6 rep3_chron_dt_first_seen_2;
		STRING6 rep3_chron_dt_last_seen_2;
		STRING65 rep3_chron_Address_3;
		STRING25 rep3_chron_City_3;
		STRING2 rep3_chron_St_3;
		STRING5 rep3_chron_Zip_3;
		STRING4 rep3_chron_Zip4_3;
		STRING50 rep3_chron_phone_3;
		STRING6 rep3_chron_dt_first_seen_3;
		STRING6 rep3_chron_dt_last_seen_3;
		STRING20 rep3_addl_fname_1;
		STRING20 rep3_addl_lname_1;
		STRING8 rep3_addl_lname_date_last_1;
		STRING20 rep3_addl_fname_2;
		STRING20 rep3_addl_lname_2;
		STRING8 rep3_addl_lname_date_last_2;
		STRING20 rep3_addl_fname_3;
		STRING20 rep3_addl_lname_3;
		STRING8 rep3_addl_lname_date_last_3;
		BOOLEAN rep3_addressPOBox;
		BOOLEAN rep3_addressCMRA;
		STRING60 rep3_watchlist_table;
		STRING120 rep3_watchlist_program;
		STRING10 rep3_watchlist_record_number;
		STRING20 rep3_watchlist_fname;
		STRING20 rep3_watchlist_lname;
		STRING65 rep3_watchlist_address;
		STRING25 rep3_watchlist_city;
		STRING2 rep3_watchlist_state;
		STRING5 rep3_watchlist_zip;
		STRING30 rep3_watchlist_country;
		STRING200 rep3_watchlist_entity_name;
		STRING60 rep3_watchlist_table_2;
		STRING120 rep3_watchlist_program_2;
		STRING10 rep3_watchlist_record_number_2;
		STRING20 rep3_watchlist_fname_2;
		STRING20 rep3_watchlist_lname_2;
		STRING65 rep3_watchlist_address_2;
		STRING25 rep3_watchlist_city_2;
		STRING2 rep3_watchlist_state_2;
		STRING5 rep3_watchlist_zip_2;
		STRING30 rep3_watchlist_country_2;
		STRING200 rep3_watchlist_entity_name_2;
		STRING60 rep3_watchlist_table_3;
		STRING120 rep3_watchlist_program_3;
		STRING10 rep3_watchlist_record_number_3;
		STRING20 rep3_watchlist_fname_3;
		STRING20 rep3_watchlist_lname_3;
		STRING65 rep3_watchlist_address_3;
		STRING25 rep3_watchlist_city_3;
		STRING2 rep3_watchlist_state_3;
		STRING5 rep3_watchlist_zip_3;
		STRING30 rep3_watchlist_country_3;
		STRING200 rep3_watchlist_entity_name_3;
		STRING60 rep3_watchlist_table_4;
		STRING120 rep3_watchlist_program_4;
		STRING10 rep3_watchlist_record_number_4;
		STRING20 rep3_watchlist_fname_4;
		STRING20 rep3_watchlist_lname_4;
		STRING65 rep3_watchlist_address_4;
		STRING25 rep3_watchlist_city_4;
		STRING2 rep3_watchlist_state_4;
		STRING5 rep3_watchlist_zip_4;
		STRING30 rep3_watchlist_country_4;
		STRING200 rep3_watchlist_entity_name_4;
		STRING60 rep3_watchlist_table_5;
		STRING120 rep3_watchlist_program_5;
		STRING10 rep3_watchlist_record_number_5;
		STRING20 rep3_watchlist_fname_5;
		STRING20 rep3_watchlist_lname_5;
		STRING65 rep3_watchlist_address_5;
		STRING25 rep3_watchlist_city_5;
		STRING2 rep3_watchlist_state_5;
		STRING5 rep3_watchlist_zip_5;
		STRING30 rep3_watchlist_country_5;
		STRING200 rep3_watchlist_entity_name_5;
		STRING60 rep3_watchlist_table_6;
		STRING120 rep3_watchlist_program_6;
		STRING10 rep3_watchlist_record_number_6;
		STRING20 rep3_watchlist_fname_6;
		STRING20 rep3_watchlist_lname_6;
		STRING65 rep3_watchlist_address_6;
		STRING25 rep3_watchlist_city_6;
		STRING2 rep3_watchlist_state_6;
		STRING5 rep3_watchlist_zip_6;
		STRING30 rep3_watchlist_country_6;
		STRING200 rep3_watchlist_entity_name_6;
		STRING60 rep3_watchlist_table_7;
		STRING120 rep3_watchlist_program_7;
		STRING10 rep3_watchlist_record_number_7;
		STRING20 rep3_watchlist_fname_7;
		STRING20 rep3_watchlist_lname_7;
		STRING65 rep3_watchlist_address_7;
		STRING25 rep3_watchlist_city_7;
		STRING2 rep3_watchlist_state_7;
		STRING5 rep3_watchlist_zip_7;
		STRING30 rep3_watchlist_country_7;
		STRING200 rep3_watchlist_entity_name_7;
		
		// Authrep4
		STRING20 rep4_verfirst;
		STRING20 rep4_verlast;
		STRING50 rep4_veraddr;
		STRING30 rep4_vercity;
		STRING2 rep4_verstate;
		STRING5 rep4_verzip;
		STRING4 rep4_verzip4;
		STRING20 rep4_vercounty;
		STRING9 rep4_verssn;
		STRING8 rep4_verdob;
		STRING10 rep4_verhphone;
		STRING25 rep4_verdl;
		STRING1 rep4_verify_addr;
		STRING1 rep4_verify_dob;
		STRING1 rep4_valid_ssn;
		STRING3 rep4_nas_summary;
		STRING3 rep4_nap_summary;
		STRING1 rep4_nap_type;
		STRING1 rep4_nap_status;
		STRING3 rep4_cvi;
		STRING8 rep4_deceaseddate;
		STRING8 rep4_deceaseddob;
		STRING20 rep4_deceasedfirst;
		STRING20 rep4_deceasedlast;
		STRING1 rep4_dobmatchlevel;
		STRING4 rep4_hri_1;
		STRING100 rep4_hri_desc_1;
		STRING4 rep4_hri_2;
		STRING100 rep4_hri_desc_2;
		STRING4 rep4_hri_3;
		STRING100 rep4_hri_desc_3;
		STRING4 rep4_hri_4;
		STRING100 rep4_hri_desc_4;
		STRING4 rep4_hri_5;
		STRING100 rep4_hri_desc_5;
		STRING4 rep4_hri_6;
		STRING100 rep4_hri_desc_6;
		STRING4 rep4_hri_7;
		STRING100 rep4_hri_desc_7;
		STRING4 rep4_hri_8;
		STRING100 rep4_hri_desc_8;
		STRING4 rep4_hri_9;
		STRING100 rep4_hri_desc_9;
		STRING4 rep4_hri_10;
		STRING100 rep4_hri_desc_10;
		STRING4 rep4_fua_1;
		STRING150 rep4_fua_desc_1;
		STRING4 rep4_fua_2;
		STRING150 rep4_fua_desc_2;
		STRING4 rep4_fua_3;
		STRING150 rep4_fua_desc_3;
		STRING4 rep4_fua_4;
		STRING150 rep4_fua_desc_4;
		STRING20 rep4_corrected_lname;
		STRING8 rep4_corrected_dob;
		STRING10 rep4_corrected_phone;
		STRING9 rep4_corrected_ssn;
		STRING65 rep4_corrected_address;
		STRING3  rep4_area_code_split;			
		STRING8  rep4_area_code_split_date;
		STRING20 rep4_phone_fname;
		STRING20 rep4_phone_lname;
		STRING65 rep4_phone_address;
		STRING25 rep4_phone_city;
		STRING2 rep4_phone_st;
		STRING5 rep4_phone_zip;
		STRING10 rep4_name_addr_phone;
		STRING6 rep4_ssa_date_first;
		STRING6 rep4_ssa_date_last;
		STRING2 rep4_ssa_state;
		STRING20 rep4_ssa_state_name;
		STRING20 rep4_current_fname;
		STRING20 rep4_current_lname;
		STRING65 rep4_chron_Address_1;
		STRING25 rep4_chron_City_1;
		STRING2 rep4_chron_St_1;
		STRING5 rep4_chron_Zip_1;
		STRING4 rep4_chron_Zip4_1;
		STRING50 rep4_chron_phone_1;
		STRING6 rep4_chron_dt_first_seen_1;
		STRING6 rep4_chron_dt_last_seen_1;
		STRING65 rep4_chron_Address_2;
		STRING25 rep4_chron_City_2;
		STRING2 rep4_chron_St_2;
		STRING5 rep4_chron_Zip_2;
		STRING4 rep4_chron_Zip4_2;
		STRING50 rep4_chron_phone_2;
		STRING6 rep4_chron_dt_first_seen_2;
		STRING6 rep4_chron_dt_last_seen_2;
		STRING65 rep4_chron_Address_3;
		STRING25 rep4_chron_City_3;
		STRING2 rep4_chron_St_3;
		STRING5 rep4_chron_Zip_3;
		STRING4 rep4_chron_Zip4_3;
		STRING50 rep4_chron_phone_3;
		STRING6 rep4_chron_dt_first_seen_3;
		STRING6 rep4_chron_dt_last_seen_3;
		STRING20 rep4_addl_fname_1;
		STRING20 rep4_addl_lname_1;
		STRING8 rep4_addl_lname_date_last_1;
		STRING20 rep4_addl_fname_2;
		STRING20 rep4_addl_lname_2;
		STRING8 rep4_addl_lname_date_last_2;
		STRING20 rep4_addl_fname_3;
		STRING20 rep4_addl_lname_3;
		STRING8 rep4_addl_lname_date_last_3;
		BOOLEAN rep4_addressPOBox;
		BOOLEAN rep4_addressCMRA;
		STRING60 rep4_watchlist_table;
		STRING120 rep4_watchlist_program;
		STRING10 rep4_watchlist_record_number;
		STRING20 rep4_watchlist_fname;
		STRING20 rep4_watchlist_lname;
		STRING65 rep4_watchlist_address;
		STRING25 rep4_watchlist_city;
		STRING2 rep4_watchlist_state;
		STRING5 rep4_watchlist_zip;
		STRING30 rep4_watchlist_country;
		STRING200 rep4_watchlist_entity_name;
		STRING60 rep4_watchlist_table_2;
		STRING120 rep4_watchlist_program_2;
		STRING10 rep4_watchlist_record_number_2;
		STRING20 rep4_watchlist_fname_2;
		STRING20 rep4_watchlist_lname_2;
		STRING65 rep4_watchlist_address_2;
		STRING25 rep4_watchlist_city_2;
		STRING2 rep4_watchlist_state_2;
		STRING5 rep4_watchlist_zip_2;
		STRING30 rep4_watchlist_country_2;
		STRING200 rep4_watchlist_entity_name_2;
		STRING60 rep4_watchlist_table_3;
		STRING120 rep4_watchlist_program_3;
		STRING10 rep4_watchlist_record_number_3;
		STRING20 rep4_watchlist_fname_3;
		STRING20 rep4_watchlist_lname_3;
		STRING65 rep4_watchlist_address_3;
		STRING25 rep4_watchlist_city_3;
		STRING2 rep4_watchlist_state_3;
		STRING5 rep4_watchlist_zip_3;
		STRING30 rep4_watchlist_country_3;
		STRING200 rep4_watchlist_entity_name_3;
		STRING60 rep4_watchlist_table_4;
		STRING120 rep4_watchlist_program_4;
		STRING10 rep4_watchlist_record_number_4;
		STRING20 rep4_watchlist_fname_4;
		STRING20 rep4_watchlist_lname_4;
		STRING65 rep4_watchlist_address_4;
		STRING25 rep4_watchlist_city_4;
		STRING2 rep4_watchlist_state_4;
		STRING5 rep4_watchlist_zip_4;
		STRING30 rep4_watchlist_country_4;
		STRING200 rep4_watchlist_entity_name_4;
		STRING60 rep4_watchlist_table_5;
		STRING120 rep4_watchlist_program_5;
		STRING10 rep4_watchlist_record_number_5;
		STRING20 rep4_watchlist_fname_5;
		STRING20 rep4_watchlist_lname_5;
		STRING65 rep4_watchlist_address_5;
		STRING25 rep4_watchlist_city_5;
		STRING2 rep4_watchlist_state_5;
		STRING5 rep4_watchlist_zip_5;
		STRING30 rep4_watchlist_country_5;
		STRING200 rep4_watchlist_entity_name_5;
		STRING60 rep4_watchlist_table_6;
		STRING120 rep4_watchlist_program_6;
		STRING10 rep4_watchlist_record_number_6;
		STRING20 rep4_watchlist_fname_6;
		STRING20 rep4_watchlist_lname_6;
		STRING65 rep4_watchlist_address_6;
		STRING25 rep4_watchlist_city_6;
		STRING2 rep4_watchlist_state_6;
		STRING5 rep4_watchlist_zip_6;
		STRING30 rep4_watchlist_country_6;
		STRING200 rep4_watchlist_entity_name_6;
		STRING60 rep4_watchlist_table_7;
		STRING120 rep4_watchlist_program_7;
		STRING10 rep4_watchlist_record_number_7;
		STRING20 rep4_watchlist_fname_7;
		STRING20 rep4_watchlist_lname_7;
		STRING65 rep4_watchlist_address_7;
		STRING25 rep4_watchlist_city_7;
		STRING2 rep4_watchlist_state_7;
		STRING5 rep4_watchlist_zip_7;
		STRING30 rep4_watchlist_country_7;
		STRING200 rep4_watchlist_entity_name_7;
		
		// Authrep5
		STRING20 rep5_verfirst;
		STRING20 rep5_verlast;
		STRING50 rep5_veraddr;
		STRING30 rep5_vercity;
		STRING2 rep5_verstate;
		STRING5 rep5_verzip;
		STRING4 rep5_verzip4;
		STRING20 rep5_vercounty;
		STRING9 rep5_verssn;
		STRING8 rep5_verdob;
		STRING10 rep5_verhphone;
		STRING25 rep5_verdl;
		STRING1 rep5_verify_addr;
		STRING1 rep5_verify_dob;
		STRING1 rep5_valid_ssn;
		STRING3 rep5_nas_summary;
		STRING3 rep5_nap_summary;
		STRING1 rep5_nap_type;
		STRING1 rep5_nap_status;
		STRING3 rep5_cvi;
		STRING8 rep5_deceaseddate;
		STRING8 rep5_deceaseddob;
		STRING20 rep5_deceasedfirst;
		STRING20 rep5_deceasedlast;
		STRING1 rep5_dobmatchlevel;
		STRING4 rep5_hri_1;
		STRING100 rep5_hri_desc_1;
		STRING4 rep5_hri_2;
		STRING100 rep5_hri_desc_2;
		STRING4 rep5_hri_3;
		STRING100 rep5_hri_desc_3;
		STRING4 rep5_hri_4;
		STRING100 rep5_hri_desc_4;
		STRING4 rep5_hri_5;
		STRING100 rep5_hri_desc_5;
		STRING4 rep5_hri_6;
		STRING100 rep5_hri_desc_6;
		STRING4 rep5_hri_7;
		STRING100 rep5_hri_desc_7;
		STRING4 rep5_hri_8;
		STRING100 rep5_hri_desc_8;
		STRING4 rep5_hri_9;
		STRING100 rep5_hri_desc_9;
		STRING4 rep5_hri_10;
		STRING100 rep5_hri_desc_10;
		STRING4 rep5_fua_1;
		STRING150 rep5_fua_desc_1;
		STRING4 rep5_fua_2;
		STRING150 rep5_fua_desc_2;
		STRING4 rep5_fua_3;
		STRING150 rep5_fua_desc_3;
		STRING4 rep5_fua_4;
		STRING150 rep5_fua_desc_4;
		STRING20 rep5_corrected_lname;
		STRING8 rep5_corrected_dob;
		STRING10 rep5_corrected_phone;
		STRING9 rep5_corrected_ssn;
		STRING65 rep5_corrected_address;
		STRING3  rep5_area_code_split;			
		STRING8  rep5_area_code_split_date;
		STRING20 rep5_phone_fname;
		STRING20 rep5_phone_lname;
		STRING65 rep5_phone_address;
		STRING25 rep5_phone_city;
		STRING2 rep5_phone_st;
		STRING5 rep5_phone_zip;
		STRING10 rep5_name_addr_phone;
		STRING6 rep5_ssa_date_first;
		STRING6 rep5_ssa_date_last;
		STRING2 rep5_ssa_state;
		STRING20 rep5_ssa_state_name;
		STRING20 rep5_current_fname;
		STRING20 rep5_current_lname;
		STRING65 rep5_chron_Address_1;
		STRING25 rep5_chron_City_1;
		STRING2 rep5_chron_St_1;
		STRING5 rep5_chron_Zip_1;
		STRING4 rep5_chron_Zip4_1;
		STRING50 rep5_chron_phone_1;
		STRING6 rep5_chron_dt_first_seen_1;
		STRING6 rep5_chron_dt_last_seen_1;
		STRING65 rep5_chron_Address_2;
		STRING25 rep5_chron_City_2;
		STRING2 rep5_chron_St_2;
		STRING5 rep5_chron_Zip_2;
		STRING4 rep5_chron_Zip4_2;
		STRING50 rep5_chron_phone_2;
		STRING6 rep5_chron_dt_first_seen_2;
		STRING6 rep5_chron_dt_last_seen_2;
		STRING65 rep5_chron_Address_3;
		STRING25 rep5_chron_City_3;
		STRING2 rep5_chron_St_3;
		STRING5 rep5_chron_Zip_3;
		STRING4 rep5_chron_Zip4_3;
		STRING50 rep5_chron_phone_3;
		STRING6 rep5_chron_dt_first_seen_3;
		STRING6 rep5_chron_dt_last_seen_3;
		STRING20 rep5_addl_fname_1;
		STRING20 rep5_addl_lname_1;
		STRING8 rep5_addl_lname_date_last_1;
		STRING20 rep5_addl_fname_2;
		STRING20 rep5_addl_lname_2;
		STRING8 rep5_addl_lname_date_last_2;
		STRING20 rep5_addl_fname_3;
		STRING20 rep5_addl_lname_3;
		STRING8 rep5_addl_lname_date_last_3;
		BOOLEAN rep5_addressPOBox;
		BOOLEAN rep5_addressCMRA;
		STRING60 rep5_watchlist_table;
		STRING120 rep5_watchlist_program;
		STRING10 rep5_watchlist_record_number;
		STRING20 rep5_watchlist_fname;
		STRING20 rep5_watchlist_lname;
		STRING65 rep5_watchlist_address;
		STRING25 rep5_watchlist_city;
		STRING2 rep5_watchlist_state;
		STRING5 rep5_watchlist_zip;
		STRING30 rep5_watchlist_country;
		STRING200 rep5_watchlist_entity_name;
		STRING60 rep5_watchlist_table_2;
		STRING120 rep5_watchlist_program_2;
		STRING10 rep5_watchlist_record_number_2;
		STRING20 rep5_watchlist_fname_2;
		STRING20 rep5_watchlist_lname_2;
		STRING65 rep5_watchlist_address_2;
		STRING25 rep5_watchlist_city_2;
		STRING2 rep5_watchlist_state_2;
		STRING5 rep5_watchlist_zip_2;
		STRING30 rep5_watchlist_country_2;
		STRING200 rep5_watchlist_entity_name_2;
		STRING60 rep5_watchlist_table_3;
		STRING120 rep5_watchlist_program_3;
		STRING10 rep5_watchlist_record_number_3;
		STRING20 rep5_watchlist_fname_3;
		STRING20 rep5_watchlist_lname_3;
		STRING65 rep5_watchlist_address_3;
		STRING25 rep5_watchlist_city_3;
		STRING2 rep5_watchlist_state_3;
		STRING5 rep5_watchlist_zip_3;
		STRING30 rep5_watchlist_country_3;
		STRING200 rep5_watchlist_entity_name_3;
		STRING60 rep5_watchlist_table_4;
		STRING120 rep5_watchlist_program_4;
		STRING10 rep5_watchlist_record_number_4;
		STRING20 rep5_watchlist_fname_4;
		STRING20 rep5_watchlist_lname_4;
		STRING65 rep5_watchlist_address_4;
		STRING25 rep5_watchlist_city_4;
		STRING2 rep5_watchlist_state_4;
		STRING5 rep5_watchlist_zip_4;
		STRING30 rep5_watchlist_country_4;
		STRING200 rep5_watchlist_entity_name_4;
		STRING60 rep5_watchlist_table_5;
		STRING120 rep5_watchlist_program_5;
		STRING10 rep5_watchlist_record_number_5;
		STRING20 rep5_watchlist_fname_5;
		STRING20 rep5_watchlist_lname_5;
		STRING65 rep5_watchlist_address_5;
		STRING25 rep5_watchlist_city_5;
		STRING2 rep5_watchlist_state_5;
		STRING5 rep5_watchlist_zip_5;
		STRING30 rep5_watchlist_country_5;
		STRING200 rep5_watchlist_entity_name_5;
		STRING60 rep5_watchlist_table_6;
		STRING120 rep5_watchlist_program_6;
		STRING10 rep5_watchlist_record_number_6;
		STRING20 rep5_watchlist_fname_6;
		STRING20 rep5_watchlist_lname_6;
		STRING65 rep5_watchlist_address_6;
		STRING25 rep5_watchlist_city_6;
		STRING2 rep5_watchlist_state_6;
		STRING5 rep5_watchlist_zip_6;
		STRING30 rep5_watchlist_country_6;
		STRING200 rep5_watchlist_entity_name_6;
		STRING60 rep5_watchlist_table_7;
		STRING120 rep5_watchlist_program_7;
		STRING10 rep5_watchlist_record_number_7;
		STRING20 rep5_watchlist_fname_7;
		STRING20 rep5_watchlist_lname_7;
		STRING65 rep5_watchlist_address_7;
		STRING25 rep5_watchlist_city_7;
		STRING2 rep5_watchlist_state_7;
		STRING5 rep5_watchlist_zip_7;
		STRING30 rep5_watchlist_country_7;
		STRING200 rep5_watchlist_entity_name_7;		
	END;	
	
	EXPORT ConsumerInstantIDLayout := RECORD 
		risk_indicators.Layout_InstantID_NuGenPlus AND NOT [acctno];
    STRING1 Rep_WhichOne;
	END;
	
	// The following layout provides the basis for transforming into either Online/XML or Batch layouts later.
	EXPORT OutputLayout_intermediate := RECORD
		UNSIGNED3 seq;
		InputEchoLayout InputEcho;
		CleanInputLayout CleanInput;
		BestInfoLayout AND NOT [Seq,isactive,isdefunct,dt_first_seen,dt_last_seen,best_bus_county] BestEcho;
		VerifiedLayout AND NOT [Seq] VerifiedEcho;
		VerificationLayout AND NOT [Seq] Verification;
		ResidentialBusLayout AND NOT [Seq] ResidentialBus;
		FirmographicLayout AND NOT [Seq] Firmographic;
		ParentLayout AND NOT [Seq] Parent;
		BusinessByPhoneLayout AND NOT [Seq] BusinessByPhone;
		PhonesByAddressLayout AND NOT [Seq] PhonesByAddress;
		BusinessByFEINLayout AND NOT [Seq] BusinessByFEIN;
		RiskIndicatorLayout AND NOT [Seq] RiskIndicators;
		VerificationSummariesLayout AND NOT [Seq] VerificationSummaries;
		Business2ExecLayout AND NOT [Seq] Bus2Exec;
		PersonRoleLayout AND NOT [Seq] PersonRole;
		SBFEVerificationLayout AND NOT [Seq] SBFEVerification;
		OFACLayoutFlat AND NOT [Seq] OFAC;
		WatchlistLayoutFlat AND NOT [Seq] Watchlists;
		DATASET(ConsumerInstantIDLayout) ConsumerInstantID;
	END;
	
	EXPORT OutputLayout_flat := RECORD  // Verification layout
		InputEchoLayout;
		BestInfoLayout AND NOT [Seq,isactive,isdefunct,dt_first_seen,dt_last_seen,best_bus_county];
		VerifiedLayout AND NOT [Seq];
		VerificationLayout AND NOT [Seq];
		ResidentialBusLayout AND NOT [Seq];
		FirmographicLayout AND NOT [Seq];
		ParentLayout AND NOT [Seq];
		BusinessByPhoneLayout AND NOT [Seq];
		PhonesByAddressLayout AND NOT [Seq];
		BusinessByFEINLayout AND NOT [Seq];
		RiskIndicatorLayout AND NOT [Seq];
		VerificationSummariesLayout AND NOT [Seq, bvi_desc_key];
		Business2ExecLayout AND NOT [Seq];
		PersonRoleLayout AND NOT [Seq];
		SBFEVerificationLayout AND NOT [Seq];
		OFACAndWatchlistLayoutFlat AND NOT [Seq];
		ConsumerIIDFlatLayout AND NOT [Seq];
	END;	

	EXPORT OutputLayout_batch := RECORD
		BatchInputEchoLayout;
		BatchVerifiedLayout AND NOT [Seq];
		BatchVerificationLayout AND NOT [Seq];
		BatchBestInfoLayout AND NOT [Seq];
		BatchLinkIDsLayout AND NOT [Seq];
		BatchBusinessVerificationLayout;
		RiskIndicatorLayout AND NOT [Seq];
		Business2ExecLayout AND NOT [Seq];
		ResidentialBusLayout AND NOT [Seq];
		BatchVerificationSummariesLayout AND NOT [Seq];
		BusinessByPhoneLayout AND NOT [Seq, bus_phone_match_ultid_1, bus_phone_match_orgid_1, bus_phone_match_proxid_1, bus_phone_match_powid_1, bus_phone_match_ultid_2, bus_phone_match_orgid_2, bus_phone_match_proxid_2, bus_phone_match_powid_2, bus_phone_match_ultid_3, bus_phone_match_orgid_3, bus_phone_match_proxid_3, bus_phone_match_powid_3];
		PhonesByAddressLayout AND NOT [Seq];
		BusinessByFEINLayout AND NOT [Seq, bus_fein_match_ultid_1, bus_fein_match_orgid_1, bus_fein_match_proxid_1, bus_fein_match_powid_1, bus_fein_match_ultid_2, bus_fein_match_orgid_2, bus_fein_match_proxid_2, bus_fein_match_powid_2, bus_fein_match_ultid_3, bus_fein_match_orgid_3, bus_fein_match_proxid_3, bus_fein_match_powid_3];
		OFACLayoutFlat AND NOT [Seq];
		WatchlistLayoutFlat AND NOT [Seq];		
		BatchFirmographicLayout AND NOT [Seq];
		BatchPersonRoleLayout AND NOT [Seq];
		BatchParentLayout AND NOT [Seq];
		SBFEVerificationLayout AND NOT [Seq];
		ConsumerIIDFlatLayout AND NOT [Seq];
	END;
	
	EXPORT BusinessHeaderSlim := RECORD
		UNSIGNED4 seq;
		UNSIGNED2 fetch_error_code;
		UNSIGNED6 HistoryDate;
		BIPV2.IDlayouts.l_xlink_ids2;
		UNSIGNED6	rcid;
		STRING2		source;
		// Hierarchy
		BOOLEAN has_lgid;
		BOOLEAN is_sele_level;
		BOOLEAN is_org_level;
		BOOLEAN is_ult_level;
		UNSIGNED6 parent_proxid;
		UNSIGNED6 sele_proxid;
		UNSIGNED6 org_proxid;
		UNSIGNED6 ultimate_proxid;
		UNSIGNED2 levels_from_top;
		UNSIGNED3 nodes_below;
		UNSIGNED3 nodes_total;
		BOOLEAN ParentAboveSELE;
		// Company info
		STRING120	company_name;
		STRING10	prim_range;
		STRING2		predir;
		STRING28	prim_name;
		STRING4		addr_suffix;
		STRING2		postdir;
		STRING10	unit_desig;
		STRING8		sec_range;
		STRING25	p_city_name;
		STRING25	v_city_name;
		STRING2		st;
		STRING5		zip;
		STRING4		zip4;
		STRING3		fips_county;
		STRING9		company_fein;
		STRING10	company_phone;
		// Record metadata
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;	
	END;

	EXPORT VerificationTempLayout := RECORD
		UNSIGNED4 Seq;
		STRING120 CompanyName;
		STRING120 AltCompanyName;
		STRING120 StreetAddress;
		STRING25  City;
		STRING2   State;
		STRING5   Zip5;
		STRING9   FEIN;
		STRING10  Phone10;		
	END;
	
END;