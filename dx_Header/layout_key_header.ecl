IMPORT _Control;
/*
xHead_Layout := RECORD
	RECORDOF (doxie_build.file_header_building); header.Layout_Header
	string1 valid_dob := '';
	unsigned6 hhid := 0;
	STRING18 county_name := '';
	STRING120 listed_name := '';
	STRING10 listed_phone := '';
	unsigned4 dod := 0;
	STRING1 death_code := '';
	unsigned4 lookup_did := 0;
END;
*/
// (almost) same manner as it was defined internally in doxie\key_header
xHead_Layout := RECORD
  unsigned6 s_did; //need to add it: will be a keyd field in the index definition
  $.layout_header;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
END;
EXPORT layout_key_header := xHead_Layout - _Control.Layout_KeyExclusions;
