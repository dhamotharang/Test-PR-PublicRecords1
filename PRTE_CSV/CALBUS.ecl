export CALBUS :=
 
module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20110124';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__calbus_autokey_addressb2	:=
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

export rthor_data400__key__calbus_autokey_citystnameb2	:=
record
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
end;

export rthor_data400__key__calbus_autokey_nameb2	:=
record
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
end;

base	:=
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

export rthor_data400__key__calbus_autokey_payload	:=
record
  unsigned6 fakeid;
  unsigned6 bdid;
  unsigned6 did;
  string13 account_number;
  string50 firm_name;
  string50 owner_name;
  Base addr;
  name ownercleanname;
  unsigned6 zero;
  string1 blank;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__calbus_autokey_zipb2	:=
record
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
end;

export rthor_data400__key__calbus_autokey_stnameb2	:=
record
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
end;

export rthor_data400__key__calbus_autokey_namewords2	:=
record
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
end;

export rthor_data400__key__calbus_autokey_name	:=
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

export rthor_data400__key__calbus_autokey_address	:=
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

export rthor_data400__key__calbus_autokey_stname	:=
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

export rthor_data400__key__calbus_autokey_citystname	:=
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

export rthor_data400__key__calbus_autokey_zip	:=
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

export rthor_data400__key__calbus_account_nbr	:=
record
  string13 account_number;
  unsigned6 did;
  unsigned1 did_score;
  string9 ssn;
  unsigned6 bdid;
  string8 process_date;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string3 district_branch;
  string3 district;
  string4 tax_code_full;
  string50 firm_name;
  string50 owner_name;
  string40 business_street;
  string30 business_city;
  string2 business_state;
  string5 business_zip_5;
  string4 business_zip_plus_4;
  string7 business_foreign_zip;
  string35 business_country_name;
  string40 mailing_street;
  string30 mailing_city;
  string2 mailing_state;
  string5 mailing_zip_5;
  string4 mailing_zip_plus_4;
  string7 mailing_foreign_zip;
  string35 mailing_country_name;
  string8 start_date;
  string5 industry_code;
  string6 naics_code;
  string2 county_code;
  string3 city_code;
  string1 ownership_code;
  string45 tax_code_full_desc;
  string100 industry_code_desc;
  string40 county_code_desc;
  string40 ownership_code_desc;
  string10 business_prim_range;
  string2 business_predir;
  string28 business_prim_name;
  string4 business_addr_suffix;
  string2 business_postdir;
  string10 business_unit_desig;
  string8 business_sec_range;
  string25 business_p_city_name;
  string25 business_v_city_name;
  string2 business_st;
  string5 business_zip5;
  string4 business_zip4;
  string4 business_cart;
  string1 business_cr_sort_sz;
  string4 business_lot;
  string1 business_lot_order;
  string2 business_dpbc;
  string1 business_chk_digit;
  string2 business_addr_rec_type;
  string2 business_fips_state;
  string3 business_fips_county;
  string10 business_geo_lat;
  string11 business_geo_long;
  string4 business_cbsa;
  string7 business_geo_blk;
  string1 business_geo_match;
  string4 business_err_stat;
  string10 mailing_prim_range;
  string2 mailing_predir;
  string28 mailing_prim_name;
  string4 mailing_addr_suffix;
  string2 mailing_postdir;
  string10 mailing_unit_desig;
  string8 mailing_sec_range;
  string25 mailing_p_city_name;
  string25 mailing_v_city_name;
  string2 mailing_st;
  string5 mailing_zip5;
  string4 mailing_zip4;
  string4 mailing_cart;
  string1 mailing_cr_sort_sz;
  string4 mailing_lot;
  string1 mailing_lot_order;
  string2 mailing_dpbc;
  string1 mailing_chk_digit;
  string2 mailing_addr_rec_type;
  string2 mailing_fips_state;
  string3 mailing_fips_county;
  string10 mailing_geo_lat;
  string11 mailing_geo_long;
  string4 mailing_cbsa;
  string7 mailing_geo_blk;
  string1 mailing_geo_match;
  string4 mailing_err_stat;
  string5 owner_title;
  string20 owner_fname;
  string20 owner_mname;
  string20 owner_lname;
  string5 owner_name_suffix;
  string3 owner_name_score;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__calbus_bdid	:= 
