import VehicleV2;

export Layout_Report_Vehicle := RECORD

	VehicleV2.Layout_Base_Main.Vehicle_Key;
	VehicleV2.Layout_Base_Main.Iteration_Key;	
	boolean is_deep_dive;
	string matchCode;
	VehicleV2.Layout_Base_Main.Source_Code;
	VehicleV2.Layout_Base_Main.State_Origin;
	string25 state_origin_decoded;
  string25 vin;
	string4 model_year; 
	string36 make_desc;	
	string40 vehicle_type_desc;
	string25 series_desc;
	string36 model_desc;
	string25 body_style_desc;
	string15 major_color_desc;                    // major color description
	string15 minor_color_desc;
	// odometer mileage (no field)
	// net weight (no field)
	// number of axles (no field)
	
	// -------------------------- from mapping append -------------------------------
	VehicleV2.Layout_Base_Main.VINA_VP_Year;
	VehicleV2.Layout_Base_Main.VINA_VP_Series;
	VehicleV2.Layout_Base_Main.VINA_VP_Series_Name;
	VehicleV2.Layout_Base_Main.VINA_VP_Model;
	string120 VINA_VP_RESTRAINT_Desc;
	string20 VINA_VP_AIR_CONDITIONING_Desc;
	string20 VINA_VP_POWER_STEERING_Desc;
	string20 VINA_VP_POWER_BRAKES_Desc;
	string20 VINA_VP_Power_Windows_Desc;
	string20 VINA_VP_Tilt_Wheel_Desc;
	string30 VINA_VP_Roof_Desc;
	string30 VINA_VP_Optional_Roof1_Desc;
	string30 VINA_VP_Optional_Roof2_Desc;
	string20 VINA_VP_Radio_Desc;
	string20 VINA_VP_Optional_Radio1_Desc;
	string20 VINA_VP_Optional_Radio2_Desc;
	VehicleV2.Layout_Base_Main.VINA_VP_Transmission;
	string40 VINA_VP_Transmission_Desc;
	string40 VINA_VP_Optional_Transmission1_Desc;
	string40 VINA_VP_Optional_Transmission2_Desc;
	string40 VINA_VP_Anti_Lock_Brakes_Desc;
	string30 VINA_VP_Front_Wheel_Drive_Desc;
	string30 VINA_VP_Four_Wheel_Drive_Desc;
	string50 VINA_VP_Security_System_Desc;
	string20 VINA_VP_Daytime_Running_Lights_Desc;
	VehicleV2.Layout_Base_Main.VINA_Number_Of_Cylinders;
	VehicleV2.Layout_Base_Main.VINA_Engine_Size;
	VehicleV2.Layout_Base_Main.Vina_fuel_code;
	string60 fuel_type_name;
	VehicleV2.Layout_Base_Main.VINA_Price;
	string6 BASE_PRICE;
	VehicleV2.Layout_Base_Main.Orig_Net_Weight;
	VehicleV2.Layout_Base_Main.Orig_Gross_Weight;
	VehicleV2.Layout_Base_Main.Orig_Number_Of_Axles;
	VehicleV2.Layout_Base_Main.Orig_Vehicle_Use_code;
	VehicleV2.Layout_Base_Main.Orig_Vehicle_Use_Desc;	
	DATASET({Layout_Vehicle_Key.Sequence_Key}) Target_Sequence_Keys {MAXCOUNT(30)};
	dataset(VehicleV2_Services.assorted_layouts.layout_brand) brands {maxcount(Constant.MAX_BRANDS_PER_VEHICLE)};
	string1 TOD_flag;

END;
