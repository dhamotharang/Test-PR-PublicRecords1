IMPORT iesp, doxie, VehicleV2_Services;

EXPORT  vehicle_records (
  dataset (doxie.layout_references) dids,
  input.vehicles in_params = module (input.vehicles) end,
  boolean IsFCRA = false
) := MODULE

  shared vehi := VehicleV2_Services.Vehicle_raw.get_vehicle_crs_report (dids, in_params.ssn_mask) 
  (~in_params.Use_CurrentlyOwnedVehicles or is_current); 

  // iesp.motorvehicle.t_MVReportRecord
  export vehicles := if (~IsFCRA, iesp.transform_vehicles (vehi));

  // iesp.motorvehicle.t_MotorVehicleReport2Record
  export vehicles_v2 := if (~IsFCRA, iesp.transform_vehiclesV2 (vehi));
END;
