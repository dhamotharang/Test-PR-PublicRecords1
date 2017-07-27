import vehiclev2_services;
  
export VehicleV2_Services.Layout_Report 
	vehicleV2_search_records_crs(
		dataset(doxie.layout_references) in_dids, 
		boolean currentlyOwnedVehicles = false) := 
function
	all_veh := vehiclev2_services.Vehicle_raw.get_vehicle_crs_report (in_dids);
	return all_veh(~currentlyOwnedVehicles or is_current);
end;
