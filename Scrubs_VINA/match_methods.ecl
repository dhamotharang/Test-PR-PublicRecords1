IMPORT SALT31,std;
EXPORT match_methods(DATASET(layout_VINA) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_match_make(TYPEOF(h.match_make) L, TYPEOF(h.match_make) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_match_year(TYPEOF(h.match_year) L, TYPEOF(h.match_year) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_match_vin(TYPEOF(h.match_vin) L, TYPEOF(h.match_vin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_make_abbreviation(TYPEOF(h.make_abbreviation) L, TYPEOF(h.make_abbreviation) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_model_year(TYPEOF(h.model_year) L, TYPEOF(h.model_year) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_vehicle_type(TYPEOF(h.vehicle_type) L, TYPEOF(h.vehicle_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_make_name(TYPEOF(h.make_name) L, TYPEOF(h.make_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_series_name(TYPEOF(h.series_name) L, TYPEOF(h.series_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_body_type(TYPEOF(h.body_type) L, TYPEOF(h.body_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_wheels(TYPEOF(h.wheels) L, TYPEOF(h.wheels) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_displacement(TYPEOF(h.displacement) L, TYPEOF(h.displacement) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cylinders(TYPEOF(h.cylinders) L, TYPEOF(h.cylinders) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_fuel(TYPEOF(h.fuel) L, TYPEOF(h.fuel) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_carburetion(TYPEOF(h.carburetion) L, TYPEOF(h.carburetion) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_gvw(TYPEOF(h.gvw) L, TYPEOF(h.gvw) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_wheel_base(TYPEOF(h.wheel_base) L, TYPEOF(h.wheel_base) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tire_size(TYPEOF(h.tire_size) L, TYPEOF(h.tire_size) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ton_rating(TYPEOF(h.ton_rating) L, TYPEOF(h.ton_rating) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_base_shipping_weight(TYPEOF(h.base_shipping_weight) L, TYPEOF(h.base_shipping_weight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_variance_weight(TYPEOF(h.variance_weight) L, TYPEOF(h.variance_weight) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_base_list_price(TYPEOF(h.base_list_price) L, TYPEOF(h.base_list_price) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_price_variance(TYPEOF(h.price_variance) L, TYPEOF(h.price_variance) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_high_performance_code(TYPEOF(h.high_performance_code) L, TYPEOF(h.high_performance_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_driving_wheels(TYPEOF(h.driving_wheels) L, TYPEOF(h.driving_wheels) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_iso_physical_damage(TYPEOF(h.iso_physical_damage) L, TYPEOF(h.iso_physical_damage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_location_indicator(TYPEOF(h.location_indicator) L, TYPEOF(h.location_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_air_conditioning(TYPEOF(h.air_conditioning) L, TYPEOF(h.air_conditioning) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_power_steering(TYPEOF(h.power_steering) L, TYPEOF(h.power_steering) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_power_brakes(TYPEOF(h.power_brakes) L, TYPEOF(h.power_brakes) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_power_windows(TYPEOF(h.power_windows) L, TYPEOF(h.power_windows) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tilt_wheel(TYPEOF(h.tilt_wheel) L, TYPEOF(h.tilt_wheel) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_roof(TYPEOF(h.roof) L, TYPEOF(h.roof) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_optional_roof1(TYPEOF(h.optional_roof1) L, TYPEOF(h.optional_roof1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_optional_roof2(TYPEOF(h.optional_roof2) L, TYPEOF(h.optional_roof2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_radio(TYPEOF(h.radio) L, TYPEOF(h.radio) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_optional_radio1(TYPEOF(h.optional_radio1) L, TYPEOF(h.optional_radio1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_optional_radio2(TYPEOF(h.optional_radio2) L, TYPEOF(h.optional_radio2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_transmission(TYPEOF(h.transmission) L, TYPEOF(h.transmission) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_optional_transmission1(TYPEOF(h.optional_transmission1) L, TYPEOF(h.optional_transmission1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_optional_transmission2(TYPEOF(h.optional_transmission2) L, TYPEOF(h.optional_transmission2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_anti_lock_brakes(TYPEOF(h.anti_lock_brakes) L, TYPEOF(h.anti_lock_brakes) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_security_system(TYPEOF(h.security_system) L, TYPEOF(h.security_system) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_daytime_running_lights(TYPEOF(h.daytime_running_lights) L, TYPEOF(h.daytime_running_lights) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_visrap(TYPEOF(h.visrap) L, TYPEOF(h.visrap) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cab_configuration(TYPEOF(h.cab_configuration) L, TYPEOF(h.cab_configuration) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_front_axle_code(TYPEOF(h.front_axle_code) L, TYPEOF(h.front_axle_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_rear_axle_code(TYPEOF(h.rear_axle_code) L, TYPEOF(h.rear_axle_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_brakes_code(TYPEOF(h.brakes_code) L, TYPEOF(h.brakes_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_manufacturer(TYPEOF(h.engine_manufacturer) L, TYPEOF(h.engine_manufacturer) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_model(TYPEOF(h.engine_model) L, TYPEOF(h.engine_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_type_code(TYPEOF(h.engine_type_code) L, TYPEOF(h.engine_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_trailer_body_style(TYPEOF(h.trailer_body_style) L, TYPEOF(h.trailer_body_style) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_trailer_number_of_axles(TYPEOF(h.trailer_number_of_axles) L, TYPEOF(h.trailer_number_of_axles) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_trailer_length(TYPEOF(h.trailer_length) L, TYPEOF(h.trailer_length) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_proactive_vin(TYPEOF(h.proactive_vin) L, TYPEOF(h.proactive_vin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ma_state_exceptions(TYPEOF(h.ma_state_exceptions) L, TYPEOF(h.ma_state_exceptions) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_filler_1(TYPEOF(h.filler_1) L, TYPEOF(h.filler_1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_series_abbreviation(TYPEOF(h.series_abbreviation) L, TYPEOF(h.series_abbreviation) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_vin_pattern(TYPEOF(h.vin_pattern) L, TYPEOF(h.vin_pattern) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ncic_data(TYPEOF(h.ncic_data) L, TYPEOF(h.ncic_data) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_full_body_style_name(TYPEOF(h.full_body_style_name) L, TYPEOF(h.full_body_style_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_nvpp_make_code(TYPEOF(h.nvpp_make_code) L, TYPEOF(h.nvpp_make_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_nvpp_make_abbreviation(TYPEOF(h.nvpp_make_abbreviation) L, TYPEOF(h.nvpp_make_abbreviation) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_nvpp_series_model(TYPEOF(h.nvpp_series_model) L, TYPEOF(h.nvpp_series_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_nvpp_series_name(TYPEOF(h.nvpp_series_name) L, TYPEOF(h.nvpp_series_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_segmentation_code(TYPEOF(h.segmentation_code) L, TYPEOF(h.segmentation_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_country_of_origin(TYPEOF(h.country_of_origin) L, TYPEOF(h.country_of_origin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_liter_information(TYPEOF(h.engine_liter_information) L, TYPEOF(h.engine_liter_information) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_filler1(TYPEOF(h.engine_information_filler1) L, TYPEOF(h.engine_information_filler1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_block_type(TYPEOF(h.engine_information_block_type) L, TYPEOF(h.engine_information_block_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_cylinders(TYPEOF(h.engine_information_cylinders) L, TYPEOF(h.engine_information_cylinders) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_filler2(TYPEOF(h.engine_information_filler2) L, TYPEOF(h.engine_information_filler2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_carburetion(TYPEOF(h.engine_information_carburetion) L, TYPEOF(h.engine_information_carburetion) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_filler3(TYPEOF(h.engine_information_filler3) L, TYPEOF(h.engine_information_filler3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_head_configuration(TYPEOF(h.engine_information_head_configuration) L, TYPEOF(h.engine_information_head_configuration) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_filler4(TYPEOF(h.engine_information_filler4) L, TYPEOF(h.engine_information_filler4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_total_valves(TYPEOF(h.engine_information_total_valves) L, TYPEOF(h.engine_information_total_valves) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_filler5(TYPEOF(h.engine_information_filler5) L, TYPEOF(h.engine_information_filler5) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_aspiration_code(TYPEOF(h.engine_information_aspiration_code) L, TYPEOF(h.engine_information_aspiration_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_carburetion_code(TYPEOF(h.engine_information_carburetion_code) L, TYPEOF(h.engine_information_carburetion_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_information_valves_per_cylinder(TYPEOF(h.engine_information_valves_per_cylinder) L, TYPEOF(h.engine_information_valves_per_cylinder) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_transmission_speed(TYPEOF(h.transmission_speed) L, TYPEOF(h.transmission_speed) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_transmission_filler1(TYPEOF(h.transmission_filler1) L, TYPEOF(h.transmission_filler1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_transmission_type(TYPEOF(h.transmission_type) L, TYPEOF(h.transmission_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_transmission_filler2(TYPEOF(h.transmission_filler2) L, TYPEOF(h.transmission_filler2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_transmission_code(TYPEOF(h.transmission_code) L, TYPEOF(h.transmission_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_transmission_filler3(TYPEOF(h.transmission_filler3) L, TYPEOF(h.transmission_filler3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_transmission_speed_code(TYPEOF(h.transmission_speed_code) L, TYPEOF(h.transmission_speed_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_base_model(TYPEOF(h.base_model) L, TYPEOF(h.base_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_complete_prefix_file_id(TYPEOF(h.complete_prefix_file_id) L, TYPEOF(h.complete_prefix_file_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_series_name_full_spelling(TYPEOF(h.series_name_full_spelling) L, TYPEOF(h.series_name_full_spelling) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_vis_theft_code(TYPEOF(h.vis_theft_code) L, TYPEOF(h.vis_theft_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_base_list_price_expanded(TYPEOF(h.base_list_price_expanded) L, TYPEOF(h.base_list_price_expanded) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_default_nada_vehicle_id(TYPEOF(h.default_nada_vehicle_id) L, TYPEOF(h.default_nada_vehicle_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_default_nada_model(TYPEOF(h.default_nada_model) L, TYPEOF(h.default_nada_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_default_nada_body_style(TYPEOF(h.default_nada_body_style) L, TYPEOF(h.default_nada_body_style) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_default_nada_msrp(TYPEOF(h.default_nada_msrp) L, TYPEOF(h.default_nada_msrp) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_default_nada_gvwr(TYPEOF(h.default_nada_gvwr) L, TYPEOF(h.default_nada_gvwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_default_nada_gcwr(TYPEOF(h.default_nada_gcwr) L, TYPEOF(h.default_nada_gcwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_1_nada_vehicle_id(TYPEOF(h.alt_1_nada_vehicle_id) L, TYPEOF(h.alt_1_nada_vehicle_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_1_nada_model(TYPEOF(h.alt_1_nada_model) L, TYPEOF(h.alt_1_nada_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_1_nada_body_style(TYPEOF(h.alt_1_nada_body_style) L, TYPEOF(h.alt_1_nada_body_style) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_1_nada_msrp(TYPEOF(h.alt_1_nada_msrp) L, TYPEOF(h.alt_1_nada_msrp) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_1_nada_gvwr(TYPEOF(h.alt_1_nada_gvwr) L, TYPEOF(h.alt_1_nada_gvwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_1_nada_gcwr(TYPEOF(h.alt_1_nada_gcwr) L, TYPEOF(h.alt_1_nada_gcwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_2_nada_vehicle_id(TYPEOF(h.alt_2_nada_vehicle_id) L, TYPEOF(h.alt_2_nada_vehicle_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_2_nada_model(TYPEOF(h.alt_2_nada_model) L, TYPEOF(h.alt_2_nada_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_2_nada_body_style(TYPEOF(h.alt_2_nada_body_style) L, TYPEOF(h.alt_2_nada_body_style) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_2_nada_msrp(TYPEOF(h.alt_2_nada_msrp) L, TYPEOF(h.alt_2_nada_msrp) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_2_nada_gvwr(TYPEOF(h.alt_2_nada_gvwr) L, TYPEOF(h.alt_2_nada_gvwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_2_nada_gcwr(TYPEOF(h.alt_2_nada_gcwr) L, TYPEOF(h.alt_2_nada_gcwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_3_nada_vehicle_id(TYPEOF(h.alt_3_nada_vehicle_id) L, TYPEOF(h.alt_3_nada_vehicle_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_3_nada_model(TYPEOF(h.alt_3_nada_model) L, TYPEOF(h.alt_3_nada_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_3_nada_body_style(TYPEOF(h.alt_3_nada_body_style) L, TYPEOF(h.alt_3_nada_body_style) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_3_nada_msrp(TYPEOF(h.alt_3_nada_msrp) L, TYPEOF(h.alt_3_nada_msrp) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_3_nada_gvwr(TYPEOF(h.alt_3_nada_gvwr) L, TYPEOF(h.alt_3_nada_gvwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_3_nada_gcwr(TYPEOF(h.alt_3_nada_gcwr) L, TYPEOF(h.alt_3_nada_gcwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_4_nada_vehicle_id(TYPEOF(h.alt_4_nada_vehicle_id) L, TYPEOF(h.alt_4_nada_vehicle_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_4_nada_model(TYPEOF(h.alt_4_nada_model) L, TYPEOF(h.alt_4_nada_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_4_nada_body_style(TYPEOF(h.alt_4_nada_body_style) L, TYPEOF(h.alt_4_nada_body_style) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_4_nada_msrp(TYPEOF(h.alt_4_nada_msrp) L, TYPEOF(h.alt_4_nada_msrp) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_4_nada_gvwr(TYPEOF(h.alt_4_nada_gvwr) L, TYPEOF(h.alt_4_nada_gvwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_4_nada_gcwr(TYPEOF(h.alt_4_nada_gcwr) L, TYPEOF(h.alt_4_nada_gcwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_5_nada_vehicle_id(TYPEOF(h.alt_5_nada_vehicle_id) L, TYPEOF(h.alt_5_nada_vehicle_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_5_nada_model(TYPEOF(h.alt_5_nada_model) L, TYPEOF(h.alt_5_nada_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_5_nada_body_style(TYPEOF(h.alt_5_nada_body_style) L, TYPEOF(h.alt_5_nada_body_style) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_5_nada_msrp(TYPEOF(h.alt_5_nada_msrp) L, TYPEOF(h.alt_5_nada_msrp) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_5_nada_gvwr(TYPEOF(h.alt_5_nada_gvwr) L, TYPEOF(h.alt_5_nada_gvwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_5_nada_gcwr(TYPEOF(h.alt_5_nada_gcwr) L, TYPEOF(h.alt_5_nada_gcwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_6_nada_vehicle_id(TYPEOF(h.alt_6_nada_vehicle_id) L, TYPEOF(h.alt_6_nada_vehicle_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_6_nada_model(TYPEOF(h.alt_6_nada_model) L, TYPEOF(h.alt_6_nada_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_6_nada_body_style(TYPEOF(h.alt_6_nada_body_style) L, TYPEOF(h.alt_6_nada_body_style) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_6_nada_msrp(TYPEOF(h.alt_6_nada_msrp) L, TYPEOF(h.alt_6_nada_msrp) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_6_nada_gvwr(TYPEOF(h.alt_6_nada_gvwr) L, TYPEOF(h.alt_6_nada_gvwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_6_nada_gcwr(TYPEOF(h.alt_6_nada_gcwr) L, TYPEOF(h.alt_6_nada_gcwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_7_nada_vehicle_id(TYPEOF(h.alt_7_nada_vehicle_id) L, TYPEOF(h.alt_7_nada_vehicle_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_7_nada_model(TYPEOF(h.alt_7_nada_model) L, TYPEOF(h.alt_7_nada_model) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_7_nada_body_style(TYPEOF(h.alt_7_nada_body_style) L, TYPEOF(h.alt_7_nada_body_style) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_7_nada_msrp(TYPEOF(h.alt_7_nada_msrp) L, TYPEOF(h.alt_7_nada_msrp) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_7_nada_gvwr(TYPEOF(h.alt_7_nada_gvwr) L, TYPEOF(h.alt_7_nada_gvwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_alt_7_nada_gcwr(TYPEOF(h.alt_7_nada_gcwr) L, TYPEOF(h.alt_7_nada_gcwr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_aaia_codes(TYPEOF(h.aaia_codes) L, TYPEOF(h.aaia_codes) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_incomplete_vehicle_flag(TYPEOF(h.incomplete_vehicle_flag) L, TYPEOF(h.incomplete_vehicle_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_filler2(TYPEOF(h.filler2) L, TYPEOF(h.filler2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_electric_battery_info_type(TYPEOF(h.electric_battery_info_type) L, TYPEOF(h.electric_battery_info_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_filler3(TYPEOF(h.filler3) L, TYPEOF(h.filler3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_electric_battery_kilowatts(TYPEOF(h.electric_battery_kilowatts) L, TYPEOF(h.electric_battery_kilowatts) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_filler4(TYPEOF(h.filler4) L, TYPEOF(h.filler4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_electric_battery_volts(TYPEOF(h.electric_battery_volts) L, TYPEOF(h.electric_battery_volts) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_filler5(TYPEOF(h.filler5) L, TYPEOF(h.filler5) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_info_proprietary_engine_brand(TYPEOF(h.engine_info_proprietary_engine_brand) L, TYPEOF(h.engine_info_proprietary_engine_brand) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_filler6(TYPEOF(h.filler6) L, TYPEOF(h.filler6) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_info_high_output_engine(TYPEOF(h.engine_info_high_output_engine) L, TYPEOF(h.engine_info_high_output_engine) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_info_supercharged(TYPEOF(h.engine_info_supercharged) L, TYPEOF(h.engine_info_supercharged) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_info_turbocharged(TYPEOF(h.engine_info_turbocharged) L, TYPEOF(h.engine_info_turbocharged) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_engine_info_vvtl(TYPEOF(h.engine_info_vvtl) L, TYPEOF(h.engine_info_vvtl) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_iso_liability(TYPEOF(h.iso_liability) L, TYPEOF(h.iso_liability) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_series_name_condensed(TYPEOF(h.series_name_condensed) L, TYPEOF(h.series_name_condensed) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_aces_data(TYPEOF(h.aces_data) L, TYPEOF(h.aces_data) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_base_shipping_weight_expanded(TYPEOF(h.base_shipping_weight_expanded) L, TYPEOF(h.base_shipping_weight_expanded) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_filler7(TYPEOF(h.filler7) L, TYPEOF(h.filler7) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_customer_defined_data(TYPEOF(h.customer_defined_data) L, TYPEOF(h.customer_defined_data) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
END;

