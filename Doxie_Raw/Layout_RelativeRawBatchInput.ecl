
ri := record
	doxie_raw.Layout_Filters.seq;
	unsigned6 DID;
end;

export Layout_RelativeRawBatchInput:= record
	ri input;
	doxie_raw.Layout_RelativeRawOutput;
end;
