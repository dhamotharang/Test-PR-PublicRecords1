IMPORT SALT311,STD;
EXPORT Base_hygiene(dataset(Base_layout_DataBridge) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_clean_company_name_cnt := COUNT(GROUP,h.clean_company_name <> (TYPEOF(h.clean_company_name))'');
    populated_clean_company_name_pcnt := AVE(GROUP,IF(h.clean_company_name = (TYPEOF(h.clean_company_name))'',0,100));
    maxlength_clean_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_company_name)));
    avelength_clean_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_company_name)),h.clean_company_name<>(typeof(h.clean_company_name))'');
    populated_clean_area_code_cnt := COUNT(GROUP,h.clean_area_code <> (TYPEOF(h.clean_area_code))'');
    populated_clean_area_code_pcnt := AVE(GROUP,IF(h.clean_area_code = (TYPEOF(h.clean_area_code))'',0,100));
    maxlength_clean_area_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_area_code)));
    avelength_clean_area_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_area_code)),h.clean_area_code<>(typeof(h.clean_area_code))'');
    populated_clean_telephone_num_cnt := COUNT(GROUP,h.clean_telephone_num <> (TYPEOF(h.clean_telephone_num))'');
    populated_clean_telephone_num_pcnt := AVE(GROUP,IF(h.clean_telephone_num = (TYPEOF(h.clean_telephone_num))'',0,100));
    maxlength_clean_telephone_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_telephone_num)));
    avelength_clean_telephone_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_telephone_num)),h.clean_telephone_num<>(typeof(h.clean_telephone_num))'');
    populated_mail_score_desc_cnt := COUNT(GROUP,h.mail_score_desc <> (TYPEOF(h.mail_score_desc))'');
    populated_mail_score_desc_pcnt := AVE(GROUP,IF(h.mail_score_desc = (TYPEOF(h.mail_score_desc))'',0,100));
    maxlength_mail_score_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score_desc)));
    avelength_mail_score_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score_desc)),h.mail_score_desc<>(typeof(h.mail_score_desc))'');
    populated_name_gender_desc_cnt := COUNT(GROUP,h.name_gender_desc <> (TYPEOF(h.name_gender_desc))'');
    populated_name_gender_desc_pcnt := AVE(GROUP,IF(h.name_gender_desc = (TYPEOF(h.name_gender_desc))'',0,100));
    maxlength_name_gender_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_gender_desc)));
    avelength_name_gender_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_gender_desc)),h.name_gender_desc<>(typeof(h.name_gender_desc))'');
    populated_title_desc_1_cnt := COUNT(GROUP,h.title_desc_1 <> (TYPEOF(h.title_desc_1))'');
    populated_title_desc_1_pcnt := AVE(GROUP,IF(h.title_desc_1 = (TYPEOF(h.title_desc_1))'',0,100));
    maxlength_title_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_desc_1)));
    avelength_title_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_desc_1)),h.title_desc_1<>(typeof(h.title_desc_1))'');
    populated_title_desc_2_cnt := COUNT(GROUP,h.title_desc_2 <> (TYPEOF(h.title_desc_2))'');
    populated_title_desc_2_pcnt := AVE(GROUP,IF(h.title_desc_2 = (TYPEOF(h.title_desc_2))'',0,100));
    maxlength_title_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_desc_2)));
    avelength_title_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_desc_2)),h.title_desc_2<>(typeof(h.title_desc_2))'');
    populated_title_desc_3_cnt := COUNT(GROUP,h.title_desc_3 <> (TYPEOF(h.title_desc_3))'');
    populated_title_desc_3_pcnt := AVE(GROUP,IF(h.title_desc_3 = (TYPEOF(h.title_desc_3))'',0,100));
    maxlength_title_desc_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_desc_3)));
    avelength_title_desc_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_desc_3)),h.title_desc_3<>(typeof(h.title_desc_3))'');
    populated_title_desc_4_cnt := COUNT(GROUP,h.title_desc_4 <> (TYPEOF(h.title_desc_4))'');
    populated_title_desc_4_pcnt := AVE(GROUP,IF(h.title_desc_4 = (TYPEOF(h.title_desc_4))'',0,100));
    maxlength_title_desc_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_desc_4)));
    avelength_title_desc_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_desc_4)),h.title_desc_4<>(typeof(h.title_desc_4))'');
    populated_sic8_desc_1_cnt := COUNT(GROUP,h.sic8_desc_1 <> (TYPEOF(h.sic8_desc_1))'');
    populated_sic8_desc_1_pcnt := AVE(GROUP,IF(h.sic8_desc_1 = (TYPEOF(h.sic8_desc_1))'',0,100));
    maxlength_sic8_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_desc_1)));
    avelength_sic8_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_desc_1)),h.sic8_desc_1<>(typeof(h.sic8_desc_1))'');
    populated_sic8_desc_2_cnt := COUNT(GROUP,h.sic8_desc_2 <> (TYPEOF(h.sic8_desc_2))'');
    populated_sic8_desc_2_pcnt := AVE(GROUP,IF(h.sic8_desc_2 = (TYPEOF(h.sic8_desc_2))'',0,100));
    maxlength_sic8_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_desc_2)));
    avelength_sic8_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_desc_2)),h.sic8_desc_2<>(typeof(h.sic8_desc_2))'');
    populated_sic8_desc_3_cnt := COUNT(GROUP,h.sic8_desc_3 <> (TYPEOF(h.sic8_desc_3))'');
    populated_sic8_desc_3_pcnt := AVE(GROUP,IF(h.sic8_desc_3 = (TYPEOF(h.sic8_desc_3))'',0,100));
    maxlength_sic8_desc_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_desc_3)));
    avelength_sic8_desc_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_desc_3)),h.sic8_desc_3<>(typeof(h.sic8_desc_3))'');
    populated_sic8_desc_4_cnt := COUNT(GROUP,h.sic8_desc_4 <> (TYPEOF(h.sic8_desc_4))'');
    populated_sic8_desc_4_pcnt := AVE(GROUP,IF(h.sic8_desc_4 = (TYPEOF(h.sic8_desc_4))'',0,100));
    maxlength_sic8_desc_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_desc_4)));
    avelength_sic8_desc_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_desc_4)),h.sic8_desc_4<>(typeof(h.sic8_desc_4))'');
    populated_sic6_desc_1_cnt := COUNT(GROUP,h.sic6_desc_1 <> (TYPEOF(h.sic6_desc_1))'');
    populated_sic6_desc_1_pcnt := AVE(GROUP,IF(h.sic6_desc_1 = (TYPEOF(h.sic6_desc_1))'',0,100));
    maxlength_sic6_desc_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_desc_1)));
    avelength_sic6_desc_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_desc_1)),h.sic6_desc_1<>(typeof(h.sic6_desc_1))'');
    populated_sic6_desc_2_cnt := COUNT(GROUP,h.sic6_desc_2 <> (TYPEOF(h.sic6_desc_2))'');
    populated_sic6_desc_2_pcnt := AVE(GROUP,IF(h.sic6_desc_2 = (TYPEOF(h.sic6_desc_2))'',0,100));
    maxlength_sic6_desc_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_desc_2)));
    avelength_sic6_desc_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_desc_2)),h.sic6_desc_2<>(typeof(h.sic6_desc_2))'');
    populated_sic6_desc_3_cnt := COUNT(GROUP,h.sic6_desc_3 <> (TYPEOF(h.sic6_desc_3))'');
    populated_sic6_desc_3_pcnt := AVE(GROUP,IF(h.sic6_desc_3 = (TYPEOF(h.sic6_desc_3))'',0,100));
    maxlength_sic6_desc_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_desc_3)));
    avelength_sic6_desc_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_desc_3)),h.sic6_desc_3<>(typeof(h.sic6_desc_3))'');
    populated_sic6_desc_4_cnt := COUNT(GROUP,h.sic6_desc_4 <> (TYPEOF(h.sic6_desc_4))'');
    populated_sic6_desc_4_pcnt := AVE(GROUP,IF(h.sic6_desc_4 = (TYPEOF(h.sic6_desc_4))'',0,100));
    maxlength_sic6_desc_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_desc_4)));
    avelength_sic6_desc_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_desc_4)),h.sic6_desc_4<>(typeof(h.sic6_desc_4))'');
    populated_sic6_desc_5_cnt := COUNT(GROUP,h.sic6_desc_5 <> (TYPEOF(h.sic6_desc_5))'');
    populated_sic6_desc_5_pcnt := AVE(GROUP,IF(h.sic6_desc_5 = (TYPEOF(h.sic6_desc_5))'',0,100));
    maxlength_sic6_desc_5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_desc_5)));
    avelength_sic6_desc_5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_desc_5)),h.sic6_desc_5<>(typeof(h.sic6_desc_5))'');
    populated_name_cnt := COUNT(GROUP,h.name <> (TYPEOF(h.name))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_company_cnt := COUNT(GROUP,h.company <> (TYPEOF(h.company))'');
    populated_company_pcnt := AVE(GROUP,IF(h.company = (TYPEOF(h.company))'',0,100));
    maxlength_company := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company)));
    avelength_company := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company)),h.company<>(typeof(h.company))'');
    populated_address_cnt := COUNT(GROUP,h.address <> (TYPEOF(h.address))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_scf_cnt := COUNT(GROUP,h.scf <> (TYPEOF(h.scf))'');
    populated_scf_pcnt := AVE(GROUP,IF(h.scf = (TYPEOF(h.scf))'',0,100));
    maxlength_scf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.scf)));
    avelength_scf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.scf)),h.scf<>(typeof(h.scf))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_mail_score_cnt := COUNT(GROUP,h.mail_score <> (TYPEOF(h.mail_score))'');
    populated_mail_score_pcnt := AVE(GROUP,IF(h.mail_score = (TYPEOF(h.mail_score))'',0,100));
    maxlength_mail_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score)));
    avelength_mail_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score)),h.mail_score<>(typeof(h.mail_score))'');
    populated_area_code_cnt := COUNT(GROUP,h.area_code <> (TYPEOF(h.area_code))'');
    populated_area_code_pcnt := AVE(GROUP,IF(h.area_code = (TYPEOF(h.area_code))'',0,100));
    maxlength_area_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.area_code)));
    avelength_area_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.area_code)),h.area_code<>(typeof(h.area_code))'');
    populated_telephone_number_cnt := COUNT(GROUP,h.telephone_number <> (TYPEOF(h.telephone_number))'');
    populated_telephone_number_pcnt := AVE(GROUP,IF(h.telephone_number = (TYPEOF(h.telephone_number))'',0,100));
    maxlength_telephone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone_number)));
    avelength_telephone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone_number)),h.telephone_number<>(typeof(h.telephone_number))'');
    populated_name_gender_cnt := COUNT(GROUP,h.name_gender <> (TYPEOF(h.name_gender))'');
    populated_name_gender_pcnt := AVE(GROUP,IF(h.name_gender = (TYPEOF(h.name_gender))'',0,100));
    maxlength_name_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_gender)));
    avelength_name_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_gender)),h.name_gender<>(typeof(h.name_gender))'');
    populated_name_prefix_cnt := COUNT(GROUP,h.name_prefix <> (TYPEOF(h.name_prefix))'');
    populated_name_prefix_pcnt := AVE(GROUP,IF(h.name_prefix = (TYPEOF(h.name_prefix))'',0,100));
    maxlength_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_prefix)));
    avelength_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_prefix)),h.name_prefix<>(typeof(h.name_prefix))'');
    populated_name_first_cnt := COUNT(GROUP,h.name_first <> (TYPEOF(h.name_first))'');
    populated_name_first_pcnt := AVE(GROUP,IF(h.name_first = (TYPEOF(h.name_first))'',0,100));
    maxlength_name_first := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_first)));
    avelength_name_first := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_first)),h.name_first<>(typeof(h.name_first))'');
    populated_name_middle_initial_cnt := COUNT(GROUP,h.name_middle_initial <> (TYPEOF(h.name_middle_initial))'');
    populated_name_middle_initial_pcnt := AVE(GROUP,IF(h.name_middle_initial = (TYPEOF(h.name_middle_initial))'',0,100));
    maxlength_name_middle_initial := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_middle_initial)));
    avelength_name_middle_initial := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_middle_initial)),h.name_middle_initial<>(typeof(h.name_middle_initial))'');
    populated_name_last_cnt := COUNT(GROUP,h.name_last <> (TYPEOF(h.name_last))'');
    populated_name_last_pcnt := AVE(GROUP,IF(h.name_last = (TYPEOF(h.name_last))'',0,100));
    maxlength_name_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_last)));
    avelength_name_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_last)),h.name_last<>(typeof(h.name_last))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_title_code_1_cnt := COUNT(GROUP,h.title_code_1 <> (TYPEOF(h.title_code_1))'');
    populated_title_code_1_pcnt := AVE(GROUP,IF(h.title_code_1 = (TYPEOF(h.title_code_1))'',0,100));
    maxlength_title_code_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_code_1)));
    avelength_title_code_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_code_1)),h.title_code_1<>(typeof(h.title_code_1))'');
    populated_title_code_2_cnt := COUNT(GROUP,h.title_code_2 <> (TYPEOF(h.title_code_2))'');
    populated_title_code_2_pcnt := AVE(GROUP,IF(h.title_code_2 = (TYPEOF(h.title_code_2))'',0,100));
    maxlength_title_code_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_code_2)));
    avelength_title_code_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_code_2)),h.title_code_2<>(typeof(h.title_code_2))'');
    populated_title_code_3_cnt := COUNT(GROUP,h.title_code_3 <> (TYPEOF(h.title_code_3))'');
    populated_title_code_3_pcnt := AVE(GROUP,IF(h.title_code_3 = (TYPEOF(h.title_code_3))'',0,100));
    maxlength_title_code_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_code_3)));
    avelength_title_code_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_code_3)),h.title_code_3<>(typeof(h.title_code_3))'');
    populated_title_code_4_cnt := COUNT(GROUP,h.title_code_4 <> (TYPEOF(h.title_code_4))'');
    populated_title_code_4_pcnt := AVE(GROUP,IF(h.title_code_4 = (TYPEOF(h.title_code_4))'',0,100));
    maxlength_title_code_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_code_4)));
    avelength_title_code_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_code_4)),h.title_code_4<>(typeof(h.title_code_4))'');
    populated_web_address_cnt := COUNT(GROUP,h.web_address <> (TYPEOF(h.web_address))'');
    populated_web_address_pcnt := AVE(GROUP,IF(h.web_address = (TYPEOF(h.web_address))'',0,100));
    maxlength_web_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.web_address)));
    avelength_web_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.web_address)),h.web_address<>(typeof(h.web_address))'');
    populated_sic8_1_cnt := COUNT(GROUP,h.sic8_1 <> (TYPEOF(h.sic8_1))'');
    populated_sic8_1_pcnt := AVE(GROUP,IF(h.sic8_1 = (TYPEOF(h.sic8_1))'',0,100));
    maxlength_sic8_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_1)));
    avelength_sic8_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_1)),h.sic8_1<>(typeof(h.sic8_1))'');
    populated_sic8_2_cnt := COUNT(GROUP,h.sic8_2 <> (TYPEOF(h.sic8_2))'');
    populated_sic8_2_pcnt := AVE(GROUP,IF(h.sic8_2 = (TYPEOF(h.sic8_2))'',0,100));
    maxlength_sic8_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_2)));
    avelength_sic8_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_2)),h.sic8_2<>(typeof(h.sic8_2))'');
    populated_sic8_3_cnt := COUNT(GROUP,h.sic8_3 <> (TYPEOF(h.sic8_3))'');
    populated_sic8_3_pcnt := AVE(GROUP,IF(h.sic8_3 = (TYPEOF(h.sic8_3))'',0,100));
    maxlength_sic8_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_3)));
    avelength_sic8_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_3)),h.sic8_3<>(typeof(h.sic8_3))'');
    populated_sic8_4_cnt := COUNT(GROUP,h.sic8_4 <> (TYPEOF(h.sic8_4))'');
    populated_sic8_4_pcnt := AVE(GROUP,IF(h.sic8_4 = (TYPEOF(h.sic8_4))'',0,100));
    maxlength_sic8_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_4)));
    avelength_sic8_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_4)),h.sic8_4<>(typeof(h.sic8_4))'');
    populated_sic6_1_cnt := COUNT(GROUP,h.sic6_1 <> (TYPEOF(h.sic6_1))'');
    populated_sic6_1_pcnt := AVE(GROUP,IF(h.sic6_1 = (TYPEOF(h.sic6_1))'',0,100));
    maxlength_sic6_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_1)));
    avelength_sic6_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_1)),h.sic6_1<>(typeof(h.sic6_1))'');
    populated_sic6_2_cnt := COUNT(GROUP,h.sic6_2 <> (TYPEOF(h.sic6_2))'');
    populated_sic6_2_pcnt := AVE(GROUP,IF(h.sic6_2 = (TYPEOF(h.sic6_2))'',0,100));
    maxlength_sic6_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_2)));
    avelength_sic6_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_2)),h.sic6_2<>(typeof(h.sic6_2))'');
    populated_sic6_3_cnt := COUNT(GROUP,h.sic6_3 <> (TYPEOF(h.sic6_3))'');
    populated_sic6_3_pcnt := AVE(GROUP,IF(h.sic6_3 = (TYPEOF(h.sic6_3))'',0,100));
    maxlength_sic6_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_3)));
    avelength_sic6_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_3)),h.sic6_3<>(typeof(h.sic6_3))'');
    populated_sic6_4_cnt := COUNT(GROUP,h.sic6_4 <> (TYPEOF(h.sic6_4))'');
    populated_sic6_4_pcnt := AVE(GROUP,IF(h.sic6_4 = (TYPEOF(h.sic6_4))'',0,100));
    maxlength_sic6_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_4)));
    avelength_sic6_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_4)),h.sic6_4<>(typeof(h.sic6_4))'');
    populated_sic6_5_cnt := COUNT(GROUP,h.sic6_5 <> (TYPEOF(h.sic6_5))'');
    populated_sic6_5_pcnt := AVE(GROUP,IF(h.sic6_5 = (TYPEOF(h.sic6_5))'',0,100));
    maxlength_sic6_5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_5)));
    avelength_sic6_5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_5)),h.sic6_5<>(typeof(h.sic6_5))'');
    populated_transaction_date_cnt := COUNT(GROUP,h.transaction_date <> (TYPEOF(h.transaction_date))'');
    populated_transaction_date_pcnt := AVE(GROUP,IF(h.transaction_date = (TYPEOF(h.transaction_date))'',0,100));
    maxlength_transaction_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_date)));
    avelength_transaction_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_date)),h.transaction_date<>(typeof(h.transaction_date))'');
    populated_database_site_id_cnt := COUNT(GROUP,h.database_site_id <> (TYPEOF(h.database_site_id))'');
    populated_database_site_id_pcnt := AVE(GROUP,IF(h.database_site_id = (TYPEOF(h.database_site_id))'',0,100));
    maxlength_database_site_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.database_site_id)));
    avelength_database_site_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.database_site_id)),h.database_site_id<>(typeof(h.database_site_id))'');
    populated_database_individual_id_cnt := COUNT(GROUP,h.database_individual_id <> (TYPEOF(h.database_individual_id))'');
    populated_database_individual_id_pcnt := AVE(GROUP,IF(h.database_individual_id = (TYPEOF(h.database_individual_id))'',0,100));
    maxlength_database_individual_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.database_individual_id)));
    avelength_database_individual_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.database_individual_id)),h.database_individual_id<>(typeof(h.database_individual_id))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_email_present_flag_cnt := COUNT(GROUP,h.email_present_flag <> (TYPEOF(h.email_present_flag))'');
    populated_email_present_flag_pcnt := AVE(GROUP,IF(h.email_present_flag = (TYPEOF(h.email_present_flag))'',0,100));
    maxlength_email_present_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_present_flag)));
    avelength_email_present_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_present_flag)),h.email_present_flag<>(typeof(h.email_present_flag))'');
    populated_site_source1_cnt := COUNT(GROUP,h.site_source1 <> (TYPEOF(h.site_source1))'');
    populated_site_source1_pcnt := AVE(GROUP,IF(h.site_source1 = (TYPEOF(h.site_source1))'',0,100));
    maxlength_site_source1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source1)));
    avelength_site_source1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source1)),h.site_source1<>(typeof(h.site_source1))'');
    populated_site_source2_cnt := COUNT(GROUP,h.site_source2 <> (TYPEOF(h.site_source2))'');
    populated_site_source2_pcnt := AVE(GROUP,IF(h.site_source2 = (TYPEOF(h.site_source2))'',0,100));
    maxlength_site_source2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source2)));
    avelength_site_source2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source2)),h.site_source2<>(typeof(h.site_source2))'');
    populated_site_source3_cnt := COUNT(GROUP,h.site_source3 <> (TYPEOF(h.site_source3))'');
    populated_site_source3_pcnt := AVE(GROUP,IF(h.site_source3 = (TYPEOF(h.site_source3))'',0,100));
    maxlength_site_source3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source3)));
    avelength_site_source3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source3)),h.site_source3<>(typeof(h.site_source3))'');
    populated_site_source4_cnt := COUNT(GROUP,h.site_source4 <> (TYPEOF(h.site_source4))'');
    populated_site_source4_pcnt := AVE(GROUP,IF(h.site_source4 = (TYPEOF(h.site_source4))'',0,100));
    maxlength_site_source4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source4)));
    avelength_site_source4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source4)),h.site_source4<>(typeof(h.site_source4))'');
    populated_site_source5_cnt := COUNT(GROUP,h.site_source5 <> (TYPEOF(h.site_source5))'');
    populated_site_source5_pcnt := AVE(GROUP,IF(h.site_source5 = (TYPEOF(h.site_source5))'',0,100));
    maxlength_site_source5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source5)));
    avelength_site_source5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source5)),h.site_source5<>(typeof(h.site_source5))'');
    populated_site_source6_cnt := COUNT(GROUP,h.site_source6 <> (TYPEOF(h.site_source6))'');
    populated_site_source6_pcnt := AVE(GROUP,IF(h.site_source6 = (TYPEOF(h.site_source6))'',0,100));
    maxlength_site_source6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source6)));
    avelength_site_source6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source6)),h.site_source6<>(typeof(h.site_source6))'');
    populated_site_source7_cnt := COUNT(GROUP,h.site_source7 <> (TYPEOF(h.site_source7))'');
    populated_site_source7_pcnt := AVE(GROUP,IF(h.site_source7 = (TYPEOF(h.site_source7))'',0,100));
    maxlength_site_source7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source7)));
    avelength_site_source7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source7)),h.site_source7<>(typeof(h.site_source7))'');
    populated_site_source8_cnt := COUNT(GROUP,h.site_source8 <> (TYPEOF(h.site_source8))'');
    populated_site_source8_pcnt := AVE(GROUP,IF(h.site_source8 = (TYPEOF(h.site_source8))'',0,100));
    maxlength_site_source8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source8)));
    avelength_site_source8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source8)),h.site_source8<>(typeof(h.site_source8))'');
    populated_site_source9_cnt := COUNT(GROUP,h.site_source9 <> (TYPEOF(h.site_source9))'');
    populated_site_source9_pcnt := AVE(GROUP,IF(h.site_source9 = (TYPEOF(h.site_source9))'',0,100));
    maxlength_site_source9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source9)));
    avelength_site_source9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source9)),h.site_source9<>(typeof(h.site_source9))'');
    populated_site_source10_cnt := COUNT(GROUP,h.site_source10 <> (TYPEOF(h.site_source10))'');
    populated_site_source10_pcnt := AVE(GROUP,IF(h.site_source10 = (TYPEOF(h.site_source10))'',0,100));
    maxlength_site_source10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source10)));
    avelength_site_source10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source10)),h.site_source10<>(typeof(h.site_source10))'');
    populated_individual_source1_cnt := COUNT(GROUP,h.individual_source1 <> (TYPEOF(h.individual_source1))'');
    populated_individual_source1_pcnt := AVE(GROUP,IF(h.individual_source1 = (TYPEOF(h.individual_source1))'',0,100));
    maxlength_individual_source1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source1)));
    avelength_individual_source1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source1)),h.individual_source1<>(typeof(h.individual_source1))'');
    populated_individual_source2_cnt := COUNT(GROUP,h.individual_source2 <> (TYPEOF(h.individual_source2))'');
    populated_individual_source2_pcnt := AVE(GROUP,IF(h.individual_source2 = (TYPEOF(h.individual_source2))'',0,100));
    maxlength_individual_source2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source2)));
    avelength_individual_source2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source2)),h.individual_source2<>(typeof(h.individual_source2))'');
    populated_individual_source3_cnt := COUNT(GROUP,h.individual_source3 <> (TYPEOF(h.individual_source3))'');
    populated_individual_source3_pcnt := AVE(GROUP,IF(h.individual_source3 = (TYPEOF(h.individual_source3))'',0,100));
    maxlength_individual_source3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source3)));
    avelength_individual_source3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source3)),h.individual_source3<>(typeof(h.individual_source3))'');
    populated_individual_source4_cnt := COUNT(GROUP,h.individual_source4 <> (TYPEOF(h.individual_source4))'');
    populated_individual_source4_pcnt := AVE(GROUP,IF(h.individual_source4 = (TYPEOF(h.individual_source4))'',0,100));
    maxlength_individual_source4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source4)));
    avelength_individual_source4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source4)),h.individual_source4<>(typeof(h.individual_source4))'');
    populated_individual_source5_cnt := COUNT(GROUP,h.individual_source5 <> (TYPEOF(h.individual_source5))'');
    populated_individual_source5_pcnt := AVE(GROUP,IF(h.individual_source5 = (TYPEOF(h.individual_source5))'',0,100));
    maxlength_individual_source5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source5)));
    avelength_individual_source5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source5)),h.individual_source5<>(typeof(h.individual_source5))'');
    populated_individual_source6_cnt := COUNT(GROUP,h.individual_source6 <> (TYPEOF(h.individual_source6))'');
    populated_individual_source6_pcnt := AVE(GROUP,IF(h.individual_source6 = (TYPEOF(h.individual_source6))'',0,100));
    maxlength_individual_source6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source6)));
    avelength_individual_source6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source6)),h.individual_source6<>(typeof(h.individual_source6))'');
    populated_individual_source7_cnt := COUNT(GROUP,h.individual_source7 <> (TYPEOF(h.individual_source7))'');
    populated_individual_source7_pcnt := AVE(GROUP,IF(h.individual_source7 = (TYPEOF(h.individual_source7))'',0,100));
    maxlength_individual_source7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source7)));
    avelength_individual_source7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source7)),h.individual_source7<>(typeof(h.individual_source7))'');
    populated_individual_source8_cnt := COUNT(GROUP,h.individual_source8 <> (TYPEOF(h.individual_source8))'');
    populated_individual_source8_pcnt := AVE(GROUP,IF(h.individual_source8 = (TYPEOF(h.individual_source8))'',0,100));
    maxlength_individual_source8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source8)));
    avelength_individual_source8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source8)),h.individual_source8<>(typeof(h.individual_source8))'');
    populated_individual_source9_cnt := COUNT(GROUP,h.individual_source9 <> (TYPEOF(h.individual_source9))'');
    populated_individual_source9_pcnt := AVE(GROUP,IF(h.individual_source9 = (TYPEOF(h.individual_source9))'',0,100));
    maxlength_individual_source9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source9)));
    avelength_individual_source9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source9)),h.individual_source9<>(typeof(h.individual_source9))'');
    populated_individual_source10_cnt := COUNT(GROUP,h.individual_source10 <> (TYPEOF(h.individual_source10))'');
    populated_individual_source10_pcnt := AVE(GROUP,IF(h.individual_source10 = (TYPEOF(h.individual_source10))'',0,100));
    maxlength_individual_source10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source10)));
    avelength_individual_source10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source10)),h.individual_source10<>(typeof(h.individual_source10))'');
    populated_email_status_cnt := COUNT(GROUP,h.email_status <> (TYPEOF(h.email_status))'');
    populated_email_status_pcnt := AVE(GROUP,IF(h.email_status = (TYPEOF(h.email_status))'',0,100));
    maxlength_email_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_status)));
    avelength_email_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_status)),h.email_status<>(typeof(h.email_status))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
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
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_state_cnt := COUNT(GROUP,h.fips_state <> (TYPEOF(h.fips_state))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
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
    populated_raw_aid_cnt := COUNT(GROUP,h.raw_aid <> (TYPEOF(h.raw_aid))'');
    populated_raw_aid_pcnt := AVE(GROUP,IF(h.raw_aid = (TYPEOF(h.raw_aid))'',0,100));
    maxlength_raw_aid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_aid)));
    avelength_raw_aid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.raw_aid)),h.raw_aid<>(typeof(h.raw_aid))'');
    populated_ace_aid_cnt := COUNT(GROUP,h.ace_aid <> (TYPEOF(h.ace_aid))'');
    populated_ace_aid_pcnt := AVE(GROUP,IF(h.ace_aid = (TYPEOF(h.ace_aid))'',0,100));
    maxlength_ace_aid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_aid)));
    avelength_ace_aid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_aid)),h.ace_aid<>(typeof(h.ace_aid))'');
    populated_prep_address_line1_cnt := COUNT(GROUP,h.prep_address_line1 <> (TYPEOF(h.prep_address_line1))'');
    populated_prep_address_line1_pcnt := AVE(GROUP,IF(h.prep_address_line1 = (TYPEOF(h.prep_address_line1))'',0,100));
    maxlength_prep_address_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_address_line1)));
    avelength_prep_address_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_address_line1)),h.prep_address_line1<>(typeof(h.prep_address_line1))'');
    populated_prep_address_line_last_cnt := COUNT(GROUP,h.prep_address_line_last <> (TYPEOF(h.prep_address_line_last))'');
    populated_prep_address_line_last_pcnt := AVE(GROUP,IF(h.prep_address_line_last = (TYPEOF(h.prep_address_line_last))'',0,100));
    maxlength_prep_address_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_address_line_last)));
    avelength_prep_address_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_address_line_last)),h.prep_address_line_last<>(typeof(h.prep_address_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_clean_company_name_pcnt *   0.00 / 100 + T.Populated_clean_area_code_pcnt *   0.00 / 100 + T.Populated_clean_telephone_num_pcnt *   0.00 / 100 + T.Populated_mail_score_desc_pcnt *   0.00 / 100 + T.Populated_name_gender_desc_pcnt *   0.00 / 100 + T.Populated_title_desc_1_pcnt *   0.00 / 100 + T.Populated_title_desc_2_pcnt *   0.00 / 100 + T.Populated_title_desc_3_pcnt *   0.00 / 100 + T.Populated_title_desc_4_pcnt *   0.00 / 100 + T.Populated_sic8_desc_1_pcnt *   0.00 / 100 + T.Populated_sic8_desc_2_pcnt *   0.00 / 100 + T.Populated_sic8_desc_3_pcnt *   0.00 / 100 + T.Populated_sic8_desc_4_pcnt *   0.00 / 100 + T.Populated_sic6_desc_1_pcnt *   0.00 / 100 + T.Populated_sic6_desc_2_pcnt *   0.00 / 100 + T.Populated_sic6_desc_3_pcnt *   0.00 / 100 + T.Populated_sic6_desc_4_pcnt *   0.00 / 100 + T.Populated_sic6_desc_5_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_company_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_scf_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_mail_score_pcnt *   0.00 / 100 + T.Populated_area_code_pcnt *   0.00 / 100 + T.Populated_telephone_number_pcnt *   0.00 / 100 + T.Populated_name_gender_pcnt *   0.00 / 100 + T.Populated_name_prefix_pcnt *   0.00 / 100 + T.Populated_name_first_pcnt *   0.00 / 100 + T.Populated_name_middle_initial_pcnt *   0.00 / 100 + T.Populated_name_last_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_title_code_1_pcnt *   0.00 / 100 + T.Populated_title_code_2_pcnt *   0.00 / 100 + T.Populated_title_code_3_pcnt *   0.00 / 100 + T.Populated_title_code_4_pcnt *   0.00 / 100 + T.Populated_web_address_pcnt *   0.00 / 100 + T.Populated_sic8_1_pcnt *   0.00 / 100 + T.Populated_sic8_2_pcnt *   0.00 / 100 + T.Populated_sic8_3_pcnt *   0.00 / 100 + T.Populated_sic8_4_pcnt *   0.00 / 100 + T.Populated_sic6_1_pcnt *   0.00 / 100 + T.Populated_sic6_2_pcnt *   0.00 / 100 + T.Populated_sic6_3_pcnt *   0.00 / 100 + T.Populated_sic6_4_pcnt *   0.00 / 100 + T.Populated_sic6_5_pcnt *   0.00 / 100 + T.Populated_transaction_date_pcnt *   0.00 / 100 + T.Populated_database_site_id_pcnt *   0.00 / 100 + T.Populated_database_individual_id_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_email_present_flag_pcnt *   0.00 / 100 + T.Populated_site_source1_pcnt *   0.00 / 100 + T.Populated_site_source2_pcnt *   0.00 / 100 + T.Populated_site_source3_pcnt *   0.00 / 100 + T.Populated_site_source4_pcnt *   0.00 / 100 + T.Populated_site_source5_pcnt *   0.00 / 100 + T.Populated_site_source6_pcnt *   0.00 / 100 + T.Populated_site_source7_pcnt *   0.00 / 100 + T.Populated_site_source8_pcnt *   0.00 / 100 + T.Populated_site_source9_pcnt *   0.00 / 100 + T.Populated_site_source10_pcnt *   0.00 / 100 + T.Populated_individual_source1_pcnt *   0.00 / 100 + T.Populated_individual_source2_pcnt *   0.00 / 100 + T.Populated_individual_source3_pcnt *   0.00 / 100 + T.Populated_individual_source4_pcnt *   0.00 / 100 + T.Populated_individual_source5_pcnt *   0.00 / 100 + T.Populated_individual_source6_pcnt *   0.00 / 100 + T.Populated_individual_source7_pcnt *   0.00 / 100 + T.Populated_individual_source8_pcnt *   0.00 / 100 + T.Populated_individual_source9_pcnt *   0.00 / 100 + T.Populated_individual_source10_pcnt *   0.00 / 100 + T.Populated_email_status_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_raw_aid_pcnt *   0.00 / 100 + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_prep_address_line1_pcnt *   0.00 / 100 + T.Populated_prep_address_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','clean_company_name','clean_area_code','clean_telephone_num','mail_score_desc','name_gender_desc','title_desc_1','title_desc_2','title_desc_3','title_desc_4','sic8_desc_1','sic8_desc_2','sic8_desc_3','sic8_desc_4','sic6_desc_1','sic6_desc_2','sic6_desc_3','sic6_desc_4','sic6_desc_5','name','company','address','address2','city','state','scf','zip','zip4','mail_score','area_code','telephone_number','name_gender','name_prefix','name_first','name_middle_initial','name_last','suffix','title_code_1','title_code_2','title_code_3','title_code_4','web_address','sic8_1','sic8_2','sic8_3','sic8_4','sic6_1','sic6_2','sic6_3','sic6_4','sic6_5','transaction_date','database_site_id','database_individual_id','email','email_present_flag','site_source1','site_source2','site_source3','site_source4','site_source5','site_source6','site_source7','site_source8','site_source9','site_source10','individual_source1','individual_source2','individual_source3','individual_source4','individual_source5','individual_source6','individual_source7','individual_source8','individual_source9','individual_source10','email_status','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_address_line1','prep_address_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_did_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_record_type_pcnt,le.populated_clean_company_name_pcnt,le.populated_clean_area_code_pcnt,le.populated_clean_telephone_num_pcnt,le.populated_mail_score_desc_pcnt,le.populated_name_gender_desc_pcnt,le.populated_title_desc_1_pcnt,le.populated_title_desc_2_pcnt,le.populated_title_desc_3_pcnt,le.populated_title_desc_4_pcnt,le.populated_sic8_desc_1_pcnt,le.populated_sic8_desc_2_pcnt,le.populated_sic8_desc_3_pcnt,le.populated_sic8_desc_4_pcnt,le.populated_sic6_desc_1_pcnt,le.populated_sic6_desc_2_pcnt,le.populated_sic6_desc_3_pcnt,le.populated_sic6_desc_4_pcnt,le.populated_sic6_desc_5_pcnt,le.populated_name_pcnt,le.populated_company_pcnt,le.populated_address_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_scf_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_mail_score_pcnt,le.populated_area_code_pcnt,le.populated_telephone_number_pcnt,le.populated_name_gender_pcnt,le.populated_name_prefix_pcnt,le.populated_name_first_pcnt,le.populated_name_middle_initial_pcnt,le.populated_name_last_pcnt,le.populated_suffix_pcnt,le.populated_title_code_1_pcnt,le.populated_title_code_2_pcnt,le.populated_title_code_3_pcnt,le.populated_title_code_4_pcnt,le.populated_web_address_pcnt,le.populated_sic8_1_pcnt,le.populated_sic8_2_pcnt,le.populated_sic8_3_pcnt,le.populated_sic8_4_pcnt,le.populated_sic6_1_pcnt,le.populated_sic6_2_pcnt,le.populated_sic6_3_pcnt,le.populated_sic6_4_pcnt,le.populated_sic6_5_pcnt,le.populated_transaction_date_pcnt,le.populated_database_site_id_pcnt,le.populated_database_individual_id_pcnt,le.populated_email_pcnt,le.populated_email_present_flag_pcnt,le.populated_site_source1_pcnt,le.populated_site_source2_pcnt,le.populated_site_source3_pcnt,le.populated_site_source4_pcnt,le.populated_site_source5_pcnt,le.populated_site_source6_pcnt,le.populated_site_source7_pcnt,le.populated_site_source8_pcnt,le.populated_site_source9_pcnt,le.populated_site_source10_pcnt,le.populated_individual_source1_pcnt,le.populated_individual_source2_pcnt,le.populated_individual_source3_pcnt,le.populated_individual_source4_pcnt,le.populated_individual_source5_pcnt,le.populated_individual_source6_pcnt,le.populated_individual_source7_pcnt,le.populated_individual_source8_pcnt,le.populated_individual_source9_pcnt,le.populated_individual_source10_pcnt,le.populated_email_status_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_raw_aid_pcnt,le.populated_ace_aid_pcnt,le.populated_prep_address_line1_pcnt,le.populated_prep_address_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_did,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_process_date,le.maxlength_record_type,le.maxlength_clean_company_name,le.maxlength_clean_area_code,le.maxlength_clean_telephone_num,le.maxlength_mail_score_desc,le.maxlength_name_gender_desc,le.maxlength_title_desc_1,le.maxlength_title_desc_2,le.maxlength_title_desc_3,le.maxlength_title_desc_4,le.maxlength_sic8_desc_1,le.maxlength_sic8_desc_2,le.maxlength_sic8_desc_3,le.maxlength_sic8_desc_4,le.maxlength_sic6_desc_1,le.maxlength_sic6_desc_2,le.maxlength_sic6_desc_3,le.maxlength_sic6_desc_4,le.maxlength_sic6_desc_5,le.maxlength_name,le.maxlength_company,le.maxlength_address,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_scf,le.maxlength_zip,le.maxlength_zip4,le.maxlength_mail_score,le.maxlength_area_code,le.maxlength_telephone_number,le.maxlength_name_gender,le.maxlength_name_prefix,le.maxlength_name_first,le.maxlength_name_middle_initial,le.maxlength_name_last,le.maxlength_suffix,le.maxlength_title_code_1,le.maxlength_title_code_2,le.maxlength_title_code_3,le.maxlength_title_code_4,le.maxlength_web_address,le.maxlength_sic8_1,le.maxlength_sic8_2,le.maxlength_sic8_3,le.maxlength_sic8_4,le.maxlength_sic6_1,le.maxlength_sic6_2,le.maxlength_sic6_3,le.maxlength_sic6_4,le.maxlength_sic6_5,le.maxlength_transaction_date,le.maxlength_database_site_id,le.maxlength_database_individual_id,le.maxlength_email,le.maxlength_email_present_flag,le.maxlength_site_source1,le.maxlength_site_source2,le.maxlength_site_source3,le.maxlength_site_source4,le.maxlength_site_source5,le.maxlength_site_source6,le.maxlength_site_source7,le.maxlength_site_source8,le.maxlength_site_source9,le.maxlength_site_source10,le.maxlength_individual_source1,le.maxlength_individual_source2,le.maxlength_individual_source3,le.maxlength_individual_source4,le.maxlength_individual_source5,le.maxlength_individual_source6,le.maxlength_individual_source7,le.maxlength_individual_source8,le.maxlength_individual_source9,le.maxlength_individual_source10,le.maxlength_email_status,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_raw_aid,le.maxlength_ace_aid,le.maxlength_prep_address_line1,le.maxlength_prep_address_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_did,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_process_date,le.avelength_record_type,le.avelength_clean_company_name,le.avelength_clean_area_code,le.avelength_clean_telephone_num,le.avelength_mail_score_desc,le.avelength_name_gender_desc,le.avelength_title_desc_1,le.avelength_title_desc_2,le.avelength_title_desc_3,le.avelength_title_desc_4,le.avelength_sic8_desc_1,le.avelength_sic8_desc_2,le.avelength_sic8_desc_3,le.avelength_sic8_desc_4,le.avelength_sic6_desc_1,le.avelength_sic6_desc_2,le.avelength_sic6_desc_3,le.avelength_sic6_desc_4,le.avelength_sic6_desc_5,le.avelength_name,le.avelength_company,le.avelength_address,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_scf,le.avelength_zip,le.avelength_zip4,le.avelength_mail_score,le.avelength_area_code,le.avelength_telephone_number,le.avelength_name_gender,le.avelength_name_prefix,le.avelength_name_first,le.avelength_name_middle_initial,le.avelength_name_last,le.avelength_suffix,le.avelength_title_code_1,le.avelength_title_code_2,le.avelength_title_code_3,le.avelength_title_code_4,le.avelength_web_address,le.avelength_sic8_1,le.avelength_sic8_2,le.avelength_sic8_3,le.avelength_sic8_4,le.avelength_sic6_1,le.avelength_sic6_2,le.avelength_sic6_3,le.avelength_sic6_4,le.avelength_sic6_5,le.avelength_transaction_date,le.avelength_database_site_id,le.avelength_database_individual_id,le.avelength_email,le.avelength_email_present_flag,le.avelength_site_source1,le.avelength_site_source2,le.avelength_site_source3,le.avelength_site_source4,le.avelength_site_source5,le.avelength_site_source6,le.avelength_site_source7,le.avelength_site_source8,le.avelength_site_source9,le.avelength_site_source10,le.avelength_individual_source1,le.avelength_individual_source2,le.avelength_individual_source3,le.avelength_individual_source4,le.avelength_individual_source5,le.avelength_individual_source6,le.avelength_individual_source7,le.avelength_individual_source8,le.avelength_individual_source9,le.avelength_individual_source10,le.avelength_email_status,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_raw_aid,le.avelength_ace_aid,le.avelength_prep_address_line1,le.avelength_prep_address_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 124, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.clean_company_name),TRIM((SALT311.StrType)le.clean_area_code),TRIM((SALT311.StrType)le.clean_telephone_num),TRIM((SALT311.StrType)le.mail_score_desc),TRIM((SALT311.StrType)le.name_gender_desc),TRIM((SALT311.StrType)le.title_desc_1),TRIM((SALT311.StrType)le.title_desc_2),TRIM((SALT311.StrType)le.title_desc_3),TRIM((SALT311.StrType)le.title_desc_4),TRIM((SALT311.StrType)le.sic8_desc_1),TRIM((SALT311.StrType)le.sic8_desc_2),TRIM((SALT311.StrType)le.sic8_desc_3),TRIM((SALT311.StrType)le.sic8_desc_4),TRIM((SALT311.StrType)le.sic6_desc_1),TRIM((SALT311.StrType)le.sic6_desc_2),TRIM((SALT311.StrType)le.sic6_desc_3),TRIM((SALT311.StrType)le.sic6_desc_4),TRIM((SALT311.StrType)le.sic6_desc_5),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.company),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.scf),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.area_code),TRIM((SALT311.StrType)le.telephone_number),TRIM((SALT311.StrType)le.name_gender),TRIM((SALT311.StrType)le.name_prefix),TRIM((SALT311.StrType)le.name_first),TRIM((SALT311.StrType)le.name_middle_initial),TRIM((SALT311.StrType)le.name_last),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.title_code_1),TRIM((SALT311.StrType)le.title_code_2),TRIM((SALT311.StrType)le.title_code_3),TRIM((SALT311.StrType)le.title_code_4),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.sic8_1),TRIM((SALT311.StrType)le.sic8_2),TRIM((SALT311.StrType)le.sic8_3),TRIM((SALT311.StrType)le.sic8_4),TRIM((SALT311.StrType)le.sic6_1),TRIM((SALT311.StrType)le.sic6_2),TRIM((SALT311.StrType)le.sic6_3),TRIM((SALT311.StrType)le.sic6_4),TRIM((SALT311.StrType)le.sic6_5),TRIM((SALT311.StrType)le.transaction_date),TRIM((SALT311.StrType)le.database_site_id),TRIM((SALT311.StrType)le.database_individual_id),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_present_flag),TRIM((SALT311.StrType)le.site_source1),TRIM((SALT311.StrType)le.site_source2),TRIM((SALT311.StrType)le.site_source3),TRIM((SALT311.StrType)le.site_source4),TRIM((SALT311.StrType)le.site_source5),TRIM((SALT311.StrType)le.site_source6),TRIM((SALT311.StrType)le.site_source7),TRIM((SALT311.StrType)le.site_source8),TRIM((SALT311.StrType)le.site_source9),TRIM((SALT311.StrType)le.site_source10),TRIM((SALT311.StrType)le.individual_source1),TRIM((SALT311.StrType)le.individual_source2),TRIM((SALT311.StrType)le.individual_source3),TRIM((SALT311.StrType)le.individual_source4),TRIM((SALT311.StrType)le.individual_source5),TRIM((SALT311.StrType)le.individual_source6),TRIM((SALT311.StrType)le.individual_source7),TRIM((SALT311.StrType)le.individual_source8),TRIM((SALT311.StrType)le.individual_source9),TRIM((SALT311.StrType)le.individual_source10),TRIM((SALT311.StrType)le.email_status),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),TRIM((SALT311.StrType)le.prep_address_line1),TRIM((SALT311.StrType)le.prep_address_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,124,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 124);
  SELF.FldNo2 := 1 + (C % 124);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.clean_company_name),TRIM((SALT311.StrType)le.clean_area_code),TRIM((SALT311.StrType)le.clean_telephone_num),TRIM((SALT311.StrType)le.mail_score_desc),TRIM((SALT311.StrType)le.name_gender_desc),TRIM((SALT311.StrType)le.title_desc_1),TRIM((SALT311.StrType)le.title_desc_2),TRIM((SALT311.StrType)le.title_desc_3),TRIM((SALT311.StrType)le.title_desc_4),TRIM((SALT311.StrType)le.sic8_desc_1),TRIM((SALT311.StrType)le.sic8_desc_2),TRIM((SALT311.StrType)le.sic8_desc_3),TRIM((SALT311.StrType)le.sic8_desc_4),TRIM((SALT311.StrType)le.sic6_desc_1),TRIM((SALT311.StrType)le.sic6_desc_2),TRIM((SALT311.StrType)le.sic6_desc_3),TRIM((SALT311.StrType)le.sic6_desc_4),TRIM((SALT311.StrType)le.sic6_desc_5),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.company),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.scf),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.area_code),TRIM((SALT311.StrType)le.telephone_number),TRIM((SALT311.StrType)le.name_gender),TRIM((SALT311.StrType)le.name_prefix),TRIM((SALT311.StrType)le.name_first),TRIM((SALT311.StrType)le.name_middle_initial),TRIM((SALT311.StrType)le.name_last),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.title_code_1),TRIM((SALT311.StrType)le.title_code_2),TRIM((SALT311.StrType)le.title_code_3),TRIM((SALT311.StrType)le.title_code_4),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.sic8_1),TRIM((SALT311.StrType)le.sic8_2),TRIM((SALT311.StrType)le.sic8_3),TRIM((SALT311.StrType)le.sic8_4),TRIM((SALT311.StrType)le.sic6_1),TRIM((SALT311.StrType)le.sic6_2),TRIM((SALT311.StrType)le.sic6_3),TRIM((SALT311.StrType)le.sic6_4),TRIM((SALT311.StrType)le.sic6_5),TRIM((SALT311.StrType)le.transaction_date),TRIM((SALT311.StrType)le.database_site_id),TRIM((SALT311.StrType)le.database_individual_id),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_present_flag),TRIM((SALT311.StrType)le.site_source1),TRIM((SALT311.StrType)le.site_source2),TRIM((SALT311.StrType)le.site_source3),TRIM((SALT311.StrType)le.site_source4),TRIM((SALT311.StrType)le.site_source5),TRIM((SALT311.StrType)le.site_source6),TRIM((SALT311.StrType)le.site_source7),TRIM((SALT311.StrType)le.site_source8),TRIM((SALT311.StrType)le.site_source9),TRIM((SALT311.StrType)le.site_source10),TRIM((SALT311.StrType)le.individual_source1),TRIM((SALT311.StrType)le.individual_source2),TRIM((SALT311.StrType)le.individual_source3),TRIM((SALT311.StrType)le.individual_source4),TRIM((SALT311.StrType)le.individual_source5),TRIM((SALT311.StrType)le.individual_source6),TRIM((SALT311.StrType)le.individual_source7),TRIM((SALT311.StrType)le.individual_source8),TRIM((SALT311.StrType)le.individual_source9),TRIM((SALT311.StrType)le.individual_source10),TRIM((SALT311.StrType)le.email_status),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),TRIM((SALT311.StrType)le.prep_address_line1),TRIM((SALT311.StrType)le.prep_address_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.clean_company_name),TRIM((SALT311.StrType)le.clean_area_code),TRIM((SALT311.StrType)le.clean_telephone_num),TRIM((SALT311.StrType)le.mail_score_desc),TRIM((SALT311.StrType)le.name_gender_desc),TRIM((SALT311.StrType)le.title_desc_1),TRIM((SALT311.StrType)le.title_desc_2),TRIM((SALT311.StrType)le.title_desc_3),TRIM((SALT311.StrType)le.title_desc_4),TRIM((SALT311.StrType)le.sic8_desc_1),TRIM((SALT311.StrType)le.sic8_desc_2),TRIM((SALT311.StrType)le.sic8_desc_3),TRIM((SALT311.StrType)le.sic8_desc_4),TRIM((SALT311.StrType)le.sic6_desc_1),TRIM((SALT311.StrType)le.sic6_desc_2),TRIM((SALT311.StrType)le.sic6_desc_3),TRIM((SALT311.StrType)le.sic6_desc_4),TRIM((SALT311.StrType)le.sic6_desc_5),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.company),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.scf),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.area_code),TRIM((SALT311.StrType)le.telephone_number),TRIM((SALT311.StrType)le.name_gender),TRIM((SALT311.StrType)le.name_prefix),TRIM((SALT311.StrType)le.name_first),TRIM((SALT311.StrType)le.name_middle_initial),TRIM((SALT311.StrType)le.name_last),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.title_code_1),TRIM((SALT311.StrType)le.title_code_2),TRIM((SALT311.StrType)le.title_code_3),TRIM((SALT311.StrType)le.title_code_4),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.sic8_1),TRIM((SALT311.StrType)le.sic8_2),TRIM((SALT311.StrType)le.sic8_3),TRIM((SALT311.StrType)le.sic8_4),TRIM((SALT311.StrType)le.sic6_1),TRIM((SALT311.StrType)le.sic6_2),TRIM((SALT311.StrType)le.sic6_3),TRIM((SALT311.StrType)le.sic6_4),TRIM((SALT311.StrType)le.sic6_5),TRIM((SALT311.StrType)le.transaction_date),TRIM((SALT311.StrType)le.database_site_id),TRIM((SALT311.StrType)le.database_individual_id),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_present_flag),TRIM((SALT311.StrType)le.site_source1),TRIM((SALT311.StrType)le.site_source2),TRIM((SALT311.StrType)le.site_source3),TRIM((SALT311.StrType)le.site_source4),TRIM((SALT311.StrType)le.site_source5),TRIM((SALT311.StrType)le.site_source6),TRIM((SALT311.StrType)le.site_source7),TRIM((SALT311.StrType)le.site_source8),TRIM((SALT311.StrType)le.site_source9),TRIM((SALT311.StrType)le.site_source10),TRIM((SALT311.StrType)le.individual_source1),TRIM((SALT311.StrType)le.individual_source2),TRIM((SALT311.StrType)le.individual_source3),TRIM((SALT311.StrType)le.individual_source4),TRIM((SALT311.StrType)le.individual_source5),TRIM((SALT311.StrType)le.individual_source6),TRIM((SALT311.StrType)le.individual_source7),TRIM((SALT311.StrType)le.individual_source8),TRIM((SALT311.StrType)le.individual_source9),TRIM((SALT311.StrType)le.individual_source10),TRIM((SALT311.StrType)le.email_status),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.raw_aid <> 0,TRIM((SALT311.StrType)le.raw_aid), ''),IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),TRIM((SALT311.StrType)le.prep_address_line1),TRIM((SALT311.StrType)le.prep_address_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),124*124,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'powid'}
      ,{2,'proxid'}
      ,{3,'seleid'}
      ,{4,'orgid'}
      ,{5,'ultid'}
      ,{6,'bdid'}
      ,{7,'did'}
      ,{8,'dt_first_seen'}
      ,{9,'dt_last_seen'}
      ,{10,'dt_vendor_first_reported'}
      ,{11,'dt_vendor_last_reported'}
      ,{12,'process_date'}
      ,{13,'record_type'}
      ,{14,'clean_company_name'}
      ,{15,'clean_area_code'}
      ,{16,'clean_telephone_num'}
      ,{17,'mail_score_desc'}
      ,{18,'name_gender_desc'}
      ,{19,'title_desc_1'}
      ,{20,'title_desc_2'}
      ,{21,'title_desc_3'}
      ,{22,'title_desc_4'}
      ,{23,'sic8_desc_1'}
      ,{24,'sic8_desc_2'}
      ,{25,'sic8_desc_3'}
      ,{26,'sic8_desc_4'}
      ,{27,'sic6_desc_1'}
      ,{28,'sic6_desc_2'}
      ,{29,'sic6_desc_3'}
      ,{30,'sic6_desc_4'}
      ,{31,'sic6_desc_5'}
      ,{32,'name'}
      ,{33,'company'}
      ,{34,'address'}
      ,{35,'address2'}
      ,{36,'city'}
      ,{37,'state'}
      ,{38,'scf'}
      ,{39,'zip'}
      ,{40,'zip4'}
      ,{41,'mail_score'}
      ,{42,'area_code'}
      ,{43,'telephone_number'}
      ,{44,'name_gender'}
      ,{45,'name_prefix'}
      ,{46,'name_first'}
      ,{47,'name_middle_initial'}
      ,{48,'name_last'}
      ,{49,'suffix'}
      ,{50,'title_code_1'}
      ,{51,'title_code_2'}
      ,{52,'title_code_3'}
      ,{53,'title_code_4'}
      ,{54,'web_address'}
      ,{55,'sic8_1'}
      ,{56,'sic8_2'}
      ,{57,'sic8_3'}
      ,{58,'sic8_4'}
      ,{59,'sic6_1'}
      ,{60,'sic6_2'}
      ,{61,'sic6_3'}
      ,{62,'sic6_4'}
      ,{63,'sic6_5'}
      ,{64,'transaction_date'}
      ,{65,'database_site_id'}
      ,{66,'database_individual_id'}
      ,{67,'email'}
      ,{68,'email_present_flag'}
      ,{69,'site_source1'}
      ,{70,'site_source2'}
      ,{71,'site_source3'}
      ,{72,'site_source4'}
      ,{73,'site_source5'}
      ,{74,'site_source6'}
      ,{75,'site_source7'}
      ,{76,'site_source8'}
      ,{77,'site_source9'}
      ,{78,'site_source10'}
      ,{79,'individual_source1'}
      ,{80,'individual_source2'}
      ,{81,'individual_source3'}
      ,{82,'individual_source4'}
      ,{83,'individual_source5'}
      ,{84,'individual_source6'}
      ,{85,'individual_source7'}
      ,{86,'individual_source8'}
      ,{87,'individual_source9'}
      ,{88,'individual_source10'}
      ,{89,'email_status'}
      ,{90,'title'}
      ,{91,'fname'}
      ,{92,'mname'}
      ,{93,'lname'}
      ,{94,'name_suffix'}
      ,{95,'name_score'}
      ,{96,'prim_range'}
      ,{97,'predir'}
      ,{98,'prim_name'}
      ,{99,'addr_suffix'}
      ,{100,'postdir'}
      ,{101,'unit_desig'}
      ,{102,'sec_range'}
      ,{103,'p_city_name'}
      ,{104,'v_city_name'}
      ,{105,'st'}
      ,{106,'cart'}
      ,{107,'cr_sort_sz'}
      ,{108,'lot'}
      ,{109,'lot_order'}
      ,{110,'dbpc'}
      ,{111,'chk_digit'}
      ,{112,'rec_type'}
      ,{113,'fips_state'}
      ,{114,'fips_county'}
      ,{115,'geo_lat'}
      ,{116,'geo_long'}
      ,{117,'msa'}
      ,{118,'geo_blk'}
      ,{119,'geo_match'}
      ,{120,'err_stat'}
      ,{121,'raw_aid'}
      ,{122,'ace_aid'}
      ,{123,'prep_address_line1'}
      ,{124,'prep_address_line_last'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_Fields.InValid_did((SALT311.StrType)le.did),
    Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_Fields.InValid_clean_company_name((SALT311.StrType)le.clean_company_name),
    Base_Fields.InValid_clean_area_code((SALT311.StrType)le.clean_area_code),
    Base_Fields.InValid_clean_telephone_num((SALT311.StrType)le.clean_telephone_num),
    Base_Fields.InValid_mail_score_desc((SALT311.StrType)le.mail_score_desc),
    Base_Fields.InValid_name_gender_desc((SALT311.StrType)le.name_gender_desc),
    Base_Fields.InValid_title_desc_1((SALT311.StrType)le.title_desc_1),
    Base_Fields.InValid_title_desc_2((SALT311.StrType)le.title_desc_2),
    Base_Fields.InValid_title_desc_3((SALT311.StrType)le.title_desc_3),
    Base_Fields.InValid_title_desc_4((SALT311.StrType)le.title_desc_4),
    Base_Fields.InValid_sic8_desc_1((SALT311.StrType)le.sic8_desc_1),
    Base_Fields.InValid_sic8_desc_2((SALT311.StrType)le.sic8_desc_2),
    Base_Fields.InValid_sic8_desc_3((SALT311.StrType)le.sic8_desc_3),
    Base_Fields.InValid_sic8_desc_4((SALT311.StrType)le.sic8_desc_4),
    Base_Fields.InValid_sic6_desc_1((SALT311.StrType)le.sic6_desc_1),
    Base_Fields.InValid_sic6_desc_2((SALT311.StrType)le.sic6_desc_2),
    Base_Fields.InValid_sic6_desc_3((SALT311.StrType)le.sic6_desc_3),
    Base_Fields.InValid_sic6_desc_4((SALT311.StrType)le.sic6_desc_4),
    Base_Fields.InValid_sic6_desc_5((SALT311.StrType)le.sic6_desc_5),
    Base_Fields.InValid_name((SALT311.StrType)le.name),
    Base_Fields.InValid_company((SALT311.StrType)le.company),
    Base_Fields.InValid_address((SALT311.StrType)le.address),
    Base_Fields.InValid_address2((SALT311.StrType)le.address2),
    Base_Fields.InValid_city((SALT311.StrType)le.city),
    Base_Fields.InValid_state((SALT311.StrType)le.state),
    Base_Fields.InValid_scf((SALT311.StrType)le.scf),
    Base_Fields.InValid_zip((SALT311.StrType)le.zip),
    Base_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Base_Fields.InValid_mail_score((SALT311.StrType)le.mail_score),
    Base_Fields.InValid_area_code((SALT311.StrType)le.area_code),
    Base_Fields.InValid_telephone_number((SALT311.StrType)le.telephone_number),
    Base_Fields.InValid_name_gender((SALT311.StrType)le.name_gender),
    Base_Fields.InValid_name_prefix((SALT311.StrType)le.name_prefix),
    Base_Fields.InValid_name_first((SALT311.StrType)le.name_first),
    Base_Fields.InValid_name_middle_initial((SALT311.StrType)le.name_middle_initial),
    Base_Fields.InValid_name_last((SALT311.StrType)le.name_last),
    Base_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Base_Fields.InValid_title_code_1((SALT311.StrType)le.title_code_1),
    Base_Fields.InValid_title_code_2((SALT311.StrType)le.title_code_2),
    Base_Fields.InValid_title_code_3((SALT311.StrType)le.title_code_3),
    Base_Fields.InValid_title_code_4((SALT311.StrType)le.title_code_4),
    Base_Fields.InValid_web_address((SALT311.StrType)le.web_address),
    Base_Fields.InValid_sic8_1((SALT311.StrType)le.sic8_1),
    Base_Fields.InValid_sic8_2((SALT311.StrType)le.sic8_2),
    Base_Fields.InValid_sic8_3((SALT311.StrType)le.sic8_3),
    Base_Fields.InValid_sic8_4((SALT311.StrType)le.sic8_4),
    Base_Fields.InValid_sic6_1((SALT311.StrType)le.sic6_1),
    Base_Fields.InValid_sic6_2((SALT311.StrType)le.sic6_2),
    Base_Fields.InValid_sic6_3((SALT311.StrType)le.sic6_3),
    Base_Fields.InValid_sic6_4((SALT311.StrType)le.sic6_4),
    Base_Fields.InValid_sic6_5((SALT311.StrType)le.sic6_5),
    Base_Fields.InValid_transaction_date((SALT311.StrType)le.transaction_date),
    Base_Fields.InValid_database_site_id((SALT311.StrType)le.database_site_id),
    Base_Fields.InValid_database_individual_id((SALT311.StrType)le.database_individual_id),
    Base_Fields.InValid_email((SALT311.StrType)le.email),
    Base_Fields.InValid_email_present_flag((SALT311.StrType)le.email_present_flag),
    Base_Fields.InValid_site_source1((SALT311.StrType)le.site_source1),
    Base_Fields.InValid_site_source2((SALT311.StrType)le.site_source2),
    Base_Fields.InValid_site_source3((SALT311.StrType)le.site_source3),
    Base_Fields.InValid_site_source4((SALT311.StrType)le.site_source4),
    Base_Fields.InValid_site_source5((SALT311.StrType)le.site_source5),
    Base_Fields.InValid_site_source6((SALT311.StrType)le.site_source6),
    Base_Fields.InValid_site_source7((SALT311.StrType)le.site_source7),
    Base_Fields.InValid_site_source8((SALT311.StrType)le.site_source8),
    Base_Fields.InValid_site_source9((SALT311.StrType)le.site_source9),
    Base_Fields.InValid_site_source10((SALT311.StrType)le.site_source10),
    Base_Fields.InValid_individual_source1((SALT311.StrType)le.individual_source1),
    Base_Fields.InValid_individual_source2((SALT311.StrType)le.individual_source2),
    Base_Fields.InValid_individual_source3((SALT311.StrType)le.individual_source3),
    Base_Fields.InValid_individual_source4((SALT311.StrType)le.individual_source4),
    Base_Fields.InValid_individual_source5((SALT311.StrType)le.individual_source5),
    Base_Fields.InValid_individual_source6((SALT311.StrType)le.individual_source6),
    Base_Fields.InValid_individual_source7((SALT311.StrType)le.individual_source7),
    Base_Fields.InValid_individual_source8((SALT311.StrType)le.individual_source8),
    Base_Fields.InValid_individual_source9((SALT311.StrType)le.individual_source9),
    Base_Fields.InValid_individual_source10((SALT311.StrType)le.individual_source10),
    Base_Fields.InValid_email_status((SALT311.StrType)le.email_status),
    Base_Fields.InValid_title((SALT311.StrType)le.title),
    Base_Fields.InValid_fname((SALT311.StrType)le.fname),
    Base_Fields.InValid_mname((SALT311.StrType)le.mname),
    Base_Fields.InValid_lname((SALT311.StrType)le.lname),
    Base_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Base_Fields.InValid_name_score((SALT311.StrType)le.name_score),
    Base_Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Base_Fields.InValid_predir((SALT311.StrType)le.predir),
    Base_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Base_Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Base_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Base_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Base_Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Base_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Base_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Base_Fields.InValid_st((SALT311.StrType)le.st),
    Base_Fields.InValid_cart((SALT311.StrType)le.cart),
    Base_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Base_Fields.InValid_lot((SALT311.StrType)le.lot),
    Base_Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Base_Fields.InValid_dbpc((SALT311.StrType)le.dbpc),
    Base_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Base_Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Base_Fields.InValid_fips_state((SALT311.StrType)le.fips_state),
    Base_Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Base_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Base_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Base_Fields.InValid_msa((SALT311.StrType)le.msa),
    Base_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Base_Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Base_Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Base_Fields.InValid_raw_aid((SALT311.StrType)le.raw_aid),
    Base_Fields.InValid_ace_aid((SALT311.StrType)le.ace_aid),
    Base_Fields.InValid_prep_address_line1((SALT311.StrType)le.prep_address_line1),
    Base_Fields.InValid_prep_address_line_last((SALT311.StrType)le.prep_address_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,124,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_generaldate','invalid_record_type','invalid_mandatory','Unknown','invalid_phone','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_st','Unknown','invalid_zip5','Unknown','invalid_mail_score','Unknown','Unknown','invalid_gender_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_url','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','Unknown','invalid_numeric','invalid_numeric','invalid_email','invalid_email_present_flag','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_email_status','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_area_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_telephone_num(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mail_score_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_gender_desc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title_desc_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title_desc_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title_desc_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title_desc_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_desc_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_desc_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_desc_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_desc_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_desc_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_desc_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_desc_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_desc_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_desc_5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_city(TotalErrors.ErrorNum),Base_Fields.InValidMessage_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_scf(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mail_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_area_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_telephone_number(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_gender(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_prefix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_first(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_middle_initial(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_last(TotalErrors.ErrorNum),Base_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title_code_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title_code_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title_code_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title_code_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_web_address(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_transaction_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_database_site_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_database_individual_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email_present_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source8(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source9(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source10(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source8(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source9(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source10(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email_status(TotalErrors.ErrorNum),Base_Fields.InValidMessage_title(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_st(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_raw_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_address_line1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prep_address_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DataBridge, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
