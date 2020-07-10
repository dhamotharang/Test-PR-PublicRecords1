import Business_Header;

export Layout_BDL2 := record
   unsigned6 bdl := 0;       // New Seisint Business Identifier
	 business_header.Layout_BH_Super_Group.group_id;
   business_header.Layout_Business_Header_Base;
   business_header.Layout_Business_Contact_Full.title;
   business_header.Layout_Business_Contact_Full.fname;
   business_header.Layout_Business_Contact_Full.mname;
   business_header.Layout_Business_Contact_Full.lname;
   business_header.Layout_Business_Contact_Full.name_suffix;
   business_header.Layout_Business_Contact_Full.ssn;
end;
