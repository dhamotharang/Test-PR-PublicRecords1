IMPORT SALT311,STD;
EXPORT Input_Delta(DATASET(Input_Layout_Frandx)old_s, DATASET(Input_Layout_Frandx) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['address1','address2','brand_name','city','company_name','exec_full_name','franchisee_id','fruns','industry','industry_type','phone','phone_extension','record_id','relationship_code','secondary_phone','sector','sic_code','state','unit_flag','zip_code','zip_code4'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Input_hygiene(old_s).Summary('Old') + Input_hygiene(new_s).Summary('New') + Input_hygiene(PROJECT(Differences(deleted), TRANSFORM(Input_Layout_Frandx, SELF := LEFT.old_rec))).Summary('Deletions') + Input_hygiene(PROJECT(Differences(added), TRANSFORM(Input_Layout_Frandx, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Frandx, Input_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
