export Layout_Voters_VoteHistory := record
	unsigned6 vtid        := 0;
	string4   voted_year  := '';
	string2   primary     := '';
	string2   special_1   := '';
	string2   other       := '';
	string2   special_2   := '';
	string2   general     := '';
	string2   pres        := '';
	string8   vote_date   := '';  
end;