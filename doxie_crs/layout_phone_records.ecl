import Risk_Indicators,PhonesFeedback_Services,FFD;
export layout_phone_records := record
	string10 prim_range;
  string30 prim_name;
  string5  zip;
  string10 sec_range;
  string2	 predir;
  string120 listing_name;
  string10 phone;
	string4  timezone;
	string1  publish_code;
	string25 name_first;
	string25 name_last;
	boolean  business_flag;
  unsigned2 fdn_phone_ind := 0;   // Added for the FDN project.
	DATASET(Risk_Indicators.Layout_Desc) hri_Phone;
	DATASET(PhonesFeedback_Services.Layouts.feedback_report) Feedback {MAXCOUNT(1)}:=DATASET ([], PhonesFeedback_Services.Layouts.feedback_report);
	unsigned8  rawaid := 0;
	string10   geo_lat := '';
	string11   geo_long := '';
	// New fields for accurint comp report re-design
	string30 carrier := '';
	string25 carrier_city := '';
	string2 carrier_state := '';
	string12 PhoneType := '' ;
	string30 new_type := ''; 
	string8 dt_first_seen := '';
	string8 dt_last_seen := '';
	FFD.Layouts.CommonRawRecordElements;
end;
