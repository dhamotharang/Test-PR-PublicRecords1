IMPORT _Control, bipv2;

EXPORT Proc_Build_AMS_Keys(STRING pIndexVersion) := FUNCTION

	rKeyAMS__autokey__address := RECORD
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

	rKeyAMS__autokey__addressb2 := RECORD
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

	rKeyAMS__autokey__citystname := RECORD
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

	rKeyAMS__autokey__citystnameb2 := RECORD
		UNSIGNED4 city_code;
		STRING2   st;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyAMS__autokey__fein2 := RECORD
		STRING1   f1;
		STRING1   f2;
		STRING1   f3;
		STRING1   f4;
		STRING1   f5;
		STRING1   f6;
		STRING1   f7;
		STRING1   f8;
		STRING1   f9;
	  STRING40  cname_indic;
	  STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyAMS__autokey__name := RECORD
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

	rKeyAMS__autokey__nameb2 := RECORD
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyAMS__autokey__namewords2 := RECORD
		STRING40  word;
		STRING2   state;
		UNSIGNED1 seq;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

  demographics := RECORD
		STRING   ams_seq;
		STRING   ams_batch;
		STRING   ams_deleted;
		STRING   amsid_type;
		STRING   amsid_subtype;
		STRING8  ams_id;
		STRING   ams_gold_flag;
		STRING20 indy_id;
		STRING   src_cd;
		STRING   acct_name;
		STRING   alt_name;
		STRING   full_name;
		STRING   last_name;
		STRING   first_name;
		STRING   middle_name;
		STRING   suffix_name;
		STRING   former_last_name;
		STRING   former_first_name;
		STRING   former_middle_name;
		STRING   former_suffix_name;
		STRING   nick_name;
		STRING   sector_cd;
		STRING   fiscal_cd;
		STRING   academic_flag;
		STRING   gen_cd;
		STRING   dob_date;
		STRING   yob_date;
		STRING   birth_city;
		STRING   birth_state;
		STRING   birth_cntry;
		STRING   opt_out_flag;
		STRING   opt_out_start_date;
		STRING   kaiser_prov_flag;
		STRING   status;
		STRING   status_cd;
		STRING   status_update_date;
		STRING   presumed_dead_flag;
		STRING   contact_flag;
		STRING   top_cd;
		STRING   pe_cd;
		STRING   mpa_cd;
		STRING9  tax_id;
		STRING   ssn_last4;
		STRING   solo;
		STRING   group_affiliated;
		STRING   hospital_affiliated;
		STRING   administrator;
		STRING   research;
		STRING   clinical_trials;
		STRING   phone_flag;
		STRING   email_flag;
		STRING   fax_flag;
		STRING   url_flag;
		STRING   add_date;
		STRING   update_date;
		STRING   delete_date;
  END;
	
  address := RECORD
		STRING    ams_seq;
		STRING    ams_batch;
		STRING    ams_deleted;
		STRING8   ams_id;
		STRING    gold_record_flag;
		STRING    bob_rank;
		STRING    bob_value;
		STRING8   new_ams_id;
		STRING    new_ams_addr_id;
		STRING    ams_addr_id;
		STRING    inactive_reason_cd;
		STRING20  indy_id;
		STRING    src_cd;
		STRING    ams_street;
		STRING    ams_unit;
		STRING    ams_city;
		STRING    ams_state;
		STRING    ams_zip5;
		STRING    ams_zip4;
		STRING    leftovers;
		STRING    cntry_cd;
		STRING    cbsa_cd;
		STRING    fips_cnty_cd;
		STRING    fips_state_cd;
		STRING    addr_type;
		STRING    ams_glid;
		STRING    multiunit_cd;
		STRING    ams_addr_pass_flag;
		STRING    addr_status;
		STRING    add_start_date;
		STRING    add_end_date;
		STRING    org_unit;
		STRING8   ams_account_id;
		STRING    unit_name;
		STRING    unit_value;
		STRING    floor_value;
		STRING    building_name_value;
		STRING    dept_name_value;
		STRING    cass_flag;
		STRING    cong_cd;
		STRING    cmra_flag;
		STRING    dpc_cd;
		STRING    street_type_cd;
		STRING    invalidunit_flag;
		STRING    buildfirm_name;
		STRING    dpv_cd;
		STRING    rdi_cd;
		STRING    lat_addr;
		STRING    lng_addr;
		STRING    latlong_type;
		STRING    phone;
		STRING    phone_ext;
		STRING    phone_flag;
		STRING    email;
		STRING    email_flag;
		STRING    fax;
		STRING    fax_flag;
		STRING    url;
		STRING    url_flag;
		STRING    dea_num;
		STRING    exp_date;
		STRING    drug_schedules;
		STRING    addr_id;
		STRING    add_date;
		STRING    update_date;
		STRING    delete_date;
		STRING    loc_id;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
  END;
	
  cleaned_name := RECORD
		STRING5  title;
		STRING20 fname;
		STRING20 mname;
		STRING20 lname;
		STRING5  name_suffix;
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
	
  cleaned_phones := RECORD
		STRING10 phone;
		STRING10 fax;
  END;
	
	rKeyAMS__autokey__payload := RECORD
		UNSIGNED6 fakeid;
		STRING8   ams_id;
		STRING    amsid_type;
		STRING    amsid_subtype;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
    demographics rawdemographicsfields;
		address      rawaddressfields;
		STRING    amsid_type_desc;
		STRING    amsid_subtype_desc;
		STRING    src_cd_desc;
		STRING    sector_cd_desc;
		STRING    academic_flag_desc;
		STRING    status_cd_desc;
		STRING    gen_cd_desc;
		STRING    birth_cntry_desc;
		STRING    opt_out_flag_desc;
		STRING    kaiser_prov_flag_desc;
		STRING    status_desc;
		STRING    presumed_dead_flag_desc;
		STRING    contact_flag_desc;
		STRING    top_cd_desc;
		STRING    pe_cd_desc;
		STRING    mpa_cd_desc;
		STRING    solo_desc;
		STRING    group_affiliated_desc;
		STRING    hospital_affiliated_desc;
		STRING    administrator_desc;
		STRING    research_desc;
		STRING    clinical_trials_desc;
		STRING    phone_flag_desc;
		STRING    email_flag_desc;
		STRING    fax_flag_desc;
		STRING    url_flag_desc;
		cleaned_name         clean_name;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyAMS__autokey__phone2 := RECORD
		STRING7   p7;
		STRING3   p3;
		STRING6   dph_lname;
		STRING20  pfname;
		STRING2   st;
		UNSIGNED6 did;
		UNSIGNED4 lookups;
	END;

	rKeyAMS__autokey__phoneb2 := RECORD
		STRING7   p7;
		STRING3   p3;
		STRING40  cname_indic;
		STRING40  cname_sec;
		STRING2   st;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyAMS__autokey__stname := RECORD
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

	rKeyAMS__autokey__stnameb2 := RECORD
		STRING2   st;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyAMS__autokey__zip := RECORD
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

	rKeyAMS__autokey__zipb2 := RECORD
		INTEGER4  zip;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	affiliation := RECORD
		STRING  ams_seq;
		STRING  ams_batch;
		STRING  ams_deleted;
		STRING  src_cd;
		STRING8 ams_parent_id;
		STRING8 ams_child_id;
		STRING  affil_status;
		STRING  affil_type;
		STRING  affil_update_date;
		STRING  affil_start_date;
		STRING  affil_end_date;
		STRING  add_date;
		STRING  update_date;
		STRING  delete_date;
	END;

	rKeyAMS__affiliation__amsid := RECORD
		STRING8   ams_id;
		STRING1   record_type;
		STRING8   ams_other_id;
		BOOLEAN   isparent;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		affiliation rawfields;
		STRING    src_cd_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	credential := RECORD
		STRING  ams_seq;
		STRING  ams_batch;
		STRING  ams_deleted;
		STRING8 ams_id;
    STRING  credential;
		STRING  add_date;
		STRING  update_date;
		STRING  delete_date;
	END;

	rKeyAMS__credential__amsid := RECORD
		STRING8   ams_id;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		credential rawfields;
		STRING    credential_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	degree := RECORD
		STRING  ams_seq;
		STRING  ams_batch;
		STRING  ams_deleted;
		STRING8 ams_id;
    STRING  degree;
    STRING  best_degree;
		STRING  add_date;
		STRING  update_date;
		STRING  delete_date;
	END;

	rKeyAMS__degree__amsid := RECORD
		STRING8   ams_id;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		degree rawfields;
		STRING    degree_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	idnumber := RECORD
		STRING   ams_seq;
		STRING   ams_batch;
		STRING   ams_deleted;
		STRING8  ams_id;
		STRING20 indy_id;
    STRING   src_cd;
    STRING   indy_id_end_date;
    STRING   end_date_reason;
		STRING   add_date;
		STRING   update_date;
		STRING   delete_date;
	END;

	rKeyAMS__idnumber__amsid := RECORD
		STRING8   ams_id;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		idnumber rawfields;
		STRING    src_cd_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyAMS__main__amsid := RECORD
		STRING8   ams_id;
		STRING1   record_type;
		STRING    amsid_type;
		STRING    amsid_subtype;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
    demographics rawdemographicsfields;
		address      rawaddressfields;
		STRING    amsid_type_desc;
		STRING    amsid_subtype_desc;
		STRING    src_cd_desc;
		STRING    sector_cd_desc;
		STRING    academic_flag_desc;
		STRING    status_cd_desc;
		STRING    gen_cd_desc;
		STRING    birth_cntry_desc;
		STRING    opt_out_flag_desc;
		STRING    kaiser_prov_flag_desc;
		STRING    status_desc;
		STRING    presumed_dead_flag_desc;
		STRING    contact_flag_desc;
		STRING    top_cd_desc;
		STRING    pe_cd_desc;
		STRING    mpa_cd_desc;
		STRING    solo_desc;
		STRING    group_affiliated_desc;
		STRING    hospital_affiliated_desc;
		STRING    administrator_desc;
		STRING    research_desc;
		STRING    clinical_trials_desc;
		STRING    phone_flag_desc;
		STRING    email_flag_desc;
		STRING    fax_flag_desc;
		STRING    url_flag_desc;
		cleaned_name         clean_name;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyAMS__main__bdid := RECORD
		UNSIGNED6 bdid;
		STRING8   ams_id;
		STRING    amsid_type;
		STRING    amsid_subtype;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED1 bdid_score;
    demographics rawdemographicsfields;
		address      rawaddressfields;
		STRING    amsid_type_desc;
		STRING    amsid_subtype_desc;
		STRING    src_cd_desc;
		STRING    sector_cd_desc;
		STRING    academic_flag_desc;
		STRING    status_cd_desc;
		STRING    gen_cd_desc;
		STRING    birth_cntry_desc;
		STRING    opt_out_flag_desc;
		STRING    kaiser_prov_flag_desc;
		STRING    status_desc;
		STRING    presumed_dead_flag_desc;
		STRING    contact_flag_desc;
		STRING    top_cd_desc;
		STRING    pe_cd_desc;
		STRING    mpa_cd_desc;
		STRING    solo_desc;
		STRING    group_affiliated_desc;
		STRING    hospital_affiliated_desc;
		STRING    administrator_desc;
		STRING    research_desc;
		STRING    clinical_trials_desc;
		STRING    phone_flag_desc;
		STRING    email_flag_desc;
		STRING    fax_flag_desc;
		STRING    url_flag_desc;
		cleaned_name         clean_name;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

 rKeyAMS__main__linkid := RECORD
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
  string8 ams_id;
  string amsid_type;
  string amsid_subtype;
  string1 record_type;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  demographics rawdemographicsfields;
  address rawaddressfields;
  string amsid_type_desc;
  string amsid_subtype_desc;
  string src_cd_desc;
  string sector_cd_desc;
  string academic_flag_desc;
  string status_cd_desc;
  string gen_cd_desc;
  string birth_cntry_desc;
  string opt_out_flag_desc;
  string kaiser_prov_flag_desc;
  string status_desc;
  string presumed_dead_flag_desc;
  string contact_flag_desc;
  string top_cd_desc;
  string pe_cd_desc;
  string mpa_cd_desc;
  string solo_desc;
  string group_affiliated_desc;
  string hospital_affiliated_desc;
  string administrator_desc;
  string research_desc;
  string clinical_trials_desc;
  string phone_flag_desc;
  string email_flag_desc;
  string fax_flag_desc;
  string url_flag_desc;
  cleaned_name clean_name;
  layout_clean182_fips clean_company_address;
  cleaned_phones clean_phones;
  unsigned8 source_rec_id;
  integer1 fp;
 END;

	rKeyAMS__main__did := RECORD
		UNSIGNED6 did;
		STRING8   ams_id;
		STRING    amsid_type;
		STRING    amsid_subtype;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
    demographics rawdemographicsfields;
		address      rawaddressfields;
		STRING    amsid_type_desc;
		STRING    amsid_subtype_desc;
		STRING    src_cd_desc;
		STRING    sector_cd_desc;
		STRING    academic_flag_desc;
		STRING    status_cd_desc;
		STRING    gen_cd_desc;
		STRING    birth_cntry_desc;
		STRING    opt_out_flag_desc;
		STRING    kaiser_prov_flag_desc;
		STRING    status_desc;
		STRING    presumed_dead_flag_desc;
		STRING    contact_flag_desc;
		STRING    top_cd_desc;
		STRING    pe_cd_desc;
		STRING    mpa_cd_desc;
		STRING    solo_desc;
		STRING    group_affiliated_desc;
		STRING    hospital_affiliated_desc;
		STRING    administrator_desc;
		STRING    research_desc;
		STRING    clinical_trials_desc;
		STRING    phone_flag_desc;
		STRING    email_flag_desc;
		STRING    fax_flag_desc;
		STRING    url_flag_desc;
		cleaned_name         clean_name;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyAMS__main__license__number := RECORD
		STRING20  st_lic_num;
		STRING8   ams_id;
		STRING2   st_lic_state;
		STRING    amsid_type;
		STRING    amsid_subtype;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
    demographics rawdemographicsfields;
		address      rawaddressfields;
		STRING    amsid_type_desc;
		STRING    amsid_subtype_desc;
		STRING    src_cd_desc;
		STRING    sector_cd_desc;
		STRING    academic_flag_desc;
		STRING    status_cd_desc;
		STRING    gen_cd_desc;
		STRING    birth_cntry_desc;
		STRING    opt_out_flag_desc;
		STRING    kaiser_prov_flag_desc;
		STRING    status_desc;
		STRING    presumed_dead_flag_desc;
		STRING    contact_flag_desc;
		STRING    top_cd_desc;
		STRING    pe_cd_desc;
		STRING    mpa_cd_desc;
		STRING    solo_desc;
		STRING    group_affiliated_desc;
		STRING    hospital_affiliated_desc;
		STRING    administrator_desc;
		STRING    research_desc;
		STRING    clinical_trials_desc;
		STRING    phone_flag_desc;
		STRING    email_flag_desc;
		STRING    fax_flag_desc;
		STRING    url_flag_desc;
		cleaned_name         clean_name;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyAMS__main__license__number__state := RECORD
		STRING20  st_lic_num;
		STRING2   st_lic_state;
		STRING8   ams_id;
		STRING    amsid_type;
		STRING    amsid_subtype;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
    demographics rawdemographicsfields;
		address      rawaddressfields;
		STRING    amsid_type_desc;
		STRING    amsid_subtype_desc;
		STRING    src_cd_desc;
		STRING    sector_cd_desc;
		STRING    academic_flag_desc;
		STRING    status_cd_desc;
		STRING    gen_cd_desc;
		STRING    birth_cntry_desc;
		STRING    opt_out_flag_desc;
		STRING    kaiser_prov_flag_desc;
		STRING    status_desc;
		STRING    presumed_dead_flag_desc;
		STRING    contact_flag_desc;
		STRING    top_cd_desc;
		STRING    pe_cd_desc;
		STRING    mpa_cd_desc;
		STRING    solo_desc;
		STRING    group_affiliated_desc;
		STRING    hospital_affiliated_desc;
		STRING    administrator_desc;
		STRING    research_desc;
		STRING    clinical_trials_desc;
		STRING    phone_flag_desc;
		STRING    email_flag_desc;
		STRING    fax_flag_desc;
		STRING    url_flag_desc;
		cleaned_name         clean_name;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyAMS__main__license__state := RECORD
		STRING2   st_lic_state;
		STRING8   ams_id;
		STRING20  st_lic_num;
		STRING    amsid_type;
		STRING    amsid_subtype;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
    demographics rawdemographicsfields;
		address      rawaddressfields;
		STRING    amsid_type_desc;
		STRING    amsid_subtype_desc;
		STRING    src_cd_desc;
		STRING    sector_cd_desc;
		STRING    academic_flag_desc;
		STRING    status_cd_desc;
		STRING    gen_cd_desc;
		STRING    birth_cntry_desc;
		STRING    opt_out_flag_desc;
		STRING    kaiser_prov_flag_desc;
		STRING    status_desc;
		STRING    presumed_dead_flag_desc;
		STRING    contact_flag_desc;
		STRING    top_cd_desc;
		STRING    pe_cd_desc;
		STRING    mpa_cd_desc;
		STRING    solo_desc;
		STRING    group_affiliated_desc;
		STRING    hospital_affiliated_desc;
		STRING    administrator_desc;
		STRING    research_desc;
		STRING    clinical_trials_desc;
		STRING    phone_flag_desc;
		STRING    email_flag_desc;
		STRING    fax_flag_desc;
		STRING    url_flag_desc;
		cleaned_name         clean_name;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyAMS__main__npi := RECORD
		STRING20  npi;
		STRING8   ams_id;
		STRING    amsid_type;
		STRING    amsid_subtype;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
    demographics rawdemographicsfields;
		address      rawaddressfields;
		STRING    amsid_type_desc;
		STRING    amsid_subtype_desc;
		STRING    src_cd_desc;
		STRING    sector_cd_desc;
		STRING    academic_flag_desc;
		STRING    status_cd_desc;
		STRING    gen_cd_desc;
		STRING    birth_cntry_desc;
		STRING    opt_out_flag_desc;
		STRING    kaiser_prov_flag_desc;
		STRING    status_desc;
		STRING    presumed_dead_flag_desc;
		STRING    contact_flag_desc;
		STRING    top_cd_desc;
		STRING    pe_cd_desc;
		STRING    mpa_cd_desc;
		STRING    solo_desc;
		STRING    group_affiliated_desc;
		STRING    hospital_affiliated_desc;
		STRING    administrator_desc;
		STRING    research_desc;
		STRING    clinical_trials_desc;
		STRING    phone_flag_desc;
		STRING    email_flag_desc;
		STRING    fax_flag_desc;
		STRING    url_flag_desc;
		cleaned_name         clean_name;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyAMS__main__taxid := RECORD
		STRING9   tax_id;
		STRING8   ams_id;
		STRING    amsid_type;
		STRING    amsid_subtype;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
    demographics rawdemographicsfields;
		address      rawaddressfields;
		STRING    amsid_type_desc;
		STRING    amsid_subtype_desc;
		STRING    src_cd_desc;
		STRING    sector_cd_desc;
		STRING    academic_flag_desc;
		STRING    status_cd_desc;
		STRING    gen_cd_desc;
		STRING    birth_cntry_desc;
		STRING    opt_out_flag_desc;
		STRING    kaiser_prov_flag_desc;
		STRING    status_desc;
		STRING    presumed_dead_flag_desc;
		STRING    contact_flag_desc;
		STRING    top_cd_desc;
		STRING    pe_cd_desc;
		STRING    mpa_cd_desc;
		STRING    solo_desc;
		STRING    group_affiliated_desc;
		STRING    hospital_affiliated_desc;
		STRING    administrator_desc;
		STRING    research_desc;
		STRING    clinical_trials_desc;
		STRING    phone_flag_desc;
		STRING    email_flag_desc;
		STRING    fax_flag_desc;
		STRING    url_flag_desc;
		cleaned_name         clean_name;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	specialty := RECORD
   string ams_seq;
   string ams_batch;
   string ams_deleted;
   string8 ams_id;
   string specialty_type;
   string specialty;
   string src_cd;
   string add_date;
   string update_date;
   string delete_date;
  END;


	rKeyAMS__specialty__amsid := RECORD
		STRING8   ams_id;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		specialty rawfields;
		STRING    specialty_desc;
		STRING    src_cd_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	statelicense := RECORD
		STRING   ams_seq;
		STRING   ams_batch;
		STRING   ams_deleted;
		STRING8  ams_id;
		STRING20 indy_id;
		STRING   src_cd;
		STRING20 st_lic_num;
		STRING   st_lic_brd_cd;
		STRING2   st_lic_state;
		STRING   st_lic_degree;
		STRING   st_lic_type;
		STRING   st_lic_status;
		STRING   st_lic_exp_date;
		STRING   st_lic_issue_date;
		STRING   st_lic_brd_date;
		STRING   eligibility_cd;
		STRING   add_date;
		STRING   update_date;
		STRING   delete_date;
	END;

	rKeyAMS__statelicense__amsid := RECORD
		STRING8   ams_id;
		STRING1   record_type;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		statelicense rawfields;
		STRING    src_cd_desc;
		STRING    st_lic_state_desc;
		STRING    st_lic_degree_desc;
		STRING    st_lic_type_desc;
		STRING    st_lic_status_desc;
		STRING    eligibility_cd_desc;
		UNSIGNED8 __internal_fpos__;
	END;

	ds_address  									:= DATASET([], rKeyAMS__autokey__address);
	ds_addressb2									:= DATASET([], rKeyAMS__autokey__addressb2);
	ds_citystname 								:= DATASET([], rKeyAMS__autokey__citystname);
	ds_citystnameb2								:= DATASET([], rKeyAMS__autokey__citystnameb2);
	ds_fein2											:= DATASET([], rKeyAMS__autokey__fein2);
	ds_name 											:= DATASET([], rKeyAMS__autokey__name);
	ds_nameb2											:= DATASET([], rKeyAMS__autokey__nameb2);
	ds_namewords2									:= DATASET([], rKeyAMS__autokey__namewords2);
	ds_payload										:= DATASET([], rKeyAMS__autokey__payload);
	ds_phone2		  								:= DATASET([], rKeyAMS__autokey__phone2);
	ds_phoneb2										:= DATASET([], rKeyAMS__autokey__phoneb2);
	ds_stname 										:= DATASET([], rKeyAMS__autokey__stname);
	ds_stnameb2										:= DATASET([], rKeyAMS__autokey__stnameb2);
	ds_zip  											:= DATASET([], rKeyAMS__autokey__zip);
	ds_zipb2											:= DATASET([], rKeyAMS__autokey__zipb2);
  ds_affiliation_amsid      		:= DATASET([], rKeyAMS__affiliation__amsid);
  ds_credential_amsid       		:= DATASET([], rKeyAMS__credential__amsid);
  ds_degree_amsid			       		:= DATASET([], rKeyAMS__degree__amsid);
  ds_idnumber_amsid      				:= DATASET([], rKeyAMS__idnumber__amsid);
  ds_main_amsid  								:= DATASET([], rKeyAMS__main__amsid);
  ds_main_bdid       						:= DATASET([], rKeyAMS__main__bdid);
	ds_main_linkid     						:= DATASET([], rKeyAMS__main__linkid);
  ds_main_did 									:= DATASET([], rKeyAMS__main__did);
  ds_main_license_number 				:= DATASET([], rKeyAMS__main__license__number);
  ds_main_license_number_state 	:= DATASET([], rKeyAMS__main__license__number__state);
  ds_main_license_state 				:= DATASET([], rKeyAMS__main__license__state);
  ds_main_npi 									:= DATASET([], rKeyAMS__main__npi);
  ds_main_taxid 								:= DATASET([], rKeyAMS__main__taxid);
  ds_specialty_amsid 						:= DATASET([], rKeyAMS__specialty__amsid);
  ds_statelicense_amsid 				:= DATASET([], rKeyAMS__statelicense__amsid);

	address_IN  									:= INDEX(ds_address, {prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2, lname3, lookups}, {ds_address}, '~prte::key::ams::' + pIndexVersion + '::autokey::address');
	addressb2_IN									:= INDEX(ds_addressb2, {prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_addressb2}, '~prte::key::ams::' + pIndexVersion + '::autokey::addressb2');
	citystname_IN	  							:= INDEX(ds_citystname, {city_code, st, dph_lname, lname, pfname, fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_citystname}, '~prte::key::ams::' + pIndexVersion + '::autokey::citystname');
	citystnameb2_IN								:= INDEX(ds_citystnameb2, {city_code, st, cname_indic, cname_sec, bdid}, {ds_citystnameb2}, '~prte::key::ams::' + pIndexVersion + '::autokey::citystnameb2');
	fein2_IN      								:= INDEX(ds_fein2, {f1, f2, f3, f4, f5, f6, f7, f8, f9, cname_indic, cname_sec, bdid}, {ds_fein2}, '~prte::key::ams::' + pIndexVersion + '::autokey::fein2');
	name_IN 											:= INDEX(ds_name, {dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_name}, '~prte::key::ams::' + pIndexVersion + '::autokey::name');
	nameb2_IN											:= INDEX(ds_nameb2, {cname_indic, cname_sec, bdid}, {ds_nameb2}, '~prte::key::ams::' + pIndexVersion + '::autokey::nameb2');
	namewords2_IN									:= INDEX(ds_namewords2, {word, state, seq, bdid}, {ds_namewords2}, '~prte::key::ams::' + pIndexVersion + '::autokey::namewords2');
	payload_IN										:= INDEX(ds_payload, {fakeid}, {ds_payload}, '~prte::key::ams::' + pIndexVersion + '::autokey::payload');
	phone2_IN 										:= INDEX(ds_phone2, {p7, p3, dph_lname, pfname, st, did}, {ds_phone2}, '~prte::key::ams::' + pIndexVersion + '::autokey::phone2');
	phoneb2_IN										:= INDEX(ds_phoneb2, {p7, p3, cname_indic, cname_sec, st, bdid}, {ds_phoneb2}, '~prte::key::ams::' + pIndexVersion + '::autokey::phoneb2');
	stname_IN 										:= INDEX(ds_stname, {st, dph_lname, lname, pfname, fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_stname}, '~prte::key::ams::' + pIndexVersion + '::autokey::stname');
	stnameb2_IN										:= INDEX(ds_stnameb2, {st, cname_indic, cname_sec, bdid}, {ds_stnameb2}, '~prte::key::ams::' + pIndexVersion + '::autokey::stnameb2');
	zip_IN  											:= INDEX(ds_zip, {zip, dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_zip}, '~prte::key::ams::' + pIndexVersion + '::autokey::zip');
	zipb2_IN											:= INDEX(ds_zipb2, {zip, cname_indic, cname_sec, bdid}, {ds_zipb2}, '~prte::key::ams::' + pIndexVersion + '::autokey::zipb2');
  affiliation_amsid_IN					:= INDEX(ds_affiliation_amsid, {ams_id, record_type, ams_other_id}, {ds_affiliation_amsid}, '~prte::key::ams::' + pIndexVersion + '::affiliation::amsid');	
  credential_amsid_IN						:= INDEX(ds_credential_amsid, {ams_id, record_type}, {ds_credential_amsid}, '~prte::key::ams::' + pIndexVersion + '::credential::amsid');	
  degree_amsid_IN								:= INDEX(ds_degree_amsid, {ams_id, record_type}, {ds_degree_amsid}, '~prte::key::ams::' + pIndexVersion + '::degree::amsid');	
  idnumber_amsid_IN							:= INDEX(ds_idnumber_amsid, {ams_id, record_type}, {ds_idnumber_amsid}, '~prte::key::ams::' + pIndexVersion + '::idnumber::amsid');	
  main_amsid_IN									:= INDEX(ds_main_amsid, {ams_id, record_type}, {ds_main_amsid}, '~prte::key::ams::' + pIndexVersion + '::main::amsid');	
  main_bdid_IN 									:= INDEX(ds_main_bdid, {bdid, ams_id}, {ds_main_bdid}, '~prte::key::ams::' + pIndexVersion + '::main::bdid');
	main_linkid_IN 								:= INDEX(ds_main_linkid, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_main_linkid}, '~prte::key::ams::' + pIndexVersion + '::main::linkids');	
  main_did_IN 									:= INDEX(ds_main_did, {did, ams_id}, {ds_main_did}, '~prte::key::ams::' + pIndexVersion + '::main::did');	
  main_license_number_IN				:= INDEX(ds_main_license_number, {st_lic_num, ams_id}, {ds_main_license_number}, '~prte::key::ams::' + pIndexVersion + '::main::license_number');	
  main_license_number_state_IN	:= INDEX(ds_main_license_number_state, {st_lic_num, st_lic_state, ams_id}, {ds_main_license_number_state}, '~prte::key::ams::' + pIndexVersion + '::main::license_number_state');	
  main_license_state_IN					:= INDEX(ds_main_license_state, {st_lic_state, ams_id}, {ds_main_license_state}, '~prte::key::ams::' + pIndexVersion + '::main::license_state');	
  main_npi_IN 									:= INDEX(ds_main_npi, {npi, ams_id}, {ds_main_npi}, '~prte::key::ams::' + pIndexVersion + '::main::npi');	
  main_taxid_IN									:= INDEX(ds_main_taxid, {tax_id, ams_id}, {ds_main_taxid}, '~prte::key::ams::' + pIndexVersion + '::main::taxid');	
  specialty_amsid_IN						:= INDEX(ds_specialty_amsid, {ams_id, record_type}, {ds_specialty_amsid}, '~prte::key::ams::' + pIndexVersion + '::specialty::amsid');	
  statelicense_amsid_IN					:= INDEX(ds_statelicense_amsid, {ams_id, record_type}, {ds_statelicense_amsid}, '~prte::key::ams::' + pIndexVersion + '::statelicense::amsid');	

	RETURN SEQUENTIAL(PARALLEL(BUILD(address_IN, update),
														 BUILD(addressb2_IN, update),
														 BUILD(citystname_IN, update),
														 BUILD(citystnameb2_IN, update),
														 BUILD(fein2_IN, update),
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
														 BUILD(affiliation_amsid_IN, update),
														 BUILD(credential_amsid_IN, update),
														 BUILD(degree_amsid_IN, update),
														 BUILD(idnumber_amsid_IN, update),
														 BUILD(main_amsid_IN, update),
														 BUILD(main_bdid_IN, update),
														 BUILD(main_linkid_IN, update),
														 BUILD(main_did_IN, update),
														 BUILD(main_license_number_IN, update),
														 BUILD(main_license_number_state_IN, update),
														 BUILD(main_license_state_IN, update),
														 BUILD(main_npi_IN, update),
														 BUILD(main_taxid_IN, update),
														 BUILD(specialty_amsid_IN, update),
														 BUILD(statelicense_amsid_IN, update)),
									  PRTE.UpdateVersion('AMSKeys',											     //	Package name
																	     pIndexVersion,											 //	Package version
																	     _control.MyInfo.EmailAddressNormal, //	Who to email with specifics
																	     'B',																 //	B = Boca, A = Alpharetta
																	     'N',																 //	N = Non-FCRA, F = FCRA
																	     'N'																 //	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );
END;