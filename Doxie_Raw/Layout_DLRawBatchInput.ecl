import doxie;

ri := record
	doxie_raw.Layout_Filters;
		unsigned6 DID;
    string20 dl_value;
end;

export Layout_DLRawBatchInput := record
		ri input;
		Doxie.Layout_DlSearch;
end;