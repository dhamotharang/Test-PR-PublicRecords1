import doxie,data_services;
in_file := Targus.File_targus_key_building(phone_number!='');

export Key_Targus_fcra_Phone := index(in_file,{p7:= phone_number[4..10],p3 := phone_number[1..3],st},
						{in_file},data_services.data_location.prefix() + 'thor_data400::key::targus::fcra::' + doxie.Version_SuperKey + '::p7.p3.st');