import address, header, watchdog, ut;

header_use := DISTRIBUTE(header.Prepped_For_Keys(city_name != '', st != '', lname != '', fname != ''), HASH(did));

Layout_Counter expandHeader(header_use L) :=
TRANSFORM
	SELF.did := L.did;
	SELF.city := L.city_name;
	SELF.orig_city1 := ut.bit_set(0, ut.Chr2Code(L.city_name[1]));
	SELF.orig_city2 := ut.bit_set(0, ut.Chr2Code(L.city_name[2]));
	SELF.orig_city3 := ut.bit_set(0, ut.Chr2Code(L.city_name[3]));
	SELF.st := L.st;
	SELF.lname4 := L.lname[1..4];
	SELF.fname3 := L.fname[1..3];
	SELF.ffirst := L.fname;
	SELF.flast := L.lname;
	SELF.states := L.states - ut.bit_set(0,ut.St2Code(L.st));
	SELF.city1 := L.city1;
	SELF.city2 := L.city2;
	SELF.city3 := L.city3;
	SELF.coHabFname1 := L.rel_fname1;
	SELF.coHabFname2 := L.rel_fname2;
	SELF.coHabFname3 := L.rel_fname3;
	SELF.lname1 := L.lname1;
	SELF.lname2 := L.lname2;
	SELF.lname3 := L.lname3;
	SELF.Age := 0;
END;
FullHeader := PROJECT(header_use, expandHeader(LEFT));

// get best age
Layout_Counter addAge (Fullheader L, Watchdog.File_best R) :=
TRANSFORM
	SELF.Age := IF(R.dob = 0, 0, ut.GetAge((STRING)R.dob));
	SElF := L;
END;
withAge := JOIN(FullHeader,	Watchdog.File_best, 
				LEFT.did = RIGHT.did, addAge(LEFT, RIGHT), LEFT OUTER, LOCAL);

uniqueRec := DISTRIBUTE(DEDUP(withAge, ALL, LOCAL), HASH(city, st, lname4, fname3));

//------------[ get base count ]-----------------------
uniqueBase := DEDUP(SORT(uniqueRec, city, st, lname4, fname3, did, LOCAL), 
					city, st, lname4, fname3, did, LOCAL);

BaseRecCount :=
RECORD
	uniqueBase.city;
	uniqueBase.st;
	uniqueBase.lname4;
	uniqueBase.fname3;
	unsigned4 cnt := COUNT(GROUP);
END;

BaseCount := TABLE(uniqueBase, BaseRecCount, city, st, lname4, fname3, LOCAL);

Layout_Counter addBaseCount (Layout_Counter L, BaseRecCount R) :=
TRANSFORM
	SELf.base_cnt := IF(R.cnt = 1, 0, 1);
	SELF := L;
END;
addedBaseCount := JOIN(uniqueRec, BaseCount, 
						LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND
											  LEFT.lname4 = RIGHT.lname4 AND LEFT.fname3 = RIGHT.fname3, 
						addBaseCount(LEFT, RIGHT), LEFT OUTER, LOCAL);

alreadyunique := addedBaseCount(base_cnt = 0);
notunique := addedBaseCount(base_cnt = 1);
toCount := notunique;

/* ******************************* Compare macros ****************************** */
age_comp() :=
MACRO
		// equal and not zero
	MAP(ABS(L.age - R.age) <= 5 AND (L.age != 0 AND R.age != 0) => 1,
		// zero
		L.age = 0 AND R.age = 0							 		=> 0,
		// not equal and not zero
		-1)
		
ENDMACRO;

state_comp() :=
MACRO
		// equal and not zero
	MAP(L.states&R.states != 0									=> 1,
		// zero
		L.states|R.states = 0									=> 0,
		// not equal not zero
		-1)
ENDMACRO;

