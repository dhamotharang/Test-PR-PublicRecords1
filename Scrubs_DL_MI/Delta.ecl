IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_In_MI)old_s, DATASET(Layout_In_MI) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['process_date','code','customer_dln_pid','last_name','first_name','middle_name','name_suffix','street_address','city','state','zipcode','date_of_birth','gender','county','dln_pid_indicator','mailing_street_address','mailing_city','mailing_state','mailing_zipcode','blob','clean_name_prefix','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_In_MI, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_In_MI, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_MI, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
