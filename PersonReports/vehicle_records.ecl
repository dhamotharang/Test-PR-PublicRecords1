IMPORT iesp, doxie, VehicleV2_Services;

EXPORT  vehicle_records (
  dataset (doxie.layout_references) dids,
  $.IParam.vehicles in_params = module ($.IParam.vehicles) end,
  boolean IsFCRA = false
) := MODULE

  isCNSMR := in_params.isConsumer();

  report_mod := VehicleV2_Services.IParam.getReportModule();
  vehicle_crs_report := if(~isCNSMR, VehicleV2_Services.raw.get_vehicle_crs_report(report_mod, dids));

  shared vehi := vehicle_crs_report(~in_params.Use_CurrentlyOwnedVehicles or is_current);


  // iesp.motorvehicle.t_MVReportRecord
  export vehicles := if (~IsFCRA, iesp.transform_vehicles (vehi));

  // iesp.motorvehicle.t_MotorVehicleReport2Record
  export vehicles_v2 := if (~IsFCRA, iesp.transform_vehiclesV2 (vehi));
END;