city_comp() :=
MACRO
		// Any shared characters
	MAP((L.city1&R.city1 != L.orig_city1) OR
		(L.city2&R.city2 != L.orig_city2) OR
		(L.city3&R.city3 != L.orig_city3)						=> 1,
		// just the original city
		(L.city1=R.city1 AND L.city1 = L.orig_city1 AND
		 L.city2=R.city2 AND L.city2 = L.orig_city2 AND
		 L.city3=R.city3 AND L.city3 = L.orig_city3)			=> 0,
		 // different cities
		 -1)
ENDMACRO;

coHabit_comp() :=
MACRO
		// same name
	MAP((L.coHabFname1&R.coHabFname1 != 0 AND
		 L.coHabFname2&R.coHabFname2 != 0 AND
		 L.coHabFname3&R.coHabFname3 != 0)						=> 1,
		// no names
		(L.coHabFname1|R.coHabFname1 = 0 AND
		 L.coHabFname2|R.coHabFname2 = 0 AND
		 L.coHabFname3|R.coHabFname3 = 0)						=> 0,
		// different names
		-1)
		 
ENDMACRO;

Maiden_comp() :=
MACRO
		// Any shared characters
	MAP((L.lname1&R.lname1 != ut.bit_set(0, ut.Chr2Code(L.lname4[1]))) OR
		(L.lname2&R.lname2 != ut.bit_set(0, ut.Chr2Code(L.lname4[2]))) OR
		(L.lname3&R.lname3 != ut.bit_set(0, ut.Chr2Code(L.lname4[3])))					=> 1,
		// just the original name
		(L.lname1=R.lname1 AND L.lname1 = ut.bit_set(0, ut.Chr2Code(L.lname4[1])) AND
		 L.lname2=R.lname2 AND L.lname2 = ut.bit_set(0, ut.Chr2Code(L.lname4[2])) AND
		 L.lname3=R.lname3 AND L.lname3 = ut.bit_set(0, ut.Chr2Code(L.lname4[3])))		=> 0,
		// different names
		-1)
ENDMACRO;	 

FullFirst_comp() :=
MACRO
	IF(L.ffirst = R.ffirst, 1, -1)
ENDMACRO;

FullLast_comp() :=
MACRO
	IF(L.flast = R.flast, 1, -1)
ENDMACRO;

scorePicker(INTEGER l, INTEGER r) :=
MAP(l = r => r,
	(l = -1) OR (r = -1) => -1,
	(l = 1) OR (r = 1) => 1, 0);
	
/* ****************************** The Join ******************************* */



