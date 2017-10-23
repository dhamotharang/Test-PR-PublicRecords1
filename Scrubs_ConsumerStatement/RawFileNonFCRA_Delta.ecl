IMPORT SALT38,STD;
EXPORT RawFileNonFCRA_Delta(DATASET(RawFileNonFCRA_Layout_ConsumerStatement)old_s, DATASET(RawFileNonFCRA_Layout_ConsumerStatement) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['statement_id','orig_fname','orig_lname','orig_mname','orig_cname','orig_address','orig_city','orig_st','orig_zip','orig_zip4','phone','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','date_submitted','date_created','did','consumer_text','override_flag'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := RawFileNonFCRA_hygiene(old_s).Summary('Old') + RawFileNonFCRA_hygiene(new_s).Summary('New') + RawFileNonFCRA_hygiene(PROJECT(Differences(deleted), TRANSFORM(RawFileNonFCRA_Layout_ConsumerStatement, SELF := LEFT.old_rec))).Summary('Deletions') + RawFileNonFCRA_hygiene(PROJECT(Differences(added), TRANSFORM(RawFileNonFCRA_Layout_ConsumerStatement, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_ConsumerStatement, RawFileNonFCRA_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
