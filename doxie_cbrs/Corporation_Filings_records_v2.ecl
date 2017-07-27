import Corp2_services;
doxie_cbrs.MAC_Selection_Declare()
export Corporation_Filings_records_v2(dataset(doxie_cbrs.layout_references) bdids) := module
  export report_view(unsigned in_limit = 0) := corp2_services.corp2_raw.report_view.by_bdid(bdids,in_limit);
	export source_view(unsigned in_limit = 0) := corp2_services.corp2_raw.source_view.by_bdid(bdids,in_limit);
	export report_count(boolean in_display) := count(corp2_services.corp2_raw.get_corpkeys_from_bdids(bdids)(in_display));
end;
