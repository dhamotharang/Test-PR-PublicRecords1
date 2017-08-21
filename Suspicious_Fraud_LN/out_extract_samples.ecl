export out_extract_samples := sequential(

output(enth(Suspicious_Fraud_LN.files.extract_SSN,500),named('extract_SSN_Samples')),
output(enth(Suspicious_Fraud_LN.files.extract_addr,500),named('extract_address_Samples')),
output(enth(Suspicious_Fraud_LN.files.extract_phone,500),named('extract_phone_Samples')));


