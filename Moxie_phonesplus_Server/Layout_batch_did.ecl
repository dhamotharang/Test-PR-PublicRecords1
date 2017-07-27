IMPORT PhonesFeedback_Services;
export Layout_batch_did := MODULE

export wo_timezone :=
RECORD
	STRING12 did;
	STRING1 listing_type_bus;
	STRING1 listing_type_res;
	STRING1 listing_type_cell;
	STRING3 prior_area_code;
	STRING10 phoneno;
	STRING10 prim_range;
	STRING2 predir;
	STRING28 prim_name;
	STRING4 suffix;
	STRING2 postdir;
	STRING10 unit_desig;
	STRING8 sec_range;
	STRING25 city;
	STRING2 st;
	STRING5 z5;
	STRING4 z4;
	STRING20 name_first;
	STRING20 name_middle;
	STRING20 name_last;
	STRING5 name_suffix;
	STRING120 listed_name;
	STRING30 carrier;
	STRING25 carrier_city;
	STRING2 carrier_state;
	STRING12 PhoneType := '';
	DATASET(PhonesFeedback_Services.Layouts.feedback_report) Feedback {MAXCOUNT(1)}:=DATASET ([], PhonesFeedback_Services.Layouts.feedback_report);

END;

export w_timezone := RECORD (wo_timezone)
 string4 timezone;
END;

// export w_timezone_feedback := record
// w_timezone;
	// DATASET(PhonesFeedback_Services.Layouts.feedback_report) Feedback {MAXCOUNT(1)};
// end;

END;