import doxie;

f := lssi.File_QuestionFile;

// remove DID and dedup
no_did :=
RECORD
	f.city;
	f.st;
	f.lname4;
	f.fname3;
	f.incAge;
	f.incSt;
	f.incCity;
	f.incCoHabit;
	f.incFname;
	f.incLast;
	f.incMaiden;
	f.incCode;
	f.incCost;
	f.prob;
END;

t := TABLE(f, no_did);

d := DEDUP(t, ALL);

export Key_Prep_Determiner := INDEX(d, {d}, '~thor_data400::key::lssi.determiner'+ thorlib.wuid());