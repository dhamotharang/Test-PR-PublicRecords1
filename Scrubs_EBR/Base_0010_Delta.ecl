IMPORT SALT311,STD;
EXPORT Base_0010_Delta(DATASET(Base_0010_Layout_EBR)old_s, DATASET(Base_0010_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','orig_extract_date_mdy','company_name','phone_number','sic_code','business_desc','extract_date','file_estab_date','prep_addr_line1','prep_addr_last_line','source_rec_id','clean_address_prim_name','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_0010_hygiene(old_s).Summary('Old') + Base_0010_hygiene(new_s).Summary('New') + Base_0010_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_0010_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_0010_hygiene(PROJECT(Differences(added), TRANSFORM(Base_0010_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_0010_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
