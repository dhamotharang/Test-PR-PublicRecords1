IMPORT ut,SALT33;
EXPORT Main_hygiene(dataset(Main_layout_LiensV2) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source_file);    NumberOfRecords := COUNT(GROUP);
    populated_tmsid_pcnt := AVE(GROUP,IF(h.tmsid = (TYPEOF(h.tmsid))'',0,100));
    maxlength_tmsid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.tmsid)));
    avelength_tmsid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.tmsid)),h.tmsid<>(typeof(h.tmsid))'');
    populated_rmsid_pcnt := AVE(GROUP,IF(h.rmsid = (TYPEOF(h.rmsid))'',0,100));
    maxlength_rmsid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.rmsid)));
    avelength_rmsid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.rmsid)),h.rmsid<>(typeof(h.rmsid))'');
    populated_orig_rmsid_pcnt := AVE(GROUP,IF(h.orig_rmsid = (TYPEOF(h.orig_rmsid))'',0,100));
    maxlength_orig_rmsid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_rmsid)));
    avelength_orig_rmsid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_rmsid)),h.orig_rmsid<>(typeof(h.orig_rmsid))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_record_code_pcnt := AVE(GROUP,IF(h.record_code = (TYPEOF(h.record_code))'',0,100));
    maxlength_record_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_code)));
    avelength_record_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_code)),h.record_code<>(typeof(h.record_code))'');
    populated_date_vendor_removed_pcnt := AVE(GROUP,IF(h.date_vendor_removed = (TYPEOF(h.date_vendor_removed))'',0,100));
    maxlength_date_vendor_removed := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_vendor_removed)));
    avelength_date_vendor_removed := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_vendor_removed)),h.date_vendor_removed<>(typeof(h.date_vendor_removed))'');
    populated_filing_jurisdiction_pcnt := AVE(GROUP,IF(h.filing_jurisdiction = (TYPEOF(h.filing_jurisdiction))'',0,100));
    maxlength_filing_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_jurisdiction)));
    avelength_filing_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_jurisdiction)),h.filing_jurisdiction<>(typeof(h.filing_jurisdiction))'');
    populated_filing_state_pcnt := AVE(GROUP,IF(h.filing_state = (TYPEOF(h.filing_state))'',0,100));
    maxlength_filing_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_state)));
    avelength_filing_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_state)),h.filing_state<>(typeof(h.filing_state))'');
    populated_orig_filing_number_pcnt := AVE(GROUP,IF(h.orig_filing_number = (TYPEOF(h.orig_filing_number))'',0,100));
    maxlength_orig_filing_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_filing_number)));
    avelength_orig_filing_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_filing_number)),h.orig_filing_number<>(typeof(h.orig_filing_number))'');
    populated_orig_filing_type_pcnt := AVE(GROUP,IF(h.orig_filing_type = (TYPEOF(h.orig_filing_type))'',0,100));
    maxlength_orig_filing_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_filing_type)));
    avelength_orig_filing_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_filing_type)),h.orig_filing_type<>(typeof(h.orig_filing_type))'');
    populated_orig_filing_date_pcnt := AVE(GROUP,IF(h.orig_filing_date = (TYPEOF(h.orig_filing_date))'',0,100));
    maxlength_orig_filing_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_filing_date)));
    avelength_orig_filing_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_filing_date)),h.orig_filing_date<>(typeof(h.orig_filing_date))'');
    populated_orig_filing_time_pcnt := AVE(GROUP,IF(h.orig_filing_time = (TYPEOF(h.orig_filing_time))'',0,100));
    maxlength_orig_filing_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_filing_time)));
    avelength_orig_filing_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_filing_time)),h.orig_filing_time<>(typeof(h.orig_filing_time))'');
    populated_case_number_pcnt := AVE(GROUP,IF(h.case_number = (TYPEOF(h.case_number))'',0,100));
    maxlength_case_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_number)));
    avelength_case_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_number)),h.case_number<>(typeof(h.case_number))'');
    populated_filing_number_pcnt := AVE(GROUP,IF(h.filing_number = (TYPEOF(h.filing_number))'',0,100));
    maxlength_filing_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_number)));
    avelength_filing_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_number)),h.filing_number<>(typeof(h.filing_number))'');
    populated_filing_type_desc_pcnt := AVE(GROUP,IF(h.filing_type_desc = (TYPEOF(h.filing_type_desc))'',0,100));
    maxlength_filing_type_desc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_type_desc)));
    avelength_filing_type_desc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_type_desc)),h.filing_type_desc<>(typeof(h.filing_type_desc))'');
    populated_filing_date_pcnt := AVE(GROUP,IF(h.filing_date = (TYPEOF(h.filing_date))'',0,100));
    maxlength_filing_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_date)));
    avelength_filing_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_date)),h.filing_date<>(typeof(h.filing_date))'');
    populated_filing_time_pcnt := AVE(GROUP,IF(h.filing_time = (TYPEOF(h.filing_time))'',0,100));
    maxlength_filing_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_time)));
    avelength_filing_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_time)),h.filing_time<>(typeof(h.filing_time))'');
    populated_vendor_entry_date_pcnt := AVE(GROUP,IF(h.vendor_entry_date = (TYPEOF(h.vendor_entry_date))'',0,100));
    maxlength_vendor_entry_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_entry_date)));
    avelength_vendor_entry_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_entry_date)),h.vendor_entry_date<>(typeof(h.vendor_entry_date))'');
    populated_judge_pcnt := AVE(GROUP,IF(h.judge = (TYPEOF(h.judge))'',0,100));
    maxlength_judge := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.judge)));
    avelength_judge := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.judge)),h.judge<>(typeof(h.judge))'');
    populated_case_title_pcnt := AVE(GROUP,IF(h.case_title = (TYPEOF(h.case_title))'',0,100));
    maxlength_case_title := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_title)));
    avelength_case_title := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_title)),h.case_title<>(typeof(h.case_title))'');
    populated_filing_book_pcnt := AVE(GROUP,IF(h.filing_book = (TYPEOF(h.filing_book))'',0,100));
    maxlength_filing_book := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_book)));
    avelength_filing_book := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_book)),h.filing_book<>(typeof(h.filing_book))'');
    populated_filing_page_pcnt := AVE(GROUP,IF(h.filing_page = (TYPEOF(h.filing_page))'',0,100));
    maxlength_filing_page := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_page)));
    avelength_filing_page := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_page)),h.filing_page<>(typeof(h.filing_page))'');
    populated_release_date_pcnt := AVE(GROUP,IF(h.release_date = (TYPEOF(h.release_date))'',0,100));
    maxlength_release_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.release_date)));
    avelength_release_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.release_date)),h.release_date<>(typeof(h.release_date))'');
    populated_amount_pcnt := AVE(GROUP,IF(h.amount = (TYPEOF(h.amount))'',0,100));
    maxlength_amount := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.amount)));
    avelength_amount := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.amount)),h.amount<>(typeof(h.amount))'');
    populated_eviction_pcnt := AVE(GROUP,IF(h.eviction = (TYPEOF(h.eviction))'',0,100));
    maxlength_eviction := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.eviction)));
    avelength_eviction := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.eviction)),h.eviction<>(typeof(h.eviction))'');
    populated_satisifaction_type_pcnt := AVE(GROUP,IF(h.satisifaction_type = (TYPEOF(h.satisifaction_type))'',0,100));
    maxlength_satisifaction_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.satisifaction_type)));
    avelength_satisifaction_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.satisifaction_type)),h.satisifaction_type<>(typeof(h.satisifaction_type))'');
    populated_judg_satisfied_date_pcnt := AVE(GROUP,IF(h.judg_satisfied_date = (TYPEOF(h.judg_satisfied_date))'',0,100));
    maxlength_judg_satisfied_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.judg_satisfied_date)));
    avelength_judg_satisfied_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.judg_satisfied_date)),h.judg_satisfied_date<>(typeof(h.judg_satisfied_date))'');
    populated_judg_vacated_date_pcnt := AVE(GROUP,IF(h.judg_vacated_date = (TYPEOF(h.judg_vacated_date))'',0,100));
    maxlength_judg_vacated_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.judg_vacated_date)));
    avelength_judg_vacated_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.judg_vacated_date)),h.judg_vacated_date<>(typeof(h.judg_vacated_date))'');
    populated_tax_code_pcnt := AVE(GROUP,IF(h.tax_code = (TYPEOF(h.tax_code))'',0,100));
    maxlength_tax_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.tax_code)));
    avelength_tax_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.tax_code)),h.tax_code<>(typeof(h.tax_code))'');
    populated_irs_serial_number_pcnt := AVE(GROUP,IF(h.irs_serial_number = (TYPEOF(h.irs_serial_number))'',0,100));
    maxlength_irs_serial_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.irs_serial_number)));
    avelength_irs_serial_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.irs_serial_number)),h.irs_serial_number<>(typeof(h.irs_serial_number))'');
    populated_effective_date_pcnt := AVE(GROUP,IF(h.effective_date = (TYPEOF(h.effective_date))'',0,100));
    maxlength_effective_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.effective_date)));
    avelength_effective_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.effective_date)),h.effective_date<>(typeof(h.effective_date))'');
    populated_lapse_date_pcnt := AVE(GROUP,IF(h.lapse_date = (TYPEOF(h.lapse_date))'',0,100));
    maxlength_lapse_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lapse_date)));
    avelength_lapse_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lapse_date)),h.lapse_date<>(typeof(h.lapse_date))'');
    populated_accident_date_pcnt := AVE(GROUP,IF(h.accident_date = (TYPEOF(h.accident_date))'',0,100));
    maxlength_accident_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.accident_date)));
    avelength_accident_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.accident_date)),h.accident_date<>(typeof(h.accident_date))'');
    populated_sherrif_indc_pcnt := AVE(GROUP,IF(h.sherrif_indc = (TYPEOF(h.sherrif_indc))'',0,100));
    maxlength_sherrif_indc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sherrif_indc)));
    avelength_sherrif_indc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sherrif_indc)),h.sherrif_indc<>(typeof(h.sherrif_indc))'');
    populated_expiration_date_pcnt := AVE(GROUP,IF(h.expiration_date = (TYPEOF(h.expiration_date))'',0,100));
    maxlength_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.expiration_date)));
    avelength_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.expiration_date)),h.expiration_date<>(typeof(h.expiration_date))'');
    populated_agency_pcnt := AVE(GROUP,IF(h.agency = (TYPEOF(h.agency))'',0,100));
    maxlength_agency := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.agency)));
    avelength_agency := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.agency)),h.agency<>(typeof(h.agency))'');
    populated_agency_city_pcnt := AVE(GROUP,IF(h.agency_city = (TYPEOF(h.agency_city))'',0,100));
    maxlength_agency_city := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.agency_city)));
    avelength_agency_city := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.agency_city)),h.agency_city<>(typeof(h.agency_city))'');
    populated_agency_state_pcnt := AVE(GROUP,IF(h.agency_state = (TYPEOF(h.agency_state))'',0,100));
    maxlength_agency_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.agency_state)));
    avelength_agency_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.agency_state)),h.agency_state<>(typeof(h.agency_state))'');
    populated_agency_county_pcnt := AVE(GROUP,IF(h.agency_county = (TYPEOF(h.agency_county))'',0,100));
    maxlength_agency_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.agency_county)));
    avelength_agency_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.agency_county)),h.agency_county<>(typeof(h.agency_county))'');
    populated_legal_lot_pcnt := AVE(GROUP,IF(h.legal_lot = (TYPEOF(h.legal_lot))'',0,100));
    maxlength_legal_lot := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_lot)));
    avelength_legal_lot := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_lot)),h.legal_lot<>(typeof(h.legal_lot))'');
    populated_legal_block_pcnt := AVE(GROUP,IF(h.legal_block = (TYPEOF(h.legal_block))'',0,100));
    maxlength_legal_block := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_block)));
    avelength_legal_block := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_block)),h.legal_block<>(typeof(h.legal_block))'');
    populated_legal_borough_pcnt := AVE(GROUP,IF(h.legal_borough = (TYPEOF(h.legal_borough))'',0,100));
    maxlength_legal_borough := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_borough)));
    avelength_legal_borough := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.legal_borough)),h.legal_borough<>(typeof(h.legal_borough))'');
    populated_certificate_number_pcnt := AVE(GROUP,IF(h.certificate_number = (TYPEOF(h.certificate_number))'',0,100));
    maxlength_certificate_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.certificate_number)));
    avelength_certificate_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.certificate_number)),h.certificate_number<>(typeof(h.certificate_number))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source_file,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_tmsid_pcnt *   0.00 / 100 + T.Populated_rmsid_pcnt *   0.00 / 100 + T.Populated_orig_rmsid_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_record_code_pcnt *   0.00 / 100 + T.Populated_date_vendor_removed_pcnt *   0.00 / 100 + T.Populated_filing_jurisdiction_pcnt *   0.00 / 100 + T.Populated_filing_state_pcnt *   0.00 / 100 + T.Populated_orig_filing_number_pcnt *   0.00 / 100 + T.Populated_orig_filing_type_pcnt *   0.00 / 100 + T.Populated_orig_filing_date_pcnt *   0.00 / 100 + T.Populated_orig_filing_time_pcnt *   0.00 / 100 + T.Populated_case_number_pcnt *   0.00 / 100 + T.Populated_filing_number_pcnt *   0.00 / 100 + T.Populated_filing_type_desc_pcnt *   0.00 / 100 + T.Populated_filing_date_pcnt *   0.00 / 100 + T.Populated_filing_time_pcnt *   0.00 / 100 + T.Populated_vendor_entry_date_pcnt *   0.00 / 100 + T.Populated_judge_pcnt *   0.00 / 100 + T.Populated_case_title_pcnt *   0.00 / 100 + T.Populated_filing_book_pcnt *   0.00 / 100 + T.Populated_filing_page_pcnt *   0.00 / 100 + T.Populated_release_date_pcnt *   0.00 / 100 + T.Populated_amount_pcnt *   0.00 / 100 + T.Populated_eviction_pcnt *   0.00 / 100 + T.Populated_satisifaction_type_pcnt *   0.00 / 100 + T.Populated_judg_satisfied_date_pcnt *   0.00 / 100 + T.Populated_judg_vacated_date_pcnt *   0.00 / 100 + T.Populated_tax_code_pcnt *   0.00 / 100 + T.Populated_irs_serial_number_pcnt *   0.00 / 100 + T.Populated_effective_date_pcnt *   0.00 / 100 + T.Populated_lapse_date_pcnt *   0.00 / 100 + T.Populated_accident_date_pcnt *   0.00 / 100 + T.Populated_sherrif_indc_pcnt *   0.00 / 100 + T.Populated_expiration_date_pcnt *   0.00 / 100 + T.Populated_agency_pcnt *   0.00 / 100 + T.Populated_agency_city_pcnt *   0.00 / 100 + T.Populated_agency_state_pcnt *   0.00 / 100 + T.Populated_agency_county_pcnt *   0.00 / 100 + T.Populated_legal_lot_pcnt *   0.00 / 100 + T.Populated_legal_block_pcnt *   0.00 / 100 + T.Populated_legal_borough_pcnt *   0.00 / 100 + T.Populated_certificate_number_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source_file1;
    STRING source_file2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source_file1 := le.Source;
    SELF.source_file2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_tmsid_pcnt*ri.Populated_tmsid_pcnt *   0.00 / 10000 + le.Populated_rmsid_pcnt*ri.Populated_rmsid_pcnt *   0.00 / 10000 + le.Populated_orig_rmsid_pcnt*ri.Populated_orig_rmsid_pcnt *   0.00 / 10000 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_record_code_pcnt*ri.Populated_record_code_pcnt *   0.00 / 10000 + le.Populated_date_vendor_removed_pcnt*ri.Populated_date_vendor_removed_pcnt *   0.00 / 10000 + le.Populated_filing_jurisdiction_pcnt*ri.Populated_filing_jurisdiction_pcnt *   0.00 / 10000 + le.Populated_filing_state_pcnt*ri.Populated_filing_state_pcnt *   0.00 / 10000 + le.Populated_orig_filing_number_pcnt*ri.Populated_orig_filing_number_pcnt *   0.00 / 10000 + le.Populated_orig_filing_type_pcnt*ri.Populated_orig_filing_type_pcnt *   0.00 / 10000 + le.Populated_orig_filing_date_pcnt*ri.Populated_orig_filing_date_pcnt *   0.00 / 10000 + le.Populated_orig_filing_time_pcnt*ri.Populated_orig_filing_time_pcnt *   0.00 / 10000 + le.Populated_case_number_pcnt*ri.Populated_case_number_pcnt *   0.00 / 10000 + le.Populated_filing_number_pcnt*ri.Populated_filing_number_pcnt *   0.00 / 10000 + le.Populated_filing_type_desc_pcnt*ri.Populated_filing_type_desc_pcnt *   0.00 / 10000 + le.Populated_filing_date_pcnt*ri.Populated_filing_date_pcnt *   0.00 / 10000 + le.Populated_filing_time_pcnt*ri.Populated_filing_time_pcnt *   0.00 / 10000 + le.Populated_vendor_entry_date_pcnt*ri.Populated_vendor_entry_date_pcnt *   0.00 / 10000 + le.Populated_judge_pcnt*ri.Populated_judge_pcnt *   0.00 / 10000 + le.Populated_case_title_pcnt*ri.Populated_case_title_pcnt *   0.00 / 10000 + le.Populated_filing_book_pcnt*ri.Populated_filing_book_pcnt *   0.00 / 10000 + le.Populated_filing_page_pcnt*ri.Populated_filing_page_pcnt *   0.00 / 10000 + le.Populated_release_date_pcnt*ri.Populated_release_date_pcnt *   0.00 / 10000 + le.Populated_amount_pcnt*ri.Populated_amount_pcnt *   0.00 / 10000 + le.Populated_eviction_pcnt*ri.Populated_eviction_pcnt *   0.00 / 10000 + le.Populated_satisifaction_type_pcnt*ri.Populated_satisifaction_type_pcnt *   0.00 / 10000 + le.Populated_judg_satisfied_date_pcnt*ri.Populated_judg_satisfied_date_pcnt *   0.00 / 10000 + le.Populated_judg_vacated_date_pcnt*ri.Populated_judg_vacated_date_pcnt *   0.00 / 10000 + le.Populated_tax_code_pcnt*ri.Populated_tax_code_pcnt *   0.00 / 10000 + le.Populated_irs_serial_number_pcnt*ri.Populated_irs_serial_number_pcnt *   0.00 / 10000 + le.Populated_effective_date_pcnt*ri.Populated_effective_date_pcnt *   0.00 / 10000 + le.Populated_lapse_date_pcnt*ri.Populated_lapse_date_pcnt *   0.00 / 10000 + le.Populated_accident_date_pcnt*ri.Populated_accident_date_pcnt *   0.00 / 10000 + le.Populated_sherrif_indc_pcnt*ri.Populated_sherrif_indc_pcnt *   0.00 / 10000 + le.Populated_expiration_date_pcnt*ri.Populated_expiration_date_pcnt *   0.00 / 10000 + le.Populated_agency_pcnt*ri.Populated_agency_pcnt *   0.00 / 10000 + le.Populated_agency_city_pcnt*ri.Populated_agency_city_pcnt *   0.00 / 10000 + le.Populated_agency_state_pcnt*ri.Populated_agency_state_pcnt *   0.00 / 10000 + le.Populated_agency_county_pcnt*ri.Populated_agency_county_pcnt *   0.00 / 10000 + le.Populated_legal_lot_pcnt*ri.Populated_legal_lot_pcnt *   0.00 / 10000 + le.Populated_legal_block_pcnt*ri.Populated_legal_block_pcnt *   0.00 / 10000 + le.Populated_legal_borough_pcnt*ri.Populated_legal_borough_pcnt *   0.00 / 10000 + le.Populated_certificate_number_pcnt*ri.Populated_certificate_number_pcnt *   0.00 / 10000 + le.Populated_persistent_record_id_pcnt*ri.Populated_persistent_record_id_pcnt *   0.00 / 10000 + le.Populated_source_file_pcnt*ri.Populated_source_file_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'tmsid','rmsid','orig_rmsid','process_date','record_code','date_vendor_removed','filing_jurisdiction','filing_state','orig_filing_number','orig_filing_type','orig_filing_date','orig_filing_time','case_number','filing_number','filing_type_desc','filing_date','filing_time','vendor_entry_date','judge','case_title','filing_book','filing_page','release_date','amount','eviction','satisifaction_type','judg_satisfied_date','judg_vacated_date','tax_code','irs_serial_number','effective_date','lapse_date','accident_date','sherrif_indc','expiration_date','agency','agency_city','agency_state','agency_county','legal_lot','legal_block','legal_borough','certificate_number','persistent_record_id','source_file');
  SELF.populated_pcnt := CHOOSE(C,le.populated_tmsid_pcnt,le.populated_rmsid_pcnt,le.populated_orig_rmsid_pcnt,le.populated_process_date_pcnt,le.populated_record_code_pcnt,le.populated_date_vendor_removed_pcnt,le.populated_filing_jurisdiction_pcnt,le.populated_filing_state_pcnt,le.populated_orig_filing_number_pcnt,le.populated_orig_filing_type_pcnt,le.populated_orig_filing_date_pcnt,le.populated_orig_filing_time_pcnt,le.populated_case_number_pcnt,le.populated_filing_number_pcnt,le.populated_filing_type_desc_pcnt,le.populated_filing_date_pcnt,le.populated_filing_time_pcnt,le.populated_vendor_entry_date_pcnt,le.populated_judge_pcnt,le.populated_case_title_pcnt,le.populated_filing_book_pcnt,le.populated_filing_page_pcnt,le.populated_release_date_pcnt,le.populated_amount_pcnt,le.populated_eviction_pcnt,le.populated_satisifaction_type_pcnt,le.populated_judg_satisfied_date_pcnt,le.populated_judg_vacated_date_pcnt,le.populated_tax_code_pcnt,le.populated_irs_serial_number_pcnt,le.populated_effective_date_pcnt,le.populated_lapse_date_pcnt,le.populated_accident_date_pcnt,le.populated_sherrif_indc_pcnt,le.populated_expiration_date_pcnt,le.populated_agency_pcnt,le.populated_agency_city_pcnt,le.populated_agency_state_pcnt,le.populated_agency_county_pcnt,le.populated_legal_lot_pcnt,le.populated_legal_block_pcnt,le.populated_legal_borough_pcnt,le.populated_certificate_number_pcnt,le.populated_persistent_record_id_pcnt,le.populated_source_file_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_tmsid,le.maxlength_rmsid,le.maxlength_orig_rmsid,le.maxlength_process_date,le.maxlength_record_code,le.maxlength_date_vendor_removed,le.maxlength_filing_jurisdiction,le.maxlength_filing_state,le.maxlength_orig_filing_number,le.maxlength_orig_filing_type,le.maxlength_orig_filing_date,le.maxlength_orig_filing_time,le.maxlength_case_number,le.maxlength_filing_number,le.maxlength_filing_type_desc,le.maxlength_filing_date,le.maxlength_filing_time,le.maxlength_vendor_entry_date,le.maxlength_judge,le.maxlength_case_title,le.maxlength_filing_book,le.maxlength_filing_page,le.maxlength_release_date,le.maxlength_amount,le.maxlength_eviction,le.maxlength_satisifaction_type,le.maxlength_judg_satisfied_date,le.maxlength_judg_vacated_date,le.maxlength_tax_code,le.maxlength_irs_serial_number,le.maxlength_effective_date,le.maxlength_lapse_date,le.maxlength_accident_date,le.maxlength_sherrif_indc,le.maxlength_expiration_date,le.maxlength_agency,le.maxlength_agency_city,le.maxlength_agency_state,le.maxlength_agency_county,le.maxlength_legal_lot,le.maxlength_legal_block,le.maxlength_legal_borough,le.maxlength_certificate_number,le.maxlength_persistent_record_id,le.maxlength_source_file);
  SELF.avelength := CHOOSE(C,le.avelength_tmsid,le.avelength_rmsid,le.avelength_orig_rmsid,le.avelength_process_date,le.avelength_record_code,le.avelength_date_vendor_removed,le.avelength_filing_jurisdiction,le.avelength_filing_state,le.avelength_orig_filing_number,le.avelength_orig_filing_type,le.avelength_orig_filing_date,le.avelength_orig_filing_time,le.avelength_case_number,le.avelength_filing_number,le.avelength_filing_type_desc,le.avelength_filing_date,le.avelength_filing_time,le.avelength_vendor_entry_date,le.avelength_judge,le.avelength_case_title,le.avelength_filing_book,le.avelength_filing_page,le.avelength_release_date,le.avelength_amount,le.avelength_eviction,le.avelength_satisifaction_type,le.avelength_judg_satisfied_date,le.avelength_judg_vacated_date,le.avelength_tax_code,le.avelength_irs_serial_number,le.avelength_effective_date,le.avelength_lapse_date,le.avelength_accident_date,le.avelength_sherrif_indc,le.avelength_expiration_date,le.avelength_agency,le.avelength_agency_city,le.avelength_agency_state,le.avelength_agency_county,le.avelength_legal_lot,le.avelength_legal_block,le.avelength_legal_borough,le.avelength_certificate_number,le.avelength_persistent_record_id,le.avelength_source_file);
