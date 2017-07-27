export mac_trim_xLNPID_layout(inDataset, outDataset) := macro

	/*-- Trim Layout ---*/
	#uniquename(LayoutScoredFetch)
	%LayoutScoredFetch% := record // Nulls required for linkpaths that do not have field
		unsigned8 LNPID;
		unsigned2 Weight;
	end;
	#uniquename(OutputLayout_Base)
	%OutputLayout_Base% := record
		boolean Resolved := false; // certain with 3 nines of accuracy
		dataset(%LayoutScoredFetch%) Results;
		unsigned4 reference;
	end;

	outDataset := project(inDataset, transform(%OutputLayout_Base%, 
																	self.resolved := left.resolved, self.reference := left.reference,
																	self.results := project(left.results, transform(%LayoutScoredFetch%, self := left))
																	));
endmacro;