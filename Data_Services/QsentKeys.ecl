export QsentKeys := macro
output(choosen(AutoKey.Key_Address('~thor_data400::key::qsent_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::qsent_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::qsent_'),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::qsent_'),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::qsent_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::qsent_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::qsent_'),10));
output(choosen(Phonesplus.key_qsent_did,10));
output(choosen(Phonesplus.key_qsent_fdid,10));
output(choosen(Phonesplus.key_qsent_companyname,10));
endmacro;