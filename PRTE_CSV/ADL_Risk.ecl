export ADL_Risk := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100105a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400__key__adl_risk_table_v2	:=
record
	unsigned6 did;
	unsigned1 addr_ct;
	unsigned1 addr_ct_last30days;
	unsigned1 addr_ct_last90days;
	unsigned1 addr_ct_c6;
	unsigned1 addr_ct_last1year;
	unsigned1 addr_ct_last2years;
	unsigned1 addr_ct_last3years;
	unsigned1 addr_ct_last5years;
	unsigned1 addr_ct_last10years;
	unsigned1 addr_ct_last15years;
	unsigned1 ssn_ct;
	unsigned1 ssn_ct_c6;
	unsigned1 lname_ct;
	unsigned1 lname_ct30;
	unsigned1 lname_ct90;
	unsigned1 lname_ct180;
	unsigned1 lname_ct12;
	unsigned1 lname_ct24;
	unsigned1 lname_ct36;
	unsigned1 lname_ct60;
	string20 newest_lname;
	string20 newest_lname2;
	unsigned3 newest_lname_dt_first_seen;
	unsigned1 phone_ct;
	unsigned1 phone_ct_c6;
	unsigned1 stability;
	unsigned4 reported_dob;
	string2 reported_dob_src;
	integer8 inferred_age;
	unsigned4 reported_dob_no_dppa;
	string2 reported_dob_src_no_dppa;
	integer8 inferred_age_no_dppa;
end;

export rthor_data400__key__adl_risk_table_v2_filtered	:=
record
	unsigned6 did;
	unsigned1 addr_ct;
	unsigned1 addr_ct_last30days;
	unsigned1 addr_ct_last90days;
	unsigned1 addr_ct_c6;
	unsigned1 addr_ct_last1year;
	unsigned1 addr_ct_last2years;
	unsigned1 addr_ct_last3years;
	unsigned1 addr_ct_last5years;
	unsigned1 addr_ct_last10years;
	unsigned1 addr_ct_last15years;
	unsigned1 ssn_ct;
	unsigned1 ssn_ct_c6;
	unsigned1 lname_ct;
	unsigned1 lname_ct30;
	unsigned1 lname_ct90;
	unsigned1 lname_ct180;
	unsigned1 lname_ct12;
	unsigned1 lname_ct24;
	unsigned1 lname_ct36;
	unsigned1 lname_ct60;
	string20 newest_lname;
	string20 newest_lname2;
	unsigned3 newest_lname_dt_first_seen;
	unsigned1 phone_ct;
	unsigned1 phone_ct_c6;
	unsigned1 stability;
	unsigned4 reported_dob;
	string2 reported_dob_src;
	integer8 inferred_age;
	unsigned4 reported_dob_no_dppa;
	string2 reported_dob_src_no_dppa;
	integer8 inferred_age_no_dppa;
end;

export dthor_data400__key__adl_risk_table_v2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__' + lCSVVersion + '__adl_risk_table_v2.csv', rthor_data400__key__adl_risk_table_v2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__adl_risk_table_v2_filtered := dataset(lCSVFileNamePrefix + 'thor_data400__key__' + lCSVVersion + '__adl_risk_table_v2_filtered.csv', rthor_data400__key__adl_risk_table_v2_filtered, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;