Layout_SlimCounter addAllCounts(Layout_Counter L, Layout_Counter R) :=
TRANSFORM
	// one extra
	SELF.base_age := age_comp();	
	SELF.base_states := state_comp();
	SELF.base_city := city_comp();		
	SELF.base_coHabit := coHabit_comp();		
	SELF.base_ffirst := FullFirst_comp();		
	SELF.base_flast := FullLast_comp();		
	SELF.base_maiden := Maiden_comp();		
	// two extra
	SELF.base_age_states := 	scorePicker(age_comp(), state_comp());
	SELF.base_age_city :=		scorePicker(age_comp(), 	city_comp());
	SELF.base_age_coHabit := 	scorePicker(age_comp(), 	coHabit_comp());
	SELF.base_age_ffirst := 	scorePicker(age_comp(), 	FullFirst_comp());
	SELF.base_age_flast := 		scorePicker(age_comp(), 	Fulllast_comp());
	SELF.base_age_maiden := 	scorePicker(age_comp(), 	Maiden_comp());
	SELF.base_states_city := 	scorePicker(state_comp(), 	city_comp());
	SELF.base_states_coHabit := scorePicker(state_comp(),	coHabit_comp());
	SELF.base_states_ffirst := 	scorePicker(state_comp(),	FullFirst_comp());
	SELF.base_states_flast := 	scorePicker(state_comp(),	Fulllast_comp());
	SELF.base_states_maiden := 	scorePicker(state_comp(),	Maiden_comp());
	SELF.base_city_coHabit := 	scorePicker(city_comp(), 	coHabit_comp());
	SELF.base_city_ffirst := 	scorePicker(city_comp(), 	FullFirst_comp());
	SELF.base_city_flast := 	scorePicker(city_comp(), 	Fulllast_comp());
	SELF.base_city_maiden := 	scorePicker(city_comp(), 	Maiden_comp());
	SELF.base_coHabit_ffirst := scorePicker(coHabit_comp(), FullFirst_comp());
	// three extra
	SELF.base_age_states_city := 		scorePicker(scorePicker(age_comp(),	state_comp()),	city_comp());
	SELF.base_age_states_coHabit := 	scorePicker(scorePicker(age_comp(),	state_comp()), 	coHabit_comp());
	SELF.base_age_states_ffirst := 		scorePicker(scorePicker(age_comp(),	state_comp()), 	FullFirst_comp());
	SELF.base_age_states_flast :=		scorePicker(scorePicker(age_comp(),	state_comp()), 	FullLast_comp());
	SELF.base_age_states_maiden := 		scorePicker(scorePicker(age_comp(),	state_comp()), 	Maiden_comp());
	SELF.base_age_city_coHabit := 		scorePicker(scorePicker(age_comp(),	city_comp()), 	coHabit_comp());
	SELF.base_age_city_ffirst := 		scorePicker(scorePicker(age_comp(), 	city_comp()), 	Fullfirst_comp());
	SELF.base_age_city_flast := 		scorePicker(scorePicker(age_comp(), 	city_comp()), 	FullLast_comp());
	SELF.base_age_city_maiden := 		scorePicker(scorePicker(age_comp(), 	city_comp()), 	Maiden_comp());
	SELF.base_states_city_coHabit := 	scorePicker(scorePicker(state_comp(),	city_comp()), 	coHabit_Comp());
	SELF.base_states_city_ffirst := 	scorePicker(scorePicker(state_comp(),	city_comp()), 	Fullfirst_comp());
	SELF.base_states_city_flast := 		scorePicker(scorePicker(state_comp(),	city_comp()), 	FullLast_comp());
	SELF.base_states_city_maiden := 	scorePicker(scorePicker(state_comp(),	city_comp()), 	Maiden_comp());
	// 4 extra
	SELF.base_age_states_city_coHabit := 	scorePicker(scorePicker(age_comp(),	state_comp()), 
													 scorePicker(city_comp(),	coHabit_comp()));
	SELF.base_age_states_city_ffirst := 	scorePicker(scorePicker(age_comp(),	state_comp()),
													 scorePicker(city_comp(),	fullfirst_comp()));
	SELF.base_age_states_city_flast := 		scorePicker(scorePicker(age_comp(),	state_comp()),
													 scorePicker(city_comp(),	fullLast_comp()));
	SELF.base_age_states_city_maiden := 	scorePicker(scorePicker(age_comp(),	state_comp()),
													 scorePicker(city_comp(),	Maiden_comp()));
	SELF := L;
END;
FullJoin := JOIN(toCount, toCount, LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND
									LEFT.lname4 = RIGHT.lname4 AND LEFT.fname3 = RIGHT.fname3 AND
									LEFT.did != RIGHT.did,
				 addAllCounts(LEFT, RIGHT), 
				 ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND
					   LEFT.lname4 = RIGHT.lname4 AND LEFT.fname3 = RIGHT.fname3,500), LOCAL);

SortDid := SORT(FullJoin, city, st, lname4, fname3, did, LOCAL);

// within a DID, what's the answer?
pickworst(integer4 l, integer4 r) := MAP(l = r => r,
								 (l = 1) OR (r = 1) => 1,
								 (l = -1) OR (r = -1) => -1, 0);
	
