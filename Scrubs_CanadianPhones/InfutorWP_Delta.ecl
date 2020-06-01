IMPORT SALT311,STD;
EXPORT InfutorWP_Delta(DATASET(InfutorWP_Layout_CanadianPhones)old_s, DATASET(InfutorWP_Layout_CanadianPhones) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['can_phone','can_title','can_fname','can_lname','can_suffix','can_address1','can_house','can_predir','can_street','can_strtype','can_postdir','can_apttype','can_aptnbr','can_city','can_province','can_postalcd','can_lang','can_rectype'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := InfutorWP_hygiene(old_s).Summary('Old') + InfutorWP_hygiene(new_s).Summary('New') + InfutorWP_hygiene(PROJECT(Differences(deleted), TRANSFORM(InfutorWP_Layout_CanadianPhones, SELF := LEFT.old_rec))).Summary('Deletions') + InfutorWP_hygiene(PROJECT(Differences(added), TRANSFORM(InfutorWP_Layout_CanadianPhones, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_CanadianPhones, InfutorWP_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
