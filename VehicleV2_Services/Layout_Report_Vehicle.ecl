IMPORT VehicleV2;

EXPORT Layout_Report_Vehicle := RECORD

  VehicleV2.Layout_Base_Main.Vehicle_Key;
  VehicleV2.Layout_Base_Main.Iteration_Key;
  BOOLEAN is_deep_dive;
  STRING matchCode;
  VehicleV2.Layout_Base_Main.Source_Code;
  VehicleV2.Layout_Base_Main.State_Origin;
  STRING25 state_origin_decoded;
  STRING25 vin;
  STRING4 model_year;
  STRING36 make_desc;
  STRING40 vehicle_type_desc;
  STRING25 series_desc;
  STRING36 model_desc;
  STRING25 body_style_desc;
  STRING15 major_color_desc; // major color description
  STRING15 minor_color_desc;
  // odometer mileage (no field)
  // net weight (no field)
  // number of axles (no field)
  
  // -------------------------- from mapping append -------------------------------
  VehicleV2.Layout_Base_Main.VINA_VP_Year;
  VehicleV2.Layout_Base_Main.VINA_VP_Series;
  VehicleV2.Layout_Base_Main.VINA_VP_Series_Name;
  VehicleV2.Layout_Base_Main.VINA_VP_Model;
  STRING120 VINA_VP_RESTRAINT_Desc;
  STRING20 VINA_VP_AIR_CONDITIONING_Desc;
  STRING20 VINA_VP_POWER_STEERING_Desc;
  STRING20 VINA_VP_POWER_BRAKES_Desc;
  STRING20 VINA_VP_Power_Windows_Desc;
  STRING20 VINA_VP_Tilt_Wheel_Desc;
  STRING30 VINA_VP_Roof_Desc;
  STRING30 VINA_VP_Optional_Roof1_Desc;
  STRING30 VINA_VP_Optional_Roof2_Desc;
  STRING20 VINA_VP_Radio_Desc;
  STRING20 VINA_VP_Optional_Radio1_Desc;
  STRING20 VINA_VP_Optional_Radio2_Desc;
  VehicleV2.Layout_Base_Main.VINA_VP_Transmission;
  STRING40 VINA_VP_Transmission_Desc;
  STRING40 VINA_VP_Optional_Transmission1_Desc;
  STRING40 VINA_VP_Optional_Transmission2_Desc;
  STRING40 VINA_VP_Anti_Lock_Brakes_Desc;
  STRING30 VINA_VP_Front_Wheel_Drive_Desc;
  STRING30 VINA_VP_Four_Wheel_Drive_Desc;
  STRING50 VINA_VP_Security_System_Desc;
  STRING20 VINA_VP_Daytime_Running_Lights_Desc;
  VehicleV2.Layout_Base_Main.VINA_Number_Of_Cylinders;
  VehicleV2.Layout_Base_Main.VINA_Engine_Size;
  VehicleV2.Layout_Base_Main.Vina_fuel_code;
  STRING60 fuel_type_name;
  VehicleV2.Layout_Base_Main.VINA_Price;
  STRING6 BASE_PRICE;
  VehicleV2.Layout_Base_Main.Orig_Net_Weight;
  VehicleV2.Layout_Base_Main.Orig_Gross_Weight;
  VehicleV2.Layout_Base_Main.Orig_Number_Of_Axles;
  VehicleV2.Layout_Base_Main.Orig_Vehicle_Use_code;
  VehicleV2.Layout_Base_Main.Orig_Vehicle_Use_Desc;
  DATASET({Layout_Vehicle_Key.Sequence_Key}) Target_Sequence_Keys {MAXCOUNT(30)};
  DATASET(VehicleV2_Services.asSORTed_layouts.layout_brand) brands {MAXCOUNT(Constant.MAX_BRANDS_PER_VEHICLE)};
  STRING1 TOD_flag;

END;