Layout_SlimCounter roller(Layout_SlimCounter L, Layout_SlimCounter R) :=
TRANSFORM
	SELF.base_age := pickworst(L.base_age, R.base_age);
	SELF.base_states := pickworst(L.base_states, R.base_states);
	SELF.base_city := pickworst(L.base_city, R.base_city);
	SELF.base_coHabit  := pickworst(L.base_coHabit , R.base_coHabit );
	SELF.base_ffirst  := pickworst(L.base_ffirst , R.base_ffirst );
	SELF.base_flast  := pickworst(L.base_flast , R.base_flast );
	SELF.base_maiden  := pickworst(L.base_maiden , R.base_maiden );
	SELF.base_age_states  := pickworst(L.base_age_states , R.base_age_states );
	SELF.base_age_city  := pickworst(L.base_age_city , R.base_age_city );
	SELF.base_age_coHabit  := pickworst(L.base_age_coHabit , R.base_age_coHabit );
	SELF.base_age_ffirst  := pickworst(L.base_age_ffirst , R.base_age_ffirst );
	SELF.base_age_flast  := pickworst(L.base_age_flast , R.base_age_flast );
	SELF.base_age_maiden  := pickworst(L.base_age_maiden , R.base_age_maiden );
	SELF.base_states_city  := pickworst(L.base_states_city , R.base_states_city );
	SELF.base_states_coHabit  := pickworst(L.base_states_coHabit , R.base_states_coHabit );
	SELF.base_states_ffirst  := pickworst(L.base_states_ffirst , R.base_states_ffirst );
	SELF.base_states_flast  := pickworst(L.base_states_flast , R.base_states_flast );
	SELF.base_states_maiden  := pickworst(L.base_states_maiden , R.base_states_maiden );
	SELF.base_city_coHabit  := pickworst(L.base_city_coHabit , R.base_city_coHabit );
	SELF.base_city_ffirst  := pickworst(L.base_city_ffirst , R.base_city_ffirst );
	SELF.base_city_flast  := pickworst(L.base_city_flast , R.base_city_flast );
	SELF.base_city_maiden  := pickworst(L.base_city_maiden , R.base_city_maiden );
	SELF.base_coHabit_ffirst  := pickworst(L.base_coHabit_ffirst , R.base_coHabit_ffirst );
	SELF.base_age_states_city  := pickworst(L.base_age_states_city , R.base_age_states_city );
	SELF.base_age_states_coHabit  := pickworst(L.base_age_states_coHabit , R.base_age_states_coHabit );
	SELF.base_age_states_ffirst  := pickworst(L.base_age_states_ffirst , R.base_age_states_ffirst );
	SELF.base_age_states_flast  := pickworst(L.base_age_states_flast , R.base_age_states_flast );
	SELF.base_age_states_maiden  := pickworst(L.base_age_states_maiden , R.base_age_states_maiden );
	SELF.base_age_city_coHabit  := pickworst(L.base_age_city_coHabit , R.base_age_city_coHabit );
	SELF.base_age_city_ffirst  := pickworst(L.base_age_city_ffirst , R.base_age_city_ffirst );
	SELF.base_age_city_flast  := pickworst(L.base_age_city_flast , R.base_age_city_flast );
	SELF.base_age_city_maiden  := pickworst(L.base_age_city_maiden , R.base_age_city_maiden );
	SELF.base_states_city_coHabit  := pickworst(L.base_states_city_coHabit , R.base_states_city_coHabit );
	SELF.base_states_city_ffirst  := pickworst(L.base_states_city_ffirst , R.base_states_city_ffirst );
	SELF.base_states_city_flast  := pickworst(L.base_states_city_flast , R.base_states_city_flast );
	SELF.base_states_city_maiden  := pickworst(L.base_states_city_maiden , R.base_states_city_maiden );
	SELF.base_age_states_city_coHabit := pickworst(L.base_age_states_city_coHabit, R.base_age_states_city_coHabit);
	SELF.base_age_states_city_ffirst  := pickworst(L.base_age_states_city_ffirst , R.base_age_states_city_ffirst );
	SELF.base_age_states_city_flast  := pickworst(L.base_age_states_city_flast , R.base_age_states_city_flast );
	SELF.base_age_states_city_maiden  := pickworst(L.base_age_states_city_maiden , R.base_age_states_city_maiden );
	SELF := L;
