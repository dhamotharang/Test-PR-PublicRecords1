EXPORT raidsReport_Layout := MODULE

EXPORT summaryRec := RECORD
    unsigned4 providerID;
    STRING 		description;
		unsigned 	importCount 	:= 0;
		STRING6 	importPct;
		unsigned 	allTimeCount	:= 0;
    STRING6 	allTimePct;
END;

EXPORT filesCountRec := RECORD
    unsigned4 providerID;
    STRING 		fileName;
		unsigned 	importCount  := 0;
		unsigned	allTimeCount := 0;
END;

EXPORT dateRangeRec := RECORD
    unsigned4 providerID;
    STRING  	description;
		STRING  	importDate;
		STRING  	allTimeDate;
END;

EXPORT coordinatesRec := RECORD
    unsigned4 providerID;
    STRING  	description;
		unsigned  importCount 	:= 0;
		STRING6		importPct;
		unsigned  allTimeCount 	:= 0;
	  STRING6 	allTimePct;
END;

EXPORT quarantinedRec := RECORD
    unsigned4 providerID;
    STRING  	incidentID;
    STRING  	Reason;
    STRING  	Notes;
END;

EXPORT deletedRec := RECORD
    unsigned4 providerID;
    STRING  	fileName;
		unsigned  recordCount := 0;
END;

EXPORT unclassifiedCrimeRec := RECORD
    unsigned4 providerID;
    STRING  	description;
END; 


EXPORT raidsReportRec := RECORD
  unsigned4 providerID;
	STRING ori; //From Data_provider table
	STRING data_provider_name; // From Data_provider table
	STRING reportEmail := '';  //From Data_Provider_Import
	STRING filename := ''; //Importer File name
	STRING dtImport := ''; //Import Date
	DATASET(summaryRec)  summaryTable;
	DATASET(filesCountRec) filesCountTable;
	DATASET(dateRangeRec) dateRangeTable;
	DATASET(coordinatesRec) coordinatesTable;
	DATASET(quarantinedRec) quarantinedTable;
	DATASET(deletedRec)    deletedTable;
	DATASET(unclassifiedCrimeRec) unclassifiedCrimeTable;
END;

EXPORT rfilesSent := RECORD
  UNSIGNED4 providerID;
  STRING filename;
	STRING emailAddress;
	STRING periodicity;
	STRING data_provider_name;
	STRING sent_date_time;
END;

END;

