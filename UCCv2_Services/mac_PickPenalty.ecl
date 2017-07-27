export mac_PickPenalty(starting_score_arg = -1) := macro

	starting_score := if(starting_score_arg = -1, uccPenalty.large, starting_score_arg);
	
	Min2(integer A, integer B) :=  if ( A<B, A, B );
	partyPenalt := min2(starting_score, if(exists(r.parties), r.penalt, uccPenalty.large));
	self.penalt := min2(L.penalt, partyPenalt);
		
endmacro;