record
	unsigned6 bdid;
	string13 account_number;
	unsigned8 __internal_fpos__ ;
end;

export rthor_data400__key__calbus_dictindx3	:=
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

export rthor_data400__key__calbus_doc_accnumber	:=
record
  unsigned2 src;
  unsigned6 doc;
  string13 account_number;
  unsigned8 __filepos;
end;

export rthor_data400__key__calbus_dtldictx	:=
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

string text_search__externalkey := string{maxLength(255)};

export rthor_data400__key__calbus_exkeyi	:=
record
  unsigned8 hashkey;
  unsigned2 part;
  unsigned2 src;
  unsigned6 doc;
  text_search__externalkey externalkey;
  unsigned8 __internal_fpos__;
end;

string text_search__externalkey := string{maxLength(255)};

export rthor_data400__key__calbus_exkeyo	:=
record
  unsigned2 src;
  unsigned6 doc;
  text_search__externalkey externalkey;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__calbus_linkids	:=
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
  unsigned6 did;
  unsigned1 did_score;
  string9 ssn;
  unsigned8 source_rec_id;
  unsigned6 bdid;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned8 mail_raw_aid;
  unsigned8 mail_ace_aid;
  string100 prep_addr_line1;
  string50 prep_addr_line_last;
  string100 prep_mail_addr_line1;
  string50 prep_mail_addr_line_last;
  string8 process_date;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string3 district_branch;
  string13 account_number;
  string3 district;
  string4 tax_code_full;
  string50 firm_name;
  string50 owner_name;
  string40 business_street;
  string30 business_city;
  string2 business_state;
  string5 business_zip_5;
  string4 business_zip_plus_4;
  string7 business_foreign_zip;
  string35 business_country_name;
  string40 mailing_street;
  string30 mailing_city;
  string2 mailing_state;
  string5 mailing_zip_5;
  string4 mailing_zip_plus_4;
  string7 mailing_foreign_zip;
  string35 mailing_country_name;
  string8 start_date;
  string5 industry_code;
  string6 naics_code;
  string2 county_code;
  string3 city_code;
  string1 ownership_code;
  string45 tax_code_full_desc;
  string100 industry_code_desc;
  string40 county_code_desc;
  string40 ownership_code_desc;
  string10 business_prim_range;
  string2 business_predir;
  string28 business_prim_name;
  string4 business_addr_suffix;
  string2 business_postdir;
  string10 business_unit_desig;
  string8 business_sec_range;
  string25 business_p_city_name;
  string25 business_v_city_name;
  string2 business_st;
  string5 business_zip5;
  string4 business_zip4;
  string4 business_cart;
  string1 business_cr_sort_sz;
  string4 business_lot;
  string1 business_lot_order;
  string2 business_dpbc;
  string1 business_chk_digit;
  string2 business_addr_rec_type;
  string2 business_fips_state;
  string3 business_fips_county;
  string10 business_geo_lat;
  string11 business_geo_long;
  string4 business_cbsa;
  string7 business_geo_blk;
  string1 business_geo_match;
  string4 business_err_stat;
  string10 mailing_prim_range;
  string2 mailing_predir;
  string28 mailing_prim_name;
  string4 mailing_addr_suffix;
  string2 mailing_postdir;
  string10 mailing_unit_desig;
  string8 mailing_sec_range;
  string25 mailing_p_city_name;
  string25 mailing_v_city_name;
  string2 mailing_st;
  string5 mailing_zip5;
  string4 mailing_zip4;
  string4 mailing_cart;
  string1 mailing_cr_sort_sz;
  string4 mailing_lot;
  string1 mailing_lot_order;
  string2 mailing_dpbc;
  string1 mailing_chk_digit;
  string2 mailing_addr_rec_type;
  string2 mailing_fips_state;
  string3 mailing_fips_county;
  string10 mailing_geo_lat;
  string11 mailing_geo_long;
  string4 mailing_cbsa;
  string7 mailing_geo_blk;
  string1 mailing_geo_match;
  string4 mailing_err_stat;
  string5 owner_title;
  string20 owner_fname;
  string20 owner_mname;
  string20 owner_lname;
  string5 owner_name_suffix;
  string3 owner_name_score;
  integer1 fp;
