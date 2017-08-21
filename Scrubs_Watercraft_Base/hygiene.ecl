IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_Watercraft_Base) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source_code);    NumberOfRecords := COUNT(GROUP);
    populated_watercraft_key_pcnt := AVE(GROUP,IF(h.watercraft_key = (TYPEOF(h.watercraft_key))'',0,100));
    maxlength_watercraft_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_key)));
    avelength_watercraft_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_key)),h.watercraft_key<>(typeof(h.watercraft_key))'');
    populated_sequence_key_pcnt := AVE(GROUP,IF(h.sequence_key = (TYPEOF(h.sequence_key))'',0,100));
    maxlength_sequence_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sequence_key)));
    avelength_sequence_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sequence_key)),h.sequence_key<>(typeof(h.sequence_key))'');
    populated_watercraft_id_pcnt := AVE(GROUP,IF(h.watercraft_id = (TYPEOF(h.watercraft_id))'',0,100));
    maxlength_watercraft_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_id)));
    avelength_watercraft_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_id)),h.watercraft_id<>(typeof(h.watercraft_id))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_st_registration_pcnt := AVE(GROUP,IF(h.st_registration = (TYPEOF(h.st_registration))'',0,100));
    maxlength_st_registration := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st_registration)));
    avelength_st_registration := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st_registration)),h.st_registration<>(typeof(h.st_registration))'');
    populated_county_registration_pcnt := AVE(GROUP,IF(h.county_registration = (TYPEOF(h.county_registration))'',0,100));
    maxlength_county_registration := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_registration)));
    avelength_county_registration := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_registration)),h.county_registration<>(typeof(h.county_registration))'');
    populated_registration_number_pcnt := AVE(GROUP,IF(h.registration_number = (TYPEOF(h.registration_number))'',0,100));
    maxlength_registration_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_number)));
    avelength_registration_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_number)),h.registration_number<>(typeof(h.registration_number))'');
    populated_hull_number_pcnt := AVE(GROUP,IF(h.hull_number = (TYPEOF(h.hull_number))'',0,100));
    maxlength_hull_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_number)));
    avelength_hull_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_number)),h.hull_number<>(typeof(h.hull_number))'');
    populated_propulsion_description_pcnt := AVE(GROUP,IF(h.propulsion_description = (TYPEOF(h.propulsion_description))'',0,100));
    maxlength_propulsion_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.propulsion_description)));
    avelength_propulsion_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.propulsion_description)),h.propulsion_description<>(typeof(h.propulsion_description))'');
    populated_vehicle_type_code_pcnt := AVE(GROUP,IF(h.vehicle_type_code = (TYPEOF(h.vehicle_type_code))'',0,100));
    maxlength_vehicle_type_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_type_code)));
    avelength_vehicle_type_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_type_code)),h.vehicle_type_code<>(typeof(h.vehicle_type_code))'');
    populated_vehicle_type_description_pcnt := AVE(GROUP,IF(h.vehicle_type_description = (TYPEOF(h.vehicle_type_description))'',0,100));
    maxlength_vehicle_type_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_type_description)));
    avelength_vehicle_type_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_type_description)),h.vehicle_type_description<>(typeof(h.vehicle_type_description))'');
    populated_fuel_code_pcnt := AVE(GROUP,IF(h.fuel_code = (TYPEOF(h.fuel_code))'',0,100));
    maxlength_fuel_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fuel_code)));
    avelength_fuel_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fuel_code)),h.fuel_code<>(typeof(h.fuel_code))'');
    populated_fuel_description_pcnt := AVE(GROUP,IF(h.fuel_description = (TYPEOF(h.fuel_description))'',0,100));
    maxlength_fuel_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fuel_description)));
    avelength_fuel_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fuel_description)),h.fuel_description<>(typeof(h.fuel_description))'');
    populated_hull_type_code_pcnt := AVE(GROUP,IF(h.hull_type_code = (TYPEOF(h.hull_type_code))'',0,100));
    maxlength_hull_type_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_type_code)));
    avelength_hull_type_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_type_code)),h.hull_type_code<>(typeof(h.hull_type_code))'');
    populated_hull_type_description_pcnt := AVE(GROUP,IF(h.hull_type_description = (TYPEOF(h.hull_type_description))'',0,100));
    maxlength_hull_type_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_type_description)));
    avelength_hull_type_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_type_description)),h.hull_type_description<>(typeof(h.hull_type_description))'');
    populated_use_code_pcnt := AVE(GROUP,IF(h.use_code = (TYPEOF(h.use_code))'',0,100));
    maxlength_use_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.use_code)));
    avelength_use_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.use_code)),h.use_code<>(typeof(h.use_code))'');
    populated_use_description_pcnt := AVE(GROUP,IF(h.use_description = (TYPEOF(h.use_description))'',0,100));
    maxlength_use_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.use_description)));
    avelength_use_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.use_description)),h.use_description<>(typeof(h.use_description))'');
    populated_model_year_pcnt := AVE(GROUP,IF(h.model_year = (TYPEOF(h.model_year))'',0,100));
    maxlength_model_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_year)));
    avelength_model_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_year)),h.model_year<>(typeof(h.model_year))'');
    populated_watercraft_name_pcnt := AVE(GROUP,IF(h.watercraft_name = (TYPEOF(h.watercraft_name))'',0,100));
    maxlength_watercraft_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_name)));
    avelength_watercraft_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_name)),h.watercraft_name<>(typeof(h.watercraft_name))'');
    populated_watercraft_class_code_pcnt := AVE(GROUP,IF(h.watercraft_class_code = (TYPEOF(h.watercraft_class_code))'',0,100));
    maxlength_watercraft_class_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_class_code)));
    avelength_watercraft_class_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_class_code)),h.watercraft_class_code<>(typeof(h.watercraft_class_code))'');
    populated_watercraft_class_description_pcnt := AVE(GROUP,IF(h.watercraft_class_description = (TYPEOF(h.watercraft_class_description))'',0,100));
    maxlength_watercraft_class_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_class_description)));
    avelength_watercraft_class_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_class_description)),h.watercraft_class_description<>(typeof(h.watercraft_class_description))'');
    populated_watercraft_make_code_pcnt := AVE(GROUP,IF(h.watercraft_make_code = (TYPEOF(h.watercraft_make_code))'',0,100));
    maxlength_watercraft_make_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_make_code)));
    avelength_watercraft_make_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_make_code)),h.watercraft_make_code<>(typeof(h.watercraft_make_code))'');
    populated_watercraft_make_description_pcnt := AVE(GROUP,IF(h.watercraft_make_description = (TYPEOF(h.watercraft_make_description))'',0,100));
    maxlength_watercraft_make_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_make_description)));
    avelength_watercraft_make_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_make_description)),h.watercraft_make_description<>(typeof(h.watercraft_make_description))'');
    populated_watercraft_model_code_pcnt := AVE(GROUP,IF(h.watercraft_model_code = (TYPEOF(h.watercraft_model_code))'',0,100));
    maxlength_watercraft_model_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_model_code)));
    avelength_watercraft_model_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_model_code)),h.watercraft_model_code<>(typeof(h.watercraft_model_code))'');
    populated_watercraft_model_description_pcnt := AVE(GROUP,IF(h.watercraft_model_description = (TYPEOF(h.watercraft_model_description))'',0,100));
    maxlength_watercraft_model_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_model_description)));
    avelength_watercraft_model_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_model_description)),h.watercraft_model_description<>(typeof(h.watercraft_model_description))'');
    populated_watercraft_length_pcnt := AVE(GROUP,IF(h.watercraft_length = (TYPEOF(h.watercraft_length))'',0,100));
    maxlength_watercraft_length := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_length)));
    avelength_watercraft_length := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_length)),h.watercraft_length<>(typeof(h.watercraft_length))'');
    populated_watercraft_width_pcnt := AVE(GROUP,IF(h.watercraft_width = (TYPEOF(h.watercraft_width))'',0,100));
    maxlength_watercraft_width := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_width)));
    avelength_watercraft_width := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_width)),h.watercraft_width<>(typeof(h.watercraft_width))'');
    populated_watercraft_weight_pcnt := AVE(GROUP,IF(h.watercraft_weight = (TYPEOF(h.watercraft_weight))'',0,100));
    maxlength_watercraft_weight := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_weight)));
    avelength_watercraft_weight := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_weight)),h.watercraft_weight<>(typeof(h.watercraft_weight))'');
    populated_watercraft_color_1_code_pcnt := AVE(GROUP,IF(h.watercraft_color_1_code = (TYPEOF(h.watercraft_color_1_code))'',0,100));
    maxlength_watercraft_color_1_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_color_1_code)));
    avelength_watercraft_color_1_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_color_1_code)),h.watercraft_color_1_code<>(typeof(h.watercraft_color_1_code))'');
    populated_watercraft_color_1_description_pcnt := AVE(GROUP,IF(h.watercraft_color_1_description = (TYPEOF(h.watercraft_color_1_description))'',0,100));
    maxlength_watercraft_color_1_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_color_1_description)));
    avelength_watercraft_color_1_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_color_1_description)),h.watercraft_color_1_description<>(typeof(h.watercraft_color_1_description))'');
    populated_watercraft_color_2_code_pcnt := AVE(GROUP,IF(h.watercraft_color_2_code = (TYPEOF(h.watercraft_color_2_code))'',0,100));
    maxlength_watercraft_color_2_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_color_2_code)));
    avelength_watercraft_color_2_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_color_2_code)),h.watercraft_color_2_code<>(typeof(h.watercraft_color_2_code))'');
    populated_watercraft_color_2_description_pcnt := AVE(GROUP,IF(h.watercraft_color_2_description = (TYPEOF(h.watercraft_color_2_description))'',0,100));
    maxlength_watercraft_color_2_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_color_2_description)));
    avelength_watercraft_color_2_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_color_2_description)),h.watercraft_color_2_description<>(typeof(h.watercraft_color_2_description))'');
    populated_watercraft_toilet_code_pcnt := AVE(GROUP,IF(h.watercraft_toilet_code = (TYPEOF(h.watercraft_toilet_code))'',0,100));
    maxlength_watercraft_toilet_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_toilet_code)));
    avelength_watercraft_toilet_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_toilet_code)),h.watercraft_toilet_code<>(typeof(h.watercraft_toilet_code))'');
    populated_watercraft_toilet_description_pcnt := AVE(GROUP,IF(h.watercraft_toilet_description = (TYPEOF(h.watercraft_toilet_description))'',0,100));
    maxlength_watercraft_toilet_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_toilet_description)));
    avelength_watercraft_toilet_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_toilet_description)),h.watercraft_toilet_description<>(typeof(h.watercraft_toilet_description))'');
    populated_watercraft_number_of_engines_pcnt := AVE(GROUP,IF(h.watercraft_number_of_engines = (TYPEOF(h.watercraft_number_of_engines))'',0,100));
    maxlength_watercraft_number_of_engines := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_number_of_engines)));
    avelength_watercraft_number_of_engines := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_number_of_engines)),h.watercraft_number_of_engines<>(typeof(h.watercraft_number_of_engines))'');
    populated_watercraft_hp_1_pcnt := AVE(GROUP,IF(h.watercraft_hp_1 = (TYPEOF(h.watercraft_hp_1))'',0,100));
    maxlength_watercraft_hp_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_hp_1)));
    avelength_watercraft_hp_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_hp_1)),h.watercraft_hp_1<>(typeof(h.watercraft_hp_1))'');
    populated_watercraft_hp_2_pcnt := AVE(GROUP,IF(h.watercraft_hp_2 = (TYPEOF(h.watercraft_hp_2))'',0,100));
    maxlength_watercraft_hp_2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_hp_2)));
    avelength_watercraft_hp_2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_hp_2)),h.watercraft_hp_2<>(typeof(h.watercraft_hp_2))'');
    populated_watercraft_hp_3_pcnt := AVE(GROUP,IF(h.watercraft_hp_3 = (TYPEOF(h.watercraft_hp_3))'',0,100));
    maxlength_watercraft_hp_3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_hp_3)));
    avelength_watercraft_hp_3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_hp_3)),h.watercraft_hp_3<>(typeof(h.watercraft_hp_3))'');
    populated_engine_number_1_pcnt := AVE(GROUP,IF(h.engine_number_1 = (TYPEOF(h.engine_number_1))'',0,100));
    maxlength_engine_number_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_number_1)));
    avelength_engine_number_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_number_1)),h.engine_number_1<>(typeof(h.engine_number_1))'');
    populated_engine_number_2_pcnt := AVE(GROUP,IF(h.engine_number_2 = (TYPEOF(h.engine_number_2))'',0,100));
    maxlength_engine_number_2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_number_2)));
    avelength_engine_number_2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_number_2)),h.engine_number_2<>(typeof(h.engine_number_2))'');
    populated_engine_number_3_pcnt := AVE(GROUP,IF(h.engine_number_3 = (TYPEOF(h.engine_number_3))'',0,100));
    maxlength_engine_number_3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_number_3)));
    avelength_engine_number_3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_number_3)),h.engine_number_3<>(typeof(h.engine_number_3))'');
    populated_engine_make_1_pcnt := AVE(GROUP,IF(h.engine_make_1 = (TYPEOF(h.engine_make_1))'',0,100));
    maxlength_engine_make_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_make_1)));
    avelength_engine_make_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_make_1)),h.engine_make_1<>(typeof(h.engine_make_1))'');
    populated_engine_make_2_pcnt := AVE(GROUP,IF(h.engine_make_2 = (TYPEOF(h.engine_make_2))'',0,100));
    maxlength_engine_make_2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_make_2)));
    avelength_engine_make_2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_make_2)),h.engine_make_2<>(typeof(h.engine_make_2))'');
    populated_engine_make_3_pcnt := AVE(GROUP,IF(h.engine_make_3 = (TYPEOF(h.engine_make_3))'',0,100));
    maxlength_engine_make_3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_make_3)));
    avelength_engine_make_3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_make_3)),h.engine_make_3<>(typeof(h.engine_make_3))'');
    populated_engine_model_1_pcnt := AVE(GROUP,IF(h.engine_model_1 = (TYPEOF(h.engine_model_1))'',0,100));
    maxlength_engine_model_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_model_1)));
    avelength_engine_model_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_model_1)),h.engine_model_1<>(typeof(h.engine_model_1))'');
    populated_engine_model_2_pcnt := AVE(GROUP,IF(h.engine_model_2 = (TYPEOF(h.engine_model_2))'',0,100));
    maxlength_engine_model_2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_model_2)));
    avelength_engine_model_2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_model_2)),h.engine_model_2<>(typeof(h.engine_model_2))'');
    populated_engine_model_3_pcnt := AVE(GROUP,IF(h.engine_model_3 = (TYPEOF(h.engine_model_3))'',0,100));
    maxlength_engine_model_3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_model_3)));
    avelength_engine_model_3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_model_3)),h.engine_model_3<>(typeof(h.engine_model_3))'');
    populated_engine_year_1_pcnt := AVE(GROUP,IF(h.engine_year_1 = (TYPEOF(h.engine_year_1))'',0,100));
    maxlength_engine_year_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_year_1)));
    avelength_engine_year_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_year_1)),h.engine_year_1<>(typeof(h.engine_year_1))'');
    populated_engine_year_2_pcnt := AVE(GROUP,IF(h.engine_year_2 = (TYPEOF(h.engine_year_2))'',0,100));
    maxlength_engine_year_2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_year_2)));
    avelength_engine_year_2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_year_2)),h.engine_year_2<>(typeof(h.engine_year_2))'');
    populated_engine_year_3_pcnt := AVE(GROUP,IF(h.engine_year_3 = (TYPEOF(h.engine_year_3))'',0,100));
    maxlength_engine_year_3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_year_3)));
    avelength_engine_year_3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_year_3)),h.engine_year_3<>(typeof(h.engine_year_3))'');
    populated_coast_guard_documented_flag_pcnt := AVE(GROUP,IF(h.coast_guard_documented_flag = (TYPEOF(h.coast_guard_documented_flag))'',0,100));
    maxlength_coast_guard_documented_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.coast_guard_documented_flag)));
    avelength_coast_guard_documented_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.coast_guard_documented_flag)),h.coast_guard_documented_flag<>(typeof(h.coast_guard_documented_flag))'');
    populated_coast_guard_number_pcnt := AVE(GROUP,IF(h.coast_guard_number = (TYPEOF(h.coast_guard_number))'',0,100));
    maxlength_coast_guard_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.coast_guard_number)));
    avelength_coast_guard_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.coast_guard_number)),h.coast_guard_number<>(typeof(h.coast_guard_number))'');
    populated_registration_date_pcnt := AVE(GROUP,IF(h.registration_date = (TYPEOF(h.registration_date))'',0,100));
    maxlength_registration_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_date)));
    avelength_registration_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_date)),h.registration_date<>(typeof(h.registration_date))'');
    populated_registration_expiration_date_pcnt := AVE(GROUP,IF(h.registration_expiration_date = (TYPEOF(h.registration_expiration_date))'',0,100));
    maxlength_registration_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_expiration_date)));
    avelength_registration_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_expiration_date)),h.registration_expiration_date<>(typeof(h.registration_expiration_date))'');
    populated_registration_status_code_pcnt := AVE(GROUP,IF(h.registration_status_code = (TYPEOF(h.registration_status_code))'',0,100));
    maxlength_registration_status_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_status_code)));
    avelength_registration_status_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_status_code)),h.registration_status_code<>(typeof(h.registration_status_code))'');
    populated_registration_status_description_pcnt := AVE(GROUP,IF(h.registration_status_description = (TYPEOF(h.registration_status_description))'',0,100));
    maxlength_registration_status_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_status_description)));
    avelength_registration_status_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_status_description)),h.registration_status_description<>(typeof(h.registration_status_description))'');
    populated_registration_status_date_pcnt := AVE(GROUP,IF(h.registration_status_date = (TYPEOF(h.registration_status_date))'',0,100));
    maxlength_registration_status_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_status_date)));
    avelength_registration_status_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_status_date)),h.registration_status_date<>(typeof(h.registration_status_date))'');
    populated_registration_renewal_date_pcnt := AVE(GROUP,IF(h.registration_renewal_date = (TYPEOF(h.registration_renewal_date))'',0,100));
    maxlength_registration_renewal_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_renewal_date)));
    avelength_registration_renewal_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_renewal_date)),h.registration_renewal_date<>(typeof(h.registration_renewal_date))'');
    populated_decal_number_pcnt := AVE(GROUP,IF(h.decal_number = (TYPEOF(h.decal_number))'',0,100));
    maxlength_decal_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.decal_number)));
    avelength_decal_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.decal_number)),h.decal_number<>(typeof(h.decal_number))'');
    populated_transaction_type_code_pcnt := AVE(GROUP,IF(h.transaction_type_code = (TYPEOF(h.transaction_type_code))'',0,100));
    maxlength_transaction_type_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.transaction_type_code)));
    avelength_transaction_type_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.transaction_type_code)),h.transaction_type_code<>(typeof(h.transaction_type_code))'');
    populated_transaction_type_description_pcnt := AVE(GROUP,IF(h.transaction_type_description = (TYPEOF(h.transaction_type_description))'',0,100));
    maxlength_transaction_type_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.transaction_type_description)));
    avelength_transaction_type_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.transaction_type_description)),h.transaction_type_description<>(typeof(h.transaction_type_description))'');
    populated_title_state_pcnt := AVE(GROUP,IF(h.title_state = (TYPEOF(h.title_state))'',0,100));
    maxlength_title_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_state)));
    avelength_title_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_state)),h.title_state<>(typeof(h.title_state))'');
    populated_title_status_code_pcnt := AVE(GROUP,IF(h.title_status_code = (TYPEOF(h.title_status_code))'',0,100));
    maxlength_title_status_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_status_code)));
    avelength_title_status_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_status_code)),h.title_status_code<>(typeof(h.title_status_code))'');
    populated_title_status_description_pcnt := AVE(GROUP,IF(h.title_status_description = (TYPEOF(h.title_status_description))'',0,100));
    maxlength_title_status_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_status_description)));
    avelength_title_status_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_status_description)),h.title_status_description<>(typeof(h.title_status_description))'');
    populated_title_number_pcnt := AVE(GROUP,IF(h.title_number = (TYPEOF(h.title_number))'',0,100));
    maxlength_title_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_number)));
    avelength_title_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_number)),h.title_number<>(typeof(h.title_number))'');
    populated_title_issue_date_pcnt := AVE(GROUP,IF(h.title_issue_date = (TYPEOF(h.title_issue_date))'',0,100));
    maxlength_title_issue_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_issue_date)));
    avelength_title_issue_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_issue_date)),h.title_issue_date<>(typeof(h.title_issue_date))'');
    populated_title_type_code_pcnt := AVE(GROUP,IF(h.title_type_code = (TYPEOF(h.title_type_code))'',0,100));
    maxlength_title_type_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_type_code)));
    avelength_title_type_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_type_code)),h.title_type_code<>(typeof(h.title_type_code))'');
    populated_title_type_description_pcnt := AVE(GROUP,IF(h.title_type_description = (TYPEOF(h.title_type_description))'',0,100));
    maxlength_title_type_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_type_description)));
    avelength_title_type_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title_type_description)),h.title_type_description<>(typeof(h.title_type_description))'');
    populated_additional_owner_count_pcnt := AVE(GROUP,IF(h.additional_owner_count = (TYPEOF(h.additional_owner_count))'',0,100));
    maxlength_additional_owner_count := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.additional_owner_count)));
    avelength_additional_owner_count := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.additional_owner_count)),h.additional_owner_count<>(typeof(h.additional_owner_count))'');
    populated_lien_1_indicator_pcnt := AVE(GROUP,IF(h.lien_1_indicator = (TYPEOF(h.lien_1_indicator))'',0,100));
    maxlength_lien_1_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_indicator)));
    avelength_lien_1_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_indicator)),h.lien_1_indicator<>(typeof(h.lien_1_indicator))'');
    populated_lien_1_name_pcnt := AVE(GROUP,IF(h.lien_1_name = (TYPEOF(h.lien_1_name))'',0,100));
    maxlength_lien_1_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_name)));
    avelength_lien_1_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_name)),h.lien_1_name<>(typeof(h.lien_1_name))'');
    populated_lien_1_date_pcnt := AVE(GROUP,IF(h.lien_1_date = (TYPEOF(h.lien_1_date))'',0,100));
    maxlength_lien_1_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_date)));
    avelength_lien_1_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_date)),h.lien_1_date<>(typeof(h.lien_1_date))'');
    populated_lien_1_address_1_pcnt := AVE(GROUP,IF(h.lien_1_address_1 = (TYPEOF(h.lien_1_address_1))'',0,100));
    maxlength_lien_1_address_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_address_1)));
    avelength_lien_1_address_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_address_1)),h.lien_1_address_1<>(typeof(h.lien_1_address_1))'');
    populated_lien_1_address_2_pcnt := AVE(GROUP,IF(h.lien_1_address_2 = (TYPEOF(h.lien_1_address_2))'',0,100));
    maxlength_lien_1_address_2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_address_2)));
    avelength_lien_1_address_2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_address_2)),h.lien_1_address_2<>(typeof(h.lien_1_address_2))'');
    populated_lien_1_city_pcnt := AVE(GROUP,IF(h.lien_1_city = (TYPEOF(h.lien_1_city))'',0,100));
    maxlength_lien_1_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_city)));
    avelength_lien_1_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_city)),h.lien_1_city<>(typeof(h.lien_1_city))'');
    populated_lien_1_state_pcnt := AVE(GROUP,IF(h.lien_1_state = (TYPEOF(h.lien_1_state))'',0,100));
    maxlength_lien_1_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_state)));
    avelength_lien_1_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_state)),h.lien_1_state<>(typeof(h.lien_1_state))'');
    populated_lien_1_zip_pcnt := AVE(GROUP,IF(h.lien_1_zip = (TYPEOF(h.lien_1_zip))'',0,100));
    maxlength_lien_1_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_zip)));
    avelength_lien_1_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_1_zip)),h.lien_1_zip<>(typeof(h.lien_1_zip))'');
    populated_lien_2_indicator_pcnt := AVE(GROUP,IF(h.lien_2_indicator = (TYPEOF(h.lien_2_indicator))'',0,100));
    maxlength_lien_2_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_indicator)));
    avelength_lien_2_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_indicator)),h.lien_2_indicator<>(typeof(h.lien_2_indicator))'');
    populated_lien_2_name_pcnt := AVE(GROUP,IF(h.lien_2_name = (TYPEOF(h.lien_2_name))'',0,100));
    maxlength_lien_2_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_name)));
    avelength_lien_2_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_name)),h.lien_2_name<>(typeof(h.lien_2_name))'');
    populated_lien_2_date_pcnt := AVE(GROUP,IF(h.lien_2_date = (TYPEOF(h.lien_2_date))'',0,100));
    maxlength_lien_2_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_date)));
    avelength_lien_2_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_date)),h.lien_2_date<>(typeof(h.lien_2_date))'');
    populated_lien_2_address_1_pcnt := AVE(GROUP,IF(h.lien_2_address_1 = (TYPEOF(h.lien_2_address_1))'',0,100));
    maxlength_lien_2_address_1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_address_1)));
    avelength_lien_2_address_1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_address_1)),h.lien_2_address_1<>(typeof(h.lien_2_address_1))'');
    populated_lien_2_address_2_pcnt := AVE(GROUP,IF(h.lien_2_address_2 = (TYPEOF(h.lien_2_address_2))'',0,100));
    maxlength_lien_2_address_2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_address_2)));
    avelength_lien_2_address_2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_address_2)),h.lien_2_address_2<>(typeof(h.lien_2_address_2))'');
    populated_lien_2_city_pcnt := AVE(GROUP,IF(h.lien_2_city = (TYPEOF(h.lien_2_city))'',0,100));
    maxlength_lien_2_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_city)));
    avelength_lien_2_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_city)),h.lien_2_city<>(typeof(h.lien_2_city))'');
    populated_lien_2_state_pcnt := AVE(GROUP,IF(h.lien_2_state = (TYPEOF(h.lien_2_state))'',0,100));
    maxlength_lien_2_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_state)));
    avelength_lien_2_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_state)),h.lien_2_state<>(typeof(h.lien_2_state))'');
    populated_lien_2_zip_pcnt := AVE(GROUP,IF(h.lien_2_zip = (TYPEOF(h.lien_2_zip))'',0,100));
    maxlength_lien_2_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_zip)));
    avelength_lien_2_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lien_2_zip)),h.lien_2_zip<>(typeof(h.lien_2_zip))'');
    populated_state_purchased_pcnt := AVE(GROUP,IF(h.state_purchased = (TYPEOF(h.state_purchased))'',0,100));
    maxlength_state_purchased := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_purchased)));
    avelength_state_purchased := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_purchased)),h.state_purchased<>(typeof(h.state_purchased))'');
    populated_purchase_date_pcnt := AVE(GROUP,IF(h.purchase_date = (TYPEOF(h.purchase_date))'',0,100));
    maxlength_purchase_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.purchase_date)));
    avelength_purchase_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.purchase_date)),h.purchase_date<>(typeof(h.purchase_date))'');
    populated_dealer_pcnt := AVE(GROUP,IF(h.dealer = (TYPEOF(h.dealer))'',0,100));
    maxlength_dealer := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dealer)));
    avelength_dealer := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dealer)),h.dealer<>(typeof(h.dealer))'');
    populated_purchase_price_pcnt := AVE(GROUP,IF(h.purchase_price = (TYPEOF(h.purchase_price))'',0,100));
    maxlength_purchase_price := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.purchase_price)));
    avelength_purchase_price := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.purchase_price)),h.purchase_price<>(typeof(h.purchase_price))'');
    populated_new_used_flag_pcnt := AVE(GROUP,IF(h.new_used_flag = (TYPEOF(h.new_used_flag))'',0,100));
    maxlength_new_used_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.new_used_flag)));
    avelength_new_used_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.new_used_flag)),h.new_used_flag<>(typeof(h.new_used_flag))'');
    populated_watercraft_status_code_pcnt := AVE(GROUP,IF(h.watercraft_status_code = (TYPEOF(h.watercraft_status_code))'',0,100));
    maxlength_watercraft_status_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_status_code)));
    avelength_watercraft_status_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_status_code)),h.watercraft_status_code<>(typeof(h.watercraft_status_code))'');
    populated_watercraft_status_description_pcnt := AVE(GROUP,IF(h.watercraft_status_description = (TYPEOF(h.watercraft_status_description))'',0,100));
    maxlength_watercraft_status_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_status_description)));
    avelength_watercraft_status_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_status_description)),h.watercraft_status_description<>(typeof(h.watercraft_status_description))'');
    populated_history_flag_pcnt := AVE(GROUP,IF(h.history_flag = (TYPEOF(h.history_flag))'',0,100));
    maxlength_history_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.history_flag)));
    avelength_history_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.history_flag)),h.history_flag<>(typeof(h.history_flag))'');
    populated_coastguard_flag_pcnt := AVE(GROUP,IF(h.coastguard_flag = (TYPEOF(h.coastguard_flag))'',0,100));
    maxlength_coastguard_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.coastguard_flag)));
    avelength_coastguard_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.coastguard_flag)),h.coastguard_flag<>(typeof(h.coastguard_flag))'');
    populated_signatory_pcnt := AVE(GROUP,IF(h.signatory = (TYPEOF(h.signatory))'',0,100));
    maxlength_signatory := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.signatory)));
    avelength_signatory := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.signatory)),h.signatory<>(typeof(h.signatory))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source_code,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_watercraft_key_pcnt *   0.00 / 100 + T.Populated_sequence_key_pcnt *   0.00 / 100 + T.Populated_watercraft_id_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_st_registration_pcnt *   0.00 / 100 + T.Populated_county_registration_pcnt *   0.00 / 100 + T.Populated_registration_number_pcnt *   0.00 / 100 + T.Populated_hull_number_pcnt *   0.00 / 100 + T.Populated_propulsion_description_pcnt *   0.00 / 100 + T.Populated_vehicle_type_code_pcnt *   0.00 / 100 + T.Populated_vehicle_type_description_pcnt *   0.00 / 100 + T.Populated_fuel_code_pcnt *   0.00 / 100 + T.Populated_fuel_description_pcnt *   0.00 / 100 + T.Populated_hull_type_code_pcnt *   0.00 / 100 + T.Populated_hull_type_description_pcnt *   0.00 / 100 + T.Populated_use_code_pcnt *   0.00 / 100 + T.Populated_use_description_pcnt *   0.00 / 100 + T.Populated_model_year_pcnt *   0.00 / 100 + T.Populated_watercraft_name_pcnt *   0.00 / 100 + T.Populated_watercraft_class_code_pcnt *   0.00 / 100 + T.Populated_watercraft_class_description_pcnt *   0.00 / 100 + T.Populated_watercraft_make_code_pcnt *   0.00 / 100 + T.Populated_watercraft_make_description_pcnt *   0.00 / 100 + T.Populated_watercraft_model_code_pcnt *   0.00 / 100 + T.Populated_watercraft_model_description_pcnt *   0.00 / 100 + T.Populated_watercraft_length_pcnt *   0.00 / 100 + T.Populated_watercraft_width_pcnt *   0.00 / 100 + T.Populated_watercraft_weight_pcnt *   0.00 / 100 + T.Populated_watercraft_color_1_code_pcnt *   0.00 / 100 + T.Populated_watercraft_color_1_description_pcnt *   0.00 / 100 + T.Populated_watercraft_color_2_code_pcnt *   0.00 / 100 + T.Populated_watercraft_color_2_description_pcnt *   0.00 / 100 + T.Populated_watercraft_toilet_code_pcnt *   0.00 / 100 + T.Populated_watercraft_toilet_description_pcnt *   0.00 / 100 + T.Populated_watercraft_number_of_engines_pcnt *   0.00 / 100 + T.Populated_watercraft_hp_1_pcnt *   0.00 / 100 + T.Populated_watercraft_hp_2_pcnt *   0.00 / 100 + T.Populated_watercraft_hp_3_pcnt *   0.00 / 100 + T.Populated_engine_number_1_pcnt *   0.00 / 100 + T.Populated_engine_number_2_pcnt *   0.00 / 100 + T.Populated_engine_number_3_pcnt *   0.00 / 100 + T.Populated_engine_make_1_pcnt *   0.00 / 100 + T.Populated_engine_make_2_pcnt *   0.00 / 100 + T.Populated_engine_make_3_pcnt *   0.00 / 100 + T.Populated_engine_model_1_pcnt *   0.00 / 100 + T.Populated_engine_model_2_pcnt *   0.00 / 100 + T.Populated_engine_model_3_pcnt *   0.00 / 100 + T.Populated_engine_year_1_pcnt *   0.00 / 100 + T.Populated_engine_year_2_pcnt *   0.00 / 100 + T.Populated_engine_year_3_pcnt *   0.00 / 100 + T.Populated_coast_guard_documented_flag_pcnt *   0.00 / 100 + T.Populated_coast_guard_number_pcnt *   0.00 / 100 + T.Populated_registration_date_pcnt *   0.00 / 100 + T.Populated_registration_expiration_date_pcnt *   0.00 / 100 + T.Populated_registration_status_code_pcnt *   0.00 / 100 + T.Populated_registration_status_description_pcnt *   0.00 / 100 + T.Populated_registration_status_date_pcnt *   0.00 / 100 + T.Populated_registration_renewal_date_pcnt *   0.00 / 100 + T.Populated_decal_number_pcnt *   0.00 / 100 + T.Populated_transaction_type_code_pcnt *   0.00 / 100 + T.Populated_transaction_type_description_pcnt *   0.00 / 100 + T.Populated_title_state_pcnt *   0.00 / 100 + T.Populated_title_status_code_pcnt *   0.00 / 100 + T.Populated_title_status_description_pcnt *   0.00 / 100 + T.Populated_title_number_pcnt *   0.00 / 100 + T.Populated_title_issue_date_pcnt *   0.00 / 100 + T.Populated_title_type_code_pcnt *   0.00 / 100 + T.Populated_title_type_description_pcnt *   0.00 / 100 + T.Populated_additional_owner_count_pcnt *   0.00 / 100 + T.Populated_lien_1_indicator_pcnt *   0.00 / 100 + T.Populated_lien_1_name_pcnt *   0.00 / 100 + T.Populated_lien_1_date_pcnt *   0.00 / 100 + T.Populated_lien_1_address_1_pcnt *   0.00 / 100 + T.Populated_lien_1_address_2_pcnt *   0.00 / 100 + T.Populated_lien_1_city_pcnt *   0.00 / 100 + T.Populated_lien_1_state_pcnt *   0.00 / 100 + T.Populated_lien_1_zip_pcnt *   0.00 / 100 + T.Populated_lien_2_indicator_pcnt *   0.00 / 100 + T.Populated_lien_2_name_pcnt *   0.00 / 100 + T.Populated_lien_2_date_pcnt *   0.00 / 100 + T.Populated_lien_2_address_1_pcnt *   0.00 / 100 + T.Populated_lien_2_address_2_pcnt *   0.00 / 100 + T.Populated_lien_2_city_pcnt *   0.00 / 100 + T.Populated_lien_2_state_pcnt *   0.00 / 100 + T.Populated_lien_2_zip_pcnt *   0.00 / 100 + T.Populated_state_purchased_pcnt *   0.00 / 100 + T.Populated_purchase_date_pcnt *   0.00 / 100 + T.Populated_dealer_pcnt *   0.00 / 100 + T.Populated_purchase_price_pcnt *   0.00 / 100 + T.Populated_new_used_flag_pcnt *   0.00 / 100 + T.Populated_watercraft_status_code_pcnt *   0.00 / 100 + T.Populated_watercraft_status_description_pcnt *   0.00 / 100 + T.Populated_history_flag_pcnt *   0.00 / 100 + T.Populated_coastguard_flag_pcnt *   0.00 / 100 + T.Populated_signatory_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source_code1;
    STRING source_code2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source_code1 := le.Source;
    SELF.source_code2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_watercraft_key_pcnt*ri.Populated_watercraft_key_pcnt *   0.00 / 10000 + le.Populated_sequence_key_pcnt*ri.Populated_sequence_key_pcnt *   0.00 / 10000 + le.Populated_watercraft_id_pcnt*ri.Populated_watercraft_id_pcnt *   0.00 / 10000 + le.Populated_state_origin_pcnt*ri.Populated_state_origin_pcnt *   0.00 / 10000 + le.Populated_source_code_pcnt*ri.Populated_source_code_pcnt *   0.00 / 10000 + le.Populated_st_registration_pcnt*ri.Populated_st_registration_pcnt *   0.00 / 10000 + le.Populated_county_registration_pcnt*ri.Populated_county_registration_pcnt *   0.00 / 10000 + le.Populated_registration_number_pcnt*ri.Populated_registration_number_pcnt *   0.00 / 10000 + le.Populated_hull_number_pcnt*ri.Populated_hull_number_pcnt *   0.00 / 10000 + le.Populated_propulsion_description_pcnt*ri.Populated_propulsion_description_pcnt *   0.00 / 10000 + le.Populated_vehicle_type_code_pcnt*ri.Populated_vehicle_type_code_pcnt *   0.00 / 10000 + le.Populated_vehicle_type_description_pcnt*ri.Populated_vehicle_type_description_pcnt *   0.00 / 10000 + le.Populated_fuel_code_pcnt*ri.Populated_fuel_code_pcnt *   0.00 / 10000 + le.Populated_fuel_description_pcnt*ri.Populated_fuel_description_pcnt *   0.00 / 10000 + le.Populated_hull_type_code_pcnt*ri.Populated_hull_type_code_pcnt *   0.00 / 10000 + le.Populated_hull_type_description_pcnt*ri.Populated_hull_type_description_pcnt *   0.00 / 10000 + le.Populated_use_code_pcnt*ri.Populated_use_code_pcnt *   0.00 / 10000 + le.Populated_use_description_pcnt*ri.Populated_use_description_pcnt *   0.00 / 10000 + le.Populated_model_year_pcnt*ri.Populated_model_year_pcnt *   0.00 / 10000 + le.Populated_watercraft_name_pcnt*ri.Populated_watercraft_name_pcnt *   0.00 / 10000 + le.Populated_watercraft_class_code_pcnt*ri.Populated_watercraft_class_code_pcnt *   0.00 / 10000 + le.Populated_watercraft_class_description_pcnt*ri.Populated_watercraft_class_description_pcnt *   0.00 / 10000 + le.Populated_watercraft_make_code_pcnt*ri.Populated_watercraft_make_code_pcnt *   0.00 / 10000 + le.Populated_watercraft_make_description_pcnt*ri.Populated_watercraft_make_description_pcnt *   0.00 / 10000 + le.Populated_watercraft_model_code_pcnt*ri.Populated_watercraft_model_code_pcnt *   0.00 / 10000 + le.Populated_watercraft_model_description_pcnt*ri.Populated_watercraft_model_description_pcnt *   0.00 / 10000 + le.Populated_watercraft_length_pcnt*ri.Populated_watercraft_length_pcnt *   0.00 / 10000 + le.Populated_watercraft_width_pcnt*ri.Populated_watercraft_width_pcnt *   0.00 / 10000 + le.Populated_watercraft_weight_pcnt*ri.Populated_watercraft_weight_pcnt *   0.00 / 10000 + le.Populated_watercraft_color_1_code_pcnt*ri.Populated_watercraft_color_1_code_pcnt *   0.00 / 10000 + le.Populated_watercraft_color_1_description_pcnt*ri.Populated_watercraft_color_1_description_pcnt *   0.00 / 10000 + le.Populated_watercraft_color_2_code_pcnt*ri.Populated_watercraft_color_2_code_pcnt *   0.00 / 10000 + le.Populated_watercraft_color_2_description_pcnt*ri.Populated_watercraft_color_2_description_pcnt *   0.00 / 10000 + le.Populated_watercraft_toilet_code_pcnt*ri.Populated_watercraft_toilet_code_pcnt *   0.00 / 10000 + le.Populated_watercraft_toilet_description_pcnt*ri.Populated_watercraft_toilet_description_pcnt *   0.00 / 10000 + le.Populated_watercraft_number_of_engines_pcnt*ri.Populated_watercraft_number_of_engines_pcnt *   0.00 / 10000 + le.Populated_watercraft_hp_1_pcnt*ri.Populated_watercraft_hp_1_pcnt *   0.00 / 10000 + le.Populated_watercraft_hp_2_pcnt*ri.Populated_watercraft_hp_2_pcnt *   0.00 / 10000 + le.Populated_watercraft_hp_3_pcnt*ri.Populated_watercraft_hp_3_pcnt *   0.00 / 10000 + le.Populated_engine_number_1_pcnt*ri.Populated_engine_number_1_pcnt *   0.00 / 10000 + le.Populated_engine_number_2_pcnt*ri.Populated_engine_number_2_pcnt *   0.00 / 10000 + le.Populated_engine_number_3_pcnt*ri.Populated_engine_number_3_pcnt *   0.00 / 10000 + le.Populated_engine_make_1_pcnt*ri.Populated_engine_make_1_pcnt *   0.00 / 10000 + le.Populated_engine_make_2_pcnt*ri.Populated_engine_make_2_pcnt *   0.00 / 10000 + le.Populated_engine_make_3_pcnt*ri.Populated_engine_make_3_pcnt *   0.00 / 10000 + le.Populated_engine_model_1_pcnt*ri.Populated_engine_model_1_pcnt *   0.00 / 10000 + le.Populated_engine_model_2_pcnt*ri.Populated_engine_model_2_pcnt *   0.00 / 10000 + le.Populated_engine_model_3_pcnt*ri.Populated_engine_model_3_pcnt *   0.00 / 10000 + le.Populated_engine_year_1_pcnt*ri.Populated_engine_year_1_pcnt *   0.00 / 10000 + le.Populated_engine_year_2_pcnt*ri.Populated_engine_year_2_pcnt *   0.00 / 10000 + le.Populated_engine_year_3_pcnt*ri.Populated_engine_year_3_pcnt *   0.00 / 10000 + le.Populated_coast_guard_documented_flag_pcnt*ri.Populated_coast_guard_documented_flag_pcnt *   0.00 / 10000 + le.Populated_coast_guard_number_pcnt*ri.Populated_coast_guard_number_pcnt *   0.00 / 10000 + le.Populated_registration_date_pcnt*ri.Populated_registration_date_pcnt *   0.00 / 10000 + le.Populated_registration_expiration_date_pcnt*ri.Populated_registration_expiration_date_pcnt *   0.00 / 10000 + le.Populated_registration_status_code_pcnt*ri.Populated_registration_status_code_pcnt *   0.00 / 10000 + le.Populated_registration_status_description_pcnt*ri.Populated_registration_status_description_pcnt *   0.00 / 10000 + le.Populated_registration_status_date_pcnt*ri.Populated_registration_status_date_pcnt *   0.00 / 10000 + le.Populated_registration_renewal_date_pcnt*ri.Populated_registration_renewal_date_pcnt *   0.00 / 10000 + le.Populated_decal_number_pcnt*ri.Populated_decal_number_pcnt *   0.00 / 10000 + le.Populated_transaction_type_code_pcnt*ri.Populated_transaction_type_code_pcnt *   0.00 / 10000 + le.Populated_transaction_type_description_pcnt*ri.Populated_transaction_type_description_pcnt *   0.00 / 10000 + le.Populated_title_state_pcnt*ri.Populated_title_state_pcnt *   0.00 / 10000 + le.Populated_title_status_code_pcnt*ri.Populated_title_status_code_pcnt *   0.00 / 10000 + le.Populated_title_status_description_pcnt*ri.Populated_title_status_description_pcnt *   0.00 / 10000 + le.Populated_title_number_pcnt*ri.Populated_title_number_pcnt *   0.00 / 10000 + le.Populated_title_issue_date_pcnt*ri.Populated_title_issue_date_pcnt *   0.00 / 10000 + le.Populated_title_type_code_pcnt*ri.Populated_title_type_code_pcnt *   0.00 / 10000 + le.Populated_title_type_description_pcnt*ri.Populated_title_type_description_pcnt *   0.00 / 10000 + le.Populated_additional_owner_count_pcnt*ri.Populated_additional_owner_count_pcnt *   0.00 / 10000 + le.Populated_lien_1_indicator_pcnt*ri.Populated_lien_1_indicator_pcnt *   0.00 / 10000 + le.Populated_lien_1_name_pcnt*ri.Populated_lien_1_name_pcnt *   0.00 / 10000 + le.Populated_lien_1_date_pcnt*ri.Populated_lien_1_date_pcnt *   0.00 / 10000 + le.Populated_lien_1_address_1_pcnt*ri.Populated_lien_1_address_1_pcnt *   0.00 / 10000 + le.Populated_lien_1_address_2_pcnt*ri.Populated_lien_1_address_2_pcnt *   0.00 / 10000 + le.Populated_lien_1_city_pcnt*ri.Populated_lien_1_city_pcnt *   0.00 / 10000 + le.Populated_lien_1_state_pcnt*ri.Populated_lien_1_state_pcnt *   0.00 / 10000 + le.Populated_lien_1_zip_pcnt*ri.Populated_lien_1_zip_pcnt *   0.00 / 10000 + le.Populated_lien_2_indicator_pcnt*ri.Populated_lien_2_indicator_pcnt *   0.00 / 10000 + le.Populated_lien_2_name_pcnt*ri.Populated_lien_2_name_pcnt *   0.00 / 10000 + le.Populated_lien_2_date_pcnt*ri.Populated_lien_2_date_pcnt *   0.00 / 10000 + le.Populated_lien_2_address_1_pcnt*ri.Populated_lien_2_address_1_pcnt *   0.00 / 10000 + le.Populated_lien_2_address_2_pcnt*ri.Populated_lien_2_address_2_pcnt *   0.00 / 10000 + le.Populated_lien_2_city_pcnt*ri.Populated_lien_2_city_pcnt *   0.00 / 10000 + le.Populated_lien_2_state_pcnt*ri.Populated_lien_2_state_pcnt *   0.00 / 10000 + le.Populated_lien_2_zip_pcnt*ri.Populated_lien_2_zip_pcnt *   0.00 / 10000 + le.Populated_state_purchased_pcnt*ri.Populated_state_purchased_pcnt *   0.00 / 10000 + le.Populated_purchase_date_pcnt*ri.Populated_purchase_date_pcnt *   0.00 / 10000 + le.Populated_dealer_pcnt*ri.Populated_dealer_pcnt *   0.00 / 10000 + le.Populated_purchase_price_pcnt*ri.Populated_purchase_price_pcnt *   0.00 / 10000 + le.Populated_new_used_flag_pcnt*ri.Populated_new_used_flag_pcnt *   0.00 / 10000 + le.Populated_watercraft_status_code_pcnt*ri.Populated_watercraft_status_code_pcnt *   0.00 / 10000 + le.Populated_watercraft_status_description_pcnt*ri.Populated_watercraft_status_description_pcnt *   0.00 / 10000 + le.Populated_history_flag_pcnt*ri.Populated_history_flag_pcnt *   0.00 / 10000 + le.Populated_coastguard_flag_pcnt*ri.Populated_coastguard_flag_pcnt *   0.00 / 10000 + le.Populated_signatory_pcnt*ri.Populated_signatory_pcnt *   0.00 / 10000 + le.Populated_persistent_record_id_pcnt*ri.Populated_persistent_record_id_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'watercraft_key','sequence_key','watercraft_id','state_origin','source_code','st_registration','county_registration','registration_number','hull_number','propulsion_description','vehicle_type_code','vehicle_type_description','fuel_code','fuel_description','hull_type_code','hull_type_description','use_code','use_description','model_year','watercraft_name','watercraft_class_code','watercraft_class_description','watercraft_make_code','watercraft_make_description','watercraft_model_code','watercraft_model_description','watercraft_length','watercraft_width','watercraft_weight','watercraft_color_1_code','watercraft_color_1_description','watercraft_color_2_code','watercraft_color_2_description','watercraft_toilet_code','watercraft_toilet_description','watercraft_number_of_engines','watercraft_hp_1','watercraft_hp_2','watercraft_hp_3','engine_number_1','engine_number_2','engine_number_3','engine_make_1','engine_make_2','engine_make_3','engine_model_1','engine_model_2','engine_model_3','engine_year_1','engine_year_2','engine_year_3','coast_guard_documented_flag','coast_guard_number','registration_date','registration_expiration_date','registration_status_code','registration_status_description','registration_status_date','registration_renewal_date','decal_number','transaction_type_code','transaction_type_description','title_state','title_status_code','title_status_description','title_number','title_issue_date','title_type_code','title_type_description','additional_owner_count','lien_1_indicator','lien_1_name','lien_1_date','lien_1_address_1','lien_1_address_2','lien_1_city','lien_1_state','lien_1_zip','lien_2_indicator','lien_2_name','lien_2_date','lien_2_address_1','lien_2_address_2','lien_2_city','lien_2_state','lien_2_zip','state_purchased','purchase_date','dealer','purchase_price','new_used_flag','watercraft_status_code','watercraft_status_description','history_flag','coastguard_flag','signatory','persistent_record_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_watercraft_key_pcnt,le.populated_sequence_key_pcnt,le.populated_watercraft_id_pcnt,le.populated_state_origin_pcnt,le.populated_source_code_pcnt,le.populated_st_registration_pcnt,le.populated_county_registration_pcnt,le.populated_registration_number_pcnt,le.populated_hull_number_pcnt,le.populated_propulsion_description_pcnt,le.populated_vehicle_type_code_pcnt,le.populated_vehicle_type_description_pcnt,le.populated_fuel_code_pcnt,le.populated_fuel_description_pcnt,le.populated_hull_type_code_pcnt,le.populated_hull_type_description_pcnt,le.populated_use_code_pcnt,le.populated_use_description_pcnt,le.populated_model_year_pcnt,le.populated_watercraft_name_pcnt,le.populated_watercraft_class_code_pcnt,le.populated_watercraft_class_description_pcnt,le.populated_watercraft_make_code_pcnt,le.populated_watercraft_make_description_pcnt,le.populated_watercraft_model_code_pcnt,le.populated_watercraft_model_description_pcnt,le.populated_watercraft_length_pcnt,le.populated_watercraft_width_pcnt,le.populated_watercraft_weight_pcnt,le.populated_watercraft_color_1_code_pcnt,le.populated_watercraft_color_1_description_pcnt,le.populated_watercraft_color_2_code_pcnt,le.populated_watercraft_color_2_description_pcnt,le.populated_watercraft_toilet_code_pcnt,le.populated_watercraft_toilet_description_pcnt,le.populated_watercraft_number_of_engines_pcnt,le.populated_watercraft_hp_1_pcnt,le.populated_watercraft_hp_2_pcnt,le.populated_watercraft_hp_3_pcnt,le.populated_engine_number_1_pcnt,le.populated_engine_number_2_pcnt,le.populated_engine_number_3_pcnt,le.populated_engine_make_1_pcnt,le.populated_engine_make_2_pcnt,le.populated_engine_make_3_pcnt,le.populated_engine_model_1_pcnt,le.populated_engine_model_2_pcnt,le.populated_engine_model_3_pcnt,le.populated_engine_year_1_pcnt,le.populated_engine_year_2_pcnt,le.populated_engine_year_3_pcnt,le.populated_coast_guard_documented_flag_pcnt,le.populated_coast_guard_number_pcnt,le.populated_registration_date_pcnt,le.populated_registration_expiration_date_pcnt,le.populated_registration_status_code_pcnt,le.populated_registration_status_description_pcnt,le.populated_registration_status_date_pcnt,le.populated_registration_renewal_date_pcnt,le.populated_decal_number_pcnt,le.populated_transaction_type_code_pcnt,le.populated_transaction_type_description_pcnt,le.populated_title_state_pcnt,le.populated_title_status_code_pcnt,le.populated_title_status_description_pcnt,le.populated_title_number_pcnt,le.populated_title_issue_date_pcnt,le.populated_title_type_code_pcnt,le.populated_title_type_description_pcnt,le.populated_additional_owner_count_pcnt,le.populated_lien_1_indicator_pcnt,le.populated_lien_1_name_pcnt,le.populated_lien_1_date_pcnt,le.populated_lien_1_address_1_pcnt,le.populated_lien_1_address_2_pcnt,le.populated_lien_1_city_pcnt,le.populated_lien_1_state_pcnt,le.populated_lien_1_zip_pcnt,le.populated_lien_2_indicator_pcnt,le.populated_lien_2_name_pcnt,le.populated_lien_2_date_pcnt,le.populated_lien_2_address_1_pcnt,le.populated_lien_2_address_2_pcnt,le.populated_lien_2_city_pcnt,le.populated_lien_2_state_pcnt,le.populated_lien_2_zip_pcnt,le.populated_state_purchased_pcnt,le.populated_purchase_date_pcnt,le.populated_dealer_pcnt,le.populated_purchase_price_pcnt,le.populated_new_used_flag_pcnt,le.populated_watercraft_status_code_pcnt,le.populated_watercraft_status_description_pcnt,le.populated_history_flag_pcnt,le.populated_coastguard_flag_pcnt,le.populated_signatory_pcnt,le.populated_persistent_record_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_watercraft_key,le.maxlength_sequence_key,le.maxlength_watercraft_id,le.maxlength_state_origin,le.maxlength_source_code,le.maxlength_st_registration,le.maxlength_county_registration,le.maxlength_registration_number,le.maxlength_hull_number,le.maxlength_propulsion_description,le.maxlength_vehicle_type_code,le.maxlength_vehicle_type_description,le.maxlength_fuel_code,le.maxlength_fuel_description,le.maxlength_hull_type_code,le.maxlength_hull_type_description,le.maxlength_use_code,le.maxlength_use_description,le.maxlength_model_year,le.maxlength_watercraft_name,le.maxlength_watercraft_class_code,le.maxlength_watercraft_class_description,le.maxlength_watercraft_make_code,le.maxlength_watercraft_make_description,le.maxlength_watercraft_model_code,le.maxlength_watercraft_model_description,le.maxlength_watercraft_length,le.maxlength_watercraft_width,le.maxlength_watercraft_weight,le.maxlength_watercraft_color_1_code,le.maxlength_watercraft_color_1_description,le.maxlength_watercraft_color_2_code,le.maxlength_watercraft_color_2_description,le.maxlength_watercraft_toilet_code,le.maxlength_watercraft_toilet_description,le.maxlength_watercraft_number_of_engines,le.maxlength_watercraft_hp_1,le.maxlength_watercraft_hp_2,le.maxlength_watercraft_hp_3,le.maxlength_engine_number_1,le.maxlength_engine_number_2,le.maxlength_engine_number_3,le.maxlength_engine_make_1,le.maxlength_engine_make_2,le.maxlength_engine_make_3,le.maxlength_engine_model_1,le.maxlength_engine_model_2,le.maxlength_engine_model_3,le.maxlength_engine_year_1,le.maxlength_engine_year_2,le.maxlength_engine_year_3,le.maxlength_coast_guard_documented_flag,le.maxlength_coast_guard_number,le.maxlength_registration_date,le.maxlength_registration_expiration_date,le.maxlength_registration_status_code,le.maxlength_registration_status_description,le.maxlength_registration_status_date,le.maxlength_registration_renewal_date,le.maxlength_decal_number,le.maxlength_transaction_type_code,le.maxlength_transaction_type_description,le.maxlength_title_state,le.maxlength_title_status_code,le.maxlength_title_status_description,le.maxlength_title_number,le.maxlength_title_issue_date,le.maxlength_title_type_code,le.maxlength_title_type_description,le.maxlength_additional_owner_count,le.maxlength_lien_1_indicator,le.maxlength_lien_1_name,le.maxlength_lien_1_date,le.maxlength_lien_1_address_1,le.maxlength_lien_1_address_2,le.maxlength_lien_1_city,le.maxlength_lien_1_state,le.maxlength_lien_1_zip,le.maxlength_lien_2_indicator,le.maxlength_lien_2_name,le.maxlength_lien_2_date,le.maxlength_lien_2_address_1,le.maxlength_lien_2_address_2,le.maxlength_lien_2_city,le.maxlength_lien_2_state,le.maxlength_lien_2_zip,le.maxlength_state_purchased,le.maxlength_purchase_date,le.maxlength_dealer,le.maxlength_purchase_price,le.maxlength_new_used_flag,le.maxlength_watercraft_status_code,le.maxlength_watercraft_status_description,le.maxlength_history_flag,le.maxlength_coastguard_flag,le.maxlength_signatory,le.maxlength_persistent_record_id);
  SELF.avelength := CHOOSE(C,le.avelength_watercraft_key,le.avelength_sequence_key,le.avelength_watercraft_id,le.avelength_state_origin,le.avelength_source_code,le.avelength_st_registration,le.avelength_county_registration,le.avelength_registration_number,le.avelength_hull_number,le.avelength_propulsion_description,le.avelength_vehicle_type_code,le.avelength_vehicle_type_description,le.avelength_fuel_code,le.avelength_fuel_description,le.avelength_hull_type_code,le.avelength_hull_type_description,le.avelength_use_code,le.avelength_use_description,le.avelength_model_year,le.avelength_watercraft_name,le.avelength_watercraft_class_code,le.avelength_watercraft_class_description,le.avelength_watercraft_make_code,le.avelength_watercraft_make_description,le.avelength_watercraft_model_code,le.avelength_watercraft_model_description,le.avelength_watercraft_length,le.avelength_watercraft_width,le.avelength_watercraft_weight,le.avelength_watercraft_color_1_code,le.avelength_watercraft_color_1_description,le.avelength_watercraft_color_2_code,le.avelength_watercraft_color_2_description,le.avelength_watercraft_toilet_code,le.avelength_watercraft_toilet_description,le.avelength_watercraft_number_of_engines,le.avelength_watercraft_hp_1,le.avelength_watercraft_hp_2,le.avelength_watercraft_hp_3,le.avelength_engine_number_1,le.avelength_engine_number_2,le.avelength_engine_number_3,le.avelength_engine_make_1,le.avelength_engine_make_2,le.avelength_engine_make_3,le.avelength_engine_model_1,le.avelength_engine_model_2,le.avelength_engine_model_3,le.avelength_engine_year_1,le.avelength_engine_year_2,le.avelength_engine_year_3,le.avelength_coast_guard_documented_flag,le.avelength_coast_guard_number,le.avelength_registration_date,le.avelength_registration_expiration_date,le.avelength_registration_status_code,le.avelength_registration_status_description,le.avelength_registration_status_date,le.avelength_registration_renewal_date,le.avelength_decal_number,le.avelength_transaction_type_code,le.avelength_transaction_type_description,le.avelength_title_state,le.avelength_title_status_code,le.avelength_title_status_description,le.avelength_title_number,le.avelength_title_issue_date,le.avelength_title_type_code,le.avelength_title_type_description,le.avelength_additional_owner_count,le.avelength_lien_1_indicator,le.avelength_lien_1_name,le.avelength_lien_1_date,le.avelength_lien_1_address_1,le.avelength_lien_1_address_2,le.avelength_lien_1_city,le.avelength_lien_1_state,le.avelength_lien_1_zip,le.avelength_lien_2_indicator,le.avelength_lien_2_name,le.avelength_lien_2_date,le.avelength_lien_2_address_1,le.avelength_lien_2_address_2,le.avelength_lien_2_city,le.avelength_lien_2_state,le.avelength_lien_2_zip,le.avelength_state_purchased,le.avelength_purchase_date,le.avelength_dealer,le.avelength_purchase_price,le.avelength_new_used_flag,le.avelength_watercraft_status_code,le.avelength_watercraft_status_description,le.avelength_history_flag,le.avelength_coastguard_flag,le.avelength_signatory,le.avelength_persistent_record_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 97, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.source_code;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.watercraft_key),TRIM((SALT30.StrType)le.sequence_key),TRIM((SALT30.StrType)le.watercraft_id),TRIM((SALT30.StrType)le.state_origin),TRIM((SALT30.StrType)le.source_code),TRIM((SALT30.StrType)le.st_registration),TRIM((SALT30.StrType)le.county_registration),TRIM((SALT30.StrType)le.registration_number),TRIM((SALT30.StrType)le.hull_number),TRIM((SALT30.StrType)le.propulsion_description),TRIM((SALT30.StrType)le.vehicle_type_code),TRIM((SALT30.StrType)le.vehicle_type_description),TRIM((SALT30.StrType)le.fuel_code),TRIM((SALT30.StrType)le.fuel_description),TRIM((SALT30.StrType)le.hull_type_code),TRIM((SALT30.StrType)le.hull_type_description),TRIM((SALT30.StrType)le.use_code),TRIM((SALT30.StrType)le.use_description),TRIM((SALT30.StrType)le.model_year),TRIM((SALT30.StrType)le.watercraft_name),TRIM((SALT30.StrType)le.watercraft_class_code),TRIM((SALT30.StrType)le.watercraft_class_description),TRIM((SALT30.StrType)le.watercraft_make_code),TRIM((SALT30.StrType)le.watercraft_make_description),TRIM((SALT30.StrType)le.watercraft_model_code),TRIM((SALT30.StrType)le.watercraft_model_description),TRIM((SALT30.StrType)le.watercraft_length),TRIM((SALT30.StrType)le.watercraft_width),TRIM((SALT30.StrType)le.watercraft_weight),TRIM((SALT30.StrType)le.watercraft_color_1_code),TRIM((SALT30.StrType)le.watercraft_color_1_description),TRIM((SALT30.StrType)le.watercraft_color_2_code),TRIM((SALT30.StrType)le.watercraft_color_2_description),TRIM((SALT30.StrType)le.watercraft_toilet_code),TRIM((SALT30.StrType)le.watercraft_toilet_description),TRIM((SALT30.StrType)le.watercraft_number_of_engines),TRIM((SALT30.StrType)le.watercraft_hp_1),TRIM((SALT30.StrType)le.watercraft_hp_2),TRIM((SALT30.StrType)le.watercraft_hp_3),TRIM((SALT30.StrType)le.engine_number_1),TRIM((SALT30.StrType)le.engine_number_2),TRIM((SALT30.StrType)le.engine_number_3),TRIM((SALT30.StrType)le.engine_make_1),TRIM((SALT30.StrType)le.engine_make_2),TRIM((SALT30.StrType)le.engine_make_3),TRIM((SALT30.StrType)le.engine_model_1),TRIM((SALT30.StrType)le.engine_model_2),TRIM((SALT30.StrType)le.engine_model_3),TRIM((SALT30.StrType)le.engine_year_1),TRIM((SALT30.StrType)le.engine_year_2),TRIM((SALT30.StrType)le.engine_year_3),TRIM((SALT30.StrType)le.coast_guard_documented_flag),TRIM((SALT30.StrType)le.coast_guard_number),TRIM((SALT30.StrType)le.registration_date),TRIM((SALT30.StrType)le.registration_expiration_date),TRIM((SALT30.StrType)le.registration_status_code),TRIM((SALT30.StrType)le.registration_status_description),TRIM((SALT30.StrType)le.registration_status_date),TRIM((SALT30.StrType)le.registration_renewal_date),TRIM((SALT30.StrType)le.decal_number),TRIM((SALT30.StrType)le.transaction_type_code),TRIM((SALT30.StrType)le.transaction_type_description),TRIM((SALT30.StrType)le.title_state),TRIM((SALT30.StrType)le.title_status_code),TRIM((SALT30.StrType)le.title_status_description),TRIM((SALT30.StrType)le.title_number),TRIM((SALT30.StrType)le.title_issue_date),TRIM((SALT30.StrType)le.title_type_code),TRIM((SALT30.StrType)le.title_type_description),TRIM((SALT30.StrType)le.additional_owner_count),TRIM((SALT30.StrType)le.lien_1_indicator),TRIM((SALT30.StrType)le.lien_1_name),TRIM((SALT30.StrType)le.lien_1_date),TRIM((SALT30.StrType)le.lien_1_address_1),TRIM((SALT30.StrType)le.lien_1_address_2),TRIM((SALT30.StrType)le.lien_1_city),TRIM((SALT30.StrType)le.lien_1_state),TRIM((SALT30.StrType)le.lien_1_zip),TRIM((SALT30.StrType)le.lien_2_indicator),TRIM((SALT30.StrType)le.lien_2_name),TRIM((SALT30.StrType)le.lien_2_date),TRIM((SALT30.StrType)le.lien_2_address_1),TRIM((SALT30.StrType)le.lien_2_address_2),TRIM((SALT30.StrType)le.lien_2_city),TRIM((SALT30.StrType)le.lien_2_state),TRIM((SALT30.StrType)le.lien_2_zip),TRIM((SALT30.StrType)le.state_purchased),TRIM((SALT30.StrType)le.purchase_date),TRIM((SALT30.StrType)le.dealer),TRIM((SALT30.StrType)le.purchase_price),TRIM((SALT30.StrType)le.new_used_flag),TRIM((SALT30.StrType)le.watercraft_status_code),TRIM((SALT30.StrType)le.watercraft_status_description),TRIM((SALT30.StrType)le.history_flag),TRIM((SALT30.StrType)le.coastguard_flag),TRIM((SALT30.StrType)le.signatory),TRIM((SALT30.StrType)le.persistent_record_id)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,97,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 97);
  SELF.FldNo2 := 1 + (C % 97);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.watercraft_key),TRIM((SALT30.StrType)le.sequence_key),TRIM((SALT30.StrType)le.watercraft_id),TRIM((SALT30.StrType)le.state_origin),TRIM((SALT30.StrType)le.source_code),TRIM((SALT30.StrType)le.st_registration),TRIM((SALT30.StrType)le.county_registration),TRIM((SALT30.StrType)le.registration_number),TRIM((SALT30.StrType)le.hull_number),TRIM((SALT30.StrType)le.propulsion_description),TRIM((SALT30.StrType)le.vehicle_type_code),TRIM((SALT30.StrType)le.vehicle_type_description),TRIM((SALT30.StrType)le.fuel_code),TRIM((SALT30.StrType)le.fuel_description),TRIM((SALT30.StrType)le.hull_type_code),TRIM((SALT30.StrType)le.hull_type_description),TRIM((SALT30.StrType)le.use_code),TRIM((SALT30.StrType)le.use_description),TRIM((SALT30.StrType)le.model_year),TRIM((SALT30.StrType)le.watercraft_name),TRIM((SALT30.StrType)le.watercraft_class_code),TRIM((SALT30.StrType)le.watercraft_class_description),TRIM((SALT30.StrType)le.watercraft_make_code),TRIM((SALT30.StrType)le.watercraft_make_description),TRIM((SALT30.StrType)le.watercraft_model_code),TRIM((SALT30.StrType)le.watercraft_model_description),TRIM((SALT30.StrType)le.watercraft_length),TRIM((SALT30.StrType)le.watercraft_width),TRIM((SALT30.StrType)le.watercraft_weight),TRIM((SALT30.StrType)le.watercraft_color_1_code),TRIM((SALT30.StrType)le.watercraft_color_1_description),TRIM((SALT30.StrType)le.watercraft_color_2_code),TRIM((SALT30.StrType)le.watercraft_color_2_description),TRIM((SALT30.StrType)le.watercraft_toilet_code),TRIM((SALT30.StrType)le.watercraft_toilet_description),TRIM((SALT30.StrType)le.watercraft_number_of_engines),TRIM((SALT30.StrType)le.watercraft_hp_1),TRIM((SALT30.StrType)le.watercraft_hp_2),TRIM((SALT30.StrType)le.watercraft_hp_3),TRIM((SALT30.StrType)le.engine_number_1),TRIM((SALT30.StrType)le.engine_number_2),TRIM((SALT30.StrType)le.engine_number_3),TRIM((SALT30.StrType)le.engine_make_1),TRIM((SALT30.StrType)le.engine_make_2),TRIM((SALT30.StrType)le.engine_make_3),TRIM((SALT30.StrType)le.engine_model_1),TRIM((SALT30.StrType)le.engine_model_2),TRIM((SALT30.StrType)le.engine_model_3),TRIM((SALT30.StrType)le.engine_year_1),TRIM((SALT30.StrType)le.engine_year_2),TRIM((SALT30.StrType)le.engine_year_3),TRIM((SALT30.StrType)le.coast_guard_documented_flag),TRIM((SALT30.StrType)le.coast_guard_number),TRIM((SALT30.StrType)le.registration_date),TRIM((SALT30.StrType)le.registration_expiration_date),TRIM((SALT30.StrType)le.registration_status_code),TRIM((SALT30.StrType)le.registration_status_description),TRIM((SALT30.StrType)le.registration_status_date),TRIM((SALT30.StrType)le.registration_renewal_date),TRIM((SALT30.StrType)le.decal_number),TRIM((SALT30.StrType)le.transaction_type_code),TRIM((SALT30.StrType)le.transaction_type_description),TRIM((SALT30.StrType)le.title_state),TRIM((SALT30.StrType)le.title_status_code),TRIM((SALT30.StrType)le.title_status_description),TRIM((SALT30.StrType)le.title_number),TRIM((SALT30.StrType)le.title_issue_date),TRIM((SALT30.StrType)le.title_type_code),TRIM((SALT30.StrType)le.title_type_description),TRIM((SALT30.StrType)le.additional_owner_count),TRIM((SALT30.StrType)le.lien_1_indicator),TRIM((SALT30.StrType)le.lien_1_name),TRIM((SALT30.StrType)le.lien_1_date),TRIM((SALT30.StrType)le.lien_1_address_1),TRIM((SALT30.StrType)le.lien_1_address_2),TRIM((SALT30.StrType)le.lien_1_city),TRIM((SALT30.StrType)le.lien_1_state),TRIM((SALT30.StrType)le.lien_1_zip),TRIM((SALT30.StrType)le.lien_2_indicator),TRIM((SALT30.StrType)le.lien_2_name),TRIM((SALT30.StrType)le.lien_2_date),TRIM((SALT30.StrType)le.lien_2_address_1),TRIM((SALT30.StrType)le.lien_2_address_2),TRIM((SALT30.StrType)le.lien_2_city),TRIM((SALT30.StrType)le.lien_2_state),TRIM((SALT30.StrType)le.lien_2_zip),TRIM((SALT30.StrType)le.state_purchased),TRIM((SALT30.StrType)le.purchase_date),TRIM((SALT30.StrType)le.dealer),TRIM((SALT30.StrType)le.purchase_price),TRIM((SALT30.StrType)le.new_used_flag),TRIM((SALT30.StrType)le.watercraft_status_code),TRIM((SALT30.StrType)le.watercraft_status_description),TRIM((SALT30.StrType)le.history_flag),TRIM((SALT30.StrType)le.coastguard_flag),TRIM((SALT30.StrType)le.signatory),TRIM((SALT30.StrType)le.persistent_record_id)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.watercraft_key),TRIM((SALT30.StrType)le.sequence_key),TRIM((SALT30.StrType)le.watercraft_id),TRIM((SALT30.StrType)le.state_origin),TRIM((SALT30.StrType)le.source_code),TRIM((SALT30.StrType)le.st_registration),TRIM((SALT30.StrType)le.county_registration),TRIM((SALT30.StrType)le.registration_number),TRIM((SALT30.StrType)le.hull_number),TRIM((SALT30.StrType)le.propulsion_description),TRIM((SALT30.StrType)le.vehicle_type_code),TRIM((SALT30.StrType)le.vehicle_type_description),TRIM((SALT30.StrType)le.fuel_code),TRIM((SALT30.StrType)le.fuel_description),TRIM((SALT30.StrType)le.hull_type_code),TRIM((SALT30.StrType)le.hull_type_description),TRIM((SALT30.StrType)le.use_code),TRIM((SALT30.StrType)le.use_description),TRIM((SALT30.StrType)le.model_year),TRIM((SALT30.StrType)le.watercraft_name),TRIM((SALT30.StrType)le.watercraft_class_code),TRIM((SALT30.StrType)le.watercraft_class_description),TRIM((SALT30.StrType)le.watercraft_make_code),TRIM((SALT30.StrType)le.watercraft_make_description),TRIM((SALT30.StrType)le.watercraft_model_code),TRIM((SALT30.StrType)le.watercraft_model_description),TRIM((SALT30.StrType)le.watercraft_length),TRIM((SALT30.StrType)le.watercraft_width),TRIM((SALT30.StrType)le.watercraft_weight),TRIM((SALT30.StrType)le.watercraft_color_1_code),TRIM((SALT30.StrType)le.watercraft_color_1_description),TRIM((SALT30.StrType)le.watercraft_color_2_code),TRIM((SALT30.StrType)le.watercraft_color_2_description),TRIM((SALT30.StrType)le.watercraft_toilet_code),TRIM((SALT30.StrType)le.watercraft_toilet_description),TRIM((SALT30.StrType)le.watercraft_number_of_engines),TRIM((SALT30.StrType)le.watercraft_hp_1),TRIM((SALT30.StrType)le.watercraft_hp_2),TRIM((SALT30.StrType)le.watercraft_hp_3),TRIM((SALT30.StrType)le.engine_number_1),TRIM((SALT30.StrType)le.engine_number_2),TRIM((SALT30.StrType)le.engine_number_3),TRIM((SALT30.StrType)le.engine_make_1),TRIM((SALT30.StrType)le.engine_make_2),TRIM((SALT30.StrType)le.engine_make_3),TRIM((SALT30.StrType)le.engine_model_1),TRIM((SALT30.StrType)le.engine_model_2),TRIM((SALT30.StrType)le.engine_model_3),TRIM((SALT30.StrType)le.engine_year_1),TRIM((SALT30.StrType)le.engine_year_2),TRIM((SALT30.StrType)le.engine_year_3),TRIM((SALT30.StrType)le.coast_guard_documented_flag),TRIM((SALT30.StrType)le.coast_guard_number),TRIM((SALT30.StrType)le.registration_date),TRIM((SALT30.StrType)le.registration_expiration_date),TRIM((SALT30.StrType)le.registration_status_code),TRIM((SALT30.StrType)le.registration_status_description),TRIM((SALT30.StrType)le.registration_status_date),TRIM((SALT30.StrType)le.registration_renewal_date),TRIM((SALT30.StrType)le.decal_number),TRIM((SALT30.StrType)le.transaction_type_code),TRIM((SALT30.StrType)le.transaction_type_description),TRIM((SALT30.StrType)le.title_state),TRIM((SALT30.StrType)le.title_status_code),TRIM((SALT30.StrType)le.title_status_description),TRIM((SALT30.StrType)le.title_number),TRIM((SALT30.StrType)le.title_issue_date),TRIM((SALT30.StrType)le.title_type_code),TRIM((SALT30.StrType)le.title_type_description),TRIM((SALT30.StrType)le.additional_owner_count),TRIM((SALT30.StrType)le.lien_1_indicator),TRIM((SALT30.StrType)le.lien_1_name),TRIM((SALT30.StrType)le.lien_1_date),TRIM((SALT30.StrType)le.lien_1_address_1),TRIM((SALT30.StrType)le.lien_1_address_2),TRIM((SALT30.StrType)le.lien_1_city),TRIM((SALT30.StrType)le.lien_1_state),TRIM((SALT30.StrType)le.lien_1_zip),TRIM((SALT30.StrType)le.lien_2_indicator),TRIM((SALT30.StrType)le.lien_2_name),TRIM((SALT30.StrType)le.lien_2_date),TRIM((SALT30.StrType)le.lien_2_address_1),TRIM((SALT30.StrType)le.lien_2_address_2),TRIM((SALT30.StrType)le.lien_2_city),TRIM((SALT30.StrType)le.lien_2_state),TRIM((SALT30.StrType)le.lien_2_zip),TRIM((SALT30.StrType)le.state_purchased),TRIM((SALT30.StrType)le.purchase_date),TRIM((SALT30.StrType)le.dealer),TRIM((SALT30.StrType)le.purchase_price),TRIM((SALT30.StrType)le.new_used_flag),TRIM((SALT30.StrType)le.watercraft_status_code),TRIM((SALT30.StrType)le.watercraft_status_description),TRIM((SALT30.StrType)le.history_flag),TRIM((SALT30.StrType)le.coastguard_flag),TRIM((SALT30.StrType)le.signatory),TRIM((SALT30.StrType)le.persistent_record_id)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),97*97,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'watercraft_key'}
      ,{2,'sequence_key'}
      ,{3,'watercraft_id'}
      ,{4,'state_origin'}
      ,{5,'source_code'}
      ,{6,'st_registration'}
      ,{7,'county_registration'}
      ,{8,'registration_number'}
      ,{9,'hull_number'}
      ,{10,'propulsion_description'}
      ,{11,'vehicle_type_code'}
      ,{12,'vehicle_type_description'}
      ,{13,'fuel_code'}
      ,{14,'fuel_description'}
      ,{15,'hull_type_code'}
      ,{16,'hull_type_description'}
      ,{17,'use_code'}
      ,{18,'use_description'}
      ,{19,'model_year'}
      ,{20,'watercraft_name'}
      ,{21,'watercraft_class_code'}
      ,{22,'watercraft_class_description'}
      ,{23,'watercraft_make_code'}
      ,{24,'watercraft_make_description'}
      ,{25,'watercraft_model_code'}
      ,{26,'watercraft_model_description'}
      ,{27,'watercraft_length'}
      ,{28,'watercraft_width'}
      ,{29,'watercraft_weight'}
      ,{30,'watercraft_color_1_code'}
      ,{31,'watercraft_color_1_description'}
      ,{32,'watercraft_color_2_code'}
      ,{33,'watercraft_color_2_description'}
      ,{34,'watercraft_toilet_code'}
      ,{35,'watercraft_toilet_description'}
      ,{36,'watercraft_number_of_engines'}
      ,{37,'watercraft_hp_1'}
      ,{38,'watercraft_hp_2'}
      ,{39,'watercraft_hp_3'}
      ,{40,'engine_number_1'}
      ,{41,'engine_number_2'}
      ,{42,'engine_number_3'}
      ,{43,'engine_make_1'}
      ,{44,'engine_make_2'}
      ,{45,'engine_make_3'}
      ,{46,'engine_model_1'}
      ,{47,'engine_model_2'}
      ,{48,'engine_model_3'}
      ,{49,'engine_year_1'}
      ,{50,'engine_year_2'}
      ,{51,'engine_year_3'}
      ,{52,'coast_guard_documented_flag'}
      ,{53,'coast_guard_number'}
      ,{54,'registration_date'}
      ,{55,'registration_expiration_date'}
      ,{56,'registration_status_code'}
      ,{57,'registration_status_description'}
      ,{58,'registration_status_date'}
      ,{59,'registration_renewal_date'}
      ,{60,'decal_number'}
      ,{61,'transaction_type_code'}
      ,{62,'transaction_type_description'}
      ,{63,'title_state'}
      ,{64,'title_status_code'}
      ,{65,'title_status_description'}
      ,{66,'title_number'}
      ,{67,'title_issue_date'}
      ,{68,'title_type_code'}
      ,{69,'title_type_description'}
      ,{70,'additional_owner_count'}
      ,{71,'lien_1_indicator'}
      ,{72,'lien_1_name'}
      ,{73,'lien_1_date'}
      ,{74,'lien_1_address_1'}
      ,{75,'lien_1_address_2'}
      ,{76,'lien_1_city'}
      ,{77,'lien_1_state'}
      ,{78,'lien_1_zip'}
      ,{79,'lien_2_indicator'}
      ,{80,'lien_2_name'}
      ,{81,'lien_2_date'}
      ,{82,'lien_2_address_1'}
      ,{83,'lien_2_address_2'}
      ,{84,'lien_2_city'}
      ,{85,'lien_2_state'}
      ,{86,'lien_2_zip'}
      ,{87,'state_purchased'}
      ,{88,'purchase_date'}
      ,{89,'dealer'}
      ,{90,'purchase_price'}
      ,{91,'new_used_flag'}
      ,{92,'watercraft_status_code'}
      ,{93,'watercraft_status_description'}
      ,{94,'history_flag'}
      ,{95,'coastguard_flag'}
      ,{96,'signatory'}
      ,{97,'persistent_record_id'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source_code) source_code; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_watercraft_key((SALT30.StrType)le.watercraft_key),
    Fields.InValid_sequence_key((SALT30.StrType)le.sequence_key),
    Fields.InValid_watercraft_id((SALT30.StrType)le.watercraft_id),
    Fields.InValid_state_origin((SALT30.StrType)le.state_origin),
    Fields.InValid_source_code((SALT30.StrType)le.source_code),
    Fields.InValid_st_registration((SALT30.StrType)le.st_registration),
    Fields.InValid_county_registration((SALT30.StrType)le.county_registration),
    Fields.InValid_registration_number((SALT30.StrType)le.registration_number),
    Fields.InValid_hull_number((SALT30.StrType)le.hull_number),
    Fields.InValid_propulsion_description((SALT30.StrType)le.propulsion_description),
    Fields.InValid_vehicle_type_code((SALT30.StrType)le.vehicle_type_code),
    Fields.InValid_vehicle_type_description((SALT30.StrType)le.vehicle_type_description),
    Fields.InValid_fuel_code((SALT30.StrType)le.fuel_code),
    Fields.InValid_fuel_description((SALT30.StrType)le.fuel_description),
    Fields.InValid_hull_type_code((SALT30.StrType)le.hull_type_code),
    Fields.InValid_hull_type_description((SALT30.StrType)le.hull_type_description),
    Fields.InValid_use_code((SALT30.StrType)le.use_code),
    Fields.InValid_use_description((SALT30.StrType)le.use_description),
    Fields.InValid_model_year((SALT30.StrType)le.model_year),
    Fields.InValid_watercraft_name((SALT30.StrType)le.watercraft_name),
    Fields.InValid_watercraft_class_code((SALT30.StrType)le.watercraft_class_code),
    Fields.InValid_watercraft_class_description((SALT30.StrType)le.watercraft_class_description),
    Fields.InValid_watercraft_make_code((SALT30.StrType)le.watercraft_make_code),
    Fields.InValid_watercraft_make_description((SALT30.StrType)le.watercraft_make_description),
    Fields.InValid_watercraft_model_code((SALT30.StrType)le.watercraft_model_code),
    Fields.InValid_watercraft_model_description((SALT30.StrType)le.watercraft_model_description),
    Fields.InValid_watercraft_length((SALT30.StrType)le.watercraft_length),
    Fields.InValid_watercraft_width((SALT30.StrType)le.watercraft_width),
    Fields.InValid_watercraft_weight((SALT30.StrType)le.watercraft_weight),
    Fields.InValid_watercraft_color_1_code((SALT30.StrType)le.watercraft_color_1_code),
    Fields.InValid_watercraft_color_1_description((SALT30.StrType)le.watercraft_color_1_description),
    Fields.InValid_watercraft_color_2_code((SALT30.StrType)le.watercraft_color_2_code),
    Fields.InValid_watercraft_color_2_description((SALT30.StrType)le.watercraft_color_2_description),
    Fields.InValid_watercraft_toilet_code((SALT30.StrType)le.watercraft_toilet_code),
    Fields.InValid_watercraft_toilet_description((SALT30.StrType)le.watercraft_toilet_description),
    Fields.InValid_watercraft_number_of_engines((SALT30.StrType)le.watercraft_number_of_engines),
    Fields.InValid_watercraft_hp_1((SALT30.StrType)le.watercraft_hp_1),
    Fields.InValid_watercraft_hp_2((SALT30.StrType)le.watercraft_hp_2),
    Fields.InValid_watercraft_hp_3((SALT30.StrType)le.watercraft_hp_3),
    Fields.InValid_engine_number_1((SALT30.StrType)le.engine_number_1),
    Fields.InValid_engine_number_2((SALT30.StrType)le.engine_number_2),
    Fields.InValid_engine_number_3((SALT30.StrType)le.engine_number_3),
    Fields.InValid_engine_make_1((SALT30.StrType)le.engine_make_1),
    Fields.InValid_engine_make_2((SALT30.StrType)le.engine_make_2),
    Fields.InValid_engine_make_3((SALT30.StrType)le.engine_make_3),
    Fields.InValid_engine_model_1((SALT30.StrType)le.engine_model_1),
    Fields.InValid_engine_model_2((SALT30.StrType)le.engine_model_2),
    Fields.InValid_engine_model_3((SALT30.StrType)le.engine_model_3),
    Fields.InValid_engine_year_1((SALT30.StrType)le.engine_year_1),
    Fields.InValid_engine_year_2((SALT30.StrType)le.engine_year_2),
    Fields.InValid_engine_year_3((SALT30.StrType)le.engine_year_3),
    Fields.InValid_coast_guard_documented_flag((SALT30.StrType)le.coast_guard_documented_flag),
    Fields.InValid_coast_guard_number((SALT30.StrType)le.coast_guard_number),
    Fields.InValid_registration_date((SALT30.StrType)le.registration_date),
    Fields.InValid_registration_expiration_date((SALT30.StrType)le.registration_expiration_date),
    Fields.InValid_registration_status_code((SALT30.StrType)le.registration_status_code),
    Fields.InValid_registration_status_description((SALT30.StrType)le.registration_status_description),
    Fields.InValid_registration_status_date((SALT30.StrType)le.registration_status_date),
    Fields.InValid_registration_renewal_date((SALT30.StrType)le.registration_renewal_date),
    Fields.InValid_decal_number((SALT30.StrType)le.decal_number),
    Fields.InValid_transaction_type_code((SALT30.StrType)le.transaction_type_code),
    Fields.InValid_transaction_type_description((SALT30.StrType)le.transaction_type_description),
    Fields.InValid_title_state((SALT30.StrType)le.title_state),
    Fields.InValid_title_status_code((SALT30.StrType)le.title_status_code),
    Fields.InValid_title_status_description((SALT30.StrType)le.title_status_description),
    Fields.InValid_title_number((SALT30.StrType)le.title_number),
    Fields.InValid_title_issue_date((SALT30.StrType)le.title_issue_date),
    Fields.InValid_title_type_code((SALT30.StrType)le.title_type_code),
    Fields.InValid_title_type_description((SALT30.StrType)le.title_type_description),
    Fields.InValid_additional_owner_count((SALT30.StrType)le.additional_owner_count),
    Fields.InValid_lien_1_indicator((SALT30.StrType)le.lien_1_indicator),
    Fields.InValid_lien_1_name((SALT30.StrType)le.lien_1_name),
    Fields.InValid_lien_1_date((SALT30.StrType)le.lien_1_date),
    Fields.InValid_lien_1_address_1((SALT30.StrType)le.lien_1_address_1),
    Fields.InValid_lien_1_address_2((SALT30.StrType)le.lien_1_address_2),
    Fields.InValid_lien_1_city((SALT30.StrType)le.lien_1_city),
    Fields.InValid_lien_1_state((SALT30.StrType)le.lien_1_state),
    Fields.InValid_lien_1_zip((SALT30.StrType)le.lien_1_zip),
    Fields.InValid_lien_2_indicator((SALT30.StrType)le.lien_2_indicator),
    Fields.InValid_lien_2_name((SALT30.StrType)le.lien_2_name),
    Fields.InValid_lien_2_date((SALT30.StrType)le.lien_2_date),
    Fields.InValid_lien_2_address_1((SALT30.StrType)le.lien_2_address_1),
    Fields.InValid_lien_2_address_2((SALT30.StrType)le.lien_2_address_2),
    Fields.InValid_lien_2_city((SALT30.StrType)le.lien_2_city),
    Fields.InValid_lien_2_state((SALT30.StrType)le.lien_2_state),
    Fields.InValid_lien_2_zip((SALT30.StrType)le.lien_2_zip),
    Fields.InValid_state_purchased((SALT30.StrType)le.state_purchased),
    Fields.InValid_purchase_date((SALT30.StrType)le.purchase_date),
    Fields.InValid_dealer((SALT30.StrType)le.dealer),
    Fields.InValid_purchase_price((SALT30.StrType)le.purchase_price),
    Fields.InValid_new_used_flag((SALT30.StrType)le.new_used_flag),
    Fields.InValid_watercraft_status_code((SALT30.StrType)le.watercraft_status_code),
    Fields.InValid_watercraft_status_description((SALT30.StrType)le.watercraft_status_description),
    Fields.InValid_history_flag((SALT30.StrType)le.history_flag),
    Fields.InValid_coastguard_flag((SALT30.StrType)le.coastguard_flag),
    Fields.InValid_signatory((SALT30.StrType)le.signatory),
    Fields.InValid_persistent_record_id((SALT30.StrType)le.persistent_record_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source_code := le.source_code;
END;
Errors := NORMALIZE(h,97,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source_code;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source_code,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source_code;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_blank','Unknown','Unknown','invalid_state','invalid_source_code','invalid_state','invalid_alnum','invalid_alnum','invalid_hull_number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_year','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_numeric','invalid_numeric','invalid_numeric','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','Unknown','Unknown','invalid_date','invalid_date','invalid_alnum','Unknown','Unknown','invalid_state','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','invalid_name','invalid_date','invalid_address','invalid_name','invalid_alpha','invalid_state','invalid_zip','Unknown','invalid_name','invalid_date','invalid_address','invalid_name','invalid_alpha','invalid_state','invalid_zip','invalid_state','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_history_flag','Unknown','Unknown','invalid_blank');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_watercraft_key(TotalErrors.ErrorNum),Fields.InValidMessage_sequence_key(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_id(TotalErrors.ErrorNum),Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_source_code(TotalErrors.ErrorNum),Fields.InValidMessage_st_registration(TotalErrors.ErrorNum),Fields.InValidMessage_county_registration(TotalErrors.ErrorNum),Fields.InValidMessage_registration_number(TotalErrors.ErrorNum),Fields.InValidMessage_hull_number(TotalErrors.ErrorNum),Fields.InValidMessage_propulsion_description(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_type_description(TotalErrors.ErrorNum),Fields.InValidMessage_fuel_code(TotalErrors.ErrorNum),Fields.InValidMessage_fuel_description(TotalErrors.ErrorNum),Fields.InValidMessage_hull_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_hull_type_description(TotalErrors.ErrorNum),Fields.InValidMessage_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_use_description(TotalErrors.ErrorNum),Fields.InValidMessage_model_year(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_name(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_class_code(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_class_description(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_make_code(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_make_description(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_model_code(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_model_description(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_length(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_width(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_weight(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_color_1_code(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_color_1_description(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_color_2_code(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_color_2_description(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_toilet_code(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_toilet_description(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_number_of_engines(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_hp_1(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_hp_2(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_hp_3(TotalErrors.ErrorNum),Fields.InValidMessage_engine_number_1(TotalErrors.ErrorNum),Fields.InValidMessage_engine_number_2(TotalErrors.ErrorNum),Fields.InValidMessage_engine_number_3(TotalErrors.ErrorNum),Fields.InValidMessage_engine_make_1(TotalErrors.ErrorNum),Fields.InValidMessage_engine_make_2(TotalErrors.ErrorNum),Fields.InValidMessage_engine_make_3(TotalErrors.ErrorNum),Fields.InValidMessage_engine_model_1(TotalErrors.ErrorNum),Fields.InValidMessage_engine_model_2(TotalErrors.ErrorNum),Fields.InValidMessage_engine_model_3(TotalErrors.ErrorNum),Fields.InValidMessage_engine_year_1(TotalErrors.ErrorNum),Fields.InValidMessage_engine_year_2(TotalErrors.ErrorNum),Fields.InValidMessage_engine_year_3(TotalErrors.ErrorNum),Fields.InValidMessage_coast_guard_documented_flag(TotalErrors.ErrorNum),Fields.InValidMessage_coast_guard_number(TotalErrors.ErrorNum),Fields.InValidMessage_registration_date(TotalErrors.ErrorNum),Fields.InValidMessage_registration_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_registration_status_code(TotalErrors.ErrorNum),Fields.InValidMessage_registration_status_description(TotalErrors.ErrorNum),Fields.InValidMessage_registration_status_date(TotalErrors.ErrorNum),Fields.InValidMessage_registration_renewal_date(TotalErrors.ErrorNum),Fields.InValidMessage_decal_number(TotalErrors.ErrorNum),Fields.InValidMessage_transaction_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_transaction_type_description(TotalErrors.ErrorNum),Fields.InValidMessage_title_state(TotalErrors.ErrorNum),Fields.InValidMessage_title_status_code(TotalErrors.ErrorNum),Fields.InValidMessage_title_status_description(TotalErrors.ErrorNum),Fields.InValidMessage_title_number(TotalErrors.ErrorNum),Fields.InValidMessage_title_issue_date(TotalErrors.ErrorNum),Fields.InValidMessage_title_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_title_type_description(TotalErrors.ErrorNum),Fields.InValidMessage_additional_owner_count(TotalErrors.ErrorNum),Fields.InValidMessage_lien_1_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_lien_1_name(TotalErrors.ErrorNum),Fields.InValidMessage_lien_1_date(TotalErrors.ErrorNum),Fields.InValidMessage_lien_1_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_lien_1_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_lien_1_city(TotalErrors.ErrorNum),Fields.InValidMessage_lien_1_state(TotalErrors.ErrorNum),Fields.InValidMessage_lien_1_zip(TotalErrors.ErrorNum),Fields.InValidMessage_lien_2_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_lien_2_name(TotalErrors.ErrorNum),Fields.InValidMessage_lien_2_date(TotalErrors.ErrorNum),Fields.InValidMessage_lien_2_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_lien_2_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_lien_2_city(TotalErrors.ErrorNum),Fields.InValidMessage_lien_2_state(TotalErrors.ErrorNum),Fields.InValidMessage_lien_2_zip(TotalErrors.ErrorNum),Fields.InValidMessage_state_purchased(TotalErrors.ErrorNum),Fields.InValidMessage_purchase_date(TotalErrors.ErrorNum),Fields.InValidMessage_dealer(TotalErrors.ErrorNum),Fields.InValidMessage_purchase_price(TotalErrors.ErrorNum),Fields.InValidMessage_new_used_flag(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_status_code(TotalErrors.ErrorNum),Fields.InValidMessage_watercraft_status_description(TotalErrors.ErrorNum),Fields.InValidMessage_history_flag(TotalErrors.ErrorNum),Fields.InValidMessage_coastguard_flag(TotalErrors.ErrorNum),Fields.InValidMessage_signatory(TotalErrors.ErrorNum),Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source_code=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
