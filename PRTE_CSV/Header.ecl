IMPORT PRTE2_Common;

export Header := 

module
	SHARED Add_Foreign_prod					:= PRTE2_Common.Constants.Add_Foreign_prod; // a function

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20110201';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	shared	lSubDirName4					:=	'';
	shared	lCSVVersion4					:=	'20080923';
	shared	lCSVFileNamePrefix4	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	shared	lSubDirName1					:=	'';
	shared	lCSVVersion1					:=	'20090706';
	shared	lCSVFileNamePrefix1	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

	shared	lSubDirName2				:=	'';
	shared	lCSVVersion2					:=	'20100110';
	shared	lCSVFileNamePrefix2	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

	shared	lSubDirName3					:=	'';
	shared	lCSVVersion3					:=	'20110201';
	shared	lCSVFileNamePrefix3	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__header__hhid__did_ver	:=
record
	unsigned6 did;
	unsigned1 ver;
	unsigned6 hhid;
	unsigned6 hhid_indiv;
	unsigned6 hhid_relat;
end;

export rthor_data400__key__header__hhid__hhid_ver := { unsigned6 hhid_relat, unsigned1 ver, unsigned6 did };
	
export rthor_data400__key__header__rid_srid	:=
record
	unsigned integer6 rid;
	unsigned integer6 uid;
	string2 src;
	unsigned integer8 __internal_fpos__;
end;

export rthor_data400__key__header__adl_infutor_knowx	:=
record
	unsigned integer6 s_did;
	unsigned integer6 did;
	unsigned integer6 rid;
	string1 pflag1;
	string1 pflag2;
	string1 pflag3;
	string2 src;
	unsigned integer3 dt_first_seen;
	unsigned integer3 dt_last_seen;
	unsigned integer3 dt_vendor_last_reported;
	unsigned integer3 dt_vendor_first_reported;
	unsigned integer3 dt_nonglb_last_seen;
	string1 rec_type;
	qstring18 vendor_id;
	qstring10 phone;
	qstring9 ssn;
	integer4 dob;
	qstring5 title;
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	qstring10 prim_range;
	string2 predir;
	qstring28 prim_name;
	qstring4 suffix;
	string2 postdir;
	qstring10 unit_desig;
	qstring8 sec_range;
	qstring25 city_name;
	string2 st;
	qstring5 zip;
	qstring4 zip4;
	string3 county;
	qstring7 geo_blk;
	qstring5 cbsa;
	string1 tnt;
	string1 valid_ssn;
	string1 jflag1;
	string1 jflag2;
	string1 jflag3;
	string1 valid_dob;
	unsigned integer6 hhid;
	string18 county_name;
	string120 listed_name;
	string10 listed_phone;
	unsigned integer4 dod;
	string1 death_code;
	unsigned integer4 lookup_did;
end;

export rthor_data400__key__header__lookups_v2	:=
record
	unsigned6 did;
	unsigned2 sex_cnt;
	unsigned2 crim_cnt;
	unsigned2 ccw_cnt;
	unsigned2 head_cnt;
	unsigned2 veh_cnt;
	unsigned2 dl_cnt;
	unsigned2 rel_count;
	unsigned2 fire_count;
	unsigned2 faa_count;
	unsigned2 vess_count;
	unsigned2 prof_count;
	unsigned2 bus_count;
	unsigned2 prop_count;
	unsigned2 bk_count;
	unsigned2 prop_asses_count;
	unsigned2 prop_deeds_count;
	unsigned2 paw_count;
	unsigned2 bc_count;
	unsigned2 prov_count;
	unsigned2 sanc_count;
	unsigned6 hhid;
	string1 gender;
	unsigned2 house_size;
	unsigned2 sg_within_7;
	unsigned2 dg_within_7;
	unsigned2 ug_within_7;
	unsigned2 sg_y_8_15;
	unsigned2 dg_y_8_15;
	unsigned2 ug_y_8_15;
	unsigned2 sg_y_16_30;
	unsigned2 dg_y_16_30;
	unsigned2 ug_y_16_30;
	unsigned2 sg_o_8_15;
	unsigned2 dg_o_8_15;
	unsigned2 ug_o_8_15;
	unsigned2 sg_o_16_30;
	unsigned2 dg_o_16_30;
	unsigned2 ug_o_16_30;
	unsigned2 sg_o_30;
	unsigned2 dg_o_30;
	unsigned2 ug_o_30;
	unsigned2 sg_y_30;
	unsigned2 dg_y_30;
	unsigned2 ug_y_30;
	unsigned2 sg;
	unsigned2 dg;
	unsigned2 ug;
	unsigned2 kids;
	unsigned2 parents;
	unsigned2 corp_affil_count;
	unsigned2 comp_prop_count;
	unsigned2 phonesplus_count;
	unsigned2 nonfares_prop_count;
	unsigned2 nofares_prop_asses_count;
	unsigned2 nofares_prop_deeds_count;
	unsigned2 filler5_count;
	unsigned2 filler6_count;
	unsigned2 filler7_count;
	unsigned2 filler8_count;
	unsigned2 filler9_count;
	unsigned2 filler10_count;
