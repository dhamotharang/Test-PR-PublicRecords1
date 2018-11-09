IMPORT SALT38,STD;
EXPORT party_aka_dba_Delta(DATASET(party_aka_dba_Layout_SANCTNKeys)old_s, DATASET(party_aka_dba_Layout_SANCTNKeys) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['batch_number','incident_number','party_number','record_type','order_number','name_type','last_name','first_name','middle_name','aka_dba_text'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := party_aka_dba_hygiene(old_s).Summary('Old') + party_aka_dba_hygiene(new_s).Summary('New') + party_aka_dba_hygiene(PROJECT(Differences(deleted), TRANSFORM(party_aka_dba_Layout_SANCTNKeys, SELF := LEFT.old_rec))).Summary('Deletions') + party_aka_dba_hygiene(PROJECT(Differences(added), TRANSFORM(party_aka_dba_Layout_SANCTNKeys, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SANCTNKeys, party_aka_dba_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
