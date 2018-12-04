IMPORT SALT311,STD;
EXPORT BaseFile_hygiene(dataset(BaseFile_layout_VINA) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_match_make_cnt := COUNT(GROUP,h.match_make <> (TYPEOF(h.match_make))'');
    populated_match_make_pcnt := AVE(GROUP,IF(h.match_make = (TYPEOF(h.match_make))'',0,100));
    maxlength_match_make := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_make)));
    avelength_match_make := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_make)),h.match_make<>(typeof(h.match_make))'');
    populated_match_year_cnt := COUNT(GROUP,h.match_year <> (TYPEOF(h.match_year))'');
    populated_match_year_pcnt := AVE(GROUP,IF(h.match_year = (TYPEOF(h.match_year))'',0,100));
    maxlength_match_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_year)));
    avelength_match_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_year)),h.match_year<>(typeof(h.match_year))'');
    populated_match_vin_cnt := COUNT(GROUP,h.match_vin <> (TYPEOF(h.match_vin))'');
    populated_match_vin_pcnt := AVE(GROUP,IF(h.match_vin = (TYPEOF(h.match_vin))'',0,100));
    maxlength_match_vin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_vin)));
    avelength_match_vin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_vin)),h.match_vin<>(typeof(h.match_vin))'');
    populated_make_abbreviation_cnt := COUNT(GROUP,h.make_abbreviation <> (TYPEOF(h.make_abbreviation))'');
    populated_make_abbreviation_pcnt := AVE(GROUP,IF(h.make_abbreviation = (TYPEOF(h.make_abbreviation))'',0,100));
    maxlength_make_abbreviation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.make_abbreviation)));
    avelength_make_abbreviation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.make_abbreviation)),h.make_abbreviation<>(typeof(h.make_abbreviation))'');
    populated_model_year_cnt := COUNT(GROUP,h.model_year <> (TYPEOF(h.model_year))'');
    populated_model_year_pcnt := AVE(GROUP,IF(h.model_year = (TYPEOF(h.model_year))'',0,100));
    maxlength_model_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_year)));
    avelength_model_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_year)),h.model_year<>(typeof(h.model_year))'');
    populated_vehicle_type_cnt := COUNT(GROUP,h.vehicle_type <> (TYPEOF(h.vehicle_type))'');
    populated_vehicle_type_pcnt := AVE(GROUP,IF(h.vehicle_type = (TYPEOF(h.vehicle_type))'',0,100));
    maxlength_vehicle_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicle_type)));
    avelength_vehicle_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicle_type)),h.vehicle_type<>(typeof(h.vehicle_type))'');
    populated_make_name_cnt := COUNT(GROUP,h.make_name <> (TYPEOF(h.make_name))'');
    populated_make_name_pcnt := AVE(GROUP,IF(h.make_name = (TYPEOF(h.make_name))'',0,100));
    maxlength_make_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.make_name)));
    avelength_make_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.make_name)),h.make_name<>(typeof(h.make_name))'');
    populated_series_name_cnt := COUNT(GROUP,h.series_name <> (TYPEOF(h.series_name))'');
    populated_series_name_pcnt := AVE(GROUP,IF(h.series_name = (TYPEOF(h.series_name))'',0,100));
    maxlength_series_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.series_name)));
    avelength_series_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.series_name)),h.series_name<>(typeof(h.series_name))'');
    populated_body_type_cnt := COUNT(GROUP,h.body_type <> (TYPEOF(h.body_type))'');
    populated_body_type_pcnt := AVE(GROUP,IF(h.body_type = (TYPEOF(h.body_type))'',0,100));
    maxlength_body_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.body_type)));
    avelength_body_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.body_type)),h.body_type<>(typeof(h.body_type))'');
    populated_wheels_cnt := COUNT(GROUP,h.wheels <> (TYPEOF(h.wheels))'');
    populated_wheels_pcnt := AVE(GROUP,IF(h.wheels = (TYPEOF(h.wheels))'',0,100));
    maxlength_wheels := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.wheels)));
    avelength_wheels := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.wheels)),h.wheels<>(typeof(h.wheels))'');
    populated_displacement_cnt := COUNT(GROUP,h.displacement <> (TYPEOF(h.displacement))'');
    populated_displacement_pcnt := AVE(GROUP,IF(h.displacement = (TYPEOF(h.displacement))'',0,100));
    maxlength_displacement := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.displacement)));
    avelength_displacement := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.displacement)),h.displacement<>(typeof(h.displacement))'');
    populated_cylinders_cnt := COUNT(GROUP,h.cylinders <> (TYPEOF(h.cylinders))'');
    populated_cylinders_pcnt := AVE(GROUP,IF(h.cylinders = (TYPEOF(h.cylinders))'',0,100));
    maxlength_cylinders := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cylinders)));
    avelength_cylinders := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cylinders)),h.cylinders<>(typeof(h.cylinders))'');
    populated_fuel_cnt := COUNT(GROUP,h.fuel <> (TYPEOF(h.fuel))'');
    populated_fuel_pcnt := AVE(GROUP,IF(h.fuel = (TYPEOF(h.fuel))'',0,100));
    maxlength_fuel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fuel)));
    avelength_fuel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fuel)),h.fuel<>(typeof(h.fuel))'');
    populated_carburetion_cnt := COUNT(GROUP,h.carburetion <> (TYPEOF(h.carburetion))'');
    populated_carburetion_pcnt := AVE(GROUP,IF(h.carburetion = (TYPEOF(h.carburetion))'',0,100));
    maxlength_carburetion := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carburetion)));
    avelength_carburetion := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carburetion)),h.carburetion<>(typeof(h.carburetion))'');
    populated_gvw_cnt := COUNT(GROUP,h.gvw <> (TYPEOF(h.gvw))'');
    populated_gvw_pcnt := AVE(GROUP,IF(h.gvw = (TYPEOF(h.gvw))'',0,100));
    maxlength_gvw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gvw)));
    avelength_gvw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gvw)),h.gvw<>(typeof(h.gvw))'');
    populated_wheel_base_cnt := COUNT(GROUP,h.wheel_base <> (TYPEOF(h.wheel_base))'');
    populated_wheel_base_pcnt := AVE(GROUP,IF(h.wheel_base = (TYPEOF(h.wheel_base))'',0,100));
    maxlength_wheel_base := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.wheel_base)));
    avelength_wheel_base := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.wheel_base)),h.wheel_base<>(typeof(h.wheel_base))'');
    populated_tire_size_cnt := COUNT(GROUP,h.tire_size <> (TYPEOF(h.tire_size))'');
    populated_tire_size_pcnt := AVE(GROUP,IF(h.tire_size = (TYPEOF(h.tire_size))'',0,100));
    maxlength_tire_size := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tire_size)));
    avelength_tire_size := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tire_size)),h.tire_size<>(typeof(h.tire_size))'');
    populated_ton_rating_cnt := COUNT(GROUP,h.ton_rating <> (TYPEOF(h.ton_rating))'');
    populated_ton_rating_pcnt := AVE(GROUP,IF(h.ton_rating = (TYPEOF(h.ton_rating))'',0,100));
    maxlength_ton_rating := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ton_rating)));
    avelength_ton_rating := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ton_rating)),h.ton_rating<>(typeof(h.ton_rating))'');
    populated_base_shipping_weight_cnt := COUNT(GROUP,h.base_shipping_weight <> (TYPEOF(h.base_shipping_weight))'');
    populated_base_shipping_weight_pcnt := AVE(GROUP,IF(h.base_shipping_weight = (TYPEOF(h.base_shipping_weight))'',0,100));
    maxlength_base_shipping_weight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.base_shipping_weight)));
    avelength_base_shipping_weight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.base_shipping_weight)),h.base_shipping_weight<>(typeof(h.base_shipping_weight))'');
    populated_variance_weight_cnt := COUNT(GROUP,h.variance_weight <> (TYPEOF(h.variance_weight))'');
    populated_variance_weight_pcnt := AVE(GROUP,IF(h.variance_weight = (TYPEOF(h.variance_weight))'',0,100));
    maxlength_variance_weight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.variance_weight)));
    avelength_variance_weight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.variance_weight)),h.variance_weight<>(typeof(h.variance_weight))'');
    populated_base_list_price_cnt := COUNT(GROUP,h.base_list_price <> (TYPEOF(h.base_list_price))'');
    populated_base_list_price_pcnt := AVE(GROUP,IF(h.base_list_price = (TYPEOF(h.base_list_price))'',0,100));
    maxlength_base_list_price := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.base_list_price)));
    avelength_base_list_price := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.base_list_price)),h.base_list_price<>(typeof(h.base_list_price))'');
    populated_price_variance_cnt := COUNT(GROUP,h.price_variance <> (TYPEOF(h.price_variance))'');
    populated_price_variance_pcnt := AVE(GROUP,IF(h.price_variance = (TYPEOF(h.price_variance))'',0,100));
    maxlength_price_variance := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.price_variance)));
    avelength_price_variance := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.price_variance)),h.price_variance<>(typeof(h.price_variance))'');
    populated_high_performance_code_cnt := COUNT(GROUP,h.high_performance_code <> (TYPEOF(h.high_performance_code))'');
    populated_high_performance_code_pcnt := AVE(GROUP,IF(h.high_performance_code = (TYPEOF(h.high_performance_code))'',0,100));
    maxlength_high_performance_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_performance_code)));
    avelength_high_performance_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_performance_code)),h.high_performance_code<>(typeof(h.high_performance_code))'');
    populated_driving_wheels_cnt := COUNT(GROUP,h.driving_wheels <> (TYPEOF(h.driving_wheels))'');
    populated_driving_wheels_pcnt := AVE(GROUP,IF(h.driving_wheels = (TYPEOF(h.driving_wheels))'',0,100));
    maxlength_driving_wheels := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.driving_wheels)));
    avelength_driving_wheels := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.driving_wheels)),h.driving_wheels<>(typeof(h.driving_wheels))'');
    populated_iso_physical_damage_cnt := COUNT(GROUP,h.iso_physical_damage <> (TYPEOF(h.iso_physical_damage))'');
    populated_iso_physical_damage_pcnt := AVE(GROUP,IF(h.iso_physical_damage = (TYPEOF(h.iso_physical_damage))'',0,100));
    maxlength_iso_physical_damage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.iso_physical_damage)));
    avelength_iso_physical_damage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.iso_physical_damage)),h.iso_physical_damage<>(typeof(h.iso_physical_damage))'');
    populated_location_indicator_cnt := COUNT(GROUP,h.location_indicator <> (TYPEOF(h.location_indicator))'');
    populated_location_indicator_pcnt := AVE(GROUP,IF(h.location_indicator = (TYPEOF(h.location_indicator))'',0,100));
    maxlength_location_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_indicator)));
    avelength_location_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_indicator)),h.location_indicator<>(typeof(h.location_indicator))'');
    populated_air_conditioning_cnt := COUNT(GROUP,h.air_conditioning <> (TYPEOF(h.air_conditioning))'');
    populated_air_conditioning_pcnt := AVE(GROUP,IF(h.air_conditioning = (TYPEOF(h.air_conditioning))'',0,100));
    maxlength_air_conditioning := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_conditioning)));
    avelength_air_conditioning := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_conditioning)),h.air_conditioning<>(typeof(h.air_conditioning))'');
    populated_power_steering_cnt := COUNT(GROUP,h.power_steering <> (TYPEOF(h.power_steering))'');
    populated_power_steering_pcnt := AVE(GROUP,IF(h.power_steering = (TYPEOF(h.power_steering))'',0,100));
    maxlength_power_steering := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.power_steering)));
    avelength_power_steering := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.power_steering)),h.power_steering<>(typeof(h.power_steering))'');
    populated_power_brakes_cnt := COUNT(GROUP,h.power_brakes <> (TYPEOF(h.power_brakes))'');
    populated_power_brakes_pcnt := AVE(GROUP,IF(h.power_brakes = (TYPEOF(h.power_brakes))'',0,100));
    maxlength_power_brakes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.power_brakes)));
    avelength_power_brakes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.power_brakes)),h.power_brakes<>(typeof(h.power_brakes))'');
    populated_power_windows_cnt := COUNT(GROUP,h.power_windows <> (TYPEOF(h.power_windows))'');
    populated_power_windows_pcnt := AVE(GROUP,IF(h.power_windows = (TYPEOF(h.power_windows))'',0,100));
    maxlength_power_windows := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.power_windows)));
    avelength_power_windows := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.power_windows)),h.power_windows<>(typeof(h.power_windows))'');
    populated_tilt_wheel_cnt := COUNT(GROUP,h.tilt_wheel <> (TYPEOF(h.tilt_wheel))'');
    populated_tilt_wheel_pcnt := AVE(GROUP,IF(h.tilt_wheel = (TYPEOF(h.tilt_wheel))'',0,100));
    maxlength_tilt_wheel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tilt_wheel)));
    avelength_tilt_wheel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tilt_wheel)),h.tilt_wheel<>(typeof(h.tilt_wheel))'');
    populated_roof_cnt := COUNT(GROUP,h.roof <> (TYPEOF(h.roof))'');
    populated_roof_pcnt := AVE(GROUP,IF(h.roof = (TYPEOF(h.roof))'',0,100));
    maxlength_roof := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.roof)));
    avelength_roof := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.roof)),h.roof<>(typeof(h.roof))'');
    populated_optional_roof1_cnt := COUNT(GROUP,h.optional_roof1 <> (TYPEOF(h.optional_roof1))'');
    populated_optional_roof1_pcnt := AVE(GROUP,IF(h.optional_roof1 = (TYPEOF(h.optional_roof1))'',0,100));
    maxlength_optional_roof1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_roof1)));
    avelength_optional_roof1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_roof1)),h.optional_roof1<>(typeof(h.optional_roof1))'');
    populated_optional_roof2_cnt := COUNT(GROUP,h.optional_roof2 <> (TYPEOF(h.optional_roof2))'');
    populated_optional_roof2_pcnt := AVE(GROUP,IF(h.optional_roof2 = (TYPEOF(h.optional_roof2))'',0,100));
    maxlength_optional_roof2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_roof2)));
    avelength_optional_roof2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_roof2)),h.optional_roof2<>(typeof(h.optional_roof2))'');
    populated_radio_cnt := COUNT(GROUP,h.radio <> (TYPEOF(h.radio))'');
    populated_radio_pcnt := AVE(GROUP,IF(h.radio = (TYPEOF(h.radio))'',0,100));
    maxlength_radio := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.radio)));
    avelength_radio := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.radio)),h.radio<>(typeof(h.radio))'');
    populated_optional_radio1_cnt := COUNT(GROUP,h.optional_radio1 <> (TYPEOF(h.optional_radio1))'');
    populated_optional_radio1_pcnt := AVE(GROUP,IF(h.optional_radio1 = (TYPEOF(h.optional_radio1))'',0,100));
    maxlength_optional_radio1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_radio1)));
    avelength_optional_radio1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_radio1)),h.optional_radio1<>(typeof(h.optional_radio1))'');
    populated_optional_radio2_cnt := COUNT(GROUP,h.optional_radio2 <> (TYPEOF(h.optional_radio2))'');
    populated_optional_radio2_pcnt := AVE(GROUP,IF(h.optional_radio2 = (TYPEOF(h.optional_radio2))'',0,100));
    maxlength_optional_radio2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_radio2)));
    avelength_optional_radio2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_radio2)),h.optional_radio2<>(typeof(h.optional_radio2))'');
    populated_transmission_cnt := COUNT(GROUP,h.transmission <> (TYPEOF(h.transmission))'');
    populated_transmission_pcnt := AVE(GROUP,IF(h.transmission = (TYPEOF(h.transmission))'',0,100));
    maxlength_transmission := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission)));
    avelength_transmission := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission)),h.transmission<>(typeof(h.transmission))'');
    populated_optional_transmission1_cnt := COUNT(GROUP,h.optional_transmission1 <> (TYPEOF(h.optional_transmission1))'');
    populated_optional_transmission1_pcnt := AVE(GROUP,IF(h.optional_transmission1 = (TYPEOF(h.optional_transmission1))'',0,100));
    maxlength_optional_transmission1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_transmission1)));
    avelength_optional_transmission1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_transmission1)),h.optional_transmission1<>(typeof(h.optional_transmission1))'');
    populated_optional_transmission2_cnt := COUNT(GROUP,h.optional_transmission2 <> (TYPEOF(h.optional_transmission2))'');
    populated_optional_transmission2_pcnt := AVE(GROUP,IF(h.optional_transmission2 = (TYPEOF(h.optional_transmission2))'',0,100));
    maxlength_optional_transmission2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_transmission2)));
    avelength_optional_transmission2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.optional_transmission2)),h.optional_transmission2<>(typeof(h.optional_transmission2))'');
    populated_anti_lock_brakes_cnt := COUNT(GROUP,h.anti_lock_brakes <> (TYPEOF(h.anti_lock_brakes))'');
    populated_anti_lock_brakes_pcnt := AVE(GROUP,IF(h.anti_lock_brakes = (TYPEOF(h.anti_lock_brakes))'',0,100));
    maxlength_anti_lock_brakes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.anti_lock_brakes)));
    avelength_anti_lock_brakes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.anti_lock_brakes)),h.anti_lock_brakes<>(typeof(h.anti_lock_brakes))'');
    populated_security_system_cnt := COUNT(GROUP,h.security_system <> (TYPEOF(h.security_system))'');
    populated_security_system_pcnt := AVE(GROUP,IF(h.security_system = (TYPEOF(h.security_system))'',0,100));
    maxlength_security_system := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.security_system)));
    avelength_security_system := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.security_system)),h.security_system<>(typeof(h.security_system))'');
    populated_daytime_running_lights_cnt := COUNT(GROUP,h.daytime_running_lights <> (TYPEOF(h.daytime_running_lights))'');
    populated_daytime_running_lights_pcnt := AVE(GROUP,IF(h.daytime_running_lights = (TYPEOF(h.daytime_running_lights))'',0,100));
    maxlength_daytime_running_lights := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.daytime_running_lights)));
    avelength_daytime_running_lights := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.daytime_running_lights)),h.daytime_running_lights<>(typeof(h.daytime_running_lights))'');
    populated_visrap_cnt := COUNT(GROUP,h.visrap <> (TYPEOF(h.visrap))'');
    populated_visrap_pcnt := AVE(GROUP,IF(h.visrap = (TYPEOF(h.visrap))'',0,100));
    maxlength_visrap := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.visrap)));
    avelength_visrap := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.visrap)),h.visrap<>(typeof(h.visrap))'');
    populated_cab_configuration_cnt := COUNT(GROUP,h.cab_configuration <> (TYPEOF(h.cab_configuration))'');
    populated_cab_configuration_pcnt := AVE(GROUP,IF(h.cab_configuration = (TYPEOF(h.cab_configuration))'',0,100));
    maxlength_cab_configuration := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cab_configuration)));
    avelength_cab_configuration := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cab_configuration)),h.cab_configuration<>(typeof(h.cab_configuration))'');
    populated_front_axle_code_cnt := COUNT(GROUP,h.front_axle_code <> (TYPEOF(h.front_axle_code))'');
    populated_front_axle_code_pcnt := AVE(GROUP,IF(h.front_axle_code = (TYPEOF(h.front_axle_code))'',0,100));
    maxlength_front_axle_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.front_axle_code)));
    avelength_front_axle_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.front_axle_code)),h.front_axle_code<>(typeof(h.front_axle_code))'');
    populated_rear_axle_code_cnt := COUNT(GROUP,h.rear_axle_code <> (TYPEOF(h.rear_axle_code))'');
    populated_rear_axle_code_pcnt := AVE(GROUP,IF(h.rear_axle_code = (TYPEOF(h.rear_axle_code))'',0,100));
    maxlength_rear_axle_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rear_axle_code)));
    avelength_rear_axle_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rear_axle_code)),h.rear_axle_code<>(typeof(h.rear_axle_code))'');
    populated_brakes_code_cnt := COUNT(GROUP,h.brakes_code <> (TYPEOF(h.brakes_code))'');
    populated_brakes_code_pcnt := AVE(GROUP,IF(h.brakes_code = (TYPEOF(h.brakes_code))'',0,100));
    maxlength_brakes_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brakes_code)));
    avelength_brakes_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brakes_code)),h.brakes_code<>(typeof(h.brakes_code))'');
    populated_engine_manufacturer_cnt := COUNT(GROUP,h.engine_manufacturer <> (TYPEOF(h.engine_manufacturer))'');
    populated_engine_manufacturer_pcnt := AVE(GROUP,IF(h.engine_manufacturer = (TYPEOF(h.engine_manufacturer))'',0,100));
    maxlength_engine_manufacturer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_manufacturer)));
    avelength_engine_manufacturer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_manufacturer)),h.engine_manufacturer<>(typeof(h.engine_manufacturer))'');
    populated_engine_model_cnt := COUNT(GROUP,h.engine_model <> (TYPEOF(h.engine_model))'');
    populated_engine_model_pcnt := AVE(GROUP,IF(h.engine_model = (TYPEOF(h.engine_model))'',0,100));
    maxlength_engine_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_model)));
    avelength_engine_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_model)),h.engine_model<>(typeof(h.engine_model))'');
    populated_engine_type_code_cnt := COUNT(GROUP,h.engine_type_code <> (TYPEOF(h.engine_type_code))'');
    populated_engine_type_code_pcnt := AVE(GROUP,IF(h.engine_type_code = (TYPEOF(h.engine_type_code))'',0,100));
    maxlength_engine_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_type_code)));
    avelength_engine_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_type_code)),h.engine_type_code<>(typeof(h.engine_type_code))'');
    populated_trailer_body_style_cnt := COUNT(GROUP,h.trailer_body_style <> (TYPEOF(h.trailer_body_style))'');
    populated_trailer_body_style_pcnt := AVE(GROUP,IF(h.trailer_body_style = (TYPEOF(h.trailer_body_style))'',0,100));
    maxlength_trailer_body_style := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trailer_body_style)));
    avelength_trailer_body_style := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trailer_body_style)),h.trailer_body_style<>(typeof(h.trailer_body_style))'');
    populated_trailer_number_of_axles_cnt := COUNT(GROUP,h.trailer_number_of_axles <> (TYPEOF(h.trailer_number_of_axles))'');
    populated_trailer_number_of_axles_pcnt := AVE(GROUP,IF(h.trailer_number_of_axles = (TYPEOF(h.trailer_number_of_axles))'',0,100));
    maxlength_trailer_number_of_axles := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trailer_number_of_axles)));
    avelength_trailer_number_of_axles := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trailer_number_of_axles)),h.trailer_number_of_axles<>(typeof(h.trailer_number_of_axles))'');
    populated_trailer_length_cnt := COUNT(GROUP,h.trailer_length <> (TYPEOF(h.trailer_length))'');
    populated_trailer_length_pcnt := AVE(GROUP,IF(h.trailer_length = (TYPEOF(h.trailer_length))'',0,100));
    maxlength_trailer_length := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.trailer_length)));
    avelength_trailer_length := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.trailer_length)),h.trailer_length<>(typeof(h.trailer_length))'');
    populated_proactive_vin_cnt := COUNT(GROUP,h.proactive_vin <> (TYPEOF(h.proactive_vin))'');
    populated_proactive_vin_pcnt := AVE(GROUP,IF(h.proactive_vin = (TYPEOF(h.proactive_vin))'',0,100));
    maxlength_proactive_vin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proactive_vin)));
    avelength_proactive_vin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proactive_vin)),h.proactive_vin<>(typeof(h.proactive_vin))'');
    populated_ma_state_exceptions_cnt := COUNT(GROUP,h.ma_state_exceptions <> (TYPEOF(h.ma_state_exceptions))'');
    populated_ma_state_exceptions_pcnt := AVE(GROUP,IF(h.ma_state_exceptions = (TYPEOF(h.ma_state_exceptions))'',0,100));
    maxlength_ma_state_exceptions := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ma_state_exceptions)));
    avelength_ma_state_exceptions := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ma_state_exceptions)),h.ma_state_exceptions<>(typeof(h.ma_state_exceptions))'');
    populated_filler_1_cnt := COUNT(GROUP,h.filler_1 <> (TYPEOF(h.filler_1))'');
    populated_filler_1_pcnt := AVE(GROUP,IF(h.filler_1 = (TYPEOF(h.filler_1))'',0,100));
    maxlength_filler_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler_1)));
    avelength_filler_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler_1)),h.filler_1<>(typeof(h.filler_1))'');
    populated_series_abbreviation_cnt := COUNT(GROUP,h.series_abbreviation <> (TYPEOF(h.series_abbreviation))'');
    populated_series_abbreviation_pcnt := AVE(GROUP,IF(h.series_abbreviation = (TYPEOF(h.series_abbreviation))'',0,100));
    maxlength_series_abbreviation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.series_abbreviation)));
    avelength_series_abbreviation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.series_abbreviation)),h.series_abbreviation<>(typeof(h.series_abbreviation))'');
    populated_vin_pattern_cnt := COUNT(GROUP,h.vin_pattern <> (TYPEOF(h.vin_pattern))'');
    populated_vin_pattern_pcnt := AVE(GROUP,IF(h.vin_pattern = (TYPEOF(h.vin_pattern))'',0,100));
    maxlength_vin_pattern := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vin_pattern)));
    avelength_vin_pattern := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vin_pattern)),h.vin_pattern<>(typeof(h.vin_pattern))'');
    populated_ncic_data_cnt := COUNT(GROUP,h.ncic_data <> (TYPEOF(h.ncic_data))'');
    populated_ncic_data_pcnt := AVE(GROUP,IF(h.ncic_data = (TYPEOF(h.ncic_data))'',0,100));
    maxlength_ncic_data := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ncic_data)));
    avelength_ncic_data := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ncic_data)),h.ncic_data<>(typeof(h.ncic_data))'');
    populated_full_body_style_name_cnt := COUNT(GROUP,h.full_body_style_name <> (TYPEOF(h.full_body_style_name))'');
    populated_full_body_style_name_pcnt := AVE(GROUP,IF(h.full_body_style_name = (TYPEOF(h.full_body_style_name))'',0,100));
    maxlength_full_body_style_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_body_style_name)));
    avelength_full_body_style_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_body_style_name)),h.full_body_style_name<>(typeof(h.full_body_style_name))'');
    populated_nvpp_make_code_cnt := COUNT(GROUP,h.nvpp_make_code <> (TYPEOF(h.nvpp_make_code))'');
    populated_nvpp_make_code_pcnt := AVE(GROUP,IF(h.nvpp_make_code = (TYPEOF(h.nvpp_make_code))'',0,100));
    maxlength_nvpp_make_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nvpp_make_code)));
    avelength_nvpp_make_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nvpp_make_code)),h.nvpp_make_code<>(typeof(h.nvpp_make_code))'');
    populated_nvpp_make_abbreviation_cnt := COUNT(GROUP,h.nvpp_make_abbreviation <> (TYPEOF(h.nvpp_make_abbreviation))'');
    populated_nvpp_make_abbreviation_pcnt := AVE(GROUP,IF(h.nvpp_make_abbreviation = (TYPEOF(h.nvpp_make_abbreviation))'',0,100));
    maxlength_nvpp_make_abbreviation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nvpp_make_abbreviation)));
    avelength_nvpp_make_abbreviation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nvpp_make_abbreviation)),h.nvpp_make_abbreviation<>(typeof(h.nvpp_make_abbreviation))'');
    populated_nvpp_series_model_cnt := COUNT(GROUP,h.nvpp_series_model <> (TYPEOF(h.nvpp_series_model))'');
    populated_nvpp_series_model_pcnt := AVE(GROUP,IF(h.nvpp_series_model = (TYPEOF(h.nvpp_series_model))'',0,100));
    maxlength_nvpp_series_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nvpp_series_model)));
    avelength_nvpp_series_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nvpp_series_model)),h.nvpp_series_model<>(typeof(h.nvpp_series_model))'');
    populated_nvpp_series_name_cnt := COUNT(GROUP,h.nvpp_series_name <> (TYPEOF(h.nvpp_series_name))'');
    populated_nvpp_series_name_pcnt := AVE(GROUP,IF(h.nvpp_series_name = (TYPEOF(h.nvpp_series_name))'',0,100));
    maxlength_nvpp_series_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nvpp_series_name)));
    avelength_nvpp_series_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nvpp_series_name)),h.nvpp_series_name<>(typeof(h.nvpp_series_name))'');
    populated_segmentation_code_cnt := COUNT(GROUP,h.segmentation_code <> (TYPEOF(h.segmentation_code))'');
    populated_segmentation_code_pcnt := AVE(GROUP,IF(h.segmentation_code = (TYPEOF(h.segmentation_code))'',0,100));
    maxlength_segmentation_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.segmentation_code)));
    avelength_segmentation_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.segmentation_code)),h.segmentation_code<>(typeof(h.segmentation_code))'');
    populated_country_of_origin_cnt := COUNT(GROUP,h.country_of_origin <> (TYPEOF(h.country_of_origin))'');
    populated_country_of_origin_pcnt := AVE(GROUP,IF(h.country_of_origin = (TYPEOF(h.country_of_origin))'',0,100));
    maxlength_country_of_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.country_of_origin)));
    avelength_country_of_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.country_of_origin)),h.country_of_origin<>(typeof(h.country_of_origin))'');
    populated_engine_liter_information_cnt := COUNT(GROUP,h.engine_liter_information <> (TYPEOF(h.engine_liter_information))'');
    populated_engine_liter_information_pcnt := AVE(GROUP,IF(h.engine_liter_information = (TYPEOF(h.engine_liter_information))'',0,100));
    maxlength_engine_liter_information := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_liter_information)));
    avelength_engine_liter_information := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_liter_information)),h.engine_liter_information<>(typeof(h.engine_liter_information))'');
    populated_engine_information_filler1_cnt := COUNT(GROUP,h.engine_information_filler1 <> (TYPEOF(h.engine_information_filler1))'');
    populated_engine_information_filler1_pcnt := AVE(GROUP,IF(h.engine_information_filler1 = (TYPEOF(h.engine_information_filler1))'',0,100));
    maxlength_engine_information_filler1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_filler1)));
    avelength_engine_information_filler1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_filler1)),h.engine_information_filler1<>(typeof(h.engine_information_filler1))'');
    populated_engine_information_block_type_cnt := COUNT(GROUP,h.engine_information_block_type <> (TYPEOF(h.engine_information_block_type))'');
    populated_engine_information_block_type_pcnt := AVE(GROUP,IF(h.engine_information_block_type = (TYPEOF(h.engine_information_block_type))'',0,100));
    maxlength_engine_information_block_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_block_type)));
    avelength_engine_information_block_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_block_type)),h.engine_information_block_type<>(typeof(h.engine_information_block_type))'');
    populated_engine_information_cylinders_cnt := COUNT(GROUP,h.engine_information_cylinders <> (TYPEOF(h.engine_information_cylinders))'');
    populated_engine_information_cylinders_pcnt := AVE(GROUP,IF(h.engine_information_cylinders = (TYPEOF(h.engine_information_cylinders))'',0,100));
    maxlength_engine_information_cylinders := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_cylinders)));
    avelength_engine_information_cylinders := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_cylinders)),h.engine_information_cylinders<>(typeof(h.engine_information_cylinders))'');
    populated_engine_information_filler2_cnt := COUNT(GROUP,h.engine_information_filler2 <> (TYPEOF(h.engine_information_filler2))'');
    populated_engine_information_filler2_pcnt := AVE(GROUP,IF(h.engine_information_filler2 = (TYPEOF(h.engine_information_filler2))'',0,100));
    maxlength_engine_information_filler2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_filler2)));
    avelength_engine_information_filler2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_filler2)),h.engine_information_filler2<>(typeof(h.engine_information_filler2))'');
    populated_engine_information_carburetion_cnt := COUNT(GROUP,h.engine_information_carburetion <> (TYPEOF(h.engine_information_carburetion))'');
    populated_engine_information_carburetion_pcnt := AVE(GROUP,IF(h.engine_information_carburetion = (TYPEOF(h.engine_information_carburetion))'',0,100));
    maxlength_engine_information_carburetion := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_carburetion)));
    avelength_engine_information_carburetion := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_carburetion)),h.engine_information_carburetion<>(typeof(h.engine_information_carburetion))'');
    populated_engine_information_filler3_cnt := COUNT(GROUP,h.engine_information_filler3 <> (TYPEOF(h.engine_information_filler3))'');
    populated_engine_information_filler3_pcnt := AVE(GROUP,IF(h.engine_information_filler3 = (TYPEOF(h.engine_information_filler3))'',0,100));
    maxlength_engine_information_filler3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_filler3)));
    avelength_engine_information_filler3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_filler3)),h.engine_information_filler3<>(typeof(h.engine_information_filler3))'');
    populated_engine_information_head_configuration_cnt := COUNT(GROUP,h.engine_information_head_configuration <> (TYPEOF(h.engine_information_head_configuration))'');
    populated_engine_information_head_configuration_pcnt := AVE(GROUP,IF(h.engine_information_head_configuration = (TYPEOF(h.engine_information_head_configuration))'',0,100));
    maxlength_engine_information_head_configuration := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_head_configuration)));
    avelength_engine_information_head_configuration := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_head_configuration)),h.engine_information_head_configuration<>(typeof(h.engine_information_head_configuration))'');
    populated_engine_information_filler4_cnt := COUNT(GROUP,h.engine_information_filler4 <> (TYPEOF(h.engine_information_filler4))'');
    populated_engine_information_filler4_pcnt := AVE(GROUP,IF(h.engine_information_filler4 = (TYPEOF(h.engine_information_filler4))'',0,100));
    maxlength_engine_information_filler4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_filler4)));
    avelength_engine_information_filler4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_filler4)),h.engine_information_filler4<>(typeof(h.engine_information_filler4))'');
    populated_engine_information_total_valves_cnt := COUNT(GROUP,h.engine_information_total_valves <> (TYPEOF(h.engine_information_total_valves))'');
    populated_engine_information_total_valves_pcnt := AVE(GROUP,IF(h.engine_information_total_valves = (TYPEOF(h.engine_information_total_valves))'',0,100));
    maxlength_engine_information_total_valves := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_total_valves)));
    avelength_engine_information_total_valves := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_total_valves)),h.engine_information_total_valves<>(typeof(h.engine_information_total_valves))'');
    populated_engine_information_filler5_cnt := COUNT(GROUP,h.engine_information_filler5 <> (TYPEOF(h.engine_information_filler5))'');
    populated_engine_information_filler5_pcnt := AVE(GROUP,IF(h.engine_information_filler5 = (TYPEOF(h.engine_information_filler5))'',0,100));
    maxlength_engine_information_filler5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_filler5)));
    avelength_engine_information_filler5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_filler5)),h.engine_information_filler5<>(typeof(h.engine_information_filler5))'');
    populated_engine_information_aspiration_code_cnt := COUNT(GROUP,h.engine_information_aspiration_code <> (TYPEOF(h.engine_information_aspiration_code))'');
    populated_engine_information_aspiration_code_pcnt := AVE(GROUP,IF(h.engine_information_aspiration_code = (TYPEOF(h.engine_information_aspiration_code))'',0,100));
    maxlength_engine_information_aspiration_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_aspiration_code)));
    avelength_engine_information_aspiration_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_aspiration_code)),h.engine_information_aspiration_code<>(typeof(h.engine_information_aspiration_code))'');
    populated_engine_information_carburetion_code_cnt := COUNT(GROUP,h.engine_information_carburetion_code <> (TYPEOF(h.engine_information_carburetion_code))'');
    populated_engine_information_carburetion_code_pcnt := AVE(GROUP,IF(h.engine_information_carburetion_code = (TYPEOF(h.engine_information_carburetion_code))'',0,100));
    maxlength_engine_information_carburetion_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_carburetion_code)));
    avelength_engine_information_carburetion_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_carburetion_code)),h.engine_information_carburetion_code<>(typeof(h.engine_information_carburetion_code))'');
    populated_engine_information_valves_per_cylinder_cnt := COUNT(GROUP,h.engine_information_valves_per_cylinder <> (TYPEOF(h.engine_information_valves_per_cylinder))'');
    populated_engine_information_valves_per_cylinder_pcnt := AVE(GROUP,IF(h.engine_information_valves_per_cylinder = (TYPEOF(h.engine_information_valves_per_cylinder))'',0,100));
    maxlength_engine_information_valves_per_cylinder := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_valves_per_cylinder)));
    avelength_engine_information_valves_per_cylinder := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_information_valves_per_cylinder)),h.engine_information_valves_per_cylinder<>(typeof(h.engine_information_valves_per_cylinder))'');
    populated_transmission_speed_cnt := COUNT(GROUP,h.transmission_speed <> (TYPEOF(h.transmission_speed))'');
    populated_transmission_speed_pcnt := AVE(GROUP,IF(h.transmission_speed = (TYPEOF(h.transmission_speed))'',0,100));
    maxlength_transmission_speed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_speed)));
    avelength_transmission_speed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_speed)),h.transmission_speed<>(typeof(h.transmission_speed))'');
    populated_transmission_filler1_cnt := COUNT(GROUP,h.transmission_filler1 <> (TYPEOF(h.transmission_filler1))'');
    populated_transmission_filler1_pcnt := AVE(GROUP,IF(h.transmission_filler1 = (TYPEOF(h.transmission_filler1))'',0,100));
    maxlength_transmission_filler1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_filler1)));
    avelength_transmission_filler1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_filler1)),h.transmission_filler1<>(typeof(h.transmission_filler1))'');
    populated_transmission_type_cnt := COUNT(GROUP,h.transmission_type <> (TYPEOF(h.transmission_type))'');
    populated_transmission_type_pcnt := AVE(GROUP,IF(h.transmission_type = (TYPEOF(h.transmission_type))'',0,100));
    maxlength_transmission_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_type)));
    avelength_transmission_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_type)),h.transmission_type<>(typeof(h.transmission_type))'');
    populated_transmission_filler2_cnt := COUNT(GROUP,h.transmission_filler2 <> (TYPEOF(h.transmission_filler2))'');
    populated_transmission_filler2_pcnt := AVE(GROUP,IF(h.transmission_filler2 = (TYPEOF(h.transmission_filler2))'',0,100));
    maxlength_transmission_filler2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_filler2)));
    avelength_transmission_filler2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_filler2)),h.transmission_filler2<>(typeof(h.transmission_filler2))'');
    populated_transmission_code_cnt := COUNT(GROUP,h.transmission_code <> (TYPEOF(h.transmission_code))'');
    populated_transmission_code_pcnt := AVE(GROUP,IF(h.transmission_code = (TYPEOF(h.transmission_code))'',0,100));
    maxlength_transmission_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_code)));
    avelength_transmission_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_code)),h.transmission_code<>(typeof(h.transmission_code))'');
    populated_transmission_filler3_cnt := COUNT(GROUP,h.transmission_filler3 <> (TYPEOF(h.transmission_filler3))'');
    populated_transmission_filler3_pcnt := AVE(GROUP,IF(h.transmission_filler3 = (TYPEOF(h.transmission_filler3))'',0,100));
    maxlength_transmission_filler3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_filler3)));
    avelength_transmission_filler3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_filler3)),h.transmission_filler3<>(typeof(h.transmission_filler3))'');
    populated_transmission_speed_code_cnt := COUNT(GROUP,h.transmission_speed_code <> (TYPEOF(h.transmission_speed_code))'');
    populated_transmission_speed_code_pcnt := AVE(GROUP,IF(h.transmission_speed_code = (TYPEOF(h.transmission_speed_code))'',0,100));
    maxlength_transmission_speed_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_speed_code)));
    avelength_transmission_speed_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transmission_speed_code)),h.transmission_speed_code<>(typeof(h.transmission_speed_code))'');
    populated_base_model_cnt := COUNT(GROUP,h.base_model <> (TYPEOF(h.base_model))'');
    populated_base_model_pcnt := AVE(GROUP,IF(h.base_model = (TYPEOF(h.base_model))'',0,100));
    maxlength_base_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.base_model)));
    avelength_base_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.base_model)),h.base_model<>(typeof(h.base_model))'');
    populated_complete_prefix_file_id_cnt := COUNT(GROUP,h.complete_prefix_file_id <> (TYPEOF(h.complete_prefix_file_id))'');
    populated_complete_prefix_file_id_pcnt := AVE(GROUP,IF(h.complete_prefix_file_id = (TYPEOF(h.complete_prefix_file_id))'',0,100));
    maxlength_complete_prefix_file_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.complete_prefix_file_id)));
    avelength_complete_prefix_file_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.complete_prefix_file_id)),h.complete_prefix_file_id<>(typeof(h.complete_prefix_file_id))'');
    populated_series_name_full_spelling_cnt := COUNT(GROUP,h.series_name_full_spelling <> (TYPEOF(h.series_name_full_spelling))'');
    populated_series_name_full_spelling_pcnt := AVE(GROUP,IF(h.series_name_full_spelling = (TYPEOF(h.series_name_full_spelling))'',0,100));
    maxlength_series_name_full_spelling := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.series_name_full_spelling)));
    avelength_series_name_full_spelling := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.series_name_full_spelling)),h.series_name_full_spelling<>(typeof(h.series_name_full_spelling))'');
    populated_vis_theft_code_cnt := COUNT(GROUP,h.vis_theft_code <> (TYPEOF(h.vis_theft_code))'');
    populated_vis_theft_code_pcnt := AVE(GROUP,IF(h.vis_theft_code = (TYPEOF(h.vis_theft_code))'',0,100));
    maxlength_vis_theft_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vis_theft_code)));
    avelength_vis_theft_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vis_theft_code)),h.vis_theft_code<>(typeof(h.vis_theft_code))'');
    populated_base_list_price_expanded_cnt := COUNT(GROUP,h.base_list_price_expanded <> (TYPEOF(h.base_list_price_expanded))'');
    populated_base_list_price_expanded_pcnt := AVE(GROUP,IF(h.base_list_price_expanded = (TYPEOF(h.base_list_price_expanded))'',0,100));
    maxlength_base_list_price_expanded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.base_list_price_expanded)));
    avelength_base_list_price_expanded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.base_list_price_expanded)),h.base_list_price_expanded<>(typeof(h.base_list_price_expanded))'');
    populated_default_nada_vehicle_id_cnt := COUNT(GROUP,h.default_nada_vehicle_id <> (TYPEOF(h.default_nada_vehicle_id))'');
    populated_default_nada_vehicle_id_pcnt := AVE(GROUP,IF(h.default_nada_vehicle_id = (TYPEOF(h.default_nada_vehicle_id))'',0,100));
    maxlength_default_nada_vehicle_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_vehicle_id)));
    avelength_default_nada_vehicle_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_vehicle_id)),h.default_nada_vehicle_id<>(typeof(h.default_nada_vehicle_id))'');
    populated_default_nada_model_cnt := COUNT(GROUP,h.default_nada_model <> (TYPEOF(h.default_nada_model))'');
    populated_default_nada_model_pcnt := AVE(GROUP,IF(h.default_nada_model = (TYPEOF(h.default_nada_model))'',0,100));
    maxlength_default_nada_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_model)));
    avelength_default_nada_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_model)),h.default_nada_model<>(typeof(h.default_nada_model))'');
    populated_default_nada_body_style_cnt := COUNT(GROUP,h.default_nada_body_style <> (TYPEOF(h.default_nada_body_style))'');
    populated_default_nada_body_style_pcnt := AVE(GROUP,IF(h.default_nada_body_style = (TYPEOF(h.default_nada_body_style))'',0,100));
    maxlength_default_nada_body_style := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_body_style)));
    avelength_default_nada_body_style := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_body_style)),h.default_nada_body_style<>(typeof(h.default_nada_body_style))'');
    populated_default_nada_msrp_cnt := COUNT(GROUP,h.default_nada_msrp <> (TYPEOF(h.default_nada_msrp))'');
    populated_default_nada_msrp_pcnt := AVE(GROUP,IF(h.default_nada_msrp = (TYPEOF(h.default_nada_msrp))'',0,100));
    maxlength_default_nada_msrp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_msrp)));
    avelength_default_nada_msrp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_msrp)),h.default_nada_msrp<>(typeof(h.default_nada_msrp))'');
    populated_default_nada_gvwr_cnt := COUNT(GROUP,h.default_nada_gvwr <> (TYPEOF(h.default_nada_gvwr))'');
    populated_default_nada_gvwr_pcnt := AVE(GROUP,IF(h.default_nada_gvwr = (TYPEOF(h.default_nada_gvwr))'',0,100));
    maxlength_default_nada_gvwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_gvwr)));
    avelength_default_nada_gvwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_gvwr)),h.default_nada_gvwr<>(typeof(h.default_nada_gvwr))'');
    populated_default_nada_gcwr_cnt := COUNT(GROUP,h.default_nada_gcwr <> (TYPEOF(h.default_nada_gcwr))'');
    populated_default_nada_gcwr_pcnt := AVE(GROUP,IF(h.default_nada_gcwr = (TYPEOF(h.default_nada_gcwr))'',0,100));
    maxlength_default_nada_gcwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_gcwr)));
    avelength_default_nada_gcwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.default_nada_gcwr)),h.default_nada_gcwr<>(typeof(h.default_nada_gcwr))'');
    populated_alt_1_nada_vehicle_id_cnt := COUNT(GROUP,h.alt_1_nada_vehicle_id <> (TYPEOF(h.alt_1_nada_vehicle_id))'');
    populated_alt_1_nada_vehicle_id_pcnt := AVE(GROUP,IF(h.alt_1_nada_vehicle_id = (TYPEOF(h.alt_1_nada_vehicle_id))'',0,100));
    maxlength_alt_1_nada_vehicle_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_vehicle_id)));
    avelength_alt_1_nada_vehicle_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_vehicle_id)),h.alt_1_nada_vehicle_id<>(typeof(h.alt_1_nada_vehicle_id))'');
    populated_alt_1_nada_model_cnt := COUNT(GROUP,h.alt_1_nada_model <> (TYPEOF(h.alt_1_nada_model))'');
    populated_alt_1_nada_model_pcnt := AVE(GROUP,IF(h.alt_1_nada_model = (TYPEOF(h.alt_1_nada_model))'',0,100));
    maxlength_alt_1_nada_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_model)));
    avelength_alt_1_nada_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_model)),h.alt_1_nada_model<>(typeof(h.alt_1_nada_model))'');
    populated_alt_1_nada_body_style_cnt := COUNT(GROUP,h.alt_1_nada_body_style <> (TYPEOF(h.alt_1_nada_body_style))'');
    populated_alt_1_nada_body_style_pcnt := AVE(GROUP,IF(h.alt_1_nada_body_style = (TYPEOF(h.alt_1_nada_body_style))'',0,100));
    maxlength_alt_1_nada_body_style := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_body_style)));
    avelength_alt_1_nada_body_style := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_body_style)),h.alt_1_nada_body_style<>(typeof(h.alt_1_nada_body_style))'');
    populated_alt_1_nada_msrp_cnt := COUNT(GROUP,h.alt_1_nada_msrp <> (TYPEOF(h.alt_1_nada_msrp))'');
    populated_alt_1_nada_msrp_pcnt := AVE(GROUP,IF(h.alt_1_nada_msrp = (TYPEOF(h.alt_1_nada_msrp))'',0,100));
    maxlength_alt_1_nada_msrp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_msrp)));
    avelength_alt_1_nada_msrp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_msrp)),h.alt_1_nada_msrp<>(typeof(h.alt_1_nada_msrp))'');
    populated_alt_1_nada_gvwr_cnt := COUNT(GROUP,h.alt_1_nada_gvwr <> (TYPEOF(h.alt_1_nada_gvwr))'');
    populated_alt_1_nada_gvwr_pcnt := AVE(GROUP,IF(h.alt_1_nada_gvwr = (TYPEOF(h.alt_1_nada_gvwr))'',0,100));
    maxlength_alt_1_nada_gvwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_gvwr)));
    avelength_alt_1_nada_gvwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_gvwr)),h.alt_1_nada_gvwr<>(typeof(h.alt_1_nada_gvwr))'');
    populated_alt_1_nada_gcwr_cnt := COUNT(GROUP,h.alt_1_nada_gcwr <> (TYPEOF(h.alt_1_nada_gcwr))'');
    populated_alt_1_nada_gcwr_pcnt := AVE(GROUP,IF(h.alt_1_nada_gcwr = (TYPEOF(h.alt_1_nada_gcwr))'',0,100));
    maxlength_alt_1_nada_gcwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_gcwr)));
    avelength_alt_1_nada_gcwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_1_nada_gcwr)),h.alt_1_nada_gcwr<>(typeof(h.alt_1_nada_gcwr))'');
    populated_alt_2_nada_vehicle_id_cnt := COUNT(GROUP,h.alt_2_nada_vehicle_id <> (TYPEOF(h.alt_2_nada_vehicle_id))'');
    populated_alt_2_nada_vehicle_id_pcnt := AVE(GROUP,IF(h.alt_2_nada_vehicle_id = (TYPEOF(h.alt_2_nada_vehicle_id))'',0,100));
    maxlength_alt_2_nada_vehicle_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_vehicle_id)));
    avelength_alt_2_nada_vehicle_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_vehicle_id)),h.alt_2_nada_vehicle_id<>(typeof(h.alt_2_nada_vehicle_id))'');
    populated_alt_2_nada_model_cnt := COUNT(GROUP,h.alt_2_nada_model <> (TYPEOF(h.alt_2_nada_model))'');
    populated_alt_2_nada_model_pcnt := AVE(GROUP,IF(h.alt_2_nada_model = (TYPEOF(h.alt_2_nada_model))'',0,100));
    maxlength_alt_2_nada_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_model)));
    avelength_alt_2_nada_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_model)),h.alt_2_nada_model<>(typeof(h.alt_2_nada_model))'');
    populated_alt_2_nada_body_style_cnt := COUNT(GROUP,h.alt_2_nada_body_style <> (TYPEOF(h.alt_2_nada_body_style))'');
    populated_alt_2_nada_body_style_pcnt := AVE(GROUP,IF(h.alt_2_nada_body_style = (TYPEOF(h.alt_2_nada_body_style))'',0,100));
    maxlength_alt_2_nada_body_style := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_body_style)));
    avelength_alt_2_nada_body_style := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_body_style)),h.alt_2_nada_body_style<>(typeof(h.alt_2_nada_body_style))'');
    populated_alt_2_nada_msrp_cnt := COUNT(GROUP,h.alt_2_nada_msrp <> (TYPEOF(h.alt_2_nada_msrp))'');
    populated_alt_2_nada_msrp_pcnt := AVE(GROUP,IF(h.alt_2_nada_msrp = (TYPEOF(h.alt_2_nada_msrp))'',0,100));
    maxlength_alt_2_nada_msrp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_msrp)));
    avelength_alt_2_nada_msrp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_msrp)),h.alt_2_nada_msrp<>(typeof(h.alt_2_nada_msrp))'');
    populated_alt_2_nada_gvwr_cnt := COUNT(GROUP,h.alt_2_nada_gvwr <> (TYPEOF(h.alt_2_nada_gvwr))'');
    populated_alt_2_nada_gvwr_pcnt := AVE(GROUP,IF(h.alt_2_nada_gvwr = (TYPEOF(h.alt_2_nada_gvwr))'',0,100));
    maxlength_alt_2_nada_gvwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_gvwr)));
    avelength_alt_2_nada_gvwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_gvwr)),h.alt_2_nada_gvwr<>(typeof(h.alt_2_nada_gvwr))'');
    populated_alt_2_nada_gcwr_cnt := COUNT(GROUP,h.alt_2_nada_gcwr <> (TYPEOF(h.alt_2_nada_gcwr))'');
    populated_alt_2_nada_gcwr_pcnt := AVE(GROUP,IF(h.alt_2_nada_gcwr = (TYPEOF(h.alt_2_nada_gcwr))'',0,100));
    maxlength_alt_2_nada_gcwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_gcwr)));
    avelength_alt_2_nada_gcwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_2_nada_gcwr)),h.alt_2_nada_gcwr<>(typeof(h.alt_2_nada_gcwr))'');
    populated_alt_3_nada_vehicle_id_cnt := COUNT(GROUP,h.alt_3_nada_vehicle_id <> (TYPEOF(h.alt_3_nada_vehicle_id))'');
    populated_alt_3_nada_vehicle_id_pcnt := AVE(GROUP,IF(h.alt_3_nada_vehicle_id = (TYPEOF(h.alt_3_nada_vehicle_id))'',0,100));
    maxlength_alt_3_nada_vehicle_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_vehicle_id)));
    avelength_alt_3_nada_vehicle_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_vehicle_id)),h.alt_3_nada_vehicle_id<>(typeof(h.alt_3_nada_vehicle_id))'');
    populated_alt_3_nada_model_cnt := COUNT(GROUP,h.alt_3_nada_model <> (TYPEOF(h.alt_3_nada_model))'');
    populated_alt_3_nada_model_pcnt := AVE(GROUP,IF(h.alt_3_nada_model = (TYPEOF(h.alt_3_nada_model))'',0,100));
    maxlength_alt_3_nada_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_model)));
    avelength_alt_3_nada_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_model)),h.alt_3_nada_model<>(typeof(h.alt_3_nada_model))'');
    populated_alt_3_nada_body_style_cnt := COUNT(GROUP,h.alt_3_nada_body_style <> (TYPEOF(h.alt_3_nada_body_style))'');
    populated_alt_3_nada_body_style_pcnt := AVE(GROUP,IF(h.alt_3_nada_body_style = (TYPEOF(h.alt_3_nada_body_style))'',0,100));
    maxlength_alt_3_nada_body_style := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_body_style)));
    avelength_alt_3_nada_body_style := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_body_style)),h.alt_3_nada_body_style<>(typeof(h.alt_3_nada_body_style))'');
    populated_alt_3_nada_msrp_cnt := COUNT(GROUP,h.alt_3_nada_msrp <> (TYPEOF(h.alt_3_nada_msrp))'');
    populated_alt_3_nada_msrp_pcnt := AVE(GROUP,IF(h.alt_3_nada_msrp = (TYPEOF(h.alt_3_nada_msrp))'',0,100));
    maxlength_alt_3_nada_msrp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_msrp)));
    avelength_alt_3_nada_msrp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_msrp)),h.alt_3_nada_msrp<>(typeof(h.alt_3_nada_msrp))'');
    populated_alt_3_nada_gvwr_cnt := COUNT(GROUP,h.alt_3_nada_gvwr <> (TYPEOF(h.alt_3_nada_gvwr))'');
    populated_alt_3_nada_gvwr_pcnt := AVE(GROUP,IF(h.alt_3_nada_gvwr = (TYPEOF(h.alt_3_nada_gvwr))'',0,100));
    maxlength_alt_3_nada_gvwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_gvwr)));
    avelength_alt_3_nada_gvwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_gvwr)),h.alt_3_nada_gvwr<>(typeof(h.alt_3_nada_gvwr))'');
    populated_alt_3_nada_gcwr_cnt := COUNT(GROUP,h.alt_3_nada_gcwr <> (TYPEOF(h.alt_3_nada_gcwr))'');
    populated_alt_3_nada_gcwr_pcnt := AVE(GROUP,IF(h.alt_3_nada_gcwr = (TYPEOF(h.alt_3_nada_gcwr))'',0,100));
    maxlength_alt_3_nada_gcwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_gcwr)));
    avelength_alt_3_nada_gcwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_3_nada_gcwr)),h.alt_3_nada_gcwr<>(typeof(h.alt_3_nada_gcwr))'');
    populated_alt_4_nada_vehicle_id_cnt := COUNT(GROUP,h.alt_4_nada_vehicle_id <> (TYPEOF(h.alt_4_nada_vehicle_id))'');
    populated_alt_4_nada_vehicle_id_pcnt := AVE(GROUP,IF(h.alt_4_nada_vehicle_id = (TYPEOF(h.alt_4_nada_vehicle_id))'',0,100));
    maxlength_alt_4_nada_vehicle_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_vehicle_id)));
    avelength_alt_4_nada_vehicle_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_vehicle_id)),h.alt_4_nada_vehicle_id<>(typeof(h.alt_4_nada_vehicle_id))'');
    populated_alt_4_nada_model_cnt := COUNT(GROUP,h.alt_4_nada_model <> (TYPEOF(h.alt_4_nada_model))'');
    populated_alt_4_nada_model_pcnt := AVE(GROUP,IF(h.alt_4_nada_model = (TYPEOF(h.alt_4_nada_model))'',0,100));
    maxlength_alt_4_nada_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_model)));
    avelength_alt_4_nada_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_model)),h.alt_4_nada_model<>(typeof(h.alt_4_nada_model))'');
    populated_alt_4_nada_body_style_cnt := COUNT(GROUP,h.alt_4_nada_body_style <> (TYPEOF(h.alt_4_nada_body_style))'');
    populated_alt_4_nada_body_style_pcnt := AVE(GROUP,IF(h.alt_4_nada_body_style = (TYPEOF(h.alt_4_nada_body_style))'',0,100));
    maxlength_alt_4_nada_body_style := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_body_style)));
    avelength_alt_4_nada_body_style := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_body_style)),h.alt_4_nada_body_style<>(typeof(h.alt_4_nada_body_style))'');
    populated_alt_4_nada_msrp_cnt := COUNT(GROUP,h.alt_4_nada_msrp <> (TYPEOF(h.alt_4_nada_msrp))'');
    populated_alt_4_nada_msrp_pcnt := AVE(GROUP,IF(h.alt_4_nada_msrp = (TYPEOF(h.alt_4_nada_msrp))'',0,100));
    maxlength_alt_4_nada_msrp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_msrp)));
    avelength_alt_4_nada_msrp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_msrp)),h.alt_4_nada_msrp<>(typeof(h.alt_4_nada_msrp))'');
    populated_alt_4_nada_gvwr_cnt := COUNT(GROUP,h.alt_4_nada_gvwr <> (TYPEOF(h.alt_4_nada_gvwr))'');
    populated_alt_4_nada_gvwr_pcnt := AVE(GROUP,IF(h.alt_4_nada_gvwr = (TYPEOF(h.alt_4_nada_gvwr))'',0,100));
    maxlength_alt_4_nada_gvwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_gvwr)));
    avelength_alt_4_nada_gvwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_gvwr)),h.alt_4_nada_gvwr<>(typeof(h.alt_4_nada_gvwr))'');
    populated_alt_4_nada_gcwr_cnt := COUNT(GROUP,h.alt_4_nada_gcwr <> (TYPEOF(h.alt_4_nada_gcwr))'');
    populated_alt_4_nada_gcwr_pcnt := AVE(GROUP,IF(h.alt_4_nada_gcwr = (TYPEOF(h.alt_4_nada_gcwr))'',0,100));
    maxlength_alt_4_nada_gcwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_gcwr)));
    avelength_alt_4_nada_gcwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_4_nada_gcwr)),h.alt_4_nada_gcwr<>(typeof(h.alt_4_nada_gcwr))'');
    populated_alt_5_nada_vehicle_id_cnt := COUNT(GROUP,h.alt_5_nada_vehicle_id <> (TYPEOF(h.alt_5_nada_vehicle_id))'');
    populated_alt_5_nada_vehicle_id_pcnt := AVE(GROUP,IF(h.alt_5_nada_vehicle_id = (TYPEOF(h.alt_5_nada_vehicle_id))'',0,100));
    maxlength_alt_5_nada_vehicle_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_vehicle_id)));
    avelength_alt_5_nada_vehicle_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_vehicle_id)),h.alt_5_nada_vehicle_id<>(typeof(h.alt_5_nada_vehicle_id))'');
    populated_alt_5_nada_model_cnt := COUNT(GROUP,h.alt_5_nada_model <> (TYPEOF(h.alt_5_nada_model))'');
    populated_alt_5_nada_model_pcnt := AVE(GROUP,IF(h.alt_5_nada_model = (TYPEOF(h.alt_5_nada_model))'',0,100));
    maxlength_alt_5_nada_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_model)));
    avelength_alt_5_nada_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_model)),h.alt_5_nada_model<>(typeof(h.alt_5_nada_model))'');
    populated_alt_5_nada_body_style_cnt := COUNT(GROUP,h.alt_5_nada_body_style <> (TYPEOF(h.alt_5_nada_body_style))'');
    populated_alt_5_nada_body_style_pcnt := AVE(GROUP,IF(h.alt_5_nada_body_style = (TYPEOF(h.alt_5_nada_body_style))'',0,100));
    maxlength_alt_5_nada_body_style := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_body_style)));
    avelength_alt_5_nada_body_style := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_body_style)),h.alt_5_nada_body_style<>(typeof(h.alt_5_nada_body_style))'');
    populated_alt_5_nada_msrp_cnt := COUNT(GROUP,h.alt_5_nada_msrp <> (TYPEOF(h.alt_5_nada_msrp))'');
    populated_alt_5_nada_msrp_pcnt := AVE(GROUP,IF(h.alt_5_nada_msrp = (TYPEOF(h.alt_5_nada_msrp))'',0,100));
    maxlength_alt_5_nada_msrp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_msrp)));
    avelength_alt_5_nada_msrp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_msrp)),h.alt_5_nada_msrp<>(typeof(h.alt_5_nada_msrp))'');
    populated_alt_5_nada_gvwr_cnt := COUNT(GROUP,h.alt_5_nada_gvwr <> (TYPEOF(h.alt_5_nada_gvwr))'');
    populated_alt_5_nada_gvwr_pcnt := AVE(GROUP,IF(h.alt_5_nada_gvwr = (TYPEOF(h.alt_5_nada_gvwr))'',0,100));
    maxlength_alt_5_nada_gvwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_gvwr)));
    avelength_alt_5_nada_gvwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_gvwr)),h.alt_5_nada_gvwr<>(typeof(h.alt_5_nada_gvwr))'');
    populated_alt_5_nada_gcwr_cnt := COUNT(GROUP,h.alt_5_nada_gcwr <> (TYPEOF(h.alt_5_nada_gcwr))'');
    populated_alt_5_nada_gcwr_pcnt := AVE(GROUP,IF(h.alt_5_nada_gcwr = (TYPEOF(h.alt_5_nada_gcwr))'',0,100));
    maxlength_alt_5_nada_gcwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_gcwr)));
    avelength_alt_5_nada_gcwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_5_nada_gcwr)),h.alt_5_nada_gcwr<>(typeof(h.alt_5_nada_gcwr))'');
    populated_alt_6_nada_vehicle_id_cnt := COUNT(GROUP,h.alt_6_nada_vehicle_id <> (TYPEOF(h.alt_6_nada_vehicle_id))'');
    populated_alt_6_nada_vehicle_id_pcnt := AVE(GROUP,IF(h.alt_6_nada_vehicle_id = (TYPEOF(h.alt_6_nada_vehicle_id))'',0,100));
    maxlength_alt_6_nada_vehicle_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_vehicle_id)));
    avelength_alt_6_nada_vehicle_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_vehicle_id)),h.alt_6_nada_vehicle_id<>(typeof(h.alt_6_nada_vehicle_id))'');
    populated_alt_6_nada_model_cnt := COUNT(GROUP,h.alt_6_nada_model <> (TYPEOF(h.alt_6_nada_model))'');
    populated_alt_6_nada_model_pcnt := AVE(GROUP,IF(h.alt_6_nada_model = (TYPEOF(h.alt_6_nada_model))'',0,100));
    maxlength_alt_6_nada_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_model)));
    avelength_alt_6_nada_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_model)),h.alt_6_nada_model<>(typeof(h.alt_6_nada_model))'');
    populated_alt_6_nada_body_style_cnt := COUNT(GROUP,h.alt_6_nada_body_style <> (TYPEOF(h.alt_6_nada_body_style))'');
    populated_alt_6_nada_body_style_pcnt := AVE(GROUP,IF(h.alt_6_nada_body_style = (TYPEOF(h.alt_6_nada_body_style))'',0,100));
    maxlength_alt_6_nada_body_style := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_body_style)));
    avelength_alt_6_nada_body_style := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_body_style)),h.alt_6_nada_body_style<>(typeof(h.alt_6_nada_body_style))'');
    populated_alt_6_nada_msrp_cnt := COUNT(GROUP,h.alt_6_nada_msrp <> (TYPEOF(h.alt_6_nada_msrp))'');
    populated_alt_6_nada_msrp_pcnt := AVE(GROUP,IF(h.alt_6_nada_msrp = (TYPEOF(h.alt_6_nada_msrp))'',0,100));
    maxlength_alt_6_nada_msrp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_msrp)));
    avelength_alt_6_nada_msrp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_msrp)),h.alt_6_nada_msrp<>(typeof(h.alt_6_nada_msrp))'');
    populated_alt_6_nada_gvwr_cnt := COUNT(GROUP,h.alt_6_nada_gvwr <> (TYPEOF(h.alt_6_nada_gvwr))'');
    populated_alt_6_nada_gvwr_pcnt := AVE(GROUP,IF(h.alt_6_nada_gvwr = (TYPEOF(h.alt_6_nada_gvwr))'',0,100));
    maxlength_alt_6_nada_gvwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_gvwr)));
    avelength_alt_6_nada_gvwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_gvwr)),h.alt_6_nada_gvwr<>(typeof(h.alt_6_nada_gvwr))'');
    populated_alt_6_nada_gcwr_cnt := COUNT(GROUP,h.alt_6_nada_gcwr <> (TYPEOF(h.alt_6_nada_gcwr))'');
    populated_alt_6_nada_gcwr_pcnt := AVE(GROUP,IF(h.alt_6_nada_gcwr = (TYPEOF(h.alt_6_nada_gcwr))'',0,100));
    maxlength_alt_6_nada_gcwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_gcwr)));
    avelength_alt_6_nada_gcwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_6_nada_gcwr)),h.alt_6_nada_gcwr<>(typeof(h.alt_6_nada_gcwr))'');
    populated_alt_7_nada_vehicle_id_cnt := COUNT(GROUP,h.alt_7_nada_vehicle_id <> (TYPEOF(h.alt_7_nada_vehicle_id))'');
    populated_alt_7_nada_vehicle_id_pcnt := AVE(GROUP,IF(h.alt_7_nada_vehicle_id = (TYPEOF(h.alt_7_nada_vehicle_id))'',0,100));
    maxlength_alt_7_nada_vehicle_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_vehicle_id)));
    avelength_alt_7_nada_vehicle_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_vehicle_id)),h.alt_7_nada_vehicle_id<>(typeof(h.alt_7_nada_vehicle_id))'');
    populated_alt_7_nada_model_cnt := COUNT(GROUP,h.alt_7_nada_model <> (TYPEOF(h.alt_7_nada_model))'');
    populated_alt_7_nada_model_pcnt := AVE(GROUP,IF(h.alt_7_nada_model = (TYPEOF(h.alt_7_nada_model))'',0,100));
    maxlength_alt_7_nada_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_model)));
    avelength_alt_7_nada_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_model)),h.alt_7_nada_model<>(typeof(h.alt_7_nada_model))'');
    populated_alt_7_nada_body_style_cnt := COUNT(GROUP,h.alt_7_nada_body_style <> (TYPEOF(h.alt_7_nada_body_style))'');
    populated_alt_7_nada_body_style_pcnt := AVE(GROUP,IF(h.alt_7_nada_body_style = (TYPEOF(h.alt_7_nada_body_style))'',0,100));
    maxlength_alt_7_nada_body_style := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_body_style)));
    avelength_alt_7_nada_body_style := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_body_style)),h.alt_7_nada_body_style<>(typeof(h.alt_7_nada_body_style))'');
    populated_alt_7_nada_msrp_cnt := COUNT(GROUP,h.alt_7_nada_msrp <> (TYPEOF(h.alt_7_nada_msrp))'');
    populated_alt_7_nada_msrp_pcnt := AVE(GROUP,IF(h.alt_7_nada_msrp = (TYPEOF(h.alt_7_nada_msrp))'',0,100));
    maxlength_alt_7_nada_msrp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_msrp)));
    avelength_alt_7_nada_msrp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_msrp)),h.alt_7_nada_msrp<>(typeof(h.alt_7_nada_msrp))'');
    populated_alt_7_nada_gvwr_cnt := COUNT(GROUP,h.alt_7_nada_gvwr <> (TYPEOF(h.alt_7_nada_gvwr))'');
    populated_alt_7_nada_gvwr_pcnt := AVE(GROUP,IF(h.alt_7_nada_gvwr = (TYPEOF(h.alt_7_nada_gvwr))'',0,100));
    maxlength_alt_7_nada_gvwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_gvwr)));
    avelength_alt_7_nada_gvwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_gvwr)),h.alt_7_nada_gvwr<>(typeof(h.alt_7_nada_gvwr))'');
    populated_alt_7_nada_gcwr_cnt := COUNT(GROUP,h.alt_7_nada_gcwr <> (TYPEOF(h.alt_7_nada_gcwr))'');
    populated_alt_7_nada_gcwr_pcnt := AVE(GROUP,IF(h.alt_7_nada_gcwr = (TYPEOF(h.alt_7_nada_gcwr))'',0,100));
    maxlength_alt_7_nada_gcwr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_gcwr)));
    avelength_alt_7_nada_gcwr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.alt_7_nada_gcwr)),h.alt_7_nada_gcwr<>(typeof(h.alt_7_nada_gcwr))'');
    populated_aaia_codes_cnt := COUNT(GROUP,h.aaia_codes <> (TYPEOF(h.aaia_codes))'');
    populated_aaia_codes_pcnt := AVE(GROUP,IF(h.aaia_codes = (TYPEOF(h.aaia_codes))'',0,100));
    maxlength_aaia_codes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aaia_codes)));
    avelength_aaia_codes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aaia_codes)),h.aaia_codes<>(typeof(h.aaia_codes))'');
    populated_incomplete_vehicle_flag_cnt := COUNT(GROUP,h.incomplete_vehicle_flag <> (TYPEOF(h.incomplete_vehicle_flag))'');
    populated_incomplete_vehicle_flag_pcnt := AVE(GROUP,IF(h.incomplete_vehicle_flag = (TYPEOF(h.incomplete_vehicle_flag))'',0,100));
    maxlength_incomplete_vehicle_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.incomplete_vehicle_flag)));
    avelength_incomplete_vehicle_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.incomplete_vehicle_flag)),h.incomplete_vehicle_flag<>(typeof(h.incomplete_vehicle_flag))'');
    populated_filler2_cnt := COUNT(GROUP,h.filler2 <> (TYPEOF(h.filler2))'');
    populated_filler2_pcnt := AVE(GROUP,IF(h.filler2 = (TYPEOF(h.filler2))'',0,100));
    maxlength_filler2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler2)));
    avelength_filler2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler2)),h.filler2<>(typeof(h.filler2))'');
    populated_electric_battery_info_type_cnt := COUNT(GROUP,h.electric_battery_info_type <> (TYPEOF(h.electric_battery_info_type))'');
    populated_electric_battery_info_type_pcnt := AVE(GROUP,IF(h.electric_battery_info_type = (TYPEOF(h.electric_battery_info_type))'',0,100));
    maxlength_electric_battery_info_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.electric_battery_info_type)));
    avelength_electric_battery_info_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.electric_battery_info_type)),h.electric_battery_info_type<>(typeof(h.electric_battery_info_type))'');
    populated_filler3_cnt := COUNT(GROUP,h.filler3 <> (TYPEOF(h.filler3))'');
    populated_filler3_pcnt := AVE(GROUP,IF(h.filler3 = (TYPEOF(h.filler3))'',0,100));
    maxlength_filler3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler3)));
    avelength_filler3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler3)),h.filler3<>(typeof(h.filler3))'');
    populated_electric_battery_kilowatts_cnt := COUNT(GROUP,h.electric_battery_kilowatts <> (TYPEOF(h.electric_battery_kilowatts))'');
    populated_electric_battery_kilowatts_pcnt := AVE(GROUP,IF(h.electric_battery_kilowatts = (TYPEOF(h.electric_battery_kilowatts))'',0,100));
    maxlength_electric_battery_kilowatts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.electric_battery_kilowatts)));
    avelength_electric_battery_kilowatts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.electric_battery_kilowatts)),h.electric_battery_kilowatts<>(typeof(h.electric_battery_kilowatts))'');
    populated_filler4_cnt := COUNT(GROUP,h.filler4 <> (TYPEOF(h.filler4))'');
    populated_filler4_pcnt := AVE(GROUP,IF(h.filler4 = (TYPEOF(h.filler4))'',0,100));
    maxlength_filler4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler4)));
    avelength_filler4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler4)),h.filler4<>(typeof(h.filler4))'');
    populated_electric_battery_volts_cnt := COUNT(GROUP,h.electric_battery_volts <> (TYPEOF(h.electric_battery_volts))'');
    populated_electric_battery_volts_pcnt := AVE(GROUP,IF(h.electric_battery_volts = (TYPEOF(h.electric_battery_volts))'',0,100));
    maxlength_electric_battery_volts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.electric_battery_volts)));
    avelength_electric_battery_volts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.electric_battery_volts)),h.electric_battery_volts<>(typeof(h.electric_battery_volts))'');
    populated_filler5_cnt := COUNT(GROUP,h.filler5 <> (TYPEOF(h.filler5))'');
    populated_filler5_pcnt := AVE(GROUP,IF(h.filler5 = (TYPEOF(h.filler5))'',0,100));
    maxlength_filler5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler5)));
    avelength_filler5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler5)),h.filler5<>(typeof(h.filler5))'');
    populated_engine_info_proprietary_engine_brand_cnt := COUNT(GROUP,h.engine_info_proprietary_engine_brand <> (TYPEOF(h.engine_info_proprietary_engine_brand))'');
    populated_engine_info_proprietary_engine_brand_pcnt := AVE(GROUP,IF(h.engine_info_proprietary_engine_brand = (TYPEOF(h.engine_info_proprietary_engine_brand))'',0,100));
    maxlength_engine_info_proprietary_engine_brand := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_info_proprietary_engine_brand)));
    avelength_engine_info_proprietary_engine_brand := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_info_proprietary_engine_brand)),h.engine_info_proprietary_engine_brand<>(typeof(h.engine_info_proprietary_engine_brand))'');
    populated_filler6_cnt := COUNT(GROUP,h.filler6 <> (TYPEOF(h.filler6))'');
    populated_filler6_pcnt := AVE(GROUP,IF(h.filler6 = (TYPEOF(h.filler6))'',0,100));
    maxlength_filler6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler6)));
    avelength_filler6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler6)),h.filler6<>(typeof(h.filler6))'');
    populated_engine_info_high_output_engine_cnt := COUNT(GROUP,h.engine_info_high_output_engine <> (TYPEOF(h.engine_info_high_output_engine))'');
    populated_engine_info_high_output_engine_pcnt := AVE(GROUP,IF(h.engine_info_high_output_engine = (TYPEOF(h.engine_info_high_output_engine))'',0,100));
    maxlength_engine_info_high_output_engine := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_info_high_output_engine)));
    avelength_engine_info_high_output_engine := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_info_high_output_engine)),h.engine_info_high_output_engine<>(typeof(h.engine_info_high_output_engine))'');
    populated_engine_info_supercharged_cnt := COUNT(GROUP,h.engine_info_supercharged <> (TYPEOF(h.engine_info_supercharged))'');
    populated_engine_info_supercharged_pcnt := AVE(GROUP,IF(h.engine_info_supercharged = (TYPEOF(h.engine_info_supercharged))'',0,100));
    maxlength_engine_info_supercharged := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_info_supercharged)));
    avelength_engine_info_supercharged := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_info_supercharged)),h.engine_info_supercharged<>(typeof(h.engine_info_supercharged))'');
    populated_engine_info_turbocharged_cnt := COUNT(GROUP,h.engine_info_turbocharged <> (TYPEOF(h.engine_info_turbocharged))'');
    populated_engine_info_turbocharged_pcnt := AVE(GROUP,IF(h.engine_info_turbocharged = (TYPEOF(h.engine_info_turbocharged))'',0,100));
    maxlength_engine_info_turbocharged := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_info_turbocharged)));
    avelength_engine_info_turbocharged := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_info_turbocharged)),h.engine_info_turbocharged<>(typeof(h.engine_info_turbocharged))'');
    populated_engine_info_vvtl_cnt := COUNT(GROUP,h.engine_info_vvtl <> (TYPEOF(h.engine_info_vvtl))'');
    populated_engine_info_vvtl_pcnt := AVE(GROUP,IF(h.engine_info_vvtl = (TYPEOF(h.engine_info_vvtl))'',0,100));
    maxlength_engine_info_vvtl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_info_vvtl)));
    avelength_engine_info_vvtl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.engine_info_vvtl)),h.engine_info_vvtl<>(typeof(h.engine_info_vvtl))'');
    populated_iso_liability_cnt := COUNT(GROUP,h.iso_liability <> (TYPEOF(h.iso_liability))'');
    populated_iso_liability_pcnt := AVE(GROUP,IF(h.iso_liability = (TYPEOF(h.iso_liability))'',0,100));
    maxlength_iso_liability := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.iso_liability)));
    avelength_iso_liability := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.iso_liability)),h.iso_liability<>(typeof(h.iso_liability))'');
    populated_series_name_condensed_cnt := COUNT(GROUP,h.series_name_condensed <> (TYPEOF(h.series_name_condensed))'');
    populated_series_name_condensed_pcnt := AVE(GROUP,IF(h.series_name_condensed = (TYPEOF(h.series_name_condensed))'',0,100));
    maxlength_series_name_condensed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.series_name_condensed)));
    avelength_series_name_condensed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.series_name_condensed)),h.series_name_condensed<>(typeof(h.series_name_condensed))'');
    populated_aces_data_cnt := COUNT(GROUP,h.aces_data <> (TYPEOF(h.aces_data))'');
    populated_aces_data_pcnt := AVE(GROUP,IF(h.aces_data = (TYPEOF(h.aces_data))'',0,100));
    maxlength_aces_data := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aces_data)));
    avelength_aces_data := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aces_data)),h.aces_data<>(typeof(h.aces_data))'');
    populated_base_shipping_weight_expanded_cnt := COUNT(GROUP,h.base_shipping_weight_expanded <> (TYPEOF(h.base_shipping_weight_expanded))'');
    populated_base_shipping_weight_expanded_pcnt := AVE(GROUP,IF(h.base_shipping_weight_expanded = (TYPEOF(h.base_shipping_weight_expanded))'',0,100));
    maxlength_base_shipping_weight_expanded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.base_shipping_weight_expanded)));
    avelength_base_shipping_weight_expanded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.base_shipping_weight_expanded)),h.base_shipping_weight_expanded<>(typeof(h.base_shipping_weight_expanded))'');
    populated_filler7_cnt := COUNT(GROUP,h.filler7 <> (TYPEOF(h.filler7))'');
    populated_filler7_pcnt := AVE(GROUP,IF(h.filler7 = (TYPEOF(h.filler7))'',0,100));
    maxlength_filler7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler7)));
    avelength_filler7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler7)),h.filler7<>(typeof(h.filler7))'');
    populated_customer_defined_data_cnt := COUNT(GROUP,h.customer_defined_data <> (TYPEOF(h.customer_defined_data))'');
    populated_customer_defined_data_pcnt := AVE(GROUP,IF(h.customer_defined_data = (TYPEOF(h.customer_defined_data))'',0,100));
    maxlength_customer_defined_data := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_defined_data)));
    avelength_customer_defined_data := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.customer_defined_data)),h.customer_defined_data<>(typeof(h.customer_defined_data))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_match_make_pcnt *   0.00 / 100 + T.Populated_match_year_pcnt *   0.00 / 100 + T.Populated_match_vin_pcnt *   0.00 / 100 + T.Populated_make_abbreviation_pcnt *   0.00 / 100 + T.Populated_model_year_pcnt *   0.00 / 100 + T.Populated_vehicle_type_pcnt *   0.00 / 100 + T.Populated_make_name_pcnt *   0.00 / 100 + T.Populated_series_name_pcnt *   0.00 / 100 + T.Populated_body_type_pcnt *   0.00 / 100 + T.Populated_wheels_pcnt *   0.00 / 100 + T.Populated_displacement_pcnt *   0.00 / 100 + T.Populated_cylinders_pcnt *   0.00 / 100 + T.Populated_fuel_pcnt *   0.00 / 100 + T.Populated_carburetion_pcnt *   0.00 / 100 + T.Populated_gvw_pcnt *   0.00 / 100 + T.Populated_wheel_base_pcnt *   0.00 / 100 + T.Populated_tire_size_pcnt *   0.00 / 100 + T.Populated_ton_rating_pcnt *   0.00 / 100 + T.Populated_base_shipping_weight_pcnt *   0.00 / 100 + T.Populated_variance_weight_pcnt *   0.00 / 100 + T.Populated_base_list_price_pcnt *   0.00 / 100 + T.Populated_price_variance_pcnt *   0.00 / 100 + T.Populated_high_performance_code_pcnt *   0.00 / 100 + T.Populated_driving_wheels_pcnt *   0.00 / 100 + T.Populated_iso_physical_damage_pcnt *   0.00 / 100 + T.Populated_location_indicator_pcnt *   0.00 / 100 + T.Populated_air_conditioning_pcnt *   0.00 / 100 + T.Populated_power_steering_pcnt *   0.00 / 100 + T.Populated_power_brakes_pcnt *   0.00 / 100 + T.Populated_power_windows_pcnt *   0.00 / 100 + T.Populated_tilt_wheel_pcnt *   0.00 / 100 + T.Populated_roof_pcnt *   0.00 / 100 + T.Populated_optional_roof1_pcnt *   0.00 / 100 + T.Populated_optional_roof2_pcnt *   0.00 / 100 + T.Populated_radio_pcnt *   0.00 / 100 + T.Populated_optional_radio1_pcnt *   0.00 / 100 + T.Populated_optional_radio2_pcnt *   0.00 / 100 + T.Populated_transmission_pcnt *   0.00 / 100 + T.Populated_optional_transmission1_pcnt *   0.00 / 100 + T.Populated_optional_transmission2_pcnt *   0.00 / 100 + T.Populated_anti_lock_brakes_pcnt *   0.00 / 100 + T.Populated_security_system_pcnt *   0.00 / 100 + T.Populated_daytime_running_lights_pcnt *   0.00 / 100 + T.Populated_visrap_pcnt *   0.00 / 100 + T.Populated_cab_configuration_pcnt *   0.00 / 100 + T.Populated_front_axle_code_pcnt *   0.00 / 100 + T.Populated_rear_axle_code_pcnt *   0.00 / 100 + T.Populated_brakes_code_pcnt *   0.00 / 100 + T.Populated_engine_manufacturer_pcnt *   0.00 / 100 + T.Populated_engine_model_pcnt *   0.00 / 100 + T.Populated_engine_type_code_pcnt *   0.00 / 100 + T.Populated_trailer_body_style_pcnt *   0.00 / 100 + T.Populated_trailer_number_of_axles_pcnt *   0.00 / 100 + T.Populated_trailer_length_pcnt *   0.00 / 100 + T.Populated_proactive_vin_pcnt *   0.00 / 100 + T.Populated_ma_state_exceptions_pcnt *   0.00 / 100 + T.Populated_filler_1_pcnt *   0.00 / 100 + T.Populated_series_abbreviation_pcnt *   0.00 / 100 + T.Populated_vin_pattern_pcnt *   0.00 / 100 + T.Populated_ncic_data_pcnt *   0.00 / 100 + T.Populated_full_body_style_name_pcnt *   0.00 / 100 + T.Populated_nvpp_make_code_pcnt *   0.00 / 100 + T.Populated_nvpp_make_abbreviation_pcnt *   0.00 / 100 + T.Populated_nvpp_series_model_pcnt *   0.00 / 100 + T.Populated_nvpp_series_name_pcnt *   0.00 / 100 + T.Populated_segmentation_code_pcnt *   0.00 / 100 + T.Populated_country_of_origin_pcnt *   0.00 / 100 + T.Populated_engine_liter_information_pcnt *   0.00 / 100 + T.Populated_engine_information_filler1_pcnt *   0.00 / 100 + T.Populated_engine_information_block_type_pcnt *   0.00 / 100 + T.Populated_engine_information_cylinders_pcnt *   0.00 / 100 + T.Populated_engine_information_filler2_pcnt *   0.00 / 100 + T.Populated_engine_information_carburetion_pcnt *   0.00 / 100 + T.Populated_engine_information_filler3_pcnt *   0.00 / 100 + T.Populated_engine_information_head_configuration_pcnt *   0.00 / 100 + T.Populated_engine_information_filler4_pcnt *   0.00 / 100 + T.Populated_engine_information_total_valves_pcnt *   0.00 / 100 + T.Populated_engine_information_filler5_pcnt *   0.00 / 100 + T.Populated_engine_information_aspiration_code_pcnt *   0.00 / 100 + T.Populated_engine_information_carburetion_code_pcnt *   0.00 / 100 + T.Populated_engine_information_valves_per_cylinder_pcnt *   0.00 / 100 + T.Populated_transmission_speed_pcnt *   0.00 / 100 + T.Populated_transmission_filler1_pcnt *   0.00 / 100 + T.Populated_transmission_type_pcnt *   0.00 / 100 + T.Populated_transmission_filler2_pcnt *   0.00 / 100 + T.Populated_transmission_code_pcnt *   0.00 / 100 + T.Populated_transmission_filler3_pcnt *   0.00 / 100 + T.Populated_transmission_speed_code_pcnt *   0.00 / 100 + T.Populated_base_model_pcnt *   0.00 / 100 + T.Populated_complete_prefix_file_id_pcnt *   0.00 / 100 + T.Populated_series_name_full_spelling_pcnt *   0.00 / 100 + T.Populated_vis_theft_code_pcnt *   0.00 / 100 + T.Populated_base_list_price_expanded_pcnt *   0.00 / 100 + T.Populated_default_nada_vehicle_id_pcnt *   0.00 / 100 + T.Populated_default_nada_model_pcnt *   0.00 / 100 + T.Populated_default_nada_body_style_pcnt *   0.00 / 100 + T.Populated_default_nada_msrp_pcnt *   0.00 / 100 + T.Populated_default_nada_gvwr_pcnt *   0.00 / 100 + T.Populated_default_nada_gcwr_pcnt *   0.00 / 100 + T.Populated_alt_1_nada_vehicle_id_pcnt *   0.00 / 100 + T.Populated_alt_1_nada_model_pcnt *   0.00 / 100 + T.Populated_alt_1_nada_body_style_pcnt *   0.00 / 100 + T.Populated_alt_1_nada_msrp_pcnt *   0.00 / 100 + T.Populated_alt_1_nada_gvwr_pcnt *   0.00 / 100 + T.Populated_alt_1_nada_gcwr_pcnt *   0.00 / 100 + T.Populated_alt_2_nada_vehicle_id_pcnt *   0.00 / 100 + T.Populated_alt_2_nada_model_pcnt *   0.00 / 100 + T.Populated_alt_2_nada_body_style_pcnt *   0.00 / 100 + T.Populated_alt_2_nada_msrp_pcnt *   0.00 / 100 + T.Populated_alt_2_nada_gvwr_pcnt *   0.00 / 100 + T.Populated_alt_2_nada_gcwr_pcnt *   0.00 / 100 + T.Populated_alt_3_nada_vehicle_id_pcnt *   0.00 / 100 + T.Populated_alt_3_nada_model_pcnt *   0.00 / 100 + T.Populated_alt_3_nada_body_style_pcnt *   0.00 / 100 + T.Populated_alt_3_nada_msrp_pcnt *   0.00 / 100 + T.Populated_alt_3_nada_gvwr_pcnt *   0.00 / 100 + T.Populated_alt_3_nada_gcwr_pcnt *   0.00 / 100 + T.Populated_alt_4_nada_vehicle_id_pcnt *   0.00 / 100 + T.Populated_alt_4_nada_model_pcnt *   0.00 / 100 + T.Populated_alt_4_nada_body_style_pcnt *   0.00 / 100 + T.Populated_alt_4_nada_msrp_pcnt *   0.00 / 100 + T.Populated_alt_4_nada_gvwr_pcnt *   0.00 / 100 + T.Populated_alt_4_nada_gcwr_pcnt *   0.00 / 100 + T.Populated_alt_5_nada_vehicle_id_pcnt *   0.00 / 100 + T.Populated_alt_5_nada_model_pcnt *   0.00 / 100 + T.Populated_alt_5_nada_body_style_pcnt *   0.00 / 100 + T.Populated_alt_5_nada_msrp_pcnt *   0.00 / 100 + T.Populated_alt_5_nada_gvwr_pcnt *   0.00 / 100 + T.Populated_alt_5_nada_gcwr_pcnt *   0.00 / 100 + T.Populated_alt_6_nada_vehicle_id_pcnt *   0.00 / 100 + T.Populated_alt_6_nada_model_pcnt *   0.00 / 100 + T.Populated_alt_6_nada_body_style_pcnt *   0.00 / 100 + T.Populated_alt_6_nada_msrp_pcnt *   0.00 / 100 + T.Populated_alt_6_nada_gvwr_pcnt *   0.00 / 100 + T.Populated_alt_6_nada_gcwr_pcnt *   0.00 / 100 + T.Populated_alt_7_nada_vehicle_id_pcnt *   0.00 / 100 + T.Populated_alt_7_nada_model_pcnt *   0.00 / 100 + T.Populated_alt_7_nada_body_style_pcnt *   0.00 / 100 + T.Populated_alt_7_nada_msrp_pcnt *   0.00 / 100 + T.Populated_alt_7_nada_gvwr_pcnt *   0.00 / 100 + T.Populated_alt_7_nada_gcwr_pcnt *   0.00 / 100 + T.Populated_aaia_codes_pcnt *   0.00 / 100 + T.Populated_incomplete_vehicle_flag_pcnt *   0.00 / 100 + T.Populated_filler2_pcnt *   0.00 / 100 + T.Populated_electric_battery_info_type_pcnt *   0.00 / 100 + T.Populated_filler3_pcnt *   0.00 / 100 + T.Populated_electric_battery_kilowatts_pcnt *   0.00 / 100 + T.Populated_filler4_pcnt *   0.00 / 100 + T.Populated_electric_battery_volts_pcnt *   0.00 / 100 + T.Populated_filler5_pcnt *   0.00 / 100 + T.Populated_engine_info_proprietary_engine_brand_pcnt *   0.00 / 100 + T.Populated_filler6_pcnt *   0.00 / 100 + T.Populated_engine_info_high_output_engine_pcnt *   0.00 / 100 + T.Populated_engine_info_supercharged_pcnt *   0.00 / 100 + T.Populated_engine_info_turbocharged_pcnt *   0.00 / 100 + T.Populated_engine_info_vvtl_pcnt *   0.00 / 100 + T.Populated_iso_liability_pcnt *   0.00 / 100 + T.Populated_series_name_condensed_pcnt *   0.00 / 100 + T.Populated_aces_data_pcnt *   0.00 / 100 + T.Populated_base_shipping_weight_expanded_pcnt *   0.00 / 100 + T.Populated_filler7_pcnt *   0.00 / 100 + T.Populated_customer_defined_data_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'match_make','match_year','match_vin','make_abbreviation','model_year','vehicle_type','make_name','series_name','body_type','wheels','displacement','cylinders','fuel','carburetion','gvw','wheel_base','tire_size','ton_rating','base_shipping_weight','variance_weight','base_list_price','price_variance','high_performance_code','driving_wheels','iso_physical_damage','location_indicator','air_conditioning','power_steering','power_brakes','power_windows','tilt_wheel','roof','optional_roof1','optional_roof2','radio','optional_radio1','optional_radio2','transmission','optional_transmission1','optional_transmission2','anti_lock_brakes','security_system','daytime_running_lights','visrap','cab_configuration','front_axle_code','rear_axle_code','brakes_code','engine_manufacturer','engine_model','engine_type_code','trailer_body_style','trailer_number_of_axles','trailer_length','proactive_vin','ma_state_exceptions','filler_1','series_abbreviation','vin_pattern','ncic_data','full_body_style_name','nvpp_make_code','nvpp_make_abbreviation','nvpp_series_model','nvpp_series_name','segmentation_code','country_of_origin','engine_liter_information','engine_information_filler1','engine_information_block_type','engine_information_cylinders','engine_information_filler2','engine_information_carburetion','engine_information_filler3','engine_information_head_configuration','engine_information_filler4','engine_information_total_valves','engine_information_filler5','engine_information_aspiration_code','engine_information_carburetion_code','engine_information_valves_per_cylinder','transmission_speed','transmission_filler1','transmission_type','transmission_filler2','transmission_code','transmission_filler3','transmission_speed_code','base_model','complete_prefix_file_id','series_name_full_spelling','vis_theft_code','base_list_price_expanded','default_nada_vehicle_id','default_nada_model','default_nada_body_style','default_nada_msrp','default_nada_gvwr','default_nada_gcwr','alt_1_nada_vehicle_id','alt_1_nada_model','alt_1_nada_body_style','alt_1_nada_msrp','alt_1_nada_gvwr','alt_1_nada_gcwr','alt_2_nada_vehicle_id','alt_2_nada_model','alt_2_nada_body_style','alt_2_nada_msrp','alt_2_nada_gvwr','alt_2_nada_gcwr','alt_3_nada_vehicle_id','alt_3_nada_model','alt_3_nada_body_style','alt_3_nada_msrp','alt_3_nada_gvwr','alt_3_nada_gcwr','alt_4_nada_vehicle_id','alt_4_nada_model','alt_4_nada_body_style','alt_4_nada_msrp','alt_4_nada_gvwr','alt_4_nada_gcwr','alt_5_nada_vehicle_id','alt_5_nada_model','alt_5_nada_body_style','alt_5_nada_msrp','alt_5_nada_gvwr','alt_5_nada_gcwr','alt_6_nada_vehicle_id','alt_6_nada_model','alt_6_nada_body_style','alt_6_nada_msrp','alt_6_nada_gvwr','alt_6_nada_gcwr','alt_7_nada_vehicle_id','alt_7_nada_model','alt_7_nada_body_style','alt_7_nada_msrp','alt_7_nada_gvwr','alt_7_nada_gcwr','aaia_codes','incomplete_vehicle_flag','filler2','electric_battery_info_type','filler3','electric_battery_kilowatts','filler4','electric_battery_volts','filler5','engine_info_proprietary_engine_brand','filler6','engine_info_high_output_engine','engine_info_supercharged','engine_info_turbocharged','engine_info_vvtl','iso_liability','series_name_condensed','aces_data','base_shipping_weight_expanded','filler7','customer_defined_data');
  SELF.populated_pcnt := CHOOSE(C,le.populated_match_make_pcnt,le.populated_match_year_pcnt,le.populated_match_vin_pcnt,le.populated_make_abbreviation_pcnt,le.populated_model_year_pcnt,le.populated_vehicle_type_pcnt,le.populated_make_name_pcnt,le.populated_series_name_pcnt,le.populated_body_type_pcnt,le.populated_wheels_pcnt,le.populated_displacement_pcnt,le.populated_cylinders_pcnt,le.populated_fuel_pcnt,le.populated_carburetion_pcnt,le.populated_gvw_pcnt,le.populated_wheel_base_pcnt,le.populated_tire_size_pcnt,le.populated_ton_rating_pcnt,le.populated_base_shipping_weight_pcnt,le.populated_variance_weight_pcnt,le.populated_base_list_price_pcnt,le.populated_price_variance_pcnt,le.populated_high_performance_code_pcnt,le.populated_driving_wheels_pcnt,le.populated_iso_physical_damage_pcnt,le.populated_location_indicator_pcnt,le.populated_air_conditioning_pcnt,le.populated_power_steering_pcnt,le.populated_power_brakes_pcnt,le.populated_power_windows_pcnt,le.populated_tilt_wheel_pcnt,le.populated_roof_pcnt,le.populated_optional_roof1_pcnt,le.populated_optional_roof2_pcnt,le.populated_radio_pcnt,le.populated_optional_radio1_pcnt,le.populated_optional_radio2_pcnt,le.populated_transmission_pcnt,le.populated_optional_transmission1_pcnt,le.populated_optional_transmission2_pcnt,le.populated_anti_lock_brakes_pcnt,le.populated_security_system_pcnt,le.populated_daytime_running_lights_pcnt,le.populated_visrap_pcnt,le.populated_cab_configuration_pcnt,le.populated_front_axle_code_pcnt,le.populated_rear_axle_code_pcnt,le.populated_brakes_code_pcnt,le.populated_engine_manufacturer_pcnt,le.populated_engine_model_pcnt,le.populated_engine_type_code_pcnt,le.populated_trailer_body_style_pcnt,le.populated_trailer_number_of_axles_pcnt,le.populated_trailer_length_pcnt,le.populated_proactive_vin_pcnt,le.populated_ma_state_exceptions_pcnt,le.populated_filler_1_pcnt,le.populated_series_abbreviation_pcnt,le.populated_vin_pattern_pcnt,le.populated_ncic_data_pcnt,le.populated_full_body_style_name_pcnt,le.populated_nvpp_make_code_pcnt,le.populated_nvpp_make_abbreviation_pcnt,le.populated_nvpp_series_model_pcnt,le.populated_nvpp_series_name_pcnt,le.populated_segmentation_code_pcnt,le.populated_country_of_origin_pcnt,le.populated_engine_liter_information_pcnt,le.populated_engine_information_filler1_pcnt,le.populated_engine_information_block_type_pcnt,le.populated_engine_information_cylinders_pcnt,le.populated_engine_information_filler2_pcnt,le.populated_engine_information_carburetion_pcnt,le.populated_engine_information_filler3_pcnt,le.populated_engine_information_head_configuration_pcnt,le.populated_engine_information_filler4_pcnt,le.populated_engine_information_total_valves_pcnt,le.populated_engine_information_filler5_pcnt,le.populated_engine_information_aspiration_code_pcnt,le.populated_engine_information_carburetion_code_pcnt,le.populated_engine_information_valves_per_cylinder_pcnt,le.populated_transmission_speed_pcnt,le.populated_transmission_filler1_pcnt,le.populated_transmission_type_pcnt,le.populated_transmission_filler2_pcnt,le.populated_transmission_code_pcnt,le.populated_transmission_filler3_pcnt,le.populated_transmission_speed_code_pcnt,le.populated_base_model_pcnt,le.populated_complete_prefix_file_id_pcnt,le.populated_series_name_full_spelling_pcnt,le.populated_vis_theft_code_pcnt,le.populated_base_list_price_expanded_pcnt,le.populated_default_nada_vehicle_id_pcnt,le.populated_default_nada_model_pcnt,le.populated_default_nada_body_style_pcnt,le.populated_default_nada_msrp_pcnt,le.populated_default_nada_gvwr_pcnt,le.populated_default_nada_gcwr_pcnt,le.populated_alt_1_nada_vehicle_id_pcnt,le.populated_alt_1_nada_model_pcnt,le.populated_alt_1_nada_body_style_pcnt,le.populated_alt_1_nada_msrp_pcnt,le.populated_alt_1_nada_gvwr_pcnt,le.populated_alt_1_nada_gcwr_pcnt,le.populated_alt_2_nada_vehicle_id_pcnt,le.populated_alt_2_nada_model_pcnt,le.populated_alt_2_nada_body_style_pcnt,le.populated_alt_2_nada_msrp_pcnt,le.populated_alt_2_nada_gvwr_pcnt,le.populated_alt_2_nada_gcwr_pcnt,le.populated_alt_3_nada_vehicle_id_pcnt,le.populated_alt_3_nada_model_pcnt,le.populated_alt_3_nada_body_style_pcnt,le.populated_alt_3_nada_msrp_pcnt,le.populated_alt_3_nada_gvwr_pcnt,le.populated_alt_3_nada_gcwr_pcnt,le.populated_alt_4_nada_vehicle_id_pcnt,le.populated_alt_4_nada_model_pcnt,le.populated_alt_4_nada_body_style_pcnt,le.populated_alt_4_nada_msrp_pcnt,le.populated_alt_4_nada_gvwr_pcnt,le.populated_alt_4_nada_gcwr_pcnt,le.populated_alt_5_nada_vehicle_id_pcnt,le.populated_alt_5_nada_model_pcnt,le.populated_alt_5_nada_body_style_pcnt,le.populated_alt_5_nada_msrp_pcnt,le.populated_alt_5_nada_gvwr_pcnt,le.populated_alt_5_nada_gcwr_pcnt,le.populated_alt_6_nada_vehicle_id_pcnt,le.populated_alt_6_nada_model_pcnt,le.populated_alt_6_nada_body_style_pcnt,le.populated_alt_6_nada_msrp_pcnt,le.populated_alt_6_nada_gvwr_pcnt,le.populated_alt_6_nada_gcwr_pcnt,le.populated_alt_7_nada_vehicle_id_pcnt,le.populated_alt_7_nada_model_pcnt,le.populated_alt_7_nada_body_style_pcnt,le.populated_alt_7_nada_msrp_pcnt,le.populated_alt_7_nada_gvwr_pcnt,le.populated_alt_7_nada_gcwr_pcnt,le.populated_aaia_codes_pcnt,le.populated_incomplete_vehicle_flag_pcnt,le.populated_filler2_pcnt,le.populated_electric_battery_info_type_pcnt,le.populated_filler3_pcnt,le.populated_electric_battery_kilowatts_pcnt,le.populated_filler4_pcnt,le.populated_electric_battery_volts_pcnt,le.populated_filler5_pcnt,le.populated_engine_info_proprietary_engine_brand_pcnt,le.populated_filler6_pcnt,le.populated_engine_info_high_output_engine_pcnt,le.populated_engine_info_supercharged_pcnt,le.populated_engine_info_turbocharged_pcnt,le.populated_engine_info_vvtl_pcnt,le.populated_iso_liability_pcnt,le.populated_series_name_condensed_pcnt,le.populated_aces_data_pcnt,le.populated_base_shipping_weight_expanded_pcnt,le.populated_filler7_pcnt,le.populated_customer_defined_data_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_match_make,le.maxlength_match_year,le.maxlength_match_vin,le.maxlength_make_abbreviation,le.maxlength_model_year,le.maxlength_vehicle_type,le.maxlength_make_name,le.maxlength_series_name,le.maxlength_body_type,le.maxlength_wheels,le.maxlength_displacement,le.maxlength_cylinders,le.maxlength_fuel,le.maxlength_carburetion,le.maxlength_gvw,le.maxlength_wheel_base,le.maxlength_tire_size,le.maxlength_ton_rating,le.maxlength_base_shipping_weight,le.maxlength_variance_weight,le.maxlength_base_list_price,le.maxlength_price_variance,le.maxlength_high_performance_code,le.maxlength_driving_wheels,le.maxlength_iso_physical_damage,le.maxlength_location_indicator,le.maxlength_air_conditioning,le.maxlength_power_steering,le.maxlength_power_brakes,le.maxlength_power_windows,le.maxlength_tilt_wheel,le.maxlength_roof,le.maxlength_optional_roof1,le.maxlength_optional_roof2,le.maxlength_radio,le.maxlength_optional_radio1,le.maxlength_optional_radio2,le.maxlength_transmission,le.maxlength_optional_transmission1,le.maxlength_optional_transmission2,le.maxlength_anti_lock_brakes,le.maxlength_security_system,le.maxlength_daytime_running_lights,le.maxlength_visrap,le.maxlength_cab_configuration,le.maxlength_front_axle_code,le.maxlength_rear_axle_code,le.maxlength_brakes_code,le.maxlength_engine_manufacturer,le.maxlength_engine_model,le.maxlength_engine_type_code,le.maxlength_trailer_body_style,le.maxlength_trailer_number_of_axles,le.maxlength_trailer_length,le.maxlength_proactive_vin,le.maxlength_ma_state_exceptions,le.maxlength_filler_1,le.maxlength_series_abbreviation,le.maxlength_vin_pattern,le.maxlength_ncic_data,le.maxlength_full_body_style_name,le.maxlength_nvpp_make_code,le.maxlength_nvpp_make_abbreviation,le.maxlength_nvpp_series_model,le.maxlength_nvpp_series_name,le.maxlength_segmentation_code,le.maxlength_country_of_origin,le.maxlength_engine_liter_information,le.maxlength_engine_information_filler1,le.maxlength_engine_information_block_type,le.maxlength_engine_information_cylinders,le.maxlength_engine_information_filler2,le.maxlength_engine_information_carburetion,le.maxlength_engine_information_filler3,le.maxlength_engine_information_head_configuration,le.maxlength_engine_information_filler4,le.maxlength_engine_information_total_valves,le.maxlength_engine_information_filler5,le.maxlength_engine_information_aspiration_code,le.maxlength_engine_information_carburetion_code,le.maxlength_engine_information_valves_per_cylinder,le.maxlength_transmission_speed,le.maxlength_transmission_filler1,le.maxlength_transmission_type,le.maxlength_transmission_filler2,le.maxlength_transmission_code,le.maxlength_transmission_filler3,le.maxlength_transmission_speed_code,le.maxlength_base_model,le.maxlength_complete_prefix_file_id,le.maxlength_series_name_full_spelling,le.maxlength_vis_theft_code,le.maxlength_base_list_price_expanded,le.maxlength_default_nada_vehicle_id,le.maxlength_default_nada_model,le.maxlength_default_nada_body_style,le.maxlength_default_nada_msrp,le.maxlength_default_nada_gvwr,le.maxlength_default_nada_gcwr,le.maxlength_alt_1_nada_vehicle_id,le.maxlength_alt_1_nada_model,le.maxlength_alt_1_nada_body_style,le.maxlength_alt_1_nada_msrp,le.maxlength_alt_1_nada_gvwr,le.maxlength_alt_1_nada_gcwr,le.maxlength_alt_2_nada_vehicle_id,le.maxlength_alt_2_nada_model,le.maxlength_alt_2_nada_body_style,le.maxlength_alt_2_nada_msrp,le.maxlength_alt_2_nada_gvwr,le.maxlength_alt_2_nada_gcwr,le.maxlength_alt_3_nada_vehicle_id,le.maxlength_alt_3_nada_model,le.maxlength_alt_3_nada_body_style,le.maxlength_alt_3_nada_msrp,le.maxlength_alt_3_nada_gvwr,le.maxlength_alt_3_nada_gcwr,le.maxlength_alt_4_nada_vehicle_id,le.maxlength_alt_4_nada_model,le.maxlength_alt_4_nada_body_style,le.maxlength_alt_4_nada_msrp,le.maxlength_alt_4_nada_gvwr,le.maxlength_alt_4_nada_gcwr,le.maxlength_alt_5_nada_vehicle_id,le.maxlength_alt_5_nada_model,le.maxlength_alt_5_nada_body_style,le.maxlength_alt_5_nada_msrp,le.maxlength_alt_5_nada_gvwr,le.maxlength_alt_5_nada_gcwr,le.maxlength_alt_6_nada_vehicle_id,le.maxlength_alt_6_nada_model,le.maxlength_alt_6_nada_body_style,le.maxlength_alt_6_nada_msrp,le.maxlength_alt_6_nada_gvwr,le.maxlength_alt_6_nada_gcwr,le.maxlength_alt_7_nada_vehicle_id,le.maxlength_alt_7_nada_model,le.maxlength_alt_7_nada_body_style,le.maxlength_alt_7_nada_msrp,le.maxlength_alt_7_nada_gvwr,le.maxlength_alt_7_nada_gcwr,le.maxlength_aaia_codes,le.maxlength_incomplete_vehicle_flag,le.maxlength_filler2,le.maxlength_electric_battery_info_type,le.maxlength_filler3,le.maxlength_electric_battery_kilowatts,le.maxlength_filler4,le.maxlength_electric_battery_volts,le.maxlength_filler5,le.maxlength_engine_info_proprietary_engine_brand,le.maxlength_filler6,le.maxlength_engine_info_high_output_engine,le.maxlength_engine_info_supercharged,le.maxlength_engine_info_turbocharged,le.maxlength_engine_info_vvtl,le.maxlength_iso_liability,le.maxlength_series_name_condensed,le.maxlength_aces_data,le.maxlength_base_shipping_weight_expanded,le.maxlength_filler7,le.maxlength_customer_defined_data);
  SELF.avelength := CHOOSE(C,le.avelength_match_make,le.avelength_match_year,le.avelength_match_vin,le.avelength_make_abbreviation,le.avelength_model_year,le.avelength_vehicle_type,le.avelength_make_name,le.avelength_series_name,le.avelength_body_type,le.avelength_wheels,le.avelength_displacement,le.avelength_cylinders,le.avelength_fuel,le.avelength_carburetion,le.avelength_gvw,le.avelength_wheel_base,le.avelength_tire_size,le.avelength_ton_rating,le.avelength_base_shipping_weight,le.avelength_variance_weight,le.avelength_base_list_price,le.avelength_price_variance,le.avelength_high_performance_code,le.avelength_driving_wheels,le.avelength_iso_physical_damage,le.avelength_location_indicator,le.avelength_air_conditioning,le.avelength_power_steering,le.avelength_power_brakes,le.avelength_power_windows,le.avelength_tilt_wheel,le.avelength_roof,le.avelength_optional_roof1,le.avelength_optional_roof2,le.avelength_radio,le.avelength_optional_radio1,le.avelength_optional_radio2,le.avelength_transmission,le.avelength_optional_transmission1,le.avelength_optional_transmission2,le.avelength_anti_lock_brakes,le.avelength_security_system,le.avelength_daytime_running_lights,le.avelength_visrap,le.avelength_cab_configuration,le.avelength_front_axle_code,le.avelength_rear_axle_code,le.avelength_brakes_code,le.avelength_engine_manufacturer,le.avelength_engine_model,le.avelength_engine_type_code,le.avelength_trailer_body_style,le.avelength_trailer_number_of_axles,le.avelength_trailer_length,le.avelength_proactive_vin,le.avelength_ma_state_exceptions,le.avelength_filler_1,le.avelength_series_abbreviation,le.avelength_vin_pattern,le.avelength_ncic_data,le.avelength_full_body_style_name,le.avelength_nvpp_make_code,le.avelength_nvpp_make_abbreviation,le.avelength_nvpp_series_model,le.avelength_nvpp_series_name,le.avelength_segmentation_code,le.avelength_country_of_origin,le.avelength_engine_liter_information,le.avelength_engine_information_filler1,le.avelength_engine_information_block_type,le.avelength_engine_information_cylinders,le.avelength_engine_information_filler2,le.avelength_engine_information_carburetion,le.avelength_engine_information_filler3,le.avelength_engine_information_head_configuration,le.avelength_engine_information_filler4,le.avelength_engine_information_total_valves,le.avelength_engine_information_filler5,le.avelength_engine_information_aspiration_code,le.avelength_engine_information_carburetion_code,le.avelength_engine_information_valves_per_cylinder,le.avelength_transmission_speed,le.avelength_transmission_filler1,le.avelength_transmission_type,le.avelength_transmission_filler2,le.avelength_transmission_code,le.avelength_transmission_filler3,le.avelength_transmission_speed_code,le.avelength_base_model,le.avelength_complete_prefix_file_id,le.avelength_series_name_full_spelling,le.avelength_vis_theft_code,le.avelength_base_list_price_expanded,le.avelength_default_nada_vehicle_id,le.avelength_default_nada_model,le.avelength_default_nada_body_style,le.avelength_default_nada_msrp,le.avelength_default_nada_gvwr,le.avelength_default_nada_gcwr,le.avelength_alt_1_nada_vehicle_id,le.avelength_alt_1_nada_model,le.avelength_alt_1_nada_body_style,le.avelength_alt_1_nada_msrp,le.avelength_alt_1_nada_gvwr,le.avelength_alt_1_nada_gcwr,le.avelength_alt_2_nada_vehicle_id,le.avelength_alt_2_nada_model,le.avelength_alt_2_nada_body_style,le.avelength_alt_2_nada_msrp,le.avelength_alt_2_nada_gvwr,le.avelength_alt_2_nada_gcwr,le.avelength_alt_3_nada_vehicle_id,le.avelength_alt_3_nada_model,le.avelength_alt_3_nada_body_style,le.avelength_alt_3_nada_msrp,le.avelength_alt_3_nada_gvwr,le.avelength_alt_3_nada_gcwr,le.avelength_alt_4_nada_vehicle_id,le.avelength_alt_4_nada_model,le.avelength_alt_4_nada_body_style,le.avelength_alt_4_nada_msrp,le.avelength_alt_4_nada_gvwr,le.avelength_alt_4_nada_gcwr,le.avelength_alt_5_nada_vehicle_id,le.avelength_alt_5_nada_model,le.avelength_alt_5_nada_body_style,le.avelength_alt_5_nada_msrp,le.avelength_alt_5_nada_gvwr,le.avelength_alt_5_nada_gcwr,le.avelength_alt_6_nada_vehicle_id,le.avelength_alt_6_nada_model,le.avelength_alt_6_nada_body_style,le.avelength_alt_6_nada_msrp,le.avelength_alt_6_nada_gvwr,le.avelength_alt_6_nada_gcwr,le.avelength_alt_7_nada_vehicle_id,le.avelength_alt_7_nada_model,le.avelength_alt_7_nada_body_style,le.avelength_alt_7_nada_msrp,le.avelength_alt_7_nada_gvwr,le.avelength_alt_7_nada_gcwr,le.avelength_aaia_codes,le.avelength_incomplete_vehicle_flag,le.avelength_filler2,le.avelength_electric_battery_info_type,le.avelength_filler3,le.avelength_electric_battery_kilowatts,le.avelength_filler4,le.avelength_electric_battery_volts,le.avelength_filler5,le.avelength_engine_info_proprietary_engine_brand,le.avelength_filler6,le.avelength_engine_info_high_output_engine,le.avelength_engine_info_supercharged,le.avelength_engine_info_turbocharged,le.avelength_engine_info_vvtl,le.avelength_iso_liability,le.avelength_series_name_condensed,le.avelength_aces_data,le.avelength_base_shipping_weight_expanded,le.avelength_filler7,le.avelength_customer_defined_data);
