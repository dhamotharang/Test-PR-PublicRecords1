/*--SOAP--
<message name="ATFKeys">
</message>
*/


export ATFKeys := macro
	// output(choosen(doxie_files.key_atf_did,10));
	// output(choosen(doxie_files.key_atf_lnum,10));
	// output(choosen(doxie_files.key_atf_trad,10));
	// output(choosen(doxie_files.key_atf_records,10));
	output(choosen(ATF.key_atf_payload,10));
output(choosen(ATF.key_atf_bdid,10));
output(choosen(ATF.key_atf_did,10));
output(choosen(ATF.key_ATF_id,10));
output(choosen(ATF.key_atf_lnum,10));
// output(choosen(ATF.key_atf_records,10));
output(choosen(Autokey.Key_Address('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::atf::firearms::autokey::'),10));
//output(choosen(AutoKey.Key_Phone2('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutoKeyB2.Key_CityStName('~thor_data400::key::atf::firearms::autokey::'),10));
// output(choosen(AutoKeyB2.Key_FEIN('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutoKeyB2.key_name('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutoKeyB2.Key_NameWords('~thor_data400::key::atf::firearms::autokey::'),10));
//output(choosen(AutoKeyB2.key_phone('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutoKeyB2.Key_StName('~thor_data400::key::atf::firearms::autokey::'),10));
output(choosen(AutoKeyB2.Key_Zip('~thor_data400::key::atf::firearms::autokey::'),10));
endmacro;