END;
EXPORT invSummary := NORMALIZE(summary0, 45, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.source_file;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.tmsid),TRIM((SALT33.StrType)le.rmsid),TRIM((SALT33.StrType)le.orig_rmsid),TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.record_code),TRIM((SALT33.StrType)le.date_vendor_removed),TRIM((SALT33.StrType)le.filing_jurisdiction),TRIM((SALT33.StrType)le.filing_state),TRIM((SALT33.StrType)le.orig_filing_number),TRIM((SALT33.StrType)le.orig_filing_type),TRIM((SALT33.StrType)le.orig_filing_date),TRIM((SALT33.StrType)le.orig_filing_time),TRIM((SALT33.StrType)le.case_number),TRIM((SALT33.StrType)le.filing_number),TRIM((SALT33.StrType)le.filing_type_desc),TRIM((SALT33.StrType)le.filing_date),TRIM((SALT33.StrType)le.filing_time),TRIM((SALT33.StrType)le.vendor_entry_date),TRIM((SALT33.StrType)le.judge),TRIM((SALT33.StrType)le.case_title),TRIM((SALT33.StrType)le.filing_book),TRIM((SALT33.StrType)le.filing_page),TRIM((SALT33.StrType)le.release_date),TRIM((SALT33.StrType)le.amount),TRIM((SALT33.StrType)le.eviction),TRIM((SALT33.StrType)le.satisifaction_type),TRIM((SALT33.StrType)le.judg_satisfied_date),TRIM((SALT33.StrType)le.judg_vacated_date),TRIM((SALT33.StrType)le.tax_code),TRIM((SALT33.StrType)le.irs_serial_number),TRIM((SALT33.StrType)le.effective_date),TRIM((SALT33.StrType)le.lapse_date),TRIM((SALT33.StrType)le.accident_date),TRIM((SALT33.StrType)le.sherrif_indc),TRIM((SALT33.StrType)le.expiration_date),TRIM((SALT33.StrType)le.agency),TRIM((SALT33.StrType)le.agency_city),TRIM((SALT33.StrType)le.agency_state),TRIM((SALT33.StrType)le.agency_county),TRIM((SALT33.StrType)le.legal_lot),TRIM((SALT33.StrType)le.legal_block),TRIM((SALT33.StrType)le.legal_borough),TRIM((SALT33.StrType)le.certificate_number),TRIM((SALT33.StrType)le.persistent_record_id),TRIM((SALT33.StrType)le.source_file)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,45,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 45);
  SELF.FldNo2 := 1 + (C % 45);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.tmsid),TRIM((SALT33.StrType)le.rmsid),TRIM((SALT33.StrType)le.orig_rmsid),TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.record_code),TRIM((SALT33.StrType)le.date_vendor_removed),TRIM((SALT33.StrType)le.filing_jurisdiction),TRIM((SALT33.StrType)le.filing_state),TRIM((SALT33.StrType)le.orig_filing_number),TRIM((SALT33.StrType)le.orig_filing_type),TRIM((SALT33.StrType)le.orig_filing_date),TRIM((SALT33.StrType)le.orig_filing_time),TRIM((SALT33.StrType)le.case_number),TRIM((SALT33.StrType)le.filing_number),TRIM((SALT33.StrType)le.filing_type_desc),TRIM((SALT33.StrType)le.filing_date),TRIM((SALT33.StrType)le.filing_time),TRIM((SALT33.StrType)le.vendor_entry_date),TRIM((SALT33.StrType)le.judge),TRIM((SALT33.StrType)le.case_title),TRIM((SALT33.StrType)le.filing_book),TRIM((SALT33.StrType)le.filing_page),TRIM((SALT33.StrType)le.release_date),TRIM((SALT33.StrType)le.amount),TRIM((SALT33.StrType)le.eviction),TRIM((SALT33.StrType)le.satisifaction_type),TRIM((SALT33.StrType)le.judg_satisfied_date),TRIM((SALT33.StrType)le.judg_vacated_date),TRIM((SALT33.StrType)le.tax_code),TRIM((SALT33.StrType)le.irs_serial_number),TRIM((SALT33.StrType)le.effective_date),TRIM((SALT33.StrType)le.lapse_date),TRIM((SALT33.StrType)le.accident_date),TRIM((SALT33.StrType)le.sherrif_indc),TRIM((SALT33.StrType)le.expiration_date),TRIM((SALT33.StrType)le.agency),TRIM((SALT33.StrType)le.agency_city),TRIM((SALT33.StrType)le.agency_state),TRIM((SALT33.StrType)le.agency_county),TRIM((SALT33.StrType)le.legal_lot),TRIM((SALT33.StrType)le.legal_block),TRIM((SALT33.StrType)le.legal_borough),TRIM((SALT33.StrType)le.certificate_number),TRIM((SALT33.StrType)le.persistent_record_id),TRIM((SALT33.StrType)le.source_file)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.tmsid),TRIM((SALT33.StrType)le.rmsid),TRIM((SALT33.StrType)le.orig_rmsid),TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.record_code),TRIM((SALT33.StrType)le.date_vendor_removed),TRIM((SALT33.StrType)le.filing_jurisdiction),TRIM((SALT33.StrType)le.filing_state),TRIM((SALT33.StrType)le.orig_filing_number),TRIM((SALT33.StrType)le.orig_filing_type),TRIM((SALT33.StrType)le.orig_filing_date),TRIM((SALT33.StrType)le.orig_filing_time),TRIM((SALT33.StrType)le.case_number),TRIM((SALT33.StrType)le.filing_number),TRIM((SALT33.StrType)le.filing_type_desc),TRIM((SALT33.StrType)le.filing_date),TRIM((SALT33.StrType)le.filing_time),TRIM((SALT33.StrType)le.vendor_entry_date),TRIM((SALT33.StrType)le.judge),TRIM((SALT33.StrType)le.case_title),TRIM((SALT33.StrType)le.filing_book),TRIM((SALT33.StrType)le.filing_page),TRIM((SALT33.StrType)le.release_date),TRIM((SALT33.StrType)le.amount),TRIM((SALT33.StrType)le.eviction),TRIM((SALT33.StrType)le.satisifaction_type),TRIM((SALT33.StrType)le.judg_satisfied_date),TRIM((SALT33.StrType)le.judg_vacated_date),TRIM((SALT33.StrType)le.tax_code),TRIM((SALT33.StrType)le.irs_serial_number),TRIM((SALT33.StrType)le.effective_date),TRIM((SALT33.StrType)le.lapse_date),TRIM((SALT33.StrType)le.accident_date),TRIM((SALT33.StrType)le.sherrif_indc),TRIM((SALT33.StrType)le.expiration_date),TRIM((SALT33.StrType)le.agency),TRIM((SALT33.StrType)le.agency_city),TRIM((SALT33.StrType)le.agency_state),TRIM((SALT33.StrType)le.agency_county),TRIM((SALT33.StrType)le.legal_lot),TRIM((SALT33.StrType)le.legal_block),TRIM((SALT33.StrType)le.legal_borough),TRIM((SALT33.StrType)le.certificate_number),TRIM((SALT33.StrType)le.persistent_record_id),TRIM((SALT33.StrType)le.source_file)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),45*45,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'tmsid'}
      ,{2,'rmsid'}
      ,{3,'orig_rmsid'}
      ,{4,'process_date'}
      ,{5,'record_code'}
      ,{6,'date_vendor_removed'}
      ,{7,'filing_jurisdiction'}
      ,{8,'filing_state'}
      ,{9,'orig_filing_number'}
      ,{10,'orig_filing_type'}
      ,{11,'orig_filing_date'}
      ,{12,'orig_filing_time'}
      ,{13,'case_number'}
      ,{14,'filing_number'}
      ,{15,'filing_type_desc'}
      ,{16,'filing_date'}
      ,{17,'filing_time'}
      ,{18,'vendor_entry_date'}
      ,{19,'judge'}
      ,{20,'case_title'}
      ,{21,'filing_book'}
      ,{22,'filing_page'}
      ,{23,'release_date'}
      ,{24,'amount'}
      ,{25,'eviction'}
      ,{26,'satisifaction_type'}
      ,{27,'judg_satisfied_date'}
      ,{28,'judg_vacated_date'}
      ,{29,'tax_code'}
      ,{30,'irs_serial_number'}
      ,{31,'effective_date'}
      ,{32,'lapse_date'}
      ,{33,'accident_date'}
      ,{34,'sherrif_indc'}
      ,{35,'expiration_date'}
      ,{36,'agency'}
      ,{37,'agency_city'}
      ,{38,'agency_state'}
      ,{39,'agency_county'}
      ,{40,'legal_lot'}
      ,{41,'legal_block'}
      ,{42,'legal_borough'}
      ,{43,'certificate_number'}
      ,{44,'persistent_record_id'}
      ,{45,'source_file'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source_file) source_file; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Main_Fields.InValid_tmsid((SALT33.StrType)le.tmsid),
    Main_Fields.InValid_rmsid((SALT33.StrType)le.rmsid),
    Main_Fields.InValid_orig_rmsid((SALT33.StrType)le.orig_rmsid),
    Main_Fields.InValid_process_date((SALT33.StrType)le.process_date),
    Main_Fields.InValid_record_code((SALT33.StrType)le.record_code),
    Main_Fields.InValid_date_vendor_removed((SALT33.StrType)le.date_vendor_removed),
    Main_Fields.InValid_filing_jurisdiction((SALT33.StrType)le.filing_jurisdiction),
    Main_Fields.InValid_filing_state((SALT33.StrType)le.filing_state),
    Main_Fields.InValid_orig_filing_number((SALT33.StrType)le.orig_filing_number),
    Main_Fields.InValid_orig_filing_type((SALT33.StrType)le.orig_filing_type),
    Main_Fields.InValid_orig_filing_date((SALT33.StrType)le.orig_filing_date),
    Main_Fields.InValid_orig_filing_time((SALT33.StrType)le.orig_filing_time),
    Main_Fields.InValid_case_number((SALT33.StrType)le.case_number),
    Main_Fields.InValid_filing_number((SALT33.StrType)le.filing_number),
    Main_Fields.InValid_filing_type_desc((SALT33.StrType)le.filing_type_desc),
    Main_Fields.InValid_filing_date((SALT33.StrType)le.filing_date),
    Main_Fields.InValid_filing_time((SALT33.StrType)le.filing_time),
    Main_Fields.InValid_vendor_entry_date((SALT33.StrType)le.vendor_entry_date),
    Main_Fields.InValid_judge((SALT33.StrType)le.judge),
    Main_Fields.InValid_case_title((SALT33.StrType)le.case_title),
    Main_Fields.InValid_filing_book((SALT33.StrType)le.filing_book),
    Main_Fields.InValid_filing_page((SALT33.StrType)le.filing_page),
    Main_Fields.InValid_release_date((SALT33.StrType)le.release_date),
    Main_Fields.InValid_amount((SALT33.StrType)le.amount),
    Main_Fields.InValid_eviction((SALT33.StrType)le.eviction),
    Main_Fields.InValid_satisifaction_type((SALT33.StrType)le.satisifaction_type),
    Main_Fields.InValid_judg_satisfied_date((SALT33.StrType)le.judg_satisfied_date),
    Main_Fields.InValid_judg_vacated_date((SALT33.StrType)le.judg_vacated_date),
    Main_Fields.InValid_tax_code((SALT33.StrType)le.tax_code),
    Main_Fields.InValid_irs_serial_number((SALT33.StrType)le.irs_serial_number),
    Main_Fields.InValid_effective_date((SALT33.StrType)le.effective_date),
    Main_Fields.InValid_lapse_date((SALT33.StrType)le.lapse_date),
    Main_Fields.InValid_accident_date((SALT33.StrType)le.accident_date),
    Main_Fields.InValid_sherrif_indc((SALT33.StrType)le.sherrif_indc),
    Main_Fields.InValid_expiration_date((SALT33.StrType)le.expiration_date),
    Main_Fields.InValid_agency((SALT33.StrType)le.agency),
    Main_Fields.InValid_agency_city((SALT33.StrType)le.agency_city),
    Main_Fields.InValid_agency_state((SALT33.StrType)le.agency_state),
    Main_Fields.InValid_agency_county((SALT33.StrType)le.agency_county),
    Main_Fields.InValid_legal_lot((SALT33.StrType)le.legal_lot),
    Main_Fields.InValid_legal_block((SALT33.StrType)le.legal_block),
    Main_Fields.InValid_legal_borough((SALT33.StrType)le.legal_borough),
    Main_Fields.InValid_certificate_number((SALT33.StrType)le.certificate_number),
    Main_Fields.InValid_persistent_record_id((SALT33.StrType)le.persistent_record_id),
    Main_Fields.InValid_source_file((SALT33.StrType)le.source_file),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source_file := le.source_file;