end;

export rthor_data400__key__header__address	:=
record
	qstring28 prim_name;
	qstring5 zip;
	qstring10 prim_range;
	qstring8 sec_range;
	unsigned6 did;
	string2 src;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	qstring10 phone;
	qstring9 ssn;
	integer4 dob;
	qstring20 fname;
	qstring20 lname;
	string2 predir;
	qstring4 suffix;
	string2 postdir;
	qstring10 unit_desig;
	qstring25 city_name;
	string2 st;
	qstring4 zip4;
	string3 county;
	qstring7 geo_blk;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__header__apt_bldgs	:=
record
	qstring10 prim_range;
	qstring28 prim_name;
	qstring5 zip;
	qstring4 suffix;
	string2 predir;
	integer4 apt_cnt;
	integer4 did_cnt;
end;

export rthor_data400__key__header__da	:=
record
	string4 l4;
	string2 st;
	unsigned4 city_code;
	string3 f3;
	qstring20 lname;
	qstring20 fname;
	unsigned2 yob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__header__data	:=
record
	unsigned6 s_did;
	unsigned6 did;
	unsigned6 rid;
	string1 pflag1;
	string1 pflag2;
	string1 pflag3;
	string2 src;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_last_reported;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_nonglb_last_seen;
	string1 rec_type;
	qstring18 vendor_id;
	qstring10 phone;
	qstring9 ssn;
	integer4 dob;
	qstring5 title;
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	qstring10 prim_range;
	string2 predir;
	qstring28 prim_name;
	qstring4 suffix;
	string2 postdir;
	qstring10 unit_desig;
	qstring8 sec_range;
	qstring25 city_name;
	string2 st;
	qstring5 zip;
	qstring4 zip4;
	string3 county;
	qstring7 geo_blk;
	qstring5 cbsa;
	string1 tnt;
	string1 valid_ssn;
	string1 jflag1;
	string1 jflag2;
	string1 jflag3;
  unsigned8 rawaid := 0;
	string1 valid_dob;
	unsigned6 hhid;
	string18 county_name;
	string120 listed_name;
	string10 listed_phone;
	unsigned4 dod;
	string1 death_code;
	unsigned4 lookup_did;
end;

export rthor_data400__key__header__data_new	:=
record
	unsigned6 s_did;
	unsigned6 did;
	unsigned6 rid;
	string1 pflag1;
	string1 pflag2;
	string1 pflag3;
	string2 src;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_last_reported;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_nonglb_last_seen;
	string1 rec_type;
	qstring18 vendor_id;
	qstring10 phone;
	qstring9 ssn;
	integer4 dob;
	qstring5 title;
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	qstring10 prim_range;
	string2 predir;
	qstring28 prim_name;
	qstring4 suffix;
	string2 postdir;
	qstring10 unit_desig;
	qstring8 sec_range;
	qstring25 city_name;
	string2 st;
	qstring5 zip;
	qstring4 zip4;
	string3 county;
	qstring7 geo_blk;
	qstring5 cbsa;
	string1 tnt;
	string1 valid_ssn;
	string1 jflag1;
	string1 jflag2;
	string1 jflag3;
  unsigned8 rawaid := 0;
	unsigned8 persistent_record_ID:=0;
	string1 valid_dob;
	unsigned6 hhid;
	string18 county_name;
	string120 listed_name;
	string10 listed_phone;
	unsigned4 dod;
	string1 death_code;
	unsigned4 lookup_did;
