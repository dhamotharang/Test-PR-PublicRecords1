IMPORT SALT311,STD;
EXPORT Contacts_Delta(DATASET(Contacts_Layout_Equifax_Business_Data)old_s, DATASET(Contacts_Layout_Equifax_Business_Data) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['EFX_id','EFX_CONTCT','EFX_TITLECD','EFX_TITLEDESC','EFX_LASTNAM','EFX_FSTNAM','EFX_EMAIL','EFX_DATE'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Contacts_hygiene(old_s).Summary('Old') + Contacts_hygiene(new_s).Summary('New') + Contacts_hygiene(PROJECT(Differences(deleted), TRANSFORM(Contacts_Layout_Equifax_Business_Data, SELF := LEFT.old_rec))).Summary('Deletions') + Contacts_hygiene(PROJECT(Differences(added), TRANSFORM(Contacts_Layout_Equifax_Business_Data, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Equifax_Business_Data, Contacts_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