END;
Errors := NORMALIZE(h,45,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source_file;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source_file,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source_file;
  FieldNme := Main_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','invalid_date','invalid_record_code','invalid_date','Unknown','Unknown','Unknown','invalid_filing_type','invalid_date','invalid_number','Unknown','Unknown','invalid_filing_desc','invalid_date','invalid_number','invalid_date','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','invalid_eviction_ind','Unknown','invalid_date','invalid_date','Unknown','Unknown','invalid_date','invalid_date','invalid_date','Unknown','invalid_date','Unknown','invalid_alpha','invalid_alpha','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Main_Fields.InValidMessage_tmsid(TotalErrors.ErrorNum),Main_Fields.InValidMessage_rmsid(TotalErrors.ErrorNum),Main_Fields.InValidMessage_orig_rmsid(TotalErrors.ErrorNum),Main_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_record_code(TotalErrors.ErrorNum),Main_Fields.InValidMessage_date_vendor_removed(TotalErrors.ErrorNum),Main_Fields.InValidMessage_filing_jurisdiction(TotalErrors.ErrorNum),Main_Fields.InValidMessage_filing_state(TotalErrors.ErrorNum),Main_Fields.InValidMessage_orig_filing_number(TotalErrors.ErrorNum),Main_Fields.InValidMessage_orig_filing_type(TotalErrors.ErrorNum),Main_Fields.InValidMessage_orig_filing_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_orig_filing_time(TotalErrors.ErrorNum),Main_Fields.InValidMessage_case_number(TotalErrors.ErrorNum),Main_Fields.InValidMessage_filing_number(TotalErrors.ErrorNum),Main_Fields.InValidMessage_filing_type_desc(TotalErrors.ErrorNum),Main_Fields.InValidMessage_filing_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_filing_time(TotalErrors.ErrorNum),Main_Fields.InValidMessage_vendor_entry_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_judge(TotalErrors.ErrorNum),Main_Fields.InValidMessage_case_title(TotalErrors.ErrorNum),Main_Fields.InValidMessage_filing_book(TotalErrors.ErrorNum),Main_Fields.InValidMessage_filing_page(TotalErrors.ErrorNum),Main_Fields.InValidMessage_release_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_amount(TotalErrors.ErrorNum),Main_Fields.InValidMessage_eviction(TotalErrors.ErrorNum),Main_Fields.InValidMessage_satisifaction_type(TotalErrors.ErrorNum),Main_Fields.InValidMessage_judg_satisfied_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_judg_vacated_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_tax_code(TotalErrors.ErrorNum),Main_Fields.InValidMessage_irs_serial_number(TotalErrors.ErrorNum),Main_Fields.InValidMessage_effective_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_lapse_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_accident_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_sherrif_indc(TotalErrors.ErrorNum),Main_Fields.InValidMessage_expiration_date(TotalErrors.ErrorNum),Main_Fields.InValidMessage_agency(TotalErrors.ErrorNum),Main_Fields.InValidMessage_agency_city(TotalErrors.ErrorNum),Main_Fields.InValidMessage_agency_state(TotalErrors.ErrorNum),Main_Fields.InValidMessage_agency_county(TotalErrors.ErrorNum),Main_Fields.InValidMessage_legal_lot(TotalErrors.ErrorNum),Main_Fields.InValidMessage_legal_block(TotalErrors.ErrorNum),Main_Fields.InValidMessage_legal_borough(TotalErrors.ErrorNum),Main_Fields.InValidMessage_certificate_number(TotalErrors.ErrorNum),Main_Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),Main_Fields.InValidMessage_source_file(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source_file=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
