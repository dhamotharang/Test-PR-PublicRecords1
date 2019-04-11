IMPORT SALT311,STD;
EXPORT Raw_hygiene(dataset(Raw_layout_IRS5500) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ack_id_cnt := COUNT(GROUP,h.ack_id <> (TYPEOF(h.ack_id))'');
    populated_ack_id_pcnt := AVE(GROUP,IF(h.ack_id = (TYPEOF(h.ack_id))'',0,100));
    maxlength_ack_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ack_id)));
    avelength_ack_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ack_id)),h.ack_id<>(typeof(h.ack_id))'');
    populated_form_plan_year_begin_date_cnt := COUNT(GROUP,h.form_plan_year_begin_date <> (TYPEOF(h.form_plan_year_begin_date))'');
    populated_form_plan_year_begin_date_pcnt := AVE(GROUP,IF(h.form_plan_year_begin_date = (TYPEOF(h.form_plan_year_begin_date))'',0,100));
    maxlength_form_plan_year_begin_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.form_plan_year_begin_date)));
    avelength_form_plan_year_begin_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.form_plan_year_begin_date)),h.form_plan_year_begin_date<>(typeof(h.form_plan_year_begin_date))'');
    populated_form_tax_prd_cnt := COUNT(GROUP,h.form_tax_prd <> (TYPEOF(h.form_tax_prd))'');
    populated_form_tax_prd_pcnt := AVE(GROUP,IF(h.form_tax_prd = (TYPEOF(h.form_tax_prd))'',0,100));
    maxlength_form_tax_prd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.form_tax_prd)));
    avelength_form_tax_prd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.form_tax_prd)),h.form_tax_prd<>(typeof(h.form_tax_prd))'');
    populated_type_plan_entity_cd_cnt := COUNT(GROUP,h.type_plan_entity_cd <> (TYPEOF(h.type_plan_entity_cd))'');
    populated_type_plan_entity_cd_pcnt := AVE(GROUP,IF(h.type_plan_entity_cd = (TYPEOF(h.type_plan_entity_cd))'',0,100));
    maxlength_type_plan_entity_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_plan_entity_cd)));
    avelength_type_plan_entity_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_plan_entity_cd)),h.type_plan_entity_cd<>(typeof(h.type_plan_entity_cd))'');
    populated_type_dfe_plan_entity_cd_cnt := COUNT(GROUP,h.type_dfe_plan_entity_cd <> (TYPEOF(h.type_dfe_plan_entity_cd))'');
    populated_type_dfe_plan_entity_cd_pcnt := AVE(GROUP,IF(h.type_dfe_plan_entity_cd = (TYPEOF(h.type_dfe_plan_entity_cd))'',0,100));
    maxlength_type_dfe_plan_entity_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_dfe_plan_entity_cd)));
    avelength_type_dfe_plan_entity_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_dfe_plan_entity_cd)),h.type_dfe_plan_entity_cd<>(typeof(h.type_dfe_plan_entity_cd))'');
    populated_initial_filing_ind_cnt := COUNT(GROUP,h.initial_filing_ind <> (TYPEOF(h.initial_filing_ind))'');
    populated_initial_filing_ind_pcnt := AVE(GROUP,IF(h.initial_filing_ind = (TYPEOF(h.initial_filing_ind))'',0,100));
    maxlength_initial_filing_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.initial_filing_ind)));
    avelength_initial_filing_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.initial_filing_ind)),h.initial_filing_ind<>(typeof(h.initial_filing_ind))'');
    populated_amended_ind_cnt := COUNT(GROUP,h.amended_ind <> (TYPEOF(h.amended_ind))'');
    populated_amended_ind_pcnt := AVE(GROUP,IF(h.amended_ind = (TYPEOF(h.amended_ind))'',0,100));
    maxlength_amended_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amended_ind)));
    avelength_amended_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amended_ind)),h.amended_ind<>(typeof(h.amended_ind))'');
    populated_final_filing_ind_cnt := COUNT(GROUP,h.final_filing_ind <> (TYPEOF(h.final_filing_ind))'');
    populated_final_filing_ind_pcnt := AVE(GROUP,IF(h.final_filing_ind = (TYPEOF(h.final_filing_ind))'',0,100));
    maxlength_final_filing_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.final_filing_ind)));
    avelength_final_filing_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.final_filing_ind)),h.final_filing_ind<>(typeof(h.final_filing_ind))'');
    populated_short_plan_yr_ind_cnt := COUNT(GROUP,h.short_plan_yr_ind <> (TYPEOF(h.short_plan_yr_ind))'');
    populated_short_plan_yr_ind_pcnt := AVE(GROUP,IF(h.short_plan_yr_ind = (TYPEOF(h.short_plan_yr_ind))'',0,100));
    maxlength_short_plan_yr_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.short_plan_yr_ind)));
    avelength_short_plan_yr_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.short_plan_yr_ind)),h.short_plan_yr_ind<>(typeof(h.short_plan_yr_ind))'');
    populated_collective_bargain_ind_cnt := COUNT(GROUP,h.collective_bargain_ind <> (TYPEOF(h.collective_bargain_ind))'');
    populated_collective_bargain_ind_pcnt := AVE(GROUP,IF(h.collective_bargain_ind = (TYPEOF(h.collective_bargain_ind))'',0,100));
    maxlength_collective_bargain_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.collective_bargain_ind)));
    avelength_collective_bargain_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.collective_bargain_ind)),h.collective_bargain_ind<>(typeof(h.collective_bargain_ind))'');
    populated_f5558_application_filed_ind_cnt := COUNT(GROUP,h.f5558_application_filed_ind <> (TYPEOF(h.f5558_application_filed_ind))'');
    populated_f5558_application_filed_ind_pcnt := AVE(GROUP,IF(h.f5558_application_filed_ind = (TYPEOF(h.f5558_application_filed_ind))'',0,100));
    maxlength_f5558_application_filed_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.f5558_application_filed_ind)));
    avelength_f5558_application_filed_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.f5558_application_filed_ind)),h.f5558_application_filed_ind<>(typeof(h.f5558_application_filed_ind))'');
    populated_ext_automatic_ind_cnt := COUNT(GROUP,h.ext_automatic_ind <> (TYPEOF(h.ext_automatic_ind))'');
    populated_ext_automatic_ind_pcnt := AVE(GROUP,IF(h.ext_automatic_ind = (TYPEOF(h.ext_automatic_ind))'',0,100));
    maxlength_ext_automatic_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ext_automatic_ind)));
    avelength_ext_automatic_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ext_automatic_ind)),h.ext_automatic_ind<>(typeof(h.ext_automatic_ind))'');
    populated_dfvc_program_ind_cnt := COUNT(GROUP,h.dfvc_program_ind <> (TYPEOF(h.dfvc_program_ind))'');
    populated_dfvc_program_ind_pcnt := AVE(GROUP,IF(h.dfvc_program_ind = (TYPEOF(h.dfvc_program_ind))'',0,100));
    maxlength_dfvc_program_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dfvc_program_ind)));
    avelength_dfvc_program_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dfvc_program_ind)),h.dfvc_program_ind<>(typeof(h.dfvc_program_ind))'');
    populated_ext_special_ind_cnt := COUNT(GROUP,h.ext_special_ind <> (TYPEOF(h.ext_special_ind))'');
    populated_ext_special_ind_pcnt := AVE(GROUP,IF(h.ext_special_ind = (TYPEOF(h.ext_special_ind))'',0,100));
    maxlength_ext_special_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ext_special_ind)));
    avelength_ext_special_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ext_special_ind)),h.ext_special_ind<>(typeof(h.ext_special_ind))'');
    populated_ext_special_text_cnt := COUNT(GROUP,h.ext_special_text <> (TYPEOF(h.ext_special_text))'');
    populated_ext_special_text_pcnt := AVE(GROUP,IF(h.ext_special_text = (TYPEOF(h.ext_special_text))'',0,100));
    maxlength_ext_special_text := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ext_special_text)));
    avelength_ext_special_text := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ext_special_text)),h.ext_special_text<>(typeof(h.ext_special_text))'');
    populated_plan_name_cnt := COUNT(GROUP,h.plan_name <> (TYPEOF(h.plan_name))'');
    populated_plan_name_pcnt := AVE(GROUP,IF(h.plan_name = (TYPEOF(h.plan_name))'',0,100));
    maxlength_plan_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_name)));
    avelength_plan_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_name)),h.plan_name<>(typeof(h.plan_name))'');
    populated_spons_dfe_pn_cnt := COUNT(GROUP,h.spons_dfe_pn <> (TYPEOF(h.spons_dfe_pn))'');
    populated_spons_dfe_pn_pcnt := AVE(GROUP,IF(h.spons_dfe_pn = (TYPEOF(h.spons_dfe_pn))'',0,100));
    maxlength_spons_dfe_pn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_pn)));
    avelength_spons_dfe_pn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_pn)),h.spons_dfe_pn<>(typeof(h.spons_dfe_pn))'');
    populated_plan_eff_date_cnt := COUNT(GROUP,h.plan_eff_date <> (TYPEOF(h.plan_eff_date))'');
    populated_plan_eff_date_pcnt := AVE(GROUP,IF(h.plan_eff_date = (TYPEOF(h.plan_eff_date))'',0,100));
    maxlength_plan_eff_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_eff_date)));
    avelength_plan_eff_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plan_eff_date)),h.plan_eff_date<>(typeof(h.plan_eff_date))'');
    populated_sponsor_dfe_name_cnt := COUNT(GROUP,h.sponsor_dfe_name <> (TYPEOF(h.sponsor_dfe_name))'');
    populated_sponsor_dfe_name_pcnt := AVE(GROUP,IF(h.sponsor_dfe_name = (TYPEOF(h.sponsor_dfe_name))'',0,100));
    maxlength_sponsor_dfe_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sponsor_dfe_name)));
    avelength_sponsor_dfe_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sponsor_dfe_name)),h.sponsor_dfe_name<>(typeof(h.sponsor_dfe_name))'');
    populated_spons_dfe_dba_name_cnt := COUNT(GROUP,h.spons_dfe_dba_name <> (TYPEOF(h.spons_dfe_dba_name))'');
    populated_spons_dfe_dba_name_pcnt := AVE(GROUP,IF(h.spons_dfe_dba_name = (TYPEOF(h.spons_dfe_dba_name))'',0,100));
    maxlength_spons_dfe_dba_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_dba_name)));
    avelength_spons_dfe_dba_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_dba_name)),h.spons_dfe_dba_name<>(typeof(h.spons_dfe_dba_name))'');
    populated_spons_dfe_care_of_name_cnt := COUNT(GROUP,h.spons_dfe_care_of_name <> (TYPEOF(h.spons_dfe_care_of_name))'');
    populated_spons_dfe_care_of_name_pcnt := AVE(GROUP,IF(h.spons_dfe_care_of_name = (TYPEOF(h.spons_dfe_care_of_name))'',0,100));
    maxlength_spons_dfe_care_of_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_care_of_name)));
    avelength_spons_dfe_care_of_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_care_of_name)),h.spons_dfe_care_of_name<>(typeof(h.spons_dfe_care_of_name))'');
    populated_spons_dfe_mail_us_address1_cnt := COUNT(GROUP,h.spons_dfe_mail_us_address1 <> (TYPEOF(h.spons_dfe_mail_us_address1))'');
    populated_spons_dfe_mail_us_address1_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_us_address1 = (TYPEOF(h.spons_dfe_mail_us_address1))'',0,100));
    maxlength_spons_dfe_mail_us_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_us_address1)));
    avelength_spons_dfe_mail_us_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_us_address1)),h.spons_dfe_mail_us_address1<>(typeof(h.spons_dfe_mail_us_address1))'');
    populated_spons_dfe_mail_us_address2_cnt := COUNT(GROUP,h.spons_dfe_mail_us_address2 <> (TYPEOF(h.spons_dfe_mail_us_address2))'');
    populated_spons_dfe_mail_us_address2_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_us_address2 = (TYPEOF(h.spons_dfe_mail_us_address2))'',0,100));
    maxlength_spons_dfe_mail_us_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_us_address2)));
    avelength_spons_dfe_mail_us_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_us_address2)),h.spons_dfe_mail_us_address2<>(typeof(h.spons_dfe_mail_us_address2))'');
    populated_spons_dfe_mail_us_city_cnt := COUNT(GROUP,h.spons_dfe_mail_us_city <> (TYPEOF(h.spons_dfe_mail_us_city))'');
    populated_spons_dfe_mail_us_city_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_us_city = (TYPEOF(h.spons_dfe_mail_us_city))'',0,100));
    maxlength_spons_dfe_mail_us_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_us_city)));
    avelength_spons_dfe_mail_us_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_us_city)),h.spons_dfe_mail_us_city<>(typeof(h.spons_dfe_mail_us_city))'');
    populated_spons_dfe_mail_us_state_cnt := COUNT(GROUP,h.spons_dfe_mail_us_state <> (TYPEOF(h.spons_dfe_mail_us_state))'');
    populated_spons_dfe_mail_us_state_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_us_state = (TYPEOF(h.spons_dfe_mail_us_state))'',0,100));
    maxlength_spons_dfe_mail_us_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_us_state)));
    avelength_spons_dfe_mail_us_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_us_state)),h.spons_dfe_mail_us_state<>(typeof(h.spons_dfe_mail_us_state))'');
    populated_spons_dfe_mail_us_zip_cnt := COUNT(GROUP,h.spons_dfe_mail_us_zip <> (TYPEOF(h.spons_dfe_mail_us_zip))'');
    populated_spons_dfe_mail_us_zip_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_us_zip = (TYPEOF(h.spons_dfe_mail_us_zip))'',0,100));
    maxlength_spons_dfe_mail_us_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_us_zip)));
    avelength_spons_dfe_mail_us_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_us_zip)),h.spons_dfe_mail_us_zip<>(typeof(h.spons_dfe_mail_us_zip))'');
    populated_spons_dfe_mail_foreign_addr1_cnt := COUNT(GROUP,h.spons_dfe_mail_foreign_addr1 <> (TYPEOF(h.spons_dfe_mail_foreign_addr1))'');
    populated_spons_dfe_mail_foreign_addr1_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_foreign_addr1 = (TYPEOF(h.spons_dfe_mail_foreign_addr1))'',0,100));
    maxlength_spons_dfe_mail_foreign_addr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_foreign_addr1)));
    avelength_spons_dfe_mail_foreign_addr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_foreign_addr1)),h.spons_dfe_mail_foreign_addr1<>(typeof(h.spons_dfe_mail_foreign_addr1))'');
    populated_spons_dfe_mail_foreign_addr2_cnt := COUNT(GROUP,h.spons_dfe_mail_foreign_addr2 <> (TYPEOF(h.spons_dfe_mail_foreign_addr2))'');
    populated_spons_dfe_mail_foreign_addr2_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_foreign_addr2 = (TYPEOF(h.spons_dfe_mail_foreign_addr2))'',0,100));
    maxlength_spons_dfe_mail_foreign_addr2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_foreign_addr2)));
    avelength_spons_dfe_mail_foreign_addr2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_foreign_addr2)),h.spons_dfe_mail_foreign_addr2<>(typeof(h.spons_dfe_mail_foreign_addr2))'');
    populated_spons_dfe_mail_foreign_city_cnt := COUNT(GROUP,h.spons_dfe_mail_foreign_city <> (TYPEOF(h.spons_dfe_mail_foreign_city))'');
    populated_spons_dfe_mail_foreign_city_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_foreign_city = (TYPEOF(h.spons_dfe_mail_foreign_city))'',0,100));
    maxlength_spons_dfe_mail_foreign_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_foreign_city)));
    avelength_spons_dfe_mail_foreign_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_foreign_city)),h.spons_dfe_mail_foreign_city<>(typeof(h.spons_dfe_mail_foreign_city))'');
    populated_spons_dfe_mail_forgn_prov_st_cnt := COUNT(GROUP,h.spons_dfe_mail_forgn_prov_st <> (TYPEOF(h.spons_dfe_mail_forgn_prov_st))'');
    populated_spons_dfe_mail_forgn_prov_st_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_forgn_prov_st = (TYPEOF(h.spons_dfe_mail_forgn_prov_st))'',0,100));
    maxlength_spons_dfe_mail_forgn_prov_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_forgn_prov_st)));
    avelength_spons_dfe_mail_forgn_prov_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_forgn_prov_st)),h.spons_dfe_mail_forgn_prov_st<>(typeof(h.spons_dfe_mail_forgn_prov_st))'');
    populated_spons_dfe_mail_foreign_cntry_cnt := COUNT(GROUP,h.spons_dfe_mail_foreign_cntry <> (TYPEOF(h.spons_dfe_mail_foreign_cntry))'');
    populated_spons_dfe_mail_foreign_cntry_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_foreign_cntry = (TYPEOF(h.spons_dfe_mail_foreign_cntry))'',0,100));
    maxlength_spons_dfe_mail_foreign_cntry := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_foreign_cntry)));
    avelength_spons_dfe_mail_foreign_cntry := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_foreign_cntry)),h.spons_dfe_mail_foreign_cntry<>(typeof(h.spons_dfe_mail_foreign_cntry))'');
    populated_spons_dfe_mail_forgn_postal_cd_cnt := COUNT(GROUP,h.spons_dfe_mail_forgn_postal_cd <> (TYPEOF(h.spons_dfe_mail_forgn_postal_cd))'');
    populated_spons_dfe_mail_forgn_postal_cd_pcnt := AVE(GROUP,IF(h.spons_dfe_mail_forgn_postal_cd = (TYPEOF(h.spons_dfe_mail_forgn_postal_cd))'',0,100));
    maxlength_spons_dfe_mail_forgn_postal_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_forgn_postal_cd)));
    avelength_spons_dfe_mail_forgn_postal_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_mail_forgn_postal_cd)),h.spons_dfe_mail_forgn_postal_cd<>(typeof(h.spons_dfe_mail_forgn_postal_cd))'');
    populated_spons_dfe_loc_us_address1_cnt := COUNT(GROUP,h.spons_dfe_loc_us_address1 <> (TYPEOF(h.spons_dfe_loc_us_address1))'');
    populated_spons_dfe_loc_us_address1_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_us_address1 = (TYPEOF(h.spons_dfe_loc_us_address1))'',0,100));
    maxlength_spons_dfe_loc_us_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_us_address1)));
    avelength_spons_dfe_loc_us_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_us_address1)),h.spons_dfe_loc_us_address1<>(typeof(h.spons_dfe_loc_us_address1))'');
    populated_spons_dfe_loc_us_address2_cnt := COUNT(GROUP,h.spons_dfe_loc_us_address2 <> (TYPEOF(h.spons_dfe_loc_us_address2))'');
    populated_spons_dfe_loc_us_address2_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_us_address2 = (TYPEOF(h.spons_dfe_loc_us_address2))'',0,100));
    maxlength_spons_dfe_loc_us_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_us_address2)));
    avelength_spons_dfe_loc_us_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_us_address2)),h.spons_dfe_loc_us_address2<>(typeof(h.spons_dfe_loc_us_address2))'');
    populated_spons_dfe_loc_us_city_cnt := COUNT(GROUP,h.spons_dfe_loc_us_city <> (TYPEOF(h.spons_dfe_loc_us_city))'');
    populated_spons_dfe_loc_us_city_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_us_city = (TYPEOF(h.spons_dfe_loc_us_city))'',0,100));
    maxlength_spons_dfe_loc_us_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_us_city)));
    avelength_spons_dfe_loc_us_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_us_city)),h.spons_dfe_loc_us_city<>(typeof(h.spons_dfe_loc_us_city))'');
    populated_spons_dfe_loc_us_state_cnt := COUNT(GROUP,h.spons_dfe_loc_us_state <> (TYPEOF(h.spons_dfe_loc_us_state))'');
    populated_spons_dfe_loc_us_state_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_us_state = (TYPEOF(h.spons_dfe_loc_us_state))'',0,100));
    maxlength_spons_dfe_loc_us_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_us_state)));
    avelength_spons_dfe_loc_us_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_us_state)),h.spons_dfe_loc_us_state<>(typeof(h.spons_dfe_loc_us_state))'');
    populated_spons_dfe_loc_us_zip_cnt := COUNT(GROUP,h.spons_dfe_loc_us_zip <> (TYPEOF(h.spons_dfe_loc_us_zip))'');
    populated_spons_dfe_loc_us_zip_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_us_zip = (TYPEOF(h.spons_dfe_loc_us_zip))'',0,100));
    maxlength_spons_dfe_loc_us_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_us_zip)));
    avelength_spons_dfe_loc_us_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_us_zip)),h.spons_dfe_loc_us_zip<>(typeof(h.spons_dfe_loc_us_zip))'');
    populated_spons_dfe_loc_foreign_address1_cnt := COUNT(GROUP,h.spons_dfe_loc_foreign_address1 <> (TYPEOF(h.spons_dfe_loc_foreign_address1))'');
    populated_spons_dfe_loc_foreign_address1_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_foreign_address1 = (TYPEOF(h.spons_dfe_loc_foreign_address1))'',0,100));
    maxlength_spons_dfe_loc_foreign_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_foreign_address1)));
    avelength_spons_dfe_loc_foreign_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_foreign_address1)),h.spons_dfe_loc_foreign_address1<>(typeof(h.spons_dfe_loc_foreign_address1))'');
    populated_spons_dfe_loc_foreign_address2_cnt := COUNT(GROUP,h.spons_dfe_loc_foreign_address2 <> (TYPEOF(h.spons_dfe_loc_foreign_address2))'');
    populated_spons_dfe_loc_foreign_address2_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_foreign_address2 = (TYPEOF(h.spons_dfe_loc_foreign_address2))'',0,100));
    maxlength_spons_dfe_loc_foreign_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_foreign_address2)));
    avelength_spons_dfe_loc_foreign_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_foreign_address2)),h.spons_dfe_loc_foreign_address2<>(typeof(h.spons_dfe_loc_foreign_address2))'');
    populated_spons_dfe_loc_foreign_city_cnt := COUNT(GROUP,h.spons_dfe_loc_foreign_city <> (TYPEOF(h.spons_dfe_loc_foreign_city))'');
    populated_spons_dfe_loc_foreign_city_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_foreign_city = (TYPEOF(h.spons_dfe_loc_foreign_city))'',0,100));
    maxlength_spons_dfe_loc_foreign_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_foreign_city)));
    avelength_spons_dfe_loc_foreign_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_foreign_city)),h.spons_dfe_loc_foreign_city<>(typeof(h.spons_dfe_loc_foreign_city))'');
    populated_spons_dfe_loc_forgn_prov_st_cnt := COUNT(GROUP,h.spons_dfe_loc_forgn_prov_st <> (TYPEOF(h.spons_dfe_loc_forgn_prov_st))'');
    populated_spons_dfe_loc_forgn_prov_st_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_forgn_prov_st = (TYPEOF(h.spons_dfe_loc_forgn_prov_st))'',0,100));
    maxlength_spons_dfe_loc_forgn_prov_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_forgn_prov_st)));
    avelength_spons_dfe_loc_forgn_prov_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_forgn_prov_st)),h.spons_dfe_loc_forgn_prov_st<>(typeof(h.spons_dfe_loc_forgn_prov_st))'');
    populated_spons_dfe_loc_foreign_cntry_cnt := COUNT(GROUP,h.spons_dfe_loc_foreign_cntry <> (TYPEOF(h.spons_dfe_loc_foreign_cntry))'');
    populated_spons_dfe_loc_foreign_cntry_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_foreign_cntry = (TYPEOF(h.spons_dfe_loc_foreign_cntry))'',0,100));
    maxlength_spons_dfe_loc_foreign_cntry := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_foreign_cntry)));
    avelength_spons_dfe_loc_foreign_cntry := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_foreign_cntry)),h.spons_dfe_loc_foreign_cntry<>(typeof(h.spons_dfe_loc_foreign_cntry))'');
    populated_spons_dfe_loc_forgn_postal_cd_cnt := COUNT(GROUP,h.spons_dfe_loc_forgn_postal_cd <> (TYPEOF(h.spons_dfe_loc_forgn_postal_cd))'');
    populated_spons_dfe_loc_forgn_postal_cd_pcnt := AVE(GROUP,IF(h.spons_dfe_loc_forgn_postal_cd = (TYPEOF(h.spons_dfe_loc_forgn_postal_cd))'',0,100));
    maxlength_spons_dfe_loc_forgn_postal_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_forgn_postal_cd)));
    avelength_spons_dfe_loc_forgn_postal_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_loc_forgn_postal_cd)),h.spons_dfe_loc_forgn_postal_cd<>(typeof(h.spons_dfe_loc_forgn_postal_cd))'');
    populated_spons_dfe_ein_cnt := COUNT(GROUP,h.spons_dfe_ein <> (TYPEOF(h.spons_dfe_ein))'');
    populated_spons_dfe_ein_pcnt := AVE(GROUP,IF(h.spons_dfe_ein = (TYPEOF(h.spons_dfe_ein))'',0,100));
    maxlength_spons_dfe_ein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_ein)));
    avelength_spons_dfe_ein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_ein)),h.spons_dfe_ein<>(typeof(h.spons_dfe_ein))'');
    populated_spons_dfe_phone_num_cnt := COUNT(GROUP,h.spons_dfe_phone_num <> (TYPEOF(h.spons_dfe_phone_num))'');
    populated_spons_dfe_phone_num_pcnt := AVE(GROUP,IF(h.spons_dfe_phone_num = (TYPEOF(h.spons_dfe_phone_num))'',0,100));
    maxlength_spons_dfe_phone_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_phone_num)));
    avelength_spons_dfe_phone_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_phone_num)),h.spons_dfe_phone_num<>(typeof(h.spons_dfe_phone_num))'');
    populated_business_code_cnt := COUNT(GROUP,h.business_code <> (TYPEOF(h.business_code))'');
    populated_business_code_pcnt := AVE(GROUP,IF(h.business_code = (TYPEOF(h.business_code))'',0,100));
    maxlength_business_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_code)));
    avelength_business_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_code)),h.business_code<>(typeof(h.business_code))'');
    populated_admin_name_cnt := COUNT(GROUP,h.admin_name <> (TYPEOF(h.admin_name))'');
    populated_admin_name_pcnt := AVE(GROUP,IF(h.admin_name = (TYPEOF(h.admin_name))'',0,100));
    maxlength_admin_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_name)));
    avelength_admin_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_name)),h.admin_name<>(typeof(h.admin_name))'');
    populated_admin_care_of_name_cnt := COUNT(GROUP,h.admin_care_of_name <> (TYPEOF(h.admin_care_of_name))'');
    populated_admin_care_of_name_pcnt := AVE(GROUP,IF(h.admin_care_of_name = (TYPEOF(h.admin_care_of_name))'',0,100));
    maxlength_admin_care_of_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_care_of_name)));
    avelength_admin_care_of_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_care_of_name)),h.admin_care_of_name<>(typeof(h.admin_care_of_name))'');
    populated_admin_us_address1_cnt := COUNT(GROUP,h.admin_us_address1 <> (TYPEOF(h.admin_us_address1))'');
    populated_admin_us_address1_pcnt := AVE(GROUP,IF(h.admin_us_address1 = (TYPEOF(h.admin_us_address1))'',0,100));
    maxlength_admin_us_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_us_address1)));
    avelength_admin_us_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_us_address1)),h.admin_us_address1<>(typeof(h.admin_us_address1))'');
    populated_admin_us_address2_cnt := COUNT(GROUP,h.admin_us_address2 <> (TYPEOF(h.admin_us_address2))'');
    populated_admin_us_address2_pcnt := AVE(GROUP,IF(h.admin_us_address2 = (TYPEOF(h.admin_us_address2))'',0,100));
    maxlength_admin_us_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_us_address2)));
    avelength_admin_us_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_us_address2)),h.admin_us_address2<>(typeof(h.admin_us_address2))'');
    populated_admin_us_city_cnt := COUNT(GROUP,h.admin_us_city <> (TYPEOF(h.admin_us_city))'');
    populated_admin_us_city_pcnt := AVE(GROUP,IF(h.admin_us_city = (TYPEOF(h.admin_us_city))'',0,100));
    maxlength_admin_us_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_us_city)));
    avelength_admin_us_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_us_city)),h.admin_us_city<>(typeof(h.admin_us_city))'');
    populated_admin_us_state_cnt := COUNT(GROUP,h.admin_us_state <> (TYPEOF(h.admin_us_state))'');
    populated_admin_us_state_pcnt := AVE(GROUP,IF(h.admin_us_state = (TYPEOF(h.admin_us_state))'',0,100));
    maxlength_admin_us_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_us_state)));
    avelength_admin_us_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_us_state)),h.admin_us_state<>(typeof(h.admin_us_state))'');
    populated_admin_us_zip_cnt := COUNT(GROUP,h.admin_us_zip <> (TYPEOF(h.admin_us_zip))'');
    populated_admin_us_zip_pcnt := AVE(GROUP,IF(h.admin_us_zip = (TYPEOF(h.admin_us_zip))'',0,100));
    maxlength_admin_us_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_us_zip)));
    avelength_admin_us_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_us_zip)),h.admin_us_zip<>(typeof(h.admin_us_zip))'');
    populated_admin_foreign_address1_cnt := COUNT(GROUP,h.admin_foreign_address1 <> (TYPEOF(h.admin_foreign_address1))'');
    populated_admin_foreign_address1_pcnt := AVE(GROUP,IF(h.admin_foreign_address1 = (TYPEOF(h.admin_foreign_address1))'',0,100));
    maxlength_admin_foreign_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_address1)));
    avelength_admin_foreign_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_address1)),h.admin_foreign_address1<>(typeof(h.admin_foreign_address1))'');
    populated_admin_foreign_address2_cnt := COUNT(GROUP,h.admin_foreign_address2 <> (TYPEOF(h.admin_foreign_address2))'');
    populated_admin_foreign_address2_pcnt := AVE(GROUP,IF(h.admin_foreign_address2 = (TYPEOF(h.admin_foreign_address2))'',0,100));
    maxlength_admin_foreign_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_address2)));
    avelength_admin_foreign_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_address2)),h.admin_foreign_address2<>(typeof(h.admin_foreign_address2))'');
    populated_admin_foreign_city_cnt := COUNT(GROUP,h.admin_foreign_city <> (TYPEOF(h.admin_foreign_city))'');
    populated_admin_foreign_city_pcnt := AVE(GROUP,IF(h.admin_foreign_city = (TYPEOF(h.admin_foreign_city))'',0,100));
    maxlength_admin_foreign_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_city)));
    avelength_admin_foreign_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_city)),h.admin_foreign_city<>(typeof(h.admin_foreign_city))'');
    populated_admin_foreign_prov_state_cnt := COUNT(GROUP,h.admin_foreign_prov_state <> (TYPEOF(h.admin_foreign_prov_state))'');
    populated_admin_foreign_prov_state_pcnt := AVE(GROUP,IF(h.admin_foreign_prov_state = (TYPEOF(h.admin_foreign_prov_state))'',0,100));
    maxlength_admin_foreign_prov_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_prov_state)));
    avelength_admin_foreign_prov_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_prov_state)),h.admin_foreign_prov_state<>(typeof(h.admin_foreign_prov_state))'');
    populated_admin_foreign_cntry_cnt := COUNT(GROUP,h.admin_foreign_cntry <> (TYPEOF(h.admin_foreign_cntry))'');
    populated_admin_foreign_cntry_pcnt := AVE(GROUP,IF(h.admin_foreign_cntry = (TYPEOF(h.admin_foreign_cntry))'',0,100));
    maxlength_admin_foreign_cntry := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_cntry)));
    avelength_admin_foreign_cntry := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_cntry)),h.admin_foreign_cntry<>(typeof(h.admin_foreign_cntry))'');
    populated_admin_foreign_postal_cd_cnt := COUNT(GROUP,h.admin_foreign_postal_cd <> (TYPEOF(h.admin_foreign_postal_cd))'');
    populated_admin_foreign_postal_cd_pcnt := AVE(GROUP,IF(h.admin_foreign_postal_cd = (TYPEOF(h.admin_foreign_postal_cd))'',0,100));
    maxlength_admin_foreign_postal_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_postal_cd)));
    avelength_admin_foreign_postal_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_foreign_postal_cd)),h.admin_foreign_postal_cd<>(typeof(h.admin_foreign_postal_cd))'');
    populated_admin_ein_cnt := COUNT(GROUP,h.admin_ein <> (TYPEOF(h.admin_ein))'');
    populated_admin_ein_pcnt := AVE(GROUP,IF(h.admin_ein = (TYPEOF(h.admin_ein))'',0,100));
    maxlength_admin_ein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_ein)));
    avelength_admin_ein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_ein)),h.admin_ein<>(typeof(h.admin_ein))'');
    populated_admin_phone_num_cnt := COUNT(GROUP,h.admin_phone_num <> (TYPEOF(h.admin_phone_num))'');
    populated_admin_phone_num_pcnt := AVE(GROUP,IF(h.admin_phone_num = (TYPEOF(h.admin_phone_num))'',0,100));
    maxlength_admin_phone_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_phone_num)));
    avelength_admin_phone_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_phone_num)),h.admin_phone_num<>(typeof(h.admin_phone_num))'');
    populated_last_rpt_spons_name_cnt := COUNT(GROUP,h.last_rpt_spons_name <> (TYPEOF(h.last_rpt_spons_name))'');
    populated_last_rpt_spons_name_pcnt := AVE(GROUP,IF(h.last_rpt_spons_name = (TYPEOF(h.last_rpt_spons_name))'',0,100));
    maxlength_last_rpt_spons_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_rpt_spons_name)));
    avelength_last_rpt_spons_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_rpt_spons_name)),h.last_rpt_spons_name<>(typeof(h.last_rpt_spons_name))'');
    populated_last_rpt_spons_ein_cnt := COUNT(GROUP,h.last_rpt_spons_ein <> (TYPEOF(h.last_rpt_spons_ein))'');
    populated_last_rpt_spons_ein_pcnt := AVE(GROUP,IF(h.last_rpt_spons_ein = (TYPEOF(h.last_rpt_spons_ein))'',0,100));
    maxlength_last_rpt_spons_ein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_rpt_spons_ein)));
    avelength_last_rpt_spons_ein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_rpt_spons_ein)),h.last_rpt_spons_ein<>(typeof(h.last_rpt_spons_ein))'');
    populated_last_rpt_plan_num_cnt := COUNT(GROUP,h.last_rpt_plan_num <> (TYPEOF(h.last_rpt_plan_num))'');
    populated_last_rpt_plan_num_pcnt := AVE(GROUP,IF(h.last_rpt_plan_num = (TYPEOF(h.last_rpt_plan_num))'',0,100));
    maxlength_last_rpt_plan_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_rpt_plan_num)));
    avelength_last_rpt_plan_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_rpt_plan_num)),h.last_rpt_plan_num<>(typeof(h.last_rpt_plan_num))'');
    populated_admin_signed_date_cnt := COUNT(GROUP,h.admin_signed_date <> (TYPEOF(h.admin_signed_date))'');
    populated_admin_signed_date_pcnt := AVE(GROUP,IF(h.admin_signed_date = (TYPEOF(h.admin_signed_date))'',0,100));
    maxlength_admin_signed_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_signed_date)));
    avelength_admin_signed_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_signed_date)),h.admin_signed_date<>(typeof(h.admin_signed_date))'');
    populated_admin_signed_name_cnt := COUNT(GROUP,h.admin_signed_name <> (TYPEOF(h.admin_signed_name))'');
    populated_admin_signed_name_pcnt := AVE(GROUP,IF(h.admin_signed_name = (TYPEOF(h.admin_signed_name))'',0,100));
    maxlength_admin_signed_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_signed_name)));
    avelength_admin_signed_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_signed_name)),h.admin_signed_name<>(typeof(h.admin_signed_name))'');
    populated_spons_signed_date_cnt := COUNT(GROUP,h.spons_signed_date <> (TYPEOF(h.spons_signed_date))'');
    populated_spons_signed_date_pcnt := AVE(GROUP,IF(h.spons_signed_date = (TYPEOF(h.spons_signed_date))'',0,100));
    maxlength_spons_signed_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_signed_date)));
    avelength_spons_signed_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_signed_date)),h.spons_signed_date<>(typeof(h.spons_signed_date))'');
    populated_spons_signed_name_cnt := COUNT(GROUP,h.spons_signed_name <> (TYPEOF(h.spons_signed_name))'');
    populated_spons_signed_name_pcnt := AVE(GROUP,IF(h.spons_signed_name = (TYPEOF(h.spons_signed_name))'',0,100));
    maxlength_spons_signed_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_signed_name)));
    avelength_spons_signed_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_signed_name)),h.spons_signed_name<>(typeof(h.spons_signed_name))'');
    populated_dfe_signed_date_cnt := COUNT(GROUP,h.dfe_signed_date <> (TYPEOF(h.dfe_signed_date))'');
    populated_dfe_signed_date_pcnt := AVE(GROUP,IF(h.dfe_signed_date = (TYPEOF(h.dfe_signed_date))'',0,100));
    maxlength_dfe_signed_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dfe_signed_date)));
    avelength_dfe_signed_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dfe_signed_date)),h.dfe_signed_date<>(typeof(h.dfe_signed_date))'');
    populated_dfe_signed_name_cnt := COUNT(GROUP,h.dfe_signed_name <> (TYPEOF(h.dfe_signed_name))'');
    populated_dfe_signed_name_pcnt := AVE(GROUP,IF(h.dfe_signed_name = (TYPEOF(h.dfe_signed_name))'',0,100));
    maxlength_dfe_signed_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dfe_signed_name)));
    avelength_dfe_signed_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dfe_signed_name)),h.dfe_signed_name<>(typeof(h.dfe_signed_name))'');
    populated_tot_partcp_boy_cnt_cnt := COUNT(GROUP,h.tot_partcp_boy_cnt <> (TYPEOF(h.tot_partcp_boy_cnt))'');
    populated_tot_partcp_boy_cnt_pcnt := AVE(GROUP,IF(h.tot_partcp_boy_cnt = (TYPEOF(h.tot_partcp_boy_cnt))'',0,100));
    maxlength_tot_partcp_boy_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tot_partcp_boy_cnt)));
    avelength_tot_partcp_boy_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tot_partcp_boy_cnt)),h.tot_partcp_boy_cnt<>(typeof(h.tot_partcp_boy_cnt))'');
    populated_tot_active_partcp_cnt_cnt := COUNT(GROUP,h.tot_active_partcp_cnt <> (TYPEOF(h.tot_active_partcp_cnt))'');
    populated_tot_active_partcp_cnt_pcnt := AVE(GROUP,IF(h.tot_active_partcp_cnt = (TYPEOF(h.tot_active_partcp_cnt))'',0,100));
    maxlength_tot_active_partcp_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tot_active_partcp_cnt)));
    avelength_tot_active_partcp_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tot_active_partcp_cnt)),h.tot_active_partcp_cnt<>(typeof(h.tot_active_partcp_cnt))'');
    populated_rtd_sep_partcp_rcvg_cnt_cnt := COUNT(GROUP,h.rtd_sep_partcp_rcvg_cnt <> (TYPEOF(h.rtd_sep_partcp_rcvg_cnt))'');
    populated_rtd_sep_partcp_rcvg_cnt_pcnt := AVE(GROUP,IF(h.rtd_sep_partcp_rcvg_cnt = (TYPEOF(h.rtd_sep_partcp_rcvg_cnt))'',0,100));
    maxlength_rtd_sep_partcp_rcvg_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rtd_sep_partcp_rcvg_cnt)));
    avelength_rtd_sep_partcp_rcvg_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rtd_sep_partcp_rcvg_cnt)),h.rtd_sep_partcp_rcvg_cnt<>(typeof(h.rtd_sep_partcp_rcvg_cnt))'');
    populated_rtd_sep_partcp_fut_cnt_cnt := COUNT(GROUP,h.rtd_sep_partcp_fut_cnt <> (TYPEOF(h.rtd_sep_partcp_fut_cnt))'');
    populated_rtd_sep_partcp_fut_cnt_pcnt := AVE(GROUP,IF(h.rtd_sep_partcp_fut_cnt = (TYPEOF(h.rtd_sep_partcp_fut_cnt))'',0,100));
    maxlength_rtd_sep_partcp_fut_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rtd_sep_partcp_fut_cnt)));
    avelength_rtd_sep_partcp_fut_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rtd_sep_partcp_fut_cnt)),h.rtd_sep_partcp_fut_cnt<>(typeof(h.rtd_sep_partcp_fut_cnt))'');
    populated_subtl_act_rtd_sep_cnt_cnt := COUNT(GROUP,h.subtl_act_rtd_sep_cnt <> (TYPEOF(h.subtl_act_rtd_sep_cnt))'');
    populated_subtl_act_rtd_sep_cnt_pcnt := AVE(GROUP,IF(h.subtl_act_rtd_sep_cnt = (TYPEOF(h.subtl_act_rtd_sep_cnt))'',0,100));
    maxlength_subtl_act_rtd_sep_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subtl_act_rtd_sep_cnt)));
    avelength_subtl_act_rtd_sep_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subtl_act_rtd_sep_cnt)),h.subtl_act_rtd_sep_cnt<>(typeof(h.subtl_act_rtd_sep_cnt))'');
    populated_benef_rcvg_bnft_cnt_cnt := COUNT(GROUP,h.benef_rcvg_bnft_cnt <> (TYPEOF(h.benef_rcvg_bnft_cnt))'');
    populated_benef_rcvg_bnft_cnt_pcnt := AVE(GROUP,IF(h.benef_rcvg_bnft_cnt = (TYPEOF(h.benef_rcvg_bnft_cnt))'',0,100));
    maxlength_benef_rcvg_bnft_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.benef_rcvg_bnft_cnt)));
    avelength_benef_rcvg_bnft_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.benef_rcvg_bnft_cnt)),h.benef_rcvg_bnft_cnt<>(typeof(h.benef_rcvg_bnft_cnt))'');
    populated_tot_act_rtd_sep_benef_cnt_cnt := COUNT(GROUP,h.tot_act_rtd_sep_benef_cnt <> (TYPEOF(h.tot_act_rtd_sep_benef_cnt))'');
    populated_tot_act_rtd_sep_benef_cnt_pcnt := AVE(GROUP,IF(h.tot_act_rtd_sep_benef_cnt = (TYPEOF(h.tot_act_rtd_sep_benef_cnt))'',0,100));
    maxlength_tot_act_rtd_sep_benef_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tot_act_rtd_sep_benef_cnt)));
    avelength_tot_act_rtd_sep_benef_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tot_act_rtd_sep_benef_cnt)),h.tot_act_rtd_sep_benef_cnt<>(typeof(h.tot_act_rtd_sep_benef_cnt))'');
    populated_partcp_account_bal_cnt_cnt := COUNT(GROUP,h.partcp_account_bal_cnt <> (TYPEOF(h.partcp_account_bal_cnt))'');
    populated_partcp_account_bal_cnt_pcnt := AVE(GROUP,IF(h.partcp_account_bal_cnt = (TYPEOF(h.partcp_account_bal_cnt))'',0,100));
    maxlength_partcp_account_bal_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.partcp_account_bal_cnt)));
    avelength_partcp_account_bal_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.partcp_account_bal_cnt)),h.partcp_account_bal_cnt<>(typeof(h.partcp_account_bal_cnt))'');
    populated_sep_partcp_partl_vstd_cnt_cnt := COUNT(GROUP,h.sep_partcp_partl_vstd_cnt <> (TYPEOF(h.sep_partcp_partl_vstd_cnt))'');
    populated_sep_partcp_partl_vstd_cnt_pcnt := AVE(GROUP,IF(h.sep_partcp_partl_vstd_cnt = (TYPEOF(h.sep_partcp_partl_vstd_cnt))'',0,100));
    maxlength_sep_partcp_partl_vstd_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sep_partcp_partl_vstd_cnt)));
    avelength_sep_partcp_partl_vstd_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sep_partcp_partl_vstd_cnt)),h.sep_partcp_partl_vstd_cnt<>(typeof(h.sep_partcp_partl_vstd_cnt))'');
    populated_contrib_emplrs_cnt_cnt := COUNT(GROUP,h.contrib_emplrs_cnt <> (TYPEOF(h.contrib_emplrs_cnt))'');
    populated_contrib_emplrs_cnt_pcnt := AVE(GROUP,IF(h.contrib_emplrs_cnt = (TYPEOF(h.contrib_emplrs_cnt))'',0,100));
    maxlength_contrib_emplrs_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contrib_emplrs_cnt)));
    avelength_contrib_emplrs_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contrib_emplrs_cnt)),h.contrib_emplrs_cnt<>(typeof(h.contrib_emplrs_cnt))'');
    populated_type_pension_bnft_code_cnt := COUNT(GROUP,h.type_pension_bnft_code <> (TYPEOF(h.type_pension_bnft_code))'');
    populated_type_pension_bnft_code_pcnt := AVE(GROUP,IF(h.type_pension_bnft_code = (TYPEOF(h.type_pension_bnft_code))'',0,100));
    maxlength_type_pension_bnft_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_pension_bnft_code)));
    avelength_type_pension_bnft_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_pension_bnft_code)),h.type_pension_bnft_code<>(typeof(h.type_pension_bnft_code))'');
    populated_type_welfare_bnft_code_cnt := COUNT(GROUP,h.type_welfare_bnft_code <> (TYPEOF(h.type_welfare_bnft_code))'');
    populated_type_welfare_bnft_code_pcnt := AVE(GROUP,IF(h.type_welfare_bnft_code = (TYPEOF(h.type_welfare_bnft_code))'',0,100));
    maxlength_type_welfare_bnft_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_welfare_bnft_code)));
    avelength_type_welfare_bnft_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_welfare_bnft_code)),h.type_welfare_bnft_code<>(typeof(h.type_welfare_bnft_code))'');
    populated_funding_insurance_ind_cnt := COUNT(GROUP,h.funding_insurance_ind <> (TYPEOF(h.funding_insurance_ind))'');
    populated_funding_insurance_ind_pcnt := AVE(GROUP,IF(h.funding_insurance_ind = (TYPEOF(h.funding_insurance_ind))'',0,100));
    maxlength_funding_insurance_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.funding_insurance_ind)));
    avelength_funding_insurance_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.funding_insurance_ind)),h.funding_insurance_ind<>(typeof(h.funding_insurance_ind))'');
    populated_funding_sec412_ind_cnt := COUNT(GROUP,h.funding_sec412_ind <> (TYPEOF(h.funding_sec412_ind))'');
    populated_funding_sec412_ind_pcnt := AVE(GROUP,IF(h.funding_sec412_ind = (TYPEOF(h.funding_sec412_ind))'',0,100));
    maxlength_funding_sec412_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.funding_sec412_ind)));
    avelength_funding_sec412_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.funding_sec412_ind)),h.funding_sec412_ind<>(typeof(h.funding_sec412_ind))'');
    populated_funding_trust_ind_cnt := COUNT(GROUP,h.funding_trust_ind <> (TYPEOF(h.funding_trust_ind))'');
    populated_funding_trust_ind_pcnt := AVE(GROUP,IF(h.funding_trust_ind = (TYPEOF(h.funding_trust_ind))'',0,100));
    maxlength_funding_trust_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.funding_trust_ind)));
    avelength_funding_trust_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.funding_trust_ind)),h.funding_trust_ind<>(typeof(h.funding_trust_ind))'');
    populated_funding_gen_asset_ind_cnt := COUNT(GROUP,h.funding_gen_asset_ind <> (TYPEOF(h.funding_gen_asset_ind))'');
    populated_funding_gen_asset_ind_pcnt := AVE(GROUP,IF(h.funding_gen_asset_ind = (TYPEOF(h.funding_gen_asset_ind))'',0,100));
    maxlength_funding_gen_asset_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.funding_gen_asset_ind)));
    avelength_funding_gen_asset_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.funding_gen_asset_ind)),h.funding_gen_asset_ind<>(typeof(h.funding_gen_asset_ind))'');
    populated_benefit_insurance_ind_cnt := COUNT(GROUP,h.benefit_insurance_ind <> (TYPEOF(h.benefit_insurance_ind))'');
    populated_benefit_insurance_ind_pcnt := AVE(GROUP,IF(h.benefit_insurance_ind = (TYPEOF(h.benefit_insurance_ind))'',0,100));
    maxlength_benefit_insurance_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.benefit_insurance_ind)));
    avelength_benefit_insurance_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.benefit_insurance_ind)),h.benefit_insurance_ind<>(typeof(h.benefit_insurance_ind))'');
    populated_benefit_sec412_ind_cnt := COUNT(GROUP,h.benefit_sec412_ind <> (TYPEOF(h.benefit_sec412_ind))'');
    populated_benefit_sec412_ind_pcnt := AVE(GROUP,IF(h.benefit_sec412_ind = (TYPEOF(h.benefit_sec412_ind))'',0,100));
    maxlength_benefit_sec412_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.benefit_sec412_ind)));
    avelength_benefit_sec412_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.benefit_sec412_ind)),h.benefit_sec412_ind<>(typeof(h.benefit_sec412_ind))'');
    populated_benefit_trust_ind_cnt := COUNT(GROUP,h.benefit_trust_ind <> (TYPEOF(h.benefit_trust_ind))'');
    populated_benefit_trust_ind_pcnt := AVE(GROUP,IF(h.benefit_trust_ind = (TYPEOF(h.benefit_trust_ind))'',0,100));
    maxlength_benefit_trust_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.benefit_trust_ind)));
    avelength_benefit_trust_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.benefit_trust_ind)),h.benefit_trust_ind<>(typeof(h.benefit_trust_ind))'');
    populated_benefit_gen_asset_ind_cnt := COUNT(GROUP,h.benefit_gen_asset_ind <> (TYPEOF(h.benefit_gen_asset_ind))'');
    populated_benefit_gen_asset_ind_pcnt := AVE(GROUP,IF(h.benefit_gen_asset_ind = (TYPEOF(h.benefit_gen_asset_ind))'',0,100));
    maxlength_benefit_gen_asset_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.benefit_gen_asset_ind)));
    avelength_benefit_gen_asset_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.benefit_gen_asset_ind)),h.benefit_gen_asset_ind<>(typeof(h.benefit_gen_asset_ind))'');
    populated_sch_r_attached_ind_cnt := COUNT(GROUP,h.sch_r_attached_ind <> (TYPEOF(h.sch_r_attached_ind))'');
    populated_sch_r_attached_ind_pcnt := AVE(GROUP,IF(h.sch_r_attached_ind = (TYPEOF(h.sch_r_attached_ind))'',0,100));
    maxlength_sch_r_attached_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_r_attached_ind)));
    avelength_sch_r_attached_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_r_attached_ind)),h.sch_r_attached_ind<>(typeof(h.sch_r_attached_ind))'');
    populated_sch_mb_attached_ind_cnt := COUNT(GROUP,h.sch_mb_attached_ind <> (TYPEOF(h.sch_mb_attached_ind))'');
    populated_sch_mb_attached_ind_pcnt := AVE(GROUP,IF(h.sch_mb_attached_ind = (TYPEOF(h.sch_mb_attached_ind))'',0,100));
    maxlength_sch_mb_attached_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_mb_attached_ind)));
    avelength_sch_mb_attached_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_mb_attached_ind)),h.sch_mb_attached_ind<>(typeof(h.sch_mb_attached_ind))'');
    populated_sch_sb_attached_ind_cnt := COUNT(GROUP,h.sch_sb_attached_ind <> (TYPEOF(h.sch_sb_attached_ind))'');
    populated_sch_sb_attached_ind_pcnt := AVE(GROUP,IF(h.sch_sb_attached_ind = (TYPEOF(h.sch_sb_attached_ind))'',0,100));
    maxlength_sch_sb_attached_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_sb_attached_ind)));
    avelength_sch_sb_attached_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_sb_attached_ind)),h.sch_sb_attached_ind<>(typeof(h.sch_sb_attached_ind))'');
    populated_sch_h_attached_ind_cnt := COUNT(GROUP,h.sch_h_attached_ind <> (TYPEOF(h.sch_h_attached_ind))'');
    populated_sch_h_attached_ind_pcnt := AVE(GROUP,IF(h.sch_h_attached_ind = (TYPEOF(h.sch_h_attached_ind))'',0,100));
    maxlength_sch_h_attached_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_h_attached_ind)));
    avelength_sch_h_attached_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_h_attached_ind)),h.sch_h_attached_ind<>(typeof(h.sch_h_attached_ind))'');
    populated_sch_i_attached_ind_cnt := COUNT(GROUP,h.sch_i_attached_ind <> (TYPEOF(h.sch_i_attached_ind))'');
    populated_sch_i_attached_ind_pcnt := AVE(GROUP,IF(h.sch_i_attached_ind = (TYPEOF(h.sch_i_attached_ind))'',0,100));
    maxlength_sch_i_attached_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_i_attached_ind)));
    avelength_sch_i_attached_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_i_attached_ind)),h.sch_i_attached_ind<>(typeof(h.sch_i_attached_ind))'');
    populated_sch_a_attached_ind_cnt := COUNT(GROUP,h.sch_a_attached_ind <> (TYPEOF(h.sch_a_attached_ind))'');
    populated_sch_a_attached_ind_pcnt := AVE(GROUP,IF(h.sch_a_attached_ind = (TYPEOF(h.sch_a_attached_ind))'',0,100));
    maxlength_sch_a_attached_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_a_attached_ind)));
    avelength_sch_a_attached_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_a_attached_ind)),h.sch_a_attached_ind<>(typeof(h.sch_a_attached_ind))'');
    populated_num_sch_a_attached_cnt_cnt := COUNT(GROUP,h.num_sch_a_attached_cnt <> (TYPEOF(h.num_sch_a_attached_cnt))'');
    populated_num_sch_a_attached_cnt_pcnt := AVE(GROUP,IF(h.num_sch_a_attached_cnt = (TYPEOF(h.num_sch_a_attached_cnt))'',0,100));
    maxlength_num_sch_a_attached_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_sch_a_attached_cnt)));
    avelength_num_sch_a_attached_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_sch_a_attached_cnt)),h.num_sch_a_attached_cnt<>(typeof(h.num_sch_a_attached_cnt))'');
    populated_sch_c_attached_ind_cnt := COUNT(GROUP,h.sch_c_attached_ind <> (TYPEOF(h.sch_c_attached_ind))'');
    populated_sch_c_attached_ind_pcnt := AVE(GROUP,IF(h.sch_c_attached_ind = (TYPEOF(h.sch_c_attached_ind))'',0,100));
    maxlength_sch_c_attached_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_c_attached_ind)));
    avelength_sch_c_attached_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_c_attached_ind)),h.sch_c_attached_ind<>(typeof(h.sch_c_attached_ind))'');
    populated_sch_d_attached_ind_cnt := COUNT(GROUP,h.sch_d_attached_ind <> (TYPEOF(h.sch_d_attached_ind))'');
    populated_sch_d_attached_ind_pcnt := AVE(GROUP,IF(h.sch_d_attached_ind = (TYPEOF(h.sch_d_attached_ind))'',0,100));
    maxlength_sch_d_attached_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_d_attached_ind)));
    avelength_sch_d_attached_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_d_attached_ind)),h.sch_d_attached_ind<>(typeof(h.sch_d_attached_ind))'');
    populated_sch_g_attached_ind_cnt := COUNT(GROUP,h.sch_g_attached_ind <> (TYPEOF(h.sch_g_attached_ind))'');
    populated_sch_g_attached_ind_pcnt := AVE(GROUP,IF(h.sch_g_attached_ind = (TYPEOF(h.sch_g_attached_ind))'',0,100));
    maxlength_sch_g_attached_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_g_attached_ind)));
    avelength_sch_g_attached_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sch_g_attached_ind)),h.sch_g_attached_ind<>(typeof(h.sch_g_attached_ind))'');
    populated_filing_status_cnt := COUNT(GROUP,h.filing_status <> (TYPEOF(h.filing_status))'');
    populated_filing_status_pcnt := AVE(GROUP,IF(h.filing_status = (TYPEOF(h.filing_status))'',0,100));
    maxlength_filing_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_status)));
    avelength_filing_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_status)),h.filing_status<>(typeof(h.filing_status))'');
    populated_date_received_cnt := COUNT(GROUP,h.date_received <> (TYPEOF(h.date_received))'');
    populated_date_received_pcnt := AVE(GROUP,IF(h.date_received = (TYPEOF(h.date_received))'',0,100));
    maxlength_date_received := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_received)));
    avelength_date_received := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_received)),h.date_received<>(typeof(h.date_received))'');
    populated_valid_admin_signature_cnt := COUNT(GROUP,h.valid_admin_signature <> (TYPEOF(h.valid_admin_signature))'');
    populated_valid_admin_signature_pcnt := AVE(GROUP,IF(h.valid_admin_signature = (TYPEOF(h.valid_admin_signature))'',0,100));
    maxlength_valid_admin_signature := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.valid_admin_signature)));
    avelength_valid_admin_signature := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.valid_admin_signature)),h.valid_admin_signature<>(typeof(h.valid_admin_signature))'');
    populated_valid_dfe_signature_cnt := COUNT(GROUP,h.valid_dfe_signature <> (TYPEOF(h.valid_dfe_signature))'');
    populated_valid_dfe_signature_pcnt := AVE(GROUP,IF(h.valid_dfe_signature = (TYPEOF(h.valid_dfe_signature))'',0,100));
    maxlength_valid_dfe_signature := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.valid_dfe_signature)));
    avelength_valid_dfe_signature := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.valid_dfe_signature)),h.valid_dfe_signature<>(typeof(h.valid_dfe_signature))'');
    populated_valid_sponsor_signature_cnt := COUNT(GROUP,h.valid_sponsor_signature <> (TYPEOF(h.valid_sponsor_signature))'');
    populated_valid_sponsor_signature_pcnt := AVE(GROUP,IF(h.valid_sponsor_signature = (TYPEOF(h.valid_sponsor_signature))'',0,100));
    maxlength_valid_sponsor_signature := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.valid_sponsor_signature)));
    avelength_valid_sponsor_signature := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.valid_sponsor_signature)),h.valid_sponsor_signature<>(typeof(h.valid_sponsor_signature))'');
    populated_admin_phone_num_foreign_cnt := COUNT(GROUP,h.admin_phone_num_foreign <> (TYPEOF(h.admin_phone_num_foreign))'');
    populated_admin_phone_num_foreign_pcnt := AVE(GROUP,IF(h.admin_phone_num_foreign = (TYPEOF(h.admin_phone_num_foreign))'',0,100));
    maxlength_admin_phone_num_foreign := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_phone_num_foreign)));
    avelength_admin_phone_num_foreign := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_phone_num_foreign)),h.admin_phone_num_foreign<>(typeof(h.admin_phone_num_foreign))'');
    populated_spons_dfe_phone_num_foreign_cnt := COUNT(GROUP,h.spons_dfe_phone_num_foreign <> (TYPEOF(h.spons_dfe_phone_num_foreign))'');
    populated_spons_dfe_phone_num_foreign_pcnt := AVE(GROUP,IF(h.spons_dfe_phone_num_foreign = (TYPEOF(h.spons_dfe_phone_num_foreign))'',0,100));
    maxlength_spons_dfe_phone_num_foreign := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_phone_num_foreign)));
    avelength_spons_dfe_phone_num_foreign := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spons_dfe_phone_num_foreign)),h.spons_dfe_phone_num_foreign<>(typeof(h.spons_dfe_phone_num_foreign))'');
    populated_admin_name_same_spon_ind_cnt := COUNT(GROUP,h.admin_name_same_spon_ind <> (TYPEOF(h.admin_name_same_spon_ind))'');
    populated_admin_name_same_spon_ind_pcnt := AVE(GROUP,IF(h.admin_name_same_spon_ind = (TYPEOF(h.admin_name_same_spon_ind))'',0,100));
    maxlength_admin_name_same_spon_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_name_same_spon_ind)));
    avelength_admin_name_same_spon_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_name_same_spon_ind)),h.admin_name_same_spon_ind<>(typeof(h.admin_name_same_spon_ind))'');
    populated_admin_address_same_spon_ind_cnt := COUNT(GROUP,h.admin_address_same_spon_ind <> (TYPEOF(h.admin_address_same_spon_ind))'');
    populated_admin_address_same_spon_ind_pcnt := AVE(GROUP,IF(h.admin_address_same_spon_ind = (TYPEOF(h.admin_address_same_spon_ind))'',0,100));
    maxlength_admin_address_same_spon_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_address_same_spon_ind)));
    avelength_admin_address_same_spon_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.admin_address_same_spon_ind)),h.admin_address_same_spon_ind<>(typeof(h.admin_address_same_spon_ind))'');
    populated_preparer_name_cnt := COUNT(GROUP,h.preparer_name <> (TYPEOF(h.preparer_name))'');
    populated_preparer_name_pcnt := AVE(GROUP,IF(h.preparer_name = (TYPEOF(h.preparer_name))'',0,100));
    maxlength_preparer_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_name)));
    avelength_preparer_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_name)),h.preparer_name<>(typeof(h.preparer_name))'');
    populated_preparer_firm_name_cnt := COUNT(GROUP,h.preparer_firm_name <> (TYPEOF(h.preparer_firm_name))'');
    populated_preparer_firm_name_pcnt := AVE(GROUP,IF(h.preparer_firm_name = (TYPEOF(h.preparer_firm_name))'',0,100));
    maxlength_preparer_firm_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_firm_name)));
    avelength_preparer_firm_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_firm_name)),h.preparer_firm_name<>(typeof(h.preparer_firm_name))'');
    populated_preparer_us_address1_cnt := COUNT(GROUP,h.preparer_us_address1 <> (TYPEOF(h.preparer_us_address1))'');
    populated_preparer_us_address1_pcnt := AVE(GROUP,IF(h.preparer_us_address1 = (TYPEOF(h.preparer_us_address1))'',0,100));
    maxlength_preparer_us_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_us_address1)));
    avelength_preparer_us_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_us_address1)),h.preparer_us_address1<>(typeof(h.preparer_us_address1))'');
    populated_preparer_us_address2_cnt := COUNT(GROUP,h.preparer_us_address2 <> (TYPEOF(h.preparer_us_address2))'');
    populated_preparer_us_address2_pcnt := AVE(GROUP,IF(h.preparer_us_address2 = (TYPEOF(h.preparer_us_address2))'',0,100));
    maxlength_preparer_us_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_us_address2)));
    avelength_preparer_us_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_us_address2)),h.preparer_us_address2<>(typeof(h.preparer_us_address2))'');
    populated_preparer_us_city_cnt := COUNT(GROUP,h.preparer_us_city <> (TYPEOF(h.preparer_us_city))'');
    populated_preparer_us_city_pcnt := AVE(GROUP,IF(h.preparer_us_city = (TYPEOF(h.preparer_us_city))'',0,100));
    maxlength_preparer_us_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_us_city)));
    avelength_preparer_us_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_us_city)),h.preparer_us_city<>(typeof(h.preparer_us_city))'');
    populated_preparer_us_state_cnt := COUNT(GROUP,h.preparer_us_state <> (TYPEOF(h.preparer_us_state))'');
    populated_preparer_us_state_pcnt := AVE(GROUP,IF(h.preparer_us_state = (TYPEOF(h.preparer_us_state))'',0,100));
    maxlength_preparer_us_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_us_state)));
    avelength_preparer_us_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_us_state)),h.preparer_us_state<>(typeof(h.preparer_us_state))'');
    populated_preparer_us_zip_cnt := COUNT(GROUP,h.preparer_us_zip <> (TYPEOF(h.preparer_us_zip))'');
    populated_preparer_us_zip_pcnt := AVE(GROUP,IF(h.preparer_us_zip = (TYPEOF(h.preparer_us_zip))'',0,100));
    maxlength_preparer_us_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_us_zip)));
    avelength_preparer_us_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_us_zip)),h.preparer_us_zip<>(typeof(h.preparer_us_zip))'');
    populated_preparer_foreign_address1_cnt := COUNT(GROUP,h.preparer_foreign_address1 <> (TYPEOF(h.preparer_foreign_address1))'');
    populated_preparer_foreign_address1_pcnt := AVE(GROUP,IF(h.preparer_foreign_address1 = (TYPEOF(h.preparer_foreign_address1))'',0,100));
    maxlength_preparer_foreign_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_address1)));
    avelength_preparer_foreign_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_address1)),h.preparer_foreign_address1<>(typeof(h.preparer_foreign_address1))'');
    populated_preparer_foreign_address2_cnt := COUNT(GROUP,h.preparer_foreign_address2 <> (TYPEOF(h.preparer_foreign_address2))'');
    populated_preparer_foreign_address2_pcnt := AVE(GROUP,IF(h.preparer_foreign_address2 = (TYPEOF(h.preparer_foreign_address2))'',0,100));
    maxlength_preparer_foreign_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_address2)));
    avelength_preparer_foreign_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_address2)),h.preparer_foreign_address2<>(typeof(h.preparer_foreign_address2))'');
    populated_preparer_foreign_city_cnt := COUNT(GROUP,h.preparer_foreign_city <> (TYPEOF(h.preparer_foreign_city))'');
    populated_preparer_foreign_city_pcnt := AVE(GROUP,IF(h.preparer_foreign_city = (TYPEOF(h.preparer_foreign_city))'',0,100));
    maxlength_preparer_foreign_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_city)));
    avelength_preparer_foreign_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_city)),h.preparer_foreign_city<>(typeof(h.preparer_foreign_city))'');
    populated_preparer_foreign_prov_state_cnt := COUNT(GROUP,h.preparer_foreign_prov_state <> (TYPEOF(h.preparer_foreign_prov_state))'');
    populated_preparer_foreign_prov_state_pcnt := AVE(GROUP,IF(h.preparer_foreign_prov_state = (TYPEOF(h.preparer_foreign_prov_state))'',0,100));
    maxlength_preparer_foreign_prov_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_prov_state)));
    avelength_preparer_foreign_prov_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_prov_state)),h.preparer_foreign_prov_state<>(typeof(h.preparer_foreign_prov_state))'');
    populated_preparer_foreign_cntry_cnt := COUNT(GROUP,h.preparer_foreign_cntry <> (TYPEOF(h.preparer_foreign_cntry))'');
    populated_preparer_foreign_cntry_pcnt := AVE(GROUP,IF(h.preparer_foreign_cntry = (TYPEOF(h.preparer_foreign_cntry))'',0,100));
    maxlength_preparer_foreign_cntry := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_cntry)));
    avelength_preparer_foreign_cntry := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_cntry)),h.preparer_foreign_cntry<>(typeof(h.preparer_foreign_cntry))'');
    populated_preparer_foreign_postal_cd_cnt := COUNT(GROUP,h.preparer_foreign_postal_cd <> (TYPEOF(h.preparer_foreign_postal_cd))'');
    populated_preparer_foreign_postal_cd_pcnt := AVE(GROUP,IF(h.preparer_foreign_postal_cd = (TYPEOF(h.preparer_foreign_postal_cd))'',0,100));
    maxlength_preparer_foreign_postal_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_postal_cd)));
    avelength_preparer_foreign_postal_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_foreign_postal_cd)),h.preparer_foreign_postal_cd<>(typeof(h.preparer_foreign_postal_cd))'');
    populated_preparer_phone_num_cnt := COUNT(GROUP,h.preparer_phone_num <> (TYPEOF(h.preparer_phone_num))'');
    populated_preparer_phone_num_pcnt := AVE(GROUP,IF(h.preparer_phone_num = (TYPEOF(h.preparer_phone_num))'',0,100));
    maxlength_preparer_phone_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_phone_num)));
    avelength_preparer_phone_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_phone_num)),h.preparer_phone_num<>(typeof(h.preparer_phone_num))'');
    populated_preparer_phone_num_foreign_cnt := COUNT(GROUP,h.preparer_phone_num_foreign <> (TYPEOF(h.preparer_phone_num_foreign))'');
    populated_preparer_phone_num_foreign_pcnt := AVE(GROUP,IF(h.preparer_phone_num_foreign = (TYPEOF(h.preparer_phone_num_foreign))'',0,100));
    maxlength_preparer_phone_num_foreign := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_phone_num_foreign)));
    avelength_preparer_phone_num_foreign := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.preparer_phone_num_foreign)),h.preparer_phone_num_foreign<>(typeof(h.preparer_phone_num_foreign))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ack_id_pcnt *   0.00 / 100 + T.Populated_form_plan_year_begin_date_pcnt *   0.00 / 100 + T.Populated_form_tax_prd_pcnt *   0.00 / 100 + T.Populated_type_plan_entity_cd_pcnt *   0.00 / 100 + T.Populated_type_dfe_plan_entity_cd_pcnt *   0.00 / 100 + T.Populated_initial_filing_ind_pcnt *   0.00 / 100 + T.Populated_amended_ind_pcnt *   0.00 / 100 + T.Populated_final_filing_ind_pcnt *   0.00 / 100 + T.Populated_short_plan_yr_ind_pcnt *   0.00 / 100 + T.Populated_collective_bargain_ind_pcnt *   0.00 / 100 + T.Populated_f5558_application_filed_ind_pcnt *   0.00 / 100 + T.Populated_ext_automatic_ind_pcnt *   0.00 / 100 + T.Populated_dfvc_program_ind_pcnt *   0.00 / 100 + T.Populated_ext_special_ind_pcnt *   0.00 / 100 + T.Populated_ext_special_text_pcnt *   0.00 / 100 + T.Populated_plan_name_pcnt *   0.00 / 100 + T.Populated_spons_dfe_pn_pcnt *   0.00 / 100 + T.Populated_plan_eff_date_pcnt *   0.00 / 100 + T.Populated_sponsor_dfe_name_pcnt *   0.00 / 100 + T.Populated_spons_dfe_dba_name_pcnt *   0.00 / 100 + T.Populated_spons_dfe_care_of_name_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_us_address1_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_us_address2_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_us_city_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_us_state_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_us_zip_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_foreign_addr1_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_foreign_addr2_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_foreign_city_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_forgn_prov_st_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_foreign_cntry_pcnt *   0.00 / 100 + T.Populated_spons_dfe_mail_forgn_postal_cd_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_us_address1_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_us_address2_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_us_city_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_us_state_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_us_zip_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_foreign_address1_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_foreign_address2_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_foreign_city_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_forgn_prov_st_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_foreign_cntry_pcnt *   0.00 / 100 + T.Populated_spons_dfe_loc_forgn_postal_cd_pcnt *   0.00 / 100 + T.Populated_spons_dfe_ein_pcnt *   0.00 / 100 + T.Populated_spons_dfe_phone_num_pcnt *   0.00 / 100 + T.Populated_business_code_pcnt *   0.00 / 100 + T.Populated_admin_name_pcnt *   0.00 / 100 + T.Populated_admin_care_of_name_pcnt *   0.00 / 100 + T.Populated_admin_us_address1_pcnt *   0.00 / 100 + T.Populated_admin_us_address2_pcnt *   0.00 / 100 + T.Populated_admin_us_city_pcnt *   0.00 / 100 + T.Populated_admin_us_state_pcnt *   0.00 / 100 + T.Populated_admin_us_zip_pcnt *   0.00 / 100 + T.Populated_admin_foreign_address1_pcnt *   0.00 / 100 + T.Populated_admin_foreign_address2_pcnt *   0.00 / 100 + T.Populated_admin_foreign_city_pcnt *   0.00 / 100 + T.Populated_admin_foreign_prov_state_pcnt *   0.00 / 100 + T.Populated_admin_foreign_cntry_pcnt *   0.00 / 100 + T.Populated_admin_foreign_postal_cd_pcnt *   0.00 / 100 + T.Populated_admin_ein_pcnt *   0.00 / 100 + T.Populated_admin_phone_num_pcnt *   0.00 / 100 + T.Populated_last_rpt_spons_name_pcnt *   0.00 / 100 + T.Populated_last_rpt_spons_ein_pcnt *   0.00 / 100 + T.Populated_last_rpt_plan_num_pcnt *   0.00 / 100 + T.Populated_admin_signed_date_pcnt *   0.00 / 100 + T.Populated_admin_signed_name_pcnt *   0.00 / 100 + T.Populated_spons_signed_date_pcnt *   0.00 / 100 + T.Populated_spons_signed_name_pcnt *   0.00 / 100 + T.Populated_dfe_signed_date_pcnt *   0.00 / 100 + T.Populated_dfe_signed_name_pcnt *   0.00 / 100 + T.Populated_tot_partcp_boy_cnt_pcnt *   0.00 / 100 + T.Populated_tot_active_partcp_cnt_pcnt *   0.00 / 100 + T.Populated_rtd_sep_partcp_rcvg_cnt_pcnt *   0.00 / 100 + T.Populated_rtd_sep_partcp_fut_cnt_pcnt *   0.00 / 100 + T.Populated_subtl_act_rtd_sep_cnt_pcnt *   0.00 / 100 + T.Populated_benef_rcvg_bnft_cnt_pcnt *   0.00 / 100 + T.Populated_tot_act_rtd_sep_benef_cnt_pcnt *   0.00 / 100 + T.Populated_partcp_account_bal_cnt_pcnt *   0.00 / 100 + T.Populated_sep_partcp_partl_vstd_cnt_pcnt *   0.00 / 100 + T.Populated_contrib_emplrs_cnt_pcnt *   0.00 / 100 + T.Populated_type_pension_bnft_code_pcnt *   0.00 / 100 + T.Populated_type_welfare_bnft_code_pcnt *   0.00 / 100 + T.Populated_funding_insurance_ind_pcnt *   0.00 / 100 + T.Populated_funding_sec412_ind_pcnt *   0.00 / 100 + T.Populated_funding_trust_ind_pcnt *   0.00 / 100 + T.Populated_funding_gen_asset_ind_pcnt *   0.00 / 100 + T.Populated_benefit_insurance_ind_pcnt *   0.00 / 100 + T.Populated_benefit_sec412_ind_pcnt *   0.00 / 100 + T.Populated_benefit_trust_ind_pcnt *   0.00 / 100 + T.Populated_benefit_gen_asset_ind_pcnt *   0.00 / 100 + T.Populated_sch_r_attached_ind_pcnt *   0.00 / 100 + T.Populated_sch_mb_attached_ind_pcnt *   0.00 / 100 + T.Populated_sch_sb_attached_ind_pcnt *   0.00 / 100 + T.Populated_sch_h_attached_ind_pcnt *   0.00 / 100 + T.Populated_sch_i_attached_ind_pcnt *   0.00 / 100 + T.Populated_sch_a_attached_ind_pcnt *   0.00 / 100 + T.Populated_num_sch_a_attached_cnt_pcnt *   0.00 / 100 + T.Populated_sch_c_attached_ind_pcnt *   0.00 / 100 + T.Populated_sch_d_attached_ind_pcnt *   0.00 / 100 + T.Populated_sch_g_attached_ind_pcnt *   0.00 / 100 + T.Populated_filing_status_pcnt *   0.00 / 100 + T.Populated_date_received_pcnt *   0.00 / 100 + T.Populated_valid_admin_signature_pcnt *   0.00 / 100 + T.Populated_valid_dfe_signature_pcnt *   0.00 / 100 + T.Populated_valid_sponsor_signature_pcnt *   0.00 / 100 + T.Populated_admin_phone_num_foreign_pcnt *   0.00 / 100 + T.Populated_spons_dfe_phone_num_foreign_pcnt *   0.00 / 100 + T.Populated_admin_name_same_spon_ind_pcnt *   0.00 / 100 + T.Populated_admin_address_same_spon_ind_pcnt *   0.00 / 100 + T.Populated_preparer_name_pcnt *   0.00 / 100 + T.Populated_preparer_firm_name_pcnt *   0.00 / 100 + T.Populated_preparer_us_address1_pcnt *   0.00 / 100 + T.Populated_preparer_us_address2_pcnt *   0.00 / 100 + T.Populated_preparer_us_city_pcnt *   0.00 / 100 + T.Populated_preparer_us_state_pcnt *   0.00 / 100 + T.Populated_preparer_us_zip_pcnt *   0.00 / 100 + T.Populated_preparer_foreign_address1_pcnt *   0.00 / 100 + T.Populated_preparer_foreign_address2_pcnt *   0.00 / 100 + T.Populated_preparer_foreign_city_pcnt *   0.00 / 100 + T.Populated_preparer_foreign_prov_state_pcnt *   0.00 / 100 + T.Populated_preparer_foreign_cntry_pcnt *   0.00 / 100 + T.Populated_preparer_foreign_postal_cd_pcnt *   0.00 / 100 + T.Populated_preparer_phone_num_pcnt *   0.00 / 100 + T.Populated_preparer_phone_num_foreign_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'ack_id','form_plan_year_begin_date','form_tax_prd','type_plan_entity_cd','type_dfe_plan_entity_cd','initial_filing_ind','amended_ind','final_filing_ind','short_plan_yr_ind','collective_bargain_ind','f5558_application_filed_ind','ext_automatic_ind','dfvc_program_ind','ext_special_ind','ext_special_text','plan_name','spons_dfe_pn','plan_eff_date','sponsor_dfe_name','spons_dfe_dba_name','spons_dfe_care_of_name','spons_dfe_mail_us_address1','spons_dfe_mail_us_address2','spons_dfe_mail_us_city','spons_dfe_mail_us_state','spons_dfe_mail_us_zip','spons_dfe_mail_foreign_addr1','spons_dfe_mail_foreign_addr2','spons_dfe_mail_foreign_city','spons_dfe_mail_forgn_prov_st','spons_dfe_mail_foreign_cntry','spons_dfe_mail_forgn_postal_cd','spons_dfe_loc_us_address1','spons_dfe_loc_us_address2','spons_dfe_loc_us_city','spons_dfe_loc_us_state','spons_dfe_loc_us_zip','spons_dfe_loc_foreign_address1','spons_dfe_loc_foreign_address2','spons_dfe_loc_foreign_city','spons_dfe_loc_forgn_prov_st','spons_dfe_loc_foreign_cntry','spons_dfe_loc_forgn_postal_cd','spons_dfe_ein','spons_dfe_phone_num','business_code','admin_name','admin_care_of_name','admin_us_address1','admin_us_address2','admin_us_city','admin_us_state','admin_us_zip','admin_foreign_address1','admin_foreign_address2','admin_foreign_city','admin_foreign_prov_state','admin_foreign_cntry','admin_foreign_postal_cd','admin_ein','admin_phone_num','last_rpt_spons_name','last_rpt_spons_ein','last_rpt_plan_num','admin_signed_date','admin_signed_name','spons_signed_date','spons_signed_name','dfe_signed_date','dfe_signed_name','tot_partcp_boy_cnt','tot_active_partcp_cnt','rtd_sep_partcp_rcvg_cnt','rtd_sep_partcp_fut_cnt','subtl_act_rtd_sep_cnt','benef_rcvg_bnft_cnt','tot_act_rtd_sep_benef_cnt','partcp_account_bal_cnt','sep_partcp_partl_vstd_cnt','contrib_emplrs_cnt','type_pension_bnft_code','type_welfare_bnft_code','funding_insurance_ind','funding_sec412_ind','funding_trust_ind','funding_gen_asset_ind','benefit_insurance_ind','benefit_sec412_ind','benefit_trust_ind','benefit_gen_asset_ind','sch_r_attached_ind','sch_mb_attached_ind','sch_sb_attached_ind','sch_h_attached_ind','sch_i_attached_ind','sch_a_attached_ind','num_sch_a_attached_cnt','sch_c_attached_ind','sch_d_attached_ind','sch_g_attached_ind','filing_status','date_received','valid_admin_signature','valid_dfe_signature','valid_sponsor_signature','admin_phone_num_foreign','spons_dfe_phone_num_foreign','admin_name_same_spon_ind','admin_address_same_spon_ind','preparer_name','preparer_firm_name','preparer_us_address1','preparer_us_address2','preparer_us_city','preparer_us_state','preparer_us_zip','preparer_foreign_address1','preparer_foreign_address2','preparer_foreign_city','preparer_foreign_prov_state','preparer_foreign_cntry','preparer_foreign_postal_cd','preparer_phone_num','preparer_phone_num_foreign');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ack_id_pcnt,le.populated_form_plan_year_begin_date_pcnt,le.populated_form_tax_prd_pcnt,le.populated_type_plan_entity_cd_pcnt,le.populated_type_dfe_plan_entity_cd_pcnt,le.populated_initial_filing_ind_pcnt,le.populated_amended_ind_pcnt,le.populated_final_filing_ind_pcnt,le.populated_short_plan_yr_ind_pcnt,le.populated_collective_bargain_ind_pcnt,le.populated_f5558_application_filed_ind_pcnt,le.populated_ext_automatic_ind_pcnt,le.populated_dfvc_program_ind_pcnt,le.populated_ext_special_ind_pcnt,le.populated_ext_special_text_pcnt,le.populated_plan_name_pcnt,le.populated_spons_dfe_pn_pcnt,le.populated_plan_eff_date_pcnt,le.populated_sponsor_dfe_name_pcnt,le.populated_spons_dfe_dba_name_pcnt,le.populated_spons_dfe_care_of_name_pcnt,le.populated_spons_dfe_mail_us_address1_pcnt,le.populated_spons_dfe_mail_us_address2_pcnt,le.populated_spons_dfe_mail_us_city_pcnt,le.populated_spons_dfe_mail_us_state_pcnt,le.populated_spons_dfe_mail_us_zip_pcnt,le.populated_spons_dfe_mail_foreign_addr1_pcnt,le.populated_spons_dfe_mail_foreign_addr2_pcnt,le.populated_spons_dfe_mail_foreign_city_pcnt,le.populated_spons_dfe_mail_forgn_prov_st_pcnt,le.populated_spons_dfe_mail_foreign_cntry_pcnt,le.populated_spons_dfe_mail_forgn_postal_cd_pcnt,le.populated_spons_dfe_loc_us_address1_pcnt,le.populated_spons_dfe_loc_us_address2_pcnt,le.populated_spons_dfe_loc_us_city_pcnt,le.populated_spons_dfe_loc_us_state_pcnt,le.populated_spons_dfe_loc_us_zip_pcnt,le.populated_spons_dfe_loc_foreign_address1_pcnt,le.populated_spons_dfe_loc_foreign_address2_pcnt,le.populated_spons_dfe_loc_foreign_city_pcnt,le.populated_spons_dfe_loc_forgn_prov_st_pcnt,le.populated_spons_dfe_loc_foreign_cntry_pcnt,le.populated_spons_dfe_loc_forgn_postal_cd_pcnt,le.populated_spons_dfe_ein_pcnt,le.populated_spons_dfe_phone_num_pcnt,le.populated_business_code_pcnt,le.populated_admin_name_pcnt,le.populated_admin_care_of_name_pcnt,le.populated_admin_us_address1_pcnt,le.populated_admin_us_address2_pcnt,le.populated_admin_us_city_pcnt,le.populated_admin_us_state_pcnt,le.populated_admin_us_zip_pcnt,le.populated_admin_foreign_address1_pcnt,le.populated_admin_foreign_address2_pcnt,le.populated_admin_foreign_city_pcnt,le.populated_admin_foreign_prov_state_pcnt,le.populated_admin_foreign_cntry_pcnt,le.populated_admin_foreign_postal_cd_pcnt,le.populated_admin_ein_pcnt,le.populated_admin_phone_num_pcnt,le.populated_last_rpt_spons_name_pcnt,le.populated_last_rpt_spons_ein_pcnt,le.populated_last_rpt_plan_num_pcnt,le.populated_admin_signed_date_pcnt,le.populated_admin_signed_name_pcnt,le.populated_spons_signed_date_pcnt,le.populated_spons_signed_name_pcnt,le.populated_dfe_signed_date_pcnt,le.populated_dfe_signed_name_pcnt,le.populated_tot_partcp_boy_cnt_pcnt,le.populated_tot_active_partcp_cnt_pcnt,le.populated_rtd_sep_partcp_rcvg_cnt_pcnt,le.populated_rtd_sep_partcp_fut_cnt_pcnt,le.populated_subtl_act_rtd_sep_cnt_pcnt,le.populated_benef_rcvg_bnft_cnt_pcnt,le.populated_tot_act_rtd_sep_benef_cnt_pcnt,le.populated_partcp_account_bal_cnt_pcnt,le.populated_sep_partcp_partl_vstd_cnt_pcnt,le.populated_contrib_emplrs_cnt_pcnt,le.populated_type_pension_bnft_code_pcnt,le.populated_type_welfare_bnft_code_pcnt,le.populated_funding_insurance_ind_pcnt,le.populated_funding_sec412_ind_pcnt,le.populated_funding_trust_ind_pcnt,le.populated_funding_gen_asset_ind_pcnt,le.populated_benefit_insurance_ind_pcnt,le.populated_benefit_sec412_ind_pcnt,le.populated_benefit_trust_ind_pcnt,le.populated_benefit_gen_asset_ind_pcnt,le.populated_sch_r_attached_ind_pcnt,le.populated_sch_mb_attached_ind_pcnt,le.populated_sch_sb_attached_ind_pcnt,le.populated_sch_h_attached_ind_pcnt,le.populated_sch_i_attached_ind_pcnt,le.populated_sch_a_attached_ind_pcnt,le.populated_num_sch_a_attached_cnt_pcnt,le.populated_sch_c_attached_ind_pcnt,le.populated_sch_d_attached_ind_pcnt,le.populated_sch_g_attached_ind_pcnt,le.populated_filing_status_pcnt,le.populated_date_received_pcnt,le.populated_valid_admin_signature_pcnt,le.populated_valid_dfe_signature_pcnt,le.populated_valid_sponsor_signature_pcnt,le.populated_admin_phone_num_foreign_pcnt,le.populated_spons_dfe_phone_num_foreign_pcnt,le.populated_admin_name_same_spon_ind_pcnt,le.populated_admin_address_same_spon_ind_pcnt,le.populated_preparer_name_pcnt,le.populated_preparer_firm_name_pcnt,le.populated_preparer_us_address1_pcnt,le.populated_preparer_us_address2_pcnt,le.populated_preparer_us_city_pcnt,le.populated_preparer_us_state_pcnt,le.populated_preparer_us_zip_pcnt,le.populated_preparer_foreign_address1_pcnt,le.populated_preparer_foreign_address2_pcnt,le.populated_preparer_foreign_city_pcnt,le.populated_preparer_foreign_prov_state_pcnt,le.populated_preparer_foreign_cntry_pcnt,le.populated_preparer_foreign_postal_cd_pcnt,le.populated_preparer_phone_num_pcnt,le.populated_preparer_phone_num_foreign_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ack_id,le.maxlength_form_plan_year_begin_date,le.maxlength_form_tax_prd,le.maxlength_type_plan_entity_cd,le.maxlength_type_dfe_plan_entity_cd,le.maxlength_initial_filing_ind,le.maxlength_amended_ind,le.maxlength_final_filing_ind,le.maxlength_short_plan_yr_ind,le.maxlength_collective_bargain_ind,le.maxlength_f5558_application_filed_ind,le.maxlength_ext_automatic_ind,le.maxlength_dfvc_program_ind,le.maxlength_ext_special_ind,le.maxlength_ext_special_text,le.maxlength_plan_name,le.maxlength_spons_dfe_pn,le.maxlength_plan_eff_date,le.maxlength_sponsor_dfe_name,le.maxlength_spons_dfe_dba_name,le.maxlength_spons_dfe_care_of_name,le.maxlength_spons_dfe_mail_us_address1,le.maxlength_spons_dfe_mail_us_address2,le.maxlength_spons_dfe_mail_us_city,le.maxlength_spons_dfe_mail_us_state,le.maxlength_spons_dfe_mail_us_zip,le.maxlength_spons_dfe_mail_foreign_addr1,le.maxlength_spons_dfe_mail_foreign_addr2,le.maxlength_spons_dfe_mail_foreign_city,le.maxlength_spons_dfe_mail_forgn_prov_st,le.maxlength_spons_dfe_mail_foreign_cntry,le.maxlength_spons_dfe_mail_forgn_postal_cd,le.maxlength_spons_dfe_loc_us_address1,le.maxlength_spons_dfe_loc_us_address2,le.maxlength_spons_dfe_loc_us_city,le.maxlength_spons_dfe_loc_us_state,le.maxlength_spons_dfe_loc_us_zip,le.maxlength_spons_dfe_loc_foreign_address1,le.maxlength_spons_dfe_loc_foreign_address2,le.maxlength_spons_dfe_loc_foreign_city,le.maxlength_spons_dfe_loc_forgn_prov_st,le.maxlength_spons_dfe_loc_foreign_cntry,le.maxlength_spons_dfe_loc_forgn_postal_cd,le.maxlength_spons_dfe_ein,le.maxlength_spons_dfe_phone_num,le.maxlength_business_code,le.maxlength_admin_name,le.maxlength_admin_care_of_name,le.maxlength_admin_us_address1,le.maxlength_admin_us_address2,le.maxlength_admin_us_city,le.maxlength_admin_us_state,le.maxlength_admin_us_zip,le.maxlength_admin_foreign_address1,le.maxlength_admin_foreign_address2,le.maxlength_admin_foreign_city,le.maxlength_admin_foreign_prov_state,le.maxlength_admin_foreign_cntry,le.maxlength_admin_foreign_postal_cd,le.maxlength_admin_ein,le.maxlength_admin_phone_num,le.maxlength_last_rpt_spons_name,le.maxlength_last_rpt_spons_ein,le.maxlength_last_rpt_plan_num,le.maxlength_admin_signed_date,le.maxlength_admin_signed_name,le.maxlength_spons_signed_date,le.maxlength_spons_signed_name,le.maxlength_dfe_signed_date,le.maxlength_dfe_signed_name,le.maxlength_tot_partcp_boy_cnt,le.maxlength_tot_active_partcp_cnt,le.maxlength_rtd_sep_partcp_rcvg_cnt,le.maxlength_rtd_sep_partcp_fut_cnt,le.maxlength_subtl_act_rtd_sep_cnt,le.maxlength_benef_rcvg_bnft_cnt,le.maxlength_tot_act_rtd_sep_benef_cnt,le.maxlength_partcp_account_bal_cnt,le.maxlength_sep_partcp_partl_vstd_cnt,le.maxlength_contrib_emplrs_cnt,le.maxlength_type_pension_bnft_code,le.maxlength_type_welfare_bnft_code,le.maxlength_funding_insurance_ind,le.maxlength_funding_sec412_ind,le.maxlength_funding_trust_ind,le.maxlength_funding_gen_asset_ind,le.maxlength_benefit_insurance_ind,le.maxlength_benefit_sec412_ind,le.maxlength_benefit_trust_ind,le.maxlength_benefit_gen_asset_ind,le.maxlength_sch_r_attached_ind,le.maxlength_sch_mb_attached_ind,le.maxlength_sch_sb_attached_ind,le.maxlength_sch_h_attached_ind,le.maxlength_sch_i_attached_ind,le.maxlength_sch_a_attached_ind,le.maxlength_num_sch_a_attached_cnt,le.maxlength_sch_c_attached_ind,le.maxlength_sch_d_attached_ind,le.maxlength_sch_g_attached_ind,le.maxlength_filing_status,le.maxlength_date_received,le.maxlength_valid_admin_signature,le.maxlength_valid_dfe_signature,le.maxlength_valid_sponsor_signature,le.maxlength_admin_phone_num_foreign,le.maxlength_spons_dfe_phone_num_foreign,le.maxlength_admin_name_same_spon_ind,le.maxlength_admin_address_same_spon_ind,le.maxlength_preparer_name,le.maxlength_preparer_firm_name,le.maxlength_preparer_us_address1,le.maxlength_preparer_us_address2,le.maxlength_preparer_us_city,le.maxlength_preparer_us_state,le.maxlength_preparer_us_zip,le.maxlength_preparer_foreign_address1,le.maxlength_preparer_foreign_address2,le.maxlength_preparer_foreign_city,le.maxlength_preparer_foreign_prov_state,le.maxlength_preparer_foreign_cntry,le.maxlength_preparer_foreign_postal_cd,le.maxlength_preparer_phone_num,le.maxlength_preparer_phone_num_foreign);
  SELF.avelength := CHOOSE(C,le.avelength_ack_id,le.avelength_form_plan_year_begin_date,le.avelength_form_tax_prd,le.avelength_type_plan_entity_cd,le.avelength_type_dfe_plan_entity_cd,le.avelength_initial_filing_ind,le.avelength_amended_ind,le.avelength_final_filing_ind,le.avelength_short_plan_yr_ind,le.avelength_collective_bargain_ind,le.avelength_f5558_application_filed_ind,le.avelength_ext_automatic_ind,le.avelength_dfvc_program_ind,le.avelength_ext_special_ind,le.avelength_ext_special_text,le.avelength_plan_name,le.avelength_spons_dfe_pn,le.avelength_plan_eff_date,le.avelength_sponsor_dfe_name,le.avelength_spons_dfe_dba_name,le.avelength_spons_dfe_care_of_name,le.avelength_spons_dfe_mail_us_address1,le.avelength_spons_dfe_mail_us_address2,le.avelength_spons_dfe_mail_us_city,le.avelength_spons_dfe_mail_us_state,le.avelength_spons_dfe_mail_us_zip,le.avelength_spons_dfe_mail_foreign_addr1,le.avelength_spons_dfe_mail_foreign_addr2,le.avelength_spons_dfe_mail_foreign_city,le.avelength_spons_dfe_mail_forgn_prov_st,le.avelength_spons_dfe_mail_foreign_cntry,le.avelength_spons_dfe_mail_forgn_postal_cd,le.avelength_spons_dfe_loc_us_address1,le.avelength_spons_dfe_loc_us_address2,le.avelength_spons_dfe_loc_us_city,le.avelength_spons_dfe_loc_us_state,le.avelength_spons_dfe_loc_us_zip,le.avelength_spons_dfe_loc_foreign_address1,le.avelength_spons_dfe_loc_foreign_address2,le.avelength_spons_dfe_loc_foreign_city,le.avelength_spons_dfe_loc_forgn_prov_st,le.avelength_spons_dfe_loc_foreign_cntry,le.avelength_spons_dfe_loc_forgn_postal_cd,le.avelength_spons_dfe_ein,le.avelength_spons_dfe_phone_num,le.avelength_business_code,le.avelength_admin_name,le.avelength_admin_care_of_name,le.avelength_admin_us_address1,le.avelength_admin_us_address2,le.avelength_admin_us_city,le.avelength_admin_us_state,le.avelength_admin_us_zip,le.avelength_admin_foreign_address1,le.avelength_admin_foreign_address2,le.avelength_admin_foreign_city,le.avelength_admin_foreign_prov_state,le.avelength_admin_foreign_cntry,le.avelength_admin_foreign_postal_cd,le.avelength_admin_ein,le.avelength_admin_phone_num,le.avelength_last_rpt_spons_name,le.avelength_last_rpt_spons_ein,le.avelength_last_rpt_plan_num,le.avelength_admin_signed_date,le.avelength_admin_signed_name,le.avelength_spons_signed_date,le.avelength_spons_signed_name,le.avelength_dfe_signed_date,le.avelength_dfe_signed_name,le.avelength_tot_partcp_boy_cnt,le.avelength_tot_active_partcp_cnt,le.avelength_rtd_sep_partcp_rcvg_cnt,le.avelength_rtd_sep_partcp_fut_cnt,le.avelength_subtl_act_rtd_sep_cnt,le.avelength_benef_rcvg_bnft_cnt,le.avelength_tot_act_rtd_sep_benef_cnt,le.avelength_partcp_account_bal_cnt,le.avelength_sep_partcp_partl_vstd_cnt,le.avelength_contrib_emplrs_cnt,le.avelength_type_pension_bnft_code,le.avelength_type_welfare_bnft_code,le.avelength_funding_insurance_ind,le.avelength_funding_sec412_ind,le.avelength_funding_trust_ind,le.avelength_funding_gen_asset_ind,le.avelength_benefit_insurance_ind,le.avelength_benefit_sec412_ind,le.avelength_benefit_trust_ind,le.avelength_benefit_gen_asset_ind,le.avelength_sch_r_attached_ind,le.avelength_sch_mb_attached_ind,le.avelength_sch_sb_attached_ind,le.avelength_sch_h_attached_ind,le.avelength_sch_i_attached_ind,le.avelength_sch_a_attached_ind,le.avelength_num_sch_a_attached_cnt,le.avelength_sch_c_attached_ind,le.avelength_sch_d_attached_ind,le.avelength_sch_g_attached_ind,le.avelength_filing_status,le.avelength_date_received,le.avelength_valid_admin_signature,le.avelength_valid_dfe_signature,le.avelength_valid_sponsor_signature,le.avelength_admin_phone_num_foreign,le.avelength_spons_dfe_phone_num_foreign,le.avelength_admin_name_same_spon_ind,le.avelength_admin_address_same_spon_ind,le.avelength_preparer_name,le.avelength_preparer_firm_name,le.avelength_preparer_us_address1,le.avelength_preparer_us_address2,le.avelength_preparer_us_city,le.avelength_preparer_us_state,le.avelength_preparer_us_zip,le.avelength_preparer_foreign_address1,le.avelength_preparer_foreign_address2,le.avelength_preparer_foreign_city,le.avelength_preparer_foreign_prov_state,le.avelength_preparer_foreign_cntry,le.avelength_preparer_foreign_postal_cd,le.avelength_preparer_phone_num,le.avelength_preparer_phone_num_foreign);
