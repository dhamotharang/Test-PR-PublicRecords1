export NppesKeys := macro

output(choosen(NPPES.Key_NPPES_npi,10));
output(choosen(NPPES.Key_NPPES_Payload,10));
output(choosen(Autokey.Key_Address('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKey.Key_Phone2('~thor_data400::key::nppes::autokey::qa::'),10));
// output(choosen(AutoKey.Key_SSN2('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_CityStName('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_Phone('~thor_data400::key::nppes::autokey::qa::'),10));
// output(choosen(AutoKeyB2.Key_FEIN('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKeyB2.key_name('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_NameWords('~thor_data400::key::nppes::autokey::qa::'),10));
// output(choosen(AutoKeyB2.key_phone('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_StName('~thor_data400::key::nppes::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_Zip('~thor_data400::key::nppes::autokey::qa::'),10));

endmacro;