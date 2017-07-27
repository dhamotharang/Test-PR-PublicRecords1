init := SORT(GROUP(name_zip_age_ssn4_do_A),
					zip, lname, did, fname, mname, LOCAL);

base := GROUP(init, zip, lname, LOCAL);

SetFM := ['Z', 'M', 'F'];
SetFMi := ['Z', 'M'];
SetFiMi := ['Z', 'M', 'I'];
SetF := ['Z'];

MAC_name_zip_age_ssn4_count_group(	base, 
									lmfz,
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_count_group(	base, 
									lmifz,
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_count_group(	base, 
									lmifiz,
									SetFiMi,
									fname[1],
									mname[1])
									
MAC_name_zip_age_ssn4_count_group(	base, 
									lfz,
									SetF,
									fname,
									'')

MAC_name_zip_age_ssn4_join_group(	base, 
									lmfz,
									lmfz_res,
									Count_Z_F_M_L,
									'',
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_join_group(	lmfz_res, 
									lmifz,
									lmifz_res,
									Count_Z_F_Mi_L,
									'',
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifz_res, 
									lmifiz,
									lmifiz_res,
									Count_Z_Fi_Mi_L,
									'',
									SetFiMi,
									fname[1],
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifiz_res, 
									lfz,
									lfz_res,
									Count_Z_F_L,
									'',
									SetF,
									fname,
									'')

export name_zip_age_ssn4_do_Z := lfz_res : PERSIST('TEMP::HSS_name_zip_age_ssn4_do_Z');