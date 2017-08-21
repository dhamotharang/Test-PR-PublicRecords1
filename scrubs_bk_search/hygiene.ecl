IMPORT ut,SALT33;
EXPORT hygiene(dataset(layout_bk_search) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.sourcecode);    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_caseid_pcnt := AVE(GROUP,IF(h.caseid = (TYPEOF(h.caseid))'',0,100));
    maxlength_caseid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.caseid)));
    avelength_caseid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.caseid)),h.caseid<>(typeof(h.caseid))'');
    populated_defendantid_pcnt := AVE(GROUP,IF(h.defendantid = (TYPEOF(h.defendantid))'',0,100));
    maxlength_defendantid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.defendantid)));
    avelength_defendantid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.defendantid)),h.defendantid<>(typeof(h.defendantid))'');
    populated_recid_pcnt := AVE(GROUP,IF(h.recid = (TYPEOF(h.recid))'',0,100));
    maxlength_recid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recid)));
    avelength_recid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recid)),h.recid<>(typeof(h.recid))'');
    populated_tmsid_pcnt := AVE(GROUP,IF(h.tmsid = (TYPEOF(h.tmsid))'',0,100));
    maxlength_tmsid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.tmsid)));
    avelength_tmsid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.tmsid)),h.tmsid<>(typeof(h.tmsid))'');
    populated_seq_number_pcnt := AVE(GROUP,IF(h.seq_number = (TYPEOF(h.seq_number))'',0,100));
    maxlength_seq_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.seq_number)));
    avelength_seq_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.seq_number)),h.seq_number<>(typeof(h.seq_number))'');
    populated_court_code_pcnt := AVE(GROUP,IF(h.court_code = (TYPEOF(h.court_code))'',0,100));
    maxlength_court_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.court_code)));
    avelength_court_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.court_code)),h.court_code<>(typeof(h.court_code))'');
    populated_case_number_pcnt := AVE(GROUP,IF(h.case_number = (TYPEOF(h.case_number))'',0,100));
    maxlength_case_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_number)));
    avelength_case_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.case_number)),h.case_number<>(typeof(h.case_number))'');
    populated_orig_case_number_pcnt := AVE(GROUP,IF(h.orig_case_number = (TYPEOF(h.orig_case_number))'',0,100));
    maxlength_orig_case_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_case_number)));
    avelength_orig_case_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_case_number)),h.orig_case_number<>(typeof(h.orig_case_number))'');
    populated_chapter_pcnt := AVE(GROUP,IF(h.chapter = (TYPEOF(h.chapter))'',0,100));
    maxlength_chapter := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.chapter)));
    avelength_chapter := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.chapter)),h.chapter<>(typeof(h.chapter))'');
    populated_filing_type_pcnt := AVE(GROUP,IF(h.filing_type = (TYPEOF(h.filing_type))'',0,100));
    maxlength_filing_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_type)));
    avelength_filing_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filing_type)),h.filing_type<>(typeof(h.filing_type))'');
    populated_business_flag_pcnt := AVE(GROUP,IF(h.business_flag = (TYPEOF(h.business_flag))'',0,100));
    maxlength_business_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.business_flag)));
    avelength_business_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.business_flag)),h.business_flag<>(typeof(h.business_flag))'');
    populated_corp_flag_pcnt := AVE(GROUP,IF(h.corp_flag = (TYPEOF(h.corp_flag))'',0,100));
    maxlength_corp_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.corp_flag)));
    avelength_corp_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.corp_flag)),h.corp_flag<>(typeof(h.corp_flag))'');
    populated_discharged_pcnt := AVE(GROUP,IF(h.discharged = (TYPEOF(h.discharged))'',0,100));
    maxlength_discharged := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.discharged)));
    avelength_discharged := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.discharged)),h.discharged<>(typeof(h.discharged))'');
    populated_disposition_pcnt := AVE(GROUP,IF(h.disposition = (TYPEOF(h.disposition))'',0,100));
    maxlength_disposition := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.disposition)));
    avelength_disposition := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.disposition)),h.disposition<>(typeof(h.disposition))'');
    populated_pro_se_ind_pcnt := AVE(GROUP,IF(h.pro_se_ind = (TYPEOF(h.pro_se_ind))'',0,100));
    maxlength_pro_se_ind := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.pro_se_ind)));
    avelength_pro_se_ind := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.pro_se_ind)),h.pro_se_ind<>(typeof(h.pro_se_ind))'');
    populated_converted_date_pcnt := AVE(GROUP,IF(h.converted_date = (TYPEOF(h.converted_date))'',0,100));
    maxlength_converted_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.converted_date)));
    avelength_converted_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.converted_date)),h.converted_date<>(typeof(h.converted_date))'');
    populated_orig_county_pcnt := AVE(GROUP,IF(h.orig_county = (TYPEOF(h.orig_county))'',0,100));
    maxlength_orig_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_county)));
    avelength_orig_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_county)),h.orig_county<>(typeof(h.orig_county))'');
    populated_debtor_type_pcnt := AVE(GROUP,IF(h.debtor_type = (TYPEOF(h.debtor_type))'',0,100));
    maxlength_debtor_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.debtor_type)));
    avelength_debtor_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.debtor_type)),h.debtor_type<>(typeof(h.debtor_type))'');
    populated_debtor_seq_pcnt := AVE(GROUP,IF(h.debtor_seq = (TYPEOF(h.debtor_seq))'',0,100));
    maxlength_debtor_seq := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.debtor_seq)));
    avelength_debtor_seq := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.debtor_seq)),h.debtor_seq<>(typeof(h.debtor_seq))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_ssnsrc_pcnt := AVE(GROUP,IF(h.ssnsrc = (TYPEOF(h.ssnsrc))'',0,100));
    maxlength_ssnsrc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssnsrc)));
    avelength_ssnsrc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssnsrc)),h.ssnsrc<>(typeof(h.ssnsrc))'');
    populated_ssnmatch_pcnt := AVE(GROUP,IF(h.ssnmatch = (TYPEOF(h.ssnmatch))'',0,100));
    maxlength_ssnmatch := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssnmatch)));
    avelength_ssnmatch := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssnmatch)),h.ssnmatch<>(typeof(h.ssnmatch))'');
    populated_ssnmsrc_pcnt := AVE(GROUP,IF(h.ssnmsrc = (TYPEOF(h.ssnmsrc))'',0,100));
    maxlength_ssnmsrc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssnmsrc)));
    avelength_ssnmsrc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssnmsrc)),h.ssnmsrc<>(typeof(h.ssnmsrc))'');
    populated_screen_pcnt := AVE(GROUP,IF(h.screen = (TYPEOF(h.screen))'',0,100));
    maxlength_screen := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.screen)));
    avelength_screen := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.screen)),h.screen<>(typeof(h.screen))'');
    populated_dcode_pcnt := AVE(GROUP,IF(h.dcode = (TYPEOF(h.dcode))'',0,100));
    maxlength_dcode := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dcode)));
    avelength_dcode := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dcode)),h.dcode<>(typeof(h.dcode))'');
    populated_disptype_pcnt := AVE(GROUP,IF(h.disptype = (TYPEOF(h.disptype))'',0,100));
    maxlength_disptype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.disptype)));
    avelength_disptype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.disptype)),h.disptype<>(typeof(h.disptype))'');
    populated_dispreason_pcnt := AVE(GROUP,IF(h.dispreason = (TYPEOF(h.dispreason))'',0,100));
    maxlength_dispreason := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dispreason)));
    avelength_dispreason := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dispreason)),h.dispreason<>(typeof(h.dispreason))'');
    populated_statusdate_pcnt := AVE(GROUP,IF(h.statusdate = (TYPEOF(h.statusdate))'',0,100));
    maxlength_statusdate := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.statusdate)));
    avelength_statusdate := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.statusdate)),h.statusdate<>(typeof(h.statusdate))'');
    populated_holdcase_pcnt := AVE(GROUP,IF(h.holdcase = (TYPEOF(h.holdcase))'',0,100));
    maxlength_holdcase := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.holdcase)));
    avelength_holdcase := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.holdcase)),h.holdcase<>(typeof(h.holdcase))'');
    populated_datevacated_pcnt := AVE(GROUP,IF(h.datevacated = (TYPEOF(h.datevacated))'',0,100));
    maxlength_datevacated := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.datevacated)));
    avelength_datevacated := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.datevacated)),h.datevacated<>(typeof(h.datevacated))'');
    populated_datetransferred_pcnt := AVE(GROUP,IF(h.datetransferred = (TYPEOF(h.datetransferred))'',0,100));
    maxlength_datetransferred := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.datetransferred)));
    avelength_datetransferred := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.datetransferred)),h.datetransferred<>(typeof(h.datetransferred))'');
    populated_activityreceipt_pcnt := AVE(GROUP,IF(h.activityreceipt = (TYPEOF(h.activityreceipt))'',0,100));
    maxlength_activityreceipt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.activityreceipt)));
    avelength_activityreceipt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.activityreceipt)),h.activityreceipt<>(typeof(h.activityreceipt))'');
    populated_tax_id_pcnt := AVE(GROUP,IF(h.tax_id = (TYPEOF(h.tax_id))'',0,100));
    maxlength_tax_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.tax_id)));
    avelength_tax_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.tax_id)),h.tax_id<>(typeof(h.tax_id))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_orig_name_pcnt := AVE(GROUP,IF(h.orig_name = (TYPEOF(h.orig_name))'',0,100));
    maxlength_orig_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_name)));
    avelength_orig_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_name)),h.orig_name<>(typeof(h.orig_name))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_name_suffix_pcnt := AVE(GROUP,IF(h.orig_name_suffix = (TYPEOF(h.orig_name_suffix))'',0,100));
    maxlength_orig_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_name_suffix)));
    avelength_orig_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_name_suffix)),h.orig_name_suffix<>(typeof(h.orig_name_suffix))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
    populated_orig_company_pcnt := AVE(GROUP,IF(h.orig_company = (TYPEOF(h.orig_company))'',0,100));
    maxlength_orig_company := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_company)));
    avelength_orig_company := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_company)),h.orig_company<>(typeof(h.orig_company))'');
    populated_orig_addr1_pcnt := AVE(GROUP,IF(h.orig_addr1 = (TYPEOF(h.orig_addr1))'',0,100));
    maxlength_orig_addr1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_addr1)));
    avelength_orig_addr1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_addr1)),h.orig_addr1<>(typeof(h.orig_addr1))'');
    populated_orig_addr2_pcnt := AVE(GROUP,IF(h.orig_addr2 = (TYPEOF(h.orig_addr2))'',0,100));
    maxlength_orig_addr2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_addr2)));
    avelength_orig_addr2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_addr2)),h.orig_addr2<>(typeof(h.orig_addr2))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_st_pcnt := AVE(GROUP,IF(h.orig_st = (TYPEOF(h.orig_st))'',0,100));
    maxlength_orig_st := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_st)));
    avelength_orig_st := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_st)),h.orig_st<>(typeof(h.orig_st))'');
    populated_orig_zip5_pcnt := AVE(GROUP,IF(h.orig_zip5 = (TYPEOF(h.orig_zip5))'',0,100));
    maxlength_orig_zip5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_zip5)));
    avelength_orig_zip5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_zip5)),h.orig_zip5<>(typeof(h.orig_zip5))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_orig_email_pcnt := AVE(GROUP,IF(h.orig_email = (TYPEOF(h.orig_email))'',0,100));
    maxlength_orig_email := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_email)));
    avelength_orig_email := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_email)),h.orig_email<>(typeof(h.orig_email))'');
    populated_orig_fax_pcnt := AVE(GROUP,IF(h.orig_fax = (TYPEOF(h.orig_fax))'',0,100));
    maxlength_orig_fax := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_fax)));
    avelength_orig_fax := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_fax)),h.orig_fax<>(typeof(h.orig_fax))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_app_ssn_pcnt := AVE(GROUP,IF(h.app_ssn = (TYPEOF(h.app_ssn))'',0,100));
    maxlength_app_ssn := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.app_ssn)));
    avelength_app_ssn := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.app_ssn)),h.app_ssn<>(typeof(h.app_ssn))'');
    populated_app_tax_id_pcnt := AVE(GROUP,IF(h.app_tax_id = (TYPEOF(h.app_tax_id))'',0,100));
    maxlength_app_tax_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.app_tax_id)));
    avelength_app_tax_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.app_tax_id)),h.app_tax_id<>(typeof(h.app_tax_id))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_disptypedesc_pcnt := AVE(GROUP,IF(h.disptypedesc = (TYPEOF(h.disptypedesc))'',0,100));
    maxlength_disptypedesc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.disptypedesc)));
    avelength_disptypedesc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.disptypedesc)),h.disptypedesc<>(typeof(h.disptypedesc))'');
    populated_srcdesc_pcnt := AVE(GROUP,IF(h.srcdesc = (TYPEOF(h.srcdesc))'',0,100));
    maxlength_srcdesc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.srcdesc)));
    avelength_srcdesc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.srcdesc)),h.srcdesc<>(typeof(h.srcdesc))'');
    populated_srcmtchdesc_pcnt := AVE(GROUP,IF(h.srcmtchdesc = (TYPEOF(h.srcmtchdesc))'',0,100));
    maxlength_srcmtchdesc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.srcmtchdesc)));
    avelength_srcmtchdesc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.srcmtchdesc)),h.srcmtchdesc<>(typeof(h.srcmtchdesc))'');
    populated_screendesc_pcnt := AVE(GROUP,IF(h.screendesc = (TYPEOF(h.screendesc))'',0,100));
    maxlength_screendesc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.screendesc)));
    avelength_screendesc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.screendesc)),h.screendesc<>(typeof(h.screendesc))'');
    populated_dcodedesc_pcnt := AVE(GROUP,IF(h.dcodedesc = (TYPEOF(h.dcodedesc))'',0,100));
    maxlength_dcodedesc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dcodedesc)));
    avelength_dcodedesc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dcodedesc)),h.dcodedesc<>(typeof(h.dcodedesc))'');
    populated_date_filed_pcnt := AVE(GROUP,IF(h.date_filed = (TYPEOF(h.date_filed))'',0,100));
    maxlength_date_filed := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_filed)));
    avelength_date_filed := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.date_filed)),h.date_filed<>(typeof(h.date_filed))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_delete_flag_pcnt := AVE(GROUP,IF(h.delete_flag = (TYPEOF(h.delete_flag))'',0,100));
    maxlength_delete_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.delete_flag)));
    avelength_delete_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.delete_flag)),h.delete_flag<>(typeof(h.delete_flag))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,sourcecode,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_caseid_pcnt *   0.00 / 100 + T.Populated_defendantid_pcnt *   0.00 / 100 + T.Populated_recid_pcnt *   0.00 / 100 + T.Populated_tmsid_pcnt *   0.00 / 100 + T.Populated_seq_number_pcnt *   0.00 / 100 + T.Populated_court_code_pcnt *   0.00 / 100 + T.Populated_case_number_pcnt *   0.00 / 100 + T.Populated_orig_case_number_pcnt *   0.00 / 100 + T.Populated_chapter_pcnt *   0.00 / 100 + T.Populated_filing_type_pcnt *   0.00 / 100 + T.Populated_business_flag_pcnt *   0.00 / 100 + T.Populated_corp_flag_pcnt *   0.00 / 100 + T.Populated_discharged_pcnt *   0.00 / 100 + T.Populated_disposition_pcnt *   0.00 / 100 + T.Populated_pro_se_ind_pcnt *   0.00 / 100 + T.Populated_converted_date_pcnt *   0.00 / 100 + T.Populated_orig_county_pcnt *   0.00 / 100 + T.Populated_debtor_type_pcnt *   0.00 / 100 + T.Populated_debtor_seq_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_ssnsrc_pcnt *   0.00 / 100 + T.Populated_ssnmatch_pcnt *   0.00 / 100 + T.Populated_ssnmsrc_pcnt *   0.00 / 100 + T.Populated_screen_pcnt *   0.00 / 100 + T.Populated_dcode_pcnt *   0.00 / 100 + T.Populated_disptype_pcnt *   0.00 / 100 + T.Populated_dispreason_pcnt *   0.00 / 100 + T.Populated_statusdate_pcnt *   0.00 / 100 + T.Populated_holdcase_pcnt *   0.00 / 100 + T.Populated_datevacated_pcnt *   0.00 / 100 + T.Populated_datetransferred_pcnt *   0.00 / 100 + T.Populated_activityreceipt_pcnt *   0.00 / 100 + T.Populated_tax_id_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_orig_name_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_name_suffix_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_orig_company_pcnt *   0.00 / 100 + T.Populated_orig_addr1_pcnt *   0.00 / 100 + T.Populated_orig_addr2_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_st_pcnt *   0.00 / 100 + T.Populated_orig_zip5_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_orig_email_pcnt *   0.00 / 100 + T.Populated_orig_fax_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_app_ssn_pcnt *   0.00 / 100 + T.Populated_app_tax_id_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_disptypedesc_pcnt *   0.00 / 100 + T.Populated_srcdesc_pcnt *   0.00 / 100 + T.Populated_srcmtchdesc_pcnt *   0.00 / 100 + T.Populated_screendesc_pcnt *   0.00 / 100 + T.Populated_dcodedesc_pcnt *   0.00 / 100 + T.Populated_date_filed_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_delete_flag_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING sourcecode1;
    STRING sourcecode2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.sourcecode1 := le.Source;
    SELF.sourcecode2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_caseid_pcnt*ri.Populated_caseid_pcnt *   0.00 / 10000 + le.Populated_defendantid_pcnt*ri.Populated_defendantid_pcnt *   0.00 / 10000 + le.Populated_recid_pcnt*ri.Populated_recid_pcnt *   0.00 / 10000 + le.Populated_tmsid_pcnt*ri.Populated_tmsid_pcnt *   0.00 / 10000 + le.Populated_seq_number_pcnt*ri.Populated_seq_number_pcnt *   0.00 / 10000 + le.Populated_court_code_pcnt*ri.Populated_court_code_pcnt *   0.00 / 10000 + le.Populated_case_number_pcnt*ri.Populated_case_number_pcnt *   0.00 / 10000 + le.Populated_orig_case_number_pcnt*ri.Populated_orig_case_number_pcnt *   0.00 / 10000 + le.Populated_chapter_pcnt*ri.Populated_chapter_pcnt *   0.00 / 10000 + le.Populated_filing_type_pcnt*ri.Populated_filing_type_pcnt *   0.00 / 10000 + le.Populated_business_flag_pcnt*ri.Populated_business_flag_pcnt *   0.00 / 10000 + le.Populated_corp_flag_pcnt*ri.Populated_corp_flag_pcnt *   0.00 / 10000 + le.Populated_discharged_pcnt*ri.Populated_discharged_pcnt *   0.00 / 10000 + le.Populated_disposition_pcnt*ri.Populated_disposition_pcnt *   0.00 / 10000 + le.Populated_pro_se_ind_pcnt*ri.Populated_pro_se_ind_pcnt *   0.00 / 10000 + le.Populated_converted_date_pcnt*ri.Populated_converted_date_pcnt *   0.00 / 10000 + le.Populated_orig_county_pcnt*ri.Populated_orig_county_pcnt *   0.00 / 10000 + le.Populated_debtor_type_pcnt*ri.Populated_debtor_type_pcnt *   0.00 / 10000 + le.Populated_debtor_seq_pcnt*ri.Populated_debtor_seq_pcnt *   0.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *   0.00 / 10000 + le.Populated_ssnsrc_pcnt*ri.Populated_ssnsrc_pcnt *   0.00 / 10000 + le.Populated_ssnmatch_pcnt*ri.Populated_ssnmatch_pcnt *   0.00 / 10000 + le.Populated_ssnmsrc_pcnt*ri.Populated_ssnmsrc_pcnt *   0.00 / 10000 + le.Populated_screen_pcnt*ri.Populated_screen_pcnt *   0.00 / 10000 + le.Populated_dcode_pcnt*ri.Populated_dcode_pcnt *   0.00 / 10000 + le.Populated_disptype_pcnt*ri.Populated_disptype_pcnt *   0.00 / 10000 + le.Populated_dispreason_pcnt*ri.Populated_dispreason_pcnt *   0.00 / 10000 + le.Populated_statusdate_pcnt*ri.Populated_statusdate_pcnt *   0.00 / 10000 + le.Populated_holdcase_pcnt*ri.Populated_holdcase_pcnt *   0.00 / 10000 + le.Populated_datevacated_pcnt*ri.Populated_datevacated_pcnt *   0.00 / 10000 + le.Populated_datetransferred_pcnt*ri.Populated_datetransferred_pcnt *   0.00 / 10000 + le.Populated_activityreceipt_pcnt*ri.Populated_activityreceipt_pcnt *   0.00 / 10000 + le.Populated_tax_id_pcnt*ri.Populated_tax_id_pcnt *   0.00 / 10000 + le.Populated_name_type_pcnt*ri.Populated_name_type_pcnt *   0.00 / 10000 + le.Populated_orig_name_pcnt*ri.Populated_orig_name_pcnt *   0.00 / 10000 + le.Populated_orig_fname_pcnt*ri.Populated_orig_fname_pcnt *   0.00 / 10000 + le.Populated_orig_mname_pcnt*ri.Populated_orig_mname_pcnt *   0.00 / 10000 + le.Populated_orig_lname_pcnt*ri.Populated_orig_lname_pcnt *   0.00 / 10000 + le.Populated_orig_name_suffix_pcnt*ri.Populated_orig_name_suffix_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_cname_pcnt*ri.Populated_cname_pcnt *   0.00 / 10000 + le.Populated_orig_company_pcnt*ri.Populated_orig_company_pcnt *   0.00 / 10000 + le.Populated_orig_addr1_pcnt*ri.Populated_orig_addr1_pcnt *   0.00 / 10000 + le.Populated_orig_addr2_pcnt*ri.Populated_orig_addr2_pcnt *   0.00 / 10000 + le.Populated_orig_city_pcnt*ri.Populated_orig_city_pcnt *   0.00 / 10000 + le.Populated_orig_st_pcnt*ri.Populated_orig_st_pcnt *   0.00 / 10000 + le.Populated_orig_zip5_pcnt*ri.Populated_orig_zip5_pcnt *   0.00 / 10000 + le.Populated_orig_zip4_pcnt*ri.Populated_orig_zip4_pcnt *   0.00 / 10000 + le.Populated_orig_email_pcnt*ri.Populated_orig_email_pcnt *   0.00 / 10000 + le.Populated_orig_fax_pcnt*ri.Populated_orig_fax_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dbpc_pcnt*ri.Populated_dbpc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_phone_pcnt*ri.Populated_phone_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_bdid_pcnt*ri.Populated_bdid_pcnt *   0.00 / 10000 + le.Populated_app_ssn_pcnt*ri.Populated_app_ssn_pcnt *   0.00 / 10000 + le.Populated_app_tax_id_pcnt*ri.Populated_app_tax_id_pcnt *   0.00 / 10000 + le.Populated_date_first_seen_pcnt*ri.Populated_date_first_seen_pcnt *   0.00 / 10000 + le.Populated_date_last_seen_pcnt*ri.Populated_date_last_seen_pcnt *   0.00 / 10000 + le.Populated_date_vendor_first_reported_pcnt*ri.Populated_date_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_date_vendor_last_reported_pcnt*ri.Populated_date_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_disptypedesc_pcnt*ri.Populated_disptypedesc_pcnt *   0.00 / 10000 + le.Populated_srcdesc_pcnt*ri.Populated_srcdesc_pcnt *   0.00 / 10000 + le.Populated_srcmtchdesc_pcnt*ri.Populated_srcmtchdesc_pcnt *   0.00 / 10000 + le.Populated_screendesc_pcnt*ri.Populated_screendesc_pcnt *   0.00 / 10000 + le.Populated_dcodedesc_pcnt*ri.Populated_dcodedesc_pcnt *   0.00 / 10000 + le.Populated_date_filed_pcnt*ri.Populated_date_filed_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_delete_flag_pcnt*ri.Populated_delete_flag_pcnt *   0.00 / 10000 + le.Populated_dotid_pcnt*ri.Populated_dotid_pcnt *   0.00 / 10000 + le.Populated_dotscore_pcnt*ri.Populated_dotscore_pcnt *   0.00 / 10000 + le.Populated_dotweight_pcnt*ri.Populated_dotweight_pcnt *   0.00 / 10000 + le.Populated_empid_pcnt*ri.Populated_empid_pcnt *   0.00 / 10000 + le.Populated_empscore_pcnt*ri.Populated_empscore_pcnt *   0.00 / 10000 + le.Populated_empweight_pcnt*ri.Populated_empweight_pcnt *   0.00 / 10000 + le.Populated_powid_pcnt*ri.Populated_powid_pcnt *   0.00 / 10000 + le.Populated_powscore_pcnt*ri.Populated_powscore_pcnt *   0.00 / 10000 + le.Populated_powweight_pcnt*ri.Populated_powweight_pcnt *   0.00 / 10000 + le.Populated_proxid_pcnt*ri.Populated_proxid_pcnt *   0.00 / 10000 + le.Populated_proxscore_pcnt*ri.Populated_proxscore_pcnt *   0.00 / 10000 + le.Populated_proxweight_pcnt*ri.Populated_proxweight_pcnt *   0.00 / 10000 + le.Populated_seleid_pcnt*ri.Populated_seleid_pcnt *   0.00 / 10000 + le.Populated_selescore_pcnt*ri.Populated_selescore_pcnt *   0.00 / 10000 + le.Populated_seleweight_pcnt*ri.Populated_seleweight_pcnt *   0.00 / 10000 + le.Populated_orgid_pcnt*ri.Populated_orgid_pcnt *   0.00 / 10000 + le.Populated_orgscore_pcnt*ri.Populated_orgscore_pcnt *   0.00 / 10000 + le.Populated_orgweight_pcnt*ri.Populated_orgweight_pcnt *   0.00 / 10000 + le.Populated_ultid_pcnt*ri.Populated_ultid_pcnt *   0.00 / 10000 + le.Populated_ultscore_pcnt*ri.Populated_ultscore_pcnt *   0.00 / 10000 + le.Populated_ultweight_pcnt*ri.Populated_ultweight_pcnt *   0.00 / 10000 + le.Populated_source_rec_id_pcnt*ri.Populated_source_rec_id_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'process_date','caseid','defendantid','recid','tmsid','seq_number','court_code','case_number','orig_case_number','chapter','filing_type','business_flag','corp_flag','discharged','disposition','pro_se_ind','converted_date','orig_county','debtor_type','debtor_seq','ssn','ssnsrc','ssnmatch','ssnmsrc','screen','dcode','disptype','dispreason','statusdate','holdcase','datevacated','datetransferred','activityreceipt','tax_id','name_type','orig_name','orig_fname','orig_mname','orig_lname','orig_name_suffix','title','fname','mname','lname','name_suffix','name_score','cname','orig_company','orig_addr1','orig_addr2','orig_city','orig_st','orig_zip5','orig_zip4','orig_email','orig_fax','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','phone','did','bdid','app_ssn','app_tax_id','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','disptypedesc','srcdesc','srcmtchdesc','screendesc','dcodedesc','date_filed','record_type','delete_flag','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_caseid_pcnt,le.populated_defendantid_pcnt,le.populated_recid_pcnt,le.populated_tmsid_pcnt,le.populated_seq_number_pcnt,le.populated_court_code_pcnt,le.populated_case_number_pcnt,le.populated_orig_case_number_pcnt,le.populated_chapter_pcnt,le.populated_filing_type_pcnt,le.populated_business_flag_pcnt,le.populated_corp_flag_pcnt,le.populated_discharged_pcnt,le.populated_disposition_pcnt,le.populated_pro_se_ind_pcnt,le.populated_converted_date_pcnt,le.populated_orig_county_pcnt,le.populated_debtor_type_pcnt,le.populated_debtor_seq_pcnt,le.populated_ssn_pcnt,le.populated_ssnsrc_pcnt,le.populated_ssnmatch_pcnt,le.populated_ssnmsrc_pcnt,le.populated_screen_pcnt,le.populated_dcode_pcnt,le.populated_disptype_pcnt,le.populated_dispreason_pcnt,le.populated_statusdate_pcnt,le.populated_holdcase_pcnt,le.populated_datevacated_pcnt,le.populated_datetransferred_pcnt,le.populated_activityreceipt_pcnt,le.populated_tax_id_pcnt,le.populated_name_type_pcnt,le.populated_orig_name_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_name_suffix_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_cname_pcnt,le.populated_orig_company_pcnt,le.populated_orig_addr1_pcnt,le.populated_orig_addr2_pcnt,le.populated_orig_city_pcnt,le.populated_orig_st_pcnt,le.populated_orig_zip5_pcnt,le.populated_orig_zip4_pcnt,le.populated_orig_email_pcnt,le.populated_orig_fax_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_phone_pcnt,le.populated_did_pcnt,le.populated_bdid_pcnt,le.populated_app_ssn_pcnt,le.populated_app_tax_id_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_disptypedesc_pcnt,le.populated_srcdesc_pcnt,le.populated_srcmtchdesc_pcnt,le.populated_screendesc_pcnt,le.populated_dcodedesc_pcnt,le.populated_date_filed_pcnt,le.populated_record_type_pcnt,le.populated_delete_flag_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_source_rec_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_caseid,le.maxlength_defendantid,le.maxlength_recid,le.maxlength_tmsid,le.maxlength_seq_number,le.maxlength_court_code,le.maxlength_case_number,le.maxlength_orig_case_number,le.maxlength_chapter,le.maxlength_filing_type,le.maxlength_business_flag,le.maxlength_corp_flag,le.maxlength_discharged,le.maxlength_disposition,le.maxlength_pro_se_ind,le.maxlength_converted_date,le.maxlength_orig_county,le.maxlength_debtor_type,le.maxlength_debtor_seq,le.maxlength_ssn,le.maxlength_ssnsrc,le.maxlength_ssnmatch,le.maxlength_ssnmsrc,le.maxlength_screen,le.maxlength_dcode,le.maxlength_disptype,le.maxlength_dispreason,le.maxlength_statusdate,le.maxlength_holdcase,le.maxlength_datevacated,le.maxlength_datetransferred,le.maxlength_activityreceipt,le.maxlength_tax_id,le.maxlength_name_type,le.maxlength_orig_name,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_lname,le.maxlength_orig_name_suffix,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_cname,le.maxlength_orig_company,le.maxlength_orig_addr1,le.maxlength_orig_addr2,le.maxlength_orig_city,le.maxlength_orig_st,le.maxlength_orig_zip5,le.maxlength_orig_zip4,le.maxlength_orig_email,le.maxlength_orig_fax,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_phone,le.maxlength_did,le.maxlength_bdid,le.maxlength_app_ssn,le.maxlength_app_tax_id,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_disptypedesc,le.maxlength_srcdesc,le.maxlength_srcmtchdesc,le.maxlength_screendesc,le.maxlength_dcodedesc,le.maxlength_date_filed,le.maxlength_record_type,le.maxlength_delete_flag,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_source_rec_id);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_caseid,le.avelength_defendantid,le.avelength_recid,le.avelength_tmsid,le.avelength_seq_number,le.avelength_court_code,le.avelength_case_number,le.avelength_orig_case_number,le.avelength_chapter,le.avelength_filing_type,le.avelength_business_flag,le.avelength_corp_flag,le.avelength_discharged,le.avelength_disposition,le.avelength_pro_se_ind,le.avelength_converted_date,le.avelength_orig_county,le.avelength_debtor_type,le.avelength_debtor_seq,le.avelength_ssn,le.avelength_ssnsrc,le.avelength_ssnmatch,le.avelength_ssnmsrc,le.avelength_screen,le.avelength_dcode,le.avelength_disptype,le.avelength_dispreason,le.avelength_statusdate,le.avelength_holdcase,le.avelength_datevacated,le.avelength_datetransferred,le.avelength_activityreceipt,le.avelength_tax_id,le.avelength_name_type,le.avelength_orig_name,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_lname,le.avelength_orig_name_suffix,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_cname,le.avelength_orig_company,le.avelength_orig_addr1,le.avelength_orig_addr2,le.avelength_orig_city,le.avelength_orig_st,le.avelength_orig_zip5,le.avelength_orig_zip4,le.avelength_orig_email,le.avelength_orig_fax,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_phone,le.avelength_did,le.avelength_bdid,le.avelength_app_ssn,le.avelength_app_tax_id,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_disptypedesc,le.avelength_srcdesc,le.avelength_srcmtchdesc,le.avelength_screendesc,le.avelength_dcodedesc,le.avelength_date_filed,le.avelength_record_type,le.avelength_delete_flag,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_source_rec_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 121, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.sourcecode;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.defendantid),TRIM((SALT33.StrType)le.recid),TRIM((SALT33.StrType)le.tmsid),TRIM((SALT33.StrType)le.seq_number),TRIM((SALT33.StrType)le.court_code),TRIM((SALT33.StrType)le.case_number),TRIM((SALT33.StrType)le.orig_case_number),TRIM((SALT33.StrType)le.chapter),TRIM((SALT33.StrType)le.filing_type),TRIM((SALT33.StrType)le.business_flag),TRIM((SALT33.StrType)le.corp_flag),TRIM((SALT33.StrType)le.discharged),TRIM((SALT33.StrType)le.disposition),TRIM((SALT33.StrType)le.pro_se_ind),TRIM((SALT33.StrType)le.converted_date),TRIM((SALT33.StrType)le.orig_county),TRIM((SALT33.StrType)le.debtor_type),TRIM((SALT33.StrType)le.debtor_seq),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.ssnsrc),TRIM((SALT33.StrType)le.ssnmatch),TRIM((SALT33.StrType)le.ssnmsrc),TRIM((SALT33.StrType)le.screen),TRIM((SALT33.StrType)le.dcode),TRIM((SALT33.StrType)le.disptype),TRIM((SALT33.StrType)le.dispreason),TRIM((SALT33.StrType)le.statusdate),TRIM((SALT33.StrType)le.holdcase),TRIM((SALT33.StrType)le.datevacated),TRIM((SALT33.StrType)le.datetransferred),TRIM((SALT33.StrType)le.activityreceipt),TRIM((SALT33.StrType)le.tax_id),TRIM((SALT33.StrType)le.name_type),TRIM((SALT33.StrType)le.orig_name),TRIM((SALT33.StrType)le.orig_fname),TRIM((SALT33.StrType)le.orig_mname),TRIM((SALT33.StrType)le.orig_lname),TRIM((SALT33.StrType)le.orig_name_suffix),TRIM((SALT33.StrType)le.title),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_score),TRIM((SALT33.StrType)le.cname),TRIM((SALT33.StrType)le.orig_company),TRIM((SALT33.StrType)le.orig_addr1),TRIM((SALT33.StrType)le.orig_addr2),TRIM((SALT33.StrType)le.orig_city),TRIM((SALT33.StrType)le.orig_st),TRIM((SALT33.StrType)le.orig_zip5),TRIM((SALT33.StrType)le.orig_zip4),TRIM((SALT33.StrType)le.orig_email),TRIM((SALT33.StrType)le.orig_fax),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dbpc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.did),TRIM((SALT33.StrType)le.bdid),TRIM((SALT33.StrType)le.app_ssn),TRIM((SALT33.StrType)le.app_tax_id),TRIM((SALT33.StrType)le.date_first_seen),TRIM((SALT33.StrType)le.date_last_seen),TRIM((SALT33.StrType)le.date_vendor_first_reported),TRIM((SALT33.StrType)le.date_vendor_last_reported),TRIM((SALT33.StrType)le.disptypedesc),TRIM((SALT33.StrType)le.srcdesc),TRIM((SALT33.StrType)le.srcmtchdesc),TRIM((SALT33.StrType)le.screendesc),TRIM((SALT33.StrType)le.dcodedesc),TRIM((SALT33.StrType)le.date_filed),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.delete_flag),TRIM((SALT33.StrType)le.dotid),TRIM((SALT33.StrType)le.dotscore),TRIM((SALT33.StrType)le.dotweight),TRIM((SALT33.StrType)le.empid),TRIM((SALT33.StrType)le.empscore),TRIM((SALT33.StrType)le.empweight),TRIM((SALT33.StrType)le.powid),TRIM((SALT33.StrType)le.powscore),TRIM((SALT33.StrType)le.powweight),TRIM((SALT33.StrType)le.proxid),TRIM((SALT33.StrType)le.proxscore),TRIM((SALT33.StrType)le.proxweight),TRIM((SALT33.StrType)le.seleid),TRIM((SALT33.StrType)le.selescore),TRIM((SALT33.StrType)le.seleweight),TRIM((SALT33.StrType)le.orgid),TRIM((SALT33.StrType)le.orgscore),TRIM((SALT33.StrType)le.orgweight),TRIM((SALT33.StrType)le.ultid),TRIM((SALT33.StrType)le.ultscore),TRIM((SALT33.StrType)le.ultweight),TRIM((SALT33.StrType)le.source_rec_id)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,121,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 121);
  SELF.FldNo2 := 1 + (C % 121);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.defendantid),TRIM((SALT33.StrType)le.recid),TRIM((SALT33.StrType)le.tmsid),TRIM((SALT33.StrType)le.seq_number),TRIM((SALT33.StrType)le.court_code),TRIM((SALT33.StrType)le.case_number),TRIM((SALT33.StrType)le.orig_case_number),TRIM((SALT33.StrType)le.chapter),TRIM((SALT33.StrType)le.filing_type),TRIM((SALT33.StrType)le.business_flag),TRIM((SALT33.StrType)le.corp_flag),TRIM((SALT33.StrType)le.discharged),TRIM((SALT33.StrType)le.disposition),TRIM((SALT33.StrType)le.pro_se_ind),TRIM((SALT33.StrType)le.converted_date),TRIM((SALT33.StrType)le.orig_county),TRIM((SALT33.StrType)le.debtor_type),TRIM((SALT33.StrType)le.debtor_seq),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.ssnsrc),TRIM((SALT33.StrType)le.ssnmatch),TRIM((SALT33.StrType)le.ssnmsrc),TRIM((SALT33.StrType)le.screen),TRIM((SALT33.StrType)le.dcode),TRIM((SALT33.StrType)le.disptype),TRIM((SALT33.StrType)le.dispreason),TRIM((SALT33.StrType)le.statusdate),TRIM((SALT33.StrType)le.holdcase),TRIM((SALT33.StrType)le.datevacated),TRIM((SALT33.StrType)le.datetransferred),TRIM((SALT33.StrType)le.activityreceipt),TRIM((SALT33.StrType)le.tax_id),TRIM((SALT33.StrType)le.name_type),TRIM((SALT33.StrType)le.orig_name),TRIM((SALT33.StrType)le.orig_fname),TRIM((SALT33.StrType)le.orig_mname),TRIM((SALT33.StrType)le.orig_lname),TRIM((SALT33.StrType)le.orig_name_suffix),TRIM((SALT33.StrType)le.title),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_score),TRIM((SALT33.StrType)le.cname),TRIM((SALT33.StrType)le.orig_company),TRIM((SALT33.StrType)le.orig_addr1),TRIM((SALT33.StrType)le.orig_addr2),TRIM((SALT33.StrType)le.orig_city),TRIM((SALT33.StrType)le.orig_st),TRIM((SALT33.StrType)le.orig_zip5),TRIM((SALT33.StrType)le.orig_zip4),TRIM((SALT33.StrType)le.orig_email),TRIM((SALT33.StrType)le.orig_fax),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dbpc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.did),TRIM((SALT33.StrType)le.bdid),TRIM((SALT33.StrType)le.app_ssn),TRIM((SALT33.StrType)le.app_tax_id),TRIM((SALT33.StrType)le.date_first_seen),TRIM((SALT33.StrType)le.date_last_seen),TRIM((SALT33.StrType)le.date_vendor_first_reported),TRIM((SALT33.StrType)le.date_vendor_last_reported),TRIM((SALT33.StrType)le.disptypedesc),TRIM((SALT33.StrType)le.srcdesc),TRIM((SALT33.StrType)le.srcmtchdesc),TRIM((SALT33.StrType)le.screendesc),TRIM((SALT33.StrType)le.dcodedesc),TRIM((SALT33.StrType)le.date_filed),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.delete_flag),TRIM((SALT33.StrType)le.dotid),TRIM((SALT33.StrType)le.dotscore),TRIM((SALT33.StrType)le.dotweight),TRIM((SALT33.StrType)le.empid),TRIM((SALT33.StrType)le.empscore),TRIM((SALT33.StrType)le.empweight),TRIM((SALT33.StrType)le.powid),TRIM((SALT33.StrType)le.powscore),TRIM((SALT33.StrType)le.powweight),TRIM((SALT33.StrType)le.proxid),TRIM((SALT33.StrType)le.proxscore),TRIM((SALT33.StrType)le.proxweight),TRIM((SALT33.StrType)le.seleid),TRIM((SALT33.StrType)le.selescore),TRIM((SALT33.StrType)le.seleweight),TRIM((SALT33.StrType)le.orgid),TRIM((SALT33.StrType)le.orgscore),TRIM((SALT33.StrType)le.orgweight),TRIM((SALT33.StrType)le.ultid),TRIM((SALT33.StrType)le.ultscore),TRIM((SALT33.StrType)le.ultweight),TRIM((SALT33.StrType)le.source_rec_id)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.process_date),TRIM((SALT33.StrType)le.caseid),TRIM((SALT33.StrType)le.defendantid),TRIM((SALT33.StrType)le.recid),TRIM((SALT33.StrType)le.tmsid),TRIM((SALT33.StrType)le.seq_number),TRIM((SALT33.StrType)le.court_code),TRIM((SALT33.StrType)le.case_number),TRIM((SALT33.StrType)le.orig_case_number),TRIM((SALT33.StrType)le.chapter),TRIM((SALT33.StrType)le.filing_type),TRIM((SALT33.StrType)le.business_flag),TRIM((SALT33.StrType)le.corp_flag),TRIM((SALT33.StrType)le.discharged),TRIM((SALT33.StrType)le.disposition),TRIM((SALT33.StrType)le.pro_se_ind),TRIM((SALT33.StrType)le.converted_date),TRIM((SALT33.StrType)le.orig_county),TRIM((SALT33.StrType)le.debtor_type),TRIM((SALT33.StrType)le.debtor_seq),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.ssnsrc),TRIM((SALT33.StrType)le.ssnmatch),TRIM((SALT33.StrType)le.ssnmsrc),TRIM((SALT33.StrType)le.screen),TRIM((SALT33.StrType)le.dcode),TRIM((SALT33.StrType)le.disptype),TRIM((SALT33.StrType)le.dispreason),TRIM((SALT33.StrType)le.statusdate),TRIM((SALT33.StrType)le.holdcase),TRIM((SALT33.StrType)le.datevacated),TRIM((SALT33.StrType)le.datetransferred),TRIM((SALT33.StrType)le.activityreceipt),TRIM((SALT33.StrType)le.tax_id),TRIM((SALT33.StrType)le.name_type),TRIM((SALT33.StrType)le.orig_name),TRIM((SALT33.StrType)le.orig_fname),TRIM((SALT33.StrType)le.orig_mname),TRIM((SALT33.StrType)le.orig_lname),TRIM((SALT33.StrType)le.orig_name_suffix),TRIM((SALT33.StrType)le.title),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_score),TRIM((SALT33.StrType)le.cname),TRIM((SALT33.StrType)le.orig_company),TRIM((SALT33.StrType)le.orig_addr1),TRIM((SALT33.StrType)le.orig_addr2),TRIM((SALT33.StrType)le.orig_city),TRIM((SALT33.StrType)le.orig_st),TRIM((SALT33.StrType)le.orig_zip5),TRIM((SALT33.StrType)le.orig_zip4),TRIM((SALT33.StrType)le.orig_email),TRIM((SALT33.StrType)le.orig_fax),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dbpc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.did),TRIM((SALT33.StrType)le.bdid),TRIM((SALT33.StrType)le.app_ssn),TRIM((SALT33.StrType)le.app_tax_id),TRIM((SALT33.StrType)le.date_first_seen),TRIM((SALT33.StrType)le.date_last_seen),TRIM((SALT33.StrType)le.date_vendor_first_reported),TRIM((SALT33.StrType)le.date_vendor_last_reported),TRIM((SALT33.StrType)le.disptypedesc),TRIM((SALT33.StrType)le.srcdesc),TRIM((SALT33.StrType)le.srcmtchdesc),TRIM((SALT33.StrType)le.screendesc),TRIM((SALT33.StrType)le.dcodedesc),TRIM((SALT33.StrType)le.date_filed),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.delete_flag),TRIM((SALT33.StrType)le.dotid),TRIM((SALT33.StrType)le.dotscore),TRIM((SALT33.StrType)le.dotweight),TRIM((SALT33.StrType)le.empid),TRIM((SALT33.StrType)le.empscore),TRIM((SALT33.StrType)le.empweight),TRIM((SALT33.StrType)le.powid),TRIM((SALT33.StrType)le.powscore),TRIM((SALT33.StrType)le.powweight),TRIM((SALT33.StrType)le.proxid),TRIM((SALT33.StrType)le.proxscore),TRIM((SALT33.StrType)le.proxweight),TRIM((SALT33.StrType)le.seleid),TRIM((SALT33.StrType)le.selescore),TRIM((SALT33.StrType)le.seleweight),TRIM((SALT33.StrType)le.orgid),TRIM((SALT33.StrType)le.orgscore),TRIM((SALT33.StrType)le.orgweight),TRIM((SALT33.StrType)le.ultid),TRIM((SALT33.StrType)le.ultscore),TRIM((SALT33.StrType)le.ultweight),TRIM((SALT33.StrType)le.source_rec_id)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),121*121,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'caseid'}
      ,{3,'defendantid'}
      ,{4,'recid'}
      ,{5,'tmsid'}
      ,{6,'seq_number'}
      ,{7,'court_code'}
      ,{8,'case_number'}
      ,{9,'orig_case_number'}
      ,{10,'chapter'}
      ,{11,'filing_type'}
      ,{12,'business_flag'}
      ,{13,'corp_flag'}
      ,{14,'discharged'}
      ,{15,'disposition'}
      ,{16,'pro_se_ind'}
      ,{17,'converted_date'}
      ,{18,'orig_county'}
      ,{19,'debtor_type'}
      ,{20,'debtor_seq'}
      ,{21,'ssn'}
      ,{22,'ssnsrc'}
      ,{23,'ssnmatch'}
      ,{24,'ssnmsrc'}
      ,{25,'screen'}
      ,{26,'dcode'}
      ,{27,'disptype'}
      ,{28,'dispreason'}
      ,{29,'statusdate'}
      ,{30,'holdcase'}
      ,{31,'datevacated'}
      ,{32,'datetransferred'}
      ,{33,'activityreceipt'}
      ,{34,'tax_id'}
      ,{35,'name_type'}
      ,{36,'orig_name'}
      ,{37,'orig_fname'}
      ,{38,'orig_mname'}
      ,{39,'orig_lname'}
      ,{40,'orig_name_suffix'}
      ,{41,'title'}
      ,{42,'fname'}
      ,{43,'mname'}
      ,{44,'lname'}
      ,{45,'name_suffix'}
      ,{46,'name_score'}
      ,{47,'cname'}
      ,{48,'orig_company'}
      ,{49,'orig_addr1'}
      ,{50,'orig_addr2'}
      ,{51,'orig_city'}
      ,{52,'orig_st'}
      ,{53,'orig_zip5'}
      ,{54,'orig_zip4'}
      ,{55,'orig_email'}
      ,{56,'orig_fax'}
      ,{57,'prim_range'}
      ,{58,'predir'}
      ,{59,'prim_name'}
      ,{60,'addr_suffix'}
      ,{61,'postdir'}
      ,{62,'unit_desig'}
      ,{63,'sec_range'}
      ,{64,'p_city_name'}
      ,{65,'v_city_name'}
      ,{66,'st'}
      ,{67,'zip'}
      ,{68,'zip4'}
      ,{69,'cart'}
      ,{70,'cr_sort_sz'}
      ,{71,'lot'}
      ,{72,'lot_order'}
      ,{73,'dbpc'}
      ,{74,'chk_digit'}
      ,{75,'rec_type'}
      ,{76,'county'}
      ,{77,'geo_lat'}
      ,{78,'geo_long'}
      ,{79,'msa'}
      ,{80,'geo_blk'}
      ,{81,'geo_match'}
      ,{82,'err_stat'}
      ,{83,'phone'}
      ,{84,'did'}
      ,{85,'bdid'}
      ,{86,'app_ssn'}
      ,{87,'app_tax_id'}
      ,{88,'date_first_seen'}
      ,{89,'date_last_seen'}
      ,{90,'date_vendor_first_reported'}
      ,{91,'date_vendor_last_reported'}
      ,{92,'disptypedesc'}
      ,{93,'srcdesc'}
      ,{94,'srcmtchdesc'}
      ,{95,'screendesc'}
      ,{96,'dcodedesc'}
      ,{97,'date_filed'}
      ,{98,'record_type'}
      ,{99,'delete_flag'}
      ,{100,'dotid'}
      ,{101,'dotscore'}
      ,{102,'dotweight'}
      ,{103,'empid'}
      ,{104,'empscore'}
      ,{105,'empweight'}
      ,{106,'powid'}
      ,{107,'powscore'}
      ,{108,'powweight'}
      ,{109,'proxid'}
      ,{110,'proxscore'}
      ,{111,'proxweight'}
      ,{112,'seleid'}
      ,{113,'selescore'}
      ,{114,'seleweight'}
      ,{115,'orgid'}
      ,{116,'orgscore'}
      ,{117,'orgweight'}
      ,{118,'ultid'}
      ,{119,'ultscore'}
      ,{120,'ultweight'}
      ,{121,'source_rec_id'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.sourcecode) sourcecode; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT33.StrType)le.process_date),
    Fields.InValid_caseid((SALT33.StrType)le.caseid),
    Fields.InValid_defendantid((SALT33.StrType)le.defendantid),
    Fields.InValid_recid((SALT33.StrType)le.recid),
    Fields.InValid_tmsid((SALT33.StrType)le.tmsid),
    Fields.InValid_seq_number((SALT33.StrType)le.seq_number),
    Fields.InValid_court_code((SALT33.StrType)le.court_code),
    Fields.InValid_case_number((SALT33.StrType)le.case_number),
    Fields.InValid_orig_case_number((SALT33.StrType)le.orig_case_number),
    Fields.InValid_chapter((SALT33.StrType)le.chapter),
    Fields.InValid_filing_type((SALT33.StrType)le.filing_type),
    Fields.InValid_business_flag((SALT33.StrType)le.business_flag),
    Fields.InValid_corp_flag((SALT33.StrType)le.corp_flag),
    Fields.InValid_discharged((SALT33.StrType)le.discharged),
    Fields.InValid_disposition((SALT33.StrType)le.disposition),
    Fields.InValid_pro_se_ind((SALT33.StrType)le.pro_se_ind),
    Fields.InValid_converted_date((SALT33.StrType)le.converted_date),
    Fields.InValid_orig_county((SALT33.StrType)le.orig_county),
    Fields.InValid_debtor_type((SALT33.StrType)le.debtor_type),
    Fields.InValid_debtor_seq((SALT33.StrType)le.debtor_seq),
    Fields.InValid_ssn((SALT33.StrType)le.ssn),
    Fields.InValid_ssnsrc((SALT33.StrType)le.ssnsrc),
    Fields.InValid_ssnmatch((SALT33.StrType)le.ssnmatch),
    Fields.InValid_ssnmsrc((SALT33.StrType)le.ssnmsrc),
    Fields.InValid_screen((SALT33.StrType)le.screen),
    Fields.InValid_dcode((SALT33.StrType)le.dcode),
    Fields.InValid_disptype((SALT33.StrType)le.disptype),
    Fields.InValid_dispreason((SALT33.StrType)le.dispreason),
    Fields.InValid_statusdate((SALT33.StrType)le.statusdate),
    Fields.InValid_holdcase((SALT33.StrType)le.holdcase),
    Fields.InValid_datevacated((SALT33.StrType)le.datevacated),
    Fields.InValid_datetransferred((SALT33.StrType)le.datetransferred),
    Fields.InValid_activityreceipt((SALT33.StrType)le.activityreceipt),
    Fields.InValid_tax_id((SALT33.StrType)le.tax_id),
    Fields.InValid_name_type((SALT33.StrType)le.name_type),
    Fields.InValid_orig_name((SALT33.StrType)le.orig_name),
    Fields.InValid_orig_fname((SALT33.StrType)le.orig_fname),
    Fields.InValid_orig_mname((SALT33.StrType)le.orig_mname),
    Fields.InValid_orig_lname((SALT33.StrType)le.orig_lname),
    Fields.InValid_orig_name_suffix((SALT33.StrType)le.orig_name_suffix),
    Fields.InValid_title((SALT33.StrType)le.title),
    Fields.InValid_fname((SALT33.StrType)le.fname),
    Fields.InValid_mname((SALT33.StrType)le.mname),
    Fields.InValid_lname((SALT33.StrType)le.lname),
    Fields.InValid_name_suffix((SALT33.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT33.StrType)le.name_score),
    Fields.InValid_cname((SALT33.StrType)le.cname),
    Fields.InValid_orig_company((SALT33.StrType)le.orig_company),
    Fields.InValid_orig_addr1((SALT33.StrType)le.orig_addr1),
    Fields.InValid_orig_addr2((SALT33.StrType)le.orig_addr2),
    Fields.InValid_orig_city((SALT33.StrType)le.orig_city),
    Fields.InValid_orig_st((SALT33.StrType)le.orig_st),
    Fields.InValid_orig_zip5((SALT33.StrType)le.orig_zip5),
    Fields.InValid_orig_zip4((SALT33.StrType)le.orig_zip4),
    Fields.InValid_orig_email((SALT33.StrType)le.orig_email),
    Fields.InValid_orig_fax((SALT33.StrType)le.orig_fax),
    Fields.InValid_prim_range((SALT33.StrType)le.prim_range),
    Fields.InValid_predir((SALT33.StrType)le.predir),
    Fields.InValid_prim_name((SALT33.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT33.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT33.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT33.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT33.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT33.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT33.StrType)le.v_city_name),
    Fields.InValid_st((SALT33.StrType)le.st),
    Fields.InValid_zip((SALT33.StrType)le.zip),
    Fields.InValid_zip4((SALT33.StrType)le.zip4),
    Fields.InValid_cart((SALT33.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT33.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT33.StrType)le.lot),
    Fields.InValid_lot_order((SALT33.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT33.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT33.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT33.StrType)le.rec_type),
    Fields.InValid_county((SALT33.StrType)le.county),
    Fields.InValid_geo_lat((SALT33.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT33.StrType)le.geo_long),
    Fields.InValid_msa((SALT33.StrType)le.msa),
    Fields.InValid_geo_blk((SALT33.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT33.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT33.StrType)le.err_stat),
    Fields.InValid_phone((SALT33.StrType)le.phone),
    Fields.InValid_did((SALT33.StrType)le.did),
    Fields.InValid_bdid((SALT33.StrType)le.bdid),
    Fields.InValid_app_ssn((SALT33.StrType)le.app_ssn),
    Fields.InValid_app_tax_id((SALT33.StrType)le.app_tax_id),
    Fields.InValid_date_first_seen((SALT33.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT33.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT33.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT33.StrType)le.date_vendor_last_reported),
    Fields.InValid_disptypedesc((SALT33.StrType)le.disptypedesc),
    Fields.InValid_srcdesc((SALT33.StrType)le.srcdesc),
    Fields.InValid_srcmtchdesc((SALT33.StrType)le.srcmtchdesc),
    Fields.InValid_screendesc((SALT33.StrType)le.screendesc),
    Fields.InValid_dcodedesc((SALT33.StrType)le.dcodedesc),
    Fields.InValid_date_filed((SALT33.StrType)le.date_filed),
    Fields.InValid_record_type((SALT33.StrType)le.record_type),
    Fields.InValid_delete_flag((SALT33.StrType)le.delete_flag),
    Fields.InValid_dotid((SALT33.StrType)le.dotid),
    Fields.InValid_dotscore((SALT33.StrType)le.dotscore),
    Fields.InValid_dotweight((SALT33.StrType)le.dotweight),
    Fields.InValid_empid((SALT33.StrType)le.empid),
    Fields.InValid_empscore((SALT33.StrType)le.empscore),
    Fields.InValid_empweight((SALT33.StrType)le.empweight),
    Fields.InValid_powid((SALT33.StrType)le.powid),
    Fields.InValid_powscore((SALT33.StrType)le.powscore),
    Fields.InValid_powweight((SALT33.StrType)le.powweight),
    Fields.InValid_proxid((SALT33.StrType)le.proxid),
    Fields.InValid_proxscore((SALT33.StrType)le.proxscore),
    Fields.InValid_proxweight((SALT33.StrType)le.proxweight),
    Fields.InValid_seleid((SALT33.StrType)le.seleid),
    Fields.InValid_selescore((SALT33.StrType)le.selescore),
    Fields.InValid_seleweight((SALT33.StrType)le.seleweight),
    Fields.InValid_orgid((SALT33.StrType)le.orgid),
    Fields.InValid_orgscore((SALT33.StrType)le.orgscore),
    Fields.InValid_orgweight((SALT33.StrType)le.orgweight),
    Fields.InValid_ultid((SALT33.StrType)le.ultid),
    Fields.InValid_ultscore((SALT33.StrType)le.ultscore),
    Fields.InValid_ultweight((SALT33.StrType)le.ultweight),
    Fields.InValid_source_rec_id((SALT33.StrType)le.source_rec_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.sourcecode := le.sourcecode;
END;
Errors := NORMALIZE(h,121,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.sourcecode;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,sourcecode,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.sourcecode;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alnum','invalid_alnum','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','invalid_ssn','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','invalid_date','invalid_date','Unknown','Unknown','Unknown','invalid_name','invalid_name','invalid_name','invalid_name','Unknown','Unknown','invalid_name','invalid_name','invalid_name','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_state','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_date','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_caseid(TotalErrors.ErrorNum),Fields.InValidMessage_defendantid(TotalErrors.ErrorNum),Fields.InValidMessage_recid(TotalErrors.ErrorNum),Fields.InValidMessage_tmsid(TotalErrors.ErrorNum),Fields.InValidMessage_seq_number(TotalErrors.ErrorNum),Fields.InValidMessage_court_code(TotalErrors.ErrorNum),Fields.InValidMessage_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_chapter(TotalErrors.ErrorNum),Fields.InValidMessage_filing_type(TotalErrors.ErrorNum),Fields.InValidMessage_business_flag(TotalErrors.ErrorNum),Fields.InValidMessage_corp_flag(TotalErrors.ErrorNum),Fields.InValidMessage_discharged(TotalErrors.ErrorNum),Fields.InValidMessage_disposition(TotalErrors.ErrorNum),Fields.InValidMessage_pro_se_ind(TotalErrors.ErrorNum),Fields.InValidMessage_converted_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_county(TotalErrors.ErrorNum),Fields.InValidMessage_debtor_type(TotalErrors.ErrorNum),Fields.InValidMessage_debtor_seq(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_ssnsrc(TotalErrors.ErrorNum),Fields.InValidMessage_ssnmatch(TotalErrors.ErrorNum),Fields.InValidMessage_ssnmsrc(TotalErrors.ErrorNum),Fields.InValidMessage_screen(TotalErrors.ErrorNum),Fields.InValidMessage_dcode(TotalErrors.ErrorNum),Fields.InValidMessage_disptype(TotalErrors.ErrorNum),Fields.InValidMessage_dispreason(TotalErrors.ErrorNum),Fields.InValidMessage_statusdate(TotalErrors.ErrorNum),Fields.InValidMessage_holdcase(TotalErrors.ErrorNum),Fields.InValidMessage_datevacated(TotalErrors.ErrorNum),Fields.InValidMessage_datetransferred(TotalErrors.ErrorNum),Fields.InValidMessage_activityreceipt(TotalErrors.ErrorNum),Fields.InValidMessage_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_cname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_company(TotalErrors.ErrorNum),Fields.InValidMessage_orig_addr1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_addr2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_email(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fax(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_app_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_app_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_disptypedesc(TotalErrors.ErrorNum),Fields.InValidMessage_srcdesc(TotalErrors.ErrorNum),Fields.InValidMessage_srcmtchdesc(TotalErrors.ErrorNum),Fields.InValidMessage_screendesc(TotalErrors.ErrorNum),Fields.InValidMessage_dcodedesc(TotalErrors.ErrorNum),Fields.InValidMessage_date_filed(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_delete_flag(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.sourcecode=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
