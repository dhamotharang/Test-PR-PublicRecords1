import Fraudpoint3,Data_Services, doxie;

file_base_has_phone := fraudpoint3.file_base(phone_number <> '');

export Key_phone := 
       index(file_base_has_phone,
             {phone_number},
						 {file_base_has_phone},
						 Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::fraudpoint3::' + doxie.Version_SuperKey + '::phone');