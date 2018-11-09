IMPORT SALT38,STD;
IMPORT Scrubs_DNB_FEIN; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 54;
  EXPORT NumRulesFromFieldType := 54;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 54;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_DNB_FEIN)
    UNSIGNED1 tmsid_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 orig_company_name_Invalid;
    UNSIGNED1 clean_cname_Invalid;
    UNSIGNED1 orig_address1_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip5_Invalid;
    UNSIGNED1 fein_Invalid;
    UNSIGNED1 source_duns_number_Invalid;
    UNSIGNED1 case_duns_number_Invalid;
    UNSIGNED1 duns_orig_source_Invalid;
    UNSIGNED1 confidence_code_Invalid;
    UNSIGNED1 indirect_direct_source_ind_Invalid;
    UNSIGNED1 best_fein_indicator_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 sic_code_Invalid;
    UNSIGNED1 telephone_number_Invalid;
    UNSIGNED1 top_contact_name_Invalid;
    UNSIGNED1 hdqtr_parent_duns_number_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
    UNSIGNED1 dotid_Invalid;
    UNSIGNED1 dotscore_Invalid;
    UNSIGNED1 dotweight_Invalid;
    UNSIGNED1 empid_Invalid;
    UNSIGNED1 empscore_Invalid;
    UNSIGNED1 empweight_Invalid;
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 powscore_Invalid;
    UNSIGNED1 powweight_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 proxscore_Invalid;
    UNSIGNED1 proxweight_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 selescore_Invalid;
    UNSIGNED1 seleweight_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 orgscore_Invalid;
    UNSIGNED1 orgweight_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 ultscore_Invalid;
    UNSIGNED1 ultweight_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_DNB_FEIN)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Layout_DNB_FEIN) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.tmsid_Invalid := Base_Fields.InValid_tmsid((SALT38.StrType)le.tmsid);
    SELF.bdid_Invalid := Base_Fields.InValid_bdid((SALT38.StrType)le.bdid);
    SELF.date_first_seen_Invalid := Base_Fields.InValid_date_first_seen((SALT38.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_Fields.InValid_date_last_seen((SALT38.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Base_Fields.InValid_date_vendor_first_reported((SALT38.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Base_Fields.InValid_date_vendor_last_reported((SALT38.StrType)le.date_vendor_last_reported);
    SELF.orig_company_name_Invalid := Base_Fields.InValid_orig_company_name((SALT38.StrType)le.orig_company_name);
    SELF.clean_cname_Invalid := Base_Fields.InValid_clean_cname((SALT38.StrType)le.clean_cname);
    SELF.orig_address1_Invalid := Base_Fields.InValid_orig_address1((SALT38.StrType)le.orig_address1);
    SELF.orig_city_Invalid := Base_Fields.InValid_orig_city((SALT38.StrType)le.orig_city);
    SELF.orig_state_Invalid := Base_Fields.InValid_orig_state((SALT38.StrType)le.orig_state);
    SELF.orig_zip5_Invalid := Base_Fields.InValid_orig_zip5((SALT38.StrType)le.orig_zip5);
    SELF.fein_Invalid := Base_Fields.InValid_fein((SALT38.StrType)le.fein);
    SELF.source_duns_number_Invalid := Base_Fields.InValid_source_duns_number((SALT38.StrType)le.source_duns_number);
    SELF.case_duns_number_Invalid := Base_Fields.InValid_case_duns_number((SALT38.StrType)le.case_duns_number);
    SELF.duns_orig_source_Invalid := Base_Fields.InValid_duns_orig_source((SALT38.StrType)le.duns_orig_source);
    SELF.confidence_code_Invalid := Base_Fields.InValid_confidence_code((SALT38.StrType)le.confidence_code);
    SELF.indirect_direct_source_ind_Invalid := Base_Fields.InValid_indirect_direct_source_ind((SALT38.StrType)le.indirect_direct_source_ind);
    SELF.best_fein_indicator_Invalid := Base_Fields.InValid_best_fein_indicator((SALT38.StrType)le.best_fein_indicator);
    SELF.company_name_Invalid := Base_Fields.InValid_company_name((SALT38.StrType)le.company_name);
    SELF.sic_code_Invalid := Base_Fields.InValid_sic_code((SALT38.StrType)le.sic_code);
    SELF.telephone_number_Invalid := Base_Fields.InValid_telephone_number((SALT38.StrType)le.telephone_number);
    SELF.top_contact_name_Invalid := Base_Fields.InValid_top_contact_name((SALT38.StrType)le.top_contact_name);
    SELF.hdqtr_parent_duns_number_Invalid := Base_Fields.InValid_hdqtr_parent_duns_number((SALT38.StrType)le.hdqtr_parent_duns_number);
    SELF.lname_Invalid := Base_Fields.InValid_lname((SALT38.StrType)le.lname,(SALT38.StrType)le.mname,(SALT38.StrType)le.fname,(SALT38.StrType)le.top_contact_name);
    SELF.prim_name_Invalid := Base_Fields.InValid_prim_name((SALT38.StrType)le.prim_name);
    SELF.p_city_name_Invalid := Base_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Base_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name);
    SELF.st_Invalid := Base_Fields.InValid_st((SALT38.StrType)le.st);
    SELF.zip_Invalid := Base_Fields.InValid_zip((SALT38.StrType)le.zip);
    SELF.prep_addr_line1_Invalid := Base_Fields.InValid_prep_addr_line1((SALT38.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Base_Fields.InValid_prep_addr_line_last((SALT38.StrType)le.prep_addr_line_last);
    SELF.source_rec_id_Invalid := Base_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id);
    SELF.dotid_Invalid := Base_Fields.InValid_dotid((SALT38.StrType)le.dotid);
    SELF.dotscore_Invalid := Base_Fields.InValid_dotscore((SALT38.StrType)le.dotscore);
    SELF.dotweight_Invalid := Base_Fields.InValid_dotweight((SALT38.StrType)le.dotweight);
    SELF.empid_Invalid := Base_Fields.InValid_empid((SALT38.StrType)le.empid);
    SELF.empscore_Invalid := Base_Fields.InValid_empscore((SALT38.StrType)le.empscore);
    SELF.empweight_Invalid := Base_Fields.InValid_empweight((SALT38.StrType)le.empweight);
    SELF.powid_Invalid := Base_Fields.InValid_powid((SALT38.StrType)le.powid);
    SELF.powscore_Invalid := Base_Fields.InValid_powscore((SALT38.StrType)le.powscore);
    SELF.powweight_Invalid := Base_Fields.InValid_powweight((SALT38.StrType)le.powweight);
    SELF.proxid_Invalid := Base_Fields.InValid_proxid((SALT38.StrType)le.proxid);
    SELF.proxscore_Invalid := Base_Fields.InValid_proxscore((SALT38.StrType)le.proxscore);
    SELF.proxweight_Invalid := Base_Fields.InValid_proxweight((SALT38.StrType)le.proxweight);
    SELF.seleid_Invalid := Base_Fields.InValid_seleid((SALT38.StrType)le.seleid);
    SELF.selescore_Invalid := Base_Fields.InValid_selescore((SALT38.StrType)le.selescore);
    SELF.seleweight_Invalid := Base_Fields.InValid_seleweight((SALT38.StrType)le.seleweight);
    SELF.orgid_Invalid := Base_Fields.InValid_orgid((SALT38.StrType)le.orgid);
    SELF.orgscore_Invalid := Base_Fields.InValid_orgscore((SALT38.StrType)le.orgscore);
    SELF.orgweight_Invalid := Base_Fields.InValid_orgweight((SALT38.StrType)le.orgweight);
    SELF.ultid_Invalid := Base_Fields.InValid_ultid((SALT38.StrType)le.ultid);
    SELF.ultscore_Invalid := Base_Fields.InValid_ultscore((SALT38.StrType)le.ultscore);
    SELF.ultweight_Invalid := Base_Fields.InValid_ultweight((SALT38.StrType)le.ultweight);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_DNB_FEIN);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.tmsid_Invalid << 0 ) + ( le.bdid_Invalid << 1 ) + ( le.date_first_seen_Invalid << 2 ) + ( le.date_last_seen_Invalid << 3 ) + ( le.date_vendor_first_reported_Invalid << 4 ) + ( le.date_vendor_last_reported_Invalid << 5 ) + ( le.orig_company_name_Invalid << 6 ) + ( le.clean_cname_Invalid << 7 ) + ( le.orig_address1_Invalid << 8 ) + ( le.orig_city_Invalid << 9 ) + ( le.orig_state_Invalid << 10 ) + ( le.orig_zip5_Invalid << 11 ) + ( le.fein_Invalid << 12 ) + ( le.source_duns_number_Invalid << 13 ) + ( le.case_duns_number_Invalid << 14 ) + ( le.duns_orig_source_Invalid << 15 ) + ( le.confidence_code_Invalid << 16 ) + ( le.indirect_direct_source_ind_Invalid << 17 ) + ( le.best_fein_indicator_Invalid << 18 ) + ( le.company_name_Invalid << 19 ) + ( le.sic_code_Invalid << 20 ) + ( le.telephone_number_Invalid << 21 ) + ( le.top_contact_name_Invalid << 22 ) + ( le.hdqtr_parent_duns_number_Invalid << 23 ) + ( le.lname_Invalid << 24 ) + ( le.prim_name_Invalid << 25 ) + ( le.p_city_name_Invalid << 26 ) + ( le.v_city_name_Invalid << 27 ) + ( le.st_Invalid << 28 ) + ( le.zip_Invalid << 29 ) + ( le.prep_addr_line1_Invalid << 30 ) + ( le.prep_addr_line_last_Invalid << 31 ) + ( le.source_rec_id_Invalid << 32 ) + ( le.dotid_Invalid << 33 ) + ( le.dotscore_Invalid << 34 ) + ( le.dotweight_Invalid << 35 ) + ( le.empid_Invalid << 36 ) + ( le.empscore_Invalid << 37 ) + ( le.empweight_Invalid << 38 ) + ( le.powid_Invalid << 39 ) + ( le.powscore_Invalid << 40 ) + ( le.powweight_Invalid << 41 ) + ( le.proxid_Invalid << 42 ) + ( le.proxscore_Invalid << 43 ) + ( le.proxweight_Invalid << 44 ) + ( le.seleid_Invalid << 45 ) + ( le.selescore_Invalid << 46 ) + ( le.seleweight_Invalid << 47 ) + ( le.orgid_Invalid << 48 ) + ( le.orgscore_Invalid << 49 ) + ( le.orgweight_Invalid << 50 ) + ( le.ultid_Invalid << 51 ) + ( le.ultscore_Invalid << 52 ) + ( le.ultweight_Invalid << 53 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_DNB_FEIN);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.tmsid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_company_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.clean_cname_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.orig_address1_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_zip5_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.fein_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.source_duns_number_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.case_duns_number_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.duns_orig_source_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.confidence_code_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.indirect_direct_source_ind_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.best_fein_indicator_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.sic_code_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.telephone_number_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.top_contact_name_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.hdqtr_parent_duns_number_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.dotid_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.dotscore_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.dotweight_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.empid_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.empscore_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.empweight_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.powid_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.powscore_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.powweight_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.proxscore_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.proxweight_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.selescore_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.seleweight_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.orgscore_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.orgweight_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.ultscore_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.ultweight_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    tmsid_CUSTOM_ErrorCount := COUNT(GROUP,h.tmsid_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    orig_company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_company_name_Invalid=1);
    clean_cname_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_cname_Invalid=1);
    orig_address1_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_address1_Invalid=1);
    orig_city_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_state_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip5_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=1);
    fein_CUSTOM_ErrorCount := COUNT(GROUP,h.fein_Invalid=1);
    source_duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.source_duns_number_Invalid=1);
    case_duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.case_duns_number_Invalid=1);
    duns_orig_source_CUSTOM_ErrorCount := COUNT(GROUP,h.duns_orig_source_Invalid=1);
    confidence_code_CUSTOM_ErrorCount := COUNT(GROUP,h.confidence_code_Invalid=1);
    indirect_direct_source_ind_ENUM_ErrorCount := COUNT(GROUP,h.indirect_direct_source_ind_Invalid=1);
    best_fein_indicator_ENUM_ErrorCount := COUNT(GROUP,h.best_fein_indicator_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sic_code_Invalid=1);
    telephone_number_CUSTOM_ErrorCount := COUNT(GROUP,h.telephone_number_Invalid=1);
    top_contact_name_CUSTOM_ErrorCount := COUNT(GROUP,h.top_contact_name_Invalid=1);
    hdqtr_parent_duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.hdqtr_parent_duns_number_Invalid=1);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    prep_addr_line1_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_line_last_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_line_last_Invalid=1);
    source_rec_id_CUSTOM_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    dotid_ENUM_ErrorCount := COUNT(GROUP,h.dotid_Invalid=1);
    dotscore_ENUM_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=1);
    dotweight_ENUM_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=1);
    empid_ENUM_ErrorCount := COUNT(GROUP,h.empid_Invalid=1);
    empscore_ENUM_ErrorCount := COUNT(GROUP,h.empscore_Invalid=1);
    empweight_ENUM_ErrorCount := COUNT(GROUP,h.empweight_Invalid=1);
    powid_CUSTOM_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    powscore_CUSTOM_ErrorCount := COUNT(GROUP,h.powscore_Invalid=1);
    powweight_CUSTOM_ErrorCount := COUNT(GROUP,h.powweight_Invalid=1);
    proxid_CUSTOM_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    proxscore_CUSTOM_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=1);
    proxweight_CUSTOM_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=1);
    seleid_CUSTOM_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    selescore_CUSTOM_ErrorCount := COUNT(GROUP,h.selescore_Invalid=1);
    seleweight_CUSTOM_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=1);
    orgid_CUSTOM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgscore_CUSTOM_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=1);
    orgweight_CUSTOM_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=1);
    ultid_CUSTOM_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultscore_CUSTOM_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=1);
    ultweight_CUSTOM_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.tmsid_Invalid > 0 OR h.bdid_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.date_vendor_first_reported_Invalid > 0 OR h.date_vendor_last_reported_Invalid > 0 OR h.orig_company_name_Invalid > 0 OR h.clean_cname_Invalid > 0 OR h.orig_address1_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip5_Invalid > 0 OR h.fein_Invalid > 0 OR h.source_duns_number_Invalid > 0 OR h.case_duns_number_Invalid > 0 OR h.duns_orig_source_Invalid > 0 OR h.confidence_code_Invalid > 0 OR h.indirect_direct_source_ind_Invalid > 0 OR h.best_fein_indicator_Invalid > 0 OR h.company_name_Invalid > 0 OR h.sic_code_Invalid > 0 OR h.telephone_number_Invalid > 0 OR h.top_contact_name_Invalid > 0 OR h.hdqtr_parent_duns_number_Invalid > 0 OR h.lname_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.prep_addr_line1_Invalid > 0 OR h.prep_addr_line_last_Invalid > 0 OR h.source_rec_id_Invalid > 0 OR h.dotid_Invalid > 0 OR h.dotscore_Invalid > 0 OR h.dotweight_Invalid > 0 OR h.empid_Invalid > 0 OR h.empscore_Invalid > 0 OR h.empweight_Invalid > 0 OR h.powid_Invalid > 0 OR h.powscore_Invalid > 0 OR h.powweight_Invalid > 0 OR h.proxid_Invalid > 0 OR h.proxscore_Invalid > 0 OR h.proxweight_Invalid > 0 OR h.seleid_Invalid > 0 OR h.selescore_Invalid > 0 OR h.seleweight_Invalid > 0 OR h.orgid_Invalid > 0 OR h.orgscore_Invalid > 0 OR h.orgweight_Invalid > 0 OR h.ultid_Invalid > 0 OR h.ultscore_Invalid > 0 OR h.ultweight_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.tmsid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_cname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fein_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.case_duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.duns_orig_source_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.confidence_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.indirect_direct_source_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.best_fein_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.telephone_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.top_contact_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hdqtr_parent_duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dotid_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.empid_ENUM_ErrorCount > 0, 1, 0) + IF(le.empscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.empweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.powid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.selescore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultweight_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.tmsid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_cname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fein_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.case_duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.duns_orig_source_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.confidence_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.indirect_direct_source_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.best_fein_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.telephone_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.top_contact_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.hdqtr_parent_duns_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dotid_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.empid_ENUM_ErrorCount > 0, 1, 0) + IF(le.empscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.empweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.powid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.selescore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultweight_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.tmsid_Invalid,le.bdid_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.orig_company_name_Invalid,le.clean_cname_Invalid,le.orig_address1_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip5_Invalid,le.fein_Invalid,le.source_duns_number_Invalid,le.case_duns_number_Invalid,le.duns_orig_source_Invalid,le.confidence_code_Invalid,le.indirect_direct_source_ind_Invalid,le.best_fein_indicator_Invalid,le.company_name_Invalid,le.sic_code_Invalid,le.telephone_number_Invalid,le.top_contact_name_Invalid,le.hdqtr_parent_duns_number_Invalid,le.lname_Invalid,le.prim_name_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,le.source_rec_id_Invalid,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_tmsid(le.tmsid_Invalid),Base_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_orig_company_name(le.orig_company_name_Invalid),Base_Fields.InvalidMessage_clean_cname(le.clean_cname_Invalid),Base_Fields.InvalidMessage_orig_address1(le.orig_address1_Invalid),Base_Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Base_Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Base_Fields.InvalidMessage_orig_zip5(le.orig_zip5_Invalid),Base_Fields.InvalidMessage_fein(le.fein_Invalid),Base_Fields.InvalidMessage_source_duns_number(le.source_duns_number_Invalid),Base_Fields.InvalidMessage_case_duns_number(le.case_duns_number_Invalid),Base_Fields.InvalidMessage_duns_orig_source(le.duns_orig_source_Invalid),Base_Fields.InvalidMessage_confidence_code(le.confidence_code_Invalid),Base_Fields.InvalidMessage_indirect_direct_source_ind(le.indirect_direct_source_ind_Invalid),Base_Fields.InvalidMessage_best_fein_indicator(le.best_fein_indicator_Invalid),Base_Fields.InvalidMessage_company_name(le.company_name_Invalid),Base_Fields.InvalidMessage_sic_code(le.sic_code_Invalid),Base_Fields.InvalidMessage_telephone_number(le.telephone_number_Invalid),Base_Fields.InvalidMessage_top_contact_name(le.top_contact_name_Invalid),Base_Fields.InvalidMessage_hdqtr_parent_duns_number(le.hdqtr_parent_duns_number_Invalid),Base_Fields.InvalidMessage_lname(le.lname_Invalid),Base_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Base_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Base_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Base_Fields.InvalidMessage_st(le.st_Invalid),Base_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Base_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),Base_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),Base_Fields.InvalidMessage_dotid(le.dotid_Invalid),Base_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),Base_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),Base_Fields.InvalidMessage_empid(le.empid_Invalid),Base_Fields.InvalidMessage_empscore(le.empscore_Invalid),Base_Fields.InvalidMessage_empweight(le.empweight_Invalid),Base_Fields.InvalidMessage_powid(le.powid_Invalid),Base_Fields.InvalidMessage_powscore(le.powscore_Invalid),Base_Fields.InvalidMessage_powweight(le.powweight_Invalid),Base_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),Base_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),Base_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_Fields.InvalidMessage_selescore(le.selescore_Invalid),Base_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),Base_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),Base_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),Base_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),Base_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.tmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_cname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fein_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.case_duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.duns_orig_source_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.confidence_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.indirect_direct_source_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.best_fein_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.telephone_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.top_contact_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hdqtr_parent_duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dotid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.powscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.powweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.selescore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultweight_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'tmsid','bdid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','orig_company_name','clean_cname','orig_address1','orig_city','orig_state','orig_zip5','fein','source_duns_number','case_duns_number','duns_orig_source','confidence_code','indirect_direct_source_ind','best_fein_indicator','company_name','sic_code','telephone_number','top_contact_name','hdqtr_parent_duns_number','lname','prim_name','p_city_name','v_city_name','st','zip','prep_addr_line1','prep_addr_line_last','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_tmsid','invalid_bdid','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_orig_state','invalid_orig_zip5','invalid_fein','invalid_source_duns_number','invalid_case_duns_number','invalid_mandatory','invalid_confidence_code','invalid_indirect_direct_source_ind','invalid_best_fein_indicator','invalid_mandatory','invalid_sic_code','invalid_telephone_number','invalid_mandatory','invalid_hdqtr_parent_duns_number','invalid_lname','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_source_rec_id','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_mandatory','invalid_percentage','invalid_weight','invalid_mandatory','invalid_percentage','invalid_weight','invalid_mandatory','invalid_percentage','invalid_weight','invalid_mandatory','invalid_percentage','invalid_weight','invalid_mandatory','invalid_percentage','invalid_weight','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.tmsid,(SALT38.StrType)le.bdid,(SALT38.StrType)le.date_first_seen,(SALT38.StrType)le.date_last_seen,(SALT38.StrType)le.date_vendor_first_reported,(SALT38.StrType)le.date_vendor_last_reported,(SALT38.StrType)le.orig_company_name,(SALT38.StrType)le.clean_cname,(SALT38.StrType)le.orig_address1,(SALT38.StrType)le.orig_city,(SALT38.StrType)le.orig_state,(SALT38.StrType)le.orig_zip5,(SALT38.StrType)le.fein,(SALT38.StrType)le.source_duns_number,(SALT38.StrType)le.case_duns_number,(SALT38.StrType)le.duns_orig_source,(SALT38.StrType)le.confidence_code,(SALT38.StrType)le.indirect_direct_source_ind,(SALT38.StrType)le.best_fein_indicator,(SALT38.StrType)le.company_name,(SALT38.StrType)le.sic_code,(SALT38.StrType)le.telephone_number,(SALT38.StrType)le.top_contact_name,(SALT38.StrType)le.hdqtr_parent_duns_number,(SALT38.StrType)le.lname,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.p_city_name,(SALT38.StrType)le.v_city_name,(SALT38.StrType)le.st,(SALT38.StrType)le.zip,(SALT38.StrType)le.prep_addr_line1,(SALT38.StrType)le.prep_addr_line_last,(SALT38.StrType)le.source_rec_id,(SALT38.StrType)le.dotid,(SALT38.StrType)le.dotscore,(SALT38.StrType)le.dotweight,(SALT38.StrType)le.empid,(SALT38.StrType)le.empscore,(SALT38.StrType)le.empweight,(SALT38.StrType)le.powid,(SALT38.StrType)le.powscore,(SALT38.StrType)le.powweight,(SALT38.StrType)le.proxid,(SALT38.StrType)le.proxscore,(SALT38.StrType)le.proxweight,(SALT38.StrType)le.seleid,(SALT38.StrType)le.selescore,(SALT38.StrType)le.seleweight,(SALT38.StrType)le.orgid,(SALT38.StrType)le.orgscore,(SALT38.StrType)le.orgweight,(SALT38.StrType)le.ultid,(SALT38.StrType)le.ultscore,(SALT38.StrType)le.ultweight,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,54,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_DNB_FEIN) prevDS = DATASET([], Base_Layout_DNB_FEIN), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'tmsid:invalid_tmsid:CUSTOM'
          ,'bdid:invalid_bdid:CUSTOM'
          ,'date_first_seen:invalid_pastdate8:CUSTOM'
          ,'date_last_seen:invalid_pastdate8:CUSTOM'
          ,'date_vendor_first_reported:invalid_pastdate8:CUSTOM'
          ,'date_vendor_last_reported:invalid_pastdate8:CUSTOM'
          ,'orig_company_name:invalid_mandatory:CUSTOM'
          ,'clean_cname:invalid_mandatory:CUSTOM'
          ,'orig_address1:invalid_mandatory:CUSTOM'
          ,'orig_city:invalid_mandatory:CUSTOM'
          ,'orig_state:invalid_orig_state:CUSTOM'
          ,'orig_zip5:invalid_orig_zip5:CUSTOM'
          ,'fein:invalid_fein:CUSTOM'
          ,'source_duns_number:invalid_source_duns_number:CUSTOM'
          ,'case_duns_number:invalid_case_duns_number:CUSTOM'
          ,'duns_orig_source:invalid_mandatory:CUSTOM'
          ,'confidence_code:invalid_confidence_code:CUSTOM'
          ,'indirect_direct_source_ind:invalid_indirect_direct_source_ind:ENUM'
          ,'best_fein_indicator:invalid_best_fein_indicator:ENUM'
          ,'company_name:invalid_mandatory:CUSTOM'
          ,'sic_code:invalid_sic_code:CUSTOM'
          ,'telephone_number:invalid_telephone_number:CUSTOM'
          ,'top_contact_name:invalid_mandatory:CUSTOM'
          ,'hdqtr_parent_duns_number:invalid_hdqtr_parent_duns_number:CUSTOM'
          ,'lname:invalid_lname:CUSTOM'
          ,'prim_name:invalid_mandatory:CUSTOM'
          ,'p_city_name:invalid_mandatory:CUSTOM'
          ,'v_city_name:invalid_mandatory:CUSTOM'
          ,'st:invalid_mandatory:CUSTOM'
          ,'zip:invalid_mandatory:CUSTOM'
          ,'prep_addr_line1:invalid_mandatory:CUSTOM'
          ,'prep_addr_line_last:invalid_mandatory:CUSTOM'
          ,'source_rec_id:invalid_source_rec_id:CUSTOM'
          ,'dotid:invalid_zero_integer:ENUM'
          ,'dotscore:invalid_zero_integer:ENUM'
          ,'dotweight:invalid_zero_integer:ENUM'
          ,'empid:invalid_zero_integer:ENUM'
          ,'empscore:invalid_zero_integer:ENUM'
          ,'empweight:invalid_zero_integer:ENUM'
          ,'powid:invalid_mandatory:CUSTOM'
          ,'powscore:invalid_percentage:CUSTOM'
          ,'powweight:invalid_weight:CUSTOM'
          ,'proxid:invalid_mandatory:CUSTOM'
          ,'proxscore:invalid_percentage:CUSTOM'
          ,'proxweight:invalid_weight:CUSTOM'
          ,'seleid:invalid_mandatory:CUSTOM'
          ,'selescore:invalid_percentage:CUSTOM'
          ,'seleweight:invalid_weight:CUSTOM'
          ,'orgid:invalid_mandatory:CUSTOM'
          ,'orgscore:invalid_percentage:CUSTOM'
          ,'orgweight:invalid_weight:CUSTOM'
          ,'ultid:invalid_mandatory:CUSTOM'
          ,'ultscore:invalid_percentage:CUSTOM'
          ,'ultweight:invalid_weight:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_tmsid(1)
          ,Base_Fields.InvalidMessage_bdid(1)
          ,Base_Fields.InvalidMessage_date_first_seen(1)
          ,Base_Fields.InvalidMessage_date_last_seen(1)
          ,Base_Fields.InvalidMessage_date_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_date_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_orig_company_name(1)
          ,Base_Fields.InvalidMessage_clean_cname(1)
          ,Base_Fields.InvalidMessage_orig_address1(1)
          ,Base_Fields.InvalidMessage_orig_city(1)
          ,Base_Fields.InvalidMessage_orig_state(1)
          ,Base_Fields.InvalidMessage_orig_zip5(1)
          ,Base_Fields.InvalidMessage_fein(1)
          ,Base_Fields.InvalidMessage_source_duns_number(1)
          ,Base_Fields.InvalidMessage_case_duns_number(1)
          ,Base_Fields.InvalidMessage_duns_orig_source(1)
          ,Base_Fields.InvalidMessage_confidence_code(1)
          ,Base_Fields.InvalidMessage_indirect_direct_source_ind(1)
          ,Base_Fields.InvalidMessage_best_fein_indicator(1)
          ,Base_Fields.InvalidMessage_company_name(1)
          ,Base_Fields.InvalidMessage_sic_code(1)
          ,Base_Fields.InvalidMessage_telephone_number(1)
          ,Base_Fields.InvalidMessage_top_contact_name(1)
          ,Base_Fields.InvalidMessage_hdqtr_parent_duns_number(1)
          ,Base_Fields.InvalidMessage_lname(1)
          ,Base_Fields.InvalidMessage_prim_name(1)
          ,Base_Fields.InvalidMessage_p_city_name(1)
          ,Base_Fields.InvalidMessage_v_city_name(1)
          ,Base_Fields.InvalidMessage_st(1)
          ,Base_Fields.InvalidMessage_zip(1)
          ,Base_Fields.InvalidMessage_prep_addr_line1(1)
          ,Base_Fields.InvalidMessage_prep_addr_line_last(1)
          ,Base_Fields.InvalidMessage_source_rec_id(1)
          ,Base_Fields.InvalidMessage_dotid(1)
          ,Base_Fields.InvalidMessage_dotscore(1)
          ,Base_Fields.InvalidMessage_dotweight(1)
          ,Base_Fields.InvalidMessage_empid(1)
          ,Base_Fields.InvalidMessage_empscore(1)
          ,Base_Fields.InvalidMessage_empweight(1)
          ,Base_Fields.InvalidMessage_powid(1)
          ,Base_Fields.InvalidMessage_powscore(1)
          ,Base_Fields.InvalidMessage_powweight(1)
          ,Base_Fields.InvalidMessage_proxid(1)
          ,Base_Fields.InvalidMessage_proxscore(1)
          ,Base_Fields.InvalidMessage_proxweight(1)
          ,Base_Fields.InvalidMessage_seleid(1)
          ,Base_Fields.InvalidMessage_selescore(1)
          ,Base_Fields.InvalidMessage_seleweight(1)
          ,Base_Fields.InvalidMessage_orgid(1)
          ,Base_Fields.InvalidMessage_orgscore(1)
          ,Base_Fields.InvalidMessage_orgweight(1)
          ,Base_Fields.InvalidMessage_ultid(1)
          ,Base_Fields.InvalidMessage_ultscore(1)
          ,Base_Fields.InvalidMessage_ultweight(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.orig_company_name_CUSTOM_ErrorCount
          ,le.clean_cname_CUSTOM_ErrorCount
          ,le.orig_address1_CUSTOM_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip5_CUSTOM_ErrorCount
          ,le.fein_CUSTOM_ErrorCount
          ,le.source_duns_number_CUSTOM_ErrorCount
          ,le.case_duns_number_CUSTOM_ErrorCount
          ,le.duns_orig_source_CUSTOM_ErrorCount
          ,le.confidence_code_CUSTOM_ErrorCount
          ,le.indirect_direct_source_ind_ENUM_ErrorCount
          ,le.best_fein_indicator_ENUM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.telephone_number_CUSTOM_ErrorCount
          ,le.top_contact_name_CUSTOM_ErrorCount
          ,le.hdqtr_parent_duns_number_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_line_last_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.dotid_ENUM_ErrorCount
          ,le.dotscore_ENUM_ErrorCount
          ,le.dotweight_ENUM_ErrorCount
          ,le.empid_ENUM_ErrorCount
          ,le.empscore_ENUM_ErrorCount
          ,le.empweight_ENUM_ErrorCount
          ,le.powid_CUSTOM_ErrorCount
          ,le.powscore_CUSTOM_ErrorCount
          ,le.powweight_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.proxscore_CUSTOM_ErrorCount
          ,le.proxweight_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.selescore_CUSTOM_ErrorCount
          ,le.seleweight_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.orgscore_CUSTOM_ErrorCount
          ,le.orgweight_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.ultscore_CUSTOM_ErrorCount
          ,le.ultweight_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.date_vendor_first_reported_CUSTOM_ErrorCount
          ,le.date_vendor_last_reported_CUSTOM_ErrorCount
          ,le.orig_company_name_CUSTOM_ErrorCount
          ,le.clean_cname_CUSTOM_ErrorCount
          ,le.orig_address1_CUSTOM_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip5_CUSTOM_ErrorCount
          ,le.fein_CUSTOM_ErrorCount
          ,le.source_duns_number_CUSTOM_ErrorCount
          ,le.case_duns_number_CUSTOM_ErrorCount
          ,le.duns_orig_source_CUSTOM_ErrorCount
          ,le.confidence_code_CUSTOM_ErrorCount
          ,le.indirect_direct_source_ind_ENUM_ErrorCount
          ,le.best_fein_indicator_ENUM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.sic_code_CUSTOM_ErrorCount
          ,le.telephone_number_CUSTOM_ErrorCount
          ,le.top_contact_name_CUSTOM_ErrorCount
          ,le.hdqtr_parent_duns_number_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_line_last_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.dotid_ENUM_ErrorCount
          ,le.dotscore_ENUM_ErrorCount
          ,le.dotweight_ENUM_ErrorCount
          ,le.empid_ENUM_ErrorCount
          ,le.empscore_ENUM_ErrorCount
          ,le.empweight_ENUM_ErrorCount
          ,le.powid_CUSTOM_ErrorCount
          ,le.powscore_CUSTOM_ErrorCount
          ,le.powweight_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.proxscore_CUSTOM_ErrorCount
          ,le.proxweight_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.selescore_CUSTOM_ErrorCount
          ,le.seleweight_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.orgscore_CUSTOM_ErrorCount
          ,le.orgweight_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.ultscore_CUSTOM_ErrorCount
          ,le.ultweight_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_DNB_FEIN));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'tmsid:' + getFieldTypeText(h.tmsid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_first_reported:' + getFieldTypeText(h.date_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_last_reported:' + getFieldTypeText(h.date_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_company_name:' + getFieldTypeText(h.orig_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_cname:' + getFieldTypeText(h.clean_cname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address1:' + getFieldTypeText(h.orig_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address2:' + getFieldTypeText(h.orig_address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip5:' + getFieldTypeText(h.orig_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip4:' + getFieldTypeText(h.orig_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_county:' + getFieldTypeText(h.orig_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fein:' + getFieldTypeText(h.fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_duns_number:' + getFieldTypeText(h.source_duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_duns_number:' + getFieldTypeText(h.case_duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'duns_orig_source:' + getFieldTypeText(h.duns_orig_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'confidence_code:' + getFieldTypeText(h.confidence_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'indirect_direct_source_ind:' + getFieldTypeText(h.indirect_direct_source_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'best_fein_indicator:' + getFieldTypeText(h.best_fein_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trade_style:' + getFieldTypeText(h.trade_style) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic_code:' + getFieldTypeText(h.sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telephone_number:' + getFieldTypeText(h.telephone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top_contact_name:' + getFieldTypeText(h.top_contact_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top_contact_title:' + getFieldTypeText(h.top_contact_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hdqtr_parent_duns_number:' + getFieldTypeText(h.hdqtr_parent_duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_aid:' + getFieldTypeText(h.raw_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_aid:' + getFieldTypeText(h.ace_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line1:' + getFieldTypeText(h.prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line_last:' + getFieldTypeText(h.prep_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotid:' + getFieldTypeText(h.dotid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotscore:' + getFieldTypeText(h.dotscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotweight:' + getFieldTypeText(h.dotweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empid:' + getFieldTypeText(h.empid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empscore:' + getFieldTypeText(h.empscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empweight:' + getFieldTypeText(h.empweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powscore:' + getFieldTypeText(h.powscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powweight:' + getFieldTypeText(h.powweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxscore:' + getFieldTypeText(h.proxscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxweight:' + getFieldTypeText(h.proxweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selescore:' + getFieldTypeText(h.selescore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleweight:' + getFieldTypeText(h.seleweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgscore:' + getFieldTypeText(h.orgscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgweight:' + getFieldTypeText(h.orgweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultscore:' + getFieldTypeText(h.ultscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_tmsid_cnt
          ,le.populated_bdid_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_date_vendor_first_reported_cnt
          ,le.populated_date_vendor_last_reported_cnt
          ,le.populated_orig_company_name_cnt
          ,le.populated_clean_cname_cnt
          ,le.populated_orig_address1_cnt
          ,le.populated_orig_address2_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip5_cnt
          ,le.populated_orig_zip4_cnt
          ,le.populated_orig_county_cnt
          ,le.populated_fein_cnt
          ,le.populated_source_duns_number_cnt
          ,le.populated_case_duns_number_cnt
          ,le.populated_duns_orig_source_cnt
          ,le.populated_confidence_code_cnt
          ,le.populated_indirect_direct_source_ind_cnt
          ,le.populated_best_fein_indicator_cnt
          ,le.populated_company_name_cnt
          ,le.populated_trade_style_cnt
          ,le.populated_sic_code_cnt
          ,le.populated_telephone_number_cnt
          ,le.populated_top_contact_name_cnt
          ,le.populated_top_contact_title_cnt
          ,le.populated_hdqtr_parent_duns_number_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_raw_aid_cnt
          ,le.populated_ace_aid_cnt
          ,le.populated_prep_addr_line1_cnt
          ,le.populated_prep_addr_line_last_cnt
          ,le.populated_source_rec_id_cnt
          ,le.populated_dotid_cnt
          ,le.populated_dotscore_cnt
          ,le.populated_dotweight_cnt
          ,le.populated_empid_cnt
          ,le.populated_empscore_cnt
          ,le.populated_empweight_cnt
          ,le.populated_powid_cnt
          ,le.populated_powscore_cnt
          ,le.populated_powweight_cnt
          ,le.populated_proxid_cnt
          ,le.populated_proxscore_cnt
          ,le.populated_proxweight_cnt
          ,le.populated_seleid_cnt
          ,le.populated_selescore_cnt
          ,le.populated_seleweight_cnt
          ,le.populated_orgid_cnt
          ,le.populated_orgscore_cnt
          ,le.populated_orgweight_cnt
          ,le.populated_ultid_cnt
          ,le.populated_ultscore_cnt
          ,le.populated_ultweight_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_tmsid_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_date_vendor_first_reported_pcnt
          ,le.populated_date_vendor_last_reported_pcnt
          ,le.populated_orig_company_name_pcnt
          ,le.populated_clean_cname_pcnt
          ,le.populated_orig_address1_pcnt
          ,le.populated_orig_address2_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip5_pcnt
          ,le.populated_orig_zip4_pcnt
          ,le.populated_orig_county_pcnt
          ,le.populated_fein_pcnt
          ,le.populated_source_duns_number_pcnt
          ,le.populated_case_duns_number_pcnt
          ,le.populated_duns_orig_source_pcnt
          ,le.populated_confidence_code_pcnt
          ,le.populated_indirect_direct_source_ind_pcnt
          ,le.populated_best_fein_indicator_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_trade_style_pcnt
          ,le.populated_sic_code_pcnt
          ,le.populated_telephone_number_pcnt
          ,le.populated_top_contact_name_pcnt
          ,le.populated_top_contact_title_pcnt
          ,le.populated_hdqtr_parent_duns_number_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_raw_aid_pcnt
          ,le.populated_ace_aid_pcnt
          ,le.populated_prep_addr_line1_pcnt
          ,le.populated_prep_addr_line_last_pcnt
          ,le.populated_source_rec_id_pcnt
          ,le.populated_dotid_pcnt
          ,le.populated_dotscore_pcnt
          ,le.populated_dotweight_pcnt
          ,le.populated_empid_pcnt
          ,le.populated_empscore_pcnt
          ,le.populated_empweight_pcnt
          ,le.populated_powid_pcnt
          ,le.populated_powscore_pcnt
          ,le.populated_powweight_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_proxscore_pcnt
          ,le.populated_proxweight_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_selescore_pcnt
          ,le.populated_seleweight_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_orgscore_pcnt
          ,le.populated_orgweight_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_ultscore_pcnt
          ,le.populated_ultweight_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,87,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_DNB_FEIN));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),87,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_DNB_FEIN) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DNB_FEIN, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
