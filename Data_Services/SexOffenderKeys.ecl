/*--SOAP--
<message name="SexOffenderKeys">
</message>
*/

export SexOffenderKeys := macro
output(choosen(AutoKey.Key_Address('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Address('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(sexoffender.Key_SexOffender_DID(),10));
output(choosen(sexoffender.Key_SexOffender_SPK_Enh(),10));
output(choosen(sexoffender.key_sexoffender_offenses(),10));
output(choosen(sexoffender.Key_SexOffender_SPK(),10));
output(choosen(sexoffender.Key_SexOffender_fdid,10));
output(choosen(sexoffender.key_sexoffender_zip_type,10));
output(choosen(SexOffender.Key_SexOffender_Payload,10));
output(choosen(AutoKey.Key_Address('~thor_data400::key::sexoffender::autokey::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::sexoffender::autokey::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::sexoffender::autokey::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::key::sexoffender::autokey::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::sexoffender::autokey::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::sexoffender::autokey::'),10));
output(choosen(sexoffender.Key_Latlong,10));

endmacro;