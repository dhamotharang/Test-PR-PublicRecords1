IMPORT iesp, InsuranceHeader_RemoteLinking, STD, FCRAGateway_Services;

//This module contains the various transform functions used to query the TUFraudAlert gateway.
EXPORT TuFraudAlert_Transforms := MODULE

  //This transform creates a user entry from in_mod params for picklist.
  EXPORT iesp.share.t_User in_mod_to_user(FCRAGateway_Services.IParam.common_params in_mod) := TRANSFORM
    SELF.GLBPurpose := (string)in_mod.GLBPurpose;
    SELF.DLPurpose := (string)in_mod.DPPAPurpose;
    SELF.SSNMask := in_mod.ssnmask;
    SELF.DOBMask := (string)in_mod.dobmask;
    SELF.DLMask := in_mod.dlmask;
    SELF.DataRestrictionMask := in_mod.DataRestrictionMask;
    SELF.DataPermissionMask := in_mod.DataPermissionMask;
    SELF.ApplicationType := in_mod.ApplicationType;
    SELF := [];
  END;
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
  EXPORT iesp.person_picklist.t_PersonPickListRequest input_to_picklist(
    iesp.tu_fraud_alert.t_TuFraudAlertRequest in_req, iesp.share.t_User user) := TRANSFORM
      SELF.User := user;
      SELF.SearchBy.Name.First := in_req.SearchBy.ReqSubject.SubjectName.FirstName;
      SELF.SearchBy.Name.Middle := in_req.SearchBy.ReqSubject.SubjectName.MiddleName;
      SELF.SearchBy.Name.Last := in_req.SearchBy.ReqSubject.SubjectName.LastName;
      SELF.SearchBy.Name.Prefix := in_req.SearchBy.ReqSubject.SubjectName.Prefix;
      SELF.SearchBy.Name.Suffix := in_req.SearchBy.ReqSubject.SubjectName.Generation;
      SELF.SearchBy.Address.StreetNumber := in_req.SearchBy.ReqSubject.Address.HouseNumber;
      SELF.SearchBy.Address.StreetSuffix := in_req.SearchBy.ReqSubject.Address.StreetType;
      SELF.SearchBy.Address.StreetName := in_req.SearchBy.ReqSubject.Address.StreetName;
      SELF.SearchBy.Address.UnitNumber := in_req.SearchBy.ReqSubject.Address.UnitNumber;
      SELF.SearchBy.Address.City := in_req.SearchBy.ReqSubject.Address.CityName;
      SELF.SearchBy.Address.State := in_req.SearchBy.ReqSubject.Address.StateCode;
      SELF.SearchBy.Address.Zip5 := in_req.SearchBy.ReqSubject.Address.ZipCode;
      SELF.SearchBy.SSN := in_req.SearchBy.ReqSubject.PersonalInfo.SocialSecurityNumber;
      SELF := [];
  END;

  //Transforms gateway response to picklist for lexID resolution.
  //Used to just be picklist, now it's didville, but it utilizes the picklist layout.
  EXPORT iesp.person_picklist.t_PersonPickListRequest output_to_lexId_resolution(
    iesp.tu_fraud_alert.t_TuFraudAlertResponse in_req, iesp.share.t_User user) := TRANSFORM
      name := in_req.RespSubjects[1].RespNames[1];
      address := in_req.RespSubjects[1].RespAddresses[1];
      SELF.User := user;
      SELF.SearchBy.Name.First := name.FirstName;
      SELF.SearchBy.Name.Middle := name.MiddleName;
      SELF.SearchBy.Name.Last := name.LastName;
      SELF.SearchBy.Name.Suffix := name.GenerationCode;
      SELF.SearchBy.SSN := in_req.RespSubjects[1].RespPersonalInfo.SocialSecurityNumber;
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
      dob := TRIM(in_req.RespSubjects[1].RespPersonalInfo.DateOfBirth, ALL);
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

  //Transform input and output into an RL request. SSNs must be padded with 0s if not 9 digits.
  EXPORT InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch input_output_to_remote_linking(
    iesp.tu_fraud_alert.t_TuFraudAlertRequest L, iesp.tu_fraud_alert.t_TuFraudAlertResponse R) := TRANSFORM

      //define shorthand attributes
      toUpper := STD.Str.ToUpperCase;
      inquiry_subject := L.SearchBy.ReqSubject;
      results_name := R.RespSubjects[1].RespNames[1];
      results_address := R.RespSubjects[1].RespAddresses[1];

      //There is only a batch version of remote linking service.
      //In TuFraudAlert it's a single request however.
      //Remote linking will fail if reference ID = 0, so set it to 1.
      SELF.referenceid := 1;

      //Input Data
      SELF.SSN_Inq := INTFORMAT((INTEGER)inquiry_subject.PersonalInfo.SocialSecurityNumber, 9, 1);
      SELF.SNAME_Inq := toUpper(inquiry_subject.SubjectName.Generation);
      SELF.FNAME_Inq := toUpper(inquiry_subject.SubjectName.FirstName);
      SELF.MNAME_Inq := toUpper(inquiry_subject.SubjectName.MiddleName);
      SELF.LNAME_Inq := toUpper(inquiry_subject.SubjectName.LastName);
      SELF.PRIM_NAME_Inq := toUpper(inquiry_subject.Address.StreetName);
      SELF.PRIM_RANGE_Inq := toUpper(inquiry_subject.Address.HouseNumber);
      SELF.SEC_RANGE_Inq := toUpper(inquiry_subject.Address.UnitNumber);
      SELF.CITY_Inq := toUpper(inquiry_subject.Address.CityName);
      SELF.ST_Inq := toUpper(inquiry_subject.Address.StateCode);
      SELF.ZIP_Inq := toUpper(inquiry_subject.Address.ZipCode);

      //Output Data
      SELF.SSN_Res := INTFORMAT((INTEGER)R.RespSubjects[1].RespPersonalInfo.SocialSecurityNumber, 9, 1);
      SELF.SNAME_Res := toUpper(results_name.GenerationCode);
      SELF.FNAME_Res := toUpper(results_name.FirstName);
      SELF.MNAME_Res := toUpper(results_name.MiddleName);
      SELF.LNAME_Res := toUpper(results_name.LastName);
      SELF.PRIM_NAME_Res := toUpper(results_address.StreetName);
      SELF.PRIM_RANGE_Res := toUpper(results_address.HouseNumber);
      SELF.SEC_RANGE_Res := toUpper(results_address.UnitNumber);
      SELF.CITY_Res := toUpper(results_address.CityName);
      SELF.ST_Res := toUpper(results_address.StateCode);
      SELF.ZIP_Res := toUpper(results_address.ZipCode);

      /*
      DateOfBirth can come in two formats, an estimated DOB or a real one which differ in length.
      This is supported by documentation attached to JIRA ticket RR-12334:
      CCYYMMDD Year, month, and day of birth
      CCYY-E Estimated year of birth followed
      Only work with the non-estimated DOB
      Remote Linking expects DOB in format: YYYYMMDD which is equivalent to CCYYMMDD.
      */
      dob := TRIM(R.RespSubjects[1].RespPersonalInfo.DateOfBirth, ALL);
      SELF.DOB_Res := IF(LENGTH(dob) = 8, (INTEGER)dob, 0);
      SELF := [];
  END;

END;