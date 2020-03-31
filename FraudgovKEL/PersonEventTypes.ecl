import FraudgovKEL;

EventTypeRec := RECORD
  FraudgovKEL.fraudgovshared.SourceCustomerFileInfo;
  FraudgovKEL.fraudgovshared.AssociatedCustomerFileInfo;
  UNSIGNED8 OttoAddressId;
	STRING PhoneNumber;
	UNSIGNED8 OttoIpAddressId;
	UNSIGNED8 OttoEmailId;
	UNSIGNED8 OttoSSNId;
  UNSIGNED8 OttoBankAccountId;
	UNSIGNED8 OttoBankAccountId2;
	UNSIGNED8 OttoDriversLicenseId;
  UNSIGNED LexId;
  FraudgovKEL.fraudgovshared.record_id;
  STRING event_type;	
END;

EventTypeRec NormIt(FraudgovKEL.fraudgovshared L, INTEGER C) := TRANSFORM
  SELF.SourceCustomerFileInfo := L.SourceCustomerFileInfo,
  SELF.AssociatedCustomerFileInfo := L.AssociatedCustomerFileInfo,
  SELF.OttoAddressId := L.OttoAddressId,
  SELF.LexID := L.did,
	SELF.PhoneNumber := TRIM(L.clean_phones.phone_number),
	SELF.OttoEmailId := L.OttoEmailId,
	SELF.OttoSSNId := L.OttoSSNId,
  SELF.OttoBankAccountId := L.OttoBankAccountId,
	SELF.OttoBankAccountId2 := L.OttoBankAccountId2,
	SELF.OttoDriversLicenseId := L.OttoDriversLicenseId,
  SELF.event_type := TRIM(CHOOSE(C, L.event_type_1,L.event_type_2,L.event_type_3,L.name_risk_code,L.dob_risk_code,L.identity_risk_code,L.mailing_address_risk_code,L.physical_address_risk_code,L.ssn_risk_code,L.phone_risk_code,L.cell_phone_risk_code,L.email_address_risk_code,L.ip_address_fraud_code,L.drivers_license_risk_code,L.bank_account_1_risk_code,L.bank_account_2_risk_code)),
  SELF := L;
END;
  
EXPORT PersonEventTypes := NORMALIZE(FraudgovKEL.fraudgovshared(
                       event_type_1 != '' OR event_type_2 != '' OR event_type_3 != '' OR name_risk_code != '' OR dob_risk_code != '' OR identity_risk_code != '' OR mailing_address_risk_code != '' OR physical_address_risk_code != '' OR ssn_risk_code != '' OR phone_risk_code != '' OR cell_phone_risk_code != '' OR email_address_risk_code != '' OR ip_address_fraud_code != '' OR drivers_license_risk_code != '' OR bank_account_1_risk_code != '' OR bank_account_2_risk_code != ''
                       ),16,NormIt(LEFT,COUNTER))(event_type != '');
