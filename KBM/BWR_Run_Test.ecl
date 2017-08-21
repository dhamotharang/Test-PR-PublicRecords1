import ut;
// ff := kbm.filtered_file;

// Run Stats


func(DATASET(recordof(kbm.filtered_file)) ff, STRING StringAppend) :=
FUNCTION

// Count records per zip 
r1 :=
RECORD
	ff.zip5;
	cnt := COUNT(GROUP);
END;
t1 := TABLE(ff,r1,zip5,local);

// Count dids per zip
dd1_ff := DEDUP(ff,did,all);
dd2_ff := DEDUP(SORT(ff,did,zip5,local),did,zip5,local);

r2 :=
RECORD
	ff.zip5;
	cnt := COUNT(GROUP);
END;
t2 := TABLE(dd2_ff,r2,zip5,local);

OUTPUT(COUNT(ff),NAMED('TotalRecordsAvailable'+StringAppend));
OUTPUT(SORT(t1,zip5),NAMED('RecordsByZip'+StringAppend));
OUTPUT(COUNT(dd1_ff),NAMED('TotalDidsAvailable'+StringAppend));
output(SORT(t2,zip5),NAMED('DidsByZip'+StringAppend));

output(CHOOSEN(ff,75000),,'~thor_data50::out::kbm::'+StringAppend,csv);

RETURN 0;
END;

age := ut.GetAgeI((INTEGER)kbm.Filtered_File.dob);
is_Test1 := age BETWEEN 18 AND 30;
is_Test2 := age >= 31;

func(kbm.Filtered_File(is_Test1), '18To30');
func(kbm.Filtered_File(is_Test2), '31Plus');
