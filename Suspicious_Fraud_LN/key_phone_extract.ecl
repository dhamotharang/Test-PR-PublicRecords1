import Suspicious_Fraud_LN,Data_Services,doxie, Phonesplus_v2;

phone_extract_in := Suspicious_Fraud_LN.files.extract_phone((unsigned)phone <> 0);

phone_extract_clean := project(phone_extract_in, transform(Suspicious_Fraud_LN.layouts.extract_phone,
self.phone := Phonesplus_v2.Fn_Clean_Phone10(left.phone), self := left));
phone_extract := phone_extract_clean(~(phone[1..3] = '000' or phone[4..10] = '0000000'));

export key_phone_extract := index(phone_extract,{phone},{phone_extract},
	//Data_Services.Data_location.Prefix('NONAMEGIVEN')+
	'~thor_data400::key::suspicious_fraud::phone_extract_' + doxie.Version_SuperKey);
	