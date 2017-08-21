/*2013-05-23T19:25:07Z (Audra Mireles)
Chankged for BIP2 project.
*/
import	_control;

export Proc_Build_Utility_Keys(string pIndexVersion) := function

arecord1:= RECORD
  string28 prim_name;
  string2 st;
  string5 zip;
  string10 prim_range;
  string8 sec_range;
  string15 id;
  string10 exchange_serial_number;
  string8 date_added_to_exchange;
  string8 connect_date;
  string8 date_first_seen;
  string8 record_date;
  string10 util_type;
  string25 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string5 orig_name_suffix;
  string1 addr_type;
  string1 addr_dual;
  string10 address_street;
  string100 address_street_name;
  string5 address_street_type;
  string2 address_street_direction;
  string10 address_apartment;
  string20 address_city;
  string2 address_state;
  string10 address_zip;
  string9 ssn;
  string10 work_phone;
  string10 phone;
  string8 dob;
  string2 drivers_license_state_code;
  string22 drivers_license;
  string2 predir;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string25 p_city_name;
  string25 v_city_name;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  unsigned8 __internal_fpos__;
 END;

arecord2:= RECORD
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
 END;

arecord3:= RECORD
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
 END;

arecord4:= RECORD
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
 END;

arecord5:= RECORD
  string7 p7;
  string3 p3;
  string6 dph_lname;
  string20 pfname;
  string2 st;
  unsigned6 did;
 END;
 
arecord6:= RECORD
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
 END;
 
arecord7:= RECORD
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
 END;
 
arecord8:= RECORD
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
 END;
 
arecord9:= RECORD
  unsigned6 fdid;
  string15 id;
  string10 exchange_serial_number;
  string8 date_added_to_exchange;
  string8 connect_date;
  string8 date_first_seen;
  string8 record_date;
  string10 util_type;
  string25 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string5 orig_name_suffix;
  string1 addr_type;
  string1 addr_dual;
  string10 address_street;
  string100 address_street_name;
  string5 address_street_type;
  string2 address_street_direction;
  string10 address_apartment;
  string20 address_city;
  string2 address_state;
  string10 address_zip;
  string9 ssn;
  string10 work_phone;
  string10 phone;
  string8 dob;
  string2 drivers_license_state_code;
  string22 drivers_license;
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
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  unsigned6 hhid;
 END;
 
arecord10:= RECORD
  unsigned6 s_did;
  string15 id;
  string10 exchange_serial_number;
  string8 date_added_to_exchange;
  string8 connect_date;
  string8 date_first_seen;
  string8 record_date;
  string10 util_type;
  string25 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string5 orig_name_suffix;
  string1 addr_type;
  string1 addr_dual;
  string10 address_street;
  string100 address_street_name;
  string5 address_street_type;
  string2 address_street_direction;
  string10 address_apartment;
  string20 address_city;
  string2 address_state;
  string10 address_zip;
  string9 ssn;
  string10 work_phone;
  string10 phone;
  string8 dob;
  string2 drivers_license_state_code;
  string22 drivers_license;
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
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  unsigned6 fdid;
  unsigned6 hhid;
 END;
 
arecord11:= RECORD
  integer4 zip;
  string10 prim_range;
  string20 lname;
  unsigned4 lookups;
  unsigned6 did;
 END;
 
arecord12:= RECORD  
	data16 hval; 
	unsigned8 __internal_fpos__ ;
 END;

arecord13:= RECORD
  string28 prim_name;
  string2 st;
  string5 zip;
  string10 prim_range;
  string8 sec_range;
  string15 id;
  string10 exchange_serial_number;
  string8 date_added_to_exchange;
  string8 connect_date;
  string8 date_first_seen;
  string8 record_date;
  string10 util_type;
  string25 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string5 orig_name_suffix;
  string1 addr_type;
  string1 addr_dual;
  string10 address_street;
  string100 address_street_name;
  string5 address_street_type;
  string2 address_street_direction;
  string10 address_apartment;
  string20 address_city;
  string2 address_state;
  string10 address_zip;
  string9 ssn;
  string10 work_phone;
  string10 phone;
  string8 dob;
  string2 drivers_license_state_code;
  string22 drivers_license;
  string1 csa_indicator;
  string2 predir;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string25 p_city_name;
  string25 v_city_name;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string100 company_name;
  string12 bdid;
  string2 source;
  unsigned8 __internal_fpos__;
 END;
 
