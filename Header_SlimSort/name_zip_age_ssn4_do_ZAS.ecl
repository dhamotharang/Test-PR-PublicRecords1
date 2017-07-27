init := SORT(GROUP(name_zip_age_ssn4_init),
					zip, age, ssn4, lname, did, fname, mname, LOCAL);

base := GROUP(init, zip, age, ssn4, lname, LOCAL);

SetFM := ['Z', 'A', 'S', 'M', 'F'];
SetFMi := ['Z', 'A', 'S', 'M'];
SetFiMi := ['Z', 'A', 'S', 'M', 'I'];
SetF := ['Z', 'A', 'S'];

MAC_name_zip_age_ssn4_count_group(	base, 
									lmfzas,
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_count_group(	base, 
									lmifzas,
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_count_group(	base, 
									lmifizas,
									SetFiMi,
									fname[1],
									mname[1])
									
MAC_name_zip_age_ssn4_count_group(	base, 
									lfzas,
									SetF,
									fname,
									'')

MAC_name_zip_age_ssn4_join_group(	base, 
									lmfzas,
									lmfzas_res,
									Count_A_Z_S_F_M_L,
									Count_Ar_Z_S_F_M_L,
									SetFM,
									fname,
									mname)

// Filter out groups with more than 200 DIDs per
// full zip-age-ssn4-lname-fname-mname combinations.
lmfzas_res_f := lmfzas_res(Count_A_Z_S_F_M_L < 20100);

MAC_name_zip_age_ssn4_join_group(	lmfzas_res_f, 
									lmifzas,
									lmifzas_res,
									Count_A_Z_S_F_Mi_L,
									Count_Ar_Z_S_F_Mi_L,
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifzas_res, 
									lmifizas,
									lmifizas_res,
									Count_A_Z_S_Fi_Mi_L,
									Count_Ar_Z_S_Fi_Mi_L,
									SetFiMi,
									fname[1],
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifizas_res, 
									lfzas,
									lfzas_res,
									Count_A_Z_S_F_L,
									Count_Ar_Z_S_F_L,
									SetF,
									fname,
									'')

export name_zip_age_ssn4_do_ZAS := lfzas_res : PERSIST('TEMP::HSS_name_zip_age_ssn4_do_ZAS');