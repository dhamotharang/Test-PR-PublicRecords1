import patriot,GlobalWatchLists,doxie,business_header;

doxie_cbrs.mac_Selection_Declare()

gwl_key := GlobalWatchLists.Key_GlobalWatchLists_Key;

EXPORT Patriot_records(unsigned1 ofac_version = 1, boolean include_ofac = false, real global_watchlist_threshold = 0.8) := 
FUNCTION
doxie_cbrs.layout_references proj(bdid_dataset l):= transform
self.bdid :=l.bdid;
end;

bdids :=project(bdid_dataset(Include_PatriotAct_val),proj(left));
all_company_names_recs := doxie_Cbrs.best_records;


//***** Add a cleaned name for deduping, to avoid sending extra rows...still send unparsed field
rec_pp := record
	patriot.Layout_batch_in;
	string120 clean_name;
end;

rec_pp convert_company(all_company_names_recs le):=transform
ccf := Business_Header.CompanyCleanFields(le.company_name, true);
cn := trim(ccf.indicative) + ' ' + trim(ccf.secondary) + ' ' + trim(ccf.furniture);
self.clean_name := Stringlib.StringToUpperCase(cn);
self.name_unparsed := Stringlib.StringToUpperCase(le.company_name);
self.search_type :='NON-INDIVIDUAL';
self :=[];
END;

almost_ready_for_patriot := dedup(sort(project(all_company_names_recs(company_name <>''),convert_company(left)),clean_name),clean_name);
ready_for_patriot := project(almost_ready_for_patriot, patriot.Layout_batch_in);

results_of_batch :=Patriot.Search_Batch_Function(Group(ready_for_patriot,acctno), false, global_watchlist_threshold, ofac_version, include_ofac);




ds_Patriot_records := 
	JOIN(results_of_batch, gwl_key,
						keyed(LEFT.pty_key=RIGHT.pty_key) AND 
						LEFT.remarks_1=RIGHT.remarks_1 AND LEFT.remarks_2=RIGHT.remarks_2
						AND LEFT.remarks_3=RIGHT.remarks_3 and Left.addr_1=right.addr_1 and left.addr_2=right.addr_2 
						and left.addr_3=right.addr_3 and left.orig_pty_name=right.orig_pty_name and left.source=right.source,
						 KEEP(50), LIMIT(1000,FAIL(203,doxie.ErrorCodes(203))), LEFT OUTER);

RETURN ds_Patriot_records;
END;