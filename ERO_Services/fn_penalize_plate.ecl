import ERO_Services,ut, VehicleV2, VehicleV2_Services;
EXPORT fn_penalize_plate(ERO_Services.Layouts.layout_extra_penalty input_rec, 
													integer penalty2use = ERO_Services.Constants.Defaults.PLATEPENALTY) := FUNCTION
 	//look up all vehicle_key's for DID
	//look up all vheicle_key's for input PLATE and STATE, state doesn't have to match if blank.
	//if the same vehicle_key is in both lists then VehFound = TRUE
		didrecs := LIMIT(VehicleV2.Key_Vehicle_DID(keyed(append_did= input_rec.did)),ut.Limits.Default); // if desired the limit might be increased to 20000 which will cover all dids except 118 records
		plateRecs := IF (input_rec.veh_plate <>'', 
										LIMIT(VehicleV2.Key_Vehicle_Lic_plate(KEYED(license_plate = input_rec.VEH_Plate 
																																AND Ut.NNEQ(state_origin,input_rec.VEH_State))),
													VehicleV2_Services.Constant.VEHICLE_PER_LIC_PLATE, SKIP));
		VEH_KEY_REC := RECORD
		  string30 Vehicle_Key;
		END;

		didkeys :=DEDUP(SORT(PROJECT(didrecs,TRANSFORM(VEH_KEY_REC, SELF := LEFT)),Vehicle_Key),Vehicle_Key);
		platekeys:=DEDUP(SORT(PROJECT(platerecs,TRANSFORM(VEH_KEY_REC, SELF := LEFT)),Vehicle_Key),Vehicle_Key);

		vehFound := EXISTS(JOIN(didkeys,platekeys, LEFT.Vehicle_Key = RIGHT.Vehicle_Key,
														KEEP(1), LIMIT(0)));
    penalty := if (vehFound, 0, penalty2use);													   
		return penalty;																	
end;													