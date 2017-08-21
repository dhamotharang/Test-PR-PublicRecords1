export Layouts_DL_TX_In := module

//Vendor Update record lenght = 275
	export Layout_TX_Update_EBCDIC := record
		 ebcdic string8  dl_number;
		 ebcdic string28 driver_name;
		 ebcdic string8  date_of_birth;
		 ebcdic string24 street_address;
		 ebcdic string19 city_zipcode;
		 ebcdic string1  class;
		 ebcdic string26 blank_1;
		 ebcdic string3  prior_transaction;
		 ebcdic string8  prior_transaction_date;
		 ebcdic string3  current_transaction;
		 ebcdic string8  current_transaction_date;
		 ebcdic string8  new_dl_number;
		 ebcdic string28 new_driver_name;
		 ebcdic string8  new_date_of_birth;
		 ebcdic string24 new_street_address;
		 ebcdic string19 new_city_zipcode;
		 ebcdic string1  new_class;
		 ebcdic string29 new_blank_2;
		 ebcdic string3  new_current_transaction;
		 ebcdic string8  new_current_transaction_date;
		 ebcdic string11 tblank2;
	end;

	export Layout_TX_With_ProcessDte := record
		string8 process_date;
		Layout_TX_Update_EBCDIC;
	end; 

end;