arecord14:= RECORD
  unsigned6 bdid;
  string15 id;
  string10 exchange_serial_number;
  string8 date_added_to_exchange;
  string8 connect_date;
  string8 date_first_seen;
  string8 record_date;
  string10 util_type;
  string25 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string5 orig_name_suffix;
  string1 addr_type;
  string1 addr_dual;
  string10 address_street;
  string100 address_street_name;
  string5 address_street_type;
  string2 address_street_direction;
  string10 address_apartment;
  string20 address_city;
  string2 address_state;
  string10 address_zip;
  string9 ssn;
  string10 work_phone;
  string10 phone;
  string8 dob;
  string2 drivers_license_state_code;
  string22 drivers_license;
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
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  unsigned6 fdid;
  unsigned6 hhid;
  string100 company_name;
  string1 co_flag;
  unsigned8 __internal_fpos__;
 END;
 
arecord15:= RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
arecord16:= RECORD
  string15 id;
  string10 exchange_serial_number;
  string8 date_added_to_exchange;
  string8 connect_date;
  string8 date_first_seen;
  string8 record_date;
  string10 util_type;
  string25 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string5 orig_name_suffix;
  string1 addr_type;
  string1 addr_dual;
  string10 address_street;
  string100 address_street_name;
  string5 address_street_type;
  string2 address_street_direction;
  string10 address_apartment;
  string20 address_city;
  string2 address_state;
  string10 address_zip;
  string9 ssn;
  string10 work_phone;
  string10 phone;
  string8 dob;
  string2 drivers_license_state_code;
  string22 drivers_license;
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
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  unsigned6 fdid;
  unsigned6 hhid;
  string100 company_name;
  string1 co_flag;
  unsigned6 bdid;
 END;
 
arecord17:= RECORD
  unsigned6 fakeid;
  string15 id;
  string10 exchange_serial_number;
  string8 date_added_to_exchange;
  string8 connect_date;
  string8 date_first_seen;
  string8 record_date;
  string10 util_type;
  string25 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string5 orig_name_suffix;
  string1 addr_type;
  string1 addr_dual;
  string10 address_street;
  string100 address_street_name;
  string5 address_street_type;
  string2 address_street_direction;
  string10 address_apartment;
  string20 address_city;
  string2 address_state;
  string10 address_zip;
  string9 ssn;
  string10 work_phone;
  string10 phone;
  string8 dob;
  string2 drivers_license_state_code;
  string22 drivers_license;
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
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  unsigned6 fdid;
  unsigned6 hhid;
  string100 company_name;
  string1 co_flag;
  unsigned6 bdid;
  integer8 zero;
  string blank;
  unsigned8 __internal_fpos__;
 END;
 
arecord18:= RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
arecord19:= RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
arecord20:= RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
arecord21:= RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
arecord22:= RECORD
  string7 p7;
  string3 p3;
  string40 cname_indic;
  string40 cname_sec;
  string2 st;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
arecord23:= RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
arecord24:= RECORD
  unsigned6 s_did;
  string15 id;
  string10 exchange_serial_number;
  string8 date_added_to_exchange;
  string8 connect_date;
  string8 date_first_seen;
  string8 record_date;
  string10 util_type;
  string25 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string5 orig_name_suffix;
  string1 addr_type;
  string1 addr_dual;
  string10 address_street;
  string100 address_street_name;
  string5 address_street_type;
  string2 address_street_direction;
  string10 address_apartment;
  string20 address_city;
  string2 address_state;
  string10 address_zip;
  string9 ssn;
  string10 work_phone;
  string10 phone;
  string8 dob;
  string2 drivers_license_state_code;
  string22 drivers_license;
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
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  unsigned8 __internal_fpos__;
 END;

arecord25:= RECORD
  data16 hval;
  unsigned3 startdate;
  unsigned3 enddate;
  string2 state;
  unsigned8 __internal_fpos__;
 END;
 
arecord26:= RECORD
  data16 hval;
  unsigned4 startdate;
  unsigned4 enddate;
  string2 state;
  unsigned8 __internal_fpos__;
 END;
 
arecord27:= RECORD
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
  string15 id;
  string10 exchange_serial_number;
  string8 date_added_to_exchange;
  string8 connect_date;
  string8 date_first_seen;
  string8 record_date;
  string10 util_type;
  string25 orig_lname;
  string20 orig_fname;
  string20 orig_mname;
  string5 orig_name_suffix;
  string1 addr_type;
  string1 addr_dual;
  string10 address_street;
  string100 address_street_name;
  string5 address_street_type;
  string2 address_street_direction;
  string10 address_apartment;
  string20 address_city;
  string2 address_state;
  string10 address_zip;
  string9 ssn;
  string10 work_phone;
  string10 phone;
  string8 dob;
  string2 drivers_license_state_code;
  string22 drivers_license;
  string1 csa_indicator;
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
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string100 company_name;
  string12 bdid;
  unsigned1 bdid_score;
  string2 source;
  unsigned8 source_rec_id;
  integer1 fp;
 END;
 
