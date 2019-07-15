IMPORT SALT311,STD;
EXPORT Base_6510_Delta(DATASET(Base_6510_Layout_EBR)old_s, DATASET(Base_6510_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','orig_date_reported_yymmdd','action_code','action_desc','co_bus_name','co_bus_address','co_bus_city','co_bus_state_code','co_bus_state_desc','co_bus_zip','extent_of_action','agency_code','agency_desc','date_reported','prep_addr_line1','prep_addr_last_line','clean_business_address_prim_range','clean_business_address_prim_name','clean_business_address_p_city_name','clean_business_address_v_city_name','clean_business_address_st','clean_business_address_zip','clean_business_name_title','clean_business_name_fname','clean_business_name_mname','clean_business_name_lname','clean_business_name_name_suffix'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_6510_hygiene(old_s).Summary('Old') + Base_6510_hygiene(new_s).Summary('New') + Base_6510_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_6510_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_6510_hygiene(PROJECT(Differences(added), TRANSFORM(Base_6510_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_6510_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
