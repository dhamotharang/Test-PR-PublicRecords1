import PRTE_CSV;

EXPORT Sanctn := module

	SHARED	lSubDirName					:=	'';
	SHARED	lCSVVersion					:=	'20140212';
	SHARED	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.MidexFilesBaseName + lSubDirName;
	
	//SANCTN Autokeys
	EXPORT rthor_data400__key__sanctn__autokey__address	:= RECORD
		STRING28 	prim_name;   	//defined in AutoKey.Layout_Address_bare
		STRING10 	prim_range;
		STRING2 	st;
		UNSIGNED4 city_code;
		STRING5 	zip;
		STRING8 	sec_range;
		STRING6 	dph_lname;		//defined in AutoKey.Layout_Address
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

	EXPORT rthor_data400__key__sanctn__autokey__addressb2	:= RECORD
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

	EXPORT rthor_data400__key__sanctn__autokey__citystname	:= RECORD
		UNSIGNED4 city_code;		//AutoKey.Layout_CityStName
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

	EXPORT rthor_data400__key__sanctn__autokey__citystnameb2	:= RECORD
		UNSIGNED4 city_code;
		STRING2 	st;
		STRING40 	cname_indic;
		STRING40 	cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__autokey__name	:= RECORD
		STRING6 	dph_lname;		//AutoKey.Layout_Name	
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

	EXPORT rthor_data400__key__sanctn__autokey__nameb2 	:= RECORD
		STRING40 	cname_indic;	
		STRING40 	cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__autokey__namewords2	:=	RECORD
		STRING40 	word;					//AutoKeyB2.layout_NameWords
		STRING2 	state;
		UNSIGNED1 seq;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__autokey__payload	:=	RECORD
		UNSIGNED6 fakeid;
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		STRING8 	ag_code;
		STRING8 	incident_date;
		STRING5 	title;
		STRING20 	fname;
		STRING20 	mname;
		STRING20 	lname;
		STRING5 	name_suffix;
		STRING3 	name_score;
		STRING45 	cname;
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
		UNSIGNED6 did;
		UNSIGNED3 did_score;
		UNSIGNED6 bdid;
		UNSIGNED3 bdid_score;
		STRING11 	ssnumber;
		STRING9 	ssn_appended;
		integer8 	zero;
		STRING0 	blk;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__autokey__ssn2	:= RECORD
		STRING1 	s1;						//AutoKey.Layout_SSN2
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

	EXPORT rthor_data400__key__sanctn__autokey__stname	:= RECORD
		STRING2 	st;						//AutoKey.Layout_StName
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

	EXPORT rthor_data400__key__sanctn__autokey__stnameb2	:= RECORD
		STRING2 	st;
		STRING40 	cname_indic;
		STRING40 	cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	EXPORT rthor_data400__key__sanctn__autokey__zip	:= RECORD
		INTEGER4 	zip;					//AutoKey.Layout_Zip
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

	EXPORT rthor_data400__key__sanctn__autokey__zipb2	:= RECORD
		INTEGER4 	zip;
		STRING40 	cname_indic;
		STRING40 	cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	//SANCTN Keys
	EXPORT rthor_data400__key__sanctn__bdid	:= RECORD
		UNSIGNED6 bdid;
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__casenum	:= RECORD
		STRING20 	case_number;
		STRING8 	batch_number;
		STRING8 	incident_number;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__did	:= RECORD
		UNSIGNED6 did;
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__incident_midex	:= RECORD
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		STRING4 	order_number;
		STRING8 	ag_code;
		STRING20 	case_number;
		STRING8 	incident_date;
		STRING90 	jurisdiction;
		STRING70 	source_document;
		STRING70 	additional_info;
		STRING70 	agency;
		STRING10 	alleged_amount;
		STRING10 	estimated_loss;
		STRING10 	fcr_date;
		STRING1 	ok_for_fcr;
		STRING10 	modified_date;
		STRING10 	load_date;
		STRING255 incident_text;
		STRING8 	incident_date_clean;
		STRING8 	fcr_date_clean;
		STRING8 	cln_modified_date;
		STRING8 	cln_load_date;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__incident	:= RECORD
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING4 	order_number;
		STRING8 	ag_code;
		STRING20 	case_number;
		STRING8 	incident_date;
		STRING90 	jurisdiction;
		STRING70 	source_document;
		STRING70 	additional_info;
		STRING70 	agency;
		STRING10 	alleged_amount;
		STRING10 	estimated_loss;
		STRING10 	fcr_date;
		STRING1 	ok_for_fcr;
		STRING255 incident_text;
		STRING8 	incident_date_clean;
		STRING8 	fcr_date_clean;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__license_midex	:= RECORD
		STRING26 	midex_rpt_nbr;
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		STRING4 	order_number;
		STRING50 	license_number;
		STRING50 	license_type;
		STRING20 	license_state;
		STRING50 	cln_license_number;
		STRING50 	std_type_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__license_nbr	:= RECORD
		STRING50 	cln_license_number;
		STRING20 	license_state;
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		STRING4 	order_number;
		STRING50 	license_number;
		STRING50 	license_type;
		STRING50 	std_type_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__midex_rpt_nbr	:= RECORD
	STRING26 	midex_rpt_nbr;
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		STRING4 	order_number;
		STRING45 	party_name;
		STRING45 	party_position;
		STRING45 	party_vocation;
		STRING70 	party_firm;
		STRING45 	inaddress;
		STRING45 	incity;
		STRING20 	instate;
		STRING10 	inzip;
		STRING11 	ssnumber;
		STRING10 	fines_levied;
		STRING10 	restitution;
		STRING1 	ok_for_fcr;
		STRING255 party_text;
		STRING5 	title;
		STRING20 	fname;
		STRING20 	mname;
		STRING20 	lname;
		STRING5 	name_suffix;
		STRING3 	name_score;
		STRING45 	cname;
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
		UNSIGNED6 did;
		UNSIGNED3 did_score;
		UNSIGNED6 bdid;
		UNSIGNED3 bdid_score;
		STRING9 	ssn_appended;
		STRING60 	dba_name;
		STRING30 	contact_name;
		UNSIGNED8 __internal_fpos__;
	END;


	EXPORT rthor_data400__key__sanctn__midex_rpt_nbr_new	:= RECORD
		STRING26 	midex_rpt_nbr;
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		STRING4 	order_number;
		STRING45 	party_name;
		STRING45 	party_position;
		STRING45 	party_vocation;
		STRING70 	party_firm;
		STRING45 	inaddress;
		STRING45 	incity;
		STRING20 	instate;
		STRING10 	inzip;
		STRING11 	ssnumber;
		STRING10 	fines_levied;
		STRING10 	restitution;
		STRING1 	ok_for_fcr;
		STRING255 party_text;
		STRING5 	title;
		STRING20 	fname;
		STRING20 	mname;
		STRING20 	lname;
		STRING5 	name_suffix;
		STRING3 	name_score;
		STRING45 	cname;
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
		UNSIGNED6 did;
		UNSIGNED3 did_score;
		UNSIGNED6 bdid;
		UNSIGNED3 bdid_score;
		STRING9 	ssn_appended;
		STRING60 	dba_name;
		STRING30 	contact_name;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__nmls_id	:= RECORD
		STRING20	nmls_id;
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		STRING4 	order_number;
		STRING50 	license_number;
		STRING50 	license_type;
		STRING20 	license_state;
		STRING50 	std_type_desc;
		STRING26 	midex_rpt_nbr;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__nmls_midex	:= RECORD
		STRING26 	midex_rpt_nbr;
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		STRING4 	order_number;
		STRING50 	license_number;
		STRING50 	license_type;
		STRING20 	license_state;
		STRING50 	std_type_desc;
		STRING20	nmls_id;
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__party	:= RECORD
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		STRING1 	RECORD_type;
		STRING4 	order_number;
		STRING45 	party_name;
		STRING45 	party_position;
		STRING45 	party_vocation;
		STRING70 	party_firm;
		STRING45 	inaddress;
		STRING45 	incity;
		STRING20 	instate;
		STRING10 	inzip;
		STRING11 	ssnumber;
		STRING10 	fines_levied;
		STRING10 	restitution;
		STRING1 	ok_for_fcr;
		STRING255 party_text;
		STRING5 	title;
		STRING20 	fname;
		STRING20 	mname;
		STRING20 	lname;
		STRING5 	name_suffix;
		STRING3 	name_score;
		STRING45 	cname;
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
		UNSIGNED8 __internal_fpos__;
	END;

	EXPORT rthor_data400__key__sanctn__rebuttal	:= RECORD
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		STRING4 	order_number;
		STRING255 party_text;
		UNSIGNED8 __internal_fpos__;	
	END;

	EXPORT rthor_data400__key__sanctn__ssn4	:= RECORD
		STRING4 	ssn4;
		STRING8 	batch_number;
		STRING8 	incident_number;
		STRING8 	party_number;
		// UNSIGNED8 __internal_fpos__;
	END;

 EXPORT rthor_data400__key__sanctn__party_aka_dba	:= RECORD
  STRING8 batch_number;
  STRING8 incident_number;
  STRING8 party_number;
  STRING3 order_number;
  STRING1 name_type;
  STRING500 aka_dba_text;
  UNSIGNED8 __internal_fpos__;
 END;


	EXPORT rthor_data400__key__sanctn__linkids	:= RECORD
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
		string8 batch_number;
		string8 incident_number;
		string8 party_number;
		string1 record_type;
		string4 order_number;
		string45 party_name;
		string45 party_position;
		string45 party_vocation;
		string70 party_firm;
		string45 inaddress;
		string45 incity;
		string20 instate;
		string10 inzip;
		string11 ssnumber;
		string10 fines_levied;
		string10 restitution;
		string1 ok_for_fcr;
		string255 party_text;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 name_score;
		string45 cname;
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
		unsigned8 source_rec_id;
		unsigned6 did;
		unsigned3 did_score;
		unsigned6 bdid;
		unsigned3 bdid_score;
		string9 ssn_appended;
		string60 dba_name;
		string30 contact_name;
		integer1 fp;
 END;

