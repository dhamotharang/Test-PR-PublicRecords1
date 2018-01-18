import doxie,data_services;
in_file := Targus.File_targus_key_building(prim_name!='' and zip!='');

export Key_Targus_fcra_Address := index(in_file,{prim_name, zip, prim_range, sec_range, predir, suffix}
						,{in_file},data_services.data_location.prefix() + 'thor_data400::key::targus::fcra::' + doxie.Version_SuperKey + '::address');