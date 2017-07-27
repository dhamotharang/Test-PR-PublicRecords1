import vehiclev2_services,doxie,doxie_cbrs;
export VehV2_raw(
    dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
    dataset(Doxie.Layout_ref_bdid) bdids = doxie_raw.ds_EmptyBDIDs,
		dataset(vehiclev2_services.layout_vehicle_key) vids = dataset([], vehiclev2_services.layout_vehicle_key),
    string6 ssn_mask_value = 'NONE',
    unsigned3 dateVal = 0
) := FUNCTION

bydid :=VehicleV2_services.Vehicle_raw.get_Vehicle_keys_from_dids(dids);
bybdid := VehicleV2_services.Vehicle_raw.get_Vehicle_keys_from_bdids(project(bdids,doxie_cbrs.layout_references));

veh_ids := project(bydid+bybdid,transform(VehicleV2_Services.layout_vehicle_key,
                                          self.is_deep_dive :=TRUE,self :=left));



	sort_keys := dedup(sort(veh_ids + vids, Vehicle_Key, Iteration_Key, sequence_key),
		vehicle_key,iteration_key,sequence_key);
  
	group_keys := group(sort_keys, Vehicle_key, Iteration_key);

	vehs := ungroup(vehiclev2_services.Vehicle_raw.get_vehicle_report(group_keys));

	RETURN sort(vehs,-(unsigned1) is_current, -iteration_key, -sequence_key,record);

END;