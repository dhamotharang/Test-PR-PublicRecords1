EXPORT layout_fl_pasco_traffic := module

	EXPORT raw_in	:= RECORD //RL = 152
		string30	Name;
		string30	address_1;
		string30	address_2;
		string21	city_state;
		string9		zip_code;
		string8		offense_date;	//yyyymmdd
		string10	statute_violated;
		string7		citation_no;
		string7		filler;
	END;
	
	EXPORT statute_lkp	:= RECORD
		string12	statute;
		string50	description;
		string1		lf;
	END;
	
END;
