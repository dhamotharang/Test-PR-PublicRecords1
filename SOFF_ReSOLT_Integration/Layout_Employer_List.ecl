export Layout_Employer_List := RECORD
  Layout_UNQ_PK_DID_Plus_Relatives;
	
  Files_used.Bus_Hdr_Business_contacts_File.dt_first_seen;   // From contact info if available
  Files_used.Bus_Hdr_Business_contacts_File.dt_last_seen;
  // Files_used.Bus_Hdr_Business_contacts_File.source;          // Source file type
  // Files_used.Bus_Hdr_Business_contacts_File.record_type;     // 'C' = Current, 'H' = Historical
  // Files_used.Bus_Hdr_Business_contacts_File.from_hdr; // 'Y' if contact is from address  match with person headers.
  // Files_used.Bus_Hdr_Business_contacts_File.glb;    // GLB restricted record (only possible for contacts pulled from header)
  // Files_used.Bus_Hdr_Business_contacts_File.dppa;   // DPPA restricted record
  Files_used.Bus_Hdr_Business_contacts_File.company_name;

end;