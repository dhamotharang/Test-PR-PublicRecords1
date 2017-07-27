import doxie, FBNv2_services, iesp, ut, doxie_raw;

export Comp_FBN2Search (dataset(doxie.layout_references) dids):= function
	newbydid := FBNv2_services.FBN_raw.get_rmsids_from_dids(dids);
	in_ids := project(newbydid,FBNv2_services.layout_search_IDs);
														
	results_fbn := FBNv2_services.FBN_raw.report_view.by_rmsid(in_ids, true);
	
	Doxie_Raw.MAC_ENTRP_CLEAN(results_fbn,filing_date,results_entrp);
  results := IF(ut.industryclass.is_Entrp,results_entrp,results_fbn);
	
	final_results := iesp.transform_FBN(results);
	return final_results;
end;
