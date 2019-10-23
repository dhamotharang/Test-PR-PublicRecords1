IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_PhonesFeedback)old_s, DATASET(Layout_PhonesFeedback) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['did','did_score','hhid','phone_number','login_history_id','fname','lname','mname','street_pre_direction','street_post_direction','street_number','street_name','street_suffix','unit_number','unit_designation','zip5','zip4','city','state','alt_phone','other_info','phone_contact_type','feedback_source','date_time_added','loginid','customerid'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_PhonesFeedback, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_PhonesFeedback, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesFeedback, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
