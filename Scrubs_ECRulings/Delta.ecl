IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_ECRulings)old_s, DATASET(Layout_ECRulings) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dartid','dateadded','dateupdated','website','state','euid','policyarea','casenumber','memberstate','lastdecisiondate','title','businessname','region','primaryobjective','aidinstrument','casetype','durationdatefrom','durationdateto','notificationregistrationdate','dgresponsible','relatedcasenumber1','relatedcaseinformation1','relatedcasenumber2','relatedcaseinformation2','relatedcasenumber3','relatedcaseinformation3','relatedcasenumber4','relatedcaseinformation4','relatedcasenumber5','relatedcaseinformation5','provisionaldeadlinedate','provisionaldeadlinearticle','provisionaldeadlinestatus','regulation','relatedlink','decpubid','decisiondate','decisionarticle','decisiondetails','pressrelease','pressreleasedate','publicationjournaldate','publicationjournal','publicationjournaledition','publicationjournalyear','publicationpriorjournal','publicationpriorjournaldate','econactid','economicactivity','compeventid','eventdate','eventdoctype','eventdocument','did','bdid','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','eu_country_code'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_ECRulings, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_ECRulings, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_ECRulings, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
