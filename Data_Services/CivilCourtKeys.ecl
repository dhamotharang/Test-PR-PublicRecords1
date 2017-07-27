export CivilCourtKeys := macro
output(choosen(civil_court.key_caseID,10));
output(choosen(civil_court.key_caseID_activity,10));
output(choosen(civil_court.key_caseID_matter,10));
output(choosen(civil_court.key_civilCourt_AutoKeyPayload,10));

output(choosen(Autokey.Key_Address('~thor_data400::key::civil_court::qa::autokey::'),10));
output(choosen(Autokey.Key_CityStName('~thor_data400::key::civil_court::qa::autokey::'),10));
output(choosen(Autokey.Key_Name('~thor_data400::key::civil_court::qa::autokey::'),10));
//output(choosen(Autokey.Key_Phone2('~thor_data400::key::civil_court::qa::autokey::'),10));
//output(choosen(Autokey.Key_SSN2('~thor_data400::key::civil_court::qa::autokey::'),10));
output(choosen(Autokey.Key_StName('~thor_data400::key::civil_court::qa::autokey::'),10));
output(choosen(Autokey.Key_Zip('~thor_data400::key::civil_court::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::civil_court::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_CityStName('~thor_data400::key::civil_court::qa::autokey::'),10));
//output(choosen(Autokey.Key_FEIN('~thor_data400::key::civil_court::qa::autokey::'),10));
output(choosen(AutokeyB2.key_name('~thor_data400::key::civil_court::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_NameWords('~thor_data400::key::civil_court::qa::autokey::'),10));
//output(choosen(AutokeyB2.key_phone('~thor_data400::key::civil_court::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_StName('~thor_data400::key::civil_court::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_Zip('~thor_data400::key::civil_court::qa::autokey::'),10));
endmacro;