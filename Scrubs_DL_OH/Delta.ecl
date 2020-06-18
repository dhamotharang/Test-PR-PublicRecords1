IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_In_oh)old_s, DATASET(Layout_In_oh) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['process_date','key_number','license_number','license_class','donor_flag','hair_color','eye_color','weight_l','height_feet','height_inches','sex_gender','permanent_license_issue_date','license_expiration_date','restriction_codes','endorsement_codes','first_name','middle_name','last_name','street_address','city','state','zip_code','county_number','birth_date','clean_name_prefix','clean_fname','clean_mname','clean_lname'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_In_oh, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_In_oh, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_OH, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
