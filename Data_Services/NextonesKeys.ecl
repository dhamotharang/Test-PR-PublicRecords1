/*--SOAP--
<message name="NextonesKeys">
</message>
*/

export NextonesKeys := macro
	output(choosen(doxie_files.key_nextones_did,10));
	output(choosen(doxie_files.key_nextones_fdid,10));
	output(choosen(AutoKey.Key_Address('~thor_data400::key::nextones_'),10));
	output(choosen(AutoKey.Key_CityStName('~thor_data400::key::nextones_'),10));
	output(choosen(AutoKey.Key_Name('~thor_data400::key::nextones_'),10));
	output(choosen(AutoKey.Key_Phone('~thor_data400::key::nextones_'),10));
	output(choosen(AutoKey.Key_SSN('~thor_data400::key::nextones_'),10));
	output(choosen(AutoKey.Key_StName('~thor_data400::key::nextones_'),10));
	output(choosen(AutoKey.Key_Zip('~thor_data400::key::nextones_'),10));
endmacro;