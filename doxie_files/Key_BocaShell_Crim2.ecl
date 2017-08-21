import doxie, doxie_files, ut, std;

todaysdate := (STRING8)Std.Date.Today();
checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;


slimrec :=
RECORD
	unsigned6	did;
	UNSIGNED1 criminal_count;
	unsigned4 last_criminal_date;
	UNSIGNED1 felony_count;
	unsigned4 last_felony_date;
	UNSIGNED1 criminal_count30;
	UNSIGNED1 criminal_count90;
	UNSIGNED1 criminal_count180;
	UNSIGNED1 criminal_count12;
	UNSIGNED1 criminal_count24;
	UNSIGNED1 criminal_count36;
	UNSIGNED1 criminal_count60;
	
	string35 crim_case_num;
	unsigned1 arrests_count;
	unsigned4 date_last_arrest;
	unsigned1 arrests_count30;
	unsigned1 arrests_count90;
	unsigned1 arrests_count180;
	unsigned1 arrests_count12;
	unsigned1 arrests_count24;
	unsigned1 arrests_count36;
	unsigned1 arrests_count60;
END;



slimrec add_doc(doxie_files.File_Offenders_Risk le) :=
TRANSFORM
	isFelony := le.criminal_offender_level='4' and le.offense_score='F';
	
	SELF.criminal_count := 1;
	SELF.felony_count := if(isFelony,1, 0);
	SELF.crim_case_num := le.case_num;
	self.did := (unsigned6)le.did;
	
	self.last_criminal_date := (unsigned4)le.earliest_offense_date;
	self.last_felony_date := if(isFelony,(unsigned4)le.earliest_offense_date, 0);
	self.criminal_count30 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,30), 1, 0);
	self.criminal_count90 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,90), 1, 0);
	self.criminal_count180 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,180), 1, 0);
	self.criminal_count12 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(1)), 1, 0);
	self.criminal_count24 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(2)), 1, 0);
	self.criminal_count36 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(3)), 1, 0);
	self.criminal_count60 := if(isFelony and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(5)), 1, 0);
	
	// add arrests here, data_type=5
	isArrest := le.data_type = '5';
	self.arrests_count := (unsigned)isArrest;
	self.date_last_arrest := if(isArrest, (unsigned4)le.earliest_offense_date, 0);	// using the case date for the arrest date
	self.arrests_count30 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,30), 1, 0);
	self.arrests_count90 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,90), 1, 0);
	self.arrests_count180 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,180), 1, 0);
	self.arrests_count12 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(1)), 1, 0);
	self.arrests_count24 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(2)), 1, 0);
	self.arrests_count36 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(3)), 1, 0);
	self.arrests_count60 := if(isArrest and checkDays(todaysDate,le.earliest_offense_date,ut.DaysInNYears(5)), 1, 0);
END;

doc_added := PROJECT(doxie_files.File_Offenders_Risk((integer)did != 0), add_doc(LEFT));


slimrec roll_crim_counts(doc_added le, doc_added ri) :=
TRANSFORM
	SELF.criminal_count := le.criminal_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count);
	SELF.criminal_count30 := le.criminal_count30+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count30);
	SELF.criminal_count90 := le.criminal_count90+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count90);
	SELF.criminal_count180 := le.criminal_count180+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count180);
	SELF.criminal_count12 := le.criminal_count12+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count12);
	SELF.criminal_count24 := le.criminal_count24+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count24);
	SELF.criminal_count36 := le.criminal_count36+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count36);
	SELF.criminal_count60 := le.criminal_count60+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count60);
	self.last_criminal_date := max(le.last_criminal_date,ri.last_criminal_date);
	self.last_felony_date := max(le.last_felony_date,ri.last_felony_date);
	SELF.felony_count := le.felony_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.felony_count);
	SELF := ri;
END;

crim_sorted := SORT(DISTRIBUTE(doc_added,HASH(did)),did,crim_case_num,-felony_count, -last_felony_date, -criminal_count, -last_criminal_date, local);
crim_counts_rolled := ROLLUP(crim_sorted, LEFT.did=RIGHT.did, roll_crim_counts(LEFT,RIGHT), local);



slimrec roll_arrest_counts(doc_added le, doc_added ri) :=
TRANSFORM
	self.arrests_count := le.arrests_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count);
	self.arrests_count30 := le.arrests_count30+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count30);
	self.arrests_count90 := le.arrests_count90+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count90);
	self.arrests_count180 := le.arrests_count180+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count180);
	self.arrests_count12 := le.arrests_count12+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count12);
	self.arrests_count24 := le.arrests_count24+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count24);
	self.arrests_count36 := le.arrests_count36+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count36);
	self.arrests_count60 := le.arrests_count60+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count60);
	self.date_last_arrest := max(le.date_last_arrest,ri.date_last_arrest);
	SELF := ri;
END;

arrests_sorted := SORT(DISTRIBUTE(doc_added,HASH(did)),did,crim_case_num,-arrests_count, -date_last_arrest, local);
arrest_counts_rolled := ROLLUP(arrests_sorted, LEFT.did=RIGHT.did, roll_arrest_counts(LEFT,RIGHT), local);


j := join(distribute(crim_counts_rolled, hash(did)), 
					distribute(arrest_counts_rolled, hash(did)), 
					left.did=right.did,
					transform(slimrec,
						SELF.criminal_count := left.criminal_count;
						SELF.criminal_count30 := left.criminal_count30;
						SELF.criminal_count90 := left.criminal_count90;
						SELF.criminal_count180 := left.criminal_count180;
						SELF.criminal_count12 := left.criminal_count12;
						SELF.criminal_count24 := left.criminal_count24;
						SELF.criminal_count36 := left.criminal_count36;
						SELF.criminal_count60 := left.criminal_count60;
						self.last_criminal_date := left.last_criminal_date;
						self.last_felony_date := left.last_felony_date;
						SELF.felony_count := left.felony_count;
						SELF := right;),
						local);

export Key_BocaShell_Crim2 := index(j, {did}, {j},'~thor_data400::key::corrections_offenders_risk::bocashell_did_' + doxie.Version_SuperKey);
