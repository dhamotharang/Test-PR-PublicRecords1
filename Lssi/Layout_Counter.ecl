export Layout_Counter :=
RECORD
	Layout_SlimCounter;
	// original in
	UNSIGNED4 orig_city1;
	UNSIGNED4 orig_city2;
	UNSIGNED4 orig_city3;
	// new in
	INTEGER Age;
	UNSIGNED8 states;
	UNSIGNED4 city1;
	UNSIGNED4 city2;
	UNSIGNED4 city3;
	UNSIGNED4 coHabFname1;
	UNSIGNED4 coHabFname2;
	UNSIGNED4 coHabFname3;
	QSTRING20 ffirst;
	QSTRING20 flast;
	UNSIGNED4 lname1; 	// for Maiden
	UNSIGNED4 lname2;
	UNSIGNED4 lname3;
END;