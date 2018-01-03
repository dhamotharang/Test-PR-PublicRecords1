import doxie, ut, data_services;

todaysdate := ut.GetDate;
checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;


slimrec :=
RECORD
	unsigned6	did;
	UNSIGNED1 criminal_count;
	UNSIGNED1 criminal_count30;
	UNSIGNED1 criminal_count90;
	UNSIGNED1 criminal_count180;
	UNSIGNED1 criminal_count12;
	UNSIGNED1 criminal_count24;
	UNSIGNED1 criminal_count36;
	UNSIGNED1 criminal_count60;
	unsigned4 last_criminal_date;
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



slimrec add_doc(doxie_files.File_Offenders le) :=
TRANSFORM
	SELF.criminal_count := 1;
	SELF.crim_case_num := le.case_num;
	self.did := (unsigned6)le.did;
	
	self.last_criminal_date := (unsigned4)le.case_date;
	
	self.criminal_count30 := (integer)checkDays(todaysDate,le.case_date,30);
	self.criminal_count90 := (integer)checkDays(todaysDate,le.case_date,90);
	self.criminal_count180 := (integer)checkDays(todaysDate,le.case_date,180);
	self.criminal_count12 := (integer)checkDays(todaysDate,le.case_date,ut.DaysInNYears(1));
	self.criminal_count24 := (integer)checkDays(todaysDate,le.case_date,ut.DaysInNYears(2));
	self.criminal_count36 := (integer)checkDays(todaysDate,le.case_date,ut.DaysInNYears(3));
	self.criminal_count60 := (integer)checkDays(todaysDate,le.case_date,ut.DaysInNYears(5));
	
	// add arrests here, data_type=5
	isArrest := le.data_type = '5';
	self.arrests_count := (unsigned)isArrest;
	self.date_last_arrest := if(isArrest, (unsigned4)le.case_date, 0);	// using the case date for the arrest date
	self.arrests_count30 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,30), 0);
	self.arrests_count90 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,90), 0);
	self.arrests_count180 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,180), 0);
	self.arrests_count12 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,ut.DaysInNYears(1)), 0);
	self.arrests_count24 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,ut.DaysInNYears(2)), 0);
	self.arrests_count36 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,ut.DaysInNYears(3)), 0);
	self.arrests_count60 := if(isArrest, (unsigned)checkDays(todaysDate,le.case_date,ut.DaysInNYears(5)), 0);
END;

doc_added := PROJECT(doxie_files.file_offenders((integer)did != 0), add_doc(LEFT));


slimrec roll_doc(doc_added le, doc_added ri) :=
TRANSFORM
	SELF.criminal_count := le.criminal_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count);
	SELF.criminal_count30 := le.criminal_count30+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count30);
	SELF.criminal_count90 := le.criminal_count90+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count90);
	SELF.criminal_count180 := le.criminal_count180+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count180);
	SELF.criminal_count12 := le.criminal_count12+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count12);
	SELF.criminal_count24 := le.criminal_count24+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count24);
	SELF.criminal_count36 := le.criminal_count36+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count36);
	SELF.criminal_count60 := le.criminal_count60+IF(le.crim_case_num=ri.crim_case_num,0,ri.criminal_count60);
	self.last_criminal_date := ut.max2(le.last_criminal_date,ri.last_criminal_date);
	
	self.arrests_count := le.arrests_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count);
	self.arrests_count30 := le.arrests_count30+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count30);
	self.arrests_count90 := le.arrests_count90+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count90);
	self.arrests_count180 := le.arrests_count180+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count180);
	self.arrests_count12 := le.arrests_count12+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count12);
	self.arrests_count24 := le.arrests_count24+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count24);
	self.arrests_count36 := le.arrests_count36+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count36);
	self.arrests_count60 := le.arrests_count60+IF(le.crim_case_num=ri.crim_case_num,0,ri.arrests_count60);
	self.date_last_arrest := ut.max2(le.date_last_arrest,ri.date_last_arrest);
	
	SELF := le;
END;

doc_rolled := ROLLUP(SORT(DISTRIBUTE(doc_added,HASH(did)),did,crim_case_num, local), LEFT.did=RIGHT.did, roll_doc(LEFT,RIGHT), local);

export Key_BocaShell_Crim := index(doc_rolled, 
                                   {did}, 
                                   {doc_rolled},
                                   data_services.data_location.prefix() + 'thor_data400::key::corrections_offenders::bocashell_did_' + doxie.Version_SuperKey);