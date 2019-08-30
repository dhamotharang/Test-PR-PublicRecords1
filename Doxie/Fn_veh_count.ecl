/*2009-09-03T23:40:14Z (Salini Pamidimukkala)
bug 43468 added dpa and dt filters
*/

import doxie,vehiclev2_services,vehiclev2,MDR,suppress;

export Fn_veh_count(
	unsigned6 DID_value,
  doxie.IDataAccess mod_access,
	boolean include_non_regulated_sources = false) := 
FUNCTION

	/* this change still leaves open the possibility that if the did has both lessor and non
	lessor records that we will count both. However, this is fine now since we also found
	only appears as a boolean to the accurint user. Additionally, I don't want to change
	the backwards compatible services to filter out lessors. */
  

	Vh_keys := LIMIT(VehicleV2.Key_Vehicle_DID(KEYED(append_did = did_value) and did_value<>0 and not is_minor),VehicleV2_Services.Constant.VEHICLE_PER_DID,skip);
	
	Party_dids := JOIN(vh_keys,VehicleV2.Key_Vehicle_Party_Key
	                  ,KEYED(LEFT.Vehicle_key = RIGHT.Vehicle_Key)
	                   and KEYED(LEFT.iteration_key = RIGHT.iteration_key)
	                   and KEYED(LEFT.sequence_key = RIGHT.sequence_key)
										 and RIGHT.orig_name_type <> '2'
										 and (include_non_regulated_sources or right.source_code not in [MDR.sourceTools.src_infutor_veh,MDR.sourceTools.src_infutor_motorcycle_veh])									 
										 ,limit(VehicleV2_Services.Constant.PARTIES_PER_VEHICLE,skip));
	cleaned_dppa_dids := Party_dids(mod_access.IsValidDppaState(state_origin,, source_code));
	cleaned_dt_dids := cleaned_dppa_dids(mod_access.date_threshold = 0 or date_first_seen <= mod_access.date_threshold);
	//ln_braded is only for owner records and probation_override_value is not used anywhere
	suppressed_dids := suppress.MAC_SuppressSource(cleaned_dt_dids,mod_access,append_did);
  
	cnt := if(~mod_access.isConsumer(), count(suppressed_dids(history = '' and orig_name_type in ['4','5'])), 0);

	return cnt;

END;