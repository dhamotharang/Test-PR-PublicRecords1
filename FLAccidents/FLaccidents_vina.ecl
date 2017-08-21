
import VehLic, FLAccidents;

EXPORT FLAccidents_vina(
	dataset(recordof(FLAccidents.Layout_FLCrash2v_v2))	ds_FLCrash2,
	dataset(recordof(FLAccidents.Layout_FLCrash3v_v2))	ds_FLCrash3,
	dataset(recordof(VehLic.Layout_VINA))															ds_vina_0)	:=
MODULE

ds_vina_1:=sort(distribute(ds_vina_0,hash(vin_input)),vin_input,local);
ds_vina_1 roll_vina(ds_vina_1 l, ds_vina_1 r) := transform
	self.veh_type					:=if(l.veh_type='U',r.veh_type,l.veh_type);
	self.ncic_make					:=if(l.ncic_make='',r.ncic_make,l.ncic_make);
	self.model_year_yy				:=if(l.model_year_yy='',r.model_year_yy,l.model_year_yy);
	self.vin						:=if(l.vin='',r.vin,l.vin);
	self.vin_error_status			:=if(l.vin_error_status='',r.vin_error_status,l.vin_error_status);
	self.vin_pattern_indicator		:=if(l.vin_pattern_indicator='',r.vin_pattern_indicator,l.vin_pattern_indicator);
	self.vin_pattern				:=if(l.vin_pattern='',r.vin_pattern,l.vin_pattern);
	self.bypass_code				:=if(l.bypass_code='',r.bypass_code,l.bypass_code);
	self.variable_segment			:=if(l.variable_segment='',r.variable_segment,l.variable_segment);
	self.vp_restraint				:=if(l.vp_restraint='',r.vp_restraint,l.vp_restraint);
	self.vp_abbrev_make_name		:=if(l.vp_abbrev_make_name='',r.vp_abbrev_make_name,l.vp_abbrev_make_name);
	self.vp_year					:=if(l.vp_year='',r.vp_year,l.vp_year);
	self.vp_series					:=if(l.vp_series='',r.vp_series,l.vp_series);
	self.vp_model					:=if(l.vp_model='',r.vp_model,l.vp_model);
	self.vp_air_conditioning		:=if(l.vp_air_conditioning='',r.vp_air_conditioning,l.vp_air_conditioning);
	self.vp_power_steering			:=if(l.vp_power_steering='',r.vp_power_steering,l.vp_power_steering);
	self.vp_power_brakes			:=if(l.vp_power_brakes='',r.vp_power_brakes,l.vp_power_brakes);
	self.vp_power_windows			:=if(l.vp_power_windows='',r.vp_power_windows,l.vp_power_windows);
	self.vp_tilt_wheel				:=if(l.vp_tilt_wheel='',r.vp_tilt_wheel,l.vp_tilt_wheel);
	self.vp_roof					:=if(l.vp_roof='',r.vp_roof,l.vp_roof);
	self.vp_optional_roof1			:=if(l.vp_optional_roof1='',r.vp_optional_roof1,l.vp_optional_roof1);
	self.vp_optional_roof2			:=if(l.vp_optional_roof2='',r.vp_optional_roof2,l.vp_optional_roof2);
	self.vp_radio					:=if(l.vp_radio='',r.vp_radio,l.vp_radio);
	self.vp_optional_radio1			:=if(l.vp_optional_radio1='',r.vp_optional_radio1,l.vp_optional_radio1);
	self.vp_optional_radio2			:=if(l.vp_optional_radio2='',r.vp_optional_radio2,l.vp_optional_radio2);
	self.vp_transmission			:=if(l.vp_transmission='',r.vp_transmission,l.vp_transmission);
	self.vp_optional_transmission1	:=if(l.vp_optional_transmission1='',r.vp_optional_transmission1,l.vp_optional_transmission1);
	self.vp_optional_transmission2	:=if(l.vp_optional_transmission2='',r.vp_optional_transmission2,l.vp_optional_transmission2);
	self.vp_anti_lock_brakes		:=if(l.vp_anti_lock_brakes='',r.vp_anti_lock_brakes,l.vp_anti_lock_brakes);
	self.vp_front_wheel_drive		:=if(l.vp_front_wheel_drive='',r.vp_front_wheel_drive,l.vp_front_wheel_drive);
	self.vp_four_wheel_drive		:=if(l.vp_four_wheel_drive='',r.vp_four_wheel_drive,l.vp_four_wheel_drive);
	self.vp_security_system			:=if(l.vp_security_system='',r.vp_security_system,l.vp_security_system);
	self.vp_daytime_running_lights	:=if(l.vp_daytime_running_lights='',r.vp_daytime_running_lights,l.vp_daytime_running_lights);
	self.vp_reserved				:=if(l.vp_reserved='',r.vp_reserved,l.vp_reserved);
	self.vp_series_name				:=if(l.vp_series_name='',r.vp_series_name,l.vp_series_name);
	self.model_year					:=if(l.model_year='',r.model_year,l.model_year);
	self.vina_series				:=if(l.vina_series='',r.vina_series,l.vina_series);
	self.vina_model					:=if(l.vina_model='',r.vina_model,l.vina_model);
	self.vina_body_style			:=if(l.vina_body_style='',r.vina_body_style,l.vina_body_style);
	self.make_description			:=if(l.make_description='',r.make_description,l.make_description);
	self.model_description			:=if(l.model_description='',r.model_description,l.model_description);
	self.series_description			:=if(l.series_description='',r.series_description,l.series_description);
	self.body_style_description		:=if(l.body_style_description='',r.body_style_description,l.body_style_description);
	self.number_of_cylinders		:=if(l.number_of_cylinders='',r.number_of_cylinders,l.number_of_cylinders);
	self.engine_size				:=if(l.engine_size='',r.engine_size,l.engine_size);
	self.fuel_code					:=if(l.fuel_code='',r.fuel_code,l.fuel_code);
	self.cr							:=if(l.cr='',r.cr,l.cr);
	self							:= l;
