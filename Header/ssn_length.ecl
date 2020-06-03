export ssn_length(string9 ssn) := FUNCTION
	len := length(trim(ssn));
	return MAP(ssn = '' or (integer) ssn = 0 => 0,  // empty or all zeros
						len < 9 => len,												// partial ssn, just use its length
						(integer) ssn[6..9] = 0 => 5,	        // first 5 populated, zero-padded last 4
						(integer) ssn[1..5] = 0 => 4,         // zero-padded first 5, last 4 populated
						9);
end;