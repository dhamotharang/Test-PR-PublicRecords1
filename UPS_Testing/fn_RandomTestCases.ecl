export DATASET(File_AutonomyQueries.layout) fn_RandomTestCases(UNSIGNED4 n) := FUNCTION

	UNSIGNED4 nrecs := File_AutonomyQueries.nrecs;
	UNSIGNED4 start := (RANDOM() % nrecs) + 1;
	UNSIGNED4 stop := start + n;
	UNSIGNED4 overflow := if (stop > nrecs, stop - nrecs, 0);

	output(n, named('n'));
	output(nrecs, named('nrecs'));
	output(start, named('start'));
	output(stop, named('stop'));
	output(overflow, named('overflow'));

	// recs := File_AutonomyQueries.records[start..stop];
	// return MAP(n > nrecs => File_AutonomyQueries.records,
						 // overflow = 0 => recs,
						 // recs  + File_AutonomyQueries.records[1..overflow]);
	return File_AutonomyQueries.records[1..2];
END;