doxie_cbrs.mac_Selection_Declare()
export motor_vehicle_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := 
	choosen(doxie_cbrs.motor_vehicle_records_prs(bdids)(Return_motorVehicle_val), Max_motorVehicle_val);