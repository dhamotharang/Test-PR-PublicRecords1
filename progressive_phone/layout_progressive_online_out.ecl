import PhonesFeedback_Services;
export layout_progressive_online_out := record(progressive_phone.layout_progressive_batch_out)
		unsigned6	did;	
		string4	timeZone := '';
		dataset(PhonesFeedback_Services.Layouts.feedback_report) feedback {MAXCOUNT(1)}:=DATASET ([], PhonesFeedback_Services.Layouts.feedback_report);
		STRING10 prim_range;
		STRING2  predir;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  postdir;
		STRING10 unit_desig;
		STRING8  sec_range;
		STRING25 p_city_name;
		STRING2  st;
		STRING5  zip5;
end;