/* ************************************************************************************
PRTE2_WaterCraft_Ins.Layouts

To imitate what we did in PhonesPlus we should:
a. Files should reference all naming via PRTE2_Common.Cross_Module_Files
b. Layouts should reference all layouts via PRTE2_WaterCraft.Layouts except our spray/despray can differ if desired. 

NOTE: We only need file info here for 
a) Spray/DeSpray and 
b) Our Base file and 
c) any research/maintenance

BaseInput_Slim_Common = the insurance group's version of the base file to spray/despray
Base = official Boca layout we must transform into from BaseInput_Slim_Common
************************************************************************************ */

/********************************************************************************************************** 
	Name: 			Layouts
	Created On: 06/10/2013
	By: 				ssivasubramanian
	Desc: 			Holds all layouts of different datasets/record sets used within PRTE watercraft build process. 
***********************************************************************************************************/
IMPORT PRTE2_WaterCraft_Ins, PRTE2_WaterCraft;

EXPORT Layouts := MODULE

	EXPORT Base := PRTE2_WaterCraft.Layouts.Base_new - [bug_num, cust_name, link_inc_date, link_fein, link_dob, link_ssn];			// use official Boca layout

	/*****************************************************************************
	  New combined layout that can work for both add and rebuild spreadsheets
	*****************************************************************************/

	EXPORT BaseInput_Slim_Common := RECORD
			STRING12 did;
			STRING5 title;
			STRING xSponsor;
			STRING xAmbest;
			STRING20 fname;
			STRING20 mname;
			STRING20 lname;
			STRING5 name_suffix;
			STRING8 dob;
			STRING9 ssn;
			STRING1 gender;
			STRING60 orig_address_1;
			STRING25 orig_city;
			STRING2 orig_state;
			STRING10 orig_zip;
			STRING xZip4;
			STRING xDLState;
			STRING xDLN;
			STRING60 orig_address_2;
			STRING10 phone_1;
			STRING30 watercraft_key;
			STRING30 sequence_key;
			STRING10 watercraft_id;
			STRING2 state_origin;
			STRING2 source_code_Main;
			STRING30 hull_number_Main;
			STRING8 date_first_seen;
			STRING8 date_last_seen;
			STRING8 date_vendor_first_reported;
			STRING8 date_vendor_last_reported;
			// STRING2 source_code;
			STRING2 st_registration;
			STRING15 county_registration;
			STRING20 registration_number;
			// STRING30 hull_number;
			STRING10 vessel_database_key;
			STRING10 vessel_id;
			STRING50 name_of_vessel;
			STRING30 hull_identification_number;
			STRING2 source_code_CG;
			STRING2 source_code_Search;
			STRING30 hull_number_CG;
			STRING2 propulsion_code;
			STRING20 propulsion_description;
			STRING2 vehicle_type_code;
			STRING20 vehicle_type_description;
			STRING1 fuel_code;
			STRING20 fuel_description;
			STRING5 hull_type_code;
			STRING20 hull_type_description;
			STRING5 use_code;
			STRING20 use_description;
			STRING4 model_year;
			STRING40 watercraft_name;
			STRING5 watercraft_class_code;
			STRING35 watercraft_class_description;
			STRING5 watercraft_make_code;
			STRING30 watercraft_make_description;
			STRING5 watercraft_model_code;
			STRING30 watercraft_model_description;
			STRING5 watercraft_length;
			STRING5 watercraft_width;
			STRING10 watercraft_weight;
			STRING3 watercraft_color_1_code;
			STRING20 watercraft_color_1_description;
			STRING3 watercraft_color_2_code;
			STRING20 watercraft_color_2_description;
			STRING2 watercraft_toilet_code;
			STRING40 watercraft_toilet_description;
			STRING2 watercraft_number_of_engines;
			STRING5 watercraft_hp_1;
			STRING5 watercraft_hp_2;
			STRING5 watercraft_hp_3;
			STRING20 engine_number_1;
			STRING20 engine_number_2;
			STRING20 engine_number_3;
			STRING20 engine_make_1;
			STRING20 engine_make_2;
			STRING20 engine_make_3;
			STRING20 engine_model_1;
			STRING20 engine_model_2;
			STRING20 engine_model_3;
			STRING4 engine_year_1;
			STRING4 engine_year_2;
			STRING4 engine_year_3;
			STRING1 coast_guard_documented_flag;
			STRING30 coast_guard_number;
			STRING8 registration_date;
			STRING8 registration_expiration_date;
			STRING5 registration_status_code;
			STRING40 registration_status_description;
			STRING8 registration_status_date;
			STRING8 registration_renewal_date;
			STRING20 decal_number;
			STRING5 transaction_type_code;
			STRING40 transaction_type_description;
			STRING2 title_state;
			STRING5 title_status_code;
			STRING40 title_status_description;
			STRING20 title_number;
			STRING8 title_issue_date;
			STRING5 title_type_code;
			STRING20 title_type_description;
			STRING1 additional_owner_count;
			STRING1 lien_1_indicator;
			STRING40 lien_1_name;
			STRING8 lien_1_date;
			STRING60 lien_1_address_1;
			STRING60 lien_1_address_2;
			STRING25 lien_1_city;
			STRING2 lien_1_state;
			STRING10 lien_1_zip;
			STRING1 lien_2_indicator;
			STRING40 lien_2_name;
			STRING8 lien_2_date;
			STRING60 lien_2_address_1;
			STRING60 lien_2_address_2;
			STRING25 lien_2_city;
			STRING2 lien_2_state;
			STRING10 lien_2_zip;
			STRING2 state_purchased;
			STRING8 purchase_date;
			STRING40 dealer;
			STRING10 purchase_price;
			STRING1 new_used_flag;
			STRING5 watercraft_status_code;
			STRING20 watercraft_status_description;
			// STRING1 history_flag;
			STRING1 history_flag_Main;
			STRING1 history_flag_Search;
			STRING1 coastguard_flag;
			STRING4 signatory;
			STRING1 dppa_flag;
			STRING100 orig_name;
			STRING1 orig_name_type_code;
			STRING20 orig_name_type_description;
			STRING25 orig_name_first;
			STRING25 orig_name_middle;
			STRING25 orig_name_last;
			STRING10 orig_name_suffix;
			STRING5 orig_fips;
			STRING30 orig_province;
			STRING30 orig_country;
			STRING9 orig_ssn;
			STRING9 orig_fein;
			STRING10 phone_2;
			STRING3 name_cleaning_score;
			STRING60 company_name;
			STRING10 prim_range;
			STRING2 predir;
			STRING28 prim_name;
			STRING4 suffix;
			STRING2 postdir;
			STRING10 unit_desig;
			STRING8 sec_range;
			STRING25 p_city_name;
			STRING25 v_city_name;
			STRING2 st;
			STRING5 zip5;
			STRING4 zip4;
			STRING3 county;
			STRING4 cart;
			STRING1 cr_sort_sz;
			STRING4 lot;
			STRING1 lot_order;
			STRING2 dpbc;
			STRING1 chk_digit;
			STRING2 rec_type;
			STRING2 ace_fips_st;
			STRING3 ace_fips_county;
			STRING10 geo_lat;
			STRING11 geo_long;
			STRING4 msa;
			STRING7 geo_blk;
			STRING1 geo_match;
			STRING4 err_stat;
			STRING12 bdid;
			STRING9 fein;
			STRING3 did_score;
			STRING8 call_sign;
			STRING10 official_number;
			STRING30 imo_number;
			STRING30 vessel_service_type;
			STRING2 flag;
			STRING1 self_propelled_indicator;
			STRING7 registered_gross_tons;
			STRING7 registered_net_tons;
			STRING7 registered_length;
			STRING6 registered_breadth;
			STRING6 registered_depth;
			STRING7 itc_gross_tons;
			STRING7 itc_net_tons;
			STRING7 itc_length;
			STRING6 itc_breadth;
			STRING6 itc_depth;
			STRING50 hailing_port;
			STRING2 hailing_port_state;
			STRING50 hailing_port_province;
			STRING50 home_port_name;
			STRING2 home_port_state;
			STRING50 home_port_province;
			STRING1 trade_ind_coastwise_unrestricted;
			STRING1 trade_ind_limited_coastwise_bowaters_only;
			STRING1 trade_ind_limited_coastwise_restricted;
			STRING1 trade_ind_limited_coastwise_oil_spill_response_only;
			STRING1 trade_ind_limited_coastwise_under_charter_to_citizen;
			STRING1 trade_ind_fishery;
			STRING1 trade_ind_limited_fishery_only;
			STRING1 trade_ind_recreation;
			STRING1 trade_ind_limited_recreation_great_lakes_use_only;
			STRING1 trade_ind_registry;
			STRING1 trade_ind_limited_registry_cross_border_financing;
			STRING1 trade_ind_limited_registry_no_foreign_voyage;
			STRING1 trade_ind_limited_registry_trade_with_canada_only;
			STRING1 trade_ind_great_lakes;
			STRING50 vessel_complete_build_city;
			STRING2 vessel_complete_build_state;
			STRING50 vessel_complete_build_province;
			STRING64 vessel_complete_build_country;
			STRING4 vessel_build_year;
			STRING50 vessel_hull_build_city;
			STRING2 vessel_hull_build_state;
			STRING50 vessel_hull_build_province;
			STRING64 vessel_hull_build_country;
			STRING10 party_identification_number;
			STRING7 main_hp_ahead;
			STRING7 main_hp_astern;
			STRING30 propulsion_type;
			STRING30 hull_material;
			STRING50 ship_yard;
			STRING50 hull_builder_name;
			STRING11 doc_certificate_status;
			STRING10 date_issued;
			STRING10 date_expires;
			STRING19 hull_design_type;
			STRING1 sail_ind;
			STRING10 party_database_key;
			STRING1 itc_tons_cod_ind;
	END;	

	
END;