import census_data,liensv2_services;
doxie_cbrs.MAC_Selection_Declare()
export Liens_Judments_records_v2(dataset(doxie_cbrs.layout_references) bdids, STRING6 SSNMask = 'NONE') := module

  export report_view(unsigned in_limit = 0) := if(JudgmentLienVersion in [0,2],liensv2_services.liens_raw.report_view.by_bdid(bdids,in_limit,SSNMask,'D',application_type_value));
	// using report view for "source view" in order to synch up the displays between report ans source docs.
	export source_view(unsigned in_limit = 0) := if(JudgmentLienVersion in [0,2],liensv2_services.liens_raw.report_view.by_bdid(bdids,in_limit,SSNMask,'D',application_type_value));
	export report_count(boolean in_display) := count(liensv2_services.liens_raw.get_tmsids_from_bdids(bdids,,'D')(in_display and JudgmentLienVersion in [0,2]));
end;
