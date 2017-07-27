
export mod_GenerateTransposedPhones(string10 p) := 
MODULE

export outrec := {string10 phone};
 
export ds := 
DATASET(
	[
	//these six get you transpositions in the last 7
		{p[1..8] + p[10] + p[9]},
		{p[1..7] + p[9] + p[8] + p[10]},
		{p[1..6] + p[8] + p[7] + p[9..10]},
		{p[1..5] + p[7] + p[6] + p[8..10]},
		{p[1..4] + p[6] + p[5] + p[7..10]},
		{p[1..3] + p[5] + p[4] + p[6..10]},
		
		//the next three get you the area code (and the first line is really a transposition shared by last 7 and area code)
		{p[1..2] + p[4] + p[3] + p[5..10]},
		{p[1] + p[3] + p[2] + p[4..10]},
		{p[2] + p[1] + p[3..10]}
		
		//was going to add something like 'hey, 9 out 10 digits match', but i think that requires a new key (or 10 lines for each digit, which seems like a performance waste)
	],
	outrec
);


export set of string10 set_phone10 := set(ds, phone);
export set of string7 set_phone7 := set(dedup(ds, phone[4..10], all), phone[4..10]);
export set of string3 set_phone3 := set(dedup(ds, phone[1..3], all), phone[1..3]);

END;