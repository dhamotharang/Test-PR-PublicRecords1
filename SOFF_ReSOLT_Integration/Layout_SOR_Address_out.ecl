import address;
export Layout_SOR_Address_out := record
   
   Layout_UNQ_PK_DID_Plus_Relatives.persistent_key;
	 Layout_SexOffender_Main.seisint_primary_key;
	 string50 name;
   string125 street;
   string55  city_state_zip;
	 string55  Addr_type;
   address.Layout_Clean182.prim_range ;	
   address.Layout_Clean182.predir;		// [11..12]
   address.Layout_Clean182.prim_name;
   address.Layout_Clean182.addr_suffix;  // [41..44]
   address.Layout_Clean182.postdir;		// [45..46]
   address.Layout_Clean182.unit_desig;	// [47..56]
   address.Layout_Clean182.sec_range;	// [57..64]
   address.Layout_Clean182.v_city_name;  // [90..114]
   address.Layout_Clean182.st;			// [115..116]
   address.Layout_Clean182.zip;		// [117..121]
	 address.Layout_Clean182.zip4;	 
   address.Layout_Clean182.geo_match;	// [178]   
   //address.Layout_Clean182.err_stat;
	 STRING40 County;
	 
end;