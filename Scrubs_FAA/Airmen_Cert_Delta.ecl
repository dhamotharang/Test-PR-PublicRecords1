IMPORT SALT38,STD;
EXPORT Airmen_Cert_Delta(DATASET(Airmen_Cert_Layout_FAA)old_s, DATASET(Airmen_Cert_Layout_FAA) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['date_first_seen','date_last_seen','current_flag','letter','unique_id','rec_type','cer_type','cer_type_mapped','cer_level','cer_level_mapped','cer_exp_date','ratings','filler','lfcr','persistent_record_id'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Airmen_Cert_hygiene(old_s).Summary('Old') + Airmen_Cert_hygiene(new_s).Summary('New') + Airmen_Cert_hygiene(PROJECT(Differences(deleted), TRANSFORM(Airmen_Cert_Layout_FAA, SELF := LEFT.old_rec))).Summary('Deletions') + Airmen_Cert_hygiene(PROJECT(Differences(added), TRANSFORM(Airmen_Cert_Layout_FAA, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FAA, Airmen_Cert_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
