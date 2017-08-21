EXPORT _readme := 'todo';
/*

to generate a full file:
(1) verify that the parameters are correc in Census_Options

ds := CensusRFP.Mac_Run();

OUTPUT(ds,,'~thor::results::census_bureau_rfp::nmnjmi',COMPRESSED,OVERWRITE);
OUTPUT(ENTH(ds,1,9000),,'~thor::results::census_bureau_rfp::nmnjmi::test',COMPRESSED,OVERWRITE);

CSV sample:
OUTPUT(ENTH(ds,1,9000),,'~thor::results::census_bureau_rfp::nmnjmi::sample.csv',
		       CSV(HEADING(SINGLE),SEPARATOR(','),TERMINATOR('\n')),OVERWRITE);










*/