end;

export rthor_data400__key__header__data_new2	:= record
  
    rthor_data400__key__header__data;
		string4         addr_suffix;  // [41..44]
		string25        p_city_name;	// [65..89]
		string25        v_city_name;  // [90..114]
		string4         cart;		// [126..129]
		string1         cr_sort_sz;	// [130]
		string4         lot;		// [131..134]
		string1         lot_order;	// [135]
		string2         dbpc;		// [136..137]
		string1         chk_digit;	// [138]
		string10        geo_lat;		// [146..155]
		string11        geo_long;	// [156..166]
		string4         msa;		// [167..170]
		string1         geo_match;	// [178]
		string4         err_stat;	// [179..182]
		unsigned6 uid := 0;
		string6 dph_lname;
		string4 l4;
		string3 f3;
		string1 s1;
		string1 s2;
		string1 s3;
		string1 s4;
		string1 s5;
		string1 s6;
		string1 s7;
		string1 s8;
		string1 s9;
		string4 ssn4;
		string5 ssn5;
		unsigned4 city_code;
		string20 pfname;
		string1 minit;
		unsigned2 yob;
		unsigned8 states;
		unsigned4 lname1;
		unsigned4 lname2;
		unsigned4 lname3;
		unsigned4 city1;
		unsigned4 city2;
		unsigned4 city3;
		unsigned4 rel_fname1;
		unsigned4 rel_fname2;
		unsigned4 rel_fname3;
		integer8 fname_count;
		string7 p7:='';
		string3 p3:='';
		unsigned5 person1:=0;
		boolean same_lname:=true;
		unsigned2 number_cohabits:=0;
		integer3 recent_cohabit:=0;
		unsigned5 person2:=0;
		unsigned1 zero:=0;
		unsigned4 lookups:=0;
		unsigned3 addr_dt_last_seen;
		qstring17 prpty_deed_id;
		qstring22 vehicle_vehnum;
		qstring22 bkrupt_crtcode_caseno;
		integer4 main_count;
		integer4 search_count;
		qstring15 dl_number;
		qstring12 bdid;
		integer4 run_date;
		integer4 total_records;
		unsigned3 addr_dt_first_seen := 0;
		string10 adl_ind := '';
		string9 s_ssn;
		unsigned8 cnt;
		boolean cellphone;
		unsigned8 persistent_record_ID:=0;
    unsigned1 rtitle :=0;

 END;

export rthor_data400__key__header__did_ssn_date := { unsigned6 did, qstring9 ssn, unsigned3 best_date };

export rthor_data400__key__header__dob	:=
record
	integer4 dob;
	string20 fname;
	string20 pfname;
	string2 st;
	string5 zip;
	unsigned6 did;
end;

export rthor_data400__key__header__dobname	:=
record
	unsigned2 yob;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	unsigned1 mob;
	unsigned1 day;
	string2 st;
	string5 zip;
	integer4 dob;
	unsigned6 did;
end;

export rthor_data400__key__header__fname_ngram	:=
record
	string3 ngram;
	string20 fname;
	string10 _count;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__header__fname_small	:=
record
	string20 pfname;
	string2 st;
	integer4 zip;
	string28 prim_name;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
	integer8 fname_count;
end;

export rthor_data400__key__header__fname_small_alt	:=
record
	string20 pfname;
	string2 st;
	qstring5 zip;
	string28 prim_name;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
	integer8 fname_count;
end;

