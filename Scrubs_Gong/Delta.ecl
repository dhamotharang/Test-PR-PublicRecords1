IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_File_Neustar)old_s, DATASET(Layout_File_Neustar) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['ACTION_CODE','RECORD_ID','RECORD_TYPE','TELEPHONE','LISTING_TYPE','BUSINESS_NAME','BUSINESS_CAPTIONS','CATEGORY','INDENT','LAST_NAME','SUFFIX_NAME','FIRST_NAME','MIDDLE_NAME','PRIMARY_STREET_NUMBER','PRE_DIR','PRIMARY_STREET_NAME','PRIMARY_STREET_SUFFIX','POST_DIR','SECONDARY_ADDRESS_TYPE','SECONDARY_RANGE','CITY','STATE','ZIP_CODE','ZIP_PLUS4','LATITUDE','LONGITUDE','LAT_LONG_MATCH_LEVEL','UNLICENSED','ADD_DATE','OMIT_ADDRESS','DATA_SOURCE','unknownField','TransactionID','Original_Suffix','Original_First_Name','Original_Middle_Name','Original_Last_Name','Original_Address','Original_Last_Line','filename'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_File_Neustar, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_File_Neustar, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Gong, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
