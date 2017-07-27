// Provide a pecking order used to sort the best DID to the top (based on searched SSN) 
// Remainder of scores are merely to provide a reasonable, repeatable order.

export valid_ssn_score(string1 c) := CASE(c,
				'G' => 1,
				'F' => 2,
				'R' => 3,
				'Z' => 4,
				'O' => 5,
        'U' => 6,
				'B' => 7,
				'M' => 8, 9);				