export rthor_data400__key__header__lname_fname	:=
record
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__header__lname_fname_alt	:=
record
	string6 dph_lname;
	string20 pfname;
	string20 fname;
	string20 lname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__header__lname_ngram	:=
record
	string3 ngram;
	string20 lname;
	string10 _count;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__header__minors := { unsigned6 did, integer4 dob };

export rthor_data400__key__header__nbr	:=
record
	qstring5 zip;
	qstring28 prim_name;
	qstring4 suffix;
	string2 predir;
	string2 postdir;
	qstring10 prim_range;
	qstring8 sec_range;
	unsigned6 uid;
  unsigned8 RawAID := 0;
end;

export rthor_data400__key__header__nbr_address	:=
record
	qstring28 prim_name;
	qstring5 zip;
	qstring2 z2;
	qstring4 suffix;
	qstring10 prim_range;
	unsigned6 did;
	qstring8 sec_range;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
  unsigned8   RawAID := 0
end;

export rthor_data400__key__header__nbr_uid	:=
record
	qstring5 zip;
	qstring28 prim_name;
	qstring4 suffix;
	string2 predir;
	string2 postdir;
	unsigned6 uid;
	unsigned6 did;
	qstring10 prim_range;
	qstring8 sec_range;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned6 rid;
	string1 pflag3;
	qstring9 ssn;
	string1 tnt;
	unsigned3 dt_nonglb_last_seen;
	string2 src;
	string1 valid_ssn;
	qstring10 phone;
	qstring5 title;
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	qstring10 unit_desig;
	qstring25 city_name;
	string2 st;
	qstring4 zip4;
	string3 county;
	qstring7 geo_blk;
	integer4 dob;
	string18 county_name;
	unsigned8  RawAID := 0
end;

export rthor_data400__key__header__phone	:=
record
	string7 p7;
	string3 p3;
	string6 dph_lname;
	string20 pfname;
	string2 st;
	unsigned6 did;
end;

export rthor_data400__key__header__phonetic_fname_top10	:=
record
	string6 ph_fname;
	string20 fname;
	string10 _count;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__header__phonetic_lname	:=
record
	string6 dph_lname;
	string20 lname;
	unsigned6 name_count;
	unsigned6 did_count;
	unsigned6 pkey_count;
end;

export rthor_data400__key__header__phonetic_lname_top10	:=
record
	string6 ph_lname;
	string20 lname;
	string10 _count;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__header__pname_prange_st_city_sec_range_lname	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	string8 sec_range;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__header__pname_zip_name_range	:=
record
	string28 prim_name;
	integer4 zip;
	string6 dph_lname;
	string20 pfname;
	string10 prim_range;
	string20 lname;
	string20 fname;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

rel_title_layout := RECORD
   unsigned1 title:=44;
   unsigned8 permissions:=1;
  END;

export rthor_data400__key__header__relatives	:=
RECORD
  unsigned5 person1;
  boolean same_lname;
  unsigned2 number_cohabits;
  integer3 recent_cohabit;
  unsigned5 person2;
  integer2 prim_range;
  DATASET(rel_title_layout) rel_title;
 END;
