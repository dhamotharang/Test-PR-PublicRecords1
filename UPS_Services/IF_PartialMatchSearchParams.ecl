import AutoHeaderI;

// Input (search) parameters for mod_PartialMatch
export IF_PartialMatchSearchParams := INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, 
																											AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full)
	export UNSIGNED8 MaxResults;
	export string20  PhoneScoreModel := 'PHONESCORE_V2': stored('PhoneScoreModel');
	export integer MaxNumPhoneSubject := 10;
END;
