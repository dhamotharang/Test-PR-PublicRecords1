IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_Targus) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_record_id_pcnt := AVE(GROUP,IF(h.record_id = (TYPEOF(h.record_id))'',0,100));
    maxlength_record_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_id)));
    avelength_record_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_id)),h.record_id<>(typeof(h.record_id))'');
    populated_pubdate_pcnt := AVE(GROUP,IF(h.pubdate = (TYPEOF(h.pubdate))'',0,100));
    maxlength_pubdate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pubdate)));
    avelength_pubdate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pubdate)),h.pubdate<>(typeof(h.pubdate))'');
    populated_filler_pcnt := AVE(GROUP,IF(h.filler = (TYPEOF(h.filler))'',0,100));
    maxlength_filler := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.filler)));
    avelength_filler := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.filler)),h.filler<>(typeof(h.filler))'');
    populated_yppa_code_pcnt := AVE(GROUP,IF(h.yppa_code = (TYPEOF(h.yppa_code))'',0,100));
    maxlength_yppa_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.yppa_code)));
    avelength_yppa_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.yppa_code)),h.yppa_code<>(typeof(h.yppa_code))'');
    populated_book_code_pcnt := AVE(GROUP,IF(h.book_code = (TYPEOF(h.book_code))'',0,100));
    maxlength_book_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.book_code)));
    avelength_book_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.book_code)),h.book_code<>(typeof(h.book_code))'');
    populated_page_number_pcnt := AVE(GROUP,IF(h.page_number = (TYPEOF(h.page_number))'',0,100));
    maxlength_page_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.page_number)));
    avelength_page_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.page_number)),h.page_number<>(typeof(h.page_number))'');
    populated_record_number_pcnt := AVE(GROUP,IF(h.record_number = (TYPEOF(h.record_number))'',0,100));
    maxlength_record_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_number)));
    avelength_record_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_number)),h.record_number<>(typeof(h.record_number))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_no_solicitation_code_pcnt := AVE(GROUP,IF(h.no_solicitation_code = (TYPEOF(h.no_solicitation_code))'',0,100));
    maxlength_no_solicitation_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.no_solicitation_code)));
    avelength_no_solicitation_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.no_solicitation_code)),h.no_solicitation_code<>(typeof(h.no_solicitation_code))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_last_name_suffix_pcnt := AVE(GROUP,IF(h.last_name_suffix = (TYPEOF(h.last_name_suffix))'',0,100));
    maxlength_last_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.last_name_suffix)));
    avelength_last_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.last_name_suffix)),h.last_name_suffix<>(typeof(h.last_name_suffix))'');
    populated_job_title_pcnt := AVE(GROUP,IF(h.job_title = (TYPEOF(h.job_title))'',0,100));
    maxlength_job_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.job_title)));
    avelength_job_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.job_title)),h.job_title<>(typeof(h.job_title))'');
    populated_secondary_name_title_pcnt := AVE(GROUP,IF(h.secondary_name_title = (TYPEOF(h.secondary_name_title))'',0,100));
    maxlength_secondary_name_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_name_title)));
    avelength_secondary_name_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_name_title)),h.secondary_name_title<>(typeof(h.secondary_name_title))'');
    populated_secondary_first_name_pcnt := AVE(GROUP,IF(h.secondary_first_name = (TYPEOF(h.secondary_first_name))'',0,100));
    maxlength_secondary_first_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_first_name)));
    avelength_secondary_first_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_first_name)),h.secondary_first_name<>(typeof(h.secondary_first_name))'');
    populated_secondary_middle_name_pcnt := AVE(GROUP,IF(h.secondary_middle_name = (TYPEOF(h.secondary_middle_name))'',0,100));
    maxlength_secondary_middle_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_middle_name)));
    avelength_secondary_middle_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_middle_name)),h.secondary_middle_name<>(typeof(h.secondary_middle_name))'');
    populated_secondary_name_suffix_pcnt := AVE(GROUP,IF(h.secondary_name_suffix = (TYPEOF(h.secondary_name_suffix))'',0,100));
    maxlength_secondary_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_name_suffix)));
    avelength_secondary_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.secondary_name_suffix)),h.secondary_name_suffix<>(typeof(h.secondary_name_suffix))'');
    populated_house_number_pcnt := AVE(GROUP,IF(h.house_number = (TYPEOF(h.house_number))'',0,100));
    maxlength_house_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.house_number)));
    avelength_house_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.house_number)),h.house_number<>(typeof(h.house_number))'');
    populated_pre_direction_pcnt := AVE(GROUP,IF(h.pre_direction = (TYPEOF(h.pre_direction))'',0,100));
    maxlength_pre_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pre_direction)));
    avelength_pre_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pre_direction)),h.pre_direction<>(typeof(h.pre_direction))'');
    populated_street_name_pcnt := AVE(GROUP,IF(h.street_name = (TYPEOF(h.street_name))'',0,100));
    maxlength_street_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_name)));
    avelength_street_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_name)),h.street_name<>(typeof(h.street_name))'');
    populated_street_type_pcnt := AVE(GROUP,IF(h.street_type = (TYPEOF(h.street_type))'',0,100));
    maxlength_street_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_type)));
    avelength_street_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_type)),h.street_type<>(typeof(h.street_type))'');
    populated_post_direction_pcnt := AVE(GROUP,IF(h.post_direction = (TYPEOF(h.post_direction))'',0,100));
    maxlength_post_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.post_direction)));
    avelength_post_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.post_direction)),h.post_direction<>(typeof(h.post_direction))'');
    populated_apt_type_pcnt := AVE(GROUP,IF(h.apt_type = (TYPEOF(h.apt_type))'',0,100));
    maxlength_apt_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.apt_type)));
    avelength_apt_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.apt_type)),h.apt_type<>(typeof(h.apt_type))'');
    populated_apt_number_pcnt := AVE(GROUP,IF(h.apt_number = (TYPEOF(h.apt_number))'',0,100));
    maxlength_apt_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.apt_number)));
    avelength_apt_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.apt_number)),h.apt_number<>(typeof(h.apt_number))'');
    populated_box_number_pcnt := AVE(GROUP,IF(h.box_number = (TYPEOF(h.box_number))'',0,100));
    maxlength_box_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.box_number)));
    avelength_box_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.box_number)),h.box_number<>(typeof(h.box_number))'');
    populated_expanded_pub_city_name_pcnt := AVE(GROUP,IF(h.expanded_pub_city_name = (TYPEOF(h.expanded_pub_city_name))'',0,100));
    maxlength_expanded_pub_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.expanded_pub_city_name)));
    avelength_expanded_pub_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.expanded_pub_city_name)),h.expanded_pub_city_name<>(typeof(h.expanded_pub_city_name))'');
    populated_postal_city_name_pcnt := AVE(GROUP,IF(h.postal_city_name = (TYPEOF(h.postal_city_name))'',0,100));
    maxlength_postal_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.postal_city_name)));
    avelength_postal_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.postal_city_name)),h.postal_city_name<>(typeof(h.postal_city_name))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_z5_pcnt := AVE(GROUP,IF(h.z5 = (TYPEOF(h.z5))'',0,100));
    maxlength_z5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.z5)));
    avelength_z5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.z5)),h.z5<>(typeof(h.z5))'');
    populated_plus4_pcnt := AVE(GROUP,IF(h.plus4 = (TYPEOF(h.plus4))'',0,100));
    maxlength_plus4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.plus4)));
    avelength_plus4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.plus4)),h.plus4<>(typeof(h.plus4))'');
    populated_delivery_point_code_pcnt := AVE(GROUP,IF(h.delivery_point_code = (TYPEOF(h.delivery_point_code))'',0,100));
    maxlength_delivery_point_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.delivery_point_code)));
    avelength_delivery_point_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.delivery_point_code)),h.delivery_point_code<>(typeof(h.delivery_point_code))'');
    populated_carrier_route_pcnt := AVE(GROUP,IF(h.carrier_route = (TYPEOF(h.carrier_route))'',0,100));
    maxlength_carrier_route := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.carrier_route)));
    avelength_carrier_route := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.carrier_route)),h.carrier_route<>(typeof(h.carrier_route))'');
    populated_county_code__pcnt := AVE(GROUP,IF(h.county_code_ = (TYPEOF(h.county_code_))'',0,100));
    maxlength_county_code_ := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_code_)));
    avelength_county_code_ := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_code_)),h.county_code_<>(typeof(h.county_code_))'');
    populated_gnrl_address_return_code_pcnt := AVE(GROUP,IF(h.gnrl_address_return_code = (TYPEOF(h.gnrl_address_return_code))'',0,100));
    maxlength_gnrl_address_return_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.gnrl_address_return_code)));
    avelength_gnrl_address_return_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.gnrl_address_return_code)),h.gnrl_address_return_code<>(typeof(h.gnrl_address_return_code))'');
    populated_house_number_usage_flag_pcnt := AVE(GROUP,IF(h.house_number_usage_flag = (TYPEOF(h.house_number_usage_flag))'',0,100));
    maxlength_house_number_usage_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.house_number_usage_flag)));
    avelength_house_number_usage_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.house_number_usage_flag)),h.house_number_usage_flag<>(typeof(h.house_number_usage_flag))'');
    populated_pre_direction_usage_flag_pcnt := AVE(GROUP,IF(h.pre_direction_usage_flag = (TYPEOF(h.pre_direction_usage_flag))'',0,100));
    maxlength_pre_direction_usage_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pre_direction_usage_flag)));
    avelength_pre_direction_usage_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pre_direction_usage_flag)),h.pre_direction_usage_flag<>(typeof(h.pre_direction_usage_flag))'');
    populated_street_name_usage_flag_pcnt := AVE(GROUP,IF(h.street_name_usage_flag = (TYPEOF(h.street_name_usage_flag))'',0,100));
    maxlength_street_name_usage_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_name_usage_flag)));
    avelength_street_name_usage_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_name_usage_flag)),h.street_name_usage_flag<>(typeof(h.street_name_usage_flag))'');
    populated_street_type_usage_flag_pcnt := AVE(GROUP,IF(h.street_type_usage_flag = (TYPEOF(h.street_type_usage_flag))'',0,100));
    maxlength_street_type_usage_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_type_usage_flag)));
    avelength_street_type_usage_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_type_usage_flag)),h.street_type_usage_flag<>(typeof(h.street_type_usage_flag))'');
    populated_post_direction_usage_flag_pcnt := AVE(GROUP,IF(h.post_direction_usage_flag = (TYPEOF(h.post_direction_usage_flag))'',0,100));
    maxlength_post_direction_usage_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.post_direction_usage_flag)));
    avelength_post_direction_usage_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.post_direction_usage_flag)),h.post_direction_usage_flag<>(typeof(h.post_direction_usage_flag))'');
    populated_apt_number_usage_flag_pcnt := AVE(GROUP,IF(h.apt_number_usage_flag = (TYPEOF(h.apt_number_usage_flag))'',0,100));
    maxlength_apt_number_usage_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.apt_number_usage_flag)));
    avelength_apt_number_usage_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.apt_number_usage_flag)),h.apt_number_usage_flag<>(typeof(h.apt_number_usage_flag))'');
    populated_validation_date_pcnt := AVE(GROUP,IF(h.validation_date = (TYPEOF(h.validation_date))'',0,100));
    maxlength_validation_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.validation_date)));
    avelength_validation_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.validation_date)),h.validation_date<>(typeof(h.validation_date))'');
    populated_validation_flag_pcnt := AVE(GROUP,IF(h.validation_flag = (TYPEOF(h.validation_flag))'',0,100));
    maxlength_validation_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.validation_flag)));
    avelength_validation_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.validation_flag)),h.validation_flag<>(typeof(h.validation_flag))'');
    populated_filler1_pcnt := AVE(GROUP,IF(h.filler1 = (TYPEOF(h.filler1))'',0,100));
    maxlength_filler1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.filler1)));
    avelength_filler1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.filler1)),h.filler1<>(typeof(h.filler1))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_hhid_pcnt := AVE(GROUP,IF(h.hhid = (TYPEOF(h.hhid))'',0,100));
    maxlength_hhid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hhid)));
    avelength_hhid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hhid)),h.hhid<>(typeof(h.hhid))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_minit_pcnt := AVE(GROUP,IF(h.minit = (TYPEOF(h.minit))'',0,100));
    maxlength_minit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.minit)));
    avelength_minit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.minit)),h.minit<>(typeof(h.minit))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_city_name_pcnt := AVE(GROUP,IF(h.city_name = (TYPEOF(h.city_name))'',0,100));
    maxlength_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.city_name)));
    avelength_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.city_name)),h.city_name<>(typeof(h.city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_cbsa_pcnt := AVE(GROUP,IF(h.cbsa = (TYPEOF(h.cbsa))'',0,100));
    maxlength_cbsa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cbsa)));
    avelength_cbsa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cbsa)),h.cbsa<>(typeof(h.cbsa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_cleanname_pcnt := AVE(GROUP,IF(h.cleanname = (TYPEOF(h.cleanname))'',0,100));
    maxlength_cleanname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cleanname)));
    avelength_cleanname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cleanname)),h.cleanname<>(typeof(h.cleanname))'');
    populated_cleanaddress_pcnt := AVE(GROUP,IF(h.cleanaddress = (TYPEOF(h.cleanaddress))'',0,100));
    maxlength_cleanaddress := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cleanaddress)));
    avelength_cleanaddress := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cleanaddress)),h.cleanaddress<>(typeof(h.cleanaddress))'');
    populated_active_pcnt := AVE(GROUP,IF(h.active = (TYPEOF(h.active))'',0,100));
    maxlength_active := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.active)));
    avelength_active := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.active)),h.active<>(typeof(h.active))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_record_id_pcnt *   0.00 / 100 + T.Populated_pubdate_pcnt *   0.00 / 100 + T.Populated_filler_pcnt *   0.00 / 100 + T.Populated_yppa_code_pcnt *   0.00 / 100 + T.Populated_book_code_pcnt *   0.00 / 100 + T.Populated_page_number_pcnt *   0.00 / 100 + T.Populated_record_number_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_no_solicitation_code_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_last_name_suffix_pcnt *   0.00 / 100 + T.Populated_job_title_pcnt *   0.00 / 100 + T.Populated_secondary_name_title_pcnt *   0.00 / 100 + T.Populated_secondary_first_name_pcnt *   0.00 / 100 + T.Populated_secondary_middle_name_pcnt *   0.00 / 100 + T.Populated_secondary_name_suffix_pcnt *   0.00 / 100 + T.Populated_house_number_pcnt *   0.00 / 100 + T.Populated_pre_direction_pcnt *   0.00 / 100 + T.Populated_street_name_pcnt *   0.00 / 100 + T.Populated_street_type_pcnt *   0.00 / 100 + T.Populated_post_direction_pcnt *   0.00 / 100 + T.Populated_apt_type_pcnt *   0.00 / 100 + T.Populated_apt_number_pcnt *   0.00 / 100 + T.Populated_box_number_pcnt *   0.00 / 100 + T.Populated_expanded_pub_city_name_pcnt *   0.00 / 100 + T.Populated_postal_city_name_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_z5_pcnt *   0.00 / 100 + T.Populated_plus4_pcnt *   0.00 / 100 + T.Populated_delivery_point_code_pcnt *   0.00 / 100 + T.Populated_carrier_route_pcnt *   0.00 / 100 + T.Populated_county_code__pcnt *   0.00 / 100 + T.Populated_gnrl_address_return_code_pcnt *   0.00 / 100 + T.Populated_house_number_usage_flag_pcnt *   0.00 / 100 + T.Populated_pre_direction_usage_flag_pcnt *   0.00 / 100 + T.Populated_street_name_usage_flag_pcnt *   0.00 / 100 + T.Populated_street_type_usage_flag_pcnt *   0.00 / 100 + T.Populated_post_direction_usage_flag_pcnt *   0.00 / 100 + T.Populated_apt_number_usage_flag_pcnt *   0.00 / 100 + T.Populated_validation_date_pcnt *   0.00 / 100 + T.Populated_validation_flag_pcnt *   0.00 / 100 + T.Populated_filler1_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_hhid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_minit_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_cbsa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_cleanname_pcnt *   0.00 / 100 + T.Populated_cleanaddress_pcnt *   0.00 / 100 + T.Populated_active_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'record_id','pubdate','filler','yppa_code','book_code','page_number','record_number','phone_number','phone_type','record_type','no_solicitation_code','title','first_name','middle_name','last_name','last_name_suffix','job_title','secondary_name_title','secondary_first_name','secondary_middle_name','secondary_name_suffix','house_number','pre_direction','street_name','street_type','post_direction','apt_type','apt_number','box_number','expanded_pub_city_name','postal_city_name','state','z5','plus4','delivery_point_code','carrier_route','county_code_','gnrl_address_return_code','house_number_usage_flag','pre_direction_usage_flag','street_name_usage_flag','street_type_usage_flag','post_direction_usage_flag','apt_number_usage_flag','validation_date','validation_flag','filler1','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','rec_type','hhid','did','did_score','fname','minit','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','county','cbsa','geo_blk','cleanname','cleanaddress','active');
  SELF.populated_pcnt := CHOOSE(C,le.populated_record_id_pcnt,le.populated_pubdate_pcnt,le.populated_filler_pcnt,le.populated_yppa_code_pcnt,le.populated_book_code_pcnt,le.populated_page_number_pcnt,le.populated_record_number_pcnt,le.populated_phone_number_pcnt,le.populated_phone_type_pcnt,le.populated_record_type_pcnt,le.populated_no_solicitation_code_pcnt,le.populated_title_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_last_name_pcnt,le.populated_last_name_suffix_pcnt,le.populated_job_title_pcnt,le.populated_secondary_name_title_pcnt,le.populated_secondary_first_name_pcnt,le.populated_secondary_middle_name_pcnt,le.populated_secondary_name_suffix_pcnt,le.populated_house_number_pcnt,le.populated_pre_direction_pcnt,le.populated_street_name_pcnt,le.populated_street_type_pcnt,le.populated_post_direction_pcnt,le.populated_apt_type_pcnt,le.populated_apt_number_pcnt,le.populated_box_number_pcnt,le.populated_expanded_pub_city_name_pcnt,le.populated_postal_city_name_pcnt,le.populated_state_pcnt,le.populated_z5_pcnt,le.populated_plus4_pcnt,le.populated_delivery_point_code_pcnt,le.populated_carrier_route_pcnt,le.populated_county_code__pcnt,le.populated_gnrl_address_return_code_pcnt,le.populated_house_number_usage_flag_pcnt,le.populated_pre_direction_usage_flag_pcnt,le.populated_street_name_usage_flag_pcnt,le.populated_street_type_usage_flag_pcnt,le.populated_post_direction_usage_flag_pcnt,le.populated_apt_number_usage_flag_pcnt,le.populated_validation_date_pcnt,le.populated_validation_flag_pcnt,le.populated_filler1_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_rec_type_pcnt,le.populated_hhid_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_fname_pcnt,le.populated_minit_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_county_pcnt,le.populated_cbsa_pcnt,le.populated_geo_blk_pcnt,le.populated_cleanname_pcnt,le.populated_cleanaddress_pcnt,le.populated_active_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_record_id,le.maxlength_pubdate,le.maxlength_filler,le.maxlength_yppa_code,le.maxlength_book_code,le.maxlength_page_number,le.maxlength_record_number,le.maxlength_phone_number,le.maxlength_phone_type,le.maxlength_record_type,le.maxlength_no_solicitation_code,le.maxlength_title,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_last_name,le.maxlength_last_name_suffix,le.maxlength_job_title,le.maxlength_secondary_name_title,le.maxlength_secondary_first_name,le.maxlength_secondary_middle_name,le.maxlength_secondary_name_suffix,le.maxlength_house_number,le.maxlength_pre_direction,le.maxlength_street_name,le.maxlength_street_type,le.maxlength_post_direction,le.maxlength_apt_type,le.maxlength_apt_number,le.maxlength_box_number,le.maxlength_expanded_pub_city_name,le.maxlength_postal_city_name,le.maxlength_state,le.maxlength_z5,le.maxlength_plus4,le.maxlength_delivery_point_code,le.maxlength_carrier_route,le.maxlength_county_code_,le.maxlength_gnrl_address_return_code,le.maxlength_house_number_usage_flag,le.maxlength_pre_direction_usage_flag,le.maxlength_street_name_usage_flag,le.maxlength_street_type_usage_flag,le.maxlength_post_direction_usage_flag,le.maxlength_apt_number_usage_flag,le.maxlength_validation_date,le.maxlength_validation_flag,le.maxlength_filler1,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_vendor_first_reported,le.maxlength_rec_type,le.maxlength_hhid,le.maxlength_did,le.maxlength_did_score,le.maxlength_fname,le.maxlength_minit,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_county,le.maxlength_cbsa,le.maxlength_geo_blk,le.maxlength_cleanname,le.maxlength_cleanaddress,le.maxlength_active);
  SELF.avelength := CHOOSE(C,le.avelength_record_id,le.avelength_pubdate,le.avelength_filler,le.avelength_yppa_code,le.avelength_book_code,le.avelength_page_number,le.avelength_record_number,le.avelength_phone_number,le.avelength_phone_type,le.avelength_record_type,le.avelength_no_solicitation_code,le.avelength_title,le.avelength_first_name,le.avelength_middle_name,le.avelength_last_name,le.avelength_last_name_suffix,le.avelength_job_title,le.avelength_secondary_name_title,le.avelength_secondary_first_name,le.avelength_secondary_middle_name,le.avelength_secondary_name_suffix,le.avelength_house_number,le.avelength_pre_direction,le.avelength_street_name,le.avelength_street_type,le.avelength_post_direction,le.avelength_apt_type,le.avelength_apt_number,le.avelength_box_number,le.avelength_expanded_pub_city_name,le.avelength_postal_city_name,le.avelength_state,le.avelength_z5,le.avelength_plus4,le.avelength_delivery_point_code,le.avelength_carrier_route,le.avelength_county_code_,le.avelength_gnrl_address_return_code,le.avelength_house_number_usage_flag,le.avelength_pre_direction_usage_flag,le.avelength_street_name_usage_flag,le.avelength_street_type_usage_flag,le.avelength_post_direction_usage_flag,le.avelength_apt_number_usage_flag,le.avelength_validation_date,le.avelength_validation_flag,le.avelength_filler1,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_last_reported,le.avelength_dt_vendor_first_reported,le.avelength_rec_type,le.avelength_hhid,le.avelength_did,le.avelength_did_score,le.avelength_fname,le.avelength_minit,le.avelength_lname,le.avelength_name_suffix,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_county,le.avelength_cbsa,le.avelength_geo_blk,le.avelength_cleanname,le.avelength_cleanaddress,le.avelength_active);