export rthor_data400__key__header__relatives_v3 := 
RECORD
  unsigned6 did1;
  string15 type;
  string10 confidence;
  unsigned6 did2;
  integer2 cohabit_score;
  integer2 cohabit_cnt;
  integer2 coapt_score;
  integer2 coapt_cnt;
  integer2 copobox_score;
  integer2 copobox_cnt;
  integer2 cossn_score;
  integer2 cossn_cnt;
  integer2 copolicy_score;
  integer2 copolicy_cnt;
  integer2 coclaim_score;
  integer2 coclaim_cnt;
  integer2 coproperty_score;
  integer2 coproperty_cnt;
  integer2 bcoproperty_score;
  integer2 bcoproperty_cnt;
  integer2 coforeclosure_score;
  integer2 coforeclosure_cnt;
  integer2 bcoforeclosure_score;
  integer2 bcoforeclosure_cnt;
  integer2 colien_score;
  integer2 colien_cnt;
  integer2 bcolien_score;
  integer2 bcolien_cnt;
  integer2 cobankruptcy_score;
  integer2 cobankruptcy_cnt;
  integer2 bcobankruptcy_score;
  integer2 bcobankruptcy_cnt;
  integer2 covehicle_score;
  integer2 covehicle_cnt;
  integer2 coexperian_score;
  integer2 coexperian_cnt;
  integer2 cotransunion_score;
  integer2 cotransunion_cnt;
  integer2 coenclarity_score;
  integer2 coenclarity_cnt;
  integer2 coecrash_score;
  integer2 coecrash_cnt;
  integer2 bcoecrash_score;
  integer2 bcoecrash_cnt;
  integer2 cowatercraft_score;
  integer2 cowatercraft_cnt;
  integer2 coaircraft_score;
  integer2 coaircraft_cnt;
  integer2 comarriagedivorce_score;
  integer2 comarriagedivorce_cnt;
  integer2 coucc_score;
  integer2 coucc_cnt;
  integer2 lname_score;
  integer2 phone_score;
  integer2 dl_nbr_score;
  unsigned2 total_cnt;
  integer2 total_score;
  string10 cluster;
  string2 generation;
  string1 gender;
  unsigned4 lname_cnt;
  unsigned4 rel_dt_first_seen;
  unsigned4 rel_dt_last_seen;
  unsigned2 overlap_months;
  unsigned4 hdr_dt_first_seen;
  unsigned4 hdr_dt_last_seen;
  unsigned2 age_first_seen;
  boolean isanylnamematch;
  boolean isanyphonematch;
  boolean isearlylnamematch;
  boolean iscurrlnamematch;
  boolean ismixedlnamematch;
  string9 ssn1;
  string9 ssn2;
  unsigned4 dob1;
  unsigned4 dob2;
  string28 current_lname1;
  string28 current_lname2;
  string28 early_lname1;
  string28 early_lname2;
  string2 addr_ind1;
  string2 addr_ind2;
  unsigned6 r2rdid;
  unsigned6 r2cnt;
  boolean personal;
  boolean business;
  boolean other;
  unsigned1 title;
 END;
export rthor_data400__key__header__rid :=
record
	unsigned6 rid;
	unsigned6 did;
	unsigned6 first_seen;
	unsigned3 dt_nonglb_last_seen;
end;

export rthor_data400__key__header__rid_did2 := { unsigned6 rid, unsigned6 did };

export rthor_data400__key__header__ssn_did	:=
record
	string1 s1;
	string1 s2;
	string1 s3;
	string1 s4;
	string1 s5;
	string1 s6;
	string1 s7;
	string1 s8;
	string1 s9;
	string6 dph_lname;
	string20 pfname;
	unsigned6 did;
end;

export rthor_data400__key__header__ssn4_did	:=
record
	string4 ssn4;
	string20 lname;
	string20 fname;
	unsigned6 did;
end;

export rthor_data400__key__header__ssn5_did	:=
record
	string5 ssn5;
	string20 lname;
	string20 fname;
	unsigned6 did;
end;

export rthor_data400__key__header__ssn_address	:=
record
	qstring9 ssn;
	qstring28 prim_name;
	qstring20 lname;
	qstring20 fname;
	qstring20 mname;
	qstring10 prim_range;
	qstring8 sec_range;
	qstring5 zip;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__header__st_city_fname_lname	:=
record
	unsigned4 city_code;
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__header__st_fname_lname	:=
record
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 zip;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__header__zip_lname_fname	:=
record
	integer4 zip;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__header__zipprlname	:=
record
	integer4 zip;
	string10 prim_range;
	string20 lname;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__header__GeoInfo_Geolink	:=
record
 string12 geolink;
  string10 lat;
  string11 long;
end;

export rthor_data400__key__header__geoblk_latlon	:=
record
  integer4 lat1000;
  qstring12 geolink;
  real4 lat;
  real4 lon;
end;

