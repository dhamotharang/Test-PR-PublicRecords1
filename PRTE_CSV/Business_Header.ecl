export Business_Header := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100713';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	shared	lSubDirNameh				:=	'';
	shared	lCSVVersionh				:=	'20061015';
	shared	lCSVFileNamePrefixh	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	shared	lCSVVersionhp				:=	'20100713d';
	shared	lCSVVersionBase			:=	'20120214';
	shared	lCSVVersionCont			:=	'20120223';
	shared	lCSVVersionpl				:=	'20120502';

export rthor_data400__key__business_header__hri__oldnpa_oldnxx	:=
record
	string3 old_npa;
	string3 old_nxx;
	string6 old_date_extablished;
	string6 permissive_end;
	string10 old_name;
	string1 old_lf;
	string3 new_npa;
	string3 new_nxx;
	string6 permissive_start;
																										string6 new_disconnect_date;
	string10 new_name;
	string1 new_lf;
	unsigned integer8 __internal_fpos__;
end;

export rthor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates	:=
record
	string3 old_npa;
	string3 old_nxx;
	string8 old_date_established;
	string8 permissive_end;
	string10 old_name;
	string1 old_lf;
	string3 new_npa;
	string3 new_nxx;
	string8 permissive_start;
	string8 new_disconnect_date;
	string10 new_name;
	boolean reverse_flag;
	string1 new_lf;
	unsigned integer8 __internal_fpos__;
end;

export rthor_data400__key__business_header__aca_institutions__address	:=
record
	string28 prim_name;
	string10 prim_range;
	string9 zip;
	string8 sec_range;
	string2 inst_type;
	string200 institution;
	string240 mail_addr;
	string30 mail_city;
	string10 mail_state;
	string9 mail_zip;
	string240 addr1;
	string30 city;
	string10 state;
	string100 notes;
	string50 name;
	string70 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string120 addr2;
	string2 predir;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 z5;
	string4 zip4;
	string10 phone;
	string10 inst_type_exp;
	string1 addr_type;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__business_header__bdl2__bdid := { unsigned6 bdid, unsigned6 bdl };

export rthor_data400__key__business_header__bdl2__bdl := { unsigned6 bdl, unsigned6 bdid, unsigned6 group_id };

export rthor_data400__key__business_header__best__filepos_data	:=
record
	unsigned6 bdid;
	unsigned4 dt_last_seen;
	qstring120 company_name;
	qstring10 prim_range;
	string2 predir;
	qstring28 prim_name;
	qstring4 addr_suffix;
	string2 postdir;
	qstring5 unit_desig;
	qstring8 sec_range;
	qstring25 city;
	string2 state;
	unsigned3 zip;
	unsigned2 zip4;
	unsigned6 phone;
	unsigned4 fein;
	unsigned1 best_flags;
	string2 source;
	string2 dppa_state;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__business_header__best__filepos_data_knowx	:=
record
	unsigned6 bdid;
	unsigned4 dt_last_seen;
	qstring120 company_name;
	qstring10 prim_range;
	string2 predir;
	qstring28 prim_name;
	qstring4 addr_suffix;
	string2 postdir;
	qstring5 unit_desig;
	qstring8 sec_range;
	qstring25 city;
	string2 state;
	unsigned3 zip;
	unsigned2 zip4;
	unsigned6 phone;
	unsigned4 fein;
	unsigned1 best_flags;
	string2 source;
	string2 dppa_state;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__business_header__contacts__bdid	:=
record
	unsigned6 bdid;
	unsigned6 did;
	unsigned1 contact_score;
	qstring34 vendor_id;
	unsigned4 dt_first_seen;
	unsigned4 dt_last_seen;
	string2 source;
	string1 record_type;
	string1 from_hdr;
	boolean glb;
	boolean dppa;
	qstring35 company_title;
	qstring35 company_department;
	qstring5 title;
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	string1 name_score;
	qstring10 prim_range;
	string2 predir;
	qstring28 prim_name;
	qstring4 addr_suffix;
	string2 postdir;
	qstring5 unit_desig;
	qstring8 sec_range;
	qstring25 city;
	string2 state;
	unsigned3 zip;
	unsigned2 zip4;
	string3 county;
	string4 msa;
	qstring10 geo_lat;
	qstring11 geo_long;
	unsigned6 phone;
	string60 email_address;
	unsigned4 ssn;
	qstring34 company_source_group;
	qstring120 company_name;
	qstring10 company_prim_range;
	string2 company_predir;
	qstring28 company_prim_name;
	qstring4 company_addr_suffix;
	string2 company_postdir;
	qstring5 company_unit_desig;
	qstring8 company_sec_range;
	qstring25 company_city;
	string2 company_state;
	unsigned3 company_zip;
	unsigned2 company_zip4;
	unsigned6 company_phone;
	unsigned4 company_fein;
