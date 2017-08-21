IMPORT SALT34;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_PROPERTY_TRANSACTION;
EXPORT fips_code_ChildRec := RECORD
  TYPEOF(l.fips_code) fips_code;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT apnt_or_pin_number_ChildRec := RECORD
  TYPEOF(l.apnt_or_pin_number) apnt_or_pin_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT did_ChildRec := RECORD
  TYPEOF(l.did) did;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT name_ChildRec := RECORD
  TYPEOF(l.name) name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_range_alpha_ChildRec := RECORD
  TYPEOF(l.prim_range_alpha) prim_range_alpha;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_range_num_ChildRec := RECORD
  TYPEOF(l.prim_range_num) prim_range_num;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_name_num_ChildRec := RECORD
  TYPEOF(l.prim_name_num) prim_name_num;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT prim_name_alpha_ChildRec := RECORD
  TYPEOF(l.prim_name_alpha) prim_name_alpha;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sec_range_alpha_ChildRec := RECORD
  TYPEOF(l.sec_range_alpha) sec_range_alpha;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sec_range_num_ChildRec := RECORD
  TYPEOF(l.sec_range_num) sec_range_num;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT city_ChildRec := RECORD
  TYPEOF(l.city) city;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT st_ChildRec := RECORD
  TYPEOF(l.st) st;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT zip_ChildRec := RECORD
  TYPEOF(l.zip) zip;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT recording_date_ChildRec := RECORD
  TYPEOF(l.recording_date) recording_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT SourceType_ChildRec := RECORD
  TYPEOF(l.SourceType) SourceType;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT contract_date_ChildRec := RECORD
  TYPEOF(l.contract_date) contract_date;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT document_number_ChildRec := RECORD
  TYPEOF(l.document_number) document_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT recorder_book_number_ChildRec := RECORD
  TYPEOF(l.recorder_book_number) recorder_book_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT recorder_page_number_ChildRec := RECORD
  TYPEOF(l.recorder_page_number) recorder_page_number;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT sales_price_ChildRec := RECORD
  TYPEOF(l.sales_price) sales_price;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT first_td_loan_amount_ChildRec := RECORD
  TYPEOF(l.first_td_loan_amount) first_td_loan_amount;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT lender_name_ChildRec := RECORD
  TYPEOF(l.lender_name) lender_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT county_name_ChildRec := RECORD
  TYPEOF(l.county_name) county_name;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT primrange_ChildRec := RECORD
  UNSIGNED4 primrange;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT primname_ChildRec := RECORD
  UNSIGNED4 primname;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT secrange_ChildRec := RECORD
  UNSIGNED4 secrange;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT locale_ChildRec := RECORD
  UNSIGNED4 locale;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT address_ChildRec := RECORD
  UNSIGNED4 address;
  UNSIGNED8 cnt;
  UNSIGNED4 id;
