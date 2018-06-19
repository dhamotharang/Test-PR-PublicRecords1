IMPORT SALT39,STD;
EXPORT Delta(DATASET(Layout_File)old_s, DATASET(Layout_File) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['did','rid','pflag1','pflag2','pflag3','src','dt_first_seen','dt_last_seen','dt_vendor_last_reported','dt_vendor_first_reported','dt_nonglb_last_seen','rec_type','vendor_id','phone','ssn','dob','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','county','geo_blk','cbsa','tnt','valid_ssn','jflag1','jflag2','jflag3','rawaid','dodgy_tracking','nid','address_ind','name_ind','persistent_record_id'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_File, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_File, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Headers_Monthly, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