end;

export rthor_data400__key__business_header__contacts__did := { unsigned6 did, unsigned8 fp };

export rthor_data400__key__business_header__contacts__filepos	:=
record
	unsigned8 fp;
	unsigned6 bdid;
	unsigned6 did;
	unsigned1 contact_score;
	qstring34 vendor_id;
	unsigned4 dt_first_seen;
	unsigned4 dt_last_seen;
	string2 source;
	string1 record_type;
	string1 from_hdr;
	boolean glb;
	boolean dppa;
	qstring35 company_title;
	qstring35 company_department;
	qstring5 title;
	qstring20 fname;
	qstring20 mname;
	qstring20 lname;
	qstring5 name_suffix;
	string1 name_score;
	qstring10 prim_range;
	string2 predir;
	qstring28 prim_name;
	qstring4 addr_suffix;
	string2 postdir;
	qstring5 unit_desig;
	qstring8 sec_range;
	qstring25 city;
	string2 state;
	unsigned3 zip;
	unsigned2 zip4;
	string3 county;
	string4 msa;
	qstring10 geo_lat;
	qstring11 geo_long;
	unsigned6 phone;
	string60 email_address;
	unsigned4 ssn;
	qstring34 company_source_group;
	qstring120 company_name;
	qstring10 company_prim_range;
	string2 company_predir;
	qstring28 company_prim_name;
	qstring4 company_addr_suffix;
	string2 company_postdir;
	qstring5 company_unit_desig;
	qstring8 company_sec_range;
	qstring25 company_city;
	string2 company_state;
	unsigned3 company_zip;
	unsigned2 company_zip4;
	unsigned6 company_phone;
	unsigned4 company_fein;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__contacts__ssn := { unsigned4 ssn, unsigned8 fp };

export rthor_data400__key__business_header__contacts__state_city_name	:=
record
	qstring20 lname;
	string2 state;
	qstring25 city;
	qstring20 fname;
	qstring20 mname;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__contacts__state_lfname	:=
record
	string2 state;
	string6 dph_lname;
	qstring20 lname;
	qstring20 pfname;
	qstring20 fname;
	unsigned8 fp;
end;

export rthor_data400__key__business_header__hri__address	:=
record
	string5 z5;
	string28 prim_name;
	string4 suffix;
	string2 predir;
	string2 postdir;
	string10 prim_range;
	string8 sec_range;
	unsigned3 dt_first_seen;
	string4 sic_code;
	string120 company_name;
	string25 city;
	string2 state;
  string2 source;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__business_header__relatives__bdid1	:=
record
	unsigned6 bdid1;
	unsigned6 bdid2;
	boolean corp_charter_number;
	boolean business_registration;
	boolean bankruptcy_filing;
	boolean duns_number;
	boolean duns_tree;
	boolean edgar_cik;
	boolean name;
	boolean name_address;
	boolean name_phone;
	boolean gong_group;
	boolean ucc_filing;
	boolean fbn_filing;
	boolean fein;
	boolean phone;
	boolean addr;
	boolean mail_addr;
	boolean dca_company_number;
	boolean dca_hierarchy;
	boolean abi_number;
	boolean abi_hierarchy;
	boolean lien_properties;
	boolean liens_v2;
	boolean rel_group;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__business_header__risk__bdid	:=
