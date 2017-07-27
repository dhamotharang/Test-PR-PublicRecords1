export Layout_RedFlags := record
// Input Fields

string20 dataset_name;
string30 acctNo;
string20 fname;
string20 lname;
string5 zipCode;
string9 ssn;
string10 phone10;
string12 outtransaction_id;

// Red Flags Fields
string2 address_discrepancy_rc1;
string100 address_discrepancy_desc1;
string2 address_discrepancy_rc2;
string100 address_discrepancy_desc2;
string2 address_discrepancy_rc3;
string100 address_discrepancy_desc3;
string2 address_discrepancy_rc4;
string100 address_discrepancy_desc4;

//string1 suspicious_documents;
string2 suspicious_documents_rc1;
string100 suspicious_documents_desc1;
string2 suspicious_documents_rc2;
string100 suspicious_documents_desc2;
string2 suspicious_documents_rc3;
string100 suspicious_documents_desc3;
string2 suspicious_documents_rc4;
string100 suspicious_documents_desc4;

// string1 suspicious_address;
string2 suspicious_address_rc1;
string100 suspicious_address_desc1;
string2 suspicious_address_rc2;
string100 suspicious_address_desc2;
string2 suspicious_address_rc3;
string100 suspicious_address_desc3;
string2 suspicious_address_rc4;
string100 suspicious_address_desc4;

// string1 suspicious_ssn;
string2 suspicious_ssn_rc1;
string100 suspicious_ssn_desc1;
string2 suspicious_ssn_rc2;
string100 suspicious_ssn_desc2;
string2 suspicious_ssn_rc3;
string100 suspicious_ssn_desc3;
string2 suspicious_ssn_rc4;
string100 suspicious_ssn_desc4;

// string1 suspicious_dob;
string2 suspicious_dob_rc1;
string100 suspicious_dob_desc1;
string2 suspicious_dob_rc2;
string100 suspicious_dob_desc2;
string2 suspicious_dob_rc3;
string100 suspicious_dob_desc3;
string2 suspicious_dob_rc4;
string100 suspicious_dob_desc4;

// string1 high_risk_address;
string2 high_risk_address_rc1;
string100 high_risk_address_desc1;
string2 high_risk_address_rc2;
string100 high_risk_address_desc2;
string2 high_risk_address_rc3;
string100 high_risk_address_desc3;
string2 high_risk_address_rc4;
string100 high_risk_address_desc4;

// string1 suspicious_phone;
string2 suspicious_phone_rc1;
string100 suspicious_phone_desc1;
string2 suspicious_phone_rc2;
string100 suspicious_phone_desc2;
string2 suspicious_phone_rc3;
string100 suspicious_phone_desc3;
string2 suspicious_phone_rc4;
string100 suspicious_phone_desc4;

// string1 ssn_multiple_last;
string2 ssn_multiple_last_rc1;
string100 ssn_multiple_last_desc1;
string2 ssn_multiple_last_rc2;
string100 ssn_multiple_last_desc2;
string2 ssn_multiple_last_rc3;
string100 ssn_multiple_last_desc3;
string2 ssn_multiple_last_rc4;
string100 ssn_multiple_last_desc4;

// string1 missing_input;
string2 missing_input_rc1;
string100 missing_input_desc1;
string2 missing_input_rc2;
string100 missing_input_desc2;
string2 missing_input_rc3;
string100 missing_input_desc3;
string2 missing_input_rc4;
string100 missing_input_desc4;

// string1 fraud_alert;
string2 fraud_alert_rc1;
string100 fraud_alert_desc1;
string2 fraud_alert_rc2;
string100 fraud_alert_desc2;
string2 fraud_alert_rc3;
string100 fraud_alert_desc3;
string2 fraud_alert_rc4;
string100 fraud_alert_desc4;

// string1 credit_freeze;
string2 credit_freeze_rc1;
string100 credit_freeze_desc1;
string2 credit_freeze_rc2;
string100 credit_freeze_desc2;
string2 credit_freeze_rc3;
string100 credit_freeze_desc3;
string2 credit_freeze_rc4;
string100 credit_freeze_desc4;

// string1 identity_theft;
string2 identity_theft_rc1;
string100 identity_theft_desc1;
string2 identity_theft_rc2;
string100 identity_theft_desc2;
string2 identity_theft_rc3;
string100 identity_theft_desc3;
string2 identity_theft_rc4;
string100 identity_theft_desc4;

end;