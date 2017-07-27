export DNBKeys := macro
	output(choosen(dnb.Key_DNB_BDID,10));
	output(choosen(dnb.key_DNB_DunsNum,10));
	output(choosen(AutokeyB2.Key_Address('~thor_data400::key::dnb::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_CityStName('~thor_data400::key::dnb::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_Name('~thor_data400::key::dnb::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_NameWords('~thor_data400::key::dnb::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_Phone('~thor_data400::key::dnb::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_StName('~thor_data400::key::dnb::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_Zip('~thor_data400::key::dnb::autokey::qa::'),10));
output(choosen(DNB.Key_DNB_Payload,10));

endmacro;