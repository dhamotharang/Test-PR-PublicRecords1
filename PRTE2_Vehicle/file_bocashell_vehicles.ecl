import prte2_vehicle;

layouts.vehrec 	add_seqno(files.party_slim R) := transform
	self.did 									:= R.append_did;
	self.vehicle_key 					:= R.vehicle_key;
	self.iteration_key 				:= R.iteration_key;
	self.sequence_key 				:= R.sequence_key;
	SELF.current_count 				:= (INTEGER)(r.Sequence_Key<>'' AND r.history='');
	SELF.historical_count 		:= (INTEGER)(r.Sequence_Key<>'' AND r.history='H');
	self.vehicle1.orig_state 	:= r.state_origin;
	self := [];
end;

iids_wseq := project(files.party_slim(append_did != 0), add_seqno(LEFT));


layouts.vehrec 	add_Vehicles(layouts.vehrec le, files.main_slim ri) := TRANSFORM
	self.historical_count 	:= le.current_count + le.historical_count;  // if it's current, also ding the historical counter
	SELF.Vehicle1.year_make := (INTEGER)ri.Best_Model_Year;
	SELF.Vehicle1.make 			:= ri.Best_Make_Code;
	SELF.Vehicle1.model 		:= ri.Best_Model_Code;
	SELF.Vehicle1.vin 				:= ri.orig_vin;
	self.vehicle1.source_code := ri.source_code;
	SELF := le;
END;

vehicles_joined := JOIN (iids_wseq, files.main_slim,
                         left.vehicle_key = right.vehicle_key and  
												 left.iteration_key = right.iteration_key and
                         right.orig_vin<>'',
                         add_Vehicles(LEFT,RIGHT), local);


vehicles_added := group(dedup( 
															// keep 1 record per VIN per person, and keep the record which has the highest current count
																sort(vehicles_joined, did, vehicle1.vin, -current_count, -historical_count, local),
																did, vehicle1.vin, local),
																did, local);


layouts.vehrec 	roll_vehicles(layouts.vehrec le, layouts.vehrec ri) := TRANSFORM
	SELF.current_count := le.current_count+
														IF(le.Vehicle1.vin=ri.Vehicle1.vin,0,ri.current_count);
	SELF.historical_count := le.historical_count+
														IF(le.Vehicle1.vin=ri.Vehicle1.vin,0,ri.historical_count);
	
	dowhich := IF(ri.Vehicle1.vin IN [le.Vehicle1.vin,le.Vehicle2.vin,le.Vehicle3.vin],
	              0,
                MAP(le.Vehicle2.vin = '' => 2, le.Vehicle3.vin = '' => 3,	0));
	
	SELF.Vehicle2.year_make 	:= 	IF(dowhich=2,ri.Vehicle1.year_make,le.Vehicle2.year_make);
	SELF.Vehicle2.make 				:= 	IF(dowhich=2,ri.Vehicle1.make,le.Vehicle2.make);
	SELF.Vehicle2.model 			:= 	IF(dowhich=2,ri.Vehicle1.model,le.Vehicle2.model);
	
	SELF.Vehicle2.vin 				:= 		IF(dowhich=2,ri.Vehicle1.vin,le.Vehicle2.vin);
	self.vehicle2.orig_state 	:=  IF(dowhich=2,ri.vehicle1.orig_state, le.vehicle2.orig_state);
	self.vehicle2.source_code :=  IF(dowhich=2,ri.vehicle1.source_code, le.vehicle2.source_code);

	SELF.Vehicle3.year_make 	:= 	IF(dowhich=3,ri.Vehicle1.year_make,le.Vehicle3.year_make);
	SELF.Vehicle3.make 				:= 	IF(dowhich=3,ri.Vehicle1.make,le.Vehicle3.make);
	SELF.Vehicle3.model 			:= 	IF(dowhich=3,ri.Vehicle1.model,le.Vehicle3.model);
	
	SELF.Vehicle3.vin 				:= 	IF(dowhich=3,ri.Vehicle1.vin,le.Vehicle3.vin);
	self.Vehicle3.orig_state 	:= 	If(dowhich=3,ri.vehicle1.orig_state,le.vehicle3.orig_state);
	self.vehicle3.source_code :=  IF(dowhich=3,ri.vehicle1.source_code, le.vehicle3.source_code);
	SELF := le;
END;
vehicles_rolled := ROLLUP (vehicles_added,true,roll_Vehicles(LEFT,RIGHT)); 

export file_bocashell_vehicles := vehicles_rolled;