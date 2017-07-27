import Fraudpoint3,Data_Services,doxie;

file_base_has_ssn:= fraudpoint3.file_base(SSN <> '');

export Key_ssn := 
       index(file_base_has_ssn,
             {ssn},
						 {file_base_has_ssn},
						 Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::fraudpoint3::' + doxie.Version_SuperKey + '::ssn');