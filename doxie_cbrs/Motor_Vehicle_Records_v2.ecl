IMPORT vehiclev2_services;
doxie_cbrs.MAC_Selection_Declare()

EXPORT Motor_Vehicle_records_v2(DATASET(doxie_cbrs.layout_references) bdids) := MODULE
  
  SHARED report_mod := vehiclev2_services.IParam.getReportModule();
  report_view_tmp := IF(VehicleVersion IN [0,2],
    vehiclev2_services.raw.get_vehicle_report(
      report_mod, 
      GROUP(SORT(vehiclev2_services.raw.get_vehicle_keys_from_bdids(report_mod, bdids), Vehicle_key, Iteration_key), 
        Vehicle_key, Iteration_key)
    ));

  EXPORT report_view(UNSIGNED in_limit = 0) := TOPN(UNGROUP(report_view_tmp), in_limit, Vehicle_key, Iteration_key);
  
  source_view_tmp := IF(VehicleVersion IN [0,2],
    vehiclev2_services.raw.get_vehicle_report(
      report_mod, 
      GROUP(SORT(vehiclev2_services.raw.get_vehicle_keys_from_bdids(report_mod, bdids), Vehicle_key, Iteration_key), 
        Vehicle_key, Iteration_key)
    ));
  
  EXPORT source_view(UNSIGNED in_limit = 0) := TOPN(UNGROUP(source_view_tmp), in_limit, Vehicle_key, Iteration_key);
  
  EXPORT report_count(BOOLEAN in_display) := COUNT(vehiclev2_services.raw.get_vehicle_keys_from_bdids(report_mod, bdids)
    (in_display AND VehicleVersion IN [0,2])
  );
END;
