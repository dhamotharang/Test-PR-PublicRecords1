EXPORT layout_FL_Lake_traffic := MODULE

	EXPORT raw_in	:= RECORD
   string	lname;
   string	fname;
   string	mname;
   string	suffix;
   string	blank1;
   string	address1;
   string	address2;
   string	blank2;
   string	city;
   string	state;
   string	zip;
   string	filing_date; //mm/dd/yyyy
   string	statute;
   string	citation_no;
end;

	EXPORT statute_lkp	:= RECORD
		string20	statute;
		string50	description;
		string1		lf;
	END;

END;