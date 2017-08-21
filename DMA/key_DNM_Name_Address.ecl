Import Data_Services, Doxie, ut;

export key_DNM_Name_Address := index(file_suppressionMPS, 
									{string28 l_prim_name := prim_name, 
									string10 l_prim_range := prim_range, 
									l_st := st, 
									l_city_code := doxie.Make_CityCode(p_city_name),
									l_zip := zip,
									l_sec_range := sec_range,
									l_lname := lname,
									l_fname := fname},{file_suppressionMPS},
									Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::DNM::' + Doxie.Version_SuperKey + '::name.address');