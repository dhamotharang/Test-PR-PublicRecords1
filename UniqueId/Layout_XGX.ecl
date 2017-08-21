EXPORT Layout_XGX := RECORD
	unsigned8 primarykey := 0	;
	Layout_Watchlist.rWatchList;
	unicode	akas := '';
	unicode	addresses := '';
	unicode	addlinfo := '';
	unicode	ids := '';
	unicode	phones := '';
	string	dob := ''	;
	integer n_aka := 0;
	integer n_address := 0;
	integer n_info := 0;
	integer n_id := 0;
	integer n_phone := 0;
END;