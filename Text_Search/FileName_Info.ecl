// Data to construct file names
EXPORT FileName_Info := INTERFACE
	EXPORT STRING		stem;
	EXPORT STRING		srcType;
	EXPORT STRING		qual;
	EXPORT INTEGER	gens := 4;					// number of generations to manage
	EXPORT SET OF STRING genSet := ['QA','FATHER','GRANDFATHER','DELETE'];	//qualifier set
	EXPORT UNSIGNED nameVersion := 2;		// current version of naming
	EXPORT INTEGER	dataVersion := 0;		// version of the data to build
END;
