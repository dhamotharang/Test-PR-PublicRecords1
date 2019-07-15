IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_BKForeclosure_Reo) h) := MODULE
 
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
    populated_fips_cd_cnt := COUNT(GROUP,h.fips_cd <> (TYPEOF(h.fips_cd))'');
    populated_fips_cd_pcnt := AVE(GROUP,IF(h.fips_cd = (TYPEOF(h.fips_cd))'',0,100));
    maxlength_fips_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_cd)));
    avelength_fips_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_cd)),h.fips_cd<>(typeof(h.fips_cd))'');
    populated_prop_full_addr_cnt := COUNT(GROUP,h.prop_full_addr <> (TYPEOF(h.prop_full_addr))'');
    populated_prop_full_addr_pcnt := AVE(GROUP,IF(h.prop_full_addr = (TYPEOF(h.prop_full_addr))'',0,100));
    maxlength_prop_full_addr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_full_addr)));
    avelength_prop_full_addr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_full_addr)),h.prop_full_addr<>(typeof(h.prop_full_addr))'');
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
    populated_prop_addr_unit_type_cnt := COUNT(GROUP,h.prop_addr_unit_type <> (TYPEOF(h.prop_addr_unit_type))'');
    populated_prop_addr_unit_type_pcnt := AVE(GROUP,IF(h.prop_addr_unit_type = (TYPEOF(h.prop_addr_unit_type))'',0,100));
    maxlength_prop_addr_unit_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_unit_type)));
    avelength_prop_addr_unit_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_unit_type)),h.prop_addr_unit_type<>(typeof(h.prop_addr_unit_type))'');
    populated_prop_addr_unit_no_cnt := COUNT(GROUP,h.prop_addr_unit_no <> (TYPEOF(h.prop_addr_unit_no))'');
    populated_prop_addr_unit_no_pcnt := AVE(GROUP,IF(h.prop_addr_unit_no = (TYPEOF(h.prop_addr_unit_no))'',0,100));
    maxlength_prop_addr_unit_no := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_unit_no)));
    avelength_prop_addr_unit_no := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_unit_no)),h.prop_addr_unit_no<>(typeof(h.prop_addr_unit_no))'');
    populated_prop_addr_house_no_cnt := COUNT(GROUP,h.prop_addr_house_no <> (TYPEOF(h.prop_addr_house_no))'');
    populated_prop_addr_house_no_pcnt := AVE(GROUP,IF(h.prop_addr_house_no = (TYPEOF(h.prop_addr_house_no))'',0,100));
    maxlength_prop_addr_house_no := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_house_no)));
    avelength_prop_addr_house_no := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_house_no)),h.prop_addr_house_no<>(typeof(h.prop_addr_house_no))'');
    populated_prop_addr_predir_cnt := COUNT(GROUP,h.prop_addr_predir <> (TYPEOF(h.prop_addr_predir))'');
    populated_prop_addr_predir_pcnt := AVE(GROUP,IF(h.prop_addr_predir = (TYPEOF(h.prop_addr_predir))'',0,100));
    maxlength_prop_addr_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_predir)));
    avelength_prop_addr_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_predir)),h.prop_addr_predir<>(typeof(h.prop_addr_predir))'');
    populated_prop_addr_street_cnt := COUNT(GROUP,h.prop_addr_street <> (TYPEOF(h.prop_addr_street))'');
    populated_prop_addr_street_pcnt := AVE(GROUP,IF(h.prop_addr_street = (TYPEOF(h.prop_addr_street))'',0,100));
    maxlength_prop_addr_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_street)));
    avelength_prop_addr_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_street)),h.prop_addr_street<>(typeof(h.prop_addr_street))'');
    populated_prop_addr_suffix_cnt := COUNT(GROUP,h.prop_addr_suffix <> (TYPEOF(h.prop_addr_suffix))'');
    populated_prop_addr_suffix_pcnt := AVE(GROUP,IF(h.prop_addr_suffix = (TYPEOF(h.prop_addr_suffix))'',0,100));
    maxlength_prop_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_suffix)));
    avelength_prop_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_suffix)),h.prop_addr_suffix<>(typeof(h.prop_addr_suffix))'');
    populated_prop_addr_postdir_cnt := COUNT(GROUP,h.prop_addr_postdir <> (TYPEOF(h.prop_addr_postdir))'');
    populated_prop_addr_postdir_pcnt := AVE(GROUP,IF(h.prop_addr_postdir = (TYPEOF(h.prop_addr_postdir))'',0,100));
    maxlength_prop_addr_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_postdir)));
    avelength_prop_addr_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_postdir)),h.prop_addr_postdir<>(typeof(h.prop_addr_postdir))'');
    populated_prop_addr_carrier_rt_cnt := COUNT(GROUP,h.prop_addr_carrier_rt <> (TYPEOF(h.prop_addr_carrier_rt))'');
    populated_prop_addr_carrier_rt_pcnt := AVE(GROUP,IF(h.prop_addr_carrier_rt = (TYPEOF(h.prop_addr_carrier_rt))'',0,100));
    maxlength_prop_addr_carrier_rt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_carrier_rt)));
    avelength_prop_addr_carrier_rt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_carrier_rt)),h.prop_addr_carrier_rt<>(typeof(h.prop_addr_carrier_rt))'');
    populated_recording_date_cnt := COUNT(GROUP,h.recording_date <> (TYPEOF(h.recording_date))'');
    populated_recording_date_pcnt := AVE(GROUP,IF(h.recording_date = (TYPEOF(h.recording_date))'',0,100));
    maxlength_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_date)));
    avelength_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_date)),h.recording_date<>(typeof(h.recording_date))'');
    populated_recording_book_num_cnt := COUNT(GROUP,h.recording_book_num <> (TYPEOF(h.recording_book_num))'');
    populated_recording_book_num_pcnt := AVE(GROUP,IF(h.recording_book_num = (TYPEOF(h.recording_book_num))'',0,100));
    maxlength_recording_book_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_book_num)));
    avelength_recording_book_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_book_num)),h.recording_book_num<>(typeof(h.recording_book_num))'');
    populated_recording_page_num_cnt := COUNT(GROUP,h.recording_page_num <> (TYPEOF(h.recording_page_num))'');
    populated_recording_page_num_pcnt := AVE(GROUP,IF(h.recording_page_num = (TYPEOF(h.recording_page_num))'',0,100));
    maxlength_recording_page_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_page_num)));
    avelength_recording_page_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_page_num)),h.recording_page_num<>(typeof(h.recording_page_num))'');
    populated_recording_doc_num_cnt := COUNT(GROUP,h.recording_doc_num <> (TYPEOF(h.recording_doc_num))'');
    populated_recording_doc_num_pcnt := AVE(GROUP,IF(h.recording_doc_num = (TYPEOF(h.recording_doc_num))'',0,100));
    maxlength_recording_doc_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_doc_num)));
    avelength_recording_doc_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_doc_num)),h.recording_doc_num<>(typeof(h.recording_doc_num))'');
    populated_doc_type_cd_cnt := COUNT(GROUP,h.doc_type_cd <> (TYPEOF(h.doc_type_cd))'');
    populated_doc_type_cd_pcnt := AVE(GROUP,IF(h.doc_type_cd = (TYPEOF(h.doc_type_cd))'',0,100));
    maxlength_doc_type_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_type_cd)));
    avelength_doc_type_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_type_cd)),h.doc_type_cd<>(typeof(h.doc_type_cd))'');
    populated_apn_cnt := COUNT(GROUP,h.apn <> (TYPEOF(h.apn))'');
    populated_apn_pcnt := AVE(GROUP,IF(h.apn = (TYPEOF(h.apn))'',0,100));
    maxlength_apn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apn)));
    avelength_apn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apn)),h.apn<>(typeof(h.apn))'');
    populated_multi_apn_cnt := COUNT(GROUP,h.multi_apn <> (TYPEOF(h.multi_apn))'');
    populated_multi_apn_pcnt := AVE(GROUP,IF(h.multi_apn = (TYPEOF(h.multi_apn))'',0,100));
    maxlength_multi_apn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.multi_apn)));
    avelength_multi_apn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.multi_apn)),h.multi_apn<>(typeof(h.multi_apn))'');
    populated_partial_interest_trans_cnt := COUNT(GROUP,h.partial_interest_trans <> (TYPEOF(h.partial_interest_trans))'');
    populated_partial_interest_trans_pcnt := AVE(GROUP,IF(h.partial_interest_trans = (TYPEOF(h.partial_interest_trans))'',0,100));
    maxlength_partial_interest_trans := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.partial_interest_trans)));
    avelength_partial_interest_trans := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.partial_interest_trans)),h.partial_interest_trans<>(typeof(h.partial_interest_trans))'');
    populated_seller1_fname_cnt := COUNT(GROUP,h.seller1_fname <> (TYPEOF(h.seller1_fname))'');
    populated_seller1_fname_pcnt := AVE(GROUP,IF(h.seller1_fname = (TYPEOF(h.seller1_fname))'',0,100));
    maxlength_seller1_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller1_fname)));
    avelength_seller1_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller1_fname)),h.seller1_fname<>(typeof(h.seller1_fname))'');
    populated_seller1_lname_cnt := COUNT(GROUP,h.seller1_lname <> (TYPEOF(h.seller1_lname))'');
    populated_seller1_lname_pcnt := AVE(GROUP,IF(h.seller1_lname = (TYPEOF(h.seller1_lname))'',0,100));
    maxlength_seller1_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller1_lname)));
    avelength_seller1_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller1_lname)),h.seller1_lname<>(typeof(h.seller1_lname))'');
    populated_seller1_id_cnt := COUNT(GROUP,h.seller1_id <> (TYPEOF(h.seller1_id))'');
    populated_seller1_id_pcnt := AVE(GROUP,IF(h.seller1_id = (TYPEOF(h.seller1_id))'',0,100));
    maxlength_seller1_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller1_id)));
    avelength_seller1_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller1_id)),h.seller1_id<>(typeof(h.seller1_id))'');
    populated_seller2_fname_cnt := COUNT(GROUP,h.seller2_fname <> (TYPEOF(h.seller2_fname))'');
    populated_seller2_fname_pcnt := AVE(GROUP,IF(h.seller2_fname = (TYPEOF(h.seller2_fname))'',0,100));
    maxlength_seller2_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller2_fname)));
    avelength_seller2_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller2_fname)),h.seller2_fname<>(typeof(h.seller2_fname))'');
    populated_seller2_lname_cnt := COUNT(GROUP,h.seller2_lname <> (TYPEOF(h.seller2_lname))'');
    populated_seller2_lname_pcnt := AVE(GROUP,IF(h.seller2_lname = (TYPEOF(h.seller2_lname))'',0,100));
    maxlength_seller2_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller2_lname)));
    avelength_seller2_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seller2_lname)),h.seller2_lname<>(typeof(h.seller2_lname))'');
    populated_buyer1_fname_cnt := COUNT(GROUP,h.buyer1_fname <> (TYPEOF(h.buyer1_fname))'');
    populated_buyer1_fname_pcnt := AVE(GROUP,IF(h.buyer1_fname = (TYPEOF(h.buyer1_fname))'',0,100));
    maxlength_buyer1_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer1_fname)));
    avelength_buyer1_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer1_fname)),h.buyer1_fname<>(typeof(h.buyer1_fname))'');
    populated_buyer1_lname_cnt := COUNT(GROUP,h.buyer1_lname <> (TYPEOF(h.buyer1_lname))'');
    populated_buyer1_lname_pcnt := AVE(GROUP,IF(h.buyer1_lname = (TYPEOF(h.buyer1_lname))'',0,100));
    maxlength_buyer1_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer1_lname)));
    avelength_buyer1_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer1_lname)),h.buyer1_lname<>(typeof(h.buyer1_lname))'');
    populated_buyer1_id_cd_cnt := COUNT(GROUP,h.buyer1_id_cd <> (TYPEOF(h.buyer1_id_cd))'');
    populated_buyer1_id_cd_pcnt := AVE(GROUP,IF(h.buyer1_id_cd = (TYPEOF(h.buyer1_id_cd))'',0,100));
    maxlength_buyer1_id_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer1_id_cd)));
    avelength_buyer1_id_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer1_id_cd)),h.buyer1_id_cd<>(typeof(h.buyer1_id_cd))'');
    populated_buyer2_fname_cnt := COUNT(GROUP,h.buyer2_fname <> (TYPEOF(h.buyer2_fname))'');
    populated_buyer2_fname_pcnt := AVE(GROUP,IF(h.buyer2_fname = (TYPEOF(h.buyer2_fname))'',0,100));
    maxlength_buyer2_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer2_fname)));
    avelength_buyer2_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer2_fname)),h.buyer2_fname<>(typeof(h.buyer2_fname))'');
    populated_buyer2_lname_cnt := COUNT(GROUP,h.buyer2_lname <> (TYPEOF(h.buyer2_lname))'');
    populated_buyer2_lname_pcnt := AVE(GROUP,IF(h.buyer2_lname = (TYPEOF(h.buyer2_lname))'',0,100));
    maxlength_buyer2_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer2_lname)));
    avelength_buyer2_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer2_lname)),h.buyer2_lname<>(typeof(h.buyer2_lname))'');
    populated_buyer_vesting_cd_cnt := COUNT(GROUP,h.buyer_vesting_cd <> (TYPEOF(h.buyer_vesting_cd))'');
    populated_buyer_vesting_cd_pcnt := AVE(GROUP,IF(h.buyer_vesting_cd = (TYPEOF(h.buyer_vesting_cd))'',0,100));
    maxlength_buyer_vesting_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_vesting_cd)));
    avelength_buyer_vesting_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_vesting_cd)),h.buyer_vesting_cd<>(typeof(h.buyer_vesting_cd))'');
    populated_concurrent_doc_num_cnt := COUNT(GROUP,h.concurrent_doc_num <> (TYPEOF(h.concurrent_doc_num))'');
    populated_concurrent_doc_num_pcnt := AVE(GROUP,IF(h.concurrent_doc_num = (TYPEOF(h.concurrent_doc_num))'',0,100));
    maxlength_concurrent_doc_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_doc_num)));
    avelength_concurrent_doc_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_doc_num)),h.concurrent_doc_num<>(typeof(h.concurrent_doc_num))'');
    populated_buyer_mail_city_cnt := COUNT(GROUP,h.buyer_mail_city <> (TYPEOF(h.buyer_mail_city))'');
    populated_buyer_mail_city_pcnt := AVE(GROUP,IF(h.buyer_mail_city = (TYPEOF(h.buyer_mail_city))'',0,100));
    maxlength_buyer_mail_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_city)));
    avelength_buyer_mail_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_city)),h.buyer_mail_city<>(typeof(h.buyer_mail_city))'');
    populated_buyer_mail_state_cnt := COUNT(GROUP,h.buyer_mail_state <> (TYPEOF(h.buyer_mail_state))'');
    populated_buyer_mail_state_pcnt := AVE(GROUP,IF(h.buyer_mail_state = (TYPEOF(h.buyer_mail_state))'',0,100));
    maxlength_buyer_mail_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_state)));
    avelength_buyer_mail_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_state)),h.buyer_mail_state<>(typeof(h.buyer_mail_state))'');
    populated_buyer_mail_zip5_cnt := COUNT(GROUP,h.buyer_mail_zip5 <> (TYPEOF(h.buyer_mail_zip5))'');
    populated_buyer_mail_zip5_pcnt := AVE(GROUP,IF(h.buyer_mail_zip5 = (TYPEOF(h.buyer_mail_zip5))'',0,100));
    maxlength_buyer_mail_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_zip5)));
    avelength_buyer_mail_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_zip5)),h.buyer_mail_zip5<>(typeof(h.buyer_mail_zip5))'');
    populated_buyer_mail_zip4_cnt := COUNT(GROUP,h.buyer_mail_zip4 <> (TYPEOF(h.buyer_mail_zip4))'');
    populated_buyer_mail_zip4_pcnt := AVE(GROUP,IF(h.buyer_mail_zip4 = (TYPEOF(h.buyer_mail_zip4))'',0,100));
    maxlength_buyer_mail_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_zip4)));
    avelength_buyer_mail_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_zip4)),h.buyer_mail_zip4<>(typeof(h.buyer_mail_zip4))'');
    populated_legal_lot_cd_cnt := COUNT(GROUP,h.legal_lot_cd <> (TYPEOF(h.legal_lot_cd))'');
    populated_legal_lot_cd_pcnt := AVE(GROUP,IF(h.legal_lot_cd = (TYPEOF(h.legal_lot_cd))'',0,100));
    maxlength_legal_lot_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_lot_cd)));
    avelength_legal_lot_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_lot_cd)),h.legal_lot_cd<>(typeof(h.legal_lot_cd))'');
    populated_legal_lot_num_cnt := COUNT(GROUP,h.legal_lot_num <> (TYPEOF(h.legal_lot_num))'');
    populated_legal_lot_num_pcnt := AVE(GROUP,IF(h.legal_lot_num = (TYPEOF(h.legal_lot_num))'',0,100));
    maxlength_legal_lot_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_lot_num)));
    avelength_legal_lot_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_lot_num)),h.legal_lot_num<>(typeof(h.legal_lot_num))'');
    populated_legal_block_cnt := COUNT(GROUP,h.legal_block <> (TYPEOF(h.legal_block))'');
    populated_legal_block_pcnt := AVE(GROUP,IF(h.legal_block = (TYPEOF(h.legal_block))'',0,100));
    maxlength_legal_block := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_block)));
    avelength_legal_block := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_block)),h.legal_block<>(typeof(h.legal_block))'');
    populated_legal_section_cnt := COUNT(GROUP,h.legal_section <> (TYPEOF(h.legal_section))'');
    populated_legal_section_pcnt := AVE(GROUP,IF(h.legal_section = (TYPEOF(h.legal_section))'',0,100));
    maxlength_legal_section := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_section)));
    avelength_legal_section := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_section)),h.legal_section<>(typeof(h.legal_section))'');
    populated_legal_district_cnt := COUNT(GROUP,h.legal_district <> (TYPEOF(h.legal_district))'');
    populated_legal_district_pcnt := AVE(GROUP,IF(h.legal_district = (TYPEOF(h.legal_district))'',0,100));
    maxlength_legal_district := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_district)));
    avelength_legal_district := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_district)),h.legal_district<>(typeof(h.legal_district))'');
    populated_legal_land_lot_cnt := COUNT(GROUP,h.legal_land_lot <> (TYPEOF(h.legal_land_lot))'');
    populated_legal_land_lot_pcnt := AVE(GROUP,IF(h.legal_land_lot = (TYPEOF(h.legal_land_lot))'',0,100));
    maxlength_legal_land_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_land_lot)));
    avelength_legal_land_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_land_lot)),h.legal_land_lot<>(typeof(h.legal_land_lot))'');
    populated_legal_unit_cnt := COUNT(GROUP,h.legal_unit <> (TYPEOF(h.legal_unit))'');
    populated_legal_unit_pcnt := AVE(GROUP,IF(h.legal_unit = (TYPEOF(h.legal_unit))'',0,100));
    maxlength_legal_unit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_unit)));
    avelength_legal_unit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_unit)),h.legal_unit<>(typeof(h.legal_unit))'');
    populated_legacl_city_cnt := COUNT(GROUP,h.legacl_city <> (TYPEOF(h.legacl_city))'');
    populated_legacl_city_pcnt := AVE(GROUP,IF(h.legacl_city = (TYPEOF(h.legacl_city))'',0,100));
    maxlength_legacl_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legacl_city)));
    avelength_legacl_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legacl_city)),h.legacl_city<>(typeof(h.legacl_city))'');
    populated_legal_subdivision_cnt := COUNT(GROUP,h.legal_subdivision <> (TYPEOF(h.legal_subdivision))'');
    populated_legal_subdivision_pcnt := AVE(GROUP,IF(h.legal_subdivision = (TYPEOF(h.legal_subdivision))'',0,100));
    maxlength_legal_subdivision := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_subdivision)));
    avelength_legal_subdivision := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_subdivision)),h.legal_subdivision<>(typeof(h.legal_subdivision))'');
    populated_legal_phase_num_cnt := COUNT(GROUP,h.legal_phase_num <> (TYPEOF(h.legal_phase_num))'');
    populated_legal_phase_num_pcnt := AVE(GROUP,IF(h.legal_phase_num = (TYPEOF(h.legal_phase_num))'',0,100));
    maxlength_legal_phase_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_phase_num)));
    avelength_legal_phase_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_phase_num)),h.legal_phase_num<>(typeof(h.legal_phase_num))'');
    populated_legal_tract_num_cnt := COUNT(GROUP,h.legal_tract_num <> (TYPEOF(h.legal_tract_num))'');
    populated_legal_tract_num_pcnt := AVE(GROUP,IF(h.legal_tract_num = (TYPEOF(h.legal_tract_num))'',0,100));
    maxlength_legal_tract_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_tract_num)));
    avelength_legal_tract_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_tract_num)),h.legal_tract_num<>(typeof(h.legal_tract_num))'');
    populated_legal_brief_desc_cnt := COUNT(GROUP,h.legal_brief_desc <> (TYPEOF(h.legal_brief_desc))'');
    populated_legal_brief_desc_pcnt := AVE(GROUP,IF(h.legal_brief_desc = (TYPEOF(h.legal_brief_desc))'',0,100));
    maxlength_legal_brief_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_brief_desc)));
    avelength_legal_brief_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_brief_desc)),h.legal_brief_desc<>(typeof(h.legal_brief_desc))'');
    populated_legal_township_cnt := COUNT(GROUP,h.legal_township <> (TYPEOF(h.legal_township))'');
    populated_legal_township_pcnt := AVE(GROUP,IF(h.legal_township = (TYPEOF(h.legal_township))'',0,100));
    maxlength_legal_township := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_township)));
    avelength_legal_township := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_township)),h.legal_township<>(typeof(h.legal_township))'');
    populated_recorder_map_ref_cnt := COUNT(GROUP,h.recorder_map_ref <> (TYPEOF(h.recorder_map_ref))'');
    populated_recorder_map_ref_pcnt := AVE(GROUP,IF(h.recorder_map_ref = (TYPEOF(h.recorder_map_ref))'',0,100));
    maxlength_recorder_map_ref := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_map_ref)));
    avelength_recorder_map_ref := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recorder_map_ref)),h.recorder_map_ref<>(typeof(h.recorder_map_ref))'');
    populated_prop_buyer_mail_addr_cd_cnt := COUNT(GROUP,h.prop_buyer_mail_addr_cd <> (TYPEOF(h.prop_buyer_mail_addr_cd))'');
    populated_prop_buyer_mail_addr_cd_pcnt := AVE(GROUP,IF(h.prop_buyer_mail_addr_cd = (TYPEOF(h.prop_buyer_mail_addr_cd))'',0,100));
    maxlength_prop_buyer_mail_addr_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_buyer_mail_addr_cd)));
    avelength_prop_buyer_mail_addr_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_buyer_mail_addr_cd)),h.prop_buyer_mail_addr_cd<>(typeof(h.prop_buyer_mail_addr_cd))'');
    populated_property_use_cd_cnt := COUNT(GROUP,h.property_use_cd <> (TYPEOF(h.property_use_cd))'');
    populated_property_use_cd_pcnt := AVE(GROUP,IF(h.property_use_cd = (TYPEOF(h.property_use_cd))'',0,100));
    maxlength_property_use_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_use_cd)));
    avelength_property_use_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_use_cd)),h.property_use_cd<>(typeof(h.property_use_cd))'');
    populated_orig_contract_date_cnt := COUNT(GROUP,h.orig_contract_date <> (TYPEOF(h.orig_contract_date))'');
    populated_orig_contract_date_pcnt := AVE(GROUP,IF(h.orig_contract_date = (TYPEOF(h.orig_contract_date))'',0,100));
    maxlength_orig_contract_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_contract_date)));
    avelength_orig_contract_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_contract_date)),h.orig_contract_date<>(typeof(h.orig_contract_date))'');
    populated_sales_price_cnt := COUNT(GROUP,h.sales_price <> (TYPEOF(h.sales_price))'');
    populated_sales_price_pcnt := AVE(GROUP,IF(h.sales_price = (TYPEOF(h.sales_price))'',0,100));
    maxlength_sales_price := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price)));
    avelength_sales_price := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price)),h.sales_price<>(typeof(h.sales_price))'');
    populated_sales_price_cd_cnt := COUNT(GROUP,h.sales_price_cd <> (TYPEOF(h.sales_price_cd))'');
    populated_sales_price_cd_pcnt := AVE(GROUP,IF(h.sales_price_cd = (TYPEOF(h.sales_price_cd))'',0,100));
    maxlength_sales_price_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price_cd)));
    avelength_sales_price_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_price_cd)),h.sales_price_cd<>(typeof(h.sales_price_cd))'');
    populated_city_xfer_tax_cnt := COUNT(GROUP,h.city_xfer_tax <> (TYPEOF(h.city_xfer_tax))'');
    populated_city_xfer_tax_pcnt := AVE(GROUP,IF(h.city_xfer_tax = (TYPEOF(h.city_xfer_tax))'',0,100));
    maxlength_city_xfer_tax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_xfer_tax)));
    avelength_city_xfer_tax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_xfer_tax)),h.city_xfer_tax<>(typeof(h.city_xfer_tax))'');
    populated_county_xfer_tax_cnt := COUNT(GROUP,h.county_xfer_tax <> (TYPEOF(h.county_xfer_tax))'');
    populated_county_xfer_tax_pcnt := AVE(GROUP,IF(h.county_xfer_tax = (TYPEOF(h.county_xfer_tax))'',0,100));
    maxlength_county_xfer_tax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_xfer_tax)));
    avelength_county_xfer_tax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_xfer_tax)),h.county_xfer_tax<>(typeof(h.county_xfer_tax))'');
    populated_total_xfer_tax_cnt := COUNT(GROUP,h.total_xfer_tax <> (TYPEOF(h.total_xfer_tax))'');
    populated_total_xfer_tax_pcnt := AVE(GROUP,IF(h.total_xfer_tax = (TYPEOF(h.total_xfer_tax))'',0,100));
    maxlength_total_xfer_tax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_xfer_tax)));
    avelength_total_xfer_tax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_xfer_tax)),h.total_xfer_tax<>(typeof(h.total_xfer_tax))'');
    populated_concurrent_lender_name_cnt := COUNT(GROUP,h.concurrent_lender_name <> (TYPEOF(h.concurrent_lender_name))'');
    populated_concurrent_lender_name_pcnt := AVE(GROUP,IF(h.concurrent_lender_name = (TYPEOF(h.concurrent_lender_name))'',0,100));
    maxlength_concurrent_lender_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_lender_name)));
    avelength_concurrent_lender_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_lender_name)),h.concurrent_lender_name<>(typeof(h.concurrent_lender_name))'');
    populated_concurrent_lender_type_cnt := COUNT(GROUP,h.concurrent_lender_type <> (TYPEOF(h.concurrent_lender_type))'');
    populated_concurrent_lender_type_pcnt := AVE(GROUP,IF(h.concurrent_lender_type = (TYPEOF(h.concurrent_lender_type))'',0,100));
    maxlength_concurrent_lender_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_lender_type)));
    avelength_concurrent_lender_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_lender_type)),h.concurrent_lender_type<>(typeof(h.concurrent_lender_type))'');
    populated_concurrent_loan_amt_cnt := COUNT(GROUP,h.concurrent_loan_amt <> (TYPEOF(h.concurrent_loan_amt))'');
    populated_concurrent_loan_amt_pcnt := AVE(GROUP,IF(h.concurrent_loan_amt = (TYPEOF(h.concurrent_loan_amt))'',0,100));
    maxlength_concurrent_loan_amt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_loan_amt)));
    avelength_concurrent_loan_amt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_loan_amt)),h.concurrent_loan_amt<>(typeof(h.concurrent_loan_amt))'');
    populated_concurrent_loan_type_cnt := COUNT(GROUP,h.concurrent_loan_type <> (TYPEOF(h.concurrent_loan_type))'');
    populated_concurrent_loan_type_pcnt := AVE(GROUP,IF(h.concurrent_loan_type = (TYPEOF(h.concurrent_loan_type))'',0,100));
    maxlength_concurrent_loan_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_loan_type)));
    avelength_concurrent_loan_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_loan_type)),h.concurrent_loan_type<>(typeof(h.concurrent_loan_type))'');
    populated_concurrent_type_fin_cnt := COUNT(GROUP,h.concurrent_type_fin <> (TYPEOF(h.concurrent_type_fin))'');
    populated_concurrent_type_fin_pcnt := AVE(GROUP,IF(h.concurrent_type_fin = (TYPEOF(h.concurrent_type_fin))'',0,100));
    maxlength_concurrent_type_fin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_type_fin)));
    avelength_concurrent_type_fin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_type_fin)),h.concurrent_type_fin<>(typeof(h.concurrent_type_fin))'');
    populated_concurrent_interest_rate_cnt := COUNT(GROUP,h.concurrent_interest_rate <> (TYPEOF(h.concurrent_interest_rate))'');
    populated_concurrent_interest_rate_pcnt := AVE(GROUP,IF(h.concurrent_interest_rate = (TYPEOF(h.concurrent_interest_rate))'',0,100));
    maxlength_concurrent_interest_rate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_interest_rate)));
    avelength_concurrent_interest_rate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_interest_rate)),h.concurrent_interest_rate<>(typeof(h.concurrent_interest_rate))'');
    populated_concurrent_due_dt_cnt := COUNT(GROUP,h.concurrent_due_dt <> (TYPEOF(h.concurrent_due_dt))'');
    populated_concurrent_due_dt_pcnt := AVE(GROUP,IF(h.concurrent_due_dt = (TYPEOF(h.concurrent_due_dt))'',0,100));
    maxlength_concurrent_due_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_due_dt)));
    avelength_concurrent_due_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_due_dt)),h.concurrent_due_dt<>(typeof(h.concurrent_due_dt))'');
    populated_concurrent_2nd_loan_amt_cnt := COUNT(GROUP,h.concurrent_2nd_loan_amt <> (TYPEOF(h.concurrent_2nd_loan_amt))'');
    populated_concurrent_2nd_loan_amt_pcnt := AVE(GROUP,IF(h.concurrent_2nd_loan_amt = (TYPEOF(h.concurrent_2nd_loan_amt))'',0,100));
    maxlength_concurrent_2nd_loan_amt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_2nd_loan_amt)));
    avelength_concurrent_2nd_loan_amt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.concurrent_2nd_loan_amt)),h.concurrent_2nd_loan_amt<>(typeof(h.concurrent_2nd_loan_amt))'');
    populated_buyer_mail_full_addr_cnt := COUNT(GROUP,h.buyer_mail_full_addr <> (TYPEOF(h.buyer_mail_full_addr))'');
    populated_buyer_mail_full_addr_pcnt := AVE(GROUP,IF(h.buyer_mail_full_addr = (TYPEOF(h.buyer_mail_full_addr))'',0,100));
    maxlength_buyer_mail_full_addr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_full_addr)));
    avelength_buyer_mail_full_addr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_full_addr)),h.buyer_mail_full_addr<>(typeof(h.buyer_mail_full_addr))'');
    populated_buyer_mail_unit_type_cnt := COUNT(GROUP,h.buyer_mail_unit_type <> (TYPEOF(h.buyer_mail_unit_type))'');
    populated_buyer_mail_unit_type_pcnt := AVE(GROUP,IF(h.buyer_mail_unit_type = (TYPEOF(h.buyer_mail_unit_type))'',0,100));
    maxlength_buyer_mail_unit_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_unit_type)));
    avelength_buyer_mail_unit_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_unit_type)),h.buyer_mail_unit_type<>(typeof(h.buyer_mail_unit_type))'');
    populated_buyer_mail_unit_no_cnt := COUNT(GROUP,h.buyer_mail_unit_no <> (TYPEOF(h.buyer_mail_unit_no))'');
    populated_buyer_mail_unit_no_pcnt := AVE(GROUP,IF(h.buyer_mail_unit_no = (TYPEOF(h.buyer_mail_unit_no))'',0,100));
    maxlength_buyer_mail_unit_no := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_unit_no)));
    avelength_buyer_mail_unit_no := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_unit_no)),h.buyer_mail_unit_no<>(typeof(h.buyer_mail_unit_no))'');
    populated_lps_internal_pid_cnt := COUNT(GROUP,h.lps_internal_pid <> (TYPEOF(h.lps_internal_pid))'');
    populated_lps_internal_pid_pcnt := AVE(GROUP,IF(h.lps_internal_pid = (TYPEOF(h.lps_internal_pid))'',0,100));
    maxlength_lps_internal_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lps_internal_pid)));
    avelength_lps_internal_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lps_internal_pid)),h.lps_internal_pid<>(typeof(h.lps_internal_pid))'');
    populated_buyer_mail_careof_cnt := COUNT(GROUP,h.buyer_mail_careof <> (TYPEOF(h.buyer_mail_careof))'');
    populated_buyer_mail_careof_pcnt := AVE(GROUP,IF(h.buyer_mail_careof = (TYPEOF(h.buyer_mail_careof))'',0,100));
    maxlength_buyer_mail_careof := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_careof)));
    avelength_buyer_mail_careof := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.buyer_mail_careof)),h.buyer_mail_careof<>(typeof(h.buyer_mail_careof))'');
    populated_title_co_name_cnt := COUNT(GROUP,h.title_co_name <> (TYPEOF(h.title_co_name))'');
    populated_title_co_name_pcnt := AVE(GROUP,IF(h.title_co_name = (TYPEOF(h.title_co_name))'',0,100));
    maxlength_title_co_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_co_name)));
    avelength_title_co_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_co_name)),h.title_co_name<>(typeof(h.title_co_name))'');
    populated_legal_desc_cd_cnt := COUNT(GROUP,h.legal_desc_cd <> (TYPEOF(h.legal_desc_cd))'');
    populated_legal_desc_cd_pcnt := AVE(GROUP,IF(h.legal_desc_cd = (TYPEOF(h.legal_desc_cd))'',0,100));
    maxlength_legal_desc_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_cd)));
    avelength_legal_desc_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_cd)),h.legal_desc_cd<>(typeof(h.legal_desc_cd))'');
    populated_adj_rate_rider_cnt := COUNT(GROUP,h.adj_rate_rider <> (TYPEOF(h.adj_rate_rider))'');
    populated_adj_rate_rider_pcnt := AVE(GROUP,IF(h.adj_rate_rider = (TYPEOF(h.adj_rate_rider))'',0,100));
    maxlength_adj_rate_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.adj_rate_rider)));
    avelength_adj_rate_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.adj_rate_rider)),h.adj_rate_rider<>(typeof(h.adj_rate_rider))'');
    populated_adj_rate_index_cnt := COUNT(GROUP,h.adj_rate_index <> (TYPEOF(h.adj_rate_index))'');
    populated_adj_rate_index_pcnt := AVE(GROUP,IF(h.adj_rate_index = (TYPEOF(h.adj_rate_index))'',0,100));
    maxlength_adj_rate_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.adj_rate_index)));
    avelength_adj_rate_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.adj_rate_index)),h.adj_rate_index<>(typeof(h.adj_rate_index))'');
    populated_change_index_cnt := COUNT(GROUP,h.change_index <> (TYPEOF(h.change_index))'');
    populated_change_index_pcnt := AVE(GROUP,IF(h.change_index = (TYPEOF(h.change_index))'',0,100));
    maxlength_change_index := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.change_index)));
    avelength_change_index := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.change_index)),h.change_index<>(typeof(h.change_index))'');
    populated_rate_change_freq_cnt := COUNT(GROUP,h.rate_change_freq <> (TYPEOF(h.rate_change_freq))'');
    populated_rate_change_freq_pcnt := AVE(GROUP,IF(h.rate_change_freq = (TYPEOF(h.rate_change_freq))'',0,100));
    maxlength_rate_change_freq := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rate_change_freq)));
    avelength_rate_change_freq := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rate_change_freq)),h.rate_change_freq<>(typeof(h.rate_change_freq))'');
    populated_int_rate_ngt_cnt := COUNT(GROUP,h.int_rate_ngt <> (TYPEOF(h.int_rate_ngt))'');
    populated_int_rate_ngt_pcnt := AVE(GROUP,IF(h.int_rate_ngt = (TYPEOF(h.int_rate_ngt))'',0,100));
    maxlength_int_rate_ngt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.int_rate_ngt)));
    avelength_int_rate_ngt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.int_rate_ngt)),h.int_rate_ngt<>(typeof(h.int_rate_ngt))'');
    populated_int_rate_nlt_cnt := COUNT(GROUP,h.int_rate_nlt <> (TYPEOF(h.int_rate_nlt))'');
    populated_int_rate_nlt_pcnt := AVE(GROUP,IF(h.int_rate_nlt = (TYPEOF(h.int_rate_nlt))'',0,100));
    maxlength_int_rate_nlt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.int_rate_nlt)));
    avelength_int_rate_nlt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.int_rate_nlt)),h.int_rate_nlt<>(typeof(h.int_rate_nlt))'');
    populated_max_int_rate_cnt := COUNT(GROUP,h.max_int_rate <> (TYPEOF(h.max_int_rate))'');
    populated_max_int_rate_pcnt := AVE(GROUP,IF(h.max_int_rate = (TYPEOF(h.max_int_rate))'',0,100));
    maxlength_max_int_rate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.max_int_rate)));
    avelength_max_int_rate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.max_int_rate)),h.max_int_rate<>(typeof(h.max_int_rate))'');
    populated_int_only_period_cnt := COUNT(GROUP,h.int_only_period <> (TYPEOF(h.int_only_period))'');
    populated_int_only_period_pcnt := AVE(GROUP,IF(h.int_only_period = (TYPEOF(h.int_only_period))'',0,100));
    maxlength_int_only_period := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.int_only_period)));
    avelength_int_only_period := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.int_only_period)),h.int_only_period<>(typeof(h.int_only_period))'');
    populated_fixed_rate_rider_cnt := COUNT(GROUP,h.fixed_rate_rider <> (TYPEOF(h.fixed_rate_rider))'');
    populated_fixed_rate_rider_pcnt := AVE(GROUP,IF(h.fixed_rate_rider = (TYPEOF(h.fixed_rate_rider))'',0,100));
    maxlength_fixed_rate_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fixed_rate_rider)));
    avelength_fixed_rate_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fixed_rate_rider)),h.fixed_rate_rider<>(typeof(h.fixed_rate_rider))'');
    populated_first_chg_dt_yy_cnt := COUNT(GROUP,h.first_chg_dt_yy <> (TYPEOF(h.first_chg_dt_yy))'');
    populated_first_chg_dt_yy_pcnt := AVE(GROUP,IF(h.first_chg_dt_yy = (TYPEOF(h.first_chg_dt_yy))'',0,100));
    maxlength_first_chg_dt_yy := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_chg_dt_yy)));
    avelength_first_chg_dt_yy := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_chg_dt_yy)),h.first_chg_dt_yy<>(typeof(h.first_chg_dt_yy))'');
    populated_first_chg_dt_mmdd_cnt := COUNT(GROUP,h.first_chg_dt_mmdd <> (TYPEOF(h.first_chg_dt_mmdd))'');
    populated_first_chg_dt_mmdd_pcnt := AVE(GROUP,IF(h.first_chg_dt_mmdd = (TYPEOF(h.first_chg_dt_mmdd))'',0,100));
    maxlength_first_chg_dt_mmdd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_chg_dt_mmdd)));
    avelength_first_chg_dt_mmdd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_chg_dt_mmdd)),h.first_chg_dt_mmdd<>(typeof(h.first_chg_dt_mmdd))'');
    populated_prepayment_rider_cnt := COUNT(GROUP,h.prepayment_rider <> (TYPEOF(h.prepayment_rider))'');
    populated_prepayment_rider_pcnt := AVE(GROUP,IF(h.prepayment_rider = (TYPEOF(h.prepayment_rider))'',0,100));
    maxlength_prepayment_rider := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepayment_rider)));
    avelength_prepayment_rider := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepayment_rider)),h.prepayment_rider<>(typeof(h.prepayment_rider))'');
    populated_prepayment_term_cnt := COUNT(GROUP,h.prepayment_term <> (TYPEOF(h.prepayment_term))'');
    populated_prepayment_term_pcnt := AVE(GROUP,IF(h.prepayment_term = (TYPEOF(h.prepayment_term))'',0,100));
    maxlength_prepayment_term := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepayment_term)));
    avelength_prepayment_term := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepayment_term)),h.prepayment_term<>(typeof(h.prepayment_term))'');
    populated_asses_land_use_cnt := COUNT(GROUP,h.asses_land_use <> (TYPEOF(h.asses_land_use))'');
    populated_asses_land_use_pcnt := AVE(GROUP,IF(h.asses_land_use = (TYPEOF(h.asses_land_use))'',0,100));
    maxlength_asses_land_use := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.asses_land_use)));
    avelength_asses_land_use := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.asses_land_use)),h.asses_land_use<>(typeof(h.asses_land_use))'');
    populated_res_indicator_cnt := COUNT(GROUP,h.res_indicator <> (TYPEOF(h.res_indicator))'');
    populated_res_indicator_pcnt := AVE(GROUP,IF(h.res_indicator = (TYPEOF(h.res_indicator))'',0,100));
    maxlength_res_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_indicator)));
    avelength_res_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_indicator)),h.res_indicator<>(typeof(h.res_indicator))'');
    populated_construction_loan_cnt := COUNT(GROUP,h.construction_loan <> (TYPEOF(h.construction_loan))'');
    populated_construction_loan_pcnt := AVE(GROUP,IF(h.construction_loan = (TYPEOF(h.construction_loan))'',0,100));
    maxlength_construction_loan := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.construction_loan)));
    avelength_construction_loan := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.construction_loan)),h.construction_loan<>(typeof(h.construction_loan))'');
    populated_inter_family_cnt := COUNT(GROUP,h.inter_family <> (TYPEOF(h.inter_family))'');
    populated_inter_family_pcnt := AVE(GROUP,IF(h.inter_family = (TYPEOF(h.inter_family))'',0,100));
    maxlength_inter_family := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.inter_family)));
    avelength_inter_family := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.inter_family)),h.inter_family<>(typeof(h.inter_family))'');
    populated_cash_purchase_cnt := COUNT(GROUP,h.cash_purchase <> (TYPEOF(h.cash_purchase))'');
    populated_cash_purchase_pcnt := AVE(GROUP,IF(h.cash_purchase = (TYPEOF(h.cash_purchase))'',0,100));
    maxlength_cash_purchase := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cash_purchase)));
    avelength_cash_purchase := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cash_purchase)),h.cash_purchase<>(typeof(h.cash_purchase))'');
    populated_stand_alone_refi_cnt := COUNT(GROUP,h.stand_alone_refi <> (TYPEOF(h.stand_alone_refi))'');
    populated_stand_alone_refi_pcnt := AVE(GROUP,IF(h.stand_alone_refi = (TYPEOF(h.stand_alone_refi))'',0,100));
    maxlength_stand_alone_refi := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stand_alone_refi)));
    avelength_stand_alone_refi := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stand_alone_refi)),h.stand_alone_refi<>(typeof(h.stand_alone_refi))'');
    populated_equity_credit_line_cnt := COUNT(GROUP,h.equity_credit_line <> (TYPEOF(h.equity_credit_line))'');
    populated_equity_credit_line_pcnt := AVE(GROUP,IF(h.equity_credit_line = (TYPEOF(h.equity_credit_line))'',0,100));
    maxlength_equity_credit_line := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.equity_credit_line)));
    avelength_equity_credit_line := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.equity_credit_line)),h.equity_credit_line<>(typeof(h.equity_credit_line))'');
    populated_reo_flag_cnt := COUNT(GROUP,h.reo_flag <> (TYPEOF(h.reo_flag))'');
    populated_reo_flag_pcnt := AVE(GROUP,IF(h.reo_flag = (TYPEOF(h.reo_flag))'',0,100));
    maxlength_reo_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reo_flag)));
    avelength_reo_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reo_flag)),h.reo_flag<>(typeof(h.reo_flag))'');
    populated_distressedsaleflag_cnt := COUNT(GROUP,h.distressedsaleflag <> (TYPEOF(h.distressedsaleflag))'');
    populated_distressedsaleflag_pcnt := AVE(GROUP,IF(h.distressedsaleflag = (TYPEOF(h.distressedsaleflag))'',0,100));
    maxlength_distressedsaleflag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.distressedsaleflag)));
    avelength_distressedsaleflag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.distressedsaleflag)),h.distressedsaleflag<>(typeof(h.distressedsaleflag))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_foreclosure_id_pcnt *   0.00 / 100 + T.Populated_ln_filedate_pcnt *   0.00 / 100 + T.Populated_bk_infile_type_pcnt *   0.00 / 100 + T.Populated_fips_cd_pcnt *   0.00 / 100 + T.Populated_prop_full_addr_pcnt *   0.00 / 100 + T.Populated_prop_addr_city_pcnt *   0.00 / 100 + T.Populated_prop_addr_state_pcnt *   0.00 / 100 + T.Populated_prop_addr_zip5_pcnt *   0.00 / 100 + T.Populated_prop_addr_zip4_pcnt *   0.00 / 100 + T.Populated_prop_addr_unit_type_pcnt *   0.00 / 100 + T.Populated_prop_addr_unit_no_pcnt *   0.00 / 100 + T.Populated_prop_addr_house_no_pcnt *   0.00 / 100 + T.Populated_prop_addr_predir_pcnt *   0.00 / 100 + T.Populated_prop_addr_street_pcnt *   0.00 / 100 + T.Populated_prop_addr_suffix_pcnt *   0.00 / 100 + T.Populated_prop_addr_postdir_pcnt *   0.00 / 100 + T.Populated_prop_addr_carrier_rt_pcnt *   0.00 / 100 + T.Populated_recording_date_pcnt *   0.00 / 100 + T.Populated_recording_book_num_pcnt *   0.00 / 100 + T.Populated_recording_page_num_pcnt *   0.00 / 100 + T.Populated_recording_doc_num_pcnt *   0.00 / 100 + T.Populated_doc_type_cd_pcnt *   0.00 / 100 + T.Populated_apn_pcnt *   0.00 / 100 + T.Populated_multi_apn_pcnt *   0.00 / 100 + T.Populated_partial_interest_trans_pcnt *   0.00 / 100 + T.Populated_seller1_fname_pcnt *   0.00 / 100 + T.Populated_seller1_lname_pcnt *   0.00 / 100 + T.Populated_seller1_id_pcnt *   0.00 / 100 + T.Populated_seller2_fname_pcnt *   0.00 / 100 + T.Populated_seller2_lname_pcnt *   0.00 / 100 + T.Populated_buyer1_fname_pcnt *   0.00 / 100 + T.Populated_buyer1_lname_pcnt *   0.00 / 100 + T.Populated_buyer1_id_cd_pcnt *   0.00 / 100 + T.Populated_buyer2_fname_pcnt *   0.00 / 100 + T.Populated_buyer2_lname_pcnt *   0.00 / 100 + T.Populated_buyer_vesting_cd_pcnt *   0.00 / 100 + T.Populated_concurrent_doc_num_pcnt *   0.00 / 100 + T.Populated_buyer_mail_city_pcnt *   0.00 / 100 + T.Populated_buyer_mail_state_pcnt *   0.00 / 100 + T.Populated_buyer_mail_zip5_pcnt *   0.00 / 100 + T.Populated_buyer_mail_zip4_pcnt *   0.00 / 100 + T.Populated_legal_lot_cd_pcnt *   0.00 / 100 + T.Populated_legal_lot_num_pcnt *   0.00 / 100 + T.Populated_legal_block_pcnt *   0.00 / 100 + T.Populated_legal_section_pcnt *   0.00 / 100 + T.Populated_legal_district_pcnt *   0.00 / 100 + T.Populated_legal_land_lot_pcnt *   0.00 / 100 + T.Populated_legal_unit_pcnt *   0.00 / 100 + T.Populated_legacl_city_pcnt *   0.00 / 100 + T.Populated_legal_subdivision_pcnt *   0.00 / 100 + T.Populated_legal_phase_num_pcnt *   0.00 / 100 + T.Populated_legal_tract_num_pcnt *   0.00 / 100 + T.Populated_legal_brief_desc_pcnt *   0.00 / 100 + T.Populated_legal_township_pcnt *   0.00 / 100 + T.Populated_recorder_map_ref_pcnt *   0.00 / 100 + T.Populated_prop_buyer_mail_addr_cd_pcnt *   0.00 / 100 + T.Populated_property_use_cd_pcnt *   0.00 / 100 + T.Populated_orig_contract_date_pcnt *   0.00 / 100 + T.Populated_sales_price_pcnt *   0.00 / 100 + T.Populated_sales_price_cd_pcnt *   0.00 / 100 + T.Populated_city_xfer_tax_pcnt *   0.00 / 100 + T.Populated_county_xfer_tax_pcnt *   0.00 / 100 + T.Populated_total_xfer_tax_pcnt *   0.00 / 100 + T.Populated_concurrent_lender_name_pcnt *   0.00 / 100 + T.Populated_concurrent_lender_type_pcnt *   0.00 / 100 + T.Populated_concurrent_loan_amt_pcnt *   0.00 / 100 + T.Populated_concurrent_loan_type_pcnt *   0.00 / 100 + T.Populated_concurrent_type_fin_pcnt *   0.00 / 100 + T.Populated_concurrent_interest_rate_pcnt *   0.00 / 100 + T.Populated_concurrent_due_dt_pcnt *   0.00 / 100 + T.Populated_concurrent_2nd_loan_amt_pcnt *   0.00 / 100 + T.Populated_buyer_mail_full_addr_pcnt *   0.00 / 100 + T.Populated_buyer_mail_unit_type_pcnt *   0.00 / 100 + T.Populated_buyer_mail_unit_no_pcnt *   0.00 / 100 + T.Populated_lps_internal_pid_pcnt *   0.00 / 100 + T.Populated_buyer_mail_careof_pcnt *   0.00 / 100 + T.Populated_title_co_name_pcnt *   0.00 / 100 + T.Populated_legal_desc_cd_pcnt *   0.00 / 100 + T.Populated_adj_rate_rider_pcnt *   0.00 / 100 + T.Populated_adj_rate_index_pcnt *   0.00 / 100 + T.Populated_change_index_pcnt *   0.00 / 100 + T.Populated_rate_change_freq_pcnt *   0.00 / 100 + T.Populated_int_rate_ngt_pcnt *   0.00 / 100 + T.Populated_int_rate_nlt_pcnt *   0.00 / 100 + T.Populated_max_int_rate_pcnt *   0.00 / 100 + T.Populated_int_only_period_pcnt *   0.00 / 100 + T.Populated_fixed_rate_rider_pcnt *   0.00 / 100 + T.Populated_first_chg_dt_yy_pcnt *   0.00 / 100 + T.Populated_first_chg_dt_mmdd_pcnt *   0.00 / 100 + T.Populated_prepayment_rider_pcnt *   0.00 / 100 + T.Populated_prepayment_term_pcnt *   0.00 / 100 + T.Populated_asses_land_use_pcnt *   0.00 / 100 + T.Populated_res_indicator_pcnt *   0.00 / 100 + T.Populated_construction_loan_pcnt *   0.00 / 100 + T.Populated_inter_family_pcnt *   0.00 / 100 + T.Populated_cash_purchase_pcnt *   0.00 / 100 + T.Populated_stand_alone_refi_pcnt *   0.00 / 100 + T.Populated_equity_credit_line_pcnt *   0.00 / 100 + T.Populated_reo_flag_pcnt *   0.00 / 100 + T.Populated_distressedsaleflag_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'foreclosure_id','ln_filedate','bk_infile_type','fips_cd','prop_full_addr','prop_addr_city','prop_addr_state','prop_addr_zip5','prop_addr_zip4','prop_addr_unit_type','prop_addr_unit_no','prop_addr_house_no','prop_addr_predir','prop_addr_street','prop_addr_suffix','prop_addr_postdir','prop_addr_carrier_rt','recording_date','recording_book_num','recording_page_num','recording_doc_num','doc_type_cd','apn','multi_apn','partial_interest_trans','seller1_fname','seller1_lname','seller1_id','seller2_fname','seller2_lname','buyer1_fname','buyer1_lname','buyer1_id_cd','buyer2_fname','buyer2_lname','buyer_vesting_cd','concurrent_doc_num','buyer_mail_city','buyer_mail_state','buyer_mail_zip5','buyer_mail_zip4','legal_lot_cd','legal_lot_num','legal_block','legal_section','legal_district','legal_land_lot','legal_unit','legacl_city','legal_subdivision','legal_phase_num','legal_tract_num','legal_brief_desc','legal_township','recorder_map_ref','prop_buyer_mail_addr_cd','property_use_cd','orig_contract_date','sales_price','sales_price_cd','city_xfer_tax','county_xfer_tax','total_xfer_tax','concurrent_lender_name','concurrent_lender_type','concurrent_loan_amt','concurrent_loan_type','concurrent_type_fin','concurrent_interest_rate','concurrent_due_dt','concurrent_2nd_loan_amt','buyer_mail_full_addr','buyer_mail_unit_type','buyer_mail_unit_no','lps_internal_pid','buyer_mail_careof','title_co_name','legal_desc_cd','adj_rate_rider','adj_rate_index','change_index','rate_change_freq','int_rate_ngt','int_rate_nlt','max_int_rate','int_only_period','fixed_rate_rider','first_chg_dt_yy','first_chg_dt_mmdd','prepayment_rider','prepayment_term','asses_land_use','res_indicator','construction_loan','inter_family','cash_purchase','stand_alone_refi','equity_credit_line','reo_flag','distressedsaleflag');
  SELF.populated_pcnt := CHOOSE(C,le.populated_foreclosure_id_pcnt,le.populated_ln_filedate_pcnt,le.populated_bk_infile_type_pcnt,le.populated_fips_cd_pcnt,le.populated_prop_full_addr_pcnt,le.populated_prop_addr_city_pcnt,le.populated_prop_addr_state_pcnt,le.populated_prop_addr_zip5_pcnt,le.populated_prop_addr_zip4_pcnt,le.populated_prop_addr_unit_type_pcnt,le.populated_prop_addr_unit_no_pcnt,le.populated_prop_addr_house_no_pcnt,le.populated_prop_addr_predir_pcnt,le.populated_prop_addr_street_pcnt,le.populated_prop_addr_suffix_pcnt,le.populated_prop_addr_postdir_pcnt,le.populated_prop_addr_carrier_rt_pcnt,le.populated_recording_date_pcnt,le.populated_recording_book_num_pcnt,le.populated_recording_page_num_pcnt,le.populated_recording_doc_num_pcnt,le.populated_doc_type_cd_pcnt,le.populated_apn_pcnt,le.populated_multi_apn_pcnt,le.populated_partial_interest_trans_pcnt,le.populated_seller1_fname_pcnt,le.populated_seller1_lname_pcnt,le.populated_seller1_id_pcnt,le.populated_seller2_fname_pcnt,le.populated_seller2_lname_pcnt,le.populated_buyer1_fname_pcnt,le.populated_buyer1_lname_pcnt,le.populated_buyer1_id_cd_pcnt,le.populated_buyer2_fname_pcnt,le.populated_buyer2_lname_pcnt,le.populated_buyer_vesting_cd_pcnt,le.populated_concurrent_doc_num_pcnt,le.populated_buyer_mail_city_pcnt,le.populated_buyer_mail_state_pcnt,le.populated_buyer_mail_zip5_pcnt,le.populated_buyer_mail_zip4_pcnt,le.populated_legal_lot_cd_pcnt,le.populated_legal_lot_num_pcnt,le.populated_legal_block_pcnt,le.populated_legal_section_pcnt,le.populated_legal_district_pcnt,le.populated_legal_land_lot_pcnt,le.populated_legal_unit_pcnt,le.populated_legacl_city_pcnt,le.populated_legal_subdivision_pcnt,le.populated_legal_phase_num_pcnt,le.populated_legal_tract_num_pcnt,le.populated_legal_brief_desc_pcnt,le.populated_legal_township_pcnt,le.populated_recorder_map_ref_pcnt,le.populated_prop_buyer_mail_addr_cd_pcnt,le.populated_property_use_cd_pcnt,le.populated_orig_contract_date_pcnt,le.populated_sales_price_pcnt,le.populated_sales_price_cd_pcnt,le.populated_city_xfer_tax_pcnt,le.populated_county_xfer_tax_pcnt,le.populated_total_xfer_tax_pcnt,le.populated_concurrent_lender_name_pcnt,le.populated_concurrent_lender_type_pcnt,le.populated_concurrent_loan_amt_pcnt,le.populated_concurrent_loan_type_pcnt,le.populated_concurrent_type_fin_pcnt,le.populated_concurrent_interest_rate_pcnt,le.populated_concurrent_due_dt_pcnt,le.populated_concurrent_2nd_loan_amt_pcnt,le.populated_buyer_mail_full_addr_pcnt,le.populated_buyer_mail_unit_type_pcnt,le.populated_buyer_mail_unit_no_pcnt,le.populated_lps_internal_pid_pcnt,le.populated_buyer_mail_careof_pcnt,le.populated_title_co_name_pcnt,le.populated_legal_desc_cd_pcnt,le.populated_adj_rate_rider_pcnt,le.populated_adj_rate_index_pcnt,le.populated_change_index_pcnt,le.populated_rate_change_freq_pcnt,le.populated_int_rate_ngt_pcnt,le.populated_int_rate_nlt_pcnt,le.populated_max_int_rate_pcnt,le.populated_int_only_period_pcnt,le.populated_fixed_rate_rider_pcnt,le.populated_first_chg_dt_yy_pcnt,le.populated_first_chg_dt_mmdd_pcnt,le.populated_prepayment_rider_pcnt,le.populated_prepayment_term_pcnt,le.populated_asses_land_use_pcnt,le.populated_res_indicator_pcnt,le.populated_construction_loan_pcnt,le.populated_inter_family_pcnt,le.populated_cash_purchase_pcnt,le.populated_stand_alone_refi_pcnt,le.populated_equity_credit_line_pcnt,le.populated_reo_flag_pcnt,le.populated_distressedsaleflag_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_foreclosure_id,le.maxlength_ln_filedate,le.maxlength_bk_infile_type,le.maxlength_fips_cd,le.maxlength_prop_full_addr,le.maxlength_prop_addr_city,le.maxlength_prop_addr_state,le.maxlength_prop_addr_zip5,le.maxlength_prop_addr_zip4,le.maxlength_prop_addr_unit_type,le.maxlength_prop_addr_unit_no,le.maxlength_prop_addr_house_no,le.maxlength_prop_addr_predir,le.maxlength_prop_addr_street,le.maxlength_prop_addr_suffix,le.maxlength_prop_addr_postdir,le.maxlength_prop_addr_carrier_rt,le.maxlength_recording_date,le.maxlength_recording_book_num,le.maxlength_recording_page_num,le.maxlength_recording_doc_num,le.maxlength_doc_type_cd,le.maxlength_apn,le.maxlength_multi_apn,le.maxlength_partial_interest_trans,le.maxlength_seller1_fname,le.maxlength_seller1_lname,le.maxlength_seller1_id,le.maxlength_seller2_fname,le.maxlength_seller2_lname,le.maxlength_buyer1_fname,le.maxlength_buyer1_lname,le.maxlength_buyer1_id_cd,le.maxlength_buyer2_fname,le.maxlength_buyer2_lname,le.maxlength_buyer_vesting_cd,le.maxlength_concurrent_doc_num,le.maxlength_buyer_mail_city,le.maxlength_buyer_mail_state,le.maxlength_buyer_mail_zip5,le.maxlength_buyer_mail_zip4,le.maxlength_legal_lot_cd,le.maxlength_legal_lot_num,le.maxlength_legal_block,le.maxlength_legal_section,le.maxlength_legal_district,le.maxlength_legal_land_lot,le.maxlength_legal_unit,le.maxlength_legacl_city,le.maxlength_legal_subdivision,le.maxlength_legal_phase_num,le.maxlength_legal_tract_num,le.maxlength_legal_brief_desc,le.maxlength_legal_township,le.maxlength_recorder_map_ref,le.maxlength_prop_buyer_mail_addr_cd,le.maxlength_property_use_cd,le.maxlength_orig_contract_date,le.maxlength_sales_price,le.maxlength_sales_price_cd,le.maxlength_city_xfer_tax,le.maxlength_county_xfer_tax,le.maxlength_total_xfer_tax,le.maxlength_concurrent_lender_name,le.maxlength_concurrent_lender_type,le.maxlength_concurrent_loan_amt,le.maxlength_concurrent_loan_type,le.maxlength_concurrent_type_fin,le.maxlength_concurrent_interest_rate,le.maxlength_concurrent_due_dt,le.maxlength_concurrent_2nd_loan_amt,le.maxlength_buyer_mail_full_addr,le.maxlength_buyer_mail_unit_type,le.maxlength_buyer_mail_unit_no,le.maxlength_lps_internal_pid,le.maxlength_buyer_mail_careof,le.maxlength_title_co_name,le.maxlength_legal_desc_cd,le.maxlength_adj_rate_rider,le.maxlength_adj_rate_index,le.maxlength_change_index,le.maxlength_rate_change_freq,le.maxlength_int_rate_ngt,le.maxlength_int_rate_nlt,le.maxlength_max_int_rate,le.maxlength_int_only_period,le.maxlength_fixed_rate_rider,le.maxlength_first_chg_dt_yy,le.maxlength_first_chg_dt_mmdd,le.maxlength_prepayment_rider,le.maxlength_prepayment_term,le.maxlength_asses_land_use,le.maxlength_res_indicator,le.maxlength_construction_loan,le.maxlength_inter_family,le.maxlength_cash_purchase,le.maxlength_stand_alone_refi,le.maxlength_equity_credit_line,le.maxlength_reo_flag,le.maxlength_distressedsaleflag);
  SELF.avelength := CHOOSE(C,le.avelength_foreclosure_id,le.avelength_ln_filedate,le.avelength_bk_infile_type,le.avelength_fips_cd,le.avelength_prop_full_addr,le.avelength_prop_addr_city,le.avelength_prop_addr_state,le.avelength_prop_addr_zip5,le.avelength_prop_addr_zip4,le.avelength_prop_addr_unit_type,le.avelength_prop_addr_unit_no,le.avelength_prop_addr_house_no,le.avelength_prop_addr_predir,le.avelength_prop_addr_street,le.avelength_prop_addr_suffix,le.avelength_prop_addr_postdir,le.avelength_prop_addr_carrier_rt,le.avelength_recording_date,le.avelength_recording_book_num,le.avelength_recording_page_num,le.avelength_recording_doc_num,le.avelength_doc_type_cd,le.avelength_apn,le.avelength_multi_apn,le.avelength_partial_interest_trans,le.avelength_seller1_fname,le.avelength_seller1_lname,le.avelength_seller1_id,le.avelength_seller2_fname,le.avelength_seller2_lname,le.avelength_buyer1_fname,le.avelength_buyer1_lname,le.avelength_buyer1_id_cd,le.avelength_buyer2_fname,le.avelength_buyer2_lname,le.avelength_buyer_vesting_cd,le.avelength_concurrent_doc_num,le.avelength_buyer_mail_city,le.avelength_buyer_mail_state,le.avelength_buyer_mail_zip5,le.avelength_buyer_mail_zip4,le.avelength_legal_lot_cd,le.avelength_legal_lot_num,le.avelength_legal_block,le.avelength_legal_section,le.avelength_legal_district,le.avelength_legal_land_lot,le.avelength_legal_unit,le.avelength_legacl_city,le.avelength_legal_subdivision,le.avelength_legal_phase_num,le.avelength_legal_tract_num,le.avelength_legal_brief_desc,le.avelength_legal_township,le.avelength_recorder_map_ref,le.avelength_prop_buyer_mail_addr_cd,le.avelength_property_use_cd,le.avelength_orig_contract_date,le.avelength_sales_price,le.avelength_sales_price_cd,le.avelength_city_xfer_tax,le.avelength_county_xfer_tax,le.avelength_total_xfer_tax,le.avelength_concurrent_lender_name,le.avelength_concurrent_lender_type,le.avelength_concurrent_loan_amt,le.avelength_concurrent_loan_type,le.avelength_concurrent_type_fin,le.avelength_concurrent_interest_rate,le.avelength_concurrent_due_dt,le.avelength_concurrent_2nd_loan_amt,le.avelength_buyer_mail_full_addr,le.avelength_buyer_mail_unit_type,le.avelength_buyer_mail_unit_no,le.avelength_lps_internal_pid,le.avelength_buyer_mail_careof,le.avelength_title_co_name,le.avelength_legal_desc_cd,le.avelength_adj_rate_rider,le.avelength_adj_rate_index,le.avelength_change_index,le.avelength_rate_change_freq,le.avelength_int_rate_ngt,le.avelength_int_rate_nlt,le.avelength_max_int_rate,le.avelength_int_only_period,le.avelength_fixed_rate_rider,le.avelength_first_chg_dt_yy,le.avelength_first_chg_dt_mmdd,le.avelength_prepayment_rider,le.avelength_prepayment_term,le.avelength_asses_land_use,le.avelength_res_indicator,le.avelength_construction_loan,le.avelength_inter_family,le.avelength_cash_purchase,le.avelength_stand_alone_refi,le.avelength_equity_credit_line,le.avelength_reo_flag,le.avelength_distressedsaleflag);
