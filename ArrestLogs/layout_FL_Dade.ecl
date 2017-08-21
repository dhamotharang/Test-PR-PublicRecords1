EXPORT layout_FL_Dade := MODULE

	EXPORT	raw_in	:= RECORD //RL = 252
		string10	PA_BOOK_DATE;
		string40	PA_DEFENDANT;
		string33	PA_ADDR1;
		string33	PA_ADDR2;
		string10	PA_DOB;
		string11	PA_CHARGE_CODE1;
		string20	PA_CHARGE1;
		string11	PA_CHARGE_CODE2;
		string20	PA_CHARGE2;
		string11	PA_CHARGE_CODE3;
		string20	PA_CHARGE3;
		string5		PA_ZIP;
		string26 	FILLER;
		string2		lf;
	END;
		
		EXPORT	raw_in_new	:= RECORD //CSV Comma Delimited with quotes
		string10	PA_BOOK_DATE;
		string40	PA_DEFENDANT;
		string10	PA_DOB;
		string11	PA_CHARGE_CODE1;
		string20	PA_CHARGE1;
		string11	PA_CHARGE_CODE2;
		string20	PA_CHARGE2;
		string11	PA_CHARGE_CODE3;
		string20	PA_CHARGE3;
		string		PA_ADDR;
	END;

END;