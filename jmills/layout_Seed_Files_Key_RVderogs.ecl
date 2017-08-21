EXPORT layout_Seed_Files_Key_RVderogs := RECORD
  string20 dataset_name;
  data16 hashvalue;
  string30 acctno;
  string15 fname;
  string20 lname;
  string9 zip;
  string9 ssn;
  string10 hphone;
  unsigned8 seq;
  unsigned8 did;
  string1 bankrupt;
  string1 federal_tax_lien;
  string30 federal_tax_amount;
  string1 state_tax_lien;
  string30 state_tax_amount;
  string1 county_tax_lien;
  string30 county_tax_amount;
  string1 child_support;
  string30 child_support_amount;
  // bk_final bankruptcy;
string10	bk_final_seq_number;
string5	bk_final_court_code;
string7	bk_final_case_number;
string20	bk_final_debtor_fname;
string20	bk_final_debtor_mname;
string20	bk_final_debtor_lname;
string5	bk_final_debtor_name_suffix;
string10	bk_final_prim_range;
string2	bk_final_predir;
string28	bk_final_prim_name;
string4	bk_final_suffix;
string2	bk_final_postdir;
string10	bk_final_unit_desig;
string8	bk_final_sec_range;
string25	bk_final_p_city_name;
string2	bk_final_st;
string5	bk_final_z5;
string4	bk_final_zip4;
string2	bk_final_rec_type;
string5	bk_final_county;
string25	bk_final_county_name;
string8	bk_final_date_filed;
string8	bk_final_date_created;
string50	bk_final_court_name;
string40	bk_final_court_location;
string20	bk_final_court_state;
string8	bk_final_case_closing_date;
string3	bk_final_chapter;
string12	bk_final_filing_status;
string20	bk_final_filer_type_mapped;
string3	bk_final_pro_se_ind;
string8	bk_final_orig_filing_date;
string3	bk_final_corp_flag;
string8	bk_final_meeting_date;
string8	bk_final_meeting_time;
string90	bk_final_address_341;
string35	bk_final_disposition;
string8	bk_final_converted_date;
  // lien_final liens;
string50	liens_final_tmsid;
string5	liens_final_title;
string20	liens_final_fname;
string20	liens_final_mname;
string20	liens_final_lname;
string5	liens_final_name_suffix;
string10	liens_final_prim_range;
string2	liens_final_predir;
string28	liens_final_prim_name;
string4	liens_final_suffix;
string2	liens_final_postdir;
string10	liens_final_unit_desig;
string8	liens_final_sec_range;
string25	liens_final_p_city_name;
string2	liens_final_st;
string5	liens_final_z5;
string4	liens_final_zip4;
string2	liens_final_rec_type;
string5	liens_final_county;
string25	liens_final_county_name;
string50	liens_final_filing_jurisdiction;
string25	liens_final_filing_jurisdiction_name;
string10	liens_final_filing_state;
string20	liens_final_orig_filing_number;
string8	liens_final_orig_filing_date;
string25	liens_final_case_number;
string20	liens_final_filing_status;
string65	liens_final_filing_status_desc;
string20	liens_final_filing_number;
string30	liens_final_filing_type_desc;
string6	liens_final_filing_book;
string6	liens_final_filing_page;
string30	liens_final_amount;
string1	liens_final_eviction;
   string1 hit;
   unsigned8 __internal_fpos__;
 END;
