export Layout_Foreclosure_Base := record
	unsigned6 bdid := 0;       // Seisint Business Identifier
	unsigned4 dt_first_seen;
	unsigned4 dt_last_seen;
	unsigned4 dt_vendor_first_reported;
	unsigned4 dt_vendor_last_reported;
	Property.Layout_Fares_Foreclosure;
	string10  Foreclosure_phone10;
	string10  Foreclosure_ra_phone10;
	STRING1   record_type;           // 'C' Current
                                 // 'H' Historical
end;
