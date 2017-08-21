export Header_Slimsort := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20110201';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400__key__header_slimsort__name_addr	:=
record
	qstring28 prim_name;
	qstring20 lname;
	qstring5 zip;
	qstring10 prim_range;
	qstring8 sec_range;
	qstring20 fname;
	qstring20 mname;
	string2 st;
	unsigned1 near_name;
	qstring5 name_suffix;
	unsigned3 dt_last_seen;
	unsigned2 fl_st_count;
	unsigned2 fl_nosec_count;
	unsigned2 fl_pz_count;
	unsigned2 fl_sec_count;
	unsigned2 fmls_nosec_count;
	unsigned2 fmls_sec_count;
	unsigned6 did;
end;

export rthor_data400__key__header_slimsort__name_addr_nn	:=
record
	qstring10 prim_range;
	qstring28 prim_name;
	qstring5 zip;
	qstring8 sec_range;
	qstring20 fname;
	unsigned1 near_name;
	unsigned2 apt_cnt;
	string2 st;
	qstring20 lname;
	qstring20 mname;
	qstring5 name_suffix;
	unsigned3 dt_last_seen;
	unsigned2 fl_st_count;
	unsigned2 fo_small_count;
	unsigned2 fl_nosec_count;
	unsigned2 fl_sec_count;
	unsigned2 fmls_nosec_count;
	unsigned2 fmls_sec_count;
	unsigned6 did;
end;

export rthor_data400__key__header_slimsort__name_address_st	:=
record
	qstring28 prim_name;
	qstring20 lname;
	string2 st;
	qstring10 prim_range;
	qstring8 sec_range;
	qstring20 fname;
	qstring20 mname;
	qstring5 zip;
	unsigned1 near_name;
	qstring5 name_suffix;
	unsigned3 dt_last_seen;
	unsigned2 fl_st_count;
	unsigned2 fl_nosec_count;
	unsigned2 fl_pz_count;
	unsigned2 fl_sec_count;
	unsigned2 fmls_nosec_count;
	unsigned2 fmls_sec_count;
	unsigned6 did;
end;

export rthor_data400__key__header_slimsort__name_dayob	:=
record
	unsigned3 mob;
	unsigned1 dayob;
	string2 alphinit;
	string20 fname;
	string20 lname;
	string20 mname;
	string5 zip;
	unsigned2 dob_fnname_dids;
	unsigned2 dob_fnmname_dids;
	unsigned2 dob_fnname_zip_dids;
	unsigned2 dob_fnname_dob_dids;
	unsigned6 did;
end;

export rthor_data400__key__header_slimsort__name_dob	:=
record
	unsigned3 mob;
	string20 fname;
	string20 lname;
	unsigned1 dayob;
	string20 mname;
	string5 zip;
	unsigned2 dob_fnname_dids;
	unsigned2 dob_fnmname_dids;
	unsigned2 dob_fnname_zip_dids;
	unsigned2 dob_fnname_dob_dids;
	unsigned6 did;
end;

export rthor_data400__key__header_slimsort__name_phone	:=
record
	qstring10 phone;
	qstring20 fname;
	qstring20 lname;
	qstring20 mname;
	qstring5 name_suffix;
	unsigned2 phone_dids;
	unsigned2 phone_fname_dids;
	unsigned2 phone_fname_suffix_dids;
	unsigned2 phone_fullname_dids;
	unsigned6 did;
end;

export rthor_data400__key__header_slimsort__name_ssn	:=
record
	qstring9 ssn;
	qstring20 fname;
	qstring20 lname;
	qstring20 mname;
	boolean near_name;
	qstring5 name_suffix;
	unsigned2 ssn_dids;
	unsigned2 ssn_fname_dids;
	unsigned2 ssn_fname_suffix_dids;
	unsigned2 ssn_fullname_dids;
	unsigned6 did;
end;

export rthor_data400__key__header_slimsort__name_zip	:=
record
	qstring20 fname;
	qstring20 lname;
	unsigned1 safe_name_zip;
	qstring5 zip;
	unsigned3 dt_last_seen;
	unsigned6 did;
end;

