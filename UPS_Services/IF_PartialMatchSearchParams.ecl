import doxie, AutoHeaderI;

key := doxie.key_header;

// Input (search) parameters for mod_PartialMatch
export IF_PartialMatchSearchParams := INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full)
	export UNSIGNED8 MaxResults;
END;
