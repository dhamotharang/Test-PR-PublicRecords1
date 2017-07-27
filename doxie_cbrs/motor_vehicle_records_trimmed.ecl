import doxie,doxie_crs;
export motor_vehicle_records_trimmed(dataset(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

mv_recs := doxie_cbrs.motor_vehicle_records_dayton(bdids)(Include_Bus_DPPA AND Include_MotorVehicles_val);

mv_rec := RECORD, maxlength(doxie_crs.maxlength_mv)
  mv_recs;
//  mv_recs.this_field_name;
//	mv_recs.that_field_name;
//	DATASET(mv_recs.this_records_subset);
END;

mv_rec mv_rec_slimmed(mv_recs l) := TRANSFORM
	SELF := l;
END;

shared mv_slim := project(mv_recs,mv_rec_slimmed(LEFT));

doxie_cbrs.mac_Selection_Declare()

export records := choosen(mv_slim,Max_MotorVehicles_val);
export records_count := count(mv_slim);

END;
