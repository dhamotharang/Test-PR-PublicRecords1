IMPORT Drivers, VehicleV2, RiskWise, ut, MDR;

EXPORT getVehicles(DATASET(ProfileBooster.Layouts.Layout_PB_Slim) PBslim, boolean onThor) := FUNCTION

kvd := VehicleV2.key_vehicle_did;
 
ProfileBooster.Layouts.Layout_PB_Slim_vehicles getVehKey(PBslim le, kvd ri) := TRANSFORM
	self.vehicle_key := ri.vehicle_key;
	self.iteration_key := ri.iteration_key;
	self.sequence_key := ri.sequence_key;
	SELF := le;
	self := [];
END;
  
vehRecs_roxie :=  join(PBslim, kvd,
												 keyed(left.did2 = right.append_did),
												 getVehKey(left,right),
												 atmost(left.did2 = right.append_did, riskwise.max_atmost));

vehRecs_thor :=  join(distribute(PBslim, did2), 
											distribute(pull(kvd), append_did),
												 left.did2 = right.append_did,
												 getVehKey(left,right),
												 atmost(left.did2 = right.append_did, riskwise.max_atmost),
												 local);

vehRecs := if(onThor, vehRecs_thor, vehRecs_roxie);												 
												 
vehPartyKey := VehicleV2.Key_Vehicle_Party_Key;
											
ProfileBooster.Layouts.Layout_PB_Slim_vehicles  add_party(vehRecs le, vehPartyKey ri) := TRANSFORM
	// self.totalCount		 		:= if(ri.Sequence_Key<>'' AND ri.history='', 1, 0); 
	self.totalCount		 		:= if(ri.Sequence_Key<>'', 1, 0); 
  src_first_date    		:= if((integer)ri.src_first_date <> 0, ri.src_first_date, (string)ri.date_first_seen);
	monthsAgo 						:= ut.MonthsApart((STRING6)le.historyDate,(string6)src_first_date);
	self.months_first_reg := monthsAgo;
	self.months_last_reg  := monthsAgo;		
	self.state_origin := le.state_origin;
	self := le;
END;

vehPartyRecs_roxie :=  join(vehRecs, vehPartyKey,
											keyed(LEFT.vehicle_key=RIGHT.vehicle_key) AND 
											keyed(left.iteration_key=right.iteration_key) and
											keyed(left.sequence_key=right.sequence_key) and
											right.source_code in MDR.sourceTools.set_Marketing_Veh and
										(((integer) RIGHT.src_first_date <> 0 and (integer)RIGHT.src_first_date [1..6] < (integer) left.historydate) or
										(RIGHT.date_first_seen <> 0 and RIGHT.date_first_seen < (integer)left.historydate)),
											add_party(LEFT,RIGHT), atmost(riskwise.max_atmost));		
											

vehPartyRecs_thor :=  join(distribute(vehRecs, hash64(vehicle_key, iteration_key, sequence_key)), 
													 distribute(pull(vehPartyKey), hash64(vehicle_key, iteration_key, sequence_key)),
											LEFT.vehicle_key=RIGHT.vehicle_key AND 
											left.iteration_key=right.iteration_key and
											left.sequence_key=right.sequence_key and
											right.source_code in MDR.sourceTools.set_Marketing_Veh and
											(((integer) RIGHT.src_first_date <> 0 and (integer)RIGHT.src_first_date [1..6] < (integer) left.historydate) or
											(RIGHT.date_first_seen <> 0 and RIGHT.date_first_seen < (integer)left.historydate)),
											add_party(LEFT,RIGHT),
											local);	

vehPartyRecs := if(onThor, vehPartyRecs_thor, vehPartyRecs_roxie);
											
ProfileBooster.Layouts.Layout_PB_Slim_vehicles add_Vehicles_main(vehPartyRecs le, VehicleV2.Key_Vehicle_Main_Key ri) := TRANSFORM
	gotMain := ri.vehicle_key <> '';
	SELF.year_make := if(gotMain, ri.Best_Model_Year, '');
	SELF.make := if(gotMain, ri.Best_Make_Code, '');
	SELF.model := if(gotMain, ri.Best_Model_Code, '');
	SELF.vin := if(gotMain, ri.orig_vin, '');
	SELF.vina_veh_type := if(gotMain, ri.vina_veh_type, '');
	SELF.vehicleCount := if(gotMain and le.totalcount > 0, if(ri.vina_veh_type <> 'M', 1, 0), 0);
	SELF.motorcycleCount := if(gotMain and le.totalcount > 0, if(ri.vina_veh_type = 'M', 1, 0), 0);
	SELF := le;
END;

vehMainRecs_roxie := JOIN(vehPartyRecs, VehicleV2.Key_Vehicle_Main_Key,
										keyed(LEFT.vehicle_key=RIGHT.vehicle_key) AND 
										keyed(left.iteration_key=right.iteration_key) and right.orig_vin<>'',
										add_Vehicles_main(LEFT,RIGHT), atmost(riskwise.max_atmost));

vehMainRecs_thor := JOIN(distribute(vehPartyRecs, hash64(vehicle_key, iteration_key)), 
										distribute(pull(VehicleV2.Key_Vehicle_Main_Key(orig_vin<>'')), hash64(vehicle_key, iteration_key)),
										LEFT.vehicle_key=RIGHT.vehicle_key AND 
										left.iteration_key=right.iteration_key,
										add_Vehicles_main(LEFT,RIGHT), atmost(riskwise.max_atmost),
										local);
										
vehMainRecs := if(onThor, vehMainRecs_thor, vehMainRecs_roxie);
																	

ProfileBooster.Layouts.Layout_PB_Slim_vehicles rollVins(vehMainRecs le, vehMainRecs ri) := TRANSFORM
	self.months_first_reg	:= max(le.months_first_reg, ri.months_first_reg);	//save oldest registration
	self.months_last_reg	:= min(le.months_last_reg, ri.months_last_reg);	  //save newest registration
	self								 	:= le;
END;

// first rollup by vin to get the earliest first and latest last registration and to avoid inflating the vehicleCount and motorcycleCount in the next rollup
vehDedup :=  rollup(sort(vehMainRecs, seq, did2, vin, -months_first_reg, -months_last_reg), 
										 left.seq = right.seq and left.did2 = right.did2 and left.vin=right.vin,
										 rollVins(left, right));
										 
ProfileBooster.Layouts.Layout_PB_Slim_vehicles rollVehicles(vehDedup le, vehDedup ri) := TRANSFORM
	self.vehicleCount 	  := le.vehicleCount + ri.vehicleCount;	
	self.motorcycleCount 	:= le.motorcycleCount + ri.motorcycleCount;	
	self.months_first_reg	:= max(le.months_first_reg, ri.months_first_reg);	//save oldest registration
	self.months_last_reg	:= min(le.months_last_reg, ri.months_last_reg);	  //save newest registration
	self								 	:= le;
END;

RolledVeh :=  rollup(vehDedup, left.seq = right.seq and left.did2 = right.did2,
										 rollVehicles(left, right));
										
// output(PBslim, named('PBslim'));
// output(vehRecs, named('vehRecs'));
// output(vehPartyRecs, named('vehPartyRecs'));
// output(vehMainRecs, named('vehMainRecs'));
// output(vehDedup, named('vehDedup'));
// output(RolledVeh, named('RolledVeh'));

RETURN RolledVeh;

END;										