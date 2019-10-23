IMPORT SALT311,STD;
EXPORT Party_Delta(DATASET(Party_Layout_Official_Records)old_s, DATASET(Party_Layout_Official_Records) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['process_date','vendor','state_origin','county_name','official_record_key','doc_instrument_or_clerk_filing_num','doc_filed_dt','doc_type_desc','entity_sequence','entity_type_cd','entity_type_desc','entity_nm','entity_nm_format','entity_dob','entity_ssn','title1','fname1','mname1','lname1','suffix1','pname1_score','cname1','title2','fname2','mname2','lname2','suffix2','pname2_score','cname2','title3','fname3','mname3','lname3','suffix3','pname3_score','cname3','title4','fname4','mname4','lname4','suffix4','pname4_score','cname4','title5','fname5','mname5','lname5','suffix5','pname5_score','cname5','master_party_type_cd'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Party_hygiene(old_s).Summary('Old') + Party_hygiene(new_s).Summary('New') + Party_hygiene(PROJECT(Differences(deleted), TRANSFORM(Party_Layout_Official_Records, SELF := LEFT.old_rec))).Summary('Deletions') + Party_hygiene(PROJECT(Differences(added), TRANSFORM(Party_Layout_Official_Records, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Official_Records, Party_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
