import autokeyi, autoheaderi, autostandardi;
export input := module

	export params := interface(
		AutoKeyI.AutoKeyStandardFetchBaseInterface,
		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
    export boolean skip_ids_search := false; // controls whether to run autokey and deep-dive search when fetching IDs
                                             //  or use only provided DIDs, BDIDs, etc.
	end;
	
	export it 				:= AutoStandardI.InterfaceTranslator;
	export gm 				:= AutoStandardI.GlobalModule();

end;