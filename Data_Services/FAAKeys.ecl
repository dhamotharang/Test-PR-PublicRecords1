/*--SOAP--
<message name="FAAKeys">
</message>
*/

export FAAKeys := MACRO

output(choosen(faa.key_aircraft_did(),10));
output(choosen(faa.key_aircraft_info(),10));
output(choosen(faa.Key_Aircraft_Reg_BDID,10));
output(choosen(faa.Key_Aircraft_Reg_NNum(),10));
output(choosen(faa.key_airmen_certs,10));
output(choosen(faa.key_airmen_did,10));
output(choosen(faa.key_engine_info(),10));
output(choosen(Autokey.Key_Address('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutoKeyB2.Key_CityStName('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutoKeyB2.key_name('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutoKeyB2.Key_NameWords('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutoKeyB2.Key_StName('~thor_data400::key::faa::autokey::'),10));
output(choosen(AutoKeyB2.Key_Zip('~thor_data400::key::faa::autokey::'),10));
output(choosen(FAA.key_faa_AutoKeyPayload,10));
output(choosen(faa.key_aircraft_id(),10));
output(choosen(faa.key_airmen_rid,10));
output(choosen(faa.key_faa_airmen_Autokeypayload,10));
output(choosen(Autokey.Key_Address('~thor_data400::key::faa::airmen::autokey::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::faa::airmen::autokey::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::faa::airmen::autokey::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::key::faa::airmen::autokey::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::faa::airmen::autokey::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::faa::airmen::autokey::'),10));
output(choosen(faa.key_airmen_id,10));


ENDMACRO;