export rthor_data400__key__header__Distance_GeoLinkToGeoLink	:=
record
  string12 geolink1;
  string12 geolink2;
  real4 distance;
end;

export rthor_data400__key__header__GeoLinkDistance_GeoLink	:=
record
  string12 geolink1;
  unsigned2 dist_100th;
  string12 geolink2;
end;

export rthor_data400__key__header__FireDepartment_geolink	:=
record
  string12 geolink;
  string90 fire_dept_name;
  string55 hq_addr1;
  string41 hq_addr2;
  string25 hq_city;
  string2 hq_state;
  string10 hq_zip;
  string52 mail_addr1;
  string41 mail_addr2;
  string23 mail_po_box;
  string24 mail_city;
  string2 mail_state;
  string10 mail_zip;
  string11 hq_phone;
  string13 hq_fax;
  string24 hq_county;
  string16 dept_type;
  string45 organization_type;
  string100 website;
  string3 number_of_stations;
  string4 active_firefighters_career;
  string4 active_firefighters_volunteer;
  string4 active_firefighters_paid_per_call;
  string4 non_firefighting_civilian;
  string4 non_firefighting_volunteer;
  string2 primary_agency_for_em;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string10 geo_lat;
  string11 geo_long;
  string7 geo_blk;
  string5 county;
  string4 msa;
  string1 geo_match;
end;

export rthor_data400__key__header__sexoffender_geolink	:=
record
  string12 geolink;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 addr_suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring25 v_city_name;
  string2 st;
  qstring5 zip5;
  qstring4 zip4;
  qstring4 cart;
  string1 cr_sort_sz;
  qstring4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  qstring5 county;
  qstring10 geo_lat;
  qstring11 geo_long;
  qstring4 msa;
  qstring7 geo_blk;
  string1 geo_match;
  qstring4 err_stat;
  unsigned1 clean_errors;
  unsigned8 did;
  string30 lname;
  string30 fname;
  string20 mname;
  string20 name_suffix;
  string50 offender_status;
  string40 offender_category;
  string10 risk_level_code;
  string8 reg_date_1;
  string125 registration_address_1;
  string8 dob;
  string8 dob_aka;
  string3 age;
  string30 race;
  string30 ethnicity;
  string10 sex;
  string40 hair_color;
  string40 eye_color;
  string3 height;
  string3 weight;
  string20 skin_tone;
  string6 addr_dt_last_seen;
  unsigned8 rawaid;
  string1 curr_incar_flag;
  string1 curr_parole_flag;
  string1 curr_probation_flag;
end;
export rthor_data400__key__header__sexoffender_geolink_alt	:=
record
  string12 geolink;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 addr_suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring25 v_city_name;
  string2 st;
  qstring5 zip5;
  qstring4 zip4;
  qstring4 cart;
  string1 cr_sort_sz;
  qstring4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  qstring5 county;
  qstring10 geo_lat;
  qstring11 geo_long;
  qstring4 msa;
  qstring7 geo_blk;
  string1 geo_match;
  qstring4 err_stat;
  unsigned1 clean_errors;
  unsigned8 did;
  string30 lname;
  string30 fname;
  string20 mname;
  string20 name_suffix;
  string50 offender_status;
  string40 offender_category;
  string10 risk_level_code;
  string8 reg_date_1;
  string125 registration_address_1;
  integer4 dob;
  string8 dob_aka;
  string3 age;
  string30 race;
  string30 ethnicity;
  string10 sex;
  string40 hair_color;
  string40 eye_color;
  string3 height;
  string3 weight;
  string20 skin_tone;
  string6 addr_dt_last_seen;
  unsigned8 rawaid;
  string1 curr_incar_flag;
  string1 curr_parole_flag;
  string1 curr_probation_flag;
end;

