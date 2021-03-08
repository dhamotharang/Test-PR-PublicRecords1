IMPORT ProfileBooster.ProfileBoosterV2_KEL, MDR, STD;

EXPORT Constants := MODULE
	EXPORT STRING KEL_KEY := '~key::kel::publicrecords_kel::pb20::person::uid';
	EXPORT STRING PB_WATCHDOG_KEY := '~thor_data400::key::watchdog_pb';

  EXPORT STRING MISSING_INPUT_DATA := '-99999';
  EXPORT STRING NO_DATA_FOUND := '-99998';
  EXPORT NO_DATA_FOUND_SET := ['-99998',''];
  EXPORT STRING RECS_AVAIL_BUT_CANNOT_CALCULATE := '-99997';
	
  EXPORT INTEGER MISSING_INPUT_DATA_INT := -99999;
  EXPORT INTEGER NO_DATA_FOUND_INT := -99998;
  EXPORT INTEGER RECS_AVAIL_BUT_CANNOT_CALCULATE_INT := -99997;

  EXPORT INTEGER DEFAULT_JOIN_LIMIT := 10000;

  // This is the set of explicitly Allowed Sources for use within the Analytic Library.  If a record doesn't belong to one of these sources, it will be blocked from usage
  // TODO: KS-1968 - Define the set of ALLOWED_SOURCES.
  EXPORT SET OF STRING2 ALLOWED_SOURCES := [];
  
  // This is a set of the explicitly allowed Marketing Sources for use within the Analytic Library.  If a record doesn't belong to one of these sources, it will be blocked from usage in Marketing Products
  EXPORT SET OF STRING2 ALLOWED_MARKETING_SOURCES := 
	MDR.SourceTools.set_Marketing_Sources + 
	MDR.SourceTools.set_Marketing_Veh + 
	[MDR.SourceTools.src_Dunndata_Consumer]; 

	
	EXPORT VALIDATE_YEAR_RANGE_LOW_DOB := 1800;
	EXPORT VALIDATE_YEAR_RANGE_HIGH_DOB := ((INTEGER)(((STRING8)STD.Date.Today())[1..4]) + 100);
	
	EXPORT VALIDATE_YEAR_RANGE_LOW_ARCHIVEDATE := ((INTEGER)(((STRING8)STD.Date.Today())[1..4]) - 120);
	EXPORT VALIDATE_YEAR_RANGE_HIGH_ARCHIVEDATE := (INTEGER)(((STRING8)STD.Date.Today())[1..4]);
	
	EXPORT FraudPoint3Source := '$F'; //FDN data - FD, FN, DN, were all taken in MDR
END;