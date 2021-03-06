export layout_activity := record
	string8  process_date;
	string60 offender_key;
	string5  vendor;
	string2  state_origin;
	string20 source_file;
	string4  off_comp;
	string35 case_number;
	string2  event_type;
	string9  event_sort_key;
	string8  event_date;
	string10 event_location_code;
	string50 event_location_desc;
	string8  event_desc_code;
	string50 event_desc_1;
	string50 event_desc_2;
	string8 conviction_override_date;
  string1 conviction_override_date_type;
	unsigned8 activity_persistent_id;
end;