END;
RollJoin := ROLLUP(SortDid, roller(LEFT, RIGHT), city, st, lname4, fname3, did, LOCAL);
RollGrouped := GROUP(RollJoin, city, st, lname4, fname3, LOCAL);

// Now, compute (negative) probability across DIDs
pos_test(integer i) := IF(i < 0, i, 0);
Layout_SlimCounter roller2(Layout_SlimCounter L, Layout_SlimCounter R) :=
TRANSFORM
	SELF.base_age := pos_test(L.base_age) + pos_test(R.base_age);
	SELF.base_states := pos_test(L.base_states) + pos_test(R.base_states);
	SELF.base_city := pos_test(L.base_city) + pos_test(R.base_city);
	SELF.base_coHabit  := pos_test(L.base_coHabit) + pos_test(R.base_coHabit);
	SELF.base_ffirst  := pos_test(L.base_ffirst) + pos_test(R.base_ffirst);
	SELF.base_flast  := pos_test(L.base_flast) + pos_test(R.base_flast);
	SELF.base_maiden  := pos_test(L.base_maiden) + pos_test(R.base_maiden);
	SELF.base_age_states  := pos_test(L.base_age_states) + pos_test(R.base_age_states);
	SELF.base_age_city  := pos_test(L.base_age_city) + pos_test(R.base_age_city);
	SELF.base_age_coHabit  := pos_test(L.base_age_coHabit) + pos_test(R.base_age_coHabit);
	SELF.base_age_ffirst  := pos_test(L.base_age_ffirst) + pos_test(R.base_age_ffirst);
	SELF.base_age_flast  := pos_test(L.base_age_flast) + pos_test(R.base_age_flast);
	SELF.base_age_maiden  := pos_test(L.base_age_maiden) + pos_test(R.base_age_maiden);
	SELF.base_states_city  := pos_test(L.base_states_city) + pos_test(R.base_states_city);
	SELF.base_states_coHabit  := pos_test(L.base_states_coHabit) + pos_test(R.base_states_coHabit);
	SELF.base_states_ffirst  := pos_test(L.base_states_ffirst) + pos_test(R.base_states_ffirst);
	SELF.base_states_flast  := pos_test(L.base_states_flast) + pos_test(R.base_states_flast);
	SELF.base_states_maiden  := pos_test(L.base_states_maiden) + pos_test(R.base_states_maiden);
	SELF.base_city_coHabit  := pos_test(L.base_city_coHabit) + pos_test(R.base_city_coHabit);
	SELF.base_city_ffirst  := pos_test(L.base_city_ffirst) + pos_test(R.base_city_ffirst);
	SELF.base_city_flast  := pos_test(L.base_city_flast) + pos_test(R.base_city_flast);
	SELF.base_city_maiden  := pos_test(L.base_city_maiden) + pos_test(R.base_city_maiden);
	SELF.base_coHabit_ffirst  := pos_test(L.base_coHabit_ffirst) + pos_test(R.base_coHabit_ffirst);
	SELF.base_age_states_city  := pos_test(L.base_age_states_city) + pos_test(R.base_age_states_city);
	SELF.base_age_states_coHabit  := pos_test(L.base_age_states_coHabit) + pos_test(R.base_age_states_coHabit);
	SELF.base_age_states_ffirst  := pos_test(L.base_age_states_ffirst) + pos_test(R.base_age_states_ffirst);
	SELF.base_age_states_flast  := pos_test(L.base_age_states_flast) + pos_test(R.base_age_states_flast);
	SELF.base_age_states_maiden  := pos_test(L.base_age_states_maiden) + pos_test(R.base_age_states_maiden);
	SELF.base_age_city_coHabit  := pos_test(L.base_age_city_coHabit) + pos_test(R.base_age_city_coHabit);
	SELF.base_age_city_ffirst  := pos_test(L.base_age_city_ffirst) + pos_test(R.base_age_city_ffirst);
	SELF.base_age_city_flast  := pos_test(L.base_age_city_flast) + pos_test(R.base_age_city_flast);
	SELF.base_age_city_maiden  := pos_test(L.base_age_city_maiden) + pos_test(R.base_age_city_maiden);
	SELF.base_states_city_coHabit  := pos_test(L.base_states_city_coHabit) + pos_test(R.base_states_city_coHabit);
	SELF.base_states_city_ffirst  := pos_test(L.base_states_city_ffirst) + pos_test(R.base_states_city_ffirst);
	SELF.base_states_city_flast  := pos_test(L.base_states_city_flast) + pos_test(R.base_states_city_flast);
	SELF.base_states_city_maiden  := pos_test(L.base_states_city_maiden) + pos_test(R.base_states_city_maiden);
	SELF.base_age_states_city_coHabit := pos_test(L.base_age_states_city_coHabit) + pos_test(R.base_age_states_city_coHabit);
	SELF.base_age_states_city_ffirst  := pos_test(L.base_age_states_city_ffirst) + pos_test(R.base_age_states_city_ffirst);
	SELF.base_age_states_city_flast  := pos_test(L.base_age_states_city_flast) + pos_test(R.base_age_states_city_flast);
	SELF.base_age_states_city_maiden  := pos_test(L.base_age_states_city_maiden) + pos_test(R.base_age_states_city_maiden);
	SELF.total_cnt := L.total_cnt + 1;
	SELF := L;
