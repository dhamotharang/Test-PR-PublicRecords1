doxie_cbrs.mac_Selection_Declare()

EXPORT bankruptcy_records_trimmed_v2(DATASET(doxie_cbrs.layout_references) bdids, STRING6 SSNMask='NONE') :=
MODULE

EXPORT records := doxie_cbrs.bankruptcy_records_v2(bdids,0,SSNMask).report_view(Max_Bankruptcies_val)(Include_BankruptciesV2_val);
EXPORT records_count := COUNT(doxie_cbrs.bankruptcy_records_v2(bdids,0).all_recs);

END;
