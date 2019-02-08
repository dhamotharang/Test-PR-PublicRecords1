IMPORT SALT311,STD;
EXPORT Flag_Delta(DATASET(Flag_Layout_Overrides)old_s, DATASET(Flag_Layout_Overrides) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['flag_file_id','did','file_id','record_id','override_flag','in_dispute_flag','consumer_statement_flag','fname','mname','lname','name_suffix','ssn','dob','riskwise_uid','user_added','date_added','known_missing','user_changed','date_changed','lf'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Flag_hygiene(old_s).Summary('Old') + Flag_hygiene(new_s).Summary('New') + Flag_hygiene(PROJECT(Differences(deleted), TRANSFORM(Flag_Layout_Overrides, SELF := LEFT.old_rec))).Summary('Deletions') + Flag_hygiene(PROJECT(Differences(added), TRANSFORM(Flag_Layout_Overrides, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Overrides, Flag_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