END;
EXPORT invSummary := NORMALIZE(summary0, 162, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.match_make),TRIM((SALT311.StrType)le.match_year),TRIM((SALT311.StrType)le.match_vin),TRIM((SALT311.StrType)le.make_abbreviation),TRIM((SALT311.StrType)le.model_year),TRIM((SALT311.StrType)le.vehicle_type),TRIM((SALT311.StrType)le.make_name),TRIM((SALT311.StrType)le.series_name),TRIM((SALT311.StrType)le.body_type),TRIM((SALT311.StrType)le.wheels),TRIM((SALT311.StrType)le.displacement),TRIM((SALT311.StrType)le.cylinders),TRIM((SALT311.StrType)le.fuel),TRIM((SALT311.StrType)le.carburetion),TRIM((SALT311.StrType)le.gvw),TRIM((SALT311.StrType)le.wheel_base),TRIM((SALT311.StrType)le.tire_size),TRIM((SALT311.StrType)le.ton_rating),TRIM((SALT311.StrType)le.base_shipping_weight),TRIM((SALT311.StrType)le.variance_weight),TRIM((SALT311.StrType)le.base_list_price),TRIM((SALT311.StrType)le.price_variance),TRIM((SALT311.StrType)le.high_performance_code),TRIM((SALT311.StrType)le.driving_wheels),TRIM((SALT311.StrType)le.iso_physical_damage),TRIM((SALT311.StrType)le.location_indicator),TRIM((SALT311.StrType)le.air_conditioning),TRIM((SALT311.StrType)le.power_steering),TRIM((SALT311.StrType)le.power_brakes),TRIM((SALT311.StrType)le.power_windows),TRIM((SALT311.StrType)le.tilt_wheel),TRIM((SALT311.StrType)le.roof),TRIM((SALT311.StrType)le.optional_roof1),TRIM((SALT311.StrType)le.optional_roof2),TRIM((SALT311.StrType)le.radio),TRIM((SALT311.StrType)le.optional_radio1),TRIM((SALT311.StrType)le.optional_radio2),TRIM((SALT311.StrType)le.transmission),TRIM((SALT311.StrType)le.optional_transmission1),TRIM((SALT311.StrType)le.optional_transmission2),TRIM((SALT311.StrType)le.anti_lock_brakes),TRIM((SALT311.StrType)le.security_system),TRIM((SALT311.StrType)le.daytime_running_lights),TRIM((SALT311.StrType)le.visrap),TRIM((SALT311.StrType)le.cab_configuration),TRIM((SALT311.StrType)le.front_axle_code),TRIM((SALT311.StrType)le.rear_axle_code),TRIM((SALT311.StrType)le.brakes_code),TRIM((SALT311.StrType)le.engine_manufacturer),TRIM((SALT311.StrType)le.engine_model),TRIM((SALT311.StrType)le.engine_type_code),TRIM((SALT311.StrType)le.trailer_body_style),TRIM((SALT311.StrType)le.trailer_number_of_axles),TRIM((SALT311.StrType)le.trailer_length),TRIM((SALT311.StrType)le.proactive_vin),TRIM((SALT311.StrType)le.ma_state_exceptions),TRIM((SALT311.StrType)le.filler_1),TRIM((SALT311.StrType)le.series_abbreviation),TRIM((SALT311.StrType)le.vin_pattern),TRIM((SALT311.StrType)le.ncic_data),TRIM((SALT311.StrType)le.full_body_style_name),TRIM((SALT311.StrType)le.nvpp_make_code),TRIM((SALT311.StrType)le.nvpp_make_abbreviation),TRIM((SALT311.StrType)le.nvpp_series_model),TRIM((SALT311.StrType)le.nvpp_series_name),TRIM((SALT311.StrType)le.segmentation_code),TRIM((SALT311.StrType)le.country_of_origin),TRIM((SALT311.StrType)le.engine_liter_information),TRIM((SALT311.StrType)le.engine_information_filler1),TRIM((SALT311.StrType)le.engine_information_block_type),TRIM((SALT311.StrType)le.engine_information_cylinders),TRIM((SALT311.StrType)le.engine_information_filler2),TRIM((SALT311.StrType)le.engine_information_carburetion),TRIM((SALT311.StrType)le.engine_information_filler3),TRIM((SALT311.StrType)le.engine_information_head_configuration),TRIM((SALT311.StrType)le.engine_information_filler4),TRIM((SALT311.StrType)le.engine_information_total_valves),TRIM((SALT311.StrType)le.engine_information_filler5),TRIM((SALT311.StrType)le.engine_information_aspiration_code),TRIM((SALT311.StrType)le.engine_information_carburetion_code),TRIM((SALT311.StrType)le.engine_information_valves_per_cylinder),TRIM((SALT311.StrType)le.transmission_speed),TRIM((SALT311.StrType)le.transmission_filler1),TRIM((SALT311.StrType)le.transmission_type),TRIM((SALT311.StrType)le.transmission_filler2),TRIM((SALT311.StrType)le.transmission_code),TRIM((SALT311.StrType)le.transmission_filler3),TRIM((SALT311.StrType)le.transmission_speed_code),TRIM((SALT311.StrType)le.base_model),TRIM((SALT311.StrType)le.complete_prefix_file_id),TRIM((SALT311.StrType)le.series_name_full_spelling),TRIM((SALT311.StrType)le.vis_theft_code),TRIM((SALT311.StrType)le.base_list_price_expanded),TRIM((SALT311.StrType)le.default_nada_vehicle_id),TRIM((SALT311.StrType)le.default_nada_model),TRIM((SALT311.StrType)le.default_nada_body_style),TRIM((SALT311.StrType)le.default_nada_msrp),TRIM((SALT311.StrType)le.default_nada_gvwr),TRIM((SALT311.StrType)le.default_nada_gcwr),TRIM((SALT311.StrType)le.alt_1_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_1_nada_model),TRIM((SALT311.StrType)le.alt_1_nada_body_style),TRIM((SALT311.StrType)le.alt_1_nada_msrp),TRIM((SALT311.StrType)le.alt_1_nada_gvwr),TRIM((SALT311.StrType)le.alt_1_nada_gcwr),TRIM((SALT311.StrType)le.alt_2_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_2_nada_model),TRIM((SALT311.StrType)le.alt_2_nada_body_style),TRIM((SALT311.StrType)le.alt_2_nada_msrp),TRIM((SALT311.StrType)le.alt_2_nada_gvwr),TRIM((SALT311.StrType)le.alt_2_nada_gcwr),TRIM((SALT311.StrType)le.alt_3_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_3_nada_model),TRIM((SALT311.StrType)le.alt_3_nada_body_style),TRIM((SALT311.StrType)le.alt_3_nada_msrp),TRIM((SALT311.StrType)le.alt_3_nada_gvwr),TRIM((SALT311.StrType)le.alt_3_nada_gcwr),TRIM((SALT311.StrType)le.alt_4_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_4_nada_model),TRIM((SALT311.StrType)le.alt_4_nada_body_style),TRIM((SALT311.StrType)le.alt_4_nada_msrp),TRIM((SALT311.StrType)le.alt_4_nada_gvwr),TRIM((SALT311.StrType)le.alt_4_nada_gcwr),TRIM((SALT311.StrType)le.alt_5_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_5_nada_model),TRIM((SALT311.StrType)le.alt_5_nada_body_style),TRIM((SALT311.StrType)le.alt_5_nada_msrp),TRIM((SALT311.StrType)le.alt_5_nada_gvwr),TRIM((SALT311.StrType)le.alt_5_nada_gcwr),TRIM((SALT311.StrType)le.alt_6_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_6_nada_model),TRIM((SALT311.StrType)le.alt_6_nada_body_style),TRIM((SALT311.StrType)le.alt_6_nada_msrp),TRIM((SALT311.StrType)le.alt_6_nada_gvwr),TRIM((SALT311.StrType)le.alt_6_nada_gcwr),TRIM((SALT311.StrType)le.alt_7_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_7_nada_model),TRIM((SALT311.StrType)le.alt_7_nada_body_style),TRIM((SALT311.StrType)le.alt_7_nada_msrp),TRIM((SALT311.StrType)le.alt_7_nada_gvwr),TRIM((SALT311.StrType)le.alt_7_nada_gcwr),TRIM((SALT311.StrType)le.aaia_codes),TRIM((SALT311.StrType)le.incomplete_vehicle_flag),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.electric_battery_info_type),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.electric_battery_kilowatts),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.electric_battery_volts),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.engine_info_proprietary_engine_brand),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.engine_info_high_output_engine),TRIM((SALT311.StrType)le.engine_info_supercharged),TRIM((SALT311.StrType)le.engine_info_turbocharged),TRIM((SALT311.StrType)le.engine_info_vvtl),TRIM((SALT311.StrType)le.iso_liability),TRIM((SALT311.StrType)le.series_name_condensed),TRIM((SALT311.StrType)le.aces_data),TRIM((SALT311.StrType)le.base_shipping_weight_expanded),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.customer_defined_data)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,162,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 162);
  SELF.FldNo2 := 1 + (C % 162);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.match_make),TRIM((SALT311.StrType)le.match_year),TRIM((SALT311.StrType)le.match_vin),TRIM((SALT311.StrType)le.make_abbreviation),TRIM((SALT311.StrType)le.model_year),TRIM((SALT311.StrType)le.vehicle_type),TRIM((SALT311.StrType)le.make_name),TRIM((SALT311.StrType)le.series_name),TRIM((SALT311.StrType)le.body_type),TRIM((SALT311.StrType)le.wheels),TRIM((SALT311.StrType)le.displacement),TRIM((SALT311.StrType)le.cylinders),TRIM((SALT311.StrType)le.fuel),TRIM((SALT311.StrType)le.carburetion),TRIM((SALT311.StrType)le.gvw),TRIM((SALT311.StrType)le.wheel_base),TRIM((SALT311.StrType)le.tire_size),TRIM((SALT311.StrType)le.ton_rating),TRIM((SALT311.StrType)le.base_shipping_weight),TRIM((SALT311.StrType)le.variance_weight),TRIM((SALT311.StrType)le.base_list_price),TRIM((SALT311.StrType)le.price_variance),TRIM((SALT311.StrType)le.high_performance_code),TRIM((SALT311.StrType)le.driving_wheels),TRIM((SALT311.StrType)le.iso_physical_damage),TRIM((SALT311.StrType)le.location_indicator),TRIM((SALT311.StrType)le.air_conditioning),TRIM((SALT311.StrType)le.power_steering),TRIM((SALT311.StrType)le.power_brakes),TRIM((SALT311.StrType)le.power_windows),TRIM((SALT311.StrType)le.tilt_wheel),TRIM((SALT311.StrType)le.roof),TRIM((SALT311.StrType)le.optional_roof1),TRIM((SALT311.StrType)le.optional_roof2),TRIM((SALT311.StrType)le.radio),TRIM((SALT311.StrType)le.optional_radio1),TRIM((SALT311.StrType)le.optional_radio2),TRIM((SALT311.StrType)le.transmission),TRIM((SALT311.StrType)le.optional_transmission1),TRIM((SALT311.StrType)le.optional_transmission2),TRIM((SALT311.StrType)le.anti_lock_brakes),TRIM((SALT311.StrType)le.security_system),TRIM((SALT311.StrType)le.daytime_running_lights),TRIM((SALT311.StrType)le.visrap),TRIM((SALT311.StrType)le.cab_configuration),TRIM((SALT311.StrType)le.front_axle_code),TRIM((SALT311.StrType)le.rear_axle_code),TRIM((SALT311.StrType)le.brakes_code),TRIM((SALT311.StrType)le.engine_manufacturer),TRIM((SALT311.StrType)le.engine_model),TRIM((SALT311.StrType)le.engine_type_code),TRIM((SALT311.StrType)le.trailer_body_style),TRIM((SALT311.StrType)le.trailer_number_of_axles),TRIM((SALT311.StrType)le.trailer_length),TRIM((SALT311.StrType)le.proactive_vin),TRIM((SALT311.StrType)le.ma_state_exceptions),TRIM((SALT311.StrType)le.filler_1),TRIM((SALT311.StrType)le.series_abbreviation),TRIM((SALT311.StrType)le.vin_pattern),TRIM((SALT311.StrType)le.ncic_data),TRIM((SALT311.StrType)le.full_body_style_name),TRIM((SALT311.StrType)le.nvpp_make_code),TRIM((SALT311.StrType)le.nvpp_make_abbreviation),TRIM((SALT311.StrType)le.nvpp_series_model),TRIM((SALT311.StrType)le.nvpp_series_name),TRIM((SALT311.StrType)le.segmentation_code),TRIM((SALT311.StrType)le.country_of_origin),TRIM((SALT311.StrType)le.engine_liter_information),TRIM((SALT311.StrType)le.engine_information_filler1),TRIM((SALT311.StrType)le.engine_information_block_type),TRIM((SALT311.StrType)le.engine_information_cylinders),TRIM((SALT311.StrType)le.engine_information_filler2),TRIM((SALT311.StrType)le.engine_information_carburetion),TRIM((SALT311.StrType)le.engine_information_filler3),TRIM((SALT311.StrType)le.engine_information_head_configuration),TRIM((SALT311.StrType)le.engine_information_filler4),TRIM((SALT311.StrType)le.engine_information_total_valves),TRIM((SALT311.StrType)le.engine_information_filler5),TRIM((SALT311.StrType)le.engine_information_aspiration_code),TRIM((SALT311.StrType)le.engine_information_carburetion_code),TRIM((SALT311.StrType)le.engine_information_valves_per_cylinder),TRIM((SALT311.StrType)le.transmission_speed),TRIM((SALT311.StrType)le.transmission_filler1),TRIM((SALT311.StrType)le.transmission_type),TRIM((SALT311.StrType)le.transmission_filler2),TRIM((SALT311.StrType)le.transmission_code),TRIM((SALT311.StrType)le.transmission_filler3),TRIM((SALT311.StrType)le.transmission_speed_code),TRIM((SALT311.StrType)le.base_model),TRIM((SALT311.StrType)le.complete_prefix_file_id),TRIM((SALT311.StrType)le.series_name_full_spelling),TRIM((SALT311.StrType)le.vis_theft_code),TRIM((SALT311.StrType)le.base_list_price_expanded),TRIM((SALT311.StrType)le.default_nada_vehicle_id),TRIM((SALT311.StrType)le.default_nada_model),TRIM((SALT311.StrType)le.default_nada_body_style),TRIM((SALT311.StrType)le.default_nada_msrp),TRIM((SALT311.StrType)le.default_nada_gvwr),TRIM((SALT311.StrType)le.default_nada_gcwr),TRIM((SALT311.StrType)le.alt_1_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_1_nada_model),TRIM((SALT311.StrType)le.alt_1_nada_body_style),TRIM((SALT311.StrType)le.alt_1_nada_msrp),TRIM((SALT311.StrType)le.alt_1_nada_gvwr),TRIM((SALT311.StrType)le.alt_1_nada_gcwr),TRIM((SALT311.StrType)le.alt_2_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_2_nada_model),TRIM((SALT311.StrType)le.alt_2_nada_body_style),TRIM((SALT311.StrType)le.alt_2_nada_msrp),TRIM((SALT311.StrType)le.alt_2_nada_gvwr),TRIM((SALT311.StrType)le.alt_2_nada_gcwr),TRIM((SALT311.StrType)le.alt_3_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_3_nada_model),TRIM((SALT311.StrType)le.alt_3_nada_body_style),TRIM((SALT311.StrType)le.alt_3_nada_msrp),TRIM((SALT311.StrType)le.alt_3_nada_gvwr),TRIM((SALT311.StrType)le.alt_3_nada_gcwr),TRIM((SALT311.StrType)le.alt_4_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_4_nada_model),TRIM((SALT311.StrType)le.alt_4_nada_body_style),TRIM((SALT311.StrType)le.alt_4_nada_msrp),TRIM((SALT311.StrType)le.alt_4_nada_gvwr),TRIM((SALT311.StrType)le.alt_4_nada_gcwr),TRIM((SALT311.StrType)le.alt_5_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_5_nada_model),TRIM((SALT311.StrType)le.alt_5_nada_body_style),TRIM((SALT311.StrType)le.alt_5_nada_msrp),TRIM((SALT311.StrType)le.alt_5_nada_gvwr),TRIM((SALT311.StrType)le.alt_5_nada_gcwr),TRIM((SALT311.StrType)le.alt_6_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_6_nada_model),TRIM((SALT311.StrType)le.alt_6_nada_body_style),TRIM((SALT311.StrType)le.alt_6_nada_msrp),TRIM((SALT311.StrType)le.alt_6_nada_gvwr),TRIM((SALT311.StrType)le.alt_6_nada_gcwr),TRIM((SALT311.StrType)le.alt_7_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_7_nada_model),TRIM((SALT311.StrType)le.alt_7_nada_body_style),TRIM((SALT311.StrType)le.alt_7_nada_msrp),TRIM((SALT311.StrType)le.alt_7_nada_gvwr),TRIM((SALT311.StrType)le.alt_7_nada_gcwr),TRIM((SALT311.StrType)le.aaia_codes),TRIM((SALT311.StrType)le.incomplete_vehicle_flag),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.electric_battery_info_type),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.electric_battery_kilowatts),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.electric_battery_volts),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.engine_info_proprietary_engine_brand),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.engine_info_high_output_engine),TRIM((SALT311.StrType)le.engine_info_supercharged),TRIM((SALT311.StrType)le.engine_info_turbocharged),TRIM((SALT311.StrType)le.engine_info_vvtl),TRIM((SALT311.StrType)le.iso_liability),TRIM((SALT311.StrType)le.series_name_condensed),TRIM((SALT311.StrType)le.aces_data),TRIM((SALT311.StrType)le.base_shipping_weight_expanded),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.customer_defined_data)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.match_make),TRIM((SALT311.StrType)le.match_year),TRIM((SALT311.StrType)le.match_vin),TRIM((SALT311.StrType)le.make_abbreviation),TRIM((SALT311.StrType)le.model_year),TRIM((SALT311.StrType)le.vehicle_type),TRIM((SALT311.StrType)le.make_name),TRIM((SALT311.StrType)le.series_name),TRIM((SALT311.StrType)le.body_type),TRIM((SALT311.StrType)le.wheels),TRIM((SALT311.StrType)le.displacement),TRIM((SALT311.StrType)le.cylinders),TRIM((SALT311.StrType)le.fuel),TRIM((SALT311.StrType)le.carburetion),TRIM((SALT311.StrType)le.gvw),TRIM((SALT311.StrType)le.wheel_base),TRIM((SALT311.StrType)le.tire_size),TRIM((SALT311.StrType)le.ton_rating),TRIM((SALT311.StrType)le.base_shipping_weight),TRIM((SALT311.StrType)le.variance_weight),TRIM((SALT311.StrType)le.base_list_price),TRIM((SALT311.StrType)le.price_variance),TRIM((SALT311.StrType)le.high_performance_code),TRIM((SALT311.StrType)le.driving_wheels),TRIM((SALT311.StrType)le.iso_physical_damage),TRIM((SALT311.StrType)le.location_indicator),TRIM((SALT311.StrType)le.air_conditioning),TRIM((SALT311.StrType)le.power_steering),TRIM((SALT311.StrType)le.power_brakes),TRIM((SALT311.StrType)le.power_windows),TRIM((SALT311.StrType)le.tilt_wheel),TRIM((SALT311.StrType)le.roof),TRIM((SALT311.StrType)le.optional_roof1),TRIM((SALT311.StrType)le.optional_roof2),TRIM((SALT311.StrType)le.radio),TRIM((SALT311.StrType)le.optional_radio1),TRIM((SALT311.StrType)le.optional_radio2),TRIM((SALT311.StrType)le.transmission),TRIM((SALT311.StrType)le.optional_transmission1),TRIM((SALT311.StrType)le.optional_transmission2),TRIM((SALT311.StrType)le.anti_lock_brakes),TRIM((SALT311.StrType)le.security_system),TRIM((SALT311.StrType)le.daytime_running_lights),TRIM((SALT311.StrType)le.visrap),TRIM((SALT311.StrType)le.cab_configuration),TRIM((SALT311.StrType)le.front_axle_code),TRIM((SALT311.StrType)le.rear_axle_code),TRIM((SALT311.StrType)le.brakes_code),TRIM((SALT311.StrType)le.engine_manufacturer),TRIM((SALT311.StrType)le.engine_model),TRIM((SALT311.StrType)le.engine_type_code),TRIM((SALT311.StrType)le.trailer_body_style),TRIM((SALT311.StrType)le.trailer_number_of_axles),TRIM((SALT311.StrType)le.trailer_length),TRIM((SALT311.StrType)le.proactive_vin),TRIM((SALT311.StrType)le.ma_state_exceptions),TRIM((SALT311.StrType)le.filler_1),TRIM((SALT311.StrType)le.series_abbreviation),TRIM((SALT311.StrType)le.vin_pattern),TRIM((SALT311.StrType)le.ncic_data),TRIM((SALT311.StrType)le.full_body_style_name),TRIM((SALT311.StrType)le.nvpp_make_code),TRIM((SALT311.StrType)le.nvpp_make_abbreviation),TRIM((SALT311.StrType)le.nvpp_series_model),TRIM((SALT311.StrType)le.nvpp_series_name),TRIM((SALT311.StrType)le.segmentation_code),TRIM((SALT311.StrType)le.country_of_origin),TRIM((SALT311.StrType)le.engine_liter_information),TRIM((SALT311.StrType)le.engine_information_filler1),TRIM((SALT311.StrType)le.engine_information_block_type),TRIM((SALT311.StrType)le.engine_information_cylinders),TRIM((SALT311.StrType)le.engine_information_filler2),TRIM((SALT311.StrType)le.engine_information_carburetion),TRIM((SALT311.StrType)le.engine_information_filler3),TRIM((SALT311.StrType)le.engine_information_head_configuration),TRIM((SALT311.StrType)le.engine_information_filler4),TRIM((SALT311.StrType)le.engine_information_total_valves),TRIM((SALT311.StrType)le.engine_information_filler5),TRIM((SALT311.StrType)le.engine_information_aspiration_code),TRIM((SALT311.StrType)le.engine_information_carburetion_code),TRIM((SALT311.StrType)le.engine_information_valves_per_cylinder),TRIM((SALT311.StrType)le.transmission_speed),TRIM((SALT311.StrType)le.transmission_filler1),TRIM((SALT311.StrType)le.transmission_type),TRIM((SALT311.StrType)le.transmission_filler2),TRIM((SALT311.StrType)le.transmission_code),TRIM((SALT311.StrType)le.transmission_filler3),TRIM((SALT311.StrType)le.transmission_speed_code),TRIM((SALT311.StrType)le.base_model),TRIM((SALT311.StrType)le.complete_prefix_file_id),TRIM((SALT311.StrType)le.series_name_full_spelling),TRIM((SALT311.StrType)le.vis_theft_code),TRIM((SALT311.StrType)le.base_list_price_expanded),TRIM((SALT311.StrType)le.default_nada_vehicle_id),TRIM((SALT311.StrType)le.default_nada_model),TRIM((SALT311.StrType)le.default_nada_body_style),TRIM((SALT311.StrType)le.default_nada_msrp),TRIM((SALT311.StrType)le.default_nada_gvwr),TRIM((SALT311.StrType)le.default_nada_gcwr),TRIM((SALT311.StrType)le.alt_1_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_1_nada_model),TRIM((SALT311.StrType)le.alt_1_nada_body_style),TRIM((SALT311.StrType)le.alt_1_nada_msrp),TRIM((SALT311.StrType)le.alt_1_nada_gvwr),TRIM((SALT311.StrType)le.alt_1_nada_gcwr),TRIM((SALT311.StrType)le.alt_2_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_2_nada_model),TRIM((SALT311.StrType)le.alt_2_nada_body_style),TRIM((SALT311.StrType)le.alt_2_nada_msrp),TRIM((SALT311.StrType)le.alt_2_nada_gvwr),TRIM((SALT311.StrType)le.alt_2_nada_gcwr),TRIM((SALT311.StrType)le.alt_3_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_3_nada_model),TRIM((SALT311.StrType)le.alt_3_nada_body_style),TRIM((SALT311.StrType)le.alt_3_nada_msrp),TRIM((SALT311.StrType)le.alt_3_nada_gvwr),TRIM((SALT311.StrType)le.alt_3_nada_gcwr),TRIM((SALT311.StrType)le.alt_4_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_4_nada_model),TRIM((SALT311.StrType)le.alt_4_nada_body_style),TRIM((SALT311.StrType)le.alt_4_nada_msrp),TRIM((SALT311.StrType)le.alt_4_nada_gvwr),TRIM((SALT311.StrType)le.alt_4_nada_gcwr),TRIM((SALT311.StrType)le.alt_5_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_5_nada_model),TRIM((SALT311.StrType)le.alt_5_nada_body_style),TRIM((SALT311.StrType)le.alt_5_nada_msrp),TRIM((SALT311.StrType)le.alt_5_nada_gvwr),TRIM((SALT311.StrType)le.alt_5_nada_gcwr),TRIM((SALT311.StrType)le.alt_6_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_6_nada_model),TRIM((SALT311.StrType)le.alt_6_nada_body_style),TRIM((SALT311.StrType)le.alt_6_nada_msrp),TRIM((SALT311.StrType)le.alt_6_nada_gvwr),TRIM((SALT311.StrType)le.alt_6_nada_gcwr),TRIM((SALT311.StrType)le.alt_7_nada_vehicle_id),TRIM((SALT311.StrType)le.alt_7_nada_model),TRIM((SALT311.StrType)le.alt_7_nada_body_style),TRIM((SALT311.StrType)le.alt_7_nada_msrp),TRIM((SALT311.StrType)le.alt_7_nada_gvwr),TRIM((SALT311.StrType)le.alt_7_nada_gcwr),TRIM((SALT311.StrType)le.aaia_codes),TRIM((SALT311.StrType)le.incomplete_vehicle_flag),TRIM((SALT311.StrType)le.filler2),TRIM((SALT311.StrType)le.electric_battery_info_type),TRIM((SALT311.StrType)le.filler3),TRIM((SALT311.StrType)le.electric_battery_kilowatts),TRIM((SALT311.StrType)le.filler4),TRIM((SALT311.StrType)le.electric_battery_volts),TRIM((SALT311.StrType)le.filler5),TRIM((SALT311.StrType)le.engine_info_proprietary_engine_brand),TRIM((SALT311.StrType)le.filler6),TRIM((SALT311.StrType)le.engine_info_high_output_engine),TRIM((SALT311.StrType)le.engine_info_supercharged),TRIM((SALT311.StrType)le.engine_info_turbocharged),TRIM((SALT311.StrType)le.engine_info_vvtl),TRIM((SALT311.StrType)le.iso_liability),TRIM((SALT311.StrType)le.series_name_condensed),TRIM((SALT311.StrType)le.aces_data),TRIM((SALT311.StrType)le.base_shipping_weight_expanded),TRIM((SALT311.StrType)le.filler7),TRIM((SALT311.StrType)le.customer_defined_data)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),162*162,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'match_make'}
      ,{2,'match_year'}
      ,{3,'match_vin'}
      ,{4,'make_abbreviation'}
      ,{5,'model_year'}
      ,{6,'vehicle_type'}
      ,{7,'make_name'}
      ,{8,'series_name'}
      ,{9,'body_type'}
      ,{10,'wheels'}
      ,{11,'displacement'}
      ,{12,'cylinders'}
      ,{13,'fuel'}
      ,{14,'carburetion'}
      ,{15,'gvw'}
      ,{16,'wheel_base'}
      ,{17,'tire_size'}
      ,{18,'ton_rating'}
      ,{19,'base_shipping_weight'}
      ,{20,'variance_weight'}
      ,{21,'base_list_price'}
      ,{22,'price_variance'}
      ,{23,'high_performance_code'}
      ,{24,'driving_wheels'}
      ,{25,'iso_physical_damage'}
      ,{26,'location_indicator'}
      ,{27,'air_conditioning'}
      ,{28,'power_steering'}
      ,{29,'power_brakes'}
      ,{30,'power_windows'}
      ,{31,'tilt_wheel'}
      ,{32,'roof'}
      ,{33,'optional_roof1'}
      ,{34,'optional_roof2'}
      ,{35,'radio'}
      ,{36,'optional_radio1'}
      ,{37,'optional_radio2'}
      ,{38,'transmission'}
      ,{39,'optional_transmission1'}
      ,{40,'optional_transmission2'}
      ,{41,'anti_lock_brakes'}
      ,{42,'security_system'}
      ,{43,'daytime_running_lights'}
      ,{44,'visrap'}
      ,{45,'cab_configuration'}
      ,{46,'front_axle_code'}
      ,{47,'rear_axle_code'}
      ,{48,'brakes_code'}
      ,{49,'engine_manufacturer'}
      ,{50,'engine_model'}
      ,{51,'engine_type_code'}
      ,{52,'trailer_body_style'}
      ,{53,'trailer_number_of_axles'}
      ,{54,'trailer_length'}
      ,{55,'proactive_vin'}
      ,{56,'ma_state_exceptions'}
      ,{57,'filler_1'}
      ,{58,'series_abbreviation'}
      ,{59,'vin_pattern'}
      ,{60,'ncic_data'}
      ,{61,'full_body_style_name'}
      ,{62,'nvpp_make_code'}
      ,{63,'nvpp_make_abbreviation'}
      ,{64,'nvpp_series_model'}
      ,{65,'nvpp_series_name'}
      ,{66,'segmentation_code'}
      ,{67,'country_of_origin'}
      ,{68,'engine_liter_information'}
      ,{69,'engine_information_filler1'}
      ,{70,'engine_information_block_type'}
      ,{71,'engine_information_cylinders'}
      ,{72,'engine_information_filler2'}
      ,{73,'engine_information_carburetion'}
      ,{74,'engine_information_filler3'}
      ,{75,'engine_information_head_configuration'}
      ,{76,'engine_information_filler4'}
      ,{77,'engine_information_total_valves'}
      ,{78,'engine_information_filler5'}
      ,{79,'engine_information_aspiration_code'}
      ,{80,'engine_information_carburetion_code'}
      ,{81,'engine_information_valves_per_cylinder'}
      ,{82,'transmission_speed'}
      ,{83,'transmission_filler1'}
      ,{84,'transmission_type'}
      ,{85,'transmission_filler2'}
      ,{86,'transmission_code'}
      ,{87,'transmission_filler3'}
      ,{88,'transmission_speed_code'}
      ,{89,'base_model'}
      ,{90,'complete_prefix_file_id'}
      ,{91,'series_name_full_spelling'}
      ,{92,'vis_theft_code'}
      ,{93,'base_list_price_expanded'}
      ,{94,'default_nada_vehicle_id'}
      ,{95,'default_nada_model'}
      ,{96,'default_nada_body_style'}
      ,{97,'default_nada_msrp'}
      ,{98,'default_nada_gvwr'}
      ,{99,'default_nada_gcwr'}
      ,{100,'alt_1_nada_vehicle_id'}
      ,{101,'alt_1_nada_model'}
      ,{102,'alt_1_nada_body_style'}
      ,{103,'alt_1_nada_msrp'}
      ,{104,'alt_1_nada_gvwr'}
      ,{105,'alt_1_nada_gcwr'}
      ,{106,'alt_2_nada_vehicle_id'}
      ,{107,'alt_2_nada_model'}
      ,{108,'alt_2_nada_body_style'}
      ,{109,'alt_2_nada_msrp'}
      ,{110,'alt_2_nada_gvwr'}
      ,{111,'alt_2_nada_gcwr'}
      ,{112,'alt_3_nada_vehicle_id'}
      ,{113,'alt_3_nada_model'}
      ,{114,'alt_3_nada_body_style'}
      ,{115,'alt_3_nada_msrp'}
      ,{116,'alt_3_nada_gvwr'}
      ,{117,'alt_3_nada_gcwr'}
      ,{118,'alt_4_nada_vehicle_id'}
      ,{119,'alt_4_nada_model'}
      ,{120,'alt_4_nada_body_style'}
      ,{121,'alt_4_nada_msrp'}
      ,{122,'alt_4_nada_gvwr'}
      ,{123,'alt_4_nada_gcwr'}
      ,{124,'alt_5_nada_vehicle_id'}
      ,{125,'alt_5_nada_model'}
      ,{126,'alt_5_nada_body_style'}
      ,{127,'alt_5_nada_msrp'}
      ,{128,'alt_5_nada_gvwr'}
      ,{129,'alt_5_nada_gcwr'}
      ,{130,'alt_6_nada_vehicle_id'}
      ,{131,'alt_6_nada_model'}
      ,{132,'alt_6_nada_body_style'}
      ,{133,'alt_6_nada_msrp'}
      ,{134,'alt_6_nada_gvwr'}
      ,{135,'alt_6_nada_gcwr'}
      ,{136,'alt_7_nada_vehicle_id'}
      ,{137,'alt_7_nada_model'}
      ,{138,'alt_7_nada_body_style'}
      ,{139,'alt_7_nada_msrp'}
      ,{140,'alt_7_nada_gvwr'}
      ,{141,'alt_7_nada_gcwr'}
      ,{142,'aaia_codes'}
      ,{143,'incomplete_vehicle_flag'}
      ,{144,'filler2'}
      ,{145,'electric_battery_info_type'}
      ,{146,'filler3'}
      ,{147,'electric_battery_kilowatts'}
      ,{148,'filler4'}
      ,{149,'electric_battery_volts'}
      ,{150,'filler5'}
      ,{151,'engine_info_proprietary_engine_brand'}
      ,{152,'filler6'}
      ,{153,'engine_info_high_output_engine'}
      ,{154,'engine_info_supercharged'}
      ,{155,'engine_info_turbocharged'}
      ,{156,'engine_info_vvtl'}
      ,{157,'iso_liability'}
      ,{158,'series_name_condensed'}
      ,{159,'aces_data'}
      ,{160,'base_shipping_weight_expanded'}
      ,{161,'filler7'}
      ,{162,'customer_defined_data'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    BaseFile_Fields.InValid_match_make((SALT311.StrType)le.match_make),
    BaseFile_Fields.InValid_match_year((SALT311.StrType)le.match_year),
    BaseFile_Fields.InValid_match_vin((SALT311.StrType)le.match_vin),
    BaseFile_Fields.InValid_make_abbreviation((SALT311.StrType)le.make_abbreviation),
    BaseFile_Fields.InValid_model_year((SALT311.StrType)le.model_year),
    BaseFile_Fields.InValid_vehicle_type((SALT311.StrType)le.vehicle_type),
    BaseFile_Fields.InValid_make_name((SALT311.StrType)le.make_name),
    BaseFile_Fields.InValid_series_name((SALT311.StrType)le.series_name),
    BaseFile_Fields.InValid_body_type((SALT311.StrType)le.body_type),
    BaseFile_Fields.InValid_wheels((SALT311.StrType)le.wheels),
    BaseFile_Fields.InValid_displacement((SALT311.StrType)le.displacement),
    BaseFile_Fields.InValid_cylinders((SALT311.StrType)le.cylinders),
    BaseFile_Fields.InValid_fuel((SALT311.StrType)le.fuel),
    BaseFile_Fields.InValid_carburetion((SALT311.StrType)le.carburetion),
    BaseFile_Fields.InValid_gvw((SALT311.StrType)le.gvw),
    BaseFile_Fields.InValid_wheel_base((SALT311.StrType)le.wheel_base),
    BaseFile_Fields.InValid_tire_size((SALT311.StrType)le.tire_size),
    BaseFile_Fields.InValid_ton_rating((SALT311.StrType)le.ton_rating),
    BaseFile_Fields.InValid_base_shipping_weight((SALT311.StrType)le.base_shipping_weight),
    BaseFile_Fields.InValid_variance_weight((SALT311.StrType)le.variance_weight),
    BaseFile_Fields.InValid_base_list_price((SALT311.StrType)le.base_list_price),
    BaseFile_Fields.InValid_price_variance((SALT311.StrType)le.price_variance),
    BaseFile_Fields.InValid_high_performance_code((SALT311.StrType)le.high_performance_code),
    BaseFile_Fields.InValid_driving_wheels((SALT311.StrType)le.driving_wheels),
    BaseFile_Fields.InValid_iso_physical_damage((SALT311.StrType)le.iso_physical_damage),
    BaseFile_Fields.InValid_location_indicator((SALT311.StrType)le.location_indicator),
    BaseFile_Fields.InValid_air_conditioning((SALT311.StrType)le.air_conditioning),
    BaseFile_Fields.InValid_power_steering((SALT311.StrType)le.power_steering),
    BaseFile_Fields.InValid_power_brakes((SALT311.StrType)le.power_brakes),
    BaseFile_Fields.InValid_power_windows((SALT311.StrType)le.power_windows),
    BaseFile_Fields.InValid_tilt_wheel((SALT311.StrType)le.tilt_wheel),
    BaseFile_Fields.InValid_roof((SALT311.StrType)le.roof),
    BaseFile_Fields.InValid_optional_roof1((SALT311.StrType)le.optional_roof1),
    BaseFile_Fields.InValid_optional_roof2((SALT311.StrType)le.optional_roof2),
    BaseFile_Fields.InValid_radio((SALT311.StrType)le.radio),
    BaseFile_Fields.InValid_optional_radio1((SALT311.StrType)le.optional_radio1),
    BaseFile_Fields.InValid_optional_radio2((SALT311.StrType)le.optional_radio2),
    BaseFile_Fields.InValid_transmission((SALT311.StrType)le.transmission),
    BaseFile_Fields.InValid_optional_transmission1((SALT311.StrType)le.optional_transmission1),
    BaseFile_Fields.InValid_optional_transmission2((SALT311.StrType)le.optional_transmission2),
    BaseFile_Fields.InValid_anti_lock_brakes((SALT311.StrType)le.anti_lock_brakes),
    BaseFile_Fields.InValid_security_system((SALT311.StrType)le.security_system),
    BaseFile_Fields.InValid_daytime_running_lights((SALT311.StrType)le.daytime_running_lights),
    BaseFile_Fields.InValid_visrap((SALT311.StrType)le.visrap),
    BaseFile_Fields.InValid_cab_configuration((SALT311.StrType)le.cab_configuration),
    BaseFile_Fields.InValid_front_axle_code((SALT311.StrType)le.front_axle_code),
    BaseFile_Fields.InValid_rear_axle_code((SALT311.StrType)le.rear_axle_code),
    BaseFile_Fields.InValid_brakes_code((SALT311.StrType)le.brakes_code),
    BaseFile_Fields.InValid_engine_manufacturer((SALT311.StrType)le.engine_manufacturer),
    BaseFile_Fields.InValid_engine_model((SALT311.StrType)le.engine_model),
    BaseFile_Fields.InValid_engine_type_code((SALT311.StrType)le.engine_type_code),
    BaseFile_Fields.InValid_trailer_body_style((SALT311.StrType)le.trailer_body_style),
    BaseFile_Fields.InValid_trailer_number_of_axles((SALT311.StrType)le.trailer_number_of_axles),
    BaseFile_Fields.InValid_trailer_length((SALT311.StrType)le.trailer_length),
    BaseFile_Fields.InValid_proactive_vin((SALT311.StrType)le.proactive_vin),
    BaseFile_Fields.InValid_ma_state_exceptions((SALT311.StrType)le.ma_state_exceptions),
    BaseFile_Fields.InValid_filler_1((SALT311.StrType)le.filler_1),
    BaseFile_Fields.InValid_series_abbreviation((SALT311.StrType)le.series_abbreviation),
    BaseFile_Fields.InValid_vin_pattern((SALT311.StrType)le.vin_pattern),
    BaseFile_Fields.InValid_ncic_data((SALT311.StrType)le.ncic_data),
    BaseFile_Fields.InValid_full_body_style_name((SALT311.StrType)le.full_body_style_name),
    BaseFile_Fields.InValid_nvpp_make_code((SALT311.StrType)le.nvpp_make_code),
    BaseFile_Fields.InValid_nvpp_make_abbreviation((SALT311.StrType)le.nvpp_make_abbreviation),
    BaseFile_Fields.InValid_nvpp_series_model((SALT311.StrType)le.nvpp_series_model),
    BaseFile_Fields.InValid_nvpp_series_name((SALT311.StrType)le.nvpp_series_name),
    BaseFile_Fields.InValid_segmentation_code((SALT311.StrType)le.segmentation_code),
    BaseFile_Fields.InValid_country_of_origin((SALT311.StrType)le.country_of_origin),
    BaseFile_Fields.InValid_engine_liter_information((SALT311.StrType)le.engine_liter_information),
    BaseFile_Fields.InValid_engine_information_filler1((SALT311.StrType)le.engine_information_filler1),
    BaseFile_Fields.InValid_engine_information_block_type((SALT311.StrType)le.engine_information_block_type),
    BaseFile_Fields.InValid_engine_information_cylinders((SALT311.StrType)le.engine_information_cylinders),
    BaseFile_Fields.InValid_engine_information_filler2((SALT311.StrType)le.engine_information_filler2),
    BaseFile_Fields.InValid_engine_information_carburetion((SALT311.StrType)le.engine_information_carburetion),
    BaseFile_Fields.InValid_engine_information_filler3((SALT311.StrType)le.engine_information_filler3),
    BaseFile_Fields.InValid_engine_information_head_configuration((SALT311.StrType)le.engine_information_head_configuration),
    BaseFile_Fields.InValid_engine_information_filler4((SALT311.StrType)le.engine_information_filler4),
    BaseFile_Fields.InValid_engine_information_total_valves((SALT311.StrType)le.engine_information_total_valves),
    BaseFile_Fields.InValid_engine_information_filler5((SALT311.StrType)le.engine_information_filler5),
    BaseFile_Fields.InValid_engine_information_aspiration_code((SALT311.StrType)le.engine_information_aspiration_code),
    BaseFile_Fields.InValid_engine_information_carburetion_code((SALT311.StrType)le.engine_information_carburetion_code),
    BaseFile_Fields.InValid_engine_information_valves_per_cylinder((SALT311.StrType)le.engine_information_valves_per_cylinder),
    BaseFile_Fields.InValid_transmission_speed((SALT311.StrType)le.transmission_speed),
    BaseFile_Fields.InValid_transmission_filler1((SALT311.StrType)le.transmission_filler1),
    BaseFile_Fields.InValid_transmission_type((SALT311.StrType)le.transmission_type),
    BaseFile_Fields.InValid_transmission_filler2((SALT311.StrType)le.transmission_filler2),
    BaseFile_Fields.InValid_transmission_code((SALT311.StrType)le.transmission_code),
    BaseFile_Fields.InValid_transmission_filler3((SALT311.StrType)le.transmission_filler3),
    BaseFile_Fields.InValid_transmission_speed_code((SALT311.StrType)le.transmission_speed_code),
    BaseFile_Fields.InValid_base_model((SALT311.StrType)le.base_model),
    BaseFile_Fields.InValid_complete_prefix_file_id((SALT311.StrType)le.complete_prefix_file_id),
    BaseFile_Fields.InValid_series_name_full_spelling((SALT311.StrType)le.series_name_full_spelling),
    BaseFile_Fields.InValid_vis_theft_code((SALT311.StrType)le.vis_theft_code),
    BaseFile_Fields.InValid_base_list_price_expanded((SALT311.StrType)le.base_list_price_expanded),
    BaseFile_Fields.InValid_default_nada_vehicle_id((SALT311.StrType)le.default_nada_vehicle_id),
    BaseFile_Fields.InValid_default_nada_model((SALT311.StrType)le.default_nada_model),
    BaseFile_Fields.InValid_default_nada_body_style((SALT311.StrType)le.default_nada_body_style),
    BaseFile_Fields.InValid_default_nada_msrp((SALT311.StrType)le.default_nada_msrp),
    BaseFile_Fields.InValid_default_nada_gvwr((SALT311.StrType)le.default_nada_gvwr),
    BaseFile_Fields.InValid_default_nada_gcwr((SALT311.StrType)le.default_nada_gcwr),
    BaseFile_Fields.InValid_alt_1_nada_vehicle_id((SALT311.StrType)le.alt_1_nada_vehicle_id),
    BaseFile_Fields.InValid_alt_1_nada_model((SALT311.StrType)le.alt_1_nada_model),
    BaseFile_Fields.InValid_alt_1_nada_body_style((SALT311.StrType)le.alt_1_nada_body_style),
    BaseFile_Fields.InValid_alt_1_nada_msrp((SALT311.StrType)le.alt_1_nada_msrp),
    BaseFile_Fields.InValid_alt_1_nada_gvwr((SALT311.StrType)le.alt_1_nada_gvwr),
    BaseFile_Fields.InValid_alt_1_nada_gcwr((SALT311.StrType)le.alt_1_nada_gcwr),
    BaseFile_Fields.InValid_alt_2_nada_vehicle_id((SALT311.StrType)le.alt_2_nada_vehicle_id),
    BaseFile_Fields.InValid_alt_2_nada_model((SALT311.StrType)le.alt_2_nada_model),
    BaseFile_Fields.InValid_alt_2_nada_body_style((SALT311.StrType)le.alt_2_nada_body_style),
    BaseFile_Fields.InValid_alt_2_nada_msrp((SALT311.StrType)le.alt_2_nada_msrp),
    BaseFile_Fields.InValid_alt_2_nada_gvwr((SALT311.StrType)le.alt_2_nada_gvwr),
    BaseFile_Fields.InValid_alt_2_nada_gcwr((SALT311.StrType)le.alt_2_nada_gcwr),
    BaseFile_Fields.InValid_alt_3_nada_vehicle_id((SALT311.StrType)le.alt_3_nada_vehicle_id),
    BaseFile_Fields.InValid_alt_3_nada_model((SALT311.StrType)le.alt_3_nada_model),
    BaseFile_Fields.InValid_alt_3_nada_body_style((SALT311.StrType)le.alt_3_nada_body_style),
    BaseFile_Fields.InValid_alt_3_nada_msrp((SALT311.StrType)le.alt_3_nada_msrp),
    BaseFile_Fields.InValid_alt_3_nada_gvwr((SALT311.StrType)le.alt_3_nada_gvwr),
    BaseFile_Fields.InValid_alt_3_nada_gcwr((SALT311.StrType)le.alt_3_nada_gcwr),
    BaseFile_Fields.InValid_alt_4_nada_vehicle_id((SALT311.StrType)le.alt_4_nada_vehicle_id),
    BaseFile_Fields.InValid_alt_4_nada_model((SALT311.StrType)le.alt_4_nada_model),
    BaseFile_Fields.InValid_alt_4_nada_body_style((SALT311.StrType)le.alt_4_nada_body_style),
    BaseFile_Fields.InValid_alt_4_nada_msrp((SALT311.StrType)le.alt_4_nada_msrp),
    BaseFile_Fields.InValid_alt_4_nada_gvwr((SALT311.StrType)le.alt_4_nada_gvwr),
    BaseFile_Fields.InValid_alt_4_nada_gcwr((SALT311.StrType)le.alt_4_nada_gcwr),
    BaseFile_Fields.InValid_alt_5_nada_vehicle_id((SALT311.StrType)le.alt_5_nada_vehicle_id),
    BaseFile_Fields.InValid_alt_5_nada_model((SALT311.StrType)le.alt_5_nada_model),
    BaseFile_Fields.InValid_alt_5_nada_body_style((SALT311.StrType)le.alt_5_nada_body_style),
    BaseFile_Fields.InValid_alt_5_nada_msrp((SALT311.StrType)le.alt_5_nada_msrp),
    BaseFile_Fields.InValid_alt_5_nada_gvwr((SALT311.StrType)le.alt_5_nada_gvwr),
    BaseFile_Fields.InValid_alt_5_nada_gcwr((SALT311.StrType)le.alt_5_nada_gcwr),
    BaseFile_Fields.InValid_alt_6_nada_vehicle_id((SALT311.StrType)le.alt_6_nada_vehicle_id),
    BaseFile_Fields.InValid_alt_6_nada_model((SALT311.StrType)le.alt_6_nada_model),
    BaseFile_Fields.InValid_alt_6_nada_body_style((SALT311.StrType)le.alt_6_nada_body_style),
    BaseFile_Fields.InValid_alt_6_nada_msrp((SALT311.StrType)le.alt_6_nada_msrp),
    BaseFile_Fields.InValid_alt_6_nada_gvwr((SALT311.StrType)le.alt_6_nada_gvwr),
    BaseFile_Fields.InValid_alt_6_nada_gcwr((SALT311.StrType)le.alt_6_nada_gcwr),
    BaseFile_Fields.InValid_alt_7_nada_vehicle_id((SALT311.StrType)le.alt_7_nada_vehicle_id),
    BaseFile_Fields.InValid_alt_7_nada_model((SALT311.StrType)le.alt_7_nada_model),
    BaseFile_Fields.InValid_alt_7_nada_body_style((SALT311.StrType)le.alt_7_nada_body_style),
    BaseFile_Fields.InValid_alt_7_nada_msrp((SALT311.StrType)le.alt_7_nada_msrp),
    BaseFile_Fields.InValid_alt_7_nada_gvwr((SALT311.StrType)le.alt_7_nada_gvwr),
    BaseFile_Fields.InValid_alt_7_nada_gcwr((SALT311.StrType)le.alt_7_nada_gcwr),
    BaseFile_Fields.InValid_aaia_codes((SALT311.StrType)le.aaia_codes),
    BaseFile_Fields.InValid_incomplete_vehicle_flag((SALT311.StrType)le.incomplete_vehicle_flag),
    BaseFile_Fields.InValid_filler2((SALT311.StrType)le.filler2),
    BaseFile_Fields.InValid_electric_battery_info_type((SALT311.StrType)le.electric_battery_info_type),
    BaseFile_Fields.InValid_filler3((SALT311.StrType)le.filler3),
    BaseFile_Fields.InValid_electric_battery_kilowatts((SALT311.StrType)le.electric_battery_kilowatts),
    BaseFile_Fields.InValid_filler4((SALT311.StrType)le.filler4),
    BaseFile_Fields.InValid_electric_battery_volts((SALT311.StrType)le.electric_battery_volts),
    BaseFile_Fields.InValid_filler5((SALT311.StrType)le.filler5),
    BaseFile_Fields.InValid_engine_info_proprietary_engine_brand((SALT311.StrType)le.engine_info_proprietary_engine_brand),
    BaseFile_Fields.InValid_filler6((SALT311.StrType)le.filler6),
    BaseFile_Fields.InValid_engine_info_high_output_engine((SALT311.StrType)le.engine_info_high_output_engine),
    BaseFile_Fields.InValid_engine_info_supercharged((SALT311.StrType)le.engine_info_supercharged),
    BaseFile_Fields.InValid_engine_info_turbocharged((SALT311.StrType)le.engine_info_turbocharged),
    BaseFile_Fields.InValid_engine_info_vvtl((SALT311.StrType)le.engine_info_vvtl),
    BaseFile_Fields.InValid_iso_liability((SALT311.StrType)le.iso_liability),
    BaseFile_Fields.InValid_series_name_condensed((SALT311.StrType)le.series_name_condensed),
    BaseFile_Fields.InValid_aces_data((SALT311.StrType)le.aces_data),
    BaseFile_Fields.InValid_base_shipping_weight_expanded((SALT311.StrType)le.base_shipping_weight_expanded),
    BaseFile_Fields.InValid_filler7((SALT311.StrType)le.filler7),
    BaseFile_Fields.InValid_customer_defined_data((SALT311.StrType)le.customer_defined_data),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,162,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := BaseFile_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Char','Invalid_Nums','Invalid_Vin','Invalid_Abbreviation','Invalid_Nums','Invalid_Vehicle_Type','Invalid_Char','Invalid_Char','Invalid_Body_Type','Invalid_Nums','Invalid_Nums_Blank','Invalid_Nums_Rotary','Invalid_Fuel','Invalid_Carburetion_Num','Invalid_Nums_Rotary','Invalid_Decimal','Invalid_Tire_Size','Invalid_Char_No_Spec','Invalid_Decimal','Invalid_Nums','Invalid_Char','Invalid_Nums','Invalid_HPC','Invalid_Wheel','Unknown','Invalid_Location','Invalid_Option_SOUN','Invalid_Option_SOUN','Invalid_Option_SOUN','Invalid_Option_SOUN','Invalid_Option_SOUN','Invalid_Roof','Invalid_Roof','Invalid_Roof','Invalid_Radio','Invalid_Radio','Invalid_Radio','Invalid_Transmission','Invalid_Transmission','Invalid_Transmission','Invalid_ALB','Invalid_Security','Invalid_Option_SOUN','Invalid_Visrap','Invalid_Cab','Invalid_FAC','Invalid_RAC','Invalid_Brakes','Invalid_Char','Invalid_Char','Invalid_Engine_Type','Invalid_Trailer_Body','Invalid_Num_Axles','Invalid_Trailer_length','Invalid_Proactive_VIN_Ind','Unknown','Unknown','Unknown','Invalid_VIN_Pattern','Invalid_Char','Invalid_Char','Unknown','Unknown','Unknown','Unknown','Invalid_Segmentation_Codes','Invalid_Char','Invalid_Liter','Unknown','Invalid_Block_Type','Invalid_engine_information_cylinders','Unknown','Invalid_Carburetion','Unknown','Invalid_Head_Configuration','Unknown','Invalid_Valves','Unknown','Invalid_Aspiration_Code','Invalid_Carburetion_Code','Invalid_VPC','Invalid_Transmission_Speed','Unknown','Invalid_Transmission_Type','Unknown','Invalid_Transmission_Code','Unknown','Invalid_Transmission_Speed_Code','Invalid_Char','Invalid_Nums','Invalid_Char','Invalid_Y_or_N','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Unknown','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Y_or_N','Unknown','Invalid_Battery_Type','Unknown','Invalid_Battery_KW','Unknown','Invalid_Battery_Volts','Unknown','Invalid_Engine_Brand','Unknown','Invalid_Y_or_N','Invalid_Supercharged','Invalid_Turbocharged','Invalid_Y_or_N_orBlank','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Decimal','Unknown','Invalid_Char');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,BaseFile_Fields.InValidMessage_match_make(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_match_year(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_match_vin(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_make_abbreviation(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_model_year(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_vehicle_type(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_make_name(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_series_name(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_body_type(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_wheels(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_displacement(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_cylinders(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_fuel(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_carburetion(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_gvw(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_wheel_base(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_tire_size(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_ton_rating(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_base_shipping_weight(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_variance_weight(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_base_list_price(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_price_variance(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_high_performance_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_driving_wheels(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_iso_physical_damage(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_location_indicator(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_air_conditioning(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_power_steering(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_power_brakes(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_power_windows(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_tilt_wheel(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_roof(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_optional_roof1(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_optional_roof2(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_radio(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_optional_radio1(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_optional_radio2(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_transmission(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_optional_transmission1(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_optional_transmission2(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_anti_lock_brakes(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_security_system(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_daytime_running_lights(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_visrap(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_cab_configuration(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_front_axle_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_rear_axle_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_brakes_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_manufacturer(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_type_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_trailer_body_style(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_trailer_number_of_axles(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_trailer_length(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_proactive_vin(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_ma_state_exceptions(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_filler_1(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_series_abbreviation(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_vin_pattern(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_ncic_data(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_full_body_style_name(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_nvpp_make_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_nvpp_make_abbreviation(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_nvpp_series_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_nvpp_series_name(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_segmentation_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_country_of_origin(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_liter_information(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_filler1(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_block_type(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_cylinders(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_filler2(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_carburetion(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_filler3(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_head_configuration(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_filler4(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_total_valves(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_filler5(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_aspiration_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_carburetion_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_information_valves_per_cylinder(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_transmission_speed(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_transmission_filler1(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_transmission_type(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_transmission_filler2(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_transmission_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_transmission_filler3(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_transmission_speed_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_base_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_complete_prefix_file_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_series_name_full_spelling(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_vis_theft_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_base_list_price_expanded(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_default_nada_vehicle_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_default_nada_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_default_nada_body_style(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_default_nada_msrp(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_default_nada_gvwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_default_nada_gcwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_1_nada_vehicle_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_1_nada_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_1_nada_body_style(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_1_nada_msrp(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_1_nada_gvwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_1_nada_gcwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_2_nada_vehicle_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_2_nada_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_2_nada_body_style(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_2_nada_msrp(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_2_nada_gvwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_2_nada_gcwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_3_nada_vehicle_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_3_nada_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_3_nada_body_style(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_3_nada_msrp(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_3_nada_gvwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_3_nada_gcwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_4_nada_vehicle_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_4_nada_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_4_nada_body_style(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_4_nada_msrp(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_4_nada_gvwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_4_nada_gcwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_5_nada_vehicle_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_5_nada_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_5_nada_body_style(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_5_nada_msrp(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_5_nada_gvwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_5_nada_gcwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_6_nada_vehicle_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_6_nada_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_6_nada_body_style(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_6_nada_msrp(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_6_nada_gvwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_6_nada_gcwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_7_nada_vehicle_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_7_nada_model(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_7_nada_body_style(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_7_nada_msrp(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_7_nada_gvwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_alt_7_nada_gcwr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_aaia_codes(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_incomplete_vehicle_flag(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_filler2(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_electric_battery_info_type(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_filler3(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_electric_battery_kilowatts(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_filler4(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_electric_battery_volts(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_filler5(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_info_proprietary_engine_brand(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_filler6(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_info_high_output_engine(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_info_supercharged(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_info_turbocharged(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_engine_info_vvtl(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_iso_liability(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_series_name_condensed(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_aces_data(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_base_shipping_weight_expanded(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_filler7(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_customer_defined_data(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_VINA, BaseFile_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
