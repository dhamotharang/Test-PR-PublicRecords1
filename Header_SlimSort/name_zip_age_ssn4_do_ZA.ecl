init := SORT(GROUP(name_zip_age_ssn4_do_ZS),
					zip, age, lname, did, fname, mname, LOCAL);
base := GROUP(init, zip, age, lname, LOCAL);

SetFM := ['Z', 'A', 'M', 'F'];
SetFMi := ['Z', 'A', 'M'];
SetFiMi := ['Z', 'A', 'M', 'I'];
SetF := ['Z', 'A'];

MAC_name_zip_age_ssn4_count_group(	base, 
									lmfza,
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_count_group(	base, 
									lmifza,
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_count_group(	base, 
									lmifiza,
									SetFiMi,
									fname[1],
									mname[1])

MAC_name_zip_age_ssn4_count_group(	base, 
									lfza,
									SetF,
									fname,
									'')

MAC_name_zip_age_ssn4_join_group(	base, 
									lmfza,
									lmfza_res,
									Count_A_Z_F_M_L,
									Count_Ar_Z_F_M_L,
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_join_group(	lmfza_res, 
									lmifza,
									lmifza_res,
									Count_A_Z_F_Mi_L,
									Count_Ar_Z_F_Mi_L,
									SetFMi,
									fname,
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifza_res, 
									lmifiza,
									lmifiza_res,
									Count_A_Z_Fi_Mi_L,
									Count_Ar_Z_Fi_Mi_L,
									SetFiMi,
									fname[1],
									mname[1])
									
MAC_name_zip_age_ssn4_join_group(	lmifiza_res, 
									lfza,
									lfza_res,
									Count_A_Z_F_L,
									Count_Ar_Z_F_L,
									SetF,
									fname,
									'')

export name_zip_age_ssn4_do_ZA := lfza_res : PERSIST('TEMP::HSS_name_zip_age_ssn4_do_ZA');