export rthor_data400__key__header_slimsort__nazs4_age	:=
record
	qstring20 lname;
	string1 fi;
	unsigned1 age;
	qstring20 mname;
	qstring20 fname;
	qstring5 zip;
	unsigned2 ssn4;
	unsigned2 count_a_z_s_f_m_l;
	unsigned2 count_a_z_s_f_mi_l;
	unsigned2 count_a_z_s_fi_mi_l;
	unsigned2 count_a_z_s_f_l;
	unsigned2 count_a_z_f_m_l;
	unsigned2 count_a_z_f_mi_l;
	unsigned2 count_a_z_fi_mi_l;
	unsigned2 count_a_z_f_l;
	unsigned2 count_a_s_f_m_l;
	unsigned2 count_a_s_f_mi_l;
	unsigned2 count_a_s_fi_mi_l;
	unsigned2 count_a_s_f_l;
	unsigned2 count_a_f_m_l;
	unsigned2 count_a_f_mi_l;
	unsigned2 count_a_f_l;
	unsigned6 did;
end;

export rthor_data400__key__header_slimsort__nazs4_ssn4	:=
record
	qstring20 lname;
	string1 fi;
	unsigned2 ssn4;
	qstring20 mname;
	qstring20 fname;
	qstring5 zip;
	unsigned1 age;
	unsigned2 count_a_z_s_f_m_l;
	unsigned2 count_a_z_s_f_mi_l;
	unsigned2 count_a_z_s_fi_mi_l;
	unsigned2 count_a_z_s_f_l;
	unsigned2 count_a_s_f_m_l;
	unsigned2 count_a_s_f_mi_l;
	unsigned2 count_a_s_fi_mi_l;
	unsigned2 count_a_s_f_l;
	unsigned2 count_z_s_f_m_l;
	unsigned2 count_z_s_f_mi_l;
	unsigned2 count_z_s_fi_mi_l;
	unsigned2 count_z_s_f_l;
	unsigned2 count_s_f_m_l;
	unsigned2 count_s_f_mi_l;
	unsigned2 count_s_fi_mi_l;
	unsigned2 count_s_f_l;
	unsigned6 did;
end;

export rthor_data400__key__header_slimsort__nazs4_zip	:=
record
	qstring20 lname;
	string1 fi;
	qstring5 zip;
	qstring20 mname;
	qstring20 fname;
	unsigned2 ssn4;
	unsigned1 age;
	unsigned2 count_a_z_s_f_m_l;
	unsigned2 count_a_z_s_f_mi_l;
	unsigned2 count_a_z_s_fi_mi_l;
	unsigned2 count_a_z_s_f_l;
	unsigned2 count_a_z_f_m_l;
	unsigned2 count_a_z_f_mi_l;
	unsigned2 count_a_z_fi_mi_l;
	unsigned2 count_a_z_f_l;
	unsigned2 count_z_s_f_m_l;
	unsigned2 count_z_s_f_mi_l;
	unsigned2 count_z_s_fi_mi_l;
	unsigned2 count_z_s_f_l;
	unsigned2 count_z_f_m_l;
	unsigned2 count_z_f_mi_l;
	unsigned2 count_z_fi_mi_l;
	unsigned2 count_z_f_l;
	unsigned6 did;
end;

export dthor_data400__key__header_slimsort__name_addr 			:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__name_addr.csv', rthor_data400__key__header_slimsort__name_addr, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_slimsort__name_addr_nn 		:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__name_addr_nn.csv', rthor_data400__key__header_slimsort__name_addr_nn, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_slimsort__name_address_st := dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__name_address_st.csv', rthor_data400__key__header_slimsort__name_address_st, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_slimsort__name_dayob 			:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__name_dayob.csv', rthor_data400__key__header_slimsort__name_dayob, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_slimsort__name_dob 				:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__name_dob.csv', rthor_data400__key__header_slimsort__name_dob, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_slimsort__name_phone 			:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__name_phone.csv', rthor_data400__key__header_slimsort__name_phone, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_slimsort__name_ssn 				:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__name_ssn.csv', rthor_data400__key__header_slimsort__name_ssn, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_slimsort__name_zip 				:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__name_zip.csv', rthor_data400__key__header_slimsort__name_zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_slimsort__nazs4_age 			:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__nazs4_age.csv', rthor_data400__key__header_slimsort__nazs4_age, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_slimsort__nazs4_ssn4 			:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__nazs4_ssn4.csv', rthor_data400__key__header_slimsort__nazs4_ssn4, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header_slimsort__nazs4_zip 			:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__header_slimsort__' + lCSVVersion + '__nazs4_zip.csv', rthor_data400__key__header_slimsort__nazs4_zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;