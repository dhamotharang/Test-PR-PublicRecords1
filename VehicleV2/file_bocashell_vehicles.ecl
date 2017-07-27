
vp := VehicleV2.file_VehicleV2_Party;
vm := VehicleV2.file_VehicleV2_main;

Layout_Veh_Info := RECORD
	UNSIGNED2 year_make;
	STRING10 make;		
	STRING10 model;
	BOOLEAN title;
	STRING25 vin;
	string2	orig_state;
	string2 source_code;
END;

Layout_Veh := RECORD
	UNSIGNED1 current_count;
	UNSIGNED1 historical_count;
	Layout_Veh_Info Vehicle1;
	Layout_Veh_Info Vehicle2;
	Layout_Veh_Info Vehicle3;
END;

vehrec := RECORD
	unsigned6	did;
	string30		Vehicle_Key;
	string15		Iteration_Key;
	string15		Sequence_Key;
	Layout_Veh;
END;

vehrec add_seqno(VehicleV2.file_VehicleV2_Party R) := transform
	self.did := R.append_did;
	self.vehicle_key := R.vehicle_key;
	self.iteration_key := R.iteration_key;
	self.sequence_key := R.sequence_key;
	SELF.current_count := (INTEGER)(r.Sequence_Key<>'' AND r.history='');
	SELF.historical_count := (INTEGER)(r.Sequence_Key<>'' AND r.history='H');
	self.vehicle1.orig_state := r.state_origin;
	self := [];
end;

iids_wseq := project(vp(append_did != 0), add_seqno(LEFT));
// output(iids_wseq, named('iids_wseq'));


vehrec add_Vehicles(vehrec le, VehicleV2.file_VehicleV2_main ri) := TRANSFORM
	self.historical_count := le.current_count + le.historical_count;  // if it's current, also ding the historical counter
	SELF.Vehicle1.year_make := (INTEGER)ri.Best_Model_Year;
	SELF.Vehicle1.make := ri.Best_Make_Code;
	SELF.Vehicle1.model := ri.Best_Model_Code;
	// SELF.Vehicle1.title := ((INTEGER)ri.LIEN_COUNTxBG10=0 AND ri.seq_no<>0);
	
	// title isn't being used at all by any of our current products, but should be noted that V2 data 
	// doesn't have a liens field to determine if title is in the hands of the buyer or if the bank has it
	// according to the data team, v1 data didn't have good population or coverage in this field anyway, 
	// so it shouldn't have been used in the first place
	// SELF.Vehicle1.title := ((INTEGER)ri.LIEN_COUNTxBG10=0 AND ri.seq_no<>0); 
	
	
	SELF.Vehicle1.vin := ri.orig_vin;
	self.vehicle1.source_code := ri.source_code;
	SELF := le;
END;

vehicles_joined := JOIN (distribute(iids_wseq, hash(vehicle_key, iteration_key)),
                         distribute(vm, hash(vehicle_key, iteration_key)),
                         left.vehicle_key = right.vehicle_key and  
						 left.iteration_key = right.iteration_key and
                         RIGHT.orig_vin<>'',
                         add_Vehicles(LEFT,RIGHT), local);
// output(vehicles_joined, named('vehicles_joined'));


vehicles_added := group(
						dedup( 
							// keep 1 record per VIN per person, and keep the record which has the highest current count
							sort(distribute(vehicles_joined, hash(did)), did, vehicle1.vin, -current_count, -historical_count, local),
						did, vehicle1.vin, local),
                   did, local);
// output(vehicles_added, named('vehicles_added'));

vehrec roll_vehicles(vehrec le, vehrec ri) := TRANSFORM
	SELF.current_count := le.current_count+
							IF(le.Vehicle1.vin=ri.Vehicle1.vin,0,ri.current_count);
	SELF.historical_count := le.historical_count+
							IF(le.Vehicle1.vin=ri.Vehicle1.vin,0,ri.historical_count);
	
	dowhich := IF(ri.Vehicle1.vin IN [le.Vehicle1.vin,le.Vehicle2.vin,le.Vehicle3.vin],
	              0,
                MAP(le.Vehicle2.vin = '' => 2, le.Vehicle3.vin = '' => 3,	0));
	
	SELF.Vehicle2.year_make := 	IF(dowhich=2,ri.Vehicle1.year_make,le.Vehicle2.year_make);
	SELF.Vehicle2.make := 		IF(dowhich=2,ri.Vehicle1.make,le.Vehicle2.make);
	SELF.Vehicle2.model := 		IF(dowhich=2,ri.Vehicle1.model,le.Vehicle2.model);
	// SELF.Vehicle2.title := 		IF(dowhich=2,ri.Vehicle1.title,le.Vehicle2.title);
	SELF.Vehicle2.vin := 		IF(dowhich=2,ri.Vehicle1.vin,le.Vehicle2.vin);
	self.vehicle2.orig_state :=   IF(dowhich=2,ri.vehicle1.orig_state, Le.vehicle2.orig_state);
	self.vehicle2.source_code :=   IF(dowhich=2,ri.vehicle1.source_code, Le.vehicle2.source_code);

	SELF.Vehicle3.year_make := 	IF(dowhich=3,ri.Vehicle1.year_make,le.Vehicle3.year_make);
	SELF.Vehicle3.make := 		IF(dowhich=3,ri.Vehicle1.make,le.Vehicle3.make);
	SELF.Vehicle3.model := 		IF(dowhich=3,ri.Vehicle1.model,le.Vehicle3.model);
	// SELF.Vehicle3.title := 		IF(dowhich=3,ri.Vehicle1.title,le.Vehicle3.title);
	SELF.Vehicle3.vin := 		IF(dowhich=3,ri.Vehicle1.vin,le.Vehicle3.vin);
	self.Vehicle3.orig_state := 	if(dowhich=3,ri.vehicle1.orig_state,le.vehicle3.orig_state);
	self.vehicle3.source_code :=   IF(dowhich=3,ri.vehicle1.source_code, Le.vehicle3.source_code);
	SELF := le;
END;
vehicles_rolled := ROLLUP (vehicles_added,true,roll_Vehicles(LEFT,RIGHT)); // : persist('persist::vehicles_rolled');

export file_bocashell_vehicles := vehicles_rolled;
