import Suspicious_Fraud_LN,Data_Services,doxie ;
ssn_extract := Suspicious_Fraud_LN.files.extract_SSN(length(trim(ssn, left,right)) = 9);

export key_SSN_extract := index(ssn_extract,{ssn},{ssn_extract},
	//Data_Services.Data_location.Prefix('NONAMEGIVEN')+
	'~thor_data400::key::suspicious_fraud::ssn_extract_' + doxie.Version_SuperKey);
	