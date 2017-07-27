/*--SOAP--
<message name="EmergesMonthly">
</message>
*/

export EmergesKeys := Macro

output(choosen(doxie_files.key_hunters_did,10));
output(choosen(doxie_files.key_ccw_did,10));
output(choosen(eMerges.Key_HuntFish_Did,10));
output(choosen(eMerges.Key_HuntFish_Rid,10));
output(choosen(eMerges.key_huntfish_payload,10));
output(choosen(Autokey.Key_Address('~thor_data400::key::hunting_fishing::qa::autokey::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::hunting_fishing::qa::autokey::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::hunting_fishing::qa::autokey::'),10));
//output(choosen(AutoKey.Key_Phone2('~thor_data400::key::hunting_fishing::qa::autokey::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::hunting_fishing::qa::autokey::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::hunting_fishing::qa::autokey::'),10));
output(choosen(AutoKey.Key_ssn2('~thor_data400::key::hunting_fishing::qa::autokey::'),10));
// output(choosen(doxie_files.key_voters_did,10));
output(choosen(emerges.key_ccw_did,10));
output(choosen(emerges.key_ccw_rid,10));
output(choosen(emerges.key_ccw_payload,10));
output(choosen(Autokey.Key_Address('~thor_data400::key::ccw::qa::autokey::'),10));
output(choosen(Autokey.Key_CityStName('~thor_data400::key::ccw::qa::autokey::'),10));
output(choosen(Autokey.Key_Name('~thor_data400::key::ccw::qa::autokey::'),10));
output(choosen(Autokey.Key_SSN2('~thor_data400::key::ccw::qa::autokey::'),10));
output(choosen(Autokey.Key_StName('~thor_data400::key::ccw::qa::autokey::'),10));
output(choosen(Autokey.Key_Zip('~thor_data400::key::ccw::qa::autokey::'),10));

endmacro;