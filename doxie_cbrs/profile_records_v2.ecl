export profile_records_v2(dataset(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

shared pr_raw := doxie_cbrs.Corporation_Filings_records_v2(bdids).report_view(Max_CorporationFilings_val)(Include_CompanyProfileV2_val);

doxie_cbrs.mac_Selection_Declare()

export records := choosen(sort(pr_raw,-max(corp_hist,corp_filing_date)),Max_CorporationFilings_val);
export records_count := count(pr_raw);

END;