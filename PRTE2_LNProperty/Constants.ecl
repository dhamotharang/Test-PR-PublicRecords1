﻿import _control, ln_propertyv2_fast;

EXPORT Constants := module

EXPORT KeyName_ln_propertyv2 := 	'~prte::key::ln_propertyv2::'; 

EXPORT FCRA_KeyName_ln_propertyv2 := '~prte::key::ln_propertyv2::fcra::';

EXPORT ak_keyname := KeyName_ln_propertyv2 +'autokey::'; 

EXPORT ak_logical(string filedate) := KeyName_ln_propertyv2 + filedate + '::autokey::'; 

EXPORT skip_set := []; 

EXPORT ak_typestr := 'AK'; 

EXPORT unsigned2 MAX_EMBEDDED := 100;

EXPORT Fares_NoOnwershipChangeDocTypes := ['T','N','U','L','R','X','J','F','S','D','CD','C','M','I','JH','M','T=','TR',''];

EXPORT OKC_NoOnwershipChangeDocTypes   := ['VL','CR','RR','FC','AF','RA','CN','RL','SA','AA',''];

//Spray constants
	EXPORT IN_PREFIX_NAME				:= '~prte::in::ln_propertyv2';
	
	EXPORT LandingZoneIP						:= _control.IPAddress.bctlpedata12;													 
	EXPORT SourcePathForCSV		    	:= '/data/prct/infiles/dev_16/';  	
	EXPORT CSVSprayFieldSeparator		:= '\\t';     
	EXPORT CSVSprayLineSeparator		:= '\\n,\\r\\n';
	EXPORT CSVSprayQuote						:= '';
	EXPORT CSVMaxCount							:= 100000;  
	EXPORT CSVOutFieldSeparator			:= ',';
	EXPORT CSVOutQuote							:= '"';
	EXPORT CSVSuffix								:= '.txt';

	EXPORT st_restrict := [];
	EXPORT max_owners := 10;
	EXPORT max_hist := 100;
	
	export field_to_clear_assessor_fid := LN_PropertyV2_fast.Constants.field_to_clear_assessor_fid;
	
	// 'air_conditioning_code,air_conditioning_type_code,amenities1_code,amenities2_code,' +
	                                      // 'amenities2_code1,amenities2_code2,amenities2_code3,amenities2_code4,amenities2_code5,' +
																				       // 'amenities3_code,amenities4_code,amenities5_code,assessee_name_indicator,' +
																								 // 'assessee_phone_number,basement_code,building_area4,building_area4_indicator,' +
																									// 'building_area5,building_area5_indicator,building_area6,building_area6_indicator,' +
																									// 'building_area7,building_area7_indicator,building_class_code,building_condition_code,' +
																									// 'building_quality_code,census_tract,certification_date,comments,' +
																									// 'condo_project_or_building_name,contract_owner,duplicate_apn_multiple_address_id,' +
																									// 'effective_year_built,elevator,exterior_walls_code,extra_features1_area,' +
																									// 'extra_features1_indicator,extra_features2_area,extra_features2_indicator,' +
																									// 'extra_features3_area,extra_features3_indicator,extra_features4_area,' +
																									// 'extra_features4_indicator,fireplace_indicator,fireplace_number,floor_cover_code,' +
																									// 'heating_code,heating_fuel_type_code,interior_walls_code,land_dimensions,' +
																									// 'land_square_footage,legal_assessor_map_ref,legal_block,legal_brief_description,' +
																									// 'legal_city_municipality_township,legal_district,legal_land_lot,legal_land_lot,' +
																									// 'legal_lot_code,legal_lot_code,legal_lot_number,legal_lot_number,legal_phase_number,' +
																									// 'legal_phase_number,legal_sec_twn_rng_mer,legal_sec_twn_rng_mer,legal_section,' +
																									// 'legal_section,legal_subdivision_name,legal_subdivision_name,legal_tract_number,' +
																									// 'legal_tract_number,legal_unit,legal_unit,lot_size_depth_feet,lot_size_frontage_feet,' +
																									// 'mail_care_of_name_indicator,mortgage_lender_type_code,mortgage_loan_amount,' +
																									// 'mortgage_loan_type_code,neighborhood_code,new_record_type_code,no_of_plumbing_fixtures,' +
																									// 'other_buildings1_code,other_buildings2_code,other_buildings3_code,' +
																									// 'other_buildings4_code,other_buildings5_code,other_impr_building_area1,' +
																									// 'other_impr_building_area2,other_impr_building_area3,other_impr_building_area4,' +
																									// 'other_impr_building_area5,other_impr_building1_indicator,other_impr_building2_indicator,' +
																									// 'other_impr_building3_indicator,other_impr_building4_indicator,' +
																									// 'other_impr_building5_indicator,other_rooms_indicator,ownership_type_code,' +
																									// 'parking_no_of_cars,prior_recording_date,prior_transfer_date,proc_date,' +
																									// 'property_address_code,record_type_code,sale_date,school_tax_district2,' +
																									// 'school_tax_district2_indicator,school_tax_district3,school_tax_district3_indicator,' +
																									// 'second_assessee_name_indicator,sewer_code,site_influence1_code,site_influence2_code,' +
																									// 'site_influence3_code,site_influence4_code,site_influence5_code,state_code,' +
																									// 'state_land_use_code,tax_delinquent_year,tax_exemption1_code,tax_exemption2_code,' +
																									// 'tax_exemption3_code,tax_exemption4_code,tax_rate_code_area,timeshare_code,' +
																									// 'topograpy_code,transfer_date,water_code';

export field_to_clear_deed_fid := LN_PropertyV2_fast.Constants.field_to_clear_deed_fid;
// 'addendum_flag,adjustable_rate_index,adjustable_rate_rider,arm_reset_date,assumability_rider,balloon_rider,biweekly_payment_rider,' +
                   // 'change_index,city_transfer_tax,condominium_rider,county_transfer_tax,excise_tax_number,filler_except_hawaii,fixed_step_rate_rider,' +
									 // 'graduated_payment_rider,hawaii_condo_cpr_code,hawaii_condo_name,hawaii_tct,legal_block,legal_city_municipality_township,legal_district,' +
									 // 'legal_land_lot,legal_lot_code,legal_lot_number,legal_phase_number,legal_sec_twn_rng_mer,legal_section,legal_subdivision_name,' +
									 // 'legal_tract_number,legal_unit,lender_address_citystatezip,lender_address_unit_number,lender_dba_aka_name,lender_full_street_address,' +
									 // 'lender_name_id,loan_term_months,loan_term_years,mailing_address_cd,multi_apn_flag,one_four_family_rider,partial_interest_transferred,' +
									 // 'planned_unit_development_rider,prepayment_rider,property_address_code,rate_improvement_rider,second_home_rider,' +
									 // 'second_td_lender_type_code,second_td_loan_amount,seller_addendum_flag,tax_id_number,timeshare_flag,total_transfer_tax';
	
END;

