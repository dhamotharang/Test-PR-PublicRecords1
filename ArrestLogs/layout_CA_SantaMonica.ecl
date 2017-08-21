EXPORT layout_CA_SantaMonica := MODULE

	EXPORT raw_in	:= RECORD
		string10	booking_date;
		string4		time;
		string10	booking_number;
		string10	case_number;
		string25	last_name;
		string25	first_name;
		string10	birthdate;
		string20	primary_charge;
	END;
	
		EXPORT raw_in_new	:= RECORD
		string11	booking_date;
		string4		time;
		string10	booking_number;
		string10	case_number;
		string25	last_name;
		string25	first_name;
		string3		age;
		string1		gender;
		string1		race;
		string20	primary_charge;
	END;
	
END;