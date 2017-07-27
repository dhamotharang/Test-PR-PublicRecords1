export CalbusKeys := macro
output(choosen(CALBUS.Key_Calbus_Account_Nbr,10));
output(choosen(CALBUS.Key_Calbus_BDID,10));
output(choosen(CALBUS.Key_Calbus_Payload,10));
output(choosen(autokeyb2.key_address('~thor_data400::key::calbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_citystname('~thor_data400::key::calbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_name('~thor_data400::key::calbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_zip('~thor_data400::key::calbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_stname('~thor_data400::key::calbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_namewords('~thor_data400::key::calbus::autokey::qa::'),10));
output(choosen(autokey.key_address('~thor_data400::key::calbus::autokey::qa::'),10));
output(choosen(autokey.key_citystname('~thor_data400::key::calbus::autokey::qa::'),10));
output(choosen(autokey.key_name('~thor_data400::key::calbus::autokey::qa::'),10));
output(choosen(autokey.key_zip('~thor_data400::key::calbus::autokey::qa::'),10));
output(choosen(autokey.key_stname('~thor_data400::key::calbus::autokey::qa::'),10));

endmacro;