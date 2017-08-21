IMPORT SALT36;
EXPORT hygiene(dataset(layout_in_BusReg) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT36.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ofc1_name_pcnt := AVE(GROUP,IF(h.ofc1_name = (TYPEOF(h.ofc1_name))'',0,100));
    maxlength_ofc1_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_name)));
    avelength_ofc1_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_name)),h.ofc1_name<>(typeof(h.ofc1_name))'');
    populated_ofc1_title_pcnt := AVE(GROUP,IF(h.ofc1_title = (TYPEOF(h.ofc1_title))'',0,100));
    maxlength_ofc1_title := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_title)));
    avelength_ofc1_title := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_title)),h.ofc1_title<>(typeof(h.ofc1_title))'');
    populated_ofc1_gender_pcnt := AVE(GROUP,IF(h.ofc1_gender = (TYPEOF(h.ofc1_gender))'',0,100));
    maxlength_ofc1_gender := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_gender)));
    avelength_ofc1_gender := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_gender)),h.ofc1_gender<>(typeof(h.ofc1_gender))'');
    populated_ofc1_add_pcnt := AVE(GROUP,IF(h.ofc1_add = (TYPEOF(h.ofc1_add))'',0,100));
    maxlength_ofc1_add := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_add)));
    avelength_ofc1_add := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_add)),h.ofc1_add<>(typeof(h.ofc1_add))'');
    populated_ofc1_suite_pcnt := AVE(GROUP,IF(h.ofc1_suite = (TYPEOF(h.ofc1_suite))'',0,100));
    maxlength_ofc1_suite := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_suite)));
    avelength_ofc1_suite := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_suite)),h.ofc1_suite<>(typeof(h.ofc1_suite))'');
    populated_ofc1_city_pcnt := AVE(GROUP,IF(h.ofc1_city = (TYPEOF(h.ofc1_city))'',0,100));
    maxlength_ofc1_city := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_city)));
    avelength_ofc1_city := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_city)),h.ofc1_city<>(typeof(h.ofc1_city))'');
    populated_ofc1_state_pcnt := AVE(GROUP,IF(h.ofc1_state = (TYPEOF(h.ofc1_state))'',0,100));
    maxlength_ofc1_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_state)));
    avelength_ofc1_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_state)),h.ofc1_state<>(typeof(h.ofc1_state))'');
    populated_ofc1_zip_pcnt := AVE(GROUP,IF(h.ofc1_zip = (TYPEOF(h.ofc1_zip))'',0,100));
    maxlength_ofc1_zip := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_zip)));
    avelength_ofc1_zip := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_zip)),h.ofc1_zip<>(typeof(h.ofc1_zip))'');
    populated_ofc1_ac_pcnt := AVE(GROUP,IF(h.ofc1_ac = (TYPEOF(h.ofc1_ac))'',0,100));
    maxlength_ofc1_ac := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_ac)));
    avelength_ofc1_ac := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_ac)),h.ofc1_ac<>(typeof(h.ofc1_ac))'');
    populated_ofc1_phone_pcnt := AVE(GROUP,IF(h.ofc1_phone = (TYPEOF(h.ofc1_phone))'',0,100));
    maxlength_ofc1_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_phone)));
    avelength_ofc1_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_phone)),h.ofc1_phone<>(typeof(h.ofc1_phone))'');
    populated_ofc1_fein_pcnt := AVE(GROUP,IF(h.ofc1_fein = (TYPEOF(h.ofc1_fein))'',0,100));
    maxlength_ofc1_fein := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_fein)));
    avelength_ofc1_fein := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_fein)),h.ofc1_fein<>(typeof(h.ofc1_fein))'');
    populated_ofc1_ssn_pcnt := AVE(GROUP,IF(h.ofc1_ssn = (TYPEOF(h.ofc1_ssn))'',0,100));
    maxlength_ofc1_ssn := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_ssn)));
    avelength_ofc1_ssn := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_ssn)),h.ofc1_ssn<>(typeof(h.ofc1_ssn))'');
    populated_ofc1_type_pcnt := AVE(GROUP,IF(h.ofc1_type = (TYPEOF(h.ofc1_type))'',0,100));
    maxlength_ofc1_type := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_type)));
    avelength_ofc1_type := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc1_type)),h.ofc1_type<>(typeof(h.ofc1_type))'');
    populated_company_pcnt := AVE(GROUP,IF(h.company = (TYPEOF(h.company))'',0,100));
    maxlength_company := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.company)));
    avelength_company := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.company)),h.company<>(typeof(h.company))'');
    populated_mail_add_pcnt := AVE(GROUP,IF(h.mail_add = (TYPEOF(h.mail_add))'',0,100));
    maxlength_mail_add := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_add)));
    avelength_mail_add := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_add)),h.mail_add<>(typeof(h.mail_add))'');
    populated_mail_suite_pcnt := AVE(GROUP,IF(h.mail_suite = (TYPEOF(h.mail_suite))'',0,100));
    maxlength_mail_suite := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_suite)));
    avelength_mail_suite := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_suite)),h.mail_suite<>(typeof(h.mail_suite))'');
    populated_mail_city_pcnt := AVE(GROUP,IF(h.mail_city = (TYPEOF(h.mail_city))'',0,100));
    maxlength_mail_city := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_city)));
    avelength_mail_city := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_city)),h.mail_city<>(typeof(h.mail_city))'');
    populated_mail_state_pcnt := AVE(GROUP,IF(h.mail_state = (TYPEOF(h.mail_state))'',0,100));
    maxlength_mail_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_state)));
    avelength_mail_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_state)),h.mail_state<>(typeof(h.mail_state))'');
    populated_mail_zip_pcnt := AVE(GROUP,IF(h.mail_zip = (TYPEOF(h.mail_zip))'',0,100));
    maxlength_mail_zip := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_zip)));
    avelength_mail_zip := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_zip)),h.mail_zip<>(typeof(h.mail_zip))'');
    populated_mail_zip4_pcnt := AVE(GROUP,IF(h.mail_zip4 = (TYPEOF(h.mail_zip4))'',0,100));
    maxlength_mail_zip4 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_zip4)));
    avelength_mail_zip4 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_zip4)),h.mail_zip4<>(typeof(h.mail_zip4))'');
    populated_mail_key_pcnt := AVE(GROUP,IF(h.mail_key = (TYPEOF(h.mail_key))'',0,100));
    maxlength_mail_key := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_key)));
    avelength_mail_key := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mail_key)),h.mail_key<>(typeof(h.mail_key))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_district_pcnt := AVE(GROUP,IF(h.district = (TYPEOF(h.district))'',0,100));
    maxlength_district := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.district)));
    avelength_district := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.district)),h.district<>(typeof(h.district))'');
    populated_biz_ac_pcnt := AVE(GROUP,IF(h.biz_ac = (TYPEOF(h.biz_ac))'',0,100));
    maxlength_biz_ac := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.biz_ac)));
    avelength_biz_ac := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.biz_ac)),h.biz_ac<>(typeof(h.biz_ac))'');
    populated_biz_phone_pcnt := AVE(GROUP,IF(h.biz_phone = (TYPEOF(h.biz_phone))'',0,100));
    maxlength_biz_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.biz_phone)));
    avelength_biz_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.biz_phone)),h.biz_phone<>(typeof(h.biz_phone))'');
    populated_sic_pcnt := AVE(GROUP,IF(h.sic = (TYPEOF(h.sic))'',0,100));
    maxlength_sic := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.sic)));
    avelength_sic := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.sic)),h.sic<>(typeof(h.sic))'');
    populated_naics_pcnt := AVE(GROUP,IF(h.naics = (TYPEOF(h.naics))'',0,100));
    maxlength_naics := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.naics)));
    avelength_naics := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.naics)),h.naics<>(typeof(h.naics))'');
    populated_descript_pcnt := AVE(GROUP,IF(h.descript = (TYPEOF(h.descript))'',0,100));
    maxlength_descript := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.descript)));
    avelength_descript := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.descript)),h.descript<>(typeof(h.descript))'');
    populated_emp_size_pcnt := AVE(GROUP,IF(h.emp_size = (TYPEOF(h.emp_size))'',0,100));
    maxlength_emp_size := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.emp_size)));
    avelength_emp_size := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.emp_size)),h.emp_size<>(typeof(h.emp_size))'');
    populated_own_size_pcnt := AVE(GROUP,IF(h.own_size = (TYPEOF(h.own_size))'',0,100));
    maxlength_own_size := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.own_size)));
    avelength_own_size := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.own_size)),h.own_size<>(typeof(h.own_size))'');
    populated_corpcode_pcnt := AVE(GROUP,IF(h.corpcode = (TYPEOF(h.corpcode))'',0,100));
    maxlength_corpcode := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.corpcode)));
    avelength_corpcode := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.corpcode)),h.corpcode<>(typeof(h.corpcode))'');
    populated_sos_code_pcnt := AVE(GROUP,IF(h.sos_code = (TYPEOF(h.sos_code))'',0,100));
    maxlength_sos_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.sos_code)));
    avelength_sos_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.sos_code)),h.sos_code<>(typeof(h.sos_code))'');
    populated_filing_cod_pcnt := AVE(GROUP,IF(h.filing_cod = (TYPEOF(h.filing_cod))'',0,100));
    maxlength_filing_cod := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filing_cod)));
    avelength_filing_cod := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filing_cod)),h.filing_cod<>(typeof(h.filing_cod))'');
    populated_state_code_pcnt := AVE(GROUP,IF(h.state_code = (TYPEOF(h.state_code))'',0,100));
    maxlength_state_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.state_code)));
    avelength_state_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.state_code)),h.state_code<>(typeof(h.state_code))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_filing_num_pcnt := AVE(GROUP,IF(h.filing_num = (TYPEOF(h.filing_num))'',0,100));
    maxlength_filing_num := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filing_num)));
    avelength_filing_num := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filing_num)),h.filing_num<>(typeof(h.filing_num))'');
    populated_ctrl_num_pcnt := AVE(GROUP,IF(h.ctrl_num = (TYPEOF(h.ctrl_num))'',0,100));
    maxlength_ctrl_num := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ctrl_num)));
    avelength_ctrl_num := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ctrl_num)),h.ctrl_num<>(typeof(h.ctrl_num))'');
    populated_start_date_pcnt := AVE(GROUP,IF(h.start_date = (TYPEOF(h.start_date))'',0,100));
    maxlength_start_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.start_date)));
    avelength_start_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.start_date)),h.start_date<>(typeof(h.start_date))'');
    populated_file_date_pcnt := AVE(GROUP,IF(h.file_date = (TYPEOF(h.file_date))'',0,100));
    maxlength_file_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.file_date)));
    avelength_file_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.file_date)),h.file_date<>(typeof(h.file_date))'');
    populated_form_date_pcnt := AVE(GROUP,IF(h.form_date = (TYPEOF(h.form_date))'',0,100));
    maxlength_form_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.form_date)));
    avelength_form_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.form_date)),h.form_date<>(typeof(h.form_date))'');
    populated_exp_date_pcnt := AVE(GROUP,IF(h.exp_date = (TYPEOF(h.exp_date))'',0,100));
    maxlength_exp_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.exp_date)));
    avelength_exp_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.exp_date)),h.exp_date<>(typeof(h.exp_date))'');
    populated_disol_date_pcnt := AVE(GROUP,IF(h.disol_date = (TYPEOF(h.disol_date))'',0,100));
    maxlength_disol_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.disol_date)));
    avelength_disol_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.disol_date)),h.disol_date<>(typeof(h.disol_date))'');
    populated_rpt_date_pcnt := AVE(GROUP,IF(h.rpt_date = (TYPEOF(h.rpt_date))'',0,100));
    maxlength_rpt_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.rpt_date)));
    avelength_rpt_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.rpt_date)),h.rpt_date<>(typeof(h.rpt_date))'');
    populated_chang_date_pcnt := AVE(GROUP,IF(h.chang_date = (TYPEOF(h.chang_date))'',0,100));
    maxlength_chang_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.chang_date)));
    avelength_chang_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.chang_date)),h.chang_date<>(typeof(h.chang_date))'');
    populated_loc_add_pcnt := AVE(GROUP,IF(h.loc_add = (TYPEOF(h.loc_add))'',0,100));
    maxlength_loc_add := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_add)));
    avelength_loc_add := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_add)),h.loc_add<>(typeof(h.loc_add))'');
    populated_loc_suite_pcnt := AVE(GROUP,IF(h.loc_suite = (TYPEOF(h.loc_suite))'',0,100));
    maxlength_loc_suite := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_suite)));
    avelength_loc_suite := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_suite)),h.loc_suite<>(typeof(h.loc_suite))'');
    populated_loc_city_pcnt := AVE(GROUP,IF(h.loc_city = (TYPEOF(h.loc_city))'',0,100));
    maxlength_loc_city := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_city)));
    avelength_loc_city := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_city)),h.loc_city<>(typeof(h.loc_city))'');
    populated_loc_state_pcnt := AVE(GROUP,IF(h.loc_state = (TYPEOF(h.loc_state))'',0,100));
    maxlength_loc_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_state)));
    avelength_loc_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_state)),h.loc_state<>(typeof(h.loc_state))'');
    populated_loc_zip_pcnt := AVE(GROUP,IF(h.loc_zip = (TYPEOF(h.loc_zip))'',0,100));
    maxlength_loc_zip := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_zip)));
    avelength_loc_zip := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_zip)),h.loc_zip<>(typeof(h.loc_zip))'');
    populated_loc_zip4_pcnt := AVE(GROUP,IF(h.loc_zip4 = (TYPEOF(h.loc_zip4))'',0,100));
    maxlength_loc_zip4 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_zip4)));
    avelength_loc_zip4 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_zip4)),h.loc_zip4<>(typeof(h.loc_zip4))'');
    populated_ofc2_name_pcnt := AVE(GROUP,IF(h.ofc2_name = (TYPEOF(h.ofc2_name))'',0,100));
    maxlength_ofc2_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_name)));
    avelength_ofc2_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_name)),h.ofc2_name<>(typeof(h.ofc2_name))'');
    populated_ofc2_title_pcnt := AVE(GROUP,IF(h.ofc2_title = (TYPEOF(h.ofc2_title))'',0,100));
    maxlength_ofc2_title := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_title)));
    avelength_ofc2_title := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_title)),h.ofc2_title<>(typeof(h.ofc2_title))'');
    populated_ofc2_add_pcnt := AVE(GROUP,IF(h.ofc2_add = (TYPEOF(h.ofc2_add))'',0,100));
    maxlength_ofc2_add := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_add)));
    avelength_ofc2_add := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_add)),h.ofc2_add<>(typeof(h.ofc2_add))'');
    populated_ofc2_csz_pcnt := AVE(GROUP,IF(h.ofc2_csz = (TYPEOF(h.ofc2_csz))'',0,100));
    maxlength_ofc2_csz := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_csz)));
    avelength_ofc2_csz := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_csz)),h.ofc2_csz<>(typeof(h.ofc2_csz))'');
    populated_ofc2_fein_pcnt := AVE(GROUP,IF(h.ofc2_fein = (TYPEOF(h.ofc2_fein))'',0,100));
    maxlength_ofc2_fein := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_fein)));
    avelength_ofc2_fein := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_fein)),h.ofc2_fein<>(typeof(h.ofc2_fein))'');
    populated_ofc2_ssn_pcnt := AVE(GROUP,IF(h.ofc2_ssn = (TYPEOF(h.ofc2_ssn))'',0,100));
    maxlength_ofc2_ssn := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_ssn)));
    avelength_ofc2_ssn := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc2_ssn)),h.ofc2_ssn<>(typeof(h.ofc2_ssn))'');
    populated_ofc3_name_pcnt := AVE(GROUP,IF(h.ofc3_name = (TYPEOF(h.ofc3_name))'',0,100));
    maxlength_ofc3_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_name)));
    avelength_ofc3_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_name)),h.ofc3_name<>(typeof(h.ofc3_name))'');
    populated_ofc3_title_pcnt := AVE(GROUP,IF(h.ofc3_title = (TYPEOF(h.ofc3_title))'',0,100));
    maxlength_ofc3_title := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_title)));
    avelength_ofc3_title := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_title)),h.ofc3_title<>(typeof(h.ofc3_title))'');
    populated_ofc3_add_pcnt := AVE(GROUP,IF(h.ofc3_add = (TYPEOF(h.ofc3_add))'',0,100));
    maxlength_ofc3_add := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_add)));
    avelength_ofc3_add := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_add)),h.ofc3_add<>(typeof(h.ofc3_add))'');
    populated_ofc3_csz_pcnt := AVE(GROUP,IF(h.ofc3_csz = (TYPEOF(h.ofc3_csz))'',0,100));
    maxlength_ofc3_csz := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_csz)));
    avelength_ofc3_csz := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_csz)),h.ofc3_csz<>(typeof(h.ofc3_csz))'');
    populated_ofc3_fein_pcnt := AVE(GROUP,IF(h.ofc3_fein = (TYPEOF(h.ofc3_fein))'',0,100));
    maxlength_ofc3_fein := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_fein)));
    avelength_ofc3_fein := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_fein)),h.ofc3_fein<>(typeof(h.ofc3_fein))'');
    populated_ofc3_ssn_pcnt := AVE(GROUP,IF(h.ofc3_ssn = (TYPEOF(h.ofc3_ssn))'',0,100));
    maxlength_ofc3_ssn := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_ssn)));
    avelength_ofc3_ssn := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc3_ssn)),h.ofc3_ssn<>(typeof(h.ofc3_ssn))'');
    populated_ofc4_name_pcnt := AVE(GROUP,IF(h.ofc4_name = (TYPEOF(h.ofc4_name))'',0,100));
    maxlength_ofc4_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_name)));
    avelength_ofc4_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_name)),h.ofc4_name<>(typeof(h.ofc4_name))'');
    populated_ofc4_title_pcnt := AVE(GROUP,IF(h.ofc4_title = (TYPEOF(h.ofc4_title))'',0,100));
    maxlength_ofc4_title := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_title)));
    avelength_ofc4_title := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_title)),h.ofc4_title<>(typeof(h.ofc4_title))'');
    populated_ofc4_add_pcnt := AVE(GROUP,IF(h.ofc4_add = (TYPEOF(h.ofc4_add))'',0,100));
    maxlength_ofc4_add := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_add)));
    avelength_ofc4_add := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_add)),h.ofc4_add<>(typeof(h.ofc4_add))'');
    populated_ofc4_csz_pcnt := AVE(GROUP,IF(h.ofc4_csz = (TYPEOF(h.ofc4_csz))'',0,100));
    maxlength_ofc4_csz := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_csz)));
    avelength_ofc4_csz := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_csz)),h.ofc4_csz<>(typeof(h.ofc4_csz))'');
    populated_ofc4_fein_pcnt := AVE(GROUP,IF(h.ofc4_fein = (TYPEOF(h.ofc4_fein))'',0,100));
    maxlength_ofc4_fein := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_fein)));
    avelength_ofc4_fein := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_fein)),h.ofc4_fein<>(typeof(h.ofc4_fein))'');
    populated_ofc4_ssn_pcnt := AVE(GROUP,IF(h.ofc4_ssn = (TYPEOF(h.ofc4_ssn))'',0,100));
    maxlength_ofc4_ssn := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_ssn)));
    avelength_ofc4_ssn := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc4_ssn)),h.ofc4_ssn<>(typeof(h.ofc4_ssn))'');
    populated_ofc5_name_pcnt := AVE(GROUP,IF(h.ofc5_name = (TYPEOF(h.ofc5_name))'',0,100));
    maxlength_ofc5_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_name)));
    avelength_ofc5_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_name)),h.ofc5_name<>(typeof(h.ofc5_name))'');
    populated_ofc5_title_pcnt := AVE(GROUP,IF(h.ofc5_title = (TYPEOF(h.ofc5_title))'',0,100));
    maxlength_ofc5_title := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_title)));
    avelength_ofc5_title := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_title)),h.ofc5_title<>(typeof(h.ofc5_title))'');
    populated_ofc5_add_pcnt := AVE(GROUP,IF(h.ofc5_add = (TYPEOF(h.ofc5_add))'',0,100));
    maxlength_ofc5_add := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_add)));
    avelength_ofc5_add := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_add)),h.ofc5_add<>(typeof(h.ofc5_add))'');
    populated_ofc5_csz_pcnt := AVE(GROUP,IF(h.ofc5_csz = (TYPEOF(h.ofc5_csz))'',0,100));
    maxlength_ofc5_csz := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_csz)));
    avelength_ofc5_csz := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_csz)),h.ofc5_csz<>(typeof(h.ofc5_csz))'');
    populated_ofc5_fein_pcnt := AVE(GROUP,IF(h.ofc5_fein = (TYPEOF(h.ofc5_fein))'',0,100));
    maxlength_ofc5_fein := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_fein)));
    avelength_ofc5_fein := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_fein)),h.ofc5_fein<>(typeof(h.ofc5_fein))'');
    populated_ofc5_ssn_pcnt := AVE(GROUP,IF(h.ofc5_ssn = (TYPEOF(h.ofc5_ssn))'',0,100));
    maxlength_ofc5_ssn := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_ssn)));
    avelength_ofc5_ssn := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc5_ssn)),h.ofc5_ssn<>(typeof(h.ofc5_ssn))'');
    populated_ofc6_name_pcnt := AVE(GROUP,IF(h.ofc6_name = (TYPEOF(h.ofc6_name))'',0,100));
    maxlength_ofc6_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_name)));
    avelength_ofc6_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_name)),h.ofc6_name<>(typeof(h.ofc6_name))'');
    populated_ofc6_title_pcnt := AVE(GROUP,IF(h.ofc6_title = (TYPEOF(h.ofc6_title))'',0,100));
    maxlength_ofc6_title := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_title)));
    avelength_ofc6_title := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_title)),h.ofc6_title<>(typeof(h.ofc6_title))'');
    populated_ofc6_add_pcnt := AVE(GROUP,IF(h.ofc6_add = (TYPEOF(h.ofc6_add))'',0,100));
    maxlength_ofc6_add := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_add)));
    avelength_ofc6_add := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_add)),h.ofc6_add<>(typeof(h.ofc6_add))'');
    populated_ofc6_csz_pcnt := AVE(GROUP,IF(h.ofc6_csz = (TYPEOF(h.ofc6_csz))'',0,100));
    maxlength_ofc6_csz := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_csz)));
    avelength_ofc6_csz := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_csz)),h.ofc6_csz<>(typeof(h.ofc6_csz))'');
    populated_ofc6_fein_pcnt := AVE(GROUP,IF(h.ofc6_fein = (TYPEOF(h.ofc6_fein))'',0,100));
    maxlength_ofc6_fein := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_fein)));
    avelength_ofc6_fein := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_fein)),h.ofc6_fein<>(typeof(h.ofc6_fein))'');
    populated_ofc6_ssn_pcnt := AVE(GROUP,IF(h.ofc6_ssn = (TYPEOF(h.ofc6_ssn))'',0,100));
    maxlength_ofc6_ssn := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_ssn)));
    avelength_ofc6_ssn := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ofc6_ssn)),h.ofc6_ssn<>(typeof(h.ofc6_ssn))'');
    populated_fee_pcnt := AVE(GROUP,IF(h.fee = (TYPEOF(h.fee))'',0,100));
    maxlength_fee := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.fee)));
    avelength_fee := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.fee)),h.fee<>(typeof(h.fee))'');
    populated_fee_2_pcnt := AVE(GROUP,IF(h.fee_2 = (TYPEOF(h.fee_2))'',0,100));
    maxlength_fee_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.fee_2)));
    avelength_fee_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.fee_2)),h.fee_2<>(typeof(h.fee_2))'');
    populated_tax_cl_pcnt := AVE(GROUP,IF(h.tax_cl = (TYPEOF(h.tax_cl))'',0,100));
    maxlength_tax_cl := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.tax_cl)));
    avelength_tax_cl := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.tax_cl)),h.tax_cl<>(typeof(h.tax_cl))'');
    populated_perm_type_pcnt := AVE(GROUP,IF(h.perm_type = (TYPEOF(h.perm_type))'',0,100));
    maxlength_perm_type := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.perm_type)));
    avelength_perm_type := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.perm_type)),h.perm_type<>(typeof(h.perm_type))'');
    populated_page_pcnt := AVE(GROUP,IF(h.page = (TYPEOF(h.page))'',0,100));
    maxlength_page := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.page)));
    avelength_page := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.page)),h.page<>(typeof(h.page))'');
    populated_volume_pcnt := AVE(GROUP,IF(h.volume = (TYPEOF(h.volume))'',0,100));
    maxlength_volume := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.volume)));
    avelength_volume := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.volume)),h.volume<>(typeof(h.volume))'');
    populated_comments_pcnt := AVE(GROUP,IF(h.comments = (TYPEOF(h.comments))'',0,100));
    maxlength_comments := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.comments)));
    avelength_comments := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.comments)),h.comments<>(typeof(h.comments))'');
    populated_jurisdiction_pcnt := AVE(GROUP,IF(h.jurisdiction = (TYPEOF(h.jurisdiction))'',0,100));
    maxlength_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.jurisdiction)));
    avelength_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.jurisdiction)),h.jurisdiction<>(typeof(h.jurisdiction))'');
    populated_adcrecordno_pcnt := AVE(GROUP,IF(h.adcrecordno = (TYPEOF(h.adcrecordno))'',0,100));
    maxlength_adcrecordno := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.adcrecordno)));
    avelength_adcrecordno := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.adcrecordno)),h.adcrecordno<>(typeof(h.adcrecordno))'');
    populated_crlf_pcnt := AVE(GROUP,IF(h.crlf = (TYPEOF(h.crlf))'',0,100));
    maxlength_crlf := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.crlf)));
    avelength_crlf := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.crlf)),h.crlf<>(typeof(h.crlf))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ofc1_name_pcnt *   0.00 / 100 + T.Populated_ofc1_title_pcnt *   0.00 / 100 + T.Populated_ofc1_gender_pcnt *   0.00 / 100 + T.Populated_ofc1_add_pcnt *   0.00 / 100 + T.Populated_ofc1_suite_pcnt *   0.00 / 100 + T.Populated_ofc1_city_pcnt *   0.00 / 100 + T.Populated_ofc1_state_pcnt *   0.00 / 100 + T.Populated_ofc1_zip_pcnt *   0.00 / 100 + T.Populated_ofc1_ac_pcnt *   0.00 / 100 + T.Populated_ofc1_phone_pcnt *   0.00 / 100 + T.Populated_ofc1_fein_pcnt *   0.00 / 100 + T.Populated_ofc1_ssn_pcnt *   0.00 / 100 + T.Populated_ofc1_type_pcnt *   0.00 / 100 + T.Populated_company_pcnt *   0.00 / 100 + T.Populated_mail_add_pcnt *   0.00 / 100 + T.Populated_mail_suite_pcnt *   0.00 / 100 + T.Populated_mail_city_pcnt *   0.00 / 100 + T.Populated_mail_state_pcnt *   0.00 / 100 + T.Populated_mail_zip_pcnt *   0.00 / 100 + T.Populated_mail_zip4_pcnt *   0.00 / 100 + T.Populated_mail_key_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_district_pcnt *   0.00 / 100 + T.Populated_biz_ac_pcnt *   0.00 / 100 + T.Populated_biz_phone_pcnt *   0.00 / 100 + T.Populated_sic_pcnt *   0.00 / 100 + T.Populated_naics_pcnt *   0.00 / 100 + T.Populated_descript_pcnt *   0.00 / 100 + T.Populated_emp_size_pcnt *   0.00 / 100 + T.Populated_own_size_pcnt *   0.00 / 100 + T.Populated_corpcode_pcnt *   0.00 / 100 + T.Populated_sos_code_pcnt *   0.00 / 100 + T.Populated_filing_cod_pcnt *   0.00 / 100 + T.Populated_state_code_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_filing_num_pcnt *   0.00 / 100 + T.Populated_ctrl_num_pcnt *   0.00 / 100 + T.Populated_start_date_pcnt *   0.00 / 100 + T.Populated_file_date_pcnt *   0.00 / 100 + T.Populated_form_date_pcnt *   0.00 / 100 + T.Populated_exp_date_pcnt *   0.00 / 100 + T.Populated_disol_date_pcnt *   0.00 / 100 + T.Populated_rpt_date_pcnt *   0.00 / 100 + T.Populated_chang_date_pcnt *   0.00 / 100 + T.Populated_loc_add_pcnt *   0.00 / 100 + T.Populated_loc_suite_pcnt *   0.00 / 100 + T.Populated_loc_city_pcnt *   0.00 / 100 + T.Populated_loc_state_pcnt *   0.00 / 100 + T.Populated_loc_zip_pcnt *   0.00 / 100 + T.Populated_loc_zip4_pcnt *   0.00 / 100 + T.Populated_ofc2_name_pcnt *   0.00 / 100 + T.Populated_ofc2_title_pcnt *   0.00 / 100 + T.Populated_ofc2_add_pcnt *   0.00 / 100 + T.Populated_ofc2_csz_pcnt *   0.00 / 100 + T.Populated_ofc2_fein_pcnt *   0.00 / 100 + T.Populated_ofc2_ssn_pcnt *   0.00 / 100 + T.Populated_ofc3_name_pcnt *   0.00 / 100 + T.Populated_ofc3_title_pcnt *   0.00 / 100 + T.Populated_ofc3_add_pcnt *   0.00 / 100 + T.Populated_ofc3_csz_pcnt *   0.00 / 100 + T.Populated_ofc3_fein_pcnt *   0.00 / 100 + T.Populated_ofc3_ssn_pcnt *   0.00 / 100 + T.Populated_ofc4_name_pcnt *   0.00 / 100 + T.Populated_ofc4_title_pcnt *   0.00 / 100 + T.Populated_ofc4_add_pcnt *   0.00 / 100 + T.Populated_ofc4_csz_pcnt *   0.00 / 100 + T.Populated_ofc4_fein_pcnt *   0.00 / 100 + T.Populated_ofc4_ssn_pcnt *   0.00 / 100 + T.Populated_ofc5_name_pcnt *   0.00 / 100 + T.Populated_ofc5_title_pcnt *   0.00 / 100 + T.Populated_ofc5_add_pcnt *   0.00 / 100 + T.Populated_ofc5_csz_pcnt *   0.00 / 100 + T.Populated_ofc5_fein_pcnt *   0.00 / 100 + T.Populated_ofc5_ssn_pcnt *   0.00 / 100 + T.Populated_ofc6_name_pcnt *   0.00 / 100 + T.Populated_ofc6_title_pcnt *   0.00 / 100 + T.Populated_ofc6_add_pcnt *   0.00 / 100 + T.Populated_ofc6_csz_pcnt *   0.00 / 100 + T.Populated_ofc6_fein_pcnt *   0.00 / 100 + T.Populated_ofc6_ssn_pcnt *   0.00 / 100 + T.Populated_fee_pcnt *   0.00 / 100 + T.Populated_fee_2_pcnt *   0.00 / 100 + T.Populated_tax_cl_pcnt *   0.00 / 100 + T.Populated_perm_type_pcnt *   0.00 / 100 + T.Populated_page_pcnt *   0.00 / 100 + T.Populated_volume_pcnt *   0.00 / 100 + T.Populated_comments_pcnt *   0.00 / 100 + T.Populated_jurisdiction_pcnt *   0.00 / 100 + T.Populated_adcrecordno_pcnt *   0.00 / 100 + T.Populated_crlf_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT36.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'ofc1_name','ofc1_title','ofc1_gender','ofc1_add','ofc1_suite','ofc1_city','ofc1_state','ofc1_zip','ofc1_ac','ofc1_phone','ofc1_fein','ofc1_ssn','ofc1_type','company','mail_add','mail_suite','mail_city','mail_state','mail_zip','mail_zip4','mail_key','county','country','district','biz_ac','biz_phone','sic','naics','descript','emp_size','own_size','corpcode','sos_code','filing_cod','state_code','status','filing_num','ctrl_num','start_date','file_date','form_date','exp_date','disol_date','rpt_date','chang_date','loc_add','loc_suite','loc_city','loc_state','loc_zip','loc_zip4','ofc2_name','ofc2_title','ofc2_add','ofc2_csz','ofc2_fein','ofc2_ssn','ofc3_name','ofc3_title','ofc3_add','ofc3_csz','ofc3_fein','ofc3_ssn','ofc4_name','ofc4_title','ofc4_add','ofc4_csz','ofc4_fein','ofc4_ssn','ofc5_name','ofc5_title','ofc5_add','ofc5_csz','ofc5_fein','ofc5_ssn','ofc6_name','ofc6_title','ofc6_add','ofc6_csz','ofc6_fein','ofc6_ssn','fee','fee_2','tax_cl','perm_type','page','volume','comments','jurisdiction','adcrecordno','crlf');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ofc1_name_pcnt,le.populated_ofc1_title_pcnt,le.populated_ofc1_gender_pcnt,le.populated_ofc1_add_pcnt,le.populated_ofc1_suite_pcnt,le.populated_ofc1_city_pcnt,le.populated_ofc1_state_pcnt,le.populated_ofc1_zip_pcnt,le.populated_ofc1_ac_pcnt,le.populated_ofc1_phone_pcnt,le.populated_ofc1_fein_pcnt,le.populated_ofc1_ssn_pcnt,le.populated_ofc1_type_pcnt,le.populated_company_pcnt,le.populated_mail_add_pcnt,le.populated_mail_suite_pcnt,le.populated_mail_city_pcnt,le.populated_mail_state_pcnt,le.populated_mail_zip_pcnt,le.populated_mail_zip4_pcnt,le.populated_mail_key_pcnt,le.populated_county_pcnt,le.populated_country_pcnt,le.populated_district_pcnt,le.populated_biz_ac_pcnt,le.populated_biz_phone_pcnt,le.populated_sic_pcnt,le.populated_naics_pcnt,le.populated_descript_pcnt,le.populated_emp_size_pcnt,le.populated_own_size_pcnt,le.populated_corpcode_pcnt,le.populated_sos_code_pcnt,le.populated_filing_cod_pcnt,le.populated_state_code_pcnt,le.populated_status_pcnt,le.populated_filing_num_pcnt,le.populated_ctrl_num_pcnt,le.populated_start_date_pcnt,le.populated_file_date_pcnt,le.populated_form_date_pcnt,le.populated_exp_date_pcnt,le.populated_disol_date_pcnt,le.populated_rpt_date_pcnt,le.populated_chang_date_pcnt,le.populated_loc_add_pcnt,le.populated_loc_suite_pcnt,le.populated_loc_city_pcnt,le.populated_loc_state_pcnt,le.populated_loc_zip_pcnt,le.populated_loc_zip4_pcnt,le.populated_ofc2_name_pcnt,le.populated_ofc2_title_pcnt,le.populated_ofc2_add_pcnt,le.populated_ofc2_csz_pcnt,le.populated_ofc2_fein_pcnt,le.populated_ofc2_ssn_pcnt,le.populated_ofc3_name_pcnt,le.populated_ofc3_title_pcnt,le.populated_ofc3_add_pcnt,le.populated_ofc3_csz_pcnt,le.populated_ofc3_fein_pcnt,le.populated_ofc3_ssn_pcnt,le.populated_ofc4_name_pcnt,le.populated_ofc4_title_pcnt,le.populated_ofc4_add_pcnt,le.populated_ofc4_csz_pcnt,le.populated_ofc4_fein_pcnt,le.populated_ofc4_ssn_pcnt,le.populated_ofc5_name_pcnt,le.populated_ofc5_title_pcnt,le.populated_ofc5_add_pcnt,le.populated_ofc5_csz_pcnt,le.populated_ofc5_fein_pcnt,le.populated_ofc5_ssn_pcnt,le.populated_ofc6_name_pcnt,le.populated_ofc6_title_pcnt,le.populated_ofc6_add_pcnt,le.populated_ofc6_csz_pcnt,le.populated_ofc6_fein_pcnt,le.populated_ofc6_ssn_pcnt,le.populated_fee_pcnt,le.populated_fee_2_pcnt,le.populated_tax_cl_pcnt,le.populated_perm_type_pcnt,le.populated_page_pcnt,le.populated_volume_pcnt,le.populated_comments_pcnt,le.populated_jurisdiction_pcnt,le.populated_adcrecordno_pcnt,le.populated_crlf_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ofc1_name,le.maxlength_ofc1_title,le.maxlength_ofc1_gender,le.maxlength_ofc1_add,le.maxlength_ofc1_suite,le.maxlength_ofc1_city,le.maxlength_ofc1_state,le.maxlength_ofc1_zip,le.maxlength_ofc1_ac,le.maxlength_ofc1_phone,le.maxlength_ofc1_fein,le.maxlength_ofc1_ssn,le.maxlength_ofc1_type,le.maxlength_company,le.maxlength_mail_add,le.maxlength_mail_suite,le.maxlength_mail_city,le.maxlength_mail_state,le.maxlength_mail_zip,le.maxlength_mail_zip4,le.maxlength_mail_key,le.maxlength_county,le.maxlength_country,le.maxlength_district,le.maxlength_biz_ac,le.maxlength_biz_phone,le.maxlength_sic,le.maxlength_naics,le.maxlength_descript,le.maxlength_emp_size,le.maxlength_own_size,le.maxlength_corpcode,le.maxlength_sos_code,le.maxlength_filing_cod,le.maxlength_state_code,le.maxlength_status,le.maxlength_filing_num,le.maxlength_ctrl_num,le.maxlength_start_date,le.maxlength_file_date,le.maxlength_form_date,le.maxlength_exp_date,le.maxlength_disol_date,le.maxlength_rpt_date,le.maxlength_chang_date,le.maxlength_loc_add,le.maxlength_loc_suite,le.maxlength_loc_city,le.maxlength_loc_state,le.maxlength_loc_zip,le.maxlength_loc_zip4,le.maxlength_ofc2_name,le.maxlength_ofc2_title,le.maxlength_ofc2_add,le.maxlength_ofc2_csz,le.maxlength_ofc2_fein,le.maxlength_ofc2_ssn,le.maxlength_ofc3_name,le.maxlength_ofc3_title,le.maxlength_ofc3_add,le.maxlength_ofc3_csz,le.maxlength_ofc3_fein,le.maxlength_ofc3_ssn,le.maxlength_ofc4_name,le.maxlength_ofc4_title,le.maxlength_ofc4_add,le.maxlength_ofc4_csz,le.maxlength_ofc4_fein,le.maxlength_ofc4_ssn,le.maxlength_ofc5_name,le.maxlength_ofc5_title,le.maxlength_ofc5_add,le.maxlength_ofc5_csz,le.maxlength_ofc5_fein,le.maxlength_ofc5_ssn,le.maxlength_ofc6_name,le.maxlength_ofc6_title,le.maxlength_ofc6_add,le.maxlength_ofc6_csz,le.maxlength_ofc6_fein,le.maxlength_ofc6_ssn,le.maxlength_fee,le.maxlength_fee_2,le.maxlength_tax_cl,le.maxlength_perm_type,le.maxlength_page,le.maxlength_volume,le.maxlength_comments,le.maxlength_jurisdiction,le.maxlength_adcrecordno,le.maxlength_crlf);
  SELF.avelength := CHOOSE(C,le.avelength_ofc1_name,le.avelength_ofc1_title,le.avelength_ofc1_gender,le.avelength_ofc1_add,le.avelength_ofc1_suite,le.avelength_ofc1_city,le.avelength_ofc1_state,le.avelength_ofc1_zip,le.avelength_ofc1_ac,le.avelength_ofc1_phone,le.avelength_ofc1_fein,le.avelength_ofc1_ssn,le.avelength_ofc1_type,le.avelength_company,le.avelength_mail_add,le.avelength_mail_suite,le.avelength_mail_city,le.avelength_mail_state,le.avelength_mail_zip,le.avelength_mail_zip4,le.avelength_mail_key,le.avelength_county,le.avelength_country,le.avelength_district,le.avelength_biz_ac,le.avelength_biz_phone,le.avelength_sic,le.avelength_naics,le.avelength_descript,le.avelength_emp_size,le.avelength_own_size,le.avelength_corpcode,le.avelength_sos_code,le.avelength_filing_cod,le.avelength_state_code,le.avelength_status,le.avelength_filing_num,le.avelength_ctrl_num,le.avelength_start_date,le.avelength_file_date,le.avelength_form_date,le.avelength_exp_date,le.avelength_disol_date,le.avelength_rpt_date,le.avelength_chang_date,le.avelength_loc_add,le.avelength_loc_suite,le.avelength_loc_city,le.avelength_loc_state,le.avelength_loc_zip,le.avelength_loc_zip4,le.avelength_ofc2_name,le.avelength_ofc2_title,le.avelength_ofc2_add,le.avelength_ofc2_csz,le.avelength_ofc2_fein,le.avelength_ofc2_ssn,le.avelength_ofc3_name,le.avelength_ofc3_title,le.avelength_ofc3_add,le.avelength_ofc3_csz,le.avelength_ofc3_fein,le.avelength_ofc3_ssn,le.avelength_ofc4_name,le.avelength_ofc4_title,le.avelength_ofc4_add,le.avelength_ofc4_csz,le.avelength_ofc4_fein,le.avelength_ofc4_ssn,le.avelength_ofc5_name,le.avelength_ofc5_title,le.avelength_ofc5_add,le.avelength_ofc5_csz,le.avelength_ofc5_fein,le.avelength_ofc5_ssn,le.avelength_ofc6_name,le.avelength_ofc6_title,le.avelength_ofc6_add,le.avelength_ofc6_csz,le.avelength_ofc6_fein,le.avelength_ofc6_ssn,le.avelength_fee,le.avelength_fee_2,le.avelength_tax_cl,le.avelength_perm_type,le.avelength_page,le.avelength_volume,le.avelength_comments,le.avelength_jurisdiction,le.avelength_adcrecordno,le.avelength_crlf);
