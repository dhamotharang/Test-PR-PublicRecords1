EXPORT Lookup_Tables := MODULE
	
//iConectiv/////////////////////////////////////////////////////////////	
	EXPORT iConectiv_SPID := dataset('~thor_data400::in::phones::iconectiv_spid', PhonesInfo.Layout_iConectiv.SPID, csv(terminator('\n'), separator(',')));
	
END;