END;
RollDIDs := ROLLUP(RollGrouped, true, roller2(LEFT, RIGHT));

incAgeCount := 	[1, 8, 9,  10, 11, 12, 13, 24, 25, 26, 27, 28, 29, 30, 31, 32, 37, 38, 39, 40];
incStateCount := 	[2, 8, 14, 15, 16, 17, 18, 24, 25, 26, 27, 28, 33, 34, 35, 36, 37, 38, 39, 40];
incCityCount := 	[3, 9, 14, 19, 20, 21, 22, 24, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40];
incCoHabitCount :=	[4, 10, 15, 19, 23, 25, 29, 33, 37];
incfnameCount :=	[5, 11, 16, 20, 23, 26, 30, 34, 38];
incLastCount :=	[6, 12, 17, 21, 27, 31, 35, 39];
incMaidenCount :=	[7, 13, 18, 22, 28, 32, 36, 40];

checkWhat() :=
MACRO
	CASE(C, 
	1 => L.base_age,
	2 => L.base_states,
	3 => L.base_city,
	4 => L.base_coHabit ,
	5 => L.base_ffirst ,
	6 => L.base_flast ,
	7 => L.base_maiden ,
	8 => L.base_age_states ,
	9 => L.base_age_city ,
	10 => L.base_age_coHabit ,
	11 => L.base_age_ffirst ,
	12 => L.base_age_flast ,
	13 => L.base_age_maiden ,
	14 => L.base_states_city ,
	15 => L.base_states_coHabit ,
	16 => L.base_states_ffirst ,
	17 => L.base_states_flast ,
	18 => L.base_states_maiden ,
	19 => L.base_city_coHabit ,
	20 => L.base_city_ffirst ,
	21 => L.base_city_flast ,
	22 => L.base_city_maiden ,
	23 => L.base_coHabit_ffirst ,
	24 => L.base_age_states_city ,
	25 => L.base_age_states_coHabit ,
	26 => L.base_age_states_ffirst ,
	27 => L.base_age_states_flast ,
	28 => L.base_age_states_maiden ,
	29 => L.base_age_city_coHabit ,
	30 => L.base_age_city_ffirst ,
	31 => L.base_age_city_flast ,
	32 => L.base_age_city_maiden ,
	33 => L.base_states_city_coHabit ,
	34 => L.base_states_city_ffirst ,
	35 => L.base_states_city_flast ,
	36 => L.base_states_city_maiden ,
	37 => L.base_age_states_city_coHabit,
	38 => L.base_age_states_city_ffirst ,
	39 => L.base_age_states_city_flast ,
	40 => L.base_age_states_city_maiden, 1)
