IMPORT iesp;
EXPORT Constants := MODULE
  EXPORT MaxCollectionRecords := iesp.Constants.CollectionReport.MaxCollectionRecords;
  EXPORT DateFormat := ENUM(YYYYMMDD = 1, YYYYMM = 2);
END;