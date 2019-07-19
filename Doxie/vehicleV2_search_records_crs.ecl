import vehiclev2_services;
  
export VehicleV2_Services.Layout_Report 
	vehicleV2_search_records_crs(
		dataset(doxie.layout_references) in_dids, 
		boolean currentlyOwnedVehicles = false) := 
function
  report_mod := VehicleV2_Services.IParam.getReportModule();  

	all_veh := vehiclev2_services.raw.get_vehicle_crs_report (report_mod, in_dids);
	return all_veh(~currentlyOwnedVehicles or is_current);
end;
