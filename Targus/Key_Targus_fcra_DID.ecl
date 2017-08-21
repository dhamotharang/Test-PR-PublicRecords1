import doxie;

in_file := Targus.File_targus_key_building(did!=0);

export Key_Targus_fcra_DID := index(in_file,{did},{in_file}
                         ,'~thor_data400::key::targus::fcra::' + doxie.Version_SuperKey + '::did');