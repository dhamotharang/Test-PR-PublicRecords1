IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_BK_Events)old_s, DATASET(Layout_BK_Events) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dractivitytypecode','docketentryid','courtid','casekey','casetype','bkcasenumber','bkcasenumberurl','proceedingscasenumber','proceedingscasenumberurl','caseid','pacercaseid','attachmenturl','entrynumber','entereddate','pacer_entereddate','fileddate','score','drcategoryeventid','court_code','district','boca_court','catevent_description','catevent_category'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_BK_Events, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_BK_Events, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BK_Events, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
