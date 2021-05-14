import doxie_files,drivers, VehicleV2, riskwise, doxie, _control;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Vehicles_Hist (GROUPED DATASET(Layout_Boca_Shell_ids) ids1,
                                 unsigned1 dppa, boolean dppa_ok,
																 boolean includeRel, unsigned1 BSversion, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
																 
kvd := VehicleV2.key_vehicle_did;

// for batch queries, dedup the input to reduce searching
ids := dedup(sort(ungroup(ids1), 
	did, historydate, seq),
	did, historydate)(did<>0);
	
vehrec := Layout_Vehicles.vehrec;

vehrecAddl := RECORD
	Layout_Boca_Shell_ids;
	Layout_Vehicles.Vehicle_SetAddl;
	unsigned1 relative_owned_count;
	unsigned1 current_count_indiv;
	unsigned1 historical_count_indiv;
END;
vtemp := record
	vehrec - layout_overrides;
	kvd.Vehicle_Key;
	kvd.Iteration_Key;
	kvd.Sequence_Key;
end;
vtemp2 := record
	vehrec - layout_overrides;
	kvd.Vehicle_Key;
	kvd.Iteration_Key;
	kvd.Sequence_Key;
	string2	Source_Code;
	string2	orig_state;	
	unsigned1 Rel_current_count;
end;
// get the vehicle keys by the did
vtemp add_Vehicle_num(ids le, kvd ri) := TRANSFORM
	self.vehicle_key := ri.vehicle_key;
	self.iteration_key := ri.iteration_key;
	self.sequence_key := ri.sequence_key;
	SELF := le;
	SELF := [];
END;

f := if(includeRel and bsVersion>1, ids, ids(~isrelat));

vehicles_idd_roxie := JOIN(f, kvd, 
                           left.did!=0 and 
                           keyed(LEFT.did=RIGHT.append_did),
                           add_Vehicle_num(LEFT,RIGHT),atmost(5000),KEEP(100));

vehicles_idd_thor := JOIN(DISTRIBUTE(f(did <> 0), HASH64(did)), 
                          DISTRIBUTE(PULL(kvd), HASH64(append_did)), 
                          LEFT.did = RIGHT.append_did,
                          add_Vehicle_num(LEFT,RIGHT),atmost(5000),KEEP(100), LOCAL);

#IF(onThor)
	vehicles_idd_correct := vehicles_idd_thor;
#ELSE
	vehicles_idd_correct := vehicles_idd_roxie;
#END

vtemp2 add_party(vehicles_idd_correct le, VehicleV2.Key_Vehicle_Party_Key R) := transform
	SELF.current_count := (INTEGER) (r.Sequence_Key<>'' AND r.history='');
	SELF.historical_count := (INTEGER) (r.Sequence_Key<>'' AND r.history='H');	
	SELF.Rel_current_count := if(r.Sequence_Key<>'' AND r.history='', (INTEGER) (r.Sequence_Key<>'' AND r.history=''), 0);
	self.orig_state := r.orig_state;
	self.source_code := r.source_code;
	SELF := le;
	self := [];
end;

vehicles_party_roxie := JOIN(vehicles_idd_correct, VehicleV2.Key_Vehicle_Party_Key,
                            keyed(LEFT.vehicle_key=RIGHT.vehicle_key) AND 
                            keyed(left.iteration_key=right.iteration_key) and
                            keyed(left.sequence_key=right.sequence_key) AND
                            RIGHT.date_first_seen < left.historydate,
                            add_party(LEFT,RIGHT), atmost(riskwise.max_atmost));
            
vehicles_party_thor := JOIN(DISTRIBUTE(vehicles_idd_correct, HASH64(vehicle_key, iteration_key, sequence_key)),
                            DISTRIBUTE(PULL(VehicleV2.Key_Vehicle_Party_Key), HASH64(vehicle_key, iteration_key, sequence_key)),
                            LEFT.vehicle_key=RIGHT.vehicle_key AND 
                            LEFT.iteration_key=right.iteration_key and
                            LEFT.sequence_key=right.sequence_key AND
                            RIGHT.date_first_seen < LEFT.historydate,
                            add_party(LEFT,RIGHT), 
                            atmost(LEFT.vehicle_key=RIGHT.vehicle_key, riskwise.max_atmost), LOCAL);
                            
#IF(onThor)
	vehicles_party_correct := vehicles_party_thor;
#ELSE
	vehicles_party_correct := vehicles_party_roxie;
#END
						

vehrecAddl add_Vehicles_main(vehicles_party_correct le, VehicleV2.Key_Vehicle_Main_Key ri) := TRANSFORM
	//Include relatives here since for batch transactions with two relatives in the same batch, we may dedup the non-relative record
	//We will filter relatives out of historical_count in vehicles_appended_to_did
	self.historical_count := le.current_count + le.historical_count;  // if it's current, also ding the historical counter.
	self.historical_count_indiv := if(~le.isrelat, le.current_count + le.historical_count, 0);
	self.current_count_indiv := if(~le.isrelat, le.current_count, 0);
	SELF.Vehicle1.year_make := (INTEGER)ri.Best_Model_Year;
	SELF.Vehicle1.make := ri.Best_Make_Code;
	SELF.Vehicle1.model := ri.Best_Model_Code;
	
	// title isn't being used at all by any of our current products, but should be noted that V2 data 
	// doesn't have a liens field to determine if title is in the hands of the buyer or if the bank has it
	// according to the data team, v1 data didn't have good population or coverage in this field anyway, 
	// so it shouldn't have been used in the first place
	// SELF.Vehicle1.title := ((INTEGER)ri.LIEN_COUNTxBG10=0 AND ri.seq_no<>0); 
	self.Vehicle1.orig_state := le.orig_state;
	self.Vehicle1.source_code := le.source_code;
	SELF.Vehicle1.vin := ri.orig_vin;
	SELF.relative_owned_count :=le.Rel_current_count ;
	SELF := le;
	SELF := [];//vehicle2 and vehicle 3 state and source code
END;

vehicles_main_roxie := JOIN(vehicles_party_roxie, VehicleV2.Key_Vehicle_Main_Key,
                            keyed(LEFT.vehicle_key=RIGHT.vehicle_key) AND 
                            keyed(left.iteration_key=right.iteration_key) and right.orig_vin<>'',
                            add_Vehicles_main(LEFT,RIGHT), atmost(riskwise.max_atmost));
            
vehicles_main_thor := JOIN(DISTRIBUTE(vehicles_party_thor, HASH64(vehicle_key, iteration_key)), 
                           DISTRIBUTE(PULL(VehicleV2.Key_Vehicle_Main_Key), HASH64(vehicle_key, iteration_key)),
                           LEFT.vehicle_key=RIGHT.vehicle_key AND 
                           LEFT.iteration_key=RIGHT.iteration_key and RIGHT.orig_vin<>'',
                           add_Vehicles_main(LEFT,RIGHT), atmost(LEFT.vehicle_key=RIGHT.vehicle_key, riskwise.max_atmost), LOCAL);
                           
#IF(onThor)
	vehicles_main_correct := vehicles_main_thor;
#ELSE
	vehicles_main_correct := vehicles_main_roxie;
#END


//TODO: do we need to change this for THOR?
//DISTRIBUTE by all sorting criteria (did, vehicle1.vin, -current_count_indiv, -historical_count_indiv, -relative_owned_count)?
//and run LOCAL?
vehicles_added := group(
                              dedup( 
                              // keep 1 record per VIN per person, and keep the record which has the highest current count
                              sort(vehicles_main_correct,  did, vehicle1.vin, -current_count_indiv, -historical_count_indiv, -relative_owned_count),
                              did, vehicle1.vin), did);
                              
                              // DIST by DID, set LOCAL, sort LOCAL
                                
// vehicles_added_Roxie := group(
                              // dedup( 
                              // keep 1 record per VIN per person, and keep the record which has the highest current count
                              // sort(vehicles_main_correct,  did, vehicle1.vin, -current_count_indiv, -historical_count_indiv, -relative_owned_count),
                              // did, vehicle1.vin), did);
                
// vehicles_added_thor := group(
                              // dedup( 
                              // keep 1 record per VIN per person, and keep the record which has the highest current count
                              // sort(vehicles_main_correct,  did, vehicle1.vin, -current_count_indiv, -historical_count_indiv, -relative_owned_count),
                              // did, vehicle1.vin), did);

                              
// #IF(onThor)
	// vehicles_added_correct := vehicles_added_thor;
// #ELSE
	// vehicles_added_correct := vehicles_added_roxie;
// #END

// vehicles_added := PROJECT(vehicles_added, transform(vehrec, SELF :=LEFT, SELF := []));

vehrecAddl roll_vehicles(vehrecAddl le, vehrecAddl ri) := TRANSFORM
	SELF.current_count := le.current_count+
							IF(le.Vehicle1.vin=ri.Vehicle1.vin,0,ri.current_count);
	SELF.historical_count := le.historical_count+
							IF(le.Vehicle1.vin=ri.Vehicle1.vin,0,ri.historical_count);
	SELF.relative_owned_count := le.relative_owned_count+
							IF(le.Vehicle1.vin=ri.Vehicle1.vin,0,ri.relative_owned_count);
	dowhich := IF(ri.Vehicle1.vin IN 
					[le.Vehicle1.vin,le.Vehicle2.vin,le.Vehicle3.vin], 0,
			 MAP(
				le.Vehicle2.vin = '' => 2,
				le.Vehicle3.vin = '' => 3,
				0));
	
	SELF.Vehicle2.year_make := 	IF(dowhich=2,ri.Vehicle1.year_make,le.Vehicle2.year_make);
	SELF.Vehicle2.make := 		IF(dowhich=2,ri.Vehicle1.make,le.Vehicle2.make);
	SELF.Vehicle2.model := 		IF(dowhich=2,ri.Vehicle1.model,le.Vehicle2.model);
	SELF.Vehicle2.title := 		IF(dowhich=2,ri.Vehicle1.title,le.Vehicle2.title);
	SELF.Vehicle2.vin := 		IF(dowhich=2,ri.Vehicle1.vin,le.Vehicle2.vin);
	SELF.Vehicle2.orig_state := IF(dowhich=2,ri.Vehicle1.orig_state,le.Vehicle2.orig_state);
	SELF.Vehicle2.source_code := IF(dowhich=2,ri.Vehicle1.orig_state,le.Vehicle2.source_code);	
	
	SELF.Vehicle3.year_make := 	IF(dowhich=3,ri.Vehicle1.year_make,le.Vehicle3.year_make);
	SELF.Vehicle3.make := 		IF(dowhich=3,ri.Vehicle1.make,le.Vehicle3.make);
	SELF.Vehicle3.model := 		IF(dowhich=3,ri.Vehicle1.model,le.Vehicle3.model);
	SELF.Vehicle3.title := 		IF(dowhich=3,ri.Vehicle1.title,le.Vehicle3.title);
	SELF.Vehicle3.vin := 		IF(dowhich=3,ri.Vehicle1.vin,le.Vehicle3.vin);
	SELF.Vehicle3.orig_state := IF(dowhich=3,ri.Vehicle1.orig_state,le.Vehicle3.orig_state);
	SELF.Vehicle3.source_code := IF(dowhich=3,ri.Vehicle1.orig_state,le.Vehicle3.source_code);	

	SELF := le;
END;
vehicles_per_did_rolled := ROLLUP(vehicles_added,true,roll_Vehicles(LEFT,RIGHT));

// join back to the original ids1 before they were deduped
vehicles_appended_to_did := join(ids1, vehicles_per_did_rolled,
	left.did=right.did,
	transform(vehrecAddl,	
		self.vehicle1 := right.vehicle1;
		self.vehicle2 := right.vehicle2;
		self.vehicle3 := right.vehicle3;
		self.current_count := if(~left.isrelat, right.current_count, 0); 
		self.historical_count := if(~left.isrelat, right.historical_count, 0);
		self.relative_owned_count := if(left.isrelat and right.relative_owned_count>0, 1, 0);
		self := left,
		self := right));

vehicles_rolled_roxie := group(sort(vehicles_appended_to_did, seq, isRelat, did), seq);
vehicles_rolled_thor := group(sort(DISTRIBUTE(vehicles_appended_to_did, HASH64(seq)), seq, isRelat, did, LOCAL), seq, LOCAL);

#IF(onThor)
	vehicles_rolled := vehicles_rolled_thor;
#ELSE
	vehicles_rolled := vehicles_rolled_roxie;
#END

vehrecAddl roll_again(vehrecAddl le, vehrecAddl ri) := TRANSFORM
	self.relative_owned_count := le.relative_owned_count + ri.relative_owned_count;
	self := le;
END;
vehicles_wrel_rolled := ROLLUP(vehicles_rolled,true,roll_again(LEFT,RIGHT));

// output(vehicles_idd, named('vehicles_idd'));
// output(vehicles_party, named('vehicles_party'));
// output(vehicles_per_did_rolled, named('vehicles_per_did_rolled'));
// output(vehicles_rolled, named('vehicles_rolled_new'));
// output(vehicles_added, named('vehicles_added_new'));
veh_hist := if(includeRel, vehicles_wrel_rolled, vehicles_rolled);

veh_hist_final := project(veh_hist, transform(vehrec, 
		self.vehicle1 := if (drivers.state_dppa_ok(left.vehicle1.orig_state,dppa,left.vehicle1.source_code), left.vehicle1),//right.vehicle1;
		self.vehicle2 := if (drivers.state_dppa_ok(left.vehicle2.orig_state,dppa,left.vehicle2.source_code), left.vehicle2),//right.vehicle2;
		self.vehicle3 := if (drivers.state_dppa_ok(left.vehicle3.orig_state,dppa,left.vehicle3.source_code), left.vehicle3),//right.vehicle3;
	self := left));

RETURN ungroup(veh_hist_final);

END;

//run roxie version first, THOR second