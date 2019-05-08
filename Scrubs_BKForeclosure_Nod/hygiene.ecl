IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_BKForeclosure_Nod) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_foreclosure_id_cnt := COUNT(GROUP,h.foreclosure_id <> (TYPEOF(h.foreclosure_id))'');
    populated_foreclosure_id_pcnt := AVE(GROUP,IF(h.foreclosure_id = (TYPEOF(h.foreclosure_id))'',0,100));
    maxlength_foreclosure_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreclosure_id)));
    avelength_foreclosure_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.foreclosure_id)),h.foreclosure_id<>(typeof(h.foreclosure_id))'');
    populated_ln_filedate_cnt := COUNT(GROUP,h.ln_filedate <> (TYPEOF(h.ln_filedate))'');
    populated_ln_filedate_pcnt := AVE(GROUP,IF(h.ln_filedate = (TYPEOF(h.ln_filedate))'',0,100));
    maxlength_ln_filedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_filedate)));
    avelength_ln_filedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_filedate)),h.ln_filedate<>(typeof(h.ln_filedate))'');
    populated_bk_infile_type_cnt := COUNT(GROUP,h.bk_infile_type <> (TYPEOF(h.bk_infile_type))'');
    populated_bk_infile_type_pcnt := AVE(GROUP,IF(h.bk_infile_type = (TYPEOF(h.bk_infile_type))'',0,100));
    maxlength_bk_infile_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bk_infile_type)));
    avelength_bk_infile_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bk_infile_type)),h.bk_infile_type<>(typeof(h.bk_infile_type))'');
    populated_src_county_cnt := COUNT(GROUP,h.src_county <> (TYPEOF(h.src_county))'');
    populated_src_county_pcnt := AVE(GROUP,IF(h.src_county = (TYPEOF(h.src_county))'',0,100));
    maxlength_src_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_county)));
    avelength_src_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_county)),h.src_county<>(typeof(h.src_county))'');
    populated_src_state_cnt := COUNT(GROUP,h.src_state <> (TYPEOF(h.src_state))'');
    populated_src_state_pcnt := AVE(GROUP,IF(h.src_state = (TYPEOF(h.src_state))'',0,100));
    maxlength_src_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_state)));
    avelength_src_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_state)),h.src_state<>(typeof(h.src_state))'');
    populated_fips_cd_cnt := COUNT(GROUP,h.fips_cd <> (TYPEOF(h.fips_cd))'');
    populated_fips_cd_pcnt := AVE(GROUP,IF(h.fips_cd = (TYPEOF(h.fips_cd))'',0,100));
    maxlength_fips_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_cd)));
    avelength_fips_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_cd)),h.fips_cd<>(typeof(h.fips_cd))'');
    populated_doc_type_cnt := COUNT(GROUP,h.doc_type <> (TYPEOF(h.doc_type))'');
    populated_doc_type_pcnt := AVE(GROUP,IF(h.doc_type = (TYPEOF(h.doc_type))'',0,100));
    maxlength_doc_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_type)));
    avelength_doc_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_type)),h.doc_type<>(typeof(h.doc_type))'');
    populated_recording_dt_cnt := COUNT(GROUP,h.recording_dt <> (TYPEOF(h.recording_dt))'');
    populated_recording_dt_pcnt := AVE(GROUP,IF(h.recording_dt = (TYPEOF(h.recording_dt))'',0,100));
    maxlength_recording_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_dt)));
    avelength_recording_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_dt)),h.recording_dt<>(typeof(h.recording_dt))'');
    populated_recording_doc_num_cnt := COUNT(GROUP,h.recording_doc_num <> (TYPEOF(h.recording_doc_num))'');
    populated_recording_doc_num_pcnt := AVE(GROUP,IF(h.recording_doc_num = (TYPEOF(h.recording_doc_num))'',0,100));
    maxlength_recording_doc_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_doc_num)));
    avelength_recording_doc_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_doc_num)),h.recording_doc_num<>(typeof(h.recording_doc_num))'');
    populated_book_number_cnt := COUNT(GROUP,h.book_number <> (TYPEOF(h.book_number))'');
    populated_book_number_pcnt := AVE(GROUP,IF(h.book_number = (TYPEOF(h.book_number))'',0,100));
    maxlength_book_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.book_number)));
    avelength_book_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.book_number)),h.book_number<>(typeof(h.book_number))'');
    populated_page_number_cnt := COUNT(GROUP,h.page_number <> (TYPEOF(h.page_number))'');
    populated_page_number_pcnt := AVE(GROUP,IF(h.page_number = (TYPEOF(h.page_number))'',0,100));
    maxlength_page_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.page_number)));
    avelength_page_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.page_number)),h.page_number<>(typeof(h.page_number))'');
    populated_loan_number_cnt := COUNT(GROUP,h.loan_number <> (TYPEOF(h.loan_number))'');
    populated_loan_number_pcnt := AVE(GROUP,IF(h.loan_number = (TYPEOF(h.loan_number))'',0,100));
    maxlength_loan_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_number)));
    avelength_loan_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_number)),h.loan_number<>(typeof(h.loan_number))'');
    populated_trustee_sale_number_cnt := COUNT(GROUP,h.trustee_sale_number <> (TYPEOF(h.trustee_sale_number))'');
    populated_trustee_sale_number_pcnt := AVE(GROUP,IF(h.trustee_sale_number = (TYPEOF(h.trustee_sale_number))'',0,100));
    maxlength_trustee_sale_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_sale_number)));
    avelength_trustee_sale_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_sale_number)),h.trustee_sale_number<>(typeof(h.trustee_sale_number))'');
    populated_case_number_cnt := COUNT(GROUP,h.case_number <> (TYPEOF(h.case_number))'');
    populated_case_number_pcnt := AVE(GROUP,IF(h.case_number = (TYPEOF(h.case_number))'',0,100));
    maxlength_case_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.case_number)));
    avelength_case_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.case_number)),h.case_number<>(typeof(h.case_number))'');
    populated_orig_contract_date_cnt := COUNT(GROUP,h.orig_contract_date <> (TYPEOF(h.orig_contract_date))'');
    populated_orig_contract_date_pcnt := AVE(GROUP,IF(h.orig_contract_date = (TYPEOF(h.orig_contract_date))'',0,100));
    maxlength_orig_contract_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_contract_date)));
    avelength_orig_contract_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_contract_date)),h.orig_contract_date<>(typeof(h.orig_contract_date))'');
    populated_unpaid_balance_cnt := COUNT(GROUP,h.unpaid_balance <> (TYPEOF(h.unpaid_balance))'');
    populated_unpaid_balance_pcnt := AVE(GROUP,IF(h.unpaid_balance = (TYPEOF(h.unpaid_balance))'',0,100));
    maxlength_unpaid_balance := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unpaid_balance)));
    avelength_unpaid_balance := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unpaid_balance)),h.unpaid_balance<>(typeof(h.unpaid_balance))'');
    populated_past_due_amt_cnt := COUNT(GROUP,h.past_due_amt <> (TYPEOF(h.past_due_amt))'');
    populated_past_due_amt_pcnt := AVE(GROUP,IF(h.past_due_amt = (TYPEOF(h.past_due_amt))'',0,100));
    maxlength_past_due_amt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.past_due_amt)));
    avelength_past_due_amt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.past_due_amt)),h.past_due_amt<>(typeof(h.past_due_amt))'');
    populated_as_of_dt_cnt := COUNT(GROUP,h.as_of_dt <> (TYPEOF(h.as_of_dt))'');
    populated_as_of_dt_pcnt := AVE(GROUP,IF(h.as_of_dt = (TYPEOF(h.as_of_dt))'',0,100));
    maxlength_as_of_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.as_of_dt)));
    avelength_as_of_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.as_of_dt)),h.as_of_dt<>(typeof(h.as_of_dt))'');
    populated_contact_fname_cnt := COUNT(GROUP,h.contact_fname <> (TYPEOF(h.contact_fname))'');
    populated_contact_fname_pcnt := AVE(GROUP,IF(h.contact_fname = (TYPEOF(h.contact_fname))'',0,100));
    maxlength_contact_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_fname)));
    avelength_contact_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_fname)),h.contact_fname<>(typeof(h.contact_fname))'');
    populated_contact_lname_cnt := COUNT(GROUP,h.contact_lname <> (TYPEOF(h.contact_lname))'');
    populated_contact_lname_pcnt := AVE(GROUP,IF(h.contact_lname = (TYPEOF(h.contact_lname))'',0,100));
    maxlength_contact_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_lname)));
    avelength_contact_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_lname)),h.contact_lname<>(typeof(h.contact_lname))'');
    populated_attention_to_cnt := COUNT(GROUP,h.attention_to <> (TYPEOF(h.attention_to))'');
    populated_attention_to_pcnt := AVE(GROUP,IF(h.attention_to = (TYPEOF(h.attention_to))'',0,100));
    maxlength_attention_to := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attention_to)));
    avelength_attention_to := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attention_to)),h.attention_to<>(typeof(h.attention_to))'');
    populated_contact_mail_full_addr_cnt := COUNT(GROUP,h.contact_mail_full_addr <> (TYPEOF(h.contact_mail_full_addr))'');
    populated_contact_mail_full_addr_pcnt := AVE(GROUP,IF(h.contact_mail_full_addr = (TYPEOF(h.contact_mail_full_addr))'',0,100));
    maxlength_contact_mail_full_addr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_full_addr)));
    avelength_contact_mail_full_addr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_full_addr)),h.contact_mail_full_addr<>(typeof(h.contact_mail_full_addr))'');
    populated_contact_mail_unit_cnt := COUNT(GROUP,h.contact_mail_unit <> (TYPEOF(h.contact_mail_unit))'');
    populated_contact_mail_unit_pcnt := AVE(GROUP,IF(h.contact_mail_unit = (TYPEOF(h.contact_mail_unit))'',0,100));
    maxlength_contact_mail_unit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_unit)));
    avelength_contact_mail_unit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_unit)),h.contact_mail_unit<>(typeof(h.contact_mail_unit))'');
    populated_contact_mail_city_cnt := COUNT(GROUP,h.contact_mail_city <> (TYPEOF(h.contact_mail_city))'');
    populated_contact_mail_city_pcnt := AVE(GROUP,IF(h.contact_mail_city = (TYPEOF(h.contact_mail_city))'',0,100));
    maxlength_contact_mail_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_city)));
    avelength_contact_mail_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_city)),h.contact_mail_city<>(typeof(h.contact_mail_city))'');
    populated_contact_mail_state_cnt := COUNT(GROUP,h.contact_mail_state <> (TYPEOF(h.contact_mail_state))'');
    populated_contact_mail_state_pcnt := AVE(GROUP,IF(h.contact_mail_state = (TYPEOF(h.contact_mail_state))'',0,100));
    maxlength_contact_mail_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_state)));
    avelength_contact_mail_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_state)),h.contact_mail_state<>(typeof(h.contact_mail_state))'');
    populated_contact_mail_zip5_cnt := COUNT(GROUP,h.contact_mail_zip5 <> (TYPEOF(h.contact_mail_zip5))'');
    populated_contact_mail_zip5_pcnt := AVE(GROUP,IF(h.contact_mail_zip5 = (TYPEOF(h.contact_mail_zip5))'',0,100));
    maxlength_contact_mail_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_zip5)));
    avelength_contact_mail_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_zip5)),h.contact_mail_zip5<>(typeof(h.contact_mail_zip5))'');
    populated_contact_mail_zip4_cnt := COUNT(GROUP,h.contact_mail_zip4 <> (TYPEOF(h.contact_mail_zip4))'');
    populated_contact_mail_zip4_pcnt := AVE(GROUP,IF(h.contact_mail_zip4 = (TYPEOF(h.contact_mail_zip4))'',0,100));
    maxlength_contact_mail_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_zip4)));
    avelength_contact_mail_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_mail_zip4)),h.contact_mail_zip4<>(typeof(h.contact_mail_zip4))'');
    populated_contact_telephone_cnt := COUNT(GROUP,h.contact_telephone <> (TYPEOF(h.contact_telephone))'');
    populated_contact_telephone_pcnt := AVE(GROUP,IF(h.contact_telephone = (TYPEOF(h.contact_telephone))'',0,100));
    maxlength_contact_telephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_telephone)));
    avelength_contact_telephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_telephone)),h.contact_telephone<>(typeof(h.contact_telephone))'');
    populated_due_date_cnt := COUNT(GROUP,h.due_date <> (TYPEOF(h.due_date))'');
    populated_due_date_pcnt := AVE(GROUP,IF(h.due_date = (TYPEOF(h.due_date))'',0,100));
    maxlength_due_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.due_date)));
    avelength_due_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.due_date)),h.due_date<>(typeof(h.due_date))'');
    populated_trustee_fname_cnt := COUNT(GROUP,h.trustee_fname <> (TYPEOF(h.trustee_fname))'');
    populated_trustee_fname_pcnt := AVE(GROUP,IF(h.trustee_fname = (TYPEOF(h.trustee_fname))'',0,100));
    maxlength_trustee_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_fname)));
    avelength_trustee_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_fname)),h.trustee_fname<>(typeof(h.trustee_fname))'');
    populated_trustee_lname_cnt := COUNT(GROUP,h.trustee_lname <> (TYPEOF(h.trustee_lname))'');
    populated_trustee_lname_pcnt := AVE(GROUP,IF(h.trustee_lname = (TYPEOF(h.trustee_lname))'',0,100));
    maxlength_trustee_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_lname)));
    avelength_trustee_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_lname)),h.trustee_lname<>(typeof(h.trustee_lname))'');
    populated_trustee_mail_full_addr_cnt := COUNT(GROUP,h.trustee_mail_full_addr <> (TYPEOF(h.trustee_mail_full_addr))'');
    populated_trustee_mail_full_addr_pcnt := AVE(GROUP,IF(h.trustee_mail_full_addr = (TYPEOF(h.trustee_mail_full_addr))'',0,100));
    maxlength_trustee_mail_full_addr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_full_addr)));
    avelength_trustee_mail_full_addr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_full_addr)),h.trustee_mail_full_addr<>(typeof(h.trustee_mail_full_addr))'');
    populated_trustee_mail_unit_cnt := COUNT(GROUP,h.trustee_mail_unit <> (TYPEOF(h.trustee_mail_unit))'');
    populated_trustee_mail_unit_pcnt := AVE(GROUP,IF(h.trustee_mail_unit = (TYPEOF(h.trustee_mail_unit))'',0,100));
    maxlength_trustee_mail_unit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_unit)));
    avelength_trustee_mail_unit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_unit)),h.trustee_mail_unit<>(typeof(h.trustee_mail_unit))'');
    populated_trustee_mail_city_cnt := COUNT(GROUP,h.trustee_mail_city <> (TYPEOF(h.trustee_mail_city))'');
    populated_trustee_mail_city_pcnt := AVE(GROUP,IF(h.trustee_mail_city = (TYPEOF(h.trustee_mail_city))'',0,100));
    maxlength_trustee_mail_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_city)));
    avelength_trustee_mail_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_city)),h.trustee_mail_city<>(typeof(h.trustee_mail_city))'');
    populated_trustee_mail_state_cnt := COUNT(GROUP,h.trustee_mail_state <> (TYPEOF(h.trustee_mail_state))'');
    populated_trustee_mail_state_pcnt := AVE(GROUP,IF(h.trustee_mail_state = (TYPEOF(h.trustee_mail_state))'',0,100));
    maxlength_trustee_mail_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_state)));
    avelength_trustee_mail_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_state)),h.trustee_mail_state<>(typeof(h.trustee_mail_state))'');
    populated_trustee_mail_zip5_cnt := COUNT(GROUP,h.trustee_mail_zip5 <> (TYPEOF(h.trustee_mail_zip5))'');
    populated_trustee_mail_zip5_pcnt := AVE(GROUP,IF(h.trustee_mail_zip5 = (TYPEOF(h.trustee_mail_zip5))'',0,100));
    maxlength_trustee_mail_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_zip5)));
    avelength_trustee_mail_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_zip5)),h.trustee_mail_zip5<>(typeof(h.trustee_mail_zip5))'');
    populated_trustee_mail_zip4_cnt := COUNT(GROUP,h.trustee_mail_zip4 <> (TYPEOF(h.trustee_mail_zip4))'');
    populated_trustee_mail_zip4_pcnt := AVE(GROUP,IF(h.trustee_mail_zip4 = (TYPEOF(h.trustee_mail_zip4))'',0,100));
    maxlength_trustee_mail_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_zip4)));
    avelength_trustee_mail_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_zip4)),h.trustee_mail_zip4<>(typeof(h.trustee_mail_zip4))'');
    populated_trustee_telephone_cnt := COUNT(GROUP,h.trustee_telephone <> (TYPEOF(h.trustee_telephone))'');
    populated_trustee_telephone_pcnt := AVE(GROUP,IF(h.trustee_telephone = (TYPEOF(h.trustee_telephone))'',0,100));
    maxlength_trustee_telephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_telephone)));
    avelength_trustee_telephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_telephone)),h.trustee_telephone<>(typeof(h.trustee_telephone))'');
    populated_borrower1_fname_cnt := COUNT(GROUP,h.borrower1_fname <> (TYPEOF(h.borrower1_fname))'');
    populated_borrower1_fname_pcnt := AVE(GROUP,IF(h.borrower1_fname = (TYPEOF(h.borrower1_fname))'',0,100));
    maxlength_borrower1_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower1_fname)));
    avelength_borrower1_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower1_fname)),h.borrower1_fname<>(typeof(h.borrower1_fname))'');
    populated_borrower1_lname_cnt := COUNT(GROUP,h.borrower1_lname <> (TYPEOF(h.borrower1_lname))'');
    populated_borrower1_lname_pcnt := AVE(GROUP,IF(h.borrower1_lname = (TYPEOF(h.borrower1_lname))'',0,100));
    maxlength_borrower1_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower1_lname)));
    avelength_borrower1_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower1_lname)),h.borrower1_lname<>(typeof(h.borrower1_lname))'');
    populated_borrower1_id_cd_cnt := COUNT(GROUP,h.borrower1_id_cd <> (TYPEOF(h.borrower1_id_cd))'');
    populated_borrower1_id_cd_pcnt := AVE(GROUP,IF(h.borrower1_id_cd = (TYPEOF(h.borrower1_id_cd))'',0,100));
    maxlength_borrower1_id_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower1_id_cd)));
    avelength_borrower1_id_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower1_id_cd)),h.borrower1_id_cd<>(typeof(h.borrower1_id_cd))'');
    populated_borrower2_fname_cnt := COUNT(GROUP,h.borrower2_fname <> (TYPEOF(h.borrower2_fname))'');
    populated_borrower2_fname_pcnt := AVE(GROUP,IF(h.borrower2_fname = (TYPEOF(h.borrower2_fname))'',0,100));
    maxlength_borrower2_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower2_fname)));
    avelength_borrower2_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower2_fname)),h.borrower2_fname<>(typeof(h.borrower2_fname))'');
    populated_borrower2_lname_cnt := COUNT(GROUP,h.borrower2_lname <> (TYPEOF(h.borrower2_lname))'');
    populated_borrower2_lname_pcnt := AVE(GROUP,IF(h.borrower2_lname = (TYPEOF(h.borrower2_lname))'',0,100));
    maxlength_borrower2_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower2_lname)));
    avelength_borrower2_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower2_lname)),h.borrower2_lname<>(typeof(h.borrower2_lname))'');
    populated_borrower2_id_cd_cnt := COUNT(GROUP,h.borrower2_id_cd <> (TYPEOF(h.borrower2_id_cd))'');
    populated_borrower2_id_cd_pcnt := AVE(GROUP,IF(h.borrower2_id_cd = (TYPEOF(h.borrower2_id_cd))'',0,100));
    maxlength_borrower2_id_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower2_id_cd)));
    avelength_borrower2_id_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.borrower2_id_cd)),h.borrower2_id_cd<>(typeof(h.borrower2_id_cd))'');
    populated_orig_lender_name_cnt := COUNT(GROUP,h.orig_lender_name <> (TYPEOF(h.orig_lender_name))'');
    populated_orig_lender_name_pcnt := AVE(GROUP,IF(h.orig_lender_name = (TYPEOF(h.orig_lender_name))'',0,100));
    maxlength_orig_lender_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_lender_name)));
    avelength_orig_lender_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_lender_name)),h.orig_lender_name<>(typeof(h.orig_lender_name))'');
    populated_orig_lender_type_cnt := COUNT(GROUP,h.orig_lender_type <> (TYPEOF(h.orig_lender_type))'');
    populated_orig_lender_type_pcnt := AVE(GROUP,IF(h.orig_lender_type = (TYPEOF(h.orig_lender_type))'',0,100));
    maxlength_orig_lender_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_lender_type)));
    avelength_orig_lender_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_lender_type)),h.orig_lender_type<>(typeof(h.orig_lender_type))'');
    populated_curr_lender_name_cnt := COUNT(GROUP,h.curr_lender_name <> (TYPEOF(h.curr_lender_name))'');
    populated_curr_lender_name_pcnt := AVE(GROUP,IF(h.curr_lender_name = (TYPEOF(h.curr_lender_name))'',0,100));
    maxlength_curr_lender_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.curr_lender_name)));
    avelength_curr_lender_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.curr_lender_name)),h.curr_lender_name<>(typeof(h.curr_lender_name))'');
    populated_curr_lender_type_cnt := COUNT(GROUP,h.curr_lender_type <> (TYPEOF(h.curr_lender_type))'');
    populated_curr_lender_type_pcnt := AVE(GROUP,IF(h.curr_lender_type = (TYPEOF(h.curr_lender_type))'',0,100));
    maxlength_curr_lender_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.curr_lender_type)));
    avelength_curr_lender_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.curr_lender_type)),h.curr_lender_type<>(typeof(h.curr_lender_type))'');
    populated_mers_indicator_cnt := COUNT(GROUP,h.mers_indicator <> (TYPEOF(h.mers_indicator))'');
    populated_mers_indicator_pcnt := AVE(GROUP,IF(h.mers_indicator = (TYPEOF(h.mers_indicator))'',0,100));
    maxlength_mers_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mers_indicator)));
    avelength_mers_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mers_indicator)),h.mers_indicator<>(typeof(h.mers_indicator))'');
    populated_loan_recording_date_cnt := COUNT(GROUP,h.loan_recording_date <> (TYPEOF(h.loan_recording_date))'');
    populated_loan_recording_date_pcnt := AVE(GROUP,IF(h.loan_recording_date = (TYPEOF(h.loan_recording_date))'',0,100));
    maxlength_loan_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_recording_date)));
    avelength_loan_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_recording_date)),h.loan_recording_date<>(typeof(h.loan_recording_date))'');
    populated_loan_doc_num_cnt := COUNT(GROUP,h.loan_doc_num <> (TYPEOF(h.loan_doc_num))'');
    populated_loan_doc_num_pcnt := AVE(GROUP,IF(h.loan_doc_num = (TYPEOF(h.loan_doc_num))'',0,100));
    maxlength_loan_doc_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_doc_num)));
    avelength_loan_doc_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_doc_num)),h.loan_doc_num<>(typeof(h.loan_doc_num))'');
    populated_loan_book_cnt := COUNT(GROUP,h.loan_book <> (TYPEOF(h.loan_book))'');
    populated_loan_book_pcnt := AVE(GROUP,IF(h.loan_book = (TYPEOF(h.loan_book))'',0,100));
    maxlength_loan_book := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_book)));
    avelength_loan_book := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_book)),h.loan_book<>(typeof(h.loan_book))'');
    populated_loan_page_cnt := COUNT(GROUP,h.loan_page <> (TYPEOF(h.loan_page))'');
    populated_loan_page_pcnt := AVE(GROUP,IF(h.loan_page = (TYPEOF(h.loan_page))'',0,100));
    maxlength_loan_page := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_page)));
    avelength_loan_page := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_page)),h.loan_page<>(typeof(h.loan_page))'');
    populated_orig_loan_amt_cnt := COUNT(GROUP,h.orig_loan_amt <> (TYPEOF(h.orig_loan_amt))'');
    populated_orig_loan_amt_pcnt := AVE(GROUP,IF(h.orig_loan_amt = (TYPEOF(h.orig_loan_amt))'',0,100));
    maxlength_orig_loan_amt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_loan_amt)));
    avelength_orig_loan_amt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_loan_amt)),h.orig_loan_amt<>(typeof(h.orig_loan_amt))'');
    populated_legal_lot_num_cnt := COUNT(GROUP,h.legal_lot_num <> (TYPEOF(h.legal_lot_num))'');
    populated_legal_lot_num_pcnt := AVE(GROUP,IF(h.legal_lot_num = (TYPEOF(h.legal_lot_num))'',0,100));
    maxlength_legal_lot_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_lot_num)));
    avelength_legal_lot_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_lot_num)),h.legal_lot_num<>(typeof(h.legal_lot_num))'');
    populated_legal_block_cnt := COUNT(GROUP,h.legal_block <> (TYPEOF(h.legal_block))'');
    populated_legal_block_pcnt := AVE(GROUP,IF(h.legal_block = (TYPEOF(h.legal_block))'',0,100));
    maxlength_legal_block := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_block)));
    avelength_legal_block := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_block)),h.legal_block<>(typeof(h.legal_block))'');
    populated_legal_subdivision_name_cnt := COUNT(GROUP,h.legal_subdivision_name <> (TYPEOF(h.legal_subdivision_name))'');
    populated_legal_subdivision_name_pcnt := AVE(GROUP,IF(h.legal_subdivision_name = (TYPEOF(h.legal_subdivision_name))'',0,100));
    maxlength_legal_subdivision_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_subdivision_name)));
    avelength_legal_subdivision_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_subdivision_name)),h.legal_subdivision_name<>(typeof(h.legal_subdivision_name))'');
    populated_legal_brief_desc_cnt := COUNT(GROUP,h.legal_brief_desc <> (TYPEOF(h.legal_brief_desc))'');
    populated_legal_brief_desc_pcnt := AVE(GROUP,IF(h.legal_brief_desc = (TYPEOF(h.legal_brief_desc))'',0,100));
    maxlength_legal_brief_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_brief_desc)));
    avelength_legal_brief_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_brief_desc)),h.legal_brief_desc<>(typeof(h.legal_brief_desc))'');
    populated_auction_date_cnt := COUNT(GROUP,h.auction_date <> (TYPEOF(h.auction_date))'');
    populated_auction_date_pcnt := AVE(GROUP,IF(h.auction_date = (TYPEOF(h.auction_date))'',0,100));
    maxlength_auction_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.auction_date)));
    avelength_auction_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.auction_date)),h.auction_date<>(typeof(h.auction_date))'');
    populated_auction_time_cnt := COUNT(GROUP,h.auction_time <> (TYPEOF(h.auction_time))'');
    populated_auction_time_pcnt := AVE(GROUP,IF(h.auction_time = (TYPEOF(h.auction_time))'',0,100));
    maxlength_auction_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.auction_time)));
    avelength_auction_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.auction_time)),h.auction_time<>(typeof(h.auction_time))'');
    populated_auction_location_cnt := COUNT(GROUP,h.auction_location <> (TYPEOF(h.auction_location))'');
    populated_auction_location_pcnt := AVE(GROUP,IF(h.auction_location = (TYPEOF(h.auction_location))'',0,100));
    maxlength_auction_location := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.auction_location)));
    avelength_auction_location := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.auction_location)),h.auction_location<>(typeof(h.auction_location))'');
    populated_auction_min_bid_amt_cnt := COUNT(GROUP,h.auction_min_bid_amt <> (TYPEOF(h.auction_min_bid_amt))'');
    populated_auction_min_bid_amt_pcnt := AVE(GROUP,IF(h.auction_min_bid_amt = (TYPEOF(h.auction_min_bid_amt))'',0,100));
    maxlength_auction_min_bid_amt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.auction_min_bid_amt)));
    avelength_auction_min_bid_amt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.auction_min_bid_amt)),h.auction_min_bid_amt<>(typeof(h.auction_min_bid_amt))'');
    populated_trustee_mail_careof_cnt := COUNT(GROUP,h.trustee_mail_careof <> (TYPEOF(h.trustee_mail_careof))'');
    populated_trustee_mail_careof_pcnt := AVE(GROUP,IF(h.trustee_mail_careof = (TYPEOF(h.trustee_mail_careof))'',0,100));
    maxlength_trustee_mail_careof := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_careof)));
    avelength_trustee_mail_careof := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trustee_mail_careof)),h.trustee_mail_careof<>(typeof(h.trustee_mail_careof))'');
    populated_property_addr_cd_cnt := COUNT(GROUP,h.property_addr_cd <> (TYPEOF(h.property_addr_cd))'');
    populated_property_addr_cd_pcnt := AVE(GROUP,IF(h.property_addr_cd = (TYPEOF(h.property_addr_cd))'',0,100));
    maxlength_property_addr_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_addr_cd)));
    avelength_property_addr_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_addr_cd)),h.property_addr_cd<>(typeof(h.property_addr_cd))'');
    populated_auction_city_cnt := COUNT(GROUP,h.auction_city <> (TYPEOF(h.auction_city))'');
    populated_auction_city_pcnt := AVE(GROUP,IF(h.auction_city = (TYPEOF(h.auction_city))'',0,100));
    maxlength_auction_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.auction_city)));
    avelength_auction_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.auction_city)),h.auction_city<>(typeof(h.auction_city))'');
    populated_original_nod_recording_date_cnt := COUNT(GROUP,h.original_nod_recording_date <> (TYPEOF(h.original_nod_recording_date))'');
    populated_original_nod_recording_date_pcnt := AVE(GROUP,IF(h.original_nod_recording_date = (TYPEOF(h.original_nod_recording_date))'',0,100));
    maxlength_original_nod_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.original_nod_recording_date)));
    avelength_original_nod_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.original_nod_recording_date)),h.original_nod_recording_date<>(typeof(h.original_nod_recording_date))'');
    populated_original_nod_doc_num_cnt := COUNT(GROUP,h.original_nod_doc_num <> (TYPEOF(h.original_nod_doc_num))'');
    populated_original_nod_doc_num_pcnt := AVE(GROUP,IF(h.original_nod_doc_num = (TYPEOF(h.original_nod_doc_num))'',0,100));
    maxlength_original_nod_doc_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.original_nod_doc_num)));
    avelength_original_nod_doc_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.original_nod_doc_num)),h.original_nod_doc_num<>(typeof(h.original_nod_doc_num))'');
    populated_original_nod_book_cnt := COUNT(GROUP,h.original_nod_book <> (TYPEOF(h.original_nod_book))'');
    populated_original_nod_book_pcnt := AVE(GROUP,IF(h.original_nod_book = (TYPEOF(h.original_nod_book))'',0,100));
    maxlength_original_nod_book := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.original_nod_book)));
    avelength_original_nod_book := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.original_nod_book)),h.original_nod_book<>(typeof(h.original_nod_book))'');
    populated_original_nod_page_cnt := COUNT(GROUP,h.original_nod_page <> (TYPEOF(h.original_nod_page))'');
    populated_original_nod_page_pcnt := AVE(GROUP,IF(h.original_nod_page = (TYPEOF(h.original_nod_page))'',0,100));
    maxlength_original_nod_page := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.original_nod_page)));
    avelength_original_nod_page := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.original_nod_page)),h.original_nod_page<>(typeof(h.original_nod_page))'');
    populated_nod_apn_cnt := COUNT(GROUP,h.nod_apn <> (TYPEOF(h.nod_apn))'');
    populated_nod_apn_pcnt := AVE(GROUP,IF(h.nod_apn = (TYPEOF(h.nod_apn))'',0,100));
    maxlength_nod_apn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nod_apn)));
    avelength_nod_apn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nod_apn)),h.nod_apn<>(typeof(h.nod_apn))'');
    populated_property_full_addr_cnt := COUNT(GROUP,h.property_full_addr <> (TYPEOF(h.property_full_addr))'');
    populated_property_full_addr_pcnt := AVE(GROUP,IF(h.property_full_addr = (TYPEOF(h.property_full_addr))'',0,100));
    maxlength_property_full_addr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_full_addr)));
    avelength_property_full_addr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_full_addr)),h.property_full_addr<>(typeof(h.property_full_addr))'');
    populated_prop_addr_unit_type_cnt := COUNT(GROUP,h.prop_addr_unit_type <> (TYPEOF(h.prop_addr_unit_type))'');
    populated_prop_addr_unit_type_pcnt := AVE(GROUP,IF(h.prop_addr_unit_type = (TYPEOF(h.prop_addr_unit_type))'',0,100));
    maxlength_prop_addr_unit_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_unit_type)));
    avelength_prop_addr_unit_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_unit_type)),h.prop_addr_unit_type<>(typeof(h.prop_addr_unit_type))'');
    populated_prop_addr_unit_no_cnt := COUNT(GROUP,h.prop_addr_unit_no <> (TYPEOF(h.prop_addr_unit_no))'');
    populated_prop_addr_unit_no_pcnt := AVE(GROUP,IF(h.prop_addr_unit_no = (TYPEOF(h.prop_addr_unit_no))'',0,100));
    maxlength_prop_addr_unit_no := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_unit_no)));
    avelength_prop_addr_unit_no := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_unit_no)),h.prop_addr_unit_no<>(typeof(h.prop_addr_unit_no))'');
    populated_prop_addr_city_cnt := COUNT(GROUP,h.prop_addr_city <> (TYPEOF(h.prop_addr_city))'');
    populated_prop_addr_city_pcnt := AVE(GROUP,IF(h.prop_addr_city = (TYPEOF(h.prop_addr_city))'',0,100));
    maxlength_prop_addr_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_city)));
    avelength_prop_addr_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_city)),h.prop_addr_city<>(typeof(h.prop_addr_city))'');
    populated_prop_addr_state_cnt := COUNT(GROUP,h.prop_addr_state <> (TYPEOF(h.prop_addr_state))'');
    populated_prop_addr_state_pcnt := AVE(GROUP,IF(h.prop_addr_state = (TYPEOF(h.prop_addr_state))'',0,100));
    maxlength_prop_addr_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_state)));
    avelength_prop_addr_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_state)),h.prop_addr_state<>(typeof(h.prop_addr_state))'');
    populated_prop_addr_zip5_cnt := COUNT(GROUP,h.prop_addr_zip5 <> (TYPEOF(h.prop_addr_zip5))'');
    populated_prop_addr_zip5_pcnt := AVE(GROUP,IF(h.prop_addr_zip5 = (TYPEOF(h.prop_addr_zip5))'',0,100));
    maxlength_prop_addr_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_zip5)));
    avelength_prop_addr_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_zip5)),h.prop_addr_zip5<>(typeof(h.prop_addr_zip5))'');
    populated_prop_addr_zip4_cnt := COUNT(GROUP,h.prop_addr_zip4 <> (TYPEOF(h.prop_addr_zip4))'');
    populated_prop_addr_zip4_pcnt := AVE(GROUP,IF(h.prop_addr_zip4 = (TYPEOF(h.prop_addr_zip4))'',0,100));
    maxlength_prop_addr_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_zip4)));
    avelength_prop_addr_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_zip4)),h.prop_addr_zip4<>(typeof(h.prop_addr_zip4))'');
    populated_apn_cnt := COUNT(GROUP,h.apn <> (TYPEOF(h.apn))'');
    populated_apn_pcnt := AVE(GROUP,IF(h.apn = (TYPEOF(h.apn))'',0,100));
    maxlength_apn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apn)));
    avelength_apn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apn)),h.apn<>(typeof(h.apn))'');
    populated_sam_pid_cnt := COUNT(GROUP,h.sam_pid <> (TYPEOF(h.sam_pid))'');
    populated_sam_pid_pcnt := AVE(GROUP,IF(h.sam_pid = (TYPEOF(h.sam_pid))'',0,100));
    maxlength_sam_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sam_pid)));
    avelength_sam_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sam_pid)),h.sam_pid<>(typeof(h.sam_pid))'');
    populated_deed_pid_cnt := COUNT(GROUP,h.deed_pid <> (TYPEOF(h.deed_pid))'');
    populated_deed_pid_pcnt := AVE(GROUP,IF(h.deed_pid = (TYPEOF(h.deed_pid))'',0,100));
    maxlength_deed_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deed_pid)));
    avelength_deed_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deed_pid)),h.deed_pid<>(typeof(h.deed_pid))'');
    populated_lps_internal_pid_cnt := COUNT(GROUP,h.lps_internal_pid <> (TYPEOF(h.lps_internal_pid))'');
    populated_lps_internal_pid_pcnt := AVE(GROUP,IF(h.lps_internal_pid = (TYPEOF(h.lps_internal_pid))'',0,100));
    maxlength_lps_internal_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lps_internal_pid)));
    avelength_lps_internal_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lps_internal_pid)),h.lps_internal_pid<>(typeof(h.lps_internal_pid))'');
    populated_nod_source_cnt := COUNT(GROUP,h.nod_source <> (TYPEOF(h.nod_source))'');
    populated_nod_source_pcnt := AVE(GROUP,IF(h.nod_source = (TYPEOF(h.nod_source))'',0,100));
    maxlength_nod_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nod_source)));
    avelength_nod_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nod_source)),h.nod_source<>(typeof(h.nod_source))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_foreclosure_id_pcnt *   0.00 / 100 + T.Populated_ln_filedate_pcnt *   0.00 / 100 + T.Populated_bk_infile_type_pcnt *   0.00 / 100 + T.Populated_src_county_pcnt *   0.00 / 100 + T.Populated_src_state_pcnt *   0.00 / 100 + T.Populated_fips_cd_pcnt *   0.00 / 100 + T.Populated_doc_type_pcnt *   0.00 / 100 + T.Populated_recording_dt_pcnt *   0.00 / 100 + T.Populated_recording_doc_num_pcnt *   0.00 / 100 + T.Populated_book_number_pcnt *   0.00 / 100 + T.Populated_page_number_pcnt *   0.00 / 100 + T.Populated_loan_number_pcnt *   0.00 / 100 + T.Populated_trustee_sale_number_pcnt *   0.00 / 100 + T.Populated_case_number_pcnt *   0.00 / 100 + T.Populated_orig_contract_date_pcnt *   0.00 / 100 + T.Populated_unpaid_balance_pcnt *   0.00 / 100 + T.Populated_past_due_amt_pcnt *   0.00 / 100 + T.Populated_as_of_dt_pcnt *   0.00 / 100 + T.Populated_contact_fname_pcnt *   0.00 / 100 + T.Populated_contact_lname_pcnt *   0.00 / 100 + T.Populated_attention_to_pcnt *   0.00 / 100 + T.Populated_contact_mail_full_addr_pcnt *   0.00 / 100 + T.Populated_contact_mail_unit_pcnt *   0.00 / 100 + T.Populated_contact_mail_city_pcnt *   0.00 / 100 + T.Populated_contact_mail_state_pcnt *   0.00 / 100 + T.Populated_contact_mail_zip5_pcnt *   0.00 / 100 + T.Populated_contact_mail_zip4_pcnt *   0.00 / 100 + T.Populated_contact_telephone_pcnt *   0.00 / 100 + T.Populated_due_date_pcnt *   0.00 / 100 + T.Populated_trustee_fname_pcnt *   0.00 / 100 + T.Populated_trustee_lname_pcnt *   0.00 / 100 + T.Populated_trustee_mail_full_addr_pcnt *   0.00 / 100 + T.Populated_trustee_mail_unit_pcnt *   0.00 / 100 + T.Populated_trustee_mail_city_pcnt *   0.00 / 100 + T.Populated_trustee_mail_state_pcnt *   0.00 / 100 + T.Populated_trustee_mail_zip5_pcnt *   0.00 / 100 + T.Populated_trustee_mail_zip4_pcnt *   0.00 / 100 + T.Populated_trustee_telephone_pcnt *   0.00 / 100 + T.Populated_borrower1_fname_pcnt *   0.00 / 100 + T.Populated_borrower1_lname_pcnt *   0.00 / 100 + T.Populated_borrower1_id_cd_pcnt *   0.00 / 100 + T.Populated_borrower2_fname_pcnt *   0.00 / 100 + T.Populated_borrower2_lname_pcnt *   0.00 / 100 + T.Populated_borrower2_id_cd_pcnt *   0.00 / 100 + T.Populated_orig_lender_name_pcnt *   0.00 / 100 + T.Populated_orig_lender_type_pcnt *   0.00 / 100 + T.Populated_curr_lender_name_pcnt *   0.00 / 100 + T.Populated_curr_lender_type_pcnt *   0.00 / 100 + T.Populated_mers_indicator_pcnt *   0.00 / 100 + T.Populated_loan_recording_date_pcnt *   0.00 / 100 + T.Populated_loan_doc_num_pcnt *   0.00 / 100 + T.Populated_loan_book_pcnt *   0.00 / 100 + T.Populated_loan_page_pcnt *   0.00 / 100 + T.Populated_orig_loan_amt_pcnt *   0.00 / 100 + T.Populated_legal_lot_num_pcnt *   0.00 / 100 + T.Populated_legal_block_pcnt *   0.00 / 100 + T.Populated_legal_subdivision_name_pcnt *   0.00 / 100 + T.Populated_legal_brief_desc_pcnt *   0.00 / 100 + T.Populated_auction_date_pcnt *   0.00 / 100 + T.Populated_auction_time_pcnt *   0.00 / 100 + T.Populated_auction_location_pcnt *   0.00 / 100 + T.Populated_auction_min_bid_amt_pcnt *   0.00 / 100 + T.Populated_trustee_mail_careof_pcnt *   0.00 / 100 + T.Populated_property_addr_cd_pcnt *   0.00 / 100 + T.Populated_auction_city_pcnt *   0.00 / 100 + T.Populated_original_nod_recording_date_pcnt *   0.00 / 100 + T.Populated_original_nod_doc_num_pcnt *   0.00 / 100 + T.Populated_original_nod_book_pcnt *   0.00 / 100 + T.Populated_original_nod_page_pcnt *   0.00 / 100 + T.Populated_nod_apn_pcnt *   0.00 / 100 + T.Populated_property_full_addr_pcnt *   0.00 / 100 + T.Populated_prop_addr_unit_type_pcnt *   0.00 / 100 + T.Populated_prop_addr_unit_no_pcnt *   0.00 / 100 + T.Populated_prop_addr_city_pcnt *   0.00 / 100 + T.Populated_prop_addr_state_pcnt *   0.00 / 100 + T.Populated_prop_addr_zip5_pcnt *   0.00 / 100 + T.Populated_prop_addr_zip4_pcnt *   0.00 / 100 + T.Populated_apn_pcnt *   0.00 / 100 + T.Populated_sam_pid_pcnt *   0.00 / 100 + T.Populated_deed_pid_pcnt *   0.00 / 100 + T.Populated_lps_internal_pid_pcnt *   0.00 / 100 + T.Populated_nod_source_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'foreclosure_id','ln_filedate','bk_infile_type','src_county','src_state','fips_cd','doc_type','recording_dt','recording_doc_num','book_number','page_number','loan_number','trustee_sale_number','case_number','orig_contract_date','unpaid_balance','past_due_amt','as_of_dt','contact_fname','contact_lname','attention_to','contact_mail_full_addr','contact_mail_unit','contact_mail_city','contact_mail_state','contact_mail_zip5','contact_mail_zip4','contact_telephone','due_date','trustee_fname','trustee_lname','trustee_mail_full_addr','trustee_mail_unit','trustee_mail_city','trustee_mail_state','trustee_mail_zip5','trustee_mail_zip4','trustee_telephone','borrower1_fname','borrower1_lname','borrower1_id_cd','borrower2_fname','borrower2_lname','borrower2_id_cd','orig_lender_name','orig_lender_type','curr_lender_name','curr_lender_type','mers_indicator','loan_recording_date','loan_doc_num','loan_book','loan_page','orig_loan_amt','legal_lot_num','legal_block','legal_subdivision_name','legal_brief_desc','auction_date','auction_time','auction_location','auction_min_bid_amt','trustee_mail_careof','property_addr_cd','auction_city','original_nod_recording_date','original_nod_doc_num','original_nod_book','original_nod_page','nod_apn','property_full_addr','prop_addr_unit_type','prop_addr_unit_no','prop_addr_city','prop_addr_state','prop_addr_zip5','prop_addr_zip4','apn','sam_pid','deed_pid','lps_internal_pid','nod_source');
  SELF.populated_pcnt := CHOOSE(C,le.populated_foreclosure_id_pcnt,le.populated_ln_filedate_pcnt,le.populated_bk_infile_type_pcnt,le.populated_src_county_pcnt,le.populated_src_state_pcnt,le.populated_fips_cd_pcnt,le.populated_doc_type_pcnt,le.populated_recording_dt_pcnt,le.populated_recording_doc_num_pcnt,le.populated_book_number_pcnt,le.populated_page_number_pcnt,le.populated_loan_number_pcnt,le.populated_trustee_sale_number_pcnt,le.populated_case_number_pcnt,le.populated_orig_contract_date_pcnt,le.populated_unpaid_balance_pcnt,le.populated_past_due_amt_pcnt,le.populated_as_of_dt_pcnt,le.populated_contact_fname_pcnt,le.populated_contact_lname_pcnt,le.populated_attention_to_pcnt,le.populated_contact_mail_full_addr_pcnt,le.populated_contact_mail_unit_pcnt,le.populated_contact_mail_city_pcnt,le.populated_contact_mail_state_pcnt,le.populated_contact_mail_zip5_pcnt,le.populated_contact_mail_zip4_pcnt,le.populated_contact_telephone_pcnt,le.populated_due_date_pcnt,le.populated_trustee_fname_pcnt,le.populated_trustee_lname_pcnt,le.populated_trustee_mail_full_addr_pcnt,le.populated_trustee_mail_unit_pcnt,le.populated_trustee_mail_city_pcnt,le.populated_trustee_mail_state_pcnt,le.populated_trustee_mail_zip5_pcnt,le.populated_trustee_mail_zip4_pcnt,le.populated_trustee_telephone_pcnt,le.populated_borrower1_fname_pcnt,le.populated_borrower1_lname_pcnt,le.populated_borrower1_id_cd_pcnt,le.populated_borrower2_fname_pcnt,le.populated_borrower2_lname_pcnt,le.populated_borrower2_id_cd_pcnt,le.populated_orig_lender_name_pcnt,le.populated_orig_lender_type_pcnt,le.populated_curr_lender_name_pcnt,le.populated_curr_lender_type_pcnt,le.populated_mers_indicator_pcnt,le.populated_loan_recording_date_pcnt,le.populated_loan_doc_num_pcnt,le.populated_loan_book_pcnt,le.populated_loan_page_pcnt,le.populated_orig_loan_amt_pcnt,le.populated_legal_lot_num_pcnt,le.populated_legal_block_pcnt,le.populated_legal_subdivision_name_pcnt,le.populated_legal_brief_desc_pcnt,le.populated_auction_date_pcnt,le.populated_auction_time_pcnt,le.populated_auction_location_pcnt,le.populated_auction_min_bid_amt_pcnt,le.populated_trustee_mail_careof_pcnt,le.populated_property_addr_cd_pcnt,le.populated_auction_city_pcnt,le.populated_original_nod_recording_date_pcnt,le.populated_original_nod_doc_num_pcnt,le.populated_original_nod_book_pcnt,le.populated_original_nod_page_pcnt,le.populated_nod_apn_pcnt,le.populated_property_full_addr_pcnt,le.populated_prop_addr_unit_type_pcnt,le.populated_prop_addr_unit_no_pcnt,le.populated_prop_addr_city_pcnt,le.populated_prop_addr_state_pcnt,le.populated_prop_addr_zip5_pcnt,le.populated_prop_addr_zip4_pcnt,le.populated_apn_pcnt,le.populated_sam_pid_pcnt,le.populated_deed_pid_pcnt,le.populated_lps_internal_pid_pcnt,le.populated_nod_source_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_foreclosure_id,le.maxlength_ln_filedate,le.maxlength_bk_infile_type,le.maxlength_src_county,le.maxlength_src_state,le.maxlength_fips_cd,le.maxlength_doc_type,le.maxlength_recording_dt,le.maxlength_recording_doc_num,le.maxlength_book_number,le.maxlength_page_number,le.maxlength_loan_number,le.maxlength_trustee_sale_number,le.maxlength_case_number,le.maxlength_orig_contract_date,le.maxlength_unpaid_balance,le.maxlength_past_due_amt,le.maxlength_as_of_dt,le.maxlength_contact_fname,le.maxlength_contact_lname,le.maxlength_attention_to,le.maxlength_contact_mail_full_addr,le.maxlength_contact_mail_unit,le.maxlength_contact_mail_city,le.maxlength_contact_mail_state,le.maxlength_contact_mail_zip5,le.maxlength_contact_mail_zip4,le.maxlength_contact_telephone,le.maxlength_due_date,le.maxlength_trustee_fname,le.maxlength_trustee_lname,le.maxlength_trustee_mail_full_addr,le.maxlength_trustee_mail_unit,le.maxlength_trustee_mail_city,le.maxlength_trustee_mail_state,le.maxlength_trustee_mail_zip5,le.maxlength_trustee_mail_zip4,le.maxlength_trustee_telephone,le.maxlength_borrower1_fname,le.maxlength_borrower1_lname,le.maxlength_borrower1_id_cd,le.maxlength_borrower2_fname,le.maxlength_borrower2_lname,le.maxlength_borrower2_id_cd,le.maxlength_orig_lender_name,le.maxlength_orig_lender_type,le.maxlength_curr_lender_name,le.maxlength_curr_lender_type,le.maxlength_mers_indicator,le.maxlength_loan_recording_date,le.maxlength_loan_doc_num,le.maxlength_loan_book,le.maxlength_loan_page,le.maxlength_orig_loan_amt,le.maxlength_legal_lot_num,le.maxlength_legal_block,le.maxlength_legal_subdivision_name,le.maxlength_legal_brief_desc,le.maxlength_auction_date,le.maxlength_auction_time,le.maxlength_auction_location,le.maxlength_auction_min_bid_amt,le.maxlength_trustee_mail_careof,le.maxlength_property_addr_cd,le.maxlength_auction_city,le.maxlength_original_nod_recording_date,le.maxlength_original_nod_doc_num,le.maxlength_original_nod_book,le.maxlength_original_nod_page,le.maxlength_nod_apn,le.maxlength_property_full_addr,le.maxlength_prop_addr_unit_type,le.maxlength_prop_addr_unit_no,le.maxlength_prop_addr_city,le.maxlength_prop_addr_state,le.maxlength_prop_addr_zip5,le.maxlength_prop_addr_zip4,le.maxlength_apn,le.maxlength_sam_pid,le.maxlength_deed_pid,le.maxlength_lps_internal_pid,le.maxlength_nod_source);
  SELF.avelength := CHOOSE(C,le.avelength_foreclosure_id,le.avelength_ln_filedate,le.avelength_bk_infile_type,le.avelength_src_county,le.avelength_src_state,le.avelength_fips_cd,le.avelength_doc_type,le.avelength_recording_dt,le.avelength_recording_doc_num,le.avelength_book_number,le.avelength_page_number,le.avelength_loan_number,le.avelength_trustee_sale_number,le.avelength_case_number,le.avelength_orig_contract_date,le.avelength_unpaid_balance,le.avelength_past_due_amt,le.avelength_as_of_dt,le.avelength_contact_fname,le.avelength_contact_lname,le.avelength_attention_to,le.avelength_contact_mail_full_addr,le.avelength_contact_mail_unit,le.avelength_contact_mail_city,le.avelength_contact_mail_state,le.avelength_contact_mail_zip5,le.avelength_contact_mail_zip4,le.avelength_contact_telephone,le.avelength_due_date,le.avelength_trustee_fname,le.avelength_trustee_lname,le.avelength_trustee_mail_full_addr,le.avelength_trustee_mail_unit,le.avelength_trustee_mail_city,le.avelength_trustee_mail_state,le.avelength_trustee_mail_zip5,le.avelength_trustee_mail_zip4,le.avelength_trustee_telephone,le.avelength_borrower1_fname,le.avelength_borrower1_lname,le.avelength_borrower1_id_cd,le.avelength_borrower2_fname,le.avelength_borrower2_lname,le.avelength_borrower2_id_cd,le.avelength_orig_lender_name,le.avelength_orig_lender_type,le.avelength_curr_lender_name,le.avelength_curr_lender_type,le.avelength_mers_indicator,le.avelength_loan_recording_date,le.avelength_loan_doc_num,le.avelength_loan_book,le.avelength_loan_page,le.avelength_orig_loan_amt,le.avelength_legal_lot_num,le.avelength_legal_block,le.avelength_legal_subdivision_name,le.avelength_legal_brief_desc,le.avelength_auction_date,le.avelength_auction_time,le.avelength_auction_location,le.avelength_auction_min_bid_amt,le.avelength_trustee_mail_careof,le.avelength_property_addr_cd,le.avelength_auction_city,le.avelength_original_nod_recording_date,le.avelength_original_nod_doc_num,le.avelength_original_nod_book,le.avelength_original_nod_page,le.avelength_nod_apn,le.avelength_property_full_addr,le.avelength_prop_addr_unit_type,le.avelength_prop_addr_unit_no,le.avelength_prop_addr_city,le.avelength_prop_addr_state,le.avelength_prop_addr_zip5,le.avelength_prop_addr_zip4,le.avelength_apn,le.avelength_sam_pid,le.avelength_deed_pid,le.avelength_lps_internal_pid,le.avelength_nod_source);
