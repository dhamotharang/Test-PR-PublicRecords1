IMPORT SALT39,STD;
EXPORT Matter_Delta(DATASET(Matter_Layout_Civil_Court)old_s, DATASET(Matter_Layout_Civil_Court) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','parent_case_key','court_code','court','case_number','case_type_code','case_type','case_title','case_cause_code','case_cause','manner_of_filing_code','manner_of_filing','filing_date','manner_of_judgmt_code','manner_of_judgmt','judgmt_date','ruled_for_against_code','ruled_for_against','judgmt_type_code','judgmt_type','judgmt_disposition_date','judgmt_disposition_code','judgmt_disposition','disposition_code','disposition_description','disposition_date','suit_amount','award_amount'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Matter_hygiene(old_s).Summary('Old') + Matter_hygiene(new_s).Summary('New') + Matter_hygiene(PROJECT(Differences(deleted), TRANSFORM(Matter_Layout_Civil_Court, SELF := LEFT.old_rec))).Summary('Deletions') + Matter_hygiene(PROJECT(Differences(added), TRANSFORM(Matter_Layout_Civil_Court, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Civil_Court, Matter_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