END;
EXPORT invSummary := NORMALIZE(summary0, 76, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.record_id),TRIM((SALT30.StrType)le.pubdate),TRIM((SALT30.StrType)le.filler),TRIM((SALT30.StrType)le.yppa_code),TRIM((SALT30.StrType)le.book_code),TRIM((SALT30.StrType)le.page_number),TRIM((SALT30.StrType)le.record_number),TRIM((SALT30.StrType)le.phone_number),TRIM((SALT30.StrType)le.phone_type),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.no_solicitation_code),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.first_name),TRIM((SALT30.StrType)le.middle_name),TRIM((SALT30.StrType)le.last_name),TRIM((SALT30.StrType)le.last_name_suffix),TRIM((SALT30.StrType)le.job_title),TRIM((SALT30.StrType)le.secondary_name_title),TRIM((SALT30.StrType)le.secondary_first_name),TRIM((SALT30.StrType)le.secondary_middle_name),TRIM((SALT30.StrType)le.secondary_name_suffix),TRIM((SALT30.StrType)le.house_number),TRIM((SALT30.StrType)le.pre_direction),TRIM((SALT30.StrType)le.street_name),TRIM((SALT30.StrType)le.street_type),TRIM((SALT30.StrType)le.post_direction),TRIM((SALT30.StrType)le.apt_type),TRIM((SALT30.StrType)le.apt_number),TRIM((SALT30.StrType)le.box_number),TRIM((SALT30.StrType)le.expanded_pub_city_name),TRIM((SALT30.StrType)le.postal_city_name),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.z5),TRIM((SALT30.StrType)le.plus4),TRIM((SALT30.StrType)le.delivery_point_code),TRIM((SALT30.StrType)le.carrier_route),TRIM((SALT30.StrType)le.county_code_),TRIM((SALT30.StrType)le.gnrl_address_return_code),TRIM((SALT30.StrType)le.house_number_usage_flag),TRIM((SALT30.StrType)le.pre_direction_usage_flag),TRIM((SALT30.StrType)le.street_name_usage_flag),TRIM((SALT30.StrType)le.street_type_usage_flag),TRIM((SALT30.StrType)le.post_direction_usage_flag),TRIM((SALT30.StrType)le.apt_number_usage_flag),TRIM((SALT30.StrType)le.validation_date),TRIM((SALT30.StrType)le.validation_flag),TRIM((SALT30.StrType)le.filler1),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.hhid),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.minit),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.cbsa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.cleanname),TRIM((SALT30.StrType)le.cleanaddress),TRIM((SALT30.StrType)le.active)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,76,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 76);
  SELF.FldNo2 := 1 + (C % 76);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.record_id),TRIM((SALT30.StrType)le.pubdate),TRIM((SALT30.StrType)le.filler),TRIM((SALT30.StrType)le.yppa_code),TRIM((SALT30.StrType)le.book_code),TRIM((SALT30.StrType)le.page_number),TRIM((SALT30.StrType)le.record_number),TRIM((SALT30.StrType)le.phone_number),TRIM((SALT30.StrType)le.phone_type),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.no_solicitation_code),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.first_name),TRIM((SALT30.StrType)le.middle_name),TRIM((SALT30.StrType)le.last_name),TRIM((SALT30.StrType)le.last_name_suffix),TRIM((SALT30.StrType)le.job_title),TRIM((SALT30.StrType)le.secondary_name_title),TRIM((SALT30.StrType)le.secondary_first_name),TRIM((SALT30.StrType)le.secondary_middle_name),TRIM((SALT30.StrType)le.secondary_name_suffix),TRIM((SALT30.StrType)le.house_number),TRIM((SALT30.StrType)le.pre_direction),TRIM((SALT30.StrType)le.street_name),TRIM((SALT30.StrType)le.street_type),TRIM((SALT30.StrType)le.post_direction),TRIM((SALT30.StrType)le.apt_type),TRIM((SALT30.StrType)le.apt_number),TRIM((SALT30.StrType)le.box_number),TRIM((SALT30.StrType)le.expanded_pub_city_name),TRIM((SALT30.StrType)le.postal_city_name),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.z5),TRIM((SALT30.StrType)le.plus4),TRIM((SALT30.StrType)le.delivery_point_code),TRIM((SALT30.StrType)le.carrier_route),TRIM((SALT30.StrType)le.county_code_),TRIM((SALT30.StrType)le.gnrl_address_return_code),TRIM((SALT30.StrType)le.house_number_usage_flag),TRIM((SALT30.StrType)le.pre_direction_usage_flag),TRIM((SALT30.StrType)le.street_name_usage_flag),TRIM((SALT30.StrType)le.street_type_usage_flag),TRIM((SALT30.StrType)le.post_direction_usage_flag),TRIM((SALT30.StrType)le.apt_number_usage_flag),TRIM((SALT30.StrType)le.validation_date),TRIM((SALT30.StrType)le.validation_flag),TRIM((SALT30.StrType)le.filler1),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.hhid),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.minit),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.cbsa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.cleanname),TRIM((SALT30.StrType)le.cleanaddress),TRIM((SALT30.StrType)le.active)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.record_id),TRIM((SALT30.StrType)le.pubdate),TRIM((SALT30.StrType)le.filler),TRIM((SALT30.StrType)le.yppa_code),TRIM((SALT30.StrType)le.book_code),TRIM((SALT30.StrType)le.page_number),TRIM((SALT30.StrType)le.record_number),TRIM((SALT30.StrType)le.phone_number),TRIM((SALT30.StrType)le.phone_type),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.no_solicitation_code),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.first_name),TRIM((SALT30.StrType)le.middle_name),TRIM((SALT30.StrType)le.last_name),TRIM((SALT30.StrType)le.last_name_suffix),TRIM((SALT30.StrType)le.job_title),TRIM((SALT30.StrType)le.secondary_name_title),TRIM((SALT30.StrType)le.secondary_first_name),TRIM((SALT30.StrType)le.secondary_middle_name),TRIM((SALT30.StrType)le.secondary_name_suffix),TRIM((SALT30.StrType)le.house_number),TRIM((SALT30.StrType)le.pre_direction),TRIM((SALT30.StrType)le.street_name),TRIM((SALT30.StrType)le.street_type),TRIM((SALT30.StrType)le.post_direction),TRIM((SALT30.StrType)le.apt_type),TRIM((SALT30.StrType)le.apt_number),TRIM((SALT30.StrType)le.box_number),TRIM((SALT30.StrType)le.expanded_pub_city_name),TRIM((SALT30.StrType)le.postal_city_name),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.z5),TRIM((SALT30.StrType)le.plus4),TRIM((SALT30.StrType)le.delivery_point_code),TRIM((SALT30.StrType)le.carrier_route),TRIM((SALT30.StrType)le.county_code_),TRIM((SALT30.StrType)le.gnrl_address_return_code),TRIM((SALT30.StrType)le.house_number_usage_flag),TRIM((SALT30.StrType)le.pre_direction_usage_flag),TRIM((SALT30.StrType)le.street_name_usage_flag),TRIM((SALT30.StrType)le.street_type_usage_flag),TRIM((SALT30.StrType)le.post_direction_usage_flag),TRIM((SALT30.StrType)le.apt_number_usage_flag),TRIM((SALT30.StrType)le.validation_date),TRIM((SALT30.StrType)le.validation_flag),TRIM((SALT30.StrType)le.filler1),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.hhid),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.minit),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.cbsa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.cleanname),TRIM((SALT30.StrType)le.cleanaddress),TRIM((SALT30.StrType)le.active)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),76*76,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'record_id'}
      ,{2,'pubdate'}
      ,{3,'filler'}
      ,{4,'yppa_code'}
      ,{5,'book_code'}
      ,{6,'page_number'}
      ,{7,'record_number'}
      ,{8,'phone_number'}
      ,{9,'phone_type'}
      ,{10,'record_type'}
      ,{11,'no_solicitation_code'}
      ,{12,'title'}
      ,{13,'first_name'}
      ,{14,'middle_name'}
      ,{15,'last_name'}
      ,{16,'last_name_suffix'}
      ,{17,'job_title'}
      ,{18,'secondary_name_title'}
      ,{19,'secondary_first_name'}
      ,{20,'secondary_middle_name'}
      ,{21,'secondary_name_suffix'}
      ,{22,'house_number'}
      ,{23,'pre_direction'}
      ,{24,'street_name'}
      ,{25,'street_type'}
      ,{26,'post_direction'}
      ,{27,'apt_type'}
      ,{28,'apt_number'}
      ,{29,'box_number'}
      ,{30,'expanded_pub_city_name'}
      ,{31,'postal_city_name'}
      ,{32,'state'}
      ,{33,'z5'}
      ,{34,'plus4'}
      ,{35,'delivery_point_code'}
      ,{36,'carrier_route'}
      ,{37,'county_code_'}
      ,{38,'gnrl_address_return_code'}
      ,{39,'house_number_usage_flag'}
      ,{40,'pre_direction_usage_flag'}
      ,{41,'street_name_usage_flag'}
      ,{42,'street_type_usage_flag'}
      ,{43,'post_direction_usage_flag'}
      ,{44,'apt_number_usage_flag'}
      ,{45,'validation_date'}
      ,{46,'validation_flag'}
      ,{47,'filler1'}
      ,{48,'dt_first_seen'}
      ,{49,'dt_last_seen'}
      ,{50,'dt_vendor_last_reported'}
      ,{51,'dt_vendor_first_reported'}
      ,{52,'rec_type'}
      ,{53,'hhid'}
      ,{54,'did'}
      ,{55,'did_score'}
      ,{56,'fname'}
      ,{57,'minit'}
      ,{58,'lname'}
      ,{59,'name_suffix'}
      ,{60,'prim_range'}
      ,{61,'predir'}
      ,{62,'prim_name'}
      ,{63,'suffix'}
      ,{64,'postdir'}
      ,{65,'unit_desig'}
      ,{66,'sec_range'}
      ,{67,'city_name'}
      ,{68,'st'}
      ,{69,'zip'}
      ,{70,'zip4'}
      ,{71,'county'}
      ,{72,'cbsa'}
      ,{73,'geo_blk'}
      ,{74,'cleanname'}
      ,{75,'cleanaddress'}
      ,{76,'active'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_record_id((SALT30.StrType)le.record_id),
    Fields.InValid_pubdate((SALT30.StrType)le.pubdate),
    Fields.InValid_filler((SALT30.StrType)le.filler),
    Fields.InValid_yppa_code((SALT30.StrType)le.yppa_code),
    Fields.InValid_book_code((SALT30.StrType)le.book_code),
    Fields.InValid_page_number((SALT30.StrType)le.page_number),
    Fields.InValid_record_number((SALT30.StrType)le.record_number),
    Fields.InValid_phone_number((SALT30.StrType)le.phone_number),
    Fields.InValid_phone_type((SALT30.StrType)le.phone_type),
    Fields.InValid_record_type((SALT30.StrType)le.record_type),
    Fields.InValid_no_solicitation_code((SALT30.StrType)le.no_solicitation_code),
    Fields.InValid_title((SALT30.StrType)le.title),
    Fields.InValid_first_name((SALT30.StrType)le.first_name),
    Fields.InValid_middle_name((SALT30.StrType)le.middle_name),
    Fields.InValid_last_name((SALT30.StrType)le.last_name),
    Fields.InValid_last_name_suffix((SALT30.StrType)le.last_name_suffix),
    Fields.InValid_job_title((SALT30.StrType)le.job_title),
    Fields.InValid_secondary_name_title((SALT30.StrType)le.secondary_name_title),
    Fields.InValid_secondary_first_name((SALT30.StrType)le.secondary_first_name),
    Fields.InValid_secondary_middle_name((SALT30.StrType)le.secondary_middle_name),
    Fields.InValid_secondary_name_suffix((SALT30.StrType)le.secondary_name_suffix),
    Fields.InValid_house_number((SALT30.StrType)le.house_number),
    Fields.InValid_pre_direction((SALT30.StrType)le.pre_direction),
    Fields.InValid_street_name((SALT30.StrType)le.street_name),
    Fields.InValid_street_type((SALT30.StrType)le.street_type),
    Fields.InValid_post_direction((SALT30.StrType)le.post_direction),
    Fields.InValid_apt_type((SALT30.StrType)le.apt_type),
    Fields.InValid_apt_number((SALT30.StrType)le.apt_number),
    Fields.InValid_box_number((SALT30.StrType)le.box_number),
    Fields.InValid_expanded_pub_city_name((SALT30.StrType)le.expanded_pub_city_name),
    Fields.InValid_postal_city_name((SALT30.StrType)le.postal_city_name),
    Fields.InValid_state((SALT30.StrType)le.state),
    Fields.InValid_z5((SALT30.StrType)le.z5),
    Fields.InValid_plus4((SALT30.StrType)le.plus4),
    Fields.InValid_delivery_point_code((SALT30.StrType)le.delivery_point_code),
    Fields.InValid_carrier_route((SALT30.StrType)le.carrier_route),
    Fields.InValid_county_code_((SALT30.StrType)le.county_code_),
    Fields.InValid_gnrl_address_return_code((SALT30.StrType)le.gnrl_address_return_code),
    Fields.InValid_house_number_usage_flag((SALT30.StrType)le.house_number_usage_flag),
    Fields.InValid_pre_direction_usage_flag((SALT30.StrType)le.pre_direction_usage_flag),
    Fields.InValid_street_name_usage_flag((SALT30.StrType)le.street_name_usage_flag),
    Fields.InValid_street_type_usage_flag((SALT30.StrType)le.street_type_usage_flag),
    Fields.InValid_post_direction_usage_flag((SALT30.StrType)le.post_direction_usage_flag),
    Fields.InValid_apt_number_usage_flag((SALT30.StrType)le.apt_number_usage_flag),
    Fields.InValid_validation_date((SALT30.StrType)le.validation_date),
    Fields.InValid_validation_flag((SALT30.StrType)le.validation_flag),
    Fields.InValid_filler1((SALT30.StrType)le.filler1),
    Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_last_reported((SALT30.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_vendor_first_reported((SALT30.StrType)le.dt_vendor_first_reported),
    Fields.InValid_rec_type((SALT30.StrType)le.rec_type),
    Fields.InValid_hhid((SALT30.StrType)le.hhid),
    Fields.InValid_did((SALT30.StrType)le.did),
    Fields.InValid_did_score((SALT30.StrType)le.did_score),
    Fields.InValid_fname((SALT30.StrType)le.fname),
    Fields.InValid_minit((SALT30.StrType)le.minit),
    Fields.InValid_lname((SALT30.StrType)le.lname),
    Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_predir((SALT30.StrType)le.predir),
    Fields.InValid_prim_name((SALT30.StrType)le.prim_name),
    Fields.InValid_suffix((SALT30.StrType)le.suffix),
    Fields.InValid_postdir((SALT30.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_city_name((SALT30.StrType)le.city_name),
    Fields.InValid_st((SALT30.StrType)le.st),
    Fields.InValid_zip((SALT30.StrType)le.zip),
    Fields.InValid_zip4((SALT30.StrType)le.zip4),
    Fields.InValid_county((SALT30.StrType)le.county),
    Fields.InValid_cbsa((SALT30.StrType)le.cbsa),
    Fields.InValid_geo_blk((SALT30.StrType)le.geo_blk),
    Fields.InValid_cleanname((SALT30.StrType)le.cleanname),
    Fields.InValid_cleanaddress((SALT30.StrType)le.cleanaddress),
    Fields.InValid_active((SALT30.StrType)le.active),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,76,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_record_id','invalid_pubdate','Unknown','invalid_yppa_code','invalid_book_code','invalid_page_number','invalid_record_number','invalid_phone_number','invalid_phone_type','invalid_record_type','invalid_no_solicitation_code','invalid_name','invalid_raw_name','invalid_raw_name','invalid_raw_name','invalid_raw_name','invalid_job_title','invalid_raw_name','invalid_raw_name','invalid_raw_name','invalid_raw_name','invalid_house_number','invalid_predir','invalid_street_name','invalid_street_type','invalid_predir','invalid_apt_type','invalid_apt_number','invalid_box_number','invalid_postal_city_name','invalid_postal_city_name','invalid_st','invalid_zip','invalid_zip4','invalid_delivery_point_code','invalid_carrier_route','invalid_county_code_','invalid_gnrl_address_return_code','invalid_address_flag','invalid_address_flag','invalid_address_flag','invalid_address_flag','invalid_address_flag','invalid_address_flag','invalid_longdate','invalid_validation_flag','Unknown','invalid_shortdate','invalid_shortdate','invalid_shortdate','invalid_shortdate','invalid_rec_type','Unknown','Unknown','Unknown','invalid_name','invalid_name','invalid_name','invalid_name','invalid_prim_range','invalid_predir','invalid_prim_name','invalid_suffix','invalid_postdir','invalid_unit_desig','invalid_sec_range','invalid_city_name','invalid_st','invalid_zip','invalid_zip4','invalid_county','invalid_cbsa','invalid_geo_blk','invalid_raw_name','invalid_cleanaddress','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_pubdate(TotalErrors.ErrorNum),Fields.InValidMessage_filler(TotalErrors.ErrorNum),Fields.InValidMessage_yppa_code(TotalErrors.ErrorNum),Fields.InValidMessage_book_code(TotalErrors.ErrorNum),Fields.InValidMessage_page_number(TotalErrors.ErrorNum),Fields.InValidMessage_record_number(TotalErrors.ErrorNum),Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_no_solicitation_code(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_last_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_job_title(TotalErrors.ErrorNum),Fields.InValidMessage_secondary_name_title(TotalErrors.ErrorNum),Fields.InValidMessage_secondary_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_secondary_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_secondary_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_house_number(TotalErrors.ErrorNum),Fields.InValidMessage_pre_direction(TotalErrors.ErrorNum),Fields.InValidMessage_street_name(TotalErrors.ErrorNum),Fields.InValidMessage_street_type(TotalErrors.ErrorNum),Fields.InValidMessage_post_direction(TotalErrors.ErrorNum),Fields.InValidMessage_apt_type(TotalErrors.ErrorNum),Fields.InValidMessage_apt_number(TotalErrors.ErrorNum),Fields.InValidMessage_box_number(TotalErrors.ErrorNum),Fields.InValidMessage_expanded_pub_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_postal_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_z5(TotalErrors.ErrorNum),Fields.InValidMessage_plus4(TotalErrors.ErrorNum),Fields.InValidMessage_delivery_point_code(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_route(TotalErrors.ErrorNum),Fields.InValidMessage_county_code_(TotalErrors.ErrorNum),Fields.InValidMessage_gnrl_address_return_code(TotalErrors.ErrorNum),Fields.InValidMessage_house_number_usage_flag(TotalErrors.ErrorNum),Fields.InValidMessage_pre_direction_usage_flag(TotalErrors.ErrorNum),Fields.InValidMessage_street_name_usage_flag(TotalErrors.ErrorNum),Fields.InValidMessage_street_type_usage_flag(TotalErrors.ErrorNum),Fields.InValidMessage_post_direction_usage_flag(TotalErrors.ErrorNum),Fields.InValidMessage_apt_number_usage_flag(TotalErrors.ErrorNum),Fields.InValidMessage_validation_date(TotalErrors.ErrorNum),Fields.InValidMessage_validation_flag(TotalErrors.ErrorNum),Fields.InValidMessage_filler1(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_hhid(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_minit(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_cbsa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_cleanname(TotalErrors.ErrorNum),Fields.InValidMessage_cleanaddress(TotalErrors.ErrorNum),Fields.InValidMessage_active(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
