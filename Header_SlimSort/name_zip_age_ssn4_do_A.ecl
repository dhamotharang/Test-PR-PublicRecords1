init := SORT(GROUP(name_zip_age_ssn4_do_S),
					age, lname, did, fname, mname, LOCAL);

base := GROUP(init, age, lname, LOCAL);

SetFM := ['A', 'M', 'F'];
SetFMi := ['A', 'M'];
SetFiMi := ['A', 'M', 'I'];
SetF := ['A'];

MAC_name_zip_age_ssn4_count_group(	base, 
									lmfa,
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_count_group(	base, 
									lmifa,
									SetFMi,
									fname,
									mname[1])
									
/*
MAC_name_zip_age_ssn4_count_group(	base, 
									lmifia,
									SetFiMi,
									fname[1],
									mname[1])
*/
									
MAC_name_zip_age_ssn4_count_group(	base, 
									lfa,
									SetF,
									fname,
									'')

MAC_name_zip_age_ssn4_join_group(	base, 
									lmfa,
									lmfa_res,
									Count_A_F_M_L,
									Count_Ar_F_M_L,
									SetFM,
									fname,
									mname)

MAC_name_zip_age_ssn4_join_group(	lmfa_res, 
									lmifa,
									lmifa_res,
									Count_A_F_Mi_L,
									Count_Ar_F_Mi_L,
									SetFMi,
									fname,
									mname[1])

/*
MAC_name_zip_age_ssn4_join_group(	lmifa_res, 
									lmifia,
									lmifia_res,
									Count_A_Fi_Mi_L,
									Count_Ar_Fi_Mi_L,
									SetFiMi,
									fname[1],
									mname[1])
*/
									
MAC_name_zip_age_ssn4_join_group(	lmifa_res, 
									lfa,
									lfa_res,
									Count_A_F_L,
									Count_Ar_F_L,
									SetF,
									fname,
									'')

export name_zip_age_ssn4_do_A := lfa_res : PERSIST('TEMP::HSS_name_zip_age_ssn4_do_A');