IMPORT FraudShared, BIPV2;

EXPORT EntitiesIds(
  string fraud_platform = FraudShared.Constants().Platform.FDN,
  boolean filterBy_entity_type = TRUE
) := MODULE

	EXPORT GetLexID(
    DATASET(FraudShared_Services.Layouts.batch_search_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_rec)
  ) := FUNCTION
		results := JOIN(
      ds_in, FraudShared.Key_Did(fraud_platform),
			KEYED(LEFT.did = RIGHT.did),
 			TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.PERSON, 
          SKIP, 
          (string)LEFT.seq),
				SELF := RIGHT,
        SELF := LEFT,
				SELF := []),
			LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetLexID');
    RETURN results;
	END;

	EXPORT GetIP(
    DATASET(FraudShared_Services.Layouts.batch_search_flags_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_flags_rec)
  ) := FUNCTION
		results := JOIN(
      ds_in, FraudShared.Key_Ip(fraud_platform),
      KEYED(LEFT.ipaddress = RIGHT.ip_address),
      TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.IP_ADDRESS, 
          SKIP, 
          (string)LEFT.seq),
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []),
      LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetIP');
    RETURN results;
	END;

	EXPORT GetLinkIds(
    DATASET(FraudShared_Services.Layouts.batch_search_flags_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_flags_rec)
  ) := FUNCTION
    fetchIn := PROJECT(ds_in, BIPV2.IDlayouts.l_xlink_ids);
		fetchedRecs := FraudShared.Key_Linkids_kFetch(fetchIn, fraud_platform, BIPV2.IDconstants.Fetch_Level_SELEID);
		results := JOIN(
      ds_in, fetchedRecs,
			BIPV2.IDmacros.mac_JoinTop3Linkids(),
			TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.classification_entity.entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.BUSINESS, 
          SKIP, 
          (string)LEFT.seq),
				SELF := RIGHT,
        SELF := LEFT,
				SELF := []),
			LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetLinkIds');
    RETURN results;
	END;

	EXPORT GetDeviceID(
    DATASET(FraudShared_Services.Layouts.batch_search_flags_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_flags_rec)
  ) := FUNCTION
		results := JOIN(
      ds_in, FraudShared.Key_Deviceid(fraud_platform),
			KEYED(LEFT.deviceid = RIGHT.device_id),
			TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.DEVICE_ID, 
          SKIP, 
          (string)LEFT.seq),
				SELF := RIGHT,
        SELF := LEFT,
				SELF := []),
			LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetDeviceID');
    RETURN results;
	END;
   
	EXPORT GetProfessionalID(
    DATASET(FraudShared_Services.Layouts.batch_search_flags_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_flags_rec)
  ) := FUNCTION
		results := JOIN(
      ds_in, FraudShared.Key_Professionalid(fraud_platform),
			KEYED(LEFT.professionalid = RIGHT.professional_id),
			TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.LICENSED_PROFESSIONAL, 
          SKIP, 
          (string)LEFT.seq),
				SELF := RIGHT,
        SELF := LEFT,
				SELF := []),
			LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetProfessionalID');
    RETURN results;
	END;

	EXPORT GetTIN(
    DATASET(FraudShared_Services.Layouts.batch_search_flags_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_flags_rec)
  ) := FUNCTION
		results := JOIN(
      ds_in, FraudShared.Key_Tin(fraud_platform),
			KEYED(LEFT.tin = RIGHT.tin),
			TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.TIN, 
          SKIP, 
          (string)LEFT.seq),
				SELF := RIGHT,
        SELF := LEFT,
				SELF := []),
			LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetTIN');
    RETURN results;
	END;

	EXPORT GetAppendedProviderID(
    DATASET(FraudShared_Services.Layouts.batch_search_flags_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_flags_rec)
  ) := FUNCTION
		results := JOIN(
      ds_in, FraudShared.Key_Appproviderid(fraud_platform),
			KEYED(LEFT.appendedproviderid = RIGHT.appended_provider_id),
			TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.PROVIDER, 
          SKIP, 
          (string)LEFT.seq),
				SELF := RIGHT,
        SELF := LEFT,
				SELF := []),
			LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetAppendedProviderID');
    RETURN results;
	END;

	EXPORT GetNPI(
    DATASET(FraudShared_Services.Layouts.batch_search_flags_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_flags_rec)
  ) := FUNCTION
		results := JOIN(
      ds_in, FraudShared.Key_Npi(fraud_platform),
			KEYED(LEFT.npi = RIGHT.npi),
			TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.PROVIDER, 
          SKIP, 
          (string)LEFT.seq),
        SELF := RIGHT,
        SELF := LEFT,
				SELF := []),
			LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetNPI');
    RETURN results;
	END;

	EXPORT GetLNPID(
    DATASET(FraudShared_Services.Layouts.batch_search_flags_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_flags_rec)
  ) := FUNCTION
		results := JOIN(
      ds_in, FraudShared.Key_Lnpid(fraud_platform),
			KEYED(LEFT.lnpid = RIGHT.lnpid),
			TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.PROVIDER, 
          SKIP, 
          (string)LEFT.seq),
				SELF := RIGHT,
        SELF := LEFT,
				SELF := []),
			LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetLNPID');
    RETURN results;
	END;

	EXPORT GetEmail(
    DATASET(FraudShared_Services.Layouts.batch_search_flags_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_flags_rec)
  ) := FUNCTION
		results := JOIN(
      ds_in, FraudShared.Key_Email(fraud_platform),
      KEYED(LEFT.emailaddress = RIGHT.email_address),
			TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
        SELF.acctno := IF(filterBy_entity_type AND RIGHT.Entity_type_id <> FraudShared_Services.Constants.EntityTypes_Enum.EMAIL_ADDRESS, 
          SKIP, 
          (string)LEFT.seq),
				SELF := RIGHT,
        SELF := LEFT,
				SELF := []),
			LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, 'EntityIds_GetEmail');
    RETURN results;
	END;
  
END;