import doxie_cbrs, doxie, VehicleV2_Services;

export VehicleReport (IParam.reportParams aInputData) := FUNCTION
	
	//********* VIN
	vin_ds := dataset([{aInputData.vin_in}],Layouts.Layout_Vehicle_VIN_New);
	by_vin := Raw.get_vehicle_keys_from_vin(aInputData, vin_ds);
	
	//********* DID
	did_ds  := dataset([{aInputData.didValue}],doxie.layout_references);
	by_did := Raw.get_vehicle_keys_from_dids(aInputData, did_ds);
	
	//********* BDID
	bdid_ds := dataset([{aInputData.bdidValue}],doxie_cbrs.layout_references);
	by_bdid := Raw.get_vehicle_keys_from_bdids(aInputData, bdid_ds);
		
	//********* Vehicle + Iteration Key
	veh_key := dataset([{aInputData.vehicleKey, aInputData.iterationKey,aInputData.sequenceKey}],
			Layout_Vehicle_Key);
	
	by_veh_key := if(aInputData.sequenceKey='', Raw.get_vehicle_keys_from_vehkey(veh_key,,,aInputData.IncludeNonRegulatedSources),veh_key);
		
	raw_keys := if(aInputData.vin_in <> '', by_vin) 
						+ if(aInputData.vehicleKey <> '', by_veh_key)
						+ if(aInputData.didValue <> '', by_did)
						+ if(aInputData.bdidValue <> 0, by_bdid);

	sort_keys := sort(raw_keys, Vehicle_Key, -Iteration_Key);
     group_keys := group(sort_keys, Vehicle_key, Iteration_key);
	dedup_keys := dedup(group_keys, Vehicle_Key, Iteration_Key,sequence_key);

	veh_report_local := ungroup(Raw.get_vehicle_report(aInputData,dedup_keys));
	veh_report_RealTimeTmp:=VehicleV2_Services.Get_Polk_Vina_Data(vin_ds);
	veh_report_RealTime := project(veh_report_RealTimeTmp, Layout_Report);
	Report_Request:=trim(stringlib.stringtouppercase(aInputData.DataSource));
	
	veh_report:=if(Report_Request=constant.realtime_val,veh_report_RealTime,veh_report_local);
	//Bug 132024 - apply new sorting rules to results
	//RETURN sort(veh_report,-(unsigned1) is_current, -iteration_key, -sequence_key,record);
		RETURN sort(veh_report, NonDMVSource,
														-MAX( MAX(owners,(unsigned4)ttl_latest_issue_date), MAX(registrants,(unsigned4)reg_latest_effective_date),
																	MAX(owners, if((unsigned4)src_last_date = 0, (unsigned4)src_first_date, (unsigned4)src_last_date))), 
														min_party_penalty, 
														Vehicle_Key);
END;