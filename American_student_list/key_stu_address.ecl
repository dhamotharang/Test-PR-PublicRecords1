import American_student_list, Doxie, ut, data_services;

file_in := American_student_list.File_american_student_DID_PH_Suppressed;

export key_stu_address := index(file_in, 
                                {string28 l_prim_name := ut.StripOrdinal(prim_name), 
								 string10 l_prim_range := TRIM(ut.CleanPrimRange(prim_range),LEFT), 
								 l_st := st, 
								 l_city_code := doxie.Make_CityCode(p_city_name),
								 l_zip := z5,
								 l_sec_range := sec_range,
								 string6 l_dph_lname := metaphonelib.DMetaPhone1(lname),
								 l_lname := lname,
								 string20 l_pfname := datalib.preferredfirst(fname),
								 l_fname := fname},{file_in},
								data_services.data_location.prefix() + 'thor_data400::key::American_Student::' + Doxie.Version_SuperKey+'::Address');