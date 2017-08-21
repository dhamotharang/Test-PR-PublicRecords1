EXPORT sanctn_np := MODULE

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20140107a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.MidexFilesBaseName + lSubDirName;
	
	//Auto Keys
	EXPORT rthor_data400__key__sanctn__np__autokey__address	:= RECORD
		STRING28 	prim_name;
		STRING10 	prim_range;
		STRING2 	st;
		UNSIGNED4 city_code;
		STRING5 	zip;
		STRING8 	sec_range;
		STRING6 	dph_lname;
		STRING20 	lname;
		STRING20 	pfname;
		STRING20 	fname;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	 END;

	EXPORT rthor_data400__key__sanctn__np__autokey__addressb2	:= RECORD
		STRING28 	prim_name;
		STRING10 	prim_range;
		STRING2 	st;
		UNSIGNED4 city_code;
		STRING5 	zip;
		STRING8 	sec_range;
		STRING40 	cname_indic;
		STRING40 	cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__citystname	:= RECORD
		UNSIGNED4 city_code;
		STRING2 	st;
		STRING6 	dph_lname;
		STRING20 	lname;
		STRING20 	pfname;
		STRING20 	fname;
		INTEGER4 	dob;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 city1;
		UNSIGNED4 city2;
		UNSIGNED4 city3;
		UNSIGNED4 rel_fname1;
		UNSIGNED4 rel_fname2;
		UNSIGNED4 rel_fname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__citystnameb2	:= RECORD
		UNSIGNED4 city_code;
		STRING2 	st;
		STRING40 	cname_indic;
		STRING40 	cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__fein2	:= RECORD
		STRING1 	f1;
		STRING1 	f2;
		STRING1 	f3;
		STRING1 	f4;
		STRING1 	f5;
		STRING1 	f6;
		STRING1 	f7;
		STRING1 	f8;
		STRING1 	f9;
		STRING40 	cname_indic;
		STRING40 	cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__name	:= RECORD
		STRING6 	dph_lname;
		STRING20 	lname;
		STRING20 	pfname;
		STRING20 	fname;
		STRING1 	minit;
		UNSIGNED2 yob;
		UNSIGNED2 s4;
		INTEGER4 	dob;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 city1;
		UNSIGNED4 city2;
		UNSIGNED4 city3;
		UNSIGNED4 rel_fname1;
		UNSIGNED4 rel_fname2;
		UNSIGNED4 rel_fname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__nameb2 	:= RECORD
		STRING40 	cname_indic;
		STRING40 	cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__namewords2	:=	RECORD
		STRING40 	word;
		STRING2 	state;
		UNSIGNED1 seq;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	addr := RECORD
		STRING10 	prim_range;
		STRING2 	predir;
		STRING28 	prim_name;
		STRING4 	addr_suffix;
		STRING2 	postdir;
		STRING10 	unit_desig;
		STRING8 	sec_range;
		STRING25 	v_city_name;
		STRING2 	st;
		STRING5 	zip5;
		STRING4 	zip4;
		STRING2 	addr_rec_type;
		STRING2 	fips_state;
		STRING3 	fips_county;
		STRING10 	geo_lat;
		STRING11 	geo_long;
		STRING4 	cbsa;
		STRING7 	geo_blk;
		STRING1 	geo_match;
		STRING4 	err_stat;
	END;
	
	name := RECORD
		STRING5 	title;
		STRING20 	fname;
		STRING20 	mname;
		STRING20 	lname;
		STRING5 	name_suffix;
		STRING3 	name_score;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__payload := RECORD
		UNSIGNED6 fakeid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED6 aid;
		UNSIGNED4 lookups;
		STRING10 	batch;
		STRING8 	incident_num;
		STRING7 	party_num;
		STRING50 	name_first;
		STRING50 	name_last;
		STRING50 	name_middle;
		STRING10 	suffix;
		STRING150 party_firm;
		STRING45 	address;
		STRING45 	city;
		STRING2 	state;
		STRING9 	zip;
		addr 			addr;
		name 			name;
		STRING100 company;
		STRING8 	dob;
		STRING10 	phone;
		STRING9 	ssn_tin;
		STRING11 	ssn;
		STRING10 	tin;
		STRING5 	srce_cd;
		STRING1 	dbcode;
		UNSIGNED1 zero;
		STRING1 	blank;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__phone2	:= RECORD
		STRING7 	p7;
		STRING3 	p3;
		STRING6 	dph_lname;
		STRING20 	pfname;
		STRING2 	st;
		UNSIGNED6 did;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__phoneb2	:= RECORD
		STRING7 	p7;
		STRING3 	p3;
		STRING40 	cname_indic;
		STRING40 	cname_sec;
		STRING2 	st;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__ssn2	:= RECORD
		STRING1 	s1;
		STRING1 	s2;
		STRING1 	s3;
		STRING1 	s4;
		STRING1 	s5;
		STRING1 	s6;
		STRING1 	s7;
		STRING1 	s8;
		STRING1 	s9;
		STRING6 	dph_lname;
		STRING20 	pfname;
		UNSIGNED6 did;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__stname	:= RECORD
		STRING2 	st;
		STRING6 	dph_lname;
		STRING20 	lname;
		STRING20 	pfname;
		STRING20 	fname;
		STRING1 	minit;
		UNSIGNED2 yob;
		UNSIGNED2 s4;
		INTEGER4 	zip;
		INTEGER4 	dob;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 city1;
		UNSIGNED4 city2;
		UNSIGNED4 city3;
		UNSIGNED4 rel_fname1;
		UNSIGNED4 rel_fname2;
		UNSIGNED4 rel_fname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__stnameb2	:= RECORD
		STRING2 	st;
		STRING40 	cname_indic;
		STRING40 	cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__zip	:= RECORD
		INTEGER4 	zip;
		STRING6 	dph_lname;
		STRING20 	lname;
		STRING20 	pfname;
		STRING20 	fname;
		STRING1 	minit;
		UNSIGNED2 yob;
		UNSIGNED2 s4;
		INTEGER4 	dob;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 city1;
		UNSIGNED4 city2;
		UNSIGNED4 city3;
		UNSIGNED4 rel_fname1;
		UNSIGNED4 rel_fname2;
		UNSIGNED4 rel_fname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	END;

	EXPORT rthor_data400__key__sanctn__np__autokey__zipb2	:= RECORD
		INTEGER4 	zip;
		STRING40 	cname_indic;
		STRING40 	cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;
	
	EXPORT rthor_data400__key__sanctn__np__bdid		:= RECORD
		UNSIGNED6 bdid;
		STRING8 	batch;
		STRING8 	incident_num;
		STRING7 	party_num;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__did	:= RECORD
		UNSIGNED6 did;
		STRING8 	batch;
		STRING8 	incident_num;
		STRING7 	party_num;
		UNSIGNED8 __internal_fpos__;	
	END;

	EXPORT rthor_data400__key__sanctn__np__incident	:= RECORD
		STRING8 	incident_num;
		STRING8 	batch;
		STRING8 	batch_date;
		STRING1 	dbcode;
		STRING8 	incident_date;
		INTEGER8 	int_key;
		STRING5 	srce_cd;
		STRING8 	billing_code;
		STRING20 	case_num;
		STRING70 	jurisdiction;
		STRING70 	agency;
		STRING70 	source_doc;
		STRING17 	source_ref;
		STRING70 	additional_info;
		STRING8 	modified_date;
		STRING8 	entry_date;
		STRING45 	member_name;
		STRING45 	submitter_name;
		STRING20 	submitter_nickname;
		STRING10 	submitter_phone;
		STRING10 	submitter_fax;
		STRING80 	submitter_email;
		STRING100 prop_addr;
		STRING45 	prop_city;
		STRING2 	prop_state;
		STRING9 	prop_zip;
		UNSIGNED8 aid;
		UNSIGNED6 did;
		UNSIGNED6 did_score;
		UNSIGNED6 bdid;
		UNSIGNED6 bdid_score;
	END;

	EXPORT rthor_data400__key__sanctn__np__incidentcode	:= RECORD
		STRING8 	incident_num;
		STRING8 	batch;
		STRING1 	dbcode;
		INTEGER8 	primary_key;
		INTEGER8 	foreign_key;
		STRING7 	number;
		STRING20 	field_name;
		STRING20 	code_type;
		STRING20 	code_value;
		STRING2 	code_state;
		STRING500 other_desc;
		STRING80 	std_type_desc;
		STRING20 	cln_license_number;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__incidenttext	:= RECORD,maxlength(9000)
		STRING8 	incident_num;
		STRING8 	batch;
		STRING1 	dbcode;
		STRING3 	seq;
		STRING20 	field_name;
		STRING 		field_txt;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__license_midex	:= RECORD
		STRING26 	midex_rpt_nbr;
		STRING8 	batch;
		STRING1 	dbcode;
		STRING8 	incident_num;
		STRING7 	party_num;
		STRING20 	field_name;
		STRING20 	license_type;
		STRING20 	code_value;
		STRING2 	license_state;
		STRING500 other_desc;
		STRING80 	std_type_desc;
		STRING20 	cln_license_number;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__license_nbr	:= RECORD
		STRING20 	cln_license_number;
		STRING2 	license_state;
		STRING8 	batch;
		STRING8 	incident_num;
		STRING7 	party_num;
		STRING20 	license_nbr;
		STRING80 	license_type;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__midex_rpt_nbr	:= RECORD
		STRING26 	midex_rpt_nbr;
		STRING8 	batch;
		STRING1 	dbcode;
		STRING8 	incident_num;
		STRING7 	party_num;
		STRING 		party_key;
		UNSIGNED6 did;
		UNSIGNED6 did_score;
		UNSIGNED6 bdid;
		UNSIGNED6 bdid_score;
		STRING45 	party_position;
		STRING150 party_employer;
		STRING150 party_firm;
		STRING1 	party_type;
		STRING8 	dob;
		STRING9 	ssn;
		STRING5 	title;
		STRING20 	fname;
		STRING20 	mname;
		STRING20 	lname;
		STRING5 	name_suffix;
		STRING3 	name_score;
		STRING150 ename;
		STRING150 cname;
		STRING10 	tin;
		STRING10 	prim_range;
		STRING2 	predir;
		STRING28 	prim_name;
		STRING4 	addr_suffix;
		STRING2 	postdir;
		STRING10 	unit_desig;
		STRING8 	sec_range;
		STRING25 	p_city_name;
		STRING25 	v_city_name;
		STRING2 	st;
		STRING5 	zip5;
		STRING4 	zip4;
		STRING2 	fips_state;
		STRING3 	fips_county;
		STRING2 	addr_rec_type;
		STRING10 	geo_lat;
		STRING11 	geo_long;
		STRING4 	cbsa;
		STRING7 	geo_blk;
		STRING1 	geo_match;
		STRING4 	cart;
		STRING1 	cr_sort_sz;
		STRING4 	lot;
		STRING1 	lot_order;
		STRING2 	dpbc;
		STRING1 	chk_digit;
		STRING4 	err_stat;
		STRING 		sanctions;
		string10	phone;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__midex_rpt_nbr_new	:= RECORD
		STRING26 	midex_rpt_nbr;
		STRING8 	batch;
		STRING1 	dbcode;
		STRING8 	incident_num;
		STRING7 	party_num;
		STRING 		party_key;
		UNSIGNED6 did;
		UNSIGNED6 did_score;
		UNSIGNED6 bdid;
		UNSIGNED6 bdid_score;
		STRING45 	party_position;
		STRING150 party_employer;
		STRING150 party_firm;
		STRING1 	party_type;
		STRING8 	dob;
		STRING9 	ssn;
		STRING5 	title;
		STRING20 	fname;
		STRING20 	mname;
		STRING20 	lname;
		STRING5 	name_suffix;
		STRING3 	name_score;
		STRING150 ename;
		STRING150 cname;
		STRING10 	tin;
		STRING10 	prim_range;
		STRING2 	predir;
		STRING28 	prim_name;
		STRING4 	addr_suffix;
		STRING2 	postdir;
		STRING10 	unit_desig;
		STRING8 	sec_range;
		STRING25 	p_city_name;
		STRING25 	v_city_name;
		STRING2 	st;
		STRING5 	zip5;
		STRING4 	zip4;
		STRING2 	fips_state;
		STRING3 	fips_county;
		STRING2 	addr_rec_type;
		STRING10 	geo_lat;
		STRING11 	geo_long;
		STRING4 	cbsa;
		STRING7 	geo_blk;
		STRING1 	geo_match;
		STRING4 	cart;
		STRING1 	cr_sort_sz;
		STRING4 	lot;
		STRING1 	lot_order;
		STRING2 	dpbc;
		STRING1 	chk_digit;
		STRING4 	err_stat;
		STRING 		sanctions;
		string10	phone;
		unsigned6 dotid;
		unsigned2 dotscore;
		unsigned2 dotweight;
		unsigned6 empid;
		unsigned2 empscore;
		unsigned2 empweight;
		unsigned6 powid;
		unsigned2 powscore;
		unsigned2 powweight;
		unsigned6 proxid;
		unsigned2 proxscore;
		unsigned2 proxweight;
		unsigned6 seleid;
		unsigned2 selescore;
		unsigned2 seleweight;
		unsigned6 orgid;
		unsigned2 orgscore;
		unsigned2 orgweight;
		unsigned6 ultid;
		unsigned2 ultscore;
		unsigned2 ultweight;
		UNSIGNED8 __internal_fpos__;
	END;


	EXPORT rthor_data400__key__sanctn__np__nmls_id	:= RECORD
		STRING20 	nmls_id;
		STRING8 	batch;
		STRING8 	incident_num;
		STRING7 	party_num;
		STRING2 	license_state;
		STRING80 	license_type;
		STRING26 	midex_rpt_nbr;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__nmls_midex	:= RECORD
		STRING26 	midex_rpt_nbr;
		STRING8 	batch;
		STRING1 	dbcode;
		STRING8 	incident_num;
		STRING7 	party_num;
		STRING20 	field_name;
		STRING20 	license_type;
		STRING20 	code_value;
		STRING2 	license_state;
		STRING500 other_desc;
		STRING80 	std_type_desc;
		STRING20 	nmls_id;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__party	:= RECORD
		STRING8 	batch;
		STRING8 	incident_num;
		STRING7 	party_num;
		STRING1 	dbcode;
		STRING 		sanctions;
		STRING 		additional_info;
		STRING150 party_firm;
		STRING10 	tin;
		STRING50 	name_first;
		STRING50 	name_last;
		STRING50 	name_middle;
		STRING10 	suffix;
		STRING20 	nickname;
		STRING45 	party_position;
		STRING150 party_employer;
		STRING9 	ssn;
		STRING8 	dob;
		STRING45 	address;
		STRING45 	city;
		STRING2 	state;
		STRING9 	zip;
		STRING1 	party_type;
		INTEGER8 	party_key;
		INTEGER8 	int_key;
		STRING20	phone;
		STRING500 akaname;
		STRING500 dbaname;
		UNSIGNED8 aid;
		UNSIGNED6 did;
		UNSIGNED6 did_score;
		UNSIGNED6 bdid;
		UNSIGNED6 bdid_score;
	END;

	EXPORT rthor_data400__key__sanctn__np__partytext	:= RECORD
		STRING8 	batch;
		STRING8 	incident_num;
		STRING7 	party_num;
		STRING1 	dbcode;
		STRING3 	seq;
		STRING20 	field_name;
		STRING 		field_txt;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__ssn4	:= RECORD
		STRING4 ssn4;
		STRING8 batch;
		STRING8 incident_num;
		STRING7 party_num;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__tin	:= RECORD
		STRING10 	tin;
		STRING8 	batch;
		STRING8 	incident_num;
		STRING7 	party_num;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__np__party_aka_dba	:= RECORD
		string8 batch;
		string8 incident_num;
		string7 party_num;
		string1 dbcode;
		string1 name_type;
		string100 aka_dba_text;
		unsigned8 __internal_fpos__;
 END;


