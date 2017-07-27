export cleanFEIN(string9 fein) := function
	fein_val := IF(~(LENGTH(Stringlib.StringFilter(fein,'0123456789'))=9) or fein='000000000','',fein);	// blank out fein if it is all 0's or isn't numeric and 9 bytes long

	return fein_val;
end;