import autokey, header, data_services;

t := header.Prepped_For_Keys;

autokey.MAC_Wild_SSN(t,fname,mname,lname,
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
						data_services.data_location.prefix() + 'thor_data400::key::header.wild.ssn.did',
						k)

export key_header_wild_ssn := k;