end;
ds_vina := rollup(ds_vina_1
					,left.vin_input=right.vin_input
					,roll_vina(left,right)
					,local);

ds_vins2	:= table(ds_FLCrash2,{string22 vin:=ds_FLCrash2.vehicle_id_nbr});
ds_vins3	:= table(ds_FLCrash3,{string22 vin:=ds_FLCrash3.towed_trlr_veh_id_nbr});

ds_vins		:= dedup(sort(distribute(ds_vins2 + ds_vins3(vin<>''),hash(vin)),vin,local),vin,local);

r_vin_file	:=	record
	ds_vina.vin_input;
	ds_vina.veh_type;
	ds_vina.ncic_make;
	ds_vina.model_year_yy;
	ds_vina.vin;
	ds_vina.vin_error_status;
	ds_vina.vin_pattern_indicator;
	ds_vina.vin_pattern;
	ds_vina.bypass_code;
	car_series					:=ds_vina.variable_segment[	1	..	3	];
	car_orig_base_list_price	:=ds_vina.variable_segment[	4	..	8	];
	car_shipping_wt				:=ds_vina.variable_segment[	9	..	12	];
	car_orig_tire_size			:=ds_vina.variable_segment[	13	..	18	];
	car_wheel_base				:=ds_vina.variable_segment[	19	..	26	];
	car_body_style				:=ds_vina.variable_segment[	27	..	28	];
	car_cid						:=ds_vina.variable_segment[	29	..	31	];
	car_cylinders				:=ds_vina.variable_segment[	32	..	33	];
	car_carburetion				:=ds_vina.variable_segment[	34	..	34	];
	car_fuel_code				:=ds_vina.variable_segment[	35	..	35	];
	car_filler					:=ds_vina.variable_segment[	36	..	44	];
	ds_vina.vp_restraint;
	ds_vina.vp_abbrev_make_name;
	ds_vina.vp_year;
	ds_vina.vp_series;
	ds_vina.vp_model;
	ds_vina.vp_air_conditioning;
	ds_vina.vp_power_steering;
	ds_vina.vp_power_brakes;
	ds_vina.vp_power_windows;
	ds_vina.vp_tilt_wheel;
	ds_vina.vp_roof;
	ds_vina.vp_optional_roof1;
	ds_vina.vp_optional_roof2;
	ds_vina.vp_radio;
	ds_vina.vp_optional_radio1;
	ds_vina.vp_optional_radio2;
	ds_vina.vp_transmission;
	ds_vina.vp_optional_transmission1;
	ds_vina.vp_optional_transmission2;
	ds_vina.vp_anti_lock_brakes;
	ds_vina.vp_front_wheel_drive;
	ds_vina.vp_four_wheel_drive;
	ds_vina.vp_security_system;
	ds_vina.vp_daytime_running_lights;
	ds_vina.vp_reserved;
	ds_vina.vp_series_name;
	ds_vina.model_year;

	ds_vina.vina_series;
	ds_vina.vina_model;
	ds_vina.vina_body_style;
	ds_vina.make_description;
	ds_vina.model_description;
	ds_vina.series_description;
	ds_vina.body_style_description;
	ds_vina.number_of_cylinders;
	ds_vina.engine_size;
	ds_vina.fuel_code;

	ds_vina.cr;
end;

ds_vin_file:=table(ds_vina,r_vin_file);

r_vina_info	:=	record
	ds_vin_file;
end;
r_vina_info	j_vina_info_thiscycle(ds_vins l, ds_vin_file r) :=	transform
	self	:=	r;
end;

ds_vina_info	:=	join(ds_vins, ds_vin_file
						,trim(left.vin,left,right)=trim(right.vin_input,left,right)
						,j_vina_info_thiscycle(left,right)
						,local
						)
						;

EXPORT vina_info_layout  := ds_vina_info;

END;