import doxie;

Util_base := UtilFile.file_util_bus_base;

export Key_Bus_Address := index(Util_base(trim(prim_name)<>''),
             {prim_name,st,zip,prim_range,sec_range},
						 {Util_base},
						 '~thor_data400::key::utility::bus::address_' + doxie.Version_SuperKey);;