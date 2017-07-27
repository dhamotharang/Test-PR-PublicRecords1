export VotersV2Keys := macro
	output(choosen(votersv2.Key_Voters_DID,10));
output(choosen(votersv2.Key_Voters_VTID,10));
output(choosen(votersv2.Key_Voters_History_VTID,10));
output(choosen(Autokey.Key_Address('~thor_data400::key::voters::autokey::qa::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::voters::autokey::qa::'),10));
output(choosen(AutoKey.key_name('~thor_data400::key::voters::autokey::qa::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::voters::autokey::qa::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::voters::autokey::qa::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::key::voters::autokey::qa::'),10));
output(choosen(AutoKey.Key_phone2('~thor_data400::key::voters::autokey::qa::'),10));
output(choosen(votersv2.Key_Voters_AutoKeyPayload,10));

endmacro;