IMPORT doxie,doxie_crs;
EXPORT aircraft_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  doxie_cbrs.mac_Selection_Declare()

  ac_recs := doxie_cbrs.aircraft_records(bdids)(Include_Aircrafts_val);

  ac_rec := RECORD, MAXLENGTH(doxie_crs.maxlength_ac)
    ac_recs;
  END;

  ac_rec ac_rec_slimmed(ac_recs l) := TRANSFORM
    SELF := l;
  END;

  SHARED ac_slim := PROJECT(ac_recs,ac_rec_slimmed(LEFT));

  doxie_cbrs.mac_Selection_Declare()

  EXPORT records := CHOOSEN(ac_slim,Max_Aircrafts_val);
  EXPORT records_count := COUNT(ac_slim);

END;
