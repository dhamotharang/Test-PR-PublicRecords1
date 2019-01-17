export varstring ErrorCodes(integer c) :=
	CASE(c,	
	    10  => 'No records found',
			11	=> 'Search is too broad',
			20  => 'No records found - gateway',
			21	=> 'Too many subjects found - gateway',
			22	=> 'Gateway returned a failure',
			203	=> 'Too many subjects found',
			301	=> 'Insufficient input',
			302 => 'At least three leading characters required',
			303 => 'Invalid input',
			305	=> 'Insufficient input: RI FCRA restriction',
			306	=> 'DID is provided in the input', // a warning, simply to reserve the code
			307	=> 'LexID was found but failed validation', // DID search doesn't necessarily use all input criteria,
                      //so subsequent verification against all input may be required (mainly, comp report usage)
			310 => 'Incomplete Address',
			311 => 'Highly populated address',
			2	  =>	'Need DPPA rights to see vehicle and dl data',
			3	  =>	'Reports must supply DID, BDID, Unique Identifier, or ST + Vehicle Number',
			23  =>   'License State and Number are both required for the search',
			100	=>	'Soap connection error',
			101	=>	'Invalid Configuration',
					    'Database Error');