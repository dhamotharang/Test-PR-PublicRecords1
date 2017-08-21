export Layout_Out :=
RECORD
	unsigned6 seq;
	STRING10 LNID;
	BOOLEAN known;	// gotta DID
	STRING1 EntityType;
	BOOLEAN name_match;	// hit on patriot
	UNSIGNED1 name_match_score;
	UNSIGNED1 best_name_match_score;
	STRING20 name_match_fname;
	STRING20 name_match_mname;
	STRING20 name_match_lname;
	unsigned4 number_with_same_name; 	// NOT IMPLEMENTED FOR COMPANIES
	unsigned4 first_seen;						 	// NOT IMPLEMENTED FOR COMPANIES
	unsigned2 relative_count;					// NOT IMPLEMENTED FOR COMPANIES
	unsigned6 did;
	unsigned6 bdid;
	unsigned1 score_id;
	unsigned1 score_ssn;
	unsigned1 score_address;
	unsigned1 score_name;
	unsigned1 score_dob;
	Layout_Patriot WatchList;
END;