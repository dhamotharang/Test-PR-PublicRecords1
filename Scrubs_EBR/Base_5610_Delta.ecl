IMPORT SALT311,STD;
EXPORT Base_5610_Delta(DATASET(Base_5610_Layout_EBR)old_s, DATASET(Base_5610_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','did','ssn','process_date','file_number','segment_code','sequence_number','officer_title','officer_first_name','officer_m_i','officer_last_name','clean_officer_name_title','clean_officer_name_fname','clean_officer_name_mname','clean_officer_name_lname','clean_officer_name_name_suffix'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_5610_hygiene(old_s).Summary('Old') + Base_5610_hygiene(new_s).Summary('New') + Base_5610_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_5610_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_5610_hygiene(PROJECT(Differences(added), TRANSFORM(Base_5610_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_5610_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
