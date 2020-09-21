IMPORT SALT311,STD;
EXPORT AccidentInjury_Raw_Delta(DATASET(AccidentInjury_Raw_Layout)old_s, DATASET(AccidentInjury_Raw_Layout) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['summary_nr','rel_insp_nr','age','sex','nature_of_inj','part_of_body','src_of_injury','event_type','evn_factor','hum_factor','occ_code','degree_of_inj','task_assigned','hazsub','const_op','const_op_cause','fat_cause','fall_distance','fall_ht','injury_line_nr'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := AccidentInjury_Raw_hygiene(old_s).Summary('Old') + AccidentInjury_Raw_hygiene(new_s).Summary('New') + AccidentInjury_Raw_hygiene(PROJECT(Differences(deleted), TRANSFORM(AccidentInjury_Raw_Layout, SELF := LEFT.old_rec))).Summary('Deletions') + AccidentInjury_Raw_hygiene(PROJECT(Differences(added), TRANSFORM(AccidentInjury_Raw_Layout, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, AccidentInjury_Raw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
