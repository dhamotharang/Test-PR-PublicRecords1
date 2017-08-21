// Thor Certification query	(**** For problems, contact Tony Kirk (tkirk) ****)
//
// Successful output of count (Record_Count) should show:
// 		ECL server successfully instantiates an ECL Agent.
//		The ECL agent successfully connected to the Thor cluster and wrote a file out to disk
//
// Successful output of actual dataset (<cluster>::temp::thor_cert_<date>) should show:
//		Each node can read, write, and replicate data

// Defines the record
rNodeValues
 :=
  record
	integer2 intVal;
	string3	stringVal;
	boolean	boolVal;
	real realVal;
  end
 ;

// Define the dataset
export SortTest
 :=
  dataset([
		{001, 'abc', true, 1234},
		{002, 'bac', true, 123.4},
		{003, 'bca', false, 12.34},
		{004, 'bca', true, 1.234},
		{005, 'cba', true, 1234.1004},
		{006, 'abc', true, 1234.1003},
		{007, 'abc', false, 1234.103},
		{008, 'abc', true, 1234.12},
		{009, 'abc', false, 1234.1},
		{010, 'abc', true, 1234}
					], rNodeValues)
 ;
