﻿IMPORT SALT311,STD,Corp2_Mapping;
EXPORT Delta(DATASET(Corp2_Mapping.LayoutsCommon.Events)old_s, DATASET(Corp2_Mapping.LayoutsCommon.Events) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','event_filing_reference_nbr','event_amendment_nbr','event_filing_date','event_date_type_cd','event_date_type_desc','event_filing_cd','event_filing_desc','event_corp_nbr','event_corp_nbr_cd','event_corp_nbr_desc','event_roll','event_frame','event_start','event_end','event_microfilm_nbr','event_desc','event_revocation_comment1','event_revocation_comment2','event_book_nbr','event_page_nbr','event_certification_nbr'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Corp2_Mapping.LayoutsCommon.Events, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Corp2_Mapping.LayoutsCommon.Events, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_NH_Event, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