EXPORT rthor_data400__key__sanctn__np__linkids_incident 	:= RECORD
	unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned8 source_rec_id;
  string8 batch;
  string8 batch_date;
  string1 dbcode;
  string8 incident_num;
  string8 incident_date;
  integer8 int_key;
  string5 srce_cd;
  string8 billing_code;
  string20 case_num;
  string70 jurisdiction;
  string70 agency;
  string70 source_doc;
  string17 source_ref;
  string70 additional_info;
  string8 modified_date;
  string8 entry_date;
  string45 member_name;
  string45 submitter_name;
  string20 submitter_nickname;
  string10 submitter_phone;
  string10 submitter_fax;
  string80 submitter_email;
  string100 prop_addr;
  string45 prop_city;
  string2 prop_state;
  string9 prop_zip;
  unsigned8 aid;
  unsigned6 did;
  unsigned6 did_score;
  unsigned6 bdid;
  unsigned6 bdid_score;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string70 cname;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string2 fips_state;
  string3 fips_county;
  string2 addr_rec_type;
  string10 geo_lat;
  string11 geo_long;
  string4 cbsa;
  string7 geo_blk;
  string1 geo_match;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string4 err_stat;
  integer1 fp;
 END;


EXPORT rthor_data400__key__sanctn__np__linkids_party		:= RECORD
unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned8 source_rec_id;
  string8 batch;
  string1 dbcode;
  string8 incident_num;
  string7 party_num;
  string sanctions;
  string additional_info;
  string150 party_firm;
  string10 tin;
  string50 name_first;
  string50 name_last;
  string50 name_middle;
  string10 suffix;
  string20 nickname;
  string45 party_position;
  string150 party_employer;
  string9 ssn;
  string8 dob;
  string45 address;
  string45 city;
  string2 state;
  string9 zip;
  string1 party_type;
  integer8 party_key;
  integer8 int_key;
  string20 phone;
  string500 akaname;
  string500 dbaname;
  unsigned8 aid;
  unsigned6 did;
  unsigned6 did_score;
  unsigned6 bdid;
  unsigned6 bdid_score;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string150 ename;
  string150 cname;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string2 fips_state;
  string3 fips_county;
  string2 addr_rec_type;
  string10 geo_lat;
  string11 geo_long;
  string4 cbsa;
  string7 geo_blk;
  string1 geo_match;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string4 err_stat;
  integer1 fp;
 END;


	EXPORT dthor_data400__key__sanctn__np__autokey__address 			:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__address.csv', rthor_data400__key__sanctn__np__autokey__address,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__addressb2 		:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__addressb2.csv', rthor_data400__key__sanctn__np__autokey__addressb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__citystname 		:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__sanctn__np__autokey__citystname,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__citystnameb2 	:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__citystnameb2.csv', rthor_data400__key__sanctn__np__autokey__citystnameb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__fein2					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__fein2.csv', rthor_data400__key__sanctn__np__autokey__fein2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__name 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__name.csv', rthor_data400__key__sanctn__np__autokey__name,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__nameb2 				:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__nameb2.csv', rthor_data400__key__sanctn__np__autokey__nameb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__namewords2		:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__namewords2.csv', rthor_data400__key__sanctn__np__autokey__namewords2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__payload 			:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__payload.csv', rthor_data400__key__sanctn__np__autokey__payload,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__phone2				:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__phone2.csv', rthor_data400__key__sanctn__np__autokey__phone2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__phoneb2				:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__phoneb2.csv', rthor_data400__key__sanctn__np__autokey__phoneb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__ssn2 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__sanctn__np__autokey__ssn2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__stname 				:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__stname.csv', rthor_data400__key__sanctn__np__autokey__stname,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__stnameb2 			:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__stnameb2.csv', rthor_data400__key__sanctn__np__autokey__stnameb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__zip 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__zip.csv', rthor_data400__key__sanctn__np__autokey__zip,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__autokey__zipb2 				:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__autokey__zipb2.csv', rthor_data400__key__sanctn__np__autokey__zipb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

	EXPORT dthor_data400__key__sanctn__np__bdid 									:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__bdid.csv', rthor_data400__key__sanctn__np__bdid,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__did 										:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__did.csv', rthor_data400__key__sanctn__np__did,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__incident 							:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__incident.csv', rthor_data400__key__sanctn__np__incident,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__incidentcode 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__incidentcode.csv', rthor_data400__key__sanctn__np__incidentcode,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__incidenttext 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__incidenttext.csv', rthor_data400__key__sanctn__np__incidenttext,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__license_nbr 						:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__license_nbr.csv', rthor_data400__key__sanctn__np__license_nbr,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__license_midex 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__license_midex.csv', rthor_data400__key__sanctn__np__license_midex,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__midex_rpt_nbr 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__midex_rpt_nbr.csv', rthor_data400__key__sanctn__np__midex_rpt_nbr,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__nmls_id 								:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__nmls_id.csv', rthor_data400__key__sanctn__np__nmls_id,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__nmls_midex							:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__nmls_midex.csv', rthor_data400__key__sanctn__np__nmls_midex,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__party 									:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__party.csv', rthor_data400__key__sanctn__np__party,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__partytext 							:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__partytext.csv', rthor_data400__key__sanctn__np__partytext,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__ssn4 									:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__ssn4.csv', rthor_data400__key__sanctn__np__ssn4,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__tin 										:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__tin.csv', rthor_data400__key__sanctn__np__tin,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	EXPORT dthor_data400__key__sanctn__np__partyaka_dba						:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__np__'+ lCSVVersion + '__party__aka__dba.csv', rthor_data400__key__sanctn__np__party_aka_dba,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	
//Linkid Keys	
	export dthor_data400__key__sanctn__np__linkids_incident				:= dataset([], rthor_data400__key__sanctn__np__linkids_incident);
	export dthor_data400__key__sanctn__np__linkids_party					:= dataset([], rthor_data400__key__sanctn__np__linkids_party);

END;
	