export Corp2Keys := macro
output(choosen(corp2.Key_AR_Bdid,10));
output(choosen(corp2.Key_AR_Corpkey,10));
output(choosen(corp2.Key_Cont_Corpkey,10));
output(choosen(corp2.Key_Cont_Bdid,10));
output(choosen(corp2.Key_cont_did,10));
output(choosen(corp2.Key_Cont_NameAddr,10));
output(choosen(corp2.Key_Corp_Bdid,10));
output(choosen(corp2.Key_Corp_BdidPL,10));
output(choosen(corp2.Key_Corp_Corpkey,10));
output(choosen(corp2.Key_Corp_NameAddr,10));

output(choosen(corp2.Key_Corp_StCharter,10));
output(choosen(corp2.Key_Event_Bdid,10));
output(choosen(corp2.Key_Event_Corpkey,10));
output(choosen(corp2.Key_Stock_Bdid,10));
output(choosen(corp2.Key_Stock_Corpkey,10));

output(choosen(corp2.Key_Corp2_AutoKeyPayload,10));

output(choosen(AutoKey.Key_Address('~thor_data400::key::corp2::qa::autokey::'),10));
//output(choosen(AutoKeyb.Key_Address('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::corp2::qa::autokey::'),10));
//output(choosen(AutoKeyb.Key_CityStName('~thor_data400::key::corp2::qa::autokey::'),10));
//output(choosen(AutoKeyb.Key_FEIN('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::corp2::qa::autokey::'),10));
//output(choosen(AutoKeyb.Key_Name('~thor_data400::key::corp2::qa::autokey::'),10));
//output(choosen(AutoKeyb.Key_NameWords('~thor_data400::key::corp2::qa::autokey::'),10));
//output(choosen(AutoKey.Key_Phone('~thor_data400::key::corp2::qa::autokey::'),10));
//output(choosen(AutoKeyb.Key_Phone('~thor_data400::key::corp2::qa::autokey::'),10));
//output(choosen(AutoKey.Key_SSN('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::corp2::qa::autokey::'),10));
//output(choosen(AutoKeyb.Key_StName('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::corp2::qa::autokey::'),10));
//output(choosen(AutoKeyb.Key_Zip('~thor_data400::key::corp2::qa::autokey::'),10));

output(choosen(AutokeyB2.Key_Address('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutoKey.key_phone2('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_CityStName('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_Name('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_NameWords('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_Phone('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_FEIN('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_StName('~thor_data400::key::corp2::qa::autokey::'),10));
output(choosen(AutokeyB2.Key_Zip('~thor_data400::key::corp2::qa::autokey::'),10));
/*output(choosen(text_search.File_Boolean_dstat('corp2'),10));
	output(choosen(text_search.File_Boolean_SegList('corp2'),10));
	output(choosen(text_search.Key_Boolean_dictindx('corp2'),10));
	output(choosen(Corp2.Key_Boolean_Map,10));*/

endmacro;