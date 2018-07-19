IMPORT iesp, FCRAGateway_Services;

//This module contains the various transform functions used to query the TUFraudAlert gateway.
EXPORT TuFraudAlert_Transforms := MODULE

	//This transform sets default values for the request for easier testing on the roxie layer.
	EXPORT iesp.tu_fraud_alert.t_TuFraudAlertRequest set_request_defaults(iesp.tu_fraud_alert.t_TuFraudAlertRequest L) := TRANSFORM
		SELF.SearchBy.TransactionControl.RecordCode := 'TU4I';
		SELF.SearchBy.TransactionControl.Version := '1';
		SELF.SearchBy.TransactionControl.CountryCode := '1';
		SELF.SearchBy.TransactionControl.LanguageIndicator := '1';
		SELF.SearchBy.TransactionControl.IndustryCode := 'Z';
		SELF.SearchBy.TransactionControl.ContractualIndicator := '1';
		SELF.SearchBy.TransactionControl.PointOfSaleIndicator := 'N';
		SELF.SearchBy.EndUsage.RecordCode := 'EU01';
		SELF.SearchBy.CustomerData.RecordCode := 'CD01';
		SELF.SearchBy.CustomerData.CustomerIdentityQualifier := '5';
		SELF.SearchBy.ReqSubject.SubjectHeader.RecordCode := 'SH01';
		SELF.SearchBy.ReqSubject.SubjectHeader.SubjectIdentifier := '1';
		SELF.SearchBy.ReqSubject.SubjectName.RecordCode := 'NM11';
		SELF.SearchBy.ReqSubject.SubjectName.NameType := '1';

		//Set record code and name type for every row in AliasNames
		SELF.SearchBy.ReqSubject.AliasNames := PROJECT(L.SearchBy.ReqSubject.AliasNames,
			TRANSFORM(iesp.tu_fraud_alert.t_TUName_41,
				SELF.RecordCode := 'NM11',
				SELF.NameType := '3',
				SELF := LEFT,
				SELF := []
				));

		SELF.SearchBy.ReqSubject.PersonalInfo.RecordCode := 'PI11';
		SELF.SearchBy.ReqSubject.Address.RecordCode := 'AD11';
		SELF.SearchBy.ReqSubject.PhoneNumber.RecordCode := 'PN01';
		SELF.SearchBy.ReqServiceStructure.RequestService.RecordCode := 'RP01';
		SELF.SearchBy.ReqServiceStructure.RequestService.ServiceCode := '07770';
		SELF.SearchBy.ReqServiceStructure.RequestService.BundleDefaultIndicator := 'N';
		SELF.SearchBy.ReqServiceStructure.OptionalRequest.RecordCode := 'OR01';
		SELF.SearchBy.ReqServiceStructure.OptionalRequest.OwningBureauIdOfCreditFile := 'W';
		SELF.SearchBy.ReqServiceStructure.OptionalRequest.ErrorTextSegRequest := 'T';
		SELF.SearchBy.ReqServiceStructure.AddOnService.RecordCode := 'RA01';
		SELF.SearchBy.TransactionEnding.RecordCode := 'END1';
		SELF.SearchBy.TransactionEnding.TotalNumberOfSegments := '00010';
		SELF := L;
	END;


	//Transforms input request to a picklist request.
	EXPORT iesp.person_picklist.t_PersonPickListRequest input_to_picklist(iesp.tu_fraud_alert.t_TuFraudAlertRequest L) := TRANSFORM
		SELF.SearchBy.Name.First := L.SearchBy.ReqSubject.SubjectName.FirstName;
		SELF.SearchBy.Name.Middle := L.SearchBy.ReqSubject.SubjectName.MiddleName;
		SELF.SearchBy.Name.Last := L.SearchBy.ReqSubject.SubjectName.LastName;
		SELF.SearchBy.Name.Prefix := L.SearchBy.ReqSubject.SubjectName.Prefix;
		SELF.SearchBy.Name.Suffix := L.SearchBy.ReqSubject.SubjectName.Generation;
		SELF.SearchBy.Address.StreetNumber := L.SearchBy.ReqSubject.Address.HouseNumber;
		SELF.SearchBy.Address.StreetSuffix := L.SearchBy.ReqSubject.Address.StreetType;
		SELF.SearchBy.Address.StreetName := L.SearchBy.ReqSubject.Address.StreetName;
		SELF.SearchBy.Address.UnitNumber := L.SearchBy.ReqSubject.Address.UnitNumber;
		SELF.SearchBy.Address.City := L.SearchBy.ReqSubject.Address.CityName;
		SELF.SearchBy.Address.State := L.SearchBy.ReqSubject.Address.StateCode;
		SELF.SearchBy.Address.Zip5 := L.SearchBy.ReqSubject.Address.ZipCode;
		SELF.SearchBy.SSN := L.SearchBy.ReqSubject.PersonalInfo.SocialSecurityNumber;
		SELF := [];
	END;

	//Transforms gateway response to picklist request.
	EXPORT iesp.person_picklist.t_PersonPickListRequest output_to_picklist(iesp.tu_fraud_alert.t_TuFraudAlertResponse L) := TRANSFORM
		name := L.RespSubjects[1].RespNames[1];
		address := L.RespSubjects[1].RespAddresses[1];
		SELF.SearchBy.Name.First := name.FirstName;
		SELF.SearchBy.Name.Middle := name.MiddleName;
		SELF.SearchBy.Name.Last := name.LastName;
		SELF.SearchBy.Name.Suffix := name.GenerationCode;
		SELF.SearchBy.SSN := L.RespSubjects[1].RespPersonalInfo.SocialSecurityNumber;
		SELF.SearchBy.Address.StreetNumber := address.HouseNumber;
		SELF.SearchBy.Address.StreetName := address.StreetName;
		SELF.SearchBy.Address.StreetSuffix := address.StreetType;
		SELF.SearchBy.Address.UnitNumber := address.UnitNumber;
		SELF.SearchBy.Address.City := address.CityName;
		SELF.SearchBy.Address.State := address.StateCode;
		SELF.SearchBy.Address.Zip5 := address.ZipCode;
		/*
		DateOfBirth can come in two formats, an estimated DOB or a real one which differ in length.
		This is supported by documentation attached to JIRA ticket RR-12334:
		CCYYMMDD Year, month, and day of birth
		CCYY-E Estimated year of birth followed
		Only work with the non-estimated DOB
		*/
		dob := TRIM(L.RespSubjects[1].RespPersonalInfo.DateOfBirth, ALL);
		SELF.SearchBy.DOB := IF(LENGTH(dob) = 8, iesp.ECL2ESP.toDatestring8(dob));

		SELF := [];
	END;

	//This adds the query transactionID and queryID to the header while keeping the response message, status, and exceptions.
	EXPORT iesp.tu_fraud_alert.t_TuFraudAlertResponse
		add_service_header(iesp.tu_fraud_alert.t_TuFraudAlertResponse L) := TRANSFORM
			SELF._header := PROJECT(iesp.ECL2ESP.GetHeaderRow(), TRANSFORM(iesp.share.t_ResponseHeader,
				SELF.status := L._header.status,
				SELF.message := L._header.message,
				SELF.exceptions := L._header.exceptions,
				SELF := LEFT));
			SELF := L;
	END;

END;