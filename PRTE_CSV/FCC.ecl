export FCC := 

module
			
//	shared	lSubDirName					:=	'';
//	shared	lCSVVersion					:=	'20100713';
//	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__fcc__autokey__address	:=
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

export rthor_data400__key__fcc__autokey__addressb2	:=
record
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
end;

export rthor_data400__key__fcc__autokey__citystname	:=
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

export rthor_data400__key__fcc__autokey__citystnameb2	:=
record
	unsigned4 city_code;
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__fcc__autokey__name	:=
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

export rthor_data400__key__fcc__autokey__nameb2	:=
record
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__fcc__autokey__namewords2	:=
record
	string40 word;
	string2 state;
	unsigned1 seq;
	unsigned6 bdid;
	unsigned4 lookups;
end;

addr	:=
record
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 v_city_name;
	string2 st;
	string5 zip5;
	string4 zip4;
	string2 addr_rec_type;
	string2 fips_state;
	string3 fips_county;
	string10 geo_lat;
	string11 geo_long;
	string4 cbsa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
end;

name	:=
record
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
end;

export rthor_data400__key__fcc__autokey__payload	:=
record
	unsigned6 fakeid;
	string2 name_type;
	unsigned4 party_bits;
	unsigned1 zero;
	string50 tmsid;
	unsigned6 intdid;
	unsigned6 intbdid;
	string150 cname;
	string9 ssn;
	string9 tax_id;
	addr company_addr;
	addr person_addr;
	name person_name;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__fcc__autokey__phone2	:=
record
	string7 p7;
	string3 p3;
	string6 dph_lname;
	string20 pfname;
	string2 st;
	unsigned6 did;
	unsigned4 lookups;
end;

export rthor_data400__key__fcc__autokey__phoneb2	:=
record
	string7 p7;
	string3 p3;
	string40 cname_indic;
	string40 cname_sec;
	string2 st;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__fcc__autokey__stname	:=
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

export rthor_data400__key__fcc__autokey__stnameb2	:=
record
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__fcc__autokey__zip	:=
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

export rthor_data400__key__fcc__autokey__zipb2	:=
record
	integer4 zip;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;
	
export rthor_data400__key__fcc__bdid	:=
	record
	unsigned6 bdid;
	unsigned6 fcc_seq;
end;

export rthor_data400__key__fcc__dictindx3	:=
record
  string20 word;
  unsigned4 nominal;
  unsigned4 suffix;
  unsigned8 freq;
  unsigned8 docfreq;
  unsigned1 typ;
  string128 fullword;
  unsigned8 fpos;
end;

export rthor_data400__key__fcc__did	:=
record
 unsigned8 did;
 unsigned6 fcc_seq;
end;

export rthor_data400__key__fcc__docref	:=
record
	unsigned2 src;
	unsigned6 doc;
end;

export rthor_data400__key__fcc__dtldictx := 
record
	string20 word;
  unsigned4 nominal;
  unsigned4 suffix;
  unsigned8 freq;
  unsigned8 docfreq;
  unsigned1 typ;
  string128 fullword;
  unsigned8 fpos;
end;

string text_search__types__externalkey := string{maxlength(255)};

export rthor_data400__key__fcc__exkeyi := 
record
  unsigned8 hashkey;
  unsigned2 part;
  unsigned2 src;
  unsigned6 doc;
  text_search__types__externalkey externalkey;
  unsigned8 __internal_fpos__;
end;

string text_search__types__externalkey := string{maxlength(255)};

export rthor_data400__key__fcc__exkeyo := 
record
  unsigned2 src;
  unsigned6 doc;
  text_search__types__externalkey externalkey;
  unsigned8 __internal_fpos__;
end;

detailed := 
record
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
  END;

