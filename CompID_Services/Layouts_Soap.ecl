EXPORT Layouts_Soap := MODULE

	/* Standard Inquiry/Order Layout */
	EXPORT Layout_Order := RECORD
		STRING6 Seq;
		STRING6 Order_Type;
		STRING3 Score;
		STRING28 LastName;
		STRING20 FirstName;
		STRING15 MiddleName;
		STRING6 NameSuffix;
		STRING8 DateOfBirth;
		STRING6 Gender;
		STRING9 SSN;
		
		STRING8 DateOfDeath;

		STRING25 DLNumber;
		STRING9  DLState;
		STRING1  LicenceClass;
		STRING10 LicenceType;
		STRING15 LicenceRest;
		STRING8  LicenceIssueDate;
		STRING8  LicenceExpDate;
		
		STRING9 PrimRange;
		STRING20 Addr1;
		STRING5 SecRange;
		STRING20 City;
		STRING5 State;
		STRING5 Zip;
		STRING4 CurrZip4;

		STRING9 Prior1PrimRange;
		STRING20 Prior1Addr;
		STRING5 Prior1Unit;
		STRING20 Prior1City;
		STRING5 Prior1State;
		STRING5 Prior1Zip;
		STRING4 Prior1Zip4;

		STRING9 Prior2PrimRange;
		STRING20 Prior2Addr;
		STRING5 Prior2Unit;
		STRING20 Prior2City;
		STRING5 Prior2State;
		STRING5 Prior2Zip;
		STRING4 Prior2Zip4;

		STRING9 Prior3PrimRange;
		STRING20 Prior3Addr;
		STRING5 Prior3Unit;
		STRING20 Prior3City;
		STRING5 Prior3State;
		STRING5 Prior3Zip;
		STRING4 Prior3Zip4;

	END;

	/* Result Layout of the SOAP call */
	EXPORT Layout_Result_Soap := RECORD
		UNSIGNED6  Seq{XPATH('seq')};
		STRING6  Output_Type{XPATH('score')};
		STRING3  Score{XPATH('score')};
		
		// Name
		STRING28 LastName{XPATH('name_last')};
		STRING20 FirstName{XPATH('name_first')};
		STRING15 MiddleName{XPATH('name_middle')};
		STRING6  Suffix{XPATH('name_suffix')};
		
		STRING8  DOB{XPATH('dob')};
		STRING6  Gender{XPATH('gender')};
		STRING9  SSN{XPATH('ssn')};

		// Licence
		STRING25 LicenceNo{XPATH('currentdl/dl_number')};
		STRING9  LicenceSt{XPATH('currentdl/dlstate')};
		STRING1  LicenceClass{XPATH('currentdl/license_class')};
		STRING10 LicenceType{XPATH('currentdl/license_type')};
		STRING15 LicenceRest{XPATH('currentdl/restrictions')};
		STRING8  LicenceIssueDate{XPATH('currentdl/lic_issue_date')};
		STRING8  LicenceExpDate{XPATH('currentdl/expiration_date')};

		// Current Address
		STRING9  CurrPrimRange{XPATH('currentaddress/prim_range')};
		STRING20 CurrAddr{XPATH('currentaddress/addr')};
		STRING5  CurrUnit{XPATH('currentaddress/unit')};
		STRING20 CurrCity{XPATH('currentaddress/city')};
		STRING5  CurrSt{XPATH('currentaddress/state')};
		STRING5  CurrZip{XPATH('currentaddress/zip')};
		STRING4  CurrZip4{XPATH('currentaddress/zip4')};
		STRING8  CurrFirstSeenDate{XPATH('currentaddress/dt_first_seen')};
		STRING8  CurrLastSeenDate{XPATH('currentaddress/dt_max_seen')};
		
		// Prior Address 1
		STRING9  Prior1PrimRange{XPATH('prioraddress1/prim_range')};
		STRING20 Prior1Addr{XPATH('prioraddress1/addr')};
		STRING5  Prior1Unit{XPATH('prioraddress1/unit')};
		STRING20 Prior1City{XPATH('prioraddress1/city')};
		STRING5  Prior1St{XPATH('prioraddress1/state')};
		STRING5  Prior1Zip{XPATH('prioraddress1/zip')};
		STRING4  Prior1Zip4{XPATH('prioraddress1/zip4')};
		STRING8  Prior1FirstSeenDate{XPATH('prioraddress1/dt_first_seen')};
		STRING8  Prior1LastSeenDate{XPATH('prioraddress1/dt_max_seen')};
		
		// Prior Address 2
		STRING9  Prior2PrimRange{XPATH('prioraddress2/prim_range')};
		STRING20 Prior2Addr{XPATH('prioraddress2/addr')};
		STRING5  Prior2Unit{XPATH('prioraddress2/unit')};
		STRING20 Prior2City{XPATH('prioraddress2/city')};
		STRING5  Prior2St{XPATH('prioraddress2/state')};
		STRING5  Prior2Zip{XPATH('prioraddress2/zip')};
		STRING4  Prior2Zip4{XPATH('prioraddress2/zip4')};
		STRING8  Prior2FirstSeenDate{XPATH('prioraddress2/dt_first_seen')};
		STRING8  Prior2LastSeenDate{XPATH('prioraddress2/dt_max_seen')};
		
		// Prior Address 3
		STRING9  Prior3PrimRange{XPATH('prioraddress3/prim_range')};
		STRING20 Prior3Addr{XPATH('prioraddress3/addr')};
		STRING5  Prior3Unit{XPATH('prioraddress3/unit')};
		STRING20 Prior3City{XPATH('prioraddress3/city')};
		STRING5  Prior3St{XPATH('prioraddress3/state')};
		STRING5  Prior3Zip{XPATH('prioraddress3/zip')};
		STRING4  Prior3Zip4{XPATH('prioraddress3/zip4')};
		STRING8  Prior3FirstSeenDate{XPATH('prioraddress3/dt_first_seen')};
		STRING8  Prior3LastSeenDate{XPATH('prioraddress3/dt_max_seen')};
		
		STRING8  DOD{XPATH('dod')};
		//STRING6  DID{XPATH('did')};

		//UNSIGNED4 Latency{XPATH('_call_latency')};
		
		STRING1 ResType{XPATH('restype')};
		STRING60 Remarks{XPATH('remarks')};
	END;
	
	/* Standard Result Layout */
	EXPORT Layout_Result := RECORD
		STRING6  Seq;
		STRING1  Comma1 := ',';
		STRING6  Output_Type := 'LNREST';
		STRING1  Comma2 := ',';
		STRING3  Score;
		STRING1  Comma2_1 := ',';
		
		// Name
		STRING28 LastName{XPATH('name_last')};
		STRING1  Comma3 := ',';
		STRING20 FirstName{XPATH('name_first')};
		STRING1  Comma4 := ',';
		STRING15 MiddleName{XPATH('name_middle')};
		STRING1  Comma5 := ',';
		STRING6  Suffix{XPATH('name_suffix')};
		STRING1  Comma6 := ',';
		
		STRING8  DOB{XPATH('dob')};
		STRING1  Comma7 := ',';
		STRING6  Gender{XPATH('gender')};
		STRING1  Comma8 := ',';
		STRING9  SSN{XPATH('ssn')};
		STRING1  Comma9 := ',';

		// DOD
		STRING8  DOD{XPATH('dod')};
		STRING1  Comma40 := ',';

		// Licence
		STRING25 LicenceNo{XPATH('currentdl/dl_number')};
		STRING1  Comma10 := ',';
		STRING9  LicenceSt{XPATH('currentdl/dlstate')};
		STRING1  Comma11 := ',';
		STRING1  LicenceClass{XPATH('currentdl/license_class')};
		STRING1  Comma111 := ',';
		STRING10 LicenceType{XPATH('currentdl/license_type')};
		STRING1  Comma112 := ',';
		STRING15 LicenceRest{XPATH('currentdl/restrictions')};
		STRING1  Comma113 := ',';
		STRING8  LicenceIssueDate{XPATH('currentdl/lic_issue_date')};
		STRING1  Comma114 := ',';
		STRING8  LicenceExpDate{XPATH('currentdl/expiration_date')};
		STRING1  Comma115 := ',';

		// Current Address
		STRING9  CurrPrimRange{XPATH('currentaddress/prim_range')};
		STRING1  Comma12 := ',';
		STRING20 CurrAddr{XPATH('currentaddress/addr')};
		STRING1  Comma13 := ',';
		STRING5  CurrUnit{XPATH('currentaddress/unit')};
		STRING1  Comma14 := ',';
		STRING20 CurrCity{XPATH('currentaddress/city')};
		STRING1  Comma15 := ',';
		STRING5  CurrSt{XPATH('currentaddress/state')};
		STRING1  Comma16 := ',';
		STRING5  CurrZip{XPATH('currentaddress/zip')};
		STRING1  Comma17 := ',';
		STRING4  CurrZip4{XPATH('currentaddress/zip4')};
		STRING1  Comma18 := ',';
		STRING8  CurrFirstSeenDate{XPATH('currentaddress/dt_first_seen')};
		STRING1  Comma181 := ',';
		STRING8  CurrLastSeenDate{XPATH('currentaddress/dt_max_seen')};
		STRING1  Comma182 := ',';
		
		// Prior Address 1
		STRING9  Prior1PrimRange{XPATH('prioraddress1/prim_range')};
		STRING1  Comma19 := ',';
		STRING20 Prior1Addr{XPATH('prioraddress1/addr')};
		STRING1  Comma20 := ',';
		STRING5  Prior1Unit{XPATH('prioraddress1/unit')};
		STRING1  Comma21 := ',';
		STRING20 Prior1City{XPATH('prioraddress1/city')};
		STRING1  Comma22 := ',';
		STRING5  Prior1St{XPATH('prioraddress1/state')};
		STRING1  Comma23 := ',';
		STRING5  Prior1Zip{XPATH('prioraddress1/zip')};
		STRING1  Comma24 := ',';
		STRING4  Prior1Zip4{XPATH('prioraddress1/zip4')};
		STRING1  Comma25 := ',';
		STRING8  Prior1FirstSeenDate{XPATH('prioraddress1/dt_first_seen')};
		STRING1  Comma251 := ',';
		STRING8  Prior1LastSeenDate{XPATH('prioraddress1/dt_max_seen')};
		STRING1  Comma252 := ',';
		
		// Prior Address 2
		STRING9  Prior2PrimRange{XPATH('prioraddress2/prim_range')};
		STRING1  Comma26 := ',';
		STRING20 Prior2Addr{XPATH('prioraddress2/addr')};
		STRING1  Comma27 := ',';
		STRING5  Prior2Unit{XPATH('prioraddress2/unit')};
		STRING1  Comma28 := ',';
		STRING20 Prior2City{XPATH('prioraddress2/city')};
		STRING1  Comma29 := ',';
		STRING5  Prior2St{XPATH('prioraddress2/state')};
		STRING1  Comma30 := ',';
		STRING5  Prior2Zip{XPATH('prioraddress2/zip')};
		STRING1  Comma31 := ',';
		STRING4  Prior2Zip4{XPATH('prioraddress2/zip4')};
		STRING1  Comma32 := ',';
		STRING8  Prior2FirstSeenDate{XPATH('prioraddress2/dt_first_seen')};
		STRING1  Comma321 := ',';
		STRING8  Prior2LastSeenDate{XPATH('prioraddress2/dt_max_seen')};
		STRING1  Comma322 := ',';
		
		// Prior Address 3
		STRING9  Prior3PrimRange{XPATH('prioraddress3/prim_range')};
		STRING1  Comma33 := ',';
		STRING20 Prior3Addr{XPATH('prioraddress3/addr')};
		STRING1  Comma34 := ',';
		STRING5  Prior3Unit{XPATH('prioraddress3/unit')};
		STRING1  Comma35 := ',';
		STRING20 Prior3City{XPATH('prioraddress3/city')};
		STRING1  Comma36 := ',';
		STRING5  Prior3St{XPATH('prioraddress3/state')};
		STRING1  Comma37 := ',';
		STRING5  Prior3Zip{XPATH('prioraddress3/zip')};
		STRING1  Comma38 := ',';
		STRING4  Prior3Zip4{XPATH('prioraddress3/zip4')};
		STRING1  Comma39 := ',';
		STRING8  Prior3FirstSeenDate{XPATH('prioraddress3/dt_first_seen')};
		STRING1  Comma391 := ',';
		STRING8  Prior3LastSeenDate{XPATH('prioraddress3/dt_max_seen')};
		STRING1  Comma392 := ',';
		
		// Remarks & ResType
		STRING1  ResType{XPATH('restype')};
		STRING1  Comma41 := ',';
		STRING70  Remarks{XPATH('remarks')};
		STRING1  Comma42 := ',';
		STRING2 CRLF := '\r\n';

	END;

	/* SSN Inquiry/Order Layout */
	EXPORT Layout_Order_SSN := RECORD
		STRING6 Seq;
		STRING9 SSN;
	END;
	
	/* DLN Inquiry/Order Layout */
	EXPORT Layout_Order_DLN := RECORD
		STRING6  Seq;
		STRING25 DLN;
		STRING9  DLNState;
	END;
	
END;