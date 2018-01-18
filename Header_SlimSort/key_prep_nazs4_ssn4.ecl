import data_services;

df := dataset('~thor_Data400::base::hss_name_zip_age_ssn4_BUILDING',header_slimsort.Layout_Name_Age_Zip_SSN4,flat);

export key_prep_nazs4_ssn4 := index(df,{
		df.lname;
	string1 fi := df.fname[1];
	df.ssn4;
	df.mname;
	df.fname;
	df.zip;
	df.age;
	df.Count_A_Z_S_F_M_L ;
	//df.Count_Ar_Z_S_F_M_L ;
	df.Count_A_Z_S_F_Mi_L ;
	//df.Count_Ar_Z_S_F_Mi_L ;
	df.Count_A_Z_S_Fi_Mi_L ;
	//df.Count_Ar_Z_S_Fi_Mi_L ;
	df.Count_A_Z_S_F_L ;
	//df.Count_Ar_Z_S_F_L ;
	df.Count_A_S_F_M_L ;
	//df.Count_Ar_S_F_M_L ;
	df.Count_A_S_F_Mi_L ;
	//df.Count_Ar_S_F_Mi_L ;
	df.Count_A_S_Fi_Mi_L ;
	//df.Count_Ar_S_Fi_Mi_L ;
	df.Count_A_S_F_L ;
	//df.Count_Ar_S_F_L ;
	df.Count_Z_S_F_M_L ;
	df.Count_Z_S_F_Mi_L ;
	df.Count_Z_S_Fi_Mi_L ;
	df.Count_Z_S_F_L ;
	df.Count_S_F_M_L ;
	df.Count_S_F_Mi_L ;
	df.Count_S_Fi_Mi_L;
	df.Count_S_F_L;
	df.did;},data_services.data_location.prefix() + 'thor_data400::key::key_nazs4_ssn4_' + thorlib.wuid());