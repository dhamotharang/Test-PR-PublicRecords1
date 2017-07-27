export QueryGetSourceOnlyBdids(string pSource) :=
function

	file := Business_Header.File_Business_Header;

	///////////////////////////////////////////////////////////
	// -- Remove pSource records from the business header 
	///////////////////////////////////////////////////////////

	////////////////////////////////////////////////
	// -- take persist in, dedup on bdid and source
	////////////////////////////////////////////////
	layout_source := record
	file.bdid;
	file.source;
	end;

	bdid_source := table(file, layout_source);
	bdid_source_dedup := dedup(bdid_source, all);

	////////////////////////////////////////////////
	// -- Filter for pSource
	////////////////////////////////////////////////
	bdid_with_source := bdid_source_dedup(source = pSource);

	////////////////////////////////////////////////
	// -- Filter for rest of records
	////////////////////////////////////////////////
	bdid_with_other_sources := bdid_source_dedup(source != pSource);

	////////////////////////////////////////////////
	// -- Gong only BDIDs
	////////////////////////////////////////////////
	bdid_source_only := join(bdid_with_other_sources,
						   bdid_with_source,
						   left.bdid = right.bdid,
						   transform(layout_source, self := right),
						   right only,
						   hash);
					   
	bdid_source_only_dedup := dedup(bdid_source_only, all);
	
	return bdid_source_only_dedup;

end;