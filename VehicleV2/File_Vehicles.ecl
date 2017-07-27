import ut, vehlic;

file_vehicles_V1 := VehLic.File_Base_Vehicles_Prod;

file_filter := file_vehicles_V1((source_code in ['AE'] and orig_state in ['AL','CT','DE','MD','OK','OR','SC']) or (source_code in ['DI'] and ~ orig_state in ['NC']));

//valid VIN by join with VINA 
VehicleV2.Mac_validVIN(VehicleV2.Layout_temp_module.Layout_vehiclesV2_slim, file_filter, validvin_out)

export File_Vehicles := validvin_out : persist('~thor_data400::persist::vehiclesV2_slim');
