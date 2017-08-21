
EXPORT Functions := MODULE

  EXPORT SetSequences(
    DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in
  ) := FUNCTION
    // Coded that if a person bothered to put the seq/acctno numbers in, 
    // we should keep them because they probably may care about them

    FraudShared_Services.Layouts.BatchIn_rec xfm_SetSequence(FraudShared_Services.Layouts.BatchIn_rec L, integer C) := TRANSFORM
      unsigned4 temp := IF(L.seq = 0, C, L.seq);
      SELF.seq := temp;
      SELF.acctno := IF(L.acctno = '', (string)temp, L.acctno);
      SELF := L;
    END;
  
    RETURN PROJECT(ds_batch_in, xfm_SetSequence(LEFT, COUNTER));
  END;

  EXPORT string25 EntityTypeEnumDisplayString(unsigned2 enum_value) := FUNCTION
  
    RETURN CASE(enum_value,
      FraudShared_Services.Constants.EntityTypes_Enum.IP_ADDRESS => FraudShared_Services.Constants.Entity_Types.IP_ADDRESS,
      FraudShared_Services.Constants.EntityTypes_Enum.BUSINESS => FraudShared_Services.Constants.Entity_Types.BUSINESS,
      FraudShared_Services.Constants.EntityTypes_Enum.ADDRESS => FraudShared_Services.Constants.Entity_Types.ADDRESS,
      FraudShared_Services.Constants.EntityTypes_Enum.SSN => FraudShared_Services.Constants.Entity_Types.SSN,
      FraudShared_Services.Constants.EntityTypes_Enum.PHONE => FraudShared_Services.Constants.Entity_Types.PHONE,
      FraudShared_Services.Constants.EntityTypes_Enum.DEVICE_ID => FraudShared_Services.Constants.Entity_Types.DEVICE_ID,
      FraudShared_Services.Constants.EntityTypes_Enum.CONTACT_NUMBER => 'CONTACT_NUMBER',   // no mapping for FraudShared_Services.Constants.EntityTypes.CONTACT_NUMBER,
      FraudShared_Services.Constants.EntityTypes_Enum.LICENSED_PROFESSIONAL => FraudShared_Services.Constants.Entity_Types.LICENSED_PROFESSIONAL,
      FraudShared_Services.Constants.EntityTypes_Enum.PERSON => FraudShared_Services.Constants.Entity_Types.PERSON,
      FraudShared_Services.Constants.EntityTypes_Enum.TIN => FraudShared_Services.Constants.Entity_Types.TIN,
      FraudShared_Services.Constants.EntityTypes_Enum.PROVIDER => FraudShared_Services.Constants.Entity_Types.APPENDED_PROVIDER,   /*diff tag*/
      FraudShared_Services.Constants.EntityTypes_Enum.EMAIL_ADDRESS => FraudShared_Services.Constants.Entity_Types.EMAIL_ADDRESS,
      'NOT MAPPED');
  END;

END;