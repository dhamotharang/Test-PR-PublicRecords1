IMPORT SALT311,STD;
EXPORT Base_Delta(DATASET(Base_Layout_Frandx)old_s, DATASET(Base_Layout_Frandx) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['ace_aid','address1','brand_name','chk_digit','city','clean_phone','clean_secondary_phone','company_name','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','err_stat','fips_county','fips_state','franchisee_id','fruns','f_units','industry','industry_type','p_city_name','phone','phone_extension','prim_name','record_id','record_type','relationship_code','relationship_code_exp','secondary_phone','sector','sic_code','state','unit_flag','unit_flag_exp','v_city_name','zip_code','zip_code4'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_hygiene(old_s).Summary('Old') + Base_hygiene(new_s).Summary('New') + Base_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Layout_Frandx, SELF := LEFT.old_rec))).Summary('Deletions') + Base_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Layout_Frandx, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Frandx, Base_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
