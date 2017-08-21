// Perform global terasort

#option('THOR_ROWCRC', 0); // don/t need individual row CRCs

rec := record
	 string10  key;
	 string10  seq;
	 string80  fill;
       end;

in := DATASET('nhtest::terasort1',rec,FLAT);
OUTPUT(SORT(in,key,UNSTABLE),,'nhtest::terasort1out',overwrite);