EXPORT dthor_data400__key__sanctn__autokey__address 			:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__address.csv', rthor_data400__key__sanctn__autokey__address,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__addressb2 		:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__addressb2.csv', rthor_data400__key__sanctn__autokey__addressb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__citystname 		:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__sanctn__autokey__citystname,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__citystnameb2 	:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__citystnameb2.csv', rthor_data400__key__sanctn__autokey__citystnameb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__name 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__name.csv', rthor_data400__key__sanctn__autokey__name,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__nameb2 				:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__nameb2.csv', rthor_data400__key__sanctn__autokey__nameb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__namewords2		:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__namewords2.csv', rthor_data400__key__sanctn__autokey__namewords2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__payload 			:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__payload.csv', rthor_data400__key__sanctn__autokey__payload,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__ssn2 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__sanctn__autokey__ssn2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__stname 				:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__stname.csv', rthor_data400__key__sanctn__autokey__stname,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__stnameb2 			:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__stnameb2.csv', rthor_data400__key__sanctn__autokey__stnameb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__zip 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__zip.csv', rthor_data400__key__sanctn__autokey__zip,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__autokey__zipb2 				:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__autokey__zipb2.csv', rthor_data400__key__sanctn__autokey__zipb2,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

EXPORT dthor_data400__key__sanctn__bdid 									:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__bdid.csv', rthor_data400__key__sanctn__bdid,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__casenum 								:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__casenum.csv', rthor_data400__key__sanctn__casenum,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__did 										:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__did.csv', rthor_data400__key__sanctn__did,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
EXPORT dthor_data400__key__sanctn__incident						 		:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__incident.csv', rthor_data400__key__sanctn__incident,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
EXPORT dthor_data400__key__sanctn__incident_midex 				:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__incident_midex.csv', rthor_data400__key__sanctn__incident_midex,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
EXPORT dthor_data400__key__sanctn__license_midex 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__license_midex.csv', rthor_data400__key__sanctn__license_midex,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
EXPORT dthor_data400__key__sanctn__license_nbr 						:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__license_nbr.csv', rthor_data400__key__sanctn__license_nbr,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
EXPORT dthor_data400__key__sanctn__midex_rpt_nbr					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__midex_rpt_nbr.csv', rthor_data400__key__sanctn__midex_rpt_nbr,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
EXPORT dthor_data400__key__sanctn__nmls_id			 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__nmls_id.csv', rthor_data400__key__sanctn__nmls_id,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
EXPORT dthor_data400__key__sanctn__nmls_midex		 					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__nmls_midex.csv', rthor_data400__key__sanctn__nmls_midex,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
EXPORT dthor_data400__key__sanctn__party 									:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__party.csv', rthor_data400__key__sanctn__party,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
EXPORT dthor_data400__key__sanctn__rebuttal 							:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__rebuttal.csv', rthor_data400__key__sanctn__rebuttal,csv(separator('\t'), terminator('\r\n'), quote('"'), heading(single)));
EXPORT dthor_data400__key__sanctn__ssn4 									:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__ssn4.csv', rthor_data400__key__sanctn__ssn4,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__sanctn__party_aka_dba					:= DATASET(lCSVFileNamePrefix+'thor_data400__key__sanctn__'+ lCSVVersion + '__party__aka__dba.csv', rthor_data400__key__sanctn__party_aka_dba,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

EXPORT dthor_data400__key__sanctn__linkids                := DATASET([], rthor_data400__key__sanctn__linkids);
END;
	
