IMPORT SALT311,STD;
EXPORT BS_Delta(DATASET(BS_Layout_Business_Credit)old_s, DATASET(BS_Layout_Business_Credit) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['segment_identifier','file_sequence_number','parent_sequence_number','account_base_number','business_name','web_address','guarantor_owner_indicator','relationship_to_business_indicator','percent_of_liability','percent_of_ownership_if_owner_principal'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := BS_hygiene(old_s).Summary('Old') + BS_hygiene(new_s).Summary('New') + BS_hygiene(PROJECT(Differences(deleted), TRANSFORM(BS_Layout_Business_Credit, SELF := LEFT.old_rec))).Summary('Deletions') + BS_hygiene(PROJECT(Differences(added), TRANSFORM(BS_Layout_Business_Credit, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Business_Credit, BS_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
