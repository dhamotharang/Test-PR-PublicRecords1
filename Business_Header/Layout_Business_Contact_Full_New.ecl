export Layout_Business_Contact_Full_New := record
    Layout_Business_Contact_Full;
	  string34		vl_id		:= '';   // Vendor linking Identifier
		unsigned8		RawAID	:= 0;    // Added for Address_id
		unsigned8		Company_RawAID	:= 0;    // Added for Address_id
		//** JIRA# CCPA-104 - The below 2 fields are added for CCPA (California Consumer Protection Act) project enhancements
		unsigned4 	global_sid := 0;
		unsigned8 	record_sid := 0;
end;