END;
EXPORT invSummary := NORMALIZE(summary0, 100, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.foreclosure_id),TRIM((SALT311.StrType)le.ln_filedate),TRIM((SALT311.StrType)le.bk_infile_type),TRIM((SALT311.StrType)le.fips_cd),TRIM((SALT311.StrType)le.prop_full_addr),TRIM((SALT311.StrType)le.prop_addr_city),TRIM((SALT311.StrType)le.prop_addr_state),TRIM((SALT311.StrType)le.prop_addr_zip5),TRIM((SALT311.StrType)le.prop_addr_zip4),TRIM((SALT311.StrType)le.prop_addr_unit_type),TRIM((SALT311.StrType)le.prop_addr_unit_no),TRIM((SALT311.StrType)le.prop_addr_house_no),TRIM((SALT311.StrType)le.prop_addr_predir),TRIM((SALT311.StrType)le.prop_addr_street),TRIM((SALT311.StrType)le.prop_addr_suffix),TRIM((SALT311.StrType)le.prop_addr_postdir),TRIM((SALT311.StrType)le.prop_addr_carrier_rt),TRIM((SALT311.StrType)le.recording_date),TRIM((SALT311.StrType)le.recording_book_num),TRIM((SALT311.StrType)le.recording_page_num),TRIM((SALT311.StrType)le.recording_doc_num),TRIM((SALT311.StrType)le.doc_type_cd),TRIM((SALT311.StrType)le.apn),TRIM((SALT311.StrType)le.multi_apn),TRIM((SALT311.StrType)le.partial_interest_trans),TRIM((SALT311.StrType)le.seller1_fname),TRIM((SALT311.StrType)le.seller1_lname),TRIM((SALT311.StrType)le.seller1_id),TRIM((SALT311.StrType)le.seller2_fname),TRIM((SALT311.StrType)le.seller2_lname),TRIM((SALT311.StrType)le.buyer1_fname),TRIM((SALT311.StrType)le.buyer1_lname),TRIM((SALT311.StrType)le.buyer1_id_cd),TRIM((SALT311.StrType)le.buyer2_fname),TRIM((SALT311.StrType)le.buyer2_lname),TRIM((SALT311.StrType)le.buyer_vesting_cd),TRIM((SALT311.StrType)le.concurrent_doc_num),TRIM((SALT311.StrType)le.buyer_mail_city),TRIM((SALT311.StrType)le.buyer_mail_state),TRIM((SALT311.StrType)le.buyer_mail_zip5),TRIM((SALT311.StrType)le.buyer_mail_zip4),TRIM((SALT311.StrType)le.legal_lot_cd),TRIM((SALT311.StrType)le.legal_lot_num),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_section),TRIM((SALT311.StrType)le.legal_district),TRIM((SALT311.StrType)le.legal_land_lot),TRIM((SALT311.StrType)le.legal_unit),TRIM((SALT311.StrType)le.legacl_city),TRIM((SALT311.StrType)le.legal_subdivision),TRIM((SALT311.StrType)le.legal_phase_num),TRIM((SALT311.StrType)le.legal_tract_num),TRIM((SALT311.StrType)le.legal_brief_desc),TRIM((SALT311.StrType)le.legal_township),TRIM((SALT311.StrType)le.recorder_map_ref),TRIM((SALT311.StrType)le.prop_buyer_mail_addr_cd),TRIM((SALT311.StrType)le.property_use_cd),TRIM((SALT311.StrType)le.orig_contract_date),TRIM((SALT311.StrType)le.sales_price),TRIM((SALT311.StrType)le.sales_price_cd),TRIM((SALT311.StrType)le.city_xfer_tax),TRIM((SALT311.StrType)le.county_xfer_tax),TRIM((SALT311.StrType)le.total_xfer_tax),TRIM((SALT311.StrType)le.concurrent_lender_name),TRIM((SALT311.StrType)le.concurrent_lender_type),TRIM((SALT311.StrType)le.concurrent_loan_amt),TRIM((SALT311.StrType)le.concurrent_loan_type),TRIM((SALT311.StrType)le.concurrent_type_fin),TRIM((SALT311.StrType)le.concurrent_interest_rate),TRIM((SALT311.StrType)le.concurrent_due_dt),TRIM((SALT311.StrType)le.concurrent_2nd_loan_amt),TRIM((SALT311.StrType)le.buyer_mail_full_addr),TRIM((SALT311.StrType)le.buyer_mail_unit_type),TRIM((SALT311.StrType)le.buyer_mail_unit_no),TRIM((SALT311.StrType)le.lps_internal_pid),TRIM((SALT311.StrType)le.buyer_mail_careof),TRIM((SALT311.StrType)le.title_co_name),TRIM((SALT311.StrType)le.legal_desc_cd),TRIM((SALT311.StrType)le.adj_rate_rider),TRIM((SALT311.StrType)le.adj_rate_index),TRIM((SALT311.StrType)le.change_index),TRIM((SALT311.StrType)le.rate_change_freq),TRIM((SALT311.StrType)le.int_rate_ngt),TRIM((SALT311.StrType)le.int_rate_nlt),TRIM((SALT311.StrType)le.max_int_rate),TRIM((SALT311.StrType)le.int_only_period),TRIM((SALT311.StrType)le.fixed_rate_rider),TRIM((SALT311.StrType)le.first_chg_dt_yy),TRIM((SALT311.StrType)le.first_chg_dt_mmdd),TRIM((SALT311.StrType)le.prepayment_rider),TRIM((SALT311.StrType)le.prepayment_term),TRIM((SALT311.StrType)le.asses_land_use),TRIM((SALT311.StrType)le.res_indicator),TRIM((SALT311.StrType)le.construction_loan),TRIM((SALT311.StrType)le.inter_family),TRIM((SALT311.StrType)le.cash_purchase),TRIM((SALT311.StrType)le.stand_alone_refi),TRIM((SALT311.StrType)le.equity_credit_line),TRIM((SALT311.StrType)le.reo_flag),TRIM((SALT311.StrType)le.distressedsaleflag)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,100,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 100);
  SELF.FldNo2 := 1 + (C % 100);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.foreclosure_id),TRIM((SALT311.StrType)le.ln_filedate),TRIM((SALT311.StrType)le.bk_infile_type),TRIM((SALT311.StrType)le.fips_cd),TRIM((SALT311.StrType)le.prop_full_addr),TRIM((SALT311.StrType)le.prop_addr_city),TRIM((SALT311.StrType)le.prop_addr_state),TRIM((SALT311.StrType)le.prop_addr_zip5),TRIM((SALT311.StrType)le.prop_addr_zip4),TRIM((SALT311.StrType)le.prop_addr_unit_type),TRIM((SALT311.StrType)le.prop_addr_unit_no),TRIM((SALT311.StrType)le.prop_addr_house_no),TRIM((SALT311.StrType)le.prop_addr_predir),TRIM((SALT311.StrType)le.prop_addr_street),TRIM((SALT311.StrType)le.prop_addr_suffix),TRIM((SALT311.StrType)le.prop_addr_postdir),TRIM((SALT311.StrType)le.prop_addr_carrier_rt),TRIM((SALT311.StrType)le.recording_date),TRIM((SALT311.StrType)le.recording_book_num),TRIM((SALT311.StrType)le.recording_page_num),TRIM((SALT311.StrType)le.recording_doc_num),TRIM((SALT311.StrType)le.doc_type_cd),TRIM((SALT311.StrType)le.apn),TRIM((SALT311.StrType)le.multi_apn),TRIM((SALT311.StrType)le.partial_interest_trans),TRIM((SALT311.StrType)le.seller1_fname),TRIM((SALT311.StrType)le.seller1_lname),TRIM((SALT311.StrType)le.seller1_id),TRIM((SALT311.StrType)le.seller2_fname),TRIM((SALT311.StrType)le.seller2_lname),TRIM((SALT311.StrType)le.buyer1_fname),TRIM((SALT311.StrType)le.buyer1_lname),TRIM((SALT311.StrType)le.buyer1_id_cd),TRIM((SALT311.StrType)le.buyer2_fname),TRIM((SALT311.StrType)le.buyer2_lname),TRIM((SALT311.StrType)le.buyer_vesting_cd),TRIM((SALT311.StrType)le.concurrent_doc_num),TRIM((SALT311.StrType)le.buyer_mail_city),TRIM((SALT311.StrType)le.buyer_mail_state),TRIM((SALT311.StrType)le.buyer_mail_zip5),TRIM((SALT311.StrType)le.buyer_mail_zip4),TRIM((SALT311.StrType)le.legal_lot_cd),TRIM((SALT311.StrType)le.legal_lot_num),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_section),TRIM((SALT311.StrType)le.legal_district),TRIM((SALT311.StrType)le.legal_land_lot),TRIM((SALT311.StrType)le.legal_unit),TRIM((SALT311.StrType)le.legacl_city),TRIM((SALT311.StrType)le.legal_subdivision),TRIM((SALT311.StrType)le.legal_phase_num),TRIM((SALT311.StrType)le.legal_tract_num),TRIM((SALT311.StrType)le.legal_brief_desc),TRIM((SALT311.StrType)le.legal_township),TRIM((SALT311.StrType)le.recorder_map_ref),TRIM((SALT311.StrType)le.prop_buyer_mail_addr_cd),TRIM((SALT311.StrType)le.property_use_cd),TRIM((SALT311.StrType)le.orig_contract_date),TRIM((SALT311.StrType)le.sales_price),TRIM((SALT311.StrType)le.sales_price_cd),TRIM((SALT311.StrType)le.city_xfer_tax),TRIM((SALT311.StrType)le.county_xfer_tax),TRIM((SALT311.StrType)le.total_xfer_tax),TRIM((SALT311.StrType)le.concurrent_lender_name),TRIM((SALT311.StrType)le.concurrent_lender_type),TRIM((SALT311.StrType)le.concurrent_loan_amt),TRIM((SALT311.StrType)le.concurrent_loan_type),TRIM((SALT311.StrType)le.concurrent_type_fin),TRIM((SALT311.StrType)le.concurrent_interest_rate),TRIM((SALT311.StrType)le.concurrent_due_dt),TRIM((SALT311.StrType)le.concurrent_2nd_loan_amt),TRIM((SALT311.StrType)le.buyer_mail_full_addr),TRIM((SALT311.StrType)le.buyer_mail_unit_type),TRIM((SALT311.StrType)le.buyer_mail_unit_no),TRIM((SALT311.StrType)le.lps_internal_pid),TRIM((SALT311.StrType)le.buyer_mail_careof),TRIM((SALT311.StrType)le.title_co_name),TRIM((SALT311.StrType)le.legal_desc_cd),TRIM((SALT311.StrType)le.adj_rate_rider),TRIM((SALT311.StrType)le.adj_rate_index),TRIM((SALT311.StrType)le.change_index),TRIM((SALT311.StrType)le.rate_change_freq),TRIM((SALT311.StrType)le.int_rate_ngt),TRIM((SALT311.StrType)le.int_rate_nlt),TRIM((SALT311.StrType)le.max_int_rate),TRIM((SALT311.StrType)le.int_only_period),TRIM((SALT311.StrType)le.fixed_rate_rider),TRIM((SALT311.StrType)le.first_chg_dt_yy),TRIM((SALT311.StrType)le.first_chg_dt_mmdd),TRIM((SALT311.StrType)le.prepayment_rider),TRIM((SALT311.StrType)le.prepayment_term),TRIM((SALT311.StrType)le.asses_land_use),TRIM((SALT311.StrType)le.res_indicator),TRIM((SALT311.StrType)le.construction_loan),TRIM((SALT311.StrType)le.inter_family),TRIM((SALT311.StrType)le.cash_purchase),TRIM((SALT311.StrType)le.stand_alone_refi),TRIM((SALT311.StrType)le.equity_credit_line),TRIM((SALT311.StrType)le.reo_flag),TRIM((SALT311.StrType)le.distressedsaleflag)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.foreclosure_id),TRIM((SALT311.StrType)le.ln_filedate),TRIM((SALT311.StrType)le.bk_infile_type),TRIM((SALT311.StrType)le.fips_cd),TRIM((SALT311.StrType)le.prop_full_addr),TRIM((SALT311.StrType)le.prop_addr_city),TRIM((SALT311.StrType)le.prop_addr_state),TRIM((SALT311.StrType)le.prop_addr_zip5),TRIM((SALT311.StrType)le.prop_addr_zip4),TRIM((SALT311.StrType)le.prop_addr_unit_type),TRIM((SALT311.StrType)le.prop_addr_unit_no),TRIM((SALT311.StrType)le.prop_addr_house_no),TRIM((SALT311.StrType)le.prop_addr_predir),TRIM((SALT311.StrType)le.prop_addr_street),TRIM((SALT311.StrType)le.prop_addr_suffix),TRIM((SALT311.StrType)le.prop_addr_postdir),TRIM((SALT311.StrType)le.prop_addr_carrier_rt),TRIM((SALT311.StrType)le.recording_date),TRIM((SALT311.StrType)le.recording_book_num),TRIM((SALT311.StrType)le.recording_page_num),TRIM((SALT311.StrType)le.recording_doc_num),TRIM((SALT311.StrType)le.doc_type_cd),TRIM((SALT311.StrType)le.apn),TRIM((SALT311.StrType)le.multi_apn),TRIM((SALT311.StrType)le.partial_interest_trans),TRIM((SALT311.StrType)le.seller1_fname),TRIM((SALT311.StrType)le.seller1_lname),TRIM((SALT311.StrType)le.seller1_id),TRIM((SALT311.StrType)le.seller2_fname),TRIM((SALT311.StrType)le.seller2_lname),TRIM((SALT311.StrType)le.buyer1_fname),TRIM((SALT311.StrType)le.buyer1_lname),TRIM((SALT311.StrType)le.buyer1_id_cd),TRIM((SALT311.StrType)le.buyer2_fname),TRIM((SALT311.StrType)le.buyer2_lname),TRIM((SALT311.StrType)le.buyer_vesting_cd),TRIM((SALT311.StrType)le.concurrent_doc_num),TRIM((SALT311.StrType)le.buyer_mail_city),TRIM((SALT311.StrType)le.buyer_mail_state),TRIM((SALT311.StrType)le.buyer_mail_zip5),TRIM((SALT311.StrType)le.buyer_mail_zip4),TRIM((SALT311.StrType)le.legal_lot_cd),TRIM((SALT311.StrType)le.legal_lot_num),TRIM((SALT311.StrType)le.legal_block),TRIM((SALT311.StrType)le.legal_section),TRIM((SALT311.StrType)le.legal_district),TRIM((SALT311.StrType)le.legal_land_lot),TRIM((SALT311.StrType)le.legal_unit),TRIM((SALT311.StrType)le.legacl_city),TRIM((SALT311.StrType)le.legal_subdivision),TRIM((SALT311.StrType)le.legal_phase_num),TRIM((SALT311.StrType)le.legal_tract_num),TRIM((SALT311.StrType)le.legal_brief_desc),TRIM((SALT311.StrType)le.legal_township),TRIM((SALT311.StrType)le.recorder_map_ref),TRIM((SALT311.StrType)le.prop_buyer_mail_addr_cd),TRIM((SALT311.StrType)le.property_use_cd),TRIM((SALT311.StrType)le.orig_contract_date),TRIM((SALT311.StrType)le.sales_price),TRIM((SALT311.StrType)le.sales_price_cd),TRIM((SALT311.StrType)le.city_xfer_tax),TRIM((SALT311.StrType)le.county_xfer_tax),TRIM((SALT311.StrType)le.total_xfer_tax),TRIM((SALT311.StrType)le.concurrent_lender_name),TRIM((SALT311.StrType)le.concurrent_lender_type),TRIM((SALT311.StrType)le.concurrent_loan_amt),TRIM((SALT311.StrType)le.concurrent_loan_type),TRIM((SALT311.StrType)le.concurrent_type_fin),TRIM((SALT311.StrType)le.concurrent_interest_rate),TRIM((SALT311.StrType)le.concurrent_due_dt),TRIM((SALT311.StrType)le.concurrent_2nd_loan_amt),TRIM((SALT311.StrType)le.buyer_mail_full_addr),TRIM((SALT311.StrType)le.buyer_mail_unit_type),TRIM((SALT311.StrType)le.buyer_mail_unit_no),TRIM((SALT311.StrType)le.lps_internal_pid),TRIM((SALT311.StrType)le.buyer_mail_careof),TRIM((SALT311.StrType)le.title_co_name),TRIM((SALT311.StrType)le.legal_desc_cd),TRIM((SALT311.StrType)le.adj_rate_rider),TRIM((SALT311.StrType)le.adj_rate_index),TRIM((SALT311.StrType)le.change_index),TRIM((SALT311.StrType)le.rate_change_freq),TRIM((SALT311.StrType)le.int_rate_ngt),TRIM((SALT311.StrType)le.int_rate_nlt),TRIM((SALT311.StrType)le.max_int_rate),TRIM((SALT311.StrType)le.int_only_period),TRIM((SALT311.StrType)le.fixed_rate_rider),TRIM((SALT311.StrType)le.first_chg_dt_yy),TRIM((SALT311.StrType)le.first_chg_dt_mmdd),TRIM((SALT311.StrType)le.prepayment_rider),TRIM((SALT311.StrType)le.prepayment_term),TRIM((SALT311.StrType)le.asses_land_use),TRIM((SALT311.StrType)le.res_indicator),TRIM((SALT311.StrType)le.construction_loan),TRIM((SALT311.StrType)le.inter_family),TRIM((SALT311.StrType)le.cash_purchase),TRIM((SALT311.StrType)le.stand_alone_refi),TRIM((SALT311.StrType)le.equity_credit_line),TRIM((SALT311.StrType)le.reo_flag),TRIM((SALT311.StrType)le.distressedsaleflag)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),100*100,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'foreclosure_id'}
      ,{2,'ln_filedate'}
      ,{3,'bk_infile_type'}
      ,{4,'fips_cd'}
      ,{5,'prop_full_addr'}
      ,{6,'prop_addr_city'}
      ,{7,'prop_addr_state'}
      ,{8,'prop_addr_zip5'}
      ,{9,'prop_addr_zip4'}
      ,{10,'prop_addr_unit_type'}
      ,{11,'prop_addr_unit_no'}
      ,{12,'prop_addr_house_no'}
      ,{13,'prop_addr_predir'}
      ,{14,'prop_addr_street'}
      ,{15,'prop_addr_suffix'}
      ,{16,'prop_addr_postdir'}
      ,{17,'prop_addr_carrier_rt'}
      ,{18,'recording_date'}
      ,{19,'recording_book_num'}
      ,{20,'recording_page_num'}
      ,{21,'recording_doc_num'}
      ,{22,'doc_type_cd'}
      ,{23,'apn'}
      ,{24,'multi_apn'}
      ,{25,'partial_interest_trans'}
      ,{26,'seller1_fname'}
      ,{27,'seller1_lname'}
      ,{28,'seller1_id'}
      ,{29,'seller2_fname'}
      ,{30,'seller2_lname'}
      ,{31,'buyer1_fname'}
      ,{32,'buyer1_lname'}
      ,{33,'buyer1_id_cd'}
      ,{34,'buyer2_fname'}
      ,{35,'buyer2_lname'}
      ,{36,'buyer_vesting_cd'}
      ,{37,'concurrent_doc_num'}
      ,{38,'buyer_mail_city'}
      ,{39,'buyer_mail_state'}
      ,{40,'buyer_mail_zip5'}
      ,{41,'buyer_mail_zip4'}
      ,{42,'legal_lot_cd'}
      ,{43,'legal_lot_num'}
      ,{44,'legal_block'}
      ,{45,'legal_section'}
      ,{46,'legal_district'}
      ,{47,'legal_land_lot'}
      ,{48,'legal_unit'}
      ,{49,'legacl_city'}
      ,{50,'legal_subdivision'}
      ,{51,'legal_phase_num'}
      ,{52,'legal_tract_num'}
      ,{53,'legal_brief_desc'}
      ,{54,'legal_township'}
      ,{55,'recorder_map_ref'}
      ,{56,'prop_buyer_mail_addr_cd'}
      ,{57,'property_use_cd'}
      ,{58,'orig_contract_date'}
      ,{59,'sales_price'}
      ,{60,'sales_price_cd'}
      ,{61,'city_xfer_tax'}
      ,{62,'county_xfer_tax'}
      ,{63,'total_xfer_tax'}
      ,{64,'concurrent_lender_name'}
      ,{65,'concurrent_lender_type'}
      ,{66,'concurrent_loan_amt'}
      ,{67,'concurrent_loan_type'}
      ,{68,'concurrent_type_fin'}
      ,{69,'concurrent_interest_rate'}
      ,{70,'concurrent_due_dt'}
      ,{71,'concurrent_2nd_loan_amt'}
      ,{72,'buyer_mail_full_addr'}
      ,{73,'buyer_mail_unit_type'}
      ,{74,'buyer_mail_unit_no'}
      ,{75,'lps_internal_pid'}
      ,{76,'buyer_mail_careof'}
      ,{77,'title_co_name'}
      ,{78,'legal_desc_cd'}
      ,{79,'adj_rate_rider'}
      ,{80,'adj_rate_index'}
      ,{81,'change_index'}
      ,{82,'rate_change_freq'}
      ,{83,'int_rate_ngt'}
      ,{84,'int_rate_nlt'}
      ,{85,'max_int_rate'}
      ,{86,'int_only_period'}
      ,{87,'fixed_rate_rider'}
      ,{88,'first_chg_dt_yy'}
      ,{89,'first_chg_dt_mmdd'}
      ,{90,'prepayment_rider'}
      ,{91,'prepayment_term'}
      ,{92,'asses_land_use'}
      ,{93,'res_indicator'}
      ,{94,'construction_loan'}
      ,{95,'inter_family'}
      ,{96,'cash_purchase'}
      ,{97,'stand_alone_refi'}
      ,{98,'equity_credit_line'}
      ,{99,'reo_flag'}
      ,{100,'distressedsaleflag'}],SALT311.MAC_Character_Counts.Field_Identification);
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
    Fields.InValid_fips_cd((SALT311.StrType)le.fips_cd),
    Fields.InValid_prop_full_addr((SALT311.StrType)le.prop_full_addr),
    Fields.InValid_prop_addr_city((SALT311.StrType)le.prop_addr_city),
    Fields.InValid_prop_addr_state((SALT311.StrType)le.prop_addr_state),
    Fields.InValid_prop_addr_zip5((SALT311.StrType)le.prop_addr_zip5),
    Fields.InValid_prop_addr_zip4((SALT311.StrType)le.prop_addr_zip4),
    Fields.InValid_prop_addr_unit_type((SALT311.StrType)le.prop_addr_unit_type),
    Fields.InValid_prop_addr_unit_no((SALT311.StrType)le.prop_addr_unit_no),
    Fields.InValid_prop_addr_house_no((SALT311.StrType)le.prop_addr_house_no),
    Fields.InValid_prop_addr_predir((SALT311.StrType)le.prop_addr_predir),
    Fields.InValid_prop_addr_street((SALT311.StrType)le.prop_addr_street),
    Fields.InValid_prop_addr_suffix((SALT311.StrType)le.prop_addr_suffix),
    Fields.InValid_prop_addr_postdir((SALT311.StrType)le.prop_addr_postdir),
    Fields.InValid_prop_addr_carrier_rt((SALT311.StrType)le.prop_addr_carrier_rt),
    Fields.InValid_recording_date((SALT311.StrType)le.recording_date),
    Fields.InValid_recording_book_num((SALT311.StrType)le.recording_book_num),
    Fields.InValid_recording_page_num((SALT311.StrType)le.recording_page_num),
    Fields.InValid_recording_doc_num((SALT311.StrType)le.recording_doc_num),
    Fields.InValid_doc_type_cd((SALT311.StrType)le.doc_type_cd),
    Fields.InValid_apn((SALT311.StrType)le.apn),
    Fields.InValid_multi_apn((SALT311.StrType)le.multi_apn),
    Fields.InValid_partial_interest_trans((SALT311.StrType)le.partial_interest_trans),
    Fields.InValid_seller1_fname((SALT311.StrType)le.seller1_fname),
    Fields.InValid_seller1_lname((SALT311.StrType)le.seller1_lname),
    Fields.InValid_seller1_id((SALT311.StrType)le.seller1_id),
    Fields.InValid_seller2_fname((SALT311.StrType)le.seller2_fname),
    Fields.InValid_seller2_lname((SALT311.StrType)le.seller2_lname),
    Fields.InValid_buyer1_fname((SALT311.StrType)le.buyer1_fname),
    Fields.InValid_buyer1_lname((SALT311.StrType)le.buyer1_lname),
    Fields.InValid_buyer1_id_cd((SALT311.StrType)le.buyer1_id_cd),
    Fields.InValid_buyer2_fname((SALT311.StrType)le.buyer2_fname),
    Fields.InValid_buyer2_lname((SALT311.StrType)le.buyer2_lname),
    Fields.InValid_buyer_vesting_cd((SALT311.StrType)le.buyer_vesting_cd),
    Fields.InValid_concurrent_doc_num((SALT311.StrType)le.concurrent_doc_num),
    Fields.InValid_buyer_mail_city((SALT311.StrType)le.buyer_mail_city),
    Fields.InValid_buyer_mail_state((SALT311.StrType)le.buyer_mail_state),
    Fields.InValid_buyer_mail_zip5((SALT311.StrType)le.buyer_mail_zip5),
    Fields.InValid_buyer_mail_zip4((SALT311.StrType)le.buyer_mail_zip4),
    Fields.InValid_legal_lot_cd((SALT311.StrType)le.legal_lot_cd),
    Fields.InValid_legal_lot_num((SALT311.StrType)le.legal_lot_num),
    Fields.InValid_legal_block((SALT311.StrType)le.legal_block),
    Fields.InValid_legal_section((SALT311.StrType)le.legal_section),
    Fields.InValid_legal_district((SALT311.StrType)le.legal_district),
    Fields.InValid_legal_land_lot((SALT311.StrType)le.legal_land_lot),
    Fields.InValid_legal_unit((SALT311.StrType)le.legal_unit),
    Fields.InValid_legacl_city((SALT311.StrType)le.legacl_city),
    Fields.InValid_legal_subdivision((SALT311.StrType)le.legal_subdivision),
    Fields.InValid_legal_phase_num((SALT311.StrType)le.legal_phase_num),
    Fields.InValid_legal_tract_num((SALT311.StrType)le.legal_tract_num),
    Fields.InValid_legal_brief_desc((SALT311.StrType)le.legal_brief_desc),
    Fields.InValid_legal_township((SALT311.StrType)le.legal_township),
    Fields.InValid_recorder_map_ref((SALT311.StrType)le.recorder_map_ref),
    Fields.InValid_prop_buyer_mail_addr_cd((SALT311.StrType)le.prop_buyer_mail_addr_cd),
    Fields.InValid_property_use_cd((SALT311.StrType)le.property_use_cd),
    Fields.InValid_orig_contract_date((SALT311.StrType)le.orig_contract_date),
    Fields.InValid_sales_price((SALT311.StrType)le.sales_price),
    Fields.InValid_sales_price_cd((SALT311.StrType)le.sales_price_cd),
    Fields.InValid_city_xfer_tax((SALT311.StrType)le.city_xfer_tax),
    Fields.InValid_county_xfer_tax((SALT311.StrType)le.county_xfer_tax),
    Fields.InValid_total_xfer_tax((SALT311.StrType)le.total_xfer_tax),
    Fields.InValid_concurrent_lender_name((SALT311.StrType)le.concurrent_lender_name),
    Fields.InValid_concurrent_lender_type((SALT311.StrType)le.concurrent_lender_type),
    Fields.InValid_concurrent_loan_amt((SALT311.StrType)le.concurrent_loan_amt),
    Fields.InValid_concurrent_loan_type((SALT311.StrType)le.concurrent_loan_type),
    Fields.InValid_concurrent_type_fin((SALT311.StrType)le.concurrent_type_fin),
    Fields.InValid_concurrent_interest_rate((SALT311.StrType)le.concurrent_interest_rate),
    Fields.InValid_concurrent_due_dt((SALT311.StrType)le.concurrent_due_dt),
    Fields.InValid_concurrent_2nd_loan_amt((SALT311.StrType)le.concurrent_2nd_loan_amt),
    Fields.InValid_buyer_mail_full_addr((SALT311.StrType)le.buyer_mail_full_addr),
    Fields.InValid_buyer_mail_unit_type((SALT311.StrType)le.buyer_mail_unit_type),
    Fields.InValid_buyer_mail_unit_no((SALT311.StrType)le.buyer_mail_unit_no),
    Fields.InValid_lps_internal_pid((SALT311.StrType)le.lps_internal_pid),
    Fields.InValid_buyer_mail_careof((SALT311.StrType)le.buyer_mail_careof),
    Fields.InValid_title_co_name((SALT311.StrType)le.title_co_name),
    Fields.InValid_legal_desc_cd((SALT311.StrType)le.legal_desc_cd),
    Fields.InValid_adj_rate_rider((SALT311.StrType)le.adj_rate_rider),
    Fields.InValid_adj_rate_index((SALT311.StrType)le.adj_rate_index),
    Fields.InValid_change_index((SALT311.StrType)le.change_index),
    Fields.InValid_rate_change_freq((SALT311.StrType)le.rate_change_freq),
    Fields.InValid_int_rate_ngt((SALT311.StrType)le.int_rate_ngt),
    Fields.InValid_int_rate_nlt((SALT311.StrType)le.int_rate_nlt),
    Fields.InValid_max_int_rate((SALT311.StrType)le.max_int_rate),
    Fields.InValid_int_only_period((SALT311.StrType)le.int_only_period),
    Fields.InValid_fixed_rate_rider((SALT311.StrType)le.fixed_rate_rider),
    Fields.InValid_first_chg_dt_yy((SALT311.StrType)le.first_chg_dt_yy),
    Fields.InValid_first_chg_dt_mmdd((SALT311.StrType)le.first_chg_dt_mmdd),
    Fields.InValid_prepayment_rider((SALT311.StrType)le.prepayment_rider),
    Fields.InValid_prepayment_term((SALT311.StrType)le.prepayment_term),
    Fields.InValid_asses_land_use((SALT311.StrType)le.asses_land_use),
    Fields.InValid_res_indicator((SALT311.StrType)le.res_indicator),
    Fields.InValid_construction_loan((SALT311.StrType)le.construction_loan),
    Fields.InValid_inter_family((SALT311.StrType)le.inter_family),
    Fields.InValid_cash_purchase((SALT311.StrType)le.cash_purchase),
    Fields.InValid_stand_alone_refi((SALT311.StrType)le.stand_alone_refi),
    Fields.InValid_equity_credit_line((SALT311.StrType)le.equity_credit_line),
    Fields.InValid_reo_flag((SALT311.StrType)le.reo_flag),
    Fields.InValid_distressedsaleflag((SALT311.StrType)le.distressedsaleflag),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,100,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','invalid_date','Unknown','invalid_number','invalid_addr','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','invalid_document_code','invalid_apn','Unknown','Unknown','invalid_name','invalid_name','Unknown','invalid_name','invalid_name','invalid_name','invalid_name','Unknown','invalid_name','invalid_name','Unknown','Unknown','invalid_AlphaNum','invalid_state','invalid_zip','invalid_zip','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_property_code','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_lender_type_code','Unknown','invalid_loan_type_code','Unknown','Unknown','invalid_date','Unknown','invalid_addr','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_land_use_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_foreclosure_id(TotalErrors.ErrorNum),Fields.InValidMessage_ln_filedate(TotalErrors.ErrorNum),Fields.InValidMessage_bk_infile_type(TotalErrors.ErrorNum),Fields.InValidMessage_fips_cd(TotalErrors.ErrorNum),Fields.InValidMessage_prop_full_addr(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_city(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_state(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_unit_type(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_unit_no(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_house_no(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_street(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_carrier_rt(TotalErrors.ErrorNum),Fields.InValidMessage_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_recording_book_num(TotalErrors.ErrorNum),Fields.InValidMessage_recording_page_num(TotalErrors.ErrorNum),Fields.InValidMessage_recording_doc_num(TotalErrors.ErrorNum),Fields.InValidMessage_doc_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_apn(TotalErrors.ErrorNum),Fields.InValidMessage_multi_apn(TotalErrors.ErrorNum),Fields.InValidMessage_partial_interest_trans(TotalErrors.ErrorNum),Fields.InValidMessage_seller1_fname(TotalErrors.ErrorNum),Fields.InValidMessage_seller1_lname(TotalErrors.ErrorNum),Fields.InValidMessage_seller1_id(TotalErrors.ErrorNum),Fields.InValidMessage_seller2_fname(TotalErrors.ErrorNum),Fields.InValidMessage_seller2_lname(TotalErrors.ErrorNum),Fields.InValidMessage_buyer1_fname(TotalErrors.ErrorNum),Fields.InValidMessage_buyer1_lname(TotalErrors.ErrorNum),Fields.InValidMessage_buyer1_id_cd(TotalErrors.ErrorNum),Fields.InValidMessage_buyer2_fname(TotalErrors.ErrorNum),Fields.InValidMessage_buyer2_lname(TotalErrors.ErrorNum),Fields.InValidMessage_buyer_vesting_cd(TotalErrors.ErrorNum),Fields.InValidMessage_concurrent_doc_num(TotalErrors.ErrorNum),Fields.InValidMessage_buyer_mail_city(TotalErrors.ErrorNum),Fields.InValidMessage_buyer_mail_state(TotalErrors.ErrorNum),Fields.InValidMessage_buyer_mail_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_buyer_mail_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_legal_lot_cd(TotalErrors.ErrorNum),Fields.InValidMessage_legal_lot_num(TotalErrors.ErrorNum),Fields.InValidMessage_legal_block(TotalErrors.ErrorNum),Fields.InValidMessage_legal_section(TotalErrors.ErrorNum),Fields.InValidMessage_legal_district(TotalErrors.ErrorNum),Fields.InValidMessage_legal_land_lot(TotalErrors.ErrorNum),Fields.InValidMessage_legal_unit(TotalErrors.ErrorNum),Fields.InValidMessage_legacl_city(TotalErrors.ErrorNum),Fields.InValidMessage_legal_subdivision(TotalErrors.ErrorNum),Fields.InValidMessage_legal_phase_num(TotalErrors.ErrorNum),Fields.InValidMessage_legal_tract_num(TotalErrors.ErrorNum),Fields.InValidMessage_legal_brief_desc(TotalErrors.ErrorNum),Fields.InValidMessage_legal_township(TotalErrors.ErrorNum),Fields.InValidMessage_recorder_map_ref(TotalErrors.ErrorNum),Fields.InValidMessage_prop_buyer_mail_addr_cd(TotalErrors.ErrorNum),Fields.InValidMessage_property_use_cd(TotalErrors.ErrorNum),Fields.InValidMessage_orig_contract_date(TotalErrors.ErrorNum),Fields.InValidMessage_sales_price(TotalErrors.ErrorNum),Fields.InValidMessage_sales_price_cd(TotalErrors.ErrorNum),Fields.InValidMessage_city_xfer_tax(TotalErrors.ErrorNum),Fields.InValidMessage_county_xfer_tax(TotalErrors.ErrorNum),Fields.InValidMessage_total_xfer_tax(TotalErrors.ErrorNum),Fields.InValidMessage_concurrent_lender_name(TotalErrors.ErrorNum),Fields.InValidMessage_concurrent_lender_type(TotalErrors.ErrorNum),Fields.InValidMessage_concurrent_loan_amt(TotalErrors.ErrorNum),Fields.InValidMessage_concurrent_loan_type(TotalErrors.ErrorNum),Fields.InValidMessage_concurrent_type_fin(TotalErrors.ErrorNum),Fields.InValidMessage_concurrent_interest_rate(TotalErrors.ErrorNum),Fields.InValidMessage_concurrent_due_dt(TotalErrors.ErrorNum),Fields.InValidMessage_concurrent_2nd_loan_amt(TotalErrors.ErrorNum),Fields.InValidMessage_buyer_mail_full_addr(TotalErrors.ErrorNum),Fields.InValidMessage_buyer_mail_unit_type(TotalErrors.ErrorNum),Fields.InValidMessage_buyer_mail_unit_no(TotalErrors.ErrorNum),Fields.InValidMessage_lps_internal_pid(TotalErrors.ErrorNum),Fields.InValidMessage_buyer_mail_careof(TotalErrors.ErrorNum),Fields.InValidMessage_title_co_name(TotalErrors.ErrorNum),Fields.InValidMessage_legal_desc_cd(TotalErrors.ErrorNum),Fields.InValidMessage_adj_rate_rider(TotalErrors.ErrorNum),Fields.InValidMessage_adj_rate_index(TotalErrors.ErrorNum),Fields.InValidMessage_change_index(TotalErrors.ErrorNum),Fields.InValidMessage_rate_change_freq(TotalErrors.ErrorNum),Fields.InValidMessage_int_rate_ngt(TotalErrors.ErrorNum),Fields.InValidMessage_int_rate_nlt(TotalErrors.ErrorNum),Fields.InValidMessage_max_int_rate(TotalErrors.ErrorNum),Fields.InValidMessage_int_only_period(TotalErrors.ErrorNum),Fields.InValidMessage_fixed_rate_rider(TotalErrors.ErrorNum),Fields.InValidMessage_first_chg_dt_yy(TotalErrors.ErrorNum),Fields.InValidMessage_first_chg_dt_mmdd(TotalErrors.ErrorNum),Fields.InValidMessage_prepayment_rider(TotalErrors.ErrorNum),Fields.InValidMessage_prepayment_term(TotalErrors.ErrorNum),Fields.InValidMessage_asses_land_use(TotalErrors.ErrorNum),Fields.InValidMessage_res_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_construction_loan(TotalErrors.ErrorNum),Fields.InValidMessage_inter_family(TotalErrors.ErrorNum),Fields.InValidMessage_cash_purchase(TotalErrors.ErrorNum),Fields.InValidMessage_stand_alone_refi(TotalErrors.ErrorNum),Fields.InValidMessage_equity_credit_line(TotalErrors.ErrorNum),Fields.InValidMessage_reo_flag(TotalErrors.ErrorNum),Fields.InValidMessage_distressedsaleflag(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BKForeclosure_Reo, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
