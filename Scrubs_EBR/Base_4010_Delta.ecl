IMPORT SALT311,STD;
EXPORT Base_4010_Delta(DATASET(Base_4010_Layout_EBR)old_s, DATASET(Base_4010_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','orig_date_filed_yymmdd','type_code','type_desc','action_code','action_desc','document_number','liability_amt','asset_amt','date_filed'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_4010_hygiene(old_s).Summary('Old') + Base_4010_hygiene(new_s).Summary('New') + Base_4010_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_4010_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_4010_hygiene(PROJECT(Differences(added), TRANSFORM(Base_4010_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_4010_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
