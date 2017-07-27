export experian_business_reports_trimmed(dataset(doxie_cbrs.layout_references) bdids) := 
MODULE

doxie_cbrs.mac_Selection_Declare()

shared mod_records := doxie_cbrs.experian_business_reports_raw(bdids,Include_Experian_Business_Reports_val,Max_Experian_Business_Reports_val);
export records := mod_records.records;
export records_count := mod_records.record_count;

END;