export rthor_data400__key__fcc__linkids := 
record
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
  unsigned6 licensee_bdid;
  unsigned6 dba_bdid;
  unsigned6 firm_bdid;
  unsigned6 attention_did;
  unsigned6 fcc_seq;
  string8 process_date;
  string3 license_type;
  string15 file_number;
  string10 callsign_of_license;
  string2 radio_service_code;
  string50 licensees_name;
  string35 licensees_attention_line;
  string40 dba_name;
  string50 licensees_street;
  string20 licensees_city;
  string2 licensees_state;
  string9 licensees_zip;
  string10 licensees_phone;
  string8 date_application_received_at_fcc;
  string8 date_license_issued;
  string8 date_license_expires;
  string8 date_of_last_change;
  string1 type_of_last_change;
  string6 latitude;
  string7 longitude;
  string50 transmitters_street;
  string20 transmitters_city;
  string30 transmitters_county;
  string2 transmitters_state;
  string8 transmitters_antenna_height;
  string8 transmitters_height_above_avg_terra;
  string8 transmitters_height_above_ground_le;
  string9 power_of_this_frequency;
  string17 frequency_mhz;
  string5 class_of_station;
  string9 number_of_units_authorized_on_freq;
  string9 effective_radiated_power;
  string45 emissions_codes;
  string30 frequency_coordination_number;
  string2 paging_license_status;
  string50 control_point_for_the_system;
  string1 pending_or_granted;
  string40 firm_preparing_application;
  string40 contact_firms_street_address;
  string40 contact_firms_city;
  string2 contact_firms_state;
  string9 contact_firms_zipcode;
  string10 contact_firms_phone_number;
  string10 contact_firms_fax_number;
  string50 unique_key;
  string5 attention_title;
  string20 attention_fname;
  string20 attention_mname;
  string20 attention_lname;
  string5 attention_name_suffix;
  string3 attention_name_score;
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
  string50 clean_licensees_name;
  string50 clean_dba_name;
  string50 clean_firm_name;
  detailed firm;
  unsigned8 source_rec_id;
  integer1 fp;
end;

export rthor_data400__key__fcc__nidx3 := 
record
  unsigned1 typ;
  unsigned4 nominal;
  unsigned2 lseg;
  unsigned2 part;
  unsigned2 src;
  unsigned6 doc;
  unsigned2 seg;
  unsigned4 kwp;
  unsigned2 wip;
  unsigned4 suffix;
  unsigned2 sect;
  unsigned8 fpos;
end;

detailed :=
record
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
  END;

export rthor_data400__key__fcc__seq := 
record
  unsigned6 fcc_seq;
  unsigned6 licensee_bdid;
  unsigned6 dba_bdid;
  unsigned6 firm_bdid;
  unsigned6 attention_did;
  string8 process_date;
  string3 license_type;
  string15 file_number;
  string10 callsign_of_license;
  string2 radio_service_code;
  string50 licensees_name;
  string35 licensees_attention_line;
  string40 dba_name;
  string50 licensees_street;
  string20 licensees_city;
  string2 licensees_state;
  string9 licensees_zip;
  string10 licensees_phone;
  string8 date_application_received_at_fcc;
  string8 date_license_issued;
  string8 date_license_expires;
  string8 date_of_last_change;
  string1 type_of_last_change;
  string6 latitude;
  string7 longitude;
  string50 transmitters_street;
  string20 transmitters_city;
  string30 transmitters_county;
  string2 transmitters_state;
  string8 transmitters_antenna_height;
  string8 transmitters_height_above_avg_terra;
  string8 transmitters_height_above_ground_le;
  string9 power_of_this_frequency;
  string17 frequency_mhz;
  string5 class_of_station;
  string9 number_of_units_authorized_on_freq;
  string9 effective_radiated_power;
  string45 emissions_codes;
  string30 frequency_coordination_number;
  string2 paging_license_status;
  string50 control_point_for_the_system;
  string1 pending_or_granted;
  string40 firm_preparing_application;
  string40 contact_firms_street_address;
  string40 contact_firms_city;
  string2 contact_firms_state;
  string9 contact_firms_zipcode;
  string10 contact_firms_phone_number;
  string10 contact_firms_fax_number;
  string50 unique_key;
  string5 attention_title;
  string20 attention_fname;
  string20 attention_mname;
  string20 attention_lname;
  string5 attention_name_suffix;
  string3 attention_name_score;
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
  string50 clean_licensees_name;
  string50 clean_dba_name;
  string50 clean_firm_name;
  detailed firm;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__fcc__xdstat2 := 
