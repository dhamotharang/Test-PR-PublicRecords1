IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_in_file) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
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
    populated_corp_ra_dt_first_seen_pcnt := AVE(GROUP,IF(h.corp_ra_dt_first_seen = (TYPEOF(h.corp_ra_dt_first_seen))'',0,100));
    maxlength_corp_ra_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_dt_first_seen)));
    avelength_corp_ra_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_dt_first_seen)),h.corp_ra_dt_first_seen<>(typeof(h.corp_ra_dt_first_seen))'');
    populated_corp_ra_dt_last_seen_pcnt := AVE(GROUP,IF(h.corp_ra_dt_last_seen = (TYPEOF(h.corp_ra_dt_last_seen))'',0,100));
    maxlength_corp_ra_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_dt_last_seen)));
    avelength_corp_ra_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_dt_last_seen)),h.corp_ra_dt_last_seen<>(typeof(h.corp_ra_dt_last_seen))'');
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
    populated_corp_src_type_pcnt := AVE(GROUP,IF(h.corp_src_type = (TYPEOF(h.corp_src_type))'',0,100));
    maxlength_corp_src_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_src_type)));
    avelength_corp_src_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_src_type)),h.corp_src_type<>(typeof(h.corp_src_type))'');
    populated_corp_legal_name_pcnt := AVE(GROUP,IF(h.corp_legal_name = (TYPEOF(h.corp_legal_name))'',0,100));
    maxlength_corp_legal_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_legal_name)));
    avelength_corp_legal_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_legal_name)),h.corp_legal_name<>(typeof(h.corp_legal_name))'');
    populated_corp_ln_name_type_cd_pcnt := AVE(GROUP,IF(h.corp_ln_name_type_cd = (TYPEOF(h.corp_ln_name_type_cd))'',0,100));
    maxlength_corp_ln_name_type_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ln_name_type_cd)));
    avelength_corp_ln_name_type_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ln_name_type_cd)),h.corp_ln_name_type_cd<>(typeof(h.corp_ln_name_type_cd))'');
    populated_corp_ln_name_type_desc_pcnt := AVE(GROUP,IF(h.corp_ln_name_type_desc = (TYPEOF(h.corp_ln_name_type_desc))'',0,100));
    maxlength_corp_ln_name_type_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ln_name_type_desc)));
    avelength_corp_ln_name_type_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ln_name_type_desc)),h.corp_ln_name_type_desc<>(typeof(h.corp_ln_name_type_desc))'');
    populated_corp_supp_nbr_pcnt := AVE(GROUP,IF(h.corp_supp_nbr = (TYPEOF(h.corp_supp_nbr))'',0,100));
    maxlength_corp_supp_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_supp_nbr)));
    avelength_corp_supp_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_supp_nbr)),h.corp_supp_nbr<>(typeof(h.corp_supp_nbr))'');
    populated_corp_name_comment_pcnt := AVE(GROUP,IF(h.corp_name_comment = (TYPEOF(h.corp_name_comment))'',0,100));
    maxlength_corp_name_comment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_name_comment)));
    avelength_corp_name_comment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_name_comment)),h.corp_name_comment<>(typeof(h.corp_name_comment))'');
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
    populated_corp_address2_type_cd_pcnt := AVE(GROUP,IF(h.corp_address2_type_cd = (TYPEOF(h.corp_address2_type_cd))'',0,100));
    maxlength_corp_address2_type_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_type_cd)));
    avelength_corp_address2_type_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_type_cd)),h.corp_address2_type_cd<>(typeof(h.corp_address2_type_cd))'');
    populated_corp_address2_type_desc_pcnt := AVE(GROUP,IF(h.corp_address2_type_desc = (TYPEOF(h.corp_address2_type_desc))'',0,100));
    maxlength_corp_address2_type_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_type_desc)));
    avelength_corp_address2_type_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_type_desc)),h.corp_address2_type_desc<>(typeof(h.corp_address2_type_desc))'');
    populated_corp_address2_line1_pcnt := AVE(GROUP,IF(h.corp_address2_line1 = (TYPEOF(h.corp_address2_line1))'',0,100));
    maxlength_corp_address2_line1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line1)));
    avelength_corp_address2_line1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line1)),h.corp_address2_line1<>(typeof(h.corp_address2_line1))'');
    populated_corp_address2_line2_pcnt := AVE(GROUP,IF(h.corp_address2_line2 = (TYPEOF(h.corp_address2_line2))'',0,100));
    maxlength_corp_address2_line2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line2)));
    avelength_corp_address2_line2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line2)),h.corp_address2_line2<>(typeof(h.corp_address2_line2))'');
    populated_corp_address2_line3_pcnt := AVE(GROUP,IF(h.corp_address2_line3 = (TYPEOF(h.corp_address2_line3))'',0,100));
    maxlength_corp_address2_line3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line3)));
    avelength_corp_address2_line3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line3)),h.corp_address2_line3<>(typeof(h.corp_address2_line3))'');
    populated_corp_address2_line4_pcnt := AVE(GROUP,IF(h.corp_address2_line4 = (TYPEOF(h.corp_address2_line4))'',0,100));
    maxlength_corp_address2_line4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line4)));
    avelength_corp_address2_line4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line4)),h.corp_address2_line4<>(typeof(h.corp_address2_line4))'');
    populated_corp_address2_line5_pcnt := AVE(GROUP,IF(h.corp_address2_line5 = (TYPEOF(h.corp_address2_line5))'',0,100));
    maxlength_corp_address2_line5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line5)));
    avelength_corp_address2_line5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line5)),h.corp_address2_line5<>(typeof(h.corp_address2_line5))'');
    populated_corp_address2_line6_pcnt := AVE(GROUP,IF(h.corp_address2_line6 = (TYPEOF(h.corp_address2_line6))'',0,100));
    maxlength_corp_address2_line6 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line6)));
    avelength_corp_address2_line6 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_line6)),h.corp_address2_line6<>(typeof(h.corp_address2_line6))'');
    populated_corp_address2_effective_date_pcnt := AVE(GROUP,IF(h.corp_address2_effective_date = (TYPEOF(h.corp_address2_effective_date))'',0,100));
    maxlength_corp_address2_effective_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_effective_date)));
    avelength_corp_address2_effective_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_address2_effective_date)),h.corp_address2_effective_date<>(typeof(h.corp_address2_effective_date))'');
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
    populated_corp_filing_reference_nbr_pcnt := AVE(GROUP,IF(h.corp_filing_reference_nbr = (TYPEOF(h.corp_filing_reference_nbr))'',0,100));
    maxlength_corp_filing_reference_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_filing_reference_nbr)));
    avelength_corp_filing_reference_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_filing_reference_nbr)),h.corp_filing_reference_nbr<>(typeof(h.corp_filing_reference_nbr))'');
    populated_corp_filing_date_pcnt := AVE(GROUP,IF(h.corp_filing_date = (TYPEOF(h.corp_filing_date))'',0,100));
    maxlength_corp_filing_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_filing_date)));
    avelength_corp_filing_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_filing_date)),h.corp_filing_date<>(typeof(h.corp_filing_date))'');
    populated_corp_filing_cd_pcnt := AVE(GROUP,IF(h.corp_filing_cd = (TYPEOF(h.corp_filing_cd))'',0,100));
    maxlength_corp_filing_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_filing_cd)));
    avelength_corp_filing_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_filing_cd)),h.corp_filing_cd<>(typeof(h.corp_filing_cd))'');
    populated_corp_filing_desc_pcnt := AVE(GROUP,IF(h.corp_filing_desc = (TYPEOF(h.corp_filing_desc))'',0,100));
    maxlength_corp_filing_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_filing_desc)));
    avelength_corp_filing_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_filing_desc)),h.corp_filing_desc<>(typeof(h.corp_filing_desc))'');
    populated_corp_status_cd_pcnt := AVE(GROUP,IF(h.corp_status_cd = (TYPEOF(h.corp_status_cd))'',0,100));
    maxlength_corp_status_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_status_cd)));
    avelength_corp_status_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_status_cd)),h.corp_status_cd<>(typeof(h.corp_status_cd))'');
    populated_corp_status_desc_pcnt := AVE(GROUP,IF(h.corp_status_desc = (TYPEOF(h.corp_status_desc))'',0,100));
    maxlength_corp_status_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_status_desc)));
    avelength_corp_status_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_status_desc)),h.corp_status_desc<>(typeof(h.corp_status_desc))'');
    populated_corp_status_date_pcnt := AVE(GROUP,IF(h.corp_status_date = (TYPEOF(h.corp_status_date))'',0,100));
    maxlength_corp_status_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_status_date)));
    avelength_corp_status_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_status_date)),h.corp_status_date<>(typeof(h.corp_status_date))'');
    populated_corp_standing_pcnt := AVE(GROUP,IF(h.corp_standing = (TYPEOF(h.corp_standing))'',0,100));
    maxlength_corp_standing := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_standing)));
    avelength_corp_standing := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_standing)),h.corp_standing<>(typeof(h.corp_standing))'');
    populated_corp_status_comment_pcnt := AVE(GROUP,IF(h.corp_status_comment = (TYPEOF(h.corp_status_comment))'',0,100));
    maxlength_corp_status_comment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_status_comment)));
    avelength_corp_status_comment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_status_comment)),h.corp_status_comment<>(typeof(h.corp_status_comment))'');
    populated_corp_ticker_symbol_pcnt := AVE(GROUP,IF(h.corp_ticker_symbol = (TYPEOF(h.corp_ticker_symbol))'',0,100));
    maxlength_corp_ticker_symbol := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ticker_symbol)));
    avelength_corp_ticker_symbol := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ticker_symbol)),h.corp_ticker_symbol<>(typeof(h.corp_ticker_symbol))'');
    populated_corp_stock_exchange_pcnt := AVE(GROUP,IF(h.corp_stock_exchange = (TYPEOF(h.corp_stock_exchange))'',0,100));
    maxlength_corp_stock_exchange := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_stock_exchange)));
    avelength_corp_stock_exchange := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_stock_exchange)),h.corp_stock_exchange<>(typeof(h.corp_stock_exchange))'');
    populated_corp_inc_state_pcnt := AVE(GROUP,IF(h.corp_inc_state = (TYPEOF(h.corp_inc_state))'',0,100));
    maxlength_corp_inc_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_inc_state)));
    avelength_corp_inc_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_inc_state)),h.corp_inc_state<>(typeof(h.corp_inc_state))'');
    populated_corp_inc_county_pcnt := AVE(GROUP,IF(h.corp_inc_county = (TYPEOF(h.corp_inc_county))'',0,100));
    maxlength_corp_inc_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_inc_county)));
    avelength_corp_inc_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_inc_county)),h.corp_inc_county<>(typeof(h.corp_inc_county))'');
    populated_corp_inc_date_pcnt := AVE(GROUP,IF(h.corp_inc_date = (TYPEOF(h.corp_inc_date))'',0,100));
    maxlength_corp_inc_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_inc_date)));
    avelength_corp_inc_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_inc_date)),h.corp_inc_date<>(typeof(h.corp_inc_date))'');
    populated_corp_anniversary_month_pcnt := AVE(GROUP,IF(h.corp_anniversary_month = (TYPEOF(h.corp_anniversary_month))'',0,100));
    maxlength_corp_anniversary_month := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_anniversary_month)));
    avelength_corp_anniversary_month := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_anniversary_month)),h.corp_anniversary_month<>(typeof(h.corp_anniversary_month))'');
    populated_corp_fed_tax_id_pcnt := AVE(GROUP,IF(h.corp_fed_tax_id = (TYPEOF(h.corp_fed_tax_id))'',0,100));
    maxlength_corp_fed_tax_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_fed_tax_id)));
    avelength_corp_fed_tax_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_fed_tax_id)),h.corp_fed_tax_id<>(typeof(h.corp_fed_tax_id))'');
    populated_corp_state_tax_id_pcnt := AVE(GROUP,IF(h.corp_state_tax_id = (TYPEOF(h.corp_state_tax_id))'',0,100));
    maxlength_corp_state_tax_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_state_tax_id)));
    avelength_corp_state_tax_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_state_tax_id)),h.corp_state_tax_id<>(typeof(h.corp_state_tax_id))'');
    populated_corp_term_exist_cd_pcnt := AVE(GROUP,IF(h.corp_term_exist_cd = (TYPEOF(h.corp_term_exist_cd))'',0,100));
    maxlength_corp_term_exist_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_term_exist_cd)));
    avelength_corp_term_exist_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_term_exist_cd)),h.corp_term_exist_cd<>(typeof(h.corp_term_exist_cd))'');
    populated_corp_term_exist_exp_pcnt := AVE(GROUP,IF(h.corp_term_exist_exp = (TYPEOF(h.corp_term_exist_exp))'',0,100));
    maxlength_corp_term_exist_exp := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_term_exist_exp)));
    avelength_corp_term_exist_exp := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_term_exist_exp)),h.corp_term_exist_exp<>(typeof(h.corp_term_exist_exp))'');
    populated_corp_term_exist_desc_pcnt := AVE(GROUP,IF(h.corp_term_exist_desc = (TYPEOF(h.corp_term_exist_desc))'',0,100));
    maxlength_corp_term_exist_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_term_exist_desc)));
    avelength_corp_term_exist_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_term_exist_desc)),h.corp_term_exist_desc<>(typeof(h.corp_term_exist_desc))'');
    populated_corp_foreign_domestic_ind_pcnt := AVE(GROUP,IF(h.corp_foreign_domestic_ind = (TYPEOF(h.corp_foreign_domestic_ind))'',0,100));
    maxlength_corp_foreign_domestic_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_foreign_domestic_ind)));
    avelength_corp_foreign_domestic_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_foreign_domestic_ind)),h.corp_foreign_domestic_ind<>(typeof(h.corp_foreign_domestic_ind))'');
    populated_corp_forgn_state_cd_pcnt := AVE(GROUP,IF(h.corp_forgn_state_cd = (TYPEOF(h.corp_forgn_state_cd))'',0,100));
    maxlength_corp_forgn_state_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_state_cd)));
    avelength_corp_forgn_state_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_state_cd)),h.corp_forgn_state_cd<>(typeof(h.corp_forgn_state_cd))'');
    populated_corp_forgn_state_desc_pcnt := AVE(GROUP,IF(h.corp_forgn_state_desc = (TYPEOF(h.corp_forgn_state_desc))'',0,100));
    maxlength_corp_forgn_state_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_state_desc)));
    avelength_corp_forgn_state_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_state_desc)),h.corp_forgn_state_desc<>(typeof(h.corp_forgn_state_desc))'');
    populated_corp_forgn_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_forgn_sos_charter_nbr = (TYPEOF(h.corp_forgn_sos_charter_nbr))'',0,100));
    maxlength_corp_forgn_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_sos_charter_nbr)));
    avelength_corp_forgn_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_sos_charter_nbr)),h.corp_forgn_sos_charter_nbr<>(typeof(h.corp_forgn_sos_charter_nbr))'');
    populated_corp_forgn_date_pcnt := AVE(GROUP,IF(h.corp_forgn_date = (TYPEOF(h.corp_forgn_date))'',0,100));
    maxlength_corp_forgn_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_date)));
    avelength_corp_forgn_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_date)),h.corp_forgn_date<>(typeof(h.corp_forgn_date))'');
    populated_corp_forgn_fed_tax_id_pcnt := AVE(GROUP,IF(h.corp_forgn_fed_tax_id = (TYPEOF(h.corp_forgn_fed_tax_id))'',0,100));
    maxlength_corp_forgn_fed_tax_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_fed_tax_id)));
    avelength_corp_forgn_fed_tax_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_fed_tax_id)),h.corp_forgn_fed_tax_id<>(typeof(h.corp_forgn_fed_tax_id))'');
    populated_corp_forgn_state_tax_id_pcnt := AVE(GROUP,IF(h.corp_forgn_state_tax_id = (TYPEOF(h.corp_forgn_state_tax_id))'',0,100));
    maxlength_corp_forgn_state_tax_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_state_tax_id)));
    avelength_corp_forgn_state_tax_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_state_tax_id)),h.corp_forgn_state_tax_id<>(typeof(h.corp_forgn_state_tax_id))'');
    populated_corp_forgn_term_exist_cd_pcnt := AVE(GROUP,IF(h.corp_forgn_term_exist_cd = (TYPEOF(h.corp_forgn_term_exist_cd))'',0,100));
    maxlength_corp_forgn_term_exist_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_term_exist_cd)));
    avelength_corp_forgn_term_exist_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_term_exist_cd)),h.corp_forgn_term_exist_cd<>(typeof(h.corp_forgn_term_exist_cd))'');
    populated_corp_forgn_term_exist_exp_pcnt := AVE(GROUP,IF(h.corp_forgn_term_exist_exp = (TYPEOF(h.corp_forgn_term_exist_exp))'',0,100));
    maxlength_corp_forgn_term_exist_exp := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_term_exist_exp)));
    avelength_corp_forgn_term_exist_exp := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_term_exist_exp)),h.corp_forgn_term_exist_exp<>(typeof(h.corp_forgn_term_exist_exp))'');
    populated_corp_forgn_term_exist_desc_pcnt := AVE(GROUP,IF(h.corp_forgn_term_exist_desc = (TYPEOF(h.corp_forgn_term_exist_desc))'',0,100));
    maxlength_corp_forgn_term_exist_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_term_exist_desc)));
    avelength_corp_forgn_term_exist_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_forgn_term_exist_desc)),h.corp_forgn_term_exist_desc<>(typeof(h.corp_forgn_term_exist_desc))'');
    populated_corp_orig_org_structure_cd_pcnt := AVE(GROUP,IF(h.corp_orig_org_structure_cd = (TYPEOF(h.corp_orig_org_structure_cd))'',0,100));
    maxlength_corp_orig_org_structure_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_orig_org_structure_cd)));
    avelength_corp_orig_org_structure_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_orig_org_structure_cd)),h.corp_orig_org_structure_cd<>(typeof(h.corp_orig_org_structure_cd))'');
    populated_corp_orig_org_structure_desc_pcnt := AVE(GROUP,IF(h.corp_orig_org_structure_desc = (TYPEOF(h.corp_orig_org_structure_desc))'',0,100));
    maxlength_corp_orig_org_structure_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_orig_org_structure_desc)));
    avelength_corp_orig_org_structure_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_orig_org_structure_desc)),h.corp_orig_org_structure_desc<>(typeof(h.corp_orig_org_structure_desc))'');
    populated_corp_for_profit_ind_pcnt := AVE(GROUP,IF(h.corp_for_profit_ind = (TYPEOF(h.corp_for_profit_ind))'',0,100));
    maxlength_corp_for_profit_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_for_profit_ind)));
    avelength_corp_for_profit_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_for_profit_ind)),h.corp_for_profit_ind<>(typeof(h.corp_for_profit_ind))'');
    populated_corp_public_or_private_ind_pcnt := AVE(GROUP,IF(h.corp_public_or_private_ind = (TYPEOF(h.corp_public_or_private_ind))'',0,100));
    maxlength_corp_public_or_private_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_public_or_private_ind)));
    avelength_corp_public_or_private_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_public_or_private_ind)),h.corp_public_or_private_ind<>(typeof(h.corp_public_or_private_ind))'');
    populated_corp_sic_code_pcnt := AVE(GROUP,IF(h.corp_sic_code = (TYPEOF(h.corp_sic_code))'',0,100));
    maxlength_corp_sic_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_sic_code)));
    avelength_corp_sic_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_sic_code)),h.corp_sic_code<>(typeof(h.corp_sic_code))'');
    populated_corp_naic_code_pcnt := AVE(GROUP,IF(h.corp_naic_code = (TYPEOF(h.corp_naic_code))'',0,100));
    maxlength_corp_naic_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_naic_code)));
    avelength_corp_naic_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_naic_code)),h.corp_naic_code<>(typeof(h.corp_naic_code))'');
    populated_corp_orig_bus_type_cd_pcnt := AVE(GROUP,IF(h.corp_orig_bus_type_cd = (TYPEOF(h.corp_orig_bus_type_cd))'',0,100));
    maxlength_corp_orig_bus_type_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_orig_bus_type_cd)));
    avelength_corp_orig_bus_type_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_orig_bus_type_cd)),h.corp_orig_bus_type_cd<>(typeof(h.corp_orig_bus_type_cd))'');
    populated_corp_orig_bus_type_desc_pcnt := AVE(GROUP,IF(h.corp_orig_bus_type_desc = (TYPEOF(h.corp_orig_bus_type_desc))'',0,100));
    maxlength_corp_orig_bus_type_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_orig_bus_type_desc)));
    avelength_corp_orig_bus_type_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_orig_bus_type_desc)),h.corp_orig_bus_type_desc<>(typeof(h.corp_orig_bus_type_desc))'');
    populated_corp_entity_desc_pcnt := AVE(GROUP,IF(h.corp_entity_desc = (TYPEOF(h.corp_entity_desc))'',0,100));
    maxlength_corp_entity_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_entity_desc)));
    avelength_corp_entity_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_entity_desc)),h.corp_entity_desc<>(typeof(h.corp_entity_desc))'');
    populated_corp_certificate_nbr_pcnt := AVE(GROUP,IF(h.corp_certificate_nbr = (TYPEOF(h.corp_certificate_nbr))'',0,100));
    maxlength_corp_certificate_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_certificate_nbr)));
    avelength_corp_certificate_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_certificate_nbr)),h.corp_certificate_nbr<>(typeof(h.corp_certificate_nbr))'');
    populated_corp_internal_nbr_pcnt := AVE(GROUP,IF(h.corp_internal_nbr = (TYPEOF(h.corp_internal_nbr))'',0,100));
    maxlength_corp_internal_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_internal_nbr)));
    avelength_corp_internal_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_internal_nbr)),h.corp_internal_nbr<>(typeof(h.corp_internal_nbr))'');
    populated_corp_previous_nbr_pcnt := AVE(GROUP,IF(h.corp_previous_nbr = (TYPEOF(h.corp_previous_nbr))'',0,100));
    maxlength_corp_previous_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_previous_nbr)));
    avelength_corp_previous_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_previous_nbr)),h.corp_previous_nbr<>(typeof(h.corp_previous_nbr))'');
    populated_corp_microfilm_nbr_pcnt := AVE(GROUP,IF(h.corp_microfilm_nbr = (TYPEOF(h.corp_microfilm_nbr))'',0,100));
    maxlength_corp_microfilm_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_microfilm_nbr)));
    avelength_corp_microfilm_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_microfilm_nbr)),h.corp_microfilm_nbr<>(typeof(h.corp_microfilm_nbr))'');
    populated_corp_amendments_filed_pcnt := AVE(GROUP,IF(h.corp_amendments_filed = (TYPEOF(h.corp_amendments_filed))'',0,100));
    maxlength_corp_amendments_filed := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_amendments_filed)));
    avelength_corp_amendments_filed := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_amendments_filed)),h.corp_amendments_filed<>(typeof(h.corp_amendments_filed))'');
    populated_corp_acts_pcnt := AVE(GROUP,IF(h.corp_acts = (TYPEOF(h.corp_acts))'',0,100));
    maxlength_corp_acts := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_acts)));
    avelength_corp_acts := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_acts)),h.corp_acts<>(typeof(h.corp_acts))'');
    populated_corp_partnership_ind_pcnt := AVE(GROUP,IF(h.corp_partnership_ind = (TYPEOF(h.corp_partnership_ind))'',0,100));
    maxlength_corp_partnership_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_partnership_ind)));
    avelength_corp_partnership_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_partnership_ind)),h.corp_partnership_ind<>(typeof(h.corp_partnership_ind))'');
    populated_corp_mfg_ind_pcnt := AVE(GROUP,IF(h.corp_mfg_ind = (TYPEOF(h.corp_mfg_ind))'',0,100));
    maxlength_corp_mfg_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_mfg_ind)));
    avelength_corp_mfg_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_mfg_ind)),h.corp_mfg_ind<>(typeof(h.corp_mfg_ind))'');
    populated_corp_addl_info_pcnt := AVE(GROUP,IF(h.corp_addl_info = (TYPEOF(h.corp_addl_info))'',0,100));
    maxlength_corp_addl_info := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addl_info)));
    avelength_corp_addl_info := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addl_info)),h.corp_addl_info<>(typeof(h.corp_addl_info))'');
    populated_corp_taxes_pcnt := AVE(GROUP,IF(h.corp_taxes = (TYPEOF(h.corp_taxes))'',0,100));
    maxlength_corp_taxes := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_taxes)));
    avelength_corp_taxes := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_taxes)),h.corp_taxes<>(typeof(h.corp_taxes))'');
    populated_corp_franchise_taxes_pcnt := AVE(GROUP,IF(h.corp_franchise_taxes = (TYPEOF(h.corp_franchise_taxes))'',0,100));
    maxlength_corp_franchise_taxes := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_franchise_taxes)));
    avelength_corp_franchise_taxes := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_franchise_taxes)),h.corp_franchise_taxes<>(typeof(h.corp_franchise_taxes))'');
    populated_corp_tax_program_cd_pcnt := AVE(GROUP,IF(h.corp_tax_program_cd = (TYPEOF(h.corp_tax_program_cd))'',0,100));
    maxlength_corp_tax_program_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_tax_program_cd)));
    avelength_corp_tax_program_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_tax_program_cd)),h.corp_tax_program_cd<>(typeof(h.corp_tax_program_cd))'');
    populated_corp_tax_program_desc_pcnt := AVE(GROUP,IF(h.corp_tax_program_desc = (TYPEOF(h.corp_tax_program_desc))'',0,100));
    maxlength_corp_tax_program_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_tax_program_desc)));
    avelength_corp_tax_program_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_tax_program_desc)),h.corp_tax_program_desc<>(typeof(h.corp_tax_program_desc))'');
    populated_corp_ra_name_pcnt := AVE(GROUP,IF(h.corp_ra_name = (TYPEOF(h.corp_ra_name))'',0,100));
    maxlength_corp_ra_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_name)));
    avelength_corp_ra_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_name)),h.corp_ra_name<>(typeof(h.corp_ra_name))'');
    populated_corp_ra_title_cd_pcnt := AVE(GROUP,IF(h.corp_ra_title_cd = (TYPEOF(h.corp_ra_title_cd))'',0,100));
    maxlength_corp_ra_title_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_title_cd)));
    avelength_corp_ra_title_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_title_cd)),h.corp_ra_title_cd<>(typeof(h.corp_ra_title_cd))'');
    populated_corp_ra_title_desc_pcnt := AVE(GROUP,IF(h.corp_ra_title_desc = (TYPEOF(h.corp_ra_title_desc))'',0,100));
    maxlength_corp_ra_title_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_title_desc)));
    avelength_corp_ra_title_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_title_desc)),h.corp_ra_title_desc<>(typeof(h.corp_ra_title_desc))'');
    populated_corp_ra_fein_pcnt := AVE(GROUP,IF(h.corp_ra_fein = (TYPEOF(h.corp_ra_fein))'',0,100));
    maxlength_corp_ra_fein := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_fein)));
    avelength_corp_ra_fein := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_fein)),h.corp_ra_fein<>(typeof(h.corp_ra_fein))'');
    populated_corp_ra_ssn_pcnt := AVE(GROUP,IF(h.corp_ra_ssn = (TYPEOF(h.corp_ra_ssn))'',0,100));
    maxlength_corp_ra_ssn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_ssn)));
    avelength_corp_ra_ssn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_ssn)),h.corp_ra_ssn<>(typeof(h.corp_ra_ssn))'');
    populated_corp_ra_dob_pcnt := AVE(GROUP,IF(h.corp_ra_dob = (TYPEOF(h.corp_ra_dob))'',0,100));
    maxlength_corp_ra_dob := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_dob)));
    avelength_corp_ra_dob := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_dob)),h.corp_ra_dob<>(typeof(h.corp_ra_dob))'');
    populated_corp_ra_effective_date_pcnt := AVE(GROUP,IF(h.corp_ra_effective_date = (TYPEOF(h.corp_ra_effective_date))'',0,100));
    maxlength_corp_ra_effective_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_effective_date)));
    avelength_corp_ra_effective_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_effective_date)),h.corp_ra_effective_date<>(typeof(h.corp_ra_effective_date))'');
    populated_corp_ra_resign_date_pcnt := AVE(GROUP,IF(h.corp_ra_resign_date = (TYPEOF(h.corp_ra_resign_date))'',0,100));
    maxlength_corp_ra_resign_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_resign_date)));
    avelength_corp_ra_resign_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_resign_date)),h.corp_ra_resign_date<>(typeof(h.corp_ra_resign_date))'');
    populated_corp_ra_no_comp_pcnt := AVE(GROUP,IF(h.corp_ra_no_comp = (TYPEOF(h.corp_ra_no_comp))'',0,100));
    maxlength_corp_ra_no_comp := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_no_comp)));
    avelength_corp_ra_no_comp := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_no_comp)),h.corp_ra_no_comp<>(typeof(h.corp_ra_no_comp))'');
    populated_corp_ra_no_comp_igs_pcnt := AVE(GROUP,IF(h.corp_ra_no_comp_igs = (TYPEOF(h.corp_ra_no_comp_igs))'',0,100));
    maxlength_corp_ra_no_comp_igs := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_no_comp_igs)));
    avelength_corp_ra_no_comp_igs := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_no_comp_igs)),h.corp_ra_no_comp_igs<>(typeof(h.corp_ra_no_comp_igs))'');
    populated_corp_ra_addl_info_pcnt := AVE(GROUP,IF(h.corp_ra_addl_info = (TYPEOF(h.corp_ra_addl_info))'',0,100));
    maxlength_corp_ra_addl_info := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_addl_info)));
    avelength_corp_ra_addl_info := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_addl_info)),h.corp_ra_addl_info<>(typeof(h.corp_ra_addl_info))'');
    populated_corp_ra_address_type_cd_pcnt := AVE(GROUP,IF(h.corp_ra_address_type_cd = (TYPEOF(h.corp_ra_address_type_cd))'',0,100));
    maxlength_corp_ra_address_type_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_type_cd)));
    avelength_corp_ra_address_type_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_type_cd)),h.corp_ra_address_type_cd<>(typeof(h.corp_ra_address_type_cd))'');
    populated_corp_ra_address_type_desc_pcnt := AVE(GROUP,IF(h.corp_ra_address_type_desc = (TYPEOF(h.corp_ra_address_type_desc))'',0,100));
    maxlength_corp_ra_address_type_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_type_desc)));
    avelength_corp_ra_address_type_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_type_desc)),h.corp_ra_address_type_desc<>(typeof(h.corp_ra_address_type_desc))'');
    populated_corp_ra_address_line1_pcnt := AVE(GROUP,IF(h.corp_ra_address_line1 = (TYPEOF(h.corp_ra_address_line1))'',0,100));
    maxlength_corp_ra_address_line1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line1)));
    avelength_corp_ra_address_line1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line1)),h.corp_ra_address_line1<>(typeof(h.corp_ra_address_line1))'');
    populated_corp_ra_address_line2_pcnt := AVE(GROUP,IF(h.corp_ra_address_line2 = (TYPEOF(h.corp_ra_address_line2))'',0,100));
    maxlength_corp_ra_address_line2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line2)));
    avelength_corp_ra_address_line2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line2)),h.corp_ra_address_line2<>(typeof(h.corp_ra_address_line2))'');
    populated_corp_ra_address_line3_pcnt := AVE(GROUP,IF(h.corp_ra_address_line3 = (TYPEOF(h.corp_ra_address_line3))'',0,100));
    maxlength_corp_ra_address_line3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line3)));
    avelength_corp_ra_address_line3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line3)),h.corp_ra_address_line3<>(typeof(h.corp_ra_address_line3))'');
    populated_corp_ra_address_line4_pcnt := AVE(GROUP,IF(h.corp_ra_address_line4 = (TYPEOF(h.corp_ra_address_line4))'',0,100));
    maxlength_corp_ra_address_line4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line4)));
    avelength_corp_ra_address_line4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line4)),h.corp_ra_address_line4<>(typeof(h.corp_ra_address_line4))'');
    populated_corp_ra_address_line5_pcnt := AVE(GROUP,IF(h.corp_ra_address_line5 = (TYPEOF(h.corp_ra_address_line5))'',0,100));
    maxlength_corp_ra_address_line5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line5)));
    avelength_corp_ra_address_line5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line5)),h.corp_ra_address_line5<>(typeof(h.corp_ra_address_line5))'');
    populated_corp_ra_address_line6_pcnt := AVE(GROUP,IF(h.corp_ra_address_line6 = (TYPEOF(h.corp_ra_address_line6))'',0,100));
    maxlength_corp_ra_address_line6 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line6)));
    avelength_corp_ra_address_line6 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_address_line6)),h.corp_ra_address_line6<>(typeof(h.corp_ra_address_line6))'');
    populated_corp_ra_phone_number_pcnt := AVE(GROUP,IF(h.corp_ra_phone_number = (TYPEOF(h.corp_ra_phone_number))'',0,100));
    maxlength_corp_ra_phone_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_phone_number)));
    avelength_corp_ra_phone_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_phone_number)),h.corp_ra_phone_number<>(typeof(h.corp_ra_phone_number))'');
    populated_corp_ra_phone_number_type_cd_pcnt := AVE(GROUP,IF(h.corp_ra_phone_number_type_cd = (TYPEOF(h.corp_ra_phone_number_type_cd))'',0,100));
    maxlength_corp_ra_phone_number_type_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_phone_number_type_cd)));
    avelength_corp_ra_phone_number_type_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_phone_number_type_cd)),h.corp_ra_phone_number_type_cd<>(typeof(h.corp_ra_phone_number_type_cd))'');
    populated_corp_ra_phone_number_type_desc_pcnt := AVE(GROUP,IF(h.corp_ra_phone_number_type_desc = (TYPEOF(h.corp_ra_phone_number_type_desc))'',0,100));
    maxlength_corp_ra_phone_number_type_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_phone_number_type_desc)));
    avelength_corp_ra_phone_number_type_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_phone_number_type_desc)),h.corp_ra_phone_number_type_desc<>(typeof(h.corp_ra_phone_number_type_desc))'');
    populated_corp_ra_fax_nbr_pcnt := AVE(GROUP,IF(h.corp_ra_fax_nbr = (TYPEOF(h.corp_ra_fax_nbr))'',0,100));
    maxlength_corp_ra_fax_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_fax_nbr)));
    avelength_corp_ra_fax_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_fax_nbr)),h.corp_ra_fax_nbr<>(typeof(h.corp_ra_fax_nbr))'');
    populated_corp_ra_email_address_pcnt := AVE(GROUP,IF(h.corp_ra_email_address = (TYPEOF(h.corp_ra_email_address))'',0,100));
    maxlength_corp_ra_email_address := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_email_address)));
    avelength_corp_ra_email_address := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_email_address)),h.corp_ra_email_address<>(typeof(h.corp_ra_email_address))'');
    populated_corp_ra_web_address_pcnt := AVE(GROUP,IF(h.corp_ra_web_address = (TYPEOF(h.corp_ra_web_address))'',0,100));
    maxlength_corp_ra_web_address := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_web_address)));
    avelength_corp_ra_web_address := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_web_address)),h.corp_ra_web_address<>(typeof(h.corp_ra_web_address))'');
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
    populated_corp_addr2_prim_range_pcnt := AVE(GROUP,IF(h.corp_addr2_prim_range = (TYPEOF(h.corp_addr2_prim_range))'',0,100));
    maxlength_corp_addr2_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_prim_range)));
    avelength_corp_addr2_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_prim_range)),h.corp_addr2_prim_range<>(typeof(h.corp_addr2_prim_range))'');
    populated_corp_addr2_predir_pcnt := AVE(GROUP,IF(h.corp_addr2_predir = (TYPEOF(h.corp_addr2_predir))'',0,100));
    maxlength_corp_addr2_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_predir)));
    avelength_corp_addr2_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_predir)),h.corp_addr2_predir<>(typeof(h.corp_addr2_predir))'');
    populated_corp_addr2_prim_name_pcnt := AVE(GROUP,IF(h.corp_addr2_prim_name = (TYPEOF(h.corp_addr2_prim_name))'',0,100));
    maxlength_corp_addr2_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_prim_name)));
    avelength_corp_addr2_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_prim_name)),h.corp_addr2_prim_name<>(typeof(h.corp_addr2_prim_name))'');
    populated_corp_addr2_addr_suffix_pcnt := AVE(GROUP,IF(h.corp_addr2_addr_suffix = (TYPEOF(h.corp_addr2_addr_suffix))'',0,100));
    maxlength_corp_addr2_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_addr_suffix)));
    avelength_corp_addr2_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_addr_suffix)),h.corp_addr2_addr_suffix<>(typeof(h.corp_addr2_addr_suffix))'');
    populated_corp_addr2_postdir_pcnt := AVE(GROUP,IF(h.corp_addr2_postdir = (TYPEOF(h.corp_addr2_postdir))'',0,100));
    maxlength_corp_addr2_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_postdir)));
    avelength_corp_addr2_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_postdir)),h.corp_addr2_postdir<>(typeof(h.corp_addr2_postdir))'');
    populated_corp_addr2_unit_desig_pcnt := AVE(GROUP,IF(h.corp_addr2_unit_desig = (TYPEOF(h.corp_addr2_unit_desig))'',0,100));
    maxlength_corp_addr2_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_unit_desig)));
    avelength_corp_addr2_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_unit_desig)),h.corp_addr2_unit_desig<>(typeof(h.corp_addr2_unit_desig))'');
    populated_corp_addr2_sec_range_pcnt := AVE(GROUP,IF(h.corp_addr2_sec_range = (TYPEOF(h.corp_addr2_sec_range))'',0,100));
    maxlength_corp_addr2_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_sec_range)));
    avelength_corp_addr2_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_sec_range)),h.corp_addr2_sec_range<>(typeof(h.corp_addr2_sec_range))'');
    populated_corp_addr2_p_city_name_pcnt := AVE(GROUP,IF(h.corp_addr2_p_city_name = (TYPEOF(h.corp_addr2_p_city_name))'',0,100));
    maxlength_corp_addr2_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_p_city_name)));
    avelength_corp_addr2_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_p_city_name)),h.corp_addr2_p_city_name<>(typeof(h.corp_addr2_p_city_name))'');
    populated_corp_addr2_v_city_name_pcnt := AVE(GROUP,IF(h.corp_addr2_v_city_name = (TYPEOF(h.corp_addr2_v_city_name))'',0,100));
    maxlength_corp_addr2_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_v_city_name)));
    avelength_corp_addr2_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_v_city_name)),h.corp_addr2_v_city_name<>(typeof(h.corp_addr2_v_city_name))'');
    populated_corp_addr2_state_pcnt := AVE(GROUP,IF(h.corp_addr2_state = (TYPEOF(h.corp_addr2_state))'',0,100));
    maxlength_corp_addr2_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_state)));
    avelength_corp_addr2_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_state)),h.corp_addr2_state<>(typeof(h.corp_addr2_state))'');
    populated_corp_addr2_zip5_pcnt := AVE(GROUP,IF(h.corp_addr2_zip5 = (TYPEOF(h.corp_addr2_zip5))'',0,100));
    maxlength_corp_addr2_zip5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_zip5)));
    avelength_corp_addr2_zip5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_zip5)),h.corp_addr2_zip5<>(typeof(h.corp_addr2_zip5))'');
    populated_corp_addr2_zip4_pcnt := AVE(GROUP,IF(h.corp_addr2_zip4 = (TYPEOF(h.corp_addr2_zip4))'',0,100));
    maxlength_corp_addr2_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_zip4)));
    avelength_corp_addr2_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_zip4)),h.corp_addr2_zip4<>(typeof(h.corp_addr2_zip4))'');
    populated_corp_addr2_cart_pcnt := AVE(GROUP,IF(h.corp_addr2_cart = (TYPEOF(h.corp_addr2_cart))'',0,100));
    maxlength_corp_addr2_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_cart)));
    avelength_corp_addr2_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_cart)),h.corp_addr2_cart<>(typeof(h.corp_addr2_cart))'');
    populated_corp_addr2_cr_sort_sz_pcnt := AVE(GROUP,IF(h.corp_addr2_cr_sort_sz = (TYPEOF(h.corp_addr2_cr_sort_sz))'',0,100));
    maxlength_corp_addr2_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_cr_sort_sz)));
    avelength_corp_addr2_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_cr_sort_sz)),h.corp_addr2_cr_sort_sz<>(typeof(h.corp_addr2_cr_sort_sz))'');
    populated_corp_addr2_lot_pcnt := AVE(GROUP,IF(h.corp_addr2_lot = (TYPEOF(h.corp_addr2_lot))'',0,100));
    maxlength_corp_addr2_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_lot)));
    avelength_corp_addr2_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_lot)),h.corp_addr2_lot<>(typeof(h.corp_addr2_lot))'');
    populated_corp_addr2_lot_order_pcnt := AVE(GROUP,IF(h.corp_addr2_lot_order = (TYPEOF(h.corp_addr2_lot_order))'',0,100));
    maxlength_corp_addr2_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_lot_order)));
    avelength_corp_addr2_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_lot_order)),h.corp_addr2_lot_order<>(typeof(h.corp_addr2_lot_order))'');
    populated_corp_addr2_dpbc_pcnt := AVE(GROUP,IF(h.corp_addr2_dpbc = (TYPEOF(h.corp_addr2_dpbc))'',0,100));
    maxlength_corp_addr2_dpbc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_dpbc)));
    avelength_corp_addr2_dpbc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_dpbc)),h.corp_addr2_dpbc<>(typeof(h.corp_addr2_dpbc))'');
    populated_corp_addr2_chk_digit_pcnt := AVE(GROUP,IF(h.corp_addr2_chk_digit = (TYPEOF(h.corp_addr2_chk_digit))'',0,100));
    maxlength_corp_addr2_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_chk_digit)));
    avelength_corp_addr2_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_chk_digit)),h.corp_addr2_chk_digit<>(typeof(h.corp_addr2_chk_digit))'');
    populated_corp_addr2_rec_type_pcnt := AVE(GROUP,IF(h.corp_addr2_rec_type = (TYPEOF(h.corp_addr2_rec_type))'',0,100));
    maxlength_corp_addr2_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_rec_type)));
    avelength_corp_addr2_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_rec_type)),h.corp_addr2_rec_type<>(typeof(h.corp_addr2_rec_type))'');
    populated_corp_addr2_ace_fips_st_pcnt := AVE(GROUP,IF(h.corp_addr2_ace_fips_st = (TYPEOF(h.corp_addr2_ace_fips_st))'',0,100));
    maxlength_corp_addr2_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_ace_fips_st)));
    avelength_corp_addr2_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_ace_fips_st)),h.corp_addr2_ace_fips_st<>(typeof(h.corp_addr2_ace_fips_st))'');
    populated_corp_addr2_county_pcnt := AVE(GROUP,IF(h.corp_addr2_county = (TYPEOF(h.corp_addr2_county))'',0,100));
    maxlength_corp_addr2_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_county)));
    avelength_corp_addr2_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_county)),h.corp_addr2_county<>(typeof(h.corp_addr2_county))'');
    populated_corp_addr2_geo_lat_pcnt := AVE(GROUP,IF(h.corp_addr2_geo_lat = (TYPEOF(h.corp_addr2_geo_lat))'',0,100));
    maxlength_corp_addr2_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_geo_lat)));
    avelength_corp_addr2_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_geo_lat)),h.corp_addr2_geo_lat<>(typeof(h.corp_addr2_geo_lat))'');
    populated_corp_addr2_geo_long_pcnt := AVE(GROUP,IF(h.corp_addr2_geo_long = (TYPEOF(h.corp_addr2_geo_long))'',0,100));
    maxlength_corp_addr2_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_geo_long)));
    avelength_corp_addr2_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_geo_long)),h.corp_addr2_geo_long<>(typeof(h.corp_addr2_geo_long))'');
    populated_corp_addr2_msa_pcnt := AVE(GROUP,IF(h.corp_addr2_msa = (TYPEOF(h.corp_addr2_msa))'',0,100));
    maxlength_corp_addr2_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_msa)));
    avelength_corp_addr2_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_msa)),h.corp_addr2_msa<>(typeof(h.corp_addr2_msa))'');
    populated_corp_addr2_geo_blk_pcnt := AVE(GROUP,IF(h.corp_addr2_geo_blk = (TYPEOF(h.corp_addr2_geo_blk))'',0,100));
    maxlength_corp_addr2_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_geo_blk)));
    avelength_corp_addr2_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_geo_blk)),h.corp_addr2_geo_blk<>(typeof(h.corp_addr2_geo_blk))'');
    populated_corp_addr2_geo_match_pcnt := AVE(GROUP,IF(h.corp_addr2_geo_match = (TYPEOF(h.corp_addr2_geo_match))'',0,100));
    maxlength_corp_addr2_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_geo_match)));
    avelength_corp_addr2_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_geo_match)),h.corp_addr2_geo_match<>(typeof(h.corp_addr2_geo_match))'');
    populated_corp_addr2_err_stat_pcnt := AVE(GROUP,IF(h.corp_addr2_err_stat = (TYPEOF(h.corp_addr2_err_stat))'',0,100));
    maxlength_corp_addr2_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_err_stat)));
    avelength_corp_addr2_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_addr2_err_stat)),h.corp_addr2_err_stat<>(typeof(h.corp_addr2_err_stat))'');
    populated_corp_ra_title1_pcnt := AVE(GROUP,IF(h.corp_ra_title1 = (TYPEOF(h.corp_ra_title1))'',0,100));
    maxlength_corp_ra_title1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_title1)));
    avelength_corp_ra_title1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_title1)),h.corp_ra_title1<>(typeof(h.corp_ra_title1))'');
    populated_corp_ra_fname1_pcnt := AVE(GROUP,IF(h.corp_ra_fname1 = (TYPEOF(h.corp_ra_fname1))'',0,100));
    maxlength_corp_ra_fname1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_fname1)));
    avelength_corp_ra_fname1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_fname1)),h.corp_ra_fname1<>(typeof(h.corp_ra_fname1))'');
    populated_corp_ra_mname1_pcnt := AVE(GROUP,IF(h.corp_ra_mname1 = (TYPEOF(h.corp_ra_mname1))'',0,100));
    maxlength_corp_ra_mname1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_mname1)));
    avelength_corp_ra_mname1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_mname1)),h.corp_ra_mname1<>(typeof(h.corp_ra_mname1))'');
    populated_corp_ra_lname1_pcnt := AVE(GROUP,IF(h.corp_ra_lname1 = (TYPEOF(h.corp_ra_lname1))'',0,100));
    maxlength_corp_ra_lname1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_lname1)));
    avelength_corp_ra_lname1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_lname1)),h.corp_ra_lname1<>(typeof(h.corp_ra_lname1))'');
    populated_corp_ra_name_suffix1_pcnt := AVE(GROUP,IF(h.corp_ra_name_suffix1 = (TYPEOF(h.corp_ra_name_suffix1))'',0,100));
    maxlength_corp_ra_name_suffix1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_name_suffix1)));
    avelength_corp_ra_name_suffix1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_name_suffix1)),h.corp_ra_name_suffix1<>(typeof(h.corp_ra_name_suffix1))'');
    populated_corp_ra_score1_pcnt := AVE(GROUP,IF(h.corp_ra_score1 = (TYPEOF(h.corp_ra_score1))'',0,100));
    maxlength_corp_ra_score1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_score1)));
    avelength_corp_ra_score1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_score1)),h.corp_ra_score1<>(typeof(h.corp_ra_score1))'');
    populated_corp_ra_title2_pcnt := AVE(GROUP,IF(h.corp_ra_title2 = (TYPEOF(h.corp_ra_title2))'',0,100));
    maxlength_corp_ra_title2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_title2)));
    avelength_corp_ra_title2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_title2)),h.corp_ra_title2<>(typeof(h.corp_ra_title2))'');
    populated_corp_ra_fname2_pcnt := AVE(GROUP,IF(h.corp_ra_fname2 = (TYPEOF(h.corp_ra_fname2))'',0,100));
    maxlength_corp_ra_fname2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_fname2)));
    avelength_corp_ra_fname2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_fname2)),h.corp_ra_fname2<>(typeof(h.corp_ra_fname2))'');
    populated_corp_ra_mname2_pcnt := AVE(GROUP,IF(h.corp_ra_mname2 = (TYPEOF(h.corp_ra_mname2))'',0,100));
    maxlength_corp_ra_mname2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_mname2)));
    avelength_corp_ra_mname2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_mname2)),h.corp_ra_mname2<>(typeof(h.corp_ra_mname2))'');
    populated_corp_ra_lname2_pcnt := AVE(GROUP,IF(h.corp_ra_lname2 = (TYPEOF(h.corp_ra_lname2))'',0,100));
    maxlength_corp_ra_lname2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_lname2)));
    avelength_corp_ra_lname2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_lname2)),h.corp_ra_lname2<>(typeof(h.corp_ra_lname2))'');
    populated_corp_ra_name_suffix2_pcnt := AVE(GROUP,IF(h.corp_ra_name_suffix2 = (TYPEOF(h.corp_ra_name_suffix2))'',0,100));
    maxlength_corp_ra_name_suffix2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_name_suffix2)));
    avelength_corp_ra_name_suffix2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_name_suffix2)),h.corp_ra_name_suffix2<>(typeof(h.corp_ra_name_suffix2))'');
    populated_corp_ra_score2_pcnt := AVE(GROUP,IF(h.corp_ra_score2 = (TYPEOF(h.corp_ra_score2))'',0,100));
    maxlength_corp_ra_score2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_score2)));
    avelength_corp_ra_score2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_score2)),h.corp_ra_score2<>(typeof(h.corp_ra_score2))'');
    populated_corp_ra_cname1_pcnt := AVE(GROUP,IF(h.corp_ra_cname1 = (TYPEOF(h.corp_ra_cname1))'',0,100));
    maxlength_corp_ra_cname1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cname1)));
    avelength_corp_ra_cname1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cname1)),h.corp_ra_cname1<>(typeof(h.corp_ra_cname1))'');
    populated_corp_ra_cname1_score_pcnt := AVE(GROUP,IF(h.corp_ra_cname1_score = (TYPEOF(h.corp_ra_cname1_score))'',0,100));
    maxlength_corp_ra_cname1_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cname1_score)));
    avelength_corp_ra_cname1_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cname1_score)),h.corp_ra_cname1_score<>(typeof(h.corp_ra_cname1_score))'');
    populated_corp_ra_cname2_pcnt := AVE(GROUP,IF(h.corp_ra_cname2 = (TYPEOF(h.corp_ra_cname2))'',0,100));
    maxlength_corp_ra_cname2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cname2)));
    avelength_corp_ra_cname2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cname2)),h.corp_ra_cname2<>(typeof(h.corp_ra_cname2))'');
    populated_corp_ra_cname2_score_pcnt := AVE(GROUP,IF(h.corp_ra_cname2_score = (TYPEOF(h.corp_ra_cname2_score))'',0,100));
    maxlength_corp_ra_cname2_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cname2_score)));
    avelength_corp_ra_cname2_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cname2_score)),h.corp_ra_cname2_score<>(typeof(h.corp_ra_cname2_score))'');
    populated_corp_ra_prim_range_pcnt := AVE(GROUP,IF(h.corp_ra_prim_range = (TYPEOF(h.corp_ra_prim_range))'',0,100));
    maxlength_corp_ra_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_prim_range)));
    avelength_corp_ra_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_prim_range)),h.corp_ra_prim_range<>(typeof(h.corp_ra_prim_range))'');
    populated_corp_ra_predir_pcnt := AVE(GROUP,IF(h.corp_ra_predir = (TYPEOF(h.corp_ra_predir))'',0,100));
    maxlength_corp_ra_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_predir)));
    avelength_corp_ra_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_predir)),h.corp_ra_predir<>(typeof(h.corp_ra_predir))'');
    populated_corp_ra_prim_name_pcnt := AVE(GROUP,IF(h.corp_ra_prim_name = (TYPEOF(h.corp_ra_prim_name))'',0,100));
    maxlength_corp_ra_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_prim_name)));
    avelength_corp_ra_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_prim_name)),h.corp_ra_prim_name<>(typeof(h.corp_ra_prim_name))'');
    populated_corp_ra_addr_suffix_pcnt := AVE(GROUP,IF(h.corp_ra_addr_suffix = (TYPEOF(h.corp_ra_addr_suffix))'',0,100));
    maxlength_corp_ra_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_addr_suffix)));
    avelength_corp_ra_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_addr_suffix)),h.corp_ra_addr_suffix<>(typeof(h.corp_ra_addr_suffix))'');
    populated_corp_ra_postdir_pcnt := AVE(GROUP,IF(h.corp_ra_postdir = (TYPEOF(h.corp_ra_postdir))'',0,100));
    maxlength_corp_ra_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_postdir)));
    avelength_corp_ra_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_postdir)),h.corp_ra_postdir<>(typeof(h.corp_ra_postdir))'');
    populated_corp_ra_unit_desig_pcnt := AVE(GROUP,IF(h.corp_ra_unit_desig = (TYPEOF(h.corp_ra_unit_desig))'',0,100));
    maxlength_corp_ra_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_unit_desig)));
    avelength_corp_ra_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_unit_desig)),h.corp_ra_unit_desig<>(typeof(h.corp_ra_unit_desig))'');
    populated_corp_ra_sec_range_pcnt := AVE(GROUP,IF(h.corp_ra_sec_range = (TYPEOF(h.corp_ra_sec_range))'',0,100));
    maxlength_corp_ra_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_sec_range)));
    avelength_corp_ra_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_sec_range)),h.corp_ra_sec_range<>(typeof(h.corp_ra_sec_range))'');
    populated_corp_ra_p_city_name_pcnt := AVE(GROUP,IF(h.corp_ra_p_city_name = (TYPEOF(h.corp_ra_p_city_name))'',0,100));
    maxlength_corp_ra_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_p_city_name)));
    avelength_corp_ra_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_p_city_name)),h.corp_ra_p_city_name<>(typeof(h.corp_ra_p_city_name))'');
    populated_corp_ra_v_city_name_pcnt := AVE(GROUP,IF(h.corp_ra_v_city_name = (TYPEOF(h.corp_ra_v_city_name))'',0,100));
    maxlength_corp_ra_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_v_city_name)));
    avelength_corp_ra_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_v_city_name)),h.corp_ra_v_city_name<>(typeof(h.corp_ra_v_city_name))'');
    populated_corp_ra_state_pcnt := AVE(GROUP,IF(h.corp_ra_state = (TYPEOF(h.corp_ra_state))'',0,100));
    maxlength_corp_ra_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_state)));
    avelength_corp_ra_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_state)),h.corp_ra_state<>(typeof(h.corp_ra_state))'');
    populated_corp_ra_zip5_pcnt := AVE(GROUP,IF(h.corp_ra_zip5 = (TYPEOF(h.corp_ra_zip5))'',0,100));
    maxlength_corp_ra_zip5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_zip5)));
    avelength_corp_ra_zip5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_zip5)),h.corp_ra_zip5<>(typeof(h.corp_ra_zip5))'');
    populated_corp_ra_zip4_pcnt := AVE(GROUP,IF(h.corp_ra_zip4 = (TYPEOF(h.corp_ra_zip4))'',0,100));
    maxlength_corp_ra_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_zip4)));
    avelength_corp_ra_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_zip4)),h.corp_ra_zip4<>(typeof(h.corp_ra_zip4))'');
    populated_corp_ra_cart_pcnt := AVE(GROUP,IF(h.corp_ra_cart = (TYPEOF(h.corp_ra_cart))'',0,100));
    maxlength_corp_ra_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cart)));
    avelength_corp_ra_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cart)),h.corp_ra_cart<>(typeof(h.corp_ra_cart))'');
    populated_corp_ra_cr_sort_sz_pcnt := AVE(GROUP,IF(h.corp_ra_cr_sort_sz = (TYPEOF(h.corp_ra_cr_sort_sz))'',0,100));
    maxlength_corp_ra_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cr_sort_sz)));
    avelength_corp_ra_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_cr_sort_sz)),h.corp_ra_cr_sort_sz<>(typeof(h.corp_ra_cr_sort_sz))'');
    populated_corp_ra_lot_pcnt := AVE(GROUP,IF(h.corp_ra_lot = (TYPEOF(h.corp_ra_lot))'',0,100));
    maxlength_corp_ra_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_lot)));
    avelength_corp_ra_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_lot)),h.corp_ra_lot<>(typeof(h.corp_ra_lot))'');
    populated_corp_ra_lot_order_pcnt := AVE(GROUP,IF(h.corp_ra_lot_order = (TYPEOF(h.corp_ra_lot_order))'',0,100));
    maxlength_corp_ra_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_lot_order)));
    avelength_corp_ra_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_lot_order)),h.corp_ra_lot_order<>(typeof(h.corp_ra_lot_order))'');
    populated_corp_ra_dpbc_pcnt := AVE(GROUP,IF(h.corp_ra_dpbc = (TYPEOF(h.corp_ra_dpbc))'',0,100));
    maxlength_corp_ra_dpbc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_dpbc)));
    avelength_corp_ra_dpbc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_dpbc)),h.corp_ra_dpbc<>(typeof(h.corp_ra_dpbc))'');
    populated_corp_ra_chk_digit_pcnt := AVE(GROUP,IF(h.corp_ra_chk_digit = (TYPEOF(h.corp_ra_chk_digit))'',0,100));
    maxlength_corp_ra_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_chk_digit)));
    avelength_corp_ra_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_chk_digit)),h.corp_ra_chk_digit<>(typeof(h.corp_ra_chk_digit))'');
    populated_corp_ra_rec_type_pcnt := AVE(GROUP,IF(h.corp_ra_rec_type = (TYPEOF(h.corp_ra_rec_type))'',0,100));
    maxlength_corp_ra_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_rec_type)));
    avelength_corp_ra_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_rec_type)),h.corp_ra_rec_type<>(typeof(h.corp_ra_rec_type))'');
    populated_corp_ra_ace_fips_st_pcnt := AVE(GROUP,IF(h.corp_ra_ace_fips_st = (TYPEOF(h.corp_ra_ace_fips_st))'',0,100));
    maxlength_corp_ra_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_ace_fips_st)));
    avelength_corp_ra_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_ace_fips_st)),h.corp_ra_ace_fips_st<>(typeof(h.corp_ra_ace_fips_st))'');
    populated_corp_ra_county_pcnt := AVE(GROUP,IF(h.corp_ra_county = (TYPEOF(h.corp_ra_county))'',0,100));
    maxlength_corp_ra_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_county)));
    avelength_corp_ra_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_county)),h.corp_ra_county<>(typeof(h.corp_ra_county))'');
    populated_corp_ra_geo_lat_pcnt := AVE(GROUP,IF(h.corp_ra_geo_lat = (TYPEOF(h.corp_ra_geo_lat))'',0,100));
    maxlength_corp_ra_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_geo_lat)));
    avelength_corp_ra_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_geo_lat)),h.corp_ra_geo_lat<>(typeof(h.corp_ra_geo_lat))'');
    populated_corp_ra_geo_long_pcnt := AVE(GROUP,IF(h.corp_ra_geo_long = (TYPEOF(h.corp_ra_geo_long))'',0,100));
    maxlength_corp_ra_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_geo_long)));
    avelength_corp_ra_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_geo_long)),h.corp_ra_geo_long<>(typeof(h.corp_ra_geo_long))'');
    populated_corp_ra_msa_pcnt := AVE(GROUP,IF(h.corp_ra_msa = (TYPEOF(h.corp_ra_msa))'',0,100));
    maxlength_corp_ra_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_msa)));
    avelength_corp_ra_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_msa)),h.corp_ra_msa<>(typeof(h.corp_ra_msa))'');
    populated_corp_ra_geo_blk_pcnt := AVE(GROUP,IF(h.corp_ra_geo_blk = (TYPEOF(h.corp_ra_geo_blk))'',0,100));
    maxlength_corp_ra_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_geo_blk)));
    avelength_corp_ra_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_geo_blk)),h.corp_ra_geo_blk<>(typeof(h.corp_ra_geo_blk))'');
    populated_corp_ra_geo_match_pcnt := AVE(GROUP,IF(h.corp_ra_geo_match = (TYPEOF(h.corp_ra_geo_match))'',0,100));
    maxlength_corp_ra_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_geo_match)));
    avelength_corp_ra_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_geo_match)),h.corp_ra_geo_match<>(typeof(h.corp_ra_geo_match))'');
    populated_corp_ra_err_stat_pcnt := AVE(GROUP,IF(h.corp_ra_err_stat = (TYPEOF(h.corp_ra_err_stat))'',0,100));
    maxlength_corp_ra_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_err_stat)));
    avelength_corp_ra_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_err_stat)),h.corp_ra_err_stat<>(typeof(h.corp_ra_err_stat))'');
    populated_corp_phone10_pcnt := AVE(GROUP,IF(h.corp_phone10 = (TYPEOF(h.corp_phone10))'',0,100));
    maxlength_corp_phone10 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_phone10)));
    avelength_corp_phone10 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_phone10)),h.corp_phone10<>(typeof(h.corp_phone10))'');
    populated_corp_ra_phone10_pcnt := AVE(GROUP,IF(h.corp_ra_phone10 = (TYPEOF(h.corp_ra_phone10))'',0,100));
    maxlength_corp_ra_phone10 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_phone10)));
    avelength_corp_ra_phone10 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_ra_phone10)),h.corp_ra_phone10<>(typeof(h.corp_ra_phone10))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_append_addr1_rawaid_pcnt := AVE(GROUP,IF(h.append_addr1_rawaid = (TYPEOF(h.append_addr1_rawaid))'',0,100));
    maxlength_append_addr1_rawaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_addr1_rawaid)));
    avelength_append_addr1_rawaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_addr1_rawaid)),h.append_addr1_rawaid<>(typeof(h.append_addr1_rawaid))'');
    populated_append_addr1_aceaid_pcnt := AVE(GROUP,IF(h.append_addr1_aceaid = (TYPEOF(h.append_addr1_aceaid))'',0,100));
    maxlength_append_addr1_aceaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_addr1_aceaid)));
    avelength_append_addr1_aceaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_addr1_aceaid)),h.append_addr1_aceaid<>(typeof(h.append_addr1_aceaid))'');
    populated_corp_prep_addr1_line1_pcnt := AVE(GROUP,IF(h.corp_prep_addr1_line1 = (TYPEOF(h.corp_prep_addr1_line1))'',0,100));
    maxlength_corp_prep_addr1_line1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr1_line1)));
    avelength_corp_prep_addr1_line1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr1_line1)),h.corp_prep_addr1_line1<>(typeof(h.corp_prep_addr1_line1))'');
    populated_corp_prep_addr1_last_line_pcnt := AVE(GROUP,IF(h.corp_prep_addr1_last_line = (TYPEOF(h.corp_prep_addr1_last_line))'',0,100));
    maxlength_corp_prep_addr1_last_line := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr1_last_line)));
    avelength_corp_prep_addr1_last_line := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr1_last_line)),h.corp_prep_addr1_last_line<>(typeof(h.corp_prep_addr1_last_line))'');
    populated_append_addr2_rawaid_pcnt := AVE(GROUP,IF(h.append_addr2_rawaid = (TYPEOF(h.append_addr2_rawaid))'',0,100));
    maxlength_append_addr2_rawaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_addr2_rawaid)));
    avelength_append_addr2_rawaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_addr2_rawaid)),h.append_addr2_rawaid<>(typeof(h.append_addr2_rawaid))'');
    populated_append_addr2_aceaid_pcnt := AVE(GROUP,IF(h.append_addr2_aceaid = (TYPEOF(h.append_addr2_aceaid))'',0,100));
    maxlength_append_addr2_aceaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_addr2_aceaid)));
    avelength_append_addr2_aceaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_addr2_aceaid)),h.append_addr2_aceaid<>(typeof(h.append_addr2_aceaid))'');
    populated_corp_prep_addr2_line1_pcnt := AVE(GROUP,IF(h.corp_prep_addr2_line1 = (TYPEOF(h.corp_prep_addr2_line1))'',0,100));
    maxlength_corp_prep_addr2_line1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr2_line1)));
    avelength_corp_prep_addr2_line1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr2_line1)),h.corp_prep_addr2_line1<>(typeof(h.corp_prep_addr2_line1))'');
    populated_corp_prep_addr2_last_line_pcnt := AVE(GROUP,IF(h.corp_prep_addr2_last_line = (TYPEOF(h.corp_prep_addr2_last_line))'',0,100));
    maxlength_corp_prep_addr2_last_line := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr2_last_line)));
    avelength_corp_prep_addr2_last_line := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_prep_addr2_last_line)),h.corp_prep_addr2_last_line<>(typeof(h.corp_prep_addr2_last_line))'');
    populated_append_ra_rawaid_pcnt := AVE(GROUP,IF(h.append_ra_rawaid = (TYPEOF(h.append_ra_rawaid))'',0,100));
    maxlength_append_ra_rawaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_ra_rawaid)));
    avelength_append_ra_rawaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_ra_rawaid)),h.append_ra_rawaid<>(typeof(h.append_ra_rawaid))'');
    populated_append_ra_aceaid_pcnt := AVE(GROUP,IF(h.append_ra_aceaid = (TYPEOF(h.append_ra_aceaid))'',0,100));
    maxlength_append_ra_aceaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_ra_aceaid)));
    avelength_append_ra_aceaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.append_ra_aceaid)),h.append_ra_aceaid<>(typeof(h.append_ra_aceaid))'');
    populated_ra_prep_addr_line1_pcnt := AVE(GROUP,IF(h.ra_prep_addr_line1 = (TYPEOF(h.ra_prep_addr_line1))'',0,100));
    maxlength_ra_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ra_prep_addr_line1)));
    avelength_ra_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ra_prep_addr_line1)),h.ra_prep_addr_line1<>(typeof(h.ra_prep_addr_line1))'');
    populated_ra_prep_addr_last_line_pcnt := AVE(GROUP,IF(h.ra_prep_addr_last_line = (TYPEOF(h.ra_prep_addr_last_line))'',0,100));
    maxlength_ra_prep_addr_last_line := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ra_prep_addr_last_line)));
    avelength_ra_prep_addr_last_line := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ra_prep_addr_last_line)),h.ra_prep_addr_last_line<>(typeof(h.ra_prep_addr_last_line))'');
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
    UNSIGNED LinkingPotential :=  + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_corp_ra_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_corp_ra_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_supp_key_pcnt *   0.00 / 100 + T.Populated_corp_vendor_pcnt *   0.00 / 100 + T.Populated_corp_vendor_county_pcnt *   0.00 / 100 + T.Populated_corp_vendor_subcode_pcnt *   0.00 / 100 + T.Populated_corp_state_origin_pcnt *   0.00 / 100 + T.Populated_corp_process_date_pcnt *   0.00 / 100 + T.Populated_corp_orig_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_corp_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_corp_src_type_pcnt *   0.00 / 100 + T.Populated_corp_legal_name_pcnt *   0.00 / 100 + T.Populated_corp_ln_name_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_ln_name_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_supp_nbr_pcnt *   0.00 / 100 + T.Populated_corp_name_comment_pcnt *   0.00 / 100 + T.Populated_corp_address1_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_address1_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_address1_line1_pcnt *   0.00 / 100 + T.Populated_corp_address1_line2_pcnt *   0.00 / 100 + T.Populated_corp_address1_line3_pcnt *   0.00 / 100 + T.Populated_corp_address1_line4_pcnt *   0.00 / 100 + T.Populated_corp_address1_line5_pcnt *   0.00 / 100 + T.Populated_corp_address1_line6_pcnt *   0.00 / 100 + T.Populated_corp_address1_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_address2_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_address2_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_address2_line1_pcnt *   0.00 / 100 + T.Populated_corp_address2_line2_pcnt *   0.00 / 100 + T.Populated_corp_address2_line3_pcnt *   0.00 / 100 + T.Populated_corp_address2_line4_pcnt *   0.00 / 100 + T.Populated_corp_address2_line5_pcnt *   0.00 / 100 + T.Populated_corp_address2_line6_pcnt *   0.00 / 100 + T.Populated_corp_address2_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_phone_number_pcnt *   0.00 / 100 + T.Populated_corp_phone_number_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_phone_number_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_fax_nbr_pcnt *   0.00 / 100 + T.Populated_corp_email_address_pcnt *   0.00 / 100 + T.Populated_corp_web_address_pcnt *   0.00 / 100 + T.Populated_corp_filing_reference_nbr_pcnt *   0.00 / 100 + T.Populated_corp_filing_date_pcnt *   0.00 / 100 + T.Populated_corp_filing_cd_pcnt *   0.00 / 100 + T.Populated_corp_filing_desc_pcnt *   0.00 / 100 + T.Populated_corp_status_cd_pcnt *   0.00 / 100 + T.Populated_corp_status_desc_pcnt *   0.00 / 100 + T.Populated_corp_status_date_pcnt *   0.00 / 100 + T.Populated_corp_standing_pcnt *   0.00 / 100 + T.Populated_corp_status_comment_pcnt *   0.00 / 100 + T.Populated_corp_ticker_symbol_pcnt *   0.00 / 100 + T.Populated_corp_stock_exchange_pcnt *   0.00 / 100 + T.Populated_corp_inc_state_pcnt *   0.00 / 100 + T.Populated_corp_inc_county_pcnt *   0.00 / 100 + T.Populated_corp_inc_date_pcnt *   0.00 / 100 + T.Populated_corp_anniversary_month_pcnt *   0.00 / 100 + T.Populated_corp_fed_tax_id_pcnt *   0.00 / 100 + T.Populated_corp_state_tax_id_pcnt *   0.00 / 100 + T.Populated_corp_term_exist_cd_pcnt *   0.00 / 100 + T.Populated_corp_term_exist_exp_pcnt *   0.00 / 100 + T.Populated_corp_term_exist_desc_pcnt *   0.00 / 100 + T.Populated_corp_foreign_domestic_ind_pcnt *   0.00 / 100 + T.Populated_corp_forgn_state_cd_pcnt *   0.00 / 100 + T.Populated_corp_forgn_state_desc_pcnt *   0.00 / 100 + T.Populated_corp_forgn_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_corp_forgn_date_pcnt *   0.00 / 100 + T.Populated_corp_forgn_fed_tax_id_pcnt *   0.00 / 100 + T.Populated_corp_forgn_state_tax_id_pcnt *   0.00 / 100 + T.Populated_corp_forgn_term_exist_cd_pcnt *   0.00 / 100 + T.Populated_corp_forgn_term_exist_exp_pcnt *   0.00 / 100 + T.Populated_corp_forgn_term_exist_desc_pcnt *   0.00 / 100 + T.Populated_corp_orig_org_structure_cd_pcnt *   0.00 / 100 + T.Populated_corp_orig_org_structure_desc_pcnt *   0.00 / 100 + T.Populated_corp_for_profit_ind_pcnt *   0.00 / 100 + T.Populated_corp_public_or_private_ind_pcnt *   0.00 / 100 + T.Populated_corp_sic_code_pcnt *   0.00 / 100 + T.Populated_corp_naic_code_pcnt *   0.00 / 100 + T.Populated_corp_orig_bus_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_orig_bus_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_entity_desc_pcnt *   0.00 / 100 + T.Populated_corp_certificate_nbr_pcnt *   0.00 / 100 + T.Populated_corp_internal_nbr_pcnt *   0.00 / 100 + T.Populated_corp_previous_nbr_pcnt *   0.00 / 100 + T.Populated_corp_microfilm_nbr_pcnt *   0.00 / 100 + T.Populated_corp_amendments_filed_pcnt *   0.00 / 100 + T.Populated_corp_acts_pcnt *   0.00 / 100 + T.Populated_corp_partnership_ind_pcnt *   0.00 / 100 + T.Populated_corp_mfg_ind_pcnt *   0.00 / 100 + T.Populated_corp_addl_info_pcnt *   0.00 / 100 + T.Populated_corp_taxes_pcnt *   0.00 / 100 + T.Populated_corp_franchise_taxes_pcnt *   0.00 / 100 + T.Populated_corp_tax_program_cd_pcnt *   0.00 / 100 + T.Populated_corp_tax_program_desc_pcnt *   0.00 / 100 + T.Populated_corp_ra_name_pcnt *   0.00 / 100 + T.Populated_corp_ra_title_cd_pcnt *   0.00 / 100 + T.Populated_corp_ra_title_desc_pcnt *   0.00 / 100 + T.Populated_corp_ra_fein_pcnt *   0.00 / 100 + T.Populated_corp_ra_ssn_pcnt *   0.00 / 100 + T.Populated_corp_ra_dob_pcnt *   0.00 / 100 + T.Populated_corp_ra_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_ra_resign_date_pcnt *   0.00 / 100 + T.Populated_corp_ra_no_comp_pcnt *   0.00 / 100 + T.Populated_corp_ra_no_comp_igs_pcnt *   0.00 / 100 + T.Populated_corp_ra_addl_info_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_line1_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_line2_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_line3_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_line4_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_line5_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_line6_pcnt *   0.00 / 100 + T.Populated_corp_ra_phone_number_pcnt *   0.00 / 100 + T.Populated_corp_ra_phone_number_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_ra_phone_number_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_ra_fax_nbr_pcnt *   0.00 / 100 + T.Populated_corp_ra_email_address_pcnt *   0.00 / 100 + T.Populated_corp_ra_web_address_pcnt *   0.00 / 100 + T.Populated_corp_addr1_prim_range_pcnt *   0.00 / 100 + T.Populated_corp_addr1_predir_pcnt *   0.00 / 100 + T.Populated_corp_addr1_prim_name_pcnt *   0.00 / 100 + T.Populated_corp_addr1_addr_suffix_pcnt *   0.00 / 100 + T.Populated_corp_addr1_postdir_pcnt *   0.00 / 100 + T.Populated_corp_addr1_unit_desig_pcnt *   0.00 / 100 + T.Populated_corp_addr1_sec_range_pcnt *   0.00 / 100 + T.Populated_corp_addr1_p_city_name_pcnt *   0.00 / 100 + T.Populated_corp_addr1_v_city_name_pcnt *   0.00 / 100 + T.Populated_corp_addr1_state_pcnt *   0.00 / 100 + T.Populated_corp_addr1_zip5_pcnt *   0.00 / 100 + T.Populated_corp_addr1_zip4_pcnt *   0.00 / 100 + T.Populated_corp_addr1_cart_pcnt *   0.00 / 100 + T.Populated_corp_addr1_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_corp_addr1_lot_pcnt *   0.00 / 100 + T.Populated_corp_addr1_lot_order_pcnt *   0.00 / 100 + T.Populated_corp_addr1_dpbc_pcnt *   0.00 / 100 + T.Populated_corp_addr1_chk_digit_pcnt *   0.00 / 100 + T.Populated_corp_addr1_rec_type_pcnt *   0.00 / 100 + T.Populated_corp_addr1_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_corp_addr1_county_pcnt *   0.00 / 100 + T.Populated_corp_addr1_geo_lat_pcnt *   0.00 / 100 + T.Populated_corp_addr1_geo_long_pcnt *   0.00 / 100 + T.Populated_corp_addr1_msa_pcnt *   0.00 / 100 + T.Populated_corp_addr1_geo_blk_pcnt *   0.00 / 100 + T.Populated_corp_addr1_geo_match_pcnt *   0.00 / 100 + T.Populated_corp_addr1_err_stat_pcnt *   0.00 / 100 + T.Populated_corp_addr2_prim_range_pcnt *   0.00 / 100 + T.Populated_corp_addr2_predir_pcnt *   0.00 / 100 + T.Populated_corp_addr2_prim_name_pcnt *   0.00 / 100 + T.Populated_corp_addr2_addr_suffix_pcnt *   0.00 / 100 + T.Populated_corp_addr2_postdir_pcnt *   0.00 / 100 + T.Populated_corp_addr2_unit_desig_pcnt *   0.00 / 100 + T.Populated_corp_addr2_sec_range_pcnt *   0.00 / 100 + T.Populated_corp_addr2_p_city_name_pcnt *   0.00 / 100 + T.Populated_corp_addr2_v_city_name_pcnt *   0.00 / 100 + T.Populated_corp_addr2_state_pcnt *   0.00 / 100 + T.Populated_corp_addr2_zip5_pcnt *   0.00 / 100 + T.Populated_corp_addr2_zip4_pcnt *   0.00 / 100 + T.Populated_corp_addr2_cart_pcnt *   0.00 / 100 + T.Populated_corp_addr2_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_corp_addr2_lot_pcnt *   0.00 / 100 + T.Populated_corp_addr2_lot_order_pcnt *   0.00 / 100 + T.Populated_corp_addr2_dpbc_pcnt *   0.00 / 100 + T.Populated_corp_addr2_chk_digit_pcnt *   0.00 / 100 + T.Populated_corp_addr2_rec_type_pcnt *   0.00 / 100 + T.Populated_corp_addr2_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_corp_addr2_county_pcnt *   0.00 / 100 + T.Populated_corp_addr2_geo_lat_pcnt *   0.00 / 100 + T.Populated_corp_addr2_geo_long_pcnt *   0.00 / 100 + T.Populated_corp_addr2_msa_pcnt *   0.00 / 100 + T.Populated_corp_addr2_geo_blk_pcnt *   0.00 / 100 + T.Populated_corp_addr2_geo_match_pcnt *   0.00 / 100 + T.Populated_corp_addr2_err_stat_pcnt *   0.00 / 100 + T.Populated_corp_ra_title1_pcnt *   0.00 / 100 + T.Populated_corp_ra_fname1_pcnt *   0.00 / 100 + T.Populated_corp_ra_mname1_pcnt *   0.00 / 100 + T.Populated_corp_ra_lname1_pcnt *   0.00 / 100 + T.Populated_corp_ra_name_suffix1_pcnt *   0.00 / 100 + T.Populated_corp_ra_score1_pcnt *   0.00 / 100 + T.Populated_corp_ra_title2_pcnt *   0.00 / 100 + T.Populated_corp_ra_fname2_pcnt *   0.00 / 100 + T.Populated_corp_ra_mname2_pcnt *   0.00 / 100 + T.Populated_corp_ra_lname2_pcnt *   0.00 / 100 + T.Populated_corp_ra_name_suffix2_pcnt *   0.00 / 100 + T.Populated_corp_ra_score2_pcnt *   0.00 / 100 + T.Populated_corp_ra_cname1_pcnt *   0.00 / 100 + T.Populated_corp_ra_cname1_score_pcnt *   0.00 / 100 + T.Populated_corp_ra_cname2_pcnt *   0.00 / 100 + T.Populated_corp_ra_cname2_score_pcnt *   0.00 / 100 + T.Populated_corp_ra_prim_range_pcnt *   0.00 / 100 + T.Populated_corp_ra_predir_pcnt *   0.00 / 100 + T.Populated_corp_ra_prim_name_pcnt *   0.00 / 100 + T.Populated_corp_ra_addr_suffix_pcnt *   0.00 / 100 + T.Populated_corp_ra_postdir_pcnt *   0.00 / 100 + T.Populated_corp_ra_unit_desig_pcnt *   0.00 / 100 + T.Populated_corp_ra_sec_range_pcnt *   0.00 / 100 + T.Populated_corp_ra_p_city_name_pcnt *   0.00 / 100 + T.Populated_corp_ra_v_city_name_pcnt *   0.00 / 100 + T.Populated_corp_ra_state_pcnt *   0.00 / 100 + T.Populated_corp_ra_zip5_pcnt *   0.00 / 100 + T.Populated_corp_ra_zip4_pcnt *   0.00 / 100 + T.Populated_corp_ra_cart_pcnt *   0.00 / 100 + T.Populated_corp_ra_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_corp_ra_lot_pcnt *   0.00 / 100 + T.Populated_corp_ra_lot_order_pcnt *   0.00 / 100 + T.Populated_corp_ra_dpbc_pcnt *   0.00 / 100 + T.Populated_corp_ra_chk_digit_pcnt *   0.00 / 100 + T.Populated_corp_ra_rec_type_pcnt *   0.00 / 100 + T.Populated_corp_ra_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_corp_ra_county_pcnt *   0.00 / 100 + T.Populated_corp_ra_geo_lat_pcnt *   0.00 / 100 + T.Populated_corp_ra_geo_long_pcnt *   0.00 / 100 + T.Populated_corp_ra_msa_pcnt *   0.00 / 100 + T.Populated_corp_ra_geo_blk_pcnt *   0.00 / 100 + T.Populated_corp_ra_geo_match_pcnt *   0.00 / 100 + T.Populated_corp_ra_err_stat_pcnt *   0.00 / 100 + T.Populated_corp_phone10_pcnt *   0.00 / 100 + T.Populated_corp_ra_phone10_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_append_addr1_rawaid_pcnt *   0.00 / 100 + T.Populated_append_addr1_aceaid_pcnt *   0.00 / 100 + T.Populated_corp_prep_addr1_line1_pcnt *   0.00 / 100 + T.Populated_corp_prep_addr1_last_line_pcnt *   0.00 / 100 + T.Populated_append_addr2_rawaid_pcnt *   0.00 / 100 + T.Populated_append_addr2_aceaid_pcnt *   0.00 / 100 + T.Populated_corp_prep_addr2_line1_pcnt *   0.00 / 100 + T.Populated_corp_prep_addr2_last_line_pcnt *   0.00 / 100 + T.Populated_append_ra_rawaid_pcnt *   0.00 / 100 + T.Populated_append_ra_aceaid_pcnt *   0.00 / 100 + T.Populated_ra_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_ra_prep_addr_last_line_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'source_rec_id','bdid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_sos_charter_nbr','corp_src_type','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_supp_nbr','corp_name_comment','corp_address1_type_cd','corp_address1_type_desc','corp_address1_line1','corp_address1_line2','corp_address1_line3','corp_address1_line4','corp_address1_line5','corp_address1_line6','corp_address1_effective_date','corp_address2_type_cd','corp_address2_type_desc','corp_address2_line1','corp_address2_line2','corp_address2_line3','corp_address2_line4','corp_address2_line5','corp_address2_line6','corp_address2_effective_date','corp_phone_number','corp_phone_number_type_cd','corp_phone_number_type_desc','corp_fax_nbr','corp_email_address','corp_web_address','corp_filing_reference_nbr','corp_filing_date','corp_filing_cd','corp_filing_desc','corp_status_cd','corp_status_desc','corp_status_date','corp_standing','corp_status_comment','corp_ticker_symbol','corp_stock_exchange','corp_inc_state','corp_inc_county','corp_inc_date','corp_anniversary_month','corp_fed_tax_id','corp_state_tax_id','corp_term_exist_cd','corp_term_exist_exp','corp_term_exist_desc','corp_foreign_domestic_ind','corp_forgn_state_cd','corp_forgn_state_desc','corp_forgn_sos_charter_nbr','corp_forgn_date','corp_forgn_fed_tax_id','corp_forgn_state_tax_id','corp_forgn_term_exist_cd','corp_forgn_term_exist_exp','corp_forgn_term_exist_desc','corp_orig_org_structure_cd','corp_orig_org_structure_desc','corp_for_profit_ind','corp_public_or_private_ind','corp_sic_code','corp_naic_code','corp_orig_bus_type_cd','corp_orig_bus_type_desc','corp_entity_desc','corp_certificate_nbr','corp_internal_nbr','corp_previous_nbr','corp_microfilm_nbr','corp_amendments_filed','corp_acts','corp_partnership_ind','corp_mfg_ind','corp_addl_info','corp_taxes','corp_franchise_taxes','corp_tax_program_cd','corp_tax_program_desc','corp_ra_name','corp_ra_title_cd','corp_ra_title_desc','corp_ra_fein','corp_ra_ssn','corp_ra_dob','corp_ra_effective_date','corp_ra_resign_date','corp_ra_no_comp','corp_ra_no_comp_igs','corp_ra_addl_info','corp_ra_address_type_cd','corp_ra_address_type_desc','corp_ra_address_line1','corp_ra_address_line2','corp_ra_address_line3','corp_ra_address_line4','corp_ra_address_line5','corp_ra_address_line6','corp_ra_phone_number','corp_ra_phone_number_type_cd','corp_ra_phone_number_type_desc','corp_ra_fax_nbr','corp_ra_email_address','corp_ra_web_address','corp_addr1_prim_range','corp_addr1_predir','corp_addr1_prim_name','corp_addr1_addr_suffix','corp_addr1_postdir','corp_addr1_unit_desig','corp_addr1_sec_range','corp_addr1_p_city_name','corp_addr1_v_city_name','corp_addr1_state','corp_addr1_zip5','corp_addr1_zip4','corp_addr1_cart','corp_addr1_cr_sort_sz','corp_addr1_lot','corp_addr1_lot_order','corp_addr1_dpbc','corp_addr1_chk_digit','corp_addr1_rec_type','corp_addr1_ace_fips_st','corp_addr1_county','corp_addr1_geo_lat','corp_addr1_geo_long','corp_addr1_msa','corp_addr1_geo_blk','corp_addr1_geo_match','corp_addr1_err_stat','corp_addr2_prim_range','corp_addr2_predir','corp_addr2_prim_name','corp_addr2_addr_suffix','corp_addr2_postdir','corp_addr2_unit_desig','corp_addr2_sec_range','corp_addr2_p_city_name','corp_addr2_v_city_name','corp_addr2_state','corp_addr2_zip5','corp_addr2_zip4','corp_addr2_cart','corp_addr2_cr_sort_sz','corp_addr2_lot','corp_addr2_lot_order','corp_addr2_dpbc','corp_addr2_chk_digit','corp_addr2_rec_type','corp_addr2_ace_fips_st','corp_addr2_county','corp_addr2_geo_lat','corp_addr2_geo_long','corp_addr2_msa','corp_addr2_geo_blk','corp_addr2_geo_match','corp_addr2_err_stat','corp_ra_title1','corp_ra_fname1','corp_ra_mname1','corp_ra_lname1','corp_ra_name_suffix1','corp_ra_score1','corp_ra_title2','corp_ra_fname2','corp_ra_mname2','corp_ra_lname2','corp_ra_name_suffix2','corp_ra_score2','corp_ra_cname1','corp_ra_cname1_score','corp_ra_cname2','corp_ra_cname2_score','corp_ra_prim_range','corp_ra_predir','corp_ra_prim_name','corp_ra_addr_suffix','corp_ra_postdir','corp_ra_unit_desig','corp_ra_sec_range','corp_ra_p_city_name','corp_ra_v_city_name','corp_ra_state','corp_ra_zip5','corp_ra_zip4','corp_ra_cart','corp_ra_cr_sort_sz','corp_ra_lot','corp_ra_lot_order','corp_ra_dpbc','corp_ra_chk_digit','corp_ra_rec_type','corp_ra_ace_fips_st','corp_ra_county','corp_ra_geo_lat','corp_ra_geo_long','corp_ra_msa','corp_ra_geo_blk','corp_ra_geo_match','corp_ra_err_stat','corp_phone10','corp_ra_phone10','record_type','append_addr1_rawaid','append_addr1_aceaid','corp_prep_addr1_line1','corp_prep_addr1_last_line','append_addr2_rawaid','append_addr2_aceaid','corp_prep_addr2_line1','corp_prep_addr2_last_line','append_ra_rawaid','append_ra_aceaid','ra_prep_addr_line1','ra_prep_addr_last_line','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
  SELF.populated_pcnt := CHOOSE(C,le.populated_source_rec_id_pcnt,le.populated_bdid_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_corp_ra_dt_first_seen_pcnt,le.populated_corp_ra_dt_last_seen_pcnt,le.populated_corp_key_pcnt,le.populated_corp_supp_key_pcnt,le.populated_corp_vendor_pcnt,le.populated_corp_vendor_county_pcnt,le.populated_corp_vendor_subcode_pcnt,le.populated_corp_state_origin_pcnt,le.populated_corp_process_date_pcnt,le.populated_corp_orig_sos_charter_nbr_pcnt,le.populated_corp_sos_charter_nbr_pcnt,le.populated_corp_src_type_pcnt,le.populated_corp_legal_name_pcnt,le.populated_corp_ln_name_type_cd_pcnt,le.populated_corp_ln_name_type_desc_pcnt,le.populated_corp_supp_nbr_pcnt,le.populated_corp_name_comment_pcnt,le.populated_corp_address1_type_cd_pcnt,le.populated_corp_address1_type_desc_pcnt,le.populated_corp_address1_line1_pcnt,le.populated_corp_address1_line2_pcnt,le.populated_corp_address1_line3_pcnt,le.populated_corp_address1_line4_pcnt,le.populated_corp_address1_line5_pcnt,le.populated_corp_address1_line6_pcnt,le.populated_corp_address1_effective_date_pcnt,le.populated_corp_address2_type_cd_pcnt,le.populated_corp_address2_type_desc_pcnt,le.populated_corp_address2_line1_pcnt,le.populated_corp_address2_line2_pcnt,le.populated_corp_address2_line3_pcnt,le.populated_corp_address2_line4_pcnt,le.populated_corp_address2_line5_pcnt,le.populated_corp_address2_line6_pcnt,le.populated_corp_address2_effective_date_pcnt,le.populated_corp_phone_number_pcnt,le.populated_corp_phone_number_type_cd_pcnt,le.populated_corp_phone_number_type_desc_pcnt,le.populated_corp_fax_nbr_pcnt,le.populated_corp_email_address_pcnt,le.populated_corp_web_address_pcnt,le.populated_corp_filing_reference_nbr_pcnt,le.populated_corp_filing_date_pcnt,le.populated_corp_filing_cd_pcnt,le.populated_corp_filing_desc_pcnt,le.populated_corp_status_cd_pcnt,le.populated_corp_status_desc_pcnt,le.populated_corp_status_date_pcnt,le.populated_corp_standing_pcnt,le.populated_corp_status_comment_pcnt,le.populated_corp_ticker_symbol_pcnt,le.populated_corp_stock_exchange_pcnt,le.populated_corp_inc_state_pcnt,le.populated_corp_inc_county_pcnt,le.populated_corp_inc_date_pcnt,le.populated_corp_anniversary_month_pcnt,le.populated_corp_fed_tax_id_pcnt,le.populated_corp_state_tax_id_pcnt,le.populated_corp_term_exist_cd_pcnt,le.populated_corp_term_exist_exp_pcnt,le.populated_corp_term_exist_desc_pcnt,le.populated_corp_foreign_domestic_ind_pcnt,le.populated_corp_forgn_state_cd_pcnt,le.populated_corp_forgn_state_desc_pcnt,le.populated_corp_forgn_sos_charter_nbr_pcnt,le.populated_corp_forgn_date_pcnt,le.populated_corp_forgn_fed_tax_id_pcnt,le.populated_corp_forgn_state_tax_id_pcnt,le.populated_corp_forgn_term_exist_cd_pcnt,le.populated_corp_forgn_term_exist_exp_pcnt,le.populated_corp_forgn_term_exist_desc_pcnt,le.populated_corp_orig_org_structure_cd_pcnt,le.populated_corp_orig_org_structure_desc_pcnt,le.populated_corp_for_profit_ind_pcnt,le.populated_corp_public_or_private_ind_pcnt,le.populated_corp_sic_code_pcnt,le.populated_corp_naic_code_pcnt,le.populated_corp_orig_bus_type_cd_pcnt,le.populated_corp_orig_bus_type_desc_pcnt,le.populated_corp_entity_desc_pcnt,le.populated_corp_certificate_nbr_pcnt,le.populated_corp_internal_nbr_pcnt,le.populated_corp_previous_nbr_pcnt,le.populated_corp_microfilm_nbr_pcnt,le.populated_corp_amendments_filed_pcnt,le.populated_corp_acts_pcnt,le.populated_corp_partnership_ind_pcnt,le.populated_corp_mfg_ind_pcnt,le.populated_corp_addl_info_pcnt,le.populated_corp_taxes_pcnt,le.populated_corp_franchise_taxes_pcnt,le.populated_corp_tax_program_cd_pcnt,le.populated_corp_tax_program_desc_pcnt,le.populated_corp_ra_name_pcnt,le.populated_corp_ra_title_cd_pcnt,le.populated_corp_ra_title_desc_pcnt,le.populated_corp_ra_fein_pcnt,le.populated_corp_ra_ssn_pcnt,le.populated_corp_ra_dob_pcnt,le.populated_corp_ra_effective_date_pcnt,le.populated_corp_ra_resign_date_pcnt,le.populated_corp_ra_no_comp_pcnt,le.populated_corp_ra_no_comp_igs_pcnt,le.populated_corp_ra_addl_info_pcnt,le.populated_corp_ra_address_type_cd_pcnt,le.populated_corp_ra_address_type_desc_pcnt,le.populated_corp_ra_address_line1_pcnt,le.populated_corp_ra_address_line2_pcnt,le.populated_corp_ra_address_line3_pcnt,le.populated_corp_ra_address_line4_pcnt,le.populated_corp_ra_address_line5_pcnt,le.populated_corp_ra_address_line6_pcnt,le.populated_corp_ra_phone_number_pcnt,le.populated_corp_ra_phone_number_type_cd_pcnt,le.populated_corp_ra_phone_number_type_desc_pcnt,le.populated_corp_ra_fax_nbr_pcnt,le.populated_corp_ra_email_address_pcnt,le.populated_corp_ra_web_address_pcnt,le.populated_corp_addr1_prim_range_pcnt,le.populated_corp_addr1_predir_pcnt,le.populated_corp_addr1_prim_name_pcnt,le.populated_corp_addr1_addr_suffix_pcnt,le.populated_corp_addr1_postdir_pcnt,le.populated_corp_addr1_unit_desig_pcnt,le.populated_corp_addr1_sec_range_pcnt,le.populated_corp_addr1_p_city_name_pcnt,le.populated_corp_addr1_v_city_name_pcnt,le.populated_corp_addr1_state_pcnt,le.populated_corp_addr1_zip5_pcnt,le.populated_corp_addr1_zip4_pcnt,le.populated_corp_addr1_cart_pcnt,le.populated_corp_addr1_cr_sort_sz_pcnt,le.populated_corp_addr1_lot_pcnt,le.populated_corp_addr1_lot_order_pcnt,le.populated_corp_addr1_dpbc_pcnt,le.populated_corp_addr1_chk_digit_pcnt,le.populated_corp_addr1_rec_type_pcnt,le.populated_corp_addr1_ace_fips_st_pcnt,le.populated_corp_addr1_county_pcnt,le.populated_corp_addr1_geo_lat_pcnt,le.populated_corp_addr1_geo_long_pcnt,le.populated_corp_addr1_msa_pcnt,le.populated_corp_addr1_geo_blk_pcnt,le.populated_corp_addr1_geo_match_pcnt,le.populated_corp_addr1_err_stat_pcnt,le.populated_corp_addr2_prim_range_pcnt,le.populated_corp_addr2_predir_pcnt,le.populated_corp_addr2_prim_name_pcnt,le.populated_corp_addr2_addr_suffix_pcnt,le.populated_corp_addr2_postdir_pcnt,le.populated_corp_addr2_unit_desig_pcnt,le.populated_corp_addr2_sec_range_pcnt,le.populated_corp_addr2_p_city_name_pcnt,le.populated_corp_addr2_v_city_name_pcnt,le.populated_corp_addr2_state_pcnt,le.populated_corp_addr2_zip5_pcnt,le.populated_corp_addr2_zip4_pcnt,le.populated_corp_addr2_cart_pcnt,le.populated_corp_addr2_cr_sort_sz_pcnt,le.populated_corp_addr2_lot_pcnt,le.populated_corp_addr2_lot_order_pcnt,le.populated_corp_addr2_dpbc_pcnt,le.populated_corp_addr2_chk_digit_pcnt,le.populated_corp_addr2_rec_type_pcnt,le.populated_corp_addr2_ace_fips_st_pcnt,le.populated_corp_addr2_county_pcnt,le.populated_corp_addr2_geo_lat_pcnt,le.populated_corp_addr2_geo_long_pcnt,le.populated_corp_addr2_msa_pcnt,le.populated_corp_addr2_geo_blk_pcnt,le.populated_corp_addr2_geo_match_pcnt,le.populated_corp_addr2_err_stat_pcnt,le.populated_corp_ra_title1_pcnt,le.populated_corp_ra_fname1_pcnt,le.populated_corp_ra_mname1_pcnt,le.populated_corp_ra_lname1_pcnt,le.populated_corp_ra_name_suffix1_pcnt,le.populated_corp_ra_score1_pcnt,le.populated_corp_ra_title2_pcnt,le.populated_corp_ra_fname2_pcnt,le.populated_corp_ra_mname2_pcnt,le.populated_corp_ra_lname2_pcnt,le.populated_corp_ra_name_suffix2_pcnt,le.populated_corp_ra_score2_pcnt,le.populated_corp_ra_cname1_pcnt,le.populated_corp_ra_cname1_score_pcnt,le.populated_corp_ra_cname2_pcnt,le.populated_corp_ra_cname2_score_pcnt,le.populated_corp_ra_prim_range_pcnt,le.populated_corp_ra_predir_pcnt,le.populated_corp_ra_prim_name_pcnt,le.populated_corp_ra_addr_suffix_pcnt,le.populated_corp_ra_postdir_pcnt,le.populated_corp_ra_unit_desig_pcnt,le.populated_corp_ra_sec_range_pcnt,le.populated_corp_ra_p_city_name_pcnt,le.populated_corp_ra_v_city_name_pcnt,le.populated_corp_ra_state_pcnt,le.populated_corp_ra_zip5_pcnt,le.populated_corp_ra_zip4_pcnt,le.populated_corp_ra_cart_pcnt,le.populated_corp_ra_cr_sort_sz_pcnt,le.populated_corp_ra_lot_pcnt,le.populated_corp_ra_lot_order_pcnt,le.populated_corp_ra_dpbc_pcnt,le.populated_corp_ra_chk_digit_pcnt,le.populated_corp_ra_rec_type_pcnt,le.populated_corp_ra_ace_fips_st_pcnt,le.populated_corp_ra_county_pcnt,le.populated_corp_ra_geo_lat_pcnt,le.populated_corp_ra_geo_long_pcnt,le.populated_corp_ra_msa_pcnt,le.populated_corp_ra_geo_blk_pcnt,le.populated_corp_ra_geo_match_pcnt,le.populated_corp_ra_err_stat_pcnt,le.populated_corp_phone10_pcnt,le.populated_corp_ra_phone10_pcnt,le.populated_record_type_pcnt,le.populated_append_addr1_rawaid_pcnt,le.populated_append_addr1_aceaid_pcnt,le.populated_corp_prep_addr1_line1_pcnt,le.populated_corp_prep_addr1_last_line_pcnt,le.populated_append_addr2_rawaid_pcnt,le.populated_append_addr2_aceaid_pcnt,le.populated_corp_prep_addr2_line1_pcnt,le.populated_corp_prep_addr2_last_line_pcnt,le.populated_append_ra_rawaid_pcnt,le.populated_append_ra_aceaid_pcnt,le.populated_ra_prep_addr_line1_pcnt,le.populated_ra_prep_addr_last_line_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_source_rec_id,le.maxlength_bdid,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_corp_ra_dt_first_seen,le.maxlength_corp_ra_dt_last_seen,le.maxlength_corp_key,le.maxlength_corp_supp_key,le.maxlength_corp_vendor,le.maxlength_corp_vendor_county,le.maxlength_corp_vendor_subcode,le.maxlength_corp_state_origin,le.maxlength_corp_process_date,le.maxlength_corp_orig_sos_charter_nbr,le.maxlength_corp_sos_charter_nbr,le.maxlength_corp_src_type,le.maxlength_corp_legal_name,le.maxlength_corp_ln_name_type_cd,le.maxlength_corp_ln_name_type_desc,le.maxlength_corp_supp_nbr,le.maxlength_corp_name_comment,le.maxlength_corp_address1_type_cd,le.maxlength_corp_address1_type_desc,le.maxlength_corp_address1_line1,le.maxlength_corp_address1_line2,le.maxlength_corp_address1_line3,le.maxlength_corp_address1_line4,le.maxlength_corp_address1_line5,le.maxlength_corp_address1_line6,le.maxlength_corp_address1_effective_date,le.maxlength_corp_address2_type_cd,le.maxlength_corp_address2_type_desc,le.maxlength_corp_address2_line1,le.maxlength_corp_address2_line2,le.maxlength_corp_address2_line3,le.maxlength_corp_address2_line4,le.maxlength_corp_address2_line5,le.maxlength_corp_address2_line6,le.maxlength_corp_address2_effective_date,le.maxlength_corp_phone_number,le.maxlength_corp_phone_number_type_cd,le.maxlength_corp_phone_number_type_desc,le.maxlength_corp_fax_nbr,le.maxlength_corp_email_address,le.maxlength_corp_web_address,le.maxlength_corp_filing_reference_nbr,le.maxlength_corp_filing_date,le.maxlength_corp_filing_cd,le.maxlength_corp_filing_desc,le.maxlength_corp_status_cd,le.maxlength_corp_status_desc,le.maxlength_corp_status_date,le.maxlength_corp_standing,le.maxlength_corp_status_comment,le.maxlength_corp_ticker_symbol,le.maxlength_corp_stock_exchange,le.maxlength_corp_inc_state,le.maxlength_corp_inc_county,le.maxlength_corp_inc_date,le.maxlength_corp_anniversary_month,le.maxlength_corp_fed_tax_id,le.maxlength_corp_state_tax_id,le.maxlength_corp_term_exist_cd,le.maxlength_corp_term_exist_exp,le.maxlength_corp_term_exist_desc,le.maxlength_corp_foreign_domestic_ind,le.maxlength_corp_forgn_state_cd,le.maxlength_corp_forgn_state_desc,le.maxlength_corp_forgn_sos_charter_nbr,le.maxlength_corp_forgn_date,le.maxlength_corp_forgn_fed_tax_id,le.maxlength_corp_forgn_state_tax_id,le.maxlength_corp_forgn_term_exist_cd,le.maxlength_corp_forgn_term_exist_exp,le.maxlength_corp_forgn_term_exist_desc,le.maxlength_corp_orig_org_structure_cd,le.maxlength_corp_orig_org_structure_desc,le.maxlength_corp_for_profit_ind,le.maxlength_corp_public_or_private_ind,le.maxlength_corp_sic_code,le.maxlength_corp_naic_code,le.maxlength_corp_orig_bus_type_cd,le.maxlength_corp_orig_bus_type_desc,le.maxlength_corp_entity_desc,le.maxlength_corp_certificate_nbr,le.maxlength_corp_internal_nbr,le.maxlength_corp_previous_nbr,le.maxlength_corp_microfilm_nbr,le.maxlength_corp_amendments_filed,le.maxlength_corp_acts,le.maxlength_corp_partnership_ind,le.maxlength_corp_mfg_ind,le.maxlength_corp_addl_info,le.maxlength_corp_taxes,le.maxlength_corp_franchise_taxes,le.maxlength_corp_tax_program_cd,le.maxlength_corp_tax_program_desc,le.maxlength_corp_ra_name,le.maxlength_corp_ra_title_cd,le.maxlength_corp_ra_title_desc,le.maxlength_corp_ra_fein,le.maxlength_corp_ra_ssn,le.maxlength_corp_ra_dob,le.maxlength_corp_ra_effective_date,le.maxlength_corp_ra_resign_date,le.maxlength_corp_ra_no_comp,le.maxlength_corp_ra_no_comp_igs,le.maxlength_corp_ra_addl_info,le.maxlength_corp_ra_address_type_cd,le.maxlength_corp_ra_address_type_desc,le.maxlength_corp_ra_address_line1,le.maxlength_corp_ra_address_line2,le.maxlength_corp_ra_address_line3,le.maxlength_corp_ra_address_line4,le.maxlength_corp_ra_address_line5,le.maxlength_corp_ra_address_line6,le.maxlength_corp_ra_phone_number,le.maxlength_corp_ra_phone_number_type_cd,le.maxlength_corp_ra_phone_number_type_desc,le.maxlength_corp_ra_fax_nbr,le.maxlength_corp_ra_email_address,le.maxlength_corp_ra_web_address,le.maxlength_corp_addr1_prim_range,le.maxlength_corp_addr1_predir,le.maxlength_corp_addr1_prim_name,le.maxlength_corp_addr1_addr_suffix,le.maxlength_corp_addr1_postdir,le.maxlength_corp_addr1_unit_desig,le.maxlength_corp_addr1_sec_range,le.maxlength_corp_addr1_p_city_name,le.maxlength_corp_addr1_v_city_name,le.maxlength_corp_addr1_state,le.maxlength_corp_addr1_zip5,le.maxlength_corp_addr1_zip4,le.maxlength_corp_addr1_cart,le.maxlength_corp_addr1_cr_sort_sz,le.maxlength_corp_addr1_lot,le.maxlength_corp_addr1_lot_order,le.maxlength_corp_addr1_dpbc,le.maxlength_corp_addr1_chk_digit,le.maxlength_corp_addr1_rec_type,le.maxlength_corp_addr1_ace_fips_st,le.maxlength_corp_addr1_county,le.maxlength_corp_addr1_geo_lat,le.maxlength_corp_addr1_geo_long,le.maxlength_corp_addr1_msa,le.maxlength_corp_addr1_geo_blk,le.maxlength_corp_addr1_geo_match,le.maxlength_corp_addr1_err_stat,le.maxlength_corp_addr2_prim_range,le.maxlength_corp_addr2_predir,le.maxlength_corp_addr2_prim_name,le.maxlength_corp_addr2_addr_suffix,le.maxlength_corp_addr2_postdir,le.maxlength_corp_addr2_unit_desig,le.maxlength_corp_addr2_sec_range,le.maxlength_corp_addr2_p_city_name,le.maxlength_corp_addr2_v_city_name,le.maxlength_corp_addr2_state,le.maxlength_corp_addr2_zip5,le.maxlength_corp_addr2_zip4,le.maxlength_corp_addr2_cart,le.maxlength_corp_addr2_cr_sort_sz,le.maxlength_corp_addr2_lot,le.maxlength_corp_addr2_lot_order,le.maxlength_corp_addr2_dpbc,le.maxlength_corp_addr2_chk_digit,le.maxlength_corp_addr2_rec_type,le.maxlength_corp_addr2_ace_fips_st,le.maxlength_corp_addr2_county,le.maxlength_corp_addr2_geo_lat,le.maxlength_corp_addr2_geo_long,le.maxlength_corp_addr2_msa,le.maxlength_corp_addr2_geo_blk,le.maxlength_corp_addr2_geo_match,le.maxlength_corp_addr2_err_stat,le.maxlength_corp_ra_title1,le.maxlength_corp_ra_fname1,le.maxlength_corp_ra_mname1,le.maxlength_corp_ra_lname1,le.maxlength_corp_ra_name_suffix1,le.maxlength_corp_ra_score1,le.maxlength_corp_ra_title2,le.maxlength_corp_ra_fname2,le.maxlength_corp_ra_mname2,le.maxlength_corp_ra_lname2,le.maxlength_corp_ra_name_suffix2,le.maxlength_corp_ra_score2,le.maxlength_corp_ra_cname1,le.maxlength_corp_ra_cname1_score,le.maxlength_corp_ra_cname2,le.maxlength_corp_ra_cname2_score,le.maxlength_corp_ra_prim_range,le.maxlength_corp_ra_predir,le.maxlength_corp_ra_prim_name,le.maxlength_corp_ra_addr_suffix,le.maxlength_corp_ra_postdir,le.maxlength_corp_ra_unit_desig,le.maxlength_corp_ra_sec_range,le.maxlength_corp_ra_p_city_name,le.maxlength_corp_ra_v_city_name,le.maxlength_corp_ra_state,le.maxlength_corp_ra_zip5,le.maxlength_corp_ra_zip4,le.maxlength_corp_ra_cart,le.maxlength_corp_ra_cr_sort_sz,le.maxlength_corp_ra_lot,le.maxlength_corp_ra_lot_order,le.maxlength_corp_ra_dpbc,le.maxlength_corp_ra_chk_digit,le.maxlength_corp_ra_rec_type,le.maxlength_corp_ra_ace_fips_st,le.maxlength_corp_ra_county,le.maxlength_corp_ra_geo_lat,le.maxlength_corp_ra_geo_long,le.maxlength_corp_ra_msa,le.maxlength_corp_ra_geo_blk,le.maxlength_corp_ra_geo_match,le.maxlength_corp_ra_err_stat,le.maxlength_corp_phone10,le.maxlength_corp_ra_phone10,le.maxlength_record_type,le.maxlength_append_addr1_rawaid,le.maxlength_append_addr1_aceaid,le.maxlength_corp_prep_addr1_line1,le.maxlength_corp_prep_addr1_last_line,le.maxlength_append_addr2_rawaid,le.maxlength_append_addr2_aceaid,le.maxlength_corp_prep_addr2_line1,le.maxlength_corp_prep_addr2_last_line,le.maxlength_append_ra_rawaid,le.maxlength_append_ra_aceaid,le.maxlength_ra_prep_addr_line1,le.maxlength_ra_prep_addr_last_line,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight);
  SELF.avelength := CHOOSE(C,le.avelength_source_rec_id,le.avelength_bdid,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_corp_ra_dt_first_seen,le.avelength_corp_ra_dt_last_seen,le.avelength_corp_key,le.avelength_corp_supp_key,le.avelength_corp_vendor,le.avelength_corp_vendor_county,le.avelength_corp_vendor_subcode,le.avelength_corp_state_origin,le.avelength_corp_process_date,le.avelength_corp_orig_sos_charter_nbr,le.avelength_corp_sos_charter_nbr,le.avelength_corp_src_type,le.avelength_corp_legal_name,le.avelength_corp_ln_name_type_cd,le.avelength_corp_ln_name_type_desc,le.avelength_corp_supp_nbr,le.avelength_corp_name_comment,le.avelength_corp_address1_type_cd,le.avelength_corp_address1_type_desc,le.avelength_corp_address1_line1,le.avelength_corp_address1_line2,le.avelength_corp_address1_line3,le.avelength_corp_address1_line4,le.avelength_corp_address1_line5,le.avelength_corp_address1_line6,le.avelength_corp_address1_effective_date,le.avelength_corp_address2_type_cd,le.avelength_corp_address2_type_desc,le.avelength_corp_address2_line1,le.avelength_corp_address2_line2,le.avelength_corp_address2_line3,le.avelength_corp_address2_line4,le.avelength_corp_address2_line5,le.avelength_corp_address2_line6,le.avelength_corp_address2_effective_date,le.avelength_corp_phone_number,le.avelength_corp_phone_number_type_cd,le.avelength_corp_phone_number_type_desc,le.avelength_corp_fax_nbr,le.avelength_corp_email_address,le.avelength_corp_web_address,le.avelength_corp_filing_reference_nbr,le.avelength_corp_filing_date,le.avelength_corp_filing_cd,le.avelength_corp_filing_desc,le.avelength_corp_status_cd,le.avelength_corp_status_desc,le.avelength_corp_status_date,le.avelength_corp_standing,le.avelength_corp_status_comment,le.avelength_corp_ticker_symbol,le.avelength_corp_stock_exchange,le.avelength_corp_inc_state,le.avelength_corp_inc_county,le.avelength_corp_inc_date,le.avelength_corp_anniversary_month,le.avelength_corp_fed_tax_id,le.avelength_corp_state_tax_id,le.avelength_corp_term_exist_cd,le.avelength_corp_term_exist_exp,le.avelength_corp_term_exist_desc,le.avelength_corp_foreign_domestic_ind,le.avelength_corp_forgn_state_cd,le.avelength_corp_forgn_state_desc,le.avelength_corp_forgn_sos_charter_nbr,le.avelength_corp_forgn_date,le.avelength_corp_forgn_fed_tax_id,le.avelength_corp_forgn_state_tax_id,le.avelength_corp_forgn_term_exist_cd,le.avelength_corp_forgn_term_exist_exp,le.avelength_corp_forgn_term_exist_desc,le.avelength_corp_orig_org_structure_cd,le.avelength_corp_orig_org_structure_desc,le.avelength_corp_for_profit_ind,le.avelength_corp_public_or_private_ind,le.avelength_corp_sic_code,le.avelength_corp_naic_code,le.avelength_corp_orig_bus_type_cd,le.avelength_corp_orig_bus_type_desc,le.avelength_corp_entity_desc,le.avelength_corp_certificate_nbr,le.avelength_corp_internal_nbr,le.avelength_corp_previous_nbr,le.avelength_corp_microfilm_nbr,le.avelength_corp_amendments_filed,le.avelength_corp_acts,le.avelength_corp_partnership_ind,le.avelength_corp_mfg_ind,le.avelength_corp_addl_info,le.avelength_corp_taxes,le.avelength_corp_franchise_taxes,le.avelength_corp_tax_program_cd,le.avelength_corp_tax_program_desc,le.avelength_corp_ra_name,le.avelength_corp_ra_title_cd,le.avelength_corp_ra_title_desc,le.avelength_corp_ra_fein,le.avelength_corp_ra_ssn,le.avelength_corp_ra_dob,le.avelength_corp_ra_effective_date,le.avelength_corp_ra_resign_date,le.avelength_corp_ra_no_comp,le.avelength_corp_ra_no_comp_igs,le.avelength_corp_ra_addl_info,le.avelength_corp_ra_address_type_cd,le.avelength_corp_ra_address_type_desc,le.avelength_corp_ra_address_line1,le.avelength_corp_ra_address_line2,le.avelength_corp_ra_address_line3,le.avelength_corp_ra_address_line4,le.avelength_corp_ra_address_line5,le.avelength_corp_ra_address_line6,le.avelength_corp_ra_phone_number,le.avelength_corp_ra_phone_number_type_cd,le.avelength_corp_ra_phone_number_type_desc,le.avelength_corp_ra_fax_nbr,le.avelength_corp_ra_email_address,le.avelength_corp_ra_web_address,le.avelength_corp_addr1_prim_range,le.avelength_corp_addr1_predir,le.avelength_corp_addr1_prim_name,le.avelength_corp_addr1_addr_suffix,le.avelength_corp_addr1_postdir,le.avelength_corp_addr1_unit_desig,le.avelength_corp_addr1_sec_range,le.avelength_corp_addr1_p_city_name,le.avelength_corp_addr1_v_city_name,le.avelength_corp_addr1_state,le.avelength_corp_addr1_zip5,le.avelength_corp_addr1_zip4,le.avelength_corp_addr1_cart,le.avelength_corp_addr1_cr_sort_sz,le.avelength_corp_addr1_lot,le.avelength_corp_addr1_lot_order,le.avelength_corp_addr1_dpbc,le.avelength_corp_addr1_chk_digit,le.avelength_corp_addr1_rec_type,le.avelength_corp_addr1_ace_fips_st,le.avelength_corp_addr1_county,le.avelength_corp_addr1_geo_lat,le.avelength_corp_addr1_geo_long,le.avelength_corp_addr1_msa,le.avelength_corp_addr1_geo_blk,le.avelength_corp_addr1_geo_match,le.avelength_corp_addr1_err_stat,le.avelength_corp_addr2_prim_range,le.avelength_corp_addr2_predir,le.avelength_corp_addr2_prim_name,le.avelength_corp_addr2_addr_suffix,le.avelength_corp_addr2_postdir,le.avelength_corp_addr2_unit_desig,le.avelength_corp_addr2_sec_range,le.avelength_corp_addr2_p_city_name,le.avelength_corp_addr2_v_city_name,le.avelength_corp_addr2_state,le.avelength_corp_addr2_zip5,le.avelength_corp_addr2_zip4,le.avelength_corp_addr2_cart,le.avelength_corp_addr2_cr_sort_sz,le.avelength_corp_addr2_lot,le.avelength_corp_addr2_lot_order,le.avelength_corp_addr2_dpbc,le.avelength_corp_addr2_chk_digit,le.avelength_corp_addr2_rec_type,le.avelength_corp_addr2_ace_fips_st,le.avelength_corp_addr2_county,le.avelength_corp_addr2_geo_lat,le.avelength_corp_addr2_geo_long,le.avelength_corp_addr2_msa,le.avelength_corp_addr2_geo_blk,le.avelength_corp_addr2_geo_match,le.avelength_corp_addr2_err_stat,le.avelength_corp_ra_title1,le.avelength_corp_ra_fname1,le.avelength_corp_ra_mname1,le.avelength_corp_ra_lname1,le.avelength_corp_ra_name_suffix1,le.avelength_corp_ra_score1,le.avelength_corp_ra_title2,le.avelength_corp_ra_fname2,le.avelength_corp_ra_mname2,le.avelength_corp_ra_lname2,le.avelength_corp_ra_name_suffix2,le.avelength_corp_ra_score2,le.avelength_corp_ra_cname1,le.avelength_corp_ra_cname1_score,le.avelength_corp_ra_cname2,le.avelength_corp_ra_cname2_score,le.avelength_corp_ra_prim_range,le.avelength_corp_ra_predir,le.avelength_corp_ra_prim_name,le.avelength_corp_ra_addr_suffix,le.avelength_corp_ra_postdir,le.avelength_corp_ra_unit_desig,le.avelength_corp_ra_sec_range,le.avelength_corp_ra_p_city_name,le.avelength_corp_ra_v_city_name,le.avelength_corp_ra_state,le.avelength_corp_ra_zip5,le.avelength_corp_ra_zip4,le.avelength_corp_ra_cart,le.avelength_corp_ra_cr_sort_sz,le.avelength_corp_ra_lot,le.avelength_corp_ra_lot_order,le.avelength_corp_ra_dpbc,le.avelength_corp_ra_chk_digit,le.avelength_corp_ra_rec_type,le.avelength_corp_ra_ace_fips_st,le.avelength_corp_ra_county,le.avelength_corp_ra_geo_lat,le.avelength_corp_ra_geo_long,le.avelength_corp_ra_msa,le.avelength_corp_ra_geo_blk,le.avelength_corp_ra_geo_match,le.avelength_corp_ra_err_stat,le.avelength_corp_phone10,le.avelength_corp_ra_phone10,le.avelength_record_type,le.avelength_append_addr1_rawaid,le.avelength_append_addr1_aceaid,le.avelength_corp_prep_addr1_line1,le.avelength_corp_prep_addr1_last_line,le.avelength_append_addr2_rawaid,le.avelength_append_addr2_aceaid,le.avelength_corp_prep_addr2_line1,le.avelength_corp_prep_addr2_last_line,le.avelength_append_ra_rawaid,le.avelength_append_ra_aceaid,le.avelength_ra_prep_addr_line1,le.avelength_ra_prep_addr_last_line,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight);
