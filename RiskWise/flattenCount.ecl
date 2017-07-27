export flattenCount(integer L, integer R, integer S=1) :=  function
	int := if (l < r , l, r);
	out := intformat(int,S,1);	// zero pad the count
	return out;
end;