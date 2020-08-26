IMPORT SALT311,STD;
EXPORT Executives_hygiene(dataset(Executives_layout_Cortera) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_link_id_cnt := COUNT(GROUP,h.link_id <> (TYPEOF(h.link_id))'');
    populated_link_id_pcnt := AVE(GROUP,IF(h.link_id = (TYPEOF(h.link_id))'',0,100));
    maxlength_link_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.link_id)));
    avelength_link_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.link_id)),h.link_id<>(typeof(h.link_id))'');
    populated_name_cnt := COUNT(GROUP,h.name <> (TYPEOF(h.name))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_alternate_business_name_cnt := COUNT(GROUP,h.alternate_business_name <> (TYPEOF(h.alternate_business_name))'');
    populated_alternate_business_name_pcnt := AVE(GROUP,IF(h.alternate_business_name = (TYPEOF(h.alternate_business_name))'',0,100));
    maxlength_alternate_business_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alternate_business_name)));
    avelength_alternate_business_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alternate_business_name)),h.alternate_business_name<>(typeof(h.alternate_business_name))'');
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
    populated_country_cnt := COUNT(GROUP,h.country <> (TYPEOF(h.country))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_postalcode_cnt := COUNT(GROUP,h.postalcode <> (TYPEOF(h.postalcode))'');
    populated_postalcode_pcnt := AVE(GROUP,IF(h.postalcode = (TYPEOF(h.postalcode))'',0,100));
    maxlength_postalcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postalcode)));
    avelength_postalcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postalcode)),h.postalcode<>(typeof(h.postalcode))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_fax_cnt := COUNT(GROUP,h.fax <> (TYPEOF(h.fax))'');
    populated_fax_pcnt := AVE(GROUP,IF(h.fax = (TYPEOF(h.fax))'',0,100));
    maxlength_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax)));
    avelength_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fax)),h.fax<>(typeof(h.fax))'');
    populated_latitude_cnt := COUNT(GROUP,h.latitude <> (TYPEOF(h.latitude))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_longitude_cnt := COUNT(GROUP,h.longitude <> (TYPEOF(h.longitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_url_cnt := COUNT(GROUP,h.url <> (TYPEOF(h.url))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_fein_cnt := COUNT(GROUP,h.fein <> (TYPEOF(h.fein))'');
    populated_fein_pcnt := AVE(GROUP,IF(h.fein = (TYPEOF(h.fein))'',0,100));
    maxlength_fein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fein)));
    avelength_fein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fein)),h.fein<>(typeof(h.fein))'');
    populated_position_type_cnt := COUNT(GROUP,h.position_type <> (TYPEOF(h.position_type))'');
    populated_position_type_pcnt := AVE(GROUP,IF(h.position_type = (TYPEOF(h.position_type))'',0,100));
    maxlength_position_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.position_type)));
    avelength_position_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.position_type)),h.position_type<>(typeof(h.position_type))'');
    populated_ultimate_linkid_cnt := COUNT(GROUP,h.ultimate_linkid <> (TYPEOF(h.ultimate_linkid))'');
    populated_ultimate_linkid_pcnt := AVE(GROUP,IF(h.ultimate_linkid = (TYPEOF(h.ultimate_linkid))'',0,100));
    maxlength_ultimate_linkid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultimate_linkid)));
    avelength_ultimate_linkid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultimate_linkid)),h.ultimate_linkid<>(typeof(h.ultimate_linkid))'');
    populated_ultimate_name_cnt := COUNT(GROUP,h.ultimate_name <> (TYPEOF(h.ultimate_name))'');
    populated_ultimate_name_pcnt := AVE(GROUP,IF(h.ultimate_name = (TYPEOF(h.ultimate_name))'',0,100));
    maxlength_ultimate_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultimate_name)));
    avelength_ultimate_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultimate_name)),h.ultimate_name<>(typeof(h.ultimate_name))'');
    populated_loc_date_last_seen_cnt := COUNT(GROUP,h.loc_date_last_seen <> (TYPEOF(h.loc_date_last_seen))'');
    populated_loc_date_last_seen_pcnt := AVE(GROUP,IF(h.loc_date_last_seen = (TYPEOF(h.loc_date_last_seen))'',0,100));
    maxlength_loc_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loc_date_last_seen)));
    avelength_loc_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loc_date_last_seen)),h.loc_date_last_seen<>(typeof(h.loc_date_last_seen))'');
    populated_primary_sic_cnt := COUNT(GROUP,h.primary_sic <> (TYPEOF(h.primary_sic))'');
    populated_primary_sic_pcnt := AVE(GROUP,IF(h.primary_sic = (TYPEOF(h.primary_sic))'',0,100));
    maxlength_primary_sic := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_sic)));
    avelength_primary_sic := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_sic)),h.primary_sic<>(typeof(h.primary_sic))'');
    populated_sic_desc_cnt := COUNT(GROUP,h.sic_desc <> (TYPEOF(h.sic_desc))'');
    populated_sic_desc_pcnt := AVE(GROUP,IF(h.sic_desc = (TYPEOF(h.sic_desc))'',0,100));
    maxlength_sic_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_desc)));
    avelength_sic_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_desc)),h.sic_desc<>(typeof(h.sic_desc))'');
    populated_primary_naics_cnt := COUNT(GROUP,h.primary_naics <> (TYPEOF(h.primary_naics))'');
    populated_primary_naics_pcnt := AVE(GROUP,IF(h.primary_naics = (TYPEOF(h.primary_naics))'',0,100));
    maxlength_primary_naics := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_naics)));
    avelength_primary_naics := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_naics)),h.primary_naics<>(typeof(h.primary_naics))'');
    populated_naics_desc_cnt := COUNT(GROUP,h.naics_desc <> (TYPEOF(h.naics_desc))'');
    populated_naics_desc_pcnt := AVE(GROUP,IF(h.naics_desc = (TYPEOF(h.naics_desc))'',0,100));
    maxlength_naics_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics_desc)));
    avelength_naics_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.naics_desc)),h.naics_desc<>(typeof(h.naics_desc))'');
    populated_segment_id_cnt := COUNT(GROUP,h.segment_id <> (TYPEOF(h.segment_id))'');
    populated_segment_id_pcnt := AVE(GROUP,IF(h.segment_id = (TYPEOF(h.segment_id))'',0,100));
    maxlength_segment_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_id)));
    avelength_segment_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_id)),h.segment_id<>(typeof(h.segment_id))'');
    populated_segment_desc_cnt := COUNT(GROUP,h.segment_desc <> (TYPEOF(h.segment_desc))'');
    populated_segment_desc_pcnt := AVE(GROUP,IF(h.segment_desc = (TYPEOF(h.segment_desc))'',0,100));
    maxlength_segment_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_desc)));
    avelength_segment_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_desc)),h.segment_desc<>(typeof(h.segment_desc))'');
    populated_year_start_cnt := COUNT(GROUP,h.year_start <> (TYPEOF(h.year_start))'');
    populated_year_start_pcnt := AVE(GROUP,IF(h.year_start = (TYPEOF(h.year_start))'',0,100));
    maxlength_year_start := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.year_start)));
    avelength_year_start := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.year_start)),h.year_start<>(typeof(h.year_start))'');
    populated_ownership_cnt := COUNT(GROUP,h.ownership <> (TYPEOF(h.ownership))'');
    populated_ownership_pcnt := AVE(GROUP,IF(h.ownership = (TYPEOF(h.ownership))'',0,100));
    maxlength_ownership := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownership)));
    avelength_ownership := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownership)),h.ownership<>(typeof(h.ownership))'');
    populated_total_employees_cnt := COUNT(GROUP,h.total_employees <> (TYPEOF(h.total_employees))'');
    populated_total_employees_pcnt := AVE(GROUP,IF(h.total_employees = (TYPEOF(h.total_employees))'',0,100));
    maxlength_total_employees := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_employees)));
    avelength_total_employees := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_employees)),h.total_employees<>(typeof(h.total_employees))'');
    populated_employee_range_cnt := COUNT(GROUP,h.employee_range <> (TYPEOF(h.employee_range))'');
    populated_employee_range_pcnt := AVE(GROUP,IF(h.employee_range = (TYPEOF(h.employee_range))'',0,100));
    maxlength_employee_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.employee_range)));
    avelength_employee_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.employee_range)),h.employee_range<>(typeof(h.employee_range))'');
    populated_total_sales_cnt := COUNT(GROUP,h.total_sales <> (TYPEOF(h.total_sales))'');
    populated_total_sales_pcnt := AVE(GROUP,IF(h.total_sales = (TYPEOF(h.total_sales))'',0,100));
    maxlength_total_sales := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_sales)));
    avelength_total_sales := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_sales)),h.total_sales<>(typeof(h.total_sales))'');
    populated_sales_range_cnt := COUNT(GROUP,h.sales_range <> (TYPEOF(h.sales_range))'');
    populated_sales_range_pcnt := AVE(GROUP,IF(h.sales_range = (TYPEOF(h.sales_range))'',0,100));
    maxlength_sales_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_range)));
    avelength_sales_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_range)),h.sales_range<>(typeof(h.sales_range))'');
    populated_executive_name1_cnt := COUNT(GROUP,h.executive_name1 <> (TYPEOF(h.executive_name1))'');
    populated_executive_name1_pcnt := AVE(GROUP,IF(h.executive_name1 = (TYPEOF(h.executive_name1))'',0,100));
    maxlength_executive_name1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name1)));
    avelength_executive_name1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name1)),h.executive_name1<>(typeof(h.executive_name1))'');
    populated_title1_cnt := COUNT(GROUP,h.title1 <> (TYPEOF(h.title1))'');
    populated_title1_pcnt := AVE(GROUP,IF(h.title1 = (TYPEOF(h.title1))'',0,100));
    maxlength_title1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title1)));
    avelength_title1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title1)),h.title1<>(typeof(h.title1))'');
    populated_executive_name2_cnt := COUNT(GROUP,h.executive_name2 <> (TYPEOF(h.executive_name2))'');
    populated_executive_name2_pcnt := AVE(GROUP,IF(h.executive_name2 = (TYPEOF(h.executive_name2))'',0,100));
    maxlength_executive_name2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name2)));
    avelength_executive_name2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name2)),h.executive_name2<>(typeof(h.executive_name2))'');
    populated_title2_cnt := COUNT(GROUP,h.title2 <> (TYPEOF(h.title2))'');
    populated_title2_pcnt := AVE(GROUP,IF(h.title2 = (TYPEOF(h.title2))'',0,100));
    maxlength_title2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title2)));
    avelength_title2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title2)),h.title2<>(typeof(h.title2))'');
    populated_executive_name3_cnt := COUNT(GROUP,h.executive_name3 <> (TYPEOF(h.executive_name3))'');
    populated_executive_name3_pcnt := AVE(GROUP,IF(h.executive_name3 = (TYPEOF(h.executive_name3))'',0,100));
    maxlength_executive_name3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name3)));
    avelength_executive_name3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name3)),h.executive_name3<>(typeof(h.executive_name3))'');
    populated_title3_cnt := COUNT(GROUP,h.title3 <> (TYPEOF(h.title3))'');
    populated_title3_pcnt := AVE(GROUP,IF(h.title3 = (TYPEOF(h.title3))'',0,100));
    maxlength_title3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title3)));
    avelength_title3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title3)),h.title3<>(typeof(h.title3))'');
    populated_executive_name4_cnt := COUNT(GROUP,h.executive_name4 <> (TYPEOF(h.executive_name4))'');
    populated_executive_name4_pcnt := AVE(GROUP,IF(h.executive_name4 = (TYPEOF(h.executive_name4))'',0,100));
    maxlength_executive_name4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name4)));
    avelength_executive_name4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name4)),h.executive_name4<>(typeof(h.executive_name4))'');
    populated_title4_cnt := COUNT(GROUP,h.title4 <> (TYPEOF(h.title4))'');
    populated_title4_pcnt := AVE(GROUP,IF(h.title4 = (TYPEOF(h.title4))'',0,100));
    maxlength_title4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title4)));
    avelength_title4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title4)),h.title4<>(typeof(h.title4))'');
    populated_executive_name5_cnt := COUNT(GROUP,h.executive_name5 <> (TYPEOF(h.executive_name5))'');
    populated_executive_name5_pcnt := AVE(GROUP,IF(h.executive_name5 = (TYPEOF(h.executive_name5))'',0,100));
    maxlength_executive_name5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name5)));
    avelength_executive_name5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name5)),h.executive_name5<>(typeof(h.executive_name5))'');
    populated_title5_cnt := COUNT(GROUP,h.title5 <> (TYPEOF(h.title5))'');
    populated_title5_pcnt := AVE(GROUP,IF(h.title5 = (TYPEOF(h.title5))'',0,100));
    maxlength_title5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title5)));
    avelength_title5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title5)),h.title5<>(typeof(h.title5))'');
    populated_executive_name6_cnt := COUNT(GROUP,h.executive_name6 <> (TYPEOF(h.executive_name6))'');
    populated_executive_name6_pcnt := AVE(GROUP,IF(h.executive_name6 = (TYPEOF(h.executive_name6))'',0,100));
    maxlength_executive_name6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name6)));
    avelength_executive_name6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name6)),h.executive_name6<>(typeof(h.executive_name6))'');
    populated_title6_cnt := COUNT(GROUP,h.title6 <> (TYPEOF(h.title6))'');
    populated_title6_pcnt := AVE(GROUP,IF(h.title6 = (TYPEOF(h.title6))'',0,100));
    maxlength_title6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title6)));
    avelength_title6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title6)),h.title6<>(typeof(h.title6))'');
    populated_executive_name7_cnt := COUNT(GROUP,h.executive_name7 <> (TYPEOF(h.executive_name7))'');
    populated_executive_name7_pcnt := AVE(GROUP,IF(h.executive_name7 = (TYPEOF(h.executive_name7))'',0,100));
    maxlength_executive_name7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name7)));
    avelength_executive_name7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name7)),h.executive_name7<>(typeof(h.executive_name7))'');
    populated_title7_cnt := COUNT(GROUP,h.title7 <> (TYPEOF(h.title7))'');
    populated_title7_pcnt := AVE(GROUP,IF(h.title7 = (TYPEOF(h.title7))'',0,100));
    maxlength_title7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title7)));
    avelength_title7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title7)),h.title7<>(typeof(h.title7))'');
    populated_executive_name8_cnt := COUNT(GROUP,h.executive_name8 <> (TYPEOF(h.executive_name8))'');
    populated_executive_name8_pcnt := AVE(GROUP,IF(h.executive_name8 = (TYPEOF(h.executive_name8))'',0,100));
    maxlength_executive_name8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name8)));
    avelength_executive_name8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name8)),h.executive_name8<>(typeof(h.executive_name8))'');
    populated_title8_cnt := COUNT(GROUP,h.title8 <> (TYPEOF(h.title8))'');
    populated_title8_pcnt := AVE(GROUP,IF(h.title8 = (TYPEOF(h.title8))'',0,100));
    maxlength_title8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title8)));
    avelength_title8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title8)),h.title8<>(typeof(h.title8))'');
    populated_executive_name9_cnt := COUNT(GROUP,h.executive_name9 <> (TYPEOF(h.executive_name9))'');
    populated_executive_name9_pcnt := AVE(GROUP,IF(h.executive_name9 = (TYPEOF(h.executive_name9))'',0,100));
    maxlength_executive_name9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name9)));
    avelength_executive_name9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name9)),h.executive_name9<>(typeof(h.executive_name9))'');
    populated_title9_cnt := COUNT(GROUP,h.title9 <> (TYPEOF(h.title9))'');
    populated_title9_pcnt := AVE(GROUP,IF(h.title9 = (TYPEOF(h.title9))'',0,100));
    maxlength_title9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title9)));
    avelength_title9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title9)),h.title9<>(typeof(h.title9))'');
    populated_executive_name10_cnt := COUNT(GROUP,h.executive_name10 <> (TYPEOF(h.executive_name10))'');
    populated_executive_name10_pcnt := AVE(GROUP,IF(h.executive_name10 = (TYPEOF(h.executive_name10))'',0,100));
    maxlength_executive_name10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name10)));
    avelength_executive_name10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name10)),h.executive_name10<>(typeof(h.executive_name10))'');
    populated_title10_cnt := COUNT(GROUP,h.title10 <> (TYPEOF(h.title10))'');
    populated_title10_pcnt := AVE(GROUP,IF(h.title10 = (TYPEOF(h.title10))'',0,100));
    maxlength_title10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title10)));
    avelength_title10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title10)),h.title10<>(typeof(h.title10))'');
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_is_closed_cnt := COUNT(GROUP,h.is_closed <> (TYPEOF(h.is_closed))'');
    populated_is_closed_pcnt := AVE(GROUP,IF(h.is_closed = (TYPEOF(h.is_closed))'',0,100));
    maxlength_is_closed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_closed)));
    avelength_is_closed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_closed)),h.is_closed<>(typeof(h.is_closed))'');
    populated_closed_date_cnt := COUNT(GROUP,h.closed_date <> (TYPEOF(h.closed_date))'');
    populated_closed_date_pcnt := AVE(GROUP,IF(h.closed_date = (TYPEOF(h.closed_date))'',0,100));
    maxlength_closed_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.closed_date)));
    avelength_closed_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.closed_date)),h.closed_date<>(typeof(h.closed_date))'');
    populated_processdate_cnt := COUNT(GROUP,h.processdate <> (TYPEOF(h.processdate))'');
    populated_processdate_pcnt := AVE(GROUP,IF(h.processdate = (TYPEOF(h.processdate))'',0,100));
    maxlength_processdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.processdate)));
    avelength_processdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.processdate)),h.processdate<>(typeof(h.processdate))'');
    populated_version_cnt := COUNT(GROUP,h.version <> (TYPEOF(h.version))'');
    populated_version_pcnt := AVE(GROUP,IF(h.version = (TYPEOF(h.version))'',0,100));
    maxlength_version := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.version)));
    avelength_version := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.version)),h.version<>(typeof(h.version))'');
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
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
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_executive_name_cnt := COUNT(GROUP,h.executive_name <> (TYPEOF(h.executive_name))'');
    populated_executive_name_pcnt := AVE(GROUP,IF(h.executive_name = (TYPEOF(h.executive_name))'',0,100));
    maxlength_executive_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name)));
    avelength_executive_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_name)),h.executive_name<>(typeof(h.executive_name))'');
    populated_executive_title_cnt := COUNT(GROUP,h.executive_title <> (TYPEOF(h.executive_title))'');
    populated_executive_title_pcnt := AVE(GROUP,IF(h.executive_title = (TYPEOF(h.executive_title))'',0,100));
    maxlength_executive_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_title)));
    avelength_executive_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.executive_title)),h.executive_title<>(typeof(h.executive_title))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_link_id_pcnt *   0.00 / 100 + T.Populated_name_pcnt *   0.00 / 100 + T.Populated_alternate_business_name_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_postalcode_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_fax_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_fein_pcnt *   0.00 / 100 + T.Populated_position_type_pcnt *   0.00 / 100 + T.Populated_ultimate_linkid_pcnt *   0.00 / 100 + T.Populated_ultimate_name_pcnt *   0.00 / 100 + T.Populated_loc_date_last_seen_pcnt *   0.00 / 100 + T.Populated_primary_sic_pcnt *   0.00 / 100 + T.Populated_sic_desc_pcnt *   0.00 / 100 + T.Populated_primary_naics_pcnt *   0.00 / 100 + T.Populated_naics_desc_pcnt *   0.00 / 100 + T.Populated_segment_id_pcnt *   0.00 / 100 + T.Populated_segment_desc_pcnt *   0.00 / 100 + T.Populated_year_start_pcnt *   0.00 / 100 + T.Populated_ownership_pcnt *   0.00 / 100 + T.Populated_total_employees_pcnt *   0.00 / 100 + T.Populated_employee_range_pcnt *   0.00 / 100 + T.Populated_total_sales_pcnt *   0.00 / 100 + T.Populated_sales_range_pcnt *   0.00 / 100 + T.Populated_executive_name1_pcnt *   0.00 / 100 + T.Populated_title1_pcnt *   0.00 / 100 + T.Populated_executive_name2_pcnt *   0.00 / 100 + T.Populated_title2_pcnt *   0.00 / 100 + T.Populated_executive_name3_pcnt *   0.00 / 100 + T.Populated_title3_pcnt *   0.00 / 100 + T.Populated_executive_name4_pcnt *   0.00 / 100 + T.Populated_title4_pcnt *   0.00 / 100 + T.Populated_executive_name5_pcnt *   0.00 / 100 + T.Populated_title5_pcnt *   0.00 / 100 + T.Populated_executive_name6_pcnt *   0.00 / 100 + T.Populated_title6_pcnt *   0.00 / 100 + T.Populated_executive_name7_pcnt *   0.00 / 100 + T.Populated_title7_pcnt *   0.00 / 100 + T.Populated_executive_name8_pcnt *   0.00 / 100 + T.Populated_title8_pcnt *   0.00 / 100 + T.Populated_executive_name9_pcnt *   0.00 / 100 + T.Populated_title9_pcnt *   0.00 / 100 + T.Populated_executive_name10_pcnt *   0.00 / 100 + T.Populated_title10_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_is_closed_pcnt *   0.00 / 100 + T.Populated_closed_date_pcnt *   0.00 / 100 + T.Populated_processdate_pcnt *   0.00 / 100 + T.Populated_version_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_executive_name_pcnt *   0.00 / 100 + T.Populated_executive_title_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'link_id','name','alternate_business_name','address','address2','city','state','country','postalcode','phone','fax','latitude','longitude','url','fein','position_type','ultimate_linkid','ultimate_name','loc_date_last_seen','primary_sic','sic_desc','primary_naics','naics_desc','segment_id','segment_desc','year_start','ownership','total_employees','employee_range','total_sales','sales_range','executive_name1','title1','executive_name2','title2','executive_name3','title3','executive_name4','title4','executive_name5','title5','executive_name6','title6','executive_name7','title7','executive_name8','title8','executive_name9','title9','executive_name10','title10','status','is_closed','closed_date','processdate','version','persistent_record_id','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','prim_name','p_city_name','v_city_name','executive_name','executive_title');
  SELF.populated_pcnt := CHOOSE(C,le.populated_link_id_pcnt,le.populated_name_pcnt,le.populated_alternate_business_name_pcnt,le.populated_address_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_country_pcnt,le.populated_postalcode_pcnt,le.populated_phone_pcnt,le.populated_fax_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_url_pcnt,le.populated_fein_pcnt,le.populated_position_type_pcnt,le.populated_ultimate_linkid_pcnt,le.populated_ultimate_name_pcnt,le.populated_loc_date_last_seen_pcnt,le.populated_primary_sic_pcnt,le.populated_sic_desc_pcnt,le.populated_primary_naics_pcnt,le.populated_naics_desc_pcnt,le.populated_segment_id_pcnt,le.populated_segment_desc_pcnt,le.populated_year_start_pcnt,le.populated_ownership_pcnt,le.populated_total_employees_pcnt,le.populated_employee_range_pcnt,le.populated_total_sales_pcnt,le.populated_sales_range_pcnt,le.populated_executive_name1_pcnt,le.populated_title1_pcnt,le.populated_executive_name2_pcnt,le.populated_title2_pcnt,le.populated_executive_name3_pcnt,le.populated_title3_pcnt,le.populated_executive_name4_pcnt,le.populated_title4_pcnt,le.populated_executive_name5_pcnt,le.populated_title5_pcnt,le.populated_executive_name6_pcnt,le.populated_title6_pcnt,le.populated_executive_name7_pcnt,le.populated_title7_pcnt,le.populated_executive_name8_pcnt,le.populated_title8_pcnt,le.populated_executive_name9_pcnt,le.populated_title9_pcnt,le.populated_executive_name10_pcnt,le.populated_title10_pcnt,le.populated_status_pcnt,le.populated_is_closed_pcnt,le.populated_closed_date_pcnt,le.populated_processdate_pcnt,le.populated_version_pcnt,le.populated_persistent_record_id_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_prim_name_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_executive_name_pcnt,le.populated_executive_title_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_link_id,le.maxlength_name,le.maxlength_alternate_business_name,le.maxlength_address,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_country,le.maxlength_postalcode,le.maxlength_phone,le.maxlength_fax,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_url,le.maxlength_fein,le.maxlength_position_type,le.maxlength_ultimate_linkid,le.maxlength_ultimate_name,le.maxlength_loc_date_last_seen,le.maxlength_primary_sic,le.maxlength_sic_desc,le.maxlength_primary_naics,le.maxlength_naics_desc,le.maxlength_segment_id,le.maxlength_segment_desc,le.maxlength_year_start,le.maxlength_ownership,le.maxlength_total_employees,le.maxlength_employee_range,le.maxlength_total_sales,le.maxlength_sales_range,le.maxlength_executive_name1,le.maxlength_title1,le.maxlength_executive_name2,le.maxlength_title2,le.maxlength_executive_name3,le.maxlength_title3,le.maxlength_executive_name4,le.maxlength_title4,le.maxlength_executive_name5,le.maxlength_title5,le.maxlength_executive_name6,le.maxlength_title6,le.maxlength_executive_name7,le.maxlength_title7,le.maxlength_executive_name8,le.maxlength_title8,le.maxlength_executive_name9,le.maxlength_title9,le.maxlength_executive_name10,le.maxlength_title10,le.maxlength_status,le.maxlength_is_closed,le.maxlength_closed_date,le.maxlength_processdate,le.maxlength_version,le.maxlength_persistent_record_id,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_prim_name,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_executive_name,le.maxlength_executive_title);
  SELF.avelength := CHOOSE(C,le.avelength_link_id,le.avelength_name,le.avelength_alternate_business_name,le.avelength_address,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_country,le.avelength_postalcode,le.avelength_phone,le.avelength_fax,le.avelength_latitude,le.avelength_longitude,le.avelength_url,le.avelength_fein,le.avelength_position_type,le.avelength_ultimate_linkid,le.avelength_ultimate_name,le.avelength_loc_date_last_seen,le.avelength_primary_sic,le.avelength_sic_desc,le.avelength_primary_naics,le.avelength_naics_desc,le.avelength_segment_id,le.avelength_segment_desc,le.avelength_year_start,le.avelength_ownership,le.avelength_total_employees,le.avelength_employee_range,le.avelength_total_sales,le.avelength_sales_range,le.avelength_executive_name1,le.avelength_title1,le.avelength_executive_name2,le.avelength_title2,le.avelength_executive_name3,le.avelength_title3,le.avelength_executive_name4,le.avelength_title4,le.avelength_executive_name5,le.avelength_title5,le.avelength_executive_name6,le.avelength_title6,le.avelength_executive_name7,le.avelength_title7,le.avelength_executive_name8,le.avelength_title8,le.avelength_executive_name9,le.avelength_title9,le.avelength_executive_name10,le.avelength_title10,le.avelength_status,le.avelength_is_closed,le.avelength_closed_date,le.avelength_processdate,le.avelength_version,le.avelength_persistent_record_id,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_prim_name,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_executive_name,le.avelength_executive_title);
