EXPORT Layouts := MODULE

EXPORT BV_Event_in	:= RECORD
	STRING16	transaction_id;
	STRING128 email_address;
	STRING100 account;
	STRING100	domain;
	STRING10	status;
	STRING10	disposable;
	STRING10	role_address;
	STRING40	error_code;
	STRING100	error_desc;
	STRING20	source;
	STRING100	extra1;
	STRING100	extra2;
	STRING10	date_added;
END;

EXPORT Domain_lkp := RECORD
	STRING	domain_name;
	STRING	create_date;
	STRING	retired_date;
	STRING	first_seen_date;
	STRING	last_seen_date;
	STRING	first_verified_date;
	STRING	last_verified_date;
	STRING	domain_type;		//MILITARY, EDU, GOVT, FREE, ect.
	STRING	domain_status;
	STRING	verifies_account;
	STRING	ip_address;
	STRING	ip_location;
	STRING	domain_ASN;		//Autonomous System Number
END;

END;