export Layout_Vehicle_Lic_Plate := record
	string10 lic_plate; // NOTE: This must match field length in VehicleV2.key_vehicle_lic_plate and VehicleV2.key_vehicle_reverse_lic_plate
	string2 state_origin :='';
	string20 fname;
	string20 lname;
end;