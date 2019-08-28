export Layouts_PhonesFeedback := MODULE

	export Layout_PhonesFeedback_in := record   //This maps the Sybase input
		string login_history_id;
	    string did;   				//unique_id from Sybase input
		string phone_number;
		string fname;
		string lname;
		string mname;
		string street_pre_direction;
		string street_post_direction;
		string street_number;
		string street_name;
		string street_suffix;
		string unit_number;
		string unit_designation;
		string zip5;
		string zip4;
		string city;
		string state;
		string alt_phone;
		string other_info;
		string phone_contact_type;
		string feedback_source;
		string date_time_added;
		string loginid;
		string customerid;
		end;
	
	export Layout_PhonesFeedback_base := record
	    unsigned6 did := 0;   //known as unique_id, from Sybase
		unsigned1 did_score := 0;
		unsigned6 hhid := 0;
		string10 phone_number;
		string login_history_id;
		string fname;
		string lname;
		string mname;
		string street_pre_direction;
		string street_post_direction;
		string street_number;
		string street_name;
		string street_suffix;
		string unit_number;
		string unit_designation;
		string zip5;
		string zip4;
		string city;
		string state;
		string alt_phone;
		string other_info;
		string phone_contact_type;
		string feedback_source;
		string date_time_added;
		string loginid;
		string customerid;
		//Added for CCPA-355
		unsigned4 global_sid;
		unsigned8 record_sid;
		end;
	end;