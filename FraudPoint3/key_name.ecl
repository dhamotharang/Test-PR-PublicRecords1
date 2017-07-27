import Fraudpoint3,Data_Services, doxie;

file_base_has_name := fraudpoint3.file_base(fname <> '' and lname <> '');

export Key_name := INDEX(file_base_has_name, {lname,fname,mname}, {file_base_has_name},
					Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::fraudpoint3::' + doxie.Version_SuperKey + '::name');