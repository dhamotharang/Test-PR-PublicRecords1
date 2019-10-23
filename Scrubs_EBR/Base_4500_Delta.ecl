IMPORT SALT311,STD;
EXPORT Base_4500_Delta(DATASET(Base_4500_Layout_EBR)old_s, DATASET(Base_4500_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','total_ucc_filed','coll_count_ucc','coll_code1','coll_desc1','coll_code2','coll_desc2','coll_code3','coll_desc3','coll_code4','coll_desc4','coll_code5','coll_desc5','coll_code6','coll_desc6','coll_code7','coll_desc7','coll_code8','coll_desc8','coll_code9','coll_desc9','coll_code10','coll_desc10','coll_code11','coll_desc11','coll_code12','coll_desc12','addtnl_coll_codes'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_4500_hygiene(old_s).Summary('Old') + Base_4500_hygiene(new_s).Summary('New') + Base_4500_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_4500_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_4500_hygiene(PROJECT(Differences(added), TRANSFORM(Base_4500_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_4500_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
