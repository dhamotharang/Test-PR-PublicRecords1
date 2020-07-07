IMPORT Vina,VehicleV2,codes;

EXPORT VehicleV2_Services.Layout_Report Get_Polk_Vina_Data (DATASET(VehicleV2_Services.Layout_Vehicle_Vin) in_VIN, BOOLEAN b_decoder = FALSE):= FUNCTION
// added b_decoder boolean for the vina.vindecoder service to return model year in yyyy format.

k(i,field) := MACRO // For the first few positions, they never have a *... this will increase performance

KEYED(LEFT.vin[i]=RIGHT.field)

ENDMACRO;

m(i,field) := MACRO

KEYED(LEFT.vin[i]=RIGHT.field OR RIGHT.field = '*')

ENDMACRO;

//**************vina data start
  VehicleV2_Services.Layout_Report xform_Vina (in_VIN l,vina.key_vin r):=TRANSFORM
  SELF.vin:=l.vin;
  SELF.make_desc := r.make_name;
  SELF.is_current :=TRUE;
  SELF.DataSource:=VehicleV2_Services.constant.Realtime_val_out;
  SELF.vehicle_type_desc :=VehicleV2_Services.Polk_Code_Translations.Veh_Type_Description(r.vehicle_type);
  SELF.body_style_desc := r.full_body_style_name;
  SELF.VINA_VP_Year := r.model_year[3..4];
  SELF.VINA_VP_Series := r.series_abbreviation ;
  SELF.VINA_VP_Series_Name := r.series_name ;
  SELF.VINA_VP_Model := r.base_model ;
  SELF.VINA_VP_RESTRAINT_Desc := '';//r. ;
  SELF.VINA_VP_AIR_CONDITIONING_Desc := codes.VEHICLE_REGISTRATION.VP_AIR_CONDITIONING(r.air_conditioning);
  SELF.VINA_VP_POWER_STEERING_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_STEERING(r.power_steering);
  SELF.VINA_VP_POWER_BRAKES_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_BRAKES(r.power_brakes);
  SELF.VINA_VP_Power_Windows_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_WINDOWS(r.power_windows);
  SELF.VINA_VP_Tilt_Wheel_Desc := codes.VEHICLE_REGISTRATION.VP_Tilt_Wheel(r.tilt_wheel);
  SELF.VINA_VP_Roof_Desc := codes.VEHICLE_REGISTRATION.VP_ROOF(r.roof);
  SELF.VINA_VP_Optional_Roof1_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF1(r.optional_roof1);
  SELF.VINA_VP_Optional_Roof2_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF2(r.optional_roof2);
  SELF.VINA_VP_Radio_Desc := codes.VEHICLE_REGISTRATION.VP_RADIO(r.radio);
  SELF.VINA_VP_Optional_Radio1_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO1(r.optional_radio1);
  SELF.VINA_VP_Optional_Radio2_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO2(r.optional_radio2);
  SELF.VINA_VP_Transmission := r.transmission ;
  SELF.VINA_VP_Transmission_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.transmission);
  SELF.VINA_VP_Optional_Transmission1_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.optional_transmission1);
  SELF.VINA_VP_Optional_Transmission2_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.optional_transmission2);
  SELF.VINA_VP_Anti_Lock_Brakes_Desc := codes.VEHICLE_REGISTRATION.VP_ANTI_LOCK_BRAKES(r.anti_lock_brakes);
  // SELF.VINA_VP_Front_Wheel_Drive_Desc := IF(r.proactive_vin = 'N',IF(r.driving_wheels='F','Y','N'),'');//r. ;
  // SELF.VINA_VP_Four_Wheel_Drive_Desc := IF(r.vehicle_type = 'T',IF(r.wheels[2] = '8','Y','N'),IF(r.proactive_vin = 'N',IF(r.driving_wheels='4','Y','N'),''));//r. ;

  SELF.VINA_VP_Front_Wheel_Drive_Desc := codes.VEHICLE_REGISTRATION.VP_FRONT_WHEEL_DRIVE(IF(r.proactive_vin = 'N',IF(r.driving_wheels='F','Y','N'),''));
  SELF.VINA_VP_Four_Wheel_Drive_Desc := codes.VEHICLE_REGISTRATION.VP_FOUR_WHEEL_DRIVE(IF(r.vehicle_type = 'T',IF(r.wheels[2] = '8','Y','N'),IF(r.proactive_vin = 'N',IF(r.driving_wheels='4','Y','N'),'')));

  SELF.VINA_VP_Security_System_Desc := codes.VEHICLE_REGISTRATION.VP_SECURITY_SYSTEM(r.security_system);
  SELF.VINA_VP_Daytime_Running_Lights_Desc := codes.VEHICLE_REGISTRATION.VP_DAYTIME_RUNNING_LIGHTS(r.daytime_running_lights);
  SELF.VINA_Number_Of_Cylinders := r.cylinders ;
  SELF.VINA_Engine_Size := r.displacement; //r.engine_liter_information;
  SELF.Vina_fuel_code := r.fuel ;
  SELF.fuel_type_name := VehicleV2_Services.Polk_Code_Translations.fuel_desc(r.fuel) ;
  SELF.VINA_Price := '';//r. ;
  SELF.BASE_PRICE := r.base_list_price ;
  SELF.Orig_Net_Weight := r.base_shipping_weight ;
  SELF.Orig_Gross_Weight := '';//r. ;
  SELF.Orig_Number_Of_Axles :='';// r. ;
  SELF.Orig_Vehicle_Use_code := '';//r. ;
  SELF.Orig_Vehicle_Use_Desc := '';//r. ;
  SELF.model_year := IF(b_decoder,r.model_year,'');
  SELF:=[];
  END;
  //**************vina data end

// WARNING: If you find that data seems to be "dropped" from this query, then make sure that there
// are no entries in the first 8 positions that contain a '*' in the vina.key_vin file.
// If you find that an '*' exists in the first 8 positions, you need to change the macro
// call for that position from k to m and check the new code into the repository. (08/24/11)
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


RETURN vina_data;
END;
