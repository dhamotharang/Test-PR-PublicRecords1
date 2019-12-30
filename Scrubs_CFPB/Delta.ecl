IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_CFPB)old_s, DATASET(Layout_CFPB) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['record_sid','global_src_id','dt_vendor_first_reported','dt_vendor_last_reported','is_latest','seqno','geoid10_blkgrp','state_fips10','county_fips10','tract_fips10','blkgrp_fips10','total_pop','hispanic_total','non_hispanic_total','nh_white_alone','nh_black_alone','nh_aian_alone','nh_api_alone','nh_other_alone','nh_mult_total','nh_white_other','nh_black_other','nh_aian_other','nh_asian_hpi','nh_api_other','nh_asian_hpi_other'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_CFPB, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_CFPB, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_CFPB, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
