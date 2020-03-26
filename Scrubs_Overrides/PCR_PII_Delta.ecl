IMPORT SALT311,STD;
EXPORT PCR_PII_Delta(DATASET(PCR_PII_Layout_Overrides)old_s, DATASET(PCR_PII_Layout_Overrides) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['uid','date_created','dt_first_seen','dt_last_seen','did','fname','mname','lname','name_suffix','ssn','dob','predir','prim_name','prim_range','suffix','postdir','unit_desig','sec_range','zip4','address','city_name','st','zip','phone','dl_number','dl_state','dispute_flag','security_freeze','security_freeze_pin','security_alert','negative_alert','id_theft_flag','insuff_inqry_data','consumer_statement_flag'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := PCR_PII_hygiene(old_s).Summary('Old') + PCR_PII_hygiene(new_s).Summary('New') + PCR_PII_hygiene(PROJECT(Differences(deleted), TRANSFORM(PCR_PII_Layout_Overrides, SELF := LEFT.old_rec))).Summary('Deletions') + PCR_PII_hygiene(PROJECT(Differences(added), TRANSFORM(PCR_PII_Layout_Overrides, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Overrides, PCR_PII_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
