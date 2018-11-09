Import BIPV2;
EXPORT Layouts := MODULE
	Shared MaxLengthVal := 10000000;
	EXPORT IdentityInput := RECORD
		string20  acctno := '';
		string30 	APSTransactionID := '';
		string30 	EnrollmentId := '';
		string20	FirstName := '';
		string20	LastName := '';
		string8 	DoB := '';
		string9 	SSN :='';
		string10  NPI	:= '';
		string60  StreetAddress1 := '';
		string60  StreetAddress2 := '';
		string25  City := '';
		string2   State := '';
		string5   Zip5 := '';
		string4   Zip4 := '';
		string80  LegalName := '';
		string50	BusinessName := '';
		string11  TaxID:='';
	END;
	
	EXPORT WarningsOutput := RECORD
		string3 	Code := '';
		string10	Source := '';
	END;

	EXPORT gapInput := RECORD
		string20  acctno := '';
		unsigned6 	LNPID := 0;//Smallest SrcID within the group
		BIPV2.IDlayouts.l_xlink_ids bipkeys;
		String Enterprise_num := '';
		string150	Url := '';
		string48  Email := '';
		string255 Description := '';
		string20	BusinessType := '';
		unsigned2	StartYear := '';
		unsigned4	TotalEmployees := '';
		string20 	Sales	:= '';
		string4 	SicCode := '';
		string255	SicDesc := '';
		unsigned4 dt_last_seen := '';
		WarningsOutput;
	END;
	

	EXPORT IdentityOutput := RECORD
		string20	acctno := '';
		unsigned6	lnpid := 0;
		string30 	APSTransactionID := '';
		string30 	TransactionId := '';
		string20	UniqueId	:= '';
		string30 	EnrollmentId := '';
		string5		NamePrefix := '';
		string20	FirstName := '';
		string20	MiddleName := '';
		string50	LastName := '';
		string5 	NameSuffix := '';
		string1		Gender := '';
		String8		dob :='';
		String8		dod :='';
		string9 	SSN :='';
		string11 	TaxId:='';
		string48  Email := '';
		string10	PhoneNumber := '';
		string30 	RawPhoneNumber := '';
		string60  StreetAddress1 := '';
		string60  StreetAddress2 := '';
		string25  City := '';
		string2   State := '';
		string5   Zip5 := '';
		string4   Zip4 := '';
		string10 	NPI	:= '';
		string12 	BusinessId := '';
		string50	BusinessName := '';
		string80	LegalName := '';
		string80  DoingBusinessAs	:= '';
		string10	FaxNumber := '';
		string150	Url := '';
		string255 Description := '';
		string20	BusinessType := '';
		unsigned2	StartYear := 0;
		unsigned4	TotalEmployees := 0;
		string20 	Sales	:= '';
		string4 	SicCode := '';
		string255	SicDesc := '';
		dataset(WarningsOutput) Warnings := dataset([],WarningsOutput);
	END;
END;