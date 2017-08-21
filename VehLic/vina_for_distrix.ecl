
dvinai := VehLic.Vin_Matches(VehLic.ValidVin(vin));

dvina := dvinai(series_description<>'' or make_description<>'' or model_description<>'' or model_year_yy<>'');

dVINAPlusLength	:=	trim(dVINA.vp_restraint
					   + dVINA.vp_abbrev_make_name
					   + dVINA.vp_year
					   + dVINA.vp_series
					   + dVINA.vp_model
					   + dVINA.vp_air_conditioning
					   + dVINA.vp_power_steering
					   + dVINA.vp_power_brakes
					   + dVINA.vp_power_windows
					   + dVINA.vp_tilt_wheel
					   + dVINA.vp_roof
					   + dVINA.vp_optional_roof1
					   + dVINA.vp_optional_roof2
					   + dVINA.vp_radio
					   + dVINA.vp_optional_radio1
					   + dVINA.vp_optional_radio2
					   + dVINA.vp_transmission
					   + dVINA.vp_optional_transmission1
					   + dVINA.vp_optional_transmission2
					   + dVINA.vp_anti_lock_brakes
					   + dVINA.vp_front_wheel_drive
					   + dVINA.vp_four_wheel_drive
					   + dVINA.vp_security_system
					   + dVINA.vp_daytime_running_lights
//					   + dVINA.vp_reserved				// removed from previous code because of unpredictability of value
					   + dVINA.vp_series_name,
						 all
						);


dVINADist	:=	distribute(dvina,hash(vin[1..10]));
dVINASort	:=	sort(dVINADist,vin[1..10],-dVINAPlusLength,local);
dVINADedup	:=	dedup(dVINASort,vin[1..10],local);

write_file := output(dVINADedup(veh_type<>'U'),,'~thor_data400::out::VinaShrunk',overwrite);

export vina_for_distrix := write_file;