export Layout_Vehicle_Key := RECORD
	string30 Vehicle_Key;
	string15 Iteration_Key;
	string15 Sequence_Key := '';
	string2	state_origin := ''; //needed for dppa stuff
	boolean is_deep_dive := false;
END;