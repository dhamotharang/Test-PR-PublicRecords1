import doxie;

ri := record
	doxie_raw.Layout_Filters;
		doxie.layout_references;
		boolean probation_override_Value;
		string6 ssn_mask_value;
end;

export Layout_HeaderRawBatchInput := record
	ri input;
	doxie_raw.Layout_HeaderRawOutput;
end;