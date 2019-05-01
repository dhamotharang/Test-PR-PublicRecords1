EXPORT Layouts := MODULE

EXPORT BV_raw	:= RECORD
	STRING128 email_address;
	STRING40	email_status;
	STRING100	secondary_status;

END;

EXPORT BV_Delta_raw	:= RECORD
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
/*
EXPORT Domain_lkp := RECORD
	STRING100	domain_name;
	STRING8	  create_date;
	STRING8	  expire_date;
	STRING8	  date_first_seen;
	STRING8	  date_last_seen;
	STRING8	  date_first_verified;
	STRING8	  date_last_verified;
	// STRING	domain_type;		//MILITARY, EDU, GOVT, FREE, ect.
	STRING50	domain_status;
	STRING10	verifies_account := true;
	STRING8   process_date;
	UNSIGNED  email_rec_key;
	// STRING	ip_address;
	// STRING	ip_location;
	// STRING	domain_ASN;		//Autonomous System Number
END;
*/
END;