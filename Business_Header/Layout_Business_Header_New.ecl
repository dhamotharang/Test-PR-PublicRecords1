import Business_Header;
export Layout_Business_Header_New := record
   Business_Header.Layout_Business_Header;
   string34		vl_id		:= '';   // Vendor linking Identifier
	 unsigned8	RawAID	:= 0;    // Added for Address_id
end;