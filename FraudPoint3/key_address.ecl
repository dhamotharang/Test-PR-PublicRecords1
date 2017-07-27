import Fraudpoint3,Data_Services, doxie;

file_base_has_address := fraudpoint3.file_base(prim_name  <> '' and zip <> '');

export Key_Address := INDEX(file_base_has_address, {zip,prim_name,prim_range,sec_range}, {file_base_has_address},
						Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::fraudpoint3::' + doxie.Version_SuperKey + '::address');