END;
EXPORT invSummary := NORMALIZE(summary0, 124, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.ack_id),TRIM((SALT311.StrType)le.form_plan_year_begin_date),TRIM((SALT311.StrType)le.form_tax_prd),TRIM((SALT311.StrType)le.type_plan_entity_cd),TRIM((SALT311.StrType)le.type_dfe_plan_entity_cd),TRIM((SALT311.StrType)le.initial_filing_ind),TRIM((SALT311.StrType)le.amended_ind),TRIM((SALT311.StrType)le.final_filing_ind),TRIM((SALT311.StrType)le.short_plan_yr_ind),TRIM((SALT311.StrType)le.collective_bargain_ind),TRIM((SALT311.StrType)le.f5558_application_filed_ind),TRIM((SALT311.StrType)le.ext_automatic_ind),TRIM((SALT311.StrType)le.dfvc_program_ind),TRIM((SALT311.StrType)le.ext_special_ind),TRIM((SALT311.StrType)le.ext_special_text),TRIM((SALT311.StrType)le.plan_name),TRIM((SALT311.StrType)le.spons_dfe_pn),TRIM((SALT311.StrType)le.plan_eff_date),TRIM((SALT311.StrType)le.sponsor_dfe_name),TRIM((SALT311.StrType)le.spons_dfe_dba_name),TRIM((SALT311.StrType)le.spons_dfe_care_of_name),TRIM((SALT311.StrType)le.spons_dfe_mail_us_address1),TRIM((SALT311.StrType)le.spons_dfe_mail_us_address2),TRIM((SALT311.StrType)le.spons_dfe_mail_us_city),TRIM((SALT311.StrType)le.spons_dfe_mail_us_state),TRIM((SALT311.StrType)le.spons_dfe_mail_us_zip),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_addr1),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_addr2),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_city),TRIM((SALT311.StrType)le.spons_dfe_mail_forgn_prov_st),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_cntry),TRIM((SALT311.StrType)le.spons_dfe_mail_forgn_postal_cd),TRIM((SALT311.StrType)le.spons_dfe_loc_us_address1),TRIM((SALT311.StrType)le.spons_dfe_loc_us_address2),TRIM((SALT311.StrType)le.spons_dfe_loc_us_city),TRIM((SALT311.StrType)le.spons_dfe_loc_us_state),TRIM((SALT311.StrType)le.spons_dfe_loc_us_zip),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_address1),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_address2),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_city),TRIM((SALT311.StrType)le.spons_dfe_loc_forgn_prov_st),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_cntry),TRIM((SALT311.StrType)le.spons_dfe_loc_forgn_postal_cd),TRIM((SALT311.StrType)le.spons_dfe_ein),TRIM((SALT311.StrType)le.spons_dfe_phone_num),TRIM((SALT311.StrType)le.business_code),TRIM((SALT311.StrType)le.admin_name),TRIM((SALT311.StrType)le.admin_care_of_name),TRIM((SALT311.StrType)le.admin_us_address1),TRIM((SALT311.StrType)le.admin_us_address2),TRIM((SALT311.StrType)le.admin_us_city),TRIM((SALT311.StrType)le.admin_us_state),TRIM((SALT311.StrType)le.admin_us_zip),TRIM((SALT311.StrType)le.admin_foreign_address1),TRIM((SALT311.StrType)le.admin_foreign_address2),TRIM((SALT311.StrType)le.admin_foreign_city),TRIM((SALT311.StrType)le.admin_foreign_prov_state),TRIM((SALT311.StrType)le.admin_foreign_cntry),TRIM((SALT311.StrType)le.admin_foreign_postal_cd),TRIM((SALT311.StrType)le.admin_ein),TRIM((SALT311.StrType)le.admin_phone_num),TRIM((SALT311.StrType)le.last_rpt_spons_name),TRIM((SALT311.StrType)le.last_rpt_spons_ein),TRIM((SALT311.StrType)le.last_rpt_plan_num),TRIM((SALT311.StrType)le.admin_signed_date),TRIM((SALT311.StrType)le.admin_signed_name),TRIM((SALT311.StrType)le.spons_signed_date),TRIM((SALT311.StrType)le.spons_signed_name),TRIM((SALT311.StrType)le.dfe_signed_date),TRIM((SALT311.StrType)le.dfe_signed_name),TRIM((SALT311.StrType)le.tot_partcp_boy_cnt),TRIM((SALT311.StrType)le.tot_active_partcp_cnt),TRIM((SALT311.StrType)le.rtd_sep_partcp_rcvg_cnt),TRIM((SALT311.StrType)le.rtd_sep_partcp_fut_cnt),TRIM((SALT311.StrType)le.subtl_act_rtd_sep_cnt),TRIM((SALT311.StrType)le.benef_rcvg_bnft_cnt),TRIM((SALT311.StrType)le.tot_act_rtd_sep_benef_cnt),TRIM((SALT311.StrType)le.partcp_account_bal_cnt),TRIM((SALT311.StrType)le.sep_partcp_partl_vstd_cnt),TRIM((SALT311.StrType)le.contrib_emplrs_cnt),TRIM((SALT311.StrType)le.type_pension_bnft_code),TRIM((SALT311.StrType)le.type_welfare_bnft_code),TRIM((SALT311.StrType)le.funding_insurance_ind),TRIM((SALT311.StrType)le.funding_sec412_ind),TRIM((SALT311.StrType)le.funding_trust_ind),TRIM((SALT311.StrType)le.funding_gen_asset_ind),TRIM((SALT311.StrType)le.benefit_insurance_ind),TRIM((SALT311.StrType)le.benefit_sec412_ind),TRIM((SALT311.StrType)le.benefit_trust_ind),TRIM((SALT311.StrType)le.benefit_gen_asset_ind),TRIM((SALT311.StrType)le.sch_r_attached_ind),TRIM((SALT311.StrType)le.sch_mb_attached_ind),TRIM((SALT311.StrType)le.sch_sb_attached_ind),TRIM((SALT311.StrType)le.sch_h_attached_ind),TRIM((SALT311.StrType)le.sch_i_attached_ind),TRIM((SALT311.StrType)le.sch_a_attached_ind),TRIM((SALT311.StrType)le.num_sch_a_attached_cnt),TRIM((SALT311.StrType)le.sch_c_attached_ind),TRIM((SALT311.StrType)le.sch_d_attached_ind),TRIM((SALT311.StrType)le.sch_g_attached_ind),TRIM((SALT311.StrType)le.filing_status),TRIM((SALT311.StrType)le.date_received),TRIM((SALT311.StrType)le.valid_admin_signature),TRIM((SALT311.StrType)le.valid_dfe_signature),TRIM((SALT311.StrType)le.valid_sponsor_signature),TRIM((SALT311.StrType)le.admin_phone_num_foreign),TRIM((SALT311.StrType)le.spons_dfe_phone_num_foreign),TRIM((SALT311.StrType)le.admin_name_same_spon_ind),TRIM((SALT311.StrType)le.admin_address_same_spon_ind),TRIM((SALT311.StrType)le.preparer_name),TRIM((SALT311.StrType)le.preparer_firm_name),TRIM((SALT311.StrType)le.preparer_us_address1),TRIM((SALT311.StrType)le.preparer_us_address2),TRIM((SALT311.StrType)le.preparer_us_city),TRIM((SALT311.StrType)le.preparer_us_state),TRIM((SALT311.StrType)le.preparer_us_zip),TRIM((SALT311.StrType)le.preparer_foreign_address1),TRIM((SALT311.StrType)le.preparer_foreign_address2),TRIM((SALT311.StrType)le.preparer_foreign_city),TRIM((SALT311.StrType)le.preparer_foreign_prov_state),TRIM((SALT311.StrType)le.preparer_foreign_cntry),TRIM((SALT311.StrType)le.preparer_foreign_postal_cd),TRIM((SALT311.StrType)le.preparer_phone_num),TRIM((SALT311.StrType)le.preparer_phone_num_foreign)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,124,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 124);
  SELF.FldNo2 := 1 + (C % 124);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.ack_id),TRIM((SALT311.StrType)le.form_plan_year_begin_date),TRIM((SALT311.StrType)le.form_tax_prd),TRIM((SALT311.StrType)le.type_plan_entity_cd),TRIM((SALT311.StrType)le.type_dfe_plan_entity_cd),TRIM((SALT311.StrType)le.initial_filing_ind),TRIM((SALT311.StrType)le.amended_ind),TRIM((SALT311.StrType)le.final_filing_ind),TRIM((SALT311.StrType)le.short_plan_yr_ind),TRIM((SALT311.StrType)le.collective_bargain_ind),TRIM((SALT311.StrType)le.f5558_application_filed_ind),TRIM((SALT311.StrType)le.ext_automatic_ind),TRIM((SALT311.StrType)le.dfvc_program_ind),TRIM((SALT311.StrType)le.ext_special_ind),TRIM((SALT311.StrType)le.ext_special_text),TRIM((SALT311.StrType)le.plan_name),TRIM((SALT311.StrType)le.spons_dfe_pn),TRIM((SALT311.StrType)le.plan_eff_date),TRIM((SALT311.StrType)le.sponsor_dfe_name),TRIM((SALT311.StrType)le.spons_dfe_dba_name),TRIM((SALT311.StrType)le.spons_dfe_care_of_name),TRIM((SALT311.StrType)le.spons_dfe_mail_us_address1),TRIM((SALT311.StrType)le.spons_dfe_mail_us_address2),TRIM((SALT311.StrType)le.spons_dfe_mail_us_city),TRIM((SALT311.StrType)le.spons_dfe_mail_us_state),TRIM((SALT311.StrType)le.spons_dfe_mail_us_zip),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_addr1),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_addr2),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_city),TRIM((SALT311.StrType)le.spons_dfe_mail_forgn_prov_st),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_cntry),TRIM((SALT311.StrType)le.spons_dfe_mail_forgn_postal_cd),TRIM((SALT311.StrType)le.spons_dfe_loc_us_address1),TRIM((SALT311.StrType)le.spons_dfe_loc_us_address2),TRIM((SALT311.StrType)le.spons_dfe_loc_us_city),TRIM((SALT311.StrType)le.spons_dfe_loc_us_state),TRIM((SALT311.StrType)le.spons_dfe_loc_us_zip),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_address1),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_address2),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_city),TRIM((SALT311.StrType)le.spons_dfe_loc_forgn_prov_st),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_cntry),TRIM((SALT311.StrType)le.spons_dfe_loc_forgn_postal_cd),TRIM((SALT311.StrType)le.spons_dfe_ein),TRIM((SALT311.StrType)le.spons_dfe_phone_num),TRIM((SALT311.StrType)le.business_code),TRIM((SALT311.StrType)le.admin_name),TRIM((SALT311.StrType)le.admin_care_of_name),TRIM((SALT311.StrType)le.admin_us_address1),TRIM((SALT311.StrType)le.admin_us_address2),TRIM((SALT311.StrType)le.admin_us_city),TRIM((SALT311.StrType)le.admin_us_state),TRIM((SALT311.StrType)le.admin_us_zip),TRIM((SALT311.StrType)le.admin_foreign_address1),TRIM((SALT311.StrType)le.admin_foreign_address2),TRIM((SALT311.StrType)le.admin_foreign_city),TRIM((SALT311.StrType)le.admin_foreign_prov_state),TRIM((SALT311.StrType)le.admin_foreign_cntry),TRIM((SALT311.StrType)le.admin_foreign_postal_cd),TRIM((SALT311.StrType)le.admin_ein),TRIM((SALT311.StrType)le.admin_phone_num),TRIM((SALT311.StrType)le.last_rpt_spons_name),TRIM((SALT311.StrType)le.last_rpt_spons_ein),TRIM((SALT311.StrType)le.last_rpt_plan_num),TRIM((SALT311.StrType)le.admin_signed_date),TRIM((SALT311.StrType)le.admin_signed_name),TRIM((SALT311.StrType)le.spons_signed_date),TRIM((SALT311.StrType)le.spons_signed_name),TRIM((SALT311.StrType)le.dfe_signed_date),TRIM((SALT311.StrType)le.dfe_signed_name),TRIM((SALT311.StrType)le.tot_partcp_boy_cnt),TRIM((SALT311.StrType)le.tot_active_partcp_cnt),TRIM((SALT311.StrType)le.rtd_sep_partcp_rcvg_cnt),TRIM((SALT311.StrType)le.rtd_sep_partcp_fut_cnt),TRIM((SALT311.StrType)le.subtl_act_rtd_sep_cnt),TRIM((SALT311.StrType)le.benef_rcvg_bnft_cnt),TRIM((SALT311.StrType)le.tot_act_rtd_sep_benef_cnt),TRIM((SALT311.StrType)le.partcp_account_bal_cnt),TRIM((SALT311.StrType)le.sep_partcp_partl_vstd_cnt),TRIM((SALT311.StrType)le.contrib_emplrs_cnt),TRIM((SALT311.StrType)le.type_pension_bnft_code),TRIM((SALT311.StrType)le.type_welfare_bnft_code),TRIM((SALT311.StrType)le.funding_insurance_ind),TRIM((SALT311.StrType)le.funding_sec412_ind),TRIM((SALT311.StrType)le.funding_trust_ind),TRIM((SALT311.StrType)le.funding_gen_asset_ind),TRIM((SALT311.StrType)le.benefit_insurance_ind),TRIM((SALT311.StrType)le.benefit_sec412_ind),TRIM((SALT311.StrType)le.benefit_trust_ind),TRIM((SALT311.StrType)le.benefit_gen_asset_ind),TRIM((SALT311.StrType)le.sch_r_attached_ind),TRIM((SALT311.StrType)le.sch_mb_attached_ind),TRIM((SALT311.StrType)le.sch_sb_attached_ind),TRIM((SALT311.StrType)le.sch_h_attached_ind),TRIM((SALT311.StrType)le.sch_i_attached_ind),TRIM((SALT311.StrType)le.sch_a_attached_ind),TRIM((SALT311.StrType)le.num_sch_a_attached_cnt),TRIM((SALT311.StrType)le.sch_c_attached_ind),TRIM((SALT311.StrType)le.sch_d_attached_ind),TRIM((SALT311.StrType)le.sch_g_attached_ind),TRIM((SALT311.StrType)le.filing_status),TRIM((SALT311.StrType)le.date_received),TRIM((SALT311.StrType)le.valid_admin_signature),TRIM((SALT311.StrType)le.valid_dfe_signature),TRIM((SALT311.StrType)le.valid_sponsor_signature),TRIM((SALT311.StrType)le.admin_phone_num_foreign),TRIM((SALT311.StrType)le.spons_dfe_phone_num_foreign),TRIM((SALT311.StrType)le.admin_name_same_spon_ind),TRIM((SALT311.StrType)le.admin_address_same_spon_ind),TRIM((SALT311.StrType)le.preparer_name),TRIM((SALT311.StrType)le.preparer_firm_name),TRIM((SALT311.StrType)le.preparer_us_address1),TRIM((SALT311.StrType)le.preparer_us_address2),TRIM((SALT311.StrType)le.preparer_us_city),TRIM((SALT311.StrType)le.preparer_us_state),TRIM((SALT311.StrType)le.preparer_us_zip),TRIM((SALT311.StrType)le.preparer_foreign_address1),TRIM((SALT311.StrType)le.preparer_foreign_address2),TRIM((SALT311.StrType)le.preparer_foreign_city),TRIM((SALT311.StrType)le.preparer_foreign_prov_state),TRIM((SALT311.StrType)le.preparer_foreign_cntry),TRIM((SALT311.StrType)le.preparer_foreign_postal_cd),TRIM((SALT311.StrType)le.preparer_phone_num),TRIM((SALT311.StrType)le.preparer_phone_num_foreign)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.ack_id),TRIM((SALT311.StrType)le.form_plan_year_begin_date),TRIM((SALT311.StrType)le.form_tax_prd),TRIM((SALT311.StrType)le.type_plan_entity_cd),TRIM((SALT311.StrType)le.type_dfe_plan_entity_cd),TRIM((SALT311.StrType)le.initial_filing_ind),TRIM((SALT311.StrType)le.amended_ind),TRIM((SALT311.StrType)le.final_filing_ind),TRIM((SALT311.StrType)le.short_plan_yr_ind),TRIM((SALT311.StrType)le.collective_bargain_ind),TRIM((SALT311.StrType)le.f5558_application_filed_ind),TRIM((SALT311.StrType)le.ext_automatic_ind),TRIM((SALT311.StrType)le.dfvc_program_ind),TRIM((SALT311.StrType)le.ext_special_ind),TRIM((SALT311.StrType)le.ext_special_text),TRIM((SALT311.StrType)le.plan_name),TRIM((SALT311.StrType)le.spons_dfe_pn),TRIM((SALT311.StrType)le.plan_eff_date),TRIM((SALT311.StrType)le.sponsor_dfe_name),TRIM((SALT311.StrType)le.spons_dfe_dba_name),TRIM((SALT311.StrType)le.spons_dfe_care_of_name),TRIM((SALT311.StrType)le.spons_dfe_mail_us_address1),TRIM((SALT311.StrType)le.spons_dfe_mail_us_address2),TRIM((SALT311.StrType)le.spons_dfe_mail_us_city),TRIM((SALT311.StrType)le.spons_dfe_mail_us_state),TRIM((SALT311.StrType)le.spons_dfe_mail_us_zip),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_addr1),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_addr2),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_city),TRIM((SALT311.StrType)le.spons_dfe_mail_forgn_prov_st),TRIM((SALT311.StrType)le.spons_dfe_mail_foreign_cntry),TRIM((SALT311.StrType)le.spons_dfe_mail_forgn_postal_cd),TRIM((SALT311.StrType)le.spons_dfe_loc_us_address1),TRIM((SALT311.StrType)le.spons_dfe_loc_us_address2),TRIM((SALT311.StrType)le.spons_dfe_loc_us_city),TRIM((SALT311.StrType)le.spons_dfe_loc_us_state),TRIM((SALT311.StrType)le.spons_dfe_loc_us_zip),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_address1),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_address2),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_city),TRIM((SALT311.StrType)le.spons_dfe_loc_forgn_prov_st),TRIM((SALT311.StrType)le.spons_dfe_loc_foreign_cntry),TRIM((SALT311.StrType)le.spons_dfe_loc_forgn_postal_cd),TRIM((SALT311.StrType)le.spons_dfe_ein),TRIM((SALT311.StrType)le.spons_dfe_phone_num),TRIM((SALT311.StrType)le.business_code),TRIM((SALT311.StrType)le.admin_name),TRIM((SALT311.StrType)le.admin_care_of_name),TRIM((SALT311.StrType)le.admin_us_address1),TRIM((SALT311.StrType)le.admin_us_address2),TRIM((SALT311.StrType)le.admin_us_city),TRIM((SALT311.StrType)le.admin_us_state),TRIM((SALT311.StrType)le.admin_us_zip),TRIM((SALT311.StrType)le.admin_foreign_address1),TRIM((SALT311.StrType)le.admin_foreign_address2),TRIM((SALT311.StrType)le.admin_foreign_city),TRIM((SALT311.StrType)le.admin_foreign_prov_state),TRIM((SALT311.StrType)le.admin_foreign_cntry),TRIM((SALT311.StrType)le.admin_foreign_postal_cd),TRIM((SALT311.StrType)le.admin_ein),TRIM((SALT311.StrType)le.admin_phone_num),TRIM((SALT311.StrType)le.last_rpt_spons_name),TRIM((SALT311.StrType)le.last_rpt_spons_ein),TRIM((SALT311.StrType)le.last_rpt_plan_num),TRIM((SALT311.StrType)le.admin_signed_date),TRIM((SALT311.StrType)le.admin_signed_name),TRIM((SALT311.StrType)le.spons_signed_date),TRIM((SALT311.StrType)le.spons_signed_name),TRIM((SALT311.StrType)le.dfe_signed_date),TRIM((SALT311.StrType)le.dfe_signed_name),TRIM((SALT311.StrType)le.tot_partcp_boy_cnt),TRIM((SALT311.StrType)le.tot_active_partcp_cnt),TRIM((SALT311.StrType)le.rtd_sep_partcp_rcvg_cnt),TRIM((SALT311.StrType)le.rtd_sep_partcp_fut_cnt),TRIM((SALT311.StrType)le.subtl_act_rtd_sep_cnt),TRIM((SALT311.StrType)le.benef_rcvg_bnft_cnt),TRIM((SALT311.StrType)le.tot_act_rtd_sep_benef_cnt),TRIM((SALT311.StrType)le.partcp_account_bal_cnt),TRIM((SALT311.StrType)le.sep_partcp_partl_vstd_cnt),TRIM((SALT311.StrType)le.contrib_emplrs_cnt),TRIM((SALT311.StrType)le.type_pension_bnft_code),TRIM((SALT311.StrType)le.type_welfare_bnft_code),TRIM((SALT311.StrType)le.funding_insurance_ind),TRIM((SALT311.StrType)le.funding_sec412_ind),TRIM((SALT311.StrType)le.funding_trust_ind),TRIM((SALT311.StrType)le.funding_gen_asset_ind),TRIM((SALT311.StrType)le.benefit_insurance_ind),TRIM((SALT311.StrType)le.benefit_sec412_ind),TRIM((SALT311.StrType)le.benefit_trust_ind),TRIM((SALT311.StrType)le.benefit_gen_asset_ind),TRIM((SALT311.StrType)le.sch_r_attached_ind),TRIM((SALT311.StrType)le.sch_mb_attached_ind),TRIM((SALT311.StrType)le.sch_sb_attached_ind),TRIM((SALT311.StrType)le.sch_h_attached_ind),TRIM((SALT311.StrType)le.sch_i_attached_ind),TRIM((SALT311.StrType)le.sch_a_attached_ind),TRIM((SALT311.StrType)le.num_sch_a_attached_cnt),TRIM((SALT311.StrType)le.sch_c_attached_ind),TRIM((SALT311.StrType)le.sch_d_attached_ind),TRIM((SALT311.StrType)le.sch_g_attached_ind),TRIM((SALT311.StrType)le.filing_status),TRIM((SALT311.StrType)le.date_received),TRIM((SALT311.StrType)le.valid_admin_signature),TRIM((SALT311.StrType)le.valid_dfe_signature),TRIM((SALT311.StrType)le.valid_sponsor_signature),TRIM((SALT311.StrType)le.admin_phone_num_foreign),TRIM((SALT311.StrType)le.spons_dfe_phone_num_foreign),TRIM((SALT311.StrType)le.admin_name_same_spon_ind),TRIM((SALT311.StrType)le.admin_address_same_spon_ind),TRIM((SALT311.StrType)le.preparer_name),TRIM((SALT311.StrType)le.preparer_firm_name),TRIM((SALT311.StrType)le.preparer_us_address1),TRIM((SALT311.StrType)le.preparer_us_address2),TRIM((SALT311.StrType)le.preparer_us_city),TRIM((SALT311.StrType)le.preparer_us_state),TRIM((SALT311.StrType)le.preparer_us_zip),TRIM((SALT311.StrType)le.preparer_foreign_address1),TRIM((SALT311.StrType)le.preparer_foreign_address2),TRIM((SALT311.StrType)le.preparer_foreign_city),TRIM((SALT311.StrType)le.preparer_foreign_prov_state),TRIM((SALT311.StrType)le.preparer_foreign_cntry),TRIM((SALT311.StrType)le.preparer_foreign_postal_cd),TRIM((SALT311.StrType)le.preparer_phone_num),TRIM((SALT311.StrType)le.preparer_phone_num_foreign)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),124*124,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ack_id'}
      ,{2,'form_plan_year_begin_date'}
      ,{3,'form_tax_prd'}
      ,{4,'type_plan_entity_cd'}
      ,{5,'type_dfe_plan_entity_cd'}
      ,{6,'initial_filing_ind'}
      ,{7,'amended_ind'}
      ,{8,'final_filing_ind'}
      ,{9,'short_plan_yr_ind'}
      ,{10,'collective_bargain_ind'}
      ,{11,'f5558_application_filed_ind'}
      ,{12,'ext_automatic_ind'}
      ,{13,'dfvc_program_ind'}
      ,{14,'ext_special_ind'}
      ,{15,'ext_special_text'}
      ,{16,'plan_name'}
      ,{17,'spons_dfe_pn'}
      ,{18,'plan_eff_date'}
      ,{19,'sponsor_dfe_name'}
      ,{20,'spons_dfe_dba_name'}
      ,{21,'spons_dfe_care_of_name'}
      ,{22,'spons_dfe_mail_us_address1'}
      ,{23,'spons_dfe_mail_us_address2'}
      ,{24,'spons_dfe_mail_us_city'}
      ,{25,'spons_dfe_mail_us_state'}
      ,{26,'spons_dfe_mail_us_zip'}
      ,{27,'spons_dfe_mail_foreign_addr1'}
      ,{28,'spons_dfe_mail_foreign_addr2'}
      ,{29,'spons_dfe_mail_foreign_city'}
      ,{30,'spons_dfe_mail_forgn_prov_st'}
      ,{31,'spons_dfe_mail_foreign_cntry'}
      ,{32,'spons_dfe_mail_forgn_postal_cd'}
      ,{33,'spons_dfe_loc_us_address1'}
      ,{34,'spons_dfe_loc_us_address2'}
      ,{35,'spons_dfe_loc_us_city'}
      ,{36,'spons_dfe_loc_us_state'}
      ,{37,'spons_dfe_loc_us_zip'}
      ,{38,'spons_dfe_loc_foreign_address1'}
      ,{39,'spons_dfe_loc_foreign_address2'}
      ,{40,'spons_dfe_loc_foreign_city'}
      ,{41,'spons_dfe_loc_forgn_prov_st'}
      ,{42,'spons_dfe_loc_foreign_cntry'}
      ,{43,'spons_dfe_loc_forgn_postal_cd'}
      ,{44,'spons_dfe_ein'}
      ,{45,'spons_dfe_phone_num'}
      ,{46,'business_code'}
      ,{47,'admin_name'}
      ,{48,'admin_care_of_name'}
      ,{49,'admin_us_address1'}
      ,{50,'admin_us_address2'}
      ,{51,'admin_us_city'}
      ,{52,'admin_us_state'}
      ,{53,'admin_us_zip'}
      ,{54,'admin_foreign_address1'}
      ,{55,'admin_foreign_address2'}
      ,{56,'admin_foreign_city'}
      ,{57,'admin_foreign_prov_state'}
      ,{58,'admin_foreign_cntry'}
      ,{59,'admin_foreign_postal_cd'}
      ,{60,'admin_ein'}
      ,{61,'admin_phone_num'}
      ,{62,'last_rpt_spons_name'}
      ,{63,'last_rpt_spons_ein'}
      ,{64,'last_rpt_plan_num'}
      ,{65,'admin_signed_date'}
      ,{66,'admin_signed_name'}
      ,{67,'spons_signed_date'}
      ,{68,'spons_signed_name'}
      ,{69,'dfe_signed_date'}
      ,{70,'dfe_signed_name'}
      ,{71,'tot_partcp_boy_cnt'}
      ,{72,'tot_active_partcp_cnt'}
      ,{73,'rtd_sep_partcp_rcvg_cnt'}
      ,{74,'rtd_sep_partcp_fut_cnt'}
      ,{75,'subtl_act_rtd_sep_cnt'}
      ,{76,'benef_rcvg_bnft_cnt'}
      ,{77,'tot_act_rtd_sep_benef_cnt'}
      ,{78,'partcp_account_bal_cnt'}
      ,{79,'sep_partcp_partl_vstd_cnt'}
      ,{80,'contrib_emplrs_cnt'}
      ,{81,'type_pension_bnft_code'}
      ,{82,'type_welfare_bnft_code'}
      ,{83,'funding_insurance_ind'}
      ,{84,'funding_sec412_ind'}
      ,{85,'funding_trust_ind'}
      ,{86,'funding_gen_asset_ind'}
      ,{87,'benefit_insurance_ind'}
      ,{88,'benefit_sec412_ind'}
      ,{89,'benefit_trust_ind'}
      ,{90,'benefit_gen_asset_ind'}
      ,{91,'sch_r_attached_ind'}
      ,{92,'sch_mb_attached_ind'}
      ,{93,'sch_sb_attached_ind'}
      ,{94,'sch_h_attached_ind'}
      ,{95,'sch_i_attached_ind'}
      ,{96,'sch_a_attached_ind'}
      ,{97,'num_sch_a_attached_cnt'}
      ,{98,'sch_c_attached_ind'}
      ,{99,'sch_d_attached_ind'}
      ,{100,'sch_g_attached_ind'}
      ,{101,'filing_status'}
      ,{102,'date_received'}
      ,{103,'valid_admin_signature'}
      ,{104,'valid_dfe_signature'}
      ,{105,'valid_sponsor_signature'}
      ,{106,'admin_phone_num_foreign'}
      ,{107,'spons_dfe_phone_num_foreign'}
      ,{108,'admin_name_same_spon_ind'}
      ,{109,'admin_address_same_spon_ind'}
      ,{110,'preparer_name'}
      ,{111,'preparer_firm_name'}
      ,{112,'preparer_us_address1'}
      ,{113,'preparer_us_address2'}
      ,{114,'preparer_us_city'}
      ,{115,'preparer_us_state'}
      ,{116,'preparer_us_zip'}
      ,{117,'preparer_foreign_address1'}
      ,{118,'preparer_foreign_address2'}
      ,{119,'preparer_foreign_city'}
      ,{120,'preparer_foreign_prov_state'}
      ,{121,'preparer_foreign_cntry'}
      ,{122,'preparer_foreign_postal_cd'}
      ,{123,'preparer_phone_num'}
      ,{124,'preparer_phone_num_foreign'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Raw_Fields.InValid_ack_id((SALT311.StrType)le.ack_id),
    Raw_Fields.InValid_form_plan_year_begin_date((SALT311.StrType)le.form_plan_year_begin_date),
    Raw_Fields.InValid_form_tax_prd((SALT311.StrType)le.form_tax_prd),
    Raw_Fields.InValid_type_plan_entity_cd((SALT311.StrType)le.type_plan_entity_cd),
    Raw_Fields.InValid_type_dfe_plan_entity_cd((SALT311.StrType)le.type_dfe_plan_entity_cd),
    Raw_Fields.InValid_initial_filing_ind((SALT311.StrType)le.initial_filing_ind),
    Raw_Fields.InValid_amended_ind((SALT311.StrType)le.amended_ind),
    Raw_Fields.InValid_final_filing_ind((SALT311.StrType)le.final_filing_ind),
    Raw_Fields.InValid_short_plan_yr_ind((SALT311.StrType)le.short_plan_yr_ind),
    Raw_Fields.InValid_collective_bargain_ind((SALT311.StrType)le.collective_bargain_ind),
    Raw_Fields.InValid_f5558_application_filed_ind((SALT311.StrType)le.f5558_application_filed_ind),
    Raw_Fields.InValid_ext_automatic_ind((SALT311.StrType)le.ext_automatic_ind),
    Raw_Fields.InValid_dfvc_program_ind((SALT311.StrType)le.dfvc_program_ind),
    Raw_Fields.InValid_ext_special_ind((SALT311.StrType)le.ext_special_ind),
    Raw_Fields.InValid_ext_special_text((SALT311.StrType)le.ext_special_text),
    Raw_Fields.InValid_plan_name((SALT311.StrType)le.plan_name),
    Raw_Fields.InValid_spons_dfe_pn((SALT311.StrType)le.spons_dfe_pn),
    Raw_Fields.InValid_plan_eff_date((SALT311.StrType)le.plan_eff_date),
    Raw_Fields.InValid_sponsor_dfe_name((SALT311.StrType)le.sponsor_dfe_name),
    Raw_Fields.InValid_spons_dfe_dba_name((SALT311.StrType)le.spons_dfe_dba_name),
    Raw_Fields.InValid_spons_dfe_care_of_name((SALT311.StrType)le.spons_dfe_care_of_name),
    Raw_Fields.InValid_spons_dfe_mail_us_address1((SALT311.StrType)le.spons_dfe_mail_us_address1,(SALT311.StrType)le.spons_dfe_mail_us_address2),
    Raw_Fields.InValid_spons_dfe_mail_us_address2((SALT311.StrType)le.spons_dfe_mail_us_address2),
    Raw_Fields.InValid_spons_dfe_mail_us_city((SALT311.StrType)le.spons_dfe_mail_us_city),
    Raw_Fields.InValid_spons_dfe_mail_us_state((SALT311.StrType)le.spons_dfe_mail_us_state),
    Raw_Fields.InValid_spons_dfe_mail_us_zip((SALT311.StrType)le.spons_dfe_mail_us_zip),
    Raw_Fields.InValid_spons_dfe_mail_foreign_addr1((SALT311.StrType)le.spons_dfe_mail_foreign_addr1,(SALT311.StrType)le.spons_dfe_mail_foreign_addr2),
    Raw_Fields.InValid_spons_dfe_mail_foreign_addr2((SALT311.StrType)le.spons_dfe_mail_foreign_addr2),
    Raw_Fields.InValid_spons_dfe_mail_foreign_city((SALT311.StrType)le.spons_dfe_mail_foreign_city),
    Raw_Fields.InValid_spons_dfe_mail_forgn_prov_st((SALT311.StrType)le.spons_dfe_mail_forgn_prov_st),
    Raw_Fields.InValid_spons_dfe_mail_foreign_cntry((SALT311.StrType)le.spons_dfe_mail_foreign_cntry),
    Raw_Fields.InValid_spons_dfe_mail_forgn_postal_cd((SALT311.StrType)le.spons_dfe_mail_forgn_postal_cd),
    Raw_Fields.InValid_spons_dfe_loc_us_address1((SALT311.StrType)le.spons_dfe_loc_us_address1,(SALT311.StrType)le.spons_dfe_loc_us_address2),
    Raw_Fields.InValid_spons_dfe_loc_us_address2((SALT311.StrType)le.spons_dfe_loc_us_address2),
    Raw_Fields.InValid_spons_dfe_loc_us_city((SALT311.StrType)le.spons_dfe_loc_us_city),
    Raw_Fields.InValid_spons_dfe_loc_us_state((SALT311.StrType)le.spons_dfe_loc_us_state),
    Raw_Fields.InValid_spons_dfe_loc_us_zip((SALT311.StrType)le.spons_dfe_loc_us_zip),
    Raw_Fields.InValid_spons_dfe_loc_foreign_address1((SALT311.StrType)le.spons_dfe_loc_foreign_address1,(SALT311.StrType)le.spons_dfe_loc_foreign_address2),
    Raw_Fields.InValid_spons_dfe_loc_foreign_address2((SALT311.StrType)le.spons_dfe_loc_foreign_address2),
    Raw_Fields.InValid_spons_dfe_loc_foreign_city((SALT311.StrType)le.spons_dfe_loc_foreign_city),
    Raw_Fields.InValid_spons_dfe_loc_forgn_prov_st((SALT311.StrType)le.spons_dfe_loc_forgn_prov_st),
    Raw_Fields.InValid_spons_dfe_loc_foreign_cntry((SALT311.StrType)le.spons_dfe_loc_foreign_cntry),
    Raw_Fields.InValid_spons_dfe_loc_forgn_postal_cd((SALT311.StrType)le.spons_dfe_loc_forgn_postal_cd),
    Raw_Fields.InValid_spons_dfe_ein((SALT311.StrType)le.spons_dfe_ein),
    Raw_Fields.InValid_spons_dfe_phone_num((SALT311.StrType)le.spons_dfe_phone_num),
    Raw_Fields.InValid_business_code((SALT311.StrType)le.business_code),
    Raw_Fields.InValid_admin_name((SALT311.StrType)le.admin_name),
    Raw_Fields.InValid_admin_care_of_name((SALT311.StrType)le.admin_care_of_name),
    Raw_Fields.InValid_admin_us_address1((SALT311.StrType)le.admin_us_address1,(SALT311.StrType)le.admin_us_address2),
    Raw_Fields.InValid_admin_us_address2((SALT311.StrType)le.admin_us_address2),
    Raw_Fields.InValid_admin_us_city((SALT311.StrType)le.admin_us_city),
    Raw_Fields.InValid_admin_us_state((SALT311.StrType)le.admin_us_state),
    Raw_Fields.InValid_admin_us_zip((SALT311.StrType)le.admin_us_zip),
    Raw_Fields.InValid_admin_foreign_address1((SALT311.StrType)le.admin_foreign_address1,(SALT311.StrType)le.admin_foreign_address2),
    Raw_Fields.InValid_admin_foreign_address2((SALT311.StrType)le.admin_foreign_address2),
    Raw_Fields.InValid_admin_foreign_city((SALT311.StrType)le.admin_foreign_city),
    Raw_Fields.InValid_admin_foreign_prov_state((SALT311.StrType)le.admin_foreign_prov_state),
    Raw_Fields.InValid_admin_foreign_cntry((SALT311.StrType)le.admin_foreign_cntry),
    Raw_Fields.InValid_admin_foreign_postal_cd((SALT311.StrType)le.admin_foreign_postal_cd),
    Raw_Fields.InValid_admin_ein((SALT311.StrType)le.admin_ein),
    Raw_Fields.InValid_admin_phone_num((SALT311.StrType)le.admin_phone_num),
    Raw_Fields.InValid_last_rpt_spons_name((SALT311.StrType)le.last_rpt_spons_name),
    Raw_Fields.InValid_last_rpt_spons_ein((SALT311.StrType)le.last_rpt_spons_ein),
    Raw_Fields.InValid_last_rpt_plan_num((SALT311.StrType)le.last_rpt_plan_num),
    Raw_Fields.InValid_admin_signed_date((SALT311.StrType)le.admin_signed_date),
    Raw_Fields.InValid_admin_signed_name((SALT311.StrType)le.admin_signed_name),
    Raw_Fields.InValid_spons_signed_date((SALT311.StrType)le.spons_signed_date),
    Raw_Fields.InValid_spons_signed_name((SALT311.StrType)le.spons_signed_name),
    Raw_Fields.InValid_dfe_signed_date((SALT311.StrType)le.dfe_signed_date),
    Raw_Fields.InValid_dfe_signed_name((SALT311.StrType)le.dfe_signed_name),
    Raw_Fields.InValid_tot_partcp_boy_cnt((SALT311.StrType)le.tot_partcp_boy_cnt),
    Raw_Fields.InValid_tot_active_partcp_cnt((SALT311.StrType)le.tot_active_partcp_cnt),
    Raw_Fields.InValid_rtd_sep_partcp_rcvg_cnt((SALT311.StrType)le.rtd_sep_partcp_rcvg_cnt),
    Raw_Fields.InValid_rtd_sep_partcp_fut_cnt((SALT311.StrType)le.rtd_sep_partcp_fut_cnt),
    Raw_Fields.InValid_subtl_act_rtd_sep_cnt((SALT311.StrType)le.subtl_act_rtd_sep_cnt),
    Raw_Fields.InValid_benef_rcvg_bnft_cnt((SALT311.StrType)le.benef_rcvg_bnft_cnt),
    Raw_Fields.InValid_tot_act_rtd_sep_benef_cnt((SALT311.StrType)le.tot_act_rtd_sep_benef_cnt),
    Raw_Fields.InValid_partcp_account_bal_cnt((SALT311.StrType)le.partcp_account_bal_cnt),
    Raw_Fields.InValid_sep_partcp_partl_vstd_cnt((SALT311.StrType)le.sep_partcp_partl_vstd_cnt),
    Raw_Fields.InValid_contrib_emplrs_cnt((SALT311.StrType)le.contrib_emplrs_cnt),
    Raw_Fields.InValid_type_pension_bnft_code((SALT311.StrType)le.type_pension_bnft_code),
    Raw_Fields.InValid_type_welfare_bnft_code((SALT311.StrType)le.type_welfare_bnft_code),
    Raw_Fields.InValid_funding_insurance_ind((SALT311.StrType)le.funding_insurance_ind),
    Raw_Fields.InValid_funding_sec412_ind((SALT311.StrType)le.funding_sec412_ind),
    Raw_Fields.InValid_funding_trust_ind((SALT311.StrType)le.funding_trust_ind),
    Raw_Fields.InValid_funding_gen_asset_ind((SALT311.StrType)le.funding_gen_asset_ind),
    Raw_Fields.InValid_benefit_insurance_ind((SALT311.StrType)le.benefit_insurance_ind),
    Raw_Fields.InValid_benefit_sec412_ind((SALT311.StrType)le.benefit_sec412_ind),
    Raw_Fields.InValid_benefit_trust_ind((SALT311.StrType)le.benefit_trust_ind),
    Raw_Fields.InValid_benefit_gen_asset_ind((SALT311.StrType)le.benefit_gen_asset_ind),
    Raw_Fields.InValid_sch_r_attached_ind((SALT311.StrType)le.sch_r_attached_ind),
    Raw_Fields.InValid_sch_mb_attached_ind((SALT311.StrType)le.sch_mb_attached_ind),
    Raw_Fields.InValid_sch_sb_attached_ind((SALT311.StrType)le.sch_sb_attached_ind),
    Raw_Fields.InValid_sch_h_attached_ind((SALT311.StrType)le.sch_h_attached_ind),
    Raw_Fields.InValid_sch_i_attached_ind((SALT311.StrType)le.sch_i_attached_ind),
    Raw_Fields.InValid_sch_a_attached_ind((SALT311.StrType)le.sch_a_attached_ind),
    Raw_Fields.InValid_num_sch_a_attached_cnt((SALT311.StrType)le.num_sch_a_attached_cnt),
    Raw_Fields.InValid_sch_c_attached_ind((SALT311.StrType)le.sch_c_attached_ind),
    Raw_Fields.InValid_sch_d_attached_ind((SALT311.StrType)le.sch_d_attached_ind),
    Raw_Fields.InValid_sch_g_attached_ind((SALT311.StrType)le.sch_g_attached_ind),
    Raw_Fields.InValid_filing_status((SALT311.StrType)le.filing_status),
    Raw_Fields.InValid_date_received((SALT311.StrType)le.date_received),
    Raw_Fields.InValid_valid_admin_signature((SALT311.StrType)le.valid_admin_signature),
    Raw_Fields.InValid_valid_dfe_signature((SALT311.StrType)le.valid_dfe_signature),
    Raw_Fields.InValid_valid_sponsor_signature((SALT311.StrType)le.valid_sponsor_signature),
    Raw_Fields.InValid_admin_phone_num_foreign((SALT311.StrType)le.admin_phone_num_foreign),
    Raw_Fields.InValid_spons_dfe_phone_num_foreign((SALT311.StrType)le.spons_dfe_phone_num_foreign),
    Raw_Fields.InValid_admin_name_same_spon_ind((SALT311.StrType)le.admin_name_same_spon_ind),
    Raw_Fields.InValid_admin_address_same_spon_ind((SALT311.StrType)le.admin_address_same_spon_ind),
    Raw_Fields.InValid_preparer_name((SALT311.StrType)le.preparer_name),
    Raw_Fields.InValid_preparer_firm_name((SALT311.StrType)le.preparer_firm_name),
    Raw_Fields.InValid_preparer_us_address1((SALT311.StrType)le.preparer_us_address1),
    Raw_Fields.InValid_preparer_us_address2((SALT311.StrType)le.preparer_us_address2),
    Raw_Fields.InValid_preparer_us_city((SALT311.StrType)le.preparer_us_city),
    Raw_Fields.InValid_preparer_us_state((SALT311.StrType)le.preparer_us_state),
    Raw_Fields.InValid_preparer_us_zip((SALT311.StrType)le.preparer_us_zip),
    Raw_Fields.InValid_preparer_foreign_address1((SALT311.StrType)le.preparer_foreign_address1),
    Raw_Fields.InValid_preparer_foreign_address2((SALT311.StrType)le.preparer_foreign_address2),
    Raw_Fields.InValid_preparer_foreign_city((SALT311.StrType)le.preparer_foreign_city),
    Raw_Fields.InValid_preparer_foreign_prov_state((SALT311.StrType)le.preparer_foreign_prov_state),
    Raw_Fields.InValid_preparer_foreign_cntry((SALT311.StrType)le.preparer_foreign_cntry),
    Raw_Fields.InValid_preparer_foreign_postal_cd((SALT311.StrType)le.preparer_foreign_postal_cd),
    Raw_Fields.InValid_preparer_phone_num((SALT311.StrType)le.preparer_phone_num),
    Raw_Fields.InValid_preparer_phone_num_foreign((SALT311.StrType)le.preparer_phone_num_foreign),
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
  FieldNme := Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_ack_id','invalid_pastdate','invalid_pastdate','invalid_type_plan_entity_cd','invalid_type_dfe_plan_entity_cd','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','Unknown','invalid_name','invalid_numeric','invalid_pastdate','invalid_name','invalid_name','invalid_name','invalid_dfe_mail_us_address','Unknown','invalid_alpha_sp','invalid_state','invalid_full_zip','invalid_dfe_mail_foreign_addr','Unknown','invalid_alphablank','invalid_alphablank','invalid_alphablank','invalid_alpha_numeric_blank','invalid_dfe_loc_us_address','Unknown','invalid_alpha_sp','invalid_state','invalid_full_zip','invalid_dfe_loc_foreign_address','Unknown','invalid_alphablank','invalid_alphablank','invalid_alphablank','invalid_alpha_numeric_blank','invalid_numeric','invalid_phone','invalid_numeric','invalid_name','invalid_name','invalid_admin_us_address','Unknown','invalid_alpha_sp','invalid_state','invalid_full_zip','invalid_admin_foreign_address','Unknown','invalid_alphablank','invalid_alphablank','invalid_alphablank','invalid_alpha_numeric_blank','invalid_numeric','invalid_phone','invalid_name','invalid_numeric','invalid_numeric','invalid_pastdate','invalid_name','invalid_pastdate','invalid_name','invalid_pastdate','invalid_name','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_type_pension_bnft_code','invalid_type_welfare_bnft_code','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_numeric','invalid_zero_1_bk','invalid_zero_1_bk','invalid_zero_1_bk','invalid_filing_status','invalid_generaldate','Unknown','Unknown','Unknown','invalid_phone','invalid_phone','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Raw_Fields.InValidMessage_ack_id(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_form_plan_year_begin_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_form_tax_prd(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_type_plan_entity_cd(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_type_dfe_plan_entity_cd(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_initial_filing_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_amended_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_final_filing_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_short_plan_yr_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_collective_bargain_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_f5558_application_filed_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_ext_automatic_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_dfvc_program_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_ext_special_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_ext_special_text(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_plan_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_pn(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_plan_eff_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sponsor_dfe_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_dba_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_care_of_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_us_address1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_us_address2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_us_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_us_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_us_zip(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_foreign_addr1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_foreign_addr2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_foreign_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_forgn_prov_st(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_foreign_cntry(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_mail_forgn_postal_cd(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_us_address1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_us_address2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_us_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_us_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_us_zip(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_foreign_address1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_foreign_address2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_foreign_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_forgn_prov_st(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_foreign_cntry(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_loc_forgn_postal_cd(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_ein(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_phone_num(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_business_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_care_of_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_us_address1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_us_address2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_us_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_us_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_us_zip(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_foreign_address1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_foreign_address2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_foreign_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_foreign_prov_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_foreign_cntry(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_foreign_postal_cd(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_ein(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_phone_num(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_last_rpt_spons_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_last_rpt_spons_ein(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_last_rpt_plan_num(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_signed_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_signed_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_signed_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_signed_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_dfe_signed_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_dfe_signed_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_tot_partcp_boy_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_tot_active_partcp_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_rtd_sep_partcp_rcvg_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_rtd_sep_partcp_fut_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_subtl_act_rtd_sep_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_benef_rcvg_bnft_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_tot_act_rtd_sep_benef_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_partcp_account_bal_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sep_partcp_partl_vstd_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_contrib_emplrs_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_type_pension_bnft_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_type_welfare_bnft_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_funding_insurance_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_funding_sec412_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_funding_trust_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_funding_gen_asset_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_benefit_insurance_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_benefit_sec412_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_benefit_trust_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_benefit_gen_asset_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sch_r_attached_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sch_mb_attached_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sch_sb_attached_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sch_h_attached_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sch_i_attached_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sch_a_attached_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_num_sch_a_attached_cnt(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sch_c_attached_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sch_d_attached_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sch_g_attached_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_filing_status(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_date_received(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_valid_admin_signature(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_valid_dfe_signature(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_valid_sponsor_signature(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_phone_num_foreign(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_spons_dfe_phone_num_foreign(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_name_same_spon_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_admin_address_same_spon_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_firm_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_us_address1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_us_address2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_us_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_us_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_us_zip(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_foreign_address1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_foreign_address2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_foreign_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_foreign_prov_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_foreign_cntry(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_foreign_postal_cd(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_phone_num(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_preparer_phone_num_foreign(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_IRS5500, Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