record
  integer1 f;
  unsigned8 maxdocfreq;
  unsigned8 maxfreq;
  integer8 meandocsize;
  integer8 uniquenominals;
  integer8 doccount;
  unsigned8 fpos;
end;

export rthor_data400__key__fcc__xseglist := 
record
  integer1 f;
  string segname{maxlength(128)};
  unsigned1 segtype;
  set of unsigned2 seglist{maxcount(64)};
  unsigned8 fpos;
end;

export dthor_data400__key__fcc__autokey__address 			:= dataset([],rthor_data400__key__fcc__autokey__address);
export dthor_data400__key__fcc__autokey__addressb2 		:= dataset([],rthor_data400__key__fcc__autokey__addressb2);
export dthor_data400__key__fcc__autokey__citystname 	:= dataset([],rthor_data400__key__fcc__autokey__citystname);
export dthor_data400__key__fcc__autokey__citystnameb2	:= dataset([],rthor_data400__key__fcc__autokey__citystnameb2);
export dthor_data400__key__fcc__autokey__name 				:= dataset([],rthor_data400__key__fcc__autokey__name);
export dthor_data400__key__fcc__autokey__nameb2 			:= dataset([],rthor_data400__key__fcc__autokey__nameb2);
export dthor_data400__key__fcc__autokey__namewords2 	:= dataset([],rthor_data400__key__fcc__autokey__namewords2);
export dthor_data400__key__fcc__autokey__payload 			:= dataset([],rthor_data400__key__fcc__autokey__payload);
export dthor_data400__key__fcc__autokey__phone2 			:= dataset([],rthor_data400__key__fcc__autokey__phone2);
export dthor_data400__key__fcc__autokey__phoneb2 			:= dataset([],rthor_data400__key__fcc__autokey__phoneb2);
export dthor_data400__key__fcc__autokey__stname 			:= dataset([],rthor_data400__key__fcc__autokey__stname);
export dthor_data400__key__fcc__autokey__stnameb2 		:= dataset([],rthor_data400__key__fcc__autokey__stnameb2);
export dthor_data400__key__fcc__autokey__zip 					:= dataset([],rthor_data400__key__fcc__autokey__zip);
export dthor_data400__key__fcc__autokey__zipb2 				:= dataset([],rthor_data400__key__fcc__autokey__zipb2);
export dthor_data400__key__fcc__bdid 									:= dataset([],rthor_data400__key__fcc__bdid);
export dthor_data400__key__fcc__dictindx3 						:= dataset([],rthor_data400__key__fcc__dictindx3);
export dthor_data400__key__fcc__did 									:= dataset([],rthor_data400__key__fcc__did);
export dthor_data400__key__fcc__docref 								:= dataset([],rthor_data400__key__fcc__docref);
export dthor_data400__key__fcc__dtldictx 							:= dataset([],rthor_data400__key__fcc__dtldictx);
export dthor_data400__key__fcc__exkeyi 								:= dataset([],rthor_data400__key__fcc__exkeyi);
export dthor_data400__key__fcc__exkeyo 								:= dataset([],rthor_data400__key__fcc__exkeyo);
export dthor_data400__key__fcc__linkids								:= dataset([],rthor_data400__key__fcc__linkids);
export dthor_data400__key__fcc__nidx3 								:= dataset([],rthor_data400__key__fcc__nidx3);
export dthor_data400__key__fcc__seq 									:= dataset([],rthor_data400__key__fcc__seq);
export dthor_data400__key__fcc__xdstat2 							:= dataset([],rthor_data400__key__fcc__xdstat2);
export dthor_data400__key__fcc__xseglist 							:= dataset([],rthor_data400__key__fcc__xseglist);
end;