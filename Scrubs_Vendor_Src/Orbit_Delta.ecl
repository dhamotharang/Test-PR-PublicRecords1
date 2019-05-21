IMPORT SALT311,STD;
EXPORT Orbit_Delta(DATASET(Orbit_Layout_Vendor_Src)old_s, DATASET(Orbit_Layout_Vendor_Src) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['item_id','item_name','item_description','status_name','item_source_code','source_id','source_name','source_address1','source_address2','source_city','source_state','source_zip','source_phone','source_website','unused_source_sourcecodes','unused_fcra','unused_fcra_comments','market_restrict_flag','unused_market_comments','unused_contact_category_name','unused_contact_name','unused_contact_phone','unused_contact_email'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Orbit_hygiene(old_s).Summary('Old') + Orbit_hygiene(new_s).Summary('New') + Orbit_hygiene(PROJECT(Differences(deleted), TRANSFORM(Orbit_Layout_Vendor_Src, SELF := LEFT.old_rec))).Summary('Deletions') + Orbit_hygiene(PROJECT(Differences(added), TRANSFORM(Orbit_Layout_Vendor_Src, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Vendor_Src, Orbit_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
