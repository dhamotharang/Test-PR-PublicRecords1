import didville;

export Layout_ID_Batch := 
RECORD
	didville.Layout_Did_OutBatch;
	STRING20 name_match_fname;
	STRING20 name_match_mname;
	STRING20 name_match_lname;
	UNSIGNED1 name_match_score;
	UNSIGNED1 best_name_match_score;
	STRING10 LNID;
	UNSIGNED6 bdid := 0;
	STRING62 name;
	STRING1 EntityType := '';
	STRING10 pty_key;
	Layout_Patriot WatchList;
END;