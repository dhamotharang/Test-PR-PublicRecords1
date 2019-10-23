IMPORT SALT311,STD;
EXPORT Base_5600_Delta(DATASET(Base_5600_Layout_EBR)old_s, DATASET(Base_5600_Layout_EBR) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','sic_1_code','sic_1_desc','sic_2_code','sic_2_desc','sic_3_code','sic_3_desc','sic_4_code','sic_4_desc','yrs_in_bus_actual','sales_actual','empl_size_actual','bus_type_code','bus_type_desc','owner_type_code','owner_type_desc','location_code','location_desc'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_5600_hygiene(old_s).Summary('Old') + Base_5600_hygiene(new_s).Summary('New') + Base_5600_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_5600_Layout_EBR, SELF := LEFT.old_rec))).Summary('Deletions') + Base_5600_hygiene(PROJECT(Differences(added), TRANSFORM(Base_5600_Layout_EBR, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_5600_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
