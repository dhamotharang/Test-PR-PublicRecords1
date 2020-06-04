IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_Scrubs)old_s, DATASET(Layout_Scrubs) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['ZIP_5','Route_Num','ZIP_4','WALK_Sequence','STREET_NUM','STREET_PRE_DIRectional','STREET_NAME','STREET_POST_DIRectional','STREET_SUFFIX','Secondary_Unit_Designator','Secondary_Unit_Number','Address_Vacancy_Indicator','Throw_Back_Indicator','Seasonal_Delivery_Indicator','Seasonal_Start_Suppression_Date','Seasonal_End_Suppression_Date','DND_Indicator','College_Indicator','College_Start_Suppression_Date','College_End_Suppression_Date','Address_Style_Flag','Simplify_Address_Count','Drop_Indicator','Residential_or_Business_Ind','DPBC_Digit','DPBC_Check_Digit','Update_Date','File_Release_Date','Override_file_release_date','County_Num','County_Name','City_Name','State_Code','State_Num','Congressional_District_Number','OWGM_Indicator','Record_Type_Code','ADVO_Key','Address_Type','Mixed_Address_Usage','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','VAC_BEGDT','VAC_ENDDT','MONTHS_VAC_CURR','MONTHS_VAC_MAX','VAC_COUNT','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','RawAID','cleanaid','addresstype','Active_flag'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_Scrubs, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_Scrubs, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Advo, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
