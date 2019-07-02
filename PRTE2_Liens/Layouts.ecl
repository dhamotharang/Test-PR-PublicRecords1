﻿IMPORT PRTE2_Liens, LiensV2, Address, BIPV2, prte2;

EXPORT Layouts := MODULE

EXPORT BaseMain_in := RECORD
//LiensV2.layout_liens_main_module.layout_liens_main and not filing_status;
LiensV2.layout_liens_main_module.layout_liens_main and not [bCBFlag,filing_status];
string20	cust_name;
string10	bug_num;
string7		courtid;
string2		filing_typ_code;
END;

EXPORT BaseStatus_in := RECORD
string50	tmsid;
string50	rmsid;
string		process_date;
string		record_code;
string		filing_status;
string		filing_status_desc;
string10	bug_num;
string20	cust_name;
END;

EXPORT Baseparty_in := RECORD
LiensV2.layout_liens_party and not persistent_record_id;
string9 	app_SSN := '';
string9 	app_tax_id := '';
BIPV2.IDlayouts.l_key_ids;
unsigned8 persistent_record_id := 0 ;
string		fp;
string10	bug_num;
string20	cust_name;
STRING8		link_dob;
STRING9		link_ssn;
STRING8		link_inc_date;
STRING9		link_fein;
END;

//Base Key files
EXPORT main_base_ext := RECORD, maxlength(32766) //Contains DI added fields
LiensV2.layout_liens_main_module.layout_liens_main;
string20	cust_name;
string10	bug_num;
string7		courtid;
string2		filing_typ_code;
END;

EXPORT main_base := RECORD, maxlength(32766)
LiensV2.layout_liens_main_module.layout_liens_main;
END;

EXPORT party_base_ext := RECORD //Contains DI added fields
LiensV2.layout_liens_party;
BIPV2.IDlayouts.l_xlink_ids;
prte2.Layouts.DEFLT_CPA;
string10	orig_rmsid;
string10	bug_num;
string20	cust_name;
STRING8		link_dob;
STRING9		link_ssn;
STRING8		link_inc_date;
STRING9		link_fein;
END;

EXPORT party_base := RECORD
LiensV2.layout_liens_party;
BIPV2.IDlayouts.l_xlink_ids;
prte2.Layouts.DEFLT_CPA;
string10	orig_rmsid;
END;

	
//LinkIDs key layout
EXPORT LinkIDSKey:= RECORD
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
  string50 tmsid;
  string50 rmsid;
  string orig_full_debtorname;
  string orig_name;
  string orig_lname;
  string orig_fname;
  string orig_mname;
  string orig_suffix;
  string9 tax_id;
  string9 ssn;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string cname;
  string orig_address1;
  string orig_address2;
  string orig_city;
  string orig_state;
  string orig_zip5;
  string orig_zip4;
  string orig_county;
  string orig_country;
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
  string phone;
  string name_type;
  string12 did;
  string12 bdid;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  unsigned8 persistent_record_id;
  string9 app_ssn := '';
  string9 app_tax_id := '';
	prte2.Layouts.DEFLT_CPA;
	string10	orig_rmsid;
 END;



//Due to the Prod Layout changes
layout_filing_status := RECORD,maxlength(10000)
   string filing_status;
   string filing_status_desc;
  END;


EXPORT alpha_main_in := RECORD,maxlength(32766)
  string50 tmsid;
  string50 rmsid;
  string process_date;
  string record_code;
  string date_vendor_removed;
  string filing_jurisdiction;
  string filing_state;
  string20 orig_filing_number;
  string orig_filing_type;
  string orig_filing_date;
  string orig_filing_time;
  string case_number;
  string20 filing_number;
  string filing_type_desc;
  string filing_date;
  string filing_time;
  string vendor_entry_date;
  string judge;
  string case_title;
  string filing_book;
  string filing_page;
  string release_date;
  string amount;
  string eviction;
  string satisifaction_type;
  string judg_satisfied_date;
  string judg_vacated_date;
  string tax_code;
  string irs_serial_number;
  string effective_date;
  string lapse_date;
  string accident_date;
  string sherrif_indc;
  string expiration_date;
  string agency;
  string agency_city;
  string agency_state;
  string agency_county;
  string legal_lot;
  string legal_block;
  string legal_borough;
  string certificate_number;
  boolean bcbflag;
  unsigned8 persistent_record_id;
  DATASET(layout_filing_status) filing_status;
  string2 filing_type_id;
  string8 collection_date;
  string45 caselinkid;
  string50 tmsid_old;
  string50 rmsid_old;
  boolean caselinkid_prop_flag;
  string20 cust_name;
  string10 bug_num;
  string7 courtid;
  string2 filing_typ_code;
 END;

	// LiensV2.layout_liens_main_module.layout_liens_main and not [global_sid,record_sid,orig_rmsid,AgencyID, AgencyID_src];
	// string20	cust_name;
	// string10	bug_num;	
	// string7		courtid;
	// string2		filing_typ_code;											 
	// end;
	
EXPORT alpha_party_in := RECORD
	party_base_ext and not [global_sid,
													record_sid,
													orig_rmsid
													];
end;

 
END;