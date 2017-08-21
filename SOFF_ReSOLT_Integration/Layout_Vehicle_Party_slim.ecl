import address;

export Layout_Vehicle_Party_slim := RECORD
Layout_UNQ_PK_DID_Plus_Relatives;
Files_used.Layout_vehicle_party.Vehicle_Key;
Files_used.Layout_vehicle_party.Iteration_Key;
Files_used.Layout_vehicle_party.Sequence_Key;
Files_used.Layout_vehicle_party.History;
Files_used.Layout_vehicle_party.Date_First_Seen;
Files_used.Layout_vehicle_party.Date_Last_Seen;
address.Layout_Clean_Name.fname;
address.Layout_Clean_Name.mname;
address.Layout_Clean_Name.lname;
address.Layout_Clean_Name.name_suffix;
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
//Files_used.Layout_vehicle_party.Append_DID;	
Files_used.Layout_vehicle_party.Reg_Latest_Effective_Date;
Files_used.Layout_vehicle_party.Reg_Latest_Expiration_Date;
Files_used.Layout_vehicle_party.Reg_License_Plate;
Files_used.Layout_vehicle_party.Reg_License_State;
Files_Used.Layout_vehicle_party.orig_name_type;
end;
