export Constants := module

	EXPORT STRING1 MAIN_SUBJECT := 'C';
	EXPORT STRING1 SPOUSE       := 'S';

	EXPORT UNSIGNED1 RIGHT_PARTY_CONTACT                       := 1;
	EXPORT UNSIGNED1 RELATIVE_OR_ASSOCIATE_RIGHT_PARTY_CONTACT := 2;
	EXPORT UNSIGNED1 POTENTIAL_WRONG_PARTY_CLAIM               := 3;
	EXPORT UNSIGNED1 POTENTIAL_TEMPORARY_DISCONNECT            := 4;
	EXPORT UNSIGNED1 NO_FEEDBACK_REPORTED                      := 9;
	
	EXPORT STRING2 EXPERIAN_INQUIRY_PHONES := 'IN';
						
	export Defaults := module
		export integer MaxResults := 2000;
		export integer MaxResultsPerAcctno := 20;
	end;
	
	export Limits := module
		export integer MAX_JOIN_LIMIT := 10000;
	end;

	export Search_Errors := module
		export integer EXPERIAN_RECORD_FOUND     := 0;
		export integer GATEWAY_RECORD_FOUND      := 0;
		export integer EXPERIAN_RECORD_NOT_FOUND := 1;
		export integer GATEWAY_RECORD_NOT_FOUND  := 2;
	end;
	
end;