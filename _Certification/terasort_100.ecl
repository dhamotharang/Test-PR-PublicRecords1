// Perform global terasort (Graysort)

#option('THOR_ROWCRC', 0); // don/t need individual row CRCs


rec := record
	 string10  key;
	 string10  seq;
	 string80  fill;
       end;

in := DATASET('nhtest::terasort100',rec,FLAT);
OUTPUT(SORT(in,key,UNSTABLE),,'nhtest::terasort100out',overwrite);