END;
EXPORT invSummary := NORMALIZE(summary0, 66, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.link_id),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.alternate_business_name),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.postalcode),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.fein),TRIM((SALT311.StrType)le.position_type),TRIM((SALT311.StrType)le.ultimate_linkid),TRIM((SALT311.StrType)le.ultimate_name),TRIM((SALT311.StrType)le.loc_date_last_seen),TRIM((SALT311.StrType)le.primary_sic),TRIM((SALT311.StrType)le.sic_desc),TRIM((SALT311.StrType)le.primary_naics),TRIM((SALT311.StrType)le.naics_desc),TRIM((SALT311.StrType)le.segment_id),TRIM((SALT311.StrType)le.segment_desc),TRIM((SALT311.StrType)le.year_start),TRIM((SALT311.StrType)le.ownership),TRIM((SALT311.StrType)le.total_employees),TRIM((SALT311.StrType)le.employee_range),TRIM((SALT311.StrType)le.total_sales),TRIM((SALT311.StrType)le.sales_range),TRIM((SALT311.StrType)le.executive_name1),TRIM((SALT311.StrType)le.title1),TRIM((SALT311.StrType)le.executive_name2),TRIM((SALT311.StrType)le.title2),TRIM((SALT311.StrType)le.executive_name3),TRIM((SALT311.StrType)le.title3),TRIM((SALT311.StrType)le.executive_name4),TRIM((SALT311.StrType)le.title4),TRIM((SALT311.StrType)le.executive_name5),TRIM((SALT311.StrType)le.title5),TRIM((SALT311.StrType)le.executive_name6),TRIM((SALT311.StrType)le.title6),TRIM((SALT311.StrType)le.executive_name7),TRIM((SALT311.StrType)le.title7),TRIM((SALT311.StrType)le.executive_name8),TRIM((SALT311.StrType)le.title8),TRIM((SALT311.StrType)le.executive_name9),TRIM((SALT311.StrType)le.title9),TRIM((SALT311.StrType)le.executive_name10),TRIM((SALT311.StrType)le.title10),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.is_closed),TRIM((SALT311.StrType)le.closed_date),TRIM((SALT311.StrType)le.processdate),TRIM((SALT311.StrType)le.version),TRIM((SALT311.StrType)le.persistent_record_id),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.executive_name),TRIM((SALT311.StrType)le.executive_title)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,66,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 66);
  SELF.FldNo2 := 1 + (C % 66);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.link_id),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.alternate_business_name),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.postalcode),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.fein),TRIM((SALT311.StrType)le.position_type),TRIM((SALT311.StrType)le.ultimate_linkid),TRIM((SALT311.StrType)le.ultimate_name),TRIM((SALT311.StrType)le.loc_date_last_seen),TRIM((SALT311.StrType)le.primary_sic),TRIM((SALT311.StrType)le.sic_desc),TRIM((SALT311.StrType)le.primary_naics),TRIM((SALT311.StrType)le.naics_desc),TRIM((SALT311.StrType)le.segment_id),TRIM((SALT311.StrType)le.segment_desc),TRIM((SALT311.StrType)le.year_start),TRIM((SALT311.StrType)le.ownership),TRIM((SALT311.StrType)le.total_employees),TRIM((SALT311.StrType)le.employee_range),TRIM((SALT311.StrType)le.total_sales),TRIM((SALT311.StrType)le.sales_range),TRIM((SALT311.StrType)le.executive_name1),TRIM((SALT311.StrType)le.title1),TRIM((SALT311.StrType)le.executive_name2),TRIM((SALT311.StrType)le.title2),TRIM((SALT311.StrType)le.executive_name3),TRIM((SALT311.StrType)le.title3),TRIM((SALT311.StrType)le.executive_name4),TRIM((SALT311.StrType)le.title4),TRIM((SALT311.StrType)le.executive_name5),TRIM((SALT311.StrType)le.title5),TRIM((SALT311.StrType)le.executive_name6),TRIM((SALT311.StrType)le.title6),TRIM((SALT311.StrType)le.executive_name7),TRIM((SALT311.StrType)le.title7),TRIM((SALT311.StrType)le.executive_name8),TRIM((SALT311.StrType)le.title8),TRIM((SALT311.StrType)le.executive_name9),TRIM((SALT311.StrType)le.title9),TRIM((SALT311.StrType)le.executive_name10),TRIM((SALT311.StrType)le.title10),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.is_closed),TRIM((SALT311.StrType)le.closed_date),TRIM((SALT311.StrType)le.processdate),TRIM((SALT311.StrType)le.version),TRIM((SALT311.StrType)le.persistent_record_id),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.executive_name),TRIM((SALT311.StrType)le.executive_title)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.link_id),TRIM((SALT311.StrType)le.name),TRIM((SALT311.StrType)le.alternate_business_name),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.country),TRIM((SALT311.StrType)le.postalcode),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.fax),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.fein),TRIM((SALT311.StrType)le.position_type),TRIM((SALT311.StrType)le.ultimate_linkid),TRIM((SALT311.StrType)le.ultimate_name),TRIM((SALT311.StrType)le.loc_date_last_seen),TRIM((SALT311.StrType)le.primary_sic),TRIM((SALT311.StrType)le.sic_desc),TRIM((SALT311.StrType)le.primary_naics),TRIM((SALT311.StrType)le.naics_desc),TRIM((SALT311.StrType)le.segment_id),TRIM((SALT311.StrType)le.segment_desc),TRIM((SALT311.StrType)le.year_start),TRIM((SALT311.StrType)le.ownership),TRIM((SALT311.StrType)le.total_employees),TRIM((SALT311.StrType)le.employee_range),TRIM((SALT311.StrType)le.total_sales),TRIM((SALT311.StrType)le.sales_range),TRIM((SALT311.StrType)le.executive_name1),TRIM((SALT311.StrType)le.title1),TRIM((SALT311.StrType)le.executive_name2),TRIM((SALT311.StrType)le.title2),TRIM((SALT311.StrType)le.executive_name3),TRIM((SALT311.StrType)le.title3),TRIM((SALT311.StrType)le.executive_name4),TRIM((SALT311.StrType)le.title4),TRIM((SALT311.StrType)le.executive_name5),TRIM((SALT311.StrType)le.title5),TRIM((SALT311.StrType)le.executive_name6),TRIM((SALT311.StrType)le.title6),TRIM((SALT311.StrType)le.executive_name7),TRIM((SALT311.StrType)le.title7),TRIM((SALT311.StrType)le.executive_name8),TRIM((SALT311.StrType)le.title8),TRIM((SALT311.StrType)le.executive_name9),TRIM((SALT311.StrType)le.title9),TRIM((SALT311.StrType)le.executive_name10),TRIM((SALT311.StrType)le.title10),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.is_closed),TRIM((SALT311.StrType)le.closed_date),TRIM((SALT311.StrType)le.processdate),TRIM((SALT311.StrType)le.version),TRIM((SALT311.StrType)le.persistent_record_id),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.executive_name),TRIM((SALT311.StrType)le.executive_title)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),66*66,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'link_id'}
      ,{2,'name'}
      ,{3,'alternate_business_name'}
      ,{4,'address'}
      ,{5,'address2'}
      ,{6,'city'}
      ,{7,'state'}
      ,{8,'country'}
      ,{9,'postalcode'}
      ,{10,'phone'}
      ,{11,'fax'}
      ,{12,'latitude'}
      ,{13,'longitude'}
      ,{14,'url'}
      ,{15,'fein'}
      ,{16,'position_type'}
      ,{17,'ultimate_linkid'}
      ,{18,'ultimate_name'}
      ,{19,'loc_date_last_seen'}
      ,{20,'primary_sic'}
      ,{21,'sic_desc'}
      ,{22,'primary_naics'}
      ,{23,'naics_desc'}
      ,{24,'segment_id'}
      ,{25,'segment_desc'}
      ,{26,'year_start'}
      ,{27,'ownership'}
      ,{28,'total_employees'}
      ,{29,'employee_range'}
      ,{30,'total_sales'}
      ,{31,'sales_range'}
      ,{32,'executive_name1'}
      ,{33,'title1'}
      ,{34,'executive_name2'}
      ,{35,'title2'}
      ,{36,'executive_name3'}
      ,{37,'title3'}
      ,{38,'executive_name4'}
      ,{39,'title4'}
      ,{40,'executive_name5'}
      ,{41,'title5'}
      ,{42,'executive_name6'}
      ,{43,'title6'}
      ,{44,'executive_name7'}
      ,{45,'title7'}
      ,{46,'executive_name8'}
      ,{47,'title8'}
      ,{48,'executive_name9'}
      ,{49,'title9'}
      ,{50,'executive_name10'}
      ,{51,'title10'}
      ,{52,'status'}
      ,{53,'is_closed'}
      ,{54,'closed_date'}
      ,{55,'processdate'}
      ,{56,'version'}
      ,{57,'persistent_record_id'}
      ,{58,'dt_first_seen'}
      ,{59,'dt_last_seen'}
      ,{60,'dt_vendor_first_reported'}
      ,{61,'dt_vendor_last_reported'}
      ,{62,'prim_name'}
      ,{63,'p_city_name'}
      ,{64,'v_city_name'}
      ,{65,'executive_name'}
      ,{66,'executive_title'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Executives_Fields.InValid_link_id((SALT311.StrType)le.link_id),
    Executives_Fields.InValid_name((SALT311.StrType)le.name),
    Executives_Fields.InValid_alternate_business_name((SALT311.StrType)le.alternate_business_name),
    Executives_Fields.InValid_address((SALT311.StrType)le.address),
    Executives_Fields.InValid_address2((SALT311.StrType)le.address2),
    Executives_Fields.InValid_city((SALT311.StrType)le.city),
    Executives_Fields.InValid_state((SALT311.StrType)le.state),
    Executives_Fields.InValid_country((SALT311.StrType)le.country),
    Executives_Fields.InValid_postalcode((SALT311.StrType)le.postalcode),
    Executives_Fields.InValid_phone((SALT311.StrType)le.phone),
    Executives_Fields.InValid_fax((SALT311.StrType)le.fax),
    Executives_Fields.InValid_latitude((SALT311.StrType)le.latitude),
    Executives_Fields.InValid_longitude((SALT311.StrType)le.longitude),
    Executives_Fields.InValid_url((SALT311.StrType)le.url),
    Executives_Fields.InValid_fein((SALT311.StrType)le.fein),
    Executives_Fields.InValid_position_type((SALT311.StrType)le.position_type),
    Executives_Fields.InValid_ultimate_linkid((SALT311.StrType)le.ultimate_linkid),
    Executives_Fields.InValid_ultimate_name((SALT311.StrType)le.ultimate_name),
    Executives_Fields.InValid_loc_date_last_seen((SALT311.StrType)le.loc_date_last_seen),
    Executives_Fields.InValid_primary_sic((SALT311.StrType)le.primary_sic),
    Executives_Fields.InValid_sic_desc((SALT311.StrType)le.sic_desc),
    Executives_Fields.InValid_primary_naics((SALT311.StrType)le.primary_naics),
    Executives_Fields.InValid_naics_desc((SALT311.StrType)le.naics_desc),
    Executives_Fields.InValid_segment_id((SALT311.StrType)le.segment_id),
    Executives_Fields.InValid_segment_desc((SALT311.StrType)le.segment_desc),
    Executives_Fields.InValid_year_start((SALT311.StrType)le.year_start),
    Executives_Fields.InValid_ownership((SALT311.StrType)le.ownership),
    Executives_Fields.InValid_total_employees((SALT311.StrType)le.total_employees),
    Executives_Fields.InValid_employee_range((SALT311.StrType)le.employee_range),
    Executives_Fields.InValid_total_sales((SALT311.StrType)le.total_sales),
    Executives_Fields.InValid_sales_range((SALT311.StrType)le.sales_range),
    Executives_Fields.InValid_executive_name1((SALT311.StrType)le.executive_name1),
    Executives_Fields.InValid_title1((SALT311.StrType)le.title1),
    Executives_Fields.InValid_executive_name2((SALT311.StrType)le.executive_name2),
    Executives_Fields.InValid_title2((SALT311.StrType)le.title2),
    Executives_Fields.InValid_executive_name3((SALT311.StrType)le.executive_name3),
    Executives_Fields.InValid_title3((SALT311.StrType)le.title3),
    Executives_Fields.InValid_executive_name4((SALT311.StrType)le.executive_name4),
    Executives_Fields.InValid_title4((SALT311.StrType)le.title4),
    Executives_Fields.InValid_executive_name5((SALT311.StrType)le.executive_name5),
    Executives_Fields.InValid_title5((SALT311.StrType)le.title5),
    Executives_Fields.InValid_executive_name6((SALT311.StrType)le.executive_name6),
    Executives_Fields.InValid_title6((SALT311.StrType)le.title6),
    Executives_Fields.InValid_executive_name7((SALT311.StrType)le.executive_name7),
    Executives_Fields.InValid_title7((SALT311.StrType)le.title7),
    Executives_Fields.InValid_executive_name8((SALT311.StrType)le.executive_name8),
    Executives_Fields.InValid_title8((SALT311.StrType)le.title8),
    Executives_Fields.InValid_executive_name9((SALT311.StrType)le.executive_name9),
    Executives_Fields.InValid_title9((SALT311.StrType)le.title9),
    Executives_Fields.InValid_executive_name10((SALT311.StrType)le.executive_name10),
    Executives_Fields.InValid_title10((SALT311.StrType)le.title10),
    Executives_Fields.InValid_status((SALT311.StrType)le.status),
    Executives_Fields.InValid_is_closed((SALT311.StrType)le.is_closed),
    Executives_Fields.InValid_closed_date((SALT311.StrType)le.closed_date),
    Executives_Fields.InValid_processdate((SALT311.StrType)le.processdate),
    Executives_Fields.InValid_version((SALT311.StrType)le.version),
    Executives_Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id),
    Executives_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Executives_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Executives_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Executives_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Executives_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Executives_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Executives_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Executives_Fields.InValid_executive_name((SALT311.StrType)le.executive_name),
    Executives_Fields.InValid_executive_title((SALT311.StrType)le.executive_title),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,66,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Executives_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Numeric','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_St','Country','Numeric_Optional','Invalid_Phone','Invalid_Phone','Invalid_LatLong','Invalid_LatLong','Unknown','Feintype','CorpHierarchy','Numeric_Optional','Unknown','Invalid_Future_Date','Invalid_Sic','Unknown','Invalid_Naics','Unknown','Unknown','Unknown','Unknown','OwnershipTypes','Unknown','Unknown','Unknown','Unknown','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','StatusTypes','YesNo','Unknown','Invalid_Date','Invalid_Date','Numeric','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Alpha','Alpha','Alpha','Alpha','Alpha');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Executives_Fields.InValidMessage_link_id(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_name(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_alternate_business_name(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_address(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_address2(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_city(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_state(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_country(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_postalcode(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_fax(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_url(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_fein(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_position_type(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_ultimate_linkid(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_ultimate_name(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_loc_date_last_seen(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_primary_sic(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_sic_desc(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_primary_naics(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_naics_desc(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_segment_id(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_segment_desc(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_year_start(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_ownership(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_total_employees(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_employee_range(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_total_sales(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_sales_range(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name1(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_title1(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name2(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_title2(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name3(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_title3(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name4(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_title4(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name5(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_title5(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name6(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_title6(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name7(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_title7(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name8(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_title8(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name9(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_title9(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name10(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_title10(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_status(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_is_closed(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_closed_date(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_processdate(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_version(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_name(TotalErrors.ErrorNum),Executives_Fields.InValidMessage_executive_title(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Cortera, Executives_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
