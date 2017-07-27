export TxbusKeys := macro
	output(choosen(TXBUS.Key_Txbus_BDID,10));
output(choosen(TXBUS.Key_Txbus_DID,10));
output(choosen(TXBUS.Key_Txbus_Taxpayer_Nbr,10));
output(choosen(TXBUS.Key_Txbus_Payload,10));
output(choosen(autokeyb2.key_address('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_citystname('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_name('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_zip('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_stname('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_namewords('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokeyb2.key_phone('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokey.key_address('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokey.key_citystname('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokey.key_name('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokey.key_zip('~thor_data400::key::txbus::autokey::qa::'),10));
output(choosen(autokey.key_stname('~thor_data400::key::txbus::autokey::qa::'),10));
//output(choosen(autokeyb2.key_fein('~thor_data400::key::txbus::autokey::qa::'),10));
//output(choosen(autokey.key_phone2('~thor_data400::key::txbus::autokey::qa::'),10));
//output(choosen(autokey.key_ssn2('~thor_data400::key::txbus::autokey::qa::'),10));


endmacro;