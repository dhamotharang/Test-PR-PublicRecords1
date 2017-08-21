import address;

export Layout_Address_list  := record, MAXLENGTH(4096)
Layout_UNQ_PK_DID_Plus_Relatives;
//Files_used.layout_Header_file.lname; 
string Prim_address;
string Sec_address;
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
address.Layout_Clean182.geo_match;	// [178]
integer1 confirmedCurrent;
Files_used.layout_Header_file.dt_last_seen;
//Files_used.layout_Header_file.phone;
unsigned8	Address_key ;
end;