END;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  REAL4 fips_code_specificity;
  REAL4 fips_code_switch;
  REAL4 fips_code_maximum;
  DATASET(fips_code_ChildRec) nulls_fips_code {MAXCOUNT(100)};
  REAL4 apnt_or_pin_number_specificity;
  REAL4 apnt_or_pin_number_switch;
  REAL4 apnt_or_pin_number_maximum;
  DATASET(apnt_or_pin_number_ChildRec) nulls_apnt_or_pin_number {MAXCOUNT(100)};
  REAL4 did_specificity;
  REAL4 did_switch;
  REAL4 did_maximum;
  DATASET(did_ChildRec) nulls_did {MAXCOUNT(100)};
  REAL4 name_specificity;
  REAL4 name_switch;
  REAL4 name_maximum;
  DATASET(name_ChildRec) nulls_name {MAXCOUNT(100)};
  REAL4 prim_range_alpha_specificity;
  REAL4 prim_range_alpha_switch;
  REAL4 prim_range_alpha_maximum;
  DATASET(prim_range_alpha_ChildRec) nulls_prim_range_alpha {MAXCOUNT(100)};
  REAL4 prim_range_num_specificity;
  REAL4 prim_range_num_switch;
  REAL4 prim_range_num_maximum;
  DATASET(prim_range_num_ChildRec) nulls_prim_range_num {MAXCOUNT(100)};
  REAL4 prim_name_num_specificity;
  REAL4 prim_name_num_switch;
  REAL4 prim_name_num_maximum;
  DATASET(prim_name_num_ChildRec) nulls_prim_name_num {MAXCOUNT(100)};
  REAL4 prim_name_alpha_specificity;
  REAL4 prim_name_alpha_switch;
  REAL4 prim_name_alpha_maximum;
  DATASET(prim_name_alpha_ChildRec) nulls_prim_name_alpha {MAXCOUNT(100)};
  REAL4 sec_range_alpha_specificity;
  REAL4 sec_range_alpha_switch;
  REAL4 sec_range_alpha_maximum;
  DATASET(sec_range_alpha_ChildRec) nulls_sec_range_alpha {MAXCOUNT(100)};
  REAL4 sec_range_num_specificity;
  REAL4 sec_range_num_switch;
  REAL4 sec_range_num_maximum;
  DATASET(sec_range_num_ChildRec) nulls_sec_range_num {MAXCOUNT(100)};
  REAL4 city_specificity;
  REAL4 city_switch;
  REAL4 city_maximum;
  DATASET(city_ChildRec) nulls_city {MAXCOUNT(100)};
  REAL4 st_specificity;
  REAL4 st_switch;
  REAL4 st_maximum;
  DATASET(st_ChildRec) nulls_st {MAXCOUNT(100)};
  REAL4 zip_specificity;
  REAL4 zip_switch;
  REAL4 zip_maximum;
  DATASET(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  REAL4 recording_date_specificity;
  REAL4 recording_date_switch;
  REAL4 recording_date_maximum;
  DATASET(recording_date_ChildRec) nulls_recording_date {MAXCOUNT(100)};
  REAL4 SourceType_specificity;
  REAL4 SourceType_switch;
  REAL4 SourceType_maximum;
  DATASET(SourceType_ChildRec) nulls_SourceType {MAXCOUNT(100)};
  REAL4 contract_date_specificity;
  REAL4 contract_date_switch;
  REAL4 contract_date_maximum;
  DATASET(contract_date_ChildRec) nulls_contract_date {MAXCOUNT(100)};
  REAL4 document_number_specificity;
  REAL4 document_number_switch;
  REAL4 document_number_maximum;
  DATASET(document_number_ChildRec) nulls_document_number {MAXCOUNT(100)};
  REAL4 recorder_book_number_specificity;
  REAL4 recorder_book_number_switch;
  REAL4 recorder_book_number_maximum;
  DATASET(recorder_book_number_ChildRec) nulls_recorder_book_number {MAXCOUNT(100)};
  REAL4 recorder_page_number_specificity;
  REAL4 recorder_page_number_switch;
  REAL4 recorder_page_number_maximum;
  DATASET(recorder_page_number_ChildRec) nulls_recorder_page_number {MAXCOUNT(100)};
  REAL4 sales_price_specificity;
  REAL4 sales_price_switch;
  REAL4 sales_price_maximum;
  DATASET(sales_price_ChildRec) nulls_sales_price {MAXCOUNT(100)};
  REAL4 first_td_loan_amount_specificity;
  REAL4 first_td_loan_amount_switch;
  REAL4 first_td_loan_amount_maximum;
  DATASET(first_td_loan_amount_ChildRec) nulls_first_td_loan_amount {MAXCOUNT(100)};
  REAL4 lender_name_specificity;
  REAL4 lender_name_switch;
  REAL4 lender_name_maximum;
  DATASET(lender_name_ChildRec) nulls_lender_name {MAXCOUNT(100)};
  REAL4 county_name_specificity;
  REAL4 county_name_switch;
  REAL4 county_name_maximum;
  DATASET(county_name_ChildRec) nulls_county_name {MAXCOUNT(100)};
  REAL4 primrange_specificity;
  REAL4 primrange_switch;
  REAL4 primrange_maximum;
  DATASET(primrange_ChildRec) nulls_primrange {MAXCOUNT(100)};
  REAL4 primname_specificity;
  REAL4 primname_switch;
  REAL4 primname_maximum;
  DATASET(primname_ChildRec) nulls_primname {MAXCOUNT(100)};
  REAL4 secrange_specificity;
  REAL4 secrange_switch;
  REAL4 secrange_maximum;
  DATASET(secrange_ChildRec) nulls_secrange {MAXCOUNT(100)};
  REAL4 locale_specificity;
  REAL4 locale_switch;
  REAL4 locale_maximum;
  DATASET(locale_ChildRec) nulls_locale {MAXCOUNT(100)};
  REAL4 address_specificity;
  REAL4 address_switch;
  REAL4 address_maximum;
  DATASET(address_ChildRec) nulls_address {MAXCOUNT(100)};
END;
END;
