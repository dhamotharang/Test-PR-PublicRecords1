/*--SOAP--
<message name="DeathWeekly">
</message>
*/

export Death_Weekly := MACRO

output(choosen(doxie.Key_Death_Master_Did,10));
output(choosen(Risk_Indicators.key_ssn_table,10));
output(choosen(Risk_Indicators.key_ssn_table_filtered,10));
output(choosen(death_master.key_death_id_base,10));
output(choosen(death_master.key_death_id_supplemental,10));
output(choosen(Doxie.key_death_masterV2_DID,10));
output(choosen(Death_Master.key_AutokeyPayload,10));
output(choosen(Autokey.Key_Address('~thor_data400::' + 'key::death_masterV2::autokey::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::' + 'key::death_masterV2::autokey::'),10));
output(choosen(AutoKey.key_name('~thor_data400::' + 'key::death_masterV2::autokey::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::' + 'key::death_masterV2::autokey::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::' + 'key::death_masterV2::autokey::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::' + 'key::death_masterV2::autokey::'),10));
output(choosen(Death_Master.key_dod,10));
output(choosen(Death_Master.key_dob,10));
output(choosen(Risk_Indicators.key_ssn_table_v2,10));
output(choosen(Risk_Indicators.Key_Address_Table,10));
output(choosen(Risk_Indicators.Key_ADL_Risk_Table,10));
output(choosen(Risk_Indicators.key_ssn_table_FCRA_v2,10));
output(choosen(Risk_Indicators.Key_ADL_Risk_Table_V2,10));



ENDMACRO;