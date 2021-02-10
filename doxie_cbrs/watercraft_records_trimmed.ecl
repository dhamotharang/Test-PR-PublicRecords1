IMPORT doxie_cbrs;
doxie_cbrs.mac_Selection_Declare()
EXPORT watercraft_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

wc_recs := doxie_cbrs.watercraft_records(bdids)(Include_Bus_DPPA AND Include_Watercrafts_val);

SHARED wc_slim := PROJECT(wc_recs, TRANSFORM(doxie_cbrs.layouts.watercraft_record, SELF := LEFT)); 

EXPORT records := CHOOSEN(wc_slim, Max_Watercrafts_val);
EXPORT records_count := COUNT(wc_slim);

END;
