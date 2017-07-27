export Layout_Corp_Report_Out := record,maxlength(128000)
	string32  corp_orig_sos_charter_nbr;
	string2	corp_state_origin;
	dataset(layout_corp_base_report) base_recs;
	dataset(layout_corp_event_base) event_recs;
	dataset(layout_corp_supp_base) supplemental_recs;
	dataset(layout_corp_cont_base) contact_recs;
end;
