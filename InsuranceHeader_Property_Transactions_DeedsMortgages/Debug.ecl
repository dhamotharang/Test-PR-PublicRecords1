// Various routines to assist in debugging
IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages; // Import modules for  attribute definitions
IMPORT SALT34,ut,std;
EXPORT Debug(DATASET(layout_PROPERTY_TRANSACTION) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  TYPEOF(h.recording_date) left_recording_date;
  INTEGER1 recording_date_match_code;
  INTEGER2 recording_date_score;
  BOOLEAN recording_date_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.recording_date) right_recording_date;
  TYPEOF(h.SourceType) left_SourceType;
  INTEGER1 SourceType_match_code;
  INTEGER2 SourceType_score;
  BOOLEAN SourceType_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.SourceType) right_SourceType;
  TYPEOF(h.did) left_did;
  INTEGER1 did_match_code;
  INTEGER2 did_score;
  TYPEOF(h.did) right_did;
  TYPEOF(h.apnt_or_pin_number) left_apnt_or_pin_number;
  INTEGER1 apnt_or_pin_number_match_code;
  INTEGER2 apnt_or_pin_number_score;
  TYPEOF(h.apnt_or_pin_number) right_apnt_or_pin_number;
  TYPEOF(h.recorder_book_number) left_recorder_book_number;
  INTEGER1 recorder_book_number_match_code;
  INTEGER2 recorder_book_number_score;
  TYPEOF(h.recorder_book_number) right_recorder_book_number;
  TYPEOF(h.primname) left_primname;
  INTEGER1 primname_match_code;
  INTEGER2 primname_score;
  TYPEOF(h.primname) right_primname;
  TYPEOF(h.zip) left_zip;
  INTEGER1 zip_match_code;
  INTEGER2 zip_score;
  BOOLEAN zip_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.zip) right_zip;
  TYPEOF(h.sales_price) left_sales_price;
  INTEGER1 sales_price_match_code;
  INTEGER2 sales_price_score;
  BOOLEAN sales_price_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.sales_price) right_sales_price;
  TYPEOF(h.first_td_loan_amount) left_first_td_loan_amount;
  INTEGER1 first_td_loan_amount_match_code;
  INTEGER2 first_td_loan_amount_score;
  BOOLEAN first_td_loan_amount_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.first_td_loan_amount) right_first_td_loan_amount;
  TYPEOF(h.primrange) left_primrange;
  INTEGER1 primrange_match_code;
  INTEGER2 primrange_score;
  TYPEOF(h.primrange) right_primrange;
  TYPEOF(h.secrange) left_secrange;
  INTEGER1 secrange_match_code;
  INTEGER2 secrange_score;
  TYPEOF(h.secrange) right_secrange;
  TYPEOF(h.contract_date) left_contract_date;
  INTEGER1 contract_date_match_code;
  INTEGER2 contract_date_score;
  BOOLEAN contract_date_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.contract_date) right_contract_date;
  TYPEOF(h.document_number) left_document_number;
  INTEGER1 document_number_match_code;
  INTEGER2 document_number_score;
  TYPEOF(h.document_number) right_document_number;
  TYPEOF(h.recorder_page_number) left_recorder_page_number;
  INTEGER1 recorder_page_number_match_code;
  INTEGER2 recorder_page_number_score;
  BOOLEAN recorder_page_number_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.recorder_page_number) right_recorder_page_number;
  TYPEOF(h.prim_range_alpha) left_prim_range_alpha;
  INTEGER1 prim_range_alpha_match_code;
  INTEGER2 prim_range_alpha_score;
  TYPEOF(h.prim_range_alpha) right_prim_range_alpha;
  TYPEOF(h.sec_range_alpha) left_sec_range_alpha;
  INTEGER1 sec_range_alpha_match_code;
  INTEGER2 sec_range_alpha_score;
  BOOLEAN sec_range_alpha_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.sec_range_alpha) right_sec_range_alpha;
  TYPEOF(h.name) left_name;
  INTEGER1 name_match_code;
  INTEGER2 name_score;
  TYPEOF(h.name) right_name;
  TYPEOF(h.prim_name_num) left_prim_name_num;
  INTEGER1 prim_name_num_match_code;
  INTEGER2 prim_name_num_score;
  BOOLEAN prim_name_num_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_name_num) right_prim_name_num;
  TYPEOF(h.prim_name_alpha) left_prim_name_alpha;
  INTEGER1 prim_name_alpha_match_code;
  INTEGER2 prim_name_alpha_score;
  BOOLEAN prim_name_alpha_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_name_alpha) right_prim_name_alpha;
  TYPEOF(h.sec_range_num) left_sec_range_num;
  INTEGER1 sec_range_num_match_code;
  INTEGER2 sec_range_num_score;
  BOOLEAN sec_range_num_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.sec_range_num) right_sec_range_num;
  TYPEOF(h.fips_code) left_fips_code;
  INTEGER1 fips_code_match_code;
  INTEGER2 fips_code_score;
  TYPEOF(h.fips_code) right_fips_code;
  TYPEOF(h.county_name) left_county_name;
  INTEGER1 county_name_match_code;
  INTEGER2 county_name_score;
  TYPEOF(h.county_name) right_county_name;
  TYPEOF(h.lender_name) left_lender_name;
  INTEGER1 lender_name_match_code;
  INTEGER2 lender_name_score;
  TYPEOF(h.lender_name) right_lender_name;
  TYPEOF(h.prim_range_num) left_prim_range_num;
  INTEGER1 prim_range_num_match_code;
  INTEGER2 prim_range_num_score;
  BOOLEAN prim_range_num_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_range_num) right_prim_range_num;
  TYPEOF(h.city) left_city;
  INTEGER1 city_match_code;
  INTEGER2 city_score;
  TYPEOF(h.city) right_city;
  TYPEOF(h.st) left_st;
  INTEGER1 st_match_code;
  INTEGER2 st_score;
  TYPEOF(h.st) right_st;
  TYPEOF(h.ln_fares_id) left_ln_fares_id;
  TYPEOF(h.ln_fares_id) right_ln_fares_id;
  TYPEOF(h.prim_range) left_prim_range;
  TYPEOF(h.prim_range) right_prim_range;
  TYPEOF(h.prim_name) left_prim_name;
  TYPEOF(h.prim_name) right_prim_name;
  TYPEOF(h.sec_range) left_sec_range;
  TYPEOF(h.sec_range) right_sec_range;
  TYPEOF(h.document_type_code) left_document_type_code;
  TYPEOF(h.document_type_code) right_document_type_code;
  TYPEOF(h.locale) left_locale;
  INTEGER1 locale_match_code;
  INTEGER2 locale_score;
  TYPEOF(h.locale) right_locale;
  TYPEOF(h.address) left_address;
  INTEGER1 address_match_code;
  INTEGER2 address_score;
  BOOLEAN address_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.address) right_address;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.DPROPTXID1 := le.DPROPTXID;
  SELF.DPROPTXID2 := ri.DPROPTXID;
  SELF.rid1 := le.rid;
  SELF.rid2 := ri.rid;
  SELF.left_recording_date := le.recording_date;
  SELF.right_recording_date := ri.recording_date;
  SELF.recording_date_match_code := MAP(
		le.recording_date_isnull OR ri.recording_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_recording_date(le.recording_date,ri.recording_date));
  INTEGER2 recording_date_score_temp := MAP(
                        le.recording_date = ri.recording_date  => le.recording_date_weight100,
                        SALT34.Fn_Fail_Scale(le.recording_date_weight100,s.recording_date_switch));
  SELF.left_SourceType := le.SourceType;
  SELF.right_SourceType := ri.SourceType;
  SELF.SourceType_match_code := MAP(
		le.SourceType_isnull OR ri.SourceType_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_SourceType(le.SourceType,ri.SourceType));
  INTEGER2 SourceType_score_temp := MAP(
                        le.SourceType = ri.SourceType  => le.SourceType_weight100,
                        SALT34.Fn_Fail_Scale(le.SourceType_weight100,s.SourceType_switch));
  SELF.left_did := le.did;
  SELF.right_did := ri.did;
  SELF.did_match_code := MAP(
		le.did_isnull OR ri.did_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_did(le.did,ri.did));
  INTEGER2 did_score_temp := MAP(
                        le.did_isnull OR ri.did_isnull => 0,
                        le.did = ri.did  => le.did_weight100,
                        SALT34.Fn_Fail_Scale(le.did_weight100,s.did_switch));
  SELF.left_apnt_or_pin_number := le.apnt_or_pin_number;
  SELF.right_apnt_or_pin_number := ri.apnt_or_pin_number;
  SELF.apnt_or_pin_number_match_code := MAP(
		le.apnt_or_pin_number_isnull OR ri.apnt_or_pin_number_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_apnt_or_pin_number(le.apnt_or_pin_number,ri.apnt_or_pin_number, le.apnt_or_pin_number_len, ri.apnt_or_pin_number_len));
  INTEGER2 apnt_or_pin_number_score_temp := MAP(
                        le.apnt_or_pin_number_isnull OR ri.apnt_or_pin_number_isnull => 0,
                        le.apnt_or_pin_number = ri.apnt_or_pin_number  => le.apnt_or_pin_number_weight100,
                        SALT34.WithinEditNew(le.apnt_or_pin_number,le.apnt_or_pin_number_len,ri.apnt_or_pin_number,ri.apnt_or_pin_number_len,1,0) =>  SALT34.fn_fuzzy_specificity(le.apnt_or_pin_number_weight100,le.apnt_or_pin_number_cnt, le.apnt_or_pin_number_e1_cnt,ri.apnt_or_pin_number_weight100,ri.apnt_or_pin_number_cnt,ri.apnt_or_pin_number_e1_cnt),
                        SALT34.Fn_Fail_Scale(le.apnt_or_pin_number_weight100,s.apnt_or_pin_number_switch));
  SELF.left_recorder_book_number := le.recorder_book_number;
  SELF.right_recorder_book_number := ri.recorder_book_number;
  SELF.recorder_book_number_match_code := MAP(
		le.recorder_book_number_isnull OR ri.recorder_book_number_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_recorder_book_number(le.recorder_book_number,ri.recorder_book_number));
  SELF.recorder_book_number_score := MAP(
                        le.recorder_book_number_isnull OR ri.recorder_book_number_isnull => 0,
                        le.recorder_book_number = ri.recorder_book_number  => le.recorder_book_number_weight100,
                        SALT34.Fn_Fail_Scale(le.recorder_book_number_weight100,s.recorder_book_number_switch));
  SELF.left_sales_price := le.sales_price;
  SELF.right_sales_price := ri.sales_price;
  SELF.sales_price_match_code := MAP(
		le.sales_price_isnull OR ri.sales_price_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_sales_price(le.sales_price,ri.sales_price));
  INTEGER2 sales_price_score_temp := MAP(
                        le.sales_price_isnull OR ri.sales_price_isnull => 0,
                        le.sales_price = ri.sales_price  => le.sales_price_weight100,
                        SALT34.Fn_Fail_Scale(le.sales_price_weight100,s.sales_price_switch));
  SELF.left_first_td_loan_amount := le.first_td_loan_amount;
  SELF.right_first_td_loan_amount := ri.first_td_loan_amount;
  SELF.first_td_loan_amount_match_code := MAP(
		le.first_td_loan_amount_isnull OR ri.first_td_loan_amount_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_first_td_loan_amount(le.first_td_loan_amount,ri.first_td_loan_amount));
  INTEGER2 first_td_loan_amount_score_temp := MAP(
                        le.first_td_loan_amount_isnull OR ri.first_td_loan_amount_isnull => 0,
                        le.first_td_loan_amount = ri.first_td_loan_amount  => le.first_td_loan_amount_weight100,
                        SALT34.Fn_Fail_Scale(le.first_td_loan_amount_weight100,s.first_td_loan_amount_switch));
  SELF.left_contract_date := le.contract_date;
  SELF.right_contract_date := ri.contract_date;
  SELF.contract_date_match_code := MAP(
		le.contract_date_isnull OR ri.contract_date_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_contract_date(le.contract_date,ri.contract_date));
  INTEGER2 contract_date_score_temp := MAP(
                        le.contract_date_isnull OR ri.contract_date_isnull => 0,
                        le.contract_date = ri.contract_date  => le.contract_date_weight100,
                        SALT34.Fn_Fail_Scale(le.contract_date_weight100,s.contract_date_switch));
  SELF.left_document_number := le.document_number;
  SELF.right_document_number := ri.document_number;
  SELF.document_number_match_code := MAP(
		le.document_number_isnull OR ri.document_number_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_document_number(le.document_number,ri.document_number));
  SELF.document_number_score := MAP(
                        le.document_number_isnull OR ri.document_number_isnull => 0,
                        le.document_number = ri.document_number  => le.document_number_weight100,
                        InsuranceHeader_Property_Transactions_DeedsMortgages.fn_document_number((STRING20)le.document_number,ri.document_number) => SALT34.MOD_NonZero.AVENZ(le.document_number_weight100,ri.document_number_weight100),
                        0 /* switchN/0 */);
  SELF.left_recorder_page_number := le.recorder_page_number;
  SELF.right_recorder_page_number := ri.recorder_page_number;
  SELF.recorder_page_number_match_code := MAP(
		le.recorder_page_number_isnull OR ri.recorder_page_number_isnull => SALT34.MatchCode.OneSideNull,
		le.recorder_book_number <> ri.recorder_book_number => SALT34.MatchCode.ContextInvolved, // Only valid if the context variable is equal
		match_methods(ih).match_recorder_page_number(le.recorder_page_number,ri.recorder_page_number));
  INTEGER2 recorder_page_number_score_temp := MAP(
                        le.recorder_page_number_isnull OR ri.recorder_page_number_isnull OR le.recorder_page_number_weight100 = 0 => 0,
                        le.recorder_book_number <> ri.recorder_book_number => 0, // Only valid if the context variable is equal
                        le.recorder_page_number = ri.recorder_page_number  => le.recorder_page_number_weight100,
                        SALT34.Fn_Fail_Scale(le.recorder_page_number_weight100,s.recorder_page_number_switch));
  SELF.left_name := le.name;
  SELF.right_name := ri.name;
  SELF.name_match_code := MAP(
		le.name_isnull OR ri.name_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_name(le.name,ri.name));
  SELF.name_score := MAP(
                        le.name_isnull OR ri.name_isnull => 0,
                        le.name = ri.name OR SALT34.HyphenMatch(le.name,ri.name,1)<=2  => MIN(le.name_weight100,ri.name_weight100),
                        SALT34.MatchBagOfWords(le.name,ri.name,31770,2));
  SELF.left_fips_code := le.fips_code;
  SELF.right_fips_code := ri.fips_code;
  SELF.fips_code_match_code := MAP(
		le.fips_code_isnull OR ri.fips_code_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_fips_code(le.fips_code,ri.fips_code));
  SELF.fips_code_score := MAP(
                        le.fips_code_isnull OR ri.fips_code_isnull => 0,
                        le.fips_code = ri.fips_code  => le.fips_code_weight100,
                        SALT34.Fn_Fail_Scale(le.fips_code_weight100,s.fips_code_switch));
  SELF.left_county_name := le.county_name;
  SELF.right_county_name := ri.county_name;
  SELF.county_name_match_code := MAP(
		le.county_name_isnull OR ri.county_name_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_county_name(le.county_name,ri.county_name));
  SELF.county_name_score := MAP(
                        le.county_name_isnull OR ri.county_name_isnull => 0,
                        le.county_name = ri.county_name  => le.county_name_weight100,
                        SALT34.Fn_Fail_Scale(le.county_name_weight100,s.county_name_switch));
  SELF.left_lender_name := le.lender_name;
  SELF.right_lender_name := ri.lender_name;
  SELF.lender_name_match_code := MAP(
		le.lender_name_isnull OR ri.lender_name_isnull => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_lender_name(le.lender_name,ri.lender_name));
  SELF.lender_name_score := MAP(
                        le.lender_name_isnull OR ri.lender_name_isnull => 0,
                        le.lender_name = ri.lender_name OR SALT34.HyphenMatch(le.lender_name,ri.lender_name,1)<=2  => MIN(le.lender_name_weight100,ri.lender_name_weight100),
                        SALT34.MatchBagOfWords(le.lender_name,ri.lender_name,31770,2));
  SELF.left_ln_fares_id := le.ln_fares_id;
  SELF.right_ln_fares_id := ri.ln_fares_id;
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.left_document_type_code := le.document_type_code;
  SELF.right_document_type_code := ri.document_type_code;
  SELF.address_match_code := MAP(
		(le.address_isnull OR (le.primrange_isnull OR le.prim_range_alpha_isnull AND le.prim_range_num_isnull) AND (le.primname_isnull OR le.prim_name_alpha_isnull AND le.prim_name_num_isnull) AND (le.secrange_isnull OR le.sec_range_alpha_isnull AND le.sec_range_num_isnull) AND (le.locale_isnull OR le.city_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.address_isnull OR (ri.primrange_isnull OR ri.prim_range_alpha_isnull AND ri.prim_range_num_isnull) AND (ri.primname_isnull OR ri.prim_name_alpha_isnull AND ri.prim_name_num_isnull) AND (ri.secrange_isnull OR ri.sec_range_alpha_isnull AND ri.sec_range_num_isnull) AND (ri.locale_isnull OR ri.city_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.address_weight100 = 0 => SALT34.MatchCode.OneSideNull,
		match_methods(ih).match_address(le.address,ri.address));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.primrange_weight100 + ri.primrange_weight100 + le.primname_weight100 + ri.primname_weight100 + le.secrange_weight100 + ri.secrange_weight100 + le.locale_weight100 + ri.locale_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR (le.primrange_isnull OR le.prim_range_alpha_isnull AND le.prim_range_num_isnull) AND (le.primname_isnull OR le.prim_name_alpha_isnull AND le.prim_name_num_isnull) AND (le.secrange_isnull OR le.sec_range_alpha_isnull AND le.sec_range_num_isnull) AND (le.locale_isnull OR le.city_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.address_isnull OR (ri.primrange_isnull OR ri.prim_range_alpha_isnull AND ri.prim_range_num_isnull) AND (ri.primname_isnull OR ri.prim_name_alpha_isnull AND ri.prim_name_num_isnull) AND (ri.secrange_isnull OR ri.sec_range_alpha_isnull AND ri.sec_range_num_isnull) AND (ri.locale_isnull OR ri.city_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.address_weight100 = 0 => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  SELF.left_address := le.address;
  SELF.right_address := ri.address;
  SELF.recording_date_score := IF ( le.recording_date = ri.recording_date, recording_date_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.recording_date_skipped := SELF.recording_date_score < -5000;// Enforce FORCE parameter
  SELF.SourceType_score := IF ( le.SourceType = ri.SourceType, SourceType_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.SourceType_skipped := SELF.SourceType_score < -5000;// Enforce FORCE parameter
  SELF.did_score := did_score_temp*0.50; 
  SELF.apnt_or_pin_number_score := apnt_or_pin_number_score_temp*0.50; 
  SELF.primname_match_code := MAP(
		(le.primname_isnull OR le.prim_name_alpha_isnull AND le.prim_name_num_isnull) OR (ri.primname_isnull OR ri.prim_name_alpha_isnull AND ri.prim_name_num_isnull) => SALT34.MatchCode.OneSideNull,
		address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_primname(le.primname,ri.primname));
  REAL primname_score_scale := ( le.primname_weight100 + ri.primname_weight100 ) / (le.prim_name_alpha_weight100 + ri.prim_name_alpha_weight100 + le.prim_name_num_weight100 + ri.prim_name_num_weight100); // Scaling factor for this concept
  INTEGER2 primname_score_pre := MAP( (le.primname_isnull OR le.prim_name_alpha_isnull AND le.prim_name_num_isnull) OR (ri.primname_isnull OR ri.prim_name_alpha_isnull AND ri.prim_name_num_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.primname = ri.primname  => le.primname_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_primname := le.primname;
  SELF.right_primname := ri.primname;
  SELF.sales_price_score := IF ( sales_price_score_temp >= Config.sales_price_Force * 100, sales_price_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.sales_price_skipped := SELF.sales_price_score < -5000;// Enforce FORCE parameter
  SELF.first_td_loan_amount_score := IF ( first_td_loan_amount_score_temp >= Config.first_td_loan_amount_Force * 100, first_td_loan_amount_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.first_td_loan_amount_skipped := SELF.first_td_loan_amount_score < -5000;// Enforce FORCE parameter
  SELF.primrange_match_code := MAP(
		(le.primrange_isnull OR le.prim_range_alpha_isnull AND le.prim_range_num_isnull) OR (ri.primrange_isnull OR ri.prim_range_alpha_isnull AND ri.prim_range_num_isnull) => SALT34.MatchCode.OneSideNull,
		address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_primrange(le.primrange,ri.primrange));
  REAL primrange_score_scale := ( le.primrange_weight100 + ri.primrange_weight100 ) / (le.prim_range_alpha_weight100 + ri.prim_range_alpha_weight100 + le.prim_range_num_weight100 + ri.prim_range_num_weight100); // Scaling factor for this concept
  INTEGER2 primrange_score_pre := MAP( (le.primrange_isnull OR le.prim_range_alpha_isnull AND le.prim_range_num_isnull) OR (ri.primrange_isnull OR ri.prim_range_alpha_isnull AND ri.prim_range_num_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.primrange = ri.primrange  => le.primrange_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_primrange := le.primrange;
  SELF.right_primrange := ri.primrange;
  SELF.secrange_match_code := MAP(
		(le.secrange_isnull OR le.sec_range_alpha_isnull AND le.sec_range_num_isnull) OR (ri.secrange_isnull OR ri.sec_range_alpha_isnull AND ri.sec_range_num_isnull) => SALT34.MatchCode.OneSideNull,
		address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_secrange(le.secrange,ri.secrange));
  REAL secrange_score_scale := ( le.secrange_weight100 + ri.secrange_weight100 ) / (le.sec_range_alpha_weight100 + ri.sec_range_alpha_weight100 + le.sec_range_num_weight100 + ri.sec_range_num_weight100); // Scaling factor for this concept
  INTEGER2 secrange_score_pre := MAP( (le.secrange_isnull OR le.sec_range_alpha_isnull AND le.sec_range_num_isnull) OR (ri.secrange_isnull OR ri.sec_range_alpha_isnull AND ri.sec_range_num_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.secrange = ri.secrange  => le.secrange_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_secrange := le.secrange;
  SELF.right_secrange := ri.secrange;
  SELF.contract_date_score := IF ( contract_date_score_temp >= Config.contract_date_Force * 100, contract_date_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.contract_date_skipped := SELF.contract_date_score < -5000;// Enforce FORCE parameter
  SELF.recorder_page_number_score := IF ( recorder_page_number_score_temp >= Config.recorder_page_number_Force * 100 OR SELF.document_number_score > Config.recorder_page_number_OR1_document_number_Force*100, recorder_page_number_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.recorder_page_number_skipped := SELF.recorder_page_number_score < -5000;// Enforce FORCE parameter
  SELF.left_prim_range_alpha := le.prim_range_alpha;
  SELF.right_prim_range_alpha := ri.prim_range_alpha;
  SELF.prim_range_alpha_match_code := MAP(
		le.prim_range_alpha_isnull OR ri.prim_range_alpha_isnull => SALT34.MatchCode.OneSideNull,
		primrange_score_pre > 0 OR address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_prim_range_alpha(le.prim_range_alpha,ri.prim_range_alpha));
  SELF.prim_range_alpha_score := MAP(
                        le.prim_range_alpha_isnull OR ri.prim_range_alpha_isnull => 0,
                        primrange_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range_alpha = ri.prim_range_alpha  => le.prim_range_alpha_weight100,
                        SALT34.Fn_Fail_Scale(le.prim_range_alpha_weight100,s.prim_range_alpha_switch))*IF(primrange_score_scale=0,1,primrange_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_sec_range_alpha := le.sec_range_alpha;
  SELF.right_sec_range_alpha := ri.sec_range_alpha;
  SELF.sec_range_alpha_match_code := MAP(
		le.sec_range_alpha_isnull OR ri.sec_range_alpha_isnull => SALT34.MatchCode.OneSideNull,
		secrange_score_pre > 0 OR address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_sec_range_alpha(le.sec_range_alpha,ri.sec_range_alpha));
  INTEGER2 sec_range_alpha_score_temp := MAP(
                        le.sec_range_alpha_isnull OR ri.sec_range_alpha_isnull => 0,
                        secrange_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range_alpha = ri.sec_range_alpha  => le.sec_range_alpha_weight100,
                        SALT34.Fn_Fail_Scale(le.sec_range_alpha_weight100,s.sec_range_alpha_switch))*IF(secrange_score_scale=0,1,secrange_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_prim_name_num := le.prim_name_num;
  SELF.right_prim_name_num := ri.prim_name_num;
  SELF.prim_name_num_match_code := MAP(
		le.prim_name_num_isnull OR ri.prim_name_num_isnull => SALT34.MatchCode.OneSideNull,
		primname_score_pre > 0 OR address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_prim_name_num(le.prim_name_num,ri.prim_name_num));
  INTEGER2 prim_name_num_score_temp := MAP(
                        le.prim_name_num_isnull OR ri.prim_name_num_isnull => 0,
                        primname_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name_num = ri.prim_name_num  => le.prim_name_num_weight100,
                        LENGTH(TRIM(le.prim_name_num))>0 and le.prim_name_num = ri.prim_name_num[1..LENGTH(TRIM(le.prim_name_num))] => le.prim_name_num_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.prim_name_num))>0 and ri.prim_name_num = le.prim_name_num[1..LENGTH(TRIM(ri.prim_name_num))] => ri.prim_name_num_weight100, // An initial match - take initial specificity
                        SALT34.Fn_Fail_Scale(le.prim_name_num_weight100,s.prim_name_num_switch))*IF(primname_score_scale=0,1,primname_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_prim_name_alpha := le.prim_name_alpha;
  SELF.right_prim_name_alpha := ri.prim_name_alpha;
  SELF.prim_name_alpha_match_code := MAP(
		le.prim_name_alpha_isnull OR ri.prim_name_alpha_isnull => SALT34.MatchCode.OneSideNull,
		primname_score_pre > 0 OR address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_prim_name_alpha(le.prim_name_alpha,ri.prim_name_alpha));
  INTEGER2 prim_name_alpha_score_temp := MAP(
                        le.prim_name_alpha_isnull OR ri.prim_name_alpha_isnull OR le.prim_name_alpha_weight100 = 0 => 0,
                        primname_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name_alpha = ri.prim_name_alpha OR SALT34.HyphenMatch(le.prim_name_alpha,ri.prim_name_alpha,1)<=2  => MIN(le.prim_name_alpha_weight100,ri.prim_name_alpha_weight100),
                        SALT34.MatchBagOfWords(le.prim_name_alpha,ri.prim_name_alpha,31768,2))*IF(primname_score_scale=0,1,primname_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_sec_range_num := le.sec_range_num;
  SELF.right_sec_range_num := ri.sec_range_num;
  SELF.sec_range_num_match_code := MAP(
		le.sec_range_num_isnull OR ri.sec_range_num_isnull => SALT34.MatchCode.OneSideNull,
		secrange_score_pre > 0 OR address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_sec_range_num(le.sec_range_num,ri.sec_range_num));
  INTEGER2 sec_range_num_score_temp := MAP(
                        le.sec_range_num_isnull OR ri.sec_range_num_isnull => 0,
                        secrange_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range_num = ri.sec_range_num OR SALT34.HyphenMatch(le.sec_range_num,ri.sec_range_num,1)<=2  => MIN(le.sec_range_num_weight100,ri.sec_range_num_weight100),
                        LENGTH(TRIM(le.sec_range_num))>0 and le.sec_range_num = ri.sec_range_num[1..LENGTH(TRIM(le.sec_range_num))] => le.sec_range_num_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.sec_range_num))>0 and ri.sec_range_num = le.sec_range_num[1..LENGTH(TRIM(ri.sec_range_num))] => ri.sec_range_num_weight100, // An initial match - take initial specificity
                        SALT34.Fn_Fail_Scale(le.sec_range_num_weight100,s.sec_range_num_switch))*IF(secrange_score_scale=0,1,secrange_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_prim_range_num := le.prim_range_num;
  SELF.right_prim_range_num := ri.prim_range_num;
  SELF.prim_range_num_match_code := MAP(
		le.prim_range_num_isnull OR ri.prim_range_num_isnull => SALT34.MatchCode.OneSideNull,
		primrange_score_pre > 0 OR address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_prim_range_num(le.prim_range_num,ri.prim_range_num));
  INTEGER2 prim_range_num_score_temp := MAP(
                        le.prim_range_num_isnull OR ri.prim_range_num_isnull OR le.prim_range_num_weight100 = 0 => 0,
                        primrange_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range_num = ri.prim_range_num OR SALT34.HyphenMatch(le.prim_range_num,ri.prim_range_num,1)<=2  => MIN(le.prim_range_num_weight100,ri.prim_range_num_weight100),
                        LENGTH(TRIM(le.prim_range_num))>0 and le.prim_range_num = ri.prim_range_num[1..LENGTH(TRIM(le.prim_range_num))] => le.prim_range_num_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.prim_range_num))>0 and ri.prim_range_num = le.prim_range_num[1..LENGTH(TRIM(ri.prim_range_num))] => ri.prim_range_num_weight100, // An initial match - take initial specificity
                        SALT34.Fn_Fail_Scale(le.prim_range_num_weight100,s.prim_range_num_switch))*IF(primrange_score_scale=0,1,primrange_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.locale_match_code := MAP(
		(le.locale_isnull OR le.city_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.locale_isnull OR ri.city_isnull AND ri.st_isnull AND ri.zip_isnull) => SALT34.MatchCode.OneSideNull,
		address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_locale(le.locale,ri.locale));
  REAL locale_score_scale := ( le.locale_weight100 + ri.locale_weight100 ) / (le.city_weight100 + ri.city_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 locale_score_pre := MAP( (le.locale_isnull OR le.city_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.locale_isnull OR ri.city_isnull AND ri.st_isnull AND ri.zip_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.locale = ri.locale  => le.locale_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_locale := le.locale;
  SELF.right_locale := ri.locale;
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_match_code := MAP(
		le.zip_isnull OR ri.zip_isnull => SALT34.MatchCode.OneSideNull,
		locale_score_pre > 0 OR address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_zip(le.zip,ri.zip, le.zip_len, ri.zip_len));
  INTEGER2 zip_score_temp := MAP(
                        le.zip_isnull OR ri.zip_isnull OR le.zip_weight100 = 0 => 0,
                        locale_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT34.WithinEditNew(le.zip,le.zip_len,ri.zip,ri.zip_len,1,0) =>  SALT34.fn_fuzzy_specificity(le.zip_weight100,le.zip_cnt, le.zip_e1_cnt,ri.zip_weight100,ri.zip_cnt,ri.zip_e1_cnt),
                        SALT34.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(locale_score_scale=0,1,locale_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.sec_range_alpha_score := IF ( sec_range_alpha_score_temp >= Config.sec_range_alpha_Force * 100, sec_range_alpha_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.sec_range_alpha_skipped := SELF.sec_range_alpha_score < -5000;// Enforce FORCE parameter
  SELF.prim_name_num_score := IF ( prim_name_num_score_temp >= Config.prim_name_num_Force * 100, prim_name_num_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_num_skipped := SELF.prim_name_num_score < -5000;// Enforce FORCE parameter
  SELF.prim_name_alpha_score := IF ( prim_name_alpha_score_temp > Config.prim_name_alpha_Force * 100 OR primname_score_pre > 0 OR address_score_pre > 0, prim_name_alpha_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_alpha_skipped := SELF.prim_name_alpha_score < -5000;// Enforce FORCE parameter
  SELF.sec_range_num_score := IF ( sec_range_num_score_temp >= Config.sec_range_num_Force * 100, sec_range_num_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.sec_range_num_skipped := SELF.sec_range_num_score < -5000;// Enforce FORCE parameter
  SELF.prim_range_num_score := IF ( prim_range_num_score_temp > Config.prim_range_num_Force * 100 OR primrange_score_pre > 0 OR address_score_pre > 0, prim_range_num_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_num_skipped := SELF.prim_range_num_score < -5000;// Enforce FORCE parameter
  SELF.left_city := le.city;
  SELF.right_city := ri.city;
  SELF.city_match_code := MAP(
		le.city_isnull OR ri.city_isnull => SALT34.MatchCode.OneSideNull,
		locale_score_pre > 0 OR address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_city(le.city,ri.city));
  SELF.city_score := MAP(
                        le.city_isnull OR ri.city_isnull => 0,
                        locale_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.city = ri.city OR SALT34.HyphenMatch(le.city,ri.city,1)<=2  => MIN(le.city_weight100,ri.city_weight100),
                        SALT34.MatchBagOfWords(le.city,ri.city,31784,1))*IF(locale_score_scale=0,1,locale_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_match_code := MAP(
		le.st_isnull OR ri.st_isnull => SALT34.MatchCode.OneSideNull,
		locale_score_pre > 0 OR address_score_pre > 0 => SALT34.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
		match_methods(ih).match_st(le.st,ri.st));
  SELF.st_score := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        locale_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT34.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(locale_score_scale=0,1,locale_score_scale)*IF(address_score_scale=0,1,address_score_scale);
// Compute the score for the concept primname
  INTEGER2 primname_score_ext := SALT34.ClipScore(MAX(primname_score_pre,0) + self.prim_name_alpha_score + self.prim_name_num_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 primname_score_res := MAX(0,primname_score_pre); // At least nothing
  SELF.primname_score := primname_score_res;
  SELF.zip_score := IF ( zip_score_temp > Config.zip_Force * 100 OR locale_score_pre > 0 OR address_score_pre > 0, zip_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.zip_skipped := SELF.zip_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept primrange
  INTEGER2 primrange_score_ext := SALT34.ClipScore(MAX(primrange_score_pre,0) + self.prim_range_alpha_score + self.prim_range_num_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 primrange_score_res := MAX(0,primrange_score_pre); // At least nothing
  SELF.primrange_score := primrange_score_res;
// Compute the score for the concept secrange
  INTEGER2 secrange_score_ext := SALT34.ClipScore(MAX(secrange_score_pre,0) + self.sec_range_alpha_score + self.sec_range_num_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 secrange_score_res := MAX(0,secrange_score_pre); // At least nothing
  SELF.secrange_score := secrange_score_res;
// Compute the score for the concept locale
  INTEGER2 locale_score_ext := SALT34.ClipScore(MAX(locale_score_pre,0) + self.city_score + self.st_score + self.zip_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 locale_score_res := MAX(0,locale_score_pre); // At least nothing
  SELF.locale_score := locale_score_res;
// Compute the score for the concept address
  INTEGER2 address_score_ext := SALT34.ClipScore(MAX(address_score_pre,0)+ SELF.primrange_score + self.prim_range_alpha_score + self.prim_range_num_score+ SELF.primname_score + self.prim_name_alpha_score + self.prim_name_num_score+ SELF.secrange_score + self.sec_range_alpha_score + self.sec_range_num_score+ SELF.locale_score + self.city_score + self.st_score + self.zip_score);// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  SELF.address_score := IF ( address_score_ext > 0,address_score_res,-9999);
  SELF.address_skipped := SELF.address_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.sales_price_prop,ri.sales_price_prop)*SELF.sales_price_score // Score if either field propogated
    +MAX(le.first_td_loan_amount_prop,ri.first_td_loan_amount_prop)*SELF.first_td_loan_amount_score // Score if either field propogated
    +if(le.secrange_prop+ri.secrange_prop>0,self.secrange_score*(0+if(le.sec_range_alpha_prop+ri.sec_range_alpha_prop>0,s.sec_range_alpha_specificity,0)+if(le.sec_range_num_prop+ri.sec_range_num_prop>0,s.sec_range_num_specificity,0))/( s.sec_range_alpha_specificity+ s.sec_range_num_specificity),0)
    +MAX(le.contract_date_prop,ri.contract_date_prop)*SELF.contract_date_score // Score if either field propogated
    +MAX(le.sec_range_alpha_prop,ri.sec_range_alpha_prop)*SELF.sec_range_alpha_score // Score if either field propogated
    +(MAX(le.sec_range_num_prop,ri.sec_range_num_prop)/MAX(LENGTH(TRIM(le.sec_range_num)),LENGTH(TRIM(ri.sec_range_num))))*self.sec_range_num_score // Proportion of longest string propogated
    +if(le.address_prop+ri.address_prop>0,self.address_score*(0+if(le.secrange_prop+ri.secrange_prop>0,s.secrange_specificity,0))/(+ s.secrange_specificity),0)
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.recording_date_score + SELF.SourceType_score + SELF.did_score + SELF.apnt_or_pin_number_score + SELF.recorder_book_number_score + SELF.sales_price_score + SELF.first_td_loan_amount_score + SELF.contract_date_score + SELF.document_number_score + SELF.recorder_page_number_score + SELF.name_score + SELF.fips_code_score + SELF.county_name_score + SELF.lender_name_score + IF(SELF.address_score>0,MAX(SELF.address_score,IF(SELF.primrange_score>0,MAX(SELF.primrange_score,SELF.prim_range_alpha_score + SELF.prim_range_num_score),SELF.prim_range_alpha_score + SELF.prim_range_num_score) + IF(SELF.primname_score>0,MAX(SELF.primname_score,SELF.prim_name_alpha_score + SELF.prim_name_num_score),SELF.prim_name_alpha_score + SELF.prim_name_num_score) + IF(SELF.secrange_score>0,MAX(SELF.secrange_score,SELF.sec_range_alpha_score + SELF.sec_range_num_score),SELF.sec_range_alpha_score + SELF.sec_range_num_score) + IF(SELF.locale_score>0,MAX(SELF.locale_score,SELF.city_score + SELF.st_score + SELF.zip_score),SELF.city_score + SELF.st_score + SELF.zip_score)),IF(SELF.primrange_score>0,MAX(SELF.primrange_score,SELF.prim_range_alpha_score + SELF.prim_range_num_score),SELF.prim_range_alpha_score + SELF.prim_range_num_score) + IF(SELF.primname_score>0,MAX(SELF.primname_score,SELF.prim_name_alpha_score + SELF.prim_name_num_score),SELF.prim_name_alpha_score + SELF.prim_name_num_score) + IF(SELF.secrange_score>0,MAX(SELF.secrange_score,SELF.sec_range_alpha_score + SELF.sec_range_num_score),SELF.sec_range_alpha_score + SELF.sec_range_num_score) + IF(SELF.locale_score>0,MAX(SELF.locale_score,SELF.city_score + SELF.st_score + SELF.zip_score),SELF.city_score + SELF.st_score + SELF.zip_score))) / 100 + outside;
END;
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.DPROPTXID = RIGHT.DPROPTXID1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.DPROPTXID2 = RIGHT.DPROPTXID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
 // d := DEDUP( SORT( r, DPROPTXID1, DPROPTXID2, -Conf, LOCAL ), DPROPTXID1, DPROPTXID2, LOCAL ); // DPROPTXID2 distributed by join
 // akayttala added it for DID compare services results
 d := DEDUP(r(rid1 <> rid2), ALL, WHOLE RECORD);
 RETURN d;
END;
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rid known
  j1 := JOIN(in_data,im,LEFT.rid = RIGHT.rid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rid2 = RIGHT.rid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT34.UIDType BaseRecord) := FUNCTION//Faster form when rid known
  j1 := in_data(rid = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(rid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches) im) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.rid1=RIGHT.rid1 AND LEFT.rid2=RIGHT.rid2,restoreRule(LEFT,RIGHT),HASH);
  RETURN annotated_matches;
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT34.UIDType DPROPTXID;
  DATASET(SALT34.Layout_FieldValueList) recording_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) SourceType_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) did_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) apnt_or_pin_number_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) recorder_book_number_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) sales_price_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) first_td_loan_amount_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) contract_date_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) document_number_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) recorder_page_number_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) name_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) fips_code_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) county_name_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) lender_name_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) ln_fares_id_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) prim_range_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) prim_name_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) sec_range_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) document_type_code_Values := DATASET([],SALT34.Layout_FieldValueList);
  DATASET(SALT34.Layout_FieldValueList) address_Values := DATASET([],SALT34.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.DPROPTXID := le.DPROPTXID;
    SELF.recording_date_values := SALT34.fn_combine_fieldvaluelist(le.recording_date_values,ri.recording_date_values);
    SELF.SourceType_values := SALT34.fn_combine_fieldvaluelist(le.SourceType_values,ri.SourceType_values);
    SELF.did_values := SALT34.fn_combine_fieldvaluelist(le.did_values,ri.did_values);
    SELF.apnt_or_pin_number_values := SALT34.fn_combine_fieldvaluelist(le.apnt_or_pin_number_values,ri.apnt_or_pin_number_values);
    SELF.recorder_book_number_values := SALT34.fn_combine_fieldvaluelist(le.recorder_book_number_values,ri.recorder_book_number_values);
    SELF.sales_price_values := SALT34.fn_combine_fieldvaluelist(le.sales_price_values,ri.sales_price_values);
    SELF.first_td_loan_amount_values := SALT34.fn_combine_fieldvaluelist(le.first_td_loan_amount_values,ri.first_td_loan_amount_values);
    SELF.contract_date_values := SALT34.fn_combine_fieldvaluelist(le.contract_date_values,ri.contract_date_values);
    SELF.document_number_values := SALT34.fn_combine_fieldvaluelist(le.document_number_values,ri.document_number_values);
    SELF.recorder_page_number_values := SALT34.fn_combine_fieldvaluelist(le.recorder_page_number_values,ri.recorder_page_number_values);
    SELF.name_values := SALT34.fn_combine_fieldvaluelist(le.name_values,ri.name_values);
    SELF.fips_code_values := SALT34.fn_combine_fieldvaluelist(le.fips_code_values,ri.fips_code_values);
    SELF.county_name_values := SALT34.fn_combine_fieldvaluelist(le.county_name_values,ri.county_name_values);
    SELF.lender_name_values := SALT34.fn_combine_fieldvaluelist(le.lender_name_values,ri.lender_name_values);
    SELF.ln_fares_id_values := SALT34.fn_combine_fieldvaluelist(le.ln_fares_id_values,ri.ln_fares_id_values);
    SELF.prim_range_values := SALT34.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
    SELF.prim_name_values := SALT34.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
    SELF.sec_range_values := SALT34.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
    SELF.document_type_code_values := SALT34.fn_combine_fieldvaluelist(le.document_type_code_values,ri.document_type_code_values);
    SELF.address_values := SALT34.fn_combine_fieldvaluelist(le.address_values,ri.address_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(DPROPTXID) ), DPROPTXID, LOCAL ), LEFT.DPROPTXID = RIGHT.DPROPTXID, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.DPROPTXID := le.DPROPTXID;
    SELF.recording_date_values := SORT(le.recording_date_values, -cnt, val, LOCAL);
    SELF.SourceType_values := SORT(le.SourceType_values, -cnt, val, LOCAL);
    SELF.did_values := SORT(le.did_values, -cnt, val, LOCAL);
    SELF.apnt_or_pin_number_values := SORT(le.apnt_or_pin_number_values, -cnt, val, LOCAL);
    SELF.recorder_book_number_values := SORT(le.recorder_book_number_values, -cnt, val, LOCAL);
    SELF.sales_price_values := SORT(le.sales_price_values, -cnt, val, LOCAL);
    SELF.first_td_loan_amount_values := SORT(le.first_td_loan_amount_values, -cnt, val, LOCAL);
    SELF.contract_date_values := SORT(le.contract_date_values, -cnt, val, LOCAL);
    SELF.document_number_values := SORT(le.document_number_values, -cnt, val, LOCAL);
    SELF.recorder_page_number_values := SORT(le.recorder_page_number_values, -cnt, val, LOCAL);
    SELF.name_values := SORT(le.name_values, -cnt, val, LOCAL);
    SELF.fips_code_values := SORT(le.fips_code_values, -cnt, val, LOCAL);
    SELF.county_name_values := SORT(le.county_name_values, -cnt, val, LOCAL);
    SELF.lender_name_values := SORT(le.lender_name_values, -cnt, val, LOCAL);
    SELF.ln_fares_id_values := SORT(le.ln_fares_id_values, -cnt, val, LOCAL);
    SELF.prim_range_values := SORT(le.prim_range_values, -cnt, val, LOCAL);
    SELF.prim_name_values := SORT(le.prim_name_values, -cnt, val, LOCAL);
    SELF.sec_range_values := SORT(le.sec_range_values, -cnt, val, LOCAL);
    SELF.document_type_code_values := SORT(le.document_type_code_values, -cnt, val, LOCAL);
    SELF.address_values := SORT(le.address_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.DPROPTXID := le.DPROPTXID;
  SELF.recording_date_Values := IF ( (le.recording_date  IN SET(s.nulls_recording_date,recording_date) OR le.recording_date = (TYPEOF(le.recording_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.recording_date)}],SALT34.Layout_FieldValueList));
  SELF.SourceType_Values := IF ( (le.SourceType  IN SET(s.nulls_SourceType,SourceType) OR le.SourceType = (TYPEOF(le.SourceType))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.SourceType)}],SALT34.Layout_FieldValueList));
  SELF.did_Values := IF ( (le.did  IN SET(s.nulls_did,did) OR le.did = (TYPEOF(le.did))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.did)}],SALT34.Layout_FieldValueList));
  SELF.apnt_or_pin_number_Values := IF ( (le.apnt_or_pin_number  IN SET(s.nulls_apnt_or_pin_number,apnt_or_pin_number) OR le.apnt_or_pin_number = (TYPEOF(le.apnt_or_pin_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.apnt_or_pin_number)}],SALT34.Layout_FieldValueList));
  SELF.recorder_book_number_Values := IF ( (le.recorder_book_number  IN SET(s.nulls_recorder_book_number,recorder_book_number) OR le.recorder_book_number = (TYPEOF(le.recorder_book_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.recorder_book_number)}],SALT34.Layout_FieldValueList));
  SELF.sales_price_Values := IF ( (le.sales_price  IN SET(s.nulls_sales_price,sales_price) OR le.sales_price = (TYPEOF(le.sales_price))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.sales_price)}],SALT34.Layout_FieldValueList));
  SELF.first_td_loan_amount_Values := IF ( (le.first_td_loan_amount  IN SET(s.nulls_first_td_loan_amount,first_td_loan_amount) OR le.first_td_loan_amount = (TYPEOF(le.first_td_loan_amount))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.first_td_loan_amount)}],SALT34.Layout_FieldValueList));
  SELF.contract_date_Values := IF ( (le.contract_date  IN SET(s.nulls_contract_date,contract_date) OR le.contract_date = (TYPEOF(le.contract_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.contract_date)}],SALT34.Layout_FieldValueList));
  SELF.document_number_Values := IF ( (le.document_number  IN SET(s.nulls_document_number,document_number) OR le.document_number = (TYPEOF(le.document_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.document_number)}],SALT34.Layout_FieldValueList));
  SELF.recorder_page_number_Values := IF ( (le.recorder_page_number  IN SET(s.nulls_recorder_page_number,recorder_page_number) OR le.recorder_page_number = (TYPEOF(le.recorder_page_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.recorder_page_number)}],SALT34.Layout_FieldValueList));
  SELF.name_Values := IF ( (le.name  IN SET(s.nulls_name,name) OR le.name = (TYPEOF(le.name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.name)}],SALT34.Layout_FieldValueList));
  SELF.fips_code_Values := IF ( (le.fips_code  IN SET(s.nulls_fips_code,fips_code) OR le.fips_code = (TYPEOF(le.fips_code))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.fips_code)}],SALT34.Layout_FieldValueList));
  SELF.county_name_Values := IF ( (le.county_name  IN SET(s.nulls_county_name,county_name) OR le.county_name = (TYPEOF(le.county_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.county_name)}],SALT34.Layout_FieldValueList));
  SELF.lender_name_Values := IF ( (le.lender_name  IN SET(s.nulls_lender_name,lender_name) OR le.lender_name = (TYPEOF(le.lender_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.lender_name)}],SALT34.Layout_FieldValueList));
  SELF.ln_fares_id_Values := DATASET([{TRIM((SALT34.StrType)le.ln_fares_id)}],SALT34.Layout_FieldValueList);
  SELF.prim_range_Values := DATASET([{TRIM((SALT34.StrType)le.prim_range)}],SALT34.Layout_FieldValueList);
  SELF.prim_name_Values := DATASET([{TRIM((SALT34.StrType)le.prim_name)}],SALT34.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT34.StrType)le.sec_range)}],SALT34.Layout_FieldValueList);
  SELF.document_type_code_Values := DATASET([{TRIM((SALT34.StrType)le.document_type_code)}],SALT34.Layout_FieldValueList);
  SELF.address_Values := IF ( (le.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR le.prim_range_alpha = (TYPEOF(le.prim_range_alpha))'') AND (le.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR le.prim_range_num = (TYPEOF(le.prim_range_num))'') AND (le.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR le.prim_name_alpha = (TYPEOF(le.prim_name_alpha))'') AND (le.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR le.prim_name_num = (TYPEOF(le.prim_name_num))'') AND (le.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR le.sec_range_alpha = (TYPEOF(le.sec_range_alpha))'') AND (le.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR le.sec_range_num = (TYPEOF(le.sec_range_num))'') AND (le.city  IN SET(s.nulls_city,city) OR le.city = (TYPEOF(le.city))'') AND (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))'') AND (le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.prim_range_alpha) + ' ' + TRIM((SALT34.StrType)le.prim_range_num) + ' ' + TRIM((SALT34.StrType)le.prim_name_alpha) + ' ' + TRIM((SALT34.StrType)le.prim_name_num) + ' ' + TRIM((SALT34.StrType)le.sec_range_alpha) + ' ' + TRIM((SALT34.StrType)le.sec_range_num) + ' ' + TRIM((SALT34.StrType)le.city) + ' ' + TRIM((SALT34.StrType)le.st) + ' ' + TRIM((SALT34.StrType)le.zip)}],SALT34.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.DPROPTXID := le.DPROPTXID;
  SELF.recording_date_Values := IF ( (le.recording_date  IN SET(s.nulls_recording_date,recording_date) OR le.recording_date = (TYPEOF(le.recording_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.recording_date)}],SALT34.Layout_FieldValueList));
  SELF.SourceType_Values := IF ( (le.SourceType  IN SET(s.nulls_SourceType,SourceType) OR le.SourceType = (TYPEOF(le.SourceType))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.SourceType)}],SALT34.Layout_FieldValueList));
  SELF.did_Values := IF ( (le.did  IN SET(s.nulls_did,did) OR le.did = (TYPEOF(le.did))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.did)}],SALT34.Layout_FieldValueList));
  SELF.apnt_or_pin_number_Values := IF ( (le.apnt_or_pin_number  IN SET(s.nulls_apnt_or_pin_number,apnt_or_pin_number) OR le.apnt_or_pin_number = (TYPEOF(le.apnt_or_pin_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.apnt_or_pin_number)}],SALT34.Layout_FieldValueList));
  SELF.recorder_book_number_Values := IF ( (le.recorder_book_number  IN SET(s.nulls_recorder_book_number,recorder_book_number) OR le.recorder_book_number = (TYPEOF(le.recorder_book_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.recorder_book_number)}],SALT34.Layout_FieldValueList));
  SELF.sales_price_Values := IF ( (le.sales_price  IN SET(s.nulls_sales_price,sales_price) OR le.sales_price = (TYPEOF(le.sales_price))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.sales_price)}],SALT34.Layout_FieldValueList));
  SELF.first_td_loan_amount_Values := IF ( (le.first_td_loan_amount  IN SET(s.nulls_first_td_loan_amount,first_td_loan_amount) OR le.first_td_loan_amount = (TYPEOF(le.first_td_loan_amount))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.first_td_loan_amount)}],SALT34.Layout_FieldValueList));
  SELF.contract_date_Values := IF ( (le.contract_date  IN SET(s.nulls_contract_date,contract_date) OR le.contract_date = (TYPEOF(le.contract_date))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.contract_date)}],SALT34.Layout_FieldValueList));
  SELF.document_number_Values := IF ( (le.document_number  IN SET(s.nulls_document_number,document_number) OR le.document_number = (TYPEOF(le.document_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.document_number)}],SALT34.Layout_FieldValueList));
  SELF.recorder_page_number_Values := IF ( (le.recorder_page_number  IN SET(s.nulls_recorder_page_number,recorder_page_number) OR le.recorder_page_number = (TYPEOF(le.recorder_page_number))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.recorder_page_number)}],SALT34.Layout_FieldValueList));
  SELF.name_Values := IF ( (le.name  IN SET(s.nulls_name,name) OR le.name = (TYPEOF(le.name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.name)}],SALT34.Layout_FieldValueList));
  SELF.fips_code_Values := IF ( (le.fips_code  IN SET(s.nulls_fips_code,fips_code) OR le.fips_code = (TYPEOF(le.fips_code))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.fips_code)}],SALT34.Layout_FieldValueList));
  SELF.county_name_Values := IF ( (le.county_name  IN SET(s.nulls_county_name,county_name) OR le.county_name = (TYPEOF(le.county_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.county_name)}],SALT34.Layout_FieldValueList));
  SELF.lender_name_Values := IF ( (le.lender_name  IN SET(s.nulls_lender_name,lender_name) OR le.lender_name = (TYPEOF(le.lender_name))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.lender_name)}],SALT34.Layout_FieldValueList));
  SELF.ln_fares_id_Values := DATASET([{TRIM((SALT34.StrType)le.ln_fares_id)}],SALT34.Layout_FieldValueList);
  SELF.prim_range_Values := DATASET([{TRIM((SALT34.StrType)le.prim_range)}],SALT34.Layout_FieldValueList);
  SELF.prim_name_Values := DATASET([{TRIM((SALT34.StrType)le.prim_name)}],SALT34.Layout_FieldValueList);
  SELF.sec_range_Values := DATASET([{TRIM((SALT34.StrType)le.sec_range)}],SALT34.Layout_FieldValueList);
  SELF.document_type_code_Values := DATASET([{TRIM((SALT34.StrType)le.document_type_code)}],SALT34.Layout_FieldValueList);
  SELF.address_Values := IF ( (le.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR le.prim_range_alpha = (TYPEOF(le.prim_range_alpha))'') AND (le.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR le.prim_range_num = (TYPEOF(le.prim_range_num))'') AND (le.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR le.prim_name_alpha = (TYPEOF(le.prim_name_alpha))'') AND (le.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR le.prim_name_num = (TYPEOF(le.prim_name_num))'') AND (le.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR le.sec_range_alpha = (TYPEOF(le.sec_range_alpha))'') AND (le.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR le.sec_range_num = (TYPEOF(le.sec_range_num))'') AND (le.city  IN SET(s.nulls_city,city) OR le.city = (TYPEOF(le.city))'') AND (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))'') AND (le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))''),DATASET([],SALT34.Layout_FieldValueList),DATASET([{TRIM((SALT34.StrType)le.prim_range_alpha) + ' ' + TRIM((SALT34.StrType)le.prim_range_num) + ' ' + TRIM((SALT34.StrType)le.prim_name_alpha) + ' ' + TRIM((SALT34.StrType)le.prim_name_num) + ' ' + TRIM((SALT34.StrType)le.sec_range_alpha) + ' ' + TRIM((SALT34.StrType)le.sec_range_num) + ' ' + TRIM((SALT34.StrType)le.city) + ' ' + TRIM((SALT34.StrType)le.st) + ' ' + TRIM((SALT34.StrType)le.zip)}],SALT34.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
  im rem(im le) := TRANSFORM
    self.sales_price := if ( le.sales_price_prop>0, (TYPEOF(le.sales_price))'', le.sales_price ); // Blank if propogated
    self.sales_price_isnull := le.sales_price_prop>0 OR le.sales_price_isnull;
    self.sales_price_prop := 0; // Avoid reducing score later
    self.first_td_loan_amount := if ( le.first_td_loan_amount_prop>0, (TYPEOF(le.first_td_loan_amount))'', le.first_td_loan_amount ); // Blank if propogated
    self.first_td_loan_amount_isnull := le.first_td_loan_amount_prop>0 OR le.first_td_loan_amount_isnull;
    self.first_td_loan_amount_prop := 0; // Avoid reducing score later
    self.secrange := if ( le.secrange_prop>0, 0, le.secrange ); // Blank if propogated
    self.secrange_isnull := true; // Flag as null to scoring
    self.secrange_prop := 0; // Avoid reducing score later
    self.contract_date := if ( le.contract_date_prop>0, (TYPEOF(le.contract_date))'', le.contract_date ); // Blank if propogated
    self.contract_date_isnull := le.contract_date_prop>0 OR le.contract_date_isnull;
    self.contract_date_prop := 0; // Avoid reducing score later
    self.sec_range_alpha := if ( le.sec_range_alpha_prop>0, (TYPEOF(le.sec_range_alpha))'', le.sec_range_alpha ); // Blank if propogated
    self.sec_range_alpha_isnull := le.sec_range_alpha_prop>0 OR le.sec_range_alpha_isnull;
    self.sec_range_alpha_prop := 0; // Avoid reducing score later
    self.sec_range_num := le.sec_range_num[1..LENGTH(TRIM(le.sec_range_num))-le.sec_range_num_prop]; // Clip propogated chars
    self.sec_range_num_isnull := self.sec_range_num='' OR le.sec_range_num_isnull;
    self.sec_range_num_prop := 0; // Avoid reducing score later
    self.address := if ( le.address_prop>0, 0, le.address ); // Blank if propogated
    self.address_isnull := true; // Flag as null to scoring
    self.address_prop := 0; // Avoid reducing score later
    SELF := le;
  END;
  RETURN PROJECT(im,rem(LEFT));
END;
// Now to compute the chubbies; those clusters which are really rather larger than one would expect
// this is presently defined in terms of number of field values * the improbability of that occuring by chance
// this could be used as poor mans dodgy-dids; but it does not allow for value planing (co-occurrence)
AllRolled := InFile_Rolled;
Layout_Chubbies0 := RECORD,MAXLENGTH(63000)
  AllRolled;
  UNSIGNED1 recording_date_size := 0;
  UNSIGNED1 SourceType_size := 0;
  UNSIGNED1 did_size := 0;
  UNSIGNED1 apnt_or_pin_number_size := 0;
  UNSIGNED1 recorder_book_number_size := 0;
  UNSIGNED1 sales_price_size := 0;
  UNSIGNED1 first_td_loan_amount_size := 0;
  UNSIGNED1 contract_date_size := 0;
  UNSIGNED1 document_number_size := 0;
  UNSIGNED1 recorder_page_number_size := 0;
  UNSIGNED1 name_size := 0;
  UNSIGNED1 fips_code_size := 0;
  UNSIGNED1 county_name_size := 0;
  UNSIGNED1 lender_name_size := 0;
  UNSIGNED1 address_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.recording_date_size := SALT34.Fn_SwitchSpec(s.recording_date_switch,count(le.recording_date_values));
  SELF.SourceType_size := SALT34.Fn_SwitchSpec(s.SourceType_switch,count(le.SourceType_values));
  SELF.did_size := SALT34.Fn_SwitchSpec(s.did_switch,count(le.did_values));
  SELF.apnt_or_pin_number_size := SALT34.Fn_SwitchSpec(s.apnt_or_pin_number_switch,count(le.apnt_or_pin_number_values));
  SELF.recorder_book_number_size := SALT34.Fn_SwitchSpec(s.recorder_book_number_switch,count(le.recorder_book_number_values));
  SELF.sales_price_size := SALT34.Fn_SwitchSpec(s.sales_price_switch,count(le.sales_price_values));
  SELF.first_td_loan_amount_size := SALT34.Fn_SwitchSpec(s.first_td_loan_amount_switch,count(le.first_td_loan_amount_values));
  SELF.contract_date_size := SALT34.Fn_SwitchSpec(s.contract_date_switch,count(le.contract_date_values));
  SELF.document_number_size := SALT34.Fn_SwitchSpec(s.document_number_switch,count(le.document_number_values));
  SELF.recorder_page_number_size := SALT34.Fn_SwitchSpec(s.recorder_page_number_switch,count(le.recorder_page_number_values));
  SELF.name_size := SALT34.Fn_SwitchSpec(s.name_switch,count(le.name_values));
  SELF.fips_code_size := SALT34.Fn_SwitchSpec(s.fips_code_switch,count(le.fips_code_values));
  SELF.county_name_size := SALT34.Fn_SwitchSpec(s.county_name_switch,count(le.county_name_values));
  SELF.lender_name_size := SALT34.Fn_SwitchSpec(s.lender_name_switch,count(le.lender_name_values));
  SELF.address_size := SALT34.Fn_SwitchSpec(s.address_switch,count(le.address_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.recording_date_size+t.SourceType_size+t.did_size+t.apnt_or_pin_number_size+t.recorder_book_number_size+t.sales_price_size+t.first_td_loan_amount_size+t.contract_date_size+t.document_number_size+t.recorder_page_number_size+t.name_size+t.fips_code_size+t.county_name_size+t.lender_name_size+t.address_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
