export EmailDataKeys := macro
	output(choosen(Email_Data.Key_Did,10));
	output(choosen(Email_Data.Key_Email_Address,10));
	output(choosen(Email_Data.Key_Payload,10));
	output(choosen(Autokey.Key_Address('~thor_200::key::email_data::autokey::qa::'),10));
	output(choosen(Autokey.Key_CityStName('~thor_200::key::email_data::autokey::qa::'),10));
	output(choosen(Autokey.Key_Name('~thor_200::key::email_data::autokey::qa::'),10));
	output(choosen(Autokey.Key_SSN2('~thor_200::key::email_data::autokey::qa::'),10));
	output(choosen(Autokey.Key_StName('~thor_200::key::email_data::autokey::qa::'),10));
	output(choosen(Autokey.Key_Zip('~thor_200::key::email_data::autokey::qa::'),10));
endmacro;