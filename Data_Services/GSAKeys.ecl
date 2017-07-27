export GSAKeys := macro
output(choosen(GSA.key_gsa_AutokeyPayload,10));
output(choosen(GSA.Key_GSA_gsa_id,10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::gsa::autokey::qa::'),10));
output(choosen(Autokey.Key_Address('~thor_data400::key::gsa::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_CityStName('~thor_data400::key::gsa::autokey::qa::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::gsa::autokey::qa::'),10));
output(choosen(AutoKeyB2.key_name('~thor_data400::key::gsa::autokey::qa::'),10));
output(choosen(AutoKey.key_name('~thor_data400::key::gsa::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_NameWords('~thor_data400::key::gsa::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_StName('~thor_data400::key::gsa::autokey::qa::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::gsa::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_Zip('~thor_data400::key::gsa::autokey::qa::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::gsa::autokey::qa::'),10));
endmacro;