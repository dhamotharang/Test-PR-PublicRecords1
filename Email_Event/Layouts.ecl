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

END;