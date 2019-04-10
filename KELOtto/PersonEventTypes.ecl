import KELOtto;

EventTypeRec := RECORD
  KELOtto.fraudgovshared.SourceCustomerFileInfo;
  KELOtto.fraudgovshared.AssociatedCustomerFileInfo;
  STRING PrimaryRange;
  STRING Predirectional;
  STRING PrimaryName; 
  STRING Suffix;
  STRING Postdirectional; 
  STRING Zip;
  STRING SecondaryRange; 
  UNSIGNED LexId;
  KELOtto.fraudgovshared.record_id;
  STRING event_type;
END;

EventTypeRec NormIt(KELOtto.fraudgovshared L, INTEGER C) := TRANSFORM
  SELF.SourceCustomerFileInfo := L.SourceCustomerFileInfo,
  SELF.AssociatedCustomerFileInfo := L.AssociatedCustomerFileInfo,
  SELF.PrimaryRange := L.clean_address.prim_range,
  SELF.Predirectional := L.clean_address.predir,
  SELF.PrimaryName := L.clean_address.prim_name,
  SELF.Suffix := L.clean_address.addr_suffix,
  SELF.Postdirectional := L.clean_address.postdir,
  SELF.Zip := L.clean_address.zip,
  SELF.SecondaryRange := L.clean_address.sec_range,
  SELF.LexID := L.did,
  SELF.event_type := TRIM(CHOOSE(C, L.event_type_1,L.event_type_2,L.event_type_3,L.name_risk_code,L.dob_risk_code,L.identity_risk_code,L.mailing_address_risk_code,L.physical_address_risk_code,L.ssn_risk_code,L.phone_risk_code,L.cell_phone_risk_code,L.email_address_risk_code,L.ip_address_fraud_code,L.drivers_license_risk_code,L.bank_account_1_risk_code,L.bank_account_2_risk_code)),
   
  SELF := L;
END;
  
EXPORT PersonEventTypes := NORMALIZE(KELOtto.fraudgovshared(
                       event_type_1 != '' OR event_type_2 != '' OR event_type_3 != '' OR name_risk_code != '' OR dob_risk_code != '' OR identity_risk_code != '' OR mailing_address_risk_code != '' OR physical_address_risk_code != '' OR ssn_risk_code != '' OR phone_risk_code != '' OR cell_phone_risk_code != '' OR email_address_risk_code != '' OR ip_address_fraud_code != '' OR drivers_license_risk_code != '' OR bank_account_1_risk_code != '' OR bank_account_2_risk_code != ''
                       ),16,NormIt(LEFT,COUNTER))(event_type != '');
