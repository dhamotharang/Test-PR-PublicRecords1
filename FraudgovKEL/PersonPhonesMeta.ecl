IMPORT FraudgovKEL, FraudGovPlatform,doxie,Suppress;

/*
RECORD
  string10 phone;
  string8 reported_date;
  unsigned8 vendor_first_reported_dt;
  unsigned8 vendor_last_reported_dt;
  string2 prepaid;
  unsigned8 record_id;
  unsigned6 fdn_file_info_id;
 END;
*/
EXPORT PersonPhonesMeta := Fraudgovplatform.Files().base.PrepaidPhone.built;;