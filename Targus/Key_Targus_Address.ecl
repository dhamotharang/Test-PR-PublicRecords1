import doxie;
in_file := Targus.File_targus_key_building(prim_name!='' and zip!='');

export Key_Targus_Address := index(in_file,{prim_name, zip, prim_range, sec_range, predir, suffix}
						,{in_file},'~thor_data400::key::targus::' + doxie.Version_SuperKey + '::address');