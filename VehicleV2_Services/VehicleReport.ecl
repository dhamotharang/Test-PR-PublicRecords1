IMPORT doxie_cbrs, doxie, VehicleV2_Services, STD;

EXPORT VehicleReport (IParam.reportParams aInputData) := FUNCTION
  
  //********* VIN
  vin_ds := DATASET([{aInputData.vin_in}],Layouts.Layout_Vehicle_VIN_New);
  by_vin := Raw.get_vehicle_keys_from_vin(aInputData, vin_ds);
  
  //********* DID
  did_ds := DATASET([{aInputData.didValue}],doxie.layout_references);
  by_did := Raw.get_vehicle_keys_from_dids(aInputData, did_ds);
  
  //********* BDID
  bdid_ds := DATASET([{aInputData.bdidValue}],doxie_cbrs.layout_references);
  by_bdid := Raw.get_vehicle_keys_from_bdids(aInputData, bdid_ds);
    
  //********* Vehicle + Iteration Key
  veh_key := DATASET([{aInputData.vehicleKey, aInputData.iterationKey,aInputData.sequenceKey}],
      Layout_Vehicle_Key);
  
  by_veh_key := IF(aInputData.sequenceKey='', Raw.get_vehicle_keys_from_vehkey(veh_key,,,aInputData.IncludeNonRegulatedSources),veh_key);
    
  raw_keys := IF(aInputData.vin_in <> '', by_vin)
            + IF(aInputData.vehicleKey <> '', by_veh_key)
            + IF(aInputData.didValue <> '', by_did)
            + IF(aInputData.bdidValue <> 0, by_bdid);

  SORT_keys := SORT(raw_keys, Vehicle_Key, -Iteration_Key);
     group_keys := GROUP(SORT_keys, Vehicle_key, Iteration_key);
  DEDUP_keys := DEDUP(group_keys, Vehicle_Key, Iteration_Key,sequence_key);

  veh_report_local := UNGROUP(Raw.get_vehicle_report(aInputData,DEDUP_keys));
  veh_report_RealTimeTmp:=VehicleV2_Services.Get_Polk_Vina_Data(vin_ds);
  veh_report_RealTime := PROJECT(veh_report_RealTimeTmp, Layout_Report);
  Report_Request:=TRIM(STD.STR.ToUpperCase(aInputData.DataSource));
  
  veh_report:=IF(Report_Request=constant.realtime_val,veh_report_RealTime,veh_report_local);
  //Bug 132024 - apply new sorting rules to results
  //RETURN sort(veh_report,-(unsigned1) is_current, -iteration_key, -sequence_key,record);
    RETURN SORT(veh_report, NonDMVSource,
                            -MAX( MAX(owners,(UNSIGNED4)ttl_latest_issue_date), MAX(registrants,(UNSIGNED4)reg_latest_effective_date),
                                  MAX(owners, IF((UNSIGNED4)src_last_date = 0, (UNSIGNED4)src_first_date, (UNSIGNED4)src_last_date))),
                            min_party_penalty,
                            Vehicle_Key);
END;
