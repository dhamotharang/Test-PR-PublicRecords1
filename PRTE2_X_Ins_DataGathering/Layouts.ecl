/* ***********************************************************************************************************
PRTE2_X_Ins_DataGathering.Layouts
UsableVINLayout
For CT purposes, VINS have no states applied so just gather by year.

vina_veh_type = Code that indicates the type of vehicle
M=motorcycle
P=passenger car
L=light truck				Tested 2019 and there were no "L" values... so using "T" instead
T=heavy truck				BUT "T" include semi trucks unless you alter filter only orig_vehicle_type_code='P'  (exclude "T") 
X=trailer
U=unknown (we could not determine the type of vehicle by decoding the VIN) 

NOTE: for commercial we would want "T" but including the semi trucks from time to time I imagine.
NOTE: After deduping there are always fewer... so added a dedup here prior to the CHOOSEN
*********************************************************************************************************** */


EXPORT Layouts := MODULE

		EXPORT MiniVIN_V2_Layout := RECORD
      	STRING	Orig_VIN;
			STRING	best_make_code;
			STRING	best_model_code;
			STRING	best_model_year;
         STRING   orig_year;
         STRING   orig_Make_code;
         STRING   orig_Model_code;
         STRING   vina_veh_type;
      END;
		EXPORT UsableVINLayout := RECORD
			unsigned8 hashvalue;
			string30 vehicle_key;
			string15 iteration_key;
			string2 source_code;
			string2 state_origin;
			unsigned8 state_bitmap_flag;
			string25 orig_vin;
			string4 orig_year;
			string5 orig_make_code;
			string36 orig_make_desc;
			string3 orig_model_code;
			string30 orig_model_desc;
			string1 vina_veh_type;
			string5 vina_ncic_make;
			string2 vina_model_year_yy;
			string17 vina_vin;
			string1 vina_vin_pattern_indicator;
			string1 vina_bypass_code;
			string1 vina_vp_restraint;
			string4 vina_vp_abbrev_make_name;
			string2 vina_vp_year;
			string3 vina_vp_series;
			string3 vina_vp_model;
			string1 vina_vp_air_conditioning;
			string1 vina_vp_power_steering;
			string1 vina_vp_power_brakes;
			string1 vina_vp_power_windows;
			string1 vina_vp_tilt_wheel;
			string1 vina_vp_roof;
			string1 vina_vp_optional_roof1;
			string1 vina_vp_optional_roof2;
			string1 vina_vp_radio;
			string1 vina_vp_optional_radio1;
			string1 vina_vp_optional_radio2;
			string1 vina_vp_transmission;
			string1 vina_vp_optional_transmission1;
			string1 vina_vp_optional_transmission2;
			string1 vina_vp_anti_lock_brakes;
			string1 vina_vp_front_wheel_drive;
			string1 vina_vp_four_wheel_drive;
			string1 vina_vp_security_system;
			string1 vina_vp_daytime_running_lights;
			string25 vina_vp_series_name;
			string4 vina_model_year;
			string3 vina_series;
			string3 vina_model;
			string2 vina_body_style;
			string36 vina_make_desc;
			string36 vina_model_desc;
			string25 vina_series_desc;
			string25 vina_body_style_desc;
			string2 vina_number_of_cylinders;
			string4 vina_engine_size;
			string1 vina_fuel_code;
			string6 vina_price;
			string5 best_make_code;
			string3 best_series_code;
			string3 best_model_code;
			string5 best_body_code;
			string4 best_model_year;
			string3 best_major_color_code;
			string3 best_minor_color_code;
		END;
END;