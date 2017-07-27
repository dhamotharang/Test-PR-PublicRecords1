/*--SOAP--
<message name="YellowPagesKeys">
</message>
*/

export YellowPagesKeys := macro
output(choosen(yellowpages.key_yellowpages_bdid,10));
//output(choosen(yellowpages.Key_YellowPages_Addr,10));
output(choosen(yellowpages.key_yellowpages_phone,10));
output(choosen(yellowpages.key_yellowpages_AutokeyPayload,10));
output(choosen(Autokey.Key_Address('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(Autokey.Key_CityStName('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(Autokey.Key_Name('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(Autokey.key_phone2('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(Autokey.Key_StName('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(Autokey.Key_Zip('~thor_data400::key::YellowPages::autokey::'),10));

output(choosen(AutokeyB2.Key_Phone('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(AutokeyB2.Key_CityStName('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(AutokeyB2.Key_Name('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(AutokeyB2.Key_NameWords('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(AutokeyB2.Key_StName('~thor_data400::key::YellowPages::autokey::'),10));
output(choosen(AutokeyB2.Key_Zip('~thor_data400::key::YellowPages::autokey::'),10));

endmacro;