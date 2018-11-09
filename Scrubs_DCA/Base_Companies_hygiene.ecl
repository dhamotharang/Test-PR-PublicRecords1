IMPORT ut,SALT34;
EXPORT Base_Companies_hygiene(dataset(Base_Companies_layout_DCA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_src_rid_pcnt := AVE(GROUP,IF(h.src_rid = (TYPEOF(h.src_rid))'',0,100));
    maxlength_src_rid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.src_rid)));
    avelength_src_rid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.src_rid)),h.src_rid<>(typeof(h.src_rid))'');
    populated_rid_pcnt := AVE(GROUP,IF(h.rid = (TYPEOF(h.rid))'',0,100));
    maxlength_rid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rid)));
    avelength_rid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rid)),h.rid<>(typeof(h.rid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_physical_rawaid_pcnt := AVE(GROUP,IF(h.physical_rawaid = (TYPEOF(h.physical_rawaid))'',0,100));
    maxlength_physical_rawaid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_rawaid)));
    avelength_physical_rawaid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_rawaid)),h.physical_rawaid<>(typeof(h.physical_rawaid))'');
    populated_physical_aceaid_pcnt := AVE(GROUP,IF(h.physical_aceaid = (TYPEOF(h.physical_aceaid))'',0,100));
    maxlength_physical_aceaid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_aceaid)));
    avelength_physical_aceaid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_aceaid)),h.physical_aceaid<>(typeof(h.physical_aceaid))'');
    populated_mailing_rawaid_pcnt := AVE(GROUP,IF(h.mailing_rawaid = (TYPEOF(h.mailing_rawaid))'',0,100));
    maxlength_mailing_rawaid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_rawaid)));
    avelength_mailing_rawaid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_rawaid)),h.mailing_rawaid<>(typeof(h.mailing_rawaid))'');
    populated_mailing_aceaid_pcnt := AVE(GROUP,IF(h.mailing_aceaid = (TYPEOF(h.mailing_aceaid))'',0,100));
    maxlength_mailing_aceaid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_aceaid)));
    avelength_mailing_aceaid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_aceaid)),h.mailing_aceaid<>(typeof(h.mailing_aceaid))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_file_type_pcnt := AVE(GROUP,IF(h.file_type = (TYPEOF(h.file_type))'',0,100));
    maxlength_file_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.file_type)));
    avelength_file_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.file_type)),h.file_type<>(typeof(h.file_type))'');
    populated_lncagid_pcnt := AVE(GROUP,IF(h.lncagid = (TYPEOF(h.lncagid))'',0,100));
    maxlength_lncagid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncagid)));
    avelength_lncagid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncagid)),h.lncagid<>(typeof(h.lncagid))'');
    populated_lncaghid_pcnt := AVE(GROUP,IF(h.lncaghid = (TYPEOF(h.lncaghid))'',0,100));
    maxlength_lncaghid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncaghid)));
    avelength_lncaghid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncaghid)),h.lncaghid<>(typeof(h.lncaghid))'');
    populated_lncaiid_pcnt := AVE(GROUP,IF(h.lncaiid = (TYPEOF(h.lncaiid))'',0,100));
    maxlength_lncaiid := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncaiid)));
    avelength_lncaiid := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lncaiid)),h.lncaiid<>(typeof(h.lncaiid))'');
    populated_rawfields_enterprise_num_pcnt := AVE(GROUP,IF(h.rawfields_enterprise_num = (TYPEOF(h.rawfields_enterprise_num))'',0,100));
    maxlength_rawfields_enterprise_num := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_enterprise_num)));
    avelength_rawfields_enterprise_num := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_enterprise_num)),h.rawfields_enterprise_num<>(typeof(h.rawfields_enterprise_num))'');
    populated_rawfields_parent_enterprise_number_pcnt := AVE(GROUP,IF(h.rawfields_parent_enterprise_number = (TYPEOF(h.rawfields_parent_enterprise_number))'',0,100));
    maxlength_rawfields_parent_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_parent_enterprise_number)));
    avelength_rawfields_parent_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_parent_enterprise_number)),h.rawfields_parent_enterprise_number<>(typeof(h.rawfields_parent_enterprise_number))'');
    populated_rawfields_ultimate_enterprise_number_pcnt := AVE(GROUP,IF(h.rawfields_ultimate_enterprise_number = (TYPEOF(h.rawfields_ultimate_enterprise_number))'',0,100));
    maxlength_rawfields_ultimate_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_ultimate_enterprise_number)));
    avelength_rawfields_ultimate_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_ultimate_enterprise_number)),h.rawfields_ultimate_enterprise_number<>(typeof(h.rawfields_ultimate_enterprise_number))'');
    populated_rawfields_company_type_pcnt := AVE(GROUP,IF(h.rawfields_company_type = (TYPEOF(h.rawfields_company_type))'',0,100));
    maxlength_rawfields_company_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_company_type)));
    avelength_rawfields_company_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_company_type)),h.rawfields_company_type<>(typeof(h.rawfields_company_type))'');
    populated_rawfields_name_pcnt := AVE(GROUP,IF(h.rawfields_name = (TYPEOF(h.rawfields_name))'',0,100));
    maxlength_rawfields_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_name)));
    avelength_rawfields_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_name)),h.rawfields_name<>(typeof(h.rawfields_name))'');
    populated_rawfields_e_mail_pcnt := AVE(GROUP,IF(h.rawfields_e_mail = (TYPEOF(h.rawfields_e_mail))'',0,100));
    maxlength_rawfields_e_mail := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_e_mail)));
    avelength_rawfields_e_mail := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_e_mail)),h.rawfields_e_mail<>(typeof(h.rawfields_e_mail))'');
    populated_rawfields_url_pcnt := AVE(GROUP,IF(h.rawfields_url = (TYPEOF(h.rawfields_url))'',0,100));
    maxlength_rawfields_url := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_url)));
    avelength_rawfields_url := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_url)),h.rawfields_url<>(typeof(h.rawfields_url))'');
    populated_rawfields_incorp_pcnt := AVE(GROUP,IF(h.rawfields_incorp = (TYPEOF(h.rawfields_incorp))'',0,100));
    maxlength_rawfields_incorp := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_incorp)));
    avelength_rawfields_incorp := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_incorp)),h.rawfields_incorp<>(typeof(h.rawfields_incorp))'');
    populated_rawfields_sic1_pcnt := AVE(GROUP,IF(h.rawfields_sic1 = (TYPEOF(h.rawfields_sic1))'',0,100));
    maxlength_rawfields_sic1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic1)));
    avelength_rawfields_sic1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic1)),h.rawfields_sic1<>(typeof(h.rawfields_sic1))'');
    populated_rawfields_sic2_pcnt := AVE(GROUP,IF(h.rawfields_sic2 = (TYPEOF(h.rawfields_sic2))'',0,100));
    maxlength_rawfields_sic2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic2)));
    avelength_rawfields_sic2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic2)),h.rawfields_sic2<>(typeof(h.rawfields_sic2))'');
    populated_rawfields_sic3_pcnt := AVE(GROUP,IF(h.rawfields_sic3 = (TYPEOF(h.rawfields_sic3))'',0,100));
    maxlength_rawfields_sic3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic3)));
    avelength_rawfields_sic3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic3)),h.rawfields_sic3<>(typeof(h.rawfields_sic3))'');
    populated_rawfields_sic4_pcnt := AVE(GROUP,IF(h.rawfields_sic4 = (TYPEOF(h.rawfields_sic4))'',0,100));
    maxlength_rawfields_sic4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic4)));
    avelength_rawfields_sic4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic4)),h.rawfields_sic4<>(typeof(h.rawfields_sic4))'');
    populated_rawfields_sic5_pcnt := AVE(GROUP,IF(h.rawfields_sic5 = (TYPEOF(h.rawfields_sic5))'',0,100));
    maxlength_rawfields_sic5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic5)));
    avelength_rawfields_sic5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic5)),h.rawfields_sic5<>(typeof(h.rawfields_sic5))'');
    populated_rawfields_sic6_pcnt := AVE(GROUP,IF(h.rawfields_sic6 = (TYPEOF(h.rawfields_sic6))'',0,100));
    maxlength_rawfields_sic6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic6)));
    avelength_rawfields_sic6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic6)),h.rawfields_sic6<>(typeof(h.rawfields_sic6))'');
    populated_rawfields_sic7_pcnt := AVE(GROUP,IF(h.rawfields_sic7 = (TYPEOF(h.rawfields_sic7))'',0,100));
    maxlength_rawfields_sic7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic7)));
    avelength_rawfields_sic7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic7)),h.rawfields_sic7<>(typeof(h.rawfields_sic7))'');
    populated_rawfields_sic8_pcnt := AVE(GROUP,IF(h.rawfields_sic8 = (TYPEOF(h.rawfields_sic8))'',0,100));
    maxlength_rawfields_sic8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic8)));
    avelength_rawfields_sic8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic8)),h.rawfields_sic8<>(typeof(h.rawfields_sic8))'');
    populated_rawfields_sic9_pcnt := AVE(GROUP,IF(h.rawfields_sic9 = (TYPEOF(h.rawfields_sic9))'',0,100));
    maxlength_rawfields_sic9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic9)));
    avelength_rawfields_sic9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic9)),h.rawfields_sic9<>(typeof(h.rawfields_sic9))'');
    populated_rawfields_sic10_pcnt := AVE(GROUP,IF(h.rawfields_sic10 = (TYPEOF(h.rawfields_sic10))'',0,100));
    maxlength_rawfields_sic10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic10)));
    avelength_rawfields_sic10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_sic10)),h.rawfields_sic10<>(typeof(h.rawfields_sic10))'');
    populated_rawfields_naics1_pcnt := AVE(GROUP,IF(h.rawfields_naics1 = (TYPEOF(h.rawfields_naics1))'',0,100));
    maxlength_rawfields_naics1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics1)));
    avelength_rawfields_naics1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics1)),h.rawfields_naics1<>(typeof(h.rawfields_naics1))'');
    populated_rawfields_naics2_pcnt := AVE(GROUP,IF(h.rawfields_naics2 = (TYPEOF(h.rawfields_naics2))'',0,100));
    maxlength_rawfields_naics2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics2)));
    avelength_rawfields_naics2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics2)),h.rawfields_naics2<>(typeof(h.rawfields_naics2))'');
    populated_rawfields_naics3_pcnt := AVE(GROUP,IF(h.rawfields_naics3 = (TYPEOF(h.rawfields_naics3))'',0,100));
    maxlength_rawfields_naics3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics3)));
    avelength_rawfields_naics3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics3)),h.rawfields_naics3<>(typeof(h.rawfields_naics3))'');
    populated_rawfields_naics4_pcnt := AVE(GROUP,IF(h.rawfields_naics4 = (TYPEOF(h.rawfields_naics4))'',0,100));
    maxlength_rawfields_naics4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics4)));
    avelength_rawfields_naics4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics4)),h.rawfields_naics4<>(typeof(h.rawfields_naics4))'');
    populated_rawfields_naics5_pcnt := AVE(GROUP,IF(h.rawfields_naics5 = (TYPEOF(h.rawfields_naics5))'',0,100));
    maxlength_rawfields_naics5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics5)));
    avelength_rawfields_naics5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics5)),h.rawfields_naics5<>(typeof(h.rawfields_naics5))'');
    populated_rawfields_naics6_pcnt := AVE(GROUP,IF(h.rawfields_naics6 = (TYPEOF(h.rawfields_naics6))'',0,100));
    maxlength_rawfields_naics6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics6)));
    avelength_rawfields_naics6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics6)),h.rawfields_naics6<>(typeof(h.rawfields_naics6))'');
    populated_rawfields_naics7_pcnt := AVE(GROUP,IF(h.rawfields_naics7 = (TYPEOF(h.rawfields_naics7))'',0,100));
    maxlength_rawfields_naics7 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics7)));
    avelength_rawfields_naics7 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics7)),h.rawfields_naics7<>(typeof(h.rawfields_naics7))'');
    populated_rawfields_naics8_pcnt := AVE(GROUP,IF(h.rawfields_naics8 = (TYPEOF(h.rawfields_naics8))'',0,100));
    maxlength_rawfields_naics8 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics8)));
    avelength_rawfields_naics8 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics8)),h.rawfields_naics8<>(typeof(h.rawfields_naics8))'');
    populated_rawfields_naics9_pcnt := AVE(GROUP,IF(h.rawfields_naics9 = (TYPEOF(h.rawfields_naics9))'',0,100));
    maxlength_rawfields_naics9 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics9)));
    avelength_rawfields_naics9 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics9)),h.rawfields_naics9<>(typeof(h.rawfields_naics9))'');
    populated_rawfields_naics10_pcnt := AVE(GROUP,IF(h.rawfields_naics10 = (TYPEOF(h.rawfields_naics10))'',0,100));
    maxlength_rawfields_naics10 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics10)));
    avelength_rawfields_naics10 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.rawfields_naics10)),h.rawfields_naics10<>(typeof(h.rawfields_naics10))'');
    populated_physical_address_prim_name_pcnt := AVE(GROUP,IF(h.physical_address_prim_name = (TYPEOF(h.physical_address_prim_name))'',0,100));
    maxlength_physical_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_prim_name)));
    avelength_physical_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_prim_name)),h.physical_address_prim_name<>(typeof(h.physical_address_prim_name))'');
    populated_physical_address_p_city_name_pcnt := AVE(GROUP,IF(h.physical_address_p_city_name = (TYPEOF(h.physical_address_p_city_name))'',0,100));
    maxlength_physical_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_p_city_name)));
    avelength_physical_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_p_city_name)),h.physical_address_p_city_name<>(typeof(h.physical_address_p_city_name))'');
    populated_physical_address_v_city_name_pcnt := AVE(GROUP,IF(h.physical_address_v_city_name = (TYPEOF(h.physical_address_v_city_name))'',0,100));
    maxlength_physical_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_v_city_name)));
    avelength_physical_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_v_city_name)),h.physical_address_v_city_name<>(typeof(h.physical_address_v_city_name))'');
    populated_physical_address_st_pcnt := AVE(GROUP,IF(h.physical_address_st = (TYPEOF(h.physical_address_st))'',0,100));
    maxlength_physical_address_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_st)));
    avelength_physical_address_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_st)),h.physical_address_st<>(typeof(h.physical_address_st))'');
    populated_physical_address_zip_pcnt := AVE(GROUP,IF(h.physical_address_zip = (TYPEOF(h.physical_address_zip))'',0,100));
    maxlength_physical_address_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_zip)));
    avelength_physical_address_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.physical_address_zip)),h.physical_address_zip<>(typeof(h.physical_address_zip))'');
    populated_mailing_address_prim_name_pcnt := AVE(GROUP,IF(h.mailing_address_prim_name = (TYPEOF(h.mailing_address_prim_name))'',0,100));
    maxlength_mailing_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_prim_name)));
    avelength_mailing_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_prim_name)),h.mailing_address_prim_name<>(typeof(h.mailing_address_prim_name))'');
    populated_mailing_address_p_city_name_pcnt := AVE(GROUP,IF(h.mailing_address_p_city_name = (TYPEOF(h.mailing_address_p_city_name))'',0,100));
    maxlength_mailing_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_p_city_name)));
    avelength_mailing_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_p_city_name)),h.mailing_address_p_city_name<>(typeof(h.mailing_address_p_city_name))'');
    populated_mailing_address_v_city_name_pcnt := AVE(GROUP,IF(h.mailing_address_v_city_name = (TYPEOF(h.mailing_address_v_city_name))'',0,100));
    maxlength_mailing_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_v_city_name)));
    avelength_mailing_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_v_city_name)),h.mailing_address_v_city_name<>(typeof(h.mailing_address_v_city_name))'');
    populated_mailing_address_st_pcnt := AVE(GROUP,IF(h.mailing_address_st = (TYPEOF(h.mailing_address_st))'',0,100));
    maxlength_mailing_address_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_st)));
    avelength_mailing_address_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_st)),h.mailing_address_st<>(typeof(h.mailing_address_st))'');
    populated_mailing_address_zip_pcnt := AVE(GROUP,IF(h.mailing_address_zip = (TYPEOF(h.mailing_address_zip))'',0,100));
    maxlength_mailing_address_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_zip)));
    avelength_mailing_address_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mailing_address_zip)),h.mailing_address_zip<>(typeof(h.mailing_address_zip))'');
    populated_clean_phones_phone_pcnt := AVE(GROUP,IF(h.clean_phones_phone = (TYPEOF(h.clean_phones_phone))'',0,100));
    maxlength_clean_phones_phone := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_phone)));
    avelength_clean_phones_phone := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_phone)),h.clean_phones_phone<>(typeof(h.clean_phones_phone))'');
    populated_clean_phones_fax_pcnt := AVE(GROUP,IF(h.clean_phones_fax = (TYPEOF(h.clean_phones_fax))'',0,100));
    maxlength_clean_phones_fax := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_fax)));
    avelength_clean_phones_fax := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_fax)),h.clean_phones_fax<>(typeof(h.clean_phones_fax))'');
    populated_clean_phones_telex_pcnt := AVE(GROUP,IF(h.clean_phones_telex = (TYPEOF(h.clean_phones_telex))'',0,100));
    maxlength_clean_phones_telex := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_telex)));
    avelength_clean_phones_telex := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_phones_telex)),h.clean_phones_telex<>(typeof(h.clean_phones_telex))'');
    populated_clean_dates_update_date_pcnt := AVE(GROUP,IF(h.clean_dates_update_date = (TYPEOF(h.clean_dates_update_date))'',0,100));
    maxlength_clean_dates_update_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_dates_update_date)));
    avelength_clean_dates_update_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_dates_update_date)),h.clean_dates_update_date<>(typeof(h.clean_dates_update_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_src_rid_pcnt *   0.00 / 100 + T.Populated_rid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_physical_rawaid_pcnt *   0.00 / 100 + T.Populated_physical_aceaid_pcnt *   0.00 / 100 + T.Populated_mailing_rawaid_pcnt *   0.00 / 100 + T.Populated_mailing_aceaid_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_file_type_pcnt *   0.00 / 100 + T.Populated_lncagid_pcnt *   0.00 / 100 + T.Populated_lncaghid_pcnt *   0.00 / 100 + T.Populated_lncaiid_pcnt *   0.00 / 100 + T.Populated_rawfields_enterprise_num_pcnt *   0.00 / 100 + T.Populated_rawfields_parent_enterprise_number_pcnt *   0.00 / 100 + T.Populated_rawfields_ultimate_enterprise_number_pcnt *   0.00 / 100 + T.Populated_rawfields_company_type_pcnt *   0.00 / 100 + T.Populated_rawfields_name_pcnt *   0.00 / 100 + T.Populated_rawfields_e_mail_pcnt *   0.00 / 100 + T.Populated_rawfields_url_pcnt *   0.00 / 100 + T.Populated_rawfields_incorp_pcnt *   0.00 / 100 + T.Populated_rawfields_sic1_pcnt *   0.00 / 100 + T.Populated_rawfields_sic2_pcnt *   0.00 / 100 + T.Populated_rawfields_sic3_pcnt *   0.00 / 100 + T.Populated_rawfields_sic4_pcnt *   0.00 / 100 + T.Populated_rawfields_sic5_pcnt *   0.00 / 100 + T.Populated_rawfields_sic6_pcnt *   0.00 / 100 + T.Populated_rawfields_sic7_pcnt *   0.00 / 100 + T.Populated_rawfields_sic8_pcnt *   0.00 / 100 + T.Populated_rawfields_sic9_pcnt *   0.00 / 100 + T.Populated_rawfields_sic10_pcnt *   0.00 / 100 + T.Populated_rawfields_naics1_pcnt *   0.00 / 100 + T.Populated_rawfields_naics2_pcnt *   0.00 / 100 + T.Populated_rawfields_naics3_pcnt *   0.00 / 100 + T.Populated_rawfields_naics4_pcnt *   0.00 / 100 + T.Populated_rawfields_naics5_pcnt *   0.00 / 100 + T.Populated_rawfields_naics6_pcnt *   0.00 / 100 + T.Populated_rawfields_naics7_pcnt *   0.00 / 100 + T.Populated_rawfields_naics8_pcnt *   0.00 / 100 + T.Populated_rawfields_naics9_pcnt *   0.00 / 100 + T.Populated_rawfields_naics10_pcnt *   0.00 / 100 + T.Populated_physical_address_prim_name_pcnt *   0.00 / 100 + T.Populated_physical_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_physical_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_physical_address_st_pcnt *   0.00 / 100 + T.Populated_physical_address_zip_pcnt *   0.00 / 100 + T.Populated_mailing_address_prim_name_pcnt *   0.00 / 100 + T.Populated_mailing_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_mailing_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_mailing_address_st_pcnt *   0.00 / 100 + T.Populated_mailing_address_zip_pcnt *   0.00 / 100 + T.Populated_clean_phones_phone_pcnt *   0.00 / 100 + T.Populated_clean_phones_fax_pcnt *   0.00 / 100 + T.Populated_clean_phones_telex_pcnt *   0.00 / 100 + T.Populated_clean_dates_update_date_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'src_rid','rid','bdid','powid','proxid','seleid','orgid','ultid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','physical_rawaid','physical_aceaid','mailing_rawaid','mailing_aceaid','record_type','file_type','lncagid','lncaghid','lncaiid','rawfields_enterprise_num','rawfields_parent_enterprise_number','rawfields_ultimate_enterprise_number','rawfields_company_type','rawfields_name','rawfields_e_mail','rawfields_url','rawfields_incorp','rawfields_sic1','rawfields_sic2','rawfields_sic3','rawfields_sic4','rawfields_sic5','rawfields_sic6','rawfields_sic7','rawfields_sic8','rawfields_sic9','rawfields_sic10','rawfields_naics1','rawfields_naics2','rawfields_naics3','rawfields_naics4','rawfields_naics5','rawfields_naics6','rawfields_naics7','rawfields_naics8','rawfields_naics9','rawfields_naics10','physical_address_prim_name','physical_address_p_city_name','physical_address_v_city_name','physical_address_st','physical_address_zip','mailing_address_prim_name','mailing_address_p_city_name','mailing_address_v_city_name','mailing_address_st','mailing_address_zip','clean_phones_phone','clean_phones_fax','clean_phones_telex','clean_dates_update_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_src_rid_pcnt,le.populated_rid_pcnt,le.populated_bdid_pcnt,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_physical_rawaid_pcnt,le.populated_physical_aceaid_pcnt,le.populated_mailing_rawaid_pcnt,le.populated_mailing_aceaid_pcnt,le.populated_record_type_pcnt,le.populated_file_type_pcnt,le.populated_lncagid_pcnt,le.populated_lncaghid_pcnt,le.populated_lncaiid_pcnt,le.populated_rawfields_enterprise_num_pcnt,le.populated_rawfields_parent_enterprise_number_pcnt,le.populated_rawfields_ultimate_enterprise_number_pcnt,le.populated_rawfields_company_type_pcnt,le.populated_rawfields_name_pcnt,le.populated_rawfields_e_mail_pcnt,le.populated_rawfields_url_pcnt,le.populated_rawfields_incorp_pcnt,le.populated_rawfields_sic1_pcnt,le.populated_rawfields_sic2_pcnt,le.populated_rawfields_sic3_pcnt,le.populated_rawfields_sic4_pcnt,le.populated_rawfields_sic5_pcnt,le.populated_rawfields_sic6_pcnt,le.populated_rawfields_sic7_pcnt,le.populated_rawfields_sic8_pcnt,le.populated_rawfields_sic9_pcnt,le.populated_rawfields_sic10_pcnt,le.populated_rawfields_naics1_pcnt,le.populated_rawfields_naics2_pcnt,le.populated_rawfields_naics3_pcnt,le.populated_rawfields_naics4_pcnt,le.populated_rawfields_naics5_pcnt,le.populated_rawfields_naics6_pcnt,le.populated_rawfields_naics7_pcnt,le.populated_rawfields_naics8_pcnt,le.populated_rawfields_naics9_pcnt,le.populated_rawfields_naics10_pcnt,le.populated_physical_address_prim_name_pcnt,le.populated_physical_address_p_city_name_pcnt,le.populated_physical_address_v_city_name_pcnt,le.populated_physical_address_st_pcnt,le.populated_physical_address_zip_pcnt,le.populated_mailing_address_prim_name_pcnt,le.populated_mailing_address_p_city_name_pcnt,le.populated_mailing_address_v_city_name_pcnt,le.populated_mailing_address_st_pcnt,le.populated_mailing_address_zip_pcnt,le.populated_clean_phones_phone_pcnt,le.populated_clean_phones_fax_pcnt,le.populated_clean_phones_telex_pcnt,le.populated_clean_dates_update_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_src_rid,le.maxlength_rid,le.maxlength_bdid,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_physical_rawaid,le.maxlength_physical_aceaid,le.maxlength_mailing_rawaid,le.maxlength_mailing_aceaid,le.maxlength_record_type,le.maxlength_file_type,le.maxlength_lncagid,le.maxlength_lncaghid,le.maxlength_lncaiid,le.maxlength_rawfields_enterprise_num,le.maxlength_rawfields_parent_enterprise_number,le.maxlength_rawfields_ultimate_enterprise_number,le.maxlength_rawfields_company_type,le.maxlength_rawfields_name,le.maxlength_rawfields_e_mail,le.maxlength_rawfields_url,le.maxlength_rawfields_incorp,le.maxlength_rawfields_sic1,le.maxlength_rawfields_sic2,le.maxlength_rawfields_sic3,le.maxlength_rawfields_sic4,le.maxlength_rawfields_sic5,le.maxlength_rawfields_sic6,le.maxlength_rawfields_sic7,le.maxlength_rawfields_sic8,le.maxlength_rawfields_sic9,le.maxlength_rawfields_sic10,le.maxlength_rawfields_naics1,le.maxlength_rawfields_naics2,le.maxlength_rawfields_naics3,le.maxlength_rawfields_naics4,le.maxlength_rawfields_naics5,le.maxlength_rawfields_naics6,le.maxlength_rawfields_naics7,le.maxlength_rawfields_naics8,le.maxlength_rawfields_naics9,le.maxlength_rawfields_naics10,le.maxlength_physical_address_prim_name,le.maxlength_physical_address_p_city_name,le.maxlength_physical_address_v_city_name,le.maxlength_physical_address_st,le.maxlength_physical_address_zip,le.maxlength_mailing_address_prim_name,le.maxlength_mailing_address_p_city_name,le.maxlength_mailing_address_v_city_name,le.maxlength_mailing_address_st,le.maxlength_mailing_address_zip,le.maxlength_clean_phones_phone,le.maxlength_clean_phones_fax,le.maxlength_clean_phones_telex,le.maxlength_clean_dates_update_date);
  SELF.avelength := CHOOSE(C,le.avelength_src_rid,le.avelength_rid,le.avelength_bdid,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_physical_rawaid,le.avelength_physical_aceaid,le.avelength_mailing_rawaid,le.avelength_mailing_aceaid,le.avelength_record_type,le.avelength_file_type,le.avelength_lncagid,le.avelength_lncaghid,le.avelength_lncaiid,le.avelength_rawfields_enterprise_num,le.avelength_rawfields_parent_enterprise_number,le.avelength_rawfields_ultimate_enterprise_number,le.avelength_rawfields_company_type,le.avelength_rawfields_name,le.avelength_rawfields_e_mail,le.avelength_rawfields_url,le.avelength_rawfields_incorp,le.avelength_rawfields_sic1,le.avelength_rawfields_sic2,le.avelength_rawfields_sic3,le.avelength_rawfields_sic4,le.avelength_rawfields_sic5,le.avelength_rawfields_sic6,le.avelength_rawfields_sic7,le.avelength_rawfields_sic8,le.avelength_rawfields_sic9,le.avelength_rawfields_sic10,le.avelength_rawfields_naics1,le.avelength_rawfields_naics2,le.avelength_rawfields_naics3,le.avelength_rawfields_naics4,le.avelength_rawfields_naics5,le.avelength_rawfields_naics6,le.avelength_rawfields_naics7,le.avelength_rawfields_naics8,le.avelength_rawfields_naics9,le.avelength_rawfields_naics10,le.avelength_physical_address_prim_name,le.avelength_physical_address_p_city_name,le.avelength_physical_address_v_city_name,le.avelength_physical_address_st,le.avelength_physical_address_zip,le.avelength_mailing_address_prim_name,le.avelength_mailing_address_p_city_name,le.avelength_mailing_address_v_city_name,le.avelength_mailing_address_st,le.avelength_mailing_address_zip,le.avelength_clean_phones_phone,le.avelength_clean_phones_fax,le.avelength_clean_phones_telex,le.avelength_clean_dates_update_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 63, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.src_rid <> 0,TRIM((SALT34.StrType)le.src_rid), ''),IF (le.rid <> 0,TRIM((SALT34.StrType)le.rid), ''),IF (le.bdid <> 0,TRIM((SALT34.StrType)le.bdid), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.date_first_seen <> 0,TRIM((SALT34.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT34.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_last_reported), ''),IF (le.physical_rawaid <> 0,TRIM((SALT34.StrType)le.physical_rawaid), ''),IF (le.physical_aceaid <> 0,TRIM((SALT34.StrType)le.physical_aceaid), ''),IF (le.mailing_rawaid <> 0,TRIM((SALT34.StrType)le.mailing_rawaid), ''),IF (le.mailing_aceaid <> 0,TRIM((SALT34.StrType)le.mailing_aceaid), ''),IF (le.record_type <> 0,TRIM((SALT34.StrType)le.record_type), ''),TRIM((SALT34.StrType)le.file_type),IF (le.lncagid <> 0,TRIM((SALT34.StrType)le.lncagid), ''),IF (le.lncaghid <> 0,TRIM((SALT34.StrType)le.lncaghid), ''),IF (le.lncaiid <> 0,TRIM((SALT34.StrType)le.lncaiid), ''),TRIM((SALT34.StrType)le.rawfields_enterprise_num),TRIM((SALT34.StrType)le.rawfields_parent_enterprise_number),TRIM((SALT34.StrType)le.rawfields_ultimate_enterprise_number),TRIM((SALT34.StrType)le.rawfields_company_type),TRIM((SALT34.StrType)le.rawfields_name),TRIM((SALT34.StrType)le.rawfields_e_mail),TRIM((SALT34.StrType)le.rawfields_url),TRIM((SALT34.StrType)le.rawfields_incorp),TRIM((SALT34.StrType)le.rawfields_sic1),TRIM((SALT34.StrType)le.rawfields_sic2),TRIM((SALT34.StrType)le.rawfields_sic3),TRIM((SALT34.StrType)le.rawfields_sic4),TRIM((SALT34.StrType)le.rawfields_sic5),TRIM((SALT34.StrType)le.rawfields_sic6),TRIM((SALT34.StrType)le.rawfields_sic7),TRIM((SALT34.StrType)le.rawfields_sic8),TRIM((SALT34.StrType)le.rawfields_sic9),TRIM((SALT34.StrType)le.rawfields_sic10),TRIM((SALT34.StrType)le.rawfields_naics1),TRIM((SALT34.StrType)le.rawfields_naics2),TRIM((SALT34.StrType)le.rawfields_naics3),TRIM((SALT34.StrType)le.rawfields_naics4),TRIM((SALT34.StrType)le.rawfields_naics5),TRIM((SALT34.StrType)le.rawfields_naics6),TRIM((SALT34.StrType)le.rawfields_naics7),TRIM((SALT34.StrType)le.rawfields_naics8),TRIM((SALT34.StrType)le.rawfields_naics9),TRIM((SALT34.StrType)le.rawfields_naics10),TRIM((SALT34.StrType)le.physical_address_prim_name),TRIM((SALT34.StrType)le.physical_address_p_city_name),TRIM((SALT34.StrType)le.physical_address_v_city_name),TRIM((SALT34.StrType)le.physical_address_st),TRIM((SALT34.StrType)le.physical_address_zip),TRIM((SALT34.StrType)le.mailing_address_prim_name),TRIM((SALT34.StrType)le.mailing_address_p_city_name),TRIM((SALT34.StrType)le.mailing_address_v_city_name),TRIM((SALT34.StrType)le.mailing_address_st),TRIM((SALT34.StrType)le.mailing_address_zip),TRIM((SALT34.StrType)le.clean_phones_phone),TRIM((SALT34.StrType)le.clean_phones_fax),TRIM((SALT34.StrType)le.clean_phones_telex),TRIM((SALT34.StrType)le.clean_dates_update_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,63,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 63);
  SELF.FldNo2 := 1 + (C % 63);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.src_rid <> 0,TRIM((SALT34.StrType)le.src_rid), ''),IF (le.rid <> 0,TRIM((SALT34.StrType)le.rid), ''),IF (le.bdid <> 0,TRIM((SALT34.StrType)le.bdid), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.date_first_seen <> 0,TRIM((SALT34.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT34.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_last_reported), ''),IF (le.physical_rawaid <> 0,TRIM((SALT34.StrType)le.physical_rawaid), ''),IF (le.physical_aceaid <> 0,TRIM((SALT34.StrType)le.physical_aceaid), ''),IF (le.mailing_rawaid <> 0,TRIM((SALT34.StrType)le.mailing_rawaid), ''),IF (le.mailing_aceaid <> 0,TRIM((SALT34.StrType)le.mailing_aceaid), ''),IF (le.record_type <> 0,TRIM((SALT34.StrType)le.record_type), ''),TRIM((SALT34.StrType)le.file_type),IF (le.lncagid <> 0,TRIM((SALT34.StrType)le.lncagid), ''),IF (le.lncaghid <> 0,TRIM((SALT34.StrType)le.lncaghid), ''),IF (le.lncaiid <> 0,TRIM((SALT34.StrType)le.lncaiid), ''),TRIM((SALT34.StrType)le.rawfields_enterprise_num),TRIM((SALT34.StrType)le.rawfields_parent_enterprise_number),TRIM((SALT34.StrType)le.rawfields_ultimate_enterprise_number),TRIM((SALT34.StrType)le.rawfields_company_type),TRIM((SALT34.StrType)le.rawfields_name),TRIM((SALT34.StrType)le.rawfields_e_mail),TRIM((SALT34.StrType)le.rawfields_url),TRIM((SALT34.StrType)le.rawfields_incorp),TRIM((SALT34.StrType)le.rawfields_sic1),TRIM((SALT34.StrType)le.rawfields_sic2),TRIM((SALT34.StrType)le.rawfields_sic3),TRIM((SALT34.StrType)le.rawfields_sic4),TRIM((SALT34.StrType)le.rawfields_sic5),TRIM((SALT34.StrType)le.rawfields_sic6),TRIM((SALT34.StrType)le.rawfields_sic7),TRIM((SALT34.StrType)le.rawfields_sic8),TRIM((SALT34.StrType)le.rawfields_sic9),TRIM((SALT34.StrType)le.rawfields_sic10),TRIM((SALT34.StrType)le.rawfields_naics1),TRIM((SALT34.StrType)le.rawfields_naics2),TRIM((SALT34.StrType)le.rawfields_naics3),TRIM((SALT34.StrType)le.rawfields_naics4),TRIM((SALT34.StrType)le.rawfields_naics5),TRIM((SALT34.StrType)le.rawfields_naics6),TRIM((SALT34.StrType)le.rawfields_naics7),TRIM((SALT34.StrType)le.rawfields_naics8),TRIM((SALT34.StrType)le.rawfields_naics9),TRIM((SALT34.StrType)le.rawfields_naics10),TRIM((SALT34.StrType)le.physical_address_prim_name),TRIM((SALT34.StrType)le.physical_address_p_city_name),TRIM((SALT34.StrType)le.physical_address_v_city_name),TRIM((SALT34.StrType)le.physical_address_st),TRIM((SALT34.StrType)le.physical_address_zip),TRIM((SALT34.StrType)le.mailing_address_prim_name),TRIM((SALT34.StrType)le.mailing_address_p_city_name),TRIM((SALT34.StrType)le.mailing_address_v_city_name),TRIM((SALT34.StrType)le.mailing_address_st),TRIM((SALT34.StrType)le.mailing_address_zip),TRIM((SALT34.StrType)le.clean_phones_phone),TRIM((SALT34.StrType)le.clean_phones_fax),TRIM((SALT34.StrType)le.clean_phones_telex),TRIM((SALT34.StrType)le.clean_dates_update_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.src_rid <> 0,TRIM((SALT34.StrType)le.src_rid), ''),IF (le.rid <> 0,TRIM((SALT34.StrType)le.rid), ''),IF (le.bdid <> 0,TRIM((SALT34.StrType)le.bdid), ''),IF (le.powid <> 0,TRIM((SALT34.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT34.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT34.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT34.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT34.StrType)le.ultid), ''),IF (le.date_first_seen <> 0,TRIM((SALT34.StrType)le.date_first_seen), ''),IF (le.date_last_seen <> 0,TRIM((SALT34.StrType)le.date_last_seen), ''),IF (le.date_vendor_first_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_first_reported), ''),IF (le.date_vendor_last_reported <> 0,TRIM((SALT34.StrType)le.date_vendor_last_reported), ''),IF (le.physical_rawaid <> 0,TRIM((SALT34.StrType)le.physical_rawaid), ''),IF (le.physical_aceaid <> 0,TRIM((SALT34.StrType)le.physical_aceaid), ''),IF (le.mailing_rawaid <> 0,TRIM((SALT34.StrType)le.mailing_rawaid), ''),IF (le.mailing_aceaid <> 0,TRIM((SALT34.StrType)le.mailing_aceaid), ''),IF (le.record_type <> 0,TRIM((SALT34.StrType)le.record_type), ''),TRIM((SALT34.StrType)le.file_type),IF (le.lncagid <> 0,TRIM((SALT34.StrType)le.lncagid), ''),IF (le.lncaghid <> 0,TRIM((SALT34.StrType)le.lncaghid), ''),IF (le.lncaiid <> 0,TRIM((SALT34.StrType)le.lncaiid), ''),TRIM((SALT34.StrType)le.rawfields_enterprise_num),TRIM((SALT34.StrType)le.rawfields_parent_enterprise_number),TRIM((SALT34.StrType)le.rawfields_ultimate_enterprise_number),TRIM((SALT34.StrType)le.rawfields_company_type),TRIM((SALT34.StrType)le.rawfields_name),TRIM((SALT34.StrType)le.rawfields_e_mail),TRIM((SALT34.StrType)le.rawfields_url),TRIM((SALT34.StrType)le.rawfields_incorp),TRIM((SALT34.StrType)le.rawfields_sic1),TRIM((SALT34.StrType)le.rawfields_sic2),TRIM((SALT34.StrType)le.rawfields_sic3),TRIM((SALT34.StrType)le.rawfields_sic4),TRIM((SALT34.StrType)le.rawfields_sic5),TRIM((SALT34.StrType)le.rawfields_sic6),TRIM((SALT34.StrType)le.rawfields_sic7),TRIM((SALT34.StrType)le.rawfields_sic8),TRIM((SALT34.StrType)le.rawfields_sic9),TRIM((SALT34.StrType)le.rawfields_sic10),TRIM((SALT34.StrType)le.rawfields_naics1),TRIM((SALT34.StrType)le.rawfields_naics2),TRIM((SALT34.StrType)le.rawfields_naics3),TRIM((SALT34.StrType)le.rawfields_naics4),TRIM((SALT34.StrType)le.rawfields_naics5),TRIM((SALT34.StrType)le.rawfields_naics6),TRIM((SALT34.StrType)le.rawfields_naics7),TRIM((SALT34.StrType)le.rawfields_naics8),TRIM((SALT34.StrType)le.rawfields_naics9),TRIM((SALT34.StrType)le.rawfields_naics10),TRIM((SALT34.StrType)le.physical_address_prim_name),TRIM((SALT34.StrType)le.physical_address_p_city_name),TRIM((SALT34.StrType)le.physical_address_v_city_name),TRIM((SALT34.StrType)le.physical_address_st),TRIM((SALT34.StrType)le.physical_address_zip),TRIM((SALT34.StrType)le.mailing_address_prim_name),TRIM((SALT34.StrType)le.mailing_address_p_city_name),TRIM((SALT34.StrType)le.mailing_address_v_city_name),TRIM((SALT34.StrType)le.mailing_address_st),TRIM((SALT34.StrType)le.mailing_address_zip),TRIM((SALT34.StrType)le.clean_phones_phone),TRIM((SALT34.StrType)le.clean_phones_fax),TRIM((SALT34.StrType)le.clean_phones_telex),TRIM((SALT34.StrType)le.clean_dates_update_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),63*63,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'src_rid'}
      ,{2,'rid'}
      ,{3,'bdid'}
      ,{4,'powid'}
      ,{5,'proxid'}
      ,{6,'seleid'}
      ,{7,'orgid'}
      ,{8,'ultid'}
      ,{9,'date_first_seen'}
      ,{10,'date_last_seen'}
      ,{11,'date_vendor_first_reported'}
      ,{12,'date_vendor_last_reported'}
      ,{13,'physical_rawaid'}
      ,{14,'physical_aceaid'}
      ,{15,'mailing_rawaid'}
      ,{16,'mailing_aceaid'}
      ,{17,'record_type'}
      ,{18,'file_type'}
      ,{19,'lncagid'}
      ,{20,'lncaghid'}
      ,{21,'lncaiid'}
      ,{22,'rawfields_enterprise_num'}
      ,{23,'rawfields_parent_enterprise_number'}
      ,{24,'rawfields_ultimate_enterprise_number'}
      ,{25,'rawfields_company_type'}
      ,{26,'rawfields_name'}
      ,{27,'rawfields_e_mail'}
      ,{28,'rawfields_url'}
      ,{29,'rawfields_incorp'}
      ,{30,'rawfields_sic1'}
      ,{31,'rawfields_sic2'}
      ,{32,'rawfields_sic3'}
      ,{33,'rawfields_sic4'}
      ,{34,'rawfields_sic5'}
      ,{35,'rawfields_sic6'}
      ,{36,'rawfields_sic7'}
      ,{37,'rawfields_sic8'}
      ,{38,'rawfields_sic9'}
      ,{39,'rawfields_sic10'}
      ,{40,'rawfields_naics1'}
      ,{41,'rawfields_naics2'}
      ,{42,'rawfields_naics3'}
      ,{43,'rawfields_naics4'}
      ,{44,'rawfields_naics5'}
      ,{45,'rawfields_naics6'}
      ,{46,'rawfields_naics7'}
      ,{47,'rawfields_naics8'}
      ,{48,'rawfields_naics9'}
      ,{49,'rawfields_naics10'}
      ,{50,'physical_address_prim_name'}
      ,{51,'physical_address_p_city_name'}
      ,{52,'physical_address_v_city_name'}
      ,{53,'physical_address_st'}
      ,{54,'physical_address_zip'}
      ,{55,'mailing_address_prim_name'}
      ,{56,'mailing_address_p_city_name'}
      ,{57,'mailing_address_v_city_name'}
      ,{58,'mailing_address_st'}
      ,{59,'mailing_address_zip'}
      ,{60,'clean_phones_phone'}
      ,{61,'clean_phones_fax'}
      ,{62,'clean_phones_telex'}
      ,{63,'clean_dates_update_date'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Companies_Fields.InValid_src_rid((SALT34.StrType)le.src_rid),
    Base_Companies_Fields.InValid_rid((SALT34.StrType)le.rid),
    Base_Companies_Fields.InValid_bdid((SALT34.StrType)le.bdid),
    Base_Companies_Fields.InValid_powid((SALT34.StrType)le.powid),
    Base_Companies_Fields.InValid_proxid((SALT34.StrType)le.proxid),
    Base_Companies_Fields.InValid_seleid((SALT34.StrType)le.seleid),
    Base_Companies_Fields.InValid_orgid((SALT34.StrType)le.orgid),
    Base_Companies_Fields.InValid_ultid((SALT34.StrType)le.ultid),
    Base_Companies_Fields.InValid_date_first_seen((SALT34.StrType)le.date_first_seen),
    Base_Companies_Fields.InValid_date_last_seen((SALT34.StrType)le.date_last_seen),
    Base_Companies_Fields.InValid_date_vendor_first_reported((SALT34.StrType)le.date_vendor_first_reported),
    Base_Companies_Fields.InValid_date_vendor_last_reported((SALT34.StrType)le.date_vendor_last_reported),
    Base_Companies_Fields.InValid_physical_rawaid((SALT34.StrType)le.physical_rawaid),
    Base_Companies_Fields.InValid_physical_aceaid((SALT34.StrType)le.physical_aceaid),
    Base_Companies_Fields.InValid_mailing_rawaid((SALT34.StrType)le.mailing_rawaid),
    Base_Companies_Fields.InValid_mailing_aceaid((SALT34.StrType)le.mailing_aceaid),
    Base_Companies_Fields.InValid_record_type((SALT34.StrType)le.record_type),
    Base_Companies_Fields.InValid_file_type((SALT34.StrType)le.file_type),
    Base_Companies_Fields.InValid_lncagid((SALT34.StrType)le.lncagid),
    Base_Companies_Fields.InValid_lncaghid((SALT34.StrType)le.lncaghid),
    Base_Companies_Fields.InValid_lncaiid((SALT34.StrType)le.lncaiid),
    Base_Companies_Fields.InValid_rawfields_enterprise_num((SALT34.StrType)le.rawfields_enterprise_num),
    Base_Companies_Fields.InValid_rawfields_parent_enterprise_number((SALT34.StrType)le.rawfields_parent_enterprise_number),
    Base_Companies_Fields.InValid_rawfields_ultimate_enterprise_number((SALT34.StrType)le.rawfields_ultimate_enterprise_number),
    Base_Companies_Fields.InValid_rawfields_company_type((SALT34.StrType)le.rawfields_company_type),
    Base_Companies_Fields.InValid_rawfields_name((SALT34.StrType)le.rawfields_name),
    Base_Companies_Fields.InValid_rawfields_e_mail((SALT34.StrType)le.rawfields_e_mail),
    Base_Companies_Fields.InValid_rawfields_url((SALT34.StrType)le.rawfields_url),
    Base_Companies_Fields.InValid_rawfields_incorp((SALT34.StrType)le.rawfields_incorp),
    Base_Companies_Fields.InValid_rawfields_sic1((SALT34.StrType)le.rawfields_sic1),
    Base_Companies_Fields.InValid_rawfields_sic2((SALT34.StrType)le.rawfields_sic2),
    Base_Companies_Fields.InValid_rawfields_sic3((SALT34.StrType)le.rawfields_sic3),
    Base_Companies_Fields.InValid_rawfields_sic4((SALT34.StrType)le.rawfields_sic4),
    Base_Companies_Fields.InValid_rawfields_sic5((SALT34.StrType)le.rawfields_sic5),
    Base_Companies_Fields.InValid_rawfields_sic6((SALT34.StrType)le.rawfields_sic6),
    Base_Companies_Fields.InValid_rawfields_sic7((SALT34.StrType)le.rawfields_sic7),
    Base_Companies_Fields.InValid_rawfields_sic8((SALT34.StrType)le.rawfields_sic8),
    Base_Companies_Fields.InValid_rawfields_sic9((SALT34.StrType)le.rawfields_sic9),
    Base_Companies_Fields.InValid_rawfields_sic10((SALT34.StrType)le.rawfields_sic10),
    Base_Companies_Fields.InValid_rawfields_naics1((SALT34.StrType)le.rawfields_naics1),
    Base_Companies_Fields.InValid_rawfields_naics2((SALT34.StrType)le.rawfields_naics2),
    Base_Companies_Fields.InValid_rawfields_naics3((SALT34.StrType)le.rawfields_naics3),
    Base_Companies_Fields.InValid_rawfields_naics4((SALT34.StrType)le.rawfields_naics4),
    Base_Companies_Fields.InValid_rawfields_naics5((SALT34.StrType)le.rawfields_naics5),
    Base_Companies_Fields.InValid_rawfields_naics6((SALT34.StrType)le.rawfields_naics6),
    Base_Companies_Fields.InValid_rawfields_naics7((SALT34.StrType)le.rawfields_naics7),
    Base_Companies_Fields.InValid_rawfields_naics8((SALT34.StrType)le.rawfields_naics8),
    Base_Companies_Fields.InValid_rawfields_naics9((SALT34.StrType)le.rawfields_naics9),
    Base_Companies_Fields.InValid_rawfields_naics10((SALT34.StrType)le.rawfields_naics10),
    Base_Companies_Fields.InValid_physical_address_prim_name((SALT34.StrType)le.physical_address_prim_name),
    Base_Companies_Fields.InValid_physical_address_p_city_name((SALT34.StrType)le.physical_address_p_city_name),
    Base_Companies_Fields.InValid_physical_address_v_city_name((SALT34.StrType)le.physical_address_v_city_name),
    Base_Companies_Fields.InValid_physical_address_st((SALT34.StrType)le.physical_address_st),
    Base_Companies_Fields.InValid_physical_address_zip((SALT34.StrType)le.physical_address_zip),
    Base_Companies_Fields.InValid_mailing_address_prim_name((SALT34.StrType)le.mailing_address_prim_name),
    Base_Companies_Fields.InValid_mailing_address_p_city_name((SALT34.StrType)le.mailing_address_p_city_name),
    Base_Companies_Fields.InValid_mailing_address_v_city_name((SALT34.StrType)le.mailing_address_v_city_name),
    Base_Companies_Fields.InValid_mailing_address_st((SALT34.StrType)le.mailing_address_st),
    Base_Companies_Fields.InValid_mailing_address_zip((SALT34.StrType)le.mailing_address_zip),
    Base_Companies_Fields.InValid_clean_phones_phone((SALT34.StrType)le.clean_phones_phone),
    Base_Companies_Fields.InValid_clean_phones_fax((SALT34.StrType)le.clean_phones_fax),
    Base_Companies_Fields.InValid_clean_phones_telex((SALT34.StrType)le.clean_phones_telex),
    Base_Companies_Fields.InValid_clean_dates_update_date((SALT34.StrType)le.clean_dates_update_date),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,63,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Companies_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_src_rid','invalid_rid','invalid_bdid','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_record_type','invalid_file_type','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_company_type','invalid_mandatory','invalid_email','invalid_url','invalid_alphablank','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_phone','invalid_phone','invalid_phone','invalid_pastdate');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Companies_Fields.InValidMessage_src_rid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_physical_rawaid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_physical_aceaid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_mailing_rawaid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_mailing_aceaid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_file_type(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_lncagid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_lncaghid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_lncaiid(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_enterprise_num(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_parent_enterprise_number(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_ultimate_enterprise_number(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_company_type(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_name(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_e_mail(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_url(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_incorp(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_sic1(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_sic2(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_sic3(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_sic4(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_sic5(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_sic6(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_sic7(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_sic8(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_sic9(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_sic10(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_naics1(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_naics2(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_naics3(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_naics4(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_naics5(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_naics6(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_naics7(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_naics8(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_naics9(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_rawfields_naics10(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_physical_address_prim_name(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_physical_address_p_city_name(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_physical_address_v_city_name(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_physical_address_st(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_physical_address_zip(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_mailing_address_prim_name(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_mailing_address_p_city_name(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_mailing_address_v_city_name(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_mailing_address_st(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_mailing_address_zip(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_clean_phones_phone(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_clean_phones_fax(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_clean_phones_telex(TotalErrors.ErrorNum),Base_Companies_Fields.InValidMessage_clean_dates_update_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
