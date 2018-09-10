IMPORT SALT311,STD;
EXPORT Document_hygiene(dataset(Document_layout_Official_Records) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_vendor_cnt := COUNT(GROUP,h.vendor <> (TYPEOF(h.vendor))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_state_origin_cnt := COUNT(GROUP,h.state_origin <> (TYPEOF(h.state_origin))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_county_name_cnt := COUNT(GROUP,h.county_name <> (TYPEOF(h.county_name))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_official_record_key_cnt := COUNT(GROUP,h.official_record_key <> (TYPEOF(h.official_record_key))'');
    populated_official_record_key_pcnt := AVE(GROUP,IF(h.official_record_key = (TYPEOF(h.official_record_key))'',0,100));
    maxlength_official_record_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.official_record_key)));
    avelength_official_record_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.official_record_key)),h.official_record_key<>(typeof(h.official_record_key))'');
    populated_fips_st_cnt := COUNT(GROUP,h.fips_st <> (TYPEOF(h.fips_st))'');
    populated_fips_st_pcnt := AVE(GROUP,IF(h.fips_st = (TYPEOF(h.fips_st))'',0,100));
    maxlength_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_st)));
    avelength_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_st)),h.fips_st<>(typeof(h.fips_st))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_batch_id_cnt := COUNT(GROUP,h.batch_id <> (TYPEOF(h.batch_id))'');
    populated_batch_id_pcnt := AVE(GROUP,IF(h.batch_id = (TYPEOF(h.batch_id))'',0,100));
    maxlength_batch_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.batch_id)));
    avelength_batch_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.batch_id)),h.batch_id<>(typeof(h.batch_id))'');
    populated_doc_serial_num_cnt := COUNT(GROUP,h.doc_serial_num <> (TYPEOF(h.doc_serial_num))'');
    populated_doc_serial_num_pcnt := AVE(GROUP,IF(h.doc_serial_num = (TYPEOF(h.doc_serial_num))'',0,100));
    maxlength_doc_serial_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_serial_num)));
    avelength_doc_serial_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_serial_num)),h.doc_serial_num<>(typeof(h.doc_serial_num))'');
    populated_doc_instrument_or_clerk_filing_num_cnt := COUNT(GROUP,h.doc_instrument_or_clerk_filing_num <> (TYPEOF(h.doc_instrument_or_clerk_filing_num))'');
    populated_doc_instrument_or_clerk_filing_num_pcnt := AVE(GROUP,IF(h.doc_instrument_or_clerk_filing_num = (TYPEOF(h.doc_instrument_or_clerk_filing_num))'',0,100));
    maxlength_doc_instrument_or_clerk_filing_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_instrument_or_clerk_filing_num)));
    avelength_doc_instrument_or_clerk_filing_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_instrument_or_clerk_filing_num)),h.doc_instrument_or_clerk_filing_num<>(typeof(h.doc_instrument_or_clerk_filing_num))'');
    populated_doc_num_dummy_flag_cnt := COUNT(GROUP,h.doc_num_dummy_flag <> (TYPEOF(h.doc_num_dummy_flag))'');
    populated_doc_num_dummy_flag_pcnt := AVE(GROUP,IF(h.doc_num_dummy_flag = (TYPEOF(h.doc_num_dummy_flag))'',0,100));
    maxlength_doc_num_dummy_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_num_dummy_flag)));
    avelength_doc_num_dummy_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_num_dummy_flag)),h.doc_num_dummy_flag<>(typeof(h.doc_num_dummy_flag))'');
    populated_doc_filed_dt_cnt := COUNT(GROUP,h.doc_filed_dt <> (TYPEOF(h.doc_filed_dt))'');
    populated_doc_filed_dt_pcnt := AVE(GROUP,IF(h.doc_filed_dt = (TYPEOF(h.doc_filed_dt))'',0,100));
    maxlength_doc_filed_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_filed_dt)));
    avelength_doc_filed_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_filed_dt)),h.doc_filed_dt<>(typeof(h.doc_filed_dt))'');
    populated_doc_record_dt_cnt := COUNT(GROUP,h.doc_record_dt <> (TYPEOF(h.doc_record_dt))'');
    populated_doc_record_dt_pcnt := AVE(GROUP,IF(h.doc_record_dt = (TYPEOF(h.doc_record_dt))'',0,100));
    maxlength_doc_record_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_record_dt)));
    avelength_doc_record_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_record_dt)),h.doc_record_dt<>(typeof(h.doc_record_dt))'');
    populated_doc_type_cd_cnt := COUNT(GROUP,h.doc_type_cd <> (TYPEOF(h.doc_type_cd))'');
    populated_doc_type_cd_pcnt := AVE(GROUP,IF(h.doc_type_cd = (TYPEOF(h.doc_type_cd))'',0,100));
    maxlength_doc_type_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_type_cd)));
    avelength_doc_type_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_type_cd)),h.doc_type_cd<>(typeof(h.doc_type_cd))'');
    populated_doc_type_desc_cnt := COUNT(GROUP,h.doc_type_desc <> (TYPEOF(h.doc_type_desc))'');
    populated_doc_type_desc_pcnt := AVE(GROUP,IF(h.doc_type_desc = (TYPEOF(h.doc_type_desc))'',0,100));
    maxlength_doc_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_type_desc)));
    avelength_doc_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_type_desc)),h.doc_type_desc<>(typeof(h.doc_type_desc))'');
    populated_doc_other_desc_cnt := COUNT(GROUP,h.doc_other_desc <> (TYPEOF(h.doc_other_desc))'');
    populated_doc_other_desc_pcnt := AVE(GROUP,IF(h.doc_other_desc = (TYPEOF(h.doc_other_desc))'',0,100));
    maxlength_doc_other_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_other_desc)));
    avelength_doc_other_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_other_desc)),h.doc_other_desc<>(typeof(h.doc_other_desc))'');
    populated_doc_page_count_cnt := COUNT(GROUP,h.doc_page_count <> (TYPEOF(h.doc_page_count))'');
    populated_doc_page_count_pcnt := AVE(GROUP,IF(h.doc_page_count = (TYPEOF(h.doc_page_count))'',0,100));
    maxlength_doc_page_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_page_count)));
    avelength_doc_page_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_page_count)),h.doc_page_count<>(typeof(h.doc_page_count))'');
    populated_doc_names_count_cnt := COUNT(GROUP,h.doc_names_count <> (TYPEOF(h.doc_names_count))'');
    populated_doc_names_count_pcnt := AVE(GROUP,IF(h.doc_names_count = (TYPEOF(h.doc_names_count))'',0,100));
    maxlength_doc_names_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_names_count)));
    avelength_doc_names_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_names_count)),h.doc_names_count<>(typeof(h.doc_names_count))'');
    populated_doc_status_cd_cnt := COUNT(GROUP,h.doc_status_cd <> (TYPEOF(h.doc_status_cd))'');
    populated_doc_status_cd_pcnt := AVE(GROUP,IF(h.doc_status_cd = (TYPEOF(h.doc_status_cd))'',0,100));
    maxlength_doc_status_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_status_cd)));
    avelength_doc_status_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_status_cd)),h.doc_status_cd<>(typeof(h.doc_status_cd))'');
    populated_doc_status_desc_cnt := COUNT(GROUP,h.doc_status_desc <> (TYPEOF(h.doc_status_desc))'');
    populated_doc_status_desc_pcnt := AVE(GROUP,IF(h.doc_status_desc = (TYPEOF(h.doc_status_desc))'',0,100));
    maxlength_doc_status_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_status_desc)));
    avelength_doc_status_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_status_desc)),h.doc_status_desc<>(typeof(h.doc_status_desc))'');
    populated_doc_amend_cd_cnt := COUNT(GROUP,h.doc_amend_cd <> (TYPEOF(h.doc_amend_cd))'');
    populated_doc_amend_cd_pcnt := AVE(GROUP,IF(h.doc_amend_cd = (TYPEOF(h.doc_amend_cd))'',0,100));
    maxlength_doc_amend_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_amend_cd)));
    avelength_doc_amend_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_amend_cd)),h.doc_amend_cd<>(typeof(h.doc_amend_cd))'');
    populated_doc_amend_desc_cnt := COUNT(GROUP,h.doc_amend_desc <> (TYPEOF(h.doc_amend_desc))'');
    populated_doc_amend_desc_pcnt := AVE(GROUP,IF(h.doc_amend_desc = (TYPEOF(h.doc_amend_desc))'',0,100));
    maxlength_doc_amend_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_amend_desc)));
    avelength_doc_amend_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_amend_desc)),h.doc_amend_desc<>(typeof(h.doc_amend_desc))'');
    populated_execution_dt_cnt := COUNT(GROUP,h.execution_dt <> (TYPEOF(h.execution_dt))'');
    populated_execution_dt_pcnt := AVE(GROUP,IF(h.execution_dt = (TYPEOF(h.execution_dt))'',0,100));
    maxlength_execution_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.execution_dt)));
    avelength_execution_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.execution_dt)),h.execution_dt<>(typeof(h.execution_dt))'');
    populated_consideration_amt_cnt := COUNT(GROUP,h.consideration_amt <> (TYPEOF(h.consideration_amt))'');
    populated_consideration_amt_pcnt := AVE(GROUP,IF(h.consideration_amt = (TYPEOF(h.consideration_amt))'',0,100));
    maxlength_consideration_amt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.consideration_amt)));
    avelength_consideration_amt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.consideration_amt)),h.consideration_amt<>(typeof(h.consideration_amt))'');
    populated_assumption_amt_cnt := COUNT(GROUP,h.assumption_amt <> (TYPEOF(h.assumption_amt))'');
    populated_assumption_amt_pcnt := AVE(GROUP,IF(h.assumption_amt = (TYPEOF(h.assumption_amt))'',0,100));
    maxlength_assumption_amt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assumption_amt)));
    avelength_assumption_amt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assumption_amt)),h.assumption_amt<>(typeof(h.assumption_amt))'');
    populated_certified_mail_fee_cnt := COUNT(GROUP,h.certified_mail_fee <> (TYPEOF(h.certified_mail_fee))'');
    populated_certified_mail_fee_pcnt := AVE(GROUP,IF(h.certified_mail_fee = (TYPEOF(h.certified_mail_fee))'',0,100));
    maxlength_certified_mail_fee := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.certified_mail_fee)));
    avelength_certified_mail_fee := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.certified_mail_fee)),h.certified_mail_fee<>(typeof(h.certified_mail_fee))'');
    populated_service_charge_cnt := COUNT(GROUP,h.service_charge <> (TYPEOF(h.service_charge))'');
    populated_service_charge_pcnt := AVE(GROUP,IF(h.service_charge = (TYPEOF(h.service_charge))'',0,100));
    maxlength_service_charge := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.service_charge)));
    avelength_service_charge := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.service_charge)),h.service_charge<>(typeof(h.service_charge))'');
    populated_trust_amt_cnt := COUNT(GROUP,h.trust_amt <> (TYPEOF(h.trust_amt))'');
    populated_trust_amt_pcnt := AVE(GROUP,IF(h.trust_amt = (TYPEOF(h.trust_amt))'',0,100));
    maxlength_trust_amt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trust_amt)));
    avelength_trust_amt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trust_amt)),h.trust_amt<>(typeof(h.trust_amt))'');
    populated_transfer__cnt := COUNT(GROUP,h.transfer_ <> (TYPEOF(h.transfer_))'');
    populated_transfer__pcnt := AVE(GROUP,IF(h.transfer_ = (TYPEOF(h.transfer_))'',0,100));
    maxlength_transfer_ := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transfer_)));
    avelength_transfer_ := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transfer_)),h.transfer_<>(typeof(h.transfer_))'');
    populated_mortgage_cnt := COUNT(GROUP,h.mortgage <> (TYPEOF(h.mortgage))'');
    populated_mortgage_pcnt := AVE(GROUP,IF(h.mortgage = (TYPEOF(h.mortgage))'',0,100));
    maxlength_mortgage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage)));
    avelength_mortgage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage)),h.mortgage<>(typeof(h.mortgage))'');
    populated_intangible_tax_amt_cnt := COUNT(GROUP,h.intangible_tax_amt <> (TYPEOF(h.intangible_tax_amt))'');
    populated_intangible_tax_amt_pcnt := AVE(GROUP,IF(h.intangible_tax_amt = (TYPEOF(h.intangible_tax_amt))'',0,100));
    maxlength_intangible_tax_amt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.intangible_tax_amt)));
    avelength_intangible_tax_amt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.intangible_tax_amt)),h.intangible_tax_amt<>(typeof(h.intangible_tax_amt))'');
    populated_intangible_tax_penalty_cnt := COUNT(GROUP,h.intangible_tax_penalty <> (TYPEOF(h.intangible_tax_penalty))'');
    populated_intangible_tax_penalty_pcnt := AVE(GROUP,IF(h.intangible_tax_penalty = (TYPEOF(h.intangible_tax_penalty))'',0,100));
    maxlength_intangible_tax_penalty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.intangible_tax_penalty)));
    avelength_intangible_tax_penalty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.intangible_tax_penalty)),h.intangible_tax_penalty<>(typeof(h.intangible_tax_penalty))'');
    populated_excise_tax_amt_cnt := COUNT(GROUP,h.excise_tax_amt <> (TYPEOF(h.excise_tax_amt))'');
    populated_excise_tax_amt_pcnt := AVE(GROUP,IF(h.excise_tax_amt = (TYPEOF(h.excise_tax_amt))'',0,100));
    maxlength_excise_tax_amt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.excise_tax_amt)));
    avelength_excise_tax_amt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.excise_tax_amt)),h.excise_tax_amt<>(typeof(h.excise_tax_amt))'');
    populated_recording_fee_cnt := COUNT(GROUP,h.recording_fee <> (TYPEOF(h.recording_fee))'');
    populated_recording_fee_pcnt := AVE(GROUP,IF(h.recording_fee = (TYPEOF(h.recording_fee))'',0,100));
    maxlength_recording_fee := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_fee)));
    avelength_recording_fee := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recording_fee)),h.recording_fee<>(typeof(h.recording_fee))'');
    populated_documentary_stamps_fee_cnt := COUNT(GROUP,h.documentary_stamps_fee <> (TYPEOF(h.documentary_stamps_fee))'');
    populated_documentary_stamps_fee_pcnt := AVE(GROUP,IF(h.documentary_stamps_fee = (TYPEOF(h.documentary_stamps_fee))'',0,100));
    maxlength_documentary_stamps_fee := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.documentary_stamps_fee)));
    avelength_documentary_stamps_fee := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.documentary_stamps_fee)),h.documentary_stamps_fee<>(typeof(h.documentary_stamps_fee))'');
    populated_doc_stamps_mtg_fee_cnt := COUNT(GROUP,h.doc_stamps_mtg_fee <> (TYPEOF(h.doc_stamps_mtg_fee))'');
    populated_doc_stamps_mtg_fee_pcnt := AVE(GROUP,IF(h.doc_stamps_mtg_fee = (TYPEOF(h.doc_stamps_mtg_fee))'',0,100));
    maxlength_doc_stamps_mtg_fee := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_stamps_mtg_fee)));
    avelength_doc_stamps_mtg_fee := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_stamps_mtg_fee)),h.doc_stamps_mtg_fee<>(typeof(h.doc_stamps_mtg_fee))'');
    populated_book_num_cnt := COUNT(GROUP,h.book_num <> (TYPEOF(h.book_num))'');
    populated_book_num_pcnt := AVE(GROUP,IF(h.book_num = (TYPEOF(h.book_num))'',0,100));
    maxlength_book_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.book_num)));
    avelength_book_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.book_num)),h.book_num<>(typeof(h.book_num))'');
    populated_page_num_cnt := COUNT(GROUP,h.page_num <> (TYPEOF(h.page_num))'');
    populated_page_num_pcnt := AVE(GROUP,IF(h.page_num = (TYPEOF(h.page_num))'',0,100));
    maxlength_page_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.page_num)));
    avelength_page_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.page_num)),h.page_num<>(typeof(h.page_num))'');
    populated_book_type_cd_cnt := COUNT(GROUP,h.book_type_cd <> (TYPEOF(h.book_type_cd))'');
    populated_book_type_cd_pcnt := AVE(GROUP,IF(h.book_type_cd = (TYPEOF(h.book_type_cd))'',0,100));
    maxlength_book_type_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.book_type_cd)));
    avelength_book_type_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.book_type_cd)),h.book_type_cd<>(typeof(h.book_type_cd))'');
    populated_book_type_desc_cnt := COUNT(GROUP,h.book_type_desc <> (TYPEOF(h.book_type_desc))'');
    populated_book_type_desc_pcnt := AVE(GROUP,IF(h.book_type_desc = (TYPEOF(h.book_type_desc))'',0,100));
    maxlength_book_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.book_type_desc)));
    avelength_book_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.book_type_desc)),h.book_type_desc<>(typeof(h.book_type_desc))'');
    populated_parcel_or_case_num_cnt := COUNT(GROUP,h.parcel_or_case_num <> (TYPEOF(h.parcel_or_case_num))'');
    populated_parcel_or_case_num_pcnt := AVE(GROUP,IF(h.parcel_or_case_num = (TYPEOF(h.parcel_or_case_num))'',0,100));
    maxlength_parcel_or_case_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parcel_or_case_num)));
    avelength_parcel_or_case_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parcel_or_case_num)),h.parcel_or_case_num<>(typeof(h.parcel_or_case_num))'');
    populated_formatted_parcel_num_cnt := COUNT(GROUP,h.formatted_parcel_num <> (TYPEOF(h.formatted_parcel_num))'');
    populated_formatted_parcel_num_pcnt := AVE(GROUP,IF(h.formatted_parcel_num = (TYPEOF(h.formatted_parcel_num))'',0,100));
    maxlength_formatted_parcel_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.formatted_parcel_num)));
    avelength_formatted_parcel_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.formatted_parcel_num)),h.formatted_parcel_num<>(typeof(h.formatted_parcel_num))'');
    populated_legal_desc_1_cnt := COUNT(GROUP,h.legal_desc_1 <> (TYPEOF(h.legal_desc_1))'');
    populated_legal_desc_1_pcnt := AVE(GROUP,IF(h.legal_desc_1 = (TYPEOF(h.legal_desc_1))'',0,100));
    maxlength_legal_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_1)));
    avelength_legal_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_1)),h.legal_desc_1<>(typeof(h.legal_desc_1))'');
    populated_legal_desc_2_cnt := COUNT(GROUP,h.legal_desc_2 <> (TYPEOF(h.legal_desc_2))'');
    populated_legal_desc_2_pcnt := AVE(GROUP,IF(h.legal_desc_2 = (TYPEOF(h.legal_desc_2))'',0,100));
    maxlength_legal_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_2)));
    avelength_legal_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_2)),h.legal_desc_2<>(typeof(h.legal_desc_2))'');
    populated_legal_desc_3_cnt := COUNT(GROUP,h.legal_desc_3 <> (TYPEOF(h.legal_desc_3))'');
    populated_legal_desc_3_pcnt := AVE(GROUP,IF(h.legal_desc_3 = (TYPEOF(h.legal_desc_3))'',0,100));
    maxlength_legal_desc_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_3)));
    avelength_legal_desc_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_3)),h.legal_desc_3<>(typeof(h.legal_desc_3))'');
    populated_legal_desc_4_cnt := COUNT(GROUP,h.legal_desc_4 <> (TYPEOF(h.legal_desc_4))'');
    populated_legal_desc_4_pcnt := AVE(GROUP,IF(h.legal_desc_4 = (TYPEOF(h.legal_desc_4))'',0,100));
    maxlength_legal_desc_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_4)));
    avelength_legal_desc_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_4)),h.legal_desc_4<>(typeof(h.legal_desc_4))'');
    populated_legal_desc_5_cnt := COUNT(GROUP,h.legal_desc_5 <> (TYPEOF(h.legal_desc_5))'');
    populated_legal_desc_5_pcnt := AVE(GROUP,IF(h.legal_desc_5 = (TYPEOF(h.legal_desc_5))'',0,100));
    maxlength_legal_desc_5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_5)));
    avelength_legal_desc_5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.legal_desc_5)),h.legal_desc_5<>(typeof(h.legal_desc_5))'');
    populated_verified_flag_cnt := COUNT(GROUP,h.verified_flag <> (TYPEOF(h.verified_flag))'');
    populated_verified_flag_pcnt := AVE(GROUP,IF(h.verified_flag = (TYPEOF(h.verified_flag))'',0,100));
    maxlength_verified_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.verified_flag)));
    avelength_verified_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.verified_flag)),h.verified_flag<>(typeof(h.verified_flag))'');
    populated_address_1_cnt := COUNT(GROUP,h.address_1 <> (TYPEOF(h.address_1))'');
    populated_address_1_pcnt := AVE(GROUP,IF(h.address_1 = (TYPEOF(h.address_1))'',0,100));
    maxlength_address_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_1)));
    avelength_address_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_1)),h.address_1<>(typeof(h.address_1))'');
    populated_address_2_cnt := COUNT(GROUP,h.address_2 <> (TYPEOF(h.address_2))'');
    populated_address_2_pcnt := AVE(GROUP,IF(h.address_2 = (TYPEOF(h.address_2))'',0,100));
    maxlength_address_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_2)));
    avelength_address_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_2)),h.address_2<>(typeof(h.address_2))'');
    populated_address_3_cnt := COUNT(GROUP,h.address_3 <> (TYPEOF(h.address_3))'');
    populated_address_3_pcnt := AVE(GROUP,IF(h.address_3 = (TYPEOF(h.address_3))'',0,100));
    maxlength_address_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_3)));
    avelength_address_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_3)),h.address_3<>(typeof(h.address_3))'');
    populated_address_4_cnt := COUNT(GROUP,h.address_4 <> (TYPEOF(h.address_4))'');
    populated_address_4_pcnt := AVE(GROUP,IF(h.address_4 = (TYPEOF(h.address_4))'',0,100));
    maxlength_address_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_4)));
    avelength_address_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_4)),h.address_4<>(typeof(h.address_4))'');
    populated_prior_doc_file_num_cnt := COUNT(GROUP,h.prior_doc_file_num <> (TYPEOF(h.prior_doc_file_num))'');
    populated_prior_doc_file_num_pcnt := AVE(GROUP,IF(h.prior_doc_file_num = (TYPEOF(h.prior_doc_file_num))'',0,100));
    maxlength_prior_doc_file_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_doc_file_num)));
    avelength_prior_doc_file_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_doc_file_num)),h.prior_doc_file_num<>(typeof(h.prior_doc_file_num))'');
    populated_prior_doc_type_cd_cnt := COUNT(GROUP,h.prior_doc_type_cd <> (TYPEOF(h.prior_doc_type_cd))'');
    populated_prior_doc_type_cd_pcnt := AVE(GROUP,IF(h.prior_doc_type_cd = (TYPEOF(h.prior_doc_type_cd))'',0,100));
    maxlength_prior_doc_type_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_doc_type_cd)));
    avelength_prior_doc_type_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_doc_type_cd)),h.prior_doc_type_cd<>(typeof(h.prior_doc_type_cd))'');
    populated_prior_doc_type_desc_cnt := COUNT(GROUP,h.prior_doc_type_desc <> (TYPEOF(h.prior_doc_type_desc))'');
    populated_prior_doc_type_desc_pcnt := AVE(GROUP,IF(h.prior_doc_type_desc = (TYPEOF(h.prior_doc_type_desc))'',0,100));
    maxlength_prior_doc_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_doc_type_desc)));
    avelength_prior_doc_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_doc_type_desc)),h.prior_doc_type_desc<>(typeof(h.prior_doc_type_desc))'');
    populated_prior_book_num_cnt := COUNT(GROUP,h.prior_book_num <> (TYPEOF(h.prior_book_num))'');
    populated_prior_book_num_pcnt := AVE(GROUP,IF(h.prior_book_num = (TYPEOF(h.prior_book_num))'',0,100));
    maxlength_prior_book_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_book_num)));
    avelength_prior_book_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_book_num)),h.prior_book_num<>(typeof(h.prior_book_num))'');
    populated_prior_page_num_cnt := COUNT(GROUP,h.prior_page_num <> (TYPEOF(h.prior_page_num))'');
    populated_prior_page_num_pcnt := AVE(GROUP,IF(h.prior_page_num = (TYPEOF(h.prior_page_num))'',0,100));
    maxlength_prior_page_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_page_num)));
    avelength_prior_page_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_page_num)),h.prior_page_num<>(typeof(h.prior_page_num))'');
    populated_prior_book_type_cd_cnt := COUNT(GROUP,h.prior_book_type_cd <> (TYPEOF(h.prior_book_type_cd))'');
    populated_prior_book_type_cd_pcnt := AVE(GROUP,IF(h.prior_book_type_cd = (TYPEOF(h.prior_book_type_cd))'',0,100));
    maxlength_prior_book_type_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_book_type_cd)));
    avelength_prior_book_type_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_book_type_cd)),h.prior_book_type_cd<>(typeof(h.prior_book_type_cd))'');
    populated_prior_book_type_desc_cnt := COUNT(GROUP,h.prior_book_type_desc <> (TYPEOF(h.prior_book_type_desc))'');
    populated_prior_book_type_desc_pcnt := AVE(GROUP,IF(h.prior_book_type_desc = (TYPEOF(h.prior_book_type_desc))'',0,100));
    maxlength_prior_book_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_book_type_desc)));
    avelength_prior_book_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prior_book_type_desc)),h.prior_book_type_desc<>(typeof(h.prior_book_type_desc))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_ace_fips_county_cnt := COUNT(GROUP,h.ace_fips_county <> (TYPEOF(h.ace_fips_county))'');
    populated_ace_fips_county_pcnt := AVE(GROUP,IF(h.ace_fips_county = (TYPEOF(h.ace_fips_county))'',0,100));
    maxlength_ace_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_county)));
    avelength_ace_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_county)),h.ace_fips_county<>(typeof(h.ace_fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_official_record_key_pcnt *   0.00 / 100 + T.Populated_fips_st_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_batch_id_pcnt *   0.00 / 100 + T.Populated_doc_serial_num_pcnt *   0.00 / 100 + T.Populated_doc_instrument_or_clerk_filing_num_pcnt *   0.00 / 100 + T.Populated_doc_num_dummy_flag_pcnt *   0.00 / 100 + T.Populated_doc_filed_dt_pcnt *   0.00 / 100 + T.Populated_doc_record_dt_pcnt *   0.00 / 100 + T.Populated_doc_type_cd_pcnt *   0.00 / 100 + T.Populated_doc_type_desc_pcnt *   0.00 / 100 + T.Populated_doc_other_desc_pcnt *   0.00 / 100 + T.Populated_doc_page_count_pcnt *   0.00 / 100 + T.Populated_doc_names_count_pcnt *   0.00 / 100 + T.Populated_doc_status_cd_pcnt *   0.00 / 100 + T.Populated_doc_status_desc_pcnt *   0.00 / 100 + T.Populated_doc_amend_cd_pcnt *   0.00 / 100 + T.Populated_doc_amend_desc_pcnt *   0.00 / 100 + T.Populated_execution_dt_pcnt *   0.00 / 100 + T.Populated_consideration_amt_pcnt *   0.00 / 100 + T.Populated_assumption_amt_pcnt *   0.00 / 100 + T.Populated_certified_mail_fee_pcnt *   0.00 / 100 + T.Populated_service_charge_pcnt *   0.00 / 100 + T.Populated_trust_amt_pcnt *   0.00 / 100 + T.Populated_transfer__pcnt *   0.00 / 100 + T.Populated_mortgage_pcnt *   0.00 / 100 + T.Populated_intangible_tax_amt_pcnt *   0.00 / 100 + T.Populated_intangible_tax_penalty_pcnt *   0.00 / 100 + T.Populated_excise_tax_amt_pcnt *   0.00 / 100 + T.Populated_recording_fee_pcnt *   0.00 / 100 + T.Populated_documentary_stamps_fee_pcnt *   0.00 / 100 + T.Populated_doc_stamps_mtg_fee_pcnt *   0.00 / 100 + T.Populated_book_num_pcnt *   0.00 / 100 + T.Populated_page_num_pcnt *   0.00 / 100 + T.Populated_book_type_cd_pcnt *   0.00 / 100 + T.Populated_book_type_desc_pcnt *   0.00 / 100 + T.Populated_parcel_or_case_num_pcnt *   0.00 / 100 + T.Populated_formatted_parcel_num_pcnt *   0.00 / 100 + T.Populated_legal_desc_1_pcnt *   0.00 / 100 + T.Populated_legal_desc_2_pcnt *   0.00 / 100 + T.Populated_legal_desc_3_pcnt *   0.00 / 100 + T.Populated_legal_desc_4_pcnt *   0.00 / 100 + T.Populated_legal_desc_5_pcnt *   0.00 / 100 + T.Populated_verified_flag_pcnt *   0.00 / 100 + T.Populated_address_1_pcnt *   0.00 / 100 + T.Populated_address_2_pcnt *   0.00 / 100 + T.Populated_address_3_pcnt *   0.00 / 100 + T.Populated_address_4_pcnt *   0.00 / 100 + T.Populated_prior_doc_file_num_pcnt *   0.00 / 100 + T.Populated_prior_doc_type_cd_pcnt *   0.00 / 100 + T.Populated_prior_doc_type_desc_pcnt *   0.00 / 100 + T.Populated_prior_book_num_pcnt *   0.00 / 100 + T.Populated_prior_page_num_pcnt *   0.00 / 100 + T.Populated_prior_book_type_cd_pcnt *   0.00 / 100 + T.Populated_prior_book_type_desc_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_ace_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'process_date','vendor','state_origin','county_name','official_record_key','fips_st','fips_county','batch_id','doc_serial_num','doc_instrument_or_clerk_filing_num','doc_num_dummy_flag','doc_filed_dt','doc_record_dt','doc_type_cd','doc_type_desc','doc_other_desc','doc_page_count','doc_names_count','doc_status_cd','doc_status_desc','doc_amend_cd','doc_amend_desc','execution_dt','consideration_amt','assumption_amt','certified_mail_fee','service_charge','trust_amt','transfer_','mortgage','intangible_tax_amt','intangible_tax_penalty','excise_tax_amt','recording_fee','documentary_stamps_fee','doc_stamps_mtg_fee','book_num','page_num','book_type_cd','book_type_desc','parcel_or_case_num','formatted_parcel_num','legal_desc_1','legal_desc_2','legal_desc_3','legal_desc_4','legal_desc_5','verified_flag','address_1','address_2','address_3','address_4','prior_doc_file_num','prior_doc_type_cd','prior_doc_type_desc','prior_book_num','prior_page_num','prior_book_type_cd','prior_book_type_desc','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_vendor_pcnt,le.populated_state_origin_pcnt,le.populated_county_name_pcnt,le.populated_official_record_key_pcnt,le.populated_fips_st_pcnt,le.populated_fips_county_pcnt,le.populated_batch_id_pcnt,le.populated_doc_serial_num_pcnt,le.populated_doc_instrument_or_clerk_filing_num_pcnt,le.populated_doc_num_dummy_flag_pcnt,le.populated_doc_filed_dt_pcnt,le.populated_doc_record_dt_pcnt,le.populated_doc_type_cd_pcnt,le.populated_doc_type_desc_pcnt,le.populated_doc_other_desc_pcnt,le.populated_doc_page_count_pcnt,le.populated_doc_names_count_pcnt,le.populated_doc_status_cd_pcnt,le.populated_doc_status_desc_pcnt,le.populated_doc_amend_cd_pcnt,le.populated_doc_amend_desc_pcnt,le.populated_execution_dt_pcnt,le.populated_consideration_amt_pcnt,le.populated_assumption_amt_pcnt,le.populated_certified_mail_fee_pcnt,le.populated_service_charge_pcnt,le.populated_trust_amt_pcnt,le.populated_transfer__pcnt,le.populated_mortgage_pcnt,le.populated_intangible_tax_amt_pcnt,le.populated_intangible_tax_penalty_pcnt,le.populated_excise_tax_amt_pcnt,le.populated_recording_fee_pcnt,le.populated_documentary_stamps_fee_pcnt,le.populated_doc_stamps_mtg_fee_pcnt,le.populated_book_num_pcnt,le.populated_page_num_pcnt,le.populated_book_type_cd_pcnt,le.populated_book_type_desc_pcnt,le.populated_parcel_or_case_num_pcnt,le.populated_formatted_parcel_num_pcnt,le.populated_legal_desc_1_pcnt,le.populated_legal_desc_2_pcnt,le.populated_legal_desc_3_pcnt,le.populated_legal_desc_4_pcnt,le.populated_legal_desc_5_pcnt,le.populated_verified_flag_pcnt,le.populated_address_1_pcnt,le.populated_address_2_pcnt,le.populated_address_3_pcnt,le.populated_address_4_pcnt,le.populated_prior_doc_file_num_pcnt,le.populated_prior_doc_type_cd_pcnt,le.populated_prior_doc_type_desc_pcnt,le.populated_prior_book_num_pcnt,le.populated_prior_page_num_pcnt,le.populated_prior_book_type_cd_pcnt,le.populated_prior_book_type_desc_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_ace_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_vendor,le.maxlength_state_origin,le.maxlength_county_name,le.maxlength_official_record_key,le.maxlength_fips_st,le.maxlength_fips_county,le.maxlength_batch_id,le.maxlength_doc_serial_num,le.maxlength_doc_instrument_or_clerk_filing_num,le.maxlength_doc_num_dummy_flag,le.maxlength_doc_filed_dt,le.maxlength_doc_record_dt,le.maxlength_doc_type_cd,le.maxlength_doc_type_desc,le.maxlength_doc_other_desc,le.maxlength_doc_page_count,le.maxlength_doc_names_count,le.maxlength_doc_status_cd,le.maxlength_doc_status_desc,le.maxlength_doc_amend_cd,le.maxlength_doc_amend_desc,le.maxlength_execution_dt,le.maxlength_consideration_amt,le.maxlength_assumption_amt,le.maxlength_certified_mail_fee,le.maxlength_service_charge,le.maxlength_trust_amt,le.maxlength_transfer_,le.maxlength_mortgage,le.maxlength_intangible_tax_amt,le.maxlength_intangible_tax_penalty,le.maxlength_excise_tax_amt,le.maxlength_recording_fee,le.maxlength_documentary_stamps_fee,le.maxlength_doc_stamps_mtg_fee,le.maxlength_book_num,le.maxlength_page_num,le.maxlength_book_type_cd,le.maxlength_book_type_desc,le.maxlength_parcel_or_case_num,le.maxlength_formatted_parcel_num,le.maxlength_legal_desc_1,le.maxlength_legal_desc_2,le.maxlength_legal_desc_3,le.maxlength_legal_desc_4,le.maxlength_legal_desc_5,le.maxlength_verified_flag,le.maxlength_address_1,le.maxlength_address_2,le.maxlength_address_3,le.maxlength_address_4,le.maxlength_prior_doc_file_num,le.maxlength_prior_doc_type_cd,le.maxlength_prior_doc_type_desc,le.maxlength_prior_book_num,le.maxlength_prior_page_num,le.maxlength_prior_book_type_cd,le.maxlength_prior_book_type_desc,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_ace_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_vendor,le.avelength_state_origin,le.avelength_county_name,le.avelength_official_record_key,le.avelength_fips_st,le.avelength_fips_county,le.avelength_batch_id,le.avelength_doc_serial_num,le.avelength_doc_instrument_or_clerk_filing_num,le.avelength_doc_num_dummy_flag,le.avelength_doc_filed_dt,le.avelength_doc_record_dt,le.avelength_doc_type_cd,le.avelength_doc_type_desc,le.avelength_doc_other_desc,le.avelength_doc_page_count,le.avelength_doc_names_count,le.avelength_doc_status_cd,le.avelength_doc_status_desc,le.avelength_doc_amend_cd,le.avelength_doc_amend_desc,le.avelength_execution_dt,le.avelength_consideration_amt,le.avelength_assumption_amt,le.avelength_certified_mail_fee,le.avelength_service_charge,le.avelength_trust_amt,le.avelength_transfer_,le.avelength_mortgage,le.avelength_intangible_tax_amt,le.avelength_intangible_tax_penalty,le.avelength_excise_tax_amt,le.avelength_recording_fee,le.avelength_documentary_stamps_fee,le.avelength_doc_stamps_mtg_fee,le.avelength_book_num,le.avelength_page_num,le.avelength_book_type_cd,le.avelength_book_type_desc,le.avelength_parcel_or_case_num,le.avelength_formatted_parcel_num,le.avelength_legal_desc_1,le.avelength_legal_desc_2,le.avelength_legal_desc_3,le.avelength_legal_desc_4,le.avelength_legal_desc_5,le.avelength_verified_flag,le.avelength_address_1,le.avelength_address_2,le.avelength_address_3,le.avelength_address_4,le.avelength_prior_doc_file_num,le.avelength_prior_doc_type_cd,le.avelength_prior_doc_type_desc,le.avelength_prior_book_num,le.avelength_prior_page_num,le.avelength_prior_book_type_cd,le.avelength_prior_book_type_desc,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_ace_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 86, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.official_record_key),TRIM((SALT311.StrType)le.fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.batch_id),TRIM((SALT311.StrType)le.doc_serial_num),TRIM((SALT311.StrType)le.doc_instrument_or_clerk_filing_num),TRIM((SALT311.StrType)le.doc_num_dummy_flag),TRIM((SALT311.StrType)le.doc_filed_dt),TRIM((SALT311.StrType)le.doc_record_dt),TRIM((SALT311.StrType)le.doc_type_cd),TRIM((SALT311.StrType)le.doc_type_desc),TRIM((SALT311.StrType)le.doc_other_desc),TRIM((SALT311.StrType)le.doc_page_count),TRIM((SALT311.StrType)le.doc_names_count),TRIM((SALT311.StrType)le.doc_status_cd),TRIM((SALT311.StrType)le.doc_status_desc),TRIM((SALT311.StrType)le.doc_amend_cd),TRIM((SALT311.StrType)le.doc_amend_desc),TRIM((SALT311.StrType)le.execution_dt),TRIM((SALT311.StrType)le.consideration_amt),TRIM((SALT311.StrType)le.assumption_amt),TRIM((SALT311.StrType)le.certified_mail_fee),TRIM((SALT311.StrType)le.service_charge),TRIM((SALT311.StrType)le.trust_amt),TRIM((SALT311.StrType)le.transfer_),TRIM((SALT311.StrType)le.mortgage),TRIM((SALT311.StrType)le.intangible_tax_amt),TRIM((SALT311.StrType)le.intangible_tax_penalty),TRIM((SALT311.StrType)le.excise_tax_amt),TRIM((SALT311.StrType)le.recording_fee),TRIM((SALT311.StrType)le.documentary_stamps_fee),TRIM((SALT311.StrType)le.doc_stamps_mtg_fee),TRIM((SALT311.StrType)le.book_num),TRIM((SALT311.StrType)le.page_num),TRIM((SALT311.StrType)le.book_type_cd),TRIM((SALT311.StrType)le.book_type_desc),TRIM((SALT311.StrType)le.parcel_or_case_num),TRIM((SALT311.StrType)le.formatted_parcel_num),TRIM((SALT311.StrType)le.legal_desc_1),TRIM((SALT311.StrType)le.legal_desc_2),TRIM((SALT311.StrType)le.legal_desc_3),TRIM((SALT311.StrType)le.legal_desc_4),TRIM((SALT311.StrType)le.legal_desc_5),TRIM((SALT311.StrType)le.verified_flag),TRIM((SALT311.StrType)le.address_1),TRIM((SALT311.StrType)le.address_2),TRIM((SALT311.StrType)le.address_3),TRIM((SALT311.StrType)le.address_4),TRIM((SALT311.StrType)le.prior_doc_file_num),TRIM((SALT311.StrType)le.prior_doc_type_cd),TRIM((SALT311.StrType)le.prior_doc_type_desc),TRIM((SALT311.StrType)le.prior_book_num),TRIM((SALT311.StrType)le.prior_page_num),TRIM((SALT311.StrType)le.prior_book_type_cd),TRIM((SALT311.StrType)le.prior_book_type_desc),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.ace_fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,86,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 86);
  SELF.FldNo2 := 1 + (C % 86);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.official_record_key),TRIM((SALT311.StrType)le.fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.batch_id),TRIM((SALT311.StrType)le.doc_serial_num),TRIM((SALT311.StrType)le.doc_instrument_or_clerk_filing_num),TRIM((SALT311.StrType)le.doc_num_dummy_flag),TRIM((SALT311.StrType)le.doc_filed_dt),TRIM((SALT311.StrType)le.doc_record_dt),TRIM((SALT311.StrType)le.doc_type_cd),TRIM((SALT311.StrType)le.doc_type_desc),TRIM((SALT311.StrType)le.doc_other_desc),TRIM((SALT311.StrType)le.doc_page_count),TRIM((SALT311.StrType)le.doc_names_count),TRIM((SALT311.StrType)le.doc_status_cd),TRIM((SALT311.StrType)le.doc_status_desc),TRIM((SALT311.StrType)le.doc_amend_cd),TRIM((SALT311.StrType)le.doc_amend_desc),TRIM((SALT311.StrType)le.execution_dt),TRIM((SALT311.StrType)le.consideration_amt),TRIM((SALT311.StrType)le.assumption_amt),TRIM((SALT311.StrType)le.certified_mail_fee),TRIM((SALT311.StrType)le.service_charge),TRIM((SALT311.StrType)le.trust_amt),TRIM((SALT311.StrType)le.transfer_),TRIM((SALT311.StrType)le.mortgage),TRIM((SALT311.StrType)le.intangible_tax_amt),TRIM((SALT311.StrType)le.intangible_tax_penalty),TRIM((SALT311.StrType)le.excise_tax_amt),TRIM((SALT311.StrType)le.recording_fee),TRIM((SALT311.StrType)le.documentary_stamps_fee),TRIM((SALT311.StrType)le.doc_stamps_mtg_fee),TRIM((SALT311.StrType)le.book_num),TRIM((SALT311.StrType)le.page_num),TRIM((SALT311.StrType)le.book_type_cd),TRIM((SALT311.StrType)le.book_type_desc),TRIM((SALT311.StrType)le.parcel_or_case_num),TRIM((SALT311.StrType)le.formatted_parcel_num),TRIM((SALT311.StrType)le.legal_desc_1),TRIM((SALT311.StrType)le.legal_desc_2),TRIM((SALT311.StrType)le.legal_desc_3),TRIM((SALT311.StrType)le.legal_desc_4),TRIM((SALT311.StrType)le.legal_desc_5),TRIM((SALT311.StrType)le.verified_flag),TRIM((SALT311.StrType)le.address_1),TRIM((SALT311.StrType)le.address_2),TRIM((SALT311.StrType)le.address_3),TRIM((SALT311.StrType)le.address_4),TRIM((SALT311.StrType)le.prior_doc_file_num),TRIM((SALT311.StrType)le.prior_doc_type_cd),TRIM((SALT311.StrType)le.prior_doc_type_desc),TRIM((SALT311.StrType)le.prior_book_num),TRIM((SALT311.StrType)le.prior_page_num),TRIM((SALT311.StrType)le.prior_book_type_cd),TRIM((SALT311.StrType)le.prior_book_type_desc),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.ace_fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.official_record_key),TRIM((SALT311.StrType)le.fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.batch_id),TRIM((SALT311.StrType)le.doc_serial_num),TRIM((SALT311.StrType)le.doc_instrument_or_clerk_filing_num),TRIM((SALT311.StrType)le.doc_num_dummy_flag),TRIM((SALT311.StrType)le.doc_filed_dt),TRIM((SALT311.StrType)le.doc_record_dt),TRIM((SALT311.StrType)le.doc_type_cd),TRIM((SALT311.StrType)le.doc_type_desc),TRIM((SALT311.StrType)le.doc_other_desc),TRIM((SALT311.StrType)le.doc_page_count),TRIM((SALT311.StrType)le.doc_names_count),TRIM((SALT311.StrType)le.doc_status_cd),TRIM((SALT311.StrType)le.doc_status_desc),TRIM((SALT311.StrType)le.doc_amend_cd),TRIM((SALT311.StrType)le.doc_amend_desc),TRIM((SALT311.StrType)le.execution_dt),TRIM((SALT311.StrType)le.consideration_amt),TRIM((SALT311.StrType)le.assumption_amt),TRIM((SALT311.StrType)le.certified_mail_fee),TRIM((SALT311.StrType)le.service_charge),TRIM((SALT311.StrType)le.trust_amt),TRIM((SALT311.StrType)le.transfer_),TRIM((SALT311.StrType)le.mortgage),TRIM((SALT311.StrType)le.intangible_tax_amt),TRIM((SALT311.StrType)le.intangible_tax_penalty),TRIM((SALT311.StrType)le.excise_tax_amt),TRIM((SALT311.StrType)le.recording_fee),TRIM((SALT311.StrType)le.documentary_stamps_fee),TRIM((SALT311.StrType)le.doc_stamps_mtg_fee),TRIM((SALT311.StrType)le.book_num),TRIM((SALT311.StrType)le.page_num),TRIM((SALT311.StrType)le.book_type_cd),TRIM((SALT311.StrType)le.book_type_desc),TRIM((SALT311.StrType)le.parcel_or_case_num),TRIM((SALT311.StrType)le.formatted_parcel_num),TRIM((SALT311.StrType)le.legal_desc_1),TRIM((SALT311.StrType)le.legal_desc_2),TRIM((SALT311.StrType)le.legal_desc_3),TRIM((SALT311.StrType)le.legal_desc_4),TRIM((SALT311.StrType)le.legal_desc_5),TRIM((SALT311.StrType)le.verified_flag),TRIM((SALT311.StrType)le.address_1),TRIM((SALT311.StrType)le.address_2),TRIM((SALT311.StrType)le.address_3),TRIM((SALT311.StrType)le.address_4),TRIM((SALT311.StrType)le.prior_doc_file_num),TRIM((SALT311.StrType)le.prior_doc_type_cd),TRIM((SALT311.StrType)le.prior_doc_type_desc),TRIM((SALT311.StrType)le.prior_book_num),TRIM((SALT311.StrType)le.prior_page_num),TRIM((SALT311.StrType)le.prior_book_type_cd),TRIM((SALT311.StrType)le.prior_book_type_desc),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.ace_fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),86*86,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'vendor'}
      ,{3,'state_origin'}
      ,{4,'county_name'}
      ,{5,'official_record_key'}
      ,{6,'fips_st'}
      ,{7,'fips_county'}
      ,{8,'batch_id'}
      ,{9,'doc_serial_num'}
      ,{10,'doc_instrument_or_clerk_filing_num'}
      ,{11,'doc_num_dummy_flag'}
      ,{12,'doc_filed_dt'}
      ,{13,'doc_record_dt'}
      ,{14,'doc_type_cd'}
      ,{15,'doc_type_desc'}
      ,{16,'doc_other_desc'}
      ,{17,'doc_page_count'}
      ,{18,'doc_names_count'}
      ,{19,'doc_status_cd'}
      ,{20,'doc_status_desc'}
      ,{21,'doc_amend_cd'}
      ,{22,'doc_amend_desc'}
      ,{23,'execution_dt'}
      ,{24,'consideration_amt'}
      ,{25,'assumption_amt'}
      ,{26,'certified_mail_fee'}
      ,{27,'service_charge'}
      ,{28,'trust_amt'}
      ,{29,'transfer_'}
      ,{30,'mortgage'}
      ,{31,'intangible_tax_amt'}
      ,{32,'intangible_tax_penalty'}
      ,{33,'excise_tax_amt'}
      ,{34,'recording_fee'}
      ,{35,'documentary_stamps_fee'}
      ,{36,'doc_stamps_mtg_fee'}
      ,{37,'book_num'}
      ,{38,'page_num'}
      ,{39,'book_type_cd'}
      ,{40,'book_type_desc'}
      ,{41,'parcel_or_case_num'}
      ,{42,'formatted_parcel_num'}
      ,{43,'legal_desc_1'}
      ,{44,'legal_desc_2'}
      ,{45,'legal_desc_3'}
      ,{46,'legal_desc_4'}
      ,{47,'legal_desc_5'}
      ,{48,'verified_flag'}
      ,{49,'address_1'}
      ,{50,'address_2'}
      ,{51,'address_3'}
      ,{52,'address_4'}
      ,{53,'prior_doc_file_num'}
      ,{54,'prior_doc_type_cd'}
      ,{55,'prior_doc_type_desc'}
      ,{56,'prior_book_num'}
      ,{57,'prior_page_num'}
      ,{58,'prior_book_type_cd'}
      ,{59,'prior_book_type_desc'}
      ,{60,'prim_range'}
      ,{61,'predir'}
      ,{62,'prim_name'}
      ,{63,'addr_suffix'}
      ,{64,'postdir'}
      ,{65,'unit_desig'}
      ,{66,'sec_range'}
      ,{67,'p_city_name'}
      ,{68,'v_city_name'}
      ,{69,'st'}
      ,{70,'zip'}
      ,{71,'zip4'}
      ,{72,'cart'}
      ,{73,'cr_sort_sz'}
      ,{74,'lot'}
      ,{75,'lot_order'}
      ,{76,'dpbc'}
      ,{77,'chk_digit'}
      ,{78,'rec_type'}
      ,{79,'ace_fips_st'}
      ,{80,'ace_fips_county'}
      ,{81,'geo_lat'}
      ,{82,'geo_long'}
      ,{83,'msa'}
      ,{84,'geo_blk'}
      ,{85,'geo_match'}
      ,{86,'err_stat'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Document_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Document_Fields.InValid_vendor((SALT311.StrType)le.vendor),
    Document_Fields.InValid_state_origin((SALT311.StrType)le.state_origin),
    Document_Fields.InValid_county_name((SALT311.StrType)le.county_name),
    Document_Fields.InValid_official_record_key((SALT311.StrType)le.official_record_key),
    Document_Fields.InValid_fips_st((SALT311.StrType)le.fips_st),
    Document_Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Document_Fields.InValid_batch_id((SALT311.StrType)le.batch_id),
    Document_Fields.InValid_doc_serial_num((SALT311.StrType)le.doc_serial_num),
    Document_Fields.InValid_doc_instrument_or_clerk_filing_num((SALT311.StrType)le.doc_instrument_or_clerk_filing_num),
    Document_Fields.InValid_doc_num_dummy_flag((SALT311.StrType)le.doc_num_dummy_flag),
    Document_Fields.InValid_doc_filed_dt((SALT311.StrType)le.doc_filed_dt),
    Document_Fields.InValid_doc_record_dt((SALT311.StrType)le.doc_record_dt),
    Document_Fields.InValid_doc_type_cd((SALT311.StrType)le.doc_type_cd),
    Document_Fields.InValid_doc_type_desc((SALT311.StrType)le.doc_type_desc),
    Document_Fields.InValid_doc_other_desc((SALT311.StrType)le.doc_other_desc),
    Document_Fields.InValid_doc_page_count((SALT311.StrType)le.doc_page_count),
    Document_Fields.InValid_doc_names_count((SALT311.StrType)le.doc_names_count),
    Document_Fields.InValid_doc_status_cd((SALT311.StrType)le.doc_status_cd),
    Document_Fields.InValid_doc_status_desc((SALT311.StrType)le.doc_status_desc),
    Document_Fields.InValid_doc_amend_cd((SALT311.StrType)le.doc_amend_cd),
    Document_Fields.InValid_doc_amend_desc((SALT311.StrType)le.doc_amend_desc),
    Document_Fields.InValid_execution_dt((SALT311.StrType)le.execution_dt),
    Document_Fields.InValid_consideration_amt((SALT311.StrType)le.consideration_amt),
    Document_Fields.InValid_assumption_amt((SALT311.StrType)le.assumption_amt),
    Document_Fields.InValid_certified_mail_fee((SALT311.StrType)le.certified_mail_fee),
    Document_Fields.InValid_service_charge((SALT311.StrType)le.service_charge),
    Document_Fields.InValid_trust_amt((SALT311.StrType)le.trust_amt),
    Document_Fields.InValid_transfer_((SALT311.StrType)le.transfer_),
    Document_Fields.InValid_mortgage((SALT311.StrType)le.mortgage),
    Document_Fields.InValid_intangible_tax_amt((SALT311.StrType)le.intangible_tax_amt),
    Document_Fields.InValid_intangible_tax_penalty((SALT311.StrType)le.intangible_tax_penalty),
    Document_Fields.InValid_excise_tax_amt((SALT311.StrType)le.excise_tax_amt),
    Document_Fields.InValid_recording_fee((SALT311.StrType)le.recording_fee),
    Document_Fields.InValid_documentary_stamps_fee((SALT311.StrType)le.documentary_stamps_fee),
    Document_Fields.InValid_doc_stamps_mtg_fee((SALT311.StrType)le.doc_stamps_mtg_fee),
    Document_Fields.InValid_book_num((SALT311.StrType)le.book_num),
    Document_Fields.InValid_page_num((SALT311.StrType)le.page_num),
    Document_Fields.InValid_book_type_cd((SALT311.StrType)le.book_type_cd),
    Document_Fields.InValid_book_type_desc((SALT311.StrType)le.book_type_desc),
    Document_Fields.InValid_parcel_or_case_num((SALT311.StrType)le.parcel_or_case_num),
    Document_Fields.InValid_formatted_parcel_num((SALT311.StrType)le.formatted_parcel_num),
    Document_Fields.InValid_legal_desc_1((SALT311.StrType)le.legal_desc_1),
    Document_Fields.InValid_legal_desc_2((SALT311.StrType)le.legal_desc_2),
    Document_Fields.InValid_legal_desc_3((SALT311.StrType)le.legal_desc_3),
    Document_Fields.InValid_legal_desc_4((SALT311.StrType)le.legal_desc_4),
    Document_Fields.InValid_legal_desc_5((SALT311.StrType)le.legal_desc_5),
    Document_Fields.InValid_verified_flag((SALT311.StrType)le.verified_flag),
    Document_Fields.InValid_address_1((SALT311.StrType)le.address_1),
    Document_Fields.InValid_address_2((SALT311.StrType)le.address_2),
    Document_Fields.InValid_address_3((SALT311.StrType)le.address_3),
    Document_Fields.InValid_address_4((SALT311.StrType)le.address_4),
    Document_Fields.InValid_prior_doc_file_num((SALT311.StrType)le.prior_doc_file_num),
    Document_Fields.InValid_prior_doc_type_cd((SALT311.StrType)le.prior_doc_type_cd),
    Document_Fields.InValid_prior_doc_type_desc((SALT311.StrType)le.prior_doc_type_desc),
    Document_Fields.InValid_prior_book_num((SALT311.StrType)le.prior_book_num),
    Document_Fields.InValid_prior_page_num((SALT311.StrType)le.prior_page_num),
    Document_Fields.InValid_prior_book_type_cd((SALT311.StrType)le.prior_book_type_cd),
    Document_Fields.InValid_prior_book_type_desc((SALT311.StrType)le.prior_book_type_desc),
    Document_Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Document_Fields.InValid_predir((SALT311.StrType)le.predir),
    Document_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Document_Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Document_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Document_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Document_Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Document_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Document_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Document_Fields.InValid_st((SALT311.StrType)le.st),
    Document_Fields.InValid_zip((SALT311.StrType)le.zip),
    Document_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Document_Fields.InValid_cart((SALT311.StrType)le.cart),
    Document_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Document_Fields.InValid_lot((SALT311.StrType)le.lot),
    Document_Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Document_Fields.InValid_dpbc((SALT311.StrType)le.dpbc),
    Document_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Document_Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Document_Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st),
    Document_Fields.InValid_ace_fips_county((SALT311.StrType)le.ace_fips_county),
    Document_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Document_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Document_Fields.InValid_msa((SALT311.StrType)le.msa),
    Document_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Document_Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Document_Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,86,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Document_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Num','Invalid_State','Invalid_County','Invalid_NonBlank','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_NonBlank','Unknown','Invalid_Date','Invalid_Date','Unknown','Unknown','Unknown','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Invalid_FutureDate','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Document_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Document_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Document_Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Document_Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Document_Fields.InValidMessage_official_record_key(TotalErrors.ErrorNum),Document_Fields.InValidMessage_fips_st(TotalErrors.ErrorNum),Document_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Document_Fields.InValidMessage_batch_id(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_serial_num(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_instrument_or_clerk_filing_num(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_num_dummy_flag(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_filed_dt(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_record_dt(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_type_cd(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_type_desc(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_other_desc(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_page_count(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_names_count(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_status_cd(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_status_desc(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_amend_cd(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_amend_desc(TotalErrors.ErrorNum),Document_Fields.InValidMessage_execution_dt(TotalErrors.ErrorNum),Document_Fields.InValidMessage_consideration_amt(TotalErrors.ErrorNum),Document_Fields.InValidMessage_assumption_amt(TotalErrors.ErrorNum),Document_Fields.InValidMessage_certified_mail_fee(TotalErrors.ErrorNum),Document_Fields.InValidMessage_service_charge(TotalErrors.ErrorNum),Document_Fields.InValidMessage_trust_amt(TotalErrors.ErrorNum),Document_Fields.InValidMessage_transfer_(TotalErrors.ErrorNum),Document_Fields.InValidMessage_mortgage(TotalErrors.ErrorNum),Document_Fields.InValidMessage_intangible_tax_amt(TotalErrors.ErrorNum),Document_Fields.InValidMessage_intangible_tax_penalty(TotalErrors.ErrorNum),Document_Fields.InValidMessage_excise_tax_amt(TotalErrors.ErrorNum),Document_Fields.InValidMessage_recording_fee(TotalErrors.ErrorNum),Document_Fields.InValidMessage_documentary_stamps_fee(TotalErrors.ErrorNum),Document_Fields.InValidMessage_doc_stamps_mtg_fee(TotalErrors.ErrorNum),Document_Fields.InValidMessage_book_num(TotalErrors.ErrorNum),Document_Fields.InValidMessage_page_num(TotalErrors.ErrorNum),Document_Fields.InValidMessage_book_type_cd(TotalErrors.ErrorNum),Document_Fields.InValidMessage_book_type_desc(TotalErrors.ErrorNum),Document_Fields.InValidMessage_parcel_or_case_num(TotalErrors.ErrorNum),Document_Fields.InValidMessage_formatted_parcel_num(TotalErrors.ErrorNum),Document_Fields.InValidMessage_legal_desc_1(TotalErrors.ErrorNum),Document_Fields.InValidMessage_legal_desc_2(TotalErrors.ErrorNum),Document_Fields.InValidMessage_legal_desc_3(TotalErrors.ErrorNum),Document_Fields.InValidMessage_legal_desc_4(TotalErrors.ErrorNum),Document_Fields.InValidMessage_legal_desc_5(TotalErrors.ErrorNum),Document_Fields.InValidMessage_verified_flag(TotalErrors.ErrorNum),Document_Fields.InValidMessage_address_1(TotalErrors.ErrorNum),Document_Fields.InValidMessage_address_2(TotalErrors.ErrorNum),Document_Fields.InValidMessage_address_3(TotalErrors.ErrorNum),Document_Fields.InValidMessage_address_4(TotalErrors.ErrorNum),Document_Fields.InValidMessage_prior_doc_file_num(TotalErrors.ErrorNum),Document_Fields.InValidMessage_prior_doc_type_cd(TotalErrors.ErrorNum),Document_Fields.InValidMessage_prior_doc_type_desc(TotalErrors.ErrorNum),Document_Fields.InValidMessage_prior_book_num(TotalErrors.ErrorNum),Document_Fields.InValidMessage_prior_page_num(TotalErrors.ErrorNum),Document_Fields.InValidMessage_prior_book_type_cd(TotalErrors.ErrorNum),Document_Fields.InValidMessage_prior_book_type_desc(TotalErrors.ErrorNum),Document_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Document_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Document_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Document_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Document_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Document_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Document_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Document_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Document_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Document_Fields.InValidMessage_st(TotalErrors.ErrorNum),Document_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Document_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Document_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Document_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Document_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Document_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Document_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Document_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Document_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Document_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Document_Fields.InValidMessage_ace_fips_county(TotalErrors.ErrorNum),Document_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Document_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Document_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Document_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Document_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Document_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Official_Records, Document_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
