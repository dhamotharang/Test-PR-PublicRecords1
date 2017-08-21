export Death_Master := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__death_master__did	:=
record
	unsigned6 l_did;
	string12 did;
	unsigned1 did_score;
	string8 filedate;
	string1 rec_type;
	string1 rec_type_orig;
	string9 ssn;
	string20 lname;
	string4 name_suffix;
	string15 fname;
	string15 mname;
	string1 vorp_code;
	string8 dod8;
	string8 dob8;
	string2 st_country_code;
	string5 zip_lastres;
	string5 zip_lastpayment;
	string2 state;
	string3 fipscounty;
	string2 crlf;
	string1 state_death_flag := '';
  string3 death_rec_src := '';
	string18 county_name;
	unsigned8 __internal_fpos__;
end;

export lname_var := RECORD
    string20 fname;
    string20 lname;
    unsigned3 first_seen;
    unsigned3 last_seen;
end;

export rthor_data400__key__death_master__ssn_table_v2	:=
record
	string9 ssn;
	unsigned3 official_first_seen;
	unsigned3 official_last_seen;
	unsigned3 header_first_seen;
	unsigned3 header_last_seen;
	boolean isvalidformat;
	boolean issequencevalid;
	boolean isbankrupt;
	unsigned8 dt_first_bankrupt;
	boolean isdeceased;
	unsigned8 dt_first_deceased;
	unsigned8 decs_dob;
	string5 decs_zip_lastres;
	string5 decs_zip_lastpayment;
	string20 decs_last;
	string20 decs_first;
	string2 issue_state;
	integer8 headercount;
	integer8 eqcount;
	integer8 tucount;
	integer8 srccount;
	integer8 didcount;
	integer8 didcount_c6;
	integer8 addr_ct;
	integer8 addr_ct_c6;
	integer8 bestcount;
	integer8 recentcount;
	unsigned6 bestdid;
	lname_var lname1;
	lname_var lname2;
	lname_var lname3;
	lname_var lname4;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__death_master__filtered__ssn_table_v2	:=
record
	string9 ssn;
	unsigned3 official_first_seen;
	unsigned3 official_last_seen;
	unsigned3 header_first_seen;
	unsigned3 header_last_seen;
	boolean isvalidformat;
	boolean issequencevalid;
	boolean isbankrupt;
	unsigned8 dt_first_bankrupt;
	boolean isdeceased;
	unsigned8 dt_first_deceased;
	unsigned8 decs_dob;
	string5 decs_zip_lastres;
	string5 decs_zip_lastpayment;
	string20 decs_last;
	string20 decs_first;
	string2 issue_state;
	integer8 headercount;
	integer8 eqcount;
	integer8 tucount;
	integer8 srccount;
	integer8 didcount;
	integer8 didcount_c6;
	integer8 addr_ct;
	integer8 addr_ct_c6;
	integer8 bestcount;
	integer8 recentcount;
	unsigned6 bestdid;
	lname_var lname1;
	lname_var lname2;
	lname_var lname3;
	lname_var lname4;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__death_master__did 										:= dataset(lCSVFileNamePrefix + 'thor_data400__key__death_master__' + lCSVVersion + '__did.csv', rthor_data400__key__death_master__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_master__ssn_table_v2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__death_master__' + lCSVVersion + '__ssn.csv', rthor_data400__key__death_master__ssn_table_v2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__death_master__filtered__ssn_table_v2 := dataset(lCSVFileNamePrefix + 'thor_data400__key__death_master__filtered__' + lCSVVersion + '__ssn_table_v2.csv', rthor_data400__key__death_master__filtered__ssn_table_v2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;