IMPORT FraudShared_Services;

EXPORT fn_postautokey_joins(
  DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
  string fraud_platform = FraudShared_Services.Constants.Platform.FDN
) := FUNCTION

  ds_auto_id  := FraudShared_Services.AutoKey_IDs(ds_batch_in, fraud_platform);

  ds_ssn := JOIN(
    ds_batch_in, ds_auto_id,
    LEFT.ssn = RIGHT.ssn
      AND LEFT.SSN <> '' 
      AND RIGHT.classification_Entity.Entity_type_id = FraudShared_Services.Constants.EntityTypes_Enum.SSN,
    TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
      SELF.acctno := RIGHT.acctno,
      SELF.record_id := RIGHT.record_id,
      SELF.entity_type_id := RIGHT.classification_Entity.Entity_type_id,
      SELF.entity_sub_type_id := RIGHT.classification_Entity.entity_sub_type_id,
      SELF := LEFT),
    LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
  
  ds_address := JOIN(
    ds_batch_in, ds_auto_id, 
    LEFT.z5 = RIGHT.zip 
      AND LEFT.st = RIGHT.state 
      AND LEFT.p_city_name = RIGHT.city 
      AND LEFT.prim_range = RIGHT.clean_address.prim_range 
      AND LEFT.prim_name = RIGHT.clean_address.prim_name 
      AND RIGHT.classification_Entity.Entity_type_id = FraudShared_Services.Constants.EntityTypes_Enum.ADDRESS,
    TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
      SELF.acctno := RIGHT.acctno,
      SELF.record_id := RIGHT.record_id,
      SELF.entity_type_id := RIGHT.classification_Entity.Entity_type_id,
      SELF.entity_sub_type_id := RIGHT.classification_Entity.entity_sub_type_id,
      SELF := LEFT),
    LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
          
  ds_phone := JOIN(
    ds_batch_in, ds_auto_id,
    LEFT.phoneno = RIGHT.clean_phones.phone_number 
      AND RIGHT.clean_phones.phone_number <> '' 
      AND RIGHT.classification_Entity.Entity_type_id = FraudShared_Services.Constants.EntityTypes_Enum.PHONE,
    TRANSFORM(FraudShared_Services.Layouts.Recid_rec, 
      SELF.acctno := RIGHT.acctno,
      SELF.record_id := RIGHT.record_id,
      SELF.entity_type_id := RIGHT.classification_Entity.Entity_type_id,
      SELF.entity_sub_type_id := RIGHT.classification_Entity.entity_sub_type_id,
      SELF := LEFT),
    LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
  
  ds_auto := ds_ssn + ds_address + ds_phone;       
  
  // OUTPUT(ds_in ,NAMED('ds_in'));    
  // OUTPUT(ds_auto_id ,NAMED('ds_auto_id'));    
  // OUTPUT(ds_ssn ,NAMED('ds_ssn'));    
  // OUTPUT(ds_address ,NAMED('ds_address'));    
  // OUTPUT(ds_phone ,NAMED('ds_phone'));    

  RETURN ds_auto;  
  
END;