export Layout_Court_Venture_Suppressions := module

export orig := 
record

string cau_nbr;
string pty_nm;
string source_file;
string dob;
string orig_ssn;
string DateReceived;
string SourceTable;
string SourceID;

end;

export clean := 
record

orig;
string5 title;
string20 fname;
string20 mname;
string20 lname;
string5 name_suffix;
string3 cleaning_score;
string1 blank := '';
unsigned6 did := 0;
unsigned did_score := 0;
end;

end;