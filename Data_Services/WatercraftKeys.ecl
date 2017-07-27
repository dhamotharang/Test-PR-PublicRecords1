import watercraftv2_services;

export WatercraftKeys := macro
output(choosen(doxie.key_watercraft_cid,10));
output(choosen(doxie.key_watercraft_bdid,10));
output(choosen(doxie.key_watercraft_did,10));
output(choosen(doxie.key_watercraft_sid,10));
output(choosen(doxie.key_watercraft_wid,10));
output(choosen(doxie.key_watercraft_hullnum,10));
output(choosen(doxie.key_watercraft_offnum,10));
output(choosen(doxie.key_watercraft_vslnam,10));

output(choosen(Autokey.Key_Address('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKey.Key_Phone2('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKeyB2.Key_CityStName('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKeyB2.Key_FEIN('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKeyB2.key_name('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKeyB2.Key_NameWords('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKeyB2.key_phone('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKeyB2.Key_StName('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(AutoKeyB2.Key_Zip('~thor_data400::key::watercraft::autokey::'),10));
output(choosen(WatercraftV2_Services.key_watercraft_autokeyPayload,10));




endmacro;