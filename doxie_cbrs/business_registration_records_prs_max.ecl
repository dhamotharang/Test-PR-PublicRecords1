import doxie, business_header;
doxie_cbrs.MAC_Selection_Declare()
export business_registration_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := module

SHARED all_recs := 
	doxie_cbrs.business_registration_records_prs(bdids)(Return_BusinessRegistrations_val);
export records := choosen(all_recs,Max_BusinessRegistrations_val);
export records_count := count(all_recs);
end;