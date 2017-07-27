import VehicleV2;

export Layout_Report_Plate := record

	VehicleV2.Layout_Base_Party.Reg_True_License_Plate;      // true license plate
	VehicleV2.Layout_Base_Party.Reg_License_Plate;           // true license plate
	VehicleV2.Layout_Base_Party.Reg_License_Plate_Type_Code;
	VehicleV2.Layout_Base_Party.Reg_License_Plate_Type_Desc;
	VehicleV2.Layout_Base_Party.Reg_License_State;
	VehicleV2.Layout_Base_Party.Reg_Previous_License_Plate;
	VehicleV2.Layout_Base_Party.Reg_Previous_License_State;
	
end;