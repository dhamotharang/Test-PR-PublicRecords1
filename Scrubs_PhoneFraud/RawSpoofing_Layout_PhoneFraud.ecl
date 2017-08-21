import phonefraud;

EXPORT RawSpoofing_Layout_PhoneFraud := record
		integer4 id_value;										//integer10
		string45 reference_id;
		string20 mode_type;
		string50 account_name;
		string20 event_time;						//timestamp
		string45 spoofed_phone_number;
		string45 destination_number;
		string45 source_phone_number;
		string20 ip_address;
		string15 neustar_lower_bound;
		string15 neustar_upper_bound;
		string30 vendor;
		string20 date_added;						//timestamp
		string30 user_added;						//remove
		end;