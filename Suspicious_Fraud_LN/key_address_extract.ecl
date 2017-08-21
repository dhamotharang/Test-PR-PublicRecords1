import Suspicious_Fraud_LN,Data_Services,doxie ;
addr_extract := Suspicious_Fraud_LN.files.extract_addr(trim(prim_name)not in ['\'', '0']) ;
//addr_extract := project(dataset('~thor_Data400::base::suspicious_fraud_address_best',suspicious_fraud_ln.layouts.extract_address_final,flat),
// suspicious_fraud_ln.layouts.extract_address);
export key_address_extract := index(addr_extract,{prim_range,prim_name,suffix,sec_range,zip},{addr_extract},
	//Data_Services.Data_location.Prefix('NONAMEGIVEN')+
	'~thor_data400::key::suspicious_fraud::address_extract_' + doxie.Version_SuperKey);
	