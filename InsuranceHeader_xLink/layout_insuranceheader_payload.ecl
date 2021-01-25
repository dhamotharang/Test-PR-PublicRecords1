IMPORT dx_header;
IMPORT IDL_header;

EXPORT layout_insuranceheader_payload := RECORD
  // BOCA header fields
  dx_header.layout_header,
  // Additional fields
 	STRING1   valid_dob;
	UNSIGNED6 hhid := 0;
	STRING18  county_name;
	STRING120 listed_name;
	STRING10  listed_phone;
	UNSIGNED4 dod := 0;
	STRING1   death_code;
	UNSIGNED4 lookup_did := 0;
  // Fields from Alpha Header
	IDL_header.Layout_Header_Link.DT_EFFECTIVE_FIRST; 
	IDL_header.Layout_Header_Link.DT_EFFECTIVE_LAST;
  // LOCID
  IDL_header.Layout_Header_Link.locid;
END;