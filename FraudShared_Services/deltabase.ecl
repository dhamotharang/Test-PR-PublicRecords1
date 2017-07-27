IMPORT iesp, Gateway, ut;

EXPORT deltabase(
  DATASET(FraudShared_Services.Layouts.batch_search_rec) in_recs,
  DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) key_recs,
  DATASET(iesp.frauddefensenetwork.t_FDNFileType) ds_fileTypes,
  integer1 DeltaStrict = 0
) := FUNCTION
   
  //***************************************************************************
  //* The following code will be un-commented when required field is provided.
  //***************************************************************************
  
  // dateAdded := MAX(key_recs,key_recs.classification_Permissible_use_access.date_added);
  dateAdded := '';
  checkDate := IF(dateAdded = '', FraudShared_Services.Utilities.offset3Days, dateAdded);
  today := FraudShared_Services.Utilities.TodayDate;

  fileTypeSet := FraudShared_Services.Utilities.convertToSet(ds_fileTypes);
  
  FraudShared_Services.Layouts.t_DeltaBaseSelectRequest xRead(FraudShared_Services.Layouts.batch_search_rec L) := TRANSFORM
    SELF.Select := 'SELECT * FROM delta_fdn.delta_key WHERE '
      + IF(L.did  = 0,  '', ' lexid = ' + FraudShared_Services.Utilities.dqString(TRIM((string)L.did, ALL)))
      + IF(L.ssn  = '',   '', ' ssn = ' + FraudShared_Services.Utilities.dqString(TRIM(L.ssn, ALL)))
      + IF(L.phone10  = '',   '', ' phone = ' + FraudShared_Services.Utilities.dqString(TRIM(L.phone10, ALL)))
      + ' AND date_added >= '  + FraudShared_Services.Utilities.dqString(checkDate)
      + ' AND date_added <= '  + FraudShared_Services.Utilities.dqString(today) 
      + IF(fileTypeSet = '',  '', ' AND file_Type IN ( '  + fileTypeSet  +  ' ) ')  
      + FraudShared_Services.Constants.limiter;
  END;
   
  readDeltabase := PROJECT(in_recs, xRead(LEFT));
   
  //Getting URL from ESP
  GatewayRes := Gateway.Configuration.get();
  FDNGWCfg := GatewayRes(servicename = Gateway.Constants.ServiceName.FDNDeltabase);
   
  // delta_strict : 1=fail if delta query fails, 0=do ;not fail if delta query fails, default: 0
  FraudShared_Services.Layouts.response_deltabase_layout failRead(FraudShared_Services.Layouts.t_DeltaBaseSelectRequest L) := TRANSFORM
    SELF.responsetime := IF(deltaStrict = 1, FraudShared_Services.Utilities.ErrorMeWithCode(ut.constants_MessageCodes.Deltabase_Not_Available), SKIP);
    SELF := [];
  END;

  serviceUrl := FDNGWCfg[1].url;

  IF(serviceUrl = '' AND deltaStrict = 1, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.Deltabase_Not_Available));
  
  callDelta := IF(serviceUrl  <> '', 
    SOAPCALL(
      readDeltabase,
      serviceUrl,
      'DeltaBasePreparedSql',
      FraudShared_Services.Layouts.t_DeltaBaseSelectRequest,
      Layouts.into_in(LEFT),
      DATASET(FraudShared_Services.Layouts.response_deltabase_layout),
      XPATH('DeltaBaseSelectResponse'),
      ONFAIL(failRead(LEFT)),
      RETRY(FraudShared_Services.Constants.read_retry),
      TIMEOUT(FraudShared_Services.Constants.read_timeout),
      TRIM));
  
  normFDN := CHOOSEN(NORMALIZE(callDelta,LEFT.deltaFields,TRANSFORM(RIGHT)),FraudShared_Services.Constants.maxRecs);
   
  //Mactch the layouts of Deltabase to Payload  
  FraudShared_Services.Layouts.Raw_Payload_rec xform(FraudShared_Services.Layouts.deltabase_layout L) := TRANSFORM
    //Required fields coming from deltabase
    SELF.transaction_id := L.transaction_id;
    SELF.classification_Permissible_use_access.file_type := L.file_type;
    SELF.classification_Permissible_use_access.gc_id := L.gc_id;
    SELF.classification_Permissible_use_access.date_added := L.date_added;
    SELF.Reported_Date := FraudShared_Services.Utilities.convertDate(L.date_added);
    SELF.Reported_Time := FraudShared_Services.Utilities.convertTime(L.Date_Added);
    SELF.classification_Permissible_use_access.fdn_file_info_id := L.fdn_file_info_id;
    SELF.classification_Permissible_use_access.product_include := L.product_include;
    SELF.Customer_ID := (STRING)L.company_id;
    SELF.did := L.LexID;
    SELF.phone_number := (STRING)L.phone;
    SELF.SSN := (STRING)L.SSN;
    SELF.IP_Address := (STRING)L.ip_addr;
    //Missing fields from deltabase
    SELF.classification_Permissible_use_access.primary_source_entity := 1;
    SELF.classification_source.Expectation_of_Victim_Entities := 'LOW';
    SELF.classification_source.Industry_segment := 'INS';
    SELF.classification_Activity.Suspected_Discrepancy := 'NONE';
    SELF.classification_Activity.Confidence_that_activity_was_deceitful := 'NEUTRAL';
    SELF.classification_Activity.workflow_stage_committed := 'APPLICATION';
    SELF.classification_Activity.Threat := 'UNKNOWN THREAT';
    SELF.classification_Entity.Entity_type := 'PERSON';
    SELF.classification_Entity.Role := 'UNKNOWN';
    SELF.classification_Entity.Evidence := 'DIRECT';  
    SELF := [];
  END;
 
  MapDeltaDS := PROJECT(normFDN, xform(LEFT));
   
  // OUTPUT(flag, NAMED('flag'));
  // OUTPUT(GatewayRes, NAMED('GatewayRes'));
  // OUTPUT(FDNGWCfg, NAMED('FDNGWCfg'));
  // OUTPUT(getURL, NAMED('getURL'));
  // OUTPUT(readDeltabase, NAMED('Read_Deltabase'));
  // OUTPUT(callDelta, NAMED('Call_Deltabase'));
  
  RETURN MapDeltaDS;
END;