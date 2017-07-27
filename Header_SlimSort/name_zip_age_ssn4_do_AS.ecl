init := SORT(GROUP(name_zip_age_ssn4_do_ZAS),
					age, ssn4, lname, did, fname, mname, LOCAL);
base := GROUP(init, age, ssn4, lname, LOCAL);

SetFM := ['A', 'S', 'M', 'F'];
SetFMi := ['A', 'S', 'M'];
SetFiMi := ['A', 'S', 'M', 'I'];
SetF := ['A', 'S'];

MAC_name_zip_age_ssn4_count_group(	base, 
									lmfas,
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_count_group(	base, 
									lmifas,
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_count_group(	base, 
									lmifias,
									SetFiMi,
									fname[1],
									mname[1])

MAC_name_zip_age_ssn4_count_group(	base, 
									lfas,
									SetF,
									fname,
									'')

MAC_name_zip_age_ssn4_join_group(	base, 
									lmfas,
									lmfas_res,
									Count_A_S_F_M_L,
									Count_Ar_S_F_M_L,
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_join_group(	lmfas_res, 
									lmifas,
									lmifas_res,
									Count_A_S_F_Mi_L,
									Count_Ar_S_F_Mi_L,
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifas_res, 
									lmifias,
									lmifias_res,
									Count_A_S_Fi_Mi_L,
									Count_Ar_S_Fi_Mi_L,
									SetFiMi,
									fname[1],
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifias_res, 
									lfas,
									lfas_res,
									Count_A_S_F_L,
									Count_Ar_S_F_L,
									SetF,
									fname,
									'')

export name_zip_age_ssn4_do_AS := lfas_res : PERSIST('TEMP::HSS_name_zip_age_ssn4_do_AS');