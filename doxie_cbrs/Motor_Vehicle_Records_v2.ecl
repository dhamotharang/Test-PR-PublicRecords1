import vehiclev2_services;
doxie_cbrs.MAC_Selection_Declare()

export Motor_Vehicle_records_v2(dataset(doxie_cbrs.layout_references) bdids) := module
  
  shared report_mod := vehiclev2_services.IParam.getReportModule();
	report_view_tmp := if(VehicleVersion in [0,2],vehiclev2_services.raw.get_vehicle_report(
		report_mod, group(sort(vehiclev2_services.raw.get_vehicle_keys_from_bdids(report_mod, bdids), Vehicle_key, Iteration_key), Vehicle_key, Iteration_key)));

  export report_view(unsigned in_limit = 0) := topn(ungroup(report_view_tmp), in_limit, Vehicle_key, Iteration_key); 
	
  source_view_tmp := if(VehicleVersion in [0,2],vehiclev2_services.raw.get_vehicle_report(
		report_mod, group(sort(vehiclev2_services.raw.get_vehicle_keys_from_bdids(report_mod, bdids), Vehicle_key, Iteration_key), Vehicle_key, Iteration_key)));
	
	export source_view(unsigned in_limit = 0) := topn(ungroup(source_view_tmp), in_limit, Vehicle_key, Iteration_key);
	
	export report_count(boolean in_display) := count(vehiclev2_services.raw.get_vehicle_keys_from_bdids(report_mod, bdids)(in_display and VehicleVersion in [0,2]));
end;
