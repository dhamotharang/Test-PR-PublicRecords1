IMPORT SALT39,STD;
EXPORT ProductInclude_Delta(DATASET(ProductInclude_Layout_ProductInclude)old_s, DATASET(ProductInclude_Layout_ProductInclude) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['fdn_file_product_include_id','fdn_file_info_id','product_id','status','date_added','user_added','date_changed','user_changed'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := ProductInclude_hygiene(old_s).Summary('Old') + ProductInclude_hygiene(new_s).Summary('New') + ProductInclude_hygiene(PROJECT(Differences(deleted), TRANSFORM(ProductInclude_Layout_ProductInclude, SELF := LEFT.old_rec))).Summary('Deletions') + ProductInclude_hygiene(PROJECT(Differences(added), TRANSFORM(ProductInclude_Layout_ProductInclude, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, ProductInclude_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
