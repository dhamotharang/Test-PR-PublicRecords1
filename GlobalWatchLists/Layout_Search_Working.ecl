export Layout_Search_Working :=
RECORD
	unsigned6 seq;
	UNSIGNED6 id;
	DATASET({unsigned6 id}) ids {MAXCOUNT(10000)};
	STRING name {MAXLENGTH(500)};
	STRING8 dob;
	string20 country;
	DATASET(Layout_SearchFile) tokens {MAXCOUNT(50)};
	REAL8 score;
	unsigned version_number;
END;