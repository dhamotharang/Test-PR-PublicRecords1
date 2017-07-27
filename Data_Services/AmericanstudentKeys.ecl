export AmericanstudentKeys := macro
	output(choosen(American_student_list.key_stu_DID,10));
//	output(choosen(American_student_list.key_stu_address,10));
	output(choosen(American_student_list.Key_ASL_Autokey_Payload,10));
	output(choosen(American_student_list.key_DID,10));
	output(choosen(Autokey.Key_Address('~thor_data400::key::american_student::autokey::qa::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::american_student::autokey::qa::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::american_student::autokey::qa::'),10));
output(choosen(AutoKey.Key_Phone2('~thor_data400::key::american_student::autokey::qa::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::key::american_student::autokey::qa::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::american_student::autokey::qa::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::american_student::autokey::qa::'),10));
	
endmacro;