record
	unsigned6 bdid;
	unsigned3 zip;
	qstring28 prim_name;
	qstring10 prim_range;
	unsigned4 bdid_per_addr;
	unsigned4 apts;
	unsigned4 ppl;
	unsigned4 r_phone_per_addr;
	unsigned4 b_phone_per_addr;
	unsigned4 dnb_emps;
	unsigned4 irs5500_emps;
	unsigned4 domainss;
	unsigned1 sources;
	unsigned1 company_name_score;
	unsigned1 combined_score;
	unsigned4 gong_yp_cnt;
	unsigned4 current_corp_cnt;
	unsigned4 dt_first_seen_min;
	unsigned4 dt_last_seen_max;
	unsigned4 dt_vendor_first_reported_min;
	unsigned4 dt_first_seen_y;
	unsigned4 dt_last_seen_y;
	unsigned4 dt_first_seen_g;
	unsigned4 dt_last_seen_g;
	unsigned4 dt_first_seen_c;
	unsigned4 dt_last_seen_c;
	unsigned4 dt_first_seen_br;
	unsigned4 dt_last_seen_br;
	unsigned4 dt_first_seen_ucc;
	unsigned4 dt_last_seen_ucc;
	unsigned4 dt_first_seen_d;
	unsigned4 dt_last_seen_d;
	unsigned4 dt_first_seen_i;
	unsigned4 dt_last_seen_i;
	unsigned4 dt_first_seen_st;
	unsigned4 dt_last_seen_st;
	unsigned4 dt_last_seen_b;
	unsigned4 dt_last_seen_lj;
	unsigned4 dt_first_seen_bm;
	unsigned4 dt_last_seen_bm;
	unsigned4 dt_first_seen_bn;
	unsigned4 dt_last_seen_bn;
	unsigned4 dt_first_seen_ia;
	unsigned4 dt_last_seen_ia;
	unsigned4 dt_first_seen_dc;
	unsigned4 dt_last_seen_dc;
	unsigned4 dt_first_seen_eb;
	unsigned4 dt_last_seen_eb;
	string1 gong_current_record_flag;
	unsigned4 gong_deletion_date;
	unsigned2 gong_disc_cnt6;
	unsigned2 gong_disc_cnt12;
	unsigned2 gong_disc_cnt18;
	unsigned3 cnt_base;
	unsigned2 cnt_ae;
	unsigned2 cnt_af;
	unsigned2 cnt_at;
	unsigned2 cnt_aw;
	unsigned2 cnt_b;
	unsigned2 cnt_bm;
	unsigned2 cnt_bn;
	unsigned2 cnt_br;
	unsigned2 cnt_c;
	unsigned2 cnt_cu;
	unsigned2 cnt_d;
	unsigned2 cnt_dc;
	unsigned2 cnt_de;
	unsigned2 cnt_e;
	unsigned2 cnt_eb;
	unsigned2 cnt_ed;
	unsigned2 cnt_f;
	unsigned2 cnt_fa;
	unsigned2 cnt_fc;
	unsigned2 cnt_fd;
	unsigned2 cnt_ff;
	unsigned2 cnt_fn;
	unsigned2 cnt_gb;
	unsigned2 cnt_gg;
	unsigned2 cnt_i;
	unsigned2 cnt_ia;
	unsigned2 cnt_id;
	unsigned2 cnt_if;
	unsigned2 cnt_ii;
	unsigned2 cnt_in;
	unsigned2 cnt_lj;
	unsigned2 cnt_lb;
	unsigned2 cnt_lp;
	unsigned2 cnt_md;
	unsigned2 cnt_mv;
	unsigned2 cnt_pl;
	unsigned2 cnt_pr;
	unsigned2 cnt_sb;
	unsigned2 cnt_sk;
	unsigned2 cnt_st;
	unsigned3 cnt_u;
	unsigned2 cnt_v;
	unsigned2 cnt_w;
	unsigned2 cnt_wc;
	unsigned2 cnt_wt;
	unsigned2 cnt_y;
end;

export rthor_data400__key__business_header__risk__did := { unsigned6 did, unsigned6 bdid };

cname_var	:=
record
	string81 cname;
	unsigned4 last_seen;
end;
export rthor_data400__key__business_header__risk__fein	:=
record
	unsigned4 fein;
	unsigned4 busheader_first_seen;
	unsigned4 busheader_last_seen;
	boolean isvalidformat;
	boolean isbankrupt;
	integer8 busheadercount;
	integer8 bdidcount;
	integer8 bestcount;
	unsigned6 bestbdid;
	cname_var cname1;
	cname_var cname2;
	cname_var cname3;
	cname_var cname4;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__business_header__risk__fein_company_name	:=
record
	unsigned4 fein;
	qstring120 company_name;
	string120 addr1;
	qstring25 city;
	string2 state;
	unsigned3 zip;
	unsigned2 zip4;
end;

export rthor_data400__key__business_header__search__addr	:=
record
	qstring28 prim_name;
	unsigned3 zip;
	qstring8 sec_range;
	qstring10 prim_range;
	unsigned6 bdid;
end;

export rthor_data400__key__business_header__search__addr_pr_pn_sr_st	:=
record
	string2 state;
	qstring28 prim_name;
	qstring10 prim_range;
	qstring8 sec_range;
	qstring2 cn2;
	qstring40 indic;
	qstring40 sec;
	unsigned6 bdid;
	unsigned1 cn_pr_pn_sr_st_bdids;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__search__addr_pr_pn_zip	:=
record
	unsigned3 zip;
	qstring28 prim_name;
	qstring10 prim_range;
	qstring2 cn2;
	qstring40 indic;
	qstring40 sec;
	unsigned6 bdid;
	unsigned1 cn_pr_pn_zip_bdids;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__search__addr_st	:=
