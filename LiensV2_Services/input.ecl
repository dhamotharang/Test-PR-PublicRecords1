import autokeyi, autoheaderi, autostandardi;
export input := module

	export params := interface(
		AutoKeyI.AutoKeyStandardFetchBaseInterface,
		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
	end;
	
	export it 				:= AutoStandardI.InterfaceTranslator;

end;