END;
EXPORT invSummary := NORMALIZE(summary0, 91, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT36.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT36.StrType)le.ofc1_name),TRIM((SALT36.StrType)le.ofc1_title),TRIM((SALT36.StrType)le.ofc1_gender),TRIM((SALT36.StrType)le.ofc1_add),TRIM((SALT36.StrType)le.ofc1_suite),TRIM((SALT36.StrType)le.ofc1_city),TRIM((SALT36.StrType)le.ofc1_state),TRIM((SALT36.StrType)le.ofc1_zip),TRIM((SALT36.StrType)le.ofc1_ac),TRIM((SALT36.StrType)le.ofc1_phone),TRIM((SALT36.StrType)le.ofc1_fein),TRIM((SALT36.StrType)le.ofc1_ssn),TRIM((SALT36.StrType)le.ofc1_type),TRIM((SALT36.StrType)le.company),TRIM((SALT36.StrType)le.mail_add),TRIM((SALT36.StrType)le.mail_suite),TRIM((SALT36.StrType)le.mail_city),TRIM((SALT36.StrType)le.mail_state),TRIM((SALT36.StrType)le.mail_zip),TRIM((SALT36.StrType)le.mail_zip4),TRIM((SALT36.StrType)le.mail_key),TRIM((SALT36.StrType)le.county),TRIM((SALT36.StrType)le.country),TRIM((SALT36.StrType)le.district),TRIM((SALT36.StrType)le.biz_ac),TRIM((SALT36.StrType)le.biz_phone),TRIM((SALT36.StrType)le.sic),TRIM((SALT36.StrType)le.naics),TRIM((SALT36.StrType)le.descript),TRIM((SALT36.StrType)le.emp_size),TRIM((SALT36.StrType)le.own_size),TRIM((SALT36.StrType)le.corpcode),TRIM((SALT36.StrType)le.sos_code),TRIM((SALT36.StrType)le.filing_cod),TRIM((SALT36.StrType)le.state_code),TRIM((SALT36.StrType)le.status),TRIM((SALT36.StrType)le.filing_num),TRIM((SALT36.StrType)le.ctrl_num),TRIM((SALT36.StrType)le.start_date),TRIM((SALT36.StrType)le.file_date),TRIM((SALT36.StrType)le.form_date),TRIM((SALT36.StrType)le.exp_date),TRIM((SALT36.StrType)le.disol_date),TRIM((SALT36.StrType)le.rpt_date),TRIM((SALT36.StrType)le.chang_date),TRIM((SALT36.StrType)le.loc_add),TRIM((SALT36.StrType)le.loc_suite),TRIM((SALT36.StrType)le.loc_city),TRIM((SALT36.StrType)le.loc_state),TRIM((SALT36.StrType)le.loc_zip),TRIM((SALT36.StrType)le.loc_zip4),TRIM((SALT36.StrType)le.ofc2_name),TRIM((SALT36.StrType)le.ofc2_title),TRIM((SALT36.StrType)le.ofc2_add),TRIM((SALT36.StrType)le.ofc2_csz),TRIM((SALT36.StrType)le.ofc2_fein),TRIM((SALT36.StrType)le.ofc2_ssn),TRIM((SALT36.StrType)le.ofc3_name),TRIM((SALT36.StrType)le.ofc3_title),TRIM((SALT36.StrType)le.ofc3_add),TRIM((SALT36.StrType)le.ofc3_csz),TRIM((SALT36.StrType)le.ofc3_fein),TRIM((SALT36.StrType)le.ofc3_ssn),TRIM((SALT36.StrType)le.ofc4_name),TRIM((SALT36.StrType)le.ofc4_title),TRIM((SALT36.StrType)le.ofc4_add),TRIM((SALT36.StrType)le.ofc4_csz),TRIM((SALT36.StrType)le.ofc4_fein),TRIM((SALT36.StrType)le.ofc4_ssn),TRIM((SALT36.StrType)le.ofc5_name),TRIM((SALT36.StrType)le.ofc5_title),TRIM((SALT36.StrType)le.ofc5_add),TRIM((SALT36.StrType)le.ofc5_csz),TRIM((SALT36.StrType)le.ofc5_fein),TRIM((SALT36.StrType)le.ofc5_ssn),TRIM((SALT36.StrType)le.ofc6_name),TRIM((SALT36.StrType)le.ofc6_title),TRIM((SALT36.StrType)le.ofc6_add),TRIM((SALT36.StrType)le.ofc6_csz),TRIM((SALT36.StrType)le.ofc6_fein),TRIM((SALT36.StrType)le.ofc6_ssn),TRIM((SALT36.StrType)le.fee),TRIM((SALT36.StrType)le.fee_2),TRIM((SALT36.StrType)le.tax_cl),TRIM((SALT36.StrType)le.perm_type),TRIM((SALT36.StrType)le.page),TRIM((SALT36.StrType)le.volume),TRIM((SALT36.StrType)le.comments),TRIM((SALT36.StrType)le.jurisdiction),TRIM((SALT36.StrType)le.adcrecordno),TRIM((SALT36.StrType)le.crlf)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,91,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT36.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 91);
  SELF.FldNo2 := 1 + (C % 91);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT36.StrType)le.ofc1_name),TRIM((SALT36.StrType)le.ofc1_title),TRIM((SALT36.StrType)le.ofc1_gender),TRIM((SALT36.StrType)le.ofc1_add),TRIM((SALT36.StrType)le.ofc1_suite),TRIM((SALT36.StrType)le.ofc1_city),TRIM((SALT36.StrType)le.ofc1_state),TRIM((SALT36.StrType)le.ofc1_zip),TRIM((SALT36.StrType)le.ofc1_ac),TRIM((SALT36.StrType)le.ofc1_phone),TRIM((SALT36.StrType)le.ofc1_fein),TRIM((SALT36.StrType)le.ofc1_ssn),TRIM((SALT36.StrType)le.ofc1_type),TRIM((SALT36.StrType)le.company),TRIM((SALT36.StrType)le.mail_add),TRIM((SALT36.StrType)le.mail_suite),TRIM((SALT36.StrType)le.mail_city),TRIM((SALT36.StrType)le.mail_state),TRIM((SALT36.StrType)le.mail_zip),TRIM((SALT36.StrType)le.mail_zip4),TRIM((SALT36.StrType)le.mail_key),TRIM((SALT36.StrType)le.county),TRIM((SALT36.StrType)le.country),TRIM((SALT36.StrType)le.district),TRIM((SALT36.StrType)le.biz_ac),TRIM((SALT36.StrType)le.biz_phone),TRIM((SALT36.StrType)le.sic),TRIM((SALT36.StrType)le.naics),TRIM((SALT36.StrType)le.descript),TRIM((SALT36.StrType)le.emp_size),TRIM((SALT36.StrType)le.own_size),TRIM((SALT36.StrType)le.corpcode),TRIM((SALT36.StrType)le.sos_code),TRIM((SALT36.StrType)le.filing_cod),TRIM((SALT36.StrType)le.state_code),TRIM((SALT36.StrType)le.status),TRIM((SALT36.StrType)le.filing_num),TRIM((SALT36.StrType)le.ctrl_num),TRIM((SALT36.StrType)le.start_date),TRIM((SALT36.StrType)le.file_date),TRIM((SALT36.StrType)le.form_date),TRIM((SALT36.StrType)le.exp_date),TRIM((SALT36.StrType)le.disol_date),TRIM((SALT36.StrType)le.rpt_date),TRIM((SALT36.StrType)le.chang_date),TRIM((SALT36.StrType)le.loc_add),TRIM((SALT36.StrType)le.loc_suite),TRIM((SALT36.StrType)le.loc_city),TRIM((SALT36.StrType)le.loc_state),TRIM((SALT36.StrType)le.loc_zip),TRIM((SALT36.StrType)le.loc_zip4),TRIM((SALT36.StrType)le.ofc2_name),TRIM((SALT36.StrType)le.ofc2_title),TRIM((SALT36.StrType)le.ofc2_add),TRIM((SALT36.StrType)le.ofc2_csz),TRIM((SALT36.StrType)le.ofc2_fein),TRIM((SALT36.StrType)le.ofc2_ssn),TRIM((SALT36.StrType)le.ofc3_name),TRIM((SALT36.StrType)le.ofc3_title),TRIM((SALT36.StrType)le.ofc3_add),TRIM((SALT36.StrType)le.ofc3_csz),TRIM((SALT36.StrType)le.ofc3_fein),TRIM((SALT36.StrType)le.ofc3_ssn),TRIM((SALT36.StrType)le.ofc4_name),TRIM((SALT36.StrType)le.ofc4_title),TRIM((SALT36.StrType)le.ofc4_add),TRIM((SALT36.StrType)le.ofc4_csz),TRIM((SALT36.StrType)le.ofc4_fein),TRIM((SALT36.StrType)le.ofc4_ssn),TRIM((SALT36.StrType)le.ofc5_name),TRIM((SALT36.StrType)le.ofc5_title),TRIM((SALT36.StrType)le.ofc5_add),TRIM((SALT36.StrType)le.ofc5_csz),TRIM((SALT36.StrType)le.ofc5_fein),TRIM((SALT36.StrType)le.ofc5_ssn),TRIM((SALT36.StrType)le.ofc6_name),TRIM((SALT36.StrType)le.ofc6_title),TRIM((SALT36.StrType)le.ofc6_add),TRIM((SALT36.StrType)le.ofc6_csz),TRIM((SALT36.StrType)le.ofc6_fein),TRIM((SALT36.StrType)le.ofc6_ssn),TRIM((SALT36.StrType)le.fee),TRIM((SALT36.StrType)le.fee_2),TRIM((SALT36.StrType)le.tax_cl),TRIM((SALT36.StrType)le.perm_type),TRIM((SALT36.StrType)le.page),TRIM((SALT36.StrType)le.volume),TRIM((SALT36.StrType)le.comments),TRIM((SALT36.StrType)le.jurisdiction),TRIM((SALT36.StrType)le.adcrecordno),TRIM((SALT36.StrType)le.crlf)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT36.StrType)le.ofc1_name),TRIM((SALT36.StrType)le.ofc1_title),TRIM((SALT36.StrType)le.ofc1_gender),TRIM((SALT36.StrType)le.ofc1_add),TRIM((SALT36.StrType)le.ofc1_suite),TRIM((SALT36.StrType)le.ofc1_city),TRIM((SALT36.StrType)le.ofc1_state),TRIM((SALT36.StrType)le.ofc1_zip),TRIM((SALT36.StrType)le.ofc1_ac),TRIM((SALT36.StrType)le.ofc1_phone),TRIM((SALT36.StrType)le.ofc1_fein),TRIM((SALT36.StrType)le.ofc1_ssn),TRIM((SALT36.StrType)le.ofc1_type),TRIM((SALT36.StrType)le.company),TRIM((SALT36.StrType)le.mail_add),TRIM((SALT36.StrType)le.mail_suite),TRIM((SALT36.StrType)le.mail_city),TRIM((SALT36.StrType)le.mail_state),TRIM((SALT36.StrType)le.mail_zip),TRIM((SALT36.StrType)le.mail_zip4),TRIM((SALT36.StrType)le.mail_key),TRIM((SALT36.StrType)le.county),TRIM((SALT36.StrType)le.country),TRIM((SALT36.StrType)le.district),TRIM((SALT36.StrType)le.biz_ac),TRIM((SALT36.StrType)le.biz_phone),TRIM((SALT36.StrType)le.sic),TRIM((SALT36.StrType)le.naics),TRIM((SALT36.StrType)le.descript),TRIM((SALT36.StrType)le.emp_size),TRIM((SALT36.StrType)le.own_size),TRIM((SALT36.StrType)le.corpcode),TRIM((SALT36.StrType)le.sos_code),TRIM((SALT36.StrType)le.filing_cod),TRIM((SALT36.StrType)le.state_code),TRIM((SALT36.StrType)le.status),TRIM((SALT36.StrType)le.filing_num),TRIM((SALT36.StrType)le.ctrl_num),TRIM((SALT36.StrType)le.start_date),TRIM((SALT36.StrType)le.file_date),TRIM((SALT36.StrType)le.form_date),TRIM((SALT36.StrType)le.exp_date),TRIM((SALT36.StrType)le.disol_date),TRIM((SALT36.StrType)le.rpt_date),TRIM((SALT36.StrType)le.chang_date),TRIM((SALT36.StrType)le.loc_add),TRIM((SALT36.StrType)le.loc_suite),TRIM((SALT36.StrType)le.loc_city),TRIM((SALT36.StrType)le.loc_state),TRIM((SALT36.StrType)le.loc_zip),TRIM((SALT36.StrType)le.loc_zip4),TRIM((SALT36.StrType)le.ofc2_name),TRIM((SALT36.StrType)le.ofc2_title),TRIM((SALT36.StrType)le.ofc2_add),TRIM((SALT36.StrType)le.ofc2_csz),TRIM((SALT36.StrType)le.ofc2_fein),TRIM((SALT36.StrType)le.ofc2_ssn),TRIM((SALT36.StrType)le.ofc3_name),TRIM((SALT36.StrType)le.ofc3_title),TRIM((SALT36.StrType)le.ofc3_add),TRIM((SALT36.StrType)le.ofc3_csz),TRIM((SALT36.StrType)le.ofc3_fein),TRIM((SALT36.StrType)le.ofc3_ssn),TRIM((SALT36.StrType)le.ofc4_name),TRIM((SALT36.StrType)le.ofc4_title),TRIM((SALT36.StrType)le.ofc4_add),TRIM((SALT36.StrType)le.ofc4_csz),TRIM((SALT36.StrType)le.ofc4_fein),TRIM((SALT36.StrType)le.ofc4_ssn),TRIM((SALT36.StrType)le.ofc5_name),TRIM((SALT36.StrType)le.ofc5_title),TRIM((SALT36.StrType)le.ofc5_add),TRIM((SALT36.StrType)le.ofc5_csz),TRIM((SALT36.StrType)le.ofc5_fein),TRIM((SALT36.StrType)le.ofc5_ssn),TRIM((SALT36.StrType)le.ofc6_name),TRIM((SALT36.StrType)le.ofc6_title),TRIM((SALT36.StrType)le.ofc6_add),TRIM((SALT36.StrType)le.ofc6_csz),TRIM((SALT36.StrType)le.ofc6_fein),TRIM((SALT36.StrType)le.ofc6_ssn),TRIM((SALT36.StrType)le.fee),TRIM((SALT36.StrType)le.fee_2),TRIM((SALT36.StrType)le.tax_cl),TRIM((SALT36.StrType)le.perm_type),TRIM((SALT36.StrType)le.page),TRIM((SALT36.StrType)le.volume),TRIM((SALT36.StrType)le.comments),TRIM((SALT36.StrType)le.jurisdiction),TRIM((SALT36.StrType)le.adcrecordno),TRIM((SALT36.StrType)le.crlf)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),91*91,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ofc1_name'}
      ,{2,'ofc1_title'}
      ,{3,'ofc1_gender'}
      ,{4,'ofc1_add'}
      ,{5,'ofc1_suite'}
      ,{6,'ofc1_city'}
      ,{7,'ofc1_state'}
      ,{8,'ofc1_zip'}
      ,{9,'ofc1_ac'}
      ,{10,'ofc1_phone'}
      ,{11,'ofc1_fein'}
      ,{12,'ofc1_ssn'}
      ,{13,'ofc1_type'}
      ,{14,'company'}
      ,{15,'mail_add'}
      ,{16,'mail_suite'}
      ,{17,'mail_city'}
      ,{18,'mail_state'}
      ,{19,'mail_zip'}
      ,{20,'mail_zip4'}
      ,{21,'mail_key'}
      ,{22,'county'}
      ,{23,'country'}
      ,{24,'district'}
      ,{25,'biz_ac'}
      ,{26,'biz_phone'}
      ,{27,'sic'}
      ,{28,'naics'}
      ,{29,'descript'}
      ,{30,'emp_size'}
      ,{31,'own_size'}
      ,{32,'corpcode'}
      ,{33,'sos_code'}
      ,{34,'filing_cod'}
      ,{35,'state_code'}
      ,{36,'status'}
      ,{37,'filing_num'}
      ,{38,'ctrl_num'}
      ,{39,'start_date'}
      ,{40,'file_date'}
      ,{41,'form_date'}
      ,{42,'exp_date'}
      ,{43,'disol_date'}
      ,{44,'rpt_date'}
      ,{45,'chang_date'}
      ,{46,'loc_add'}
      ,{47,'loc_suite'}
      ,{48,'loc_city'}
      ,{49,'loc_state'}
      ,{50,'loc_zip'}
      ,{51,'loc_zip4'}
      ,{52,'ofc2_name'}
      ,{53,'ofc2_title'}
      ,{54,'ofc2_add'}
      ,{55,'ofc2_csz'}
      ,{56,'ofc2_fein'}
      ,{57,'ofc2_ssn'}
      ,{58,'ofc3_name'}
      ,{59,'ofc3_title'}
      ,{60,'ofc3_add'}
      ,{61,'ofc3_csz'}
      ,{62,'ofc3_fein'}
      ,{63,'ofc3_ssn'}
      ,{64,'ofc4_name'}
      ,{65,'ofc4_title'}
      ,{66,'ofc4_add'}
      ,{67,'ofc4_csz'}
      ,{68,'ofc4_fein'}
      ,{69,'ofc4_ssn'}
      ,{70,'ofc5_name'}
      ,{71,'ofc5_title'}
      ,{72,'ofc5_add'}
      ,{73,'ofc5_csz'}
      ,{74,'ofc5_fein'}
      ,{75,'ofc5_ssn'}
      ,{76,'ofc6_name'}
      ,{77,'ofc6_title'}
      ,{78,'ofc6_add'}
      ,{79,'ofc6_csz'}
      ,{80,'ofc6_fein'}
      ,{81,'ofc6_ssn'}
      ,{82,'fee'}
      ,{83,'fee_2'}
      ,{84,'tax_cl'}
      ,{85,'perm_type'}
      ,{86,'page'}
      ,{87,'volume'}
      ,{88,'comments'}
      ,{89,'jurisdiction'}
      ,{90,'adcrecordno'}
      ,{91,'crlf'}],SALT36.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT36.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT36.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT36.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_ofc1_name((SALT36.StrType)le.ofc1_name),
    Fields.InValid_ofc1_title((SALT36.StrType)le.ofc1_title),
    Fields.InValid_ofc1_gender((SALT36.StrType)le.ofc1_gender),
    Fields.InValid_ofc1_add((SALT36.StrType)le.ofc1_add),
    Fields.InValid_ofc1_suite((SALT36.StrType)le.ofc1_suite),
    Fields.InValid_ofc1_city((SALT36.StrType)le.ofc1_city),
    Fields.InValid_ofc1_state((SALT36.StrType)le.ofc1_state),
    Fields.InValid_ofc1_zip((SALT36.StrType)le.ofc1_zip),
    Fields.InValid_ofc1_ac((SALT36.StrType)le.ofc1_ac),
    Fields.InValid_ofc1_phone((SALT36.StrType)le.ofc1_phone),
    Fields.InValid_ofc1_fein((SALT36.StrType)le.ofc1_fein),
    Fields.InValid_ofc1_ssn((SALT36.StrType)le.ofc1_ssn),
    Fields.InValid_ofc1_type((SALT36.StrType)le.ofc1_type),
    Fields.InValid_company((SALT36.StrType)le.company),
    Fields.InValid_mail_add((SALT36.StrType)le.mail_add),
    Fields.InValid_mail_suite((SALT36.StrType)le.mail_suite),
    Fields.InValid_mail_city((SALT36.StrType)le.mail_city),
    Fields.InValid_mail_state((SALT36.StrType)le.mail_state),
    Fields.InValid_mail_zip((SALT36.StrType)le.mail_zip),
    Fields.InValid_mail_zip4((SALT36.StrType)le.mail_zip4),
    Fields.InValid_mail_key((SALT36.StrType)le.mail_key),
    Fields.InValid_county((SALT36.StrType)le.county),
    Fields.InValid_country((SALT36.StrType)le.country),
    Fields.InValid_district((SALT36.StrType)le.district),
    Fields.InValid_biz_ac((SALT36.StrType)le.biz_ac),
    Fields.InValid_biz_phone((SALT36.StrType)le.biz_phone),
    Fields.InValid_sic((SALT36.StrType)le.sic),
    Fields.InValid_naics((SALT36.StrType)le.naics),
    Fields.InValid_descript((SALT36.StrType)le.descript),
    Fields.InValid_emp_size((SALT36.StrType)le.emp_size),
    Fields.InValid_own_size((SALT36.StrType)le.own_size),
    Fields.InValid_corpcode((SALT36.StrType)le.corpcode),
    Fields.InValid_sos_code((SALT36.StrType)le.sos_code),
    Fields.InValid_filing_cod((SALT36.StrType)le.filing_cod),
    Fields.InValid_state_code((SALT36.StrType)le.state_code),
    Fields.InValid_status((SALT36.StrType)le.status),
    Fields.InValid_filing_num((SALT36.StrType)le.filing_num),
    Fields.InValid_ctrl_num((SALT36.StrType)le.ctrl_num),
    Fields.InValid_start_date((SALT36.StrType)le.start_date),
    Fields.InValid_file_date((SALT36.StrType)le.file_date),
    Fields.InValid_form_date((SALT36.StrType)le.form_date),
    Fields.InValid_exp_date((SALT36.StrType)le.exp_date),
    Fields.InValid_disol_date((SALT36.StrType)le.disol_date),
    Fields.InValid_rpt_date((SALT36.StrType)le.rpt_date),
    Fields.InValid_chang_date((SALT36.StrType)le.chang_date),
    Fields.InValid_loc_add((SALT36.StrType)le.loc_add),
    Fields.InValid_loc_suite((SALT36.StrType)le.loc_suite),
    Fields.InValid_loc_city((SALT36.StrType)le.loc_city),
    Fields.InValid_loc_state((SALT36.StrType)le.loc_state),
    Fields.InValid_loc_zip((SALT36.StrType)le.loc_zip),
    Fields.InValid_loc_zip4((SALT36.StrType)le.loc_zip4),
    Fields.InValid_ofc2_name((SALT36.StrType)le.ofc2_name),
    Fields.InValid_ofc2_title((SALT36.StrType)le.ofc2_title),
    Fields.InValid_ofc2_add((SALT36.StrType)le.ofc2_add),
    Fields.InValid_ofc2_csz((SALT36.StrType)le.ofc2_csz),
    Fields.InValid_ofc2_fein((SALT36.StrType)le.ofc2_fein),
    Fields.InValid_ofc2_ssn((SALT36.StrType)le.ofc2_ssn),
    Fields.InValid_ofc3_name((SALT36.StrType)le.ofc3_name),
    Fields.InValid_ofc3_title((SALT36.StrType)le.ofc3_title),
    Fields.InValid_ofc3_add((SALT36.StrType)le.ofc3_add),
    Fields.InValid_ofc3_csz((SALT36.StrType)le.ofc3_csz),
    Fields.InValid_ofc3_fein((SALT36.StrType)le.ofc3_fein),
    Fields.InValid_ofc3_ssn((SALT36.StrType)le.ofc3_ssn),
    Fields.InValid_ofc4_name((SALT36.StrType)le.ofc4_name),
    Fields.InValid_ofc4_title((SALT36.StrType)le.ofc4_title),
    Fields.InValid_ofc4_add((SALT36.StrType)le.ofc4_add),
    Fields.InValid_ofc4_csz((SALT36.StrType)le.ofc4_csz),
    Fields.InValid_ofc4_fein((SALT36.StrType)le.ofc4_fein),
    Fields.InValid_ofc4_ssn((SALT36.StrType)le.ofc4_ssn),
    Fields.InValid_ofc5_name((SALT36.StrType)le.ofc5_name),
    Fields.InValid_ofc5_title((SALT36.StrType)le.ofc5_title),
    Fields.InValid_ofc5_add((SALT36.StrType)le.ofc5_add),
    Fields.InValid_ofc5_csz((SALT36.StrType)le.ofc5_csz),
    Fields.InValid_ofc5_fein((SALT36.StrType)le.ofc5_fein),
    Fields.InValid_ofc5_ssn((SALT36.StrType)le.ofc5_ssn),
    Fields.InValid_ofc6_name((SALT36.StrType)le.ofc6_name),
    Fields.InValid_ofc6_title((SALT36.StrType)le.ofc6_title),
    Fields.InValid_ofc6_add((SALT36.StrType)le.ofc6_add),
    Fields.InValid_ofc6_csz((SALT36.StrType)le.ofc6_csz),
    Fields.InValid_ofc6_fein((SALT36.StrType)le.ofc6_fein),
    Fields.InValid_ofc6_ssn((SALT36.StrType)le.ofc6_ssn),
    Fields.InValid_fee((SALT36.StrType)le.fee),
    Fields.InValid_fee_2((SALT36.StrType)le.fee_2),
    Fields.InValid_tax_cl((SALT36.StrType)le.tax_cl),
    Fields.InValid_perm_type((SALT36.StrType)le.perm_type),
    Fields.InValid_page((SALT36.StrType)le.page),
    Fields.InValid_volume((SALT36.StrType)le.volume),
    Fields.InValid_comments((SALT36.StrType)le.comments),
    Fields.InValid_jurisdiction((SALT36.StrType)le.jurisdiction),
    Fields.InValid_adcrecordno((SALT36.StrType)le.adcrecordno),
    Fields.InValid_crlf((SALT36.StrType)le.crlf),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,91,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','invalid_ofc1_title','invalid_ofc1_gender','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_county','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_corpcode','invalid_sos_code','invalid_filing_code','Unknown','invalid_status','invalid_filing_num','Unknown','invalid_date','invalid_date','invalid_date','Unknown','invalid_date','invalid_date','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_ofc1_title','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_ofc1_title','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_ofc1_title','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_ofc1_title','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_ofc1_title','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_ofc1_name(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_title(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_gender(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_add(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_suite(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_city(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_state(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_zip(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_ac(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_phone(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_fein(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_ofc1_type(TotalErrors.ErrorNum),Fields.InValidMessage_company(TotalErrors.ErrorNum),Fields.InValidMessage_mail_add(TotalErrors.ErrorNum),Fields.InValidMessage_mail_suite(TotalErrors.ErrorNum),Fields.InValidMessage_mail_city(TotalErrors.ErrorNum),Fields.InValidMessage_mail_state(TotalErrors.ErrorNum),Fields.InValidMessage_mail_zip(TotalErrors.ErrorNum),Fields.InValidMessage_mail_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_mail_key(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_country(TotalErrors.ErrorNum),Fields.InValidMessage_district(TotalErrors.ErrorNum),Fields.InValidMessage_biz_ac(TotalErrors.ErrorNum),Fields.InValidMessage_biz_phone(TotalErrors.ErrorNum),Fields.InValidMessage_sic(TotalErrors.ErrorNum),Fields.InValidMessage_naics(TotalErrors.ErrorNum),Fields.InValidMessage_descript(TotalErrors.ErrorNum),Fields.InValidMessage_emp_size(TotalErrors.ErrorNum),Fields.InValidMessage_own_size(TotalErrors.ErrorNum),Fields.InValidMessage_corpcode(TotalErrors.ErrorNum),Fields.InValidMessage_sos_code(TotalErrors.ErrorNum),Fields.InValidMessage_filing_cod(TotalErrors.ErrorNum),Fields.InValidMessage_state_code(TotalErrors.ErrorNum),Fields.InValidMessage_status(TotalErrors.ErrorNum),Fields.InValidMessage_filing_num(TotalErrors.ErrorNum),Fields.InValidMessage_ctrl_num(TotalErrors.ErrorNum),Fields.InValidMessage_start_date(TotalErrors.ErrorNum),Fields.InValidMessage_file_date(TotalErrors.ErrorNum),Fields.InValidMessage_form_date(TotalErrors.ErrorNum),Fields.InValidMessage_exp_date(TotalErrors.ErrorNum),Fields.InValidMessage_disol_date(TotalErrors.ErrorNum),Fields.InValidMessage_rpt_date(TotalErrors.ErrorNum),Fields.InValidMessage_chang_date(TotalErrors.ErrorNum),Fields.InValidMessage_loc_add(TotalErrors.ErrorNum),Fields.InValidMessage_loc_suite(TotalErrors.ErrorNum),Fields.InValidMessage_loc_city(TotalErrors.ErrorNum),Fields.InValidMessage_loc_state(TotalErrors.ErrorNum),Fields.InValidMessage_loc_zip(TotalErrors.ErrorNum),Fields.InValidMessage_loc_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_ofc2_name(TotalErrors.ErrorNum),Fields.InValidMessage_ofc2_title(TotalErrors.ErrorNum),Fields.InValidMessage_ofc2_add(TotalErrors.ErrorNum),Fields.InValidMessage_ofc2_csz(TotalErrors.ErrorNum),Fields.InValidMessage_ofc2_fein(TotalErrors.ErrorNum),Fields.InValidMessage_ofc2_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_ofc3_name(TotalErrors.ErrorNum),Fields.InValidMessage_ofc3_title(TotalErrors.ErrorNum),Fields.InValidMessage_ofc3_add(TotalErrors.ErrorNum),Fields.InValidMessage_ofc3_csz(TotalErrors.ErrorNum),Fields.InValidMessage_ofc3_fein(TotalErrors.ErrorNum),Fields.InValidMessage_ofc3_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_ofc4_name(TotalErrors.ErrorNum),Fields.InValidMessage_ofc4_title(TotalErrors.ErrorNum),Fields.InValidMessage_ofc4_add(TotalErrors.ErrorNum),Fields.InValidMessage_ofc4_csz(TotalErrors.ErrorNum),Fields.InValidMessage_ofc4_fein(TotalErrors.ErrorNum),Fields.InValidMessage_ofc4_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_ofc5_name(TotalErrors.ErrorNum),Fields.InValidMessage_ofc5_title(TotalErrors.ErrorNum),Fields.InValidMessage_ofc5_add(TotalErrors.ErrorNum),Fields.InValidMessage_ofc5_csz(TotalErrors.ErrorNum),Fields.InValidMessage_ofc5_fein(TotalErrors.ErrorNum),Fields.InValidMessage_ofc5_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_ofc6_name(TotalErrors.ErrorNum),Fields.InValidMessage_ofc6_title(TotalErrors.ErrorNum),Fields.InValidMessage_ofc6_add(TotalErrors.ErrorNum),Fields.InValidMessage_ofc6_csz(TotalErrors.ErrorNum),Fields.InValidMessage_ofc6_fein(TotalErrors.ErrorNum),Fields.InValidMessage_ofc6_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_fee(TotalErrors.ErrorNum),Fields.InValidMessage_fee_2(TotalErrors.ErrorNum),Fields.InValidMessage_tax_cl(TotalErrors.ErrorNum),Fields.InValidMessage_perm_type(TotalErrors.ErrorNum),Fields.InValidMessage_page(TotalErrors.ErrorNum),Fields.InValidMessage_volume(TotalErrors.ErrorNum),Fields.InValidMessage_comments(TotalErrors.ErrorNum),Fields.InValidMessage_jurisdiction(TotalErrors.ErrorNum),Fields.InValidMessage_adcrecordno(TotalErrors.ErrorNum),Fields.InValidMessage_crlf(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
