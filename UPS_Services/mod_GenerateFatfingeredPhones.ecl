// "Fatfingering" in this context is when, during data entry, an adjacent key
// is struck instead of or in addition to the intended key.  We'll also include
// a repeat-strike in this sort of error.  For example, if I intended to type
// the digit "4" above the keyboard, I might accidentally type: "3", "5", "34",
// "43", "45", "54", or "44".
//
// This routine focuses on fatfingering in the context of phone numbers only,
// so we're looking at digits adjacent to other digits.  For the digits above
// letters on a keyboard, that means we can err to the left or right.  When the
// numeric keypad is also considered, additional errors are possible.

export mod_GenerateFatfingeredPhones(string10 p, boolean withKeypad=false) := MODULE

	export outrec := {string10 phone};
	
	// lists of adjacent digits
	shared set of string1 adjacent(string1 d) :=
		case(withKeypad,
			false => case(d,
				'1' => ['2'],
				'2' => ['1','3'],
				'3' => ['2','4'],
				'4' => ['3','5'],
				'5' => ['4','6'],
				'6' => ['5','7'],
				'7' => ['6','8'],
				'8' => ['7','9'],
				'9' => ['8','0'],
				'0' => ['9'],
				[]),
			true => case(d,
				'1' => ['0','2','4'],
				'2' => ['1','3','5'],
				'3' => ['2','4','6'],
				'4' => ['1','3','5','7'],
				'5' => ['2','4','6','8'],
				'6' => ['3','5','7','9'],
				'7' => ['4','6','8'],
				'8' => ['5','7','9'],
				'9' => ['6','8','0'],
				'0' => ['1','2','9'],
				[]),
			[]);
	
	// errant phone numbers for an error in one particular digit
	shared dataset(outrec) tweak(dataset(outrec) base, unsigned1 digit, set of string1 adj) :=
		normalize(base, count(adj), transform(outrec, self.phone := left.phone[1..(digit-1)] + adj[counter] + left.phone[(digit+1)..10])) +	// error in-place
		normalize(base, count(adj), transform(outrec, self.phone := left.phone[1..(digit-1)] + adj[counter] + left.phone[digit..10])) +			// error before
		normalize(base, count(adj), transform(outrec, self.phone := left.phone[1..digit] + adj[counter] + left.phone[(digit+1)..10])) +			// error after
		project(base, transform(outrec, self.phone := left.phone[1..digit] + left.phone[digit] + left.phone[(digit+1)..10]));								// error repeat
	
	// assimilate errant numbers for errors in each of 10 digits
	export dataset(outrec) ds := dedup(
		tweak(dataset([p],outrec), 1, adjacent(p[1])) +
		tweak(dataset([p],outrec), 2, adjacent(p[2])) +
		tweak(dataset([p],outrec), 3, adjacent(p[3])) +
		tweak(dataset([p],outrec), 4, adjacent(p[4])) +
		tweak(dataset([p],outrec), 5, adjacent(p[5])) +
		tweak(dataset([p],outrec), 6, adjacent(p[6])) +
		tweak(dataset([p],outrec), 7, adjacent(p[7])) +
		tweak(dataset([p],outrec), 8, adjacent(p[8])) +
		tweak(dataset([p],outrec), 8, adjacent(p[9])) +
		tweak(dataset([p],outrec), 10, adjacent(p[10])),
		all);
	
	// output sets
	export set of string10	set_phone10	:= set(ds, phone);
	export set of string7		set_phone7	:= set(dedup(ds, phone[4..10], all), phone[4..10]);
	export set of string3		set_phone3	:= set(dedup(ds, phone[1..3], all), phone[1..3]);

END;