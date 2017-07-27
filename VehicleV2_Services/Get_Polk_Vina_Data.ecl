IMPORT Vina,VehicleV2,codes;

export VehicleV2_Services.Layout_Report Get_Polk_Vina_Data (dataset(VehicleV2_Services.Layout_Vehicle_Vin) in_VIN, boolean b_decoder = false):= FUNCTION
// added b_decoder boolean for the vina.vindecoder service to return model year in yyyy format.

k(i,field) := MACRO // For the first few positions, they never have a *... this will increase performance

keyed(LEFT.vin[i]=RIGHT.field)

ENDMACRO;

m(i,field) := MACRO

keyed(LEFT.vin[i]=RIGHT.field OR RIGHT.field = '*')

ENDMACRO;

//**************vina data start
	VehicleV2_Services.Layout_Report xform_Vina (in_VIN l,vina.key_vin r):=transform
	self.vin:=l.vin;
	self.make_desc := r.make_name;
	self.is_current :=True;
	self.DataSource:=VehicleV2_Services.constant.Realtime_val_out;
	self.vehicle_type_desc :=VehicleV2_Services.Polk_Code_Translations.Veh_Type_Description(r.vehicle_type);
	self.body_style_desc := r.full_body_style_name;
	self.VINA_VP_Year := r.model_year[3..4];
	self.VINA_VP_Series := r.series_abbreviation ;
	self.VINA_VP_Series_Name := r.series_name ;
	self.VINA_VP_Model := r.base_model ;
	self.VINA_VP_RESTRAINT_Desc := '';//r. ;
	self.VINA_VP_AIR_CONDITIONING_Desc := codes.VEHICLE_REGISTRATION.VP_AIR_CONDITIONING(r.air_conditioning);
	self.VINA_VP_POWER_STEERING_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_STEERING(r.power_steering);
	self.VINA_VP_POWER_BRAKES_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_BRAKES(r.power_brakes);
	self.VINA_VP_Power_Windows_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_WINDOWS(r.power_windows);
	self.VINA_VP_Tilt_Wheel_Desc := codes.VEHICLE_REGISTRATION.VP_Tilt_Wheel(r.tilt_wheel);
	self.VINA_VP_Roof_Desc := codes.VEHICLE_REGISTRATION.VP_ROOF(r.roof);
	self.VINA_VP_Optional_Roof1_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF1(r.optional_roof1);
	self.VINA_VP_Optional_Roof2_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF2(r.optional_roof2);
	self.VINA_VP_Radio_Desc := codes.VEHICLE_REGISTRATION.VP_RADIO(r.radio);
	self.VINA_VP_Optional_Radio1_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO1(r.optional_radio1);
	self.VINA_VP_Optional_Radio2_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO2(r.optional_radio2);
	self.VINA_VP_Transmission := r.transmission ;
	self.VINA_VP_Transmission_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.transmission);
	self.VINA_VP_Optional_Transmission1_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.optional_transmission1);
	self.VINA_VP_Optional_Transmission2_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.optional_transmission2);
	self.VINA_VP_Anti_Lock_Brakes_Desc := codes.VEHICLE_REGISTRATION.VP_ANTI_LOCK_BRAKES(r.anti_lock_brakes);
	// self.VINA_VP_Front_Wheel_Drive_Desc := if(r.proactive_vin = 'N',if(r.driving_wheels='F','Y','N'),'');//r. ;
	// self.VINA_VP_Four_Wheel_Drive_Desc := if(r.vehicle_type = 'T',if(r.wheels[2] = '8','Y','N'),if(r.proactive_vin = 'N',if(r.driving_wheels='4','Y','N'),''));//r. ;

	self.VINA_VP_Front_Wheel_Drive_Desc := codes.VEHICLE_REGISTRATION.VP_FRONT_WHEEL_DRIVE(if(r.proactive_vin = 'N',if(r.driving_wheels='F','Y','N'),''));
	self.VINA_VP_Four_Wheel_Drive_Desc := codes.VEHICLE_REGISTRATION.VP_FOUR_WHEEL_DRIVE(if(r.vehicle_type = 'T',if(r.wheels[2] = '8','Y','N'),if(r.proactive_vin = 'N',if(r.driving_wheels='4','Y','N'),'')));

	self.VINA_VP_Security_System_Desc := codes.VEHICLE_REGISTRATION.VP_SECURITY_SYSTEM(r.security_system);
	self.VINA_VP_Daytime_Running_Lights_Desc := codes.VEHICLE_REGISTRATION.VP_DAYTIME_RUNNING_LIGHTS(r.daytime_running_lights);
	self.VINA_Number_Of_Cylinders := r.cylinders ;
	self.VINA_Engine_Size := r.displacement; //r.engine_liter_information;
	self.Vina_fuel_code := r.fuel ;
	self.fuel_type_name := VehicleV2_Services.Polk_Code_Translations.fuel_desc(r.fuel) ;
	self.VINA_Price := '';//r. ;
	self.BASE_PRICE := r.base_list_price ;
	self.Orig_Net_Weight := r.base_shipping_weight ;
	self.Orig_Gross_Weight := '';//r. ;
	self.Orig_Number_Of_Axles :='';// r. ;
	self.Orig_Vehicle_Use_code := '';//r. ;
	self.Orig_Vehicle_Use_Desc := '';//r. ;
	self.model_year := if(b_decoder,r.model_year,'');
	self:=[];
	end;
	//**************vina data end	

// WARNING: If you find that data seems to be "dropped" from this query, then make sure that there
//          are no entries in the first 8 positions that contain a '*' in the vina.key_vin file.
//          If you find that an '*' exists in the first 8 positions, you need to change the macro
//          call for that position from k to m and check the new code into the repository. (08/24/11)
vina_data := JOIN(in_VIN, vina.key_vin,
						k(1,l_vin1) AND
						k(2,l_vin2) AND
						k(3,l_vin3) AND
						k(4,l_vin4) AND
						k(5,l_vin5) AND
						k(6,l_vin6) AND
						k(7,l_vin7) AND
						k(8,l_vin8) AND
						m(9,l_vin9) AND
						m(10,l_vin10) AND
						m(11,l_vin11) AND
						m(12,l_vin12) AND
						m(13,l_vin13) AND
						m(14,l_vin14) AND
						m(15,l_vin15) AND
						m(16,l_vin16) AND
						m(17,l_vin17),xform_Vina(LEFT,RIGHT),
            LIMIT (VehicleV2_Services.Constant.VINDATA_LIMIT, SKIP));

// output(j,all);
// layout_local_vina:= record
// VehicleV2_Services.Layout_Report_Vehicle;
// end;

// vina_data:= project(vina_data_join,xform_Vina(LEFT));
// output(in_Vin);
// output(vina_data);

return vina_data;
END;