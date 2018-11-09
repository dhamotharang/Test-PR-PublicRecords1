IMPORT SALT38,STD;
EXPORT DID_SSN_Delta(DATASET(DID_SSN_Layout_FCRA_Opt_Out)old_s, DATASET(DID_SSN_Layout_FCRA_Opt_Out) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['ssn','did','source_flag','julian_date','inname_first','inname_last','address','city','state','zip5','did_score','ssn_append','permanent_flag','opt_back_in','date_yyyymmdd'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := DID_SSN_hygiene(old_s).Summary('Old') + DID_SSN_hygiene(new_s).Summary('New') + DID_SSN_hygiene(PROJECT(Differences(deleted), TRANSFORM(DID_SSN_Layout_FCRA_Opt_Out, SELF := LEFT.old_rec))).Summary('Deletions') + DID_SSN_hygiene(PROJECT(Differences(added), TRANSFORM(DID_SSN_Layout_FCRA_Opt_Out, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FCRA_Opt_Out, DID_SSN_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
