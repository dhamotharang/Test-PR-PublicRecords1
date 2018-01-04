//WARNING: THIS KEY IS AN FCRA KEY...
import doxie, data_services;

Layout_Veh_Info := RECORD
	UNSIGNED2 year_make;
	STRING10 make;		// TODO: type
	STRING10 model;	// TODO: type
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
	unsigned4	seq_no;
	Layout_Veh;
END;

vehrec add_seqno(doxie_files.File_VehicleContacts R) := transform
	self.did := R.did;
	self.seq_no := R.seq_no;
	self := [];
end;


iids_wseq := project(File_VehicleContacts(did != 0), add_seqno(LEFT));

vehrec add_Vehicles(vehrec le, File_VehicleVehicles ri) := TRANSFORM
	SELF.current_count := (INTEGER)(ri.seq_no<>0 AND ri.history='');
	SELF.historical_count := (INTEGER)(ri.seq_no<>0 AND ri.history='H');
	SELF.Vehicle1.year_make := (INTEGER)ri.Best_Model_Year;
	SELF.Vehicle1.make := ri.Best_Make_Code;
	SELF.Vehicle1.model := ri.Best_Model_Code;
	SELF.Vehicle1.title := ((INTEGER)ri.LIEN_COUNTxBG10=0 AND ri.seq_no<>0);
	SELF.Vehicle1.vin := ri.orig_vin;
	self.vehicle1.orig_state := ri.orig_state;
	self.vehicle1.source_code := ri.source_code;
	SELF := le;
END;

vehicles_joined := JOIN (distribute(iids_wseq, hash(seq_no)),
                         distribute(doxie_files.File_VehicleVehicles, hash(seq_no)),
                         left.seq_no = right.seq_no and  
                         RIGHT.orig_vin<>'',
                         add_Vehicles(LEFT,RIGHT), local);

vehicles_added := group(sort(distribute(vehicles_joined, hash(did)), did, vehicle1.vin, local),
                        did, local);

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
	SELF.Vehicle2.title := 		IF(dowhich=2,ri.Vehicle1.title,le.Vehicle2.title);
	SELF.Vehicle2.vin := 		IF(dowhich=2,ri.Vehicle1.vin,le.Vehicle2.vin);
	self.vehicle2.orig_state :=   IF(dowhich=2,ri.vehicle1.orig_state, Le.vehicle2.orig_state);
	self.vehicle2.source_code :=   IF(dowhich=2,ri.vehicle1.source_code, Le.vehicle2.source_code);

	SELF.Vehicle3.year_make := 	IF(dowhich=3,ri.Vehicle1.year_make,le.Vehicle3.year_make);
	SELF.Vehicle3.make := 		IF(dowhich=3,ri.Vehicle1.make,le.Vehicle3.make);
	SELF.Vehicle3.model := 		IF(dowhich=3,ri.Vehicle1.model,le.Vehicle3.model);
	SELF.Vehicle3.title := 		IF(dowhich=3,ri.Vehicle1.title,le.Vehicle3.title);
	SELF.Vehicle3.vin := 		IF(dowhich=3,ri.Vehicle1.vin,le.Vehicle3.vin);
	self.Vehicle3.orig_state := 	if(dowhich=3,ri.vehicle1.orig_state,le.vehicle3.orig_state);
	self.vehicle3.source_code :=   IF(dowhich=3,ri.vehicle1.source_code, Le.vehicle3.source_code);
	SELF := le;
END;
vehicles_rolled := ROLLUP (vehicles_added,true,roll_Vehicles(LEFT,RIGHT));

//Old name:  'thor_data400::key::bocashell_veh_did_' + doxie.Version_SuperKey
export Key_BocaShell_Vehicles_FCRA := index (vehicles_rolled, {did}, {vehicles_rolled},
                                             data_services.data_location.prefix() + 'thor_data400::key::vehicle::fcra::bocashell.did_' + doxie.Version_SuperKey);