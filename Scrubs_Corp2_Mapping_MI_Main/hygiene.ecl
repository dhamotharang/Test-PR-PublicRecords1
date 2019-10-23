IMPORT SALT38,STD,Corp2_Mapping;
EXPORT hygiene(dataset(Corp2_Mapping.LayoutsCommon.Main) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_corp_ra_dt_first_seen_cnt := COUNT(GROUP,h.corp_ra_dt_first_seen <> (TYPEOF(h.corp_ra_dt_first_seen))'');
    populated_corp_ra_dt_first_seen_pcnt := AVE(GROUP,IF(h.corp_ra_dt_first_seen = (TYPEOF(h.corp_ra_dt_first_seen))'',0,100));
    maxlength_corp_ra_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_dt_first_seen)));
    avelength_corp_ra_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_dt_first_seen)),h.corp_ra_dt_first_seen<>(typeof(h.corp_ra_dt_first_seen))'');
    populated_corp_ra_dt_last_seen_cnt := COUNT(GROUP,h.corp_ra_dt_last_seen <> (TYPEOF(h.corp_ra_dt_last_seen))'');
    populated_corp_ra_dt_last_seen_pcnt := AVE(GROUP,IF(h.corp_ra_dt_last_seen = (TYPEOF(h.corp_ra_dt_last_seen))'',0,100));
    maxlength_corp_ra_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_dt_last_seen)));
    avelength_corp_ra_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_dt_last_seen)),h.corp_ra_dt_last_seen<>(typeof(h.corp_ra_dt_last_seen))'');
    populated_corp_key_cnt := COUNT(GROUP,h.corp_key <> (TYPEOF(h.corp_key))'');
    populated_corp_key_pcnt := AVE(GROUP,IF(h.corp_key = (TYPEOF(h.corp_key))'',0,100));
    maxlength_corp_key := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_key)));
    avelength_corp_key := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_key)),h.corp_key<>(typeof(h.corp_key))'');
    populated_corp_supp_key_cnt := COUNT(GROUP,h.corp_supp_key <> (TYPEOF(h.corp_supp_key))'');
    populated_corp_supp_key_pcnt := AVE(GROUP,IF(h.corp_supp_key = (TYPEOF(h.corp_supp_key))'',0,100));
    maxlength_corp_supp_key := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_supp_key)));
    avelength_corp_supp_key := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_supp_key)),h.corp_supp_key<>(typeof(h.corp_supp_key))'');
    populated_corp_vendor_cnt := COUNT(GROUP,h.corp_vendor <> (TYPEOF(h.corp_vendor))'');
    populated_corp_vendor_pcnt := AVE(GROUP,IF(h.corp_vendor = (TYPEOF(h.corp_vendor))'',0,100));
    maxlength_corp_vendor := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor)));
    avelength_corp_vendor := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor)),h.corp_vendor<>(typeof(h.corp_vendor))'');
    populated_corp_vendor_county_cnt := COUNT(GROUP,h.corp_vendor_county <> (TYPEOF(h.corp_vendor_county))'');
    populated_corp_vendor_county_pcnt := AVE(GROUP,IF(h.corp_vendor_county = (TYPEOF(h.corp_vendor_county))'',0,100));
    maxlength_corp_vendor_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_county)));
    avelength_corp_vendor_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_county)),h.corp_vendor_county<>(typeof(h.corp_vendor_county))'');
    populated_corp_vendor_subcode_cnt := COUNT(GROUP,h.corp_vendor_subcode <> (TYPEOF(h.corp_vendor_subcode))'');
    populated_corp_vendor_subcode_pcnt := AVE(GROUP,IF(h.corp_vendor_subcode = (TYPEOF(h.corp_vendor_subcode))'',0,100));
    maxlength_corp_vendor_subcode := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_subcode)));
    avelength_corp_vendor_subcode := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_subcode)),h.corp_vendor_subcode<>(typeof(h.corp_vendor_subcode))'');
    populated_corp_state_origin_cnt := COUNT(GROUP,h.corp_state_origin <> (TYPEOF(h.corp_state_origin))'');
    populated_corp_state_origin_pcnt := AVE(GROUP,IF(h.corp_state_origin = (TYPEOF(h.corp_state_origin))'',0,100));
    maxlength_corp_state_origin := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_state_origin)));
    avelength_corp_state_origin := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_state_origin)),h.corp_state_origin<>(typeof(h.corp_state_origin))'');
    populated_corp_process_date_cnt := COUNT(GROUP,h.corp_process_date <> (TYPEOF(h.corp_process_date))'');
    populated_corp_process_date_pcnt := AVE(GROUP,IF(h.corp_process_date = (TYPEOF(h.corp_process_date))'',0,100));
    maxlength_corp_process_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_process_date)));
    avelength_corp_process_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_process_date)),h.corp_process_date<>(typeof(h.corp_process_date))'');
    populated_corp_orig_sos_charter_nbr_cnt := COUNT(GROUP,h.corp_orig_sos_charter_nbr <> (TYPEOF(h.corp_orig_sos_charter_nbr))'');
    populated_corp_orig_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_orig_sos_charter_nbr = (TYPEOF(h.corp_orig_sos_charter_nbr))'',0,100));
    maxlength_corp_orig_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_orig_sos_charter_nbr)));
    avelength_corp_orig_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_orig_sos_charter_nbr)),h.corp_orig_sos_charter_nbr<>(typeof(h.corp_orig_sos_charter_nbr))'');
    populated_corp_legal_name_cnt := COUNT(GROUP,h.corp_legal_name <> (TYPEOF(h.corp_legal_name))'');
    populated_corp_legal_name_pcnt := AVE(GROUP,IF(h.corp_legal_name = (TYPEOF(h.corp_legal_name))'',0,100));
    maxlength_corp_legal_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_legal_name)));
    avelength_corp_legal_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_legal_name)),h.corp_legal_name<>(typeof(h.corp_legal_name))'');
    populated_corp_ln_name_type_cd_cnt := COUNT(GROUP,h.corp_ln_name_type_cd <> (TYPEOF(h.corp_ln_name_type_cd))'');
    populated_corp_ln_name_type_cd_pcnt := AVE(GROUP,IF(h.corp_ln_name_type_cd = (TYPEOF(h.corp_ln_name_type_cd))'',0,100));
    maxlength_corp_ln_name_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ln_name_type_cd)));
    avelength_corp_ln_name_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ln_name_type_cd)),h.corp_ln_name_type_cd<>(typeof(h.corp_ln_name_type_cd))'');
    populated_corp_ln_name_type_desc_cnt := COUNT(GROUP,h.corp_ln_name_type_desc <> (TYPEOF(h.corp_ln_name_type_desc))'');
    populated_corp_ln_name_type_desc_pcnt := AVE(GROUP,IF(h.corp_ln_name_type_desc = (TYPEOF(h.corp_ln_name_type_desc))'',0,100));
    maxlength_corp_ln_name_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ln_name_type_desc)));
    avelength_corp_ln_name_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ln_name_type_desc)),h.corp_ln_name_type_desc<>(typeof(h.corp_ln_name_type_desc))'');
    populated_corp_supp_nbr_cnt := COUNT(GROUP,h.corp_supp_nbr <> (TYPEOF(h.corp_supp_nbr))'');
    populated_corp_supp_nbr_pcnt := AVE(GROUP,IF(h.corp_supp_nbr = (TYPEOF(h.corp_supp_nbr))'',0,100));
    maxlength_corp_supp_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_supp_nbr)));
    avelength_corp_supp_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_supp_nbr)),h.corp_supp_nbr<>(typeof(h.corp_supp_nbr))'');
    populated_corp_name_comment_cnt := COUNT(GROUP,h.corp_name_comment <> (TYPEOF(h.corp_name_comment))'');
    populated_corp_name_comment_pcnt := AVE(GROUP,IF(h.corp_name_comment = (TYPEOF(h.corp_name_comment))'',0,100));
    maxlength_corp_name_comment := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_comment)));
    avelength_corp_name_comment := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_comment)),h.corp_name_comment<>(typeof(h.corp_name_comment))'');
    populated_corp_address1_type_cd_cnt := COUNT(GROUP,h.corp_address1_type_cd <> (TYPEOF(h.corp_address1_type_cd))'');
    populated_corp_address1_type_cd_pcnt := AVE(GROUP,IF(h.corp_address1_type_cd = (TYPEOF(h.corp_address1_type_cd))'',0,100));
    maxlength_corp_address1_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_type_cd)));
    avelength_corp_address1_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_type_cd)),h.corp_address1_type_cd<>(typeof(h.corp_address1_type_cd))'');
    populated_corp_address1_type_desc_cnt := COUNT(GROUP,h.corp_address1_type_desc <> (TYPEOF(h.corp_address1_type_desc))'');
    populated_corp_address1_type_desc_pcnt := AVE(GROUP,IF(h.corp_address1_type_desc = (TYPEOF(h.corp_address1_type_desc))'',0,100));
    maxlength_corp_address1_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_type_desc)));
    avelength_corp_address1_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_type_desc)),h.corp_address1_type_desc<>(typeof(h.corp_address1_type_desc))'');
    populated_corp_address1_line1_cnt := COUNT(GROUP,h.corp_address1_line1 <> (TYPEOF(h.corp_address1_line1))'');
    populated_corp_address1_line1_pcnt := AVE(GROUP,IF(h.corp_address1_line1 = (TYPEOF(h.corp_address1_line1))'',0,100));
    maxlength_corp_address1_line1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_line1)));
    avelength_corp_address1_line1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_line1)),h.corp_address1_line1<>(typeof(h.corp_address1_line1))'');
    populated_corp_address1_line2_cnt := COUNT(GROUP,h.corp_address1_line2 <> (TYPEOF(h.corp_address1_line2))'');
    populated_corp_address1_line2_pcnt := AVE(GROUP,IF(h.corp_address1_line2 = (TYPEOF(h.corp_address1_line2))'',0,100));
    maxlength_corp_address1_line2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_line2)));
    avelength_corp_address1_line2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_line2)),h.corp_address1_line2<>(typeof(h.corp_address1_line2))'');
    populated_corp_address1_line3_cnt := COUNT(GROUP,h.corp_address1_line3 <> (TYPEOF(h.corp_address1_line3))'');
    populated_corp_address1_line3_pcnt := AVE(GROUP,IF(h.corp_address1_line3 = (TYPEOF(h.corp_address1_line3))'',0,100));
    maxlength_corp_address1_line3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_line3)));
    avelength_corp_address1_line3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_line3)),h.corp_address1_line3<>(typeof(h.corp_address1_line3))'');
    populated_corp_address1_effective_date_cnt := COUNT(GROUP,h.corp_address1_effective_date <> (TYPEOF(h.corp_address1_effective_date))'');
    populated_corp_address1_effective_date_pcnt := AVE(GROUP,IF(h.corp_address1_effective_date = (TYPEOF(h.corp_address1_effective_date))'',0,100));
    maxlength_corp_address1_effective_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_effective_date)));
    avelength_corp_address1_effective_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address1_effective_date)),h.corp_address1_effective_date<>(typeof(h.corp_address1_effective_date))'');
    populated_corp_address2_type_cd_cnt := COUNT(GROUP,h.corp_address2_type_cd <> (TYPEOF(h.corp_address2_type_cd))'');
    populated_corp_address2_type_cd_pcnt := AVE(GROUP,IF(h.corp_address2_type_cd = (TYPEOF(h.corp_address2_type_cd))'',0,100));
    maxlength_corp_address2_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_type_cd)));
    avelength_corp_address2_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_type_cd)),h.corp_address2_type_cd<>(typeof(h.corp_address2_type_cd))'');
    populated_corp_address2_type_desc_cnt := COUNT(GROUP,h.corp_address2_type_desc <> (TYPEOF(h.corp_address2_type_desc))'');
    populated_corp_address2_type_desc_pcnt := AVE(GROUP,IF(h.corp_address2_type_desc = (TYPEOF(h.corp_address2_type_desc))'',0,100));
    maxlength_corp_address2_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_type_desc)));
    avelength_corp_address2_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_type_desc)),h.corp_address2_type_desc<>(typeof(h.corp_address2_type_desc))'');
    populated_corp_address2_line1_cnt := COUNT(GROUP,h.corp_address2_line1 <> (TYPEOF(h.corp_address2_line1))'');
    populated_corp_address2_line1_pcnt := AVE(GROUP,IF(h.corp_address2_line1 = (TYPEOF(h.corp_address2_line1))'',0,100));
    maxlength_corp_address2_line1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_line1)));
    avelength_corp_address2_line1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_line1)),h.corp_address2_line1<>(typeof(h.corp_address2_line1))'');
    populated_corp_address2_line2_cnt := COUNT(GROUP,h.corp_address2_line2 <> (TYPEOF(h.corp_address2_line2))'');
    populated_corp_address2_line2_pcnt := AVE(GROUP,IF(h.corp_address2_line2 = (TYPEOF(h.corp_address2_line2))'',0,100));
    maxlength_corp_address2_line2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_line2)));
    avelength_corp_address2_line2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_line2)),h.corp_address2_line2<>(typeof(h.corp_address2_line2))'');
    populated_corp_address2_line3_cnt := COUNT(GROUP,h.corp_address2_line3 <> (TYPEOF(h.corp_address2_line3))'');
    populated_corp_address2_line3_pcnt := AVE(GROUP,IF(h.corp_address2_line3 = (TYPEOF(h.corp_address2_line3))'',0,100));
    maxlength_corp_address2_line3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_line3)));
    avelength_corp_address2_line3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_line3)),h.corp_address2_line3<>(typeof(h.corp_address2_line3))'');
    populated_corp_address2_effective_date_cnt := COUNT(GROUP,h.corp_address2_effective_date <> (TYPEOF(h.corp_address2_effective_date))'');
    populated_corp_address2_effective_date_pcnt := AVE(GROUP,IF(h.corp_address2_effective_date = (TYPEOF(h.corp_address2_effective_date))'',0,100));
    maxlength_corp_address2_effective_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_effective_date)));
    avelength_corp_address2_effective_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address2_effective_date)),h.corp_address2_effective_date<>(typeof(h.corp_address2_effective_date))'');
    populated_corp_phone_number_cnt := COUNT(GROUP,h.corp_phone_number <> (TYPEOF(h.corp_phone_number))'');
    populated_corp_phone_number_pcnt := AVE(GROUP,IF(h.corp_phone_number = (TYPEOF(h.corp_phone_number))'',0,100));
    maxlength_corp_phone_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_phone_number)));
    avelength_corp_phone_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_phone_number)),h.corp_phone_number<>(typeof(h.corp_phone_number))'');
    populated_corp_phone_number_type_cd_cnt := COUNT(GROUP,h.corp_phone_number_type_cd <> (TYPEOF(h.corp_phone_number_type_cd))'');
    populated_corp_phone_number_type_cd_pcnt := AVE(GROUP,IF(h.corp_phone_number_type_cd = (TYPEOF(h.corp_phone_number_type_cd))'',0,100));
    maxlength_corp_phone_number_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_phone_number_type_cd)));
    avelength_corp_phone_number_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_phone_number_type_cd)),h.corp_phone_number_type_cd<>(typeof(h.corp_phone_number_type_cd))'');
    populated_corp_phone_number_type_desc_cnt := COUNT(GROUP,h.corp_phone_number_type_desc <> (TYPEOF(h.corp_phone_number_type_desc))'');
    populated_corp_phone_number_type_desc_pcnt := AVE(GROUP,IF(h.corp_phone_number_type_desc = (TYPEOF(h.corp_phone_number_type_desc))'',0,100));
    maxlength_corp_phone_number_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_phone_number_type_desc)));
    avelength_corp_phone_number_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_phone_number_type_desc)),h.corp_phone_number_type_desc<>(typeof(h.corp_phone_number_type_desc))'');
    populated_corp_fax_nbr_cnt := COUNT(GROUP,h.corp_fax_nbr <> (TYPEOF(h.corp_fax_nbr))'');
    populated_corp_fax_nbr_pcnt := AVE(GROUP,IF(h.corp_fax_nbr = (TYPEOF(h.corp_fax_nbr))'',0,100));
    maxlength_corp_fax_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_fax_nbr)));
    avelength_corp_fax_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_fax_nbr)),h.corp_fax_nbr<>(typeof(h.corp_fax_nbr))'');
    populated_corp_email_address_cnt := COUNT(GROUP,h.corp_email_address <> (TYPEOF(h.corp_email_address))'');
    populated_corp_email_address_pcnt := AVE(GROUP,IF(h.corp_email_address = (TYPEOF(h.corp_email_address))'',0,100));
    maxlength_corp_email_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_email_address)));
    avelength_corp_email_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_email_address)),h.corp_email_address<>(typeof(h.corp_email_address))'');
    populated_corp_web_address_cnt := COUNT(GROUP,h.corp_web_address <> (TYPEOF(h.corp_web_address))'');
    populated_corp_web_address_pcnt := AVE(GROUP,IF(h.corp_web_address = (TYPEOF(h.corp_web_address))'',0,100));
    maxlength_corp_web_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_web_address)));
    avelength_corp_web_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_web_address)),h.corp_web_address<>(typeof(h.corp_web_address))'');
    populated_corp_filing_reference_nbr_cnt := COUNT(GROUP,h.corp_filing_reference_nbr <> (TYPEOF(h.corp_filing_reference_nbr))'');
    populated_corp_filing_reference_nbr_pcnt := AVE(GROUP,IF(h.corp_filing_reference_nbr = (TYPEOF(h.corp_filing_reference_nbr))'',0,100));
    maxlength_corp_filing_reference_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_filing_reference_nbr)));
    avelength_corp_filing_reference_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_filing_reference_nbr)),h.corp_filing_reference_nbr<>(typeof(h.corp_filing_reference_nbr))'');
    populated_corp_filing_date_cnt := COUNT(GROUP,h.corp_filing_date <> (TYPEOF(h.corp_filing_date))'');
    populated_corp_filing_date_pcnt := AVE(GROUP,IF(h.corp_filing_date = (TYPEOF(h.corp_filing_date))'',0,100));
    maxlength_corp_filing_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_filing_date)));
    avelength_corp_filing_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_filing_date)),h.corp_filing_date<>(typeof(h.corp_filing_date))'');
    populated_corp_filing_cd_cnt := COUNT(GROUP,h.corp_filing_cd <> (TYPEOF(h.corp_filing_cd))'');
    populated_corp_filing_cd_pcnt := AVE(GROUP,IF(h.corp_filing_cd = (TYPEOF(h.corp_filing_cd))'',0,100));
    maxlength_corp_filing_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_filing_cd)));
    avelength_corp_filing_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_filing_cd)),h.corp_filing_cd<>(typeof(h.corp_filing_cd))'');
    populated_corp_filing_desc_cnt := COUNT(GROUP,h.corp_filing_desc <> (TYPEOF(h.corp_filing_desc))'');
    populated_corp_filing_desc_pcnt := AVE(GROUP,IF(h.corp_filing_desc = (TYPEOF(h.corp_filing_desc))'',0,100));
    maxlength_corp_filing_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_filing_desc)));
    avelength_corp_filing_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_filing_desc)),h.corp_filing_desc<>(typeof(h.corp_filing_desc))'');
    populated_corp_status_cd_cnt := COUNT(GROUP,h.corp_status_cd <> (TYPEOF(h.corp_status_cd))'');
    populated_corp_status_cd_pcnt := AVE(GROUP,IF(h.corp_status_cd = (TYPEOF(h.corp_status_cd))'',0,100));
    maxlength_corp_status_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_status_cd)));
    avelength_corp_status_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_status_cd)),h.corp_status_cd<>(typeof(h.corp_status_cd))'');
    populated_corp_status_desc_cnt := COUNT(GROUP,h.corp_status_desc <> (TYPEOF(h.corp_status_desc))'');
    populated_corp_status_desc_pcnt := AVE(GROUP,IF(h.corp_status_desc = (TYPEOF(h.corp_status_desc))'',0,100));
    maxlength_corp_status_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_status_desc)));
    avelength_corp_status_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_status_desc)),h.corp_status_desc<>(typeof(h.corp_status_desc))'');
    populated_corp_status_date_cnt := COUNT(GROUP,h.corp_status_date <> (TYPEOF(h.corp_status_date))'');
    populated_corp_status_date_pcnt := AVE(GROUP,IF(h.corp_status_date = (TYPEOF(h.corp_status_date))'',0,100));
    maxlength_corp_status_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_status_date)));
    avelength_corp_status_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_status_date)),h.corp_status_date<>(typeof(h.corp_status_date))'');
    populated_corp_standing_cnt := COUNT(GROUP,h.corp_standing <> (TYPEOF(h.corp_standing))'');
    populated_corp_standing_pcnt := AVE(GROUP,IF(h.corp_standing = (TYPEOF(h.corp_standing))'',0,100));
    maxlength_corp_standing := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_standing)));
    avelength_corp_standing := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_standing)),h.corp_standing<>(typeof(h.corp_standing))'');
    populated_corp_status_comment_cnt := COUNT(GROUP,h.corp_status_comment <> (TYPEOF(h.corp_status_comment))'');
    populated_corp_status_comment_pcnt := AVE(GROUP,IF(h.corp_status_comment = (TYPEOF(h.corp_status_comment))'',0,100));
    maxlength_corp_status_comment := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_status_comment)));
    avelength_corp_status_comment := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_status_comment)),h.corp_status_comment<>(typeof(h.corp_status_comment))'');
    populated_corp_ticker_symbol_cnt := COUNT(GROUP,h.corp_ticker_symbol <> (TYPEOF(h.corp_ticker_symbol))'');
    populated_corp_ticker_symbol_pcnt := AVE(GROUP,IF(h.corp_ticker_symbol = (TYPEOF(h.corp_ticker_symbol))'',0,100));
    maxlength_corp_ticker_symbol := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ticker_symbol)));
    avelength_corp_ticker_symbol := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ticker_symbol)),h.corp_ticker_symbol<>(typeof(h.corp_ticker_symbol))'');
    populated_corp_stock_exchange_cnt := COUNT(GROUP,h.corp_stock_exchange <> (TYPEOF(h.corp_stock_exchange))'');
    populated_corp_stock_exchange_pcnt := AVE(GROUP,IF(h.corp_stock_exchange = (TYPEOF(h.corp_stock_exchange))'',0,100));
    maxlength_corp_stock_exchange := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_stock_exchange)));
    avelength_corp_stock_exchange := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_stock_exchange)),h.corp_stock_exchange<>(typeof(h.corp_stock_exchange))'');
    populated_corp_inc_state_cnt := COUNT(GROUP,h.corp_inc_state <> (TYPEOF(h.corp_inc_state))'');
    populated_corp_inc_state_pcnt := AVE(GROUP,IF(h.corp_inc_state = (TYPEOF(h.corp_inc_state))'',0,100));
    maxlength_corp_inc_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_inc_state)));
    avelength_corp_inc_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_inc_state)),h.corp_inc_state<>(typeof(h.corp_inc_state))'');
    populated_corp_inc_county_cnt := COUNT(GROUP,h.corp_inc_county <> (TYPEOF(h.corp_inc_county))'');
    populated_corp_inc_county_pcnt := AVE(GROUP,IF(h.corp_inc_county = (TYPEOF(h.corp_inc_county))'',0,100));
    maxlength_corp_inc_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_inc_county)));
    avelength_corp_inc_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_inc_county)),h.corp_inc_county<>(typeof(h.corp_inc_county))'');
    populated_corp_inc_date_cnt := COUNT(GROUP,h.corp_inc_date <> (TYPEOF(h.corp_inc_date))'');
    populated_corp_inc_date_pcnt := AVE(GROUP,IF(h.corp_inc_date = (TYPEOF(h.corp_inc_date))'',0,100));
    maxlength_corp_inc_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_inc_date)));
    avelength_corp_inc_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_inc_date)),h.corp_inc_date<>(typeof(h.corp_inc_date))'');
    populated_corp_anniversary_month_cnt := COUNT(GROUP,h.corp_anniversary_month <> (TYPEOF(h.corp_anniversary_month))'');
    populated_corp_anniversary_month_pcnt := AVE(GROUP,IF(h.corp_anniversary_month = (TYPEOF(h.corp_anniversary_month))'',0,100));
    maxlength_corp_anniversary_month := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_anniversary_month)));
    avelength_corp_anniversary_month := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_anniversary_month)),h.corp_anniversary_month<>(typeof(h.corp_anniversary_month))'');
    populated_corp_fed_tax_id_cnt := COUNT(GROUP,h.corp_fed_tax_id <> (TYPEOF(h.corp_fed_tax_id))'');
    populated_corp_fed_tax_id_pcnt := AVE(GROUP,IF(h.corp_fed_tax_id = (TYPEOF(h.corp_fed_tax_id))'',0,100));
    maxlength_corp_fed_tax_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_fed_tax_id)));
    avelength_corp_fed_tax_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_fed_tax_id)),h.corp_fed_tax_id<>(typeof(h.corp_fed_tax_id))'');
    populated_corp_state_tax_id_cnt := COUNT(GROUP,h.corp_state_tax_id <> (TYPEOF(h.corp_state_tax_id))'');
    populated_corp_state_tax_id_pcnt := AVE(GROUP,IF(h.corp_state_tax_id = (TYPEOF(h.corp_state_tax_id))'',0,100));
    maxlength_corp_state_tax_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_state_tax_id)));
    avelength_corp_state_tax_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_state_tax_id)),h.corp_state_tax_id<>(typeof(h.corp_state_tax_id))'');
    populated_corp_term_exist_cd_cnt := COUNT(GROUP,h.corp_term_exist_cd <> (TYPEOF(h.corp_term_exist_cd))'');
    populated_corp_term_exist_cd_pcnt := AVE(GROUP,IF(h.corp_term_exist_cd = (TYPEOF(h.corp_term_exist_cd))'',0,100));
    maxlength_corp_term_exist_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_term_exist_cd)));
    avelength_corp_term_exist_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_term_exist_cd)),h.corp_term_exist_cd<>(typeof(h.corp_term_exist_cd))'');
    populated_corp_term_exist_exp_cnt := COUNT(GROUP,h.corp_term_exist_exp <> (TYPEOF(h.corp_term_exist_exp))'');
    populated_corp_term_exist_exp_pcnt := AVE(GROUP,IF(h.corp_term_exist_exp = (TYPEOF(h.corp_term_exist_exp))'',0,100));
    maxlength_corp_term_exist_exp := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_term_exist_exp)));
    avelength_corp_term_exist_exp := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_term_exist_exp)),h.corp_term_exist_exp<>(typeof(h.corp_term_exist_exp))'');
    populated_corp_term_exist_desc_cnt := COUNT(GROUP,h.corp_term_exist_desc <> (TYPEOF(h.corp_term_exist_desc))'');
    populated_corp_term_exist_desc_pcnt := AVE(GROUP,IF(h.corp_term_exist_desc = (TYPEOF(h.corp_term_exist_desc))'',0,100));
    maxlength_corp_term_exist_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_term_exist_desc)));
    avelength_corp_term_exist_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_term_exist_desc)),h.corp_term_exist_desc<>(typeof(h.corp_term_exist_desc))'');
    populated_corp_foreign_domestic_ind_cnt := COUNT(GROUP,h.corp_foreign_domestic_ind <> (TYPEOF(h.corp_foreign_domestic_ind))'');
    populated_corp_foreign_domestic_ind_pcnt := AVE(GROUP,IF(h.corp_foreign_domestic_ind = (TYPEOF(h.corp_foreign_domestic_ind))'',0,100));
    maxlength_corp_foreign_domestic_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_foreign_domestic_ind)));
    avelength_corp_foreign_domestic_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_foreign_domestic_ind)),h.corp_foreign_domestic_ind<>(typeof(h.corp_foreign_domestic_ind))'');
    populated_corp_forgn_state_cd_cnt := COUNT(GROUP,h.corp_forgn_state_cd <> (TYPEOF(h.corp_forgn_state_cd))'');
    populated_corp_forgn_state_cd_pcnt := AVE(GROUP,IF(h.corp_forgn_state_cd = (TYPEOF(h.corp_forgn_state_cd))'',0,100));
    maxlength_corp_forgn_state_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_state_cd)));
    avelength_corp_forgn_state_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_state_cd)),h.corp_forgn_state_cd<>(typeof(h.corp_forgn_state_cd))'');
    populated_corp_forgn_state_desc_cnt := COUNT(GROUP,h.corp_forgn_state_desc <> (TYPEOF(h.corp_forgn_state_desc))'');
    populated_corp_forgn_state_desc_pcnt := AVE(GROUP,IF(h.corp_forgn_state_desc = (TYPEOF(h.corp_forgn_state_desc))'',0,100));
    maxlength_corp_forgn_state_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_state_desc)));
    avelength_corp_forgn_state_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_state_desc)),h.corp_forgn_state_desc<>(typeof(h.corp_forgn_state_desc))'');
    populated_corp_forgn_sos_charter_nbr_cnt := COUNT(GROUP,h.corp_forgn_sos_charter_nbr <> (TYPEOF(h.corp_forgn_sos_charter_nbr))'');
    populated_corp_forgn_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_forgn_sos_charter_nbr = (TYPEOF(h.corp_forgn_sos_charter_nbr))'',0,100));
    maxlength_corp_forgn_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_sos_charter_nbr)));
    avelength_corp_forgn_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_sos_charter_nbr)),h.corp_forgn_sos_charter_nbr<>(typeof(h.corp_forgn_sos_charter_nbr))'');
    populated_corp_forgn_date_cnt := COUNT(GROUP,h.corp_forgn_date <> (TYPEOF(h.corp_forgn_date))'');
    populated_corp_forgn_date_pcnt := AVE(GROUP,IF(h.corp_forgn_date = (TYPEOF(h.corp_forgn_date))'',0,100));
    maxlength_corp_forgn_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_date)));
    avelength_corp_forgn_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_date)),h.corp_forgn_date<>(typeof(h.corp_forgn_date))'');
    populated_corp_forgn_fed_tax_id_cnt := COUNT(GROUP,h.corp_forgn_fed_tax_id <> (TYPEOF(h.corp_forgn_fed_tax_id))'');
    populated_corp_forgn_fed_tax_id_pcnt := AVE(GROUP,IF(h.corp_forgn_fed_tax_id = (TYPEOF(h.corp_forgn_fed_tax_id))'',0,100));
    maxlength_corp_forgn_fed_tax_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_fed_tax_id)));
    avelength_corp_forgn_fed_tax_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_fed_tax_id)),h.corp_forgn_fed_tax_id<>(typeof(h.corp_forgn_fed_tax_id))'');
    populated_corp_forgn_state_tax_id_cnt := COUNT(GROUP,h.corp_forgn_state_tax_id <> (TYPEOF(h.corp_forgn_state_tax_id))'');
    populated_corp_forgn_state_tax_id_pcnt := AVE(GROUP,IF(h.corp_forgn_state_tax_id = (TYPEOF(h.corp_forgn_state_tax_id))'',0,100));
    maxlength_corp_forgn_state_tax_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_state_tax_id)));
    avelength_corp_forgn_state_tax_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_state_tax_id)),h.corp_forgn_state_tax_id<>(typeof(h.corp_forgn_state_tax_id))'');
    populated_corp_forgn_term_exist_cd_cnt := COUNT(GROUP,h.corp_forgn_term_exist_cd <> (TYPEOF(h.corp_forgn_term_exist_cd))'');
    populated_corp_forgn_term_exist_cd_pcnt := AVE(GROUP,IF(h.corp_forgn_term_exist_cd = (TYPEOF(h.corp_forgn_term_exist_cd))'',0,100));
    maxlength_corp_forgn_term_exist_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_term_exist_cd)));
    avelength_corp_forgn_term_exist_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_term_exist_cd)),h.corp_forgn_term_exist_cd<>(typeof(h.corp_forgn_term_exist_cd))'');
    populated_corp_forgn_term_exist_exp_cnt := COUNT(GROUP,h.corp_forgn_term_exist_exp <> (TYPEOF(h.corp_forgn_term_exist_exp))'');
    populated_corp_forgn_term_exist_exp_pcnt := AVE(GROUP,IF(h.corp_forgn_term_exist_exp = (TYPEOF(h.corp_forgn_term_exist_exp))'',0,100));
    maxlength_corp_forgn_term_exist_exp := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_term_exist_exp)));
    avelength_corp_forgn_term_exist_exp := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_term_exist_exp)),h.corp_forgn_term_exist_exp<>(typeof(h.corp_forgn_term_exist_exp))'');
    populated_corp_forgn_term_exist_desc_cnt := COUNT(GROUP,h.corp_forgn_term_exist_desc <> (TYPEOF(h.corp_forgn_term_exist_desc))'');
    populated_corp_forgn_term_exist_desc_pcnt := AVE(GROUP,IF(h.corp_forgn_term_exist_desc = (TYPEOF(h.corp_forgn_term_exist_desc))'',0,100));
    maxlength_corp_forgn_term_exist_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_term_exist_desc)));
    avelength_corp_forgn_term_exist_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_forgn_term_exist_desc)),h.corp_forgn_term_exist_desc<>(typeof(h.corp_forgn_term_exist_desc))'');
    populated_corp_orig_org_structure_cd_cnt := COUNT(GROUP,h.corp_orig_org_structure_cd <> (TYPEOF(h.corp_orig_org_structure_cd))'');
    populated_corp_orig_org_structure_cd_pcnt := AVE(GROUP,IF(h.corp_orig_org_structure_cd = (TYPEOF(h.corp_orig_org_structure_cd))'',0,100));
    maxlength_corp_orig_org_structure_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_orig_org_structure_cd)));
    avelength_corp_orig_org_structure_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_orig_org_structure_cd)),h.corp_orig_org_structure_cd<>(typeof(h.corp_orig_org_structure_cd))'');
    populated_corp_orig_org_structure_desc_cnt := COUNT(GROUP,h.corp_orig_org_structure_desc <> (TYPEOF(h.corp_orig_org_structure_desc))'');
    populated_corp_orig_org_structure_desc_pcnt := AVE(GROUP,IF(h.corp_orig_org_structure_desc = (TYPEOF(h.corp_orig_org_structure_desc))'',0,100));
    maxlength_corp_orig_org_structure_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_orig_org_structure_desc)));
    avelength_corp_orig_org_structure_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_orig_org_structure_desc)),h.corp_orig_org_structure_desc<>(typeof(h.corp_orig_org_structure_desc))'');
    populated_corp_for_profit_ind_cnt := COUNT(GROUP,h.corp_for_profit_ind <> (TYPEOF(h.corp_for_profit_ind))'');
    populated_corp_for_profit_ind_pcnt := AVE(GROUP,IF(h.corp_for_profit_ind = (TYPEOF(h.corp_for_profit_ind))'',0,100));
    maxlength_corp_for_profit_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_for_profit_ind)));
    avelength_corp_for_profit_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_for_profit_ind)),h.corp_for_profit_ind<>(typeof(h.corp_for_profit_ind))'');
    populated_corp_public_or_private_ind_cnt := COUNT(GROUP,h.corp_public_or_private_ind <> (TYPEOF(h.corp_public_or_private_ind))'');
    populated_corp_public_or_private_ind_pcnt := AVE(GROUP,IF(h.corp_public_or_private_ind = (TYPEOF(h.corp_public_or_private_ind))'',0,100));
    maxlength_corp_public_or_private_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_public_or_private_ind)));
    avelength_corp_public_or_private_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_public_or_private_ind)),h.corp_public_or_private_ind<>(typeof(h.corp_public_or_private_ind))'');
    populated_corp_sic_code_cnt := COUNT(GROUP,h.corp_sic_code <> (TYPEOF(h.corp_sic_code))'');
    populated_corp_sic_code_pcnt := AVE(GROUP,IF(h.corp_sic_code = (TYPEOF(h.corp_sic_code))'',0,100));
    maxlength_corp_sic_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_sic_code)));
    avelength_corp_sic_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_sic_code)),h.corp_sic_code<>(typeof(h.corp_sic_code))'');
    populated_corp_naic_code_cnt := COUNT(GROUP,h.corp_naic_code <> (TYPEOF(h.corp_naic_code))'');
    populated_corp_naic_code_pcnt := AVE(GROUP,IF(h.corp_naic_code = (TYPEOF(h.corp_naic_code))'',0,100));
    maxlength_corp_naic_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_naic_code)));
    avelength_corp_naic_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_naic_code)),h.corp_naic_code<>(typeof(h.corp_naic_code))'');
    populated_corp_orig_bus_type_cd_cnt := COUNT(GROUP,h.corp_orig_bus_type_cd <> (TYPEOF(h.corp_orig_bus_type_cd))'');
    populated_corp_orig_bus_type_cd_pcnt := AVE(GROUP,IF(h.corp_orig_bus_type_cd = (TYPEOF(h.corp_orig_bus_type_cd))'',0,100));
    maxlength_corp_orig_bus_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_orig_bus_type_cd)));
    avelength_corp_orig_bus_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_orig_bus_type_cd)),h.corp_orig_bus_type_cd<>(typeof(h.corp_orig_bus_type_cd))'');
    populated_corp_orig_bus_type_desc_cnt := COUNT(GROUP,h.corp_orig_bus_type_desc <> (TYPEOF(h.corp_orig_bus_type_desc))'');
    populated_corp_orig_bus_type_desc_pcnt := AVE(GROUP,IF(h.corp_orig_bus_type_desc = (TYPEOF(h.corp_orig_bus_type_desc))'',0,100));
    maxlength_corp_orig_bus_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_orig_bus_type_desc)));
    avelength_corp_orig_bus_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_orig_bus_type_desc)),h.corp_orig_bus_type_desc<>(typeof(h.corp_orig_bus_type_desc))'');
    populated_corp_entity_desc_cnt := COUNT(GROUP,h.corp_entity_desc <> (TYPEOF(h.corp_entity_desc))'');
    populated_corp_entity_desc_pcnt := AVE(GROUP,IF(h.corp_entity_desc = (TYPEOF(h.corp_entity_desc))'',0,100));
    maxlength_corp_entity_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_entity_desc)));
    avelength_corp_entity_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_entity_desc)),h.corp_entity_desc<>(typeof(h.corp_entity_desc))'');
    populated_corp_certificate_nbr_cnt := COUNT(GROUP,h.corp_certificate_nbr <> (TYPEOF(h.corp_certificate_nbr))'');
    populated_corp_certificate_nbr_pcnt := AVE(GROUP,IF(h.corp_certificate_nbr = (TYPEOF(h.corp_certificate_nbr))'',0,100));
    maxlength_corp_certificate_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_certificate_nbr)));
    avelength_corp_certificate_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_certificate_nbr)),h.corp_certificate_nbr<>(typeof(h.corp_certificate_nbr))'');
    populated_corp_internal_nbr_cnt := COUNT(GROUP,h.corp_internal_nbr <> (TYPEOF(h.corp_internal_nbr))'');
    populated_corp_internal_nbr_pcnt := AVE(GROUP,IF(h.corp_internal_nbr = (TYPEOF(h.corp_internal_nbr))'',0,100));
    maxlength_corp_internal_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_internal_nbr)));
    avelength_corp_internal_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_internal_nbr)),h.corp_internal_nbr<>(typeof(h.corp_internal_nbr))'');
    populated_corp_previous_nbr_cnt := COUNT(GROUP,h.corp_previous_nbr <> (TYPEOF(h.corp_previous_nbr))'');
    populated_corp_previous_nbr_pcnt := AVE(GROUP,IF(h.corp_previous_nbr = (TYPEOF(h.corp_previous_nbr))'',0,100));
    maxlength_corp_previous_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_previous_nbr)));
    avelength_corp_previous_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_previous_nbr)),h.corp_previous_nbr<>(typeof(h.corp_previous_nbr))'');
    populated_corp_microfilm_nbr_cnt := COUNT(GROUP,h.corp_microfilm_nbr <> (TYPEOF(h.corp_microfilm_nbr))'');
    populated_corp_microfilm_nbr_pcnt := AVE(GROUP,IF(h.corp_microfilm_nbr = (TYPEOF(h.corp_microfilm_nbr))'',0,100));
    maxlength_corp_microfilm_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_microfilm_nbr)));
    avelength_corp_microfilm_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_microfilm_nbr)),h.corp_microfilm_nbr<>(typeof(h.corp_microfilm_nbr))'');
    populated_corp_amendments_filed_cnt := COUNT(GROUP,h.corp_amendments_filed <> (TYPEOF(h.corp_amendments_filed))'');
    populated_corp_amendments_filed_pcnt := AVE(GROUP,IF(h.corp_amendments_filed = (TYPEOF(h.corp_amendments_filed))'',0,100));
    maxlength_corp_amendments_filed := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_amendments_filed)));
    avelength_corp_amendments_filed := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_amendments_filed)),h.corp_amendments_filed<>(typeof(h.corp_amendments_filed))'');
    populated_corp_acts_cnt := COUNT(GROUP,h.corp_acts <> (TYPEOF(h.corp_acts))'');
    populated_corp_acts_pcnt := AVE(GROUP,IF(h.corp_acts = (TYPEOF(h.corp_acts))'',0,100));
    maxlength_corp_acts := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_acts)));
    avelength_corp_acts := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_acts)),h.corp_acts<>(typeof(h.corp_acts))'');
    populated_corp_partnership_ind_cnt := COUNT(GROUP,h.corp_partnership_ind <> (TYPEOF(h.corp_partnership_ind))'');
    populated_corp_partnership_ind_pcnt := AVE(GROUP,IF(h.corp_partnership_ind = (TYPEOF(h.corp_partnership_ind))'',0,100));
    maxlength_corp_partnership_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_partnership_ind)));
    avelength_corp_partnership_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_partnership_ind)),h.corp_partnership_ind<>(typeof(h.corp_partnership_ind))'');
    populated_corp_mfg_ind_cnt := COUNT(GROUP,h.corp_mfg_ind <> (TYPEOF(h.corp_mfg_ind))'');
    populated_corp_mfg_ind_pcnt := AVE(GROUP,IF(h.corp_mfg_ind = (TYPEOF(h.corp_mfg_ind))'',0,100));
    maxlength_corp_mfg_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_mfg_ind)));
    avelength_corp_mfg_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_mfg_ind)),h.corp_mfg_ind<>(typeof(h.corp_mfg_ind))'');
    populated_corp_addl_info_cnt := COUNT(GROUP,h.corp_addl_info <> (TYPEOF(h.corp_addl_info))'');
    populated_corp_addl_info_pcnt := AVE(GROUP,IF(h.corp_addl_info = (TYPEOF(h.corp_addl_info))'',0,100));
    maxlength_corp_addl_info := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_addl_info)));
    avelength_corp_addl_info := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_addl_info)),h.corp_addl_info<>(typeof(h.corp_addl_info))'');
    populated_corp_taxes_cnt := COUNT(GROUP,h.corp_taxes <> (TYPEOF(h.corp_taxes))'');
    populated_corp_taxes_pcnt := AVE(GROUP,IF(h.corp_taxes = (TYPEOF(h.corp_taxes))'',0,100));
    maxlength_corp_taxes := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_taxes)));
    avelength_corp_taxes := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_taxes)),h.corp_taxes<>(typeof(h.corp_taxes))'');
    populated_corp_franchise_taxes_cnt := COUNT(GROUP,h.corp_franchise_taxes <> (TYPEOF(h.corp_franchise_taxes))'');
    populated_corp_franchise_taxes_pcnt := AVE(GROUP,IF(h.corp_franchise_taxes = (TYPEOF(h.corp_franchise_taxes))'',0,100));
    maxlength_corp_franchise_taxes := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_franchise_taxes)));
    avelength_corp_franchise_taxes := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_franchise_taxes)),h.corp_franchise_taxes<>(typeof(h.corp_franchise_taxes))'');
    populated_corp_tax_program_cd_cnt := COUNT(GROUP,h.corp_tax_program_cd <> (TYPEOF(h.corp_tax_program_cd))'');
    populated_corp_tax_program_cd_pcnt := AVE(GROUP,IF(h.corp_tax_program_cd = (TYPEOF(h.corp_tax_program_cd))'',0,100));
    maxlength_corp_tax_program_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_tax_program_cd)));
    avelength_corp_tax_program_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_tax_program_cd)),h.corp_tax_program_cd<>(typeof(h.corp_tax_program_cd))'');
    populated_corp_tax_program_desc_cnt := COUNT(GROUP,h.corp_tax_program_desc <> (TYPEOF(h.corp_tax_program_desc))'');
    populated_corp_tax_program_desc_pcnt := AVE(GROUP,IF(h.corp_tax_program_desc = (TYPEOF(h.corp_tax_program_desc))'',0,100));
    maxlength_corp_tax_program_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_tax_program_desc)));
    avelength_corp_tax_program_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_tax_program_desc)),h.corp_tax_program_desc<>(typeof(h.corp_tax_program_desc))'');
    populated_corp_ra_full_name_cnt := COUNT(GROUP,h.corp_ra_full_name <> (TYPEOF(h.corp_ra_full_name))'');
    populated_corp_ra_full_name_pcnt := AVE(GROUP,IF(h.corp_ra_full_name = (TYPEOF(h.corp_ra_full_name))'',0,100));
    maxlength_corp_ra_full_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_full_name)));
    avelength_corp_ra_full_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_full_name)),h.corp_ra_full_name<>(typeof(h.corp_ra_full_name))'');
    populated_corp_ra_fname_cnt := COUNT(GROUP,h.corp_ra_fname <> (TYPEOF(h.corp_ra_fname))'');
    populated_corp_ra_fname_pcnt := AVE(GROUP,IF(h.corp_ra_fname = (TYPEOF(h.corp_ra_fname))'',0,100));
    maxlength_corp_ra_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_fname)));
    avelength_corp_ra_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_fname)),h.corp_ra_fname<>(typeof(h.corp_ra_fname))'');
    populated_corp_ra_mname_cnt := COUNT(GROUP,h.corp_ra_mname <> (TYPEOF(h.corp_ra_mname))'');
    populated_corp_ra_mname_pcnt := AVE(GROUP,IF(h.corp_ra_mname = (TYPEOF(h.corp_ra_mname))'',0,100));
    maxlength_corp_ra_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_mname)));
    avelength_corp_ra_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_mname)),h.corp_ra_mname<>(typeof(h.corp_ra_mname))'');
    populated_corp_ra_lname_cnt := COUNT(GROUP,h.corp_ra_lname <> (TYPEOF(h.corp_ra_lname))'');
    populated_corp_ra_lname_pcnt := AVE(GROUP,IF(h.corp_ra_lname = (TYPEOF(h.corp_ra_lname))'',0,100));
    maxlength_corp_ra_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_lname)));
    avelength_corp_ra_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_lname)),h.corp_ra_lname<>(typeof(h.corp_ra_lname))'');
    populated_corp_ra_suffix_cnt := COUNT(GROUP,h.corp_ra_suffix <> (TYPEOF(h.corp_ra_suffix))'');
    populated_corp_ra_suffix_pcnt := AVE(GROUP,IF(h.corp_ra_suffix = (TYPEOF(h.corp_ra_suffix))'',0,100));
    maxlength_corp_ra_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_suffix)));
    avelength_corp_ra_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_suffix)),h.corp_ra_suffix<>(typeof(h.corp_ra_suffix))'');
    populated_corp_ra_title_cd_cnt := COUNT(GROUP,h.corp_ra_title_cd <> (TYPEOF(h.corp_ra_title_cd))'');
    populated_corp_ra_title_cd_pcnt := AVE(GROUP,IF(h.corp_ra_title_cd = (TYPEOF(h.corp_ra_title_cd))'',0,100));
    maxlength_corp_ra_title_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_title_cd)));
    avelength_corp_ra_title_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_title_cd)),h.corp_ra_title_cd<>(typeof(h.corp_ra_title_cd))'');
    populated_corp_ra_title_desc_cnt := COUNT(GROUP,h.corp_ra_title_desc <> (TYPEOF(h.corp_ra_title_desc))'');
    populated_corp_ra_title_desc_pcnt := AVE(GROUP,IF(h.corp_ra_title_desc = (TYPEOF(h.corp_ra_title_desc))'',0,100));
    maxlength_corp_ra_title_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_title_desc)));
    avelength_corp_ra_title_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_title_desc)),h.corp_ra_title_desc<>(typeof(h.corp_ra_title_desc))'');
    populated_corp_ra_fein_cnt := COUNT(GROUP,h.corp_ra_fein <> (TYPEOF(h.corp_ra_fein))'');
    populated_corp_ra_fein_pcnt := AVE(GROUP,IF(h.corp_ra_fein = (TYPEOF(h.corp_ra_fein))'',0,100));
    maxlength_corp_ra_fein := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_fein)));
    avelength_corp_ra_fein := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_fein)),h.corp_ra_fein<>(typeof(h.corp_ra_fein))'');
    populated_corp_ra_ssn_cnt := COUNT(GROUP,h.corp_ra_ssn <> (TYPEOF(h.corp_ra_ssn))'');
    populated_corp_ra_ssn_pcnt := AVE(GROUP,IF(h.corp_ra_ssn = (TYPEOF(h.corp_ra_ssn))'',0,100));
    maxlength_corp_ra_ssn := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_ssn)));
    avelength_corp_ra_ssn := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_ssn)),h.corp_ra_ssn<>(typeof(h.corp_ra_ssn))'');
    populated_corp_ra_dob_cnt := COUNT(GROUP,h.corp_ra_dob <> (TYPEOF(h.corp_ra_dob))'');
    populated_corp_ra_dob_pcnt := AVE(GROUP,IF(h.corp_ra_dob = (TYPEOF(h.corp_ra_dob))'',0,100));
    maxlength_corp_ra_dob := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_dob)));
    avelength_corp_ra_dob := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_dob)),h.corp_ra_dob<>(typeof(h.corp_ra_dob))'');
    populated_corp_ra_effective_date_cnt := COUNT(GROUP,h.corp_ra_effective_date <> (TYPEOF(h.corp_ra_effective_date))'');
    populated_corp_ra_effective_date_pcnt := AVE(GROUP,IF(h.corp_ra_effective_date = (TYPEOF(h.corp_ra_effective_date))'',0,100));
    maxlength_corp_ra_effective_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_effective_date)));
    avelength_corp_ra_effective_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_effective_date)),h.corp_ra_effective_date<>(typeof(h.corp_ra_effective_date))'');
    populated_corp_ra_resign_date_cnt := COUNT(GROUP,h.corp_ra_resign_date <> (TYPEOF(h.corp_ra_resign_date))'');
    populated_corp_ra_resign_date_pcnt := AVE(GROUP,IF(h.corp_ra_resign_date = (TYPEOF(h.corp_ra_resign_date))'',0,100));
    maxlength_corp_ra_resign_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_resign_date)));
    avelength_corp_ra_resign_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_resign_date)),h.corp_ra_resign_date<>(typeof(h.corp_ra_resign_date))'');
    populated_corp_ra_no_comp_cnt := COUNT(GROUP,h.corp_ra_no_comp <> (TYPEOF(h.corp_ra_no_comp))'');
    populated_corp_ra_no_comp_pcnt := AVE(GROUP,IF(h.corp_ra_no_comp = (TYPEOF(h.corp_ra_no_comp))'',0,100));
    maxlength_corp_ra_no_comp := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_no_comp)));
    avelength_corp_ra_no_comp := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_no_comp)),h.corp_ra_no_comp<>(typeof(h.corp_ra_no_comp))'');
    populated_corp_ra_no_comp_igs_cnt := COUNT(GROUP,h.corp_ra_no_comp_igs <> (TYPEOF(h.corp_ra_no_comp_igs))'');
    populated_corp_ra_no_comp_igs_pcnt := AVE(GROUP,IF(h.corp_ra_no_comp_igs = (TYPEOF(h.corp_ra_no_comp_igs))'',0,100));
    maxlength_corp_ra_no_comp_igs := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_no_comp_igs)));
    avelength_corp_ra_no_comp_igs := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_no_comp_igs)),h.corp_ra_no_comp_igs<>(typeof(h.corp_ra_no_comp_igs))'');
    populated_corp_ra_addl_info_cnt := COUNT(GROUP,h.corp_ra_addl_info <> (TYPEOF(h.corp_ra_addl_info))'');
    populated_corp_ra_addl_info_pcnt := AVE(GROUP,IF(h.corp_ra_addl_info = (TYPEOF(h.corp_ra_addl_info))'',0,100));
    maxlength_corp_ra_addl_info := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_addl_info)));
    avelength_corp_ra_addl_info := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_addl_info)),h.corp_ra_addl_info<>(typeof(h.corp_ra_addl_info))'');
    populated_corp_ra_address_type_cd_cnt := COUNT(GROUP,h.corp_ra_address_type_cd <> (TYPEOF(h.corp_ra_address_type_cd))'');
    populated_corp_ra_address_type_cd_pcnt := AVE(GROUP,IF(h.corp_ra_address_type_cd = (TYPEOF(h.corp_ra_address_type_cd))'',0,100));
    maxlength_corp_ra_address_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_address_type_cd)));
    avelength_corp_ra_address_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_address_type_cd)),h.corp_ra_address_type_cd<>(typeof(h.corp_ra_address_type_cd))'');
    populated_corp_ra_address_type_desc_cnt := COUNT(GROUP,h.corp_ra_address_type_desc <> (TYPEOF(h.corp_ra_address_type_desc))'');
    populated_corp_ra_address_type_desc_pcnt := AVE(GROUP,IF(h.corp_ra_address_type_desc = (TYPEOF(h.corp_ra_address_type_desc))'',0,100));
    maxlength_corp_ra_address_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_address_type_desc)));
    avelength_corp_ra_address_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_address_type_desc)),h.corp_ra_address_type_desc<>(typeof(h.corp_ra_address_type_desc))'');
    populated_corp_ra_address_line1_cnt := COUNT(GROUP,h.corp_ra_address_line1 <> (TYPEOF(h.corp_ra_address_line1))'');
    populated_corp_ra_address_line1_pcnt := AVE(GROUP,IF(h.corp_ra_address_line1 = (TYPEOF(h.corp_ra_address_line1))'',0,100));
    maxlength_corp_ra_address_line1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_address_line1)));
    avelength_corp_ra_address_line1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_address_line1)),h.corp_ra_address_line1<>(typeof(h.corp_ra_address_line1))'');
    populated_corp_ra_address_line2_cnt := COUNT(GROUP,h.corp_ra_address_line2 <> (TYPEOF(h.corp_ra_address_line2))'');
    populated_corp_ra_address_line2_pcnt := AVE(GROUP,IF(h.corp_ra_address_line2 = (TYPEOF(h.corp_ra_address_line2))'',0,100));
    maxlength_corp_ra_address_line2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_address_line2)));
    avelength_corp_ra_address_line2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_address_line2)),h.corp_ra_address_line2<>(typeof(h.corp_ra_address_line2))'');
    populated_corp_ra_address_line3_cnt := COUNT(GROUP,h.corp_ra_address_line3 <> (TYPEOF(h.corp_ra_address_line3))'');
    populated_corp_ra_address_line3_pcnt := AVE(GROUP,IF(h.corp_ra_address_line3 = (TYPEOF(h.corp_ra_address_line3))'',0,100));
    maxlength_corp_ra_address_line3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_address_line3)));
    avelength_corp_ra_address_line3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_address_line3)),h.corp_ra_address_line3<>(typeof(h.corp_ra_address_line3))'');
    populated_corp_ra_phone_number_cnt := COUNT(GROUP,h.corp_ra_phone_number <> (TYPEOF(h.corp_ra_phone_number))'');
    populated_corp_ra_phone_number_pcnt := AVE(GROUP,IF(h.corp_ra_phone_number = (TYPEOF(h.corp_ra_phone_number))'',0,100));
    maxlength_corp_ra_phone_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_phone_number)));
    avelength_corp_ra_phone_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_phone_number)),h.corp_ra_phone_number<>(typeof(h.corp_ra_phone_number))'');
    populated_corp_ra_phone_number_type_cd_cnt := COUNT(GROUP,h.corp_ra_phone_number_type_cd <> (TYPEOF(h.corp_ra_phone_number_type_cd))'');
    populated_corp_ra_phone_number_type_cd_pcnt := AVE(GROUP,IF(h.corp_ra_phone_number_type_cd = (TYPEOF(h.corp_ra_phone_number_type_cd))'',0,100));
    maxlength_corp_ra_phone_number_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_phone_number_type_cd)));
    avelength_corp_ra_phone_number_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_phone_number_type_cd)),h.corp_ra_phone_number_type_cd<>(typeof(h.corp_ra_phone_number_type_cd))'');
    populated_corp_ra_phone_number_type_desc_cnt := COUNT(GROUP,h.corp_ra_phone_number_type_desc <> (TYPEOF(h.corp_ra_phone_number_type_desc))'');
    populated_corp_ra_phone_number_type_desc_pcnt := AVE(GROUP,IF(h.corp_ra_phone_number_type_desc = (TYPEOF(h.corp_ra_phone_number_type_desc))'',0,100));
    maxlength_corp_ra_phone_number_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_phone_number_type_desc)));
    avelength_corp_ra_phone_number_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_phone_number_type_desc)),h.corp_ra_phone_number_type_desc<>(typeof(h.corp_ra_phone_number_type_desc))'');
    populated_corp_ra_fax_nbr_cnt := COUNT(GROUP,h.corp_ra_fax_nbr <> (TYPEOF(h.corp_ra_fax_nbr))'');
    populated_corp_ra_fax_nbr_pcnt := AVE(GROUP,IF(h.corp_ra_fax_nbr = (TYPEOF(h.corp_ra_fax_nbr))'',0,100));
    maxlength_corp_ra_fax_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_fax_nbr)));
    avelength_corp_ra_fax_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_fax_nbr)),h.corp_ra_fax_nbr<>(typeof(h.corp_ra_fax_nbr))'');
    populated_corp_ra_email_address_cnt := COUNT(GROUP,h.corp_ra_email_address <> (TYPEOF(h.corp_ra_email_address))'');
    populated_corp_ra_email_address_pcnt := AVE(GROUP,IF(h.corp_ra_email_address = (TYPEOF(h.corp_ra_email_address))'',0,100));
    maxlength_corp_ra_email_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_email_address)));
    avelength_corp_ra_email_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_email_address)),h.corp_ra_email_address<>(typeof(h.corp_ra_email_address))'');
    populated_corp_ra_web_address_cnt := COUNT(GROUP,h.corp_ra_web_address <> (TYPEOF(h.corp_ra_web_address))'');
    populated_corp_ra_web_address_pcnt := AVE(GROUP,IF(h.corp_ra_web_address = (TYPEOF(h.corp_ra_web_address))'',0,100));
    maxlength_corp_ra_web_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_web_address)));
    avelength_corp_ra_web_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_web_address)),h.corp_ra_web_address<>(typeof(h.corp_ra_web_address))'');
    populated_corp_prep_addr1_line1_cnt := COUNT(GROUP,h.corp_prep_addr1_line1 <> (TYPEOF(h.corp_prep_addr1_line1))'');
    populated_corp_prep_addr1_line1_pcnt := AVE(GROUP,IF(h.corp_prep_addr1_line1 = (TYPEOF(h.corp_prep_addr1_line1))'',0,100));
    maxlength_corp_prep_addr1_line1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_prep_addr1_line1)));
    avelength_corp_prep_addr1_line1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_prep_addr1_line1)),h.corp_prep_addr1_line1<>(typeof(h.corp_prep_addr1_line1))'');
    populated_corp_prep_addr1_last_line_cnt := COUNT(GROUP,h.corp_prep_addr1_last_line <> (TYPEOF(h.corp_prep_addr1_last_line))'');
    populated_corp_prep_addr1_last_line_pcnt := AVE(GROUP,IF(h.corp_prep_addr1_last_line = (TYPEOF(h.corp_prep_addr1_last_line))'',0,100));
    maxlength_corp_prep_addr1_last_line := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_prep_addr1_last_line)));
    avelength_corp_prep_addr1_last_line := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_prep_addr1_last_line)),h.corp_prep_addr1_last_line<>(typeof(h.corp_prep_addr1_last_line))'');
    populated_corp_prep_addr2_line1_cnt := COUNT(GROUP,h.corp_prep_addr2_line1 <> (TYPEOF(h.corp_prep_addr2_line1))'');
    populated_corp_prep_addr2_line1_pcnt := AVE(GROUP,IF(h.corp_prep_addr2_line1 = (TYPEOF(h.corp_prep_addr2_line1))'',0,100));
    maxlength_corp_prep_addr2_line1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_prep_addr2_line1)));
    avelength_corp_prep_addr2_line1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_prep_addr2_line1)),h.corp_prep_addr2_line1<>(typeof(h.corp_prep_addr2_line1))'');
    populated_corp_prep_addr2_last_line_cnt := COUNT(GROUP,h.corp_prep_addr2_last_line <> (TYPEOF(h.corp_prep_addr2_last_line))'');
    populated_corp_prep_addr2_last_line_pcnt := AVE(GROUP,IF(h.corp_prep_addr2_last_line = (TYPEOF(h.corp_prep_addr2_last_line))'',0,100));
    maxlength_corp_prep_addr2_last_line := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_prep_addr2_last_line)));
    avelength_corp_prep_addr2_last_line := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_prep_addr2_last_line)),h.corp_prep_addr2_last_line<>(typeof(h.corp_prep_addr2_last_line))'');
    populated_ra_prep_addr_line1_cnt := COUNT(GROUP,h.ra_prep_addr_line1 <> (TYPEOF(h.ra_prep_addr_line1))'');
    populated_ra_prep_addr_line1_pcnt := AVE(GROUP,IF(h.ra_prep_addr_line1 = (TYPEOF(h.ra_prep_addr_line1))'',0,100));
    maxlength_ra_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ra_prep_addr_line1)));
    avelength_ra_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ra_prep_addr_line1)),h.ra_prep_addr_line1<>(typeof(h.ra_prep_addr_line1))'');
    populated_ra_prep_addr_last_line_cnt := COUNT(GROUP,h.ra_prep_addr_last_line <> (TYPEOF(h.ra_prep_addr_last_line))'');
    populated_ra_prep_addr_last_line_pcnt := AVE(GROUP,IF(h.ra_prep_addr_last_line = (TYPEOF(h.ra_prep_addr_last_line))'',0,100));
    maxlength_ra_prep_addr_last_line := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ra_prep_addr_last_line)));
    avelength_ra_prep_addr_last_line := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ra_prep_addr_last_line)),h.ra_prep_addr_last_line<>(typeof(h.ra_prep_addr_last_line))'');
    populated_cont_filing_reference_nbr_cnt := COUNT(GROUP,h.cont_filing_reference_nbr <> (TYPEOF(h.cont_filing_reference_nbr))'');
    populated_cont_filing_reference_nbr_pcnt := AVE(GROUP,IF(h.cont_filing_reference_nbr = (TYPEOF(h.cont_filing_reference_nbr))'',0,100));
    maxlength_cont_filing_reference_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_filing_reference_nbr)));
    avelength_cont_filing_reference_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_filing_reference_nbr)),h.cont_filing_reference_nbr<>(typeof(h.cont_filing_reference_nbr))'');
    populated_cont_filing_date_cnt := COUNT(GROUP,h.cont_filing_date <> (TYPEOF(h.cont_filing_date))'');
    populated_cont_filing_date_pcnt := AVE(GROUP,IF(h.cont_filing_date = (TYPEOF(h.cont_filing_date))'',0,100));
    maxlength_cont_filing_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_filing_date)));
    avelength_cont_filing_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_filing_date)),h.cont_filing_date<>(typeof(h.cont_filing_date))'');
    populated_cont_filing_cd_cnt := COUNT(GROUP,h.cont_filing_cd <> (TYPEOF(h.cont_filing_cd))'');
    populated_cont_filing_cd_pcnt := AVE(GROUP,IF(h.cont_filing_cd = (TYPEOF(h.cont_filing_cd))'',0,100));
    maxlength_cont_filing_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_filing_cd)));
    avelength_cont_filing_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_filing_cd)),h.cont_filing_cd<>(typeof(h.cont_filing_cd))'');
    populated_cont_filing_desc_cnt := COUNT(GROUP,h.cont_filing_desc <> (TYPEOF(h.cont_filing_desc))'');
    populated_cont_filing_desc_pcnt := AVE(GROUP,IF(h.cont_filing_desc = (TYPEOF(h.cont_filing_desc))'',0,100));
    maxlength_cont_filing_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_filing_desc)));
    avelength_cont_filing_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_filing_desc)),h.cont_filing_desc<>(typeof(h.cont_filing_desc))'');
    populated_cont_type_cd_cnt := COUNT(GROUP,h.cont_type_cd <> (TYPEOF(h.cont_type_cd))'');
    populated_cont_type_cd_pcnt := AVE(GROUP,IF(h.cont_type_cd = (TYPEOF(h.cont_type_cd))'',0,100));
    maxlength_cont_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_type_cd)));
    avelength_cont_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_type_cd)),h.cont_type_cd<>(typeof(h.cont_type_cd))'');
    populated_cont_type_desc_cnt := COUNT(GROUP,h.cont_type_desc <> (TYPEOF(h.cont_type_desc))'');
    populated_cont_type_desc_pcnt := AVE(GROUP,IF(h.cont_type_desc = (TYPEOF(h.cont_type_desc))'',0,100));
    maxlength_cont_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_type_desc)));
    avelength_cont_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_type_desc)),h.cont_type_desc<>(typeof(h.cont_type_desc))'');
    populated_cont_full_name_cnt := COUNT(GROUP,h.cont_full_name <> (TYPEOF(h.cont_full_name))'');
    populated_cont_full_name_pcnt := AVE(GROUP,IF(h.cont_full_name = (TYPEOF(h.cont_full_name))'',0,100));
    maxlength_cont_full_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_full_name)));
    avelength_cont_full_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_full_name)),h.cont_full_name<>(typeof(h.cont_full_name))'');
    populated_cont_fname_cnt := COUNT(GROUP,h.cont_fname <> (TYPEOF(h.cont_fname))'');
    populated_cont_fname_pcnt := AVE(GROUP,IF(h.cont_fname = (TYPEOF(h.cont_fname))'',0,100));
    maxlength_cont_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_fname)));
    avelength_cont_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_fname)),h.cont_fname<>(typeof(h.cont_fname))'');
    populated_cont_mname_cnt := COUNT(GROUP,h.cont_mname <> (TYPEOF(h.cont_mname))'');
    populated_cont_mname_pcnt := AVE(GROUP,IF(h.cont_mname = (TYPEOF(h.cont_mname))'',0,100));
    maxlength_cont_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_mname)));
    avelength_cont_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_mname)),h.cont_mname<>(typeof(h.cont_mname))'');
    populated_cont_lname_cnt := COUNT(GROUP,h.cont_lname <> (TYPEOF(h.cont_lname))'');
    populated_cont_lname_pcnt := AVE(GROUP,IF(h.cont_lname = (TYPEOF(h.cont_lname))'',0,100));
    maxlength_cont_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_lname)));
    avelength_cont_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_lname)),h.cont_lname<>(typeof(h.cont_lname))'');
    populated_cont_suffix_cnt := COUNT(GROUP,h.cont_suffix <> (TYPEOF(h.cont_suffix))'');
    populated_cont_suffix_pcnt := AVE(GROUP,IF(h.cont_suffix = (TYPEOF(h.cont_suffix))'',0,100));
    maxlength_cont_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_suffix)));
    avelength_cont_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_suffix)),h.cont_suffix<>(typeof(h.cont_suffix))'');
    populated_cont_title1_desc_cnt := COUNT(GROUP,h.cont_title1_desc <> (TYPEOF(h.cont_title1_desc))'');
    populated_cont_title1_desc_pcnt := AVE(GROUP,IF(h.cont_title1_desc = (TYPEOF(h.cont_title1_desc))'',0,100));
    maxlength_cont_title1_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_title1_desc)));
    avelength_cont_title1_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_title1_desc)),h.cont_title1_desc<>(typeof(h.cont_title1_desc))'');
    populated_cont_title2_desc_cnt := COUNT(GROUP,h.cont_title2_desc <> (TYPEOF(h.cont_title2_desc))'');
    populated_cont_title2_desc_pcnt := AVE(GROUP,IF(h.cont_title2_desc = (TYPEOF(h.cont_title2_desc))'',0,100));
    maxlength_cont_title2_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_title2_desc)));
    avelength_cont_title2_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_title2_desc)),h.cont_title2_desc<>(typeof(h.cont_title2_desc))'');
    populated_cont_title3_desc_cnt := COUNT(GROUP,h.cont_title3_desc <> (TYPEOF(h.cont_title3_desc))'');
    populated_cont_title3_desc_pcnt := AVE(GROUP,IF(h.cont_title3_desc = (TYPEOF(h.cont_title3_desc))'',0,100));
    maxlength_cont_title3_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_title3_desc)));
    avelength_cont_title3_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_title3_desc)),h.cont_title3_desc<>(typeof(h.cont_title3_desc))'');
    populated_cont_title4_desc_cnt := COUNT(GROUP,h.cont_title4_desc <> (TYPEOF(h.cont_title4_desc))'');
    populated_cont_title4_desc_pcnt := AVE(GROUP,IF(h.cont_title4_desc = (TYPEOF(h.cont_title4_desc))'',0,100));
    maxlength_cont_title4_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_title4_desc)));
    avelength_cont_title4_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_title4_desc)),h.cont_title4_desc<>(typeof(h.cont_title4_desc))'');
    populated_cont_title5_desc_cnt := COUNT(GROUP,h.cont_title5_desc <> (TYPEOF(h.cont_title5_desc))'');
    populated_cont_title5_desc_pcnt := AVE(GROUP,IF(h.cont_title5_desc = (TYPEOF(h.cont_title5_desc))'',0,100));
    maxlength_cont_title5_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_title5_desc)));
    avelength_cont_title5_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_title5_desc)),h.cont_title5_desc<>(typeof(h.cont_title5_desc))'');
    populated_cont_fein_cnt := COUNT(GROUP,h.cont_fein <> (TYPEOF(h.cont_fein))'');
    populated_cont_fein_pcnt := AVE(GROUP,IF(h.cont_fein = (TYPEOF(h.cont_fein))'',0,100));
    maxlength_cont_fein := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_fein)));
    avelength_cont_fein := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_fein)),h.cont_fein<>(typeof(h.cont_fein))'');
    populated_cont_ssn_cnt := COUNT(GROUP,h.cont_ssn <> (TYPEOF(h.cont_ssn))'');
    populated_cont_ssn_pcnt := AVE(GROUP,IF(h.cont_ssn = (TYPEOF(h.cont_ssn))'',0,100));
    maxlength_cont_ssn := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_ssn)));
    avelength_cont_ssn := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_ssn)),h.cont_ssn<>(typeof(h.cont_ssn))'');
    populated_cont_dob_cnt := COUNT(GROUP,h.cont_dob <> (TYPEOF(h.cont_dob))'');
    populated_cont_dob_pcnt := AVE(GROUP,IF(h.cont_dob = (TYPEOF(h.cont_dob))'',0,100));
    maxlength_cont_dob := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_dob)));
    avelength_cont_dob := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_dob)),h.cont_dob<>(typeof(h.cont_dob))'');
    populated_cont_status_cd_cnt := COUNT(GROUP,h.cont_status_cd <> (TYPEOF(h.cont_status_cd))'');
    populated_cont_status_cd_pcnt := AVE(GROUP,IF(h.cont_status_cd = (TYPEOF(h.cont_status_cd))'',0,100));
    maxlength_cont_status_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_status_cd)));
    avelength_cont_status_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_status_cd)),h.cont_status_cd<>(typeof(h.cont_status_cd))'');
    populated_cont_status_desc_cnt := COUNT(GROUP,h.cont_status_desc <> (TYPEOF(h.cont_status_desc))'');
    populated_cont_status_desc_pcnt := AVE(GROUP,IF(h.cont_status_desc = (TYPEOF(h.cont_status_desc))'',0,100));
    maxlength_cont_status_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_status_desc)));
    avelength_cont_status_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_status_desc)),h.cont_status_desc<>(typeof(h.cont_status_desc))'');
    populated_cont_effective_date_cnt := COUNT(GROUP,h.cont_effective_date <> (TYPEOF(h.cont_effective_date))'');
    populated_cont_effective_date_pcnt := AVE(GROUP,IF(h.cont_effective_date = (TYPEOF(h.cont_effective_date))'',0,100));
    maxlength_cont_effective_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_effective_date)));
    avelength_cont_effective_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_effective_date)),h.cont_effective_date<>(typeof(h.cont_effective_date))'');
    populated_cont_effective_cd_cnt := COUNT(GROUP,h.cont_effective_cd <> (TYPEOF(h.cont_effective_cd))'');
    populated_cont_effective_cd_pcnt := AVE(GROUP,IF(h.cont_effective_cd = (TYPEOF(h.cont_effective_cd))'',0,100));
    maxlength_cont_effective_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_effective_cd)));
    avelength_cont_effective_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_effective_cd)),h.cont_effective_cd<>(typeof(h.cont_effective_cd))'');
    populated_cont_effective_desc_cnt := COUNT(GROUP,h.cont_effective_desc <> (TYPEOF(h.cont_effective_desc))'');
    populated_cont_effective_desc_pcnt := AVE(GROUP,IF(h.cont_effective_desc = (TYPEOF(h.cont_effective_desc))'',0,100));
    maxlength_cont_effective_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_effective_desc)));
    avelength_cont_effective_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_effective_desc)),h.cont_effective_desc<>(typeof(h.cont_effective_desc))'');
    populated_cont_addl_info_cnt := COUNT(GROUP,h.cont_addl_info <> (TYPEOF(h.cont_addl_info))'');
    populated_cont_addl_info_pcnt := AVE(GROUP,IF(h.cont_addl_info = (TYPEOF(h.cont_addl_info))'',0,100));
    maxlength_cont_addl_info := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_addl_info)));
    avelength_cont_addl_info := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_addl_info)),h.cont_addl_info<>(typeof(h.cont_addl_info))'');
    populated_cont_address_type_cd_cnt := COUNT(GROUP,h.cont_address_type_cd <> (TYPEOF(h.cont_address_type_cd))'');
    populated_cont_address_type_cd_pcnt := AVE(GROUP,IF(h.cont_address_type_cd = (TYPEOF(h.cont_address_type_cd))'',0,100));
    maxlength_cont_address_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_type_cd)));
    avelength_cont_address_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_type_cd)),h.cont_address_type_cd<>(typeof(h.cont_address_type_cd))'');
    populated_cont_address_type_desc_cnt := COUNT(GROUP,h.cont_address_type_desc <> (TYPEOF(h.cont_address_type_desc))'');
    populated_cont_address_type_desc_pcnt := AVE(GROUP,IF(h.cont_address_type_desc = (TYPEOF(h.cont_address_type_desc))'',0,100));
    maxlength_cont_address_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_type_desc)));
    avelength_cont_address_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_type_desc)),h.cont_address_type_desc<>(typeof(h.cont_address_type_desc))'');
    populated_cont_address_line1_cnt := COUNT(GROUP,h.cont_address_line1 <> (TYPEOF(h.cont_address_line1))'');
    populated_cont_address_line1_pcnt := AVE(GROUP,IF(h.cont_address_line1 = (TYPEOF(h.cont_address_line1))'',0,100));
    maxlength_cont_address_line1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_line1)));
    avelength_cont_address_line1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_line1)),h.cont_address_line1<>(typeof(h.cont_address_line1))'');
    populated_cont_address_line2_cnt := COUNT(GROUP,h.cont_address_line2 <> (TYPEOF(h.cont_address_line2))'');
    populated_cont_address_line2_pcnt := AVE(GROUP,IF(h.cont_address_line2 = (TYPEOF(h.cont_address_line2))'',0,100));
    maxlength_cont_address_line2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_line2)));
    avelength_cont_address_line2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_line2)),h.cont_address_line2<>(typeof(h.cont_address_line2))'');
    populated_cont_address_line3_cnt := COUNT(GROUP,h.cont_address_line3 <> (TYPEOF(h.cont_address_line3))'');
    populated_cont_address_line3_pcnt := AVE(GROUP,IF(h.cont_address_line3 = (TYPEOF(h.cont_address_line3))'',0,100));
    maxlength_cont_address_line3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_line3)));
    avelength_cont_address_line3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_line3)),h.cont_address_line3<>(typeof(h.cont_address_line3))'');
    populated_cont_address_effective_date_cnt := COUNT(GROUP,h.cont_address_effective_date <> (TYPEOF(h.cont_address_effective_date))'');
    populated_cont_address_effective_date_pcnt := AVE(GROUP,IF(h.cont_address_effective_date = (TYPEOF(h.cont_address_effective_date))'',0,100));
    maxlength_cont_address_effective_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_effective_date)));
    avelength_cont_address_effective_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_effective_date)),h.cont_address_effective_date<>(typeof(h.cont_address_effective_date))'');
    populated_cont_address_county_cnt := COUNT(GROUP,h.cont_address_county <> (TYPEOF(h.cont_address_county))'');
    populated_cont_address_county_pcnt := AVE(GROUP,IF(h.cont_address_county = (TYPEOF(h.cont_address_county))'',0,100));
    maxlength_cont_address_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_county)));
    avelength_cont_address_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_address_county)),h.cont_address_county<>(typeof(h.cont_address_county))'');
    populated_cont_phone_number_cnt := COUNT(GROUP,h.cont_phone_number <> (TYPEOF(h.cont_phone_number))'');
    populated_cont_phone_number_pcnt := AVE(GROUP,IF(h.cont_phone_number = (TYPEOF(h.cont_phone_number))'',0,100));
    maxlength_cont_phone_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_phone_number)));
    avelength_cont_phone_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_phone_number)),h.cont_phone_number<>(typeof(h.cont_phone_number))'');
    populated_cont_phone_number_type_cd_cnt := COUNT(GROUP,h.cont_phone_number_type_cd <> (TYPEOF(h.cont_phone_number_type_cd))'');
    populated_cont_phone_number_type_cd_pcnt := AVE(GROUP,IF(h.cont_phone_number_type_cd = (TYPEOF(h.cont_phone_number_type_cd))'',0,100));
    maxlength_cont_phone_number_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_phone_number_type_cd)));
    avelength_cont_phone_number_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_phone_number_type_cd)),h.cont_phone_number_type_cd<>(typeof(h.cont_phone_number_type_cd))'');
    populated_cont_phone_number_type_desc_cnt := COUNT(GROUP,h.cont_phone_number_type_desc <> (TYPEOF(h.cont_phone_number_type_desc))'');
    populated_cont_phone_number_type_desc_pcnt := AVE(GROUP,IF(h.cont_phone_number_type_desc = (TYPEOF(h.cont_phone_number_type_desc))'',0,100));
    maxlength_cont_phone_number_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_phone_number_type_desc)));
    avelength_cont_phone_number_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_phone_number_type_desc)),h.cont_phone_number_type_desc<>(typeof(h.cont_phone_number_type_desc))'');
    populated_cont_fax_nbr_cnt := COUNT(GROUP,h.cont_fax_nbr <> (TYPEOF(h.cont_fax_nbr))'');
    populated_cont_fax_nbr_pcnt := AVE(GROUP,IF(h.cont_fax_nbr = (TYPEOF(h.cont_fax_nbr))'',0,100));
    maxlength_cont_fax_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_fax_nbr)));
    avelength_cont_fax_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_fax_nbr)),h.cont_fax_nbr<>(typeof(h.cont_fax_nbr))'');
    populated_cont_email_address_cnt := COUNT(GROUP,h.cont_email_address <> (TYPEOF(h.cont_email_address))'');
    populated_cont_email_address_pcnt := AVE(GROUP,IF(h.cont_email_address = (TYPEOF(h.cont_email_address))'',0,100));
    maxlength_cont_email_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_email_address)));
    avelength_cont_email_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_email_address)),h.cont_email_address<>(typeof(h.cont_email_address))'');
    populated_cont_web_address_cnt := COUNT(GROUP,h.cont_web_address <> (TYPEOF(h.cont_web_address))'');
    populated_cont_web_address_pcnt := AVE(GROUP,IF(h.cont_web_address = (TYPEOF(h.cont_web_address))'',0,100));
    maxlength_cont_web_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_web_address)));
    avelength_cont_web_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_web_address)),h.cont_web_address<>(typeof(h.cont_web_address))'');
    populated_corp_acres_cnt := COUNT(GROUP,h.corp_acres <> (TYPEOF(h.corp_acres))'');
    populated_corp_acres_pcnt := AVE(GROUP,IF(h.corp_acres = (TYPEOF(h.corp_acres))'',0,100));
    maxlength_corp_acres := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_acres)));
    avelength_corp_acres := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_acres)),h.corp_acres<>(typeof(h.corp_acres))'');
    populated_corp_action_cnt := COUNT(GROUP,h.corp_action <> (TYPEOF(h.corp_action))'');
    populated_corp_action_pcnt := AVE(GROUP,IF(h.corp_action = (TYPEOF(h.corp_action))'',0,100));
    maxlength_corp_action := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action)));
    avelength_corp_action := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action)),h.corp_action<>(typeof(h.corp_action))'');
    populated_corp_action_date_cnt := COUNT(GROUP,h.corp_action_date <> (TYPEOF(h.corp_action_date))'');
    populated_corp_action_date_pcnt := AVE(GROUP,IF(h.corp_action_date = (TYPEOF(h.corp_action_date))'',0,100));
    maxlength_corp_action_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_date)));
    avelength_corp_action_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_date)),h.corp_action_date<>(typeof(h.corp_action_date))'');
    populated_corp_action_employment_security_approval_date_cnt := COUNT(GROUP,h.corp_action_employment_security_approval_date <> (TYPEOF(h.corp_action_employment_security_approval_date))'');
    populated_corp_action_employment_security_approval_date_pcnt := AVE(GROUP,IF(h.corp_action_employment_security_approval_date = (TYPEOF(h.corp_action_employment_security_approval_date))'',0,100));
    maxlength_corp_action_employment_security_approval_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_employment_security_approval_date)));
    avelength_corp_action_employment_security_approval_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_employment_security_approval_date)),h.corp_action_employment_security_approval_date<>(typeof(h.corp_action_employment_security_approval_date))'');
    populated_corp_action_pending_cd_cnt := COUNT(GROUP,h.corp_action_pending_cd <> (TYPEOF(h.corp_action_pending_cd))'');
    populated_corp_action_pending_cd_pcnt := AVE(GROUP,IF(h.corp_action_pending_cd = (TYPEOF(h.corp_action_pending_cd))'',0,100));
    maxlength_corp_action_pending_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_pending_cd)));
    avelength_corp_action_pending_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_pending_cd)),h.corp_action_pending_cd<>(typeof(h.corp_action_pending_cd))'');
    populated_corp_action_pending_desc_cnt := COUNT(GROUP,h.corp_action_pending_desc <> (TYPEOF(h.corp_action_pending_desc))'');
    populated_corp_action_pending_desc_pcnt := AVE(GROUP,IF(h.corp_action_pending_desc = (TYPEOF(h.corp_action_pending_desc))'',0,100));
    maxlength_corp_action_pending_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_pending_desc)));
    avelength_corp_action_pending_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_pending_desc)),h.corp_action_pending_desc<>(typeof(h.corp_action_pending_desc))'');
    populated_corp_action_statement_of_intent_date_cnt := COUNT(GROUP,h.corp_action_statement_of_intent_date <> (TYPEOF(h.corp_action_statement_of_intent_date))'');
    populated_corp_action_statement_of_intent_date_pcnt := AVE(GROUP,IF(h.corp_action_statement_of_intent_date = (TYPEOF(h.corp_action_statement_of_intent_date))'',0,100));
    maxlength_corp_action_statement_of_intent_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_statement_of_intent_date)));
    avelength_corp_action_statement_of_intent_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_statement_of_intent_date)),h.corp_action_statement_of_intent_date<>(typeof(h.corp_action_statement_of_intent_date))'');
    populated_corp_action_tax_dept_approval_date_cnt := COUNT(GROUP,h.corp_action_tax_dept_approval_date <> (TYPEOF(h.corp_action_tax_dept_approval_date))'');
    populated_corp_action_tax_dept_approval_date_pcnt := AVE(GROUP,IF(h.corp_action_tax_dept_approval_date = (TYPEOF(h.corp_action_tax_dept_approval_date))'',0,100));
    maxlength_corp_action_tax_dept_approval_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_tax_dept_approval_date)));
    avelength_corp_action_tax_dept_approval_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_action_tax_dept_approval_date)),h.corp_action_tax_dept_approval_date<>(typeof(h.corp_action_tax_dept_approval_date))'');
    populated_corp_acts2_cnt := COUNT(GROUP,h.corp_acts2 <> (TYPEOF(h.corp_acts2))'');
    populated_corp_acts2_pcnt := AVE(GROUP,IF(h.corp_acts2 = (TYPEOF(h.corp_acts2))'',0,100));
    maxlength_corp_acts2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_acts2)));
    avelength_corp_acts2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_acts2)),h.corp_acts2<>(typeof(h.corp_acts2))'');
    populated_corp_acts3_cnt := COUNT(GROUP,h.corp_acts3 <> (TYPEOF(h.corp_acts3))'');
    populated_corp_acts3_pcnt := AVE(GROUP,IF(h.corp_acts3 = (TYPEOF(h.corp_acts3))'',0,100));
    maxlength_corp_acts3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_acts3)));
    avelength_corp_acts3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_acts3)),h.corp_acts3<>(typeof(h.corp_acts3))'');
    populated_corp_additional_principals_cnt := COUNT(GROUP,h.corp_additional_principals <> (TYPEOF(h.corp_additional_principals))'');
    populated_corp_additional_principals_pcnt := AVE(GROUP,IF(h.corp_additional_principals = (TYPEOF(h.corp_additional_principals))'',0,100));
    maxlength_corp_additional_principals := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_additional_principals)));
    avelength_corp_additional_principals := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_additional_principals)),h.corp_additional_principals<>(typeof(h.corp_additional_principals))'');
    populated_corp_address_office_type_cnt := COUNT(GROUP,h.corp_address_office_type <> (TYPEOF(h.corp_address_office_type))'');
    populated_corp_address_office_type_pcnt := AVE(GROUP,IF(h.corp_address_office_type = (TYPEOF(h.corp_address_office_type))'',0,100));
    maxlength_corp_address_office_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address_office_type)));
    avelength_corp_address_office_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_address_office_type)),h.corp_address_office_type<>(typeof(h.corp_address_office_type))'');
    populated_corp_agent_commercial_cnt := COUNT(GROUP,h.corp_agent_commercial <> (TYPEOF(h.corp_agent_commercial))'');
    populated_corp_agent_commercial_pcnt := AVE(GROUP,IF(h.corp_agent_commercial = (TYPEOF(h.corp_agent_commercial))'',0,100));
    maxlength_corp_agent_commercial := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_commercial)));
    avelength_corp_agent_commercial := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_commercial)),h.corp_agent_commercial<>(typeof(h.corp_agent_commercial))'');
    populated_corp_agent_country_cnt := COUNT(GROUP,h.corp_agent_country <> (TYPEOF(h.corp_agent_country))'');
    populated_corp_agent_country_pcnt := AVE(GROUP,IF(h.corp_agent_country = (TYPEOF(h.corp_agent_country))'',0,100));
    maxlength_corp_agent_country := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_country)));
    avelength_corp_agent_country := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_country)),h.corp_agent_country<>(typeof(h.corp_agent_country))'');
    populated_corp_agent_county_cnt := COUNT(GROUP,h.corp_agent_county <> (TYPEOF(h.corp_agent_county))'');
    populated_corp_agent_county_pcnt := AVE(GROUP,IF(h.corp_agent_county = (TYPEOF(h.corp_agent_county))'',0,100));
    maxlength_corp_agent_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_county)));
    avelength_corp_agent_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_county)),h.corp_agent_county<>(typeof(h.corp_agent_county))'');
    populated_corp_agent_status_cd_cnt := COUNT(GROUP,h.corp_agent_status_cd <> (TYPEOF(h.corp_agent_status_cd))'');
    populated_corp_agent_status_cd_pcnt := AVE(GROUP,IF(h.corp_agent_status_cd = (TYPEOF(h.corp_agent_status_cd))'',0,100));
    maxlength_corp_agent_status_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_status_cd)));
    avelength_corp_agent_status_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_status_cd)),h.corp_agent_status_cd<>(typeof(h.corp_agent_status_cd))'');
    populated_corp_agent_status_desc_cnt := COUNT(GROUP,h.corp_agent_status_desc <> (TYPEOF(h.corp_agent_status_desc))'');
    populated_corp_agent_status_desc_pcnt := AVE(GROUP,IF(h.corp_agent_status_desc = (TYPEOF(h.corp_agent_status_desc))'',0,100));
    maxlength_corp_agent_status_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_status_desc)));
    avelength_corp_agent_status_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_status_desc)),h.corp_agent_status_desc<>(typeof(h.corp_agent_status_desc))'');
    populated_corp_agent_id_cnt := COUNT(GROUP,h.corp_agent_id <> (TYPEOF(h.corp_agent_id))'');
    populated_corp_agent_id_pcnt := AVE(GROUP,IF(h.corp_agent_id = (TYPEOF(h.corp_agent_id))'',0,100));
    maxlength_corp_agent_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_id)));
    avelength_corp_agent_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_id)),h.corp_agent_id<>(typeof(h.corp_agent_id))'');
    populated_corp_agent_assign_date_cnt := COUNT(GROUP,h.corp_agent_assign_date <> (TYPEOF(h.corp_agent_assign_date))'');
    populated_corp_agent_assign_date_pcnt := AVE(GROUP,IF(h.corp_agent_assign_date = (TYPEOF(h.corp_agent_assign_date))'',0,100));
    maxlength_corp_agent_assign_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_assign_date)));
    avelength_corp_agent_assign_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agent_assign_date)),h.corp_agent_assign_date<>(typeof(h.corp_agent_assign_date))'');
    populated_corp_agriculture_flag_cnt := COUNT(GROUP,h.corp_agriculture_flag <> (TYPEOF(h.corp_agriculture_flag))'');
    populated_corp_agriculture_flag_pcnt := AVE(GROUP,IF(h.corp_agriculture_flag = (TYPEOF(h.corp_agriculture_flag))'',0,100));
    maxlength_corp_agriculture_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agriculture_flag)));
    avelength_corp_agriculture_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_agriculture_flag)),h.corp_agriculture_flag<>(typeof(h.corp_agriculture_flag))'');
    populated_corp_authorized_partners_cnt := COUNT(GROUP,h.corp_authorized_partners <> (TYPEOF(h.corp_authorized_partners))'');
    populated_corp_authorized_partners_pcnt := AVE(GROUP,IF(h.corp_authorized_partners = (TYPEOF(h.corp_authorized_partners))'',0,100));
    maxlength_corp_authorized_partners := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_authorized_partners)));
    avelength_corp_authorized_partners := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_authorized_partners)),h.corp_authorized_partners<>(typeof(h.corp_authorized_partners))'');
    populated_corp_comment_cnt := COUNT(GROUP,h.corp_comment <> (TYPEOF(h.corp_comment))'');
    populated_corp_comment_pcnt := AVE(GROUP,IF(h.corp_comment = (TYPEOF(h.corp_comment))'',0,100));
    maxlength_corp_comment := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_comment)));
    avelength_corp_comment := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_comment)),h.corp_comment<>(typeof(h.corp_comment))'');
    populated_corp_consent_flag_for_protected_name_cnt := COUNT(GROUP,h.corp_consent_flag_for_protected_name <> (TYPEOF(h.corp_consent_flag_for_protected_name))'');
    populated_corp_consent_flag_for_protected_name_pcnt := AVE(GROUP,IF(h.corp_consent_flag_for_protected_name = (TYPEOF(h.corp_consent_flag_for_protected_name))'',0,100));
    maxlength_corp_consent_flag_for_protected_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_consent_flag_for_protected_name)));
    avelength_corp_consent_flag_for_protected_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_consent_flag_for_protected_name)),h.corp_consent_flag_for_protected_name<>(typeof(h.corp_consent_flag_for_protected_name))'');
    populated_corp_converted_cnt := COUNT(GROUP,h.corp_converted <> (TYPEOF(h.corp_converted))'');
    populated_corp_converted_pcnt := AVE(GROUP,IF(h.corp_converted = (TYPEOF(h.corp_converted))'',0,100));
    maxlength_corp_converted := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_converted)));
    avelength_corp_converted := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_converted)),h.corp_converted<>(typeof(h.corp_converted))'');
    populated_corp_converted_from_cnt := COUNT(GROUP,h.corp_converted_from <> (TYPEOF(h.corp_converted_from))'');
    populated_corp_converted_from_pcnt := AVE(GROUP,IF(h.corp_converted_from = (TYPEOF(h.corp_converted_from))'',0,100));
    maxlength_corp_converted_from := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_converted_from)));
    avelength_corp_converted_from := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_converted_from)),h.corp_converted_from<>(typeof(h.corp_converted_from))'');
    populated_corp_country_of_formation_cnt := COUNT(GROUP,h.corp_country_of_formation <> (TYPEOF(h.corp_country_of_formation))'');
    populated_corp_country_of_formation_pcnt := AVE(GROUP,IF(h.corp_country_of_formation = (TYPEOF(h.corp_country_of_formation))'',0,100));
    maxlength_corp_country_of_formation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_country_of_formation)));
    avelength_corp_country_of_formation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_country_of_formation)),h.corp_country_of_formation<>(typeof(h.corp_country_of_formation))'');
    populated_corp_date_of_organization_meeting_cnt := COUNT(GROUP,h.corp_date_of_organization_meeting <> (TYPEOF(h.corp_date_of_organization_meeting))'');
    populated_corp_date_of_organization_meeting_pcnt := AVE(GROUP,IF(h.corp_date_of_organization_meeting = (TYPEOF(h.corp_date_of_organization_meeting))'',0,100));
    maxlength_corp_date_of_organization_meeting := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_date_of_organization_meeting)));
    avelength_corp_date_of_organization_meeting := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_date_of_organization_meeting)),h.corp_date_of_organization_meeting<>(typeof(h.corp_date_of_organization_meeting))'');
    populated_corp_delayed_effective_date_cnt := COUNT(GROUP,h.corp_delayed_effective_date <> (TYPEOF(h.corp_delayed_effective_date))'');
    populated_corp_delayed_effective_date_pcnt := AVE(GROUP,IF(h.corp_delayed_effective_date = (TYPEOF(h.corp_delayed_effective_date))'',0,100));
    maxlength_corp_delayed_effective_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_delayed_effective_date)));
    avelength_corp_delayed_effective_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_delayed_effective_date)),h.corp_delayed_effective_date<>(typeof(h.corp_delayed_effective_date))'');
    populated_corp_directors_from_to_cnt := COUNT(GROUP,h.corp_directors_from_to <> (TYPEOF(h.corp_directors_from_to))'');
    populated_corp_directors_from_to_pcnt := AVE(GROUP,IF(h.corp_directors_from_to = (TYPEOF(h.corp_directors_from_to))'',0,100));
    maxlength_corp_directors_from_to := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_directors_from_to)));
    avelength_corp_directors_from_to := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_directors_from_to)),h.corp_directors_from_to<>(typeof(h.corp_directors_from_to))'');
    populated_corp_dissolved_date_cnt := COUNT(GROUP,h.corp_dissolved_date <> (TYPEOF(h.corp_dissolved_date))'');
    populated_corp_dissolved_date_pcnt := AVE(GROUP,IF(h.corp_dissolved_date = (TYPEOF(h.corp_dissolved_date))'',0,100));
    maxlength_corp_dissolved_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_dissolved_date)));
    avelength_corp_dissolved_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_dissolved_date)),h.corp_dissolved_date<>(typeof(h.corp_dissolved_date))'');
    populated_corp_farm_exemptions_cnt := COUNT(GROUP,h.corp_farm_exemptions <> (TYPEOF(h.corp_farm_exemptions))'');
    populated_corp_farm_exemptions_pcnt := AVE(GROUP,IF(h.corp_farm_exemptions = (TYPEOF(h.corp_farm_exemptions))'',0,100));
    maxlength_corp_farm_exemptions := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_farm_exemptions)));
    avelength_corp_farm_exemptions := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_farm_exemptions)),h.corp_farm_exemptions<>(typeof(h.corp_farm_exemptions))'');
    populated_corp_farm_qual_date_cnt := COUNT(GROUP,h.corp_farm_qual_date <> (TYPEOF(h.corp_farm_qual_date))'');
    populated_corp_farm_qual_date_pcnt := AVE(GROUP,IF(h.corp_farm_qual_date = (TYPEOF(h.corp_farm_qual_date))'',0,100));
    maxlength_corp_farm_qual_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_farm_qual_date)));
    avelength_corp_farm_qual_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_farm_qual_date)),h.corp_farm_qual_date<>(typeof(h.corp_farm_qual_date))'');
    populated_corp_farm_status_cd_cnt := COUNT(GROUP,h.corp_farm_status_cd <> (TYPEOF(h.corp_farm_status_cd))'');
    populated_corp_farm_status_cd_pcnt := AVE(GROUP,IF(h.corp_farm_status_cd = (TYPEOF(h.corp_farm_status_cd))'',0,100));
    maxlength_corp_farm_status_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_farm_status_cd)));
    avelength_corp_farm_status_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_farm_status_cd)),h.corp_farm_status_cd<>(typeof(h.corp_farm_status_cd))'');
    populated_corp_farm_status_desc_cnt := COUNT(GROUP,h.corp_farm_status_desc <> (TYPEOF(h.corp_farm_status_desc))'');
    populated_corp_farm_status_desc_pcnt := AVE(GROUP,IF(h.corp_farm_status_desc = (TYPEOF(h.corp_farm_status_desc))'',0,100));
    maxlength_corp_farm_status_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_farm_status_desc)));
    avelength_corp_farm_status_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_farm_status_desc)),h.corp_farm_status_desc<>(typeof(h.corp_farm_status_desc))'');
    populated_corp_farm_status_date_cnt := COUNT(GROUP,h.corp_farm_status_date <> (TYPEOF(h.corp_farm_status_date))'');
    populated_corp_farm_status_date_pcnt := AVE(GROUP,IF(h.corp_farm_status_date = (TYPEOF(h.corp_farm_status_date))'',0,100));
    maxlength_corp_farm_status_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_farm_status_date)));
    avelength_corp_farm_status_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_farm_status_date)),h.corp_farm_status_date<>(typeof(h.corp_farm_status_date))'');
    populated_corp_fiscal_year_month_cnt := COUNT(GROUP,h.corp_fiscal_year_month <> (TYPEOF(h.corp_fiscal_year_month))'');
    populated_corp_fiscal_year_month_pcnt := AVE(GROUP,IF(h.corp_fiscal_year_month = (TYPEOF(h.corp_fiscal_year_month))'',0,100));
    maxlength_corp_fiscal_year_month := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_fiscal_year_month)));
    avelength_corp_fiscal_year_month := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_fiscal_year_month)),h.corp_fiscal_year_month<>(typeof(h.corp_fiscal_year_month))'');
    populated_corp_foreign_fiduciary_capacity_in_state_cnt := COUNT(GROUP,h.corp_foreign_fiduciary_capacity_in_state <> (TYPEOF(h.corp_foreign_fiduciary_capacity_in_state))'');
    populated_corp_foreign_fiduciary_capacity_in_state_pcnt := AVE(GROUP,IF(h.corp_foreign_fiduciary_capacity_in_state = (TYPEOF(h.corp_foreign_fiduciary_capacity_in_state))'',0,100));
    maxlength_corp_foreign_fiduciary_capacity_in_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_foreign_fiduciary_capacity_in_state)));
    avelength_corp_foreign_fiduciary_capacity_in_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_foreign_fiduciary_capacity_in_state)),h.corp_foreign_fiduciary_capacity_in_state<>(typeof(h.corp_foreign_fiduciary_capacity_in_state))'');
    populated_corp_governing_statute_cnt := COUNT(GROUP,h.corp_governing_statute <> (TYPEOF(h.corp_governing_statute))'');
    populated_corp_governing_statute_pcnt := AVE(GROUP,IF(h.corp_governing_statute = (TYPEOF(h.corp_governing_statute))'',0,100));
    maxlength_corp_governing_statute := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_governing_statute)));
    avelength_corp_governing_statute := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_governing_statute)),h.corp_governing_statute<>(typeof(h.corp_governing_statute))'');
    populated_corp_has_members_cnt := COUNT(GROUP,h.corp_has_members <> (TYPEOF(h.corp_has_members))'');
    populated_corp_has_members_pcnt := AVE(GROUP,IF(h.corp_has_members = (TYPEOF(h.corp_has_members))'',0,100));
    maxlength_corp_has_members := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_has_members)));
    avelength_corp_has_members := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_has_members)),h.corp_has_members<>(typeof(h.corp_has_members))'');
    populated_corp_has_vested_managers_cnt := COUNT(GROUP,h.corp_has_vested_managers <> (TYPEOF(h.corp_has_vested_managers))'');
    populated_corp_has_vested_managers_pcnt := AVE(GROUP,IF(h.corp_has_vested_managers = (TYPEOF(h.corp_has_vested_managers))'',0,100));
    maxlength_corp_has_vested_managers := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_has_vested_managers)));
    avelength_corp_has_vested_managers := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_has_vested_managers)),h.corp_has_vested_managers<>(typeof(h.corp_has_vested_managers))'');
    populated_corp_home_incorporated_county_cnt := COUNT(GROUP,h.corp_home_incorporated_county <> (TYPEOF(h.corp_home_incorporated_county))'');
    populated_corp_home_incorporated_county_pcnt := AVE(GROUP,IF(h.corp_home_incorporated_county = (TYPEOF(h.corp_home_incorporated_county))'',0,100));
    maxlength_corp_home_incorporated_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_home_incorporated_county)));
    avelength_corp_home_incorporated_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_home_incorporated_county)),h.corp_home_incorporated_county<>(typeof(h.corp_home_incorporated_county))'');
    populated_corp_home_state_name_cnt := COUNT(GROUP,h.corp_home_state_name <> (TYPEOF(h.corp_home_state_name))'');
    populated_corp_home_state_name_pcnt := AVE(GROUP,IF(h.corp_home_state_name = (TYPEOF(h.corp_home_state_name))'',0,100));
    maxlength_corp_home_state_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_home_state_name)));
    avelength_corp_home_state_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_home_state_name)),h.corp_home_state_name<>(typeof(h.corp_home_state_name))'');
    populated_corp_is_professional_cnt := COUNT(GROUP,h.corp_is_professional <> (TYPEOF(h.corp_is_professional))'');
    populated_corp_is_professional_pcnt := AVE(GROUP,IF(h.corp_is_professional = (TYPEOF(h.corp_is_professional))'',0,100));
    maxlength_corp_is_professional := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_is_professional)));
    avelength_corp_is_professional := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_is_professional)),h.corp_is_professional<>(typeof(h.corp_is_professional))'');
    populated_corp_is_non_profit_irs_approved_cnt := COUNT(GROUP,h.corp_is_non_profit_irs_approved <> (TYPEOF(h.corp_is_non_profit_irs_approved))'');
    populated_corp_is_non_profit_irs_approved_pcnt := AVE(GROUP,IF(h.corp_is_non_profit_irs_approved = (TYPEOF(h.corp_is_non_profit_irs_approved))'',0,100));
    maxlength_corp_is_non_profit_irs_approved := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_is_non_profit_irs_approved)));
    avelength_corp_is_non_profit_irs_approved := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_is_non_profit_irs_approved)),h.corp_is_non_profit_irs_approved<>(typeof(h.corp_is_non_profit_irs_approved))'');
    populated_corp_last_renewal_date_cnt := COUNT(GROUP,h.corp_last_renewal_date <> (TYPEOF(h.corp_last_renewal_date))'');
    populated_corp_last_renewal_date_pcnt := AVE(GROUP,IF(h.corp_last_renewal_date = (TYPEOF(h.corp_last_renewal_date))'',0,100));
    maxlength_corp_last_renewal_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_last_renewal_date)));
    avelength_corp_last_renewal_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_last_renewal_date)),h.corp_last_renewal_date<>(typeof(h.corp_last_renewal_date))'');
    populated_corp_last_renewal_year_cnt := COUNT(GROUP,h.corp_last_renewal_year <> (TYPEOF(h.corp_last_renewal_year))'');
    populated_corp_last_renewal_year_pcnt := AVE(GROUP,IF(h.corp_last_renewal_year = (TYPEOF(h.corp_last_renewal_year))'',0,100));
    maxlength_corp_last_renewal_year := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_last_renewal_year)));
    avelength_corp_last_renewal_year := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_last_renewal_year)),h.corp_last_renewal_year<>(typeof(h.corp_last_renewal_year))'');
    populated_corp_license_type_cnt := COUNT(GROUP,h.corp_license_type <> (TYPEOF(h.corp_license_type))'');
    populated_corp_license_type_pcnt := AVE(GROUP,IF(h.corp_license_type = (TYPEOF(h.corp_license_type))'',0,100));
    maxlength_corp_license_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_license_type)));
    avelength_corp_license_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_license_type)),h.corp_license_type<>(typeof(h.corp_license_type))'');
    populated_corp_llc_managed_ind_cnt := COUNT(GROUP,h.corp_llc_managed_ind <> (TYPEOF(h.corp_llc_managed_ind))'');
    populated_corp_llc_managed_ind_pcnt := AVE(GROUP,IF(h.corp_llc_managed_ind = (TYPEOF(h.corp_llc_managed_ind))'',0,100));
    maxlength_corp_llc_managed_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_llc_managed_ind)));
    avelength_corp_llc_managed_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_llc_managed_ind)),h.corp_llc_managed_ind<>(typeof(h.corp_llc_managed_ind))'');
    populated_corp_llc_managed_desc_cnt := COUNT(GROUP,h.corp_llc_managed_desc <> (TYPEOF(h.corp_llc_managed_desc))'');
    populated_corp_llc_managed_desc_pcnt := AVE(GROUP,IF(h.corp_llc_managed_desc = (TYPEOF(h.corp_llc_managed_desc))'',0,100));
    maxlength_corp_llc_managed_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_llc_managed_desc)));
    avelength_corp_llc_managed_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_llc_managed_desc)),h.corp_llc_managed_desc<>(typeof(h.corp_llc_managed_desc))'');
    populated_corp_management_desc_cnt := COUNT(GROUP,h.corp_management_desc <> (TYPEOF(h.corp_management_desc))'');
    populated_corp_management_desc_pcnt := AVE(GROUP,IF(h.corp_management_desc = (TYPEOF(h.corp_management_desc))'',0,100));
    maxlength_corp_management_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_management_desc)));
    avelength_corp_management_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_management_desc)),h.corp_management_desc<>(typeof(h.corp_management_desc))'');
    populated_corp_management_type_cnt := COUNT(GROUP,h.corp_management_type <> (TYPEOF(h.corp_management_type))'');
    populated_corp_management_type_pcnt := AVE(GROUP,IF(h.corp_management_type = (TYPEOF(h.corp_management_type))'',0,100));
    maxlength_corp_management_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_management_type)));
    avelength_corp_management_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_management_type)),h.corp_management_type<>(typeof(h.corp_management_type))'');
    populated_corp_manager_managed_cnt := COUNT(GROUP,h.corp_manager_managed <> (TYPEOF(h.corp_manager_managed))'');
    populated_corp_manager_managed_pcnt := AVE(GROUP,IF(h.corp_manager_managed = (TYPEOF(h.corp_manager_managed))'',0,100));
    maxlength_corp_manager_managed := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_manager_managed)));
    avelength_corp_manager_managed := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_manager_managed)),h.corp_manager_managed<>(typeof(h.corp_manager_managed))'');
    populated_corp_merged_corporation_id_cnt := COUNT(GROUP,h.corp_merged_corporation_id <> (TYPEOF(h.corp_merged_corporation_id))'');
    populated_corp_merged_corporation_id_pcnt := AVE(GROUP,IF(h.corp_merged_corporation_id = (TYPEOF(h.corp_merged_corporation_id))'',0,100));
    maxlength_corp_merged_corporation_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merged_corporation_id)));
    avelength_corp_merged_corporation_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merged_corporation_id)),h.corp_merged_corporation_id<>(typeof(h.corp_merged_corporation_id))'');
    populated_corp_merged_fein_cnt := COUNT(GROUP,h.corp_merged_fein <> (TYPEOF(h.corp_merged_fein))'');
    populated_corp_merged_fein_pcnt := AVE(GROUP,IF(h.corp_merged_fein = (TYPEOF(h.corp_merged_fein))'',0,100));
    maxlength_corp_merged_fein := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merged_fein)));
    avelength_corp_merged_fein := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merged_fein)),h.corp_merged_fein<>(typeof(h.corp_merged_fein))'');
    populated_corp_merger_allowed_flag_cnt := COUNT(GROUP,h.corp_merger_allowed_flag <> (TYPEOF(h.corp_merger_allowed_flag))'');
    populated_corp_merger_allowed_flag_pcnt := AVE(GROUP,IF(h.corp_merger_allowed_flag = (TYPEOF(h.corp_merger_allowed_flag))'',0,100));
    maxlength_corp_merger_allowed_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_allowed_flag)));
    avelength_corp_merger_allowed_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_allowed_flag)),h.corp_merger_allowed_flag<>(typeof(h.corp_merger_allowed_flag))'');
    populated_corp_merger_date_cnt := COUNT(GROUP,h.corp_merger_date <> (TYPEOF(h.corp_merger_date))'');
    populated_corp_merger_date_pcnt := AVE(GROUP,IF(h.corp_merger_date = (TYPEOF(h.corp_merger_date))'',0,100));
    maxlength_corp_merger_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_date)));
    avelength_corp_merger_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_date)),h.corp_merger_date<>(typeof(h.corp_merger_date))'');
    populated_corp_merger_desc_cnt := COUNT(GROUP,h.corp_merger_desc <> (TYPEOF(h.corp_merger_desc))'');
    populated_corp_merger_desc_pcnt := AVE(GROUP,IF(h.corp_merger_desc = (TYPEOF(h.corp_merger_desc))'',0,100));
    maxlength_corp_merger_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_desc)));
    avelength_corp_merger_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_desc)),h.corp_merger_desc<>(typeof(h.corp_merger_desc))'');
    populated_corp_merger_effective_date_cnt := COUNT(GROUP,h.corp_merger_effective_date <> (TYPEOF(h.corp_merger_effective_date))'');
    populated_corp_merger_effective_date_pcnt := AVE(GROUP,IF(h.corp_merger_effective_date = (TYPEOF(h.corp_merger_effective_date))'',0,100));
    maxlength_corp_merger_effective_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_effective_date)));
    avelength_corp_merger_effective_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_effective_date)),h.corp_merger_effective_date<>(typeof(h.corp_merger_effective_date))'');
    populated_corp_merger_id_cnt := COUNT(GROUP,h.corp_merger_id <> (TYPEOF(h.corp_merger_id))'');
    populated_corp_merger_id_pcnt := AVE(GROUP,IF(h.corp_merger_id = (TYPEOF(h.corp_merger_id))'',0,100));
    maxlength_corp_merger_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_id)));
    avelength_corp_merger_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_id)),h.corp_merger_id<>(typeof(h.corp_merger_id))'');
    populated_corp_merger_indicator_cnt := COUNT(GROUP,h.corp_merger_indicator <> (TYPEOF(h.corp_merger_indicator))'');
    populated_corp_merger_indicator_pcnt := AVE(GROUP,IF(h.corp_merger_indicator = (TYPEOF(h.corp_merger_indicator))'',0,100));
    maxlength_corp_merger_indicator := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_indicator)));
    avelength_corp_merger_indicator := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_indicator)),h.corp_merger_indicator<>(typeof(h.corp_merger_indicator))'');
    populated_corp_merger_name_cnt := COUNT(GROUP,h.corp_merger_name <> (TYPEOF(h.corp_merger_name))'');
    populated_corp_merger_name_pcnt := AVE(GROUP,IF(h.corp_merger_name = (TYPEOF(h.corp_merger_name))'',0,100));
    maxlength_corp_merger_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_name)));
    avelength_corp_merger_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_name)),h.corp_merger_name<>(typeof(h.corp_merger_name))'');
    populated_corp_merger_type_converted_to_cd_cnt := COUNT(GROUP,h.corp_merger_type_converted_to_cd <> (TYPEOF(h.corp_merger_type_converted_to_cd))'');
    populated_corp_merger_type_converted_to_cd_pcnt := AVE(GROUP,IF(h.corp_merger_type_converted_to_cd = (TYPEOF(h.corp_merger_type_converted_to_cd))'',0,100));
    maxlength_corp_merger_type_converted_to_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_type_converted_to_cd)));
    avelength_corp_merger_type_converted_to_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_type_converted_to_cd)),h.corp_merger_type_converted_to_cd<>(typeof(h.corp_merger_type_converted_to_cd))'');
    populated_corp_merger_type_converted_to_desc_cnt := COUNT(GROUP,h.corp_merger_type_converted_to_desc <> (TYPEOF(h.corp_merger_type_converted_to_desc))'');
    populated_corp_merger_type_converted_to_desc_pcnt := AVE(GROUP,IF(h.corp_merger_type_converted_to_desc = (TYPEOF(h.corp_merger_type_converted_to_desc))'',0,100));
    maxlength_corp_merger_type_converted_to_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_type_converted_to_desc)));
    avelength_corp_merger_type_converted_to_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_merger_type_converted_to_desc)),h.corp_merger_type_converted_to_desc<>(typeof(h.corp_merger_type_converted_to_desc))'');
    populated_corp_naics_desc_cnt := COUNT(GROUP,h.corp_naics_desc <> (TYPEOF(h.corp_naics_desc))'');
    populated_corp_naics_desc_pcnt := AVE(GROUP,IF(h.corp_naics_desc = (TYPEOF(h.corp_naics_desc))'',0,100));
    maxlength_corp_naics_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_naics_desc)));
    avelength_corp_naics_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_naics_desc)),h.corp_naics_desc<>(typeof(h.corp_naics_desc))'');
    populated_corp_name_effective_date_cnt := COUNT(GROUP,h.corp_name_effective_date <> (TYPEOF(h.corp_name_effective_date))'');
    populated_corp_name_effective_date_pcnt := AVE(GROUP,IF(h.corp_name_effective_date = (TYPEOF(h.corp_name_effective_date))'',0,100));
    maxlength_corp_name_effective_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_effective_date)));
    avelength_corp_name_effective_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_effective_date)),h.corp_name_effective_date<>(typeof(h.corp_name_effective_date))'');
    populated_corp_name_reservation_date_cnt := COUNT(GROUP,h.corp_name_reservation_date <> (TYPEOF(h.corp_name_reservation_date))'');
    populated_corp_name_reservation_date_pcnt := AVE(GROUP,IF(h.corp_name_reservation_date = (TYPEOF(h.corp_name_reservation_date))'',0,100));
    maxlength_corp_name_reservation_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_reservation_date)));
    avelength_corp_name_reservation_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_reservation_date)),h.corp_name_reservation_date<>(typeof(h.corp_name_reservation_date))'');
    populated_corp_name_reservation_expiration_date_cnt := COUNT(GROUP,h.corp_name_reservation_expiration_date <> (TYPEOF(h.corp_name_reservation_expiration_date))'');
    populated_corp_name_reservation_expiration_date_pcnt := AVE(GROUP,IF(h.corp_name_reservation_expiration_date = (TYPEOF(h.corp_name_reservation_expiration_date))'',0,100));
    maxlength_corp_name_reservation_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_reservation_expiration_date)));
    avelength_corp_name_reservation_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_reservation_expiration_date)),h.corp_name_reservation_expiration_date<>(typeof(h.corp_name_reservation_expiration_date))'');
    populated_corp_name_reservation_nbr_cnt := COUNT(GROUP,h.corp_name_reservation_nbr <> (TYPEOF(h.corp_name_reservation_nbr))'');
    populated_corp_name_reservation_nbr_pcnt := AVE(GROUP,IF(h.corp_name_reservation_nbr = (TYPEOF(h.corp_name_reservation_nbr))'',0,100));
    maxlength_corp_name_reservation_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_reservation_nbr)));
    avelength_corp_name_reservation_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_reservation_nbr)),h.corp_name_reservation_nbr<>(typeof(h.corp_name_reservation_nbr))'');
    populated_corp_name_reservation_type_cnt := COUNT(GROUP,h.corp_name_reservation_type <> (TYPEOF(h.corp_name_reservation_type))'');
    populated_corp_name_reservation_type_pcnt := AVE(GROUP,IF(h.corp_name_reservation_type = (TYPEOF(h.corp_name_reservation_type))'',0,100));
    maxlength_corp_name_reservation_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_reservation_type)));
    avelength_corp_name_reservation_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_reservation_type)),h.corp_name_reservation_type<>(typeof(h.corp_name_reservation_type))'');
    populated_corp_name_status_cd_cnt := COUNT(GROUP,h.corp_name_status_cd <> (TYPEOF(h.corp_name_status_cd))'');
    populated_corp_name_status_cd_pcnt := AVE(GROUP,IF(h.corp_name_status_cd = (TYPEOF(h.corp_name_status_cd))'',0,100));
    maxlength_corp_name_status_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_status_cd)));
    avelength_corp_name_status_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_status_cd)),h.corp_name_status_cd<>(typeof(h.corp_name_status_cd))'');
    populated_corp_name_status_date_cnt := COUNT(GROUP,h.corp_name_status_date <> (TYPEOF(h.corp_name_status_date))'');
    populated_corp_name_status_date_pcnt := AVE(GROUP,IF(h.corp_name_status_date = (TYPEOF(h.corp_name_status_date))'',0,100));
    maxlength_corp_name_status_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_status_date)));
    avelength_corp_name_status_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_status_date)),h.corp_name_status_date<>(typeof(h.corp_name_status_date))'');
    populated_corp_name_status_desc_cnt := COUNT(GROUP,h.corp_name_status_desc <> (TYPEOF(h.corp_name_status_desc))'');
    populated_corp_name_status_desc_pcnt := AVE(GROUP,IF(h.corp_name_status_desc = (TYPEOF(h.corp_name_status_desc))'',0,100));
    maxlength_corp_name_status_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_status_desc)));
    avelength_corp_name_status_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_name_status_desc)),h.corp_name_status_desc<>(typeof(h.corp_name_status_desc))'');
    populated_corp_non_profit_irs_approved_purpose_cnt := COUNT(GROUP,h.corp_non_profit_irs_approved_purpose <> (TYPEOF(h.corp_non_profit_irs_approved_purpose))'');
    populated_corp_non_profit_irs_approved_purpose_pcnt := AVE(GROUP,IF(h.corp_non_profit_irs_approved_purpose = (TYPEOF(h.corp_non_profit_irs_approved_purpose))'',0,100));
    maxlength_corp_non_profit_irs_approved_purpose := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_non_profit_irs_approved_purpose)));
    avelength_corp_non_profit_irs_approved_purpose := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_non_profit_irs_approved_purpose)),h.corp_non_profit_irs_approved_purpose<>(typeof(h.corp_non_profit_irs_approved_purpose))'');
    populated_corp_non_profit_solicit_donations_cnt := COUNT(GROUP,h.corp_non_profit_solicit_donations <> (TYPEOF(h.corp_non_profit_solicit_donations))'');
    populated_corp_non_profit_solicit_donations_pcnt := AVE(GROUP,IF(h.corp_non_profit_solicit_donations = (TYPEOF(h.corp_non_profit_solicit_donations))'',0,100));
    maxlength_corp_non_profit_solicit_donations := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_non_profit_solicit_donations)));
    avelength_corp_non_profit_solicit_donations := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_non_profit_solicit_donations)),h.corp_non_profit_solicit_donations<>(typeof(h.corp_non_profit_solicit_donations))'');
    populated_corp_nbr_of_amendments_cnt := COUNT(GROUP,h.corp_nbr_of_amendments <> (TYPEOF(h.corp_nbr_of_amendments))'');
    populated_corp_nbr_of_amendments_pcnt := AVE(GROUP,IF(h.corp_nbr_of_amendments = (TYPEOF(h.corp_nbr_of_amendments))'',0,100));
    maxlength_corp_nbr_of_amendments := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_nbr_of_amendments)));
    avelength_corp_nbr_of_amendments := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_nbr_of_amendments)),h.corp_nbr_of_amendments<>(typeof(h.corp_nbr_of_amendments))'');
    populated_corp_nbr_of_initial_llc_members_cnt := COUNT(GROUP,h.corp_nbr_of_initial_llc_members <> (TYPEOF(h.corp_nbr_of_initial_llc_members))'');
    populated_corp_nbr_of_initial_llc_members_pcnt := AVE(GROUP,IF(h.corp_nbr_of_initial_llc_members = (TYPEOF(h.corp_nbr_of_initial_llc_members))'',0,100));
    maxlength_corp_nbr_of_initial_llc_members := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_nbr_of_initial_llc_members)));
    avelength_corp_nbr_of_initial_llc_members := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_nbr_of_initial_llc_members)),h.corp_nbr_of_initial_llc_members<>(typeof(h.corp_nbr_of_initial_llc_members))'');
    populated_corp_nbr_of_partners_cnt := COUNT(GROUP,h.corp_nbr_of_partners <> (TYPEOF(h.corp_nbr_of_partners))'');
    populated_corp_nbr_of_partners_pcnt := AVE(GROUP,IF(h.corp_nbr_of_partners = (TYPEOF(h.corp_nbr_of_partners))'',0,100));
    maxlength_corp_nbr_of_partners := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_nbr_of_partners)));
    avelength_corp_nbr_of_partners := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_nbr_of_partners)),h.corp_nbr_of_partners<>(typeof(h.corp_nbr_of_partners))'');
    populated_corp_operating_agreement_cnt := COUNT(GROUP,h.corp_operating_agreement <> (TYPEOF(h.corp_operating_agreement))'');
    populated_corp_operating_agreement_pcnt := AVE(GROUP,IF(h.corp_operating_agreement = (TYPEOF(h.corp_operating_agreement))'',0,100));
    maxlength_corp_operating_agreement := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_operating_agreement)));
    avelength_corp_operating_agreement := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_operating_agreement)),h.corp_operating_agreement<>(typeof(h.corp_operating_agreement))'');
    populated_corp_opt_in_llc_act_desc_cnt := COUNT(GROUP,h.corp_opt_in_llc_act_desc <> (TYPEOF(h.corp_opt_in_llc_act_desc))'');
    populated_corp_opt_in_llc_act_desc_pcnt := AVE(GROUP,IF(h.corp_opt_in_llc_act_desc = (TYPEOF(h.corp_opt_in_llc_act_desc))'',0,100));
    maxlength_corp_opt_in_llc_act_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_opt_in_llc_act_desc)));
    avelength_corp_opt_in_llc_act_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_opt_in_llc_act_desc)),h.corp_opt_in_llc_act_desc<>(typeof(h.corp_opt_in_llc_act_desc))'');
    populated_corp_opt_in_llc_act_ind_cnt := COUNT(GROUP,h.corp_opt_in_llc_act_ind <> (TYPEOF(h.corp_opt_in_llc_act_ind))'');
    populated_corp_opt_in_llc_act_ind_pcnt := AVE(GROUP,IF(h.corp_opt_in_llc_act_ind = (TYPEOF(h.corp_opt_in_llc_act_ind))'',0,100));
    maxlength_corp_opt_in_llc_act_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_opt_in_llc_act_ind)));
    avelength_corp_opt_in_llc_act_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_opt_in_llc_act_ind)),h.corp_opt_in_llc_act_ind<>(typeof(h.corp_opt_in_llc_act_ind))'');
    populated_corp_organizational_comments_cnt := COUNT(GROUP,h.corp_organizational_comments <> (TYPEOF(h.corp_organizational_comments))'');
    populated_corp_organizational_comments_pcnt := AVE(GROUP,IF(h.corp_organizational_comments = (TYPEOF(h.corp_organizational_comments))'',0,100));
    maxlength_corp_organizational_comments := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_organizational_comments)));
    avelength_corp_organizational_comments := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_organizational_comments)),h.corp_organizational_comments<>(typeof(h.corp_organizational_comments))'');
    populated_corp_partner_contributions_total_cnt := COUNT(GROUP,h.corp_partner_contributions_total <> (TYPEOF(h.corp_partner_contributions_total))'');
    populated_corp_partner_contributions_total_pcnt := AVE(GROUP,IF(h.corp_partner_contributions_total = (TYPEOF(h.corp_partner_contributions_total))'',0,100));
    maxlength_corp_partner_contributions_total := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_partner_contributions_total)));
    avelength_corp_partner_contributions_total := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_partner_contributions_total)),h.corp_partner_contributions_total<>(typeof(h.corp_partner_contributions_total))'');
    populated_corp_partner_terms_cnt := COUNT(GROUP,h.corp_partner_terms <> (TYPEOF(h.corp_partner_terms))'');
    populated_corp_partner_terms_pcnt := AVE(GROUP,IF(h.corp_partner_terms = (TYPEOF(h.corp_partner_terms))'',0,100));
    maxlength_corp_partner_terms := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_partner_terms)));
    avelength_corp_partner_terms := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_partner_terms)),h.corp_partner_terms<>(typeof(h.corp_partner_terms))'');
    populated_corp_percentage_voters_required_to_approve_amendments_cnt := COUNT(GROUP,h.corp_percentage_voters_required_to_approve_amendments <> (TYPEOF(h.corp_percentage_voters_required_to_approve_amendments))'');
    populated_corp_percentage_voters_required_to_approve_amendments_pcnt := AVE(GROUP,IF(h.corp_percentage_voters_required_to_approve_amendments = (TYPEOF(h.corp_percentage_voters_required_to_approve_amendments))'',0,100));
    maxlength_corp_percentage_voters_required_to_approve_amendments := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_percentage_voters_required_to_approve_amendments)));
    avelength_corp_percentage_voters_required_to_approve_amendments := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_percentage_voters_required_to_approve_amendments)),h.corp_percentage_voters_required_to_approve_amendments<>(typeof(h.corp_percentage_voters_required_to_approve_amendments))'');
    populated_corp_profession_cnt := COUNT(GROUP,h.corp_profession <> (TYPEOF(h.corp_profession))'');
    populated_corp_profession_pcnt := AVE(GROUP,IF(h.corp_profession = (TYPEOF(h.corp_profession))'',0,100));
    maxlength_corp_profession := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_profession)));
    avelength_corp_profession := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_profession)),h.corp_profession<>(typeof(h.corp_profession))'');
    populated_corp_province_cnt := COUNT(GROUP,h.corp_province <> (TYPEOF(h.corp_province))'');
    populated_corp_province_pcnt := AVE(GROUP,IF(h.corp_province = (TYPEOF(h.corp_province))'',0,100));
    maxlength_corp_province := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_province)));
    avelength_corp_province := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_province)),h.corp_province<>(typeof(h.corp_province))'');
    populated_corp_public_mutual_corporation_cnt := COUNT(GROUP,h.corp_public_mutual_corporation <> (TYPEOF(h.corp_public_mutual_corporation))'');
    populated_corp_public_mutual_corporation_pcnt := AVE(GROUP,IF(h.corp_public_mutual_corporation = (TYPEOF(h.corp_public_mutual_corporation))'',0,100));
    maxlength_corp_public_mutual_corporation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_public_mutual_corporation)));
    avelength_corp_public_mutual_corporation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_public_mutual_corporation)),h.corp_public_mutual_corporation<>(typeof(h.corp_public_mutual_corporation))'');
    populated_corp_purpose_cnt := COUNT(GROUP,h.corp_purpose <> (TYPEOF(h.corp_purpose))'');
    populated_corp_purpose_pcnt := AVE(GROUP,IF(h.corp_purpose = (TYPEOF(h.corp_purpose))'',0,100));
    maxlength_corp_purpose := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_purpose)));
    avelength_corp_purpose := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_purpose)),h.corp_purpose<>(typeof(h.corp_purpose))'');
    populated_corp_ra_required_flag_cnt := COUNT(GROUP,h.corp_ra_required_flag <> (TYPEOF(h.corp_ra_required_flag))'');
    populated_corp_ra_required_flag_pcnt := AVE(GROUP,IF(h.corp_ra_required_flag = (TYPEOF(h.corp_ra_required_flag))'',0,100));
    maxlength_corp_ra_required_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_required_flag)));
    avelength_corp_ra_required_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_ra_required_flag)),h.corp_ra_required_flag<>(typeof(h.corp_ra_required_flag))'');
    populated_corp_registered_counties_cnt := COUNT(GROUP,h.corp_registered_counties <> (TYPEOF(h.corp_registered_counties))'');
    populated_corp_registered_counties_pcnt := AVE(GROUP,IF(h.corp_registered_counties = (TYPEOF(h.corp_registered_counties))'',0,100));
    maxlength_corp_registered_counties := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_registered_counties)));
    avelength_corp_registered_counties := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_registered_counties)),h.corp_registered_counties<>(typeof(h.corp_registered_counties))'');
    populated_corp_regulated_ind_cnt := COUNT(GROUP,h.corp_regulated_ind <> (TYPEOF(h.corp_regulated_ind))'');
    populated_corp_regulated_ind_pcnt := AVE(GROUP,IF(h.corp_regulated_ind = (TYPEOF(h.corp_regulated_ind))'',0,100));
    maxlength_corp_regulated_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_regulated_ind)));
    avelength_corp_regulated_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_regulated_ind)),h.corp_regulated_ind<>(typeof(h.corp_regulated_ind))'');
    populated_corp_renewal_date_cnt := COUNT(GROUP,h.corp_renewal_date <> (TYPEOF(h.corp_renewal_date))'');
    populated_corp_renewal_date_pcnt := AVE(GROUP,IF(h.corp_renewal_date = (TYPEOF(h.corp_renewal_date))'',0,100));
    maxlength_corp_renewal_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_renewal_date)));
    avelength_corp_renewal_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_renewal_date)),h.corp_renewal_date<>(typeof(h.corp_renewal_date))'');
    populated_corp_standing_other_cnt := COUNT(GROUP,h.corp_standing_other <> (TYPEOF(h.corp_standing_other))'');
    populated_corp_standing_other_pcnt := AVE(GROUP,IF(h.corp_standing_other = (TYPEOF(h.corp_standing_other))'',0,100));
    maxlength_corp_standing_other := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_standing_other)));
    avelength_corp_standing_other := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_standing_other)),h.corp_standing_other<>(typeof(h.corp_standing_other))'');
    populated_corp_survivor_corporation_id_cnt := COUNT(GROUP,h.corp_survivor_corporation_id <> (TYPEOF(h.corp_survivor_corporation_id))'');
    populated_corp_survivor_corporation_id_pcnt := AVE(GROUP,IF(h.corp_survivor_corporation_id = (TYPEOF(h.corp_survivor_corporation_id))'',0,100));
    maxlength_corp_survivor_corporation_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_survivor_corporation_id)));
    avelength_corp_survivor_corporation_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_survivor_corporation_id)),h.corp_survivor_corporation_id<>(typeof(h.corp_survivor_corporation_id))'');
    populated_corp_tax_base_cnt := COUNT(GROUP,h.corp_tax_base <> (TYPEOF(h.corp_tax_base))'');
    populated_corp_tax_base_pcnt := AVE(GROUP,IF(h.corp_tax_base = (TYPEOF(h.corp_tax_base))'',0,100));
    maxlength_corp_tax_base := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_tax_base)));
    avelength_corp_tax_base := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_tax_base)),h.corp_tax_base<>(typeof(h.corp_tax_base))'');
    populated_corp_tax_standing_cnt := COUNT(GROUP,h.corp_tax_standing <> (TYPEOF(h.corp_tax_standing))'');
    populated_corp_tax_standing_pcnt := AVE(GROUP,IF(h.corp_tax_standing = (TYPEOF(h.corp_tax_standing))'',0,100));
    maxlength_corp_tax_standing := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_tax_standing)));
    avelength_corp_tax_standing := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_tax_standing)),h.corp_tax_standing<>(typeof(h.corp_tax_standing))'');
    populated_corp_termination_cd_cnt := COUNT(GROUP,h.corp_termination_cd <> (TYPEOF(h.corp_termination_cd))'');
    populated_corp_termination_cd_pcnt := AVE(GROUP,IF(h.corp_termination_cd = (TYPEOF(h.corp_termination_cd))'',0,100));
    maxlength_corp_termination_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_termination_cd)));
    avelength_corp_termination_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_termination_cd)),h.corp_termination_cd<>(typeof(h.corp_termination_cd))'');
    populated_corp_termination_desc_cnt := COUNT(GROUP,h.corp_termination_desc <> (TYPEOF(h.corp_termination_desc))'');
    populated_corp_termination_desc_pcnt := AVE(GROUP,IF(h.corp_termination_desc = (TYPEOF(h.corp_termination_desc))'',0,100));
    maxlength_corp_termination_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_termination_desc)));
    avelength_corp_termination_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_termination_desc)),h.corp_termination_desc<>(typeof(h.corp_termination_desc))'');
    populated_corp_termination_date_cnt := COUNT(GROUP,h.corp_termination_date <> (TYPEOF(h.corp_termination_date))'');
    populated_corp_termination_date_pcnt := AVE(GROUP,IF(h.corp_termination_date = (TYPEOF(h.corp_termination_date))'',0,100));
    maxlength_corp_termination_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_termination_date)));
    avelength_corp_termination_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_termination_date)),h.corp_termination_date<>(typeof(h.corp_termination_date))'');
    populated_corp_trademark_classification_nbr_cnt := COUNT(GROUP,h.corp_trademark_classification_nbr <> (TYPEOF(h.corp_trademark_classification_nbr))'');
    populated_corp_trademark_classification_nbr_pcnt := AVE(GROUP,IF(h.corp_trademark_classification_nbr = (TYPEOF(h.corp_trademark_classification_nbr))'',0,100));
    maxlength_corp_trademark_classification_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_classification_nbr)));
    avelength_corp_trademark_classification_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_classification_nbr)),h.corp_trademark_classification_nbr<>(typeof(h.corp_trademark_classification_nbr))'');
    populated_corp_trademark_first_use_date_cnt := COUNT(GROUP,h.corp_trademark_first_use_date <> (TYPEOF(h.corp_trademark_first_use_date))'');
    populated_corp_trademark_first_use_date_pcnt := AVE(GROUP,IF(h.corp_trademark_first_use_date = (TYPEOF(h.corp_trademark_first_use_date))'',0,100));
    maxlength_corp_trademark_first_use_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_first_use_date)));
    avelength_corp_trademark_first_use_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_first_use_date)),h.corp_trademark_first_use_date<>(typeof(h.corp_trademark_first_use_date))'');
    populated_corp_trademark_first_use_date_in_state_cnt := COUNT(GROUP,h.corp_trademark_first_use_date_in_state <> (TYPEOF(h.corp_trademark_first_use_date_in_state))'');
    populated_corp_trademark_first_use_date_in_state_pcnt := AVE(GROUP,IF(h.corp_trademark_first_use_date_in_state = (TYPEOF(h.corp_trademark_first_use_date_in_state))'',0,100));
    maxlength_corp_trademark_first_use_date_in_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_first_use_date_in_state)));
    avelength_corp_trademark_first_use_date_in_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_first_use_date_in_state)),h.corp_trademark_first_use_date_in_state<>(typeof(h.corp_trademark_first_use_date_in_state))'');
    populated_corp_trademark_business_mark_type_cnt := COUNT(GROUP,h.corp_trademark_business_mark_type <> (TYPEOF(h.corp_trademark_business_mark_type))'');
    populated_corp_trademark_business_mark_type_pcnt := AVE(GROUP,IF(h.corp_trademark_business_mark_type = (TYPEOF(h.corp_trademark_business_mark_type))'',0,100));
    maxlength_corp_trademark_business_mark_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_business_mark_type)));
    avelength_corp_trademark_business_mark_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_business_mark_type)),h.corp_trademark_business_mark_type<>(typeof(h.corp_trademark_business_mark_type))'');
    populated_corp_trademark_cancelled_date_cnt := COUNT(GROUP,h.corp_trademark_cancelled_date <> (TYPEOF(h.corp_trademark_cancelled_date))'');
    populated_corp_trademark_cancelled_date_pcnt := AVE(GROUP,IF(h.corp_trademark_cancelled_date = (TYPEOF(h.corp_trademark_cancelled_date))'',0,100));
    maxlength_corp_trademark_cancelled_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_cancelled_date)));
    avelength_corp_trademark_cancelled_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_cancelled_date)),h.corp_trademark_cancelled_date<>(typeof(h.corp_trademark_cancelled_date))'');
    populated_corp_trademark_class_desc1_cnt := COUNT(GROUP,h.corp_trademark_class_desc1 <> (TYPEOF(h.corp_trademark_class_desc1))'');
    populated_corp_trademark_class_desc1_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc1 = (TYPEOF(h.corp_trademark_class_desc1))'',0,100));
    maxlength_corp_trademark_class_desc1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc1)));
    avelength_corp_trademark_class_desc1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc1)),h.corp_trademark_class_desc1<>(typeof(h.corp_trademark_class_desc1))'');
    populated_corp_trademark_class_desc2_cnt := COUNT(GROUP,h.corp_trademark_class_desc2 <> (TYPEOF(h.corp_trademark_class_desc2))'');
    populated_corp_trademark_class_desc2_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc2 = (TYPEOF(h.corp_trademark_class_desc2))'',0,100));
    maxlength_corp_trademark_class_desc2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc2)));
    avelength_corp_trademark_class_desc2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc2)),h.corp_trademark_class_desc2<>(typeof(h.corp_trademark_class_desc2))'');
    populated_corp_trademark_class_desc3_cnt := COUNT(GROUP,h.corp_trademark_class_desc3 <> (TYPEOF(h.corp_trademark_class_desc3))'');
    populated_corp_trademark_class_desc3_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc3 = (TYPEOF(h.corp_trademark_class_desc3))'',0,100));
    maxlength_corp_trademark_class_desc3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc3)));
    avelength_corp_trademark_class_desc3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc3)),h.corp_trademark_class_desc3<>(typeof(h.corp_trademark_class_desc3))'');
    populated_corp_trademark_class_desc4_cnt := COUNT(GROUP,h.corp_trademark_class_desc4 <> (TYPEOF(h.corp_trademark_class_desc4))'');
    populated_corp_trademark_class_desc4_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc4 = (TYPEOF(h.corp_trademark_class_desc4))'',0,100));
    maxlength_corp_trademark_class_desc4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc4)));
    avelength_corp_trademark_class_desc4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc4)),h.corp_trademark_class_desc4<>(typeof(h.corp_trademark_class_desc4))'');
    populated_corp_trademark_class_desc5_cnt := COUNT(GROUP,h.corp_trademark_class_desc5 <> (TYPEOF(h.corp_trademark_class_desc5))'');
    populated_corp_trademark_class_desc5_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc5 = (TYPEOF(h.corp_trademark_class_desc5))'',0,100));
    maxlength_corp_trademark_class_desc5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc5)));
    avelength_corp_trademark_class_desc5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc5)),h.corp_trademark_class_desc5<>(typeof(h.corp_trademark_class_desc5))'');
    populated_corp_trademark_class_desc6_cnt := COUNT(GROUP,h.corp_trademark_class_desc6 <> (TYPEOF(h.corp_trademark_class_desc6))'');
    populated_corp_trademark_class_desc6_pcnt := AVE(GROUP,IF(h.corp_trademark_class_desc6 = (TYPEOF(h.corp_trademark_class_desc6))'',0,100));
    maxlength_corp_trademark_class_desc6 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc6)));
    avelength_corp_trademark_class_desc6 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_class_desc6)),h.corp_trademark_class_desc6<>(typeof(h.corp_trademark_class_desc6))'');
    populated_corp_trademark_disclaimer1_cnt := COUNT(GROUP,h.corp_trademark_disclaimer1 <> (TYPEOF(h.corp_trademark_disclaimer1))'');
    populated_corp_trademark_disclaimer1_pcnt := AVE(GROUP,IF(h.corp_trademark_disclaimer1 = (TYPEOF(h.corp_trademark_disclaimer1))'',0,100));
    maxlength_corp_trademark_disclaimer1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_disclaimer1)));
    avelength_corp_trademark_disclaimer1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_disclaimer1)),h.corp_trademark_disclaimer1<>(typeof(h.corp_trademark_disclaimer1))'');
    populated_corp_trademark_disclaimer2_cnt := COUNT(GROUP,h.corp_trademark_disclaimer2 <> (TYPEOF(h.corp_trademark_disclaimer2))'');
    populated_corp_trademark_disclaimer2_pcnt := AVE(GROUP,IF(h.corp_trademark_disclaimer2 = (TYPEOF(h.corp_trademark_disclaimer2))'',0,100));
    maxlength_corp_trademark_disclaimer2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_disclaimer2)));
    avelength_corp_trademark_disclaimer2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_disclaimer2)),h.corp_trademark_disclaimer2<>(typeof(h.corp_trademark_disclaimer2))'');
    populated_corp_trademark_expiration_date_cnt := COUNT(GROUP,h.corp_trademark_expiration_date <> (TYPEOF(h.corp_trademark_expiration_date))'');
    populated_corp_trademark_expiration_date_pcnt := AVE(GROUP,IF(h.corp_trademark_expiration_date = (TYPEOF(h.corp_trademark_expiration_date))'',0,100));
    maxlength_corp_trademark_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_expiration_date)));
    avelength_corp_trademark_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_expiration_date)),h.corp_trademark_expiration_date<>(typeof(h.corp_trademark_expiration_date))'');
    populated_corp_trademark_filing_date_cnt := COUNT(GROUP,h.corp_trademark_filing_date <> (TYPEOF(h.corp_trademark_filing_date))'');
    populated_corp_trademark_filing_date_pcnt := AVE(GROUP,IF(h.corp_trademark_filing_date = (TYPEOF(h.corp_trademark_filing_date))'',0,100));
    maxlength_corp_trademark_filing_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_filing_date)));
    avelength_corp_trademark_filing_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_filing_date)),h.corp_trademark_filing_date<>(typeof(h.corp_trademark_filing_date))'');
    populated_corp_trademark_keywords_cnt := COUNT(GROUP,h.corp_trademark_keywords <> (TYPEOF(h.corp_trademark_keywords))'');
    populated_corp_trademark_keywords_pcnt := AVE(GROUP,IF(h.corp_trademark_keywords = (TYPEOF(h.corp_trademark_keywords))'',0,100));
    maxlength_corp_trademark_keywords := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_keywords)));
    avelength_corp_trademark_keywords := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_keywords)),h.corp_trademark_keywords<>(typeof(h.corp_trademark_keywords))'');
    populated_corp_trademark_logo_cnt := COUNT(GROUP,h.corp_trademark_logo <> (TYPEOF(h.corp_trademark_logo))'');
    populated_corp_trademark_logo_pcnt := AVE(GROUP,IF(h.corp_trademark_logo = (TYPEOF(h.corp_trademark_logo))'',0,100));
    maxlength_corp_trademark_logo := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_logo)));
    avelength_corp_trademark_logo := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_logo)),h.corp_trademark_logo<>(typeof(h.corp_trademark_logo))'');
    populated_corp_trademark_name_expiration_date_cnt := COUNT(GROUP,h.corp_trademark_name_expiration_date <> (TYPEOF(h.corp_trademark_name_expiration_date))'');
    populated_corp_trademark_name_expiration_date_pcnt := AVE(GROUP,IF(h.corp_trademark_name_expiration_date = (TYPEOF(h.corp_trademark_name_expiration_date))'',0,100));
    maxlength_corp_trademark_name_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_name_expiration_date)));
    avelength_corp_trademark_name_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_name_expiration_date)),h.corp_trademark_name_expiration_date<>(typeof(h.corp_trademark_name_expiration_date))'');
    populated_corp_trademark_nbr_cnt := COUNT(GROUP,h.corp_trademark_nbr <> (TYPEOF(h.corp_trademark_nbr))'');
    populated_corp_trademark_nbr_pcnt := AVE(GROUP,IF(h.corp_trademark_nbr = (TYPEOF(h.corp_trademark_nbr))'',0,100));
    maxlength_corp_trademark_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_nbr)));
    avelength_corp_trademark_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_nbr)),h.corp_trademark_nbr<>(typeof(h.corp_trademark_nbr))'');
    populated_corp_trademark_renewal_date_cnt := COUNT(GROUP,h.corp_trademark_renewal_date <> (TYPEOF(h.corp_trademark_renewal_date))'');
    populated_corp_trademark_renewal_date_pcnt := AVE(GROUP,IF(h.corp_trademark_renewal_date = (TYPEOF(h.corp_trademark_renewal_date))'',0,100));
    maxlength_corp_trademark_renewal_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_renewal_date)));
    avelength_corp_trademark_renewal_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_renewal_date)),h.corp_trademark_renewal_date<>(typeof(h.corp_trademark_renewal_date))'');
    populated_corp_trademark_status_cnt := COUNT(GROUP,h.corp_trademark_status <> (TYPEOF(h.corp_trademark_status))'');
    populated_corp_trademark_status_pcnt := AVE(GROUP,IF(h.corp_trademark_status = (TYPEOF(h.corp_trademark_status))'',0,100));
    maxlength_corp_trademark_status := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_status)));
    avelength_corp_trademark_status := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_status)),h.corp_trademark_status<>(typeof(h.corp_trademark_status))'');
    populated_corp_trademark_used_1_cnt := COUNT(GROUP,h.corp_trademark_used_1 <> (TYPEOF(h.corp_trademark_used_1))'');
    populated_corp_trademark_used_1_pcnt := AVE(GROUP,IF(h.corp_trademark_used_1 = (TYPEOF(h.corp_trademark_used_1))'',0,100));
    maxlength_corp_trademark_used_1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_used_1)));
    avelength_corp_trademark_used_1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_used_1)),h.corp_trademark_used_1<>(typeof(h.corp_trademark_used_1))'');
    populated_corp_trademark_used_2_cnt := COUNT(GROUP,h.corp_trademark_used_2 <> (TYPEOF(h.corp_trademark_used_2))'');
    populated_corp_trademark_used_2_pcnt := AVE(GROUP,IF(h.corp_trademark_used_2 = (TYPEOF(h.corp_trademark_used_2))'',0,100));
    maxlength_corp_trademark_used_2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_used_2)));
    avelength_corp_trademark_used_2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_used_2)),h.corp_trademark_used_2<>(typeof(h.corp_trademark_used_2))'');
    populated_corp_trademark_used_3_cnt := COUNT(GROUP,h.corp_trademark_used_3 <> (TYPEOF(h.corp_trademark_used_3))'');
    populated_corp_trademark_used_3_pcnt := AVE(GROUP,IF(h.corp_trademark_used_3 = (TYPEOF(h.corp_trademark_used_3))'',0,100));
    maxlength_corp_trademark_used_3 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_used_3)));
    avelength_corp_trademark_used_3 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_trademark_used_3)),h.corp_trademark_used_3<>(typeof(h.corp_trademark_used_3))'');
    populated_cont_owner_percentage_cnt := COUNT(GROUP,h.cont_owner_percentage <> (TYPEOF(h.cont_owner_percentage))'');
    populated_cont_owner_percentage_pcnt := AVE(GROUP,IF(h.cont_owner_percentage = (TYPEOF(h.cont_owner_percentage))'',0,100));
    maxlength_cont_owner_percentage := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_owner_percentage)));
    avelength_cont_owner_percentage := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_owner_percentage)),h.cont_owner_percentage<>(typeof(h.cont_owner_percentage))'');
    populated_cont_country_cnt := COUNT(GROUP,h.cont_country <> (TYPEOF(h.cont_country))'');
    populated_cont_country_pcnt := AVE(GROUP,IF(h.cont_country = (TYPEOF(h.cont_country))'',0,100));
    maxlength_cont_country := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_country)));
    avelength_cont_country := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_country)),h.cont_country<>(typeof(h.cont_country))'');
    populated_cont_country_mailing_cnt := COUNT(GROUP,h.cont_country_mailing <> (TYPEOF(h.cont_country_mailing))'');
    populated_cont_country_mailing_pcnt := AVE(GROUP,IF(h.cont_country_mailing = (TYPEOF(h.cont_country_mailing))'',0,100));
    maxlength_cont_country_mailing := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_country_mailing)));
    avelength_cont_country_mailing := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_country_mailing)),h.cont_country_mailing<>(typeof(h.cont_country_mailing))'');
    populated_cont_nondislosure_cnt := COUNT(GROUP,h.cont_nondislosure <> (TYPEOF(h.cont_nondislosure))'');
    populated_cont_nondislosure_pcnt := AVE(GROUP,IF(h.cont_nondislosure = (TYPEOF(h.cont_nondislosure))'',0,100));
    maxlength_cont_nondislosure := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_nondislosure)));
    avelength_cont_nondislosure := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_nondislosure)),h.cont_nondislosure<>(typeof(h.cont_nondislosure))'');
    populated_cont_prep_addr_line1_cnt := COUNT(GROUP,h.cont_prep_addr_line1 <> (TYPEOF(h.cont_prep_addr_line1))'');
    populated_cont_prep_addr_line1_pcnt := AVE(GROUP,IF(h.cont_prep_addr_line1 = (TYPEOF(h.cont_prep_addr_line1))'',0,100));
    maxlength_cont_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_prep_addr_line1)));
    avelength_cont_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_prep_addr_line1)),h.cont_prep_addr_line1<>(typeof(h.cont_prep_addr_line1))'');
    populated_cont_prep_addr_last_line_cnt := COUNT(GROUP,h.cont_prep_addr_last_line <> (TYPEOF(h.cont_prep_addr_last_line))'');
    populated_cont_prep_addr_last_line_pcnt := AVE(GROUP,IF(h.cont_prep_addr_last_line = (TYPEOF(h.cont_prep_addr_last_line))'',0,100));
    maxlength_cont_prep_addr_last_line := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_prep_addr_last_line)));
    avelength_cont_prep_addr_last_line := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cont_prep_addr_last_line)),h.cont_prep_addr_last_line<>(typeof(h.cont_prep_addr_last_line))'');
    populated_recordorigin_cnt := COUNT(GROUP,h.recordorigin <> (TYPEOF(h.recordorigin))'');
    populated_recordorigin_pcnt := AVE(GROUP,IF(h.recordorigin = (TYPEOF(h.recordorigin))'',0,100));
    maxlength_recordorigin := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.recordorigin)));
    avelength_recordorigin := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.recordorigin)),h.recordorigin<>(typeof(h.recordorigin))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_corp_ra_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_corp_ra_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_supp_key_pcnt *   0.00 / 100 + T.Populated_corp_vendor_pcnt *   0.00 / 100 + T.Populated_corp_vendor_county_pcnt *   0.00 / 100 + T.Populated_corp_vendor_subcode_pcnt *   0.00 / 100 + T.Populated_corp_state_origin_pcnt *   0.00 / 100 + T.Populated_corp_process_date_pcnt *   0.00 / 100 + T.Populated_corp_orig_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_corp_legal_name_pcnt *   0.00 / 100 + T.Populated_corp_ln_name_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_ln_name_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_supp_nbr_pcnt *   0.00 / 100 + T.Populated_corp_name_comment_pcnt *   0.00 / 100 + T.Populated_corp_address1_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_address1_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_address1_line1_pcnt *   0.00 / 100 + T.Populated_corp_address1_line2_pcnt *   0.00 / 100 + T.Populated_corp_address1_line3_pcnt *   0.00 / 100 + T.Populated_corp_address1_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_address2_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_address2_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_address2_line1_pcnt *   0.00 / 100 + T.Populated_corp_address2_line2_pcnt *   0.00 / 100 + T.Populated_corp_address2_line3_pcnt *   0.00 / 100 + T.Populated_corp_address2_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_phone_number_pcnt *   0.00 / 100 + T.Populated_corp_phone_number_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_phone_number_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_fax_nbr_pcnt *   0.00 / 100 + T.Populated_corp_email_address_pcnt *   0.00 / 100 + T.Populated_corp_web_address_pcnt *   0.00 / 100 + T.Populated_corp_filing_reference_nbr_pcnt *   0.00 / 100 + T.Populated_corp_filing_date_pcnt *   0.00 / 100 + T.Populated_corp_filing_cd_pcnt *   0.00 / 100 + T.Populated_corp_filing_desc_pcnt *   0.00 / 100 + T.Populated_corp_status_cd_pcnt *   0.00 / 100 + T.Populated_corp_status_desc_pcnt *   0.00 / 100 + T.Populated_corp_status_date_pcnt *   0.00 / 100 + T.Populated_corp_standing_pcnt *   0.00 / 100 + T.Populated_corp_status_comment_pcnt *   0.00 / 100 + T.Populated_corp_ticker_symbol_pcnt *   0.00 / 100 + T.Populated_corp_stock_exchange_pcnt *   0.00 / 100 + T.Populated_corp_inc_state_pcnt *   0.00 / 100 + T.Populated_corp_inc_county_pcnt *   0.00 / 100 + T.Populated_corp_inc_date_pcnt *   0.00 / 100 + T.Populated_corp_anniversary_month_pcnt *   0.00 / 100 + T.Populated_corp_fed_tax_id_pcnt *   0.00 / 100 + T.Populated_corp_state_tax_id_pcnt *   0.00 / 100 + T.Populated_corp_term_exist_cd_pcnt *   0.00 / 100 + T.Populated_corp_term_exist_exp_pcnt *   0.00 / 100 + T.Populated_corp_term_exist_desc_pcnt *   0.00 / 100 + T.Populated_corp_foreign_domestic_ind_pcnt *   0.00 / 100 + T.Populated_corp_forgn_state_cd_pcnt *   0.00 / 100 + T.Populated_corp_forgn_state_desc_pcnt *   0.00 / 100 + T.Populated_corp_forgn_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_corp_forgn_date_pcnt *   0.00 / 100 + T.Populated_corp_forgn_fed_tax_id_pcnt *   0.00 / 100 + T.Populated_corp_forgn_state_tax_id_pcnt *   0.00 / 100 + T.Populated_corp_forgn_term_exist_cd_pcnt *   0.00 / 100 + T.Populated_corp_forgn_term_exist_exp_pcnt *   0.00 / 100 + T.Populated_corp_forgn_term_exist_desc_pcnt *   0.00 / 100 + T.Populated_corp_orig_org_structure_cd_pcnt *   0.00 / 100 + T.Populated_corp_orig_org_structure_desc_pcnt *   0.00 / 100 + T.Populated_corp_for_profit_ind_pcnt *   0.00 / 100 + T.Populated_corp_public_or_private_ind_pcnt *   0.00 / 100 + T.Populated_corp_sic_code_pcnt *   0.00 / 100 + T.Populated_corp_naic_code_pcnt *   0.00 / 100 + T.Populated_corp_orig_bus_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_orig_bus_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_entity_desc_pcnt *   0.00 / 100 + T.Populated_corp_certificate_nbr_pcnt *   0.00 / 100 + T.Populated_corp_internal_nbr_pcnt *   0.00 / 100 + T.Populated_corp_previous_nbr_pcnt *   0.00 / 100 + T.Populated_corp_microfilm_nbr_pcnt *   0.00 / 100 + T.Populated_corp_amendments_filed_pcnt *   0.00 / 100 + T.Populated_corp_acts_pcnt *   0.00 / 100 + T.Populated_corp_partnership_ind_pcnt *   0.00 / 100 + T.Populated_corp_mfg_ind_pcnt *   0.00 / 100 + T.Populated_corp_addl_info_pcnt *   0.00 / 100 + T.Populated_corp_taxes_pcnt *   0.00 / 100 + T.Populated_corp_franchise_taxes_pcnt *   0.00 / 100 + T.Populated_corp_tax_program_cd_pcnt *   0.00 / 100 + T.Populated_corp_tax_program_desc_pcnt *   0.00 / 100 + T.Populated_corp_ra_full_name_pcnt *   0.00 / 100 + T.Populated_corp_ra_fname_pcnt *   0.00 / 100 + T.Populated_corp_ra_mname_pcnt *   0.00 / 100 + T.Populated_corp_ra_lname_pcnt *   0.00 / 100 + T.Populated_corp_ra_suffix_pcnt *   0.00 / 100 + T.Populated_corp_ra_title_cd_pcnt *   0.00 / 100 + T.Populated_corp_ra_title_desc_pcnt *   0.00 / 100 + T.Populated_corp_ra_fein_pcnt *   0.00 / 100 + T.Populated_corp_ra_ssn_pcnt *   0.00 / 100 + T.Populated_corp_ra_dob_pcnt *   0.00 / 100 + T.Populated_corp_ra_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_ra_resign_date_pcnt *   0.00 / 100 + T.Populated_corp_ra_no_comp_pcnt *   0.00 / 100 + T.Populated_corp_ra_no_comp_igs_pcnt *   0.00 / 100 + T.Populated_corp_ra_addl_info_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_line1_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_line2_pcnt *   0.00 / 100 + T.Populated_corp_ra_address_line3_pcnt *   0.00 / 100 + T.Populated_corp_ra_phone_number_pcnt *   0.00 / 100 + T.Populated_corp_ra_phone_number_type_cd_pcnt *   0.00 / 100 + T.Populated_corp_ra_phone_number_type_desc_pcnt *   0.00 / 100 + T.Populated_corp_ra_fax_nbr_pcnt *   0.00 / 100 + T.Populated_corp_ra_email_address_pcnt *   0.00 / 100 + T.Populated_corp_ra_web_address_pcnt *   0.00 / 100 + T.Populated_corp_prep_addr1_line1_pcnt *   0.00 / 100 + T.Populated_corp_prep_addr1_last_line_pcnt *   0.00 / 100 + T.Populated_corp_prep_addr2_line1_pcnt *   0.00 / 100 + T.Populated_corp_prep_addr2_last_line_pcnt *   0.00 / 100 + T.Populated_ra_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_ra_prep_addr_last_line_pcnt *   0.00 / 100 + T.Populated_cont_filing_reference_nbr_pcnt *   0.00 / 100 + T.Populated_cont_filing_date_pcnt *   0.00 / 100 + T.Populated_cont_filing_cd_pcnt *   0.00 / 100 + T.Populated_cont_filing_desc_pcnt *   0.00 / 100 + T.Populated_cont_type_cd_pcnt *   0.00 / 100 + T.Populated_cont_type_desc_pcnt *   0.00 / 100 + T.Populated_cont_full_name_pcnt *   0.00 / 100 + T.Populated_cont_fname_pcnt *   0.00 / 100 + T.Populated_cont_mname_pcnt *   0.00 / 100 + T.Populated_cont_lname_pcnt *   0.00 / 100 + T.Populated_cont_suffix_pcnt *   0.00 / 100 + T.Populated_cont_title1_desc_pcnt *   0.00 / 100 + T.Populated_cont_title2_desc_pcnt *   0.00 / 100 + T.Populated_cont_title3_desc_pcnt *   0.00 / 100 + T.Populated_cont_title4_desc_pcnt *   0.00 / 100 + T.Populated_cont_title5_desc_pcnt *   0.00 / 100 + T.Populated_cont_fein_pcnt *   0.00 / 100 + T.Populated_cont_ssn_pcnt *   0.00 / 100 + T.Populated_cont_dob_pcnt *   0.00 / 100 + T.Populated_cont_status_cd_pcnt *   0.00 / 100 + T.Populated_cont_status_desc_pcnt *   0.00 / 100 + T.Populated_cont_effective_date_pcnt *   0.00 / 100 + T.Populated_cont_effective_cd_pcnt *   0.00 / 100 + T.Populated_cont_effective_desc_pcnt *   0.00 / 100 + T.Populated_cont_addl_info_pcnt *   0.00 / 100 + T.Populated_cont_address_type_cd_pcnt *   0.00 / 100 + T.Populated_cont_address_type_desc_pcnt *   0.00 / 100 + T.Populated_cont_address_line1_pcnt *   0.00 / 100 + T.Populated_cont_address_line2_pcnt *   0.00 / 100 + T.Populated_cont_address_line3_pcnt *   0.00 / 100 + T.Populated_cont_address_effective_date_pcnt *   0.00 / 100 + T.Populated_cont_address_county_pcnt *   0.00 / 100 + T.Populated_cont_phone_number_pcnt *   0.00 / 100 + T.Populated_cont_phone_number_type_cd_pcnt *   0.00 / 100 + T.Populated_cont_phone_number_type_desc_pcnt *   0.00 / 100 + T.Populated_cont_fax_nbr_pcnt *   0.00 / 100 + T.Populated_cont_email_address_pcnt *   0.00 / 100 + T.Populated_cont_web_address_pcnt *   0.00 / 100 + T.Populated_corp_acres_pcnt *   0.00 / 100 + T.Populated_corp_action_pcnt *   0.00 / 100 + T.Populated_corp_action_date_pcnt *   0.00 / 100 + T.Populated_corp_action_employment_security_approval_date_pcnt *   0.00 / 100 + T.Populated_corp_action_pending_cd_pcnt *   0.00 / 100 + T.Populated_corp_action_pending_desc_pcnt *   0.00 / 100 + T.Populated_corp_action_statement_of_intent_date_pcnt *   0.00 / 100 + T.Populated_corp_action_tax_dept_approval_date_pcnt *   0.00 / 100 + T.Populated_corp_acts2_pcnt *   0.00 / 100 + T.Populated_corp_acts3_pcnt *   0.00 / 100 + T.Populated_corp_additional_principals_pcnt *   0.00 / 100 + T.Populated_corp_address_office_type_pcnt *   0.00 / 100 + T.Populated_corp_agent_commercial_pcnt *   0.00 / 100 + T.Populated_corp_agent_country_pcnt *   0.00 / 100 + T.Populated_corp_agent_county_pcnt *   0.00 / 100 + T.Populated_corp_agent_status_cd_pcnt *   0.00 / 100 + T.Populated_corp_agent_status_desc_pcnt *   0.00 / 100 + T.Populated_corp_agent_id_pcnt *   0.00 / 100 + T.Populated_corp_agent_assign_date_pcnt *   0.00 / 100 + T.Populated_corp_agriculture_flag_pcnt *   0.00 / 100 + T.Populated_corp_authorized_partners_pcnt *   0.00 / 100 + T.Populated_corp_comment_pcnt *   0.00 / 100 + T.Populated_corp_consent_flag_for_protected_name_pcnt *   0.00 / 100 + T.Populated_corp_converted_pcnt *   0.00 / 100 + T.Populated_corp_converted_from_pcnt *   0.00 / 100 + T.Populated_corp_country_of_formation_pcnt *   0.00 / 100 + T.Populated_corp_date_of_organization_meeting_pcnt *   0.00 / 100 + T.Populated_corp_delayed_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_directors_from_to_pcnt *   0.00 / 100 + T.Populated_corp_dissolved_date_pcnt *   0.00 / 100 + T.Populated_corp_farm_exemptions_pcnt *   0.00 / 100 + T.Populated_corp_farm_qual_date_pcnt *   0.00 / 100 + T.Populated_corp_farm_status_cd_pcnt *   0.00 / 100 + T.Populated_corp_farm_status_desc_pcnt *   0.00 / 100 + T.Populated_corp_farm_status_date_pcnt *   0.00 / 100 + T.Populated_corp_fiscal_year_month_pcnt *   0.00 / 100 + T.Populated_corp_foreign_fiduciary_capacity_in_state_pcnt *   0.00 / 100 + T.Populated_corp_governing_statute_pcnt *   0.00 / 100 + T.Populated_corp_has_members_pcnt *   0.00 / 100 + T.Populated_corp_has_vested_managers_pcnt *   0.00 / 100 + T.Populated_corp_home_incorporated_county_pcnt *   0.00 / 100 + T.Populated_corp_home_state_name_pcnt *   0.00 / 100 + T.Populated_corp_is_professional_pcnt *   0.00 / 100 + T.Populated_corp_is_non_profit_irs_approved_pcnt *   0.00 / 100 + T.Populated_corp_last_renewal_date_pcnt *   0.00 / 100 + T.Populated_corp_last_renewal_year_pcnt *   0.00 / 100 + T.Populated_corp_license_type_pcnt *   0.00 / 100 + T.Populated_corp_llc_managed_ind_pcnt *   0.00 / 100 + T.Populated_corp_llc_managed_desc_pcnt *   0.00 / 100 + T.Populated_corp_management_desc_pcnt *   0.00 / 100 + T.Populated_corp_management_type_pcnt *   0.00 / 100 + T.Populated_corp_manager_managed_pcnt *   0.00 / 100 + T.Populated_corp_merged_corporation_id_pcnt *   0.00 / 100 + T.Populated_corp_merged_fein_pcnt *   0.00 / 100 + T.Populated_corp_merger_allowed_flag_pcnt *   0.00 / 100 + T.Populated_corp_merger_date_pcnt *   0.00 / 100 + T.Populated_corp_merger_desc_pcnt *   0.00 / 100 + T.Populated_corp_merger_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_merger_id_pcnt *   0.00 / 100 + T.Populated_corp_merger_indicator_pcnt *   0.00 / 100 + T.Populated_corp_merger_name_pcnt *   0.00 / 100 + T.Populated_corp_merger_type_converted_to_cd_pcnt *   0.00 / 100 + T.Populated_corp_merger_type_converted_to_desc_pcnt *   0.00 / 100 + T.Populated_corp_naics_desc_pcnt *   0.00 / 100 + T.Populated_corp_name_effective_date_pcnt *   0.00 / 100 + T.Populated_corp_name_reservation_date_pcnt *   0.00 / 100 + T.Populated_corp_name_reservation_expiration_date_pcnt *   0.00 / 100 + T.Populated_corp_name_reservation_nbr_pcnt *   0.00 / 100 + T.Populated_corp_name_reservation_type_pcnt *   0.00 / 100 + T.Populated_corp_name_status_cd_pcnt *   0.00 / 100 + T.Populated_corp_name_status_date_pcnt *   0.00 / 100 + T.Populated_corp_name_status_desc_pcnt *   0.00 / 100 + T.Populated_corp_non_profit_irs_approved_purpose_pcnt *   0.00 / 100 + T.Populated_corp_non_profit_solicit_donations_pcnt *   0.00 / 100 + T.Populated_corp_nbr_of_amendments_pcnt *   0.00 / 100 + T.Populated_corp_nbr_of_initial_llc_members_pcnt *   0.00 / 100 + T.Populated_corp_nbr_of_partners_pcnt *   0.00 / 100 + T.Populated_corp_operating_agreement_pcnt *   0.00 / 100 + T.Populated_corp_opt_in_llc_act_desc_pcnt *   0.00 / 100 + T.Populated_corp_opt_in_llc_act_ind_pcnt *   0.00 / 100 + T.Populated_corp_organizational_comments_pcnt *   0.00 / 100 + T.Populated_corp_partner_contributions_total_pcnt *   0.00 / 100 + T.Populated_corp_partner_terms_pcnt *   0.00 / 100 + T.Populated_corp_percentage_voters_required_to_approve_amendments_pcnt *   0.00 / 100 + T.Populated_corp_profession_pcnt *   0.00 / 100 + T.Populated_corp_province_pcnt *   0.00 / 100 + T.Populated_corp_public_mutual_corporation_pcnt *   0.00 / 100 + T.Populated_corp_purpose_pcnt *   0.00 / 100 + T.Populated_corp_ra_required_flag_pcnt *   0.00 / 100 + T.Populated_corp_registered_counties_pcnt *   0.00 / 100 + T.Populated_corp_regulated_ind_pcnt *   0.00 / 100 + T.Populated_corp_renewal_date_pcnt *   0.00 / 100 + T.Populated_corp_standing_other_pcnt *   0.00 / 100 + T.Populated_corp_survivor_corporation_id_pcnt *   0.00 / 100 + T.Populated_corp_tax_base_pcnt *   0.00 / 100 + T.Populated_corp_tax_standing_pcnt *   0.00 / 100 + T.Populated_corp_termination_cd_pcnt *   0.00 / 100 + T.Populated_corp_termination_desc_pcnt *   0.00 / 100 + T.Populated_corp_termination_date_pcnt *   0.00 / 100 + T.Populated_corp_trademark_classification_nbr_pcnt *   0.00 / 100 + T.Populated_corp_trademark_first_use_date_pcnt *   0.00 / 100 + T.Populated_corp_trademark_first_use_date_in_state_pcnt *   0.00 / 100 + T.Populated_corp_trademark_business_mark_type_pcnt *   0.00 / 100 + T.Populated_corp_trademark_cancelled_date_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc1_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc2_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc3_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc4_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc5_pcnt *   0.00 / 100 + T.Populated_corp_trademark_class_desc6_pcnt *   0.00 / 100 + T.Populated_corp_trademark_disclaimer1_pcnt *   0.00 / 100 + T.Populated_corp_trademark_disclaimer2_pcnt *   0.00 / 100 + T.Populated_corp_trademark_expiration_date_pcnt *   0.00 / 100 + T.Populated_corp_trademark_filing_date_pcnt *   0.00 / 100 + T.Populated_corp_trademark_keywords_pcnt *   0.00 / 100 + T.Populated_corp_trademark_logo_pcnt *   0.00 / 100 + T.Populated_corp_trademark_name_expiration_date_pcnt *   0.00 / 100 + T.Populated_corp_trademark_nbr_pcnt *   0.00 / 100 + T.Populated_corp_trademark_renewal_date_pcnt *   0.00 / 100 + T.Populated_corp_trademark_status_pcnt *   0.00 / 100 + T.Populated_corp_trademark_used_1_pcnt *   0.00 / 100 + T.Populated_corp_trademark_used_2_pcnt *   0.00 / 100 + T.Populated_corp_trademark_used_3_pcnt *   0.00 / 100 + T.Populated_cont_owner_percentage_pcnt *   0.00 / 100 + T.Populated_cont_country_pcnt *   0.00 / 100 + T.Populated_cont_country_mailing_pcnt *   0.00 / 100 + T.Populated_cont_nondislosure_pcnt *   0.00 / 100 + T.Populated_cont_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_cont_prep_addr_last_line_pcnt *   0.00 / 100 + T.Populated_recordorigin_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_supp_nbr','corp_name_comment','corp_address1_type_cd','corp_address1_type_desc','corp_address1_line1','corp_address1_line2','corp_address1_line3','corp_address1_effective_date','corp_address2_type_cd','corp_address2_type_desc','corp_address2_line1','corp_address2_line2','corp_address2_line3','corp_address2_effective_date','corp_phone_number','corp_phone_number_type_cd','corp_phone_number_type_desc','corp_fax_nbr','corp_email_address','corp_web_address','corp_filing_reference_nbr','corp_filing_date','corp_filing_cd','corp_filing_desc','corp_status_cd','corp_status_desc','corp_status_date','corp_standing','corp_status_comment','corp_ticker_symbol','corp_stock_exchange','corp_inc_state','corp_inc_county','corp_inc_date','corp_anniversary_month','corp_fed_tax_id','corp_state_tax_id','corp_term_exist_cd','corp_term_exist_exp','corp_term_exist_desc','corp_foreign_domestic_ind','corp_forgn_state_cd','corp_forgn_state_desc','corp_forgn_sos_charter_nbr','corp_forgn_date','corp_forgn_fed_tax_id','corp_forgn_state_tax_id','corp_forgn_term_exist_cd','corp_forgn_term_exist_exp','corp_forgn_term_exist_desc','corp_orig_org_structure_cd','corp_orig_org_structure_desc','corp_for_profit_ind','corp_public_or_private_ind','corp_sic_code','corp_naic_code','corp_orig_bus_type_cd','corp_orig_bus_type_desc','corp_entity_desc','corp_certificate_nbr','corp_internal_nbr','corp_previous_nbr','corp_microfilm_nbr','corp_amendments_filed','corp_acts','corp_partnership_ind','corp_mfg_ind','corp_addl_info','corp_taxes','corp_franchise_taxes','corp_tax_program_cd','corp_tax_program_desc','corp_ra_full_name','corp_ra_fname','corp_ra_mname','corp_ra_lname','corp_ra_suffix','corp_ra_title_cd','corp_ra_title_desc','corp_ra_fein','corp_ra_ssn','corp_ra_dob','corp_ra_effective_date','corp_ra_resign_date','corp_ra_no_comp','corp_ra_no_comp_igs','corp_ra_addl_info','corp_ra_address_type_cd','corp_ra_address_type_desc','corp_ra_address_line1','corp_ra_address_line2','corp_ra_address_line3','corp_ra_phone_number','corp_ra_phone_number_type_cd','corp_ra_phone_number_type_desc','corp_ra_fax_nbr','corp_ra_email_address','corp_ra_web_address','corp_prep_addr1_line1','corp_prep_addr1_last_line','corp_prep_addr2_line1','corp_prep_addr2_last_line','ra_prep_addr_line1','ra_prep_addr_last_line','cont_filing_reference_nbr','cont_filing_date','cont_filing_cd','cont_filing_desc','cont_type_cd','cont_type_desc','cont_full_name','cont_fname','cont_mname','cont_lname','cont_suffix','cont_title1_desc','cont_title2_desc','cont_title3_desc','cont_title4_desc','cont_title5_desc','cont_fein','cont_ssn','cont_dob','cont_status_cd','cont_status_desc','cont_effective_date','cont_effective_cd','cont_effective_desc','cont_addl_info','cont_address_type_cd','cont_address_type_desc','cont_address_line1','cont_address_line2','cont_address_line3','cont_address_effective_date','cont_address_county','cont_phone_number','cont_phone_number_type_cd','cont_phone_number_type_desc','cont_fax_nbr','cont_email_address','cont_web_address','corp_acres','corp_action','corp_action_date','corp_action_employment_security_approval_date','corp_action_pending_cd','corp_action_pending_desc','corp_action_statement_of_intent_date','corp_action_tax_dept_approval_date','corp_acts2','corp_acts3','corp_additional_principals','corp_address_office_type','corp_agent_commercial','corp_agent_country','corp_agent_county','corp_agent_status_cd','corp_agent_status_desc','corp_agent_id','corp_agent_assign_date','corp_agriculture_flag','corp_authorized_partners','corp_comment','corp_consent_flag_for_protected_name','corp_converted','corp_converted_from','corp_country_of_formation','corp_date_of_organization_meeting','corp_delayed_effective_date','corp_directors_from_to','corp_dissolved_date','corp_farm_exemptions','corp_farm_qual_date','corp_farm_status_cd','corp_farm_status_desc','corp_farm_status_date','corp_fiscal_year_month','corp_foreign_fiduciary_capacity_in_state','corp_governing_statute','corp_has_members','corp_has_vested_managers','corp_home_incorporated_county','corp_home_state_name','corp_is_professional','corp_is_non_profit_irs_approved','corp_last_renewal_date','corp_last_renewal_year','corp_license_type','corp_llc_managed_ind','corp_llc_managed_desc','corp_management_desc','corp_management_type','corp_manager_managed','corp_merged_corporation_id','corp_merged_fein','corp_merger_allowed_flag','corp_merger_date','corp_merger_desc','corp_merger_effective_date','corp_merger_id','corp_merger_indicator','corp_merger_name','corp_merger_type_converted_to_cd','corp_merger_type_converted_to_desc','corp_naics_desc','corp_name_effective_date','corp_name_reservation_date','corp_name_reservation_expiration_date','corp_name_reservation_nbr','corp_name_reservation_type','corp_name_status_cd','corp_name_status_date','corp_name_status_desc','corp_non_profit_irs_approved_purpose','corp_non_profit_solicit_donations','corp_nbr_of_amendments','corp_nbr_of_initial_llc_members','corp_nbr_of_partners','corp_operating_agreement','corp_opt_in_llc_act_desc','corp_opt_in_llc_act_ind','corp_organizational_comments','corp_partner_contributions_total','corp_partner_terms','corp_percentage_voters_required_to_approve_amendments','corp_profession','corp_province','corp_public_mutual_corporation','corp_purpose','corp_ra_required_flag','corp_registered_counties','corp_regulated_ind','corp_renewal_date','corp_standing_other','corp_survivor_corporation_id','corp_tax_base','corp_tax_standing','corp_termination_cd','corp_termination_desc','corp_termination_date','corp_trademark_classification_nbr','corp_trademark_first_use_date','corp_trademark_first_use_date_in_state','corp_trademark_business_mark_type','corp_trademark_cancelled_date','corp_trademark_class_desc1','corp_trademark_class_desc2','corp_trademark_class_desc3','corp_trademark_class_desc4','corp_trademark_class_desc5','corp_trademark_class_desc6','corp_trademark_disclaimer1','corp_trademark_disclaimer2','corp_trademark_expiration_date','corp_trademark_filing_date','corp_trademark_keywords','corp_trademark_logo','corp_trademark_name_expiration_date','corp_trademark_nbr','corp_trademark_renewal_date','corp_trademark_status','corp_trademark_used_1','corp_trademark_used_2','corp_trademark_used_3','cont_owner_percentage','cont_country','cont_country_mailing','cont_nondislosure','cont_prep_addr_line1','cont_prep_addr_last_line','recordorigin');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_corp_ra_dt_first_seen_pcnt,le.populated_corp_ra_dt_last_seen_pcnt,le.populated_corp_key_pcnt,le.populated_corp_supp_key_pcnt,le.populated_corp_vendor_pcnt,le.populated_corp_vendor_county_pcnt,le.populated_corp_vendor_subcode_pcnt,le.populated_corp_state_origin_pcnt,le.populated_corp_process_date_pcnt,le.populated_corp_orig_sos_charter_nbr_pcnt,le.populated_corp_legal_name_pcnt,le.populated_corp_ln_name_type_cd_pcnt,le.populated_corp_ln_name_type_desc_pcnt,le.populated_corp_supp_nbr_pcnt,le.populated_corp_name_comment_pcnt,le.populated_corp_address1_type_cd_pcnt,le.populated_corp_address1_type_desc_pcnt,le.populated_corp_address1_line1_pcnt,le.populated_corp_address1_line2_pcnt,le.populated_corp_address1_line3_pcnt,le.populated_corp_address1_effective_date_pcnt,le.populated_corp_address2_type_cd_pcnt,le.populated_corp_address2_type_desc_pcnt,le.populated_corp_address2_line1_pcnt,le.populated_corp_address2_line2_pcnt,le.populated_corp_address2_line3_pcnt,le.populated_corp_address2_effective_date_pcnt,le.populated_corp_phone_number_pcnt,le.populated_corp_phone_number_type_cd_pcnt,le.populated_corp_phone_number_type_desc_pcnt,le.populated_corp_fax_nbr_pcnt,le.populated_corp_email_address_pcnt,le.populated_corp_web_address_pcnt,le.populated_corp_filing_reference_nbr_pcnt,le.populated_corp_filing_date_pcnt,le.populated_corp_filing_cd_pcnt,le.populated_corp_filing_desc_pcnt,le.populated_corp_status_cd_pcnt,le.populated_corp_status_desc_pcnt,le.populated_corp_status_date_pcnt,le.populated_corp_standing_pcnt,le.populated_corp_status_comment_pcnt,le.populated_corp_ticker_symbol_pcnt,le.populated_corp_stock_exchange_pcnt,le.populated_corp_inc_state_pcnt,le.populated_corp_inc_county_pcnt,le.populated_corp_inc_date_pcnt,le.populated_corp_anniversary_month_pcnt,le.populated_corp_fed_tax_id_pcnt,le.populated_corp_state_tax_id_pcnt,le.populated_corp_term_exist_cd_pcnt,le.populated_corp_term_exist_exp_pcnt,le.populated_corp_term_exist_desc_pcnt,le.populated_corp_foreign_domestic_ind_pcnt,le.populated_corp_forgn_state_cd_pcnt,le.populated_corp_forgn_state_desc_pcnt,le.populated_corp_forgn_sos_charter_nbr_pcnt,le.populated_corp_forgn_date_pcnt,le.populated_corp_forgn_fed_tax_id_pcnt,le.populated_corp_forgn_state_tax_id_pcnt,le.populated_corp_forgn_term_exist_cd_pcnt,le.populated_corp_forgn_term_exist_exp_pcnt,le.populated_corp_forgn_term_exist_desc_pcnt,le.populated_corp_orig_org_structure_cd_pcnt,le.populated_corp_orig_org_structure_desc_pcnt,le.populated_corp_for_profit_ind_pcnt,le.populated_corp_public_or_private_ind_pcnt,le.populated_corp_sic_code_pcnt,le.populated_corp_naic_code_pcnt,le.populated_corp_orig_bus_type_cd_pcnt,le.populated_corp_orig_bus_type_desc_pcnt,le.populated_corp_entity_desc_pcnt,le.populated_corp_certificate_nbr_pcnt,le.populated_corp_internal_nbr_pcnt,le.populated_corp_previous_nbr_pcnt,le.populated_corp_microfilm_nbr_pcnt,le.populated_corp_amendments_filed_pcnt,le.populated_corp_acts_pcnt,le.populated_corp_partnership_ind_pcnt,le.populated_corp_mfg_ind_pcnt,le.populated_corp_addl_info_pcnt,le.populated_corp_taxes_pcnt,le.populated_corp_franchise_taxes_pcnt,le.populated_corp_tax_program_cd_pcnt,le.populated_corp_tax_program_desc_pcnt,le.populated_corp_ra_full_name_pcnt,le.populated_corp_ra_fname_pcnt,le.populated_corp_ra_mname_pcnt,le.populated_corp_ra_lname_pcnt,le.populated_corp_ra_suffix_pcnt,le.populated_corp_ra_title_cd_pcnt,le.populated_corp_ra_title_desc_pcnt,le.populated_corp_ra_fein_pcnt,le.populated_corp_ra_ssn_pcnt,le.populated_corp_ra_dob_pcnt,le.populated_corp_ra_effective_date_pcnt,le.populated_corp_ra_resign_date_pcnt,le.populated_corp_ra_no_comp_pcnt,le.populated_corp_ra_no_comp_igs_pcnt,le.populated_corp_ra_addl_info_pcnt,le.populated_corp_ra_address_type_cd_pcnt,le.populated_corp_ra_address_type_desc_pcnt,le.populated_corp_ra_address_line1_pcnt,le.populated_corp_ra_address_line2_pcnt,le.populated_corp_ra_address_line3_pcnt,le.populated_corp_ra_phone_number_pcnt,le.populated_corp_ra_phone_number_type_cd_pcnt,le.populated_corp_ra_phone_number_type_desc_pcnt,le.populated_corp_ra_fax_nbr_pcnt,le.populated_corp_ra_email_address_pcnt,le.populated_corp_ra_web_address_pcnt,le.populated_corp_prep_addr1_line1_pcnt,le.populated_corp_prep_addr1_last_line_pcnt,le.populated_corp_prep_addr2_line1_pcnt,le.populated_corp_prep_addr2_last_line_pcnt,le.populated_ra_prep_addr_line1_pcnt,le.populated_ra_prep_addr_last_line_pcnt,le.populated_cont_filing_reference_nbr_pcnt,le.populated_cont_filing_date_pcnt,le.populated_cont_filing_cd_pcnt,le.populated_cont_filing_desc_pcnt,le.populated_cont_type_cd_pcnt,le.populated_cont_type_desc_pcnt,le.populated_cont_full_name_pcnt,le.populated_cont_fname_pcnt,le.populated_cont_mname_pcnt,le.populated_cont_lname_pcnt,le.populated_cont_suffix_pcnt,le.populated_cont_title1_desc_pcnt,le.populated_cont_title2_desc_pcnt,le.populated_cont_title3_desc_pcnt,le.populated_cont_title4_desc_pcnt,le.populated_cont_title5_desc_pcnt,le.populated_cont_fein_pcnt,le.populated_cont_ssn_pcnt,le.populated_cont_dob_pcnt,le.populated_cont_status_cd_pcnt,le.populated_cont_status_desc_pcnt,le.populated_cont_effective_date_pcnt,le.populated_cont_effective_cd_pcnt,le.populated_cont_effective_desc_pcnt,le.populated_cont_addl_info_pcnt,le.populated_cont_address_type_cd_pcnt,le.populated_cont_address_type_desc_pcnt,le.populated_cont_address_line1_pcnt,le.populated_cont_address_line2_pcnt,le.populated_cont_address_line3_pcnt,le.populated_cont_address_effective_date_pcnt,le.populated_cont_address_county_pcnt,le.populated_cont_phone_number_pcnt,le.populated_cont_phone_number_type_cd_pcnt,le.populated_cont_phone_number_type_desc_pcnt,le.populated_cont_fax_nbr_pcnt,le.populated_cont_email_address_pcnt,le.populated_cont_web_address_pcnt,le.populated_corp_acres_pcnt,le.populated_corp_action_pcnt,le.populated_corp_action_date_pcnt,le.populated_corp_action_employment_security_approval_date_pcnt,le.populated_corp_action_pending_cd_pcnt,le.populated_corp_action_pending_desc_pcnt,le.populated_corp_action_statement_of_intent_date_pcnt,le.populated_corp_action_tax_dept_approval_date_pcnt,le.populated_corp_acts2_pcnt,le.populated_corp_acts3_pcnt,le.populated_corp_additional_principals_pcnt,le.populated_corp_address_office_type_pcnt,le.populated_corp_agent_commercial_pcnt,le.populated_corp_agent_country_pcnt,le.populated_corp_agent_county_pcnt,le.populated_corp_agent_status_cd_pcnt,le.populated_corp_agent_status_desc_pcnt,le.populated_corp_agent_id_pcnt,le.populated_corp_agent_assign_date_pcnt,le.populated_corp_agriculture_flag_pcnt,le.populated_corp_authorized_partners_pcnt,le.populated_corp_comment_pcnt,le.populated_corp_consent_flag_for_protected_name_pcnt,le.populated_corp_converted_pcnt,le.populated_corp_converted_from_pcnt,le.populated_corp_country_of_formation_pcnt,le.populated_corp_date_of_organization_meeting_pcnt,le.populated_corp_delayed_effective_date_pcnt,le.populated_corp_directors_from_to_pcnt,le.populated_corp_dissolved_date_pcnt,le.populated_corp_farm_exemptions_pcnt,le.populated_corp_farm_qual_date_pcnt,le.populated_corp_farm_status_cd_pcnt,le.populated_corp_farm_status_desc_pcnt,le.populated_corp_farm_status_date_pcnt,le.populated_corp_fiscal_year_month_pcnt,le.populated_corp_foreign_fiduciary_capacity_in_state_pcnt,le.populated_corp_governing_statute_pcnt,le.populated_corp_has_members_pcnt,le.populated_corp_has_vested_managers_pcnt,le.populated_corp_home_incorporated_county_pcnt,le.populated_corp_home_state_name_pcnt,le.populated_corp_is_professional_pcnt,le.populated_corp_is_non_profit_irs_approved_pcnt,le.populated_corp_last_renewal_date_pcnt,le.populated_corp_last_renewal_year_pcnt,le.populated_corp_license_type_pcnt,le.populated_corp_llc_managed_ind_pcnt,le.populated_corp_llc_managed_desc_pcnt,le.populated_corp_management_desc_pcnt,le.populated_corp_management_type_pcnt,le.populated_corp_manager_managed_pcnt,le.populated_corp_merged_corporation_id_pcnt,le.populated_corp_merged_fein_pcnt,le.populated_corp_merger_allowed_flag_pcnt,le.populated_corp_merger_date_pcnt,le.populated_corp_merger_desc_pcnt,le.populated_corp_merger_effective_date_pcnt,le.populated_corp_merger_id_pcnt,le.populated_corp_merger_indicator_pcnt,le.populated_corp_merger_name_pcnt,le.populated_corp_merger_type_converted_to_cd_pcnt,le.populated_corp_merger_type_converted_to_desc_pcnt,le.populated_corp_naics_desc_pcnt,le.populated_corp_name_effective_date_pcnt,le.populated_corp_name_reservation_date_pcnt,le.populated_corp_name_reservation_expiration_date_pcnt,le.populated_corp_name_reservation_nbr_pcnt,le.populated_corp_name_reservation_type_pcnt,le.populated_corp_name_status_cd_pcnt,le.populated_corp_name_status_date_pcnt,le.populated_corp_name_status_desc_pcnt,le.populated_corp_non_profit_irs_approved_purpose_pcnt,le.populated_corp_non_profit_solicit_donations_pcnt,le.populated_corp_nbr_of_amendments_pcnt,le.populated_corp_nbr_of_initial_llc_members_pcnt,le.populated_corp_nbr_of_partners_pcnt,le.populated_corp_operating_agreement_pcnt,le.populated_corp_opt_in_llc_act_desc_pcnt,le.populated_corp_opt_in_llc_act_ind_pcnt,le.populated_corp_organizational_comments_pcnt,le.populated_corp_partner_contributions_total_pcnt,le.populated_corp_partner_terms_pcnt,le.populated_corp_percentage_voters_required_to_approve_amendments_pcnt,le.populated_corp_profession_pcnt,le.populated_corp_province_pcnt,le.populated_corp_public_mutual_corporation_pcnt,le.populated_corp_purpose_pcnt,le.populated_corp_ra_required_flag_pcnt,le.populated_corp_registered_counties_pcnt,le.populated_corp_regulated_ind_pcnt,le.populated_corp_renewal_date_pcnt,le.populated_corp_standing_other_pcnt,le.populated_corp_survivor_corporation_id_pcnt,le.populated_corp_tax_base_pcnt,le.populated_corp_tax_standing_pcnt,le.populated_corp_termination_cd_pcnt,le.populated_corp_termination_desc_pcnt,le.populated_corp_termination_date_pcnt,le.populated_corp_trademark_classification_nbr_pcnt,le.populated_corp_trademark_first_use_date_pcnt,le.populated_corp_trademark_first_use_date_in_state_pcnt,le.populated_corp_trademark_business_mark_type_pcnt,le.populated_corp_trademark_cancelled_date_pcnt,le.populated_corp_trademark_class_desc1_pcnt,le.populated_corp_trademark_class_desc2_pcnt,le.populated_corp_trademark_class_desc3_pcnt,le.populated_corp_trademark_class_desc4_pcnt,le.populated_corp_trademark_class_desc5_pcnt,le.populated_corp_trademark_class_desc6_pcnt,le.populated_corp_trademark_disclaimer1_pcnt,le.populated_corp_trademark_disclaimer2_pcnt,le.populated_corp_trademark_expiration_date_pcnt,le.populated_corp_trademark_filing_date_pcnt,le.populated_corp_trademark_keywords_pcnt,le.populated_corp_trademark_logo_pcnt,le.populated_corp_trademark_name_expiration_date_pcnt,le.populated_corp_trademark_nbr_pcnt,le.populated_corp_trademark_renewal_date_pcnt,le.populated_corp_trademark_status_pcnt,le.populated_corp_trademark_used_1_pcnt,le.populated_corp_trademark_used_2_pcnt,le.populated_corp_trademark_used_3_pcnt,le.populated_cont_owner_percentage_pcnt,le.populated_cont_country_pcnt,le.populated_cont_country_mailing_pcnt,le.populated_cont_nondislosure_pcnt,le.populated_cont_prep_addr_line1_pcnt,le.populated_cont_prep_addr_last_line_pcnt,le.populated_recordorigin_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_corp_ra_dt_first_seen,le.maxlength_corp_ra_dt_last_seen,le.maxlength_corp_key,le.maxlength_corp_supp_key,le.maxlength_corp_vendor,le.maxlength_corp_vendor_county,le.maxlength_corp_vendor_subcode,le.maxlength_corp_state_origin,le.maxlength_corp_process_date,le.maxlength_corp_orig_sos_charter_nbr,le.maxlength_corp_legal_name,le.maxlength_corp_ln_name_type_cd,le.maxlength_corp_ln_name_type_desc,le.maxlength_corp_supp_nbr,le.maxlength_corp_name_comment,le.maxlength_corp_address1_type_cd,le.maxlength_corp_address1_type_desc,le.maxlength_corp_address1_line1,le.maxlength_corp_address1_line2,le.maxlength_corp_address1_line3,le.maxlength_corp_address1_effective_date,le.maxlength_corp_address2_type_cd,le.maxlength_corp_address2_type_desc,le.maxlength_corp_address2_line1,le.maxlength_corp_address2_line2,le.maxlength_corp_address2_line3,le.maxlength_corp_address2_effective_date,le.maxlength_corp_phone_number,le.maxlength_corp_phone_number_type_cd,le.maxlength_corp_phone_number_type_desc,le.maxlength_corp_fax_nbr,le.maxlength_corp_email_address,le.maxlength_corp_web_address,le.maxlength_corp_filing_reference_nbr,le.maxlength_corp_filing_date,le.maxlength_corp_filing_cd,le.maxlength_corp_filing_desc,le.maxlength_corp_status_cd,le.maxlength_corp_status_desc,le.maxlength_corp_status_date,le.maxlength_corp_standing,le.maxlength_corp_status_comment,le.maxlength_corp_ticker_symbol,le.maxlength_corp_stock_exchange,le.maxlength_corp_inc_state,le.maxlength_corp_inc_county,le.maxlength_corp_inc_date,le.maxlength_corp_anniversary_month,le.maxlength_corp_fed_tax_id,le.maxlength_corp_state_tax_id,le.maxlength_corp_term_exist_cd,le.maxlength_corp_term_exist_exp,le.maxlength_corp_term_exist_desc,le.maxlength_corp_foreign_domestic_ind,le.maxlength_corp_forgn_state_cd,le.maxlength_corp_forgn_state_desc,le.maxlength_corp_forgn_sos_charter_nbr,le.maxlength_corp_forgn_date,le.maxlength_corp_forgn_fed_tax_id,le.maxlength_corp_forgn_state_tax_id,le.maxlength_corp_forgn_term_exist_cd,le.maxlength_corp_forgn_term_exist_exp,le.maxlength_corp_forgn_term_exist_desc,le.maxlength_corp_orig_org_structure_cd,le.maxlength_corp_orig_org_structure_desc,le.maxlength_corp_for_profit_ind,le.maxlength_corp_public_or_private_ind,le.maxlength_corp_sic_code,le.maxlength_corp_naic_code,le.maxlength_corp_orig_bus_type_cd,le.maxlength_corp_orig_bus_type_desc,le.maxlength_corp_entity_desc,le.maxlength_corp_certificate_nbr,le.maxlength_corp_internal_nbr,le.maxlength_corp_previous_nbr,le.maxlength_corp_microfilm_nbr,le.maxlength_corp_amendments_filed,le.maxlength_corp_acts,le.maxlength_corp_partnership_ind,le.maxlength_corp_mfg_ind,le.maxlength_corp_addl_info,le.maxlength_corp_taxes,le.maxlength_corp_franchise_taxes,le.maxlength_corp_tax_program_cd,le.maxlength_corp_tax_program_desc,le.maxlength_corp_ra_full_name,le.maxlength_corp_ra_fname,le.maxlength_corp_ra_mname,le.maxlength_corp_ra_lname,le.maxlength_corp_ra_suffix,le.maxlength_corp_ra_title_cd,le.maxlength_corp_ra_title_desc,le.maxlength_corp_ra_fein,le.maxlength_corp_ra_ssn,le.maxlength_corp_ra_dob,le.maxlength_corp_ra_effective_date,le.maxlength_corp_ra_resign_date,le.maxlength_corp_ra_no_comp,le.maxlength_corp_ra_no_comp_igs,le.maxlength_corp_ra_addl_info,le.maxlength_corp_ra_address_type_cd,le.maxlength_corp_ra_address_type_desc,le.maxlength_corp_ra_address_line1,le.maxlength_corp_ra_address_line2,le.maxlength_corp_ra_address_line3,le.maxlength_corp_ra_phone_number,le.maxlength_corp_ra_phone_number_type_cd,le.maxlength_corp_ra_phone_number_type_desc,le.maxlength_corp_ra_fax_nbr,le.maxlength_corp_ra_email_address,le.maxlength_corp_ra_web_address,le.maxlength_corp_prep_addr1_line1,le.maxlength_corp_prep_addr1_last_line,le.maxlength_corp_prep_addr2_line1,le.maxlength_corp_prep_addr2_last_line,le.maxlength_ra_prep_addr_line1,le.maxlength_ra_prep_addr_last_line,le.maxlength_cont_filing_reference_nbr,le.maxlength_cont_filing_date,le.maxlength_cont_filing_cd,le.maxlength_cont_filing_desc,le.maxlength_cont_type_cd,le.maxlength_cont_type_desc,le.maxlength_cont_full_name,le.maxlength_cont_fname,le.maxlength_cont_mname,le.maxlength_cont_lname,le.maxlength_cont_suffix,le.maxlength_cont_title1_desc,le.maxlength_cont_title2_desc,le.maxlength_cont_title3_desc,le.maxlength_cont_title4_desc,le.maxlength_cont_title5_desc,le.maxlength_cont_fein,le.maxlength_cont_ssn,le.maxlength_cont_dob,le.maxlength_cont_status_cd,le.maxlength_cont_status_desc,le.maxlength_cont_effective_date,le.maxlength_cont_effective_cd,le.maxlength_cont_effective_desc,le.maxlength_cont_addl_info,le.maxlength_cont_address_type_cd,le.maxlength_cont_address_type_desc,le.maxlength_cont_address_line1,le.maxlength_cont_address_line2,le.maxlength_cont_address_line3,le.maxlength_cont_address_effective_date,le.maxlength_cont_address_county,le.maxlength_cont_phone_number,le.maxlength_cont_phone_number_type_cd,le.maxlength_cont_phone_number_type_desc,le.maxlength_cont_fax_nbr,le.maxlength_cont_email_address,le.maxlength_cont_web_address,le.maxlength_corp_acres,le.maxlength_corp_action,le.maxlength_corp_action_date,le.maxlength_corp_action_employment_security_approval_date,le.maxlength_corp_action_pending_cd,le.maxlength_corp_action_pending_desc,le.maxlength_corp_action_statement_of_intent_date,le.maxlength_corp_action_tax_dept_approval_date,le.maxlength_corp_acts2,le.maxlength_corp_acts3,le.maxlength_corp_additional_principals,le.maxlength_corp_address_office_type,le.maxlength_corp_agent_commercial,le.maxlength_corp_agent_country,le.maxlength_corp_agent_county,le.maxlength_corp_agent_status_cd,le.maxlength_corp_agent_status_desc,le.maxlength_corp_agent_id,le.maxlength_corp_agent_assign_date,le.maxlength_corp_agriculture_flag,le.maxlength_corp_authorized_partners,le.maxlength_corp_comment,le.maxlength_corp_consent_flag_for_protected_name,le.maxlength_corp_converted,le.maxlength_corp_converted_from,le.maxlength_corp_country_of_formation,le.maxlength_corp_date_of_organization_meeting,le.maxlength_corp_delayed_effective_date,le.maxlength_corp_directors_from_to,le.maxlength_corp_dissolved_date,le.maxlength_corp_farm_exemptions,le.maxlength_corp_farm_qual_date,le.maxlength_corp_farm_status_cd,le.maxlength_corp_farm_status_desc,le.maxlength_corp_farm_status_date,le.maxlength_corp_fiscal_year_month,le.maxlength_corp_foreign_fiduciary_capacity_in_state,le.maxlength_corp_governing_statute,le.maxlength_corp_has_members,le.maxlength_corp_has_vested_managers,le.maxlength_corp_home_incorporated_county,le.maxlength_corp_home_state_name,le.maxlength_corp_is_professional,le.maxlength_corp_is_non_profit_irs_approved,le.maxlength_corp_last_renewal_date,le.maxlength_corp_last_renewal_year,le.maxlength_corp_license_type,le.maxlength_corp_llc_managed_ind,le.maxlength_corp_llc_managed_desc,le.maxlength_corp_management_desc,le.maxlength_corp_management_type,le.maxlength_corp_manager_managed,le.maxlength_corp_merged_corporation_id,le.maxlength_corp_merged_fein,le.maxlength_corp_merger_allowed_flag,le.maxlength_corp_merger_date,le.maxlength_corp_merger_desc,le.maxlength_corp_merger_effective_date,le.maxlength_corp_merger_id,le.maxlength_corp_merger_indicator,le.maxlength_corp_merger_name,le.maxlength_corp_merger_type_converted_to_cd,le.maxlength_corp_merger_type_converted_to_desc,le.maxlength_corp_naics_desc,le.maxlength_corp_name_effective_date,le.maxlength_corp_name_reservation_date,le.maxlength_corp_name_reservation_expiration_date,le.maxlength_corp_name_reservation_nbr,le.maxlength_corp_name_reservation_type,le.maxlength_corp_name_status_cd,le.maxlength_corp_name_status_date,le.maxlength_corp_name_status_desc,le.maxlength_corp_non_profit_irs_approved_purpose,le.maxlength_corp_non_profit_solicit_donations,le.maxlength_corp_nbr_of_amendments,le.maxlength_corp_nbr_of_initial_llc_members,le.maxlength_corp_nbr_of_partners,le.maxlength_corp_operating_agreement,le.maxlength_corp_opt_in_llc_act_desc,le.maxlength_corp_opt_in_llc_act_ind,le.maxlength_corp_organizational_comments,le.maxlength_corp_partner_contributions_total,le.maxlength_corp_partner_terms,le.maxlength_corp_percentage_voters_required_to_approve_amendments,le.maxlength_corp_profession,le.maxlength_corp_province,le.maxlength_corp_public_mutual_corporation,le.maxlength_corp_purpose,le.maxlength_corp_ra_required_flag,le.maxlength_corp_registered_counties,le.maxlength_corp_regulated_ind,le.maxlength_corp_renewal_date,le.maxlength_corp_standing_other,le.maxlength_corp_survivor_corporation_id,le.maxlength_corp_tax_base,le.maxlength_corp_tax_standing,le.maxlength_corp_termination_cd,le.maxlength_corp_termination_desc,le.maxlength_corp_termination_date,le.maxlength_corp_trademark_classification_nbr,le.maxlength_corp_trademark_first_use_date,le.maxlength_corp_trademark_first_use_date_in_state,le.maxlength_corp_trademark_business_mark_type,le.maxlength_corp_trademark_cancelled_date,le.maxlength_corp_trademark_class_desc1,le.maxlength_corp_trademark_class_desc2,le.maxlength_corp_trademark_class_desc3,le.maxlength_corp_trademark_class_desc4,le.maxlength_corp_trademark_class_desc5,le.maxlength_corp_trademark_class_desc6,le.maxlength_corp_trademark_disclaimer1,le.maxlength_corp_trademark_disclaimer2,le.maxlength_corp_trademark_expiration_date,le.maxlength_corp_trademark_filing_date,le.maxlength_corp_trademark_keywords,le.maxlength_corp_trademark_logo,le.maxlength_corp_trademark_name_expiration_date,le.maxlength_corp_trademark_nbr,le.maxlength_corp_trademark_renewal_date,le.maxlength_corp_trademark_status,le.maxlength_corp_trademark_used_1,le.maxlength_corp_trademark_used_2,le.maxlength_corp_trademark_used_3,le.maxlength_cont_owner_percentage,le.maxlength_cont_country,le.maxlength_cont_country_mailing,le.maxlength_cont_nondislosure,le.maxlength_cont_prep_addr_line1,le.maxlength_cont_prep_addr_last_line,le.maxlength_recordorigin);
  SELF.avelength := CHOOSE(C,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_corp_ra_dt_first_seen,le.avelength_corp_ra_dt_last_seen,le.avelength_corp_key,le.avelength_corp_supp_key,le.avelength_corp_vendor,le.avelength_corp_vendor_county,le.avelength_corp_vendor_subcode,le.avelength_corp_state_origin,le.avelength_corp_process_date,le.avelength_corp_orig_sos_charter_nbr,le.avelength_corp_legal_name,le.avelength_corp_ln_name_type_cd,le.avelength_corp_ln_name_type_desc,le.avelength_corp_supp_nbr,le.avelength_corp_name_comment,le.avelength_corp_address1_type_cd,le.avelength_corp_address1_type_desc,le.avelength_corp_address1_line1,le.avelength_corp_address1_line2,le.avelength_corp_address1_line3,le.avelength_corp_address1_effective_date,le.avelength_corp_address2_type_cd,le.avelength_corp_address2_type_desc,le.avelength_corp_address2_line1,le.avelength_corp_address2_line2,le.avelength_corp_address2_line3,le.avelength_corp_address2_effective_date,le.avelength_corp_phone_number,le.avelength_corp_phone_number_type_cd,le.avelength_corp_phone_number_type_desc,le.avelength_corp_fax_nbr,le.avelength_corp_email_address,le.avelength_corp_web_address,le.avelength_corp_filing_reference_nbr,le.avelength_corp_filing_date,le.avelength_corp_filing_cd,le.avelength_corp_filing_desc,le.avelength_corp_status_cd,le.avelength_corp_status_desc,le.avelength_corp_status_date,le.avelength_corp_standing,le.avelength_corp_status_comment,le.avelength_corp_ticker_symbol,le.avelength_corp_stock_exchange,le.avelength_corp_inc_state,le.avelength_corp_inc_county,le.avelength_corp_inc_date,le.avelength_corp_anniversary_month,le.avelength_corp_fed_tax_id,le.avelength_corp_state_tax_id,le.avelength_corp_term_exist_cd,le.avelength_corp_term_exist_exp,le.avelength_corp_term_exist_desc,le.avelength_corp_foreign_domestic_ind,le.avelength_corp_forgn_state_cd,le.avelength_corp_forgn_state_desc,le.avelength_corp_forgn_sos_charter_nbr,le.avelength_corp_forgn_date,le.avelength_corp_forgn_fed_tax_id,le.avelength_corp_forgn_state_tax_id,le.avelength_corp_forgn_term_exist_cd,le.avelength_corp_forgn_term_exist_exp,le.avelength_corp_forgn_term_exist_desc,le.avelength_corp_orig_org_structure_cd,le.avelength_corp_orig_org_structure_desc,le.avelength_corp_for_profit_ind,le.avelength_corp_public_or_private_ind,le.avelength_corp_sic_code,le.avelength_corp_naic_code,le.avelength_corp_orig_bus_type_cd,le.avelength_corp_orig_bus_type_desc,le.avelength_corp_entity_desc,le.avelength_corp_certificate_nbr,le.avelength_corp_internal_nbr,le.avelength_corp_previous_nbr,le.avelength_corp_microfilm_nbr,le.avelength_corp_amendments_filed,le.avelength_corp_acts,le.avelength_corp_partnership_ind,le.avelength_corp_mfg_ind,le.avelength_corp_addl_info,le.avelength_corp_taxes,le.avelength_corp_franchise_taxes,le.avelength_corp_tax_program_cd,le.avelength_corp_tax_program_desc,le.avelength_corp_ra_full_name,le.avelength_corp_ra_fname,le.avelength_corp_ra_mname,le.avelength_corp_ra_lname,le.avelength_corp_ra_suffix,le.avelength_corp_ra_title_cd,le.avelength_corp_ra_title_desc,le.avelength_corp_ra_fein,le.avelength_corp_ra_ssn,le.avelength_corp_ra_dob,le.avelength_corp_ra_effective_date,le.avelength_corp_ra_resign_date,le.avelength_corp_ra_no_comp,le.avelength_corp_ra_no_comp_igs,le.avelength_corp_ra_addl_info,le.avelength_corp_ra_address_type_cd,le.avelength_corp_ra_address_type_desc,le.avelength_corp_ra_address_line1,le.avelength_corp_ra_address_line2,le.avelength_corp_ra_address_line3,le.avelength_corp_ra_phone_number,le.avelength_corp_ra_phone_number_type_cd,le.avelength_corp_ra_phone_number_type_desc,le.avelength_corp_ra_fax_nbr,le.avelength_corp_ra_email_address,le.avelength_corp_ra_web_address,le.avelength_corp_prep_addr1_line1,le.avelength_corp_prep_addr1_last_line,le.avelength_corp_prep_addr2_line1,le.avelength_corp_prep_addr2_last_line,le.avelength_ra_prep_addr_line1,le.avelength_ra_prep_addr_last_line,le.avelength_cont_filing_reference_nbr,le.avelength_cont_filing_date,le.avelength_cont_filing_cd,le.avelength_cont_filing_desc,le.avelength_cont_type_cd,le.avelength_cont_type_desc,le.avelength_cont_full_name,le.avelength_cont_fname,le.avelength_cont_mname,le.avelength_cont_lname,le.avelength_cont_suffix,le.avelength_cont_title1_desc,le.avelength_cont_title2_desc,le.avelength_cont_title3_desc,le.avelength_cont_title4_desc,le.avelength_cont_title5_desc,le.avelength_cont_fein,le.avelength_cont_ssn,le.avelength_cont_dob,le.avelength_cont_status_cd,le.avelength_cont_status_desc,le.avelength_cont_effective_date,le.avelength_cont_effective_cd,le.avelength_cont_effective_desc,le.avelength_cont_addl_info,le.avelength_cont_address_type_cd,le.avelength_cont_address_type_desc,le.avelength_cont_address_line1,le.avelength_cont_address_line2,le.avelength_cont_address_line3,le.avelength_cont_address_effective_date,le.avelength_cont_address_county,le.avelength_cont_phone_number,le.avelength_cont_phone_number_type_cd,le.avelength_cont_phone_number_type_desc,le.avelength_cont_fax_nbr,le.avelength_cont_email_address,le.avelength_cont_web_address,le.avelength_corp_acres,le.avelength_corp_action,le.avelength_corp_action_date,le.avelength_corp_action_employment_security_approval_date,le.avelength_corp_action_pending_cd,le.avelength_corp_action_pending_desc,le.avelength_corp_action_statement_of_intent_date,le.avelength_corp_action_tax_dept_approval_date,le.avelength_corp_acts2,le.avelength_corp_acts3,le.avelength_corp_additional_principals,le.avelength_corp_address_office_type,le.avelength_corp_agent_commercial,le.avelength_corp_agent_country,le.avelength_corp_agent_county,le.avelength_corp_agent_status_cd,le.avelength_corp_agent_status_desc,le.avelength_corp_agent_id,le.avelength_corp_agent_assign_date,le.avelength_corp_agriculture_flag,le.avelength_corp_authorized_partners,le.avelength_corp_comment,le.avelength_corp_consent_flag_for_protected_name,le.avelength_corp_converted,le.avelength_corp_converted_from,le.avelength_corp_country_of_formation,le.avelength_corp_date_of_organization_meeting,le.avelength_corp_delayed_effective_date,le.avelength_corp_directors_from_to,le.avelength_corp_dissolved_date,le.avelength_corp_farm_exemptions,le.avelength_corp_farm_qual_date,le.avelength_corp_farm_status_cd,le.avelength_corp_farm_status_desc,le.avelength_corp_farm_status_date,le.avelength_corp_fiscal_year_month,le.avelength_corp_foreign_fiduciary_capacity_in_state,le.avelength_corp_governing_statute,le.avelength_corp_has_members,le.avelength_corp_has_vested_managers,le.avelength_corp_home_incorporated_county,le.avelength_corp_home_state_name,le.avelength_corp_is_professional,le.avelength_corp_is_non_profit_irs_approved,le.avelength_corp_last_renewal_date,le.avelength_corp_last_renewal_year,le.avelength_corp_license_type,le.avelength_corp_llc_managed_ind,le.avelength_corp_llc_managed_desc,le.avelength_corp_management_desc,le.avelength_corp_management_type,le.avelength_corp_manager_managed,le.avelength_corp_merged_corporation_id,le.avelength_corp_merged_fein,le.avelength_corp_merger_allowed_flag,le.avelength_corp_merger_date,le.avelength_corp_merger_desc,le.avelength_corp_merger_effective_date,le.avelength_corp_merger_id,le.avelength_corp_merger_indicator,le.avelength_corp_merger_name,le.avelength_corp_merger_type_converted_to_cd,le.avelength_corp_merger_type_converted_to_desc,le.avelength_corp_naics_desc,le.avelength_corp_name_effective_date,le.avelength_corp_name_reservation_date,le.avelength_corp_name_reservation_expiration_date,le.avelength_corp_name_reservation_nbr,le.avelength_corp_name_reservation_type,le.avelength_corp_name_status_cd,le.avelength_corp_name_status_date,le.avelength_corp_name_status_desc,le.avelength_corp_non_profit_irs_approved_purpose,le.avelength_corp_non_profit_solicit_donations,le.avelength_corp_nbr_of_amendments,le.avelength_corp_nbr_of_initial_llc_members,le.avelength_corp_nbr_of_partners,le.avelength_corp_operating_agreement,le.avelength_corp_opt_in_llc_act_desc,le.avelength_corp_opt_in_llc_act_ind,le.avelength_corp_organizational_comments,le.avelength_corp_partner_contributions_total,le.avelength_corp_partner_terms,le.avelength_corp_percentage_voters_required_to_approve_amendments,le.avelength_corp_profession,le.avelength_corp_province,le.avelength_corp_public_mutual_corporation,le.avelength_corp_purpose,le.avelength_corp_ra_required_flag,le.avelength_corp_registered_counties,le.avelength_corp_regulated_ind,le.avelength_corp_renewal_date,le.avelength_corp_standing_other,le.avelength_corp_survivor_corporation_id,le.avelength_corp_tax_base,le.avelength_corp_tax_standing,le.avelength_corp_termination_cd,le.avelength_corp_termination_desc,le.avelength_corp_termination_date,le.avelength_corp_trademark_classification_nbr,le.avelength_corp_trademark_first_use_date,le.avelength_corp_trademark_first_use_date_in_state,le.avelength_corp_trademark_business_mark_type,le.avelength_corp_trademark_cancelled_date,le.avelength_corp_trademark_class_desc1,le.avelength_corp_trademark_class_desc2,le.avelength_corp_trademark_class_desc3,le.avelength_corp_trademark_class_desc4,le.avelength_corp_trademark_class_desc5,le.avelength_corp_trademark_class_desc6,le.avelength_corp_trademark_disclaimer1,le.avelength_corp_trademark_disclaimer2,le.avelength_corp_trademark_expiration_date,le.avelength_corp_trademark_filing_date,le.avelength_corp_trademark_keywords,le.avelength_corp_trademark_logo,le.avelength_corp_trademark_name_expiration_date,le.avelength_corp_trademark_nbr,le.avelength_corp_trademark_renewal_date,le.avelength_corp_trademark_status,le.avelength_corp_trademark_used_1,le.avelength_corp_trademark_used_2,le.avelength_corp_trademark_used_3,le.avelength_cont_owner_percentage,le.avelength_cont_country,le.avelength_cont_country_mailing,le.avelength_cont_nondislosure,le.avelength_cont_prep_addr_line1,le.avelength_cont_prep_addr_last_line,le.avelength_recordorigin);
END;
EXPORT invSummary := NORMALIZE(summary0, 289, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT38.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT38.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT38.StrType)le.corp_key),TRIM((SALT38.StrType)le.corp_supp_key),TRIM((SALT38.StrType)le.corp_vendor),TRIM((SALT38.StrType)le.corp_vendor_county),TRIM((SALT38.StrType)le.corp_vendor_subcode),TRIM((SALT38.StrType)le.corp_state_origin),TRIM((SALT38.StrType)le.corp_process_date),TRIM((SALT38.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT38.StrType)le.corp_legal_name),TRIM((SALT38.StrType)le.corp_ln_name_type_cd),TRIM((SALT38.StrType)le.corp_ln_name_type_desc),TRIM((SALT38.StrType)le.corp_supp_nbr),TRIM((SALT38.StrType)le.corp_name_comment),TRIM((SALT38.StrType)le.corp_address1_type_cd),TRIM((SALT38.StrType)le.corp_address1_type_desc),TRIM((SALT38.StrType)le.corp_address1_line1),TRIM((SALT38.StrType)le.corp_address1_line2),TRIM((SALT38.StrType)le.corp_address1_line3),TRIM((SALT38.StrType)le.corp_address1_effective_date),TRIM((SALT38.StrType)le.corp_address2_type_cd),TRIM((SALT38.StrType)le.corp_address2_type_desc),TRIM((SALT38.StrType)le.corp_address2_line1),TRIM((SALT38.StrType)le.corp_address2_line2),TRIM((SALT38.StrType)le.corp_address2_line3),TRIM((SALT38.StrType)le.corp_address2_effective_date),TRIM((SALT38.StrType)le.corp_phone_number),TRIM((SALT38.StrType)le.corp_phone_number_type_cd),TRIM((SALT38.StrType)le.corp_phone_number_type_desc),TRIM((SALT38.StrType)le.corp_fax_nbr),TRIM((SALT38.StrType)le.corp_email_address),TRIM((SALT38.StrType)le.corp_web_address),TRIM((SALT38.StrType)le.corp_filing_reference_nbr),TRIM((SALT38.StrType)le.corp_filing_date),TRIM((SALT38.StrType)le.corp_filing_cd),TRIM((SALT38.StrType)le.corp_filing_desc),TRIM((SALT38.StrType)le.corp_status_cd),TRIM((SALT38.StrType)le.corp_status_desc),TRIM((SALT38.StrType)le.corp_status_date),TRIM((SALT38.StrType)le.corp_standing),TRIM((SALT38.StrType)le.corp_status_comment),TRIM((SALT38.StrType)le.corp_ticker_symbol),TRIM((SALT38.StrType)le.corp_stock_exchange),TRIM((SALT38.StrType)le.corp_inc_state),TRIM((SALT38.StrType)le.corp_inc_county),TRIM((SALT38.StrType)le.corp_inc_date),TRIM((SALT38.StrType)le.corp_anniversary_month),TRIM((SALT38.StrType)le.corp_fed_tax_id),TRIM((SALT38.StrType)le.corp_state_tax_id),TRIM((SALT38.StrType)le.corp_term_exist_cd),TRIM((SALT38.StrType)le.corp_term_exist_exp),TRIM((SALT38.StrType)le.corp_term_exist_desc),TRIM((SALT38.StrType)le.corp_foreign_domestic_ind),TRIM((SALT38.StrType)le.corp_forgn_state_cd),TRIM((SALT38.StrType)le.corp_forgn_state_desc),TRIM((SALT38.StrType)le.corp_forgn_sos_charter_nbr),TRIM((SALT38.StrType)le.corp_forgn_date),TRIM((SALT38.StrType)le.corp_forgn_fed_tax_id),TRIM((SALT38.StrType)le.corp_forgn_state_tax_id),TRIM((SALT38.StrType)le.corp_forgn_term_exist_cd),TRIM((SALT38.StrType)le.corp_forgn_term_exist_exp),TRIM((SALT38.StrType)le.corp_forgn_term_exist_desc),TRIM((SALT38.StrType)le.corp_orig_org_structure_cd),TRIM((SALT38.StrType)le.corp_orig_org_structure_desc),TRIM((SALT38.StrType)le.corp_for_profit_ind),TRIM((SALT38.StrType)le.corp_public_or_private_ind),TRIM((SALT38.StrType)le.corp_sic_code),TRIM((SALT38.StrType)le.corp_naic_code),TRIM((SALT38.StrType)le.corp_orig_bus_type_cd),TRIM((SALT38.StrType)le.corp_orig_bus_type_desc),TRIM((SALT38.StrType)le.corp_entity_desc),TRIM((SALT38.StrType)le.corp_certificate_nbr),TRIM((SALT38.StrType)le.corp_internal_nbr),TRIM((SALT38.StrType)le.corp_previous_nbr),TRIM((SALT38.StrType)le.corp_microfilm_nbr),TRIM((SALT38.StrType)le.corp_amendments_filed),TRIM((SALT38.StrType)le.corp_acts),TRIM((SALT38.StrType)le.corp_partnership_ind),TRIM((SALT38.StrType)le.corp_mfg_ind),TRIM((SALT38.StrType)le.corp_addl_info),TRIM((SALT38.StrType)le.corp_taxes),TRIM((SALT38.StrType)le.corp_franchise_taxes),TRIM((SALT38.StrType)le.corp_tax_program_cd),TRIM((SALT38.StrType)le.corp_tax_program_desc),TRIM((SALT38.StrType)le.corp_ra_full_name),TRIM((SALT38.StrType)le.corp_ra_fname),TRIM((SALT38.StrType)le.corp_ra_mname),TRIM((SALT38.StrType)le.corp_ra_lname),TRIM((SALT38.StrType)le.corp_ra_suffix),TRIM((SALT38.StrType)le.corp_ra_title_cd),TRIM((SALT38.StrType)le.corp_ra_title_desc),TRIM((SALT38.StrType)le.corp_ra_fein),TRIM((SALT38.StrType)le.corp_ra_ssn),TRIM((SALT38.StrType)le.corp_ra_dob),TRIM((SALT38.StrType)le.corp_ra_effective_date),TRIM((SALT38.StrType)le.corp_ra_resign_date),TRIM((SALT38.StrType)le.corp_ra_no_comp),TRIM((SALT38.StrType)le.corp_ra_no_comp_igs),TRIM((SALT38.StrType)le.corp_ra_addl_info),TRIM((SALT38.StrType)le.corp_ra_address_type_cd),TRIM((SALT38.StrType)le.corp_ra_address_type_desc),TRIM((SALT38.StrType)le.corp_ra_address_line1),TRIM((SALT38.StrType)le.corp_ra_address_line2),TRIM((SALT38.StrType)le.corp_ra_address_line3),TRIM((SALT38.StrType)le.corp_ra_phone_number),TRIM((SALT38.StrType)le.corp_ra_phone_number_type_cd),TRIM((SALT38.StrType)le.corp_ra_phone_number_type_desc),TRIM((SALT38.StrType)le.corp_ra_fax_nbr),TRIM((SALT38.StrType)le.corp_ra_email_address),TRIM((SALT38.StrType)le.corp_ra_web_address),TRIM((SALT38.StrType)le.corp_prep_addr1_line1),TRIM((SALT38.StrType)le.corp_prep_addr1_last_line),TRIM((SALT38.StrType)le.corp_prep_addr2_line1),TRIM((SALT38.StrType)le.corp_prep_addr2_last_line),TRIM((SALT38.StrType)le.ra_prep_addr_line1),TRIM((SALT38.StrType)le.ra_prep_addr_last_line),TRIM((SALT38.StrType)le.cont_filing_reference_nbr),TRIM((SALT38.StrType)le.cont_filing_date),TRIM((SALT38.StrType)le.cont_filing_cd),TRIM((SALT38.StrType)le.cont_filing_desc),TRIM((SALT38.StrType)le.cont_type_cd),TRIM((SALT38.StrType)le.cont_type_desc),TRIM((SALT38.StrType)le.cont_full_name),TRIM((SALT38.StrType)le.cont_fname),TRIM((SALT38.StrType)le.cont_mname),TRIM((SALT38.StrType)le.cont_lname),TRIM((SALT38.StrType)le.cont_suffix),TRIM((SALT38.StrType)le.cont_title1_desc),TRIM((SALT38.StrType)le.cont_title2_desc),TRIM((SALT38.StrType)le.cont_title3_desc),TRIM((SALT38.StrType)le.cont_title4_desc),TRIM((SALT38.StrType)le.cont_title5_desc),TRIM((SALT38.StrType)le.cont_fein),TRIM((SALT38.StrType)le.cont_ssn),TRIM((SALT38.StrType)le.cont_dob),TRIM((SALT38.StrType)le.cont_status_cd),TRIM((SALT38.StrType)le.cont_status_desc),TRIM((SALT38.StrType)le.cont_effective_date),TRIM((SALT38.StrType)le.cont_effective_cd),TRIM((SALT38.StrType)le.cont_effective_desc),TRIM((SALT38.StrType)le.cont_addl_info),TRIM((SALT38.StrType)le.cont_address_type_cd),TRIM((SALT38.StrType)le.cont_address_type_desc),TRIM((SALT38.StrType)le.cont_address_line1),TRIM((SALT38.StrType)le.cont_address_line2),TRIM((SALT38.StrType)le.cont_address_line3),TRIM((SALT38.StrType)le.cont_address_effective_date),TRIM((SALT38.StrType)le.cont_address_county),TRIM((SALT38.StrType)le.cont_phone_number),TRIM((SALT38.StrType)le.cont_phone_number_type_cd),TRIM((SALT38.StrType)le.cont_phone_number_type_desc),TRIM((SALT38.StrType)le.cont_fax_nbr),TRIM((SALT38.StrType)le.cont_email_address),TRIM((SALT38.StrType)le.cont_web_address),TRIM((SALT38.StrType)le.corp_acres),TRIM((SALT38.StrType)le.corp_action),TRIM((SALT38.StrType)le.corp_action_date),TRIM((SALT38.StrType)le.corp_action_employment_security_approval_date),TRIM((SALT38.StrType)le.corp_action_pending_cd),TRIM((SALT38.StrType)le.corp_action_pending_desc),TRIM((SALT38.StrType)le.corp_action_statement_of_intent_date),TRIM((SALT38.StrType)le.corp_action_tax_dept_approval_date),TRIM((SALT38.StrType)le.corp_acts2),TRIM((SALT38.StrType)le.corp_acts3),TRIM((SALT38.StrType)le.corp_additional_principals),TRIM((SALT38.StrType)le.corp_address_office_type),TRIM((SALT38.StrType)le.corp_agent_commercial),TRIM((SALT38.StrType)le.corp_agent_country),TRIM((SALT38.StrType)le.corp_agent_county),TRIM((SALT38.StrType)le.corp_agent_status_cd),TRIM((SALT38.StrType)le.corp_agent_status_desc),TRIM((SALT38.StrType)le.corp_agent_id),TRIM((SALT38.StrType)le.corp_agent_assign_date),TRIM((SALT38.StrType)le.corp_agriculture_flag),TRIM((SALT38.StrType)le.corp_authorized_partners),TRIM((SALT38.StrType)le.corp_comment),TRIM((SALT38.StrType)le.corp_consent_flag_for_protected_name),TRIM((SALT38.StrType)le.corp_converted),TRIM((SALT38.StrType)le.corp_converted_from),TRIM((SALT38.StrType)le.corp_country_of_formation),TRIM((SALT38.StrType)le.corp_date_of_organization_meeting),TRIM((SALT38.StrType)le.corp_delayed_effective_date),TRIM((SALT38.StrType)le.corp_directors_from_to),TRIM((SALT38.StrType)le.corp_dissolved_date),TRIM((SALT38.StrType)le.corp_farm_exemptions),TRIM((SALT38.StrType)le.corp_farm_qual_date),TRIM((SALT38.StrType)le.corp_farm_status_cd),TRIM((SALT38.StrType)le.corp_farm_status_desc),TRIM((SALT38.StrType)le.corp_farm_status_date),TRIM((SALT38.StrType)le.corp_fiscal_year_month),TRIM((SALT38.StrType)le.corp_foreign_fiduciary_capacity_in_state),TRIM((SALT38.StrType)le.corp_governing_statute),TRIM((SALT38.StrType)le.corp_has_members),TRIM((SALT38.StrType)le.corp_has_vested_managers),TRIM((SALT38.StrType)le.corp_home_incorporated_county),TRIM((SALT38.StrType)le.corp_home_state_name),TRIM((SALT38.StrType)le.corp_is_professional),TRIM((SALT38.StrType)le.corp_is_non_profit_irs_approved),TRIM((SALT38.StrType)le.corp_last_renewal_date),TRIM((SALT38.StrType)le.corp_last_renewal_year),TRIM((SALT38.StrType)le.corp_license_type),TRIM((SALT38.StrType)le.corp_llc_managed_ind),TRIM((SALT38.StrType)le.corp_llc_managed_desc),TRIM((SALT38.StrType)le.corp_management_desc),TRIM((SALT38.StrType)le.corp_management_type),TRIM((SALT38.StrType)le.corp_manager_managed),TRIM((SALT38.StrType)le.corp_merged_corporation_id),TRIM((SALT38.StrType)le.corp_merged_fein),TRIM((SALT38.StrType)le.corp_merger_allowed_flag),TRIM((SALT38.StrType)le.corp_merger_date),TRIM((SALT38.StrType)le.corp_merger_desc),TRIM((SALT38.StrType)le.corp_merger_effective_date),TRIM((SALT38.StrType)le.corp_merger_id),TRIM((SALT38.StrType)le.corp_merger_indicator),TRIM((SALT38.StrType)le.corp_merger_name),TRIM((SALT38.StrType)le.corp_merger_type_converted_to_cd),TRIM((SALT38.StrType)le.corp_merger_type_converted_to_desc),TRIM((SALT38.StrType)le.corp_naics_desc),TRIM((SALT38.StrType)le.corp_name_effective_date),TRIM((SALT38.StrType)le.corp_name_reservation_date),TRIM((SALT38.StrType)le.corp_name_reservation_expiration_date),TRIM((SALT38.StrType)le.corp_name_reservation_nbr),TRIM((SALT38.StrType)le.corp_name_reservation_type),TRIM((SALT38.StrType)le.corp_name_status_cd),TRIM((SALT38.StrType)le.corp_name_status_date),TRIM((SALT38.StrType)le.corp_name_status_desc),TRIM((SALT38.StrType)le.corp_non_profit_irs_approved_purpose),TRIM((SALT38.StrType)le.corp_non_profit_solicit_donations),IF (le.corp_nbr_of_amendments <> '0',TRIM((SALT38.StrType)le.corp_nbr_of_amendments), ''),TRIM((SALT38.StrType)le.corp_nbr_of_initial_llc_members),IF (le.corp_nbr_of_partners <> '0',TRIM((SALT38.StrType)le.corp_nbr_of_partners), ''),TRIM((SALT38.StrType)le.corp_operating_agreement),TRIM((SALT38.StrType)le.corp_opt_in_llc_act_desc),TRIM((SALT38.StrType)le.corp_opt_in_llc_act_ind),TRIM((SALT38.StrType)le.corp_organizational_comments),IF (le.corp_partner_contributions_total <> '0',TRIM((SALT38.StrType)le.corp_partner_contributions_total), ''),TRIM((SALT38.StrType)le.corp_partner_terms),TRIM((SALT38.StrType)le.corp_percentage_voters_required_to_approve_amendments),TRIM((SALT38.StrType)le.corp_profession),TRIM((SALT38.StrType)le.corp_province),TRIM((SALT38.StrType)le.corp_public_mutual_corporation),TRIM((SALT38.StrType)le.corp_purpose),TRIM((SALT38.StrType)le.corp_ra_required_flag),TRIM((SALT38.StrType)le.corp_registered_counties),TRIM((SALT38.StrType)le.corp_regulated_ind),TRIM((SALT38.StrType)le.corp_renewal_date),TRIM((SALT38.StrType)le.corp_standing_other),TRIM((SALT38.StrType)le.corp_survivor_corporation_id),TRIM((SALT38.StrType)le.corp_tax_base),TRIM((SALT38.StrType)le.corp_tax_standing),TRIM((SALT38.StrType)le.corp_termination_cd),TRIM((SALT38.StrType)le.corp_termination_desc),TRIM((SALT38.StrType)le.corp_termination_date),TRIM((SALT38.StrType)le.corp_trademark_classification_nbr),TRIM((SALT38.StrType)le.corp_trademark_first_use_date),TRIM((SALT38.StrType)le.corp_trademark_first_use_date_in_state),TRIM((SALT38.StrType)le.corp_trademark_business_mark_type),TRIM((SALT38.StrType)le.corp_trademark_cancelled_date),TRIM((SALT38.StrType)le.corp_trademark_class_desc1),TRIM((SALT38.StrType)le.corp_trademark_class_desc2),TRIM((SALT38.StrType)le.corp_trademark_class_desc3),TRIM((SALT38.StrType)le.corp_trademark_class_desc4),TRIM((SALT38.StrType)le.corp_trademark_class_desc5),TRIM((SALT38.StrType)le.corp_trademark_class_desc6),TRIM((SALT38.StrType)le.corp_trademark_disclaimer1),TRIM((SALT38.StrType)le.corp_trademark_disclaimer2),TRIM((SALT38.StrType)le.corp_trademark_expiration_date),TRIM((SALT38.StrType)le.corp_trademark_filing_date),TRIM((SALT38.StrType)le.corp_trademark_keywords),TRIM((SALT38.StrType)le.corp_trademark_logo),TRIM((SALT38.StrType)le.corp_trademark_name_expiration_date),TRIM((SALT38.StrType)le.corp_trademark_nbr),TRIM((SALT38.StrType)le.corp_trademark_renewal_date),TRIM((SALT38.StrType)le.corp_trademark_status),TRIM((SALT38.StrType)le.corp_trademark_used_1),TRIM((SALT38.StrType)le.corp_trademark_used_2),TRIM((SALT38.StrType)le.corp_trademark_used_3),IF (le.cont_owner_percentage <> 0,TRIM((SALT38.StrType)le.cont_owner_percentage), ''),TRIM((SALT38.StrType)le.cont_country),TRIM((SALT38.StrType)le.cont_country_mailing),TRIM((SALT38.StrType)le.cont_nondislosure),TRIM((SALT38.StrType)le.cont_prep_addr_line1),TRIM((SALT38.StrType)le.cont_prep_addr_last_line),TRIM((SALT38.StrType)le.recordorigin)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,289,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 289);
  SELF.FldNo2 := 1 + (C % 289);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT38.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT38.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT38.StrType)le.corp_key),TRIM((SALT38.StrType)le.corp_supp_key),TRIM((SALT38.StrType)le.corp_vendor),TRIM((SALT38.StrType)le.corp_vendor_county),TRIM((SALT38.StrType)le.corp_vendor_subcode),TRIM((SALT38.StrType)le.corp_state_origin),TRIM((SALT38.StrType)le.corp_process_date),TRIM((SALT38.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT38.StrType)le.corp_legal_name),TRIM((SALT38.StrType)le.corp_ln_name_type_cd),TRIM((SALT38.StrType)le.corp_ln_name_type_desc),TRIM((SALT38.StrType)le.corp_supp_nbr),TRIM((SALT38.StrType)le.corp_name_comment),TRIM((SALT38.StrType)le.corp_address1_type_cd),TRIM((SALT38.StrType)le.corp_address1_type_desc),TRIM((SALT38.StrType)le.corp_address1_line1),TRIM((SALT38.StrType)le.corp_address1_line2),TRIM((SALT38.StrType)le.corp_address1_line3),TRIM((SALT38.StrType)le.corp_address1_effective_date),TRIM((SALT38.StrType)le.corp_address2_type_cd),TRIM((SALT38.StrType)le.corp_address2_type_desc),TRIM((SALT38.StrType)le.corp_address2_line1),TRIM((SALT38.StrType)le.corp_address2_line2),TRIM((SALT38.StrType)le.corp_address2_line3),TRIM((SALT38.StrType)le.corp_address2_effective_date),TRIM((SALT38.StrType)le.corp_phone_number),TRIM((SALT38.StrType)le.corp_phone_number_type_cd),TRIM((SALT38.StrType)le.corp_phone_number_type_desc),TRIM((SALT38.StrType)le.corp_fax_nbr),TRIM((SALT38.StrType)le.corp_email_address),TRIM((SALT38.StrType)le.corp_web_address),TRIM((SALT38.StrType)le.corp_filing_reference_nbr),TRIM((SALT38.StrType)le.corp_filing_date),TRIM((SALT38.StrType)le.corp_filing_cd),TRIM((SALT38.StrType)le.corp_filing_desc),TRIM((SALT38.StrType)le.corp_status_cd),TRIM((SALT38.StrType)le.corp_status_desc),TRIM((SALT38.StrType)le.corp_status_date),TRIM((SALT38.StrType)le.corp_standing),TRIM((SALT38.StrType)le.corp_status_comment),TRIM((SALT38.StrType)le.corp_ticker_symbol),TRIM((SALT38.StrType)le.corp_stock_exchange),TRIM((SALT38.StrType)le.corp_inc_state),TRIM((SALT38.StrType)le.corp_inc_county),TRIM((SALT38.StrType)le.corp_inc_date),TRIM((SALT38.StrType)le.corp_anniversary_month),TRIM((SALT38.StrType)le.corp_fed_tax_id),TRIM((SALT38.StrType)le.corp_state_tax_id),TRIM((SALT38.StrType)le.corp_term_exist_cd),TRIM((SALT38.StrType)le.corp_term_exist_exp),TRIM((SALT38.StrType)le.corp_term_exist_desc),TRIM((SALT38.StrType)le.corp_foreign_domestic_ind),TRIM((SALT38.StrType)le.corp_forgn_state_cd),TRIM((SALT38.StrType)le.corp_forgn_state_desc),TRIM((SALT38.StrType)le.corp_forgn_sos_charter_nbr),TRIM((SALT38.StrType)le.corp_forgn_date),TRIM((SALT38.StrType)le.corp_forgn_fed_tax_id),TRIM((SALT38.StrType)le.corp_forgn_state_tax_id),TRIM((SALT38.StrType)le.corp_forgn_term_exist_cd),TRIM((SALT38.StrType)le.corp_forgn_term_exist_exp),TRIM((SALT38.StrType)le.corp_forgn_term_exist_desc),TRIM((SALT38.StrType)le.corp_orig_org_structure_cd),TRIM((SALT38.StrType)le.corp_orig_org_structure_desc),TRIM((SALT38.StrType)le.corp_for_profit_ind),TRIM((SALT38.StrType)le.corp_public_or_private_ind),TRIM((SALT38.StrType)le.corp_sic_code),TRIM((SALT38.StrType)le.corp_naic_code),TRIM((SALT38.StrType)le.corp_orig_bus_type_cd),TRIM((SALT38.StrType)le.corp_orig_bus_type_desc),TRIM((SALT38.StrType)le.corp_entity_desc),TRIM((SALT38.StrType)le.corp_certificate_nbr),TRIM((SALT38.StrType)le.corp_internal_nbr),TRIM((SALT38.StrType)le.corp_previous_nbr),TRIM((SALT38.StrType)le.corp_microfilm_nbr),TRIM((SALT38.StrType)le.corp_amendments_filed),TRIM((SALT38.StrType)le.corp_acts),TRIM((SALT38.StrType)le.corp_partnership_ind),TRIM((SALT38.StrType)le.corp_mfg_ind),TRIM((SALT38.StrType)le.corp_addl_info),TRIM((SALT38.StrType)le.corp_taxes),TRIM((SALT38.StrType)le.corp_franchise_taxes),TRIM((SALT38.StrType)le.corp_tax_program_cd),TRIM((SALT38.StrType)le.corp_tax_program_desc),TRIM((SALT38.StrType)le.corp_ra_full_name),TRIM((SALT38.StrType)le.corp_ra_fname),TRIM((SALT38.StrType)le.corp_ra_mname),TRIM((SALT38.StrType)le.corp_ra_lname),TRIM((SALT38.StrType)le.corp_ra_suffix),TRIM((SALT38.StrType)le.corp_ra_title_cd),TRIM((SALT38.StrType)le.corp_ra_title_desc),TRIM((SALT38.StrType)le.corp_ra_fein),TRIM((SALT38.StrType)le.corp_ra_ssn),TRIM((SALT38.StrType)le.corp_ra_dob),TRIM((SALT38.StrType)le.corp_ra_effective_date),TRIM((SALT38.StrType)le.corp_ra_resign_date),TRIM((SALT38.StrType)le.corp_ra_no_comp),TRIM((SALT38.StrType)le.corp_ra_no_comp_igs),TRIM((SALT38.StrType)le.corp_ra_addl_info),TRIM((SALT38.StrType)le.corp_ra_address_type_cd),TRIM((SALT38.StrType)le.corp_ra_address_type_desc),TRIM((SALT38.StrType)le.corp_ra_address_line1),TRIM((SALT38.StrType)le.corp_ra_address_line2),TRIM((SALT38.StrType)le.corp_ra_address_line3),TRIM((SALT38.StrType)le.corp_ra_phone_number),TRIM((SALT38.StrType)le.corp_ra_phone_number_type_cd),TRIM((SALT38.StrType)le.corp_ra_phone_number_type_desc),TRIM((SALT38.StrType)le.corp_ra_fax_nbr),TRIM((SALT38.StrType)le.corp_ra_email_address),TRIM((SALT38.StrType)le.corp_ra_web_address),TRIM((SALT38.StrType)le.corp_prep_addr1_line1),TRIM((SALT38.StrType)le.corp_prep_addr1_last_line),TRIM((SALT38.StrType)le.corp_prep_addr2_line1),TRIM((SALT38.StrType)le.corp_prep_addr2_last_line),TRIM((SALT38.StrType)le.ra_prep_addr_line1),TRIM((SALT38.StrType)le.ra_prep_addr_last_line),TRIM((SALT38.StrType)le.cont_filing_reference_nbr),TRIM((SALT38.StrType)le.cont_filing_date),TRIM((SALT38.StrType)le.cont_filing_cd),TRIM((SALT38.StrType)le.cont_filing_desc),TRIM((SALT38.StrType)le.cont_type_cd),TRIM((SALT38.StrType)le.cont_type_desc),TRIM((SALT38.StrType)le.cont_full_name),TRIM((SALT38.StrType)le.cont_fname),TRIM((SALT38.StrType)le.cont_mname),TRIM((SALT38.StrType)le.cont_lname),TRIM((SALT38.StrType)le.cont_suffix),TRIM((SALT38.StrType)le.cont_title1_desc),TRIM((SALT38.StrType)le.cont_title2_desc),TRIM((SALT38.StrType)le.cont_title3_desc),TRIM((SALT38.StrType)le.cont_title4_desc),TRIM((SALT38.StrType)le.cont_title5_desc),TRIM((SALT38.StrType)le.cont_fein),TRIM((SALT38.StrType)le.cont_ssn),TRIM((SALT38.StrType)le.cont_dob),TRIM((SALT38.StrType)le.cont_status_cd),TRIM((SALT38.StrType)le.cont_status_desc),TRIM((SALT38.StrType)le.cont_effective_date),TRIM((SALT38.StrType)le.cont_effective_cd),TRIM((SALT38.StrType)le.cont_effective_desc),TRIM((SALT38.StrType)le.cont_addl_info),TRIM((SALT38.StrType)le.cont_address_type_cd),TRIM((SALT38.StrType)le.cont_address_type_desc),TRIM((SALT38.StrType)le.cont_address_line1),TRIM((SALT38.StrType)le.cont_address_line2),TRIM((SALT38.StrType)le.cont_address_line3),TRIM((SALT38.StrType)le.cont_address_effective_date),TRIM((SALT38.StrType)le.cont_address_county),TRIM((SALT38.StrType)le.cont_phone_number),TRIM((SALT38.StrType)le.cont_phone_number_type_cd),TRIM((SALT38.StrType)le.cont_phone_number_type_desc),TRIM((SALT38.StrType)le.cont_fax_nbr),TRIM((SALT38.StrType)le.cont_email_address),TRIM((SALT38.StrType)le.cont_web_address),TRIM((SALT38.StrType)le.corp_acres),TRIM((SALT38.StrType)le.corp_action),TRIM((SALT38.StrType)le.corp_action_date),TRIM((SALT38.StrType)le.corp_action_employment_security_approval_date),TRIM((SALT38.StrType)le.corp_action_pending_cd),TRIM((SALT38.StrType)le.corp_action_pending_desc),TRIM((SALT38.StrType)le.corp_action_statement_of_intent_date),TRIM((SALT38.StrType)le.corp_action_tax_dept_approval_date),TRIM((SALT38.StrType)le.corp_acts2),TRIM((SALT38.StrType)le.corp_acts3),TRIM((SALT38.StrType)le.corp_additional_principals),TRIM((SALT38.StrType)le.corp_address_office_type),TRIM((SALT38.StrType)le.corp_agent_commercial),TRIM((SALT38.StrType)le.corp_agent_country),TRIM((SALT38.StrType)le.corp_agent_county),TRIM((SALT38.StrType)le.corp_agent_status_cd),TRIM((SALT38.StrType)le.corp_agent_status_desc),TRIM((SALT38.StrType)le.corp_agent_id),TRIM((SALT38.StrType)le.corp_agent_assign_date),TRIM((SALT38.StrType)le.corp_agriculture_flag),TRIM((SALT38.StrType)le.corp_authorized_partners),TRIM((SALT38.StrType)le.corp_comment),TRIM((SALT38.StrType)le.corp_consent_flag_for_protected_name),TRIM((SALT38.StrType)le.corp_converted),TRIM((SALT38.StrType)le.corp_converted_from),TRIM((SALT38.StrType)le.corp_country_of_formation),TRIM((SALT38.StrType)le.corp_date_of_organization_meeting),TRIM((SALT38.StrType)le.corp_delayed_effective_date),TRIM((SALT38.StrType)le.corp_directors_from_to),TRIM((SALT38.StrType)le.corp_dissolved_date),TRIM((SALT38.StrType)le.corp_farm_exemptions),TRIM((SALT38.StrType)le.corp_farm_qual_date),TRIM((SALT38.StrType)le.corp_farm_status_cd),TRIM((SALT38.StrType)le.corp_farm_status_desc),TRIM((SALT38.StrType)le.corp_farm_status_date),TRIM((SALT38.StrType)le.corp_fiscal_year_month),TRIM((SALT38.StrType)le.corp_foreign_fiduciary_capacity_in_state),TRIM((SALT38.StrType)le.corp_governing_statute),TRIM((SALT38.StrType)le.corp_has_members),TRIM((SALT38.StrType)le.corp_has_vested_managers),TRIM((SALT38.StrType)le.corp_home_incorporated_county),TRIM((SALT38.StrType)le.corp_home_state_name),TRIM((SALT38.StrType)le.corp_is_professional),TRIM((SALT38.StrType)le.corp_is_non_profit_irs_approved),TRIM((SALT38.StrType)le.corp_last_renewal_date),TRIM((SALT38.StrType)le.corp_last_renewal_year),TRIM((SALT38.StrType)le.corp_license_type),TRIM((SALT38.StrType)le.corp_llc_managed_ind),TRIM((SALT38.StrType)le.corp_llc_managed_desc),TRIM((SALT38.StrType)le.corp_management_desc),TRIM((SALT38.StrType)le.corp_management_type),TRIM((SALT38.StrType)le.corp_manager_managed),TRIM((SALT38.StrType)le.corp_merged_corporation_id),TRIM((SALT38.StrType)le.corp_merged_fein),TRIM((SALT38.StrType)le.corp_merger_allowed_flag),TRIM((SALT38.StrType)le.corp_merger_date),TRIM((SALT38.StrType)le.corp_merger_desc),TRIM((SALT38.StrType)le.corp_merger_effective_date),TRIM((SALT38.StrType)le.corp_merger_id),TRIM((SALT38.StrType)le.corp_merger_indicator),TRIM((SALT38.StrType)le.corp_merger_name),TRIM((SALT38.StrType)le.corp_merger_type_converted_to_cd),TRIM((SALT38.StrType)le.corp_merger_type_converted_to_desc),TRIM((SALT38.StrType)le.corp_naics_desc),TRIM((SALT38.StrType)le.corp_name_effective_date),TRIM((SALT38.StrType)le.corp_name_reservation_date),TRIM((SALT38.StrType)le.corp_name_reservation_expiration_date),TRIM((SALT38.StrType)le.corp_name_reservation_nbr),TRIM((SALT38.StrType)le.corp_name_reservation_type),TRIM((SALT38.StrType)le.corp_name_status_cd),TRIM((SALT38.StrType)le.corp_name_status_date),TRIM((SALT38.StrType)le.corp_name_status_desc),TRIM((SALT38.StrType)le.corp_non_profit_irs_approved_purpose),TRIM((SALT38.StrType)le.corp_non_profit_solicit_donations),IF (le.corp_nbr_of_amendments <> '0',TRIM((SALT38.StrType)le.corp_nbr_of_amendments), ''),TRIM((SALT38.StrType)le.corp_nbr_of_initial_llc_members),IF (le.corp_nbr_of_partners <> '0',TRIM((SALT38.StrType)le.corp_nbr_of_partners), ''),TRIM((SALT38.StrType)le.corp_operating_agreement),TRIM((SALT38.StrType)le.corp_opt_in_llc_act_desc),TRIM((SALT38.StrType)le.corp_opt_in_llc_act_ind),TRIM((SALT38.StrType)le.corp_organizational_comments),IF (le.corp_partner_contributions_total <> '0',TRIM((SALT38.StrType)le.corp_partner_contributions_total), ''),TRIM((SALT38.StrType)le.corp_partner_terms),TRIM((SALT38.StrType)le.corp_percentage_voters_required_to_approve_amendments),TRIM((SALT38.StrType)le.corp_profession),TRIM((SALT38.StrType)le.corp_province),TRIM((SALT38.StrType)le.corp_public_mutual_corporation),TRIM((SALT38.StrType)le.corp_purpose),TRIM((SALT38.StrType)le.corp_ra_required_flag),TRIM((SALT38.StrType)le.corp_registered_counties),TRIM((SALT38.StrType)le.corp_regulated_ind),TRIM((SALT38.StrType)le.corp_renewal_date),TRIM((SALT38.StrType)le.corp_standing_other),TRIM((SALT38.StrType)le.corp_survivor_corporation_id),TRIM((SALT38.StrType)le.corp_tax_base),TRIM((SALT38.StrType)le.corp_tax_standing),TRIM((SALT38.StrType)le.corp_termination_cd),TRIM((SALT38.StrType)le.corp_termination_desc),TRIM((SALT38.StrType)le.corp_termination_date),TRIM((SALT38.StrType)le.corp_trademark_classification_nbr),TRIM((SALT38.StrType)le.corp_trademark_first_use_date),TRIM((SALT38.StrType)le.corp_trademark_first_use_date_in_state),TRIM((SALT38.StrType)le.corp_trademark_business_mark_type),TRIM((SALT38.StrType)le.corp_trademark_cancelled_date),TRIM((SALT38.StrType)le.corp_trademark_class_desc1),TRIM((SALT38.StrType)le.corp_trademark_class_desc2),TRIM((SALT38.StrType)le.corp_trademark_class_desc3),TRIM((SALT38.StrType)le.corp_trademark_class_desc4),TRIM((SALT38.StrType)le.corp_trademark_class_desc5),TRIM((SALT38.StrType)le.corp_trademark_class_desc6),TRIM((SALT38.StrType)le.corp_trademark_disclaimer1),TRIM((SALT38.StrType)le.corp_trademark_disclaimer2),TRIM((SALT38.StrType)le.corp_trademark_expiration_date),TRIM((SALT38.StrType)le.corp_trademark_filing_date),TRIM((SALT38.StrType)le.corp_trademark_keywords),TRIM((SALT38.StrType)le.corp_trademark_logo),TRIM((SALT38.StrType)le.corp_trademark_name_expiration_date),TRIM((SALT38.StrType)le.corp_trademark_nbr),TRIM((SALT38.StrType)le.corp_trademark_renewal_date),TRIM((SALT38.StrType)le.corp_trademark_status),TRIM((SALT38.StrType)le.corp_trademark_used_1),TRIM((SALT38.StrType)le.corp_trademark_used_2),TRIM((SALT38.StrType)le.corp_trademark_used_3),IF (le.cont_owner_percentage <> 0,TRIM((SALT38.StrType)le.cont_owner_percentage), ''),TRIM((SALT38.StrType)le.cont_country),TRIM((SALT38.StrType)le.cont_country_mailing),TRIM((SALT38.StrType)le.cont_nondislosure),TRIM((SALT38.StrType)le.cont_prep_addr_line1),TRIM((SALT38.StrType)le.cont_prep_addr_last_line),TRIM((SALT38.StrType)le.recordorigin)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_vendor_first_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT38.StrType)le.dt_vendor_last_reported), ''),IF (le.dt_first_seen <> 0,TRIM((SALT38.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT38.StrType)le.dt_last_seen), ''),IF (le.corp_ra_dt_first_seen <> 0,TRIM((SALT38.StrType)le.corp_ra_dt_first_seen), ''),IF (le.corp_ra_dt_last_seen <> 0,TRIM((SALT38.StrType)le.corp_ra_dt_last_seen), ''),TRIM((SALT38.StrType)le.corp_key),TRIM((SALT38.StrType)le.corp_supp_key),TRIM((SALT38.StrType)le.corp_vendor),TRIM((SALT38.StrType)le.corp_vendor_county),TRIM((SALT38.StrType)le.corp_vendor_subcode),TRIM((SALT38.StrType)le.corp_state_origin),TRIM((SALT38.StrType)le.corp_process_date),TRIM((SALT38.StrType)le.corp_orig_sos_charter_nbr),TRIM((SALT38.StrType)le.corp_legal_name),TRIM((SALT38.StrType)le.corp_ln_name_type_cd),TRIM((SALT38.StrType)le.corp_ln_name_type_desc),TRIM((SALT38.StrType)le.corp_supp_nbr),TRIM((SALT38.StrType)le.corp_name_comment),TRIM((SALT38.StrType)le.corp_address1_type_cd),TRIM((SALT38.StrType)le.corp_address1_type_desc),TRIM((SALT38.StrType)le.corp_address1_line1),TRIM((SALT38.StrType)le.corp_address1_line2),TRIM((SALT38.StrType)le.corp_address1_line3),TRIM((SALT38.StrType)le.corp_address1_effective_date),TRIM((SALT38.StrType)le.corp_address2_type_cd),TRIM((SALT38.StrType)le.corp_address2_type_desc),TRIM((SALT38.StrType)le.corp_address2_line1),TRIM((SALT38.StrType)le.corp_address2_line2),TRIM((SALT38.StrType)le.corp_address2_line3),TRIM((SALT38.StrType)le.corp_address2_effective_date),TRIM((SALT38.StrType)le.corp_phone_number),TRIM((SALT38.StrType)le.corp_phone_number_type_cd),TRIM((SALT38.StrType)le.corp_phone_number_type_desc),TRIM((SALT38.StrType)le.corp_fax_nbr),TRIM((SALT38.StrType)le.corp_email_address),TRIM((SALT38.StrType)le.corp_web_address),TRIM((SALT38.StrType)le.corp_filing_reference_nbr),TRIM((SALT38.StrType)le.corp_filing_date),TRIM((SALT38.StrType)le.corp_filing_cd),TRIM((SALT38.StrType)le.corp_filing_desc),TRIM((SALT38.StrType)le.corp_status_cd),TRIM((SALT38.StrType)le.corp_status_desc),TRIM((SALT38.StrType)le.corp_status_date),TRIM((SALT38.StrType)le.corp_standing),TRIM((SALT38.StrType)le.corp_status_comment),TRIM((SALT38.StrType)le.corp_ticker_symbol),TRIM((SALT38.StrType)le.corp_stock_exchange),TRIM((SALT38.StrType)le.corp_inc_state),TRIM((SALT38.StrType)le.corp_inc_county),TRIM((SALT38.StrType)le.corp_inc_date),TRIM((SALT38.StrType)le.corp_anniversary_month),TRIM((SALT38.StrType)le.corp_fed_tax_id),TRIM((SALT38.StrType)le.corp_state_tax_id),TRIM((SALT38.StrType)le.corp_term_exist_cd),TRIM((SALT38.StrType)le.corp_term_exist_exp),TRIM((SALT38.StrType)le.corp_term_exist_desc),TRIM((SALT38.StrType)le.corp_foreign_domestic_ind),TRIM((SALT38.StrType)le.corp_forgn_state_cd),TRIM((SALT38.StrType)le.corp_forgn_state_desc),TRIM((SALT38.StrType)le.corp_forgn_sos_charter_nbr),TRIM((SALT38.StrType)le.corp_forgn_date),TRIM((SALT38.StrType)le.corp_forgn_fed_tax_id),TRIM((SALT38.StrType)le.corp_forgn_state_tax_id),TRIM((SALT38.StrType)le.corp_forgn_term_exist_cd),TRIM((SALT38.StrType)le.corp_forgn_term_exist_exp),TRIM((SALT38.StrType)le.corp_forgn_term_exist_desc),TRIM((SALT38.StrType)le.corp_orig_org_structure_cd),TRIM((SALT38.StrType)le.corp_orig_org_structure_desc),TRIM((SALT38.StrType)le.corp_for_profit_ind),TRIM((SALT38.StrType)le.corp_public_or_private_ind),TRIM((SALT38.StrType)le.corp_sic_code),TRIM((SALT38.StrType)le.corp_naic_code),TRIM((SALT38.StrType)le.corp_orig_bus_type_cd),TRIM((SALT38.StrType)le.corp_orig_bus_type_desc),TRIM((SALT38.StrType)le.corp_entity_desc),TRIM((SALT38.StrType)le.corp_certificate_nbr),TRIM((SALT38.StrType)le.corp_internal_nbr),TRIM((SALT38.StrType)le.corp_previous_nbr),TRIM((SALT38.StrType)le.corp_microfilm_nbr),TRIM((SALT38.StrType)le.corp_amendments_filed),TRIM((SALT38.StrType)le.corp_acts),TRIM((SALT38.StrType)le.corp_partnership_ind),TRIM((SALT38.StrType)le.corp_mfg_ind),TRIM((SALT38.StrType)le.corp_addl_info),TRIM((SALT38.StrType)le.corp_taxes),TRIM((SALT38.StrType)le.corp_franchise_taxes),TRIM((SALT38.StrType)le.corp_tax_program_cd),TRIM((SALT38.StrType)le.corp_tax_program_desc),TRIM((SALT38.StrType)le.corp_ra_full_name),TRIM((SALT38.StrType)le.corp_ra_fname),TRIM((SALT38.StrType)le.corp_ra_mname),TRIM((SALT38.StrType)le.corp_ra_lname),TRIM((SALT38.StrType)le.corp_ra_suffix),TRIM((SALT38.StrType)le.corp_ra_title_cd),TRIM((SALT38.StrType)le.corp_ra_title_desc),TRIM((SALT38.StrType)le.corp_ra_fein),TRIM((SALT38.StrType)le.corp_ra_ssn),TRIM((SALT38.StrType)le.corp_ra_dob),TRIM((SALT38.StrType)le.corp_ra_effective_date),TRIM((SALT38.StrType)le.corp_ra_resign_date),TRIM((SALT38.StrType)le.corp_ra_no_comp),TRIM((SALT38.StrType)le.corp_ra_no_comp_igs),TRIM((SALT38.StrType)le.corp_ra_addl_info),TRIM((SALT38.StrType)le.corp_ra_address_type_cd),TRIM((SALT38.StrType)le.corp_ra_address_type_desc),TRIM((SALT38.StrType)le.corp_ra_address_line1),TRIM((SALT38.StrType)le.corp_ra_address_line2),TRIM((SALT38.StrType)le.corp_ra_address_line3),TRIM((SALT38.StrType)le.corp_ra_phone_number),TRIM((SALT38.StrType)le.corp_ra_phone_number_type_cd),TRIM((SALT38.StrType)le.corp_ra_phone_number_type_desc),TRIM((SALT38.StrType)le.corp_ra_fax_nbr),TRIM((SALT38.StrType)le.corp_ra_email_address),TRIM((SALT38.StrType)le.corp_ra_web_address),TRIM((SALT38.StrType)le.corp_prep_addr1_line1),TRIM((SALT38.StrType)le.corp_prep_addr1_last_line),TRIM((SALT38.StrType)le.corp_prep_addr2_line1),TRIM((SALT38.StrType)le.corp_prep_addr2_last_line),TRIM((SALT38.StrType)le.ra_prep_addr_line1),TRIM((SALT38.StrType)le.ra_prep_addr_last_line),TRIM((SALT38.StrType)le.cont_filing_reference_nbr),TRIM((SALT38.StrType)le.cont_filing_date),TRIM((SALT38.StrType)le.cont_filing_cd),TRIM((SALT38.StrType)le.cont_filing_desc),TRIM((SALT38.StrType)le.cont_type_cd),TRIM((SALT38.StrType)le.cont_type_desc),TRIM((SALT38.StrType)le.cont_full_name),TRIM((SALT38.StrType)le.cont_fname),TRIM((SALT38.StrType)le.cont_mname),TRIM((SALT38.StrType)le.cont_lname),TRIM((SALT38.StrType)le.cont_suffix),TRIM((SALT38.StrType)le.cont_title1_desc),TRIM((SALT38.StrType)le.cont_title2_desc),TRIM((SALT38.StrType)le.cont_title3_desc),TRIM((SALT38.StrType)le.cont_title4_desc),TRIM((SALT38.StrType)le.cont_title5_desc),TRIM((SALT38.StrType)le.cont_fein),TRIM((SALT38.StrType)le.cont_ssn),TRIM((SALT38.StrType)le.cont_dob),TRIM((SALT38.StrType)le.cont_status_cd),TRIM((SALT38.StrType)le.cont_status_desc),TRIM((SALT38.StrType)le.cont_effective_date),TRIM((SALT38.StrType)le.cont_effective_cd),TRIM((SALT38.StrType)le.cont_effective_desc),TRIM((SALT38.StrType)le.cont_addl_info),TRIM((SALT38.StrType)le.cont_address_type_cd),TRIM((SALT38.StrType)le.cont_address_type_desc),TRIM((SALT38.StrType)le.cont_address_line1),TRIM((SALT38.StrType)le.cont_address_line2),TRIM((SALT38.StrType)le.cont_address_line3),TRIM((SALT38.StrType)le.cont_address_effective_date),TRIM((SALT38.StrType)le.cont_address_county),TRIM((SALT38.StrType)le.cont_phone_number),TRIM((SALT38.StrType)le.cont_phone_number_type_cd),TRIM((SALT38.StrType)le.cont_phone_number_type_desc),TRIM((SALT38.StrType)le.cont_fax_nbr),TRIM((SALT38.StrType)le.cont_email_address),TRIM((SALT38.StrType)le.cont_web_address),TRIM((SALT38.StrType)le.corp_acres),TRIM((SALT38.StrType)le.corp_action),TRIM((SALT38.StrType)le.corp_action_date),TRIM((SALT38.StrType)le.corp_action_employment_security_approval_date),TRIM((SALT38.StrType)le.corp_action_pending_cd),TRIM((SALT38.StrType)le.corp_action_pending_desc),TRIM((SALT38.StrType)le.corp_action_statement_of_intent_date),TRIM((SALT38.StrType)le.corp_action_tax_dept_approval_date),TRIM((SALT38.StrType)le.corp_acts2),TRIM((SALT38.StrType)le.corp_acts3),TRIM((SALT38.StrType)le.corp_additional_principals),TRIM((SALT38.StrType)le.corp_address_office_type),TRIM((SALT38.StrType)le.corp_agent_commercial),TRIM((SALT38.StrType)le.corp_agent_country),TRIM((SALT38.StrType)le.corp_agent_county),TRIM((SALT38.StrType)le.corp_agent_status_cd),TRIM((SALT38.StrType)le.corp_agent_status_desc),TRIM((SALT38.StrType)le.corp_agent_id),TRIM((SALT38.StrType)le.corp_agent_assign_date),TRIM((SALT38.StrType)le.corp_agriculture_flag),TRIM((SALT38.StrType)le.corp_authorized_partners),TRIM((SALT38.StrType)le.corp_comment),TRIM((SALT38.StrType)le.corp_consent_flag_for_protected_name),TRIM((SALT38.StrType)le.corp_converted),TRIM((SALT38.StrType)le.corp_converted_from),TRIM((SALT38.StrType)le.corp_country_of_formation),TRIM((SALT38.StrType)le.corp_date_of_organization_meeting),TRIM((SALT38.StrType)le.corp_delayed_effective_date),TRIM((SALT38.StrType)le.corp_directors_from_to),TRIM((SALT38.StrType)le.corp_dissolved_date),TRIM((SALT38.StrType)le.corp_farm_exemptions),TRIM((SALT38.StrType)le.corp_farm_qual_date),TRIM((SALT38.StrType)le.corp_farm_status_cd),TRIM((SALT38.StrType)le.corp_farm_status_desc),TRIM((SALT38.StrType)le.corp_farm_status_date),TRIM((SALT38.StrType)le.corp_fiscal_year_month),TRIM((SALT38.StrType)le.corp_foreign_fiduciary_capacity_in_state),TRIM((SALT38.StrType)le.corp_governing_statute),TRIM((SALT38.StrType)le.corp_has_members),TRIM((SALT38.StrType)le.corp_has_vested_managers),TRIM((SALT38.StrType)le.corp_home_incorporated_county),TRIM((SALT38.StrType)le.corp_home_state_name),TRIM((SALT38.StrType)le.corp_is_professional),TRIM((SALT38.StrType)le.corp_is_non_profit_irs_approved),TRIM((SALT38.StrType)le.corp_last_renewal_date),TRIM((SALT38.StrType)le.corp_last_renewal_year),TRIM((SALT38.StrType)le.corp_license_type),TRIM((SALT38.StrType)le.corp_llc_managed_ind),TRIM((SALT38.StrType)le.corp_llc_managed_desc),TRIM((SALT38.StrType)le.corp_management_desc),TRIM((SALT38.StrType)le.corp_management_type),TRIM((SALT38.StrType)le.corp_manager_managed),TRIM((SALT38.StrType)le.corp_merged_corporation_id),TRIM((SALT38.StrType)le.corp_merged_fein),TRIM((SALT38.StrType)le.corp_merger_allowed_flag),TRIM((SALT38.StrType)le.corp_merger_date),TRIM((SALT38.StrType)le.corp_merger_desc),TRIM((SALT38.StrType)le.corp_merger_effective_date),TRIM((SALT38.StrType)le.corp_merger_id),TRIM((SALT38.StrType)le.corp_merger_indicator),TRIM((SALT38.StrType)le.corp_merger_name),TRIM((SALT38.StrType)le.corp_merger_type_converted_to_cd),TRIM((SALT38.StrType)le.corp_merger_type_converted_to_desc),TRIM((SALT38.StrType)le.corp_naics_desc),TRIM((SALT38.StrType)le.corp_name_effective_date),TRIM((SALT38.StrType)le.corp_name_reservation_date),TRIM((SALT38.StrType)le.corp_name_reservation_expiration_date),TRIM((SALT38.StrType)le.corp_name_reservation_nbr),TRIM((SALT38.StrType)le.corp_name_reservation_type),TRIM((SALT38.StrType)le.corp_name_status_cd),TRIM((SALT38.StrType)le.corp_name_status_date),TRIM((SALT38.StrType)le.corp_name_status_desc),TRIM((SALT38.StrType)le.corp_non_profit_irs_approved_purpose),TRIM((SALT38.StrType)le.corp_non_profit_solicit_donations),IF (le.corp_nbr_of_amendments <> '0',TRIM((SALT38.StrType)le.corp_nbr_of_amendments), ''),TRIM((SALT38.StrType)le.corp_nbr_of_initial_llc_members),IF (le.corp_nbr_of_partners <> '0',TRIM((SALT38.StrType)le.corp_nbr_of_partners), ''),TRIM((SALT38.StrType)le.corp_operating_agreement),TRIM((SALT38.StrType)le.corp_opt_in_llc_act_desc),TRIM((SALT38.StrType)le.corp_opt_in_llc_act_ind),TRIM((SALT38.StrType)le.corp_organizational_comments),IF (le.corp_partner_contributions_total <> '0',TRIM((SALT38.StrType)le.corp_partner_contributions_total), ''),TRIM((SALT38.StrType)le.corp_partner_terms),TRIM((SALT38.StrType)le.corp_percentage_voters_required_to_approve_amendments),TRIM((SALT38.StrType)le.corp_profession),TRIM((SALT38.StrType)le.corp_province),TRIM((SALT38.StrType)le.corp_public_mutual_corporation),TRIM((SALT38.StrType)le.corp_purpose),TRIM((SALT38.StrType)le.corp_ra_required_flag),TRIM((SALT38.StrType)le.corp_registered_counties),TRIM((SALT38.StrType)le.corp_regulated_ind),TRIM((SALT38.StrType)le.corp_renewal_date),TRIM((SALT38.StrType)le.corp_standing_other),TRIM((SALT38.StrType)le.corp_survivor_corporation_id),TRIM((SALT38.StrType)le.corp_tax_base),TRIM((SALT38.StrType)le.corp_tax_standing),TRIM((SALT38.StrType)le.corp_termination_cd),TRIM((SALT38.StrType)le.corp_termination_desc),TRIM((SALT38.StrType)le.corp_termination_date),TRIM((SALT38.StrType)le.corp_trademark_classification_nbr),TRIM((SALT38.StrType)le.corp_trademark_first_use_date),TRIM((SALT38.StrType)le.corp_trademark_first_use_date_in_state),TRIM((SALT38.StrType)le.corp_trademark_business_mark_type),TRIM((SALT38.StrType)le.corp_trademark_cancelled_date),TRIM((SALT38.StrType)le.corp_trademark_class_desc1),TRIM((SALT38.StrType)le.corp_trademark_class_desc2),TRIM((SALT38.StrType)le.corp_trademark_class_desc3),TRIM((SALT38.StrType)le.corp_trademark_class_desc4),TRIM((SALT38.StrType)le.corp_trademark_class_desc5),TRIM((SALT38.StrType)le.corp_trademark_class_desc6),TRIM((SALT38.StrType)le.corp_trademark_disclaimer1),TRIM((SALT38.StrType)le.corp_trademark_disclaimer2),TRIM((SALT38.StrType)le.corp_trademark_expiration_date),TRIM((SALT38.StrType)le.corp_trademark_filing_date),TRIM((SALT38.StrType)le.corp_trademark_keywords),TRIM((SALT38.StrType)le.corp_trademark_logo),TRIM((SALT38.StrType)le.corp_trademark_name_expiration_date),TRIM((SALT38.StrType)le.corp_trademark_nbr),TRIM((SALT38.StrType)le.corp_trademark_renewal_date),TRIM((SALT38.StrType)le.corp_trademark_status),TRIM((SALT38.StrType)le.corp_trademark_used_1),TRIM((SALT38.StrType)le.corp_trademark_used_2),TRIM((SALT38.StrType)le.corp_trademark_used_3),IF (le.cont_owner_percentage <> 0,TRIM((SALT38.StrType)le.cont_owner_percentage), ''),TRIM((SALT38.StrType)le.cont_country),TRIM((SALT38.StrType)le.cont_country_mailing),TRIM((SALT38.StrType)le.cont_nondislosure),TRIM((SALT38.StrType)le.cont_prep_addr_line1),TRIM((SALT38.StrType)le.cont_prep_addr_last_line),TRIM((SALT38.StrType)le.recordorigin)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),289*289,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_vendor_first_reported'}
      ,{2,'dt_vendor_last_reported'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'corp_ra_dt_first_seen'}
      ,{6,'corp_ra_dt_last_seen'}
      ,{7,'corp_key'}
      ,{8,'corp_supp_key'}
      ,{9,'corp_vendor'}
      ,{10,'corp_vendor_county'}
      ,{11,'corp_vendor_subcode'}
      ,{12,'corp_state_origin'}
      ,{13,'corp_process_date'}
      ,{14,'corp_orig_sos_charter_nbr'}
      ,{15,'corp_legal_name'}
      ,{16,'corp_ln_name_type_cd'}
      ,{17,'corp_ln_name_type_desc'}
      ,{18,'corp_supp_nbr'}
      ,{19,'corp_name_comment'}
      ,{20,'corp_address1_type_cd'}
      ,{21,'corp_address1_type_desc'}
      ,{22,'corp_address1_line1'}
      ,{23,'corp_address1_line2'}
      ,{24,'corp_address1_line3'}
      ,{25,'corp_address1_effective_date'}
      ,{26,'corp_address2_type_cd'}
      ,{27,'corp_address2_type_desc'}
      ,{28,'corp_address2_line1'}
      ,{29,'corp_address2_line2'}
      ,{30,'corp_address2_line3'}
      ,{31,'corp_address2_effective_date'}
      ,{32,'corp_phone_number'}
      ,{33,'corp_phone_number_type_cd'}
      ,{34,'corp_phone_number_type_desc'}
      ,{35,'corp_fax_nbr'}
      ,{36,'corp_email_address'}
      ,{37,'corp_web_address'}
      ,{38,'corp_filing_reference_nbr'}
      ,{39,'corp_filing_date'}
      ,{40,'corp_filing_cd'}
      ,{41,'corp_filing_desc'}
      ,{42,'corp_status_cd'}
      ,{43,'corp_status_desc'}
      ,{44,'corp_status_date'}
      ,{45,'corp_standing'}
      ,{46,'corp_status_comment'}
      ,{47,'corp_ticker_symbol'}
      ,{48,'corp_stock_exchange'}
      ,{49,'corp_inc_state'}
      ,{50,'corp_inc_county'}
      ,{51,'corp_inc_date'}
      ,{52,'corp_anniversary_month'}
      ,{53,'corp_fed_tax_id'}
      ,{54,'corp_state_tax_id'}
      ,{55,'corp_term_exist_cd'}
      ,{56,'corp_term_exist_exp'}
      ,{57,'corp_term_exist_desc'}
      ,{58,'corp_foreign_domestic_ind'}
      ,{59,'corp_forgn_state_cd'}
      ,{60,'corp_forgn_state_desc'}
      ,{61,'corp_forgn_sos_charter_nbr'}
      ,{62,'corp_forgn_date'}
      ,{63,'corp_forgn_fed_tax_id'}
      ,{64,'corp_forgn_state_tax_id'}
      ,{65,'corp_forgn_term_exist_cd'}
      ,{66,'corp_forgn_term_exist_exp'}
      ,{67,'corp_forgn_term_exist_desc'}
      ,{68,'corp_orig_org_structure_cd'}
      ,{69,'corp_orig_org_structure_desc'}
      ,{70,'corp_for_profit_ind'}
      ,{71,'corp_public_or_private_ind'}
      ,{72,'corp_sic_code'}
      ,{73,'corp_naic_code'}
      ,{74,'corp_orig_bus_type_cd'}
      ,{75,'corp_orig_bus_type_desc'}
      ,{76,'corp_entity_desc'}
      ,{77,'corp_certificate_nbr'}
      ,{78,'corp_internal_nbr'}
      ,{79,'corp_previous_nbr'}
      ,{80,'corp_microfilm_nbr'}
      ,{81,'corp_amendments_filed'}
      ,{82,'corp_acts'}
      ,{83,'corp_partnership_ind'}
      ,{84,'corp_mfg_ind'}
      ,{85,'corp_addl_info'}
      ,{86,'corp_taxes'}
      ,{87,'corp_franchise_taxes'}
      ,{88,'corp_tax_program_cd'}
      ,{89,'corp_tax_program_desc'}
      ,{90,'corp_ra_full_name'}
      ,{91,'corp_ra_fname'}
      ,{92,'corp_ra_mname'}
      ,{93,'corp_ra_lname'}
      ,{94,'corp_ra_suffix'}
      ,{95,'corp_ra_title_cd'}
      ,{96,'corp_ra_title_desc'}
      ,{97,'corp_ra_fein'}
      ,{98,'corp_ra_ssn'}
      ,{99,'corp_ra_dob'}
      ,{100,'corp_ra_effective_date'}
      ,{101,'corp_ra_resign_date'}
      ,{102,'corp_ra_no_comp'}
      ,{103,'corp_ra_no_comp_igs'}
      ,{104,'corp_ra_addl_info'}
      ,{105,'corp_ra_address_type_cd'}
      ,{106,'corp_ra_address_type_desc'}
      ,{107,'corp_ra_address_line1'}
      ,{108,'corp_ra_address_line2'}
      ,{109,'corp_ra_address_line3'}
      ,{110,'corp_ra_phone_number'}
      ,{111,'corp_ra_phone_number_type_cd'}
      ,{112,'corp_ra_phone_number_type_desc'}
      ,{113,'corp_ra_fax_nbr'}
      ,{114,'corp_ra_email_address'}
      ,{115,'corp_ra_web_address'}
      ,{116,'corp_prep_addr1_line1'}
      ,{117,'corp_prep_addr1_last_line'}
      ,{118,'corp_prep_addr2_line1'}
      ,{119,'corp_prep_addr2_last_line'}
      ,{120,'ra_prep_addr_line1'}
      ,{121,'ra_prep_addr_last_line'}
      ,{122,'cont_filing_reference_nbr'}
      ,{123,'cont_filing_date'}
      ,{124,'cont_filing_cd'}
      ,{125,'cont_filing_desc'}
      ,{126,'cont_type_cd'}
      ,{127,'cont_type_desc'}
      ,{128,'cont_full_name'}
      ,{129,'cont_fname'}
      ,{130,'cont_mname'}
      ,{131,'cont_lname'}
      ,{132,'cont_suffix'}
      ,{133,'cont_title1_desc'}
      ,{134,'cont_title2_desc'}
      ,{135,'cont_title3_desc'}
      ,{136,'cont_title4_desc'}
      ,{137,'cont_title5_desc'}
      ,{138,'cont_fein'}
      ,{139,'cont_ssn'}
      ,{140,'cont_dob'}
      ,{141,'cont_status_cd'}
      ,{142,'cont_status_desc'}
      ,{143,'cont_effective_date'}
      ,{144,'cont_effective_cd'}
      ,{145,'cont_effective_desc'}
      ,{146,'cont_addl_info'}
      ,{147,'cont_address_type_cd'}
      ,{148,'cont_address_type_desc'}
      ,{149,'cont_address_line1'}
      ,{150,'cont_address_line2'}
      ,{151,'cont_address_line3'}
      ,{152,'cont_address_effective_date'}
      ,{153,'cont_address_county'}
      ,{154,'cont_phone_number'}
      ,{155,'cont_phone_number_type_cd'}
      ,{156,'cont_phone_number_type_desc'}
      ,{157,'cont_fax_nbr'}
      ,{158,'cont_email_address'}
      ,{159,'cont_web_address'}
      ,{160,'corp_acres'}
      ,{161,'corp_action'}
      ,{162,'corp_action_date'}
      ,{163,'corp_action_employment_security_approval_date'}
      ,{164,'corp_action_pending_cd'}
      ,{165,'corp_action_pending_desc'}
      ,{166,'corp_action_statement_of_intent_date'}
      ,{167,'corp_action_tax_dept_approval_date'}
      ,{168,'corp_acts2'}
      ,{169,'corp_acts3'}
      ,{170,'corp_additional_principals'}
      ,{171,'corp_address_office_type'}
      ,{172,'corp_agent_commercial'}
      ,{173,'corp_agent_country'}
      ,{174,'corp_agent_county'}
      ,{175,'corp_agent_status_cd'}
      ,{176,'corp_agent_status_desc'}
      ,{177,'corp_agent_id'}
      ,{178,'corp_agent_assign_date'}
      ,{179,'corp_agriculture_flag'}
      ,{180,'corp_authorized_partners'}
      ,{181,'corp_comment'}
      ,{182,'corp_consent_flag_for_protected_name'}
      ,{183,'corp_converted'}
      ,{184,'corp_converted_from'}
      ,{185,'corp_country_of_formation'}
      ,{186,'corp_date_of_organization_meeting'}
      ,{187,'corp_delayed_effective_date'}
      ,{188,'corp_directors_from_to'}
      ,{189,'corp_dissolved_date'}
      ,{190,'corp_farm_exemptions'}
      ,{191,'corp_farm_qual_date'}
      ,{192,'corp_farm_status_cd'}
      ,{193,'corp_farm_status_desc'}
      ,{194,'corp_farm_status_date'}
      ,{195,'corp_fiscal_year_month'}
      ,{196,'corp_foreign_fiduciary_capacity_in_state'}
      ,{197,'corp_governing_statute'}
      ,{198,'corp_has_members'}
      ,{199,'corp_has_vested_managers'}
      ,{200,'corp_home_incorporated_county'}
      ,{201,'corp_home_state_name'}
      ,{202,'corp_is_professional'}
      ,{203,'corp_is_non_profit_irs_approved'}
      ,{204,'corp_last_renewal_date'}
      ,{205,'corp_last_renewal_year'}
      ,{206,'corp_license_type'}
      ,{207,'corp_llc_managed_ind'}
      ,{208,'corp_llc_managed_desc'}
      ,{209,'corp_management_desc'}
      ,{210,'corp_management_type'}
      ,{211,'corp_manager_managed'}
      ,{212,'corp_merged_corporation_id'}
      ,{213,'corp_merged_fein'}
      ,{214,'corp_merger_allowed_flag'}
      ,{215,'corp_merger_date'}
      ,{216,'corp_merger_desc'}
      ,{217,'corp_merger_effective_date'}
      ,{218,'corp_merger_id'}
      ,{219,'corp_merger_indicator'}
      ,{220,'corp_merger_name'}
      ,{221,'corp_merger_type_converted_to_cd'}
      ,{222,'corp_merger_type_converted_to_desc'}
      ,{223,'corp_naics_desc'}
      ,{224,'corp_name_effective_date'}
      ,{225,'corp_name_reservation_date'}
      ,{226,'corp_name_reservation_expiration_date'}
      ,{227,'corp_name_reservation_nbr'}
      ,{228,'corp_name_reservation_type'}
      ,{229,'corp_name_status_cd'}
      ,{230,'corp_name_status_date'}
      ,{231,'corp_name_status_desc'}
      ,{232,'corp_non_profit_irs_approved_purpose'}
      ,{233,'corp_non_profit_solicit_donations'}
      ,{234,'corp_nbr_of_amendments'}
      ,{235,'corp_nbr_of_initial_llc_members'}
      ,{236,'corp_nbr_of_partners'}
      ,{237,'corp_operating_agreement'}
      ,{238,'corp_opt_in_llc_act_desc'}
      ,{239,'corp_opt_in_llc_act_ind'}
      ,{240,'corp_organizational_comments'}
      ,{241,'corp_partner_contributions_total'}
      ,{242,'corp_partner_terms'}
      ,{243,'corp_percentage_voters_required_to_approve_amendments'}
      ,{244,'corp_profession'}
      ,{245,'corp_province'}
      ,{246,'corp_public_mutual_corporation'}
      ,{247,'corp_purpose'}
      ,{248,'corp_ra_required_flag'}
      ,{249,'corp_registered_counties'}
      ,{250,'corp_regulated_ind'}
      ,{251,'corp_renewal_date'}
      ,{252,'corp_standing_other'}
      ,{253,'corp_survivor_corporation_id'}
      ,{254,'corp_tax_base'}
      ,{255,'corp_tax_standing'}
      ,{256,'corp_termination_cd'}
      ,{257,'corp_termination_desc'}
      ,{258,'corp_termination_date'}
      ,{259,'corp_trademark_classification_nbr'}
      ,{260,'corp_trademark_first_use_date'}
      ,{261,'corp_trademark_first_use_date_in_state'}
      ,{262,'corp_trademark_business_mark_type'}
      ,{263,'corp_trademark_cancelled_date'}
      ,{264,'corp_trademark_class_desc1'}
      ,{265,'corp_trademark_class_desc2'}
      ,{266,'corp_trademark_class_desc3'}
      ,{267,'corp_trademark_class_desc4'}
      ,{268,'corp_trademark_class_desc5'}
      ,{269,'corp_trademark_class_desc6'}
      ,{270,'corp_trademark_disclaimer1'}
      ,{271,'corp_trademark_disclaimer2'}
      ,{272,'corp_trademark_expiration_date'}
      ,{273,'corp_trademark_filing_date'}
      ,{274,'corp_trademark_keywords'}
      ,{275,'corp_trademark_logo'}
      ,{276,'corp_trademark_name_expiration_date'}
      ,{277,'corp_trademark_nbr'}
      ,{278,'corp_trademark_renewal_date'}
      ,{279,'corp_trademark_status'}
      ,{280,'corp_trademark_used_1'}
      ,{281,'corp_trademark_used_2'}
      ,{282,'corp_trademark_used_3'}
      ,{283,'cont_owner_percentage'}
      ,{284,'cont_country'}
      ,{285,'cont_country_mailing'}
      ,{286,'cont_nondislosure'}
      ,{287,'cont_prep_addr_line1'}
      ,{288,'cont_prep_addr_last_line'}
      ,{289,'recordorigin'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_first_seen((SALT38.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT38.StrType)le.dt_last_seen),
    Fields.InValid_corp_ra_dt_first_seen((SALT38.StrType)le.corp_ra_dt_first_seen),
    Fields.InValid_corp_ra_dt_last_seen((SALT38.StrType)le.corp_ra_dt_last_seen),
    Fields.InValid_corp_key((SALT38.StrType)le.corp_key),
    Fields.InValid_corp_supp_key((SALT38.StrType)le.corp_supp_key),
    Fields.InValid_corp_vendor((SALT38.StrType)le.corp_vendor),
    Fields.InValid_corp_vendor_county((SALT38.StrType)le.corp_vendor_county),
    Fields.InValid_corp_vendor_subcode((SALT38.StrType)le.corp_vendor_subcode),
    Fields.InValid_corp_state_origin((SALT38.StrType)le.corp_state_origin),
    Fields.InValid_corp_process_date((SALT38.StrType)le.corp_process_date),
    Fields.InValid_corp_orig_sos_charter_nbr((SALT38.StrType)le.corp_orig_sos_charter_nbr),
    Fields.InValid_corp_legal_name((SALT38.StrType)le.corp_legal_name),
    Fields.InValid_corp_ln_name_type_cd((SALT38.StrType)le.corp_ln_name_type_cd,(SALT38.StrType)le.recordorigin),
    Fields.InValid_corp_ln_name_type_desc((SALT38.StrType)le.corp_ln_name_type_desc,(SALT38.StrType)le.recordorigin),
    Fields.InValid_corp_supp_nbr((SALT38.StrType)le.corp_supp_nbr),
    Fields.InValid_corp_name_comment((SALT38.StrType)le.corp_name_comment),
    Fields.InValid_corp_address1_type_cd((SALT38.StrType)le.corp_address1_type_cd),
    Fields.InValid_corp_address1_type_desc((SALT38.StrType)le.corp_address1_type_desc),
    Fields.InValid_corp_address1_line1((SALT38.StrType)le.corp_address1_line1),
    Fields.InValid_corp_address1_line2((SALT38.StrType)le.corp_address1_line2),
    Fields.InValid_corp_address1_line3((SALT38.StrType)le.corp_address1_line3),
    Fields.InValid_corp_address1_effective_date((SALT38.StrType)le.corp_address1_effective_date),
    Fields.InValid_corp_address2_type_cd((SALT38.StrType)le.corp_address2_type_cd),
    Fields.InValid_corp_address2_type_desc((SALT38.StrType)le.corp_address2_type_desc),
    Fields.InValid_corp_address2_line1((SALT38.StrType)le.corp_address2_line1),
    Fields.InValid_corp_address2_line2((SALT38.StrType)le.corp_address2_line2),
    Fields.InValid_corp_address2_line3((SALT38.StrType)le.corp_address2_line3),
    Fields.InValid_corp_address2_effective_date((SALT38.StrType)le.corp_address2_effective_date),
    Fields.InValid_corp_phone_number((SALT38.StrType)le.corp_phone_number),
    Fields.InValid_corp_phone_number_type_cd((SALT38.StrType)le.corp_phone_number_type_cd),
    Fields.InValid_corp_phone_number_type_desc((SALT38.StrType)le.corp_phone_number_type_desc),
    Fields.InValid_corp_fax_nbr((SALT38.StrType)le.corp_fax_nbr),
    Fields.InValid_corp_email_address((SALT38.StrType)le.corp_email_address),
    Fields.InValid_corp_web_address((SALT38.StrType)le.corp_web_address),
    Fields.InValid_corp_filing_reference_nbr((SALT38.StrType)le.corp_filing_reference_nbr),
    Fields.InValid_corp_filing_date((SALT38.StrType)le.corp_filing_date),
    Fields.InValid_corp_filing_cd((SALT38.StrType)le.corp_filing_cd),
    Fields.InValid_corp_filing_desc((SALT38.StrType)le.corp_filing_desc),
    Fields.InValid_corp_status_cd((SALT38.StrType)le.corp_status_cd),
    Fields.InValid_corp_status_desc((SALT38.StrType)le.corp_status_desc),
    Fields.InValid_corp_status_date((SALT38.StrType)le.corp_status_date),
    Fields.InValid_corp_standing((SALT38.StrType)le.corp_standing),
    Fields.InValid_corp_status_comment((SALT38.StrType)le.corp_status_comment),
    Fields.InValid_corp_ticker_symbol((SALT38.StrType)le.corp_ticker_symbol),
    Fields.InValid_corp_stock_exchange((SALT38.StrType)le.corp_stock_exchange),
    Fields.InValid_corp_inc_state((SALT38.StrType)le.corp_inc_state),
    Fields.InValid_corp_inc_county((SALT38.StrType)le.corp_inc_county),
    Fields.InValid_corp_inc_date((SALT38.StrType)le.corp_inc_date),
    Fields.InValid_corp_anniversary_month((SALT38.StrType)le.corp_anniversary_month),
    Fields.InValid_corp_fed_tax_id((SALT38.StrType)le.corp_fed_tax_id),
    Fields.InValid_corp_state_tax_id((SALT38.StrType)le.corp_state_tax_id),
    Fields.InValid_corp_term_exist_cd((SALT38.StrType)le.corp_term_exist_cd),
    Fields.InValid_corp_term_exist_exp((SALT38.StrType)le.corp_term_exist_exp),
    Fields.InValid_corp_term_exist_desc((SALT38.StrType)le.corp_term_exist_desc),
    Fields.InValid_corp_foreign_domestic_ind((SALT38.StrType)le.corp_foreign_domestic_ind),
    Fields.InValid_corp_forgn_state_cd((SALT38.StrType)le.corp_forgn_state_cd),
    Fields.InValid_corp_forgn_state_desc((SALT38.StrType)le.corp_forgn_state_desc),
    Fields.InValid_corp_forgn_sos_charter_nbr((SALT38.StrType)le.corp_forgn_sos_charter_nbr),
    Fields.InValid_corp_forgn_date((SALT38.StrType)le.corp_forgn_date),
    Fields.InValid_corp_forgn_fed_tax_id((SALT38.StrType)le.corp_forgn_fed_tax_id),
    Fields.InValid_corp_forgn_state_tax_id((SALT38.StrType)le.corp_forgn_state_tax_id),
    Fields.InValid_corp_forgn_term_exist_cd((SALT38.StrType)le.corp_forgn_term_exist_cd),
    Fields.InValid_corp_forgn_term_exist_exp((SALT38.StrType)le.corp_forgn_term_exist_exp),
    Fields.InValid_corp_forgn_term_exist_desc((SALT38.StrType)le.corp_forgn_term_exist_desc),
    Fields.InValid_corp_orig_org_structure_cd((SALT38.StrType)le.corp_orig_org_structure_cd),
    Fields.InValid_corp_orig_org_structure_desc((SALT38.StrType)le.corp_orig_org_structure_desc),
    Fields.InValid_corp_for_profit_ind((SALT38.StrType)le.corp_for_profit_ind),
    Fields.InValid_corp_public_or_private_ind((SALT38.StrType)le.corp_public_or_private_ind),
    Fields.InValid_corp_sic_code((SALT38.StrType)le.corp_sic_code),
    Fields.InValid_corp_naic_code((SALT38.StrType)le.corp_naic_code),
    Fields.InValid_corp_orig_bus_type_cd((SALT38.StrType)le.corp_orig_bus_type_cd),
    Fields.InValid_corp_orig_bus_type_desc((SALT38.StrType)le.corp_orig_bus_type_desc),
    Fields.InValid_corp_entity_desc((SALT38.StrType)le.corp_entity_desc),
    Fields.InValid_corp_certificate_nbr((SALT38.StrType)le.corp_certificate_nbr),
    Fields.InValid_corp_internal_nbr((SALT38.StrType)le.corp_internal_nbr),
    Fields.InValid_corp_previous_nbr((SALT38.StrType)le.corp_previous_nbr),
    Fields.InValid_corp_microfilm_nbr((SALT38.StrType)le.corp_microfilm_nbr),
    Fields.InValid_corp_amendments_filed((SALT38.StrType)le.corp_amendments_filed),
    Fields.InValid_corp_acts((SALT38.StrType)le.corp_acts),
    Fields.InValid_corp_partnership_ind((SALT38.StrType)le.corp_partnership_ind),
    Fields.InValid_corp_mfg_ind((SALT38.StrType)le.corp_mfg_ind),
    Fields.InValid_corp_addl_info((SALT38.StrType)le.corp_addl_info),
    Fields.InValid_corp_taxes((SALT38.StrType)le.corp_taxes),
    Fields.InValid_corp_franchise_taxes((SALT38.StrType)le.corp_franchise_taxes),
    Fields.InValid_corp_tax_program_cd((SALT38.StrType)le.corp_tax_program_cd),
    Fields.InValid_corp_tax_program_desc((SALT38.StrType)le.corp_tax_program_desc),
    Fields.InValid_corp_ra_full_name((SALT38.StrType)le.corp_ra_full_name),
    Fields.InValid_corp_ra_fname((SALT38.StrType)le.corp_ra_fname),
    Fields.InValid_corp_ra_mname((SALT38.StrType)le.corp_ra_mname),
    Fields.InValid_corp_ra_lname((SALT38.StrType)le.corp_ra_lname),
    Fields.InValid_corp_ra_suffix((SALT38.StrType)le.corp_ra_suffix),
    Fields.InValid_corp_ra_title_cd((SALT38.StrType)le.corp_ra_title_cd),
    Fields.InValid_corp_ra_title_desc((SALT38.StrType)le.corp_ra_title_desc),
    Fields.InValid_corp_ra_fein((SALT38.StrType)le.corp_ra_fein),
    Fields.InValid_corp_ra_ssn((SALT38.StrType)le.corp_ra_ssn),
    Fields.InValid_corp_ra_dob((SALT38.StrType)le.corp_ra_dob),
    Fields.InValid_corp_ra_effective_date((SALT38.StrType)le.corp_ra_effective_date),
    Fields.InValid_corp_ra_resign_date((SALT38.StrType)le.corp_ra_resign_date),
    Fields.InValid_corp_ra_no_comp((SALT38.StrType)le.corp_ra_no_comp),
    Fields.InValid_corp_ra_no_comp_igs((SALT38.StrType)le.corp_ra_no_comp_igs),
    Fields.InValid_corp_ra_addl_info((SALT38.StrType)le.corp_ra_addl_info),
    Fields.InValid_corp_ra_address_type_cd((SALT38.StrType)le.corp_ra_address_type_cd),
    Fields.InValid_corp_ra_address_type_desc((SALT38.StrType)le.corp_ra_address_type_desc),
    Fields.InValid_corp_ra_address_line1((SALT38.StrType)le.corp_ra_address_line1),
    Fields.InValid_corp_ra_address_line2((SALT38.StrType)le.corp_ra_address_line2),
    Fields.InValid_corp_ra_address_line3((SALT38.StrType)le.corp_ra_address_line3),
    Fields.InValid_corp_ra_phone_number((SALT38.StrType)le.corp_ra_phone_number),
    Fields.InValid_corp_ra_phone_number_type_cd((SALT38.StrType)le.corp_ra_phone_number_type_cd),
    Fields.InValid_corp_ra_phone_number_type_desc((SALT38.StrType)le.corp_ra_phone_number_type_desc),
    Fields.InValid_corp_ra_fax_nbr((SALT38.StrType)le.corp_ra_fax_nbr),
    Fields.InValid_corp_ra_email_address((SALT38.StrType)le.corp_ra_email_address),
    Fields.InValid_corp_ra_web_address((SALT38.StrType)le.corp_ra_web_address),
    Fields.InValid_corp_prep_addr1_line1((SALT38.StrType)le.corp_prep_addr1_line1),
    Fields.InValid_corp_prep_addr1_last_line((SALT38.StrType)le.corp_prep_addr1_last_line),
    Fields.InValid_corp_prep_addr2_line1((SALT38.StrType)le.corp_prep_addr2_line1),
    Fields.InValid_corp_prep_addr2_last_line((SALT38.StrType)le.corp_prep_addr2_last_line),
    Fields.InValid_ra_prep_addr_line1((SALT38.StrType)le.ra_prep_addr_line1),
    Fields.InValid_ra_prep_addr_last_line((SALT38.StrType)le.ra_prep_addr_last_line),
    Fields.InValid_cont_filing_reference_nbr((SALT38.StrType)le.cont_filing_reference_nbr),
    Fields.InValid_cont_filing_date((SALT38.StrType)le.cont_filing_date),
    Fields.InValid_cont_filing_cd((SALT38.StrType)le.cont_filing_cd),
    Fields.InValid_cont_filing_desc((SALT38.StrType)le.cont_filing_desc),
    Fields.InValid_cont_type_cd((SALT38.StrType)le.cont_type_cd),
    Fields.InValid_cont_type_desc((SALT38.StrType)le.cont_type_desc),
    Fields.InValid_cont_full_name((SALT38.StrType)le.cont_full_name),
    Fields.InValid_cont_fname((SALT38.StrType)le.cont_fname),
    Fields.InValid_cont_mname((SALT38.StrType)le.cont_mname),
    Fields.InValid_cont_lname((SALT38.StrType)le.cont_lname),
    Fields.InValid_cont_suffix((SALT38.StrType)le.cont_suffix),
    Fields.InValid_cont_title1_desc((SALT38.StrType)le.cont_title1_desc),
    Fields.InValid_cont_title2_desc((SALT38.StrType)le.cont_title2_desc),
    Fields.InValid_cont_title3_desc((SALT38.StrType)le.cont_title3_desc),
    Fields.InValid_cont_title4_desc((SALT38.StrType)le.cont_title4_desc),
    Fields.InValid_cont_title5_desc((SALT38.StrType)le.cont_title5_desc),
    Fields.InValid_cont_fein((SALT38.StrType)le.cont_fein),
    Fields.InValid_cont_ssn((SALT38.StrType)le.cont_ssn),
    Fields.InValid_cont_dob((SALT38.StrType)le.cont_dob),
    Fields.InValid_cont_status_cd((SALT38.StrType)le.cont_status_cd),
    Fields.InValid_cont_status_desc((SALT38.StrType)le.cont_status_desc),
    Fields.InValid_cont_effective_date((SALT38.StrType)le.cont_effective_date),
    Fields.InValid_cont_effective_cd((SALT38.StrType)le.cont_effective_cd),
    Fields.InValid_cont_effective_desc((SALT38.StrType)le.cont_effective_desc),
    Fields.InValid_cont_addl_info((SALT38.StrType)le.cont_addl_info),
    Fields.InValid_cont_address_type_cd((SALT38.StrType)le.cont_address_type_cd),
    Fields.InValid_cont_address_type_desc((SALT38.StrType)le.cont_address_type_desc),
    Fields.InValid_cont_address_line1((SALT38.StrType)le.cont_address_line1),
    Fields.InValid_cont_address_line2((SALT38.StrType)le.cont_address_line2),
    Fields.InValid_cont_address_line3((SALT38.StrType)le.cont_address_line3),
    Fields.InValid_cont_address_effective_date((SALT38.StrType)le.cont_address_effective_date),
    Fields.InValid_cont_address_county((SALT38.StrType)le.cont_address_county),
    Fields.InValid_cont_phone_number((SALT38.StrType)le.cont_phone_number),
    Fields.InValid_cont_phone_number_type_cd((SALT38.StrType)le.cont_phone_number_type_cd),
    Fields.InValid_cont_phone_number_type_desc((SALT38.StrType)le.cont_phone_number_type_desc),
    Fields.InValid_cont_fax_nbr((SALT38.StrType)le.cont_fax_nbr),
    Fields.InValid_cont_email_address((SALT38.StrType)le.cont_email_address),
    Fields.InValid_cont_web_address((SALT38.StrType)le.cont_web_address),
    Fields.InValid_corp_acres((SALT38.StrType)le.corp_acres),
    Fields.InValid_corp_action((SALT38.StrType)le.corp_action),
    Fields.InValid_corp_action_date((SALT38.StrType)le.corp_action_date),
    Fields.InValid_corp_action_employment_security_approval_date((SALT38.StrType)le.corp_action_employment_security_approval_date),
    Fields.InValid_corp_action_pending_cd((SALT38.StrType)le.corp_action_pending_cd),
    Fields.InValid_corp_action_pending_desc((SALT38.StrType)le.corp_action_pending_desc),
    Fields.InValid_corp_action_statement_of_intent_date((SALT38.StrType)le.corp_action_statement_of_intent_date),
    Fields.InValid_corp_action_tax_dept_approval_date((SALT38.StrType)le.corp_action_tax_dept_approval_date),
    Fields.InValid_corp_acts2((SALT38.StrType)le.corp_acts2),
    Fields.InValid_corp_acts3((SALT38.StrType)le.corp_acts3),
    Fields.InValid_corp_additional_principals((SALT38.StrType)le.corp_additional_principals),
    Fields.InValid_corp_address_office_type((SALT38.StrType)le.corp_address_office_type),
    Fields.InValid_corp_agent_commercial((SALT38.StrType)le.corp_agent_commercial),
    Fields.InValid_corp_agent_country((SALT38.StrType)le.corp_agent_country),
    Fields.InValid_corp_agent_county((SALT38.StrType)le.corp_agent_county),
    Fields.InValid_corp_agent_status_cd((SALT38.StrType)le.corp_agent_status_cd),
    Fields.InValid_corp_agent_status_desc((SALT38.StrType)le.corp_agent_status_desc),
    Fields.InValid_corp_agent_id((SALT38.StrType)le.corp_agent_id),
    Fields.InValid_corp_agent_assign_date((SALT38.StrType)le.corp_agent_assign_date),
    Fields.InValid_corp_agriculture_flag((SALT38.StrType)le.corp_agriculture_flag),
    Fields.InValid_corp_authorized_partners((SALT38.StrType)le.corp_authorized_partners),
    Fields.InValid_corp_comment((SALT38.StrType)le.corp_comment),
    Fields.InValid_corp_consent_flag_for_protected_name((SALT38.StrType)le.corp_consent_flag_for_protected_name),
    Fields.InValid_corp_converted((SALT38.StrType)le.corp_converted),
    Fields.InValid_corp_converted_from((SALT38.StrType)le.corp_converted_from),
    Fields.InValid_corp_country_of_formation((SALT38.StrType)le.corp_country_of_formation),
    Fields.InValid_corp_date_of_organization_meeting((SALT38.StrType)le.corp_date_of_organization_meeting),
    Fields.InValid_corp_delayed_effective_date((SALT38.StrType)le.corp_delayed_effective_date),
    Fields.InValid_corp_directors_from_to((SALT38.StrType)le.corp_directors_from_to),
    Fields.InValid_corp_dissolved_date((SALT38.StrType)le.corp_dissolved_date),
    Fields.InValid_corp_farm_exemptions((SALT38.StrType)le.corp_farm_exemptions),
    Fields.InValid_corp_farm_qual_date((SALT38.StrType)le.corp_farm_qual_date),
    Fields.InValid_corp_farm_status_cd((SALT38.StrType)le.corp_farm_status_cd),
    Fields.InValid_corp_farm_status_desc((SALT38.StrType)le.corp_farm_status_desc),
    Fields.InValid_corp_farm_status_date((SALT38.StrType)le.corp_farm_status_date),
    Fields.InValid_corp_fiscal_year_month((SALT38.StrType)le.corp_fiscal_year_month),
    Fields.InValid_corp_foreign_fiduciary_capacity_in_state((SALT38.StrType)le.corp_foreign_fiduciary_capacity_in_state),
    Fields.InValid_corp_governing_statute((SALT38.StrType)le.corp_governing_statute),
    Fields.InValid_corp_has_members((SALT38.StrType)le.corp_has_members),
    Fields.InValid_corp_has_vested_managers((SALT38.StrType)le.corp_has_vested_managers),
    Fields.InValid_corp_home_incorporated_county((SALT38.StrType)le.corp_home_incorporated_county),
    Fields.InValid_corp_home_state_name((SALT38.StrType)le.corp_home_state_name),
    Fields.InValid_corp_is_professional((SALT38.StrType)le.corp_is_professional),
    Fields.InValid_corp_is_non_profit_irs_approved((SALT38.StrType)le.corp_is_non_profit_irs_approved),
    Fields.InValid_corp_last_renewal_date((SALT38.StrType)le.corp_last_renewal_date),
    Fields.InValid_corp_last_renewal_year((SALT38.StrType)le.corp_last_renewal_year),
    Fields.InValid_corp_license_type((SALT38.StrType)le.corp_license_type),
    Fields.InValid_corp_llc_managed_ind((SALT38.StrType)le.corp_llc_managed_ind),
    Fields.InValid_corp_llc_managed_desc((SALT38.StrType)le.corp_llc_managed_desc),
    Fields.InValid_corp_management_desc((SALT38.StrType)le.corp_management_desc),
    Fields.InValid_corp_management_type((SALT38.StrType)le.corp_management_type),
    Fields.InValid_corp_manager_managed((SALT38.StrType)le.corp_manager_managed),
    Fields.InValid_corp_merged_corporation_id((SALT38.StrType)le.corp_merged_corporation_id),
    Fields.InValid_corp_merged_fein((SALT38.StrType)le.corp_merged_fein),
    Fields.InValid_corp_merger_allowed_flag((SALT38.StrType)le.corp_merger_allowed_flag),
    Fields.InValid_corp_merger_date((SALT38.StrType)le.corp_merger_date),
    Fields.InValid_corp_merger_desc((SALT38.StrType)le.corp_merger_desc),
    Fields.InValid_corp_merger_effective_date((SALT38.StrType)le.corp_merger_effective_date),
    Fields.InValid_corp_merger_id((SALT38.StrType)le.corp_merger_id),
    Fields.InValid_corp_merger_indicator((SALT38.StrType)le.corp_merger_indicator),
    Fields.InValid_corp_merger_name((SALT38.StrType)le.corp_merger_name),
    Fields.InValid_corp_merger_type_converted_to_cd((SALT38.StrType)le.corp_merger_type_converted_to_cd),
    Fields.InValid_corp_merger_type_converted_to_desc((SALT38.StrType)le.corp_merger_type_converted_to_desc),
    Fields.InValid_corp_naics_desc((SALT38.StrType)le.corp_naics_desc),
    Fields.InValid_corp_name_effective_date((SALT38.StrType)le.corp_name_effective_date),
    Fields.InValid_corp_name_reservation_date((SALT38.StrType)le.corp_name_reservation_date),
    Fields.InValid_corp_name_reservation_expiration_date((SALT38.StrType)le.corp_name_reservation_expiration_date),
    Fields.InValid_corp_name_reservation_nbr((SALT38.StrType)le.corp_name_reservation_nbr),
    Fields.InValid_corp_name_reservation_type((SALT38.StrType)le.corp_name_reservation_type),
    Fields.InValid_corp_name_status_cd((SALT38.StrType)le.corp_name_status_cd),
    Fields.InValid_corp_name_status_date((SALT38.StrType)le.corp_name_status_date),
    Fields.InValid_corp_name_status_desc((SALT38.StrType)le.corp_name_status_desc),
    Fields.InValid_corp_non_profit_irs_approved_purpose((SALT38.StrType)le.corp_non_profit_irs_approved_purpose),
    Fields.InValid_corp_non_profit_solicit_donations((SALT38.StrType)le.corp_non_profit_solicit_donations),
    Fields.InValid_corp_nbr_of_amendments((SALT38.StrType)le.corp_nbr_of_amendments),
    Fields.InValid_corp_nbr_of_initial_llc_members((SALT38.StrType)le.corp_nbr_of_initial_llc_members),
    Fields.InValid_corp_nbr_of_partners((SALT38.StrType)le.corp_nbr_of_partners),
    Fields.InValid_corp_operating_agreement((SALT38.StrType)le.corp_operating_agreement),
    Fields.InValid_corp_opt_in_llc_act_desc((SALT38.StrType)le.corp_opt_in_llc_act_desc),
    Fields.InValid_corp_opt_in_llc_act_ind((SALT38.StrType)le.corp_opt_in_llc_act_ind),
    Fields.InValid_corp_organizational_comments((SALT38.StrType)le.corp_organizational_comments),
    Fields.InValid_corp_partner_contributions_total((SALT38.StrType)le.corp_partner_contributions_total),
    Fields.InValid_corp_partner_terms((SALT38.StrType)le.corp_partner_terms),
    Fields.InValid_corp_percentage_voters_required_to_approve_amendments((SALT38.StrType)le.corp_percentage_voters_required_to_approve_amendments),
    Fields.InValid_corp_profession((SALT38.StrType)le.corp_profession),
    Fields.InValid_corp_province((SALT38.StrType)le.corp_province),
    Fields.InValid_corp_public_mutual_corporation((SALT38.StrType)le.corp_public_mutual_corporation),
    Fields.InValid_corp_purpose((SALT38.StrType)le.corp_purpose),
    Fields.InValid_corp_ra_required_flag((SALT38.StrType)le.corp_ra_required_flag),
    Fields.InValid_corp_registered_counties((SALT38.StrType)le.corp_registered_counties),
    Fields.InValid_corp_regulated_ind((SALT38.StrType)le.corp_regulated_ind),
    Fields.InValid_corp_renewal_date((SALT38.StrType)le.corp_renewal_date),
    Fields.InValid_corp_standing_other((SALT38.StrType)le.corp_standing_other),
    Fields.InValid_corp_survivor_corporation_id((SALT38.StrType)le.corp_survivor_corporation_id),
    Fields.InValid_corp_tax_base((SALT38.StrType)le.corp_tax_base),
    Fields.InValid_corp_tax_standing((SALT38.StrType)le.corp_tax_standing),
    Fields.InValid_corp_termination_cd((SALT38.StrType)le.corp_termination_cd),
    Fields.InValid_corp_termination_desc((SALT38.StrType)le.corp_termination_desc),
    Fields.InValid_corp_termination_date((SALT38.StrType)le.corp_termination_date),
    Fields.InValid_corp_trademark_classification_nbr((SALT38.StrType)le.corp_trademark_classification_nbr),
    Fields.InValid_corp_trademark_first_use_date((SALT38.StrType)le.corp_trademark_first_use_date),
    Fields.InValid_corp_trademark_first_use_date_in_state((SALT38.StrType)le.corp_trademark_first_use_date_in_state),
    Fields.InValid_corp_trademark_business_mark_type((SALT38.StrType)le.corp_trademark_business_mark_type),
    Fields.InValid_corp_trademark_cancelled_date((SALT38.StrType)le.corp_trademark_cancelled_date),
    Fields.InValid_corp_trademark_class_desc1((SALT38.StrType)le.corp_trademark_class_desc1),
    Fields.InValid_corp_trademark_class_desc2((SALT38.StrType)le.corp_trademark_class_desc2),
    Fields.InValid_corp_trademark_class_desc3((SALT38.StrType)le.corp_trademark_class_desc3),
    Fields.InValid_corp_trademark_class_desc4((SALT38.StrType)le.corp_trademark_class_desc4),
    Fields.InValid_corp_trademark_class_desc5((SALT38.StrType)le.corp_trademark_class_desc5),
    Fields.InValid_corp_trademark_class_desc6((SALT38.StrType)le.corp_trademark_class_desc6),
    Fields.InValid_corp_trademark_disclaimer1((SALT38.StrType)le.corp_trademark_disclaimer1),
    Fields.InValid_corp_trademark_disclaimer2((SALT38.StrType)le.corp_trademark_disclaimer2),
    Fields.InValid_corp_trademark_expiration_date((SALT38.StrType)le.corp_trademark_expiration_date),
    Fields.InValid_corp_trademark_filing_date((SALT38.StrType)le.corp_trademark_filing_date),
    Fields.InValid_corp_trademark_keywords((SALT38.StrType)le.corp_trademark_keywords),
    Fields.InValid_corp_trademark_logo((SALT38.StrType)le.corp_trademark_logo),
    Fields.InValid_corp_trademark_name_expiration_date((SALT38.StrType)le.corp_trademark_name_expiration_date),
    Fields.InValid_corp_trademark_nbr((SALT38.StrType)le.corp_trademark_nbr),
    Fields.InValid_corp_trademark_renewal_date((SALT38.StrType)le.corp_trademark_renewal_date),
    Fields.InValid_corp_trademark_status((SALT38.StrType)le.corp_trademark_status),
    Fields.InValid_corp_trademark_used_1((SALT38.StrType)le.corp_trademark_used_1),
    Fields.InValid_corp_trademark_used_2((SALT38.StrType)le.corp_trademark_used_2),
    Fields.InValid_corp_trademark_used_3((SALT38.StrType)le.corp_trademark_used_3),
    Fields.InValid_cont_owner_percentage((SALT38.StrType)le.cont_owner_percentage),
    Fields.InValid_cont_country((SALT38.StrType)le.cont_country),
    Fields.InValid_cont_country_mailing((SALT38.StrType)le.cont_country_mailing),
    Fields.InValid_cont_nondislosure((SALT38.StrType)le.cont_nondislosure),
    Fields.InValid_cont_prep_addr_line1((SALT38.StrType)le.cont_prep_addr_line1),
    Fields.InValid_cont_prep_addr_last_line((SALT38.StrType)le.cont_prep_addr_last_line),
    Fields.InValid_recordorigin((SALT38.StrType)le.recordorigin),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,289,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_corp_key','Unknown','invalid_corp_vendor','Unknown','Unknown','invalid_state_origin','invalid_date','invalid_charter_nbr','invalid_mandatory','invalid_type_cd','invalid_type_desc','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alpha','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_status_comment','Unknown','Unknown','invalid_state_origin','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_forgn_state','invalid_forgn_state','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_org_structure_desc','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alpha','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_recordorigin');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_supp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_subcode(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_corp_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_legal_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ln_name_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ln_name_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_supp_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_comment(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_line3(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address1_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_line2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_line3(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address2_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone_number_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_phone_number_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_fax_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_web_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_reference_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_filing_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_standing(TotalErrors.ErrorNum),Fields.InValidMessage_corp_status_comment(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ticker_symbol(TotalErrors.ErrorNum),Fields.InValidMessage_corp_stock_exchange(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_inc_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_anniversary_month(TotalErrors.ErrorNum),Fields.InValidMessage_corp_fed_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_term_exist_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_term_exist_exp(TotalErrors.ErrorNum),Fields.InValidMessage_corp_term_exist_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_foreign_domestic_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_state_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_state_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_fed_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_state_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_term_exist_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_term_exist_exp(TotalErrors.ErrorNum),Fields.InValidMessage_corp_forgn_term_exist_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_org_structure_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_org_structure_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_for_profit_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_public_or_private_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_sic_code(TotalErrors.ErrorNum),Fields.InValidMessage_corp_naic_code(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_bus_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_orig_bus_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_entity_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_certificate_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_internal_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_previous_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_microfilm_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_amendments_filed(TotalErrors.ErrorNum),Fields.InValidMessage_corp_acts(TotalErrors.ErrorNum),Fields.InValidMessage_corp_partnership_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_mfg_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_addl_info(TotalErrors.ErrorNum),Fields.InValidMessage_corp_taxes(TotalErrors.ErrorNum),Fields.InValidMessage_corp_franchise_taxes(TotalErrors.ErrorNum),Fields.InValidMessage_corp_tax_program_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_tax_program_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_fname(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_mname(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_lname(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_title_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_title_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_fein(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_dob(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_resign_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_no_comp(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_no_comp_igs(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_addl_info(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_line2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_address_line3(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_phone_number_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_phone_number_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_fax_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_web_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_prep_addr1_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_prep_addr1_last_line(TotalErrors.ErrorNum),Fields.InValidMessage_corp_prep_addr2_line1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_prep_addr2_last_line(TotalErrors.ErrorNum),Fields.InValidMessage_ra_prep_addr_line1(TotalErrors.ErrorNum),Fields.InValidMessage_ra_prep_addr_last_line(TotalErrors.ErrorNum),Fields.InValidMessage_cont_filing_reference_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_cont_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_cont_filing_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_filing_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_full_name(TotalErrors.ErrorNum),Fields.InValidMessage_cont_fname(TotalErrors.ErrorNum),Fields.InValidMessage_cont_mname(TotalErrors.ErrorNum),Fields.InValidMessage_cont_lname(TotalErrors.ErrorNum),Fields.InValidMessage_cont_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cont_title1_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_title2_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_title3_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_title4_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_title5_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_fein(TotalErrors.ErrorNum),Fields.InValidMessage_cont_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_cont_dob(TotalErrors.ErrorNum),Fields.InValidMessage_cont_status_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_cont_effective_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_effective_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_addl_info(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_line1(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_line2(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_line3(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_cont_address_county(TotalErrors.ErrorNum),Fields.InValidMessage_cont_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_cont_phone_number_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_cont_phone_number_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_cont_fax_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_cont_email_address(TotalErrors.ErrorNum),Fields.InValidMessage_cont_web_address(TotalErrors.ErrorNum),Fields.InValidMessage_corp_acres(TotalErrors.ErrorNum),Fields.InValidMessage_corp_action(TotalErrors.ErrorNum),Fields.InValidMessage_corp_action_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_action_employment_security_approval_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_action_pending_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_action_pending_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_action_statement_of_intent_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_action_tax_dept_approval_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_acts2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_acts3(TotalErrors.ErrorNum),Fields.InValidMessage_corp_additional_principals(TotalErrors.ErrorNum),Fields.InValidMessage_corp_address_office_type(TotalErrors.ErrorNum),Fields.InValidMessage_corp_agent_commercial(TotalErrors.ErrorNum),Fields.InValidMessage_corp_agent_country(TotalErrors.ErrorNum),Fields.InValidMessage_corp_agent_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_agent_status_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_agent_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_agent_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_agent_assign_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_agriculture_flag(TotalErrors.ErrorNum),Fields.InValidMessage_corp_authorized_partners(TotalErrors.ErrorNum),Fields.InValidMessage_corp_comment(TotalErrors.ErrorNum),Fields.InValidMessage_corp_consent_flag_for_protected_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_converted(TotalErrors.ErrorNum),Fields.InValidMessage_corp_converted_from(TotalErrors.ErrorNum),Fields.InValidMessage_corp_country_of_formation(TotalErrors.ErrorNum),Fields.InValidMessage_corp_date_of_organization_meeting(TotalErrors.ErrorNum),Fields.InValidMessage_corp_delayed_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_directors_from_to(TotalErrors.ErrorNum),Fields.InValidMessage_corp_dissolved_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_farm_exemptions(TotalErrors.ErrorNum),Fields.InValidMessage_corp_farm_qual_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_farm_status_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_farm_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_farm_status_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_fiscal_year_month(TotalErrors.ErrorNum),Fields.InValidMessage_corp_foreign_fiduciary_capacity_in_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_governing_statute(TotalErrors.ErrorNum),Fields.InValidMessage_corp_has_members(TotalErrors.ErrorNum),Fields.InValidMessage_corp_has_vested_managers(TotalErrors.ErrorNum),Fields.InValidMessage_corp_home_incorporated_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_home_state_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_is_professional(TotalErrors.ErrorNum),Fields.InValidMessage_corp_is_non_profit_irs_approved(TotalErrors.ErrorNum),Fields.InValidMessage_corp_last_renewal_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_last_renewal_year(TotalErrors.ErrorNum),Fields.InValidMessage_corp_license_type(TotalErrors.ErrorNum),Fields.InValidMessage_corp_llc_managed_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_llc_managed_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_management_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_management_type(TotalErrors.ErrorNum),Fields.InValidMessage_corp_manager_managed(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merged_corporation_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merged_fein(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merger_allowed_flag(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merger_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merger_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merger_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merger_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merger_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merger_name(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merger_type_converted_to_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_merger_type_converted_to_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_naics_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_reservation_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_reservation_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_reservation_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_reservation_type(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_status_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_status_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_name_status_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_non_profit_irs_approved_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_corp_non_profit_solicit_donations(TotalErrors.ErrorNum),Fields.InValidMessage_corp_nbr_of_amendments(TotalErrors.ErrorNum),Fields.InValidMessage_corp_nbr_of_initial_llc_members(TotalErrors.ErrorNum),Fields.InValidMessage_corp_nbr_of_partners(TotalErrors.ErrorNum),Fields.InValidMessage_corp_operating_agreement(TotalErrors.ErrorNum),Fields.InValidMessage_corp_opt_in_llc_act_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_opt_in_llc_act_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_organizational_comments(TotalErrors.ErrorNum),Fields.InValidMessage_corp_partner_contributions_total(TotalErrors.ErrorNum),Fields.InValidMessage_corp_partner_terms(TotalErrors.ErrorNum),Fields.InValidMessage_corp_percentage_voters_required_to_approve_amendments(TotalErrors.ErrorNum),Fields.InValidMessage_corp_profession(TotalErrors.ErrorNum),Fields.InValidMessage_corp_province(TotalErrors.ErrorNum),Fields.InValidMessage_corp_public_mutual_corporation(TotalErrors.ErrorNum),Fields.InValidMessage_corp_purpose(TotalErrors.ErrorNum),Fields.InValidMessage_corp_ra_required_flag(TotalErrors.ErrorNum),Fields.InValidMessage_corp_registered_counties(TotalErrors.ErrorNum),Fields.InValidMessage_corp_regulated_ind(TotalErrors.ErrorNum),Fields.InValidMessage_corp_renewal_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_standing_other(TotalErrors.ErrorNum),Fields.InValidMessage_corp_survivor_corporation_id(TotalErrors.ErrorNum),Fields.InValidMessage_corp_tax_base(TotalErrors.ErrorNum),Fields.InValidMessage_corp_tax_standing(TotalErrors.ErrorNum),Fields.InValidMessage_corp_termination_cd(TotalErrors.ErrorNum),Fields.InValidMessage_corp_termination_desc(TotalErrors.ErrorNum),Fields.InValidMessage_corp_termination_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_classification_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_first_use_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_first_use_date_in_state(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_business_mark_type(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_cancelled_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc3(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc4(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc5(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_class_desc6(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_disclaimer1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_disclaimer2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_keywords(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_logo(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_name_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_renewal_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_status(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_used_1(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_used_2(TotalErrors.ErrorNum),Fields.InValidMessage_corp_trademark_used_3(TotalErrors.ErrorNum),Fields.InValidMessage_cont_owner_percentage(TotalErrors.ErrorNum),Fields.InValidMessage_cont_country(TotalErrors.ErrorNum),Fields.InValidMessage_cont_country_mailing(TotalErrors.ErrorNum),Fields.InValidMessage_cont_nondislosure(TotalErrors.ErrorNum),Fields.InValidMessage_cont_prep_addr_line1(TotalErrors.ErrorNum),Fields.InValidMessage_cont_prep_addr_last_line(TotalErrors.ErrorNum),Fields.InValidMessage_recordorigin(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_MI_Main, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
