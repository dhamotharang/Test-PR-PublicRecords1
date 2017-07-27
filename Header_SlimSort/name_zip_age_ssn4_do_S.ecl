init := SORT(GROUP(name_zip_age_ssn4_do_ZA),
					ssn4, lname, did, fname, mname, LOCAL);

base := GROUP(init, ssn4, lname, LOCAL);

SetFM := ['S', 'M', 'F'];
SetFMi := ['S', 'M'];
SetFiMi := ['S', 'M', 'I'];
SetF := ['S'];

MAC_name_zip_age_ssn4_count_group(	base, 
									lmfs,
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_count_group(	base, 
									lmifs,
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_count_group(	base, 
									lmifis,
									SetFiMi,
									fname[1],
									mname[1])
									
MAC_name_zip_age_ssn4_count_group(	base, 
									lfs,
									SetF,
									fname,
									'')

MAC_name_zip_age_ssn4_join_group(	base, 
									lmfs,
									lmfs_res,
									Count_S_F_M_L,
									'',
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_join_group(	lmfs_res, 
									lmifs,
									lmifs_res,
									Count_S_F_Mi_L,
									'',
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifs_res, 
									lmifis,
									lmifis_res,
									Count_S_Fi_Mi_L,
									'',
									SetFiMi,
									fname[1],
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifis_res, 
									lfs,
									lfs_res,
									Count_S_F_L,
									'',
									SetF,
									fname,
									'')

export name_zip_age_ssn4_do_S := lfs_res : PERSIST('TEMP::HSS_name_zip_age_ssn4_do_S');