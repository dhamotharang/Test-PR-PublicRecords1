import doxie,doxie_crs;
export aircraft_records_trimmed(dataset(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

ac_recs := doxie_cbrs.aircraft_records(bdids)(Include_Aircrafts_val);

ac_rec := RECORD, maxlength(doxie_crs.maxlength_ac)
  ac_recs;
END;

ac_rec ac_rec_slimmed(ac_recs l) := TRANSFORM
	SELF := l;
END;

shared ac_slim := project(ac_recs,ac_rec_slimmed(LEFT));

doxie_cbrs.mac_Selection_Declare()

export records := choosen(ac_slim,Max_Aircrafts_val);
export records_count := count(ac_slim);

END;
