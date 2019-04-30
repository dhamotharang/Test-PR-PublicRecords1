﻿IMPORT SALT311,STD;
EXPORT MasterList_Delta(DATASET(MasterList_Layout_Vendor_Src)old_s, DATASET(MasterList_Layout_Vendor_Src) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['lnfilecategory','lnsourcetcode','vendorname','address1','address2','city','state','zipcode','phone'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := MasterList_hygiene(old_s).Summary('Old') + MasterList_hygiene(new_s).Summary('New') + MasterList_hygiene(PROJECT(Differences(deleted), TRANSFORM(MasterList_Layout_Vendor_Src, SELF := LEFT.old_rec))).Summary('Deletions') + MasterList_hygiene(PROJECT(Differences(added), TRANSFORM(MasterList_Layout_Vendor_Src, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Vendor_Src, MasterList_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
