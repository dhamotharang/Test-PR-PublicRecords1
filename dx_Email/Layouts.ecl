EXPORT Layouts := MODULE

IMPORT BIPv2;

EXPORT layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
END;

EXPORT layout_clean182 := RECORD
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
END;

EXPORT base := RECORD
  string200 clean_email;
  string100 append_email_username;
  string120 append_domain;
  string12  append_domain_type;
  string100 append_domain_root;
  string20  append_domain_ext;
  boolean   append_is_tld_state;
  boolean   append_is_tld_generic;
  boolean   append_is_tld_country;
  boolean   append_is_valid_domain_ext;
	unsigned	email_rec_key;
	string2 email_src;
  string orig_pmghousehold_id;
  string orig_pmgindividual_id;
  string orig_first_name;
  string orig_last_name;
	string orig_middle_name;
	string orig_name_suffix;
  string orig_address;
  string orig_city;
  string orig_state;
  string orig_zip;
  string orig_zip4;
  string orig_email;
  string orig_ip;
	string orig_login_date;
  string orig_site;
  string orig_e360_id;
  string orig_teramedia_id;
	string orig_phone;
	string orig_ssn;
	string orig_dob;
  unsigned6 did;
  unsigned8 did_score;
	string10  did_type;
	unsigned hhid;
  Layout_Clean_Name clean_name;
  Layout_Clean182 clean_address;
  unsigned8 append_rawaid;
	string10	clean_phone;
  string9 	clean_ssn;
  unsigned4 clean_dob;
	string8		process_date;
	string1 activecode;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
	boolean current_rec;
	string	orig_CompanyName;
	string	cln_CompanyName;
	string	CompanyTitle;
	unsigned	rules;
	bipv2.IDlayouts.l_xlink_ids;
END;

EXPORT i_DID	:= RECORD
	unsigned6 did;
	unsigned	email_rec_key;
END;

EXPORT i_Email_Address := RECORD
	string200 clean_email;
	unsigned	email_rec_key;
END;

EXPORT i_Payload	:= RECORD
	unsigned	email_rec_key;
	base;
END;

END;