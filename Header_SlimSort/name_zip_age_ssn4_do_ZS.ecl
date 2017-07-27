init := SORT(GROUP(name_zip_age_ssn4_do_AS),
					zip, ssn4, lname, did, fname, mname, LOCAL);
base := GROUP(init, zip, ssn4, lname, LOCAL);

SetFM := ['Z', 'S', 'M', 'F'];
SetFMi := ['Z', 'S', 'M'];
SetFiMi := ['Z', 'S', 'M', 'I'];
SetF := ['Z', 'S'];

MAC_name_zip_age_ssn4_count_group(	base, 
									lmfzs,
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_count_group(	base, 
									lmifzs,
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_count_group(	base, 
									lmifizs,
									SetFiMi,
									fname[1],
									mname[1])

MAC_name_zip_age_ssn4_count_group(	base, 
									lfzs,
									SetF,
									fname,
									'')

MAC_name_zip_age_ssn4_join_group(	base, 
									lmfzs,
									lmfzs_res,
									Count_Z_S_F_M_L,
									'',
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_join_group(	lmfzs_res, 
									lmifzs,
									lmifzs_res,
									Count_Z_S_F_Mi_L,
									'',
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifzs_res, 
									lmifizs,
									lmifizs_res,
									Count_Z_S_Fi_Mi_L,
									'',
									SetFiMi,
									fname[1],
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifizs_res, 
									lfzs,
									lfzs_res,
									Count_Z_S_F_L,
									'',
									SetF,
									fname,
									'')

export name_zip_age_ssn4_do_ZS := lfzs_res : PERSIST('TEMP::HSS_name_zip_age_ssn4_do_ZS');