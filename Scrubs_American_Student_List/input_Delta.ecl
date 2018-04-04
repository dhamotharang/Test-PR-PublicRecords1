IMPORT SALT38,STD;
EXPORT input_Delta(DATASET(input_Layout_American_Student_List)old_s, DATASET(input_Layout_American_Student_List) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['name','first_name','last_name','address_1','address_2','city','state','z5','zip_4','crrt_code','delivery_point_barcode','zip4_check_digit','address_type','county_number','county_name','gender','age','birth_date','telephone','class','college_class','college_name','college_major','college_code','college_type','head_of_household_first_name','head_of_household_gender','income_level','file_type'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := input_hygiene(old_s).Summary('Old') + input_hygiene(new_s).Summary('New') + input_hygiene(PROJECT(Differences(deleted), TRANSFORM(input_Layout_American_Student_List, SELF := LEFT.old_rec))).Summary('Deletions') + input_hygiene(PROJECT(Differences(added), TRANSFORM(input_Layout_American_Student_List, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_American_Student_List, input_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
