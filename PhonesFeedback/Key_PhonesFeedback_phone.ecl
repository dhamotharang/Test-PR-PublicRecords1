Import Data_Services, doxie, data_services;

base := PhonesFeedback.File_PhonesFeedback_base;
 
key_base := base(phone_number <> '0' and phone_number <> ' ');				   

export Key_PhonesFeedback_phone := index(key_base,
										  {phone_number},
										  {key_base},
										  data_services.foreign_prod + 'thor_data400::key::phonesFeedback::'+doxie.Version_SuperKey+'::phone');