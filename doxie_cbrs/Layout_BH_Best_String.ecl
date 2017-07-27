export Layout_BH_Best_String := record
	unsigned6		bdid; // i know, not a string.
	string8 		dt_last_seen := '';
	qstring120 	company_name := '';
	qstring10 	prim_range := '';
	string2   	predir := '';
	qstring28 	prim_name := '';
	qstring4  	addr_suffix := '';
	string2   	postdir := '';
	qstring5  	unit_desig := '';
	qstring8  	sec_range := '';
	qstring25 	city := '';
	string2   	state := '';
	string5	 	zip := '';
	string4		zip4 := '';
	string10		phone := '';
	string10		fein := '';        
	unsigned1 	best_flags := 0;   // also ok not a string
end;
