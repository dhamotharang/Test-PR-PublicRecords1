import Doxie, ut;

export key_DNM_Name_Address := index(file_suppressionMPS, 
									{string28 l_prim_name := ut.StripOrdinal(prim_name), 
									string10 l_prim_range := TRIM(ut.CleanPrimRange(prim_range),LEFT), 
									l_st := st, 
									l_city_code := doxie.Make_CityCode(p_city_name),
									l_zip := zip,
									l_sec_range := sec_range,
									l_lname := lname,
									l_fname := fname},{file_suppressionMPS},
									'~thor_data400::key::DNM::' + Doxie.Version_SuperKey + '::name.address');