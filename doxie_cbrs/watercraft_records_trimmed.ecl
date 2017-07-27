import doxie,doxie_crs;
export watercraft_records_trimmed(dataset(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

wc_recs := doxie_cbrs.watercraft_records(bdids)(Include_Bus_DPPA AND Include_Watercrafts_val);

wc_rec := RECORD, maxlength(doxie_crs.maxlength_wc)
  wc_recs;
//  wc_recs.this_field_name;
//	wc_recs.that_field_name;
//	DATASET(wc_recs.this_records_subset);
END;

wc_rec wc_rec_slimmed(wc_recs l) := TRANSFORM
	SELF := l;
END;

shared wc_slim := project(wc_recs,wc_rec_slimmed(LEFT));

doxie_cbrs.mac_Selection_Declare()

export records := choosen(wc_slim,Max_Watercrafts_val);
export records_count := count(wc_slim);

END;
