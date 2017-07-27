
/* **************************
  As of this date, VINA processing is changed to use all 17-digits of the VIN instead of only the first 10 characters.
  This is required because the "VinPlus" and "VISRAP" details are different for specific VINs.  While the major codes
  returned by VINA (make, model, body style, etc) would be valid for vin[1..10] these other values, which are going to
  be added to the vehicle report, would not be valid.
  
  It makes the attribute misnomer, but it keeps the code and chain alive.

  tkirk - 20050422
************************** */

dVINA			:=	vehlic.File_VINA;

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


dVINADist	:=	distribute(vehlic.File_VINA,hash(vin_input));
dVINASort	:=	sort(dVINADist,vin_input,-dVINAPlusLength,local);
dVINADedup	:=	dedup(dVINASort,vin_input,local);

export Vin_Matches	:=	dVINADedup : persist('~thor_data400::persist::vehreg_vina_deduped');
