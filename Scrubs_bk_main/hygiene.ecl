IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_bk_main) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_tmsid_pcnt := AVE(GROUP,IF(h.tmsid = (TYPEOF(h.tmsid))'',0,100));
    maxlength_tmsid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.tmsid)));
    avelength_tmsid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.tmsid)),h.tmsid<>(typeof(h.tmsid))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_id_pcnt := AVE(GROUP,IF(h.id = (TYPEOF(h.id))'',0,100));
    maxlength_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.id)));
    avelength_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.id)),h.id<>(typeof(h.id))'');
    populated_seq_number_pcnt := AVE(GROUP,IF(h.seq_number = (TYPEOF(h.seq_number))'',0,100));
    maxlength_seq_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.seq_number)));
    avelength_seq_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.seq_number)),h.seq_number<>(typeof(h.seq_number))'');
    populated_date_created_pcnt := AVE(GROUP,IF(h.date_created = (TYPEOF(h.date_created))'',0,100));
    maxlength_date_created := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_created)));
    avelength_date_created := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_created)),h.date_created<>(typeof(h.date_created))'');
    populated_date_modified_pcnt := AVE(GROUP,IF(h.date_modified = (TYPEOF(h.date_modified))'',0,100));
    maxlength_date_modified := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_modified)));
    avelength_date_modified := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_modified)),h.date_modified<>(typeof(h.date_modified))'');
    populated_method_dismiss_pcnt := AVE(GROUP,IF(h.method_dismiss = (TYPEOF(h.method_dismiss))'',0,100));
    maxlength_method_dismiss := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.method_dismiss)));
    avelength_method_dismiss := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.method_dismiss)),h.method_dismiss<>(typeof(h.method_dismiss))'');
    populated_case_status_pcnt := AVE(GROUP,IF(h.case_status = (TYPEOF(h.case_status))'',0,100));
    maxlength_case_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.case_status)));
    avelength_case_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.case_status)),h.case_status<>(typeof(h.case_status))'');
    populated_court_code_pcnt := AVE(GROUP,IF(h.court_code = (TYPEOF(h.court_code))'',0,100));
    maxlength_court_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.court_code)));
    avelength_court_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.court_code)),h.court_code<>(typeof(h.court_code))'');
    populated_court_name_pcnt := AVE(GROUP,IF(h.court_name = (TYPEOF(h.court_name))'',0,100));
    maxlength_court_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.court_name)));
    avelength_court_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.court_name)),h.court_name<>(typeof(h.court_name))'');
    populated_court_location_pcnt := AVE(GROUP,IF(h.court_location = (TYPEOF(h.court_location))'',0,100));
    maxlength_court_location := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.court_location)));
    avelength_court_location := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.court_location)),h.court_location<>(typeof(h.court_location))'');
    populated_case_number_pcnt := AVE(GROUP,IF(h.case_number = (TYPEOF(h.case_number))'',0,100));
    maxlength_case_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.case_number)));
    avelength_case_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.case_number)),h.case_number<>(typeof(h.case_number))'');
    populated_orig_case_number_pcnt := AVE(GROUP,IF(h.orig_case_number = (TYPEOF(h.orig_case_number))'',0,100));
    maxlength_orig_case_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_case_number)));
    avelength_orig_case_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_case_number)),h.orig_case_number<>(typeof(h.orig_case_number))'');
    populated_date_filed_pcnt := AVE(GROUP,IF(h.date_filed = (TYPEOF(h.date_filed))'',0,100));
    maxlength_date_filed := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_filed)));
    avelength_date_filed := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_filed)),h.date_filed<>(typeof(h.date_filed))'');
    populated_filing_status_pcnt := AVE(GROUP,IF(h.filing_status = (TYPEOF(h.filing_status))'',0,100));
    maxlength_filing_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.filing_status)));
    avelength_filing_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.filing_status)),h.filing_status<>(typeof(h.filing_status))'');
    populated_orig_chapter_pcnt := AVE(GROUP,IF(h.orig_chapter = (TYPEOF(h.orig_chapter))'',0,100));
    maxlength_orig_chapter := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_chapter)));
    avelength_orig_chapter := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_chapter)),h.orig_chapter<>(typeof(h.orig_chapter))'');
    populated_orig_filing_date_pcnt := AVE(GROUP,IF(h.orig_filing_date = (TYPEOF(h.orig_filing_date))'',0,100));
    maxlength_orig_filing_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_filing_date)));
    avelength_orig_filing_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_filing_date)),h.orig_filing_date<>(typeof(h.orig_filing_date))'');
    populated_assets_no_asset_indicator_pcnt := AVE(GROUP,IF(h.assets_no_asset_indicator = (TYPEOF(h.assets_no_asset_indicator))'',0,100));
    maxlength_assets_no_asset_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.assets_no_asset_indicator)));
    avelength_assets_no_asset_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.assets_no_asset_indicator)),h.assets_no_asset_indicator<>(typeof(h.assets_no_asset_indicator))'');
    populated_filer_type_pcnt := AVE(GROUP,IF(h.filer_type = (TYPEOF(h.filer_type))'',0,100));
    maxlength_filer_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.filer_type)));
    avelength_filer_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.filer_type)),h.filer_type<>(typeof(h.filer_type))'');
    populated_meeting_date_pcnt := AVE(GROUP,IF(h.meeting_date = (TYPEOF(h.meeting_date))'',0,100));
    maxlength_meeting_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.meeting_date)));
    avelength_meeting_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.meeting_date)),h.meeting_date<>(typeof(h.meeting_date))'');
    populated_meeting_time_pcnt := AVE(GROUP,IF(h.meeting_time = (TYPEOF(h.meeting_time))'',0,100));
    maxlength_meeting_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.meeting_time)));
    avelength_meeting_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.meeting_time)),h.meeting_time<>(typeof(h.meeting_time))'');
    populated_address_341_pcnt := AVE(GROUP,IF(h.address_341 = (TYPEOF(h.address_341))'',0,100));
    maxlength_address_341 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_341)));
    avelength_address_341 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_341)),h.address_341<>(typeof(h.address_341))'');
    populated_claims_deadline_pcnt := AVE(GROUP,IF(h.claims_deadline = (TYPEOF(h.claims_deadline))'',0,100));
    maxlength_claims_deadline := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.claims_deadline)));
    avelength_claims_deadline := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.claims_deadline)),h.claims_deadline<>(typeof(h.claims_deadline))'');
    populated_complaint_deadline_pcnt := AVE(GROUP,IF(h.complaint_deadline = (TYPEOF(h.complaint_deadline))'',0,100));
    maxlength_complaint_deadline := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.complaint_deadline)));
    avelength_complaint_deadline := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.complaint_deadline)),h.complaint_deadline<>(typeof(h.complaint_deadline))'');
    populated_judge_name_pcnt := AVE(GROUP,IF(h.judge_name = (TYPEOF(h.judge_name))'',0,100));
    maxlength_judge_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.judge_name)));
    avelength_judge_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.judge_name)),h.judge_name<>(typeof(h.judge_name))'');
    populated_judges_identification_pcnt := AVE(GROUP,IF(h.judges_identification = (TYPEOF(h.judges_identification))'',0,100));
    maxlength_judges_identification := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.judges_identification)));
    avelength_judges_identification := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.judges_identification)),h.judges_identification<>(typeof(h.judges_identification))'');
    populated_filing_jurisdiction_pcnt := AVE(GROUP,IF(h.filing_jurisdiction = (TYPEOF(h.filing_jurisdiction))'',0,100));
    maxlength_filing_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.filing_jurisdiction)));
    avelength_filing_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.filing_jurisdiction)),h.filing_jurisdiction<>(typeof(h.filing_jurisdiction))'');
    populated_assets_pcnt := AVE(GROUP,IF(h.assets = (TYPEOF(h.assets))'',0,100));
    maxlength_assets := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.assets)));
    avelength_assets := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.assets)),h.assets<>(typeof(h.assets))'');
    populated_liabilities_pcnt := AVE(GROUP,IF(h.liabilities = (TYPEOF(h.liabilities))'',0,100));
    maxlength_liabilities := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.liabilities)));
    avelength_liabilities := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.liabilities)),h.liabilities<>(typeof(h.liabilities))'');
    populated_casetype_pcnt := AVE(GROUP,IF(h.casetype = (TYPEOF(h.casetype))'',0,100));
    maxlength_casetype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.casetype)));
    avelength_casetype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.casetype)),h.casetype<>(typeof(h.casetype))'');
    populated_assoccode_pcnt := AVE(GROUP,IF(h.assoccode = (TYPEOF(h.assoccode))'',0,100));
    maxlength_assoccode := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.assoccode)));
    avelength_assoccode := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.assoccode)),h.assoccode<>(typeof(h.assoccode))'');
    populated_splitcase_pcnt := AVE(GROUP,IF(h.splitcase = (TYPEOF(h.splitcase))'',0,100));
    maxlength_splitcase := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.splitcase)));
    avelength_splitcase := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.splitcase)),h.splitcase<>(typeof(h.splitcase))'');
    populated_filedinerror_pcnt := AVE(GROUP,IF(h.filedinerror = (TYPEOF(h.filedinerror))'',0,100));
    maxlength_filedinerror := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.filedinerror)));
    avelength_filedinerror := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.filedinerror)),h.filedinerror<>(typeof(h.filedinerror))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_reopen_date_pcnt := AVE(GROUP,IF(h.reopen_date = (TYPEOF(h.reopen_date))'',0,100));
    maxlength_reopen_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.reopen_date)));
    avelength_reopen_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.reopen_date)),h.reopen_date<>(typeof(h.reopen_date))'');
    populated_case_closing_date_pcnt := AVE(GROUP,IF(h.case_closing_date = (TYPEOF(h.case_closing_date))'',0,100));
    maxlength_case_closing_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.case_closing_date)));
    avelength_case_closing_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.case_closing_date)),h.case_closing_date<>(typeof(h.case_closing_date))'');
    populated_datereclosed_pcnt := AVE(GROUP,IF(h.datereclosed = (TYPEOF(h.datereclosed))'',0,100));
    maxlength_datereclosed := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.datereclosed)));
    avelength_datereclosed := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.datereclosed)),h.datereclosed<>(typeof(h.datereclosed))'');
    populated_trusteename_pcnt := AVE(GROUP,IF(h.trusteename = (TYPEOF(h.trusteename))'',0,100));
    maxlength_trusteename := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteename)));
    avelength_trusteename := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteename)),h.trusteename<>(typeof(h.trusteename))'');
    populated_trusteeaddress_pcnt := AVE(GROUP,IF(h.trusteeaddress = (TYPEOF(h.trusteeaddress))'',0,100));
    maxlength_trusteeaddress := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteeaddress)));
    avelength_trusteeaddress := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteeaddress)),h.trusteeaddress<>(typeof(h.trusteeaddress))'');
    populated_trusteecity_pcnt := AVE(GROUP,IF(h.trusteecity = (TYPEOF(h.trusteecity))'',0,100));
    maxlength_trusteecity := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteecity)));
    avelength_trusteecity := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteecity)),h.trusteecity<>(typeof(h.trusteecity))'');
    populated_trusteestate_pcnt := AVE(GROUP,IF(h.trusteestate = (TYPEOF(h.trusteestate))'',0,100));
    maxlength_trusteestate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteestate)));
    avelength_trusteestate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteestate)),h.trusteestate<>(typeof(h.trusteestate))'');
    populated_trusteezip_pcnt := AVE(GROUP,IF(h.trusteezip = (TYPEOF(h.trusteezip))'',0,100));
    maxlength_trusteezip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteezip)));
    avelength_trusteezip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteezip)),h.trusteezip<>(typeof(h.trusteezip))'');
    populated_trusteezip4_pcnt := AVE(GROUP,IF(h.trusteezip4 = (TYPEOF(h.trusteezip4))'',0,100));
    maxlength_trusteezip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteezip4)));
    avelength_trusteezip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteezip4)),h.trusteezip4<>(typeof(h.trusteezip4))'');
    populated_trusteephone_pcnt := AVE(GROUP,IF(h.trusteephone = (TYPEOF(h.trusteephone))'',0,100));
    maxlength_trusteephone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteephone)));
    avelength_trusteephone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteephone)),h.trusteephone<>(typeof(h.trusteephone))'');
    populated_trusteeid_pcnt := AVE(GROUP,IF(h.trusteeid = (TYPEOF(h.trusteeid))'',0,100));
    maxlength_trusteeid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteeid)));
    avelength_trusteeid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteeid)),h.trusteeid<>(typeof(h.trusteeid))'');
    populated_caseid_pcnt := AVE(GROUP,IF(h.caseid = (TYPEOF(h.caseid))'',0,100));
    maxlength_caseid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.caseid)));
    avelength_caseid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.caseid)),h.caseid<>(typeof(h.caseid))'');
    populated_bardate_pcnt := AVE(GROUP,IF(h.bardate = (TYPEOF(h.bardate))'',0,100));
    maxlength_bardate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bardate)));
    avelength_bardate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bardate)),h.bardate<>(typeof(h.bardate))'');
    populated_transferin_pcnt := AVE(GROUP,IF(h.transferin = (TYPEOF(h.transferin))'',0,100));
    maxlength_transferin := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.transferin)));
    avelength_transferin := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.transferin)),h.transferin<>(typeof(h.transferin))'');
    populated_trusteeemail_pcnt := AVE(GROUP,IF(h.trusteeemail = (TYPEOF(h.trusteeemail))'',0,100));
    maxlength_trusteeemail := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteeemail)));
    avelength_trusteeemail := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trusteeemail)),h.trusteeemail<>(typeof(h.trusteeemail))'');
    populated_planconfdate_pcnt := AVE(GROUP,IF(h.planconfdate = (TYPEOF(h.planconfdate))'',0,100));
    maxlength_planconfdate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.planconfdate)));
    avelength_planconfdate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.planconfdate)),h.planconfdate<>(typeof(h.planconfdate))'');
    populated_confheardate_pcnt := AVE(GROUP,IF(h.confheardate = (TYPEOF(h.confheardate))'',0,100));
    maxlength_confheardate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.confheardate)));
    avelength_confheardate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.confheardate)),h.confheardate<>(typeof(h.confheardate))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_app_ssn_pcnt := AVE(GROUP,IF(h.app_ssn = (TYPEOF(h.app_ssn))'',0,100));
    maxlength_app_ssn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.app_ssn)));
    avelength_app_ssn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.app_ssn)),h.app_ssn<>(typeof(h.app_ssn))'');
    populated_delete_flag_pcnt := AVE(GROUP,IF(h.delete_flag = (TYPEOF(h.delete_flag))'',0,100));
    maxlength_delete_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.delete_flag)));
    avelength_delete_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.delete_flag)),h.delete_flag<>(typeof(h.delete_flag))'');
    populated_unique_id_pcnt := AVE(GROUP,IF(h.unique_id = (TYPEOF(h.unique_id))'',0,100));
    maxlength_unique_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unique_id)));
    avelength_unique_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unique_id)),h.unique_id<>(typeof(h.unique_id))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_tmsid_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_id_pcnt *   0.00 / 100 + T.Populated_seq_number_pcnt *   0.00 / 100 + T.Populated_date_created_pcnt *   0.00 / 100 + T.Populated_date_modified_pcnt *   0.00 / 100 + T.Populated_method_dismiss_pcnt *   0.00 / 100 + T.Populated_case_status_pcnt *   0.00 / 100 + T.Populated_court_code_pcnt *   0.00 / 100 + T.Populated_court_name_pcnt *   0.00 / 100 + T.Populated_court_location_pcnt *   0.00 / 100 + T.Populated_case_number_pcnt *   0.00 / 100 + T.Populated_orig_case_number_pcnt *   0.00 / 100 + T.Populated_date_filed_pcnt *   0.00 / 100 + T.Populated_filing_status_pcnt *   0.00 / 100 + T.Populated_orig_chapter_pcnt *   0.00 / 100 + T.Populated_orig_filing_date_pcnt *   0.00 / 100 + T.Populated_assets_no_asset_indicator_pcnt *   0.00 / 100 + T.Populated_filer_type_pcnt *   0.00 / 100 + T.Populated_meeting_date_pcnt *   0.00 / 100 + T.Populated_meeting_time_pcnt *   0.00 / 100 + T.Populated_address_341_pcnt *   0.00 / 100 + T.Populated_claims_deadline_pcnt *   0.00 / 100 + T.Populated_complaint_deadline_pcnt *   0.00 / 100 + T.Populated_judge_name_pcnt *   0.00 / 100 + T.Populated_judges_identification_pcnt *   0.00 / 100 + T.Populated_filing_jurisdiction_pcnt *   0.00 / 100 + T.Populated_assets_pcnt *   0.00 / 100 + T.Populated_liabilities_pcnt *   0.00 / 100 + T.Populated_casetype_pcnt *   0.00 / 100 + T.Populated_assoccode_pcnt *   0.00 / 100 + T.Populated_splitcase_pcnt *   0.00 / 100 + T.Populated_filedinerror_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_reopen_date_pcnt *   0.00 / 100 + T.Populated_case_closing_date_pcnt *   0.00 / 100 + T.Populated_datereclosed_pcnt *   0.00 / 100 + T.Populated_trusteename_pcnt *   0.00 / 100 + T.Populated_trusteeaddress_pcnt *   0.00 / 100 + T.Populated_trusteecity_pcnt *   0.00 / 100 + T.Populated_trusteestate_pcnt *   0.00 / 100 + T.Populated_trusteezip_pcnt *   0.00 / 100 + T.Populated_trusteezip4_pcnt *   0.00 / 100 + T.Populated_trusteephone_pcnt *   0.00 / 100 + T.Populated_trusteeid_pcnt *   0.00 / 100 + T.Populated_caseid_pcnt *   0.00 / 100 + T.Populated_bardate_pcnt *   0.00 / 100 + T.Populated_transferin_pcnt *   0.00 / 100 + T.Populated_trusteeemail_pcnt *   0.00 / 100 + T.Populated_planconfdate_pcnt *   0.00 / 100 + T.Populated_confheardate_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_app_ssn_pcnt *   0.00 / 100 + T.Populated_delete_flag_pcnt *   0.00 / 100 + T.Populated_unique_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source1;
    STRING source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source1 := le.Source;
    SELF.source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_tmsid_pcnt*ri.Populated_tmsid_pcnt *   0.00 / 10000 + le.Populated_source_pcnt*ri.Populated_source_pcnt *   0.00 / 10000 + le.Populated_id_pcnt*ri.Populated_id_pcnt *   0.00 / 10000 + le.Populated_seq_number_pcnt*ri.Populated_seq_number_pcnt *   0.00 / 10000 + le.Populated_date_created_pcnt*ri.Populated_date_created_pcnt *   0.00 / 10000 + le.Populated_date_modified_pcnt*ri.Populated_date_modified_pcnt *   0.00 / 10000 + le.Populated_method_dismiss_pcnt*ri.Populated_method_dismiss_pcnt *   0.00 / 10000 + le.Populated_case_status_pcnt*ri.Populated_case_status_pcnt *   0.00 / 10000 + le.Populated_court_code_pcnt*ri.Populated_court_code_pcnt *   0.00 / 10000 + le.Populated_court_name_pcnt*ri.Populated_court_name_pcnt *   0.00 / 10000 + le.Populated_court_location_pcnt*ri.Populated_court_location_pcnt *   0.00 / 10000 + le.Populated_case_number_pcnt*ri.Populated_case_number_pcnt *   0.00 / 10000 + le.Populated_orig_case_number_pcnt*ri.Populated_orig_case_number_pcnt *   0.00 / 10000 + le.Populated_date_filed_pcnt*ri.Populated_date_filed_pcnt *   0.00 / 10000 + le.Populated_filing_status_pcnt*ri.Populated_filing_status_pcnt *   0.00 / 10000 + le.Populated_orig_chapter_pcnt*ri.Populated_orig_chapter_pcnt *   0.00 / 10000 + le.Populated_orig_filing_date_pcnt*ri.Populated_orig_filing_date_pcnt *   0.00 / 10000 + le.Populated_assets_no_asset_indicator_pcnt*ri.Populated_assets_no_asset_indicator_pcnt *   0.00 / 10000 + le.Populated_filer_type_pcnt*ri.Populated_filer_type_pcnt *   0.00 / 10000 + le.Populated_meeting_date_pcnt*ri.Populated_meeting_date_pcnt *   0.00 / 10000 + le.Populated_meeting_time_pcnt*ri.Populated_meeting_time_pcnt *   0.00 / 10000 + le.Populated_address_341_pcnt*ri.Populated_address_341_pcnt *   0.00 / 10000 + le.Populated_claims_deadline_pcnt*ri.Populated_claims_deadline_pcnt *   0.00 / 10000 + le.Populated_complaint_deadline_pcnt*ri.Populated_complaint_deadline_pcnt *   0.00 / 10000 + le.Populated_judge_name_pcnt*ri.Populated_judge_name_pcnt *   0.00 / 10000 + le.Populated_judges_identification_pcnt*ri.Populated_judges_identification_pcnt *   0.00 / 10000 + le.Populated_filing_jurisdiction_pcnt*ri.Populated_filing_jurisdiction_pcnt *   0.00 / 10000 + le.Populated_assets_pcnt*ri.Populated_assets_pcnt *   0.00 / 10000 + le.Populated_liabilities_pcnt*ri.Populated_liabilities_pcnt *   0.00 / 10000 + le.Populated_casetype_pcnt*ri.Populated_casetype_pcnt *   0.00 / 10000 + le.Populated_assoccode_pcnt*ri.Populated_assoccode_pcnt *   0.00 / 10000 + le.Populated_splitcase_pcnt*ri.Populated_splitcase_pcnt *   0.00 / 10000 + le.Populated_filedinerror_pcnt*ri.Populated_filedinerror_pcnt *   0.00 / 10000 + le.Populated_date_last_seen_pcnt*ri.Populated_date_last_seen_pcnt *   0.00 / 10000 + le.Populated_date_first_seen_pcnt*ri.Populated_date_first_seen_pcnt *   0.00 / 10000 + le.Populated_date_vendor_first_reported_pcnt*ri.Populated_date_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_date_vendor_last_reported_pcnt*ri.Populated_date_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_reopen_date_pcnt*ri.Populated_reopen_date_pcnt *   0.00 / 10000 + le.Populated_case_closing_date_pcnt*ri.Populated_case_closing_date_pcnt *   0.00 / 10000 + le.Populated_datereclosed_pcnt*ri.Populated_datereclosed_pcnt *   0.00 / 10000 + le.Populated_trusteename_pcnt*ri.Populated_trusteename_pcnt *   0.00 / 10000 + le.Populated_trusteeaddress_pcnt*ri.Populated_trusteeaddress_pcnt *   0.00 / 10000 + le.Populated_trusteecity_pcnt*ri.Populated_trusteecity_pcnt *   0.00 / 10000 + le.Populated_trusteestate_pcnt*ri.Populated_trusteestate_pcnt *   0.00 / 10000 + le.Populated_trusteezip_pcnt*ri.Populated_trusteezip_pcnt *   0.00 / 10000 + le.Populated_trusteezip4_pcnt*ri.Populated_trusteezip4_pcnt *   0.00 / 10000 + le.Populated_trusteephone_pcnt*ri.Populated_trusteephone_pcnt *   0.00 / 10000 + le.Populated_trusteeid_pcnt*ri.Populated_trusteeid_pcnt *   0.00 / 10000 + le.Populated_caseid_pcnt*ri.Populated_caseid_pcnt *   0.00 / 10000 + le.Populated_bardate_pcnt*ri.Populated_bardate_pcnt *   0.00 / 10000 + le.Populated_transferin_pcnt*ri.Populated_transferin_pcnt *   0.00 / 10000 + le.Populated_trusteeemail_pcnt*ri.Populated_trusteeemail_pcnt *   0.00 / 10000 + le.Populated_planconfdate_pcnt*ri.Populated_planconfdate_pcnt *   0.00 / 10000 + le.Populated_confheardate_pcnt*ri.Populated_confheardate_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dbpc_pcnt*ri.Populated_dbpc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_app_ssn_pcnt*ri.Populated_app_ssn_pcnt *   0.00 / 10000 + le.Populated_delete_flag_pcnt*ri.Populated_delete_flag_pcnt *   0.00 / 10000 + le.Populated_unique_id_pcnt*ri.Populated_unique_id_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'process_date','tmsid','source','id','seq_number','date_created','date_modified','method_dismiss','case_status','court_code','court_name','court_location','case_number','orig_case_number','date_filed','filing_status','orig_chapter','orig_filing_date','assets_no_asset_indicator','filer_type','meeting_date','meeting_time','address_341','claims_deadline','complaint_deadline','judge_name','judges_identification','filing_jurisdiction','assets','liabilities','casetype','assoccode','splitcase','filedinerror','date_last_seen','date_first_seen','date_vendor_first_reported','date_vendor_last_reported','reopen_date','case_closing_date','datereclosed','trusteename','trusteeaddress','trusteecity','trusteestate','trusteezip','trusteezip4','trusteephone','trusteeid','caseid','bardate','transferin','trusteeemail','planconfdate','confheardate','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','did','app_ssn','delete_flag','unique_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_tmsid_pcnt,le.populated_source_pcnt,le.populated_id_pcnt,le.populated_seq_number_pcnt,le.populated_date_created_pcnt,le.populated_date_modified_pcnt,le.populated_method_dismiss_pcnt,le.populated_case_status_pcnt,le.populated_court_code_pcnt,le.populated_court_name_pcnt,le.populated_court_location_pcnt,le.populated_case_number_pcnt,le.populated_orig_case_number_pcnt,le.populated_date_filed_pcnt,le.populated_filing_status_pcnt,le.populated_orig_chapter_pcnt,le.populated_orig_filing_date_pcnt,le.populated_assets_no_asset_indicator_pcnt,le.populated_filer_type_pcnt,le.populated_meeting_date_pcnt,le.populated_meeting_time_pcnt,le.populated_address_341_pcnt,le.populated_claims_deadline_pcnt,le.populated_complaint_deadline_pcnt,le.populated_judge_name_pcnt,le.populated_judges_identification_pcnt,le.populated_filing_jurisdiction_pcnt,le.populated_assets_pcnt,le.populated_liabilities_pcnt,le.populated_casetype_pcnt,le.populated_assoccode_pcnt,le.populated_splitcase_pcnt,le.populated_filedinerror_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_reopen_date_pcnt,le.populated_case_closing_date_pcnt,le.populated_datereclosed_pcnt,le.populated_trusteename_pcnt,le.populated_trusteeaddress_pcnt,le.populated_trusteecity_pcnt,le.populated_trusteestate_pcnt,le.populated_trusteezip_pcnt,le.populated_trusteezip4_pcnt,le.populated_trusteephone_pcnt,le.populated_trusteeid_pcnt,le.populated_caseid_pcnt,le.populated_bardate_pcnt,le.populated_transferin_pcnt,le.populated_trusteeemail_pcnt,le.populated_planconfdate_pcnt,le.populated_confheardate_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_did_pcnt,le.populated_app_ssn_pcnt,le.populated_delete_flag_pcnt,le.populated_unique_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_tmsid,le.maxlength_source,le.maxlength_id,le.maxlength_seq_number,le.maxlength_date_created,le.maxlength_date_modified,le.maxlength_method_dismiss,le.maxlength_case_status,le.maxlength_court_code,le.maxlength_court_name,le.maxlength_court_location,le.maxlength_case_number,le.maxlength_orig_case_number,le.maxlength_date_filed,le.maxlength_filing_status,le.maxlength_orig_chapter,le.maxlength_orig_filing_date,le.maxlength_assets_no_asset_indicator,le.maxlength_filer_type,le.maxlength_meeting_date,le.maxlength_meeting_time,le.maxlength_address_341,le.maxlength_claims_deadline,le.maxlength_complaint_deadline,le.maxlength_judge_name,le.maxlength_judges_identification,le.maxlength_filing_jurisdiction,le.maxlength_assets,le.maxlength_liabilities,le.maxlength_casetype,le.maxlength_assoccode,le.maxlength_splitcase,le.maxlength_filedinerror,le.maxlength_date_last_seen,le.maxlength_date_first_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_reopen_date,le.maxlength_case_closing_date,le.maxlength_datereclosed,le.maxlength_trusteename,le.maxlength_trusteeaddress,le.maxlength_trusteecity,le.maxlength_trusteestate,le.maxlength_trusteezip,le.maxlength_trusteezip4,le.maxlength_trusteephone,le.maxlength_trusteeid,le.maxlength_caseid,le.maxlength_bardate,le.maxlength_transferin,le.maxlength_trusteeemail,le.maxlength_planconfdate,le.maxlength_confheardate,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_did,le.maxlength_app_ssn,le.maxlength_delete_flag,le.maxlength_unique_id);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_tmsid,le.avelength_source,le.avelength_id,le.avelength_seq_number,le.avelength_date_created,le.avelength_date_modified,le.avelength_method_dismiss,le.avelength_case_status,le.avelength_court_code,le.avelength_court_name,le.avelength_court_location,le.avelength_case_number,le.avelength_orig_case_number,le.avelength_date_filed,le.avelength_filing_status,le.avelength_orig_chapter,le.avelength_orig_filing_date,le.avelength_assets_no_asset_indicator,le.avelength_filer_type,le.avelength_meeting_date,le.avelength_meeting_time,le.avelength_address_341,le.avelength_claims_deadline,le.avelength_complaint_deadline,le.avelength_judge_name,le.avelength_judges_identification,le.avelength_filing_jurisdiction,le.avelength_assets,le.avelength_liabilities,le.avelength_casetype,le.avelength_assoccode,le.avelength_splitcase,le.avelength_filedinerror,le.avelength_date_last_seen,le.avelength_date_first_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_reopen_date,le.avelength_case_closing_date,le.avelength_datereclosed,le.avelength_trusteename,le.avelength_trusteeaddress,le.avelength_trusteecity,le.avelength_trusteestate,le.avelength_trusteezip,le.avelength_trusteezip4,le.avelength_trusteephone,le.avelength_trusteeid,le.avelength_caseid,le.avelength_bardate,le.avelength_transferin,le.avelength_trusteeemail,le.avelength_planconfdate,le.avelength_confheardate,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_did,le.avelength_app_ssn,le.avelength_delete_flag,le.avelength_unique_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 91, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.process_date),TRIM((SALT30.StrType)le.tmsid),TRIM((SALT30.StrType)le.source),TRIM((SALT30.StrType)le.id),TRIM((SALT30.StrType)le.seq_number),TRIM((SALT30.StrType)le.date_created),TRIM((SALT30.StrType)le.date_modified),TRIM((SALT30.StrType)le.method_dismiss),TRIM((SALT30.StrType)le.case_status),TRIM((SALT30.StrType)le.court_code),TRIM((SALT30.StrType)le.court_name),TRIM((SALT30.StrType)le.court_location),TRIM((SALT30.StrType)le.case_number),TRIM((SALT30.StrType)le.orig_case_number),TRIM((SALT30.StrType)le.date_filed),TRIM((SALT30.StrType)le.filing_status),TRIM((SALT30.StrType)le.orig_chapter),TRIM((SALT30.StrType)le.orig_filing_date),TRIM((SALT30.StrType)le.assets_no_asset_indicator),TRIM((SALT30.StrType)le.filer_type),TRIM((SALT30.StrType)le.meeting_date),TRIM((SALT30.StrType)le.meeting_time),TRIM((SALT30.StrType)le.address_341),TRIM((SALT30.StrType)le.claims_deadline),TRIM((SALT30.StrType)le.complaint_deadline),TRIM((SALT30.StrType)le.judge_name),TRIM((SALT30.StrType)le.judges_identification),TRIM((SALT30.StrType)le.filing_jurisdiction),TRIM((SALT30.StrType)le.assets),TRIM((SALT30.StrType)le.liabilities),TRIM((SALT30.StrType)le.casetype),TRIM((SALT30.StrType)le.assoccode),TRIM((SALT30.StrType)le.splitcase),TRIM((SALT30.StrType)le.filedinerror),TRIM((SALT30.StrType)le.date_last_seen),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.reopen_date),TRIM((SALT30.StrType)le.case_closing_date),TRIM((SALT30.StrType)le.datereclosed),TRIM((SALT30.StrType)le.trusteename),TRIM((SALT30.StrType)le.trusteeaddress),TRIM((SALT30.StrType)le.trusteecity),TRIM((SALT30.StrType)le.trusteestate),TRIM((SALT30.StrType)le.trusteezip),TRIM((SALT30.StrType)le.trusteezip4),TRIM((SALT30.StrType)le.trusteephone),TRIM((SALT30.StrType)le.trusteeid),TRIM((SALT30.StrType)le.caseid),TRIM((SALT30.StrType)le.bardate),TRIM((SALT30.StrType)le.transferin),TRIM((SALT30.StrType)le.trusteeemail),TRIM((SALT30.StrType)le.planconfdate),TRIM((SALT30.StrType)le.confheardate),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dbpc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.app_ssn),TRIM((SALT30.StrType)le.delete_flag),TRIM((SALT30.StrType)le.unique_id)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,91,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 91);
  SELF.FldNo2 := 1 + (C % 91);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.process_date),TRIM((SALT30.StrType)le.tmsid),TRIM((SALT30.StrType)le.source),TRIM((SALT30.StrType)le.id),TRIM((SALT30.StrType)le.seq_number),TRIM((SALT30.StrType)le.date_created),TRIM((SALT30.StrType)le.date_modified),TRIM((SALT30.StrType)le.method_dismiss),TRIM((SALT30.StrType)le.case_status),TRIM((SALT30.StrType)le.court_code),TRIM((SALT30.StrType)le.court_name),TRIM((SALT30.StrType)le.court_location),TRIM((SALT30.StrType)le.case_number),TRIM((SALT30.StrType)le.orig_case_number),TRIM((SALT30.StrType)le.date_filed),TRIM((SALT30.StrType)le.filing_status),TRIM((SALT30.StrType)le.orig_chapter),TRIM((SALT30.StrType)le.orig_filing_date),TRIM((SALT30.StrType)le.assets_no_asset_indicator),TRIM((SALT30.StrType)le.filer_type),TRIM((SALT30.StrType)le.meeting_date),TRIM((SALT30.StrType)le.meeting_time),TRIM((SALT30.StrType)le.address_341),TRIM((SALT30.StrType)le.claims_deadline),TRIM((SALT30.StrType)le.complaint_deadline),TRIM((SALT30.StrType)le.judge_name),TRIM((SALT30.StrType)le.judges_identification),TRIM((SALT30.StrType)le.filing_jurisdiction),TRIM((SALT30.StrType)le.assets),TRIM((SALT30.StrType)le.liabilities),TRIM((SALT30.StrType)le.casetype),TRIM((SALT30.StrType)le.assoccode),TRIM((SALT30.StrType)le.splitcase),TRIM((SALT30.StrType)le.filedinerror),TRIM((SALT30.StrType)le.date_last_seen),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.reopen_date),TRIM((SALT30.StrType)le.case_closing_date),TRIM((SALT30.StrType)le.datereclosed),TRIM((SALT30.StrType)le.trusteename),TRIM((SALT30.StrType)le.trusteeaddress),TRIM((SALT30.StrType)le.trusteecity),TRIM((SALT30.StrType)le.trusteestate),TRIM((SALT30.StrType)le.trusteezip),TRIM((SALT30.StrType)le.trusteezip4),TRIM((SALT30.StrType)le.trusteephone),TRIM((SALT30.StrType)le.trusteeid),TRIM((SALT30.StrType)le.caseid),TRIM((SALT30.StrType)le.bardate),TRIM((SALT30.StrType)le.transferin),TRIM((SALT30.StrType)le.trusteeemail),TRIM((SALT30.StrType)le.planconfdate),TRIM((SALT30.StrType)le.confheardate),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dbpc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.app_ssn),TRIM((SALT30.StrType)le.delete_flag),TRIM((SALT30.StrType)le.unique_id)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.process_date),TRIM((SALT30.StrType)le.tmsid),TRIM((SALT30.StrType)le.source),TRIM((SALT30.StrType)le.id),TRIM((SALT30.StrType)le.seq_number),TRIM((SALT30.StrType)le.date_created),TRIM((SALT30.StrType)le.date_modified),TRIM((SALT30.StrType)le.method_dismiss),TRIM((SALT30.StrType)le.case_status),TRIM((SALT30.StrType)le.court_code),TRIM((SALT30.StrType)le.court_name),TRIM((SALT30.StrType)le.court_location),TRIM((SALT30.StrType)le.case_number),TRIM((SALT30.StrType)le.orig_case_number),TRIM((SALT30.StrType)le.date_filed),TRIM((SALT30.StrType)le.filing_status),TRIM((SALT30.StrType)le.orig_chapter),TRIM((SALT30.StrType)le.orig_filing_date),TRIM((SALT30.StrType)le.assets_no_asset_indicator),TRIM((SALT30.StrType)le.filer_type),TRIM((SALT30.StrType)le.meeting_date),TRIM((SALT30.StrType)le.meeting_time),TRIM((SALT30.StrType)le.address_341),TRIM((SALT30.StrType)le.claims_deadline),TRIM((SALT30.StrType)le.complaint_deadline),TRIM((SALT30.StrType)le.judge_name),TRIM((SALT30.StrType)le.judges_identification),TRIM((SALT30.StrType)le.filing_jurisdiction),TRIM((SALT30.StrType)le.assets),TRIM((SALT30.StrType)le.liabilities),TRIM((SALT30.StrType)le.casetype),TRIM((SALT30.StrType)le.assoccode),TRIM((SALT30.StrType)le.splitcase),TRIM((SALT30.StrType)le.filedinerror),TRIM((SALT30.StrType)le.date_last_seen),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.reopen_date),TRIM((SALT30.StrType)le.case_closing_date),TRIM((SALT30.StrType)le.datereclosed),TRIM((SALT30.StrType)le.trusteename),TRIM((SALT30.StrType)le.trusteeaddress),TRIM((SALT30.StrType)le.trusteecity),TRIM((SALT30.StrType)le.trusteestate),TRIM((SALT30.StrType)le.trusteezip),TRIM((SALT30.StrType)le.trusteezip4),TRIM((SALT30.StrType)le.trusteephone),TRIM((SALT30.StrType)le.trusteeid),TRIM((SALT30.StrType)le.caseid),TRIM((SALT30.StrType)le.bardate),TRIM((SALT30.StrType)le.transferin),TRIM((SALT30.StrType)le.trusteeemail),TRIM((SALT30.StrType)le.planconfdate),TRIM((SALT30.StrType)le.confheardate),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dbpc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.app_ssn),TRIM((SALT30.StrType)le.delete_flag),TRIM((SALT30.StrType)le.unique_id)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),91*91,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'tmsid'}
      ,{3,'source'}
      ,{4,'id'}
      ,{5,'seq_number'}
      ,{6,'date_created'}
      ,{7,'date_modified'}
      ,{8,'method_dismiss'}
      ,{9,'case_status'}
      ,{10,'court_code'}
      ,{11,'court_name'}
      ,{12,'court_location'}
      ,{13,'case_number'}
      ,{14,'orig_case_number'}
      ,{15,'date_filed'}
      ,{16,'filing_status'}
      ,{17,'orig_chapter'}
      ,{18,'orig_filing_date'}
      ,{19,'assets_no_asset_indicator'}
      ,{20,'filer_type'}
      ,{21,'meeting_date'}
      ,{22,'meeting_time'}
      ,{23,'address_341'}
      ,{24,'claims_deadline'}
      ,{25,'complaint_deadline'}
      ,{26,'judge_name'}
      ,{27,'judges_identification'}
      ,{28,'filing_jurisdiction'}
      ,{29,'assets'}
      ,{30,'liabilities'}
      ,{31,'casetype'}
      ,{32,'assoccode'}
      ,{33,'splitcase'}
      ,{34,'filedinerror'}
      ,{35,'date_last_seen'}
      ,{36,'date_first_seen'}
      ,{37,'date_vendor_first_reported'}
      ,{38,'date_vendor_last_reported'}
      ,{39,'reopen_date'}
      ,{40,'case_closing_date'}
      ,{41,'datereclosed'}
      ,{42,'trusteename'}
      ,{43,'trusteeaddress'}
      ,{44,'trusteecity'}
      ,{45,'trusteestate'}
      ,{46,'trusteezip'}
      ,{47,'trusteezip4'}
      ,{48,'trusteephone'}
      ,{49,'trusteeid'}
      ,{50,'caseid'}
      ,{51,'bardate'}
      ,{52,'transferin'}
      ,{53,'trusteeemail'}
      ,{54,'planconfdate'}
      ,{55,'confheardate'}
      ,{56,'title'}
      ,{57,'fname'}
      ,{58,'mname'}
      ,{59,'lname'}
      ,{60,'name_suffix'}
      ,{61,'name_score'}
      ,{62,'prim_range'}
      ,{63,'predir'}
      ,{64,'prim_name'}
      ,{65,'addr_suffix'}
      ,{66,'postdir'}
      ,{67,'unit_desig'}
      ,{68,'sec_range'}
      ,{69,'p_city_name'}
      ,{70,'v_city_name'}
      ,{71,'st'}
      ,{72,'zip'}
      ,{73,'zip4'}
      ,{74,'cart'}
      ,{75,'cr_sort_sz'}
      ,{76,'lot'}
      ,{77,'lot_order'}
      ,{78,'dbpc'}
      ,{79,'chk_digit'}
      ,{80,'rec_type'}
      ,{81,'county'}
      ,{82,'geo_lat'}
      ,{83,'geo_long'}
      ,{84,'msa'}
      ,{85,'geo_blk'}
      ,{86,'geo_match'}
      ,{87,'err_stat'}
      ,{88,'did'}
      ,{89,'app_ssn'}
      ,{90,'delete_flag'}
      ,{91,'unique_id'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT30.StrType)le.process_date),
    Fields.InValid_tmsid((SALT30.StrType)le.tmsid),
    Fields.InValid_source((SALT30.StrType)le.source),
    Fields.InValid_id((SALT30.StrType)le.id),
    Fields.InValid_seq_number((SALT30.StrType)le.seq_number),
    Fields.InValid_date_created((SALT30.StrType)le.date_created),
    Fields.InValid_date_modified((SALT30.StrType)le.date_modified),
    Fields.InValid_method_dismiss((SALT30.StrType)le.method_dismiss),
    Fields.InValid_case_status((SALT30.StrType)le.case_status),
    Fields.InValid_court_code((SALT30.StrType)le.court_code),
    Fields.InValid_court_name((SALT30.StrType)le.court_name),
    Fields.InValid_court_location((SALT30.StrType)le.court_location),
    Fields.InValid_case_number((SALT30.StrType)le.case_number),
    Fields.InValid_orig_case_number((SALT30.StrType)le.orig_case_number),
    Fields.InValid_date_filed((SALT30.StrType)le.date_filed),
    Fields.InValid_filing_status((SALT30.StrType)le.filing_status),
    Fields.InValid_orig_chapter((SALT30.StrType)le.orig_chapter),
    Fields.InValid_orig_filing_date((SALT30.StrType)le.orig_filing_date),
    Fields.InValid_assets_no_asset_indicator((SALT30.StrType)le.assets_no_asset_indicator),
    Fields.InValid_filer_type((SALT30.StrType)le.filer_type),
    Fields.InValid_meeting_date((SALT30.StrType)le.meeting_date),
    Fields.InValid_meeting_time((SALT30.StrType)le.meeting_time),
    Fields.InValid_address_341((SALT30.StrType)le.address_341),
    Fields.InValid_claims_deadline((SALT30.StrType)le.claims_deadline),
    Fields.InValid_complaint_deadline((SALT30.StrType)le.complaint_deadline),
    Fields.InValid_judge_name((SALT30.StrType)le.judge_name),
    Fields.InValid_judges_identification((SALT30.StrType)le.judges_identification),
    Fields.InValid_filing_jurisdiction((SALT30.StrType)le.filing_jurisdiction),
    Fields.InValid_assets((SALT30.StrType)le.assets),
    Fields.InValid_liabilities((SALT30.StrType)le.liabilities),
    Fields.InValid_casetype((SALT30.StrType)le.casetype),
    Fields.InValid_assoccode((SALT30.StrType)le.assoccode),
    Fields.InValid_splitcase((SALT30.StrType)le.splitcase),
    Fields.InValid_filedinerror((SALT30.StrType)le.filedinerror),
    Fields.InValid_date_last_seen((SALT30.StrType)le.date_last_seen),
    Fields.InValid_date_first_seen((SALT30.StrType)le.date_first_seen),
    Fields.InValid_date_vendor_first_reported((SALT30.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT30.StrType)le.date_vendor_last_reported),
    Fields.InValid_reopen_date((SALT30.StrType)le.reopen_date),
    Fields.InValid_case_closing_date((SALT30.StrType)le.case_closing_date),
    Fields.InValid_datereclosed((SALT30.StrType)le.datereclosed),
    Fields.InValid_trusteename((SALT30.StrType)le.trusteename),
    Fields.InValid_trusteeaddress((SALT30.StrType)le.trusteeaddress),
    Fields.InValid_trusteecity((SALT30.StrType)le.trusteecity),
    Fields.InValid_trusteestate((SALT30.StrType)le.trusteestate),
    Fields.InValid_trusteezip((SALT30.StrType)le.trusteezip),
    Fields.InValid_trusteezip4((SALT30.StrType)le.trusteezip4),
    Fields.InValid_trusteephone((SALT30.StrType)le.trusteephone),
    Fields.InValid_trusteeid((SALT30.StrType)le.trusteeid),
    Fields.InValid_caseid((SALT30.StrType)le.caseid),
    Fields.InValid_bardate((SALT30.StrType)le.bardate),
    Fields.InValid_transferin((SALT30.StrType)le.transferin),
    Fields.InValid_trusteeemail((SALT30.StrType)le.trusteeemail),
    Fields.InValid_planconfdate((SALT30.StrType)le.planconfdate),
    Fields.InValid_confheardate((SALT30.StrType)le.confheardate),
    Fields.InValid_title((SALT30.StrType)le.title),
    Fields.InValid_fname((SALT30.StrType)le.fname),
    Fields.InValid_mname((SALT30.StrType)le.mname),
    Fields.InValid_lname((SALT30.StrType)le.lname),
    Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT30.StrType)le.name_score),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_predir((SALT30.StrType)le.predir),
    Fields.InValid_prim_name((SALT30.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT30.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT30.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT30.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name),
    Fields.InValid_st((SALT30.StrType)le.st),
    Fields.InValid_zip((SALT30.StrType)le.zip),
    Fields.InValid_zip4((SALT30.StrType)le.zip4),
    Fields.InValid_cart((SALT30.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT30.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT30.StrType)le.lot),
    Fields.InValid_lot_order((SALT30.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT30.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT30.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT30.StrType)le.rec_type),
    Fields.InValid_county((SALT30.StrType)le.county),
    Fields.InValid_geo_lat((SALT30.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT30.StrType)le.geo_long),
    Fields.InValid_msa((SALT30.StrType)le.msa),
    Fields.InValid_geo_blk((SALT30.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT30.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT30.StrType)le.err_stat),
    Fields.InValid_did((SALT30.StrType)le.did),
    Fields.InValid_app_ssn((SALT30.StrType)le.app_ssn),
    Fields.InValid_delete_flag((SALT30.StrType)le.delete_flag),
    Fields.InValid_unique_id((SALT30.StrType)le.unique_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,91,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alnum','invalid_alnum','invalid_date','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_name','invalid_name','invalid_name','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_tmsid(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_id(TotalErrors.ErrorNum),Fields.InValidMessage_seq_number(TotalErrors.ErrorNum),Fields.InValidMessage_date_created(TotalErrors.ErrorNum),Fields.InValidMessage_date_modified(TotalErrors.ErrorNum),Fields.InValidMessage_method_dismiss(TotalErrors.ErrorNum),Fields.InValidMessage_case_status(TotalErrors.ErrorNum),Fields.InValidMessage_court_code(TotalErrors.ErrorNum),Fields.InValidMessage_court_name(TotalErrors.ErrorNum),Fields.InValidMessage_court_location(TotalErrors.ErrorNum),Fields.InValidMessage_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_date_filed(TotalErrors.ErrorNum),Fields.InValidMessage_filing_status(TotalErrors.ErrorNum),Fields.InValidMessage_orig_chapter(TotalErrors.ErrorNum),Fields.InValidMessage_orig_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_assets_no_asset_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_filer_type(TotalErrors.ErrorNum),Fields.InValidMessage_meeting_date(TotalErrors.ErrorNum),Fields.InValidMessage_meeting_time(TotalErrors.ErrorNum),Fields.InValidMessage_address_341(TotalErrors.ErrorNum),Fields.InValidMessage_claims_deadline(TotalErrors.ErrorNum),Fields.InValidMessage_complaint_deadline(TotalErrors.ErrorNum),Fields.InValidMessage_judge_name(TotalErrors.ErrorNum),Fields.InValidMessage_judges_identification(TotalErrors.ErrorNum),Fields.InValidMessage_filing_jurisdiction(TotalErrors.ErrorNum),Fields.InValidMessage_assets(TotalErrors.ErrorNum),Fields.InValidMessage_liabilities(TotalErrors.ErrorNum),Fields.InValidMessage_casetype(TotalErrors.ErrorNum),Fields.InValidMessage_assoccode(TotalErrors.ErrorNum),Fields.InValidMessage_splitcase(TotalErrors.ErrorNum),Fields.InValidMessage_filedinerror(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_reopen_date(TotalErrors.ErrorNum),Fields.InValidMessage_case_closing_date(TotalErrors.ErrorNum),Fields.InValidMessage_datereclosed(TotalErrors.ErrorNum),Fields.InValidMessage_trusteename(TotalErrors.ErrorNum),Fields.InValidMessage_trusteeaddress(TotalErrors.ErrorNum),Fields.InValidMessage_trusteecity(TotalErrors.ErrorNum),Fields.InValidMessage_trusteestate(TotalErrors.ErrorNum),Fields.InValidMessage_trusteezip(TotalErrors.ErrorNum),Fields.InValidMessage_trusteezip4(TotalErrors.ErrorNum),Fields.InValidMessage_trusteephone(TotalErrors.ErrorNum),Fields.InValidMessage_trusteeid(TotalErrors.ErrorNum),Fields.InValidMessage_caseid(TotalErrors.ErrorNum),Fields.InValidMessage_bardate(TotalErrors.ErrorNum),Fields.InValidMessage_transferin(TotalErrors.ErrorNum),Fields.InValidMessage_trusteeemail(TotalErrors.ErrorNum),Fields.InValidMessage_planconfdate(TotalErrors.ErrorNum),Fields.InValidMessage_confheardate(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_app_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_delete_flag(TotalErrors.ErrorNum),Fields.InValidMessage_unique_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
