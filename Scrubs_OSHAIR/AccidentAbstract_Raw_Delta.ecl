IMPORT SALT311,STD;
EXPORT AccidentAbstract_Raw_Delta(DATASET(AccidentAbstract_Raw_Layout)old_s, DATASET(AccidentAbstract_Raw_Layout) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['summary_nr','line_nr'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := AccidentAbstract_Raw_hygiene(old_s).Summary('Old') + AccidentAbstract_Raw_hygiene(new_s).Summary('New') + AccidentAbstract_Raw_hygiene(PROJECT(Differences(deleted), TRANSFORM(AccidentAbstract_Raw_Layout, SELF := LEFT.old_rec))).Summary('Deletions') + AccidentAbstract_Raw_hygiene(PROJECT(Differences(added), TRANSFORM(AccidentAbstract_Raw_Layout, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, AccidentAbstract_Raw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
