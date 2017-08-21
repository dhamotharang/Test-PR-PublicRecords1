EXPORT files := module

export extract_SSN := dataset('~thor_Data400::base::suspicious_fraud_SSN', Suspicious_Fraud_LN.layouts.extract_SSN, flat);
export extract_addr := dataset('~thor_Data400::base::suspicious_fraud_address', Suspicious_Fraud_LN.layouts.extract_address, flat);
export extract_name := dataset('~thor_Data400::base::suspicious_fraud_name', Suspicious_Fraud_LN.layouts.extract_name, flat);
export extract_email := dataset('~thor_Data400::base::suspicious_fraud_email', Suspicious_Fraud_LN.layouts.extract_email, flat);
export extract_IPaddr := dataset('~thor_Data400::base::suspicious_fraud_IPaddr', Suspicious_Fraud_LN.layouts.extract_IPaddress, flat);
export extract_phone := dataset('~thor_Data400::base::suspicious_fraud_phone', Suspicious_Fraud_LN.layouts.extract_phone, flat);


end;