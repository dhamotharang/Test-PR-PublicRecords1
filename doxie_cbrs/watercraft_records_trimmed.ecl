IMPORT doxie,doxie_crs;
EXPORT watercraft_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

wc_recs := doxie_cbrs.watercraft_records(bdids)(Include_Bus_DPPA AND Include_Watercrafts_val);

wc_rec := RECORD, MAXLENGTH(doxie_crs.maxlength_wc)
  wc_recs;
// wc_recs.this_field_name;
// wc_recs.that_field_name;
// DATASET(wc_recs.this_records_subset);
END;

wc_rec wc_rec_slimmed(wc_recs l) := TRANSFORM
  SELF := l;
END;

SHARED wc_slim := PROJECT(wc_recs,wc_rec_slimmed(LEFT));

doxie_cbrs.mac_Selection_Declare()

EXPORT records := CHOOSEN(wc_slim,Max_Watercrafts_val);
EXPORT records_count := COUNT(wc_slim);

END;
