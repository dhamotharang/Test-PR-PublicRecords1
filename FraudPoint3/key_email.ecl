import Fraudpoint3,Data_Services,doxie;

file_base_has_email := fraudpoint3.file_base(Email_Address <> '');

export Key_email := 
       index(file_base_has_email,
             {Email_Address},
						 {file_base_has_email},
						 Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::fraudpoint3::' + doxie.Version_SuperKey + '::email');