
ri := record
	doxie_raw.Layout_Filters;
	unsigned6 DID;
	boolean include_relatives_val;
	boolean include_associates_val;
	unsigned1 Relative_Depth;	
end;

export Layout_RelativeRawBatchInput:= record
	ri input;
	doxie_raw.Layout_RelativeRawOutput;
end;