END;
EXPORT invSummary := NORMALIZE(summary0, 82, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.foreclosure_id),TRIM((SALT311.StrType)le.ln_filedate),TRIM((SALT311.StrType)le.bk_infile_type),TRIM((SALT311.StrType)le.src_county),TRIM((SALT311.StrType)le.src_state),TRIM((SALT311.StrType)le.fips_cd),TRIM((SALT311.StrType)le.doc_type),TRIM((SALT311.StrType)le.recording_dt),TRIM((SALT311.StrType)le.recording_doc_num),TRIM((SALT311.StrType)le.book_number),TRIM((SALT311.StrType)le.page_number),TRIM((SALT311.StrType)le.loan_number),TRIM((SALT311.StrType)le.trustee_sale_number),TRIM((SALT311.StrType)le.case_number),TRIM((SALT311.StrType)le.orig_contract_date),TRIM((SALT311.StrType)le.unpaid_balance),TRIM((SALT311.StrType)le.past_due_amt),TRIM((SALT311.StrType)le.as_of_dt),TRIM((SALT311.StrType)le.contact_fname),TRIM((SALT311.StrType)le.contact_lname),TRIM((SALT311.StrType)le.attention_to),TRIM((SALT311.StrType)le.contact_mail_full_addr),TRIM((SALT311.StrType)le.contact_mail_unit),TRIM((SALT311.StrType)le.contact_mail_city),TRIM((SALT311.StrType)le.contact_mail_state),TRIM((SALT311.StrType)le.contact_mail_zip5),TRIM((SALT311.StrType)le.contact_mail_zip4),TRIM((SALT311.StrType)le.contact_telephone),TRIM((SALT311.StrType)le.due_date),TRIM((SALT311.StrType)le.trustee_fname),TRIM((SALT311.StrType)le.trustee_lname),TRIM((SALT311.StrType)le.trustee_mail_full_addr),TRIM((SALT311.StrType)le.trustee_mail_unit),TRIM((SALT311.StrType)le.trustee_mail_city),TRIM((SALT311.StrType)le.trustee_mail_state),TRIM((SALT311.StrType)le.trustee_mail_zip5),TRIM((SALT311.StrType)le.trustee_mail_zip4),TRIM((SALT311.StrType)le.trustee_telephone),TRIM((SALT311.StrType)le.borrower1_fname),TRIM((SALT311.StrType)le.borrower1_lname),TRIM((SALT311.StrType)le.borrower1_id_cd),TRIM((SALT311.StrType)le.borrower2_fname),TRIM((SALT311.StrType)le.borrower2_lname),TRIM((SALT311.StrType)le.borrower2_id_cd),TRIM((SALT311.StrType)le.orig_lender_name),TRIM((SALT311.StrType)le.orig_lender_type),TRIM((SALT311.StrType)le.curr_lender_name),TRIM((SALT311.StrType)le.curr_lender_type),TRIM((SALT311.StrType)le.mers_indicator),TRIM((SALT311.StrType)le.loan_recording_date),TRIM((SALT311.StrType)le.loan_doc_num),TRIM((SALT311.StrType)le.loan_book),TRIM((SALT311.StrType)le.loan_page),TRIM((SALT311.StrType)le.orig_loan_amt),TRIM((SALT311.StrType)le.legal_lot_num),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_subdivision_name),TRIM((SALT311.StrType)le.legal_brief_desc),TRIM((SALT311.StrType)le.auction_date),TRIM((SALT311.StrType)le.auction_time),TRIM((SALT311.StrType)le.auction_location),TRIM((SALT311.StrType)le.auction_min_bid_amt),TRIM((SALT311.StrType)le.trustee_mail_careof),TRIM((SALT311.StrType)le.property_addr_cd),TRIM((SALT311.StrType)le.auction_city),TRIM((SALT311.StrType)le.original_nod_recording_date),TRIM((SALT311.StrType)le.original_nod_doc_num),TRIM((SALT311.StrType)le.original_nod_book),TRIM((SALT311.StrType)le.original_nod_page),TRIM((SALT311.StrType)le.nod_apn),TRIM((SALT311.StrType)le.property_full_addr),TRIM((SALT311.StrType)le.prop_addr_unit_type),TRIM((SALT311.StrType)le.prop_addr_unit_no),TRIM((SALT311.StrType)le.prop_addr_city),TRIM((SALT311.StrType)le.prop_addr_state),TRIM((SALT311.StrType)le.prop_addr_zip5),TRIM((SALT311.StrType)le.prop_addr_zip4),TRIM((SALT311.StrType)le.apn),TRIM((SALT311.StrType)le.sam_pid),TRIM((SALT311.StrType)le.deed_pid),TRIM((SALT311.StrType)le.lps_internal_pid),TRIM((SALT311.StrType)le.nod_source)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,82,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 82);
  SELF.FldNo2 := 1 + (C % 82);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.foreclosure_id),TRIM((SALT311.StrType)le.ln_filedate),TRIM((SALT311.StrType)le.bk_infile_type),TRIM((SALT311.StrType)le.src_county),TRIM((SALT311.StrType)le.src_state),TRIM((SALT311.StrType)le.fips_cd),TRIM((SALT311.StrType)le.doc_type),TRIM((SALT311.StrType)le.recording_dt),TRIM((SALT311.StrType)le.recording_doc_num),TRIM((SALT311.StrType)le.book_number),TRIM((SALT311.StrType)le.page_number),TRIM((SALT311.StrType)le.loan_number),TRIM((SALT311.StrType)le.trustee_sale_number),TRIM((SALT311.StrType)le.case_number),TRIM((SALT311.StrType)le.orig_contract_date),TRIM((SALT311.StrType)le.unpaid_balance),TRIM((SALT311.StrType)le.past_due_amt),TRIM((SALT311.StrType)le.as_of_dt),TRIM((SALT311.StrType)le.contact_fname),TRIM((SALT311.StrType)le.contact_lname),TRIM((SALT311.StrType)le.attention_to),TRIM((SALT311.StrType)le.contact_mail_full_addr),TRIM((SALT311.StrType)le.contact_mail_unit),TRIM((SALT311.StrType)le.contact_mail_city),TRIM((SALT311.StrType)le.contact_mail_state),TRIM((SALT311.StrType)le.contact_mail_zip5),TRIM((SALT311.StrType)le.contact_mail_zip4),TRIM((SALT311.StrType)le.contact_telephone),TRIM((SALT311.StrType)le.due_date),TRIM((SALT311.StrType)le.trustee_fname),TRIM((SALT311.StrType)le.trustee_lname),TRIM((SALT311.StrType)le.trustee_mail_full_addr),TRIM((SALT311.StrType)le.trustee_mail_unit),TRIM((SALT311.StrType)le.trustee_mail_city),TRIM((SALT311.StrType)le.trustee_mail_state),TRIM((SALT311.StrType)le.trustee_mail_zip5),TRIM((SALT311.StrType)le.trustee_mail_zip4),TRIM((SALT311.StrType)le.trustee_telephone),TRIM((SALT311.StrType)le.borrower1_fname),TRIM((SALT311.StrType)le.borrower1_lname),TRIM((SALT311.StrType)le.borrower1_id_cd),TRIM((SALT311.StrType)le.borrower2_fname),TRIM((SALT311.StrType)le.borrower2_lname),TRIM((SALT311.StrType)le.borrower2_id_cd),TRIM((SALT311.StrType)le.orig_lender_name),TRIM((SALT311.StrType)le.orig_lender_type),TRIM((SALT311.StrType)le.curr_lender_name),TRIM((SALT311.StrType)le.curr_lender_type),TRIM((SALT311.StrType)le.mers_indicator),TRIM((SALT311.StrType)le.loan_recording_date),TRIM((SALT311.StrType)le.loan_doc_num),TRIM((SALT311.StrType)le.loan_book),TRIM((SALT311.StrType)le.loan_page),TRIM((SALT311.StrType)le.orig_loan_amt),TRIM((SALT311.StrType)le.legal_lot_num),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_subdivision_name),TRIM((SALT311.StrType)le.legal_brief_desc),TRIM((SALT311.StrType)le.auction_date),TRIM((SALT311.StrType)le.auction_time),TRIM((SALT311.StrType)le.auction_location),TRIM((SALT311.StrType)le.auction_min_bid_amt),TRIM((SALT311.StrType)le.trustee_mail_careof),TRIM((SALT311.StrType)le.property_addr_cd),TRIM((SALT311.StrType)le.auction_city),TRIM((SALT311.StrType)le.original_nod_recording_date),TRIM((SALT311.StrType)le.original_nod_doc_num),TRIM((SALT311.StrType)le.original_nod_book),TRIM((SALT311.StrType)le.original_nod_page),TRIM((SALT311.StrType)le.nod_apn),TRIM((SALT311.StrType)le.property_full_addr),TRIM((SALT311.StrType)le.prop_addr_unit_type),TRIM((SALT311.StrType)le.prop_addr_unit_no),TRIM((SALT311.StrType)le.prop_addr_city),TRIM((SALT311.StrType)le.prop_addr_state),TRIM((SALT311.StrType)le.prop_addr_zip5),TRIM((SALT311.StrType)le.prop_addr_zip4),TRIM((SALT311.StrType)le.apn),TRIM((SALT311.StrType)le.sam_pid),TRIM((SALT311.StrType)le.deed_pid),TRIM((SALT311.StrType)le.lps_internal_pid),TRIM((SALT311.StrType)le.nod_source)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.foreclosure_id),TRIM((SALT311.StrType)le.ln_filedate),TRIM((SALT311.StrType)le.bk_infile_type),TRIM((SALT311.StrType)le.src_county),TRIM((SALT311.StrType)le.src_state),TRIM((SALT311.StrType)le.fips_cd),TRIM((SALT311.StrType)le.doc_type),TRIM((SALT311.StrType)le.recording_dt),TRIM((SALT311.StrType)le.recording_doc_num),TRIM((SALT311.StrType)le.book_number),TRIM((SALT311.StrType)le.page_number),TRIM((SALT311.StrType)le.loan_number),TRIM((SALT311.StrType)le.trustee_sale_number),TRIM((SALT311.StrType)le.case_number),TRIM((SALT311.StrType)le.orig_contract_date),TRIM((SALT311.StrType)le.unpaid_balance),TRIM((SALT311.StrType)le.past_due_amt),TRIM((SALT311.StrType)le.as_of_dt),TRIM((SALT311.StrType)le.contact_fname),TRIM((SALT311.StrType)le.contact_lname),TRIM((SALT311.StrType)le.attention_to),TRIM((SALT311.StrType)le.contact_mail_full_addr),TRIM((SALT311.StrType)le.contact_mail_unit),TRIM((SALT311.StrType)le.contact_mail_city),TRIM((SALT311.StrType)le.contact_mail_state),TRIM((SALT311.StrType)le.contact_mail_zip5),TRIM((SALT311.StrType)le.contact_mail_zip4),TRIM((SALT311.StrType)le.contact_telephone),TRIM((SALT311.StrType)le.due_date),TRIM((SALT311.StrType)le.trustee_fname),TRIM((SALT311.StrType)le.trustee_lname),TRIM((SALT311.StrType)le.trustee_mail_full_addr),TRIM((SALT311.StrType)le.trustee_mail_unit),TRIM((SALT311.StrType)le.trustee_mail_city),TRIM((SALT311.StrType)le.trustee_mail_state),TRIM((SALT311.StrType)le.trustee_mail_zip5),TRIM((SALT311.StrType)le.trustee_mail_zip4),TRIM((SALT311.StrType)le.trustee_telephone),TRIM((SALT311.StrType)le.borrower1_fname),TRIM((SALT311.StrType)le.borrower1_lname),TRIM((SALT311.StrType)le.borrower1_id_cd),TRIM((SALT311.StrType)le.borrower2_fname),TRIM((SALT311.StrType)le.borrower2_lname),TRIM((SALT311.StrType)le.borrower2_id_cd),TRIM((SALT311.StrType)le.orig_lender_name),TRIM((SALT311.StrType)le.orig_lender_type),TRIM((SALT311.StrType)le.curr_lender_name),TRIM((SALT311.StrType)le.curr_lender_type),TRIM((SALT311.StrType)le.mers_indicator),TRIM((SALT311.StrType)le.loan_recording_date),TRIM((SALT311.StrType)le.loan_doc_num),TRIM((SALT311.StrType)le.loan_book),TRIM((SALT311.StrType)le.loan_page),TRIM((SALT311.StrType)le.orig_loan_amt),TRIM((SALT311.StrType)le.legal_lot_num),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_subdivision_name),TRIM((SALT311.StrType)le.legal_brief_desc),TRIM((SALT311.StrType)le.auction_date),TRIM((SALT311.StrType)le.auction_time),TRIM((SALT311.StrType)le.auction_location),TRIM((SALT311.StrType)le.auction_min_bid_amt),TRIM((SALT311.StrType)le.trustee_mail_careof),TRIM((SALT311.StrType)le.property_addr_cd),TRIM((SALT311.StrType)le.auction_city),TRIM((SALT311.StrType)le.original_nod_recording_date),TRIM((SALT311.StrType)le.original_nod_doc_num),TRIM((SALT311.StrType)le.original_nod_book),TRIM((SALT311.StrType)le.original_nod_page),TRIM((SALT311.StrType)le.nod_apn),TRIM((SALT311.StrType)le.property_full_addr),TRIM((SALT311.StrType)le.prop_addr_unit_type),TRIM((SALT311.StrType)le.prop_addr_unit_no),TRIM((SALT311.StrType)le.prop_addr_city),TRIM((SALT311.StrType)le.prop_addr_state),TRIM((SALT311.StrType)le.prop_addr_zip5),TRIM((SALT311.StrType)le.prop_addr_zip4),TRIM((SALT311.StrType)le.apn),TRIM((SALT311.StrType)le.sam_pid),TRIM((SALT311.StrType)le.deed_pid),TRIM((SALT311.StrType)le.lps_internal_pid),TRIM((SALT311.StrType)le.nod_source)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),82*82,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'foreclosure_id'}
      ,{2,'ln_filedate'}
      ,{3,'bk_infile_type'}
      ,{4,'src_county'}
      ,{5,'src_state'}
      ,{6,'fips_cd'}
      ,{7,'doc_type'}
      ,{8,'recording_dt'}
      ,{9,'recording_doc_num'}
      ,{10,'book_number'}
      ,{11,'page_number'}
      ,{12,'loan_number'}
      ,{13,'trustee_sale_number'}
      ,{14,'case_number'}
      ,{15,'orig_contract_date'}
      ,{16,'unpaid_balance'}
      ,{17,'past_due_amt'}
      ,{18,'as_of_dt'}
      ,{19,'contact_fname'}
      ,{20,'contact_lname'}
      ,{21,'attention_to'}
      ,{22,'contact_mail_full_addr'}
      ,{23,'contact_mail_unit'}
      ,{24,'contact_mail_city'}
      ,{25,'contact_mail_state'}
      ,{26,'contact_mail_zip5'}
      ,{27,'contact_mail_zip4'}
      ,{28,'contact_telephone'}
      ,{29,'due_date'}
      ,{30,'trustee_fname'}
      ,{31,'trustee_lname'}
      ,{32,'trustee_mail_full_addr'}
      ,{33,'trustee_mail_unit'}
      ,{34,'trustee_mail_city'}
      ,{35,'trustee_mail_state'}
      ,{36,'trustee_mail_zip5'}
      ,{37,'trustee_mail_zip4'}
      ,{38,'trustee_telephone'}
      ,{39,'borrower1_fname'}
      ,{40,'borrower1_lname'}
      ,{41,'borrower1_id_cd'}
      ,{42,'borrower2_fname'}
      ,{43,'borrower2_lname'}
      ,{44,'borrower2_id_cd'}
      ,{45,'orig_lender_name'}
      ,{46,'orig_lender_type'}
      ,{47,'curr_lender_name'}
      ,{48,'curr_lender_type'}
      ,{49,'mers_indicator'}
      ,{50,'loan_recording_date'}
      ,{51,'loan_doc_num'}
      ,{52,'loan_book'}
      ,{53,'loan_page'}
      ,{54,'orig_loan_amt'}
      ,{55,'legal_lot_num'}
      ,{56,'legal_block'}
      ,{57,'legal_subdivision_name'}
      ,{58,'legal_brief_desc'}
      ,{59,'auction_date'}
      ,{60,'auction_time'}
      ,{61,'auction_location'}
      ,{62,'auction_min_bid_amt'}
      ,{63,'trustee_mail_careof'}
      ,{64,'property_addr_cd'}
      ,{65,'auction_city'}
      ,{66,'original_nod_recording_date'}
      ,{67,'original_nod_doc_num'}
      ,{68,'original_nod_book'}
      ,{69,'original_nod_page'}
      ,{70,'nod_apn'}
      ,{71,'property_full_addr'}
      ,{72,'prop_addr_unit_type'}
      ,{73,'prop_addr_unit_no'}
      ,{74,'prop_addr_city'}
      ,{75,'prop_addr_state'}
      ,{76,'prop_addr_zip5'}
      ,{77,'prop_addr_zip4'}
      ,{78,'apn'}
      ,{79,'sam_pid'}
      ,{80,'deed_pid'}
      ,{81,'lps_internal_pid'}
      ,{82,'nod_source'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_foreclosure_id((SALT311.StrType)le.foreclosure_id),
    Fields.InValid_ln_filedate((SALT311.StrType)le.ln_filedate),
    Fields.InValid_bk_infile_type((SALT311.StrType)le.bk_infile_type),
    Fields.InValid_src_county((SALT311.StrType)le.src_county),
    Fields.InValid_src_state((SALT311.StrType)le.src_state),
    Fields.InValid_fips_cd((SALT311.StrType)le.fips_cd),
    Fields.InValid_doc_type((SALT311.StrType)le.doc_type),
    Fields.InValid_recording_dt((SALT311.StrType)le.recording_dt),
    Fields.InValid_recording_doc_num((SALT311.StrType)le.recording_doc_num),
    Fields.InValid_book_number((SALT311.StrType)le.book_number),
    Fields.InValid_page_number((SALT311.StrType)le.page_number),
    Fields.InValid_loan_number((SALT311.StrType)le.loan_number),
    Fields.InValid_trustee_sale_number((SALT311.StrType)le.trustee_sale_number),
    Fields.InValid_case_number((SALT311.StrType)le.case_number),
    Fields.InValid_orig_contract_date((SALT311.StrType)le.orig_contract_date),
    Fields.InValid_unpaid_balance((SALT311.StrType)le.unpaid_balance),
    Fields.InValid_past_due_amt((SALT311.StrType)le.past_due_amt),
    Fields.InValid_as_of_dt((SALT311.StrType)le.as_of_dt),
    Fields.InValid_contact_fname((SALT311.StrType)le.contact_fname),
    Fields.InValid_contact_lname((SALT311.StrType)le.contact_lname),
    Fields.InValid_attention_to((SALT311.StrType)le.attention_to),
    Fields.InValid_contact_mail_full_addr((SALT311.StrType)le.contact_mail_full_addr),
    Fields.InValid_contact_mail_unit((SALT311.StrType)le.contact_mail_unit),
    Fields.InValid_contact_mail_city((SALT311.StrType)le.contact_mail_city),
    Fields.InValid_contact_mail_state((SALT311.StrType)le.contact_mail_state),
    Fields.InValid_contact_mail_zip5((SALT311.StrType)le.contact_mail_zip5),
    Fields.InValid_contact_mail_zip4((SALT311.StrType)le.contact_mail_zip4),
    Fields.InValid_contact_telephone((SALT311.StrType)le.contact_telephone),
    Fields.InValid_due_date((SALT311.StrType)le.due_date),
    Fields.InValid_trustee_fname((SALT311.StrType)le.trustee_fname),
    Fields.InValid_trustee_lname((SALT311.StrType)le.trustee_lname),
    Fields.InValid_trustee_mail_full_addr((SALT311.StrType)le.trustee_mail_full_addr),
    Fields.InValid_trustee_mail_unit((SALT311.StrType)le.trustee_mail_unit),
    Fields.InValid_trustee_mail_city((SALT311.StrType)le.trustee_mail_city),
    Fields.InValid_trustee_mail_state((SALT311.StrType)le.trustee_mail_state),
    Fields.InValid_trustee_mail_zip5((SALT311.StrType)le.trustee_mail_zip5),
    Fields.InValid_trustee_mail_zip4((SALT311.StrType)le.trustee_mail_zip4),
    Fields.InValid_trustee_telephone((SALT311.StrType)le.trustee_telephone),
    Fields.InValid_borrower1_fname((SALT311.StrType)le.borrower1_fname),
    Fields.InValid_borrower1_lname((SALT311.StrType)le.borrower1_lname),
    Fields.InValid_borrower1_id_cd((SALT311.StrType)le.borrower1_id_cd),
    Fields.InValid_borrower2_fname((SALT311.StrType)le.borrower2_fname),
    Fields.InValid_borrower2_lname((SALT311.StrType)le.borrower2_lname),
    Fields.InValid_borrower2_id_cd((SALT311.StrType)le.borrower2_id_cd),
    Fields.InValid_orig_lender_name((SALT311.StrType)le.orig_lender_name),
    Fields.InValid_orig_lender_type((SALT311.StrType)le.orig_lender_type),
    Fields.InValid_curr_lender_name((SALT311.StrType)le.curr_lender_name),
    Fields.InValid_curr_lender_type((SALT311.StrType)le.curr_lender_type),
    Fields.InValid_mers_indicator((SALT311.StrType)le.mers_indicator),
    Fields.InValid_loan_recording_date((SALT311.StrType)le.loan_recording_date),
    Fields.InValid_loan_doc_num((SALT311.StrType)le.loan_doc_num),
    Fields.InValid_loan_book((SALT311.StrType)le.loan_book),
    Fields.InValid_loan_page((SALT311.StrType)le.loan_page),
    Fields.InValid_orig_loan_amt((SALT311.StrType)le.orig_loan_amt),
    Fields.InValid_legal_lot_num((SALT311.StrType)le.legal_lot_num),
    Fields.InValid_legal_block((SALT311.StrType)le.legal_block),
    Fields.InValid_legal_subdivision_name((SALT311.StrType)le.legal_subdivision_name),
    Fields.InValid_legal_brief_desc((SALT311.StrType)le.legal_brief_desc),
    Fields.InValid_auction_date((SALT311.StrType)le.auction_date),
    Fields.InValid_auction_time((SALT311.StrType)le.auction_time),
    Fields.InValid_auction_location((SALT311.StrType)le.auction_location),
    Fields.InValid_auction_min_bid_amt((SALT311.StrType)le.auction_min_bid_amt),
    Fields.InValid_trustee_mail_careof((SALT311.StrType)le.trustee_mail_careof),
    Fields.InValid_property_addr_cd((SALT311.StrType)le.property_addr_cd),
    Fields.InValid_auction_city((SALT311.StrType)le.auction_city),
    Fields.InValid_original_nod_recording_date((SALT311.StrType)le.original_nod_recording_date),
    Fields.InValid_original_nod_doc_num((SALT311.StrType)le.original_nod_doc_num),
    Fields.InValid_original_nod_book((SALT311.StrType)le.original_nod_book),
    Fields.InValid_original_nod_page((SALT311.StrType)le.original_nod_page),
    Fields.InValid_nod_apn((SALT311.StrType)le.nod_apn),
    Fields.InValid_property_full_addr((SALT311.StrType)le.property_full_addr),
    Fields.InValid_prop_addr_unit_type((SALT311.StrType)le.prop_addr_unit_type),
    Fields.InValid_prop_addr_unit_no((SALT311.StrType)le.prop_addr_unit_no),
    Fields.InValid_prop_addr_city((SALT311.StrType)le.prop_addr_city),
    Fields.InValid_prop_addr_state((SALT311.StrType)le.prop_addr_state),
    Fields.InValid_prop_addr_zip5((SALT311.StrType)le.prop_addr_zip5),
    Fields.InValid_prop_addr_zip4((SALT311.StrType)le.prop_addr_zip4),
    Fields.InValid_apn((SALT311.StrType)le.apn),
    Fields.InValid_sam_pid((SALT311.StrType)le.sam_pid),
    Fields.InValid_deed_pid((SALT311.StrType)le.deed_pid),
    Fields.InValid_lps_internal_pid((SALT311.StrType)le.lps_internal_pid),
    Fields.InValid_nod_source((SALT311.StrType)le.nod_source),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,82,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','invalid_date','Unknown','Unknown','invalid_state','invalid_number','invalid_document_code','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_case','invalid_date','Unknown','Unknown','invalid_date','invalid_name','invalid_name','Unknown','invalid_alpha','Unknown','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','Unknown','invalid_date','invalid_name','invalid_name','invalid_alpha','Unknown','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','Unknown','invalid_name','invalid_name','Unknown','invalid_name','invalid_name','Unknown','invalid_name','Unknown','Unknown','Unknown','invalid_mers','invalid_date','Unknown','Unknown','Unknown','invalid_amount','Unknown','Unknown','invalid_name','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','invalid_apn','invalid_alpha','Unknown','Unknown','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','invalid_apn','Unknown','Unknown','Unknown','Invalid_NodSourceCode');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_foreclosure_id(TotalErrors.ErrorNum),Fields.InValidMessage_ln_filedate(TotalErrors.ErrorNum),Fields.InValidMessage_bk_infile_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_county(TotalErrors.ErrorNum),Fields.InValidMessage_src_state(TotalErrors.ErrorNum),Fields.InValidMessage_fips_cd(TotalErrors.ErrorNum),Fields.InValidMessage_doc_type(TotalErrors.ErrorNum),Fields.InValidMessage_recording_dt(TotalErrors.ErrorNum),Fields.InValidMessage_recording_doc_num(TotalErrors.ErrorNum),Fields.InValidMessage_book_number(TotalErrors.ErrorNum),Fields.InValidMessage_page_number(TotalErrors.ErrorNum),Fields.InValidMessage_loan_number(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_sale_number(TotalErrors.ErrorNum),Fields.InValidMessage_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_contract_date(TotalErrors.ErrorNum),Fields.InValidMessage_unpaid_balance(TotalErrors.ErrorNum),Fields.InValidMessage_past_due_amt(TotalErrors.ErrorNum),Fields.InValidMessage_as_of_dt(TotalErrors.ErrorNum),Fields.InValidMessage_contact_fname(TotalErrors.ErrorNum),Fields.InValidMessage_contact_lname(TotalErrors.ErrorNum),Fields.InValidMessage_attention_to(TotalErrors.ErrorNum),Fields.InValidMessage_contact_mail_full_addr(TotalErrors.ErrorNum),Fields.InValidMessage_contact_mail_unit(TotalErrors.ErrorNum),Fields.InValidMessage_contact_mail_city(TotalErrors.ErrorNum),Fields.InValidMessage_contact_mail_state(TotalErrors.ErrorNum),Fields.InValidMessage_contact_mail_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_contact_mail_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_contact_telephone(TotalErrors.ErrorNum),Fields.InValidMessage_due_date(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_fname(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_lname(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_mail_full_addr(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_mail_unit(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_mail_city(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_mail_state(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_mail_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_mail_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_telephone(TotalErrors.ErrorNum),Fields.InValidMessage_borrower1_fname(TotalErrors.ErrorNum),Fields.InValidMessage_borrower1_lname(TotalErrors.ErrorNum),Fields.InValidMessage_borrower1_id_cd(TotalErrors.ErrorNum),Fields.InValidMessage_borrower2_fname(TotalErrors.ErrorNum),Fields.InValidMessage_borrower2_lname(TotalErrors.ErrorNum),Fields.InValidMessage_borrower2_id_cd(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lender_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lender_type(TotalErrors.ErrorNum),Fields.InValidMessage_curr_lender_name(TotalErrors.ErrorNum),Fields.InValidMessage_curr_lender_type(TotalErrors.ErrorNum),Fields.InValidMessage_mers_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_loan_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_loan_doc_num(TotalErrors.ErrorNum),Fields.InValidMessage_loan_book(TotalErrors.ErrorNum),Fields.InValidMessage_loan_page(TotalErrors.ErrorNum),Fields.InValidMessage_orig_loan_amt(TotalErrors.ErrorNum),Fields.InValidMessage_legal_lot_num(TotalErrors.ErrorNum),Fields.InValidMessage_legal_block(TotalErrors.ErrorNum),Fields.InValidMessage_legal_subdivision_name(TotalErrors.ErrorNum),Fields.InValidMessage_legal_brief_desc(TotalErrors.ErrorNum),Fields.InValidMessage_auction_date(TotalErrors.ErrorNum),Fields.InValidMessage_auction_time(TotalErrors.ErrorNum),Fields.InValidMessage_auction_location(TotalErrors.ErrorNum),Fields.InValidMessage_auction_min_bid_amt(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_mail_careof(TotalErrors.ErrorNum),Fields.InValidMessage_property_addr_cd(TotalErrors.ErrorNum),Fields.InValidMessage_auction_city(TotalErrors.ErrorNum),Fields.InValidMessage_original_nod_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_original_nod_doc_num(TotalErrors.ErrorNum),Fields.InValidMessage_original_nod_book(TotalErrors.ErrorNum),Fields.InValidMessage_original_nod_page(TotalErrors.ErrorNum),Fields.InValidMessage_nod_apn(TotalErrors.ErrorNum),Fields.InValidMessage_property_full_addr(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_unit_type(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_unit_no(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_city(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_state(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_apn(TotalErrors.ErrorNum),Fields.InValidMessage_sam_pid(TotalErrors.ErrorNum),Fields.InValidMessage_deed_pid(TotalErrors.ErrorNum),Fields.InValidMessage_lps_internal_pid(TotalErrors.ErrorNum),Fields.InValidMessage_nod_source(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BKForeclosure_Nod, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
