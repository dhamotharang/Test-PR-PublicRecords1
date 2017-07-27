export PhonesPlusKeys := macro
		output(choosen(AutoKey.Key_Address('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::phonesplus_'),10));
output(choosen(PhonesPlus.Key_phonesplus_did,10));
output(choosen(Phonesplus.key_phonesplus_fdid,10));
output(choosen(Cellphone.key_neustar_phone,10));
output(choosen(Phonesplus.key_phonesplus_companyname,10));
endmacro;