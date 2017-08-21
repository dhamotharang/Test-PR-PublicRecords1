export Layout_WA_Clark := module

export payload := 
record
string unparsedRec;
end;


export unparsed_LFM_name := 
RECORD
		STRING   ID;
		STRING   Name;
		STRING   Book_Date;
		STRING   Cell;
		STRING   Release_Date;
	END;


export parsed_LFM_name := 
record
string ID;
string LastName;
string FirstName;
string MiddleName;
string Suffix;
string FullName;
string Book_Date;
string Cell;
string Release_Date;
string Charge;
end;

end;