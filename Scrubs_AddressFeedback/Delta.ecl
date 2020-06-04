IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_AddressFeedback)old_s, DATASET(Layout_AddressFeedback) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['did','did_score','raw_aid','hhid','address_feedback_id','login_history_id','phone_number','unique_id','fname','lname','mname','orig_street_pre_direction','orig_street_post_direction','orig_street_number','orig_street_name','orig_street_suffix','orig_unit_number','orig_unit_designation','orig_zip5','orig_zip4','orig_city','orig_state','street_pre_direction','street_post_direction','street_number','street_name','street_suffix','unit_number','unit_designation','zip5','zip4','city','state','alt_phone','other_info','address_contact_type','feedback_source','date_time_added','loginid','companyid'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_AddressFeedback, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_AddressFeedback, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_AddressFeedback, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
