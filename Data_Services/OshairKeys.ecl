export OshairKeys := macro
	output(choosen(OSHAIR.Key_OSHAIR_accident,10));
output(choosen(OSHAIR.Key_OSHAIR_autokey_payload,10));
output(choosen(OSHAIR.Key_OSHAIR_BDID,10));
output(choosen(OSHAIR.Key_OSHAIR_hazardous_substance,10));
output(choosen(OSHAIR.Key_OSHAIR_inspection,10));
output(choosen(OSHAIR.Key_OSHAIR_optional_info,10));
output(choosen(OSHAIR.Key_OSHAIR_program,10));
output(choosen(OSHAIR.Key_OSHAIR_related_activity,10));
output(choosen(OSHAIR.Key_OSHAIR_violations,10));
output(choosen(autokeyb2.Key_Address('~thor_data400::key::oshair::qa::autokey::'),10));
output(choosen(autokeyb2.Key_CityStName('~thor_data400::key::oshair::qa::autokey::'),10));
output(choosen(autokeyb2.Key_FEIN('~thor_data400::key::oshair::qa::autokey::'),10));
output(choosen(autokeyb2.Key_Name('~thor_data400::key::oshair::qa::autokey::'),10));
output(choosen(autokeyb2.Key_NameWords('~thor_data400::key::oshair::qa::autokey::'),10));
output(choosen(autokeyb2.Key_StName('~thor_data400::key::oshair::qa::autokey::'),10));
output(choosen(autokeyb2.Key_Zip('~thor_data400::key::oshair::qa::autokey::'),10));

endmacro;
