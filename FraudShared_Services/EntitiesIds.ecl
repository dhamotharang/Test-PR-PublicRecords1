IMPORT BIPV2, FraudShared;

EXPORT EntitiesIds(
  DATASET(FraudShared_Services.Layouts.BatchIn_Valid_rec) ds_valid_in,
  string fraud_platform,
  boolean filterBy_entity_type
) := MODULE

  EXPORT GetLexID() := FUNCTION
    results := JOIN(
      ds_valid_in(hasPerson), FraudShared.Key_Did(fraud_platform),
      KEYED(LEFT.did = RIGHT.did),
       TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.PERSON, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetLexID');
    RETURN results;
  END;

  EXPORT GetIP() := FUNCTION
    results := JOIN(
      ds_valid_in(hasIpAddress), FraudShared.Key_Ip(fraud_platform),
      KEYED(LEFT.ip_address = RIGHT.ip_address),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.IP_ADDRESS, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetIP');
    RETURN results;
  END;

  EXPORT GetLinkIds() := FUNCTION
    fetchIn := PROJECT(ds_valid_in(hasBusiness), BIPV2.IDlayouts.l_xlink_ids);
    fetchedRecs := FraudShared.Key_Linkids_kFetch(fetchIn, fraud_platform, BIPV2.IDconstants.Fetch_Level_SELEID);
    results := JOIN(
      ds_valid_in(hasBusiness), fetchedRecs,
      BIPV2.IDmacros.mac_JoinTop3Linkids(),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.classification_entity.entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.BUSINESS, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetLinkIds');
    RETURN results;
  END;

  EXPORT GetDeviceID() := FUNCTION
    results := JOIN(
      ds_valid_in(hasDevice), FraudShared.Key_Deviceid(fraud_platform),
      KEYED(LEFT.device_id = RIGHT.device_id),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.DEVICE_ID, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetDeviceID');
    RETURN results;
  END;
   
  EXPORT GetProfessionalID() := FUNCTION
    results := JOIN(
      ds_valid_in(hasProfessionalid), FraudShared.Key_Professionalid(fraud_platform),
      KEYED(LEFT.professionalid = RIGHT.professional_id),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.LICENSED_PROFESSIONAL, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetProfessionalID');
    RETURN results;
  END;

  EXPORT GetTIN() := FUNCTION
    results := JOIN(
      ds_valid_in(hasTin), FraudShared.Key_Tin(fraud_platform),
      KEYED(LEFT.tin = RIGHT.tin),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.TIN, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetTIN');
    RETURN results;
  END;

  EXPORT GetAppendedProviderID() := FUNCTION
    results := JOIN(
      ds_valid_in(hasAppendedproviderid), FraudShared.Key_Appproviderid(fraud_platform),
      KEYED(LEFT.appendedproviderid = RIGHT.appended_provider_id),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.PROVIDER, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetAppendedProviderID');
    RETURN results;
  END;

  EXPORT GetNPI() := FUNCTION
    results := JOIN(
      ds_valid_in(hasNpi), FraudShared.Key_Npi(fraud_platform),
      KEYED(LEFT.npi = RIGHT.npi),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.PROVIDER, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetNPI');
    RETURN results;
  END;

  EXPORT GetLNPID() := FUNCTION
    results := JOIN(
      ds_valid_in(hasLnpid), FraudShared.Key_Lnpid(fraud_platform),
      KEYED(LEFT.lnpid = RIGHT.lnpid),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.PROVIDER, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetLNPID');
    RETURN results;
  END;

  EXPORT GetEmail() := FUNCTION
    results := JOIN(
      ds_valid_in(hasEmailAddress), FraudShared.Key_Email(fraud_platform),
      KEYED(LEFT.email_address = RIGHT.email_address),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.EMAIL_ADDRESS, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetEmail');
    RETURN results;
  END;
	
  EXPORT GetBankAccountNumber() := FUNCTION
    results := JOIN(
      ds_valid_in(hasBankAccount), FraudShared.Key_BankAccount(fraud_platform),
      KEYED(LEFT.bank_account_number = RIGHT.bank_account_number),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.PERSON, 
          SKIP, 
          LEFT.acctno),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_BankAccountNumber');
    RETURN results;
  END;
	
	EXPORT GetDriverLicenses() := FUNCTION
		results := JOIN(
			ds_valid_in(hasDL), FraudShared.Key_DriversLicense(fraud_platform),
			KEYED(LEFT.dl_number = RIGHT.drivers_license AND LEFT.dl_state = RIGHT.drivers_license_state),
			 TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
				SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.PERSON, 
					SKIP, 
					LEFT.acctno),
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []), 
			LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
		
		// OUTPUT(results, named('results'));
		RETURN results;
	END;	
  
END;