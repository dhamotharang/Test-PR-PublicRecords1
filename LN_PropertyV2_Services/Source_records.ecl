l_out := LN_PropertyV2_Services.layouts.out_widest;

export dataset(l_out) Source_records(
	dataset(layouts.search_did)		dids	= dataset([],layouts.search_did),
	dataset(layouts.search_bdid)	bdids	= dataset([],layouts.search_bdid),
	unsigned inMaxProperties = 0,
	boolean inTrimBySortBy = false
) := function

	// get the fids
	fids := LN_PropertyV2_Services.ReportService_ids(
		/*did*/, /*bdid*/, /*parcelID*/, /*faresID*/,
		dids, project(bdids,layouts.search_bdid)
	);
	
	// retrieve results
	tmp		:= LN_PropertyV2_Services.resultFmt.widest_view.get_by_fid(fids,inMaxProperties,inTrimBySortBy);
	rpen	:= project(tmp, transform(l_out, self.isDeepDive:=false, self:=left));
	
	// final dedup
	results := dedup(rpen, except ln_fares_id);
	
	// output(fids,			named('fids'));			// DEBUG
	// output(tmp,			named('tmp'));			// DEBUG
	// output(rpen,			named('rpen'));			// DEBUG
	// output(results,	named('results'));	// DEBUG
	
	return results;

end;