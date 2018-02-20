import ut;

export find_dob_match(string8 ldob,unsigned2 Age=0,string8 rdob_1,string8 rdob_2,string8 rdob_3,string8 rdob_4,string8 rdob_5,string8 rdob_6,string8 rdob_7,string8 rdob_8,
											string8 rdob_9,string8 rdob_10,unsigned2 dob_radius=-1):= FUNCTION 
											

	Ok_numerically(string8 L) :=Ut.isNumeric(L) and (integer) L[1..4] <> 0;
	matching(string8 L, string8 R,unsigned2 Age) := Ok_numerically(R) 
				and  ((Age > 0 and abs(Age - ut.Age((UNSIGNED)R)) <= dob_radius) or
						 (Ok_numerically(L) and abs((integer)L[1..4]-(integer)R[1..4]) <= dob_radius));
  match_1  := matching(ldob,rdob_1,Age);
	match_2  := matching(ldob,rdob_2,Age);
	match_3  := matching(ldob,rdob_3,Age);
	match_4  := matching(ldob,rdob_4,Age);
	match_5  := matching(ldob,rdob_5,Age);
	match_6  := matching(ldob,rdob_6,Age);
	match_7  := matching(ldob,rdob_7,Age);
	match_8  := matching(ldob,rdob_8,Age);
	match_9  := matching(ldob,rdob_9,Age);
	match_10 := matching(ldob,rdob_10,Age);
	match := match_1 or match_2 or match_3 or match_4 or match_5 or 
										match_6 or match_7 or match_8 or match_9 or match_10;
	dob_provided := Ok_numerically(rdob_1) or Ok_numerically(rdob_2) or Ok_numerically(rdob_3) or Ok_numerically(rdob_4) or Ok_numerically(rdob_5) or
									Ok_numerically(rdob_6) or Ok_numerically(rdob_7) or Ok_numerically(rdob_8) or Ok_numerically(rdob_9) or Ok_numerically(rdob_10);
	
	res := match  or (~ok_numerically(ldob) and Age=0) or ~dob_provided;

	return res;
END;
	
	