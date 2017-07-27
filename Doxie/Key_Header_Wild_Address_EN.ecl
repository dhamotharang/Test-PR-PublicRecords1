import header,autokey,ut;

t := header.Prepped_For_Keys;

autokey.MAC_Wild_Address_EN(t,fname,mname,lname,
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
						'~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname.en',
						k)

export Key_Header_Wild_Address_EN := k;