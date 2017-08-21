IMPORT _Control;

EXPORT Proc_Build_ABMS_Keys(STRING pIndexVersion) := FUNCTION

	rKeyABMS__autokey__address := RECORD
		STRING28  prim_name;
		STRING10  prim_range;
		STRING2   st;
		UNSIGNED4 city_code;
		STRING5   zip;
		STRING8   sec_range;
    STRING6   dph_lname;
		STRING20  lname;
		STRING20  pfname;
		STRING20  fname;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	END;

	rKeyABMS__autokey__addressb2 := RECORD
		STRING28  prim_name;
		STRING10  prim_range;
		STRING2   st;
		UNSIGNED4 city_code;
		STRING5   zip;
		STRING8   sec_range;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyABMS__autokey__citystname := RECORD
		UNSIGNED4 city_code;
		STRING2   st;
		STRING6   dph_lname;
		STRING20  lname;
		STRING20  pfname;
		STRING20  fname;
		INTEGER4  dob;
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

	rKeyABMS__autokey__citystnameb2 := RECORD
		UNSIGNED4 city_code;
		STRING2   st;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyABMS__autokey__name := RECORD
		STRING6   dph_lname;
		STRING20  lname;
		STRING20  pfname;
		STRING20  fname;
		STRING1   minit;
		UNSIGNED2 yob;
		UNSIGNED2 s4;
		INTEGER4  dob;
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

	rKeyABMS__autokey__nameb2 := RECORD
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyABMS__autokey__namewords2 := RECORD
		STRING40  word;
		STRING2   state;
		UNSIGNED1 seq;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

  layout_clean_name := RECORD
		STRING5  title;
		STRING20 fname;
		STRING20 mname;
		STRING20 lname;
		STRING5  name_suffix;
		STRING3  name_score;
  END;

  cleaned_phone := RECORD
		STRING10  phone;
  END;

  layout_clean182_fips := RECORD
		STRING10 prim_range;
		STRING2  predir;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  postdir;
		STRING10 unit_desig;
		STRING8  sec_range;
		STRING25 p_city_name;
		STRING25 v_city_name;
		STRING2  st;
		STRING5  zip;
		STRING4  zip4;
		STRING4  cart;
		STRING1  cr_sort_sz;
		STRING4  lot;
		STRING1  lot_order;
		STRING2  dbpc;
		STRING1  chk_digit;
		STRING2  rec_type;
		STRING2  fips_state;
		STRING3  fips_county;
		STRING10 geo_lat;
		STRING11 geo_long;
		STRING4  msa;
		STRING7  geo_blk;
		STRING1  geo_match;
		STRING4  err_stat;
  END;
	
	rKeyABMS__autokey__payload := RECORD
		UNSIGNED6 fakeid;
		STRING8   biog_number;
		STRING2   birth_day;
		STRING2   birth_month;
		STRING4   birth_year;
		STRING1   birth_date_suppress_ind;
		STRING67  birth_city;
		STRING67  birth_state;
		STRING67  birth_nation;
		STRING1   birth_location_suppress_ind;
		STRING40  first_name;
		STRING30  middle_name;
		STRING40  last_name;
		STRING15  name_suffix;
		STRING4   placement_cert;
		STRING100 placement_city;
		STRING2   placement_state;
		STRING1   gender;
		STRING1   board_certified;
		STRING10  npi;
		STRING10  dod;
		STRING4   board_code;
		STRING100 board_name;
		STRING1   participation;
		STRING8   moc_cert_id;
		STRING100 moc_cert_name;
		UNSIGNED6 address_id;
		STRING2   state;
		STRING9   full_zip;
		STRING60  org1;
		STRING40  line1;
		STRING40  line2;
		STRING40  line3;
		STRING40  city;
		STRING40  country;
		STRING1   address_type;
		STRING1   address_suppress_ind;
		STRING6   contact_type;
		STRING250 description;
		STRING3   area_code;
		STRING3   exchange;
		STRING4   phone_last_four;
		UNSIGNED6 address_occurrence_number;
		UNSIGNED6 contact_occurrence_number;
		STRING8   dob;
		STRING1   dead_ind;
		STRING60  org_name;
		STRING40  additional_org_text;
		STRING40  address1;
		STRING40  address2;
		STRING10  phone_number;
		STRING    website;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		STRING    board_source;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		UNSIGNED8 lnpid;
		layout_clean182_fips clean_company_address;
		layout_clean_name    clean_name;
		cleaned_phone        clean_phone;
		STRING    address_type_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__autokey__phone2 := RECORD
		STRING7   p7;
		STRING3   p3;
		STRING6   dph_lname;
		STRING20  pfname;
		STRING2   st;
		UNSIGNED6 did;
		UNSIGNED4 lookups;
	END;

	rKeyABMS__autokey__phoneb2 := RECORD
		STRING7   p7;
		STRING3   p3;
		STRING40  cname_indic;
		STRING40  cname_sec;
		STRING2   st;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyABMS__autokey__stname := RECORD
		STRING2   st;
		STRING6   dph_lname;
		STRING20  lname;
		STRING20  pfname;
		STRING20  fname;
		STRING1   minit;
		UNSIGNED2 yob;
		UNSIGNED2 s4;
		INTEGER4  zip;
		INTEGER4  dob;
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

	rKeyABMS__autokey__stnameb2 := RECORD
		STRING2   st;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyABMS__autokey__zip := RECORD
		INTEGER4  zip;
		STRING6   dph_lname;
		STRING20  lname;
		STRING20  pfname;
		STRING20  fname;
		STRING1   minit;
		UNSIGNED2 yob;
		UNSIGNED2 s4;
		INTEGER4  dob;
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

	rKeyABMS__autokey__zipb2 := RECORD
		INTEGER4  zip;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyABMS__career__biog_number := RECORD
		STRING8   biog_number;
		STRING1   record_type;
		UNSIGNED6 occurrence_number;
		STRING100 specialty;
		STRING150 position;
		STRING230 organization;
		STRING70  city;
		STRING70  state;
		STRING70  nation;
		STRING4   from_year;
		STRING4   to_year;
		STRING3   career_type;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING    career_type_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__cert__biog_number := RECORD
		STRING8   biog_number;
		STRING1   record_type;
		STRING3   biog_cert_id;
		STRING100 cert_name;
		STRING1   cert_type_ind;
		STRING1   recert_ind;
		STRING1   board_certified;
		STRING4   cert_year;
		STRING2   cert_month;
		STRING2   cert_day;
		STRING4   expiration_year;
		STRING2   expiration_month;
		STRING2   expiration_day;
		STRING4   reverification_year;
		STRING2   reverification_month;
		STRING2   reverification_day;
		STRING2   duration_type;
		STRING100 board_web_desc;
		STRING8   cert_id;
		STRING8   mocpathway_id;
		STRING200 mocpathway_name;
		STRING8   cert_date;
		STRING8   expiration_date;
		STRING8   reverification_date;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING    cert_type_ind_desc;
		STRING    recert_ind_desc;
		STRING    duration_type_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__education__biog_number := RECORD
		STRING8   biog_number;
		STRING1   record_type;
		UNSIGNED6 occurrence_number;
		STRING150 degree;
		STRING5   abms_school_code;
		STRING150 school;
		STRING75  years;
		STRING25  city;
		STRING67  state;
		STRING40  country;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING    abms_school_code_desc;
		STRING    abms_school_code_desc_abbrev;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__lookups__specialty := RECORD
		STRING100 specialty;
		STRING8   sub_specialty_id;
		STRING100 sub_specialty;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__main__bdid := RECORD
		UNSIGNED6 bdid;
		STRING8   biog_number;
		STRING2   birth_day;
		STRING2   birth_month;
		STRING4   birth_year;
		STRING1   birth_date_suppress_ind;
		STRING67  birth_city;
		STRING67  birth_state;
		STRING67  birth_nation;
		STRING1   birth_location_suppress_ind;
		STRING40  first_name;
		STRING30  middle_name;
		STRING40  last_name;
		STRING15  name_suffix;
		STRING4   placement_cert;
		STRING100 placement_city;
		STRING2   placement_state;
		STRING1   gender;
		STRING1   board_certified;
		STRING10  npi;
		STRING10  dod;
		STRING4   board_code;
		STRING100 board_name;
		STRING1   participation;
		STRING8   moc_cert_id;
		STRING100 moc_cert_name;
		UNSIGNED6 address_id;
		STRING2   state;
		STRING9   full_zip;
		STRING60  org1;
		STRING40  line1;
		STRING40  line2;
		STRING40  line3;
		STRING40  city;
		STRING40  country;
		STRING1   address_type;
		STRING1   address_suppress_ind;
		STRING6   contact_type;
		STRING250 description;
		STRING3   area_code;
		STRING3   exchange;
		STRING4   phone_last_four;
		UNSIGNED6 address_occurrence_number;
		UNSIGNED6 contact_occurrence_number;
		STRING8   dob;
		STRING1   dead_ind;
		STRING60  org_name;
		STRING40  additional_org_text;
		STRING40  address1;
		STRING40  address2;
		STRING10  phone_number;
		STRING    website;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		STRING    board_source;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED1 bdid_score;
		UNSIGNED8 lnpid;
		layout_clean182_fips clean_company_address;
		layout_clean_name    clean_name;
		cleaned_phone        clean_phone;
		STRING    address_type_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__main__biog_number := RECORD
		STRING8   biog_number;
		STRING1   record_type;
		STRING2   birth_day;
		STRING2   birth_month;
		STRING4   birth_year;
		STRING1   birth_date_suppress_ind;
		STRING67  birth_city;
		STRING67  birth_state;
		STRING67  birth_nation;
		STRING1   birth_location_suppress_ind;
		STRING40  first_name;
		STRING30  middle_name;
		STRING40  last_name;
		STRING15  name_suffix;
		STRING4   placement_cert;
		STRING100 placement_city;
		STRING2   placement_state;
		STRING1   gender;
		STRING1   board_certified;
		STRING10  npi;
		STRING10  dod;
		STRING4   board_code;
		STRING100 board_name;
		STRING1   participation;
		STRING8   moc_cert_id;
		STRING100 moc_cert_name;
		UNSIGNED6 address_id;
		STRING2   state;
		STRING9   full_zip;
		STRING60  org1;
		STRING40  line1;
		STRING40  line2;
		STRING40  line3;
		STRING40  city;
		STRING40  country;
		STRING1   address_type;
		STRING1   address_suppress_ind;
		STRING6   contact_type;
		STRING250 description;
		STRING3   area_code;
		STRING3   exchange;
		STRING4   phone_last_four;
		UNSIGNED6 address_occurrence_number;
		UNSIGNED6 contact_occurrence_number;
		STRING8   dob;
		STRING1   dead_ind;
		STRING60  org_name;
		STRING40  additional_org_text;
		STRING40  address1;
		STRING40  address2;
		STRING10  phone_number;
		STRING    website;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING    board_source;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		UNSIGNED8 lnpid;
		layout_clean182_fips clean_company_address;
		layout_clean_name    clean_name;
		cleaned_phone        clean_phone;
		STRING    address_type_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__main__did := RECORD
		UNSIGNED6 did;
		STRING8   biog_number;
		STRING2   birth_day;
		STRING2   birth_month;
		STRING4   birth_year;
		STRING1   birth_date_suppress_ind;
		STRING67  birth_city;
		STRING67  birth_state;
		STRING67  birth_nation;
		STRING1   birth_location_suppress_ind;
		STRING40  first_name;
		STRING30  middle_name;
		STRING40  last_name;
		STRING15  name_suffix;
		STRING4   placement_cert;
		STRING100 placement_city;
		STRING2   placement_state;
		STRING1   gender;
		STRING1   board_certified;
		STRING10  npi;
		STRING10  dod;
		STRING4   board_code;
		STRING100 board_name;
		STRING1   participation;
		STRING8   moc_cert_id;
		STRING100 moc_cert_name;
		UNSIGNED6 address_id;
		STRING2   state;
		STRING9   full_zip;
		STRING60  org1;
		STRING40  line1;
		STRING40  line2;
		STRING40  line3;
		STRING40  city;
		STRING40  country;
		STRING1   address_type;
		STRING1   address_suppress_ind;
		STRING6   contact_type;
		STRING250 description;
		STRING3   area_code;
		STRING3   exchange;
		STRING4   phone_last_four;
		UNSIGNED6 address_occurrence_number;
		UNSIGNED6 contact_occurrence_number;
		STRING8   dob;
		STRING1   dead_ind;
		STRING60  org_name;
		STRING40  additional_org_text;
		STRING40  address1;
		STRING40  address2;
		STRING10  phone_number;
		STRING    website;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		STRING    board_source;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		UNSIGNED8 lnpid;
		layout_clean182_fips clean_company_address;
		layout_clean_name    clean_name;
		cleaned_phone        clean_phone;
		STRING    address_type_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__main__lname_cert_fname := RECORD
		STRING40  last_name;
		STRING100 cert_name;
		STRING40  first_name;
		STRING8   biog_number;
		STRING2   birth_day;
		STRING2   birth_month;
		STRING4   birth_year;
		STRING1   birth_date_suppress_ind;
		STRING67  birth_city;
		STRING67  birth_state;
		STRING67  birth_nation;
		STRING1   birth_location_suppress_ind;
		STRING30  middle_name;
		STRING15  name_suffix;
		STRING4   placement_cert;
		STRING100 placement_city;
		STRING2   placement_state;
		STRING1   gender;
		STRING1   board_certified;
		STRING10  npi;
		STRING10  dod;
		STRING4   board_code;
		STRING100 board_name;
		STRING1   participation;
		STRING8   moc_cert_id;
		STRING100 moc_cert_name;
		UNSIGNED6 address_id;
		STRING2   state;
		STRING9   full_zip;
		STRING60  org1;
		STRING40  line1;
		STRING40  line2;
		STRING40  line3;
		STRING40  city;
		STRING40  country;
		STRING1   address_type;
		STRING1   address_suppress_ind;
		STRING6   contact_type;
		STRING250 description;
		STRING3   area_code;
		STRING3   exchange;
		STRING4   phone_last_four;
		UNSIGNED6 address_occurrence_number;
		UNSIGNED6 contact_occurrence_number;
		STRING8   dob;
		STRING1   dead_ind;
		STRING60  org_name;
		STRING40  additional_org_text;
		STRING40  address1;
		STRING40  address2;
		STRING10  phone_number;
		STRING    website;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		STRING    board_source;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		UNSIGNED8 lnpid;
		layout_clean182_fips clean_company_address;
		layout_clean_name    clean_name;
		cleaned_phone        clean_phone;
		STRING    address_type_desc;
		STRING1   cert_type_ind;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__main__lname_specialty_fname := RECORD
		STRING40  last_name;
		STRING100 specialty;
		STRING40  first_name;
		STRING8   biog_number;
		STRING2   birth_day;
		STRING2   birth_month;
		STRING4   birth_year;
		STRING1   birth_date_suppress_ind;
		STRING67  birth_city;
		STRING67  birth_state;
		STRING67  birth_nation;
		STRING1   birth_location_suppress_ind;
		STRING30  middle_name;
		STRING15  name_suffix;
		STRING4   placement_cert;
		STRING100 placement_city;
		STRING2   placement_state;
		STRING1   gender;
		STRING1   board_certified;
		STRING10  npi;
		STRING10  dod;
		STRING4   board_code;
		STRING100 board_name;
		STRING1   participation;
		STRING8   moc_cert_id;
		STRING100 moc_cert_name;
		UNSIGNED6 address_id;
		STRING2   state;
		STRING9   full_zip;
		STRING60  org1;
		STRING40  line1;
		STRING40  line2;
		STRING40  line3;
		STRING40  city;
		STRING40  country;
		STRING1   address_type;
		STRING1   address_suppress_ind;
		STRING6   contact_type;
		STRING250 description;
		STRING3   area_code;
		STRING3   exchange;
		STRING4   phone_last_four;
		UNSIGNED6 address_occurrence_number;
		UNSIGNED6 contact_occurrence_number;
		STRING8   dob;
		STRING1   dead_ind;
		STRING60  org_name;
		STRING40  additional_org_text;
		STRING40  address1;
		STRING40  address2;
		STRING10  phone_number;
		STRING    website;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		STRING    board_source;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		UNSIGNED8 lnpid;
		layout_clean182_fips clean_company_address;
		layout_clean_name    clean_name;
		cleaned_phone        clean_phone;
		STRING    address_type_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__main__npi := RECORD
		STRING10  npi;
		STRING8   biog_number;
		STRING2   birth_day;
		STRING2   birth_month;
		STRING4   birth_year;
		STRING1   birth_date_suppress_ind;
		STRING67  birth_city;
		STRING67  birth_state;
		STRING67  birth_nation;
		STRING1   birth_location_suppress_ind;
		STRING40  first_name;
		STRING30  middle_name;
		STRING40  last_name;
		STRING15  name_suffix;
		STRING4   placement_cert;
		STRING100 placement_city;
		STRING2   placement_state;
		STRING1   gender;
		STRING1   board_certified;
		STRING10  dod;
		STRING4   board_code;
		STRING100 board_name;
		STRING1   participation;
		STRING8   moc_cert_id;
		STRING100 moc_cert_name;
		UNSIGNED6 address_id;
		STRING2   state;
		STRING9   full_zip;
		STRING60  org1;
		STRING40  line1;
		STRING40  line2;
		STRING40  line3;
		STRING40  city;
		STRING40  country;
		STRING1   address_type;
		STRING1   address_suppress_ind;
		STRING6   contact_type;
		STRING250 description;
		STRING3   area_code;
		STRING3   exchange;
		STRING4   phone_last_four;
		UNSIGNED6 address_occurrence_number;
		UNSIGNED6 contact_occurrence_number;
		STRING8   dob;
		STRING1   dead_ind;
		STRING60  org_name;
		STRING40  additional_org_text;
		STRING40  address1;
		STRING40  address2;
		STRING10  phone_number;
		STRING    website;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		STRING    board_source;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		UNSIGNED8 lnpid;
		layout_clean182_fips clean_company_address;
		layout_clean_name    clean_name;
		cleaned_phone        clean_phone;
		STRING    address_type_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyABMS__membership__biog_number := RECORD
		STRING8   biog_number;
		STRING1   record_type;
		STRING125 member_of;
		STRING125 position_held_years;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
	END;

	rKeyABMS__typeofpractice__biog_number := RECORD
		STRING8   biog_number;
		STRING1   record_type;
		STRING60  type_of_practice;
		STRING100 other_text;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
	END;