export dthor_data400__key__header__rid_srid 														:= dataset(lCSVFileNamePrefix + 'thor_data400__key__header__' + lCSVVersion4 + '__rid_srid.csv', rthor_data400__key__header__rid_srid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__adl_infutor_knowx 										:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__header__' + lCSVVersion1 + '__adl.infutor.knowx.csv', rthor_data400__key__header__adl_infutor_knowx, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__lookups_v2 													:= dataset(lCSVFileNamePrefix2 + 'thor_data400__key__header__' + lCSVVersion2 + '__lookups_v2.csv', rthor_data400__key__header__lookups_v2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__address 															:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__address.csv', rthor_data400__key__header__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__apt_bldgs 														:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__apt_bldgs.csv', rthor_data400__key__header__apt_bldgs, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__da 																	:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__da.csv', rthor_data400__key__header__da, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__data 																:= dataset(Add_Foreign_prod('~prte::in::header::payload'),rthor_data400__key__header__data_new2 - rtitle, flat);
export dthor_data400__key__header__did_ssn_date 												:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__did.ssn.date.csv', rthor_data400__key__header__did_ssn_date, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__dob 																	:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__dob.csv', rthor_data400__key__header__dob, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__dobname 															:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__dobname.csv', rthor_data400__key__header__dobname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__fname_ngram 													:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__fname_ngram.csv', rthor_data400__key__header__fname_ngram, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__fname_small 													:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__fname_small.csv', rthor_data400__key__header__fname_small, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__lname_fname 													:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__lname.fname.csv', rthor_data400__key__header__lname_fname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__lname_fname_alt 											:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__lname.fname_alt.csv', rthor_data400__key__header__lname_fname_alt, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__lname_ngram 													:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__lname_ngram.csv', rthor_data400__key__header__lname_ngram, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__minors 															:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__minors.csv', rthor_data400__key__header__minors, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__nbr 																	:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__nbr.csv', rthor_data400__key__header__nbr, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__nbr_address 													:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__nbr_address.csv', rthor_data400__key__header__nbr_address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__nbr_uid 															:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__nbr_uid.csv', rthor_data400__key__header__nbr_uid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__phone 																:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__phone.csv', rthor_data400__key__header__phone, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__phonetic_fname_top10 								:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__phonetic_fname_top10.csv', rthor_data400__key__header__phonetic_fname_top10, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__phonetic_lname 											:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__phonetic_lname.csv', rthor_data400__key__header__phonetic_lname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__phonetic_lname_top10 								:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__phonetic_lname_top10.csv', rthor_data400__key__header__phonetic_lname_top10, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__pname_prange_st_city_sec_range_lname := dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__pname.prange.st.city.sec_range.lname.csv', rthor_data400__key__header__pname_prange_st_city_sec_range_lname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__pname_zip_name_range 								:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__pname.zip.name.range.csv', rthor_data400__key__header__pname_zip_name_range, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__rid 																	:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__rid.csv', rthor_data400__key__header__rid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__rid_did2 														:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__rid_did2.csv', rthor_data400__key__header__rid_did2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__ssn_did 															:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__ssn.did.csv', rthor_data400__key__header__ssn_did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__ssn4_did 														:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__ssn4.did.csv', rthor_data400__key__header__ssn4_did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__ssn5_did 														:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__ssn5.did.csv', rthor_data400__key__header__ssn5_did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__ssn_address 													:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__ssn_address.csv', rthor_data400__key__header__ssn_address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__st_city_fname_lname 									:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__st.city.fname.lname.csv', rthor_data400__key__header__st_city_fname_lname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__st_fname_lname 											:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__st.fname.lname.csv', rthor_data400__key__header__st_fname_lname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__zip_lname_fname 											:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__zip.lname.fname.csv', rthor_data400__key__header__zip_lname_fname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__zipprlname 													:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__' + lCSVVersion + '__zipprlname.csv', rthor_data400__key__header__zipprlname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__hhid__did_ver 												:= dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__hhid__' + lCSVVersion + '__did.ver.csv', rthor_data400__key__header__hhid__did_ver, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__header__hhid__hhid_ver											  := dataset(lCSVFileNamePrefix3 + 'thor_data400__key__header__hhid__' + lCSVVersion + '__hhid.ver.csv', rthor_data400__key__header__hhid__hhid_ver, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;