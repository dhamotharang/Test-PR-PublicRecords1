export LaborActionsWHDKeys := macro

output(choosen(LaborActions_WHD.key_AutokeyPayload,10));
output(choosen(LaborActions_WHD.Key_BDID,10));
output(choosen(AutoKeyb2.Key_Address('~thor_data400::key::laboractions_whd::autokey::qa::'),10));
output(choosen(AutoKeyb2.Key_CityStName('~thor_data400::key::laboractions_whd::autokey::qa::'),10));
output(choosen(AutoKeyb2.Key_Name('~thor_data400::key::laboractions_whd::autokey::qa::'),10));
output(choosen(AutoKeyb2.Key_NameWords('~thor_data400::key::laboractions_whd::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_StName('~thor_data400::key::laboractions_whd::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_Zip('~thor_data400::key::laboractions_whd::autokey::qa::'),10));

endmacro;