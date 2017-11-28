import AutoHeaderI;

export Search_IDs := MODULE

	export params := interface(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
	end;
		
	export val(params in_mod) := function
	
		dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(in_mod);
	
		return dids;
	END;
END;