END;
EXPORT invSummary := NORMALIZE(summary0, 257, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.source_rec_id),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.corp_ra_dt_first_seen),TRIM((SALT30.StrType)le.corp_ra_dt_last_seen),TRIM((SALT30.StrType)le.corp_key),TRIM((SALT30.StrType)le.corp_supp_key),TRIM((SALT30.StrType)le.corp_vendor),TRIM((SALT30.StrType)le.corp_vendor_county),TRIM((SALT30.StrType)le.corp_vendor_subcode),TRIM((SALT30.StrType)le.corp_state_origin),TRIM((SALT30.StrType)le.corp_process_date),TRIM((SALT30.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_src_type),TRIM((SALT30.StrType)le.corp_legal_name),TRIM((SALT30.StrType)le.corp_ln_name_type_cd),TRIM((SALT30.StrType)le.corp_ln_name_type_desc),TRIM((SALT30.StrType)le.corp_supp_nbr),TRIM((SALT30.StrType)le.corp_name_comment),TRIM((SALT30.StrType)le.corp_address1_type_cd),TRIM((SALT30.StrType)le.corp_address1_type_desc),TRIM((SALT30.StrType)le.corp_address1_line1),TRIM((SALT30.StrType)le.corp_address1_line2),TRIM((SALT30.StrType)le.corp_address1_line3),TRIM((SALT30.StrType)le.corp_address1_line4),TRIM((SALT30.StrType)le.corp_address1_line5),TRIM((SALT30.StrType)le.corp_address1_line6),TRIM((SALT30.StrType)le.corp_address1_effective_date),TRIM((SALT30.StrType)le.corp_address2_type_cd),TRIM((SALT30.StrType)le.corp_address2_type_desc),TRIM((SALT30.StrType)le.corp_address2_line1),TRIM((SALT30.StrType)le.corp_address2_line2),TRIM((SALT30.StrType)le.corp_address2_line3),TRIM((SALT30.StrType)le.corp_address2_line4),TRIM((SALT30.StrType)le.corp_address2_line5),TRIM((SALT30.StrType)le.corp_address2_line6),TRIM((SALT30.StrType)le.corp_address2_effective_date),TRIM((SALT30.StrType)le.corp_phone_number),TRIM((SALT30.StrType)le.corp_phone_number_type_cd),TRIM((SALT30.StrType)le.corp_phone_number_type_desc),TRIM((SALT30.StrType)le.corp_fax_nbr),TRIM((SALT30.StrType)le.corp_email_address),TRIM((SALT30.StrType)le.corp_web_address),TRIM((SALT30.StrType)le.corp_filing_reference_nbr),TRIM((SALT30.StrType)le.corp_filing_date),TRIM((SALT30.StrType)le.corp_filing_cd),TRIM((SALT30.StrType)le.corp_filing_desc),TRIM((SALT30.StrType)le.corp_status_cd),TRIM((SALT30.StrType)le.corp_status_desc),TRIM((SALT30.StrType)le.corp_status_date),TRIM((SALT30.StrType)le.corp_standing),TRIM((SALT30.StrType)le.corp_status_comment),TRIM((SALT30.StrType)le.corp_ticker_symbol),TRIM((SALT30.StrType)le.corp_stock_exchange),TRIM((SALT30.StrType)le.corp_inc_state),TRIM((SALT30.StrType)le.corp_inc_county),TRIM((SALT30.StrType)le.corp_inc_date),TRIM((SALT30.StrType)le.corp_anniversary_month),TRIM((SALT30.StrType)le.corp_fed_tax_id),TRIM((SALT30.StrType)le.corp_state_tax_id),TRIM((SALT30.StrType)le.corp_term_exist_cd),TRIM((SALT30.StrType)le.corp_term_exist_exp),TRIM((SALT30.StrType)le.corp_term_exist_desc),TRIM((SALT30.StrType)le.corp_foreign_domestic_ind),TRIM((SALT30.StrType)le.corp_forgn_state_cd),TRIM((SALT30.StrType)le.corp_forgn_state_desc),TRIM((SALT30.StrType)le.corp_forgn_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_forgn_date),TRIM((SALT30.StrType)le.corp_forgn_fed_tax_id),TRIM((SALT30.StrType)le.corp_forgn_state_tax_id),TRIM((SALT30.StrType)le.corp_forgn_term_exist_cd),TRIM((SALT30.StrType)le.corp_forgn_term_exist_exp),TRIM((SALT30.StrType)le.corp_forgn_term_exist_desc),TRIM((SALT30.StrType)le.corp_orig_org_structure_cd),TRIM((SALT30.StrType)le.corp_orig_org_structure_desc),TRIM((SALT30.StrType)le.corp_for_profit_ind),TRIM((SALT30.StrType)le.corp_public_or_private_ind),TRIM((SALT30.StrType)le.corp_sic_code),TRIM((SALT30.StrType)le.corp_naic_code),TRIM((SALT30.StrType)le.corp_orig_bus_type_cd),TRIM((SALT30.StrType)le.corp_orig_bus_type_desc),TRIM((SALT30.StrType)le.corp_entity_desc),TRIM((SALT30.StrType)le.corp_certificate_nbr),TRIM((SALT30.StrType)le.corp_internal_nbr),TRIM((SALT30.StrType)le.corp_previous_nbr),TRIM((SALT30.StrType)le.corp_microfilm_nbr),TRIM((SALT30.StrType)le.corp_amendments_filed),TRIM((SALT30.StrType)le.corp_acts),TRIM((SALT30.StrType)le.corp_partnership_ind),TRIM((SALT30.StrType)le.corp_mfg_ind),TRIM((SALT30.StrType)le.corp_addl_info),TRIM((SALT30.StrType)le.corp_taxes),TRIM((SALT30.StrType)le.corp_franchise_taxes),TRIM((SALT30.StrType)le.corp_tax_program_cd),TRIM((SALT30.StrType)le.corp_tax_program_desc),TRIM((SALT30.StrType)le.corp_ra_name),TRIM((SALT30.StrType)le.corp_ra_title_cd),TRIM((SALT30.StrType)le.corp_ra_title_desc),TRIM((SALT30.StrType)le.corp_ra_fein),TRIM((SALT30.StrType)le.corp_ra_ssn),TRIM((SALT30.StrType)le.corp_ra_dob),TRIM((SALT30.StrType)le.corp_ra_effective_date),TRIM((SALT30.StrType)le.corp_ra_resign_date),TRIM((SALT30.StrType)le.corp_ra_no_comp),TRIM((SALT30.StrType)le.corp_ra_no_comp_igs),TRIM((SALT30.StrType)le.corp_ra_addl_info),TRIM((SALT30.StrType)le.corp_ra_address_type_cd),TRIM((SALT30.StrType)le.corp_ra_address_type_desc),TRIM((SALT30.StrType)le.corp_ra_address_line1),TRIM((SALT30.StrType)le.corp_ra_address_line2),TRIM((SALT30.StrType)le.corp_ra_address_line3),TRIM((SALT30.StrType)le.corp_ra_address_line4),TRIM((SALT30.StrType)le.corp_ra_address_line5),TRIM((SALT30.StrType)le.corp_ra_address_line6),TRIM((SALT30.StrType)le.corp_ra_phone_number),TRIM((SALT30.StrType)le.corp_ra_phone_number_type_cd),TRIM((SALT30.StrType)le.corp_ra_phone_number_type_desc),TRIM((SALT30.StrType)le.corp_ra_fax_nbr),TRIM((SALT30.StrType)le.corp_ra_email_address),TRIM((SALT30.StrType)le.corp_ra_web_address),TRIM((SALT30.StrType)le.corp_addr1_prim_range),TRIM((SALT30.StrType)le.corp_addr1_predir),TRIM((SALT30.StrType)le.corp_addr1_prim_name),TRIM((SALT30.StrType)le.corp_addr1_addr_suffix),TRIM((SALT30.StrType)le.corp_addr1_postdir),TRIM((SALT30.StrType)le.corp_addr1_unit_desig),TRIM((SALT30.StrType)le.corp_addr1_sec_range),TRIM((SALT30.StrType)le.corp_addr1_p_city_name),TRIM((SALT30.StrType)le.corp_addr1_v_city_name),TRIM((SALT30.StrType)le.corp_addr1_state),TRIM((SALT30.StrType)le.corp_addr1_zip5),TRIM((SALT30.StrType)le.corp_addr1_zip4),TRIM((SALT30.StrType)le.corp_addr1_cart),TRIM((SALT30.StrType)le.corp_addr1_cr_sort_sz),TRIM((SALT30.StrType)le.corp_addr1_lot),TRIM((SALT30.StrType)le.corp_addr1_lot_order),TRIM((SALT30.StrType)le.corp_addr1_dpbc),TRIM((SALT30.StrType)le.corp_addr1_chk_digit),TRIM((SALT30.StrType)le.corp_addr1_rec_type),TRIM((SALT30.StrType)le.corp_addr1_ace_fips_st),TRIM((SALT30.StrType)le.corp_addr1_county),TRIM((SALT30.StrType)le.corp_addr1_geo_lat),TRIM((SALT30.StrType)le.corp_addr1_geo_long),TRIM((SALT30.StrType)le.corp_addr1_msa),TRIM((SALT30.StrType)le.corp_addr1_geo_blk),TRIM((SALT30.StrType)le.corp_addr1_geo_match),TRIM((SALT30.StrType)le.corp_addr1_err_stat),TRIM((SALT30.StrType)le.corp_addr2_prim_range),TRIM((SALT30.StrType)le.corp_addr2_predir),TRIM((SALT30.StrType)le.corp_addr2_prim_name),TRIM((SALT30.StrType)le.corp_addr2_addr_suffix),TRIM((SALT30.StrType)le.corp_addr2_postdir),TRIM((SALT30.StrType)le.corp_addr2_unit_desig),TRIM((SALT30.StrType)le.corp_addr2_sec_range),TRIM((SALT30.StrType)le.corp_addr2_p_city_name),TRIM((SALT30.StrType)le.corp_addr2_v_city_name),TRIM((SALT30.StrType)le.corp_addr2_state),TRIM((SALT30.StrType)le.corp_addr2_zip5),TRIM((SALT30.StrType)le.corp_addr2_zip4),TRIM((SALT30.StrType)le.corp_addr2_cart),TRIM((SALT30.StrType)le.corp_addr2_cr_sort_sz),TRIM((SALT30.StrType)le.corp_addr2_lot),TRIM((SALT30.StrType)le.corp_addr2_lot_order),TRIM((SALT30.StrType)le.corp_addr2_dpbc),TRIM((SALT30.StrType)le.corp_addr2_chk_digit),TRIM((SALT30.StrType)le.corp_addr2_rec_type),TRIM((SALT30.StrType)le.corp_addr2_ace_fips_st),TRIM((SALT30.StrType)le.corp_addr2_county),TRIM((SALT30.StrType)le.corp_addr2_geo_lat),TRIM((SALT30.StrType)le.corp_addr2_geo_long),TRIM((SALT30.StrType)le.corp_addr2_msa),TRIM((SALT30.StrType)le.corp_addr2_geo_blk),TRIM((SALT30.StrType)le.corp_addr2_geo_match),TRIM((SALT30.StrType)le.corp_addr2_err_stat),TRIM((SALT30.StrType)le.corp_ra_title1),TRIM((SALT30.StrType)le.corp_ra_fname1),TRIM((SALT30.StrType)le.corp_ra_mname1),TRIM((SALT30.StrType)le.corp_ra_lname1),TRIM((SALT30.StrType)le.corp_ra_name_suffix1),TRIM((SALT30.StrType)le.corp_ra_score1),TRIM((SALT30.StrType)le.corp_ra_title2),TRIM((SALT30.StrType)le.corp_ra_fname2),TRIM((SALT30.StrType)le.corp_ra_mname2),TRIM((SALT30.StrType)le.corp_ra_lname2),TRIM((SALT30.StrType)le.corp_ra_name_suffix2),TRIM((SALT30.StrType)le.corp_ra_score2),TRIM((SALT30.StrType)le.corp_ra_cname1),TRIM((SALT30.StrType)le.corp_ra_cname1_score),TRIM((SALT30.StrType)le.corp_ra_cname2),TRIM((SALT30.StrType)le.corp_ra_cname2_score),TRIM((SALT30.StrType)le.corp_ra_prim_range),TRIM((SALT30.StrType)le.corp_ra_predir),TRIM((SALT30.StrType)le.corp_ra_prim_name),TRIM((SALT30.StrType)le.corp_ra_addr_suffix),TRIM((SALT30.StrType)le.corp_ra_postdir),TRIM((SALT30.StrType)le.corp_ra_unit_desig),TRIM((SALT30.StrType)le.corp_ra_sec_range),TRIM((SALT30.StrType)le.corp_ra_p_city_name),TRIM((SALT30.StrType)le.corp_ra_v_city_name),TRIM((SALT30.StrType)le.corp_ra_state),TRIM((SALT30.StrType)le.corp_ra_zip5),TRIM((SALT30.StrType)le.corp_ra_zip4),TRIM((SALT30.StrType)le.corp_ra_cart),TRIM((SALT30.StrType)le.corp_ra_cr_sort_sz),TRIM((SALT30.StrType)le.corp_ra_lot),TRIM((SALT30.StrType)le.corp_ra_lot_order),TRIM((SALT30.StrType)le.corp_ra_dpbc),TRIM((SALT30.StrType)le.corp_ra_chk_digit),TRIM((SALT30.StrType)le.corp_ra_rec_type),TRIM((SALT30.StrType)le.corp_ra_ace_fips_st),TRIM((SALT30.StrType)le.corp_ra_county),TRIM((SALT30.StrType)le.corp_ra_geo_lat),TRIM((SALT30.StrType)le.corp_ra_geo_long),TRIM((SALT30.StrType)le.corp_ra_msa),TRIM((SALT30.StrType)le.corp_ra_geo_blk),TRIM((SALT30.StrType)le.corp_ra_geo_match),TRIM((SALT30.StrType)le.corp_ra_err_stat),TRIM((SALT30.StrType)le.corp_phone10),TRIM((SALT30.StrType)le.corp_ra_phone10),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.append_addr1_rawaid),TRIM((SALT30.StrType)le.append_addr1_aceaid),TRIM((SALT30.StrType)le.corp_prep_addr1_line1),TRIM((SALT30.StrType)le.corp_prep_addr1_last_line),TRIM((SALT30.StrType)le.append_addr2_rawaid),TRIM((SALT30.StrType)le.append_addr2_aceaid),TRIM((SALT30.StrType)le.corp_prep_addr2_line1),TRIM((SALT30.StrType)le.corp_prep_addr2_last_line),TRIM((SALT30.StrType)le.append_ra_rawaid),TRIM((SALT30.StrType)le.append_ra_aceaid),TRIM((SALT30.StrType)le.ra_prep_addr_line1),TRIM((SALT30.StrType)le.ra_prep_addr_last_line),TRIM((SALT30.StrType)le.dotid),TRIM((SALT30.StrType)le.dotscore),TRIM((SALT30.StrType)le.dotweight),TRIM((SALT30.StrType)le.empid),TRIM((SALT30.StrType)le.empscore),TRIM((SALT30.StrType)le.empweight),TRIM((SALT30.StrType)le.powid),TRIM((SALT30.StrType)le.powscore),TRIM((SALT30.StrType)le.powweight),TRIM((SALT30.StrType)le.proxid),TRIM((SALT30.StrType)le.proxscore),TRIM((SALT30.StrType)le.proxweight),TRIM((SALT30.StrType)le.seleid),TRIM((SALT30.StrType)le.selescore),TRIM((SALT30.StrType)le.seleweight),TRIM((SALT30.StrType)le.orgid),TRIM((SALT30.StrType)le.orgscore),TRIM((SALT30.StrType)le.orgweight),TRIM((SALT30.StrType)le.ultid),TRIM((SALT30.StrType)le.ultscore),TRIM((SALT30.StrType)le.ultweight)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,257,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 257);
  SELF.FldNo2 := 1 + (C % 257);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.source_rec_id),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.corp_ra_dt_first_seen),TRIM((SALT30.StrType)le.corp_ra_dt_last_seen),TRIM((SALT30.StrType)le.corp_key),TRIM((SALT30.StrType)le.corp_supp_key),TRIM((SALT30.StrType)le.corp_vendor),TRIM((SALT30.StrType)le.corp_vendor_county),TRIM((SALT30.StrType)le.corp_vendor_subcode),TRIM((SALT30.StrType)le.corp_state_origin),TRIM((SALT30.StrType)le.corp_process_date),TRIM((SALT30.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_src_type),TRIM((SALT30.StrType)le.corp_legal_name),TRIM((SALT30.StrType)le.corp_ln_name_type_cd),TRIM((SALT30.StrType)le.corp_ln_name_type_desc),TRIM((SALT30.StrType)le.corp_supp_nbr),TRIM((SALT30.StrType)le.corp_name_comment),TRIM((SALT30.StrType)le.corp_address1_type_cd),TRIM((SALT30.StrType)le.corp_address1_type_desc),TRIM((SALT30.StrType)le.corp_address1_line1),TRIM((SALT30.StrType)le.corp_address1_line2),TRIM((SALT30.StrType)le.corp_address1_line3),TRIM((SALT30.StrType)le.corp_address1_line4),TRIM((SALT30.StrType)le.corp_address1_line5),TRIM((SALT30.StrType)le.corp_address1_line6),TRIM((SALT30.StrType)le.corp_address1_effective_date),TRIM((SALT30.StrType)le.corp_address2_type_cd),TRIM((SALT30.StrType)le.corp_address2_type_desc),TRIM((SALT30.StrType)le.corp_address2_line1),TRIM((SALT30.StrType)le.corp_address2_line2),TRIM((SALT30.StrType)le.corp_address2_line3),TRIM((SALT30.StrType)le.corp_address2_line4),TRIM((SALT30.StrType)le.corp_address2_line5),TRIM((SALT30.StrType)le.corp_address2_line6),TRIM((SALT30.StrType)le.corp_address2_effective_date),TRIM((SALT30.StrType)le.corp_phone_number),TRIM((SALT30.StrType)le.corp_phone_number_type_cd),TRIM((SALT30.StrType)le.corp_phone_number_type_desc),TRIM((SALT30.StrType)le.corp_fax_nbr),TRIM((SALT30.StrType)le.corp_email_address),TRIM((SALT30.StrType)le.corp_web_address),TRIM((SALT30.StrType)le.corp_filing_reference_nbr),TRIM((SALT30.StrType)le.corp_filing_date),TRIM((SALT30.StrType)le.corp_filing_cd),TRIM((SALT30.StrType)le.corp_filing_desc),TRIM((SALT30.StrType)le.corp_status_cd),TRIM((SALT30.StrType)le.corp_status_desc),TRIM((SALT30.StrType)le.corp_status_date),TRIM((SALT30.StrType)le.corp_standing),TRIM((SALT30.StrType)le.corp_status_comment),TRIM((SALT30.StrType)le.corp_ticker_symbol),TRIM((SALT30.StrType)le.corp_stock_exchange),TRIM((SALT30.StrType)le.corp_inc_state),TRIM((SALT30.StrType)le.corp_inc_county),TRIM((SALT30.StrType)le.corp_inc_date),TRIM((SALT30.StrType)le.corp_anniversary_month),TRIM((SALT30.StrType)le.corp_fed_tax_id),TRIM((SALT30.StrType)le.corp_state_tax_id),TRIM((SALT30.StrType)le.corp_term_exist_cd),TRIM((SALT30.StrType)le.corp_term_exist_exp),TRIM((SALT30.StrType)le.corp_term_exist_desc),TRIM((SALT30.StrType)le.corp_foreign_domestic_ind),TRIM((SALT30.StrType)le.corp_forgn_state_cd),TRIM((SALT30.StrType)le.corp_forgn_state_desc),TRIM((SALT30.StrType)le.corp_forgn_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_forgn_date),TRIM((SALT30.StrType)le.corp_forgn_fed_tax_id),TRIM((SALT30.StrType)le.corp_forgn_state_tax_id),TRIM((SALT30.StrType)le.corp_forgn_term_exist_cd),TRIM((SALT30.StrType)le.corp_forgn_term_exist_exp),TRIM((SALT30.StrType)le.corp_forgn_term_exist_desc),TRIM((SALT30.StrType)le.corp_orig_org_structure_cd),TRIM((SALT30.StrType)le.corp_orig_org_structure_desc),TRIM((SALT30.StrType)le.corp_for_profit_ind),TRIM((SALT30.StrType)le.corp_public_or_private_ind),TRIM((SALT30.StrType)le.corp_sic_code),TRIM((SALT30.StrType)le.corp_naic_code),TRIM((SALT30.StrType)le.corp_orig_bus_type_cd),TRIM((SALT30.StrType)le.corp_orig_bus_type_desc),TRIM((SALT30.StrType)le.corp_entity_desc),TRIM((SALT30.StrType)le.corp_certificate_nbr),TRIM((SALT30.StrType)le.corp_internal_nbr),TRIM((SALT30.StrType)le.corp_previous_nbr),TRIM((SALT30.StrType)le.corp_microfilm_nbr),TRIM((SALT30.StrType)le.corp_amendments_filed),TRIM((SALT30.StrType)le.corp_acts),TRIM((SALT30.StrType)le.corp_partnership_ind),TRIM((SALT30.StrType)le.corp_mfg_ind),TRIM((SALT30.StrType)le.corp_addl_info),TRIM((SALT30.StrType)le.corp_taxes),TRIM((SALT30.StrType)le.corp_franchise_taxes),TRIM((SALT30.StrType)le.corp_tax_program_cd),TRIM((SALT30.StrType)le.corp_tax_program_desc),TRIM((SALT30.StrType)le.corp_ra_name),TRIM((SALT30.StrType)le.corp_ra_title_cd),TRIM((SALT30.StrType)le.corp_ra_title_desc),TRIM((SALT30.StrType)le.corp_ra_fein),TRIM((SALT30.StrType)le.corp_ra_ssn),TRIM((SALT30.StrType)le.corp_ra_dob),TRIM((SALT30.StrType)le.corp_ra_effective_date),TRIM((SALT30.StrType)le.corp_ra_resign_date),TRIM((SALT30.StrType)le.corp_ra_no_comp),TRIM((SALT30.StrType)le.corp_ra_no_comp_igs),TRIM((SALT30.StrType)le.corp_ra_addl_info),TRIM((SALT30.StrType)le.corp_ra_address_type_cd),TRIM((SALT30.StrType)le.corp_ra_address_type_desc),TRIM((SALT30.StrType)le.corp_ra_address_line1),TRIM((SALT30.StrType)le.corp_ra_address_line2),TRIM((SALT30.StrType)le.corp_ra_address_line3),TRIM((SALT30.StrType)le.corp_ra_address_line4),TRIM((SALT30.StrType)le.corp_ra_address_line5),TRIM((SALT30.StrType)le.corp_ra_address_line6),TRIM((SALT30.StrType)le.corp_ra_phone_number),TRIM((SALT30.StrType)le.corp_ra_phone_number_type_cd),TRIM((SALT30.StrType)le.corp_ra_phone_number_type_desc),TRIM((SALT30.StrType)le.corp_ra_fax_nbr),TRIM((SALT30.StrType)le.corp_ra_email_address),TRIM((SALT30.StrType)le.corp_ra_web_address),TRIM((SALT30.StrType)le.corp_addr1_prim_range),TRIM((SALT30.StrType)le.corp_addr1_predir),TRIM((SALT30.StrType)le.corp_addr1_prim_name),TRIM((SALT30.StrType)le.corp_addr1_addr_suffix),TRIM((SALT30.StrType)le.corp_addr1_postdir),TRIM((SALT30.StrType)le.corp_addr1_unit_desig),TRIM((SALT30.StrType)le.corp_addr1_sec_range),TRIM((SALT30.StrType)le.corp_addr1_p_city_name),TRIM((SALT30.StrType)le.corp_addr1_v_city_name),TRIM((SALT30.StrType)le.corp_addr1_state),TRIM((SALT30.StrType)le.corp_addr1_zip5),TRIM((SALT30.StrType)le.corp_addr1_zip4),TRIM((SALT30.StrType)le.corp_addr1_cart),TRIM((SALT30.StrType)le.corp_addr1_cr_sort_sz),TRIM((SALT30.StrType)le.corp_addr1_lot),TRIM((SALT30.StrType)le.corp_addr1_lot_order),TRIM((SALT30.StrType)le.corp_addr1_dpbc),TRIM((SALT30.StrType)le.corp_addr1_chk_digit),TRIM((SALT30.StrType)le.corp_addr1_rec_type),TRIM((SALT30.StrType)le.corp_addr1_ace_fips_st),TRIM((SALT30.StrType)le.corp_addr1_county),TRIM((SALT30.StrType)le.corp_addr1_geo_lat),TRIM((SALT30.StrType)le.corp_addr1_geo_long),TRIM((SALT30.StrType)le.corp_addr1_msa),TRIM((SALT30.StrType)le.corp_addr1_geo_blk),TRIM((SALT30.StrType)le.corp_addr1_geo_match),TRIM((SALT30.StrType)le.corp_addr1_err_stat),TRIM((SALT30.StrType)le.corp_addr2_prim_range),TRIM((SALT30.StrType)le.corp_addr2_predir),TRIM((SALT30.StrType)le.corp_addr2_prim_name),TRIM((SALT30.StrType)le.corp_addr2_addr_suffix),TRIM((SALT30.StrType)le.corp_addr2_postdir),TRIM((SALT30.StrType)le.corp_addr2_unit_desig),TRIM((SALT30.StrType)le.corp_addr2_sec_range),TRIM((SALT30.StrType)le.corp_addr2_p_city_name),TRIM((SALT30.StrType)le.corp_addr2_v_city_name),TRIM((SALT30.StrType)le.corp_addr2_state),TRIM((SALT30.StrType)le.corp_addr2_zip5),TRIM((SALT30.StrType)le.corp_addr2_zip4),TRIM((SALT30.StrType)le.corp_addr2_cart),TRIM((SALT30.StrType)le.corp_addr2_cr_sort_sz),TRIM((SALT30.StrType)le.corp_addr2_lot),TRIM((SALT30.StrType)le.corp_addr2_lot_order),TRIM((SALT30.StrType)le.corp_addr2_dpbc),TRIM((SALT30.StrType)le.corp_addr2_chk_digit),TRIM((SALT30.StrType)le.corp_addr2_rec_type),TRIM((SALT30.StrType)le.corp_addr2_ace_fips_st),TRIM((SALT30.StrType)le.corp_addr2_county),TRIM((SALT30.StrType)le.corp_addr2_geo_lat),TRIM((SALT30.StrType)le.corp_addr2_geo_long),TRIM((SALT30.StrType)le.corp_addr2_msa),TRIM((SALT30.StrType)le.corp_addr2_geo_blk),TRIM((SALT30.StrType)le.corp_addr2_geo_match),TRIM((SALT30.StrType)le.corp_addr2_err_stat),TRIM((SALT30.StrType)le.corp_ra_title1),TRIM((SALT30.StrType)le.corp_ra_fname1),TRIM((SALT30.StrType)le.corp_ra_mname1),TRIM((SALT30.StrType)le.corp_ra_lname1),TRIM((SALT30.StrType)le.corp_ra_name_suffix1),TRIM((SALT30.StrType)le.corp_ra_score1),TRIM((SALT30.StrType)le.corp_ra_title2),TRIM((SALT30.StrType)le.corp_ra_fname2),TRIM((SALT30.StrType)le.corp_ra_mname2),TRIM((SALT30.StrType)le.corp_ra_lname2),TRIM((SALT30.StrType)le.corp_ra_name_suffix2),TRIM((SALT30.StrType)le.corp_ra_score2),TRIM((SALT30.StrType)le.corp_ra_cname1),TRIM((SALT30.StrType)le.corp_ra_cname1_score),TRIM((SALT30.StrType)le.corp_ra_cname2),TRIM((SALT30.StrType)le.corp_ra_cname2_score),TRIM((SALT30.StrType)le.corp_ra_prim_range),TRIM((SALT30.StrType)le.corp_ra_predir),TRIM((SALT30.StrType)le.corp_ra_prim_name),TRIM((SALT30.StrType)le.corp_ra_addr_suffix),TRIM((SALT30.StrType)le.corp_ra_postdir),TRIM((SALT30.StrType)le.corp_ra_unit_desig),TRIM((SALT30.StrType)le.corp_ra_sec_range),TRIM((SALT30.StrType)le.corp_ra_p_city_name),TRIM((SALT30.StrType)le.corp_ra_v_city_name),TRIM((SALT30.StrType)le.corp_ra_state),TRIM((SALT30.StrType)le.corp_ra_zip5),TRIM((SALT30.StrType)le.corp_ra_zip4),TRIM((SALT30.StrType)le.corp_ra_cart),TRIM((SALT30.StrType)le.corp_ra_cr_sort_sz),TRIM((SALT30.StrType)le.corp_ra_lot),TRIM((SALT30.StrType)le.corp_ra_lot_order),TRIM((SALT30.StrType)le.corp_ra_dpbc),TRIM((SALT30.StrType)le.corp_ra_chk_digit),TRIM((SALT30.StrType)le.corp_ra_rec_type),TRIM((SALT30.StrType)le.corp_ra_ace_fips_st),TRIM((SALT30.StrType)le.corp_ra_county),TRIM((SALT30.StrType)le.corp_ra_geo_lat),TRIM((SALT30.StrType)le.corp_ra_geo_long),TRIM((SALT30.StrType)le.corp_ra_msa),TRIM((SALT30.StrType)le.corp_ra_geo_blk),TRIM((SALT30.StrType)le.corp_ra_geo_match),TRIM((SALT30.StrType)le.corp_ra_err_stat),TRIM((SALT30.StrType)le.corp_phone10),TRIM((SALT30.StrType)le.corp_ra_phone10),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.append_addr1_rawaid),TRIM((SALT30.StrType)le.append_addr1_aceaid),TRIM((SALT30.StrType)le.corp_prep_addr1_line1),TRIM((SALT30.StrType)le.corp_prep_addr1_last_line),TRIM((SALT30.StrType)le.append_addr2_rawaid),TRIM((SALT30.StrType)le.append_addr2_aceaid),TRIM((SALT30.StrType)le.corp_prep_addr2_line1),TRIM((SALT30.StrType)le.corp_prep_addr2_last_line),TRIM((SALT30.StrType)le.append_ra_rawaid),TRIM((SALT30.StrType)le.append_ra_aceaid),TRIM((SALT30.StrType)le.ra_prep_addr_line1),TRIM((SALT30.StrType)le.ra_prep_addr_last_line),TRIM((SALT30.StrType)le.dotid),TRIM((SALT30.StrType)le.dotscore),TRIM((SALT30.StrType)le.dotweight),TRIM((SALT30.StrType)le.empid),TRIM((SALT30.StrType)le.empscore),TRIM((SALT30.StrType)le.empweight),TRIM((SALT30.StrType)le.powid),TRIM((SALT30.StrType)le.powscore),TRIM((SALT30.StrType)le.powweight),TRIM((SALT30.StrType)le.proxid),TRIM((SALT30.StrType)le.proxscore),TRIM((SALT30.StrType)le.proxweight),TRIM((SALT30.StrType)le.seleid),TRIM((SALT30.StrType)le.selescore),TRIM((SALT30.StrType)le.seleweight),TRIM((SALT30.StrType)le.orgid),TRIM((SALT30.StrType)le.orgscore),TRIM((SALT30.StrType)le.orgweight),TRIM((SALT30.StrType)le.ultid),TRIM((SALT30.StrType)le.ultscore),TRIM((SALT30.StrType)le.ultweight)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.source_rec_id),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.corp_ra_dt_first_seen),TRIM((SALT30.StrType)le.corp_ra_dt_last_seen),TRIM((SALT30.StrType)le.corp_key),TRIM((SALT30.StrType)le.corp_supp_key),TRIM((SALT30.StrType)le.corp_vendor),TRIM((SALT30.StrType)le.corp_vendor_county),TRIM((SALT30.StrType)le.corp_vendor_subcode),TRIM((SALT30.StrType)le.corp_state_origin),TRIM((SALT30.StrType)le.corp_process_date),TRIM((SALT30.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_src_type),TRIM((SALT30.StrType)le.corp_legal_name),TRIM((SALT30.StrType)le.corp_ln_name_type_cd),TRIM((SALT30.StrType)le.corp_ln_name_type_desc),TRIM((SALT30.StrType)le.corp_supp_nbr),TRIM((SALT30.StrType)le.corp_name_comment),TRIM((SALT30.StrType)le.corp_address1_type_cd),TRIM((SALT30.StrType)le.corp_address1_type_desc),TRIM((SALT30.StrType)le.corp_address1_line1),TRIM((SALT30.StrType)le.corp_address1_line2),TRIM((SALT30.StrType)le.corp_address1_line3),TRIM((SALT30.StrType)le.corp_address1_line4),TRIM((SALT30.StrType)le.corp_address1_line5),TRIM((SALT30.StrType)le.corp_address1_line6),TRIM((SALT30.StrType)le.corp_address1_effective_date),TRIM((SALT30.StrType)le.corp_address2_type_cd),TRIM((SALT30.StrType)le.corp_address2_type_desc),TRIM((SALT30.StrType)le.corp_address2_line1),TRIM((SALT30.StrType)le.corp_address2_line2),TRIM((SALT30.StrType)le.corp_address2_line3),TRIM((SALT30.StrType)le.corp_address2_line4),TRIM((SALT30.StrType)le.corp_address2_line5),TRIM((SALT30.StrType)le.corp_address2_line6),TRIM((SALT30.StrType)le.corp_address2_effective_date),TRIM((SALT30.StrType)le.corp_phone_number),TRIM((SALT30.StrType)le.corp_phone_number_type_cd),TRIM((SALT30.StrType)le.corp_phone_number_type_desc),TRIM((SALT30.StrType)le.corp_fax_nbr),TRIM((SALT30.StrType)le.corp_email_address),TRIM((SALT30.StrType)le.corp_web_address),TRIM((SALT30.StrType)le.corp_filing_reference_nbr),TRIM((SALT30.StrType)le.corp_filing_date),TRIM((SALT30.StrType)le.corp_filing_cd),TRIM((SALT30.StrType)le.corp_filing_desc),TRIM((SALT30.StrType)le.corp_status_cd),TRIM((SALT30.StrType)le.corp_status_desc),TRIM((SALT30.StrType)le.corp_status_date),TRIM((SALT30.StrType)le.corp_standing),TRIM((SALT30.StrType)le.corp_status_comment),TRIM((SALT30.StrType)le.corp_ticker_symbol),TRIM((SALT30.StrType)le.corp_stock_exchange),TRIM((SALT30.StrType)le.corp_inc_state),TRIM((SALT30.StrType)le.corp_inc_county),TRIM((SALT30.StrType)le.corp_inc_date),TRIM((SALT30.StrType)le.corp_anniversary_month),TRIM((SALT30.StrType)le.corp_fed_tax_id),TRIM((SALT30.StrType)le.corp_state_tax_id),TRIM((SALT30.StrType)le.corp_term_exist_cd),TRIM((SALT30.StrType)le.corp_term_exist_exp),TRIM((SALT30.StrType)le.corp_term_exist_desc),TRIM((SALT30.StrType)le.corp_foreign_domestic_ind),TRIM((SALT30.StrType)le.corp_forgn_state_cd),TRIM((SALT30.StrType)le.corp_forgn_state_desc),TRIM((SALT30.StrType)le.corp_forgn_sos_charter_nbr),TRIM((SALT30.StrType)le.corp_forgn_date),TRIM((SALT30.StrType)le.corp_forgn_fed_tax_id),TRIM((SALT30.StrType)le.corp_forgn_state_tax_id),TRIM((SALT30.StrType)le.corp_forgn_term_exist_cd),TRIM((SALT30.StrType)le.corp_forgn_term_exist_exp),TRIM((SALT30.StrType)le.corp_forgn_term_exist_desc),TRIM((SALT30.StrType)le.corp_orig_org_structure_cd),TRIM((SALT30.StrType)le.corp_orig_org_structure_desc),TRIM((SALT30.StrType)le.corp_for_profit_ind),TRIM((SALT30.StrType)le.corp_public_or_private_ind),TRIM((SALT30.StrType)le.corp_sic_code),TRIM((SALT30.StrType)le.corp_naic_code),TRIM((SALT30.StrType)le.corp_orig_bus_type_cd),TRIM((SALT30.StrType)le.corp_orig_bus_type_desc),TRIM((SALT30.StrType)le.corp_entity_desc),TRIM((SALT30.StrType)le.corp_certificate_nbr),TRIM((SALT30.StrType)le.corp_internal_nbr),TRIM((SALT30.StrType)le.corp_previous_nbr),TRIM((SALT30.StrType)le.corp_microfilm_nbr),TRIM((SALT30.StrType)le.corp_amendments_filed),TRIM((SALT30.StrType)le.corp_acts),TRIM((SALT30.StrType)le.corp_partnership_ind),TRIM((SALT30.StrType)le.corp_mfg_ind),TRIM((SALT30.StrType)le.corp_addl_info),TRIM((SALT30.StrType)le.corp_taxes),TRIM((SALT30.StrType)le.corp_franchise_taxes),TRIM((SALT30.StrType)le.corp_tax_program_cd),TRIM((SALT30.StrType)le.corp_tax_program_desc),TRIM((SALT30.StrType)le.corp_ra_name),TRIM((SALT30.StrType)le.corp_ra_title_cd),TRIM((SALT30.StrType)le.corp_ra_title_desc),TRIM((SALT30.StrType)le.corp_ra_fein),TRIM((SALT30.StrType)le.corp_ra_ssn),TRIM((SALT30.StrType)le.corp_ra_dob),TRIM((SALT30.StrType)le.corp_ra_effective_date),TRIM((SALT30.StrType)le.corp_ra_resign_date),TRIM((SALT30.StrType)le.corp_ra_no_comp),TRIM((SALT30.StrType)le.corp_ra_no_comp_igs),TRIM((SALT30.StrType)le.corp_ra_addl_info),TRIM((SALT30.StrType)le.corp_ra_address_type_cd),TRIM((SALT30.StrType)le.corp_ra_address_type_desc),TRIM((SALT30.StrType)le.corp_ra_address_line1),TRIM((SALT30.StrType)le.corp_ra_address_line2),TRIM((SALT30.StrType)le.corp_ra_address_line3),TRIM((SALT30.StrType)le.corp_ra_address_line4),TRIM((SALT30.StrType)le.corp_ra_address_line5),TRIM((SALT30.StrType)le.corp_ra_address_line6),TRIM((SALT30.StrType)le.corp_ra_phone_number),TRIM((SALT30.StrType)le.corp_ra_phone_number_type_cd),TRIM((SALT30.StrType)le.corp_ra_phone_number_type_desc),TRIM((SALT30.StrType)le.corp_ra_fax_nbr),TRIM((SALT30.StrType)le.corp_ra_email_address),TRIM((SALT30.StrType)le.corp_ra_web_address),TRIM((SALT30.StrType)le.corp_addr1_prim_range),TRIM((SALT30.StrType)le.corp_addr1_predir),TRIM((SALT30.StrType)le.corp_addr1_prim_name),TRIM((SALT30.StrType)le.corp_addr1_addr_suffix),TRIM((SALT30.StrType)le.corp_addr1_postdir),TRIM((SALT30.StrType)le.corp_addr1_unit_desig),TRIM((SALT30.StrType)le.corp_addr1_sec_range),TRIM((SALT30.StrType)le.corp_addr1_p_city_name),TRIM((SALT30.StrType)le.corp_addr1_v_city_name),TRIM((SALT30.StrType)le.corp_addr1_state),TRIM((SALT30.StrType)le.corp_addr1_zip5),TRIM((SALT30.StrType)le.corp_addr1_zip4),TRIM((SALT30.StrType)le.corp_addr1_cart),TRIM((SALT30.StrType)le.corp_addr1_cr_sort_sz),TRIM((SALT30.StrType)le.corp_addr1_lot),TRIM((SALT30.StrType)le.corp_addr1_lot_order),TRIM((SALT30.StrType)le.corp_addr1_dpbc),TRIM((SALT30.StrType)le.corp_addr1_chk_digit),TRIM((SALT30.StrType)le.corp_addr1_rec_type),TRIM((SALT30.StrType)le.corp_addr1_ace_fips_st),TRIM((SALT30.StrType)le.corp_addr1_county),TRIM((SALT30.StrType)le.corp_addr1_geo_lat),TRIM((SALT30.StrType)le.corp_addr1_geo_long),TRIM((SALT30.StrType)le.corp_addr1_msa),TRIM((SALT30.StrType)le.corp_addr1_geo_blk),TRIM((SALT30.StrType)le.corp_addr1_geo_match),TRIM((SALT30.StrType)le.corp_addr1_err_stat),TRIM((SALT30.StrType)le.corp_addr2_prim_range),TRIM((SALT30.StrType)le.corp_addr2_predir),TRIM((SALT30.StrType)le.corp_addr2_prim_name),TRIM((SALT30.StrType)le.corp_addr2_addr_suffix),TRIM((SALT30.StrType)le.corp_addr2_postdir),TRIM((SALT30.StrType)le.corp_addr2_unit_desig),TRIM((SALT30.StrType)le.corp_addr2_sec_range),TRIM((SALT30.StrType)le.corp_addr2_p_city_name),TRIM((SALT30.StrType)le.corp_addr2_v_city_name),TRIM((SALT30.StrType)le.corp_addr2_state),TRIM((SALT30.StrType)le.corp_addr2_zip5),TRIM((SALT30.StrType)le.corp_addr2_zip4),TRIM((SALT30.StrType)le.corp_addr2_cart),TRIM((SALT30.StrType)le.corp_addr2_cr_sort_sz),TRIM((SALT30.StrType)le.corp_addr2_lot),TRIM((SALT30.StrType)le.corp_addr2_lot_order),TRIM((SALT30.StrType)le.corp_addr2_dpbc),TRIM((SALT30.StrType)le.corp_addr2_chk_digit),TRIM((SALT30.StrType)le.corp_addr2_rec_type),TRIM((SALT30.StrType)le.corp_addr2_ace_fips_st),TRIM((SALT30.StrType)le.corp_addr2_county),TRIM((SALT30.StrType)le.corp_addr2_geo_lat),TRIM((SALT30.StrType)le.corp_addr2_geo_long),TRIM((SALT30.StrType)le.corp_addr2_msa),TRIM((SALT30.StrType)le.corp_addr2_geo_blk),TRIM((SALT30.StrType)le.corp_addr2_geo_match),TRIM((SALT30.StrType)le.corp_addr2_err_stat),TRIM((SALT30.StrType)le.corp_ra_title1),TRIM((SALT30.StrType)le.corp_ra_fname1),TRIM((SALT30.StrType)le.corp_ra_mname1),TRIM((SALT30.StrType)le.corp_ra_lname1),TRIM((SALT30.StrType)le.corp_ra_name_suffix1),TRIM((SALT30.StrType)le.corp_ra_score1),TRIM((SALT30.StrType)le.corp_ra_title2),TRIM((SALT30.StrType)le.corp_ra_fname2),TRIM((SALT30.StrType)le.corp_ra_mname2),TRIM((SALT30.StrType)le.corp_ra_lname2),TRIM((SALT30.StrType)le.corp_ra_name_suffix2),TRIM((SALT30.StrType)le.corp_ra_score2),TRIM((SALT30.StrType)le.corp_ra_cname1),TRIM((SALT30.StrType)le.corp_ra_cname1_score),TRIM((SALT30.StrType)le.corp_ra_cname2),TRIM((SALT30.StrType)le.corp_ra_cname2_score),TRIM((SALT30.StrType)le.corp_ra_prim_range),TRIM((SALT30.StrType)le.corp_ra_predir),TRIM((SALT30.StrType)le.corp_ra_prim_name),TRIM((SALT30.StrType)le.corp_ra_addr_suffix),TRIM((SALT30.StrType)le.corp_ra_postdir),TRIM((SALT30.StrType)le.corp_ra_unit_desig),TRIM((SALT30.StrType)le.corp_ra_sec_range),TRIM((SALT30.StrType)le.corp_ra_p_city_name),TRIM((SALT30.StrType)le.corp_ra_v_city_name),TRIM((SALT30.StrType)le.corp_ra_state),TRIM((SALT30.StrType)le.corp_ra_zip5),TRIM((SALT30.StrType)le.corp_ra_zip4),TRIM((SALT30.StrType)le.corp_ra_cart),TRIM((SALT30.StrType)le.corp_ra_cr_sort_sz),TRIM((SALT30.StrType)le.corp_ra_lot),TRIM((SALT30.StrType)le.corp_ra_lot_order),TRIM((SALT30.StrType)le.corp_ra_dpbc),TRIM((SALT30.StrType)le.corp_ra_chk_digit),TRIM((SALT30.StrType)le.corp_ra_rec_type),TRIM((SALT30.StrType)le.corp_ra_ace_fips_st),TRIM((SALT30.StrType)le.corp_ra_county),TRIM((SALT30.StrType)le.corp_ra_geo_lat),TRIM((SALT30.StrType)le.corp_ra_geo_long),TRIM((SALT30.StrType)le.corp_ra_msa),TRIM((SALT30.StrType)le.corp_ra_geo_blk),TRIM((SALT30.StrType)le.corp_ra_geo_match),TRIM((SALT30.StrType)le.corp_ra_err_stat),TRIM((SALT30.StrType)le.corp_phone10),TRIM((SALT30.StrType)le.corp_ra_phone10),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.append_addr1_rawaid),TRIM((SALT30.StrType)le.append_addr1_aceaid),TRIM((SALT30.StrType)le.corp_prep_addr1_line1),TRIM((SALT30.StrType)le.corp_prep_addr1_last_line),TRIM((SALT30.StrType)le.append_addr2_rawaid),TRIM((SALT30.StrType)le.append_addr2_aceaid),TRIM((SALT30.StrType)le.corp_prep_addr2_line1),TRIM((SALT30.StrType)le.corp_prep_addr2_last_line),TRIM((SALT30.StrType)le.append_ra_rawaid),TRIM((SALT30.StrType)le.append_ra_aceaid),TRIM((SALT30.StrType)le.ra_prep_addr_line1),TRIM((SALT30.StrType)le.ra_prep_addr_last_line),TRIM((SALT30.StrType)le.dotid),TRIM((SALT30.StrType)le.dotscore),TRIM((SALT30.StrType)le.dotweight),TRIM((SALT30.StrType)le.empid),TRIM((SALT30.StrType)le.empscore),TRIM((SALT30.StrType)le.empweight),TRIM((SALT30.StrType)le.powid),TRIM((SALT30.StrType)le.powscore),TRIM((SALT30.StrType)le.powweight),TRIM((SALT30.StrType)le.proxid),TRIM((SALT30.StrType)le.proxscore),TRIM((SALT30.StrType)le.proxweight),TRIM((SALT30.StrType)le.seleid),TRIM((SALT30.StrType)le.selescore),TRIM((SALT30.StrType)le.seleweight),TRIM((SALT30.StrType)le.orgid),TRIM((SALT30.StrType)le.orgscore),TRIM((SALT30.StrType)le.orgweight),TRIM((SALT30.StrType)le.ultid),TRIM((SALT30.StrType)le.ultscore),TRIM((SALT30.StrType)le.ultweight)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),257*257,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'source_rec_id'}
      ,{2,'bdid'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'dt_vendor_first_reported'}
      ,{6,'dt_vendor_last_reported'}
      ,{7,'corp_ra_dt_first_seen'}
      ,{8,'corp_ra_dt_last_seen'}
      ,{9,'corp_key'}
      ,{10,'corp_supp_key'}
      ,{11,'corp_vendor'}
      ,{12,'corp_vendor_county'}
      ,{13,'corp_vendor_subcode'}
      ,{14,'corp_state_origin'}
      ,{15,'corp_process_date'}
      ,{16,'corp_orig_sos_charter_nbr'}
      ,{17,'corp_sos_charter_nbr'}
      ,{18,'corp_src_type'}
      ,{19,'corp_legal_name'}
      ,{20,'corp_ln_name_type_cd'}
      ,{21,'corp_ln_name_type_desc'}
      ,{22,'corp_supp_nbr'}
      ,{23,'corp_name_comment'}
      ,{24,'corp_address1_type_cd'}
      ,{25,'corp_address1_type_desc'}
      ,{26,'corp_address1_line1'}
      ,{27,'corp_address1_line2'}
      ,{28,'corp_address1_line3'}
      ,{29,'corp_address1_line4'}
      ,{30,'corp_address1_line5'}
      ,{31,'corp_address1_line6'}
      ,{32,'corp_address1_effective_date'}
      ,{33,'corp_address2_type_cd'}
      ,{34,'corp_address2_type_desc'}
      ,{35,'corp_address2_line1'}
      ,{36,'corp_address2_line2'}
      ,{37,'corp_address2_line3'}
      ,{38,'corp_address2_line4'}
      ,{39,'corp_address2_line5'}
      ,{40,'corp_address2_line6'}
      ,{41,'corp_address2_effective_date'}
      ,{42,'corp_phone_number'}
      ,{43,'corp_phone_number_type_cd'}
      ,{44,'corp_phone_number_type_desc'}
      ,{45,'corp_fax_nbr'}
      ,{46,'corp_email_address'}
      ,{47,'corp_web_address'}
      ,{48,'corp_filing_reference_nbr'}
      ,{49,'corp_filing_date'}
      ,{50,'corp_filing_cd'}
      ,{51,'corp_filing_desc'}
      ,{52,'corp_status_cd'}
      ,{53,'corp_status_desc'}
      ,{54,'corp_status_date'}
      ,{55,'corp_standing'}
      ,{56,'corp_status_comment'}
      ,{57,'corp_ticker_symbol'}
      ,{58,'corp_stock_exchange'}
      ,{59,'corp_inc_state'}
      ,{60,'corp_inc_county'}
      ,{61,'corp_inc_date'}
      ,{62,'corp_anniversary_month'}
      ,{63,'corp_fed_tax_id'}
      ,{64,'corp_state_tax_id'}
      ,{65,'corp_term_exist_cd'}
      ,{66,'corp_term_exist_exp'}
      ,{67,'corp_term_exist_desc'}
      ,{68,'corp_foreign_domestic_ind'}
      ,{69,'corp_forgn_state_cd'}
      ,{70,'corp_forgn_state_desc'}
      ,{71,'corp_forgn_sos_charter_nbr'}
      ,{72,'corp_forgn_date'}
      ,{73,'corp_forgn_fed_tax_id'}
      ,{74,'corp_forgn_state_tax_id'}
      ,{75,'corp_forgn_term_exist_cd'}
      ,{76,'corp_forgn_term_exist_exp'}
      ,{77,'corp_forgn_term_exist_desc'}
      ,{78,'corp_orig_org_structure_cd'}
      ,{79,'corp_orig_org_structure_desc'}
      ,{80,'corp_for_profit_ind'}
      ,{81,'corp_public_or_private_ind'}
      ,{82,'corp_sic_code'}
      ,{83,'corp_naic_code'}
      ,{84,'corp_orig_bus_type_cd'}
      ,{85,'corp_orig_bus_type_desc'}
      ,{86,'corp_entity_desc'}
      ,{87,'corp_certificate_nbr'}
      ,{88,'corp_internal_nbr'}
      ,{89,'corp_previous_nbr'}
      ,{90,'corp_microfilm_nbr'}
      ,{91,'corp_amendments_filed'}
      ,{92,'corp_acts'}
      ,{93,'corp_partnership_ind'}
      ,{94,'corp_mfg_ind'}
      ,{95,'corp_addl_info'}
      ,{96,'corp_taxes'}
      ,{97,'corp_franchise_taxes'}
      ,{98,'corp_tax_program_cd'}
      ,{99,'corp_tax_program_desc'}
      ,{100,'corp_ra_name'}
      ,{101,'corp_ra_title_cd'}
      ,{102,'corp_ra_title_desc'}
      ,{103,'corp_ra_fein'}
      ,{104,'corp_ra_ssn'}
      ,{105,'corp_ra_dob'}
      ,{106,'corp_ra_effective_date'}
      ,{107,'corp_ra_resign_date'}
      ,{108,'corp_ra_no_comp'}
      ,{109,'corp_ra_no_comp_igs'}
      ,{110,'corp_ra_addl_info'}
      ,{111,'corp_ra_address_type_cd'}
      ,{112,'corp_ra_address_type_desc'}
      ,{113,'corp_ra_address_line1'}
      ,{114,'corp_ra_address_line2'}
      ,{115,'corp_ra_address_line3'}
      ,{116,'corp_ra_address_line4'}
      ,{117,'corp_ra_address_line5'}
      ,{118,'corp_ra_address_line6'}
      ,{119,'corp_ra_phone_number'}
      ,{120,'corp_ra_phone_number_type_cd'}
      ,{121,'corp_ra_phone_number_type_desc'}
      ,{122,'corp_ra_fax_nbr'}
      ,{123,'corp_ra_email_address'}
      ,{124,'corp_ra_web_address'}
      ,{125,'corp_addr1_prim_range'}
      ,{126,'corp_addr1_predir'}
      ,{127,'corp_addr1_prim_name'}
      ,{128,'corp_addr1_addr_suffix'}
      ,{129,'corp_addr1_postdir'}
      ,{130,'corp_addr1_unit_desig'}
      ,{131,'corp_addr1_sec_range'}
      ,{132,'corp_addr1_p_city_name'}
      ,{133,'corp_addr1_v_city_name'}
      ,{134,'corp_addr1_state'}
      ,{135,'corp_addr1_zip5'}
      ,{136,'corp_addr1_zip4'}
      ,{137,'corp_addr1_cart'}
      ,{138,'corp_addr1_cr_sort_sz'}
      ,{139,'corp_addr1_lot'}
      ,{140,'corp_addr1_lot_order'}
      ,{141,'corp_addr1_dpbc'}
      ,{142,'corp_addr1_chk_digit'}
      ,{143,'corp_addr1_rec_type'}
      ,{144,'corp_addr1_ace_fips_st'}
      ,{145,'corp_addr1_county'}
      ,{146,'corp_addr1_geo_lat'}
      ,{147,'corp_addr1_geo_long'}
      ,{148,'corp_addr1_msa'}
      ,{149,'corp_addr1_geo_blk'}
      ,{150,'corp_addr1_geo_match'}
      ,{151,'corp_addr1_err_stat'}
      ,{152,'corp_addr2_prim_range'}
      ,{153,'corp_addr2_predir'}
      ,{154,'corp_addr2_prim_name'}
      ,{155,'corp_addr2_addr_suffix'}
      ,{156,'corp_addr2_postdir'}
      ,{157,'corp_addr2_unit_desig'}
      ,{158,'corp_addr2_sec_range'}
      ,{159,'corp_addr2_p_city_name'}
      ,{160,'corp_addr2_v_city_name'}
      ,{161,'corp_addr2_state'}
      ,{162,'corp_addr2_zip5'}
      ,{163,'corp_addr2_zip4'}
      ,{164,'corp_addr2_cart'}
      ,{165,'corp_addr2_cr_sort_sz'}
      ,{166,'corp_addr2_lot'}
      ,{167,'corp_addr2_lot_order'}
      ,{168,'corp_addr2_dpbc'}
      ,{169,'corp_addr2_chk_digit'}
      ,{170,'corp_addr2_rec_type'}
      ,{171,'corp_addr2_ace_fips_st'}
      ,{172,'corp_addr2_county'}
      ,{173,'corp_addr2_geo_lat'}
      ,{174,'corp_addr2_geo_long'}
      ,{175,'corp_addr2_msa'}
      ,{176,'corp_addr2_geo_blk'}
      ,{177,'corp_addr2_geo_match'}
      ,{178,'corp_addr2_err_stat'}
      ,{179,'corp_ra_title1'}
      ,{180,'corp_ra_fname1'}
      ,{181,'corp_ra_mname1'}
      ,{182,'corp_ra_lname1'}
      ,{183,'corp_ra_name_suffix1'}
      ,{184,'corp_ra_score1'}
      ,{185,'corp_ra_title2'}
      ,{186,'corp_ra_fname2'}
      ,{187,'corp_ra_mname2'}
      ,{188,'corp_ra_lname2'}
      ,{189,'corp_ra_name_suffix2'}
      ,{190,'corp_ra_score2'}
      ,{191,'corp_ra_cname1'}
      ,{192,'corp_ra_cname1_score'}
      ,{193,'corp_ra_cname2'}
      ,{194,'corp_ra_cname2_score'}
      ,{195,'corp_ra_prim_range'}
      ,{196,'corp_ra_predir'}
      ,{197,'corp_ra_prim_name'}
      ,{198,'corp_ra_addr_suffix'}
      ,{199,'corp_ra_postdir'}
      ,{200,'corp_ra_unit_desig'}
      ,{201,'corp_ra_sec_range'}
      ,{202,'corp_ra_p_city_name'}
      ,{203,'corp_ra_v_city_name'}
      ,{204,'corp_ra_state'}
      ,{205,'corp_ra_zip5'}
      ,{206,'corp_ra_zip4'}
      ,{207,'corp_ra_cart'}
      ,{208,'corp_ra_cr_sort_sz'}
      ,{209,'corp_ra_lot'}
      ,{210,'corp_ra_lot_order'}
      ,{211,'corp_ra_dpbc'}
      ,{212,'corp_ra_chk_digit'}
      ,{213,'corp_ra_rec_type'}
      ,{214,'corp_ra_ace_fips_st'}
      ,{215,'corp_ra_county'}
      ,{216,'corp_ra_geo_lat'}
      ,{217,'corp_ra_geo_long'}
      ,{218,'corp_ra_msa'}
      ,{219,'corp_ra_geo_blk'}
      ,{220,'corp_ra_geo_match'}
      ,{221,'corp_ra_err_stat'}
      ,{222,'corp_phone10'}
      ,{223,'corp_ra_phone10'}
      ,{224,'record_type'}
      ,{225,'append_addr1_rawaid'}
      ,{226,'append_addr1_aceaid'}
      ,{227,'corp_prep_addr1_line1'}
      ,{228,'corp_prep_addr1_last_line'}
      ,{229,'append_addr2_rawaid'}
      ,{230,'append_addr2_aceaid'}
      ,{231,'corp_prep_addr2_line1'}
      ,{232,'corp_prep_addr2_last_line'}
      ,{233,'append_ra_rawaid'}
      ,{234,'append_ra_aceaid'}
      ,{235,'ra_prep_addr_line1'}
      ,{236,'ra_prep_addr_last_line'}
      ,{237,'dotid'}
      ,{238,'dotscore'}
      ,{239,'dotweight'}
      ,{240,'empid'}
      ,{241,'empscore'}
      ,{242,'empweight'}
      ,{243,'powid'}
      ,{244,'powscore'}
      ,{245,'powweight'}
      ,{246,'proxid'}
      ,{247,'proxscore'}
      ,{248,'proxweight'}
      ,{249,'seleid'}
      ,{250,'selescore'}
      ,{251,'seleweight'}
      ,{252,'orgid'}
      ,{253,'orgscore'}
      ,{254,'orgweight'}
      ,{255,'ultid'}
      ,{256,'ultscore'}
      ,{257,'ultweight'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_source_rec_id((SALT30.StrType)le.source_rec_id),
    Fields.InValid_bdid((SALT30.StrType)le.bdid),
    Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT30.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT30.StrType)le.dt_vendor_last_reported),
    Fields.InValid_corp_ra_dt_first_seen((SALT30.StrType)le.corp_ra_dt_first_seen),
    Fields.InValid_corp_ra_dt_last_seen((SALT30.StrType)le.corp_ra_dt_last_seen),
    Fields.InValid_corp_key((SALT30.StrType)le.corp_key),
    Fields.InValid_corp_supp_key((SALT30.StrType)le.corp_supp_key),
    Fields.InValid_corp_vendor((SALT30.StrType)le.corp_vendor),
    Fields.InValid_corp_vendor_county((SALT30.StrType)le.corp_vendor_county),
    Fields.InValid_corp_vendor_subcode((SALT30.StrType)le.corp_vendor_subcode),
    Fields.InValid_corp_state_origin((SALT30.StrType)le.corp_state_origin),
    Fields.InValid_corp_process_date((SALT30.StrType)le.corp_process_date),
    Fields.InValid_corp_orig_sos_charter_nbr((SALT30.StrType)le.corp_orig_sos_charter_nbr),
    Fields.InValid_corp_sos_charter_nbr((SALT30.StrType)le.corp_sos_charter_nbr),
    Fields.InValid_corp_src_type((SALT30.StrType)le.corp_src_type),
    Fields.InValid_corp_legal_name((SALT30.StrType)le.corp_legal_name),
    Fields.InValid_corp_ln_name_type_cd((SALT30.StrType)le.corp_ln_name_type_cd),
    Fields.InValid_corp_ln_name_type_desc((SALT30.StrType)le.corp_ln_name_type_desc),
    Fields.InValid_corp_supp_nbr((SALT30.StrType)le.corp_supp_nbr),
    Fields.InValid_corp_name_comment((SALT30.StrType)le.corp_name_comment),
    Fields.InValid_corp_address1_type_cd((SALT30.StrType)le.corp_address1_type_cd),
    Fields.InValid_corp_address1_type_desc((SALT30.StrType)le.corp_address1_type_desc),
    Fields.InValid_corp_address1_line1((SALT30.StrType)le.corp_address1_line1),
    Fields.InValid_corp_address1_line2((SALT30.StrType)le.corp_address1_line2),
    Fields.InValid_corp_address1_line3((SALT30.StrType)le.corp_address1_line3),
    Fields.InValid_corp_address1_line4((SALT30.StrType)le.corp_address1_line4),
    Fields.InValid_corp_address1_line5((SALT30.StrType)le.corp_address1_line5),
    Fields.InValid_corp_address1_line6((SALT30.StrType)le.corp_address1_line6),
    Fields.InValid_corp_address1_effective_date((SALT30.StrType)le.corp_address1_effective_date),
    Fields.InValid_corp_address2_type_cd((SALT30.StrType)le.corp_address2_type_cd),
    Fields.InValid_corp_address2_type_desc((SALT30.StrType)le.corp_address2_type_desc),
    Fields.InValid_corp_address2_line1((SALT30.StrType)le.corp_address2_line1),
    Fields.InValid_corp_address2_line2((SALT30.StrType)le.corp_address2_line2),
    Fields.InValid_corp_address2_line3((SALT30.StrType)le.corp_address2_line3),
    Fields.InValid_corp_address2_line4((SALT30.StrType)le.corp_address2_line4),
    Fields.InValid_corp_address2_line5((SALT30.StrType)le.corp_address2_line5),
    Fields.InValid_corp_address2_line6((SALT30.StrType)le.corp_address2_line6),
    Fields.InValid_corp_address2_effective_date((SALT30.StrType)le.corp_address2_effective_date),
    Fields.InValid_corp_phone_number((SALT30.StrType)le.corp_phone_number),
    Fields.InValid_corp_phone_number_type_cd((SALT30.StrType)le.corp_phone_number_type_cd),
    Fields.InValid_corp_phone_number_type_desc((SALT30.StrType)le.corp_phone_number_type_desc),
    Fields.InValid_corp_fax_nbr((SALT30.StrType)le.corp_fax_nbr),
    Fields.InValid_corp_email_address((SALT30.StrType)le.corp_email_address),
    Fields.InValid_corp_web_address((SALT30.StrType)le.corp_web_address),
    Fields.InValid_corp_filing_reference_nbr((SALT30.StrType)le.corp_filing_reference_nbr),
    Fields.InValid_corp_filing_date((SALT30.StrType)le.corp_filing_date),
    Fields.InValid_corp_filing_cd((SALT30.StrType)le.corp_filing_cd),
    Fields.InValid_corp_filing_desc((SALT30.StrType)le.corp_filing_desc),
    Fields.InValid_corp_status_cd((SALT30.StrType)le.corp_status_cd),
    Fields.InValid_corp_status_desc((SALT30.StrType)le.corp_status_desc),
    Fields.InValid_corp_status_date((SALT30.StrType)le.corp_status_date),
    Fields.InValid_corp_standing((SALT30.StrType)le.corp_standing),
    Fields.InValid_corp_status_comment((SALT30.StrType)le.corp_status_comment),
    Fields.InValid_corp_ticker_symbol((SALT30.StrType)le.corp_ticker_symbol),
    Fields.InValid_corp_stock_exchange((SALT30.StrType)le.corp_stock_exchange),
    Fields.InValid_corp_inc_state((SALT30.StrType)le.corp_inc_state),
    Fields.InValid_corp_inc_county((SALT30.StrType)le.corp_inc_county),
    Fields.InValid_corp_inc_date((SALT30.StrType)le.corp_inc_date),
    Fields.InValid_corp_anniversary_month((SALT30.StrType)le.corp_anniversary_month),
    Fields.InValid_corp_fed_tax_id((SALT30.StrType)le.corp_fed_tax_id),
    Fields.InValid_corp_state_tax_id((SALT30.StrType)le.corp_state_tax_id),
    Fields.InValid_corp_term_exist_cd((SALT30.StrType)le.corp_term_exist_cd),
    Fields.InValid_corp_term_exist_exp((SALT30.StrType)le.corp_term_exist_exp),
    Fields.InValid_corp_term_exist_desc((SALT30.StrType)le.corp_term_exist_desc),
    Fields.InValid_corp_foreign_domestic_ind((SALT30.StrType)le.corp_foreign_domestic_ind),
    Fields.InValid_corp_forgn_state_cd((SALT30.StrType)le.corp_forgn_state_cd),
    Fields.InValid_corp_forgn_state_desc((SALT30.StrType)le.corp_forgn_state_desc),
    Fields.InValid_corp_forgn_sos_charter_nbr((SALT30.StrType)le.corp_forgn_sos_charter_nbr),
    Fields.InValid_corp_forgn_date((SALT30.StrType)le.corp_forgn_date),
    Fields.InValid_corp_forgn_fed_tax_id((SALT30.StrType)le.corp_forgn_fed_tax_id),
    Fields.InValid_corp_forgn_state_tax_id((SALT30.StrType)le.corp_forgn_state_tax_id),
    Fields.InValid_corp_forgn_term_exist_cd((SALT30.StrType)le.corp_forgn_term_exist_cd),
    Fields.InValid_corp_forgn_term_exist_exp((SALT30.StrType)le.corp_forgn_term_exist_exp),
    Fields.InValid_corp_forgn_term_exist_desc((SALT30.StrType)le.corp_forgn_term_exist_desc),
    Fields.InValid_corp_orig_org_structure_cd((SALT30.StrType)le.corp_orig_org_structure_cd),
    Fields.InValid_corp_orig_org_structure_desc((SALT30.StrType)le.corp_orig_org_structure_desc),
    Fields.InValid_corp_for_profit_ind((SALT30.StrType)le.corp_for_profit_ind),
    Fields.InValid_corp_public_or_private_ind((SALT30.StrType)le.corp_public_or_private_ind),
    Fields.InValid_corp_sic_code((SALT30.StrType)le.corp_sic_code),
    Fields.InValid_corp_naic_code((SALT30.StrType)le.corp_naic_code),
    Fields.InValid_corp_orig_bus_type_cd((SALT30.StrType)le.corp_orig_bus_type_cd),
    Fields.InValid_corp_orig_bus_type_desc((SALT30.StrType)le.corp_orig_bus_type_desc),
    Fields.InValid_corp_entity_desc((SALT30.StrType)le.corp_entity_desc),
    Fields.InValid_corp_certificate_nbr((SALT30.StrType)le.corp_certificate_nbr),
    Fields.InValid_corp_internal_nbr((SALT30.StrType)le.corp_internal_nbr),
    Fields.InValid_corp_previous_nbr((SALT30.StrType)le.corp_previous_nbr),
    Fields.InValid_corp_microfilm_nbr((SALT30.StrType)le.corp_microfilm_nbr),
    Fields.InValid_corp_amendments_filed((SALT30.StrType)le.corp_amendments_filed),
    Fields.InValid_corp_acts((SALT30.StrType)le.corp_acts),
    Fields.InValid_corp_partnership_ind((SALT30.StrType)le.corp_partnership_ind),
    Fields.InValid_corp_mfg_ind((SALT30.StrType)le.corp_mfg_ind),
    Fields.InValid_corp_addl_info((SALT30.StrType)le.corp_addl_info),
    Fields.InValid_corp_taxes((SALT30.StrType)le.corp_taxes),
    Fields.InValid_corp_franchise_taxes((SALT30.StrType)le.corp_franchise_taxes),
    Fields.InValid_corp_tax_program_cd((SALT30.StrType)le.corp_tax_program_cd),
    Fields.InValid_corp_tax_program_desc((SALT30.StrType)le.corp_tax_program_desc),
    Fields.InValid_corp_ra_name((SALT30.StrType)le.corp_ra_name),
    Fields.InValid_corp_ra_title_cd((SALT30.StrType)le.corp_ra_title_cd),
    Fields.InValid_corp_ra_title_desc((SALT30.StrType)le.corp_ra_title_desc),
    Fields.InValid_corp_ra_fein((SALT30.StrType)le.corp_ra_fein),
    Fields.InValid_corp_ra_ssn((SALT30.StrType)le.corp_ra_ssn),
    Fields.InValid_corp_ra_dob((SALT30.StrType)le.corp_ra_dob),
    Fields.InValid_corp_ra_effective_date((SALT30.StrType)le.corp_ra_effective_date),
    Fields.InValid_corp_ra_resign_date((SALT30.StrType)le.corp_ra_resign_date),
    Fields.InValid_corp_ra_no_comp((SALT30.StrType)le.corp_ra_no_comp),
    Fields.InValid_corp_ra_no_comp_igs((SALT30.StrType)le.corp_ra_no_comp_igs),
    Fields.InValid_corp_ra_addl_info((SALT30.StrType)le.corp_ra_addl_info),
    Fields.InValid_corp_ra_address_type_cd((SALT30.StrType)le.corp_ra_address_type_cd),
    Fields.InValid_corp_ra_address_type_desc((SALT30.StrType)le.corp_ra_address_type_desc),
    Fields.InValid_corp_ra_address_line1((SALT30.StrType)le.corp_ra_address_line1),
    Fields.InValid_corp_ra_address_line2((SALT30.StrType)le.corp_ra_address_line2),
    Fields.InValid_corp_ra_address_line3((SALT30.StrType)le.corp_ra_address_line3),
    Fields.InValid_corp_ra_address_line4((SALT30.StrType)le.corp_ra_address_line4),
    Fields.InValid_corp_ra_address_line5((SALT30.StrType)le.corp_ra_address_line5),
    Fields.InValid_corp_ra_address_line6((SALT30.StrType)le.corp_ra_address_line6),
    Fields.InValid_corp_ra_phone_number((SALT30.StrType)le.corp_ra_phone_number),
    Fields.InValid_corp_ra_phone_number_type_cd((SALT30.StrType)le.corp_ra_phone_number_type_cd),
    Fields.InValid_corp_ra_phone_number_type_desc((SALT30.StrType)le.corp_ra_phone_number_type_desc),
    Fields.InValid_corp_ra_fax_nbr((SALT30.StrType)le.corp_ra_fax_nbr),
    Fields.InValid_corp_ra_email_address((SALT30.StrType)le.corp_ra_email_address),
    Fields.InValid_corp_ra_web_address((SALT30.StrType)le.corp_ra_web_address),
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
    Fields.InValid_corp_addr2_prim_range((SALT30.StrType)le.corp_addr2_prim_range),
    Fields.InValid_corp_addr2_predir((SALT30.StrType)le.corp_addr2_predir),
    Fields.InValid_corp_addr2_prim_name((SALT30.StrType)le.corp_addr2_prim_name),
    Fields.InValid_corp_addr2_addr_suffix((SALT30.StrType)le.corp_addr2_addr_suffix),
    Fields.InValid_corp_addr2_postdir((SALT30.StrType)le.corp_addr2_postdir),
    Fields.InValid_corp_addr2_unit_desig((SALT30.StrType)le.corp_addr2_unit_desig),
    Fields.InValid_corp_addr2_sec_range((SALT30.StrType)le.corp_addr2_sec_range),
    Fields.InValid_corp_addr2_p_city_name((SALT30.StrType)le.corp_addr2_p_city_name),
    Fields.InValid_corp_addr2_v_city_name((SALT30.StrType)le.corp_addr2_v_city_name),
    Fields.InValid_corp_addr2_state((SALT30.StrType)le.corp_addr2_state),
    Fields.InValid_corp_addr2_zip5((SALT30.StrType)le.corp_addr2_zip5),
    Fields.InValid_corp_addr2_zip4((SALT30.StrType)le.corp_addr2_zip4),
    Fields.InValid_corp_addr2_cart((SALT30.StrType)le.corp_addr2_cart),
    Fields.InValid_corp_addr2_cr_sort_sz((SALT30.StrType)le.corp_addr2_cr_sort_sz),
    Fields.InValid_corp_addr2_lot((SALT30.StrType)le.corp_addr2_lot),
    Fields.InValid_corp_addr2_lot_order((SALT30.StrType)le.corp_addr2_lot_order),
    Fields.InValid_corp_addr2_dpbc((SALT30.StrType)le.corp_addr2_dpbc),
    Fields.InValid_corp_addr2_chk_digit((SALT30.StrType)le.corp_addr2_chk_digit),
    Fields.InValid_corp_addr2_rec_type((SALT30.StrType)le.corp_addr2_rec_type),
    Fields.InValid_corp_addr2_ace_fips_st((SALT30.StrType)le.corp_addr2_ace_fips_st),
    Fields.InValid_corp_addr2_county((SALT30.StrType)le.corp_addr2_county),
    Fields.InValid_corp_addr2_geo_lat((SALT30.StrType)le.corp_addr2_geo_lat),
    Fields.InValid_corp_addr2_geo_long((SALT30.StrType)le.corp_addr2_geo_long),
    Fields.InValid_corp_addr2_msa((SALT30.StrType)le.corp_addr2_msa),
    Fields.InValid_corp_addr2_geo_blk((SALT30.StrType)le.corp_addr2_geo_blk),
    Fields.InValid_corp_addr2_geo_match((SALT30.StrType)le.corp_addr2_geo_match),
    Fields.InValid_corp_addr2_err_stat((SALT30.StrType)le.corp_addr2_err_stat),
    Fields.InValid_corp_ra_title1((SALT30.StrType)le.corp_ra_title1),
    Fields.InValid_corp_ra_fname1((SALT30.StrType)le.corp_ra_fname1),
    Fields.InValid_corp_ra_mname1((SALT30.StrType)le.corp_ra_mname1),
    Fields.InValid_corp_ra_lname1((SALT30.StrType)le.corp_ra_lname1),
    Fields.InValid_corp_ra_name_suffix1((SALT30.StrType)le.corp_ra_name_suffix1),
    Fields.InValid_corp_ra_score1((SALT30.StrType)le.corp_ra_score1),
    Fields.InValid_corp_ra_title2((SALT30.StrType)le.corp_ra_title2),
    Fields.InValid_corp_ra_fname2((SALT30.StrType)le.corp_ra_fname2),
    Fields.InValid_corp_ra_mname2((SALT30.StrType)le.corp_ra_mname2),
    Fields.InValid_corp_ra_lname2((SALT30.StrType)le.corp_ra_lname2),
    Fields.InValid_corp_ra_name_suffix2((SALT30.StrType)le.corp_ra_name_suffix2),
    Fields.InValid_corp_ra_score2((SALT30.StrType)le.corp_ra_score2),
    Fields.InValid_corp_ra_cname1((SALT30.StrType)le.corp_ra_cname1),
    Fields.InValid_corp_ra_cname1_score((SALT30.StrType)le.corp_ra_cname1_score),
    Fields.InValid_corp_ra_cname2((SALT30.StrType)le.corp_ra_cname2),
    Fields.InValid_corp_ra_cname2_score((SALT30.StrType)le.corp_ra_cname2_score),
    Fields.InValid_corp_ra_prim_range((SALT30.StrType)le.corp_ra_prim_range),
    Fields.InValid_corp_ra_predir((SALT30.StrType)le.corp_ra_predir),
    Fields.InValid_corp_ra_prim_name((SALT30.StrType)le.corp_ra_prim_name),
    Fields.InValid_corp_ra_addr_suffix((SALT30.StrType)le.corp_ra_addr_suffix),
    Fields.InValid_corp_ra_postdir((SALT30.StrType)le.corp_ra_postdir),
    Fields.InValid_corp_ra_unit_desig((SALT30.StrType)le.corp_ra_unit_desig),
    Fields.InValid_corp_ra_sec_range((SALT30.StrType)le.corp_ra_sec_range),
    Fields.InValid_corp_ra_p_city_name((SALT30.StrType)le.corp_ra_p_city_name),
    Fields.InValid_corp_ra_v_city_name((SALT30.StrType)le.corp_ra_v_city_name),
    Fields.InValid_corp_ra_state((SALT30.StrType)le.corp_ra_state),
    Fields.InValid_corp_ra_zip5((SALT30.StrType)le.corp_ra_zip5),
    Fields.InValid_corp_ra_zip4((SALT30.StrType)le.corp_ra_zip4),
    Fields.InValid_corp_ra_cart((SALT30.StrType)le.corp_ra_cart),
    Fields.InValid_corp_ra_cr_sort_sz((SALT30.StrType)le.corp_ra_cr_sort_sz),
    Fields.InValid_corp_ra_lot((SALT30.StrType)le.corp_ra_lot),
    Fields.InValid_corp_ra_lot_order((SALT30.StrType)le.corp_ra_lot_order),
    Fields.InValid_corp_ra_dpbc((SALT30.StrType)le.corp_ra_dpbc),
    Fields.InValid_corp_ra_chk_digit((SALT30.StrType)le.corp_ra_chk_digit),
    Fields.InValid_corp_ra_rec_type((SALT30.StrType)le.corp_ra_rec_type),
    Fields.InValid_corp_ra_ace_fips_st((SALT30.StrType)le.corp_ra_ace_fips_st),
    Fields.InValid_corp_ra_county((SALT30.StrType)le.corp_ra_county),
    Fields.InValid_corp_ra_geo_lat((SALT30.StrType)le.corp_ra_geo_lat),
    Fields.InValid_corp_ra_geo_long((SALT30.StrType)le.corp_ra_geo_long),
    Fields.InValid_corp_ra_msa((SALT30.StrType)le.corp_ra_msa),
    Fields.InValid_corp_ra_geo_blk((SALT30.StrType)le.corp_ra_geo_blk),
    Fields.InValid_corp_ra_geo_match((SALT30.StrType)le.corp_ra_geo_match),
    Fields.InValid_corp_ra_err_stat((SALT30.StrType)le.corp_ra_err_stat),
    Fields.InValid_corp_phone10((SALT30.StrType)le.corp_phone10),
    Fields.InValid_corp_ra_phone10((SALT30.StrType)le.corp_ra_phone10),
    Fields.InValid_record_type((SALT30.StrType)le.record_type),
    Fields.InValid_append_addr1_rawaid((SALT30.StrType)le.append_addr1_rawaid),
    Fields.InValid_append_addr1_aceaid((SALT30.StrType)le.append_addr1_aceaid),
    Fields.InValid_corp_prep_addr1_line1((SALT30.StrType)le.corp_prep_addr1_line1),
    Fields.InValid_corp_prep_addr1_last_line((SALT30.StrType)le.corp_prep_addr1_last_line),
    Fields.InValid_append_addr2_rawaid((SALT30.StrType)le.append_addr2_rawaid),
    Fields.InValid_append_addr2_aceaid((SALT30.StrType)le.append_addr2_aceaid),
    Fields.InValid_corp_prep_addr2_line1((SALT30.StrType)le.corp_prep_addr2_line1),
    Fields.InValid_corp_prep_addr2_last_line((SALT30.StrType)le.corp_prep_addr2_last_line),
    Fields.InValid_append_ra_rawaid((SALT30.StrType)le.append_ra_rawaid),
    Fields.InValid_append_ra_aceaid((SALT30.StrType)le.append_ra_aceaid),
    Fields.InValid_ra_prep_addr_line1((SALT30.StrType)le.ra_prep_addr_line1),
    Fields.InValid_ra_prep_addr_last_line((SALT30.StrType)le.ra_prep_addr_last_line),
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
Errors := NORMALIZE(h,257,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_corp_key','Unknown','invalid_corp_vendor','Unknown','Unknown','invalid_state_origin','invalid_date','invalid_mandatory','invalid_mandatory','Unknown','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_phone','Unknown','Unknown','invalid_phone','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_flag_code','Unknown','Unknown','Unknown','invalid_state_origin','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_forgn_dom_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_flag_code','invalid_flag_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_phone','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_supp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_subcode(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_corp_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_src_type(TotalErrors.ErrorNum),Fields.InValidMessage_corp_legal_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ln_name_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ln_name_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_supp_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_comment(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line3(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line4(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line5(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line6(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_line2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_line3(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_line4(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_line5(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_line6(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone_number_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone_number_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_fax_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_web_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_reference_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_standing(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_comment(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ticker_symbol(TotalErrors.ErrorNum),Fields.InValidMessage_corp_stock_exchange(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_anniversary_month(TotalErrors.ErrorNum),Fields.InValidMessage_corp_fed_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_term_exist_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_term_exist_exp(TotalErrors.ErrorNum),Fields.InValidMessage_corp_term_exist_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_foreign_domestic_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_state_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_state_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_fed_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_state_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_term_exist_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_term_exist_exp(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_term_exist_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_org_structure_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_org_structure_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_for_profit_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_public_or_private_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_sic_code(TotalErrors.ErrorNum),Fields.InValidMessage_corp_naic_code(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_bus_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_bus_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_entity_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_certificate_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_internal_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_previous_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_microfilm_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_amendments_filed(TotalErrors.ErrorNum),Fields.InValidMessage_corp_acts(TotalErrors.ErrorNum),Fields.InValidMessage_corp_partnership_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_mfg_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addl_info(TotalErrors.ErrorNum),Fields.InValidMessage_corp_taxes(TotalErrors.ErrorNum),Fields.InValidMessage_corp_franchise_taxes(TotalErrors.ErrorNum),Fields.InValidMessage_corp_tax_program_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_tax_program_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_title_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_title_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_fein(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dob(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_resign_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_no_comp(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_no_comp_igs(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_addl_info(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_line2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_line3(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_line4(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_line5(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_line6(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_phone_number_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_phone_number_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_fax_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_web_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_predir(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_cart(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_lot(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_msa(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr1_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_predir(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_cart(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_lot(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_msa(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addr2_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_title1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_fname1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_mname1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_lname1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_name_suffix1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_score1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_title2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_fname2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_mname2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_lname2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_name_suffix2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_score2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_cname1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_cname1_score(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_cname2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_cname2_score(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_predir(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_cart(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_lot(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_msa(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone10(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_phone10(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_append_addr1_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_append_addr1_aceaid(TotalErrors.ErrorNum),Fields.InValidMessage_corp_prep_addr1_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_prep_addr1_last_line(TotalErrors.ErrorNum),Fields.InValidMessage_append_addr2_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_append_addr2_aceaid(TotalErrors.ErrorNum),Fields.InValidMessage_corp_prep_addr2_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_prep_addr2_last_line(TotalErrors.ErrorNum),Fields.InValidMessage_append_ra_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_append_ra_aceaid(TotalErrors.ErrorNum),Fields.InValidMessage_ra_prep_addr_line1(TotalErrors.ErrorNum),Fields.InValidMessage_ra_prep_addr_last_line(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
