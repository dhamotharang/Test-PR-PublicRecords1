import STD,NAC;
EXPORT Build_Prepped_NAC(
	string pversion
) :=
MODULE
	

	Shared Sprayed_NAC := Files(pversion).Sprayed.NAC;

	Shared NAC_Base := NAC.Files().base;

	Shared Level_1 := [ 'NSD', 'VSD', 'NSB', 'VSB', 'NPD' ];
	Shared Level_2 := [ 'NPB', 'VPB','S', 'NDACZ', 'NDAC', 'NDAZ', 'VDACZ','VDAC','VDAZ','NBACZ','NBAC','NBAZ', 'VBACZ', 'VBAC', 'VBAZ' ];

	IdentityData := RECORD 
		string75 fn { virtual(logicalfilename) };
		Layouts.Sprayed.IdentityData;
	END;	

	

	IdentityData MapIDDT(Sprayed_NAC L) := TRANSFORM 

			searchpattern := '([0-9])\\w+';
			sw := STD.Str.SplitWords( regexfind(searchpattern, l.fn,0), '_');
			vDate := sw[1];

			SELF.Transaction_ID_Number := L.ESPTransactionId;
			SELF.Reason_for_Transaction_Activity:= 'Search in National Accuracy Clearinghouse';

			SELF.Date_of_Transaction := vDate;

			SELF.raw_Full_Name := l.SearchFullName;
			SELF.raw_First_name := l.SearchFirstName;
			SELF.raw_Middle_Name := l.SearchMiddleName;
			SELF.raw_Last_Name := l.SearchLastName;
			SELF.raw_Orig_Suffix := l.SearchSuffix;

			SELF.SSN := l.SearchSSN;
			SELF.dob := l.SearchDOB;
			SELF.Email_Address := l.ClientEmail;
			SELF.phone_number := l.ClientPhone;

			SELF.Street_1 := l.SearchAddress1StreetAddress1;
			SELF.Street_2 := l.SearchAddress1StreetAddress2;
			SELF.City := l.SearchAddress1City;
			SELF.State := l.SearchAddress1State;
			SELF.Zip := l.SearchAddress1Zip;

			SELF.Mailing_Street_1 := l.SearchAddress2StreetAddress1;
			SELF.Mailing_Street_2 := l.SearchAddress2StreetAddress2;
			SELF.Mailing_City := l.SearchAddress2City;
			SELF.Mailing_State := l.SearchAddress2State;
			SELF.Mailing_Zip := l.SearchAddress2Zip;

			SELF.Ethnicity := l.ClientEthnicity;
			SELF.Race := l.ClientRace;

			SELF.Case_ID := l.SearchCaseId;
			SELF.Client_ID := l.SearchClientId;

			SELF.source_input := 'NAC_MSH';
			SELF := L;
			SELF := [];
	END;

	bucket_1_n_2 := Sprayed_NAC(ActivityType in ['1','2']);
	EXPORT NACIDDTUpdate := Project(dedup(bucket_1_n_2,all),MapIDDT(Left));
	
	KnownFraud := RECORD 
		string75 fn { virtual(logicalfilename) };
		Layouts.Sprayed.KnownFraud;
	END;	

	KnownFraud MapKNFD(Sprayed_NAC L) := TRANSFORM 

			searchpattern := '([0-9])\\w+';
			sw := STD.Str.SplitWords( regexfind(searchpattern, l.fn,0), '_');
			vDate := sw[1];
			vTime := sw[2];

			SELF.reported_date := '';
			SELF.reported_time := '';
			SELF.customer_event_id := '';
			SELF.event_type_1 := '';

			SELF.raw_first_name		:= L.ClientFirstName;
			SELF.raw_middle_name	:= L.ClientMiddleName;
			SELF.raw_last_name		:= L.ClientLastName;

			SELF.ssn		:= L.ClientSSN;
			SELF.dob		:= L.ClientDOB;

			SELF.email_address := L.ClientEmail;
			SELF.phone_number := L.ClientPhone;

			SELF.Street_1 	:= L.CasePhysicalStreet1;
			SELF.Street_2 	:= L.CasePhysicalStreet2;
			SELF.city		:= L.CasePhysicalCity;
			SELF.state		:= L.CasePhysicalState;
			SELF.zip		:= L.CasePhysicalZip;

			SELF.mailing_Street_1	:= L.CaseMailStreet1;
			SELF.mailing_Street_2	:= L.CaseMailStreet2;
			SELF.mailing_city		:= L.CaseMailCity;
			SELF.mailing_state		:= L.CaseMailState;
			SELF.mailing_zip		:= L.CaseMailZip;

			SELF.Customer_Program := L.CaseBenefitType;

			SELF.reason_description := map(	L.matchcodes in Level_1 => 'Identity associated to NAC level 1 collision',
											L.matchcodes in Level_2 => 'Identity associated to NAC level 2 collision',
											'');

			SELF.case_id	:= L.CaseID;
			SELF.client_id	:= L.ClientID;

			SELF.source_input := 'NAC_MSH';
			SELF := L;
			SELF := [];
	END;

	KnownFraud JoinNACBase(Sprayed_NAC L, Nac_BASE R) := TRANSFORM 

			searchpattern := '([0-9])\\w+';
			sw := STD.Str.SplitWords( regexfind(searchpattern, L.fn,0), '_');
			vDate := sw[1];
			vTime := sw[2];

			SELF.reported_date := vDate;
			SELF.reported_time := vTime;

			SELF.customer_event_id := L.SequenceNumber + '_' + L.activitysource ;

			SELF.event_type_1 := map(	L.matchcodes in Level_1 => '14000',
										L.matchcodes in Level_2 => '14001',
										'');

			SELF.raw_first_name		:= R.Client_First_Name;
			SELF.raw_middle_name	:= R.Client_Middle_Name;
			SELF.raw_last_name		:= R.Client_Last_Name;

			SELF.ssn		:= R.Client_SSN;
			SELF.dob		:= R.Client_DOB;

			SELF.phone_number := R.Client_Phone;
			SELF.email_address := R.Client_Email;

			SELF.Street_1 	:= R.Case_Physical_Address_Street_1;
			SELF.Street_2 	:= R.Case_Physical_Address_Street_2;
			SELF.city		:= R.Case_Physical_Address_City;
			SELF.state		:= R.Case_Physical_Address_State;
			SELF.zip		:= R.Case_Physical_Address_Zip;

			SELF.mailing_Street_1	:= R.Case_Mailing_Address_Street_1;
			SELF.mailing_Street_2	:= R.Case_Mailing_Address_Street_2;
			SELF.mailing_city		:= R.Case_Mailing_Address_City;
			SELF.mailing_state		:= R.Case_Mailing_Address_State;
			SELF.mailing_zip		:= R.Case_Mailing_Address_Zip;

			SELF.Customer_Program := R.Case_Benefit_Type;

			SELF.reason_description := map(	L.matchcodes in Level_1 => 'Identity associated to NAC level 1 collision',
											L.matchcodes in Level_2 => 'Identity associated to NAC level 2 collision',
											'');

			SELF.case_id	:= R.Case_Identifier;
			SELF.client_id	:= R.Client_Identifier;

			SELF.source_input := 'NAC_MSH';
			SELF := L;
			SELF := [];
	END;

	bucket_4 := Sprayed_NAC(ActivityType ='4');
	dbucket_4 := dedup(bucket_4,all);

	J_NACBase := Join(bucket_4(DrupalUserState='FL') , NAC_Base(Case_State_Abbreviation='FL')
													,		trim(left.drupaluserstate)		=		trim(right.Case_State_Abbreviation)
													and 	trim(left.SearchCaseId)			=		trim(right.case_identifier)
													and 	trim(left.SearchClientId)		=		trim(right.client_identifier)
													and 	trim(left.SearchBenefitType)	=		trim(right.case_benefit_type)
													and 	trim(left.SearchBenefitMonth)	=		trim(right.case_benefit_month)
											,JoinNACBase(left, right));

	P_NacKNFD := Project(dbucket_4(DrupalUserState='FL' and caseState = 'FL'),MapKNFD(Left));
	
	EXPORT NACKNFDUpdate := dedup(J_NACBase + P_NacKNFD,all);
end;