ENDMACRO;


lssi.Layout_Determiner makeNorm (Layout_SlimCounter L, INTEGER C) :=
TRANSFORM
	SELF.incAge := 	IF(C IN incAgeCount 	/* AND checkWhat() */, 'Y', '');
	SELF.incSt := 		IF(C IN incStateCount 	/* AND checkWhat() */, 'Y', '');
	SELF.incCity := 	IF(C IN incCityCount 	/* AND checkWhat() */, 'Y', '');
	SELF.incCoHabit := 	IF(C IN incCoHabitCount 	/* AND checkWhat() */, 'Y', '');
	SELF.incfname := 	IF(C IN incFnameCount 	/* AND checkWhat() */, 'Y', '');
	SELF.incLast := 	IF(C IN incLastCount 	/* AND checkWhat() */, 'Y', '');
	SELF.incMaiden := 	IF(C IN incMaidenCount 	/* AND checkWhat() */, 'Y', '');
	
	SELF.incCost := 	1*IF(SELF.incAge 		= 'Y', 1, 0) + 
					1*IF(SELF.incSt 		= 'Y', 1, 0) + 
					2*IF(SELF.incCity 		= 'Y', 1, 0) +
					7*IF(SELF.incCoHabit 	= 'Y', 1, 0) +
					7*IF(SELF.incfname 		= 'Y', 1, 0) +
					10*IF(SELF.incLast 		= 'Y', 1, 0) +
					10*IF(SELF.incMaiden 	= 'Y', 1, 0);
	SELF.incCode := ut.bit_set(0, IF(SELF.incAge 		= 'Y', 1, 0)) | 
					ut.bit_set(0, IF(SELF.incSt 		= 'Y', 2, 0)) |
					ut.bit_set(0, IF(SELF.incCity 	= 'Y', 3, 0)) |
					ut.bit_set(0, IF(SELF.incCoHabit 	= 'Y', 4, 0)) |
					ut.bit_set(0, IF(SELF.incfname 	= 'Y', 5, 0)) |
					ut.bit_set(0, IF(SELF.incLast 	= 'Y', 6, 0)) |
					ut.bit_set(0, IF(SELF.incMaiden 	= 'Y', 7, 0)) - ut.bit_set(0, 0);
	SELF.prob := IF(checkWhat() >= 0, 0, (-1*checkWhat() / L.total_cnt) * 100);
	SELF := L;
END;

// NEW: prob > 1 indicates that this is at all probable
n := NORMALIZE(RollDIDs, 40, makeNorm(LEFT, COUNTER))(prob > 0);

// still grouped
allSort := SORT(n, 	city, st, lname4, fname3, 
					incAge, incSt, incCity, incCoHabit, 
					incfname, incLast, incMaiden, -prob);

// remove all supersets
// remove all equal sets, such that city/st/lname4/fnam3/incCode is unique
// still grouped
allDdp := DEDUP(allSort, LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.lname4 = RIGHT.lname4 AND
						 LEFT.fname3 = RIGHT.fname3 AND
						 // LEFT is a subset of RIGHT
						 (LEFT.incCode|RIGHT.incCode = RIGHT.incCode) AND
						 // there is some intersection
						 (LEFT.incCode&RIGHT.incCode > 0) AND
						 // LEFT is always more likely
						 LEFT.prob >= RIGHT.prob);

