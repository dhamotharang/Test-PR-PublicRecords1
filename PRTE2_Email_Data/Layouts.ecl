IMPORT PRTE2_Email_Data, email_data,AID_BUILD;

EXPORT Layouts := MODULE

 export rFinal := RECORD
    AID_BUILD.layouts.rFinal;
  end;

Export incoming_base := record
	string200 clean_email := '';
  string100 append_email_username;
  string120 append_domain := '';
  string12  append_domain_type := '';
  string100 append_domain_root := '';
  string20  append_domain_ext := '';
  boolean   append_is_tld_state := false;
  boolean   append_is_tld_generic := false;
  boolean   append_is_tld_country := false;
  boolean   append_is_valid_domain_ext := false;
	unsigned	email_rec_key;
	string2 email_src;
	unsigned rec_src_all;
	unsigned email_src_all;
	unsigned email_src_num;
	unsigned num_email_per_did := 0;
	unsigned num_did_per_email:= 0;
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
	string orig_login_date := '';
  string orig_site;
  string orig_e360_id;
  string orig_teramedia_id;
	string orig_phone;
	string orig_ssn;
	string orig_dob;
  unsigned6 did;
  unsigned8 did_score;
	string10  did_type := '';
	boolean	 is_did_prop := false;
	unsigned hhid := 0;
 	string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
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
  unsigned8 append_rawaid;
	string clean_phone;
	string clean_ssn;
	string clean_dob;
 	string8		process_date := '';
	string1 activecode;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
	boolean current_rec;
	string companyname;
  string cln_companyname;
string companytitle;
string rules;
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
string link_ssn;
string link_dob;
string link_fein;
string link_inc_date;
string cust_name;
string bug_num;
end;

shared layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
end;

shared layout_clean182 := RECORD
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
end;

		   
		EXPORT incoming_alpha := record
			 Email_Data.Layout_Email.Scrubs_bits_base - [scrubsbits1,global_sid,record_sid];
			 
		END;
	
EXPORT base := record
Email_Data.Layout_Email.Scrubs_bits_base - [scrubsbits1];
string companyname;
string cln_companyname;
string companytitle;
string rules;
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
string link_ssn;
string link_dob;
string link_fein;
string link_inc_date;
string cust_name;
string bug_num;
string10	date_aging_ind;
END;
		
		// The build process uses this layout in preparation
		EXPORT keyRec := record
	    Email_Data.Layout_Email.Keys;
		END;

		// The build process uses this layout in preparation
		EXPORT Autokey_layout := RECORD
			Email_Data.Layout_email.Autokey_layout;
		END;
END;