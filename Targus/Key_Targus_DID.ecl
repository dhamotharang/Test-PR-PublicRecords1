import doxie,data_services;
in_file := Targus.File_targus_key_building(did!=0);

export Key_Targus_DID := index(in_file,{did},{in_file}
                         ,data_services.data_location.prefix() + 'thor_data400::key::targus::' + doxie.Version_SuperKey + '::did');