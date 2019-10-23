IMPORT SALT310,STD;
EXPORT Base_Delta(DATASET(Base_Layout_QA_Data)old_s, DATASET(Base_Layout_QA_Data) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawtrans_masteraddressid','rawtrans_date','rawtrans_category','rawaddr_databasematchcode','rawaddr_homebusinessflag','rawaddr_masteraddressid','prep_trans_line1','prep_trans_line_last','prep_addr_line1','prep_addr_line_last','trans_address_prim_name','trans_address_p_city_name','trans_address_v_city_name','trans_address_st','trans_address_zip','addr_address_prim_name','addr_address_p_city_name','addr_address_v_city_name','addr_address_st','addr_address_zip','clean_person_type','clean_person_name_fname','clean_person_name_lname','clean_phone','clean_company','nametype','source_rec_id'];
  EXPORT Differences := SALT310.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_hygiene(old_s).Summary('Old') + Base_hygiene(new_s).Summary('New') + Base_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Layout_QA_Data, SELF := LEFT.old_rec))).Summary('Deletions') + Base_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Layout_QA_Data, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT310.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT310.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_QA_Data, Base_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
