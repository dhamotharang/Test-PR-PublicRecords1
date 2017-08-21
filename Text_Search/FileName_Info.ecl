// Data to construct file names
EXPORT FileName_Info := INTERFACE
	EXPORT STRING		stem;
	EXPORT STRING		srcType;
	EXPORT STRING		qual;
  EXPORT BOOLEAN  incr;
	EXPORT INTEGER	gens := 4;					// number of generations to manage
	EXPORT SET OF STRING genSet := ['QA','FATHER','GRANDFATHER','DELETE'];	//qualifier set
  EXPORT INTEGER incrs := 3;
  EXPORT SET OF STRING incrSet:= ['CURR_INCR', 'PREV_INCR', 'DELETE_INCR'];
	EXPORT UNSIGNED nameVersion := 2;		// current version of naming
	EXPORT INTEGER	dataVersion := 0;		// version of the data to build
END;
