EXPORT profile_records_v2(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

SHARED pr_raw := doxie_cbrs.Corporation_Filings_records_v2(bdids).report_view(Max_CorporationFilings_val)(Include_CompanyProfileV2_val);

doxie_cbrs.mac_Selection_Declare()

EXPORT records := CHOOSEN(SORT(pr_raw,-MAX(corp_hist,corp_filing_date)),Max_CorporationFilings_val);
EXPORT records_count := COUNT(pr_raw);

END;
