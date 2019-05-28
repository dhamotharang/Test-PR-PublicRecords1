import autokey, header;

t := header.Prepped_For_Keys;

autokey.MAC_data_SSN(t,fname,mname,lname,
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
						'',
						k);

export data_key_ssn := k;