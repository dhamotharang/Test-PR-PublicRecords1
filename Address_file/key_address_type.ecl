import doxie,ut;

import address_file,doxie;
	
export key_address_type := index(address_file.File_AddressID,
                                 {prim_range, prim_name, sec_range, city_name, st, zip, suffix, predir, postdir},
				                 {address_file.File_AddressID},
				                 ut.Data_Location.Person_header+'thor_data400::key::address::' + doxie.Version_SuperKey + '::address_type'
						        );