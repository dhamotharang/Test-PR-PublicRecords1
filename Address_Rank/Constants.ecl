export Constants := module
	export	unsigned1	MaxRecordsToReturn := 10;
	export	JOIN_LIMIT := 10000;
	export	Validity_LIMIT := 9; //minimum input = did or (fullname and street_address and (city/st or zip) and (ssn or DOB)
end;