IMPORT doxie, doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

EXPORT motor_vehicle_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids,
                                     doxie.IDataAccess mod_access) := 
	CHOOSEN(doxie_cbrs.motor_vehicle_records_prs(bdids,mod_access)(Return_motorVehicle_val), Max_motorVehicle_val);