end;

export rthor_data400__key__calbus_nidx3	:=
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

export rthor_data400__key__calbus_xdstat2	:=
record
  integer1 f;
  unsigned8 maxdocfreq;
  unsigned8 maxfreq;
  integer8 meandocsize;
  integer8 uniquenominals;
  integer8 doccount;
  unsigned8 fpos;
end;

export rthor_data400__key__calbus_xseglist	:=
record
  integer1 f;
  string segname{maxLength(128)};
  unsigned1 segtype;
  set of unsigned2 seglist{maxCount(64)};
  unsigned8 fpos;
end;

export dthor_data400__key__calbus_autokey_addressb2			:= dataset([], rthor_data400__key__calbus_autokey_addressb2);
export dthor_data400__key__calbus_autokey_citystnameb2	:= dataset([], rthor_data400__key__calbus_autokey_citystnameb2);
export dthor_data400__key__calbus_autokey_nameb2				:= dataset([], rthor_data400__key__calbus_autokey_nameb2);
export dthor_data400__key__calbus_autokey_payload				:= dataset([], rthor_data400__key__calbus_autokey_payload);
export dthor_data400__key__calbus_autokey_zipb2					:= dataset([], rthor_data400__key__calbus_autokey_zipb2);
export dthor_data400__key__calbus_autokey_stnameb2			:= dataset([], rthor_data400__key__calbus_autokey_stnameb2);
export dthor_data400__key__calbus_autokey_namewords2		:= dataset([], rthor_data400__key__calbus_autokey_namewords2);
export dthor_data400__key__calbus_autokey_name					:= dataset([], rthor_data400__key__calbus_autokey_name);
export dthor_data400__key__calbus_autokey_address				:= dataset([], rthor_data400__key__calbus_autokey_address);
export dthor_data400__key__calbus_autokey_stname				:= dataset([], rthor_data400__key__calbus_autokey_stname);
export dthor_data400__key__calbus_autokey_citystname		:= dataset([], rthor_data400__key__calbus_autokey_citystname);
export dthor_data400__key__calbus_autokey_zip						:= dataset([], rthor_data400__key__calbus_autokey_zip);
export dthor_data400__key__calbus_account_nbr						:= dataset([], rthor_data400__key__calbus_account_nbr);
export dthor_data400__key__calbus_bdid									:= dataset([], rthor_data400__key__calbus_bdid);
export dthor_data400__key__calbus_dictindx3							:= dataset([], rthor_data400__key__calbus_dictindx3);
export dthor_data400__key__calbus_doc_accnumber					:= dataset([], rthor_data400__key__calbus_doc_accnumber);
export dthor_data400__key__calbus_dtldictx							:= dataset([], rthor_data400__key__calbus_dtldictx);
export dthor_data400__key__calbus_exkeyi								:= dataset([], rthor_data400__key__calbus_exkeyi);
export dthor_data400__key__calbus_exkeyo								:= dataset([], rthor_data400__key__calbus_exkeyo);
export dthor_data400__key__calbus_linkids 							:= dataset([], rthor_data400__key__calbus_linkids);
export dthor_data400__key__calbus_nidx3									:= dataset([], rthor_data400__key__calbus_nidx3);
export dthor_data400__key__calbus_xdstat2								:= dataset([], rthor_data400__key__calbus_xdstat2);
export dthor_data400__key__calbus_xseglist							:= dataset([], rthor_data400__key__calbus_xseglist);

end;