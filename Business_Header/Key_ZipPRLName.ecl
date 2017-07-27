import autokey,header,ut,doxie_cbrs;
d := Business_Header.File_Business_Header_Base_for_keybuild;

ds := 
	project(d, 
		transform(
			{d, /*string1 zeros, integer1 zeroi,*/ UNSIGNED4 lookups1},
			self := left,
			self := [],
		)
	);

autokey.MAC_zipPRLname(ds,fname,mname,company_name,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,city_name,zip,sec_range,
						states,
						lname1,lname2,lname3,
						city1,city2,city3,
						rel_fname1,rel_fname2,rel_fname3,
						lookups1,
						bdid,
						'~thor_data400::key::business_header.ZipPRLName',
						k)

export Key_ZipPRLName := k;