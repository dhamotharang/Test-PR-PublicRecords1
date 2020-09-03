import doxie_raw, vehiclev2_services, doxie;

export veh_legacy_raw(
    dataset(vehiclev2_services.layout_vehicle_key) vids,
    doxie.IDataAccess mod_access,
    boolean IncludeNonRegulatedVehicleSources = false
) := FUNCTION

  // Mimic what Veh_Raw_Batch does;
  // re-using the intricate V2-to-V1 transform code,
  // and less impact than modifying the Veh_Raw_Batch interface to take Vehicle keys

  doxie_raw.layout_VehRawBatchInput.input_w_keys xt(vehiclev2_services.layout_vehicle_key l) := TRANSFORM
    SELF := l;
    SELF := [];
  END;

  vids2 := project(vids, xt(LEFT));
  vids3 := group(sort(vids2, vehicle_key, iteration_key, sequence_key), vehicle_key, iteration_key, sequence_key);
  veh := vehiclev2_services.Fn_Find(vids3,mod_access,TRUE,,,,IncludeNonRegulatedVehicleSources);
  veh_s := sort(ungroup(veh), history_name,history, record);
  veh_d := dedup(veh_s, whole record);
  vehs_out := project(veh_d, Doxie.Layout_VehicleSearch);

  RETURN vehs_out;

END;