rKeyABMS__main__Linkids :=RECORD
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
  string8 biog_number;
  string2 birth_day;
  string2 birth_month;
  string4 birth_year;
  string1 birth_date_suppress_ind;
  string67 birth_city;
  string67 birth_state;
  string67 birth_nation;
  string1 birth_location_suppress_ind;
  string40 first_name;
  string30 middle_name;
  string40 last_name;
  string15 name_suffix;
  string4 placement_cert;
  string100 placement_city;
  string2 placement_state;
  string1 gender;
  string1 board_certified;
  string10 npi;
  string10 dod;
  string4 board_code;
  string100 board_name;
  string1 participation;
  string8 moc_cert_id;
  string100 moc_cert_name;
  unsigned6 address_id;
  string2 state;
  string9 full_zip;
  string60 org1;
  string40 line1;
  string40 line2;
  string40 line3;
  string40 city;
  string40 country;
  string1 address_type;
  string1 address_suppress_ind;
  string6 contact_type;
  string250 description;
  string3 area_code;
  string3 exchange;
  string4 phone_last_four;
  unsigned6 address_occurrence_number;
  unsigned6 contact_occurrence_number;
  string8 dob;
  string1 dead_ind;
  string60 org_name;
  string40 additional_org_text;
  string40 address1;
  string40 address2;
  string10 phone_number;
  string website;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  string board_source;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned6 did;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 lnpid;
  unsigned8 source_rec_id;
  layout_clean182_fips clean_company_address;
  layout_clean_name clean_name;
  cleaned_phone clean_phone;
  string address_type_desc;
  integer1 fp;
 END;


	ds_address  									:= DATASET([], rKeyABMS__autokey__address);
	ds_addressb2									:= DATASET([], rKeyABMS__autokey__addressb2);
	ds_citystname 								:= DATASET([], rKeyABMS__autokey__citystname);
	ds_citystnameb2								:= DATASET([], rKeyABMS__autokey__citystnameb2);
	ds_name 											:= DATASET([], rKeyABMS__autokey__name);
	ds_nameb2											:= DATASET([], rKeyABMS__autokey__nameb2);
	ds_namewords2									:= DATASET([], rKeyABMS__autokey__namewords2);
	ds_payload										:= DATASET([], rKeyABMS__autokey__payload);
	ds_phone2		  								:= DATASET([], rKeyABMS__autokey__phone2);
	ds_phoneb2										:= DATASET([], rKeyABMS__autokey__phoneb2);
	ds_stname 										:= DATASET([], rKeyABMS__autokey__stname);
	ds_stnameb2										:= DATASET([], rKeyABMS__autokey__stnameb2);
	ds_zip  											:= DATASET([], rKeyABMS__autokey__zip);
	ds_zipb2											:= DATASET([], rKeyABMS__autokey__zipb2);
  ds_career_biog_number      		:= DATASET([], rKeyABMS__career__biog_number);
  ds_cert_biog_number       		:= DATASET([], rKeyABMS__cert__biog_number);
  ds_education_biog_number      := DATASET([], rKeyABMS__education__biog_number);
  ds_lookups_specialty		      := DATASET([], rKeyABMS__lookups__specialty);
  ds_main_bdid       						:= DATASET([], rKeyABMS__main__bdid);
  ds_main_biog_number  					:= DATASET([], rKeyABMS__main__biog_number);
  ds_main_did 									:= DATASET([], rKeyABMS__main__did);
  ds_main_lname_cert_fname 			:= DATASET([], rKeyABMS__main__lname_cert_fname);
  ds_main_lname_specialty_fname := DATASET([], rKeyABMS__main__lname_specialty_fname);
  ds_main_npi 									:= DATASET([], rKeyABMS__main__npi);
	ds_main_LinkIDs 							:= DATASET([], rKeyABMS__main__LinkIDs);
  ds_membership_biog_number     := DATASET([], rKeyABMS__membership__biog_number);
  ds_typeofpractice_biog_number := DATASET([], rKeyABMS__typeofpractice__biog_number);

	address_IN  									:= INDEX(ds_address, {prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2, lname3, lookups}, {ds_address}, '~prte::key::abms::' + pIndexVersion + '::autokey::address');
	addressb2_IN									:= INDEX(ds_addressb2, {prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_addressb2}, '~prte::key::abms::' + pIndexVersion + '::autokey::addressb2');
	citystname_IN	  							:= INDEX(ds_citystname, {city_code, st, dph_lname, lname, pfname, fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_citystname}, '~prte::key::abms::' + pIndexVersion + '::autokey::citystname');
	citystnameb2_IN								:= INDEX(ds_citystnameb2, {city_code, st, cname_indic, cname_sec, bdid}, {ds_citystnameb2}, '~prte::key::abms::' + pIndexVersion + '::autokey::citystnameb2');
	name_IN 											:= INDEX(ds_name, {dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_name}, '~prte::key::abms::' + pIndexVersion + '::autokey::name');
	nameb2_IN											:= INDEX(ds_nameb2, {cname_indic, cname_sec, bdid}, {ds_nameb2}, '~prte::key::abms::' + pIndexVersion + '::autokey::nameb2');
	namewords2_IN									:= INDEX(ds_namewords2, {word, state, seq, bdid}, {ds_namewords2}, '~prte::key::abms::' + pIndexVersion + '::autokey::namewords2');
	payload_IN										:= INDEX(ds_payload, {fakeid}, {ds_payload}, '~prte::key::abms::' + pIndexVersion + '::autokey::payload');
	phone2_IN 										:= INDEX(ds_phone2, {p7, p3, dph_lname, pfname, st, did}, {ds_phone2}, '~prte::key::abms::' + pIndexVersion + '::autokey::phone2');
	phoneb2_IN										:= INDEX(ds_phoneb2, {p7, p3, cname_indic, cname_sec, st, bdid}, {ds_phoneb2}, '~prte::key::abms::' + pIndexVersion + '::autokey::phoneb2');
	stname_IN 										:= INDEX(ds_stname, {st, dph_lname, lname, pfname, fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_stname}, '~prte::key::abms::' + pIndexVersion + '::autokey::stname');
	stnameb2_IN										:= INDEX(ds_stnameb2, {st, cname_indic, cname_sec, bdid}, {ds_stnameb2}, '~prte::key::abms::' + pIndexVersion + '::autokey::stnameb2');
	zip_IN  											:= INDEX(ds_zip, {zip, dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_zip}, '~prte::key::abms::' + pIndexVersion + '::autokey::zip');
	zipb2_IN											:= INDEX(ds_zipb2, {zip, cname_indic, cname_sec, bdid}, {ds_zipb2}, '~prte::key::abms::' + pIndexVersion + '::autokey::zipb2');
  career_biog_number_IN					:= INDEX(ds_career_biog_number, {biog_number, record_type}, {ds_career_biog_number}, '~prte::key::abms::' + pIndexVersion + '::career::biog_number');	
  cert_biog_number_IN						:= INDEX(ds_cert_biog_number, {biog_number, record_type}, {ds_cert_biog_number}, '~prte::key::abms::' + pIndexVersion + '::cert::biog_number');	
  education_biog_number_IN			:= INDEX(ds_education_biog_number, {biog_number, record_type}, {ds_education_biog_number}, '~prte::key::abms::' + pIndexVersion + '::education::biog_number');	
  lookups_specialty_IN					:= INDEX(ds_lookups_specialty, {specialty, sub_specialty_id, sub_specialty}, {ds_lookups_specialty}, '~prte::key::abms::' + pIndexVersion + '::lookups::specialty');	
  main_bdid_IN									:= INDEX(ds_main_bdid, {bdid, biog_number}, {ds_main_bdid}, '~prte::key::abms::' + pIndexVersion + '::main::bdid');	
  main_biog_number_IN						:= INDEX(ds_main_biog_number, {biog_number, record_type}, {ds_main_biog_number}, '~prte::key::abms::' + pIndexVersion + '::main::biog_number');	
  main_did_IN										:= INDEX(ds_main_did, {did, biog_number}, {ds_main_did}, '~prte::key::abms::' + pIndexVersion + '::main::did');	
  main_lname_cert_fname_IN			:= INDEX(ds_main_lname_cert_fname, {last_name, cert_name, first_name, biog_number}, {ds_main_lname_cert_fname}, '~prte::key::abms::' + pIndexVersion + '::main::lname_cert_fname');	
  main_lname_specialty_fname_IN	:= INDEX(ds_main_lname_specialty_fname, {last_name, specialty, first_name, biog_number}, {ds_main_lname_specialty_fname}, '~prte::key::abms::' + pIndexVersion + '::main::lname_specialty_fname');	
  main_npi_IN										:= INDEX(ds_main_npi, {npi, biog_number}, {ds_main_npi}, '~prte::key::abms::' + pIndexVersion + '::main::npi');	
	main_linkids_IN							  := INDEX(ds_main_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, {ds_main_linkids}, '~prte::key::abms::' + pIndexVersion + '::main::linkids');	
  membership_biog_number_IN			:= INDEX(ds_membership_biog_number, {biog_number, record_type}, {ds_membership_biog_number}, '~prte::key::abms::' + pIndexVersion + '::membership::biog_number');	
  typeofpractice_biog_number_IN	:= INDEX(ds_typeofpractice_biog_number, {biog_number, record_type}, {ds_typeofpractice_biog_number}, '~prte::key::abms::' + pIndexVersion + '::typeofpractice::biog_number');	

	RETURN SEQUENTIAL(PARALLEL(BUILD(address_IN, update),
														 BUILD(addressb2_IN, update),
														 BUILD(citystname_IN, update),
														 BUILD(citystnameb2_IN, update),
														 BUILD(name_IN, update),
														 BUILD(nameb2_IN, update),
														 BUILD(namewords2_IN, update),
														 BUILD(payload_IN, update),
														 BUILD(phone2_IN, update),
														 BUILD(phoneb2_IN, update),
														 BUILD(stname_IN, update),
														 BUILD(stnameb2_IN, update),
														 BUILD(zip_IN, update),
														 BUILD(zipb2_IN, update),
														 BUILD(career_biog_number_IN, update),
														 BUILD(cert_biog_number_IN, update),
														 BUILD(education_biog_number_IN, update),
														 BUILD(lookups_specialty_IN, update),
														 BUILD(main_bdid_IN, update),
														 BUILD(main_biog_number_IN, update),
														 BUILD(main_did_IN, update),
														 BUILD(main_lname_cert_fname_IN, update),
														 BUILD(main_lname_specialty_fname_IN, update),
														 BUILD(main_npi_IN, update),
														 BUILD(main_linkids_IN, update),
														 BUILD(membership_biog_number_IN, update),
														 BUILD(typeofpractice_biog_number_IN, update)),
									  PRTE.UpdateVersion('ABMSKeys',											   //	Package name
																	     pIndexVersion,											 //	Package version
																	     _control.MyInfo.EmailAddressNormal, //	Who to email with specifics
																	     'B',																 //	B = Boca, A = Alpharetta
																	     'N',																 //	N = Non-FCRA, F = FCRA
																	     'N'																 //	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );
END;