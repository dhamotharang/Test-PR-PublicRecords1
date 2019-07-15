IMPORT SALT311,STD;
EXPORT Base_5000_Delta(DATASET(Base_5000_Layout_EBR)old_s, DATASET(Base_5000_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','name','street_address','city','state_code','state_desc','zip_code','telephone','relationship_code','relationship_desc','bal_range_code','acct_bal_range_code','nbr_fig_in_bal','acct_bal_total','acct_rating_code','date_acct_opened_ymd','date_acct_closed_ymd','name_addr_key','append_rawaid','append_aceaid','prep_addr_line1','prep_addr_last_line','clean_address_predir','clean_address_prim_name','clean_address_postdir','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_5000_hygiene(old_s).Summary('Old') + Base_5000_hygiene(new_s).Summary('New') + Base_5000_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_5000_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_5000_hygiene(PROJECT(Differences(added), TRANSFORM(Base_5000_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_5000_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
