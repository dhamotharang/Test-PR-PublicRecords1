IMPORT SALT38,STD;
EXPORT Address_Delta(DATASET(Address_Layout_FCRA_Opt_Out)old_s, DATASET(Address_Layout_FCRA_Opt_Out) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['z5','prim_range','prim_name','sec_range','ssn','did','source_flag','julian_date','inname_first','inname_last','address','city','state','zip5','did_score','ssn_append','permanent_flag','opt_back_in','date_yyyymmdd'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Address_hygiene(old_s).Summary('Old') + Address_hygiene(new_s).Summary('New') + Address_hygiene(PROJECT(Differences(deleted), TRANSFORM(Address_Layout_FCRA_Opt_Out, SELF := LEFT.old_rec))).Summary('Deletions') + Address_hygiene(PROJECT(Differences(added), TRANSFORM(Address_Layout_FCRA_Opt_Out, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FCRA_Opt_Out, Address_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
