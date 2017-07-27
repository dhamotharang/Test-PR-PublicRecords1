import doxie_crs;
export layout_property_records := record
	unsigned6 bdid := 0;
	boolean byBDID;					//because some recs may be by both
	boolean byAddress;
	doxie_crs.layout_property_ln;
end;
	