record
	string2 state;
	qstring2 cn2;
	qstring40 indic;
	qstring40 sec;
	unsigned6 bdid;
	unsigned1 cn_st_bdids;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__search__addr_zip	:=
record
	unsigned3 zip;
	qstring2 cn2;
	qstring40 indic;
	qstring40 sec;
	unsigned6 bdid;
	unsigned1 cn_zip_bdids;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__search__bdid_city_zip_fein_phone	:=
record
	unsigned6 bdid;
	qstring25 city;
	unsigned3 zip;
	unsigned4 fein;
	unsigned6 phone;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__search__bdid_pl	:=
record
	unsigned6 bdid;
	string2 source;
	qstring34 source_group;
	unsigned4 dt_first_seen;
	unsigned4 dt_last_seen;
	unsigned4 dt_vendor_first_reported;
	unsigned4 dt_vendor_last_reported;
	qstring120 company_name;
	qstring10 prim_range;
	string2 predir;
	qstring28 prim_name;
	qstring4 addr_suffix;
	string2 postdir;
	qstring5 unit_desig;
	qstring8 sec_range;
	qstring25 city;
	string2 state;
	unsigned3 zip;
	unsigned2 zip4;
	string3 county;
	string4 msa;
	qstring10 geo_lat;
	qstring11 geo_long;
	unsigned6 phone;
	unsigned2 phone_score;
	unsigned4 fein;
	boolean current;
	boolean dppa;
	string2 vendor_st;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__business_header__search__companyname := { string20 clean_company_name20, string60 clean_company_name60, unsigned6 bdid };

export rthor_data400__key__business_header__search__companyname_bdid_cn_bdids	:=
record
	string20 clean_company_name20;
	string60 clean_company_name60;
	unsigned6 bdid;
	unsigned1 cn_bdids;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__search__conamewords	:=
record
	string120 word;
	string2 state;
	unsigned1 seq;
	unsigned8 bh_filepos;
	unsigned6 bdid;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__search__fein	:=
record
	unsigned4 fein;
	qstring120 company_name;
	unsigned6 bdid;
	unsigned1 cn_f_bdids;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__search__phone	:=
record
	unsigned6 phone;
	qstring120 company_name;
	unsigned6 bdid;
	unsigned1 cn_p_bdids;
	qstring10 prim_range;
	qstring28 prim_name;
	qstring8 sec_range;
	unsigned3 zip;
	unsigned8 __filepos;
end;

export rthor_data400__key__business_header__search__siccode_zip :=
record
	string10 	prim_range;
	string2   predir;
	string28	prim_name;
	string4  	addr_suffix;
	string2   postdir;
	string5  	unit_desig;
	string8  	sec_range;
	string25 	city;
	string2   state;
	string5  	zip;
	string4  	zip4;
  string4   sic_code;
	string2 	source; //Added
	string12  bdid;
	string4   addr_type;
	real 			lat;
	real 			long;
end;	

export rthor_data400__key__business_header__supergroup__bdid := { unsigned6 bdid, unsigned6 group_id };

export rthor_data400__key__business_header__supergroup__groupid := { unsigned6 group_id, unsigned6 bdid };

export rthor_data400__key__business_header__hri__phone10_v2	:=
record
	string10 phone10;
	boolean iscurrent;
	unsigned3 dt_first_seen;
	string20 lname;
	string28 prim_name;
	string10 prim_range;
	string25 city;
	string2 state;
	string5 zip5;
	string4 zip4;
	boolean potdisconnect;
	boolean isacompany;
	string1 company_type;
	boolean company_type_a;
	string4 sic_code;
	string120 company_name;
	unsigned3 hri_dt_first_seen;
	string2 nxx_type;
	integer8 did_ct;
	integer8 did_ct_c6;
end;

export rthor_data400__key__business_header__hri__risk_bdid :=
record
  unsigned8 bdid;
  qstring5 zip;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring4 addr_suffix;
  string2 predir;
  string2 postdir;
  qstring5 unit_desig;
  qstring8 sec_range;
  qstring25 city;
  string2 state;
  unsigned2 zip4;
  string7 geo_blk;
  string13 geolink;
  string7 streetlink;
  string3 pflag;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string3 county;
  string4 msa;
  qstring10 geo_lat;
  qstring11 geo_long;
  boolean current;
  string2 source;
  qstring81 match_company_name;
  qstring20 match_branch_unit;
  qstring25 match_geo_city;
  integer4 business_count;
  integer4 legal_srv_cnt;
  integer4 hr_biz_cnt;
  boolean incorp_srv;
  boolean credit_rpr_srv;
  boolean hr_drug_trfc_zip;
  string1 address_type;
  string1 mixed_address_usage;
  string1 residential_or_business_ind;
  string1 dnd_indicator;
  string1 address_style_flag;
  string1 owgm_indicator;
  string1 drop_indicator;
  boolean deliverable;
  boolean occupant_owned;
  unsigned1 property_count;
  unsigned1 property_total;
  string standardized_land_use_code;
  unsigned8 building_area;
  unsigned8 no_of_buildings;
  unsigned8 no_of_stories;
  unsigned8 no_of_rooms;
  unsigned8 no_of_bedrooms;
  integer4 undel_sec_range;
  integer4 undel_bus_sec_range;
  integer4 num_undel_sec_ranges;
  real8 bdid_to_sqft_ratio;
  boolean prop_sfd;
  boolean potential_shelf_address;
  boolean potential_shell_address;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__business_header__hri__risk_geolink := 
