export PhonesPlusV2Keys := macro
Output(choosen(Phonesplus_v2.Key_Phonesplus_Companyname,10));
output(choosen(Phonesplus_v2.Key_Phonesplus_Did,10));
output(choosen(Phonesplus_v2.Key_Phonesplus_Fdid,10));
output(choosen(Phonesplus_v2.Key_Royalty_Companyname,10)); 
output(choosen(Phonesplus_v2.Key_Royalty_Did,10)); 
output(choosen(Phonesplus_v2.Key_Royalty_Fdid,10)); 

output(choosen(Autokey.Key_Address('~thor_data400::key::phonesplusv2_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::phonesplusv2_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::phonesplusv2_'),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::phonesplusv2_'),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::phonesplusv2_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::phonesplusv2_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::phonesplusv2_'),10));

output(choosen(Autokey.Key_Address('~thor_data400::key::phonesplusv2_royalty_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::phonesplusv2_royalty_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::phonesplusv2_royalty_'),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::phonesplusv2_royalty_'),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::phonesplusv2_royalty_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::phonesplusv2_royalty_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::phonesplusv2_royalty_'),10));
endmacro;

