import doxie_files, drivers, FCRA, VehicleV2;

EXPORT Boca_Shell_Vehicles_Hist_FCRA (GROUPED DATASET(Layout_Boca_Shell_ids) ids,
                                      unsigned1 dppa, boolean dppa_ok) := FUNCTION
unsigned2 MAX_OVERRIDE_VEHICLES := 100;
unsigned2 MAX_VEHICLES := 100;

kvd := VehicleV2.key_vehicle_did_fcra;

vehrec := RECORD
	Layout_Boca_Shell_ids;
	Layout_Vehicles.Vehicle_Set;
	unsigned1 relative_owned_count := 0;
END;

vtemp := record
	vehrec;
	kvd.Vehicle_Key;
	kvd.Iteration_Key;
	kvd.Sequence_Key;
	DATASET(Layout_Vehicles.Vehicle_Information) vehicles;
	DATASET(Layout_Vehicles.Vehicle_Information) corrections;
end;

Layout_Vehicles.Vehicle_Information correct_veh(FCRA.Key_Override_Vehicles_FFID ri) := TRANSFORM
	SELF.year_make := (INTEGER)ri.Best_Model_Year;
	SELF.make := ri.Best_Make_Code;
	SELF.model := ri.Best_Model_Code;
	SELF.title := (INTEGER)ri.LIEN_COUNTxBG10=0;
	SELF.vin := ri.orig_vin;
END;

// get the vehicle keys by the did
vtemp add_Vehicle_num(ids le, kvd ri) := TRANSFORM
	self.vehicle_key := ri.vehicle_key;
	self.iteration_key := ri.iteration_key;
	self.sequence_key := ri.sequence_key;
	
	self.corrections := PROJECT (CHOOSEN (FCRA.Key_Override_Vehicles_FFID(keyed(flag_file_id IN le.veh_correct_ffid)), MAX_OVERRIDE_VEHICLES), correct_Veh(LEFT));

	SELF := le;
	SELF := [];
END;
vehicles_idd := JOIN(ids(~isrelat), kvd, left.did!=0 and keyed(LEFT.did=RIGHT.append_did),add_Vehicle_num(LEFT,RIGHT),atmost(5000),KEEP(MAX_VEHICLES));

vtemp add_party(vehicles_idd le, VehicleV2.Key_Vehicle_Party_Key_fcra R) := transform
	SELF.current_count := (INTEGER)(r.Sequence_Key<>'' AND r.history='');
	SELF.historical_count := (INTEGER)(r.Sequence_Key<>'' AND r.history='H');
	self := le;
	self := [];
end;

vehicles_party := JOIN(vehicles_idd, VehicleV2.Key_Vehicle_Party_Key_fcra,
						keyed(LEFT.vehicle_key=RIGHT.vehicle_key) AND 
						keyed(left.iteration_key=right.iteration_key) and
						keyed(left.sequence_key=right.sequence_key) AND
						RIGHT.date_first_seen < left.historydate AND
						dppa_ok AND drivers.state_dppa_ok(RIGHT.orig_state,dppa, RIGHT.source_code),
						add_party(LEFT,RIGHT));
						

vtemp add_Vehicles_main(vehicles_party le, VehicleV2.Key_Vehicle_Main_Key_fcra ri) := TRANSFORM
	self.historical_count := le.current_count + le.historical_count;  // if it's current, also ding the historical counter
	SELF.Vehicle1.year_make := (INTEGER)ri.Best_Model_Year;
	SELF.Vehicle1.make := ri.Best_Make_Code;
	SELF.Vehicle1.model := ri.Best_Model_Code;
	
	// title isn't being used at all by any of our current products, but should be noted that V2 data 
	// doesn't have a liens field to determine if title is in the hands of the buyer or if the bank has it
	// according to the data team, v1 data didn't have good population or coverage in this field anyway, 
	// so it shouldn't have been used in the first place
	// SELF.Vehicle1.title := ((INTEGER)ri.LIEN_COUNTxBG10=0 AND ri.seq_no<>0); 
	
	SELF.Vehicle1.vin := ri.orig_vin;
	SELF := le;
END;

vehicles_main := JOIN(vehicles_party, VehicleV2.Key_Vehicle_Main_Key_fcra,
						keyed(LEFT.vehicle_key=RIGHT.vehicle_key) AND 
						keyed(left.iteration_key=right.iteration_key) and right.orig_vin<>'',
						add_Vehicles_main(LEFT,RIGHT));


vehicles_added := group(
						dedup( 
							// keep 1 record per VIN per person, and keep the record which has the highest current count
							sort(vehicles_main,  seq, did, vehicle1.vin, -current_count, -historical_count),
						seq, did, vehicle1.vin),
                   seq, did);
// output(vehicles_added, named('vehicles_added'));


vtemp roll_vehicles(vtemp le, vtemp ri) := TRANSFORM
	SELF.current_count := le.current_count+
							IF(le.Vehicle1.vin=ri.Vehicle1.vin,0,ri.current_count);
	SELF.historical_count := le.historical_count+
							IF(le.Vehicle1.vin=ri.Vehicle1.vin,0,ri.historical_count);
	
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
	
	SELF.Vehicle3.year_make := 	IF(dowhich=3,ri.Vehicle1.year_make,le.Vehicle3.year_make);
	SELF.Vehicle3.make := 		IF(dowhich=3,ri.Vehicle1.make,le.Vehicle3.make);
	SELF.Vehicle3.model := 		IF(dowhich=3,ri.Vehicle1.model,le.Vehicle3.model);
	SELF.Vehicle3.title := 		IF(dowhich=3,ri.Vehicle1.title,le.Vehicle3.title);
	SELF.Vehicle3.vin := 		IF(dowhich=3,ri.Vehicle1.vin,le.Vehicle3.vin);
	SELF := le;
END;
vehicles_rolled := ROLLUP(vehicles_added,true,roll_Vehicles(LEFT,RIGHT));

vtemp correct(vtemp le) := TRANSFORM
  // kind of easier to make it here, than in a rollup before...
  all_vehicles := le.vehicle1 + le.vehicle2 + le.vehicle3;

  // this should be the same as in non-history version:
	good_vehicles := all_vehicles (vin != '' AND vin NOT IN le.veh_correct_vin);
  vehicles_verified := JOIN (le.corrections, all_vehicles, LEFT.vin=RIGHT.vin, LEFT OUTER, LOOKUP);
  self.vehicles := vehicles_verified & good_vehicles;
  
	SELF := le;
END;

// nofold to keep the project below away from this project; so that the JOIN logic only happens once
outf_corrected := nofold(PROJECT (vehicles_rolled, correct(LEFT)));

vehrec split(vtemp le) :=
TRANSFORM
	self.vehicle1 := le.vehicles[1];
	self.vehicle2 := le.vehicles[2];
	self.vehicle3 := le.vehicles[3];
	SELF := le;
END;
outf_split := PROJECT(outf_corrected, split(LEFT));

return ungroup(outf_split);
END;