record
  string13 geolink;
  integer8 cnt_shell;
  integer8 cnt_shelf;
  integer8 cnt_businesses;
  integer8 cnt_legal_srv_cnt;
  integer8 cnt_hr_biz_cnt;
  integer8 cnt_incorp_srv;
  integer8 cnt_credit_rpr_srv;
  integer8 cnt_residential_addrs;
  integer8 cnt_business_addrs;
end;

export rthor_data400__key__business_header__filtered__hri__address	:=
record
	string5 z5;
	string28 prim_name;
	string4 suffix;
	string2 predir;
	string2 postdir;
	string10 prim_range;
	string8 sec_range;
	unsigned3 dt_first_seen;
	string4 sic_code;
	string120 company_name;
	string25 city;
	string2 state;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__business_header__filtered__hri__phone10_v2	:=
record
	string10 phone10;
	boolean iscurrent;
	unsigned3 dt_first_seen;
	string20 lname;
	string28 prim_name;
	string10 prim_range;
	string25 city;
	string2 state;
	string5 zip5;
	string4 zip4;
	boolean potdisconnect;
	boolean isacompany;
	string1 company_type;
	boolean company_type_a;
	string4 sic_code;
	string120 company_name;
	unsigned3 hri_dt_first_seen;
	string2 nxx_type;
	integer8 did_ct;
	integer8 did_ct_c6;
end;

export rthor_data400__key__business_header__base__address				:= 
RECORD
  qstring28 prim_name;
  qstring10 prim_range;
  qstring2 state;
  unsigned4 city_code;
  integer4 zip;
  qstring8 sec_range;
  qstring40 word;
  qstring40 indic;
  qstring40 sec;
  qstring120 cname;
  unsigned6 bdid;
 END;

export rthor_data400__key__business_header__base__fein					:= 
RECORD
  string1 f1;
  string1 f2;
  string1 f3;
  string1 f4;
  string1 f5;
  string1 f6;
  string1 f7;
  string1 f8;
  string1 f9;
  qstring40 word;
  qstring40 indic;
  qstring40 sec;
  qstring120 cname;
  unsigned6 bdid;
 END;
export rthor_data400__key__business_header__base__name					:= 
RECORD
  qstring40 word;
  qstring40 indic;
  qstring40 sec;
  qstring120 cname;
  unsigned4 fein;
  unsigned6 bdid;
END;

export rthor_data400__key__business_header__base__phone					:=
RECORD
  string7 p7;
  string3 p3;
  qstring40 word;
  qstring40 indic;
  qstring40 sec;
  qstring120 cname;
  qstring2 state;
  unsigned6 bdid;
END;

export rthor_data400__key__business_header__base__st_city_name	:= 
RECORD
  unsigned4 city_code;
  qstring2 state;
  qstring40 word;
  qstring40 indic;
  qstring40 sec;
  qstring120 cname;
  unsigned6 bdid;
END;

export rthor_data400__key__business_header__base__st_name				:= 
RECORD
  qstring2 state;
  qstring40 word;
  qstring40 indic;
  qstring40 sec;
  qstring120 cname;
  unsigned4 fein;
  integer4 zip;
  unsigned6 bdid;
END;

export rthor_data400__key__business_header__base__street				:= 
RECORD
  qstring28 prim_name;
  integer4 zip;
  qstring40 word;
  qstring10 prim_range;
  qstring40 indic;
  qstring40 sec;
  qstring120 cname;
  unsigned6 bdid;
END;

export rthor_data400__key__business_header__base__zip						:= 
RECORD
  integer4 zip;
  qstring40 word;
  qstring40 indic;
  qstring40 sec;
  qstring120 cname;
  unsigned4 fein;
  unsigned6 bdid;
END;

