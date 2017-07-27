
export mac_PickPenalty(starting_score = 100) :=
macro

	Min2(integer L, integer R) :=  if ( l>r , r, l );
	self.penalt := min2(starting_score, if(exists(r.parties), r.penalt, 100));
	
ENDmacro;