singles_scored := 
allDdp( IF(incAge = 'Y', 1, 0) + 
		IF(incSt = 'Y', 1, 0) + 
		IF(incCity = 'Y', 1, 0) +
		IF(incCoHabit = 'Y', 1, 0) +
		IF(incfname = 'Y', 1, 0) +
		IF(incLast = 'Y', 1, 0) +
		IF(incMaiden = 'Y', 1, 0) = 1);

doubles_scored :=
allDdp( IF(incAge = 'Y', 1, 0) + 
		IF(incSt = 'Y', 1, 0) + 
		IF(incCity = 'Y', 1, 0) +
		IF(incCoHabit = 'Y', 1, 0) +
		IF(incfname = 'Y', 1, 0) +
		IF(incLast = 'Y', 1, 0) +
		IF(incMaiden = 'Y', 1, 0) = 2);

triples_scored :=
allDdp( IF(incAge = 'Y', 1, 0) + 
		IF(incSt = 'Y', 1, 0) + 
		IF(incCity = 'Y', 1, 0) +
		IF(incCoHabit = 'Y', 1, 0) +
		IF(incfname = 'Y', 1, 0) +
		IF(incLast = 'Y', 1, 0) +
		IF(incMaiden = 'Y', 1, 0) = 3);

quads_scored :=
allDdp( IF(incAge = 'Y', 1, 0) + 
		IF(incSt = 'Y', 1, 0) + 
		IF(incCity = 'Y', 1, 0) +
		IF(incCoHabit = 'Y', 1, 0) +
		IF(incfname = 'Y', 1, 0) +
		IF(incLast = 'Y', 1, 0) +
		IF(incMaiden = 'Y', 1, 0) = 4);


Lssi.Layout_Determiner keepLeft(Lssi.Layout_Determiner L) :=
TRANSFORM
	SELF := L;
END;


onetwo := JOIN(doubles_scored, singles_scored, (LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND 
										LEFT.lname4 = RIGHT.lname4 AND LEFT.fname3 = RIGHT.fname3) AND
										// RIGHT is a subset of LEFT
										(LEFT.incCode|RIGHT.incCode = LEFT.incCode) AND
										// RIGHT is better prob 
										RIGHT.prob >= LEFT.prob,
								keepLeft(LEFT), LEFT ONLY, LOCAL) + singles_scored;

onetwothree := JOIN(triples_scored, onetwo, (LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND 
										LEFT.lname4 = RIGHT.lname4 AND LEFT.fname3 = RIGHT.fname3) AND
										// RIGHT is a subset of LEFT
										(LEFT.incCode|RIGHT.incCode = LEFT.incCode) AND
										// RIGHT is better prob 
										RIGHT.prob >= LEFT.prob,
								keepLeft(LEFT), LEFT ONLY, LOCAL) + onetwo;

onetwothreefour := JOIN(quads_scored, onetwothree, (LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND 
										LEFT.lname4 = RIGHT.lname4 AND LEFT.fname3 = RIGHT.fname3) AND
										// RIGHT is a subset of LEFT
										(LEFT.incCode|RIGHT.incCode = LEFT.incCode) AND
										// RIGHT is better prob 
										RIGHT.prob >= LEFT.prob,
								keepLeft(LEFT), LEFT ONLY, LOCAL) + onetwothree;

lssi.Layout_Determiner makeDeterminer(alreadyunique L) :=
TRANSFORM
	SELF.incCode := 0;
	SELF.incCost := 0;
	SELF.prob := 100;
	SELF := L;
END; 
// remove extra dids
Unique2Determiner := DEDUP(PROJECT(alreadyunique, makeDeterminer(LEFT)), ALL, LOCAL);

export QuestionFile := Unique2Determiner+onetwothreefour;