return	sequential(
					parallel(	
							buildindex(index(dataset([],arecord1),{prim_name,st,zip,prim_range,sec_range},{dataset([],arecord1)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::address',update);
							buildindex(index(dataset([],arecord2),{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{dataset([],arecord2)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily.address',update);
							buildindex(index(dataset([],arecord3),{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord3)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily.citystname',update);
							buildindex(index(dataset([],arecord4),{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord4)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily.name',update);
							buildindex(index(dataset([],arecord5),{p7,p3,dph_lname,pfname,st},{dataset([],arecord5)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily.phone',update);
							buildindex(index(dataset([],arecord6),{s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname},{dataset([],arecord6)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily.ssn',update);
							buildindex(index(dataset([],arecord7),{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord7)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily.stname',update);
							buildindex(index(dataset([],arecord8),{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord8)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily.zip',update);
							buildindex(index(dataset([],arecord9),{fdid},{dataset([],arecord9)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily.fid',update);
							buildindex(index(dataset([],arecord10),{s_did},{dataset([],arecord10)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily.did',update);
							buildindex(index(dataset([],arecord11),{zip,prim_range,lname,lookups},{dataset([],arecord11)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily.zipprlname',update);
							buildindex(index(dataset([],arecord12),{hval},{dataset([],arecord12)},'keyname')
													,'~prte::key::md5::' + pIndexVersion + '::ssn',update);
							buildindex(index(dataset([],arecord13),{prim_name,st,zip,prim_range,sec_range},{dataset([],arecord13)},'keyname')
													,'~prte::key::utility::bus::' + pIndexVersion + '::address',update);
							buildindex(index(dataset([],arecord14),{bdid,id},{dataset([],arecord14)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily::bus::bdid',update);
							buildindex(index(dataset([],arecord15),{zip,cname_indic,cname_sec,bdid},{dataset([],arecord15)},'keyname')
													,'~prte::key::utility::daily::bus::' + pIndexVersion + '::autokey::zipb2',update);
							buildindex(index(dataset([],arecord16),{id},{dataset([],arecord16)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::daily::bus::id',update);
							buildindex(index(dataset([],arecord17),{fakeid},{dataset([],arecord17)},'keyname')
													,'~prte::key::utility::daily::bus::' + pIndexVersion + '::autokey::payload',update);
							buildindex(index(dataset([],arecord18),{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},{dataset([],arecord18)},'keyname')
													,'~prte::key::utility::daily::bus::' + pIndexVersion + '::autokey::addressb2',update);
							buildindex(index(dataset([],arecord19),{city_code,st,cname_indic,cname_sec,bdid},{dataset([],arecord19)},'keyname')
													,'~prte::key::utility::daily::bus::' + pIndexVersion + '::autokey::citystnameb2',update);
							buildindex(index(dataset([],arecord20),{cname_indic,cname_sec,bdid},{dataset([],arecord20)},'keyname')
													,'~prte::key::utility::daily::bus::' + pIndexVersion + '::autokey::nameb2',update);
							buildindex(index(dataset([],arecord21),{word,state,seq,bdid},{dataset([],arecord21)},'keyname')
													,'~prte::key::utility::daily::bus::' + pIndexVersion + '::autokey::namewords2',update);
							buildindex(index(dataset([],arecord22),{p7,p3,cname_indic,cname_sec,st,bdid},{dataset([],arecord22)},'keyname')
													,'~prte::key::utility::daily::bus::' + pIndexVersion + '::autokey::phoneb2',update);
							buildindex(index(dataset([],arecord23),{st,cname_indic,cname_sec,bdid},{dataset([],arecord23)},'keyname')
													,'~prte::key::utility::daily::bus::' + pIndexVersion + '::autokey::stnameb2',update);
							buildindex(index(dataset([],arecord24),{s_did},{dataset([],arecord24)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::did',update);
							buildindex(index(dataset([],arecord25),{hval},{dataset([],arecord25)},'keyname')
													,'~prte::key::misc2b::' + pIndexVersion + '::hval',update);
							buildindex(index(dataset([],arecord26),{hval},{dataset([],arecord26)},'keyname')
													,'~prte::key::datecorrect::' + pIndexVersion + '::hval',update);
						  buildindex(index(dataset([],arecord27),{ultid,orgid,seleid,proxid,powid,empid,dotid},{dataset([],arecord27)},'keyname')
													,'~prte::key::utility::' + pIndexVersion + '::linkids',update)
						  																	 ),
						PRTE.UpdateVersion('UtilityDailyKeys',			       	//	Package name
						  							pIndexVersion,											//	Package version
							  						_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
														 'B',																//	B = Boca, A = Alpharetta
														 'N',																//	N = Non-FCRA, F = FCRA
														 'N'));															//	N = Do not also include boolean, Y = Include boolean, too
end;
 
	