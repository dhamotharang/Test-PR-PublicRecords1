IMPORT VehicleV2;

EXPORT Layout_Report_airbag_safety := RECORD
  VehicleV2.Layout_Base_Main.safety_type;
  VehicleV2.Layout_Base_Main.airbags;
  VehicleV2.Layout_Base_Main.tod_flag;
  VehicleV2.Layout_Base_Main.min_door_count;
  VehicleV2.Layout_Base_Main.airbag_driver;
  VehicleV2.Layout_Base_Main.airbag_front_driver_side;
  VehicleV2.Layout_Base_Main.airbag_front_head_curtain;
  VehicleV2.Layout_Base_Main.airbag_front_pass;
  VehicleV2.Layout_Base_Main.airbag_front_pass_side;
  STRING3 documenttypecode := '';
END;
