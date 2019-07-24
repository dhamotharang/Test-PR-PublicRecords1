import vehiclev2_services, doxie;

export VehV2_raw(
    dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
    dataset(vehiclev2_services.layout_vehicle_key) vids = dataset([], vehiclev2_services.layout_vehicle_key),
    string6 ssn_mask_value = 'NONE',
    unsigned3 dateVal = 0
) := FUNCTION

  report_mod := VehicleV2_Services.IParam.getReportModule();
  in_mod := module (report_mod)
    export boolean excludeLessors := FALSE;
  end;
  bydid := VehicleV2_services.Raw.get_Vehicle_keys_from_dids(in_mod, dids);      


  veh_ids := project(bydid,transform(VehicleV2_Services.layout_vehicle_key,
                                     self.is_deep_dive :=TRUE,self :=left));



  sort_keys := dedup(sort(veh_ids + vids, Vehicle_Key, Iteration_Key, sequence_key),
                                          vehicle_key, iteration_key, sequence_key);
  
  group_keys := group(sort_keys, Vehicle_key, Iteration_key);

  vehs := ungroup(vehiclev2_services.raw.get_vehicle_report(report_mod, group_keys));

  RETURN sort(vehs,-(unsigned1) is_current, -iteration_key, -sequence_key,record);

END;
