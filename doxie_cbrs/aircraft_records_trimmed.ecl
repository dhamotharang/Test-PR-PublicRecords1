IMPORT doxie_cbrs;
doxie_cbrs.mac_Selection_Declare()
EXPORT aircraft_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  ac_recs := doxie_cbrs.aircraft_records(bdids)(Include_Aircrafts_val);

  SHARED ac_slim := PROJECT(ac_recs, TRANSFORM(doxie_cbrs.layouts.faa_record, SELF := LEFT));
  EXPORT records := CHOOSEN(ac_slim, Max_Aircrafts_val);
  EXPORT records_count := COUNT(ac_slim);

END;
