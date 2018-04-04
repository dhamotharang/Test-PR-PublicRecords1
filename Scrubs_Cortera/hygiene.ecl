IMPORT SALT36;
EXPORT hygiene(dataset(layout_File_Header_In) h) := MODULE

//A simple summary record
EXPORT Summary(SALT36.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_link_id_pcnt := AVE(GROUP,IF(h.link_id = (TYPEOF(h.link_id))'',0,100));
    maxlength_link_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.link_id)));
    avelength_link_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.link_id)),h.link_id<>(typeof(h.link_id))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_postalcode_pcnt := AVE(GROUP,IF(h.postalcode = (TYPEOF(h.postalcode))'',0,100));
    maxlength_postalcode := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.postalcode)));
    avelength_postalcode := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.postalcode)),h.postalcode<>(typeof(h.postalcode))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_fax_pcnt := AVE(GROUP,IF(h.fax = (TYPEOF(h.fax))'',0,100));
    maxlength_fax := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.fax)));
    avelength_fax := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.fax)),h.fax<>(typeof(h.fax))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_fein_pcnt := AVE(GROUP,IF(h.fein = (TYPEOF(h.fein))'',0,100));
    maxlength_fein := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.fein)));
    avelength_fein := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.fein)),h.fein<>(typeof(h.fein))'');
    populated_position_type_pcnt := AVE(GROUP,IF(h.position_type = (TYPEOF(h.position_type))'',0,100));
    maxlength_position_type := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.position_type)));
    avelength_position_type := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.position_type)),h.position_type<>(typeof(h.position_type))'');
    populated_ultimate_linkid_pcnt := AVE(GROUP,IF(h.ultimate_linkid = (TYPEOF(h.ultimate_linkid))'',0,100));
    maxlength_ultimate_linkid := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ultimate_linkid)));
    avelength_ultimate_linkid := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ultimate_linkid)),h.ultimate_linkid<>(typeof(h.ultimate_linkid))'');
    populated_loc_date_last_seen_pcnt := AVE(GROUP,IF(h.loc_date_last_seen = (TYPEOF(h.loc_date_last_seen))'',0,100));
    maxlength_loc_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_date_last_seen)));
    avelength_loc_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.loc_date_last_seen)),h.loc_date_last_seen<>(typeof(h.loc_date_last_seen))'');
    populated_primary_sic_pcnt := AVE(GROUP,IF(h.primary_sic = (TYPEOF(h.primary_sic))'',0,100));
    maxlength_primary_sic := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.primary_sic)));
    avelength_primary_sic := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.primary_sic)),h.primary_sic<>(typeof(h.primary_sic))'');
    populated_sic_desc_pcnt := AVE(GROUP,IF(h.sic_desc = (TYPEOF(h.sic_desc))'',0,100));
    maxlength_sic_desc := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.sic_desc)));
    avelength_sic_desc := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.sic_desc)),h.sic_desc<>(typeof(h.sic_desc))'');
    populated_primary_naics_pcnt := AVE(GROUP,IF(h.primary_naics = (TYPEOF(h.primary_naics))'',0,100));
    maxlength_primary_naics := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.primary_naics)));
    avelength_primary_naics := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.primary_naics)),h.primary_naics<>(typeof(h.primary_naics))'');
    populated_naics_desc_pcnt := AVE(GROUP,IF(h.naics_desc = (TYPEOF(h.naics_desc))'',0,100));
    maxlength_naics_desc := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.naics_desc)));
    avelength_naics_desc := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.naics_desc)),h.naics_desc<>(typeof(h.naics_desc))'');
    populated_segment_id_pcnt := AVE(GROUP,IF(h.segment_id = (TYPEOF(h.segment_id))'',0,100));
    maxlength_segment_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.segment_id)));
    avelength_segment_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.segment_id)),h.segment_id<>(typeof(h.segment_id))'');
    populated_segment_desc_pcnt := AVE(GROUP,IF(h.segment_desc = (TYPEOF(h.segment_desc))'',0,100));
    maxlength_segment_desc := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.segment_desc)));
    avelength_segment_desc := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.segment_desc)),h.segment_desc<>(typeof(h.segment_desc))'');
    populated_year_start_pcnt := AVE(GROUP,IF(h.year_start = (TYPEOF(h.year_start))'',0,100));
    maxlength_year_start := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.year_start)));
    avelength_year_start := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.year_start)),h.year_start<>(typeof(h.year_start))'');
    populated_ownership_pcnt := AVE(GROUP,IF(h.ownership = (TYPEOF(h.ownership))'',0,100));
    maxlength_ownership := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ownership)));
    avelength_ownership := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ownership)),h.ownership<>(typeof(h.ownership))'');
    populated_total_employees_pcnt := AVE(GROUP,IF(h.total_employees = (TYPEOF(h.total_employees))'',0,100));
    maxlength_total_employees := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.total_employees)));
    avelength_total_employees := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.total_employees)),h.total_employees<>(typeof(h.total_employees))'');
    populated_employee_range_pcnt := AVE(GROUP,IF(h.employee_range = (TYPEOF(h.employee_range))'',0,100));
    maxlength_employee_range := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.employee_range)));
    avelength_employee_range := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.employee_range)),h.employee_range<>(typeof(h.employee_range))'');
    populated_total_sales_pcnt := AVE(GROUP,IF(h.total_sales = (TYPEOF(h.total_sales))'',0,100));
    maxlength_total_sales := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.total_sales)));
    avelength_total_sales := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.total_sales)),h.total_sales<>(typeof(h.total_sales))'');
    populated_sales_range_pcnt := AVE(GROUP,IF(h.sales_range = (TYPEOF(h.sales_range))'',0,100));
    maxlength_sales_range := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.sales_range)));
    avelength_sales_range := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.sales_range)),h.sales_range<>(typeof(h.sales_range))'');
    populated_executive_name1_pcnt := AVE(GROUP,IF(h.executive_name1 = (TYPEOF(h.executive_name1))'',0,100));
    maxlength_executive_name1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name1)));
    avelength_executive_name1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name1)),h.executive_name1<>(typeof(h.executive_name1))'');
    populated_title1_pcnt := AVE(GROUP,IF(h.title1 = (TYPEOF(h.title1))'',0,100));
    maxlength_title1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title1)));
    avelength_title1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title1)),h.title1<>(typeof(h.title1))'');
    populated_executive_name2_pcnt := AVE(GROUP,IF(h.executive_name2 = (TYPEOF(h.executive_name2))'',0,100));
    maxlength_executive_name2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name2)));
    avelength_executive_name2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name2)),h.executive_name2<>(typeof(h.executive_name2))'');
    populated_title2_pcnt := AVE(GROUP,IF(h.title2 = (TYPEOF(h.title2))'',0,100));
    maxlength_title2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title2)));
    avelength_title2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title2)),h.title2<>(typeof(h.title2))'');
    populated_executive_name3_pcnt := AVE(GROUP,IF(h.executive_name3 = (TYPEOF(h.executive_name3))'',0,100));
    maxlength_executive_name3 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name3)));
    avelength_executive_name3 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name3)),h.executive_name3<>(typeof(h.executive_name3))'');
    populated_title3_pcnt := AVE(GROUP,IF(h.title3 = (TYPEOF(h.title3))'',0,100));
    maxlength_title3 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title3)));
    avelength_title3 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title3)),h.title3<>(typeof(h.title3))'');
    populated_executive_name4_pcnt := AVE(GROUP,IF(h.executive_name4 = (TYPEOF(h.executive_name4))'',0,100));
    maxlength_executive_name4 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name4)));
    avelength_executive_name4 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name4)),h.executive_name4<>(typeof(h.executive_name4))'');
    populated_title4_pcnt := AVE(GROUP,IF(h.title4 = (TYPEOF(h.title4))'',0,100));
    maxlength_title4 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title4)));
    avelength_title4 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title4)),h.title4<>(typeof(h.title4))'');
    populated_executive_name5_pcnt := AVE(GROUP,IF(h.executive_name5 = (TYPEOF(h.executive_name5))'',0,100));
    maxlength_executive_name5 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name5)));
    avelength_executive_name5 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name5)),h.executive_name5<>(typeof(h.executive_name5))'');
    populated_title5_pcnt := AVE(GROUP,IF(h.title5 = (TYPEOF(h.title5))'',0,100));
    maxlength_title5 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title5)));
    avelength_title5 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title5)),h.title5<>(typeof(h.title5))'');
    populated_executive_name6_pcnt := AVE(GROUP,IF(h.executive_name6 = (TYPEOF(h.executive_name6))'',0,100));
    maxlength_executive_name6 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name6)));
    avelength_executive_name6 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name6)),h.executive_name6<>(typeof(h.executive_name6))'');
    populated_title6_pcnt := AVE(GROUP,IF(h.title6 = (TYPEOF(h.title6))'',0,100));
    maxlength_title6 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title6)));
    avelength_title6 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title6)),h.title6<>(typeof(h.title6))'');
    populated_executive_name7_pcnt := AVE(GROUP,IF(h.executive_name7 = (TYPEOF(h.executive_name7))'',0,100));
    maxlength_executive_name7 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name7)));
    avelength_executive_name7 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name7)),h.executive_name7<>(typeof(h.executive_name7))'');
    populated_title7_pcnt := AVE(GROUP,IF(h.title7 = (TYPEOF(h.title7))'',0,100));
    maxlength_title7 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title7)));
    avelength_title7 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title7)),h.title7<>(typeof(h.title7))'');
    populated_executive_name8_pcnt := AVE(GROUP,IF(h.executive_name8 = (TYPEOF(h.executive_name8))'',0,100));
    maxlength_executive_name8 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name8)));
    avelength_executive_name8 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name8)),h.executive_name8<>(typeof(h.executive_name8))'');
    populated_title8_pcnt := AVE(GROUP,IF(h.title8 = (TYPEOF(h.title8))'',0,100));
    maxlength_title8 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title8)));
    avelength_title8 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title8)),h.title8<>(typeof(h.title8))'');
    populated_executive_name9_pcnt := AVE(GROUP,IF(h.executive_name9 = (TYPEOF(h.executive_name9))'',0,100));
    maxlength_executive_name9 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name9)));
    avelength_executive_name9 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name9)),h.executive_name9<>(typeof(h.executive_name9))'');
    populated_title9_pcnt := AVE(GROUP,IF(h.title9 = (TYPEOF(h.title9))'',0,100));
    maxlength_title9 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title9)));
    avelength_title9 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title9)),h.title9<>(typeof(h.title9))'');
    populated_executive_name10_pcnt := AVE(GROUP,IF(h.executive_name10 = (TYPEOF(h.executive_name10))'',0,100));
    maxlength_executive_name10 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name10)));
    avelength_executive_name10 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.executive_name10)),h.executive_name10<>(typeof(h.executive_name10))'');
    populated_title10_pcnt := AVE(GROUP,IF(h.title10 = (TYPEOF(h.title10))'',0,100));
    maxlength_title10 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title10)));
    avelength_title10 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title10)),h.title10<>(typeof(h.title10))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_is_closed_pcnt := AVE(GROUP,IF(h.is_closed = (TYPEOF(h.is_closed))'',0,100));
    maxlength_is_closed := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.is_closed)));
    avelength_is_closed := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.is_closed)),h.is_closed<>(typeof(h.is_closed))'');
    populated_closed_date_pcnt := AVE(GROUP,IF(h.closed_date = (TYPEOF(h.closed_date))'',0,100));
    maxlength_closed_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.closed_date)));
    avelength_closed_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.closed_date)),h.closed_date<>(typeof(h.closed_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_link_id_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_postalcode_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_fax_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_fein_pcnt *   0.00 / 100 + T.Populated_position_type_pcnt *   0.00 / 100 + T.Populated_ultimate_linkid_pcnt *   0.00 / 100 + T.Populated_loc_date_last_seen_pcnt *   0.00 / 100 + T.Populated_primary_sic_pcnt *   0.00 / 100 + T.Populated_sic_desc_pcnt *   0.00 / 100 + T.Populated_primary_naics_pcnt *   0.00 / 100 + T.Populated_naics_desc_pcnt *   0.00 / 100 + T.Populated_segment_id_pcnt *   0.00 / 100 + T.Populated_segment_desc_pcnt *   0.00 / 100 + T.Populated_year_start_pcnt *   0.00 / 100 + T.Populated_ownership_pcnt *   0.00 / 100 + T.Populated_total_employees_pcnt *   0.00 / 100 + T.Populated_employee_range_pcnt *   0.00 / 100 + T.Populated_total_sales_pcnt *   0.00 / 100 + T.Populated_sales_range_pcnt *   0.00 / 100 + T.Populated_executive_name1_pcnt *   0.00 / 100 + T.Populated_title1_pcnt *   0.00 / 100 + T.Populated_executive_name2_pcnt *   0.00 / 100 + T.Populated_title2_pcnt *   0.00 / 100 + T.Populated_executive_name3_pcnt *   0.00 / 100 + T.Populated_title3_pcnt *   0.00 / 100 + T.Populated_executive_name4_pcnt *   0.00 / 100 + T.Populated_title4_pcnt *   0.00 / 100 + T.Populated_executive_name5_pcnt *   0.00 / 100 + T.Populated_title5_pcnt *   0.00 / 100 + T.Populated_executive_name6_pcnt *   0.00 / 100 + T.Populated_title6_pcnt *   0.00 / 100 + T.Populated_executive_name7_pcnt *   0.00 / 100 + T.Populated_title7_pcnt *   0.00 / 100 + T.Populated_executive_name8_pcnt *   0.00 / 100 + T.Populated_title8_pcnt *   0.00 / 100 + T.Populated_executive_name9_pcnt *   0.00 / 100 + T.Populated_title9_pcnt *   0.00 / 100 + T.Populated_executive_name10_pcnt *   0.00 / 100 + T.Populated_title10_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_is_closed_pcnt *   0.00 / 100 + T.Populated_closed_date_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'link_id','address','address2','city','state','country','postalcode','phone','fax','latitude','longitude','url','fein','position_type','ultimate_linkid','loc_date_last_seen','primary_sic','sic_desc','primary_naics','naics_desc','segment_id','segment_desc','year_start','ownership','total_employees','employee_range','total_sales','sales_range','executive_name1','title1','executive_name2','title2','executive_name3','title3','executive_name4','title4','executive_name5','title5','executive_name6','title6','executive_name7','title7','executive_name8','title8','executive_name9','title9','executive_name10','title10','status','is_closed','closed_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_link_id_pcnt,le.populated_address_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_country_pcnt,le.populated_postalcode_pcnt,le.populated_phone_pcnt,le.populated_fax_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_url_pcnt,le.populated_fein_pcnt,le.populated_position_type_pcnt,le.populated_ultimate_linkid_pcnt,le.populated_loc_date_last_seen_pcnt,le.populated_primary_sic_pcnt,le.populated_sic_desc_pcnt,le.populated_primary_naics_pcnt,le.populated_naics_desc_pcnt,le.populated_segment_id_pcnt,le.populated_segment_desc_pcnt,le.populated_year_start_pcnt,le.populated_ownership_pcnt,le.populated_total_employees_pcnt,le.populated_employee_range_pcnt,le.populated_total_sales_pcnt,le.populated_sales_range_pcnt,le.populated_executive_name1_pcnt,le.populated_title1_pcnt,le.populated_executive_name2_pcnt,le.populated_title2_pcnt,le.populated_executive_name3_pcnt,le.populated_title3_pcnt,le.populated_executive_name4_pcnt,le.populated_title4_pcnt,le.populated_executive_name5_pcnt,le.populated_title5_pcnt,le.populated_executive_name6_pcnt,le.populated_title6_pcnt,le.populated_executive_name7_pcnt,le.populated_title7_pcnt,le.populated_executive_name8_pcnt,le.populated_title8_pcnt,le.populated_executive_name9_pcnt,le.populated_title9_pcnt,le.populated_executive_name10_pcnt,le.populated_title10_pcnt,le.populated_status_pcnt,le.populated_is_closed_pcnt,le.populated_closed_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_link_id,le.maxlength_address,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_country,le.maxlength_postalcode,le.maxlength_phone,le.maxlength_fax,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_url,le.maxlength_fein,le.maxlength_position_type,le.maxlength_ultimate_linkid,le.maxlength_loc_date_last_seen,le.maxlength_primary_sic,le.maxlength_sic_desc,le.maxlength_primary_naics,le.maxlength_naics_desc,le.maxlength_segment_id,le.maxlength_segment_desc,le.maxlength_year_start,le.maxlength_ownership,le.maxlength_total_employees,le.maxlength_employee_range,le.maxlength_total_sales,le.maxlength_sales_range,le.maxlength_executive_name1,le.maxlength_title1,le.maxlength_executive_name2,le.maxlength_title2,le.maxlength_executive_name3,le.maxlength_title3,le.maxlength_executive_name4,le.maxlength_title4,le.maxlength_executive_name5,le.maxlength_title5,le.maxlength_executive_name6,le.maxlength_title6,le.maxlength_executive_name7,le.maxlength_title7,le.maxlength_executive_name8,le.maxlength_title8,le.maxlength_executive_name9,le.maxlength_title9,le.maxlength_executive_name10,le.maxlength_title10,le.maxlength_status,le.maxlength_is_closed,le.maxlength_closed_date);
  SELF.avelength := CHOOSE(C,le.avelength_link_id,le.avelength_address,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_country,le.avelength_postalcode,le.avelength_phone,le.avelength_fax,le.avelength_latitude,le.avelength_longitude,le.avelength_url,le.avelength_fein,le.avelength_position_type,le.avelength_ultimate_linkid,le.avelength_loc_date_last_seen,le.avelength_primary_sic,le.avelength_sic_desc,le.avelength_primary_naics,le.avelength_naics_desc,le.avelength_segment_id,le.avelength_segment_desc,le.avelength_year_start,le.avelength_ownership,le.avelength_total_employees,le.avelength_employee_range,le.avelength_total_sales,le.avelength_sales_range,le.avelength_executive_name1,le.avelength_title1,le.avelength_executive_name2,le.avelength_title2,le.avelength_executive_name3,le.avelength_title3,le.avelength_executive_name4,le.avelength_title4,le.avelength_executive_name5,le.avelength_title5,le.avelength_executive_name6,le.avelength_title6,le.avelength_executive_name7,le.avelength_title7,le.avelength_executive_name8,le.avelength_title8,le.avelength_executive_name9,le.avelength_title9,le.avelength_executive_name10,le.avelength_title10,le.avelength_status,le.avelength_is_closed,le.avelength_closed_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 51, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT36.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT36.StrType)le.link_id),TRIM((SALT36.StrType)le.address),TRIM((SALT36.StrType)le.address2),TRIM((SALT36.StrType)le.city),TRIM((SALT36.StrType)le.state),TRIM((SALT36.StrType)le.country),TRIM((SALT36.StrType)le.postalcode),TRIM((SALT36.StrType)le.phone),TRIM((SALT36.StrType)le.fax),TRIM((SALT36.StrType)le.latitude),TRIM((SALT36.StrType)le.longitude),TRIM((SALT36.StrType)le.url),TRIM((SALT36.StrType)le.fein),TRIM((SALT36.StrType)le.position_type),TRIM((SALT36.StrType)le.ultimate_linkid),TRIM((SALT36.StrType)le.loc_date_last_seen),TRIM((SALT36.StrType)le.primary_sic),TRIM((SALT36.StrType)le.sic_desc),TRIM((SALT36.StrType)le.primary_naics),TRIM((SALT36.StrType)le.naics_desc),TRIM((SALT36.StrType)le.segment_id),TRIM((SALT36.StrType)le.segment_desc),TRIM((SALT36.StrType)le.year_start),TRIM((SALT36.StrType)le.ownership),TRIM((SALT36.StrType)le.total_employees),TRIM((SALT36.StrType)le.employee_range),TRIM((SALT36.StrType)le.total_sales),TRIM((SALT36.StrType)le.sales_range),TRIM((SALT36.StrType)le.executive_name1),TRIM((SALT36.StrType)le.title1),TRIM((SALT36.StrType)le.executive_name2),TRIM((SALT36.StrType)le.title2),TRIM((SALT36.StrType)le.executive_name3),TRIM((SALT36.StrType)le.title3),TRIM((SALT36.StrType)le.executive_name4),TRIM((SALT36.StrType)le.title4),TRIM((SALT36.StrType)le.executive_name5),TRIM((SALT36.StrType)le.title5),TRIM((SALT36.StrType)le.executive_name6),TRIM((SALT36.StrType)le.title6),TRIM((SALT36.StrType)le.executive_name7),TRIM((SALT36.StrType)le.title7),TRIM((SALT36.StrType)le.executive_name8),TRIM((SALT36.StrType)le.title8),TRIM((SALT36.StrType)le.executive_name9),TRIM((SALT36.StrType)le.title9),TRIM((SALT36.StrType)le.executive_name10),TRIM((SALT36.StrType)le.title10),TRIM((SALT36.StrType)le.status),TRIM((SALT36.StrType)le.is_closed),TRIM((SALT36.StrType)le.closed_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,51,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT36.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 51);
  SELF.FldNo2 := 1 + (C % 51);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT36.StrType)le.link_id),TRIM((SALT36.StrType)le.address),TRIM((SALT36.StrType)le.address2),TRIM((SALT36.StrType)le.city),TRIM((SALT36.StrType)le.state),TRIM((SALT36.StrType)le.country),TRIM((SALT36.StrType)le.postalcode),TRIM((SALT36.StrType)le.phone),TRIM((SALT36.StrType)le.fax),TRIM((SALT36.StrType)le.latitude),TRIM((SALT36.StrType)le.longitude),TRIM((SALT36.StrType)le.url),TRIM((SALT36.StrType)le.fein),TRIM((SALT36.StrType)le.position_type),TRIM((SALT36.StrType)le.ultimate_linkid),TRIM((SALT36.StrType)le.loc_date_last_seen),TRIM((SALT36.StrType)le.primary_sic),TRIM((SALT36.StrType)le.sic_desc),TRIM((SALT36.StrType)le.primary_naics),TRIM((SALT36.StrType)le.naics_desc),TRIM((SALT36.StrType)le.segment_id),TRIM((SALT36.StrType)le.segment_desc),TRIM((SALT36.StrType)le.year_start),TRIM((SALT36.StrType)le.ownership),TRIM((SALT36.StrType)le.total_employees),TRIM((SALT36.StrType)le.employee_range),TRIM((SALT36.StrType)le.total_sales),TRIM((SALT36.StrType)le.sales_range),TRIM((SALT36.StrType)le.executive_name1),TRIM((SALT36.StrType)le.title1),TRIM((SALT36.StrType)le.executive_name2),TRIM((SALT36.StrType)le.title2),TRIM((SALT36.StrType)le.executive_name3),TRIM((SALT36.StrType)le.title3),TRIM((SALT36.StrType)le.executive_name4),TRIM((SALT36.StrType)le.title4),TRIM((SALT36.StrType)le.executive_name5),TRIM((SALT36.StrType)le.title5),TRIM((SALT36.StrType)le.executive_name6),TRIM((SALT36.StrType)le.title6),TRIM((SALT36.StrType)le.executive_name7),TRIM((SALT36.StrType)le.title7),TRIM((SALT36.StrType)le.executive_name8),TRIM((SALT36.StrType)le.title8),TRIM((SALT36.StrType)le.executive_name9),TRIM((SALT36.StrType)le.title9),TRIM((SALT36.StrType)le.executive_name10),TRIM((SALT36.StrType)le.title10),TRIM((SALT36.StrType)le.status),TRIM((SALT36.StrType)le.is_closed),TRIM((SALT36.StrType)le.closed_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT36.StrType)le.link_id),TRIM((SALT36.StrType)le.address),TRIM((SALT36.StrType)le.address2),TRIM((SALT36.StrType)le.city),TRIM((SALT36.StrType)le.state),TRIM((SALT36.StrType)le.country),TRIM((SALT36.StrType)le.postalcode),TRIM((SALT36.StrType)le.phone),TRIM((SALT36.StrType)le.fax),TRIM((SALT36.StrType)le.latitude),TRIM((SALT36.StrType)le.longitude),TRIM((SALT36.StrType)le.url),TRIM((SALT36.StrType)le.fein),TRIM((SALT36.StrType)le.position_type),TRIM((SALT36.StrType)le.ultimate_linkid),TRIM((SALT36.StrType)le.loc_date_last_seen),TRIM((SALT36.StrType)le.primary_sic),TRIM((SALT36.StrType)le.sic_desc),TRIM((SALT36.StrType)le.primary_naics),TRIM((SALT36.StrType)le.naics_desc),TRIM((SALT36.StrType)le.segment_id),TRIM((SALT36.StrType)le.segment_desc),TRIM((SALT36.StrType)le.year_start),TRIM((SALT36.StrType)le.ownership),TRIM((SALT36.StrType)le.total_employees),TRIM((SALT36.StrType)le.employee_range),TRIM((SALT36.StrType)le.total_sales),TRIM((SALT36.StrType)le.sales_range),TRIM((SALT36.StrType)le.executive_name1),TRIM((SALT36.StrType)le.title1),TRIM((SALT36.StrType)le.executive_name2),TRIM((SALT36.StrType)le.title2),TRIM((SALT36.StrType)le.executive_name3),TRIM((SALT36.StrType)le.title3),TRIM((SALT36.StrType)le.executive_name4),TRIM((SALT36.StrType)le.title4),TRIM((SALT36.StrType)le.executive_name5),TRIM((SALT36.StrType)le.title5),TRIM((SALT36.StrType)le.executive_name6),TRIM((SALT36.StrType)le.title6),TRIM((SALT36.StrType)le.executive_name7),TRIM((SALT36.StrType)le.title7),TRIM((SALT36.StrType)le.executive_name8),TRIM((SALT36.StrType)le.title8),TRIM((SALT36.StrType)le.executive_name9),TRIM((SALT36.StrType)le.title9),TRIM((SALT36.StrType)le.executive_name10),TRIM((SALT36.StrType)le.title10),TRIM((SALT36.StrType)le.status),TRIM((SALT36.StrType)le.is_closed),TRIM((SALT36.StrType)le.closed_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),51*51,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'link_id'}
      ,{2,'address'}
      ,{3,'address2'}
      ,{4,'city'}
      ,{5,'state'}
      ,{6,'country'}
      ,{7,'postalcode'}
      ,{8,'phone'}
      ,{9,'fax'}
      ,{10,'latitude'}
      ,{11,'longitude'}
      ,{12,'url'}
      ,{13,'fein'}
      ,{14,'position_type'}
      ,{15,'ultimate_linkid'}
      ,{16,'loc_date_last_seen'}
      ,{17,'primary_sic'}
      ,{18,'sic_desc'}
      ,{19,'primary_naics'}
      ,{20,'naics_desc'}
      ,{21,'segment_id'}
      ,{22,'segment_desc'}
      ,{23,'year_start'}
      ,{24,'ownership'}
      ,{25,'total_employees'}
      ,{26,'employee_range'}
      ,{27,'total_sales'}
      ,{28,'sales_range'}
      ,{29,'executive_name1'}
      ,{30,'title1'}
      ,{31,'executive_name2'}
      ,{32,'title2'}
      ,{33,'executive_name3'}
      ,{34,'title3'}
      ,{35,'executive_name4'}
      ,{36,'title4'}
      ,{37,'executive_name5'}
      ,{38,'title5'}
      ,{39,'executive_name6'}
      ,{40,'title6'}
      ,{41,'executive_name7'}
      ,{42,'title7'}
      ,{43,'executive_name8'}
      ,{44,'title8'}
      ,{45,'executive_name9'}
      ,{46,'title9'}
      ,{47,'executive_name10'}
      ,{48,'title10'}
      ,{49,'status'}
      ,{50,'is_closed'}
      ,{51,'closed_date'}],SALT36.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT36.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT36.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT36.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_link_id((SALT36.StrType)le.link_id),
    Fields.InValid_address((SALT36.StrType)le.address),
    Fields.InValid_address2((SALT36.StrType)le.address2),
    Fields.InValid_city((SALT36.StrType)le.city),
    Fields.InValid_state((SALT36.StrType)le.state),
    Fields.InValid_country((SALT36.StrType)le.country),
    Fields.InValid_postalcode((SALT36.StrType)le.postalcode),
    Fields.InValid_phone((SALT36.StrType)le.phone),
    Fields.InValid_fax((SALT36.StrType)le.fax),
    Fields.InValid_latitude((SALT36.StrType)le.latitude),
    Fields.InValid_longitude((SALT36.StrType)le.longitude),
    Fields.InValid_url((SALT36.StrType)le.url),
    Fields.InValid_fein((SALT36.StrType)le.fein),
    Fields.InValid_position_type((SALT36.StrType)le.position_type),
    Fields.InValid_ultimate_linkid((SALT36.StrType)le.ultimate_linkid),
    Fields.InValid_loc_date_last_seen((SALT36.StrType)le.loc_date_last_seen),
    Fields.InValid_primary_sic((SALT36.StrType)le.primary_sic),
    Fields.InValid_sic_desc((SALT36.StrType)le.sic_desc),
    Fields.InValid_primary_naics((SALT36.StrType)le.primary_naics),
    Fields.InValid_naics_desc((SALT36.StrType)le.naics_desc),
    Fields.InValid_segment_id((SALT36.StrType)le.segment_id),
    Fields.InValid_segment_desc((SALT36.StrType)le.segment_desc),
    Fields.InValid_year_start((SALT36.StrType)le.year_start),
    Fields.InValid_ownership((SALT36.StrType)le.ownership),
    Fields.InValid_total_employees((SALT36.StrType)le.total_employees),
    Fields.InValid_employee_range((SALT36.StrType)le.employee_range),
    Fields.InValid_total_sales((SALT36.StrType)le.total_sales),
    Fields.InValid_sales_range((SALT36.StrType)le.sales_range),
    Fields.InValid_executive_name1((SALT36.StrType)le.executive_name1),
    Fields.InValid_title1((SALT36.StrType)le.title1),
    Fields.InValid_executive_name2((SALT36.StrType)le.executive_name2),
    Fields.InValid_title2((SALT36.StrType)le.title2),
    Fields.InValid_executive_name3((SALT36.StrType)le.executive_name3),
    Fields.InValid_title3((SALT36.StrType)le.title3),
    Fields.InValid_executive_name4((SALT36.StrType)le.executive_name4),
    Fields.InValid_title4((SALT36.StrType)le.title4),
    Fields.InValid_executive_name5((SALT36.StrType)le.executive_name5),
    Fields.InValid_title5((SALT36.StrType)le.title5),
    Fields.InValid_executive_name6((SALT36.StrType)le.executive_name6),
    Fields.InValid_title6((SALT36.StrType)le.title6),
    Fields.InValid_executive_name7((SALT36.StrType)le.executive_name7),
    Fields.InValid_title7((SALT36.StrType)le.title7),
    Fields.InValid_executive_name8((SALT36.StrType)le.executive_name8),
    Fields.InValid_title8((SALT36.StrType)le.title8),
    Fields.InValid_executive_name9((SALT36.StrType)le.executive_name9),
    Fields.InValid_title9((SALT36.StrType)le.title9),
    Fields.InValid_executive_name10((SALT36.StrType)le.executive_name10),
    Fields.InValid_title10((SALT36.StrType)le.title10),
    Fields.InValid_status((SALT36.StrType)le.status),
    Fields.InValid_is_closed((SALT36.StrType)le.is_closed),
    Fields.InValid_closed_date((SALT36.StrType)le.closed_date),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,51,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Numeric','Unknown','Unknown','Unknown','Unknown','StateAbrv','Unknown','Unknown','Unknown','LatLong','LatLong','Unknown','feintype','CorpHierarchy','Numeric','Invalid_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','OwnershipTypes','Unknown','Unknown','Unknown','Unknown','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','StatusTypes','YesNo','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_link_id(TotalErrors.ErrorNum),Fields.InValidMessage_address(TotalErrors.ErrorNum),Fields.InValidMessage_address2(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_country(TotalErrors.ErrorNum),Fields.InValidMessage_postalcode(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_fax(TotalErrors.ErrorNum),Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Fields.InValidMessage_url(TotalErrors.ErrorNum),Fields.InValidMessage_fein(TotalErrors.ErrorNum),Fields.InValidMessage_position_type(TotalErrors.ErrorNum),Fields.InValidMessage_ultimate_linkid(TotalErrors.ErrorNum),Fields.InValidMessage_loc_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_primary_sic(TotalErrors.ErrorNum),Fields.InValidMessage_sic_desc(TotalErrors.ErrorNum),Fields.InValidMessage_primary_naics(TotalErrors.ErrorNum),Fields.InValidMessage_naics_desc(TotalErrors.ErrorNum),Fields.InValidMessage_segment_id(TotalErrors.ErrorNum),Fields.InValidMessage_segment_desc(TotalErrors.ErrorNum),Fields.InValidMessage_year_start(TotalErrors.ErrorNum),Fields.InValidMessage_ownership(TotalErrors.ErrorNum),Fields.InValidMessage_total_employees(TotalErrors.ErrorNum),Fields.InValidMessage_employee_range(TotalErrors.ErrorNum),Fields.InValidMessage_total_sales(TotalErrors.ErrorNum),Fields.InValidMessage_sales_range(TotalErrors.ErrorNum),Fields.InValidMessage_executive_name1(TotalErrors.ErrorNum),Fields.InValidMessage_title1(TotalErrors.ErrorNum),Fields.InValidMessage_executive_name2(TotalErrors.ErrorNum),Fields.InValidMessage_title2(TotalErrors.ErrorNum),Fields.InValidMessage_executive_name3(TotalErrors.ErrorNum),Fields.InValidMessage_title3(TotalErrors.ErrorNum),Fields.InValidMessage_executive_name4(TotalErrors.ErrorNum),Fields.InValidMessage_title4(TotalErrors.ErrorNum),Fields.InValidMessage_executive_name5(TotalErrors.ErrorNum),Fields.InValidMessage_title5(TotalErrors.ErrorNum),Fields.InValidMessage_executive_name6(TotalErrors.ErrorNum),Fields.InValidMessage_title6(TotalErrors.ErrorNum),Fields.InValidMessage_executive_name7(TotalErrors.ErrorNum),Fields.InValidMessage_title7(TotalErrors.ErrorNum),Fields.InValidMessage_executive_name8(TotalErrors.ErrorNum),Fields.InValidMessage_title8(TotalErrors.ErrorNum),Fields.InValidMessage_executive_name9(TotalErrors.ErrorNum),Fields.InValidMessage_title9(TotalErrors.ErrorNum),Fields.InValidMessage_executive_name10(TotalErrors.ErrorNum),Fields.InValidMessage_title10(TotalErrors.ErrorNum),Fields.InValidMessage_status(TotalErrors.ErrorNum),Fields.InValidMessage_is_closed(TotalErrors.ErrorNum),Fields.InValidMessage_closed_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
