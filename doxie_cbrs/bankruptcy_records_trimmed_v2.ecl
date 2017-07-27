doxie_cbrs.mac_Selection_Declare()

export bankruptcy_records_trimmed_v2(dataset(doxie_cbrs.layout_references) bdids, STRING6 SSNMask='NONE') :=
MODULE

export records := doxie_cbrs.bankruptcy_records_v2(bdids,0,SSNMask).report_view(Max_Bankruptcies_val)(Include_BankruptciesV2_val);
export records_count := count(doxie_cbrs.bankruptcy_records_v2(bdids,0).all_recs);

END;