EXPORT Constants_Status := 
MODULE

export set_defunct :=  ['FORFEITED','TERMINATED','DISSOLVED'];
export set_inactive := ['SUSPENDED','INACTIVE'];

export _rank(string status) := 
FUNCTION
	s := stringlib.stringtouppercase(status);
	return
	case(
		 s
		,'ACTIVE'										=> 1
		,'TERMINATED'								=> 2
		,'DISSOLVED'								=> 3
		,'SUSPENDED'								=> 4
		,'INACTIVE'									=> 5
		,'NOT IN GOOD STANDING'			=> 6
		,'FORFEITED'								=> 7
		,'DEFUNCT'					  			=> 8
		,'DORMANT'					  			=> 9
		,                              100
	);
END;//_rank

END;//Constants_Status