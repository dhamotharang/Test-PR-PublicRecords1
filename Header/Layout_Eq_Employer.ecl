export Layout_Eq_Employer := record
 	unsigned6 DID := 0;
	unsigned3 dt_first_seen := 0;
	unsigned3 dt_last_seen := 0;
	qstring20 fname;
	qstring35 occupation_employer;
	qstring35 occupation_position;
    //C - current, F - former, G - former2, O - other, P - other2
    string1 employer_type;
	qstring5 zip;
end;