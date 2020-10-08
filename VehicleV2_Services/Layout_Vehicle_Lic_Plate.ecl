EXPORT Layout_Vehicle_Lic_Plate := RECORD
  STRING10 lic_plate; // NOTE: This must match field length in VehicleV2.key_vehicle_lic_plate and VehicleV2.key_vehicle_reverse_lic_plate
  STRING2 state_origin :='';
  STRING20 fname;
  STRING20 lname;
END;