export rthor_data400__key__business_header__hri__sic_z5 :=
RECORD
	string10 prim_range;
	string2   predir;
	string28 prim_name;
	string4  addr_suffix;
	string2   postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2   state;
	string5  zip;
	string4  zip4;
     string4   sic_code;
	 string2 	source; //Added
	string12  bdid;
	string4   addr_type;
	real lat;
	real long;
END;

export rthor_data400__key__business_header__address_siccode := 
record
	string10 prim_range;
	string2  predir;
	string28 prim_name;
	string4  addr_suffix;
	string2  postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2  state;
	string5  zip;
	string4  zip4;
	string8  sic_code;
	string2 source;
end;

export rthor_data400__key__business_header__hri__address_siccode := 
record
	string10 prim_range;
	string2  predir;
	string28 prim_name;
	string4  addr_suffix;
	string2  postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2  state;
	string5  zip;
	string4  zip4;
	string8  sic_code;
	string2 source;
end;


export rthor_data400__key__business_header__risk__bdid_risk :=
record
unsigned6 bdid;
unsigned1 PRScore := 0;
unsigned4 PRScore_date;
string120 best_CompanyName := '';
string60 best_addr1 := '';
string60 best_addr2 := '';
string10  best_phone := '';
string9   best_fein := '';
unsigned1 busreg_flag;
unsigned1 corp_flag;
unsigned1 dnb_flag;
unsigned1 irs5500_flag;
unsigned1 st_flag;
unsigned1 ucc_flag;
unsigned1 yp_flag;
unsigned1 tier1srcs;
unsigned1 t1scr5;
unsigned1 currphn;
unsigned1 currcorp;
unsigned1 currbr;
unsigned1 currdnb;
unsigned1 currucc;
unsigned1 curry;
unsigned1 currt1cnt;
unsigned1 currt1src4;
unsigned2 year_lj;
unsigned1 lj;
unsigned1 ustic;
unsigned1 t1x;
unsigned2 OFAC_cnt := 0;
unsigned2 cnt_B;
end;


export rthor_data400__key__business_header__contacts__bdid_score                      :=
record
	unsigned6 bdid;
	unsigned6 bdid2 := 0;
	unsigned1 score := 1;
	unsigned6 did;
end;

export rthor_data400__key__business_header__contacts__company_title                   :=
RECORD
	qstring35  company_title;
	string100  decode_company_title := '';
	STRING100  pcompany_title ;
	string100  rcompany_title ;
	UNSIGNED8  rcid ;
END;

export rthor_data400__key__business_header__search__bdid_seq                          :=
record
	unsigned6 bdid;
	unsigned1 seq;
	unsigned6 bdid2;
end;	

export rthor_data400__key__business_header__relatives_group__groupid                  :=
record
unsigned6 group_id;
unsigned6 bdid;
string2   group_type;
end;

export rthor_data400__key__business_header__eda__word_freq                            := 
RECORD
  STRING30	word;
	UNSIGNED8	freq;
END;
           
export rthor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range  := 
record
  unsigned6		rcid											:= 0		;
  unsigned6		bdid											:= 0		; // Seisint Business Identifier
  string2  		source														; // Source file type
  qstring34		source_group							:= ''		; // Source group identifier for merging of records only within source and group
  string3  		pflag 										:= ''		; // Internal processing flags
  unsigned6		group1_id									:= 0		; // Group identifier (temporary) for matching groups of records pre-linked
  qstring34 	vendor_id									:= ''		; // Vendor key
  unsigned4 	dt_first_seen											; // Date record first seen at Seisint
  unsigned4 	dt_last_seen											; // Date record last (most recently seen) at Seisint
  unsigned4 	dt_vendor_first_reported					;
  unsigned4 	dt_vendor_last_reported						;
  qstring120 	company_name											;
  qstring10 	prim_range												;
  string2   	predir														;
  qstring28 	prim_name													;
  qstring4  	addr_suffix												;
  string2   	postdir														;
  qstring5  	unit_desig												;
  qstring8  	sec_range													;
  qstring25 	city															;
  string2   	state															;
  unsigned3 	zip																;
  unsigned2 	zip4															;
  string3   	county														;
  string4   	msa																;
  qstring10 	geo_lat														;
  qstring11 	geo_long													;
  unsigned6 	phone															;
  unsigned2 	phone_score								:= 0		; // Score captioned listings for display ranking
  unsigned4 	fein 											:= 0		; // Federal Tax ID
  boolean   	current														; // Current/Historical indicator
  boolean	  	dppa 											:= false; // DPPA restricted record (Vehicles and Watercraft)
	qstring81 match_company_name				;
	qstring20 match_branch_unit					;
	qstring25 match_geo_city			:= ''	;
	UNSIGNED8 __filepos { virtual(fileposition) };
end;

