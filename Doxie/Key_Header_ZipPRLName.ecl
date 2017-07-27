import autokey,header,ut;
d := header.Prepped_For_Keys;

autokey.MAC_zipPRLname(d,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,city_name,zip,sec_range,
						states,
						lname1,lname2,lname3,
						city1,city2,city3,
						rel_fname1,rel_fname2,rel_fname3,
						lookups,
						did,
						//ut.foreign_prod +'thor_data400::key::header.ZipPRLName',
						'~thor_data400::key::header.ZipPRLName',
						k)

export Key_Header_ZipPRLName := k;