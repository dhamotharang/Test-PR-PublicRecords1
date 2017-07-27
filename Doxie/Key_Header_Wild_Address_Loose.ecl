import header,autokey,ut;

t := header.Prepped_For_Keys;

autokey.MAC_Wild_Address_Loose(t,fname,mname,lname,
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
						 '~thor_data400::key::header.wild.lname.fname.st.city.z5.pname.prange.sec_range',
						 k)

export Key_Header_Wild_Address_Loose := k;