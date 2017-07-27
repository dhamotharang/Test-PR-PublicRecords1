import ut;

// Convert UCCv2 jurisdictions to their full names

export string jur2Name(string rawJur) := function

	jur := trim(rawJur);

	jurName := map(
		jur = 'NYC' 		=> 'NEW YORK CITY, NEW YORK',
		jur = 'TXD' 		=> 'DALLAS COUNTY, TEXAS',
		jur = 'TXH' 		=> 'HARRIS COUNTY, TEXAS',
		length(jur) = 2 => ut.St2Name(jur),
		''
	);

	return if( jurName<>'', jurName, jur);

end;