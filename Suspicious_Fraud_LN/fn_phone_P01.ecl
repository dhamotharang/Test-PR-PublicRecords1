EXPORT fn_phone_P01 := 'todo';

key_phonesplus := dedup(sort(distribute(Phonesplus_v2.Key_Phonesplus_Did((unsigned)cellphone > 0 and append_phone_type = 'PAGE' ), hash(cellphone)),
cellphone, local), cellphone, local);

key_phone := distribute(Risk_Indicators.Key_Phone_Table_v2, hash(phone10));

temp_rec := record
key_phone;
integer hriskphoneflag;
integer hphonetypeflag;
end;

key_phone_type := project(key_phone, transform(temp_rec,

self.hriskphoneflag := 
						risk_indicators.PRIIPhoneRiskFlag(left.phone10).phoneRiskFlag(left.nxx_type, left.pot_Disconnect, left.sic_code),
	
self.hphonetypeflag := 
						risk_indicators.PRIIPhoneRiskFlag(left.phone10).PWphoneRiskFlag(left.nxx_type, left.sic_code),
						
						self := left));


output(key_phone_type);
					