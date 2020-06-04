IMPORT autokey, data_services;
IMPORT $;

t  		:= $.Prepped_For_Keys;
t_fcra 	:= $.FCRA_Prepped_For_Keys;

autokey.MAC_data_wild_SSN(t,fname,mname,lname,
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

autokey.MAC_data_wild_SSN(t_fcra,fname,mname,lname,
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
						k_fcra);

export data_key_wild_ssn(integer data_category = 0) := IF (data_category = data_services.data_env.iFCRA,
															k_fcra,
															k); 
