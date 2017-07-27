import ut;

ip := header_slimsort.propagated_matchrecs;
hdrs := ip(lname <> '' AND fname <> '');

IsValidDate(INTEGER i) := 
	(STRING)i >= '19000000' AND 
	(STRING)i <= ut.GetDate;

Layout_Name_Age_Zip_SSN4 Proj(hdrs le) := TRANSFORM
	SELF.age := IF (IsValidDate(le.dob), ut.GetAge((STRING) le.dob), 0);
	SELF.ssn4 := (UNSIGNED2) (INTFORMAT((INTEGER) le.ssn, 9, 1)[6..9]);
	SELF := le;
END;

t := PROJECT(hdrs, Proj(LEFT));

init := t;
initd := DISTRIBUTE(init, HASH(lname + fname[1]));

lmfzass := SORT(initd, zip, age, ssn4, lname, did, fname, mname, LOCAL);
lmfzasg := GROUP(lmfzass, zip, age, ssn4, lname, LOCAL);
lmfzasd := DEDUP(lmfzasg, did, fname, mname);

export name_zip_age_ssn4_init := GROUP(lmfzasd) : PERSIST('headerbuild_hss_name_zip_age_ssn4_init');