export rthor_data400__key__business_header__search__zipprlname                        :=
RECORD
  integer4 zip;
  string10 prim_range;
  string20 lname;
  unsigned4 lookups;
  unsigned6 did;
 END;

export rthor_data400__key__business_header__search__conamewordsmetaphone              :=
RECORD
	STRING15 metaphone;
	STRING120 word;
	STRING2   state;
	UNSIGNED1 seq;
	UNSIGNED6 bdid;
  unsigned4 lookups;
  string6 zip;
end;

export rthor_data400__key__business_header__search__rcid                              := rthor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range;


// prte::key::business_header::20130531a::contacts::bdid.score                                     
// prte::key::business_header::20130531a::contacts::company_title                      
// prte::key::business_header::20130531a::search::bdid.seq                          
// prte::key::business_header::20130531a::relatives_group::groupid                   
// prte::key::business_header::20130531a::eda::word.freq                             
// prte::key::business_header::20130531a::risk::zip.prim_range.prim_name.sec_range   
// prte::key::business_header::20130531a::search::zipprlname                         
// prte::key::business_header::20130531a::search::conamewordsmetaphone               
// prte::key::business_header::20130531a::search::rcid                              

export dthor_data400__key__business_header__hri__oldnpa_oldnxx 								:= dataset(lCSVFileNamePrefixh + 'thor_data400__key__business_header__'+ lCSVVersionh + '__hri__oldnpa.oldnxx.csv'							, rthor_data400__key__business_header__hri__oldnpa_oldnxx								, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates 		:= dataset(lCSVFileNamePrefixh + 'thor_data400__key__business_header__'+ lCSVVersionh + '__hri__oldnpa.oldnxx.fixeddates.csv'		, rthor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates		, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__aca_institutions__address 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__aca_institutions__address.csv'					, rthor_data400__key__business_header__aca_institutions__address				, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__bdl2__bdid 												:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__bdl2__bdid.csv'												, rthor_data400__key__business_header__bdl2__bdid												, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__bdl2__bdl 												:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__bdl2__bdl.csv'													, rthor_data400__key__business_header__bdl2__bdl												, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__best__filepos_data 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__best__filepos.data.csv'								, rthor_data400__key__business_header__best__filepos_data								, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__best__filepos_data_knowx 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__best__filepos.data.knowx.csv'					, rthor_data400__key__business_header__best__filepos_data_knowx					, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__contacts__bdid 										:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionCont + '__contacts__bdid.csv'										, rthor_data400__key__business_header__contacts__bdid										, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__contacts__did 										:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__contacts__did.csv'											, rthor_data400__key__business_header__contacts__did										, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__contacts__filepos 								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__contacts__filepos.csv'									, rthor_data400__key__business_header__contacts__filepos								, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__contacts__ssn 										:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionCont + '__contacts__ssn.csv'											, rthor_data400__key__business_header__contacts__ssn										, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__contacts__state_city_name 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__contacts__state.city.name.csv'					, rthor_data400__key__business_header__contacts__state_city_name				, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__contacts__state_lfname 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionCont + '__contacts__state.lfname.csv'						, rthor_data400__key__business_header__contacts__state_lfname						, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__hri__risk_bdid 										:= dataset([]										, rthor_data400__key__business_header__hri__risk_bdid									);
export dthor_data400__key__business_header__hri__risk_geolink 								:= dataset([]										, rthor_data400__key__business_header__hri__risk_geolink							);
export dthor_data400__key__business_header__hri__address 											:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__hri__address.csv'											, rthor_data400__key__business_header__hri__address											, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__relatives__bdid1 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__relatives__bdid1.csv'									, rthor_data400__key__business_header__relatives__bdid1									, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__risk__bdid 												:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__risk__bdid.csv'												, rthor_data400__key__business_header__risk__bdid												, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__risk__did 												:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__risk__did.csv'													, rthor_data400__key__business_header__risk__did												, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__risk__fein 												:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__risk__fein.csv'												, rthor_data400__key__business_header__risk__fein												, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__risk__fein_company_name 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__risk__fein.company_name.csv'						, rthor_data400__key__business_header__risk__fein_company_name					, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__addr 											:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__addr.csv'											, rthor_data400__key__business_header__search__addr											, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__addr_pr_pn_sr_st 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__addr.pr.pn.sr.st.csv'					, rthor_data400__key__business_header__search__addr_pr_pn_sr_st					, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__addr_pr_pn_zip 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__addr.pr.pn.zip.csv'						, rthor_data400__key__business_header__search__addr_pr_pn_zip						, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__addr_st 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__addr.st.csv'										, rthor_data400__key__business_header__search__addr_st									, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__addr_zip 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__addr.zip.csv'									, rthor_data400__key__business_header__search__addr_zip									, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__bdid_city_zip_fein_phone 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__bdid.city.zip.fein.phone.csv'	, rthor_data400__key__business_header__search__bdid_city_zip_fein_phone	, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__bdid_pl 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionpl + '__search__bdid.pl.csv'										, rthor_data400__key__business_header__search__bdid_pl									, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__companyname 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__companyname.csv'								, rthor_data400__key__business_header__search__companyname							, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__companyname_bdid_cn_bdids := dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__companyname.bdid.cn_bdids.csv', rthor_data400__key__business_header__search__companyname_bdid_cn_bdids, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__conamewords 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__conamewords.csv'								, rthor_data400__key__business_header__search__conamewords							, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__fein 											:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__fein.csv'											, rthor_data400__key__business_header__search__fein											, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__phone 										:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__search__phone.csv'											, rthor_data400__key__business_header__search__phone										, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__search__siccode_zip								:= dataset([]										, rthor_data400__key__business_header__search__siccode_zip		);

export dthor_data400__key__business_header__supergroup__bdid 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__supergroup__bdid.csv'									, rthor_data400__key__business_header__supergroup__bdid									, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__supergroup__groupid 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersion + '__supergroup__groupid.csv'								, rthor_data400__key__business_header__supergroup__groupid							, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__hri__phone10_v2 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionhp + '__hri__phone10_v2.csv'										, rthor_data400__key__business_header__hri__phone10_v2									, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__filtered__hri__address 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__filtered__'+ lCSVVersion + '__hri__address.csv'						, rthor_data400__key__business_header__filtered__hri__address						, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__filtered__hri__phone10_v2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__filtered__'+ lCSVVersionhp + '__hri__phone10_v2.csv'					, rthor_data400__key__business_header__filtered__hri__phone10_v2				, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

export dthor_data400__key__business_header__base__address											:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionBase + '__base__address.csv'				, rthor_data400__key__business_header__base__address			, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__base__fein												:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionBase + '__base__fein.csv'					, rthor_data400__key__business_header__base__fein					, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__base__name												:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionBase + '__base__name.csv'					, rthor_data400__key__business_header__base__name					, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__base__phone												:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionBase + '__base__phone.csv'					, rthor_data400__key__business_header__base__phone				, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__base__st_city_name								:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionBase + '__base__st.city.name.csv'	, rthor_data400__key__business_header__base__st_city_name	, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__base__st_name											:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionBase + '__base__st.name.csv'				, rthor_data400__key__business_header__base__st_name			, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__base__street											:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionBase + '__base__street.csv'				, rthor_data400__key__business_header__base__street				, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__business_header__base__zip													:= dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__'+ lCSVVersionBase + '__base__zip.csv'						, rthor_data400__key__business_header__base__zip					, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

export dthor_data400__key__business_header__hri__sic_z5         							:= dataset([]										, rthor_data400__key__business_header__hri__sic_z5         		);
export dthor_data400__key__business_header__address_siccode     							:= dataset([]										, rthor_data400__key__business_header__address_siccode     		);
export dthor_data400__key__business_header__hri__address_siccode							:= dataset([]										, rthor_data400__key__business_header__hri__address_siccode		);
export dthor_data400__key__business_header__risk__bdid_risk     							:= dataset([]										, rthor_data400__key__business_header__risk__bdid_risk     		);

export dthor_data400__key__business_header__contacts__bdid_score                    := dataset([]										, rthor_data400__key__business_header__contacts__bdid_score                         		);
export dthor_data400__key__business_header__contacts__company_title                 := dataset([]										, rthor_data400__key__business_header__contacts__company_title                      		);
export dthor_data400__key__business_header__search__bdid_seq                        := dataset([]										, rthor_data400__key__business_header__search__bdid_seq                             		);
export dthor_data400__key__business_header__relatives_group__groupid                := dataset([]										, rthor_data400__key__business_header__relatives_group__groupid                     		);
export dthor_data400__key__business_header__eda__word_freq                          := dataset([]										, rthor_data400__key__business_header__eda__word_freq                               		);
export dthor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range:= dataset([]										, rthor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range     		);
export dthor_data400__key__business_header__search__zipprlname                      := dataset([]										, rthor_data400__key__business_header__search__zipprlname                           		);
export dthor_data400__key__business_header__search__conamewordsmetaphone            := dataset([]										, rthor_data400__key__business_header__search__conamewordsmetaphone                 		);
export dthor_data400__key__business_header__search__rcid                            := dataset([]										, rthor_data400__key__business_header__search__rcid                                 		);
end;