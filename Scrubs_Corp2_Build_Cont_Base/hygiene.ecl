IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_Scrubs_Corp2_Build_Cont_Base.in_file) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_corp_key_pcnt := AVE(GROUP,IF(h.corp_key = (TYPEOF(h.corp_key))'',0,100));
    maxlength_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_key)));
    avelength_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_key)),h.corp_key<>(typeof(h.corp_key))'');
    populated_corp_supp_key_pcnt := AVE(GROUP,IF(h.corp_supp_key = (TYPEOF(h.corp_supp_key))'',0,100));
    maxlength_corp_supp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_supp_key)));
    avelength_corp_supp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_supp_key)),h.corp_supp_key<>(typeof(h.corp_supp_key))'');
    populated_corp_vendor_pcnt := AVE(GROUP,IF(h.corp_vendor = (TYPEOF(h.corp_vendor))'',0,100));
    maxlength_corp_vendor := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor)));
    avelength_corp_vendor := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor)),h.corp_vendor<>(typeof(h.corp_vendor))'');
    populated_corp_vendor_county_pcnt := AVE(GROUP,IF(h.corp_vendor_county = (TYPEOF(h.corp_vendor_county))'',0,100));
    maxlength_corp_vendor_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor_county)));
    avelength_corp_vendor_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor_county)),h.corp_vendor_county<>(typeof(h.corp_vendor_county))'');
    populated_corp_vendor_subcode_pcnt := AVE(GROUP,IF(h.corp_vendor_subcode = (TYPEOF(h.corp_vendor_subcode))'',0,100));
    maxlength_corp_vendor_subcode := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor_subcode)));
    avelength_corp_vendor_subcode := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor_subcode)),h.corp_vendor_subcode<>(typeof(h.corp_vendor_subcode))'');
    populated_corp_state_origin_pcnt := AVE(GROUP,IF(h.corp_state_origin = (TYPEOF(h.corp_state_origin))'',0,100));
    maxlength_corp_state_origin := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_state_origin)));
    avelength_corp_state_origin := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_state_origin)),h.corp_state_origin<>(typeof(h.corp_state_origin))'');
    populated_corp_process_date_pcnt := AVE(GROUP,IF(h.corp_process_date = (TYPEOF(h.corp_process_date))'',0,100));
    maxlength_corp_process_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_process_date)));
    avelength_corp_process_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_process_date)),h.corp_process_date<>(typeof(h.corp_process_date))'');
    populated_corp_orig_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_orig_sos_charter_nbr = (TYPEOF(h.corp_orig_sos_charter_nbr))'',0,100));
    maxlength_corp_orig_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_orig_sos_charter_nbr)));
    avelength_corp_orig_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_orig_sos_charter_nbr)),h.corp_orig_sos_charter_nbr<>(typeof(h.corp_orig_sos_charter_nbr))'');
    populated_corp_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_sos_charter_nbr = (TYPEOF(h.corp_sos_charter_nbr))'',0,100));
    maxlength_corp_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_sos_charter_nbr)));
    avelength_corp_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_sos_charter_nbr)),h.corp_sos_charter_nbr<>(typeof(h.corp_sos_charter_nbr))'');
    populated_corp_legal_name_pcnt := AVE(GROUP,IF(h.corp_legal_name = (TYPEOF(h.corp_legal_name))'',0,100));
    maxlength_corp_legal_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_legal_name)));
    avelength_corp_legal_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_legal_name)),h.corp_legal_name<>(typeof(h.corp_legal_name))'');
    populated_corp_address1_type_cd_pcnt := AVE(GROUP,IF(h.corp_address1_type_cd = (TYPEOF(h.corp_address1_type_cd))'',0,100));
    maxlength_corp_address1_type_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_type_cd)));
    avelength_corp_address1_type_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_type_cd)),h.corp_address1_type_cd<>(typeof(h.corp_address1_type_cd))'');
    populated_corp_address1_type_desc_pcnt := AVE(GROUP,IF(h.corp_address1_type_desc = (TYPEOF(h.corp_address1_type_desc))'',0,100));
    maxlength_corp_address1_type_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_type_desc)));
    avelength_corp_address1_type_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_type_desc)),h.corp_address1_type_desc<>(typeof(h.corp_address1_type_desc))'');
    populated_corp_address1_line1_pcnt := AVE(GROUP,IF(h.corp_address1_line1 = (TYPEOF(h.corp_address1_line1))'',0,100));
    maxlength_corp_address1_line1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line1)));
    avelength_corp_address1_line1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line1)),h.corp_address1_line1<>(typeof(h.corp_address1_line1))'');
    populated_corp_address1_line2_pcnt := AVE(GROUP,IF(h.corp_address1_line2 = (TYPEOF(h.corp_address1_line2))'',0,100));
    maxlength_corp_address1_line2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line2)));
    avelength_corp_address1_line2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line2)),h.corp_address1_line2<>(typeof(h.corp_address1_line2))'');
    populated_corp_address1_line3_pcnt := AVE(GROUP,IF(h.corp_address1_line3 = (TYPEOF(h.corp_address1_line3))'',0,100));
    maxlength_corp_address1_line3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line3)));
    avelength_corp_address1_line3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line3)),h.corp_address1_line3<>(typeof(h.corp_address1_line3))'');
    populated_corp_address1_line4_pcnt := AVE(GROUP,IF(h.corp_address1_line4 = (TYPEOF(h.corp_address1_line4))'',0,100));
    maxlength_corp_address1_line4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line4)));
    avelength_corp_address1_line4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line4)),h.corp_address1_line4<>(typeof(h.corp_address1_line4))'');
    populated_corp_address1_line5_pcnt := AVE(GROUP,IF(h.corp_address1_line5 = (TYPEOF(h.corp_address1_line5))'',0,100));
    maxlength_corp_address1_line5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line5)));
    avelength_corp_address1_line5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line5)),h.corp_address1_line5<>(typeof(h.corp_address1_line5))'');
    populated_corp_address1_line6_pcnt := AVE(GROUP,IF(h.corp_address1_line6 = (TYPEOF(h.corp_address1_line6))'',0,100));
    maxlength_corp_address1_line6 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line6)));
    avelength_corp_address1_line6 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_line6)),h.corp_address1_line6<>(typeof(h.corp_address1_line6))'');
    populated_corp_address1_effective_date_pcnt := AVE(GROUP,IF(h.corp_address1_effective_date = (TYPEOF(h.corp_address1_effective_date))'',0,100));
    maxlength_corp_address1_effective_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_effective_date)));
    avelength_corp_address1_effective_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address1_effective_date)),h.corp_address1_effective_date<>(typeof(h.corp_address1_effective_date))'');
    populated_corp_phone_number_pcnt := AVE(GROUP,IF(h.corp_phone_number = (TYPEOF(h.corp_phone_number))'',0,100));
    maxlength_corp_phone_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_phone_number)));
    avelength_corp_phone_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_phone_number)),h.corp_phone_number<>(typeof(h.corp_phone_number))'');
    populated_corp_phone_number_type_cd_pcnt := AVE(GROUP,IF(h.corp_phone_number_type_cd = (TYPEOF(h.corp_phone_number_type_cd))'',0,100));
    maxlength_corp_phone_number_type_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_phone_number_type_cd)));
    avelength_corp_phone_number_type_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_phone_number_type_cd)),h.corp_phone_number_type_cd<>(typeof(h.corp_phone_number_type_cd))'');
    populated_corp_phone_number_type_desc_pcnt := AVE(GROUP,IF(h.corp_phone_number_type_desc = (TYPEOF(h.corp_phone_number_type_desc))'',0,100));
    maxlength_corp_phone_number_type_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_phone_number_type_desc)));
    avelength_corp_phone_number_type_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_phone_number_type_desc)),h.corp_phone_number_type_desc<>(typeof(h.corp_phone_number_type_desc))'');
    populated_corp_fax_nbr_pcnt := AVE(GROUP,IF(h.corp_fax_nbr = (TYPEOF(h.corp_fax_nbr))'',0,100));
    maxlength_corp_fax_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_fax_nbr)));
    avelength_corp_fax_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_fax_nbr)),h.corp_fax_nbr<>(typeof(h.corp_fax_nbr))'');
    populated_corp_email_address_pcnt := AVE(GROUP,IF(h.corp_email_address = (TYPEOF(h.corp_email_address))'',0,100));
    maxlength_corp_email_address := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_email_address)));
    avelength_corp_email_address := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_email_address)),h.corp_email_address<>(typeof(h.corp_email_address))'');
    populated_corp_web_address_pcnt := AVE(GROUP,IF(h.corp_web_address = (TYPEOF(h.corp_web_address))'',0,100));
    maxlength_corp_web_address := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_web_address)));
    avelength_corp_web_address := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_web_address)),h.corp_web_address<>(typeof(h.corp_web_address))'');
    populated_cont_filing_reference_nbr_pcnt := AVE(GROUP,IF(h.cont_filing_reference_nbr = (TYPEOF(h.cont_filing_reference_nbr))'',0,100));
    maxlength_cont_filing_reference_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_filing_reference_nbr)));
    avelength_cont_filing_reference_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_filing_reference_nbr)),h.cont_filing_reference_nbr<>(typeof(h.cont_filing_reference_nbr))'');
    populated_cont_filing_date_pcnt := AVE(GROUP,IF(h.cont_filing_date = (TYPEOF(h.cont_filing_date))'',0,100));
    maxlength_cont_filing_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_filing_date)));
    avelength_cont_filing_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_filing_date)),h.cont_filing_date<>(typeof(h.cont_filing_date))'');
    populated_cont_filing_cd_pcnt := AVE(GROUP,IF(h.cont_filing_cd = (TYPEOF(h.cont_filing_cd))'',0,100));
    maxlength_cont_filing_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_filing_cd)));
    avelength_cont_filing_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_filing_cd)),h.cont_filing_cd<>(typeof(h.cont_filing_cd))'');
    populated_cont_filing_desc_pcnt := AVE(GROUP,IF(h.cont_filing_desc = (TYPEOF(h.cont_filing_desc))'',0,100));
    maxlength_cont_filing_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_filing_desc)));
    avelength_cont_filing_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_filing_desc)),h.cont_filing_desc<>(typeof(h.cont_filing_desc))'');
    populated_cont_type_cd_pcnt := AVE(GROUP,IF(h.cont_type_cd = (TYPEOF(h.cont_type_cd))'',0,100));
    maxlength_cont_type_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_type_cd)));
    avelength_cont_type_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_type_cd)),h.cont_type_cd<>(typeof(h.cont_type_cd))'');
    populated_cont_type_desc_pcnt := AVE(GROUP,IF(h.cont_type_desc = (TYPEOF(h.cont_type_desc))'',0,100));
    maxlength_cont_type_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_type_desc)));
    avelength_cont_type_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_type_desc)),h.cont_type_desc<>(typeof(h.cont_type_desc))'');
    populated_cont_name_pcnt := AVE(GROUP,IF(h.cont_name = (TYPEOF(h.cont_name))'',0,100));
    maxlength_cont_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_name)));
    avelength_cont_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_name)),h.cont_name<>(typeof(h.cont_name))'');
    populated_cont_title_desc_pcnt := AVE(GROUP,IF(h.cont_title_desc = (TYPEOF(h.cont_title_desc))'',0,100));
    maxlength_cont_title_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_title_desc)));
    avelength_cont_title_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_title_desc)),h.cont_title_desc<>(typeof(h.cont_title_desc))'');
    populated_cont_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.cont_sos_charter_nbr = (TYPEOF(h.cont_sos_charter_nbr))'',0,100));
    maxlength_cont_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_sos_charter_nbr)));
    avelength_cont_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_sos_charter_nbr)),h.cont_sos_charter_nbr<>(typeof(h.cont_sos_charter_nbr))'');
    populated_cont_fein_pcnt := AVE(GROUP,IF(h.cont_fein = (TYPEOF(h.cont_fein))'',0,100));
    maxlength_cont_fein := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_fein)));
    avelength_cont_fein := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_fein)),h.cont_fein<>(typeof(h.cont_fein))'');
    populated_cont_ssn_pcnt := AVE(GROUP,IF(h.cont_ssn = (TYPEOF(h.cont_ssn))'',0,100));
    maxlength_cont_ssn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_ssn)));
    avelength_cont_ssn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_ssn)),h.cont_ssn<>(typeof(h.cont_ssn))'');
    populated_cont_dob_pcnt := AVE(GROUP,IF(h.cont_dob = (TYPEOF(h.cont_dob))'',0,100));
    maxlength_cont_dob := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_dob)));
    avelength_cont_dob := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_dob)),h.cont_dob<>(typeof(h.cont_dob))'');
    populated_cont_status_cd_pcnt := AVE(GROUP,IF(h.cont_status_cd = (TYPEOF(h.cont_status_cd))'',0,100));
    maxlength_cont_status_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_status_cd)));
    avelength_cont_status_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_status_cd)),h.cont_status_cd<>(typeof(h.cont_status_cd))'');
    populated_cont_status_desc_pcnt := AVE(GROUP,IF(h.cont_status_desc = (TYPEOF(h.cont_status_desc))'',0,100));
    maxlength_cont_status_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_status_desc)));
    avelength_cont_status_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_status_desc)),h.cont_status_desc<>(typeof(h.cont_status_desc))'');
    populated_cont_effective_date_pcnt := AVE(GROUP,IF(h.cont_effective_date = (TYPEOF(h.cont_effective_date))'',0,100));
    maxlength_cont_effective_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_effective_date)));
    avelength_cont_effective_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_effective_date)),h.cont_effective_date<>(typeof(h.cont_effective_date))'');
    populated_cont_effective_cd_pcnt := AVE(GROUP,IF(h.cont_effective_cd = (TYPEOF(h.cont_effective_cd))'',0,100));
    maxlength_cont_effective_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_effective_cd)));
    avelength_cont_effective_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_effective_cd)),h.cont_effective_cd<>(typeof(h.cont_effective_cd))'');
    populated_cont_effective_desc_pcnt := AVE(GROUP,IF(h.cont_effective_desc = (TYPEOF(h.cont_effective_desc))'',0,100));
    maxlength_cont_effective_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_effective_desc)));
    avelength_cont_effective_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_effective_desc)),h.cont_effective_desc<>(typeof(h.cont_effective_desc))'');
    populated_cont_addl_info_pcnt := AVE(GROUP,IF(h.cont_addl_info = (TYPEOF(h.cont_addl_info))'',0,100));
    maxlength_cont_addl_info := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_addl_info)));
    avelength_cont_addl_info := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_addl_info)),h.cont_addl_info<>(typeof(h.cont_addl_info))'');
    populated_cont_address_type_cd_pcnt := AVE(GROUP,IF(h.cont_address_type_cd = (TYPEOF(h.cont_address_type_cd))'',0,100));
    maxlength_cont_address_type_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_type_cd)));
    avelength_cont_address_type_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_type_cd)),h.cont_address_type_cd<>(typeof(h.cont_address_type_cd))'');
    populated_cont_address_type_desc_pcnt := AVE(GROUP,IF(h.cont_address_type_desc = (TYPEOF(h.cont_address_type_desc))'',0,100));
    maxlength_cont_address_type_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_type_desc)));
    avelength_cont_address_type_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_type_desc)),h.cont_address_type_desc<>(typeof(h.cont_address_type_desc))'');
    populated_cont_address_line1_pcnt := AVE(GROUP,IF(h.cont_address_line1 = (TYPEOF(h.cont_address_line1))'',0,100));
    maxlength_cont_address_line1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line1)));
    avelength_cont_address_line1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line1)),h.cont_address_line1<>(typeof(h.cont_address_line1))'');
    populated_cont_address_line2_pcnt := AVE(GROUP,IF(h.cont_address_line2 = (TYPEOF(h.cont_address_line2))'',0,100));
    maxlength_cont_address_line2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line2)));
    avelength_cont_address_line2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line2)),h.cont_address_line2<>(typeof(h.cont_address_line2))'');
    populated_cont_address_line3_pcnt := AVE(GROUP,IF(h.cont_address_line3 = (TYPEOF(h.cont_address_line3))'',0,100));
    maxlength_cont_address_line3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line3)));
    avelength_cont_address_line3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line3)),h.cont_address_line3<>(typeof(h.cont_address_line3))'');
    populated_cont_address_line4_pcnt := AVE(GROUP,IF(h.cont_address_line4 = (TYPEOF(h.cont_address_line4))'',0,100));
    maxlength_cont_address_line4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line4)));
    avelength_cont_address_line4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line4)),h.cont_address_line4<>(typeof(h.cont_address_line4))'');
    populated_cont_address_line5_pcnt := AVE(GROUP,IF(h.cont_address_line5 = (TYPEOF(h.cont_address_line5))'',0,100));
    maxlength_cont_address_line5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line5)));
    avelength_cont_address_line5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line5)),h.cont_address_line5<>(typeof(h.cont_address_line5))'');
    populated_cont_address_line6_pcnt := AVE(GROUP,IF(h.cont_address_line6 = (TYPEOF(h.cont_address_line6))'',0,100));
    maxlength_cont_address_line6 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line6)));
    avelength_cont_address_line6 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_line6)),h.cont_address_line6<>(typeof(h.cont_address_line6))'');
    populated_cont_address_effective_date_pcnt := AVE(GROUP,IF(h.cont_address_effective_date = (TYPEOF(h.cont_address_effective_date))'',0,100));
    maxlength_cont_address_effective_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_effective_date)));
    avelength_cont_address_effective_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_effective_date)),h.cont_address_effective_date<>(typeof(h.cont_address_effective_date))'');
    populated_cont_address_county_pcnt := AVE(GROUP,IF(h.cont_address_county = (TYPEOF(h.cont_address_county))'',0,100));
    maxlength_cont_address_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_county)));
    avelength_cont_address_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_address_county)),h.cont_address_county<>(typeof(h.cont_address_county))'');
    populated_cont_phone_number_pcnt := AVE(GROUP,IF(h.cont_phone_number = (TYPEOF(h.cont_phone_number))'',0,100));
    maxlength_cont_phone_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_phone_number)));
    avelength_cont_phone_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_phone_number)),h.cont_phone_number<>(typeof(h.cont_phone_number))'');
    populated_cont_phone_number_type_cd_pcnt := AVE(GROUP,IF(h.cont_phone_number_type_cd = (TYPEOF(h.cont_phone_number_type_cd))'',0,100));
    maxlength_cont_phone_number_type_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_phone_number_type_cd)));
    avelength_cont_phone_number_type_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_phone_number_type_cd)),h.cont_phone_number_type_cd<>(typeof(h.cont_phone_number_type_cd))'');
    populated_cont_phone_number_type_desc_pcnt := AVE(GROUP,IF(h.cont_phone_number_type_desc = (TYPEOF(h.cont_phone_number_type_desc))'',0,100));
    maxlength_cont_phone_number_type_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_phone_number_type_desc)));
    avelength_cont_phone_number_type_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_phone_number_type_desc)),h.cont_phone_number_type_desc<>(typeof(h.cont_phone_number_type_desc))'');
    populated_cont_fax_nbr_pcnt := AVE(GROUP,IF(h.cont_fax_nbr = (TYPEOF(h.cont_fax_nbr))'',0,100));
    maxlength_cont_fax_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_fax_nbr)));
    avelength_cont_fax_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_fax_nbr)),h.cont_fax_nbr<>(typeof(h.cont_fax_nbr))'');
    populated_cont_email_address_pcnt := AVE(GROUP,IF(h.cont_email_address = (TYPEOF(h.cont_email_address))'',0,100));
    maxlength_cont_email_address := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_email_address)));
    avelength_cont_email_address := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_email_address)),h.cont_email_address<>(typeof(h.cont_email_address))'');
    populated_cont_web_address_pcnt := AVE(GROUP,IF(h.cont_web_address = (TYPEOF(h.cont_web_address))'',0,100));
    maxlength_cont_web_address := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_web_address)));
    avelength_cont_web_address := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_web_address)),h.cont_web_address<>(typeof(h.cont_web_address))'');
    populated_corp_addr1_prim_range_pcnt := AVE(GROUP,IF(h.corp_addr1_prim_range = (TYPEOF(h.corp_addr1_prim_range))'',0,100));
    maxlength_corp_addr1_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_prim_range)));
    avelength_corp_addr1_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_prim_range)),h.corp_addr1_prim_range<>(typeof(h.corp_addr1_prim_range))'');
    populated_corp_addr1_predir_pcnt := AVE(GROUP,IF(h.corp_addr1_predir = (TYPEOF(h.corp_addr1_predir))'',0,100));
    maxlength_corp_addr1_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_predir)));
    avelength_corp_addr1_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_predir)),h.corp_addr1_predir<>(typeof(h.corp_addr1_predir))'');
    populated_corp_addr1_prim_name_pcnt := AVE(GROUP,IF(h.corp_addr1_prim_name = (TYPEOF(h.corp_addr1_prim_name))'',0,100));
    maxlength_corp_addr1_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_prim_name)));
    avelength_corp_addr1_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_prim_name)),h.corp_addr1_prim_name<>(typeof(h.corp_addr1_prim_name))'');
    populated_corp_addr1_addr_suffix_pcnt := AVE(GROUP,IF(h.corp_addr1_addr_suffix = (TYPEOF(h.corp_addr1_addr_suffix))'',0,100));
    maxlength_corp_addr1_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_addr_suffix)));
    avelength_corp_addr1_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_addr_suffix)),h.corp_addr1_addr_suffix<>(typeof(h.corp_addr1_addr_suffix))'');
    populated_corp_addr1_postdir_pcnt := AVE(GROUP,IF(h.corp_addr1_postdir = (TYPEOF(h.corp_addr1_postdir))'',0,100));
    maxlength_corp_addr1_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_postdir)));
    avelength_corp_addr1_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_postdir)),h.corp_addr1_postdir<>(typeof(h.corp_addr1_postdir))'');
    populated_corp_addr1_unit_desig_pcnt := AVE(GROUP,IF(h.corp_addr1_unit_desig = (TYPEOF(h.corp_addr1_unit_desig))'',0,100));
    maxlength_corp_addr1_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_unit_desig)));
    avelength_corp_addr1_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_unit_desig)),h.corp_addr1_unit_desig<>(typeof(h.corp_addr1_unit_desig))'');
    populated_corp_addr1_sec_range_pcnt := AVE(GROUP,IF(h.corp_addr1_sec_range = (TYPEOF(h.corp_addr1_sec_range))'',0,100));
    maxlength_corp_addr1_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_sec_range)));
    avelength_corp_addr1_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_sec_range)),h.corp_addr1_sec_range<>(typeof(h.corp_addr1_sec_range))'');
    populated_corp_addr1_p_city_name_pcnt := AVE(GROUP,IF(h.corp_addr1_p_city_name = (TYPEOF(h.corp_addr1_p_city_name))'',0,100));
    maxlength_corp_addr1_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_p_city_name)));
    avelength_corp_addr1_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_p_city_name)),h.corp_addr1_p_city_name<>(typeof(h.corp_addr1_p_city_name))'');
    populated_corp_addr1_v_city_name_pcnt := AVE(GROUP,IF(h.corp_addr1_v_city_name = (TYPEOF(h.corp_addr1_v_city_name))'',0,100));
    maxlength_corp_addr1_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_v_city_name)));
    avelength_corp_addr1_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_v_city_name)),h.corp_addr1_v_city_name<>(typeof(h.corp_addr1_v_city_name))'');
    populated_corp_addr1_state_pcnt := AVE(GROUP,IF(h.corp_addr1_state = (TYPEOF(h.corp_addr1_state))'',0,100));
    maxlength_corp_addr1_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_state)));
    avelength_corp_addr1_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_state)),h.corp_addr1_state<>(typeof(h.corp_addr1_state))'');
    populated_corp_addr1_zip5_pcnt := AVE(GROUP,IF(h.corp_addr1_zip5 = (TYPEOF(h.corp_addr1_zip5))'',0,100));
    maxlength_corp_addr1_zip5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_zip5)));
    avelength_corp_addr1_zip5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_zip5)),h.corp_addr1_zip5<>(typeof(h.corp_addr1_zip5))'');
    populated_corp_addr1_zip4_pcnt := AVE(GROUP,IF(h.corp_addr1_zip4 = (TYPEOF(h.corp_addr1_zip4))'',0,100));
    maxlength_corp_addr1_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_zip4)));
    avelength_corp_addr1_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_zip4)),h.corp_addr1_zip4<>(typeof(h.corp_addr1_zip4))'');
    populated_corp_addr1_cart_pcnt := AVE(GROUP,IF(h.corp_addr1_cart = (TYPEOF(h.corp_addr1_cart))'',0,100));
    maxlength_corp_addr1_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_cart)));
    avelength_corp_addr1_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_cart)),h.corp_addr1_cart<>(typeof(h.corp_addr1_cart))'');
    populated_corp_addr1_cr_sort_sz_pcnt := AVE(GROUP,IF(h.corp_addr1_cr_sort_sz = (TYPEOF(h.corp_addr1_cr_sort_sz))'',0,100));
    maxlength_corp_addr1_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_cr_sort_sz)));
    avelength_corp_addr1_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_cr_sort_sz)),h.corp_addr1_cr_sort_sz<>(typeof(h.corp_addr1_cr_sort_sz))'');
    populated_corp_addr1_lot_pcnt := AVE(GROUP,IF(h.corp_addr1_lot = (TYPEOF(h.corp_addr1_lot))'',0,100));
    maxlength_corp_addr1_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_lot)));
    avelength_corp_addr1_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_lot)),h.corp_addr1_lot<>(typeof(h.corp_addr1_lot))'');
    populated_corp_addr1_lot_order_pcnt := AVE(GROUP,IF(h.corp_addr1_lot_order = (TYPEOF(h.corp_addr1_lot_order))'',0,100));
    maxlength_corp_addr1_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_lot_order)));
    avelength_corp_addr1_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_lot_order)),h.corp_addr1_lot_order<>(typeof(h.corp_addr1_lot_order))'');
    populated_corp_addr1_dpbc_pcnt := AVE(GROUP,IF(h.corp_addr1_dpbc = (TYPEOF(h.corp_addr1_dpbc))'',0,100));
    maxlength_corp_addr1_dpbc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_dpbc)));
    avelength_corp_addr1_dpbc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_dpbc)),h.corp_addr1_dpbc<>(typeof(h.corp_addr1_dpbc))'');
    populated_corp_addr1_chk_digit_pcnt := AVE(GROUP,IF(h.corp_addr1_chk_digit = (TYPEOF(h.corp_addr1_chk_digit))'',0,100));
    maxlength_corp_addr1_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_chk_digit)));
    avelength_corp_addr1_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_chk_digit)),h.corp_addr1_chk_digit<>(typeof(h.corp_addr1_chk_digit))'');
    populated_corp_addr1_rec_type_pcnt := AVE(GROUP,IF(h.corp_addr1_rec_type = (TYPEOF(h.corp_addr1_rec_type))'',0,100));
    maxlength_corp_addr1_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_rec_type)));
    avelength_corp_addr1_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_rec_type)),h.corp_addr1_rec_type<>(typeof(h.corp_addr1_rec_type))'');
    populated_corp_addr1_ace_fips_st_pcnt := AVE(GROUP,IF(h.corp_addr1_ace_fips_st = (TYPEOF(h.corp_addr1_ace_fips_st))'',0,100));
    maxlength_corp_addr1_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_ace_fips_st)));
    avelength_corp_addr1_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_ace_fips_st)),h.corp_addr1_ace_fips_st<>(typeof(h.corp_addr1_ace_fips_st))'');
    populated_corp_addr1_county_pcnt := AVE(GROUP,IF(h.corp_addr1_county = (TYPEOF(h.corp_addr1_county))'',0,100));
    maxlength_corp_addr1_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_county)));
    avelength_corp_addr1_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_county)),h.corp_addr1_county<>(typeof(h.corp_addr1_county))'');
    populated_corp_addr1_geo_lat_pcnt := AVE(GROUP,IF(h.corp_addr1_geo_lat = (TYPEOF(h.corp_addr1_geo_lat))'',0,100));
    maxlength_corp_addr1_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_geo_lat)));
    avelength_corp_addr1_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_geo_lat)),h.corp_addr1_geo_lat<>(typeof(h.corp_addr1_geo_lat))'');
    populated_corp_addr1_geo_long_pcnt := AVE(GROUP,IF(h.corp_addr1_geo_long = (TYPEOF(h.corp_addr1_geo_long))'',0,100));
    maxlength_corp_addr1_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_geo_long)));
    avelength_corp_addr1_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_geo_long)),h.corp_addr1_geo_long<>(typeof(h.corp_addr1_geo_long))'');
    populated_corp_addr1_msa_pcnt := AVE(GROUP,IF(h.corp_addr1_msa = (TYPEOF(h.corp_addr1_msa))'',0,100));
    maxlength_corp_addr1_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_msa)));
    avelength_corp_addr1_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_msa)),h.corp_addr1_msa<>(typeof(h.corp_addr1_msa))'');
    populated_corp_addr1_geo_blk_pcnt := AVE(GROUP,IF(h.corp_addr1_geo_blk = (TYPEOF(h.corp_addr1_geo_blk))'',0,100));
    maxlength_corp_addr1_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_geo_blk)));
    avelength_corp_addr1_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_geo_blk)),h.corp_addr1_geo_blk<>(typeof(h.corp_addr1_geo_blk))'');
    populated_corp_addr1_geo_match_pcnt := AVE(GROUP,IF(h.corp_addr1_geo_match = (TYPEOF(h.corp_addr1_geo_match))'',0,100));
    maxlength_corp_addr1_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_geo_match)));
    avelength_corp_addr1_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_geo_match)),h.corp_addr1_geo_match<>(typeof(h.corp_addr1_geo_match))'');
    populated_corp_addr1_err_stat_pcnt := AVE(GROUP,IF(h.corp_addr1_err_stat = (TYPEOF(h.corp_addr1_err_stat))'',0,100));
    maxlength_corp_addr1_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_err_stat)));
    avelength_corp_addr1_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr1_err_stat)),h.corp_addr1_err_stat<>(typeof(h.corp_addr1_err_stat))'');
    populated_cont_title_pcnt := AVE(GROUP,IF(h.cont_title = (TYPEOF(h.cont_title))'',0,100));
    maxlength_cont_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_title)));
    avelength_cont_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_title)),h.cont_title<>(typeof(h.cont_title))'');
    populated_cont_fname_pcnt := AVE(GROUP,IF(h.cont_fname = (TYPEOF(h.cont_fname))'',0,100));
    maxlength_cont_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_fname)));
    avelength_cont_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_fname)),h.cont_fname<>(typeof(h.cont_fname))'');
    populated_cont_mname_pcnt := AVE(GROUP,IF(h.cont_mname = (TYPEOF(h.cont_mname))'',0,100));
    maxlength_cont_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_mname)));
    avelength_cont_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_mname)),h.cont_mname<>(typeof(h.cont_mname))'');
    populated_cont_lname_pcnt := AVE(GROUP,IF(h.cont_lname = (TYPEOF(h.cont_lname))'',0,100));
    maxlength_cont_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_lname)));
    avelength_cont_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_lname)),h.cont_lname<>(typeof(h.cont_lname))'');
    populated_cont_name_suffix_pcnt := AVE(GROUP,IF(h.cont_name_suffix = (TYPEOF(h.cont_name_suffix))'',0,100));
    maxlength_cont_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_name_suffix)));
    avelength_cont_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_name_suffix)),h.cont_name_suffix<>(typeof(h.cont_name_suffix))'');
    populated_cont_score_pcnt := AVE(GROUP,IF(h.cont_score = (TYPEOF(h.cont_score))'',0,100));
    maxlength_cont_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_score)));
    avelength_cont_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_score)),h.cont_score<>(typeof(h.cont_score))'');
    populated_cont_cname_pcnt := AVE(GROUP,IF(h.cont_cname = (TYPEOF(h.cont_cname))'',0,100));
    maxlength_cont_cname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_cname)));
    avelength_cont_cname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_cname)),h.cont_cname<>(typeof(h.cont_cname))'');
    populated_cont_cname_score_pcnt := AVE(GROUP,IF(h.cont_cname_score = (TYPEOF(h.cont_cname_score))'',0,100));
    maxlength_cont_cname_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_cname_score)));
    avelength_cont_cname_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_cname_score)),h.cont_cname_score<>(typeof(h.cont_cname_score))'');
    populated_cont_prim_range_pcnt := AVE(GROUP,IF(h.cont_prim_range = (TYPEOF(h.cont_prim_range))'',0,100));
    maxlength_cont_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_prim_range)));
    avelength_cont_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_prim_range)),h.cont_prim_range<>(typeof(h.cont_prim_range))'');
    populated_cont_predir_pcnt := AVE(GROUP,IF(h.cont_predir = (TYPEOF(h.cont_predir))'',0,100));
    maxlength_cont_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_predir)));
    avelength_cont_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_predir)),h.cont_predir<>(typeof(h.cont_predir))'');
    populated_cont_prim_name_pcnt := AVE(GROUP,IF(h.cont_prim_name = (TYPEOF(h.cont_prim_name))'',0,100));
    maxlength_cont_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_prim_name)));
    avelength_cont_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_prim_name)),h.cont_prim_name<>(typeof(h.cont_prim_name))'');
    populated_cont_addr_suffix_pcnt := AVE(GROUP,IF(h.cont_addr_suffix = (TYPEOF(h.cont_addr_suffix))'',0,100));
    maxlength_cont_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_addr_suffix)));
    avelength_cont_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_addr_suffix)),h.cont_addr_suffix<>(typeof(h.cont_addr_suffix))'');
    populated_cont_postdir_pcnt := AVE(GROUP,IF(h.cont_postdir = (TYPEOF(h.cont_postdir))'',0,100));
    maxlength_cont_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_postdir)));
    avelength_cont_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_postdir)),h.cont_postdir<>(typeof(h.cont_postdir))'');
    populated_cont_unit_desig_pcnt := AVE(GROUP,IF(h.cont_unit_desig = (TYPEOF(h.cont_unit_desig))'',0,100));
    maxlength_cont_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_unit_desig)));
    avelength_cont_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_unit_desig)),h.cont_unit_desig<>(typeof(h.cont_unit_desig))'');
    populated_cont_sec_range_pcnt := AVE(GROUP,IF(h.cont_sec_range = (TYPEOF(h.cont_sec_range))'',0,100));
    maxlength_cont_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_sec_range)));
    avelength_cont_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_sec_range)),h.cont_sec_range<>(typeof(h.cont_sec_range))'');
    populated_cont_p_city_name_pcnt := AVE(GROUP,IF(h.cont_p_city_name = (TYPEOF(h.cont_p_city_name))'',0,100));
    maxlength_cont_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_p_city_name)));
    avelength_cont_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_p_city_name)),h.cont_p_city_name<>(typeof(h.cont_p_city_name))'');
    populated_cont_v_city_name_pcnt := AVE(GROUP,IF(h.cont_v_city_name = (TYPEOF(h.cont_v_city_name))'',0,100));
    maxlength_cont_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_v_city_name)));
    avelength_cont_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_v_city_name)),h.cont_v_city_name<>(typeof(h.cont_v_city_name))'');
    populated_cont_state_pcnt := AVE(GROUP,IF(h.cont_state = (TYPEOF(h.cont_state))'',0,100));
    maxlength_cont_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_state)));
    avelength_cont_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_state)),h.cont_state<>(typeof(h.cont_state))'');
    populated_cont_zip5_pcnt := AVE(GROUP,IF(h.cont_zip5 = (TYPEOF(h.cont_zip5))'',0,100));
    maxlength_cont_zip5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_zip5)));
    avelength_cont_zip5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_zip5)),h.cont_zip5<>(typeof(h.cont_zip5))'');
    populated_cont_zip4_pcnt := AVE(GROUP,IF(h.cont_zip4 = (TYPEOF(h.cont_zip4))'',0,100));
    maxlength_cont_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_zip4)));
    avelength_cont_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_zip4)),h.cont_zip4<>(typeof(h.cont_zip4))'');
    populated_cont_cart_pcnt := AVE(GROUP,IF(h.cont_cart = (TYPEOF(h.cont_cart))'',0,100));
    maxlength_cont_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_cart)));
    avelength_cont_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_cart)),h.cont_cart<>(typeof(h.cont_cart))'');
    populated_cont_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cont_cr_sort_sz = (TYPEOF(h.cont_cr_sort_sz))'',0,100));
    maxlength_cont_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_cr_sort_sz)));
    avelength_cont_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_cr_sort_sz)),h.cont_cr_sort_sz<>(typeof(h.cont_cr_sort_sz))'');
    populated_cont_lot_pcnt := AVE(GROUP,IF(h.cont_lot = (TYPEOF(h.cont_lot))'',0,100));
    maxlength_cont_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_lot)));
    avelength_cont_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_lot)),h.cont_lot<>(typeof(h.cont_lot))'');
    populated_cont_lot_order_pcnt := AVE(GROUP,IF(h.cont_lot_order = (TYPEOF(h.cont_lot_order))'',0,100));
    maxlength_cont_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_lot_order)));
    avelength_cont_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_lot_order)),h.cont_lot_order<>(typeof(h.cont_lot_order))'');
    populated_cont_dpbc_pcnt := AVE(GROUP,IF(h.cont_dpbc = (TYPEOF(h.cont_dpbc))'',0,100));
    maxlength_cont_dpbc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_dpbc)));
    avelength_cont_dpbc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_dpbc)),h.cont_dpbc<>(typeof(h.cont_dpbc))'');
    populated_cont_chk_digit_pcnt := AVE(GROUP,IF(h.cont_chk_digit = (TYPEOF(h.cont_chk_digit))'',0,100));
    maxlength_cont_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_chk_digit)));
    avelength_cont_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_chk_digit)),h.cont_chk_digit<>(typeof(h.cont_chk_digit))'');
    populated_cont_rec_type_pcnt := AVE(GROUP,IF(h.cont_rec_type = (TYPEOF(h.cont_rec_type))'',0,100));
    maxlength_cont_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_rec_type)));
    avelength_cont_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_rec_type)),h.cont_rec_type<>(typeof(h.cont_rec_type))'');
    populated_cont_ace_fips_st_pcnt := AVE(GROUP,IF(h.cont_ace_fips_st = (TYPEOF(h.cont_ace_fips_st))'',0,100));
    maxlength_cont_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_ace_fips_st)));
    avelength_cont_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_ace_fips_st)),h.cont_ace_fips_st<>(typeof(h.cont_ace_fips_st))'');
    populated_cont_county_pcnt := AVE(GROUP,IF(h.cont_county = (TYPEOF(h.cont_county))'',0,100));
    maxlength_cont_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_county)));
    avelength_cont_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_county)),h.cont_county<>(typeof(h.cont_county))'');
    populated_cont_geo_lat_pcnt := AVE(GROUP,IF(h.cont_geo_lat = (TYPEOF(h.cont_geo_lat))'',0,100));
    maxlength_cont_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_geo_lat)));
    avelength_cont_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_geo_lat)),h.cont_geo_lat<>(typeof(h.cont_geo_lat))'');
    populated_cont_geo_long_pcnt := AVE(GROUP,IF(h.cont_geo_long = (TYPEOF(h.cont_geo_long))'',0,100));
    maxlength_cont_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_geo_long)));
    avelength_cont_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_geo_long)),h.cont_geo_long<>(typeof(h.cont_geo_long))'');
    populated_cont_msa_pcnt := AVE(GROUP,IF(h.cont_msa = (TYPEOF(h.cont_msa))'',0,100));
    maxlength_cont_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_msa)));
    avelength_cont_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_msa)),h.cont_msa<>(typeof(h.cont_msa))'');
    populated_cont_geo_blk_pcnt := AVE(GROUP,IF(h.cont_geo_blk = (TYPEOF(h.cont_geo_blk))'',0,100));
    maxlength_cont_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_geo_blk)));
    avelength_cont_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_geo_blk)),h.cont_geo_blk<>(typeof(h.cont_geo_blk))'');
    populated_cont_geo_match_pcnt := AVE(GROUP,IF(h.cont_geo_match = (TYPEOF(h.cont_geo_match))'',0,100));
    maxlength_cont_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_geo_match)));
    avelength_cont_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_geo_match)),h.cont_geo_match<>(typeof(h.cont_geo_match))'');
    populated_cont_err_stat_pcnt := AVE(GROUP,IF(h.cont_err_stat = (TYPEOF(h.cont_err_stat))'',0,100));
    maxlength_cont_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_err_stat)));
    avelength_cont_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_err_stat)),h.cont_err_stat<>(typeof(h.cont_err_stat))'');
    populated_corp_phone10_pcnt := AVE(GROUP,IF(h.corp_phone10 = (TYPEOF(h.corp_phone10))'',0,100));
    maxlength_corp_phone10 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_phone10)));
    avelength_corp_phone10 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_phone10)),h.corp_phone10<>(typeof(h.corp_phone10))'');
    populated_cont_phone10_pcnt := AVE(GROUP,IF(h.cont_phone10 = (TYPEOF(h.cont_phone10))'',0,100));
    maxlength_cont_phone10 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_phone10)));
    avelength_cont_phone10 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_phone10)),h.cont_phone10<>(typeof(h.cont_phone10))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_append_corp_addr_rawaid_pcnt := AVE(GROUP,IF(h.append_corp_addr_rawaid = (TYPEOF(h.append_corp_addr_rawaid))'',0,100));
    maxlength_append_corp_addr_rawaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_corp_addr_rawaid)));
    avelength_append_corp_addr_rawaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_corp_addr_rawaid)),h.append_corp_addr_rawaid<>(typeof(h.append_corp_addr_rawaid))'');
    populated_append_corp_addr_aceaid_pcnt := AVE(GROUP,IF(h.append_corp_addr_aceaid = (TYPEOF(h.append_corp_addr_aceaid))'',0,100));
    maxlength_append_corp_addr_aceaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_corp_addr_aceaid)));
    avelength_append_corp_addr_aceaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_corp_addr_aceaid)),h.append_corp_addr_aceaid<>(typeof(h.append_corp_addr_aceaid))'');
    populated_corp_prep_addr_line1_pcnt := AVE(GROUP,IF(h.corp_prep_addr_line1 = (TYPEOF(h.corp_prep_addr_line1))'',0,100));
    maxlength_corp_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr_line1)));
    avelength_corp_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr_line1)),h.corp_prep_addr_line1<>(typeof(h.corp_prep_addr_line1))'');
    populated_corp_prep_addr_last_line_pcnt := AVE(GROUP,IF(h.corp_prep_addr_last_line = (TYPEOF(h.corp_prep_addr_last_line))'',0,100));
    maxlength_corp_prep_addr_last_line := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr_last_line)));
    avelength_corp_prep_addr_last_line := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr_last_line)),h.corp_prep_addr_last_line<>(typeof(h.corp_prep_addr_last_line))'');
    populated_append_cont_addr_rawaid_pcnt := AVE(GROUP,IF(h.append_cont_addr_rawaid = (TYPEOF(h.append_cont_addr_rawaid))'',0,100));
    maxlength_append_cont_addr_rawaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_cont_addr_rawaid)));
    avelength_append_cont_addr_rawaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_cont_addr_rawaid)),h.append_cont_addr_rawaid<>(typeof(h.append_cont_addr_rawaid))'');
    populated_append_cont_addr_aceaid_pcnt := AVE(GROUP,IF(h.append_cont_addr_aceaid = (TYPEOF(h.append_cont_addr_aceaid))'',0,100));
    maxlength_append_cont_addr_aceaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_cont_addr_aceaid)));
    avelength_append_cont_addr_aceaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_cont_addr_aceaid)),h.append_cont_addr_aceaid<>(typeof(h.append_cont_addr_aceaid))'');
    populated_cont_prep_addr_line1_pcnt := AVE(GROUP,IF(h.cont_prep_addr_line1 = (TYPEOF(h.cont_prep_addr_line1))'',0,100));
    maxlength_cont_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_prep_addr_line1)));
    avelength_cont_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_prep_addr_line1)),h.cont_prep_addr_line1<>(typeof(h.cont_prep_addr_line1))'');
    populated_cont_prep_addr_last_line_pcnt := AVE(GROUP,IF(h.cont_prep_addr_last_line = (TYPEOF(h.cont_prep_addr_last_line))'',0,100));
    maxlength_cont_prep_addr_last_line := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_prep_addr_last_line)));
    avelength_cont_prep_addr_last_line := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cont_prep_addr_last_line)),h.cont_prep_addr_last_line<>(typeof(h.cont_prep_addr_last_line))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_supp_key_pcnt *   0.00 / 100 + T.Populated_corp_vendor_pcnt *   0.00 / 100 + T.Populated_corp_vendor_county_pcnt *   0.00 / 100 + T.Populated_corp_vendor_subcode_pcnt *   0.00 / 100 + T.Populated_corp_state_origin_pcnt *   0.00 / 100 + T.Populated_corp_process_date_pcnt *   0.00 / 100 + T.Populated_corp_orig_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_corp_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_corp_legal_name_pcnt *   0.00 / 100 + T.Populated_corp_address1_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_address1_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_address1_line1_pcnt *   0.00 / 100 + T.Populated_corp_address1_line2_pcnt *   0.00 / 100 + T.Populated_corp_address1_line3_pcnt *   0.00 / 100 + T.Populated_corp_address1_line4_pcnt *   0.00 / 100 + T.Populated_corp_address1_line5_pcnt *   0.00 / 100 + T.Populated_corp_address1_line6_pcnt *   0.00 / 100 + T.Populated_corp_address1_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_phone_number_pcnt *   0.00 / 100 + T.Populated_corp_phone_number_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_phone_number_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_fax_nbr_pcnt *   0.00 / 100 + T.Populated_corp_email_address_pcnt *   0.00 / 100 + T.Populated_corp_web_address_pcnt *   0.00 / 100 + T.Populated_cont_filing_reference_nbr_pcnt *   0.00 / 100 + T.Populated_cont_filing_date_pcnt *   0.00 / 100 + T.Populated_cont_filing_cd_pcnt *   0.00 / 100 + T.Populated_cont_filing_desc_pcnt *   0.00 / 100 + T.Populated_cont_type_cd_pcnt *   0.00 / 100 + T.Populated_cont_type_desc_pcnt *   0.00 / 100 + T.Populated_cont_name_pcnt *   0.00 / 100 + T.Populated_cont_title_desc_pcnt *   0.00 / 100 + T.Populated_cont_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_cont_fein_pcnt *   0.00 / 100 + T.Populated_cont_ssn_pcnt *   0.00 / 100 + T.Populated_cont_dob_pcnt *   0.00 / 100 + T.Populated_cont_status_cd_pcnt *   0.00 / 100 + T.Populated_cont_status_desc_pcnt *   0.00 / 100 + T.Populated_cont_effective_date_pcnt *   0.00 / 100 + T.Populated_cont_effective_cd_pcnt *   0.00 / 100 + T.Populated_cont_effective_desc_pcnt *   0.00 / 100 + T.Populated_cont_addl_info_pcnt *   0.00 / 100 + T.Populated_cont_address_type_cd_pcnt *   0.00 / 100 + T.Populated_cont_address_type_desc_pcnt *   0.00 / 100 + T.Populated_cont_address_line1_pcnt *   0.00 / 100 + T.Populated_cont_address_line2_pcnt *   0.00 / 100 + T.Populated_cont_address_line3_pcnt *   0.00 / 100 + T.Populated_cont_address_line4_pcnt *   0.00 / 100 + T.Populated_cont_address_line5_pcnt *   0.00 / 100 + T.Populated_cont_address_line6_pcnt *   0.00 / 100 + T.Populated_cont_address_effective_date_pcnt *   0.00 / 100 + T.Populated_cont_address_county_pcnt *   0.00 / 100 + T.Populated_cont_phone_number_pcnt *   0.00 / 100 + T.Populated_cont_phone_number_type_cd_pcnt *   0.00 / 100 + T.Populated_cont_phone_number_type_desc_pcnt *   0.00 / 100 + T.Populated_cont_fax_nbr_pcnt *   0.00 / 100 + T.Populated_cont_email_address_pcnt *   0.00 / 100 + T.Populated_cont_web_address_pcnt *   0.00 / 100 + T.Populated_corp_addr1_prim_range_pcnt *   0.00 / 100 + T.Populated_corp_addr1_predir_pcnt *   0.00 / 100 + T.Populated_corp_addr1_prim_name_pcnt *   0.00 / 100 + T.Populated_corp_addr1_addr_suffix_pcnt *   0.00 / 100 + T.Populated_corp_addr1_postdir_pcnt *   0.00 / 100 + T.Populated_corp_addr1_unit_desig_pcnt *   0.00 / 100 + T.Populated_corp_addr1_sec_range_pcnt *   0.00 / 100 + T.Populated_corp_addr1_p_city_name_pcnt *   0.00 / 100 + T.Populated_corp_addr1_v_city_name_pcnt *   0.00 / 100 + T.Populated_corp_addr1_state_pcnt *   0.00 / 100 + T.Populated_corp_addr1_zip5_pcnt *   0.00 / 100 + T.Populated_corp_addr1_zip4_pcnt *   0.00 / 100 + T.Populated_corp_addr1_cart_pcnt *   0.00 / 100 + T.Populated_corp_addr1_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_corp_addr1_lot_pcnt *   0.00 / 100 + T.Populated_corp_addr1_lot_order_pcnt *   0.00 / 100 + T.Populated_corp_addr1_dpbc_pcnt *   0.00 / 100 + T.Populated_corp_addr1_chk_digit_pcnt *   0.00 / 100 + T.Populated_corp_addr1_rec_type_pcnt *   0.00 / 100 + T.Populated_corp_addr1_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_corp_addr1_county_pcnt *   0.00 / 100 + T.Populated_corp_addr1_geo_lat_pcnt *   0.00 / 100 + T.Populated_corp_addr1_geo_long_pcnt *   0.00 / 100 + T.Populated_corp_addr1_msa_pcnt *   0.00 / 100 + T.Populated_corp_addr1_geo_blk_pcnt *   0.00 / 100 + T.Populated_corp_addr1_geo_match_pcnt *   0.00 / 100 + T.Populated_corp_addr1_err_stat_pcnt *   0.00 / 100 + T.Populated_cont_title_pcnt *   0.00 / 100 + T.Populated_cont_fname_pcnt *   0.00 / 100 + T.Populated_cont_mname_pcnt *   0.00 / 100 + T.Populated_cont_lname_pcnt *   0.00 / 100 + T.Populated_cont_name_suffix_pcnt *   0.00 / 100 + T.Populated_cont_score_pcnt *   0.00 / 100 + T.Populated_cont_cname_pcnt *   0.00 / 100 + T.Populated_cont_cname_score_pcnt *   0.00 / 100 + T.Populated_cont_prim_range_pcnt *   0.00 / 100 + T.Populated_cont_predir_pcnt *   0.00 / 100 + T.Populated_cont_prim_name_pcnt *   0.00 / 100 + T.Populated_cont_addr_suffix_pcnt *   0.00 / 100 + T.Populated_cont_postdir_pcnt *   0.00 / 100 + T.Populated_cont_unit_desig_pcnt *   0.00 / 100 + T.Populated_cont_sec_range_pcnt *   0.00 / 100 + T.Populated_cont_p_city_name_pcnt *   0.00 / 100 + T.Populated_cont_v_city_name_pcnt *   0.00 / 100 + T.Populated_cont_state_pcnt *   0.00 / 100 + T.Populated_cont_zip5_pcnt *   0.00 / 100 + T.Populated_cont_zip4_pcnt *   0.00 / 100 + T.Populated_cont_cart_pcnt *   0.00 / 100 + T.Populated_cont_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_cont_lot_pcnt *   0.00 / 100 + T.Populated_cont_lot_order_pcnt *   0.00 / 100 + T.Populated_cont_dpbc_pcnt *   0.00 / 100 + T.Populated_cont_chk_digit_pcnt *   0.00 / 100 + T.Populated_cont_rec_type_pcnt *   0.00 / 100 + T.Populated_cont_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_cont_county_pcnt *   0.00 / 100 + T.Populated_cont_geo_lat_pcnt *   0.00 / 100 + T.Populated_cont_geo_long_pcnt *   0.00 / 100 + T.Populated_cont_msa_pcnt *   0.00 / 100 + T.Populated_cont_geo_blk_pcnt *   0.00 / 100 + T.Populated_cont_geo_match_pcnt *   0.00 / 100 + T.Populated_cont_err_stat_pcnt *   0.00 / 100 + T.Populated_corp_phone10_pcnt *   0.00 / 100 + T.Populated_cont_phone10_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_append_corp_addr_rawaid_pcnt *   0.00 / 100 + T.Populated_append_corp_addr_aceaid_pcnt *   0.00 / 100 + T.Populated_corp_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_corp_prep_addr_last_line_pcnt *   0.00 / 100 + T.Populated_append_cont_addr_rawaid_pcnt *   0.00 / 100 + T.Populated_append_cont_addr_aceaid_pcnt *   0.00 / 100 + T.Populated_cont_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_cont_prep_addr_last_line_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
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
  SELF.FieldName := CHOOSE(C,'bdid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_sos_charter_nbr','corp_legal_name','corp_address1_type_cd','corp_address1_type_desc','corp_address1_line1','corp_address1_line2','corp_address1_line3','corp_address1_line4','corp_address1_line5','corp_address1_line6','corp_address1_effective_date','corp_phone_number','corp_phone_number_type_cd','corp_phone_number_type_desc','corp_fax_nbr','corp_email_address','corp_web_address','cont_filing_reference_nbr','cont_filing_date','cont_filing_cd','cont_filing_desc','cont_type_cd','cont_type_desc','cont_name','cont_title_desc','cont_sos_charter_nbr','cont_fein','cont_ssn','cont_dob','cont_status_cd','cont_status_desc','cont_effective_date','cont_effective_cd','cont_effective_desc','cont_addl_info','cont_address_type_cd','cont_address_type_desc','cont_address_line1','cont_address_line2','cont_address_line3','cont_address_line4','cont_address_line5','cont_address_line6','cont_address_effective_date','cont_address_county','cont_phone_number','cont_phone_number_type_cd','cont_phone_number_type_desc','cont_fax_nbr','cont_email_address','cont_web_address','corp_addr1_prim_range','corp_addr1_predir','corp_addr1_prim_name','corp_addr1_addr_suffix','corp_addr1_postdir','corp_addr1_unit_desig','corp_addr1_sec_range','corp_addr1_p_city_name','corp_addr1_v_city_name','corp_addr1_state','corp_addr1_zip5','corp_addr1_zip4','corp_addr1_cart','corp_addr1_cr_sort_sz','corp_addr1_lot','corp_addr1_lot_order','corp_addr1_dpbc','corp_addr1_chk_digit','corp_addr1_rec_type','corp_addr1_ace_fips_st','corp_addr1_county','corp_addr1_geo_lat','corp_addr1_geo_long','corp_addr1_msa','corp_addr1_geo_blk','corp_addr1_geo_match','corp_addr1_err_stat','cont_title','cont_fname','cont_mname','cont_lname','cont_name_suffix','cont_score','cont_cname','cont_cname_score','cont_prim_range','cont_predir','cont_prim_name','cont_addr_suffix','cont_postdir','cont_unit_desig','cont_sec_range','cont_p_city_name','cont_v_city_name','cont_state','cont_zip5','cont_zip4','cont_cart','cont_cr_sort_sz','cont_lot','cont_lot_order','cont_dpbc','cont_chk_digit','cont_rec_type','cont_ace_fips_st','cont_county','cont_geo_lat','cont_geo_long','cont_msa','cont_geo_blk','cont_geo_match','cont_err_stat','corp_phone10','cont_phone10','record_type','append_corp_addr_rawaid','append_corp_addr_aceaid','corp_prep_addr_line1','corp_prep_addr_last_line','append_cont_addr_rawaid','append_cont_addr_aceaid','cont_prep_addr_line1','cont_prep_addr_last_line','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  SELF.populated_pcnt := CHOOSE(C,le.populated_bdid_pcnt,le.populated_did_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_corp_key_pcnt,le.populated_corp_supp_key_pcnt,le.populated_corp_vendor_pcnt,le.populated_corp_vendor_county_pcnt,le.populated_corp_vendor_subcode_pcnt,le.populated_corp_state_origin_pcnt,le.populated_corp_process_date_pcnt,le.populated_corp_orig_sos_charter_nbr_pcnt,le.populated_corp_sos_charter_nbr_pcnt,le.populated_corp_legal_name_pcnt,le.populated_corp_address1_type_cd_pcnt,le.populated_corp_address1_type_desc_pcnt,le.populated_corp_address1_line1_pcnt,le.populated_corp_address1_line2_pcnt,le.populated_corp_address1_line3_pcnt,le.populated_corp_address1_line4_pcnt,le.populated_corp_address1_line5_pcnt,le.populated_corp_address1_line6_pcnt,le.populated_corp_address1_effective_date_pcnt,le.populated_corp_phone_number_pcnt,le.populated_corp_phone_number_type_cd_pcnt,le.populated_corp_phone_number_type_desc_pcnt,le.populated_corp_fax_nbr_pcnt,le.populated_corp_email_address_pcnt,le.populated_corp_web_address_pcnt,le.populated_cont_filing_reference_nbr_pcnt,le.populated_cont_filing_date_pcnt,le.populated_cont_filing_cd_pcnt,le.populated_cont_filing_desc_pcnt,le.populated_cont_type_cd_pcnt,le.populated_cont_type_desc_pcnt,le.populated_cont_name_pcnt,le.populated_cont_title_desc_pcnt,le.populated_cont_sos_charter_nbr_pcnt,le.populated_cont_fein_pcnt,le.populated_cont_ssn_pcnt,le.populated_cont_dob_pcnt,le.populated_cont_status_cd_pcnt,le.populated_cont_status_desc_pcnt,le.populated_cont_effective_date_pcnt,le.populated_cont_effective_cd_pcnt,le.populated_cont_effective_desc_pcnt,le.populated_cont_addl_info_pcnt,le.populated_cont_address_type_cd_pcnt,le.populated_cont_address_type_desc_pcnt,le.populated_cont_address_line1_pcnt,le.populated_cont_address_line2_pcnt,le.populated_cont_address_line3_pcnt,le.populated_cont_address_line4_pcnt,le.populated_cont_address_line5_pcnt,le.populated_cont_address_line6_pcnt,le.populated_cont_address_effective_date_pcnt,le.populated_cont_address_county_pcnt,le.populated_cont_phone_number_pcnt,le.populated_cont_phone_number_type_cd_pcnt,le.populated_cont_phone_number_type_desc_pcnt,le.populated_cont_fax_nbr_pcnt,le.populated_cont_email_address_pcnt,le.populated_cont_web_address_pcnt,le.populated_corp_addr1_prim_range_pcnt,le.populated_corp_addr1_predir_pcnt,le.populated_corp_addr1_prim_name_pcnt,le.populated_corp_addr1_addr_suffix_pcnt,le.populated_corp_addr1_postdir_pcnt,le.populated_corp_addr1_unit_desig_pcnt,le.populated_corp_addr1_sec_range_pcnt,le.populated_corp_addr1_p_city_name_pcnt,le.populated_corp_addr1_v_city_name_pcnt,le.populated_corp_addr1_state_pcnt,le.populated_corp_addr1_zip5_pcnt,le.populated_corp_addr1_zip4_pcnt,le.populated_corp_addr1_cart_pcnt,le.populated_corp_addr1_cr_sort_sz_pcnt,le.populated_corp_addr1_lot_pcnt,le.populated_corp_addr1_lot_order_pcnt,le.populated_corp_addr1_dpbc_pcnt,le.populated_corp_addr1_chk_digit_pcnt,le.populated_corp_addr1_rec_type_pcnt,le.populated_corp_addr1_ace_fips_st_pcnt,le.populated_corp_addr1_county_pcnt,le.populated_corp_addr1_geo_lat_pcnt,le.populated_corp_addr1_geo_long_pcnt,le.populated_corp_addr1_msa_pcnt,le.populated_corp_addr1_geo_blk_pcnt,le.populated_corp_addr1_geo_match_pcnt,le.populated_corp_addr1_err_stat_pcnt,le.populated_cont_title_pcnt,le.populated_cont_fname_pcnt,le.populated_cont_mname_pcnt,le.populated_cont_lname_pcnt,le.populated_cont_name_suffix_pcnt,le.populated_cont_score_pcnt,le.populated_cont_cname_pcnt,le.populated_cont_cname_score_pcnt,le.populated_cont_prim_range_pcnt,le.populated_cont_predir_pcnt,le.populated_cont_prim_name_pcnt,le.populated_cont_addr_suffix_pcnt,le.populated_cont_postdir_pcnt,le.populated_cont_unit_desig_pcnt,le.populated_cont_sec_range_pcnt,le.populated_cont_p_city_name_pcnt,le.populated_cont_v_city_name_pcnt,le.populated_cont_state_pcnt,le.populated_cont_zip5_pcnt,le.populated_cont_zip4_pcnt,le.populated_cont_cart_pcnt,le.populated_cont_cr_sort_sz_pcnt,le.populated_cont_lot_pcnt,le.populated_cont_lot_order_pcnt,le.populated_cont_dpbc_pcnt,le.populated_cont_chk_digit_pcnt,le.populated_cont_rec_type_pcnt,le.populated_cont_ace_fips_st_pcnt,le.populated_cont_county_pcnt,le.populated_cont_geo_lat_pcnt,le.populated_cont_geo_long_pcnt,le.populated_cont_msa_pcnt,le.populated_cont_geo_blk_pcnt,le.populated_cont_geo_match_pcnt,le.populated_cont_err_stat_pcnt,le.populated_corp_phone10_pcnt,le.populated_cont_phone10_pcnt,le.populated_record_type_pcnt,le.populated_append_corp_addr_rawaid_pcnt,le.populated_append_corp_addr_aceaid_pcnt,le.populated_corp_prep_addr_line1_pcnt,le.populated_corp_prep_addr_last_line_pcnt,le.populated_append_cont_addr_rawaid_pcnt,le.populated_append_cont_addr_aceaid_pcnt,le.populated_cont_prep_addr_line1_pcnt,le.populated_cont_prep_addr_last_line_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_bdid,le.maxlength_did,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_corp_key,le.maxlength_corp_supp_key,le.maxlength_corp_vendor,le.maxlength_corp_vendor_county,le.maxlength_corp_vendor_subcode,le.maxlength_corp_state_origin,le.maxlength_corp_process_date,le.maxlength_corp_orig_sos_charter_nbr,le.maxlength_corp_sos_charter_nbr,le.maxlength_corp_legal_name,le.maxlength_corp_address1_type_cd,le.maxlength_corp_address1_type_desc,le.maxlength_corp_address1_line1,le.maxlength_corp_address1_line2,le.maxlength_corp_address1_line3,le.maxlength_corp_address1_line4,le.maxlength_corp_address1_line5,le.maxlength_corp_address1_line6,le.maxlength_corp_address1_effective_date,le.maxlength_corp_phone_number,le.maxlength_corp_phone_number_type_cd,le.maxlength_corp_phone_number_type_desc,le.maxlength_corp_fax_nbr,le.maxlength_corp_email_address,le.maxlength_corp_web_address,le.maxlength_cont_filing_reference_nbr,le.maxlength_cont_filing_date,le.maxlength_cont_filing_cd,le.maxlength_cont_filing_desc,le.maxlength_cont_type_cd,le.maxlength_cont_type_desc,le.maxlength_cont_name,le.maxlength_cont_title_desc,le.maxlength_cont_sos_charter_nbr,le.maxlength_cont_fein,le.maxlength_cont_ssn,le.maxlength_cont_dob,le.maxlength_cont_status_cd,le.maxlength_cont_status_desc,le.maxlength_cont_effective_date,le.maxlength_cont_effective_cd,le.maxlength_cont_effective_desc,le.maxlength_cont_addl_info,le.maxlength_cont_address_type_cd,le.maxlength_cont_address_type_desc,le.maxlength_cont_address_line1,le.maxlength_cont_address_line2,le.maxlength_cont_address_line3,le.maxlength_cont_address_line4,le.maxlength_cont_address_line5,le.maxlength_cont_address_line6,le.maxlength_cont_address_effective_date,le.maxlength_cont_address_county,le.maxlength_cont_phone_number,le.maxlength_cont_phone_number_type_cd,le.maxlength_cont_phone_number_type_desc,le.maxlength_cont_fax_nbr,le.maxlength_cont_email_address,le.maxlength_cont_web_address,le.maxlength_corp_addr1_prim_range,le.maxlength_corp_addr1_predir,le.maxlength_corp_addr1_prim_name,le.maxlength_corp_addr1_addr_suffix,le.maxlength_corp_addr1_postdir,le.maxlength_corp_addr1_unit_desig,le.maxlength_corp_addr1_sec_range,le.maxlength_corp_addr1_p_city_name,le.maxlength_corp_addr1_v_city_name,le.maxlength_corp_addr1_state,le.maxlength_corp_addr1_zip5,le.maxlength_corp_addr1_zip4,le.maxlength_corp_addr1_cart,le.maxlength_corp_addr1_cr_sort_sz,le.maxlength_corp_addr1_lot,le.maxlength_corp_addr1_lot_order,le.maxlength_corp_addr1_dpbc,le.maxlength_corp_addr1_chk_digit,le.maxlength_corp_addr1_rec_type,le.maxlength_corp_addr1_ace_fips_st,le.maxlength_corp_addr1_county,le.maxlength_corp_addr1_geo_lat,le.maxlength_corp_addr1_geo_long,le.maxlength_corp_addr1_msa,le.maxlength_corp_addr1_geo_blk,le.maxlength_corp_addr1_geo_match,le.maxlength_corp_addr1_err_stat,le.maxlength_cont_title,le.maxlength_cont_fname,le.maxlength_cont_mname,le.maxlength_cont_lname,le.maxlength_cont_name_suffix,le.maxlength_cont_score,le.maxlength_cont_cname,le.maxlength_cont_cname_score,le.maxlength_cont_prim_range,le.maxlength_cont_predir,le.maxlength_cont_prim_name,le.maxlength_cont_addr_suffix,le.maxlength_cont_postdir,le.maxlength_cont_unit_desig,le.maxlength_cont_sec_range,le.maxlength_cont_p_city_name,le.maxlength_cont_v_city_name,le.maxlength_cont_state,le.maxlength_cont_zip5,le.maxlength_cont_zip4,le.maxlength_cont_cart,le.maxlength_cont_cr_sort_sz,le.maxlength_cont_lot,le.maxlength_cont_lot_order,le.maxlength_cont_dpbc,le.maxlength_cont_chk_digit,le.maxlength_cont_rec_type,le.maxlength_cont_ace_fips_st,le.maxlength_cont_county,le.maxlength_cont_geo_lat,le.maxlength_cont_geo_long,le.maxlength_cont_msa,le.maxlength_cont_geo_blk,le.maxlength_cont_geo_match,le.maxlength_cont_err_stat,le.maxlength_corp_phone10,le.maxlength_cont_phone10,le.maxlength_record_type,le.maxlength_append_corp_addr_rawaid,le.maxlength_append_corp_addr_aceaid,le.maxlength_corp_prep_addr_line1,le.maxlength_corp_prep_addr_last_line,le.maxlength_append_cont_addr_rawaid,le.maxlength_append_cont_addr_aceaid,le.maxlength_cont_prep_addr_line1,le.maxlength_cont_prep_addr_last_line,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight);
  SELF.avelength := CHOOSE(C,le.avelength_bdid,le.avelength_did,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_corp_key,le.avelength_corp_supp_key,le.avelength_corp_vendor,le.avelength_corp_vendor_county,le.avelength_corp_vendor_subcode,le.avelength_corp_state_origin,le.avelength_corp_process_date,le.avelength_corp_orig_sos_charter_nbr,le.avelength_corp_sos_charter_nbr,le.avelength_corp_legal_name,le.avelength_corp_address1_type_cd,le.avelength_corp_address1_type_desc,le.avelength_corp_address1_line1,le.avelength_corp_address1_line2,le.avelength_corp_address1_line3,le.avelength_corp_address1_line4,le.avelength_corp_address1_line5,le.avelength_corp_address1_line6,le.avelength_corp_address1_effective_date,le.avelength_corp_phone_number,le.avelength_corp_phone_number_type_cd,le.avelength_corp_phone_number_type_desc,le.avelength_corp_fax_nbr,le.avelength_corp_email_address,le.avelength_corp_web_address,le.avelength_cont_filing_reference_nbr,le.avelength_cont_filing_date,le.avelength_cont_filing_cd,le.avelength_cont_filing_desc,le.avelength_cont_type_cd,le.avelength_cont_type_desc,le.avelength_cont_name,le.avelength_cont_title_desc,le.avelength_cont_sos_charter_nbr,le.avelength_cont_fein,le.avelength_cont_ssn,le.avelength_cont_dob,le.avelength_cont_status_cd,le.avelength_cont_status_desc,le.avelength_cont_effective_date,le.avelength_cont_effective_cd,le.avelength_cont_effective_desc,le.avelength_cont_addl_info,le.avelength_cont_address_type_cd,le.avelength_cont_address_type_desc,le.avelength_cont_address_line1,le.avelength_cont_address_line2,le.avelength_cont_address_line3,le.avelength_cont_address_line4,le.avelength_cont_address_line5,le.avelength_cont_address_line6,le.avelength_cont_address_effective_date,le.avelength_cont_address_county,le.avelength_cont_phone_number,le.avelength_cont_phone_number_type_cd,le.avelength_cont_phone_number_type_desc,le.avelength_cont_fax_nbr,le.avelength_cont_email_address,le.avelength_cont_web_address,le.avelength_corp_addr1_prim_range,le.avelength_corp_addr1_predir,le.avelength_corp_addr1_prim_name,le.avelength_corp_addr1_addr_suffix,le.avelength_corp_addr1_postdir,le.avelength_corp_addr1_unit_desig,le.avelength_corp_addr1_sec_range,le.avelength_corp_addr1_p_city_name,le.avelength_corp_addr1_v_city_name,le.avelength_corp_addr1_state,le.avelength_corp_addr1_zip5,le.avelength_corp_addr1_zip4,le.avelength_corp_addr1_cart,le.avelength_corp_addr1_cr_sort_sz,le.avelength_corp_addr1_lot,le.avelength_corp_addr1_lot_order,le.avelength_corp_addr1_dpbc,le.avelength_corp_addr1_chk_digit,le.avelength_corp_addr1_rec_type,le.avelength_corp_addr1_ace_fips_st,le.avelength_corp_addr1_county,le.avelength_corp_addr1_geo_lat,le.avelength_corp_addr1_geo_long,le.avelength_corp_addr1_msa,le.avelength_corp_addr1_geo_blk,le.avelength_corp_addr1_geo_match,le.avelength_corp_addr1_err_stat,le.avelength_cont_title,le.avelength_cont_fname,le.avelength_cont_mname,le.avelength_cont_lname,le.avelength_cont_name_suffix,le.avelength_cont_score,le.avelength_cont_cname,le.avelength_cont_cname_score,le.avelength_cont_prim_range,le.avelength_cont_predir,le.avelength_cont_prim_name,le.avelength_cont_addr_suffix,le.avelength_cont_postdir,le.avelength_cont_unit_desig,le.avelength_cont_sec_range,le.avelength_cont_p_city_name,le.avelength_cont_v_city_name,le.avelength_cont_state,le.avelength_cont_zip5,le.avelength_cont_zip4,le.avelength_cont_cart,le.avelength_cont_cr_sort_sz,le.avelength_cont_lot,le.avelength_cont_lot_order,le.avelength_cont_dpbc,le.avelength_cont_chk_digit,le.avelength_cont_rec_type,le.avelength_cont_ace_fips_st,le.avelength_cont_county,le.avelength_cont_geo_lat,le.avelength_cont_geo_long,le.avelength_cont_msa,le.avelength_cont_geo_blk,le.avelength_cont_geo_match,le.avelength_cont_err_stat,le.avelength_corp_phone10,le.avelength_cont_phone10,le.avelength_record_type,le.avelength_append_corp_addr_rawaid,le.avelength_append_corp_addr_aceaid,le.avelength_corp_prep_addr_line1,le.avelength_corp_prep_addr_last_line,le.avelength_append_cont_addr_rawaid,le.avelength_append_cont_addr_aceaid,le.avelength_cont_prep_addr_line1,le.avelength_cont_prep_addr_last_line,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight);
END;
EXPORT invSummary := NORMALIZE(summary0, 159, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.corp_key),TRIM((SALT30.StrType)le.corp_supp_key),TRIM((SALT30.StrType)le.corp_vendor),TRIM((SALT30.StrType)le.corp_vendor_county),TRIM((SALT30.StrType)le.corp_vendor_subcode),TRIM((SALT30.StrType)le.corp_state_origin),TRIM((SALT30.StrType)le.corp_process_date),TRIM((SALT30.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_legal_name),TRIM((SALT30.StrType)le.corp_address1_type_cd),TRIM((SALT30.StrType)le.corp_address1_type_desc),TRIM((SALT30.StrType)le.corp_address1_line1),TRIM((SALT30.StrType)le.corp_address1_line2),TRIM((SALT30.StrType)le.corp_address1_line3),TRIM((SALT30.StrType)le.corp_address1_line4),TRIM((SALT30.StrType)le.corp_address1_line5),TRIM((SALT30.StrType)le.corp_address1_line6),TRIM((SALT30.StrType)le.corp_address1_effective_date),TRIM((SALT30.StrType)le.corp_phone_number),TRIM((SALT30.StrType)le.corp_phone_number_type_cd),TRIM((SALT30.StrType)le.corp_phone_number_type_desc),TRIM((SALT30.StrType)le.corp_fax_nbr),TRIM((SALT30.StrType)le.corp_email_address),TRIM((SALT30.StrType)le.corp_web_address),TRIM((SALT30.StrType)le.cont_filing_reference_nbr),TRIM((SALT30.StrType)le.cont_filing_date),TRIM((SALT30.StrType)le.cont_filing_cd),TRIM((SALT30.StrType)le.cont_filing_desc),TRIM((SALT30.StrType)le.cont_type_cd),TRIM((SALT30.StrType)le.cont_type_desc),TRIM((SALT30.StrType)le.cont_name),TRIM((SALT30.StrType)le.cont_title_desc),TRIM((SALT30.StrType)le.cont_sos_charter_nbr),TRIM((SALT30.StrType)le.cont_fein),TRIM((SALT30.StrType)le.cont_ssn),TRIM((SALT30.StrType)le.cont_dob),TRIM((SALT30.StrType)le.cont_status_cd),TRIM((SALT30.StrType)le.cont_status_desc),TRIM((SALT30.StrType)le.cont_effective_date),TRIM((SALT30.StrType)le.cont_effective_cd),TRIM((SALT30.StrType)le.cont_effective_desc),TRIM((SALT30.StrType)le.cont_addl_info),TRIM((SALT30.StrType)le.cont_address_type_cd),TRIM((SALT30.StrType)le.cont_address_type_desc),TRIM((SALT30.StrType)le.cont_address_line1),TRIM((SALT30.StrType)le.cont_address_line2),TRIM((SALT30.StrType)le.cont_address_line3),TRIM((SALT30.StrType)le.cont_address_line4),TRIM((SALT30.StrType)le.cont_address_line5),TRIM((SALT30.StrType)le.cont_address_line6),TRIM((SALT30.StrType)le.cont_address_effective_date),TRIM((SALT30.StrType)le.cont_address_county),TRIM((SALT30.StrType)le.cont_phone_number),TRIM((SALT30.StrType)le.cont_phone_number_type_cd),TRIM((SALT30.StrType)le.cont_phone_number_type_desc),TRIM((SALT30.StrType)le.cont_fax_nbr),TRIM((SALT30.StrType)le.cont_email_address),TRIM((SALT30.StrType)le.cont_web_address),TRIM((SALT30.StrType)le.corp_addr1_prim_range),TRIM((SALT30.StrType)le.corp_addr1_predir),TRIM((SALT30.StrType)le.corp_addr1_prim_name),TRIM((SALT30.StrType)le.corp_addr1_addr_suffix),TRIM((SALT30.StrType)le.corp_addr1_postdir),TRIM((SALT30.StrType)le.corp_addr1_unit_desig),TRIM((SALT30.StrType)le.corp_addr1_sec_range),TRIM((SALT30.StrType)le.corp_addr1_p_city_name),TRIM((SALT30.StrType)le.corp_addr1_v_city_name),TRIM((SALT30.StrType)le.corp_addr1_state),TRIM((SALT30.StrType)le.corp_addr1_zip5),TRIM((SALT30.StrType)le.corp_addr1_zip4),TRIM((SALT30.StrType)le.corp_addr1_cart),TRIM((SALT30.StrType)le.corp_addr1_cr_sort_sz),TRIM((SALT30.StrType)le.corp_addr1_lot),TRIM((SALT30.StrType)le.corp_addr1_lot_order),TRIM((SALT30.StrType)le.corp_addr1_dpbc),TRIM((SALT30.StrType)le.corp_addr1_chk_digit),TRIM((SALT30.StrType)le.corp_addr1_rec_type),TRIM((SALT30.StrType)le.corp_addr1_ace_fips_st),TRIM((SALT30.StrType)le.corp_addr1_county),TRIM((SALT30.StrType)le.corp_addr1_geo_lat),TRIM((SALT30.StrType)le.corp_addr1_geo_long),TRIM((SALT30.StrType)le.corp_addr1_msa),TRIM((SALT30.StrType)le.corp_addr1_geo_blk),TRIM((SALT30.StrType)le.corp_addr1_geo_match),TRIM((SALT30.StrType)le.corp_addr1_err_stat),TRIM((SALT30.StrType)le.cont_title),TRIM((SALT30.StrType)le.cont_fname),TRIM((SALT30.StrType)le.cont_mname),TRIM((SALT30.StrType)le.cont_lname),TRIM((SALT30.StrType)le.cont_name_suffix),TRIM((SALT30.StrType)le.cont_score),TRIM((SALT30.StrType)le.cont_cname),TRIM((SALT30.StrType)le.cont_cname_score),TRIM((SALT30.StrType)le.cont_prim_range),TRIM((SALT30.StrType)le.cont_predir),TRIM((SALT30.StrType)le.cont_prim_name),TRIM((SALT30.StrType)le.cont_addr_suffix),TRIM((SALT30.StrType)le.cont_postdir),TRIM((SALT30.StrType)le.cont_unit_desig),TRIM((SALT30.StrType)le.cont_sec_range),TRIM((SALT30.StrType)le.cont_p_city_name),TRIM((SALT30.StrType)le.cont_v_city_name),TRIM((SALT30.StrType)le.cont_state),TRIM((SALT30.StrType)le.cont_zip5),TRIM((SALT30.StrType)le.cont_zip4),TRIM((SALT30.StrType)le.cont_cart),TRIM((SALT30.StrType)le.cont_cr_sort_sz),TRIM((SALT30.StrType)le.cont_lot),TRIM((SALT30.StrType)le.cont_lot_order),TRIM((SALT30.StrType)le.cont_dpbc),TRIM((SALT30.StrType)le.cont_chk_digit),TRIM((SALT30.StrType)le.cont_rec_type),TRIM((SALT30.StrType)le.cont_ace_fips_st),TRIM((SALT30.StrType)le.cont_county),TRIM((SALT30.StrType)le.cont_geo_lat),TRIM((SALT30.StrType)le.cont_geo_long),TRIM((SALT30.StrType)le.cont_msa),TRIM((SALT30.StrType)le.cont_geo_blk),TRIM((SALT30.StrType)le.cont_geo_match),TRIM((SALT30.StrType)le.cont_err_stat),TRIM((SALT30.StrType)le.corp_phone10),TRIM((SALT30.StrType)le.cont_phone10),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.append_corp_addr_rawaid),TRIM((SALT30.StrType)le.append_corp_addr_aceaid),TRIM((SALT30.StrType)le.corp_prep_addr_line1),TRIM((SALT30.StrType)le.corp_prep_addr_last_line),TRIM((SALT30.StrType)le.append_cont_addr_rawaid),TRIM((SALT30.StrType)le.append_cont_addr_aceaid),TRIM((SALT30.StrType)le.cont_prep_addr_line1),TRIM((SALT30.StrType)le.cont_prep_addr_last_line),TRIM((SALT30.StrType)le.dotid),TRIM((SALT30.StrType)le.dotscore),TRIM((SALT30.StrType)le.dotweight),TRIM((SALT30.StrType)le.empid),TRIM((SALT30.StrType)le.empscore),TRIM((SALT30.StrType)le.empweight),TRIM((SALT30.StrType)le.powid),TRIM((SALT30.StrType)le.powscore),TRIM((SALT30.StrType)le.powweight),TRIM((SALT30.StrType)le.proxid),TRIM((SALT30.StrType)le.proxscore),TRIM((SALT30.StrType)le.proxweight),TRIM((SALT30.StrType)le.seleid),TRIM((SALT30.StrType)le.selescore),TRIM((SALT30.StrType)le.seleweight),TRIM((SALT30.StrType)le.orgid),TRIM((SALT30.StrType)le.orgscore),TRIM((SALT30.StrType)le.orgweight),TRIM((SALT30.StrType)le.ultid),TRIM((SALT30.StrType)le.ultscore),TRIM((SALT30.StrType)le.ultweight)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,159,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 159);
  SELF.FldNo2 := 1 + (C % 159);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.corp_key),TRIM((SALT30.StrType)le.corp_supp_key),TRIM((SALT30.StrType)le.corp_vendor),TRIM((SALT30.StrType)le.corp_vendor_county),TRIM((SALT30.StrType)le.corp_vendor_subcode),TRIM((SALT30.StrType)le.corp_state_origin),TRIM((SALT30.StrType)le.corp_process_date),TRIM((SALT30.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_legal_name),TRIM((SALT30.StrType)le.corp_address1_type_cd),TRIM((SALT30.StrType)le.corp_address1_type_desc),TRIM((SALT30.StrType)le.corp_address1_line1),TRIM((SALT30.StrType)le.corp_address1_line2),TRIM((SALT30.StrType)le.corp_address1_line3),TRIM((SALT30.StrType)le.corp_address1_line4),TRIM((SALT30.StrType)le.corp_address1_line5),TRIM((SALT30.StrType)le.corp_address1_line6),TRIM((SALT30.StrType)le.corp_address1_effective_date),TRIM((SALT30.StrType)le.corp_phone_number),TRIM((SALT30.StrType)le.corp_phone_number_type_cd),TRIM((SALT30.StrType)le.corp_phone_number_type_desc),TRIM((SALT30.StrType)le.corp_fax_nbr),TRIM((SALT30.StrType)le.corp_email_address),TRIM((SALT30.StrType)le.corp_web_address),TRIM((SALT30.StrType)le.cont_filing_reference_nbr),TRIM((SALT30.StrType)le.cont_filing_date),TRIM((SALT30.StrType)le.cont_filing_cd),TRIM((SALT30.StrType)le.cont_filing_desc),TRIM((SALT30.StrType)le.cont_type_cd),TRIM((SALT30.StrType)le.cont_type_desc),TRIM((SALT30.StrType)le.cont_name),TRIM((SALT30.StrType)le.cont_title_desc),TRIM((SALT30.StrType)le.cont_sos_charter_nbr),TRIM((SALT30.StrType)le.cont_fein),TRIM((SALT30.StrType)le.cont_ssn),TRIM((SALT30.StrType)le.cont_dob),TRIM((SALT30.StrType)le.cont_status_cd),TRIM((SALT30.StrType)le.cont_status_desc),TRIM((SALT30.StrType)le.cont_effective_date),TRIM((SALT30.StrType)le.cont_effective_cd),TRIM((SALT30.StrType)le.cont_effective_desc),TRIM((SALT30.StrType)le.cont_addl_info),TRIM((SALT30.StrType)le.cont_address_type_cd),TRIM((SALT30.StrType)le.cont_address_type_desc),TRIM((SALT30.StrType)le.cont_address_line1),TRIM((SALT30.StrType)le.cont_address_line2),TRIM((SALT30.StrType)le.cont_address_line3),TRIM((SALT30.StrType)le.cont_address_line4),TRIM((SALT30.StrType)le.cont_address_line5),TRIM((SALT30.StrType)le.cont_address_line6),TRIM((SALT30.StrType)le.cont_address_effective_date),TRIM((SALT30.StrType)le.cont_address_county),TRIM((SALT30.StrType)le.cont_phone_number),TRIM((SALT30.StrType)le.cont_phone_number_type_cd),TRIM((SALT30.StrType)le.cont_phone_number_type_desc),TRIM((SALT30.StrType)le.cont_fax_nbr),TRIM((SALT30.StrType)le.cont_email_address),TRIM((SALT30.StrType)le.cont_web_address),TRIM((SALT30.StrType)le.corp_addr1_prim_range),TRIM((SALT30.StrType)le.corp_addr1_predir),TRIM((SALT30.StrType)le.corp_addr1_prim_name),TRIM((SALT30.StrType)le.corp_addr1_addr_suffix),TRIM((SALT30.StrType)le.corp_addr1_postdir),TRIM((SALT30.StrType)le.corp_addr1_unit_desig),TRIM((SALT30.StrType)le.corp_addr1_sec_range),TRIM((SALT30.StrType)le.corp_addr1_p_city_name),TRIM((SALT30.StrType)le.corp_addr1_v_city_name),TRIM((SALT30.StrType)le.corp_addr1_state),TRIM((SALT30.StrType)le.corp_addr1_zip5),TRIM((SALT30.StrType)le.corp_addr1_zip4),TRIM((SALT30.StrType)le.corp_addr1_cart),TRIM((SALT30.StrType)le.corp_addr1_cr_sort_sz),TRIM((SALT30.StrType)le.corp_addr1_lot),TRIM((SALT30.StrType)le.corp_addr1_lot_order),TRIM((SALT30.StrType)le.corp_addr1_dpbc),TRIM((SALT30.StrType)le.corp_addr1_chk_digit),TRIM((SALT30.StrType)le.corp_addr1_rec_type),TRIM((SALT30.StrType)le.corp_addr1_ace_fips_st),TRIM((SALT30.StrType)le.corp_addr1_county),TRIM((SALT30.StrType)le.corp_addr1_geo_lat),TRIM((SALT30.StrType)le.corp_addr1_geo_long),TRIM((SALT30.StrType)le.corp_addr1_msa),TRIM((SALT30.StrType)le.corp_addr1_geo_blk),TRIM((SALT30.StrType)le.corp_addr1_geo_match),TRIM((SALT30.StrType)le.corp_addr1_err_stat),TRIM((SALT30.StrType)le.cont_title),TRIM((SALT30.StrType)le.cont_fname),TRIM((SALT30.StrType)le.cont_mname),TRIM((SALT30.StrType)le.cont_lname),TRIM((SALT30.StrType)le.cont_name_suffix),TRIM((SALT30.StrType)le.cont_score),TRIM((SALT30.StrType)le.cont_cname),TRIM((SALT30.StrType)le.cont_cname_score),TRIM((SALT30.StrType)le.cont_prim_range),TRIM((SALT30.StrType)le.cont_predir),TRIM((SALT30.StrType)le.cont_prim_name),TRIM((SALT30.StrType)le.cont_addr_suffix),TRIM((SALT30.StrType)le.cont_postdir),TRIM((SALT30.StrType)le.cont_unit_desig),TRIM((SALT30.StrType)le.cont_sec_range),TRIM((SALT30.StrType)le.cont_p_city_name),TRIM((SALT30.StrType)le.cont_v_city_name),TRIM((SALT30.StrType)le.cont_state),TRIM((SALT30.StrType)le.cont_zip5),TRIM((SALT30.StrType)le.cont_zip4),TRIM((SALT30.StrType)le.cont_cart),TRIM((SALT30.StrType)le.cont_cr_sort_sz),TRIM((SALT30.StrType)le.cont_lot),TRIM((SALT30.StrType)le.cont_lot_order),TRIM((SALT30.StrType)le.cont_dpbc),TRIM((SALT30.StrType)le.cont_chk_digit),TRIM((SALT30.StrType)le.cont_rec_type),TRIM((SALT30.StrType)le.cont_ace_fips_st),TRIM((SALT30.StrType)le.cont_county),TRIM((SALT30.StrType)le.cont_geo_lat),TRIM((SALT30.StrType)le.cont_geo_long),TRIM((SALT30.StrType)le.cont_msa),TRIM((SALT30.StrType)le.cont_geo_blk),TRIM((SALT30.StrType)le.cont_geo_match),TRIM((SALT30.StrType)le.cont_err_stat),TRIM((SALT30.StrType)le.corp_phone10),TRIM((SALT30.StrType)le.cont_phone10),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.append_corp_addr_rawaid),TRIM((SALT30.StrType)le.append_corp_addr_aceaid),TRIM((SALT30.StrType)le.corp_prep_addr_line1),TRIM((SALT30.StrType)le.corp_prep_addr_last_line),TRIM((SALT30.StrType)le.append_cont_addr_rawaid),TRIM((SALT30.StrType)le.append_cont_addr_aceaid),TRIM((SALT30.StrType)le.cont_prep_addr_line1),TRIM((SALT30.StrType)le.cont_prep_addr_last_line),TRIM((SALT30.StrType)le.dotid),TRIM((SALT30.StrType)le.dotscore),TRIM((SALT30.StrType)le.dotweight),TRIM((SALT30.StrType)le.empid),TRIM((SALT30.StrType)le.empscore),TRIM((SALT30.StrType)le.empweight),TRIM((SALT30.StrType)le.powid),TRIM((SALT30.StrType)le.powscore),TRIM((SALT30.StrType)le.powweight),TRIM((SALT30.StrType)le.proxid),TRIM((SALT30.StrType)le.proxscore),TRIM((SALT30.StrType)le.proxweight),TRIM((SALT30.StrType)le.seleid),TRIM((SALT30.StrType)le.selescore),TRIM((SALT30.StrType)le.seleweight),TRIM((SALT30.StrType)le.orgid),TRIM((SALT30.StrType)le.orgscore),TRIM((SALT30.StrType)le.orgweight),TRIM((SALT30.StrType)le.ultid),TRIM((SALT30.StrType)le.ultscore),TRIM((SALT30.StrType)le.ultweight)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.corp_key),TRIM((SALT30.StrType)le.corp_supp_key),TRIM((SALT30.StrType)le.corp_vendor),TRIM((SALT30.StrType)le.corp_vendor_county),TRIM((SALT30.StrType)le.corp_vendor_subcode),TRIM((SALT30.StrType)le.corp_state_origin),TRIM((SALT30.StrType)le.corp_process_date),TRIM((SALT30.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_legal_name),TRIM((SALT30.StrType)le.corp_address1_type_cd),TRIM((SALT30.StrType)le.corp_address1_type_desc),TRIM((SALT30.StrType)le.corp_address1_line1),TRIM((SALT30.StrType)le.corp_address1_line2),TRIM((SALT30.StrType)le.corp_address1_line3),TRIM((SALT30.StrType)le.corp_address1_line4),TRIM((SALT30.StrType)le.corp_address1_line5),TRIM((SALT30.StrType)le.corp_address1_line6),TRIM((SALT30.StrType)le.corp_address1_effective_date),TRIM((SALT30.StrType)le.corp_phone_number),TRIM((SALT30.StrType)le.corp_phone_number_type_cd),TRIM((SALT30.StrType)le.corp_phone_number_type_desc),TRIM((SALT30.StrType)le.corp_fax_nbr),TRIM((SALT30.StrType)le.corp_email_address),TRIM((SALT30.StrType)le.corp_web_address),TRIM((SALT30.StrType)le.cont_filing_reference_nbr),TRIM((SALT30.StrType)le.cont_filing_date),TRIM((SALT30.StrType)le.cont_filing_cd),TRIM((SALT30.StrType)le.cont_filing_desc),TRIM((SALT30.StrType)le.cont_type_cd),TRIM((SALT30.StrType)le.cont_type_desc),TRIM((SALT30.StrType)le.cont_name),TRIM((SALT30.StrType)le.cont_title_desc),TRIM((SALT30.StrType)le.cont_sos_charter_nbr),TRIM((SALT30.StrType)le.cont_fein),TRIM((SALT30.StrType)le.cont_ssn),TRIM((SALT30.StrType)le.cont_dob),TRIM((SALT30.StrType)le.cont_status_cd),TRIM((SALT30.StrType)le.cont_status_desc),TRIM((SALT30.StrType)le.cont_effective_date),TRIM((SALT30.StrType)le.cont_effective_cd),TRIM((SALT30.StrType)le.cont_effective_desc),TRIM((SALT30.StrType)le.cont_addl_info),TRIM((SALT30.StrType)le.cont_address_type_cd),TRIM((SALT30.StrType)le.cont_address_type_desc),TRIM((SALT30.StrType)le.cont_address_line1),TRIM((SALT30.StrType)le.cont_address_line2),TRIM((SALT30.StrType)le.cont_address_line3),TRIM((SALT30.StrType)le.cont_address_line4),TRIM((SALT30.StrType)le.cont_address_line5),TRIM((SALT30.StrType)le.cont_address_line6),TRIM((SALT30.StrType)le.cont_address_effective_date),TRIM((SALT30.StrType)le.cont_address_county),TRIM((SALT30.StrType)le.cont_phone_number),TRIM((SALT30.StrType)le.cont_phone_number_type_cd),TRIM((SALT30.StrType)le.cont_phone_number_type_desc),TRIM((SALT30.StrType)le.cont_fax_nbr),TRIM((SALT30.StrType)le.cont_email_address),TRIM((SALT30.StrType)le.cont_web_address),TRIM((SALT30.StrType)le.corp_addr1_prim_range),TRIM((SALT30.StrType)le.corp_addr1_predir),TRIM((SALT30.StrType)le.corp_addr1_prim_name),TRIM((SALT30.StrType)le.corp_addr1_addr_suffix),TRIM((SALT30.StrType)le.corp_addr1_postdir),TRIM((SALT30.StrType)le.corp_addr1_unit_desig),TRIM((SALT30.StrType)le.corp_addr1_sec_range),TRIM((SALT30.StrType)le.corp_addr1_p_city_name),TRIM((SALT30.StrType)le.corp_addr1_v_city_name),TRIM((SALT30.StrType)le.corp_addr1_state),TRIM((SALT30.StrType)le.corp_addr1_zip5),TRIM((SALT30.StrType)le.corp_addr1_zip4),TRIM((SALT30.StrType)le.corp_addr1_cart),TRIM((SALT30.StrType)le.corp_addr1_cr_sort_sz),TRIM((SALT30.StrType)le.corp_addr1_lot),TRIM((SALT30.StrType)le.corp_addr1_lot_order),TRIM((SALT30.StrType)le.corp_addr1_dpbc),TRIM((SALT30.StrType)le.corp_addr1_chk_digit),TRIM((SALT30.StrType)le.corp_addr1_rec_type),TRIM((SALT30.StrType)le.corp_addr1_ace_fips_st),TRIM((SALT30.StrType)le.corp_addr1_county),TRIM((SALT30.StrType)le.corp_addr1_geo_lat),TRIM((SALT30.StrType)le.corp_addr1_geo_long),TRIM((SALT30.StrType)le.corp_addr1_msa),TRIM((SALT30.StrType)le.corp_addr1_geo_blk),TRIM((SALT30.StrType)le.corp_addr1_geo_match),TRIM((SALT30.StrType)le.corp_addr1_err_stat),TRIM((SALT30.StrType)le.cont_title),TRIM((SALT30.StrType)le.cont_fname),TRIM((SALT30.StrType)le.cont_mname),TRIM((SALT30.StrType)le.cont_lname),TRIM((SALT30.StrType)le.cont_name_suffix),TRIM((SALT30.StrType)le.cont_score),TRIM((SALT30.StrType)le.cont_cname),TRIM((SALT30.StrType)le.cont_cname_score),TRIM((SALT30.StrType)le.cont_prim_range),TRIM((SALT30.StrType)le.cont_predir),TRIM((SALT30.StrType)le.cont_prim_name),TRIM((SALT30.StrType)le.cont_addr_suffix),TRIM((SALT30.StrType)le.cont_postdir),TRIM((SALT30.StrType)le.cont_unit_desig),TRIM((SALT30.StrType)le.cont_sec_range),TRIM((SALT30.StrType)le.cont_p_city_name),TRIM((SALT30.StrType)le.cont_v_city_name),TRIM((SALT30.StrType)le.cont_state),TRIM((SALT30.StrType)le.cont_zip5),TRIM((SALT30.StrType)le.cont_zip4),TRIM((SALT30.StrType)le.cont_cart),TRIM((SALT30.StrType)le.cont_cr_sort_sz),TRIM((SALT30.StrType)le.cont_lot),TRIM((SALT30.StrType)le.cont_lot_order),TRIM((SALT30.StrType)le.cont_dpbc),TRIM((SALT30.StrType)le.cont_chk_digit),TRIM((SALT30.StrType)le.cont_rec_type),TRIM((SALT30.StrType)le.cont_ace_fips_st),TRIM((SALT30.StrType)le.cont_county),TRIM((SALT30.StrType)le.cont_geo_lat),TRIM((SALT30.StrType)le.cont_geo_long),TRIM((SALT30.StrType)le.cont_msa),TRIM((SALT30.StrType)le.cont_geo_blk),TRIM((SALT30.StrType)le.cont_geo_match),TRIM((SALT30.StrType)le.cont_err_stat),TRIM((SALT30.StrType)le.corp_phone10),TRIM((SALT30.StrType)le.cont_phone10),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.append_corp_addr_rawaid),TRIM((SALT30.StrType)le.append_corp_addr_aceaid),TRIM((SALT30.StrType)le.corp_prep_addr_line1),TRIM((SALT30.StrType)le.corp_prep_addr_last_line),TRIM((SALT30.StrType)le.append_cont_addr_rawaid),TRIM((SALT30.StrType)le.append_cont_addr_aceaid),TRIM((SALT30.StrType)le.cont_prep_addr_line1),TRIM((SALT30.StrType)le.cont_prep_addr_last_line),TRIM((SALT30.StrType)le.dotid),TRIM((SALT30.StrType)le.dotscore),TRIM((SALT30.StrType)le.dotweight),TRIM((SALT30.StrType)le.empid),TRIM((SALT30.StrType)le.empscore),TRIM((SALT30.StrType)le.empweight),TRIM((SALT30.StrType)le.powid),TRIM((SALT30.StrType)le.powscore),TRIM((SALT30.StrType)le.powweight),TRIM((SALT30.StrType)le.proxid),TRIM((SALT30.StrType)le.proxscore),TRIM((SALT30.StrType)le.proxweight),TRIM((SALT30.StrType)le.seleid),TRIM((SALT30.StrType)le.selescore),TRIM((SALT30.StrType)le.seleweight),TRIM((SALT30.StrType)le.orgid),TRIM((SALT30.StrType)le.orgscore),TRIM((SALT30.StrType)le.orgweight),TRIM((SALT30.StrType)le.ultid),TRIM((SALT30.StrType)le.ultscore),TRIM((SALT30.StrType)le.ultweight)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),159*159,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'bdid'}
      ,{2,'did'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'dt_vendor_first_reported'}
      ,{6,'dt_vendor_last_reported'}
      ,{7,'corp_key'}
      ,{8,'corp_supp_key'}
      ,{9,'corp_vendor'}
      ,{10,'corp_vendor_county'}
      ,{11,'corp_vendor_subcode'}
      ,{12,'corp_state_origin'}
      ,{13,'corp_process_date'}
      ,{14,'corp_orig_sos_charter_nbr'}
      ,{15,'corp_sos_charter_nbr'}
      ,{16,'corp_legal_name'}
      ,{17,'corp_address1_type_cd'}
      ,{18,'corp_address1_type_desc'}
      ,{19,'corp_address1_line1'}
      ,{20,'corp_address1_line2'}
      ,{21,'corp_address1_line3'}
      ,{22,'corp_address1_line4'}
      ,{23,'corp_address1_line5'}
      ,{24,'corp_address1_line6'}
      ,{25,'corp_address1_effective_date'}
      ,{26,'corp_phone_number'}
      ,{27,'corp_phone_number_type_cd'}
      ,{28,'corp_phone_number_type_desc'}
      ,{29,'corp_fax_nbr'}
      ,{30,'corp_email_address'}
      ,{31,'corp_web_address'}
      ,{32,'cont_filing_reference_nbr'}
      ,{33,'cont_filing_date'}
      ,{34,'cont_filing_cd'}
      ,{35,'cont_filing_desc'}
      ,{36,'cont_type_cd'}
      ,{37,'cont_type_desc'}
      ,{38,'cont_name'}
      ,{39,'cont_title_desc'}
      ,{40,'cont_sos_charter_nbr'}
      ,{41,'cont_fein'}
      ,{42,'cont_ssn'}
      ,{43,'cont_dob'}
      ,{44,'cont_status_cd'}
      ,{45,'cont_status_desc'}
      ,{46,'cont_effective_date'}
      ,{47,'cont_effective_cd'}
      ,{48,'cont_effective_desc'}
      ,{49,'cont_addl_info'}
      ,{50,'cont_address_type_cd'}
      ,{51,'cont_address_type_desc'}
      ,{52,'cont_address_line1'}
      ,{53,'cont_address_line2'}
      ,{54,'cont_address_line3'}
      ,{55,'cont_address_line4'}
      ,{56,'cont_address_line5'}
      ,{57,'cont_address_line6'}
      ,{58,'cont_address_effective_date'}
      ,{59,'cont_address_county'}
      ,{60,'cont_phone_number'}
      ,{61,'cont_phone_number_type_cd'}
      ,{62,'cont_phone_number_type_desc'}
      ,{63,'cont_fax_nbr'}
      ,{64,'cont_email_address'}
      ,{65,'cont_web_address'}
      ,{66,'corp_addr1_prim_range'}
      ,{67,'corp_addr1_predir'}
      ,{68,'corp_addr1_prim_name'}
      ,{69,'corp_addr1_addr_suffix'}
      ,{70,'corp_addr1_postdir'}
      ,{71,'corp_addr1_unit_desig'}
      ,{72,'corp_addr1_sec_range'}
      ,{73,'corp_addr1_p_city_name'}
      ,{74,'corp_addr1_v_city_name'}
      ,{75,'corp_addr1_state'}
      ,{76,'corp_addr1_zip5'}
      ,{77,'corp_addr1_zip4'}
      ,{78,'corp_addr1_cart'}
      ,{79,'corp_addr1_cr_sort_sz'}
      ,{80,'corp_addr1_lot'}
      ,{81,'corp_addr1_lot_order'}
      ,{82,'corp_addr1_dpbc'}
      ,{83,'corp_addr1_chk_digit'}
      ,{84,'corp_addr1_rec_type'}
      ,{85,'corp_addr1_ace_fips_st'}
      ,{86,'corp_addr1_county'}
      ,{87,'corp_addr1_geo_lat'}
      ,{88,'corp_addr1_geo_long'}
      ,{89,'corp_addr1_msa'}
      ,{90,'corp_addr1_geo_blk'}
      ,{91,'corp_addr1_geo_match'}
      ,{92,'corp_addr1_err_stat'}
      ,{93,'cont_title'}
      ,{94,'cont_fname'}
      ,{95,'cont_mname'}
      ,{96,'cont_lname'}
      ,{97,'cont_name_suffix'}
      ,{98,'cont_score'}
      ,{99,'cont_cname'}
      ,{100,'cont_cname_score'}
      ,{101,'cont_prim_range'}
      ,{102,'cont_predir'}
      ,{103,'cont_prim_name'}
      ,{104,'cont_addr_suffix'}
      ,{105,'cont_postdir'}
      ,{106,'cont_unit_desig'}
      ,{107,'cont_sec_range'}
      ,{108,'cont_p_city_name'}
      ,{109,'cont_v_city_name'}
      ,{110,'cont_state'}
      ,{111,'cont_zip5'}
      ,{112,'cont_zip4'}
      ,{113,'cont_cart'}
      ,{114,'cont_cr_sort_sz'}
      ,{115,'cont_lot'}
      ,{116,'cont_lot_order'}
      ,{117,'cont_dpbc'}
      ,{118,'cont_chk_digit'}
      ,{119,'cont_rec_type'}
      ,{120,'cont_ace_fips_st'}
      ,{121,'cont_county'}
      ,{122,'cont_geo_lat'}
      ,{123,'cont_geo_long'}
      ,{124,'cont_msa'}
      ,{125,'cont_geo_blk'}
      ,{126,'cont_geo_match'}
      ,{127,'cont_err_stat'}
      ,{128,'corp_phone10'}
      ,{129,'cont_phone10'}
      ,{130,'record_type'}
      ,{131,'append_corp_addr_rawaid'}
      ,{132,'append_corp_addr_aceaid'}
      ,{133,'corp_prep_addr_line1'}
      ,{134,'corp_prep_addr_last_line'}
      ,{135,'append_cont_addr_rawaid'}
      ,{136,'append_cont_addr_aceaid'}
      ,{137,'cont_prep_addr_line1'}
      ,{138,'cont_prep_addr_last_line'}
      ,{139,'dotid'}
      ,{140,'dotscore'}
      ,{141,'dotweight'}
      ,{142,'empid'}
      ,{143,'empscore'}
      ,{144,'empweight'}
      ,{145,'powid'}
      ,{146,'powscore'}
      ,{147,'powweight'}
      ,{148,'proxid'}
      ,{149,'proxscore'}
      ,{150,'proxweight'}
      ,{151,'seleid'}
      ,{152,'selescore'}
      ,{153,'seleweight'}
      ,{154,'orgid'}
      ,{155,'orgscore'}
      ,{156,'orgweight'}
      ,{157,'ultid'}
      ,{158,'ultscore'}
      ,{159,'ultweight'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_bdid((SALT30.StrType)le.bdid),
    Fields.InValid_did((SALT30.StrType)le.did),
    Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT30.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT30.StrType)le.dt_vendor_last_reported),
    Fields.InValid_corp_key((SALT30.StrType)le.corp_key),
    Fields.InValid_corp_supp_key((SALT30.StrType)le.corp_supp_key),
    Fields.InValid_corp_vendor((SALT30.StrType)le.corp_vendor),
    Fields.InValid_corp_vendor_county((SALT30.StrType)le.corp_vendor_county),
    Fields.InValid_corp_vendor_subcode((SALT30.StrType)le.corp_vendor_subcode),
    Fields.InValid_corp_state_origin((SALT30.StrType)le.corp_state_origin),
    Fields.InValid_corp_process_date((SALT30.StrType)le.corp_process_date),
    Fields.InValid_corp_orig_sos_charter_nbr((SALT30.StrType)le.corp_orig_sos_charter_nbr),
    Fields.InValid_corp_sos_charter_nbr((SALT30.StrType)le.corp_sos_charter_nbr),
    Fields.InValid_corp_legal_name((SALT30.StrType)le.corp_legal_name),
    Fields.InValid_corp_address1_type_cd((SALT30.StrType)le.corp_address1_type_cd),
    Fields.InValid_corp_address1_type_desc((SALT30.StrType)le.corp_address1_type_desc),
    Fields.InValid_corp_address1_line1((SALT30.StrType)le.corp_address1_line1),
    Fields.InValid_corp_address1_line2((SALT30.StrType)le.corp_address1_line2),
    Fields.InValid_corp_address1_line3((SALT30.StrType)le.corp_address1_line3),
    Fields.InValid_corp_address1_line4((SALT30.StrType)le.corp_address1_line4),
    Fields.InValid_corp_address1_line5((SALT30.StrType)le.corp_address1_line5),
    Fields.InValid_corp_address1_line6((SALT30.StrType)le.corp_address1_line6),
    Fields.InValid_corp_address1_effective_date((SALT30.StrType)le.corp_address1_effective_date),
    Fields.InValid_corp_phone_number((SALT30.StrType)le.corp_phone_number),
    Fields.InValid_corp_phone_number_type_cd((SALT30.StrType)le.corp_phone_number_type_cd),
    Fields.InValid_corp_phone_number_type_desc((SALT30.StrType)le.corp_phone_number_type_desc),
    Fields.InValid_corp_fax_nbr((SALT30.StrType)le.corp_fax_nbr),
    Fields.InValid_corp_email_address((SALT30.StrType)le.corp_email_address),
    Fields.InValid_corp_web_address((SALT30.StrType)le.corp_web_address),
    Fields.InValid_cont_filing_reference_nbr((SALT30.StrType)le.cont_filing_reference_nbr),
    Fields.InValid_cont_filing_date((SALT30.StrType)le.cont_filing_date),
    Fields.InValid_cont_filing_cd((SALT30.StrType)le.cont_filing_cd),
    Fields.InValid_cont_filing_desc((SALT30.StrType)le.cont_filing_desc),
    Fields.InValid_cont_type_cd((SALT30.StrType)le.cont_type_cd),
    Fields.InValid_cont_type_desc((SALT30.StrType)le.cont_type_desc),
    Fields.InValid_cont_name((SALT30.StrType)le.cont_name),
    Fields.InValid_cont_title_desc((SALT30.StrType)le.cont_title_desc),
    Fields.InValid_cont_sos_charter_nbr((SALT30.StrType)le.cont_sos_charter_nbr),
    Fields.InValid_cont_fein((SALT30.StrType)le.cont_fein),
    Fields.InValid_cont_ssn((SALT30.StrType)le.cont_ssn),
    Fields.InValid_cont_dob((SALT30.StrType)le.cont_dob),
    Fields.InValid_cont_status_cd((SALT30.StrType)le.cont_status_cd),
    Fields.InValid_cont_status_desc((SALT30.StrType)le.cont_status_desc),
    Fields.InValid_cont_effective_date((SALT30.StrType)le.cont_effective_date),
    Fields.InValid_cont_effective_cd((SALT30.StrType)le.cont_effective_cd),
    Fields.InValid_cont_effective_desc((SALT30.StrType)le.cont_effective_desc),
    Fields.InValid_cont_addl_info((SALT30.StrType)le.cont_addl_info),
    Fields.InValid_cont_address_type_cd((SALT30.StrType)le.cont_address_type_cd),
    Fields.InValid_cont_address_type_desc((SALT30.StrType)le.cont_address_type_desc),
    Fields.InValid_cont_address_line1((SALT30.StrType)le.cont_address_line1),
    Fields.InValid_cont_address_line2((SALT30.StrType)le.cont_address_line2),
    Fields.InValid_cont_address_line3((SALT30.StrType)le.cont_address_line3),
    Fields.InValid_cont_address_line4((SALT30.StrType)le.cont_address_line4),
    Fields.InValid_cont_address_line5((SALT30.StrType)le.cont_address_line5),
    Fields.InValid_cont_address_line6((SALT30.StrType)le.cont_address_line6),
    Fields.InValid_cont_address_effective_date((SALT30.StrType)le.cont_address_effective_date),
    Fields.InValid_cont_address_county((SALT30.StrType)le.cont_address_county),
    Fields.InValid_cont_phone_number((SALT30.StrType)le.cont_phone_number),
    Fields.InValid_cont_phone_number_type_cd((SALT30.StrType)le.cont_phone_number_type_cd),
    Fields.InValid_cont_phone_number_type_desc((SALT30.StrType)le.cont_phone_number_type_desc),
    Fields.InValid_cont_fax_nbr((SALT30.StrType)le.cont_fax_nbr),
    Fields.InValid_cont_email_address((SALT30.StrType)le.cont_email_address),
    Fields.InValid_cont_web_address((SALT30.StrType)le.cont_web_address),
    Fields.InValid_corp_addr1_prim_range((SALT30.StrType)le.corp_addr1_prim_range),
    Fields.InValid_corp_addr1_predir((SALT30.StrType)le.corp_addr1_predir),
    Fields.InValid_corp_addr1_prim_name((SALT30.StrType)le.corp_addr1_prim_name),
    Fields.InValid_corp_addr1_addr_suffix((SALT30.StrType)le.corp_addr1_addr_suffix),
    Fields.InValid_corp_addr1_postdir((SALT30.StrType)le.corp_addr1_postdir),
    Fields.InValid_corp_addr1_unit_desig((SALT30.StrType)le.corp_addr1_unit_desig),
    Fields.InValid_corp_addr1_sec_range((SALT30.StrType)le.corp_addr1_sec_range),
    Fields.InValid_corp_addr1_p_city_name((SALT30.StrType)le.corp_addr1_p_city_name),
    Fields.InValid_corp_addr1_v_city_name((SALT30.StrType)le.corp_addr1_v_city_name),
    Fields.InValid_corp_addr1_state((SALT30.StrType)le.corp_addr1_state),
    Fields.InValid_corp_addr1_zip5((SALT30.StrType)le.corp_addr1_zip5),
    Fields.InValid_corp_addr1_zip4((SALT30.StrType)le.corp_addr1_zip4),
    Fields.InValid_corp_addr1_cart((SALT30.StrType)le.corp_addr1_cart),
    Fields.InValid_corp_addr1_cr_sort_sz((SALT30.StrType)le.corp_addr1_cr_sort_sz),
    Fields.InValid_corp_addr1_lot((SALT30.StrType)le.corp_addr1_lot),
    Fields.InValid_corp_addr1_lot_order((SALT30.StrType)le.corp_addr1_lot_order),
    Fields.InValid_corp_addr1_dpbc((SALT30.StrType)le.corp_addr1_dpbc),
    Fields.InValid_corp_addr1_chk_digit((SALT30.StrType)le.corp_addr1_chk_digit),
    Fields.InValid_corp_addr1_rec_type((SALT30.StrType)le.corp_addr1_rec_type),
    Fields.InValid_corp_addr1_ace_fips_st((SALT30.StrType)le.corp_addr1_ace_fips_st),
    Fields.InValid_corp_addr1_county((SALT30.StrType)le.corp_addr1_county),
    Fields.InValid_corp_addr1_geo_lat((SALT30.StrType)le.corp_addr1_geo_lat),
    Fields.InValid_corp_addr1_geo_long((SALT30.StrType)le.corp_addr1_geo_long),
    Fields.InValid_corp_addr1_msa((SALT30.StrType)le.corp_addr1_msa),
    Fields.InValid_corp_addr1_geo_blk((SALT30.StrType)le.corp_addr1_geo_blk),
    Fields.InValid_corp_addr1_geo_match((SALT30.StrType)le.corp_addr1_geo_match),
    Fields.InValid_corp_addr1_err_stat((SALT30.StrType)le.corp_addr1_err_stat),
    Fields.InValid_cont_title((SALT30.StrType)le.cont_title),
    Fields.InValid_cont_fname((SALT30.StrType)le.cont_fname),
    Fields.InValid_cont_mname((SALT30.StrType)le.cont_mname),
    Fields.InValid_cont_lname((SALT30.StrType)le.cont_lname),
    Fields.InValid_cont_name_suffix((SALT30.StrType)le.cont_name_suffix),
    Fields.InValid_cont_score((SALT30.StrType)le.cont_score),
    Fields.InValid_cont_cname((SALT30.StrType)le.cont_cname),
    Fields.InValid_cont_cname_score((SALT30.StrType)le.cont_cname_score),
    Fields.InValid_cont_prim_range((SALT30.StrType)le.cont_prim_range),
    Fields.InValid_cont_predir((SALT30.StrType)le.cont_predir),
    Fields.InValid_cont_prim_name((SALT30.StrType)le.cont_prim_name),
    Fields.InValid_cont_addr_suffix((SALT30.StrType)le.cont_addr_suffix),
    Fields.InValid_cont_postdir((SALT30.StrType)le.cont_postdir),
    Fields.InValid_cont_unit_desig((SALT30.StrType)le.cont_unit_desig),
    Fields.InValid_cont_sec_range((SALT30.StrType)le.cont_sec_range),
    Fields.InValid_cont_p_city_name((SALT30.StrType)le.cont_p_city_name),
    Fields.InValid_cont_v_city_name((SALT30.StrType)le.cont_v_city_name),
    Fields.InValid_cont_state((SALT30.StrType)le.cont_state),
    Fields.InValid_cont_zip5((SALT30.StrType)le.cont_zip5),
    Fields.InValid_cont_zip4((SALT30.StrType)le.cont_zip4),
    Fields.InValid_cont_cart((SALT30.StrType)le.cont_cart),
    Fields.InValid_cont_cr_sort_sz((SALT30.StrType)le.cont_cr_sort_sz),
    Fields.InValid_cont_lot((SALT30.StrType)le.cont_lot),
    Fields.InValid_cont_lot_order((SALT30.StrType)le.cont_lot_order),
    Fields.InValid_cont_dpbc((SALT30.StrType)le.cont_dpbc),
    Fields.InValid_cont_chk_digit((SALT30.StrType)le.cont_chk_digit),
    Fields.InValid_cont_rec_type((SALT30.StrType)le.cont_rec_type),
    Fields.InValid_cont_ace_fips_st((SALT30.StrType)le.cont_ace_fips_st),
    Fields.InValid_cont_county((SALT30.StrType)le.cont_county),
    Fields.InValid_cont_geo_lat((SALT30.StrType)le.cont_geo_lat),
    Fields.InValid_cont_geo_long((SALT30.StrType)le.cont_geo_long),
    Fields.InValid_cont_msa((SALT30.StrType)le.cont_msa),
    Fields.InValid_cont_geo_blk((SALT30.StrType)le.cont_geo_blk),
    Fields.InValid_cont_geo_match((SALT30.StrType)le.cont_geo_match),
    Fields.InValid_cont_err_stat((SALT30.StrType)le.cont_err_stat),
    Fields.InValid_corp_phone10((SALT30.StrType)le.corp_phone10),
    Fields.InValid_cont_phone10((SALT30.StrType)le.cont_phone10),
    Fields.InValid_record_type((SALT30.StrType)le.record_type),
    Fields.InValid_append_corp_addr_rawaid((SALT30.StrType)le.append_corp_addr_rawaid),
    Fields.InValid_append_corp_addr_aceaid((SALT30.StrType)le.append_corp_addr_aceaid),
    Fields.InValid_corp_prep_addr_line1((SALT30.StrType)le.corp_prep_addr_line1),
    Fields.InValid_corp_prep_addr_last_line((SALT30.StrType)le.corp_prep_addr_last_line),
    Fields.InValid_append_cont_addr_rawaid((SALT30.StrType)le.append_cont_addr_rawaid),
    Fields.InValid_append_cont_addr_aceaid((SALT30.StrType)le.append_cont_addr_aceaid),
    Fields.InValid_cont_prep_addr_line1((SALT30.StrType)le.cont_prep_addr_line1),
    Fields.InValid_cont_prep_addr_last_line((SALT30.StrType)le.cont_prep_addr_last_line),
    Fields.InValid_dotid((SALT30.StrType)le.dotid),
    Fields.InValid_dotscore((SALT30.StrType)le.dotscore),
    Fields.InValid_dotweight((SALT30.StrType)le.dotweight),
    Fields.InValid_empid((SALT30.StrType)le.empid),
    Fields.InValid_empscore((SALT30.StrType)le.empscore),
    Fields.InValid_empweight((SALT30.StrType)le.empweight),
    Fields.InValid_powid((SALT30.StrType)le.powid),
    Fields.InValid_powscore((SALT30.StrType)le.powscore),
    Fields.InValid_powweight((SALT30.StrType)le.powweight),
    Fields.InValid_proxid((SALT30.StrType)le.proxid),
    Fields.InValid_proxscore((SALT30.StrType)le.proxscore),
    Fields.InValid_proxweight((SALT30.StrType)le.proxweight),
    Fields.InValid_seleid((SALT30.StrType)le.seleid),
    Fields.InValid_selescore((SALT30.StrType)le.selescore),
    Fields.InValid_seleweight((SALT30.StrType)le.seleweight),
    Fields.InValid_orgid((SALT30.StrType)le.orgid),
    Fields.InValid_orgscore((SALT30.StrType)le.orgscore),
    Fields.InValid_orgweight((SALT30.StrType)le.orgweight),
    Fields.InValid_ultid((SALT30.StrType)le.ultid),
    Fields.InValid_ultscore((SALT30.StrType)le.ultscore),
    Fields.InValid_ultweight((SALT30.StrType)le.ultweight),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,159,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_corp_key','Unknown','invalid_corp_vendor','Unknown','Unknown','invalid_state_origin','invalid_date','Unknown','Unknown','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_phone','Unknown','Unknown','invalid_phone','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','invalid_phone','Unknown','Unknown','invalid_phone','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_supp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_subcode(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_corp_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_legal_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line3(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line4(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line5(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line6(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone_number_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone_number_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_fax_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_web_address(TotalErrors.ErrorNum),Fields.InValidMessage_cont_filing_reference_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_cont_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_cont_filing_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_filing_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_name(TotalErrors.ErrorNum),Fields.InValidMessage_cont_title_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_cont_fein(TotalErrors.ErrorNum),Fields.InValidMessage_cont_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_cont_dob(TotalErrors.ErrorNum),Fields.InValidMessage_cont_status_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_cont_effective_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_effective_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_addl_info(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_line1(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_line2(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_line3(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_line4(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_line5(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_line6(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_county(TotalErrors.ErrorNum),Fields.InValidMessage_cont_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_cont_phone_number_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_phone_number_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_fax_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_cont_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_cont_web_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_predir(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_cart(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_lot(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_msa(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_cont_title(TotalErrors.ErrorNum),Fields.InValidMessage_cont_fname(TotalErrors.ErrorNum),Fields.InValidMessage_cont_mname(TotalErrors.ErrorNum),Fields.InValidMessage_cont_lname(TotalErrors.ErrorNum),Fields.InValidMessage_cont_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cont_score(TotalErrors.ErrorNum),Fields.InValidMessage_cont_cname(TotalErrors.ErrorNum),Fields.InValidMessage_cont_cname_score(TotalErrors.ErrorNum),Fields.InValidMessage_cont_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_cont_predir(TotalErrors.ErrorNum),Fields.InValidMessage_cont_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_cont_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cont_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_cont_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_cont_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_cont_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_cont_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_cont_state(TotalErrors.ErrorNum),Fields.InValidMessage_cont_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_cont_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cont_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cont_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_cont_lot(TotalErrors.ErrorNum),Fields.InValidMessage_cont_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_cont_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_cont_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_cont_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_cont_county(TotalErrors.ErrorNum),Fields.InValidMessage_cont_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_cont_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_cont_msa(TotalErrors.ErrorNum),Fields.InValidMessage_cont_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_cont_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_cont_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone10(TotalErrors.ErrorNum),Fields.InValidMessage_cont_phone10(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_append_corp_addr_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_append_corp_addr_aceaid(TotalErrors.ErrorNum),Fields.InValidMessage_corp_prep_addr_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_prep_addr_last_line(TotalErrors.ErrorNum),Fields.InValidMessage_append_cont_addr_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_append_cont_addr_aceaid(TotalErrors.ErrorNum),Fields.InValidMessage_cont_prep_addr_line1(TotalErrors.ErrorNum),Fields.InValidMessage_cont_prep_addr_last_line(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
