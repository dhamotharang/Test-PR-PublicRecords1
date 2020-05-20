IMPORT SALT311,STD;
EXPORT RDP_Delta(DATASET(RDP_Layout_RDP)old_s, DATASET(RDP_Layout_RDP) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['Transaction_ID','TransactionDate','FirstName','LastName','MiddleName','Suffix','BirthDate','SSN','Lexid_Input','Street1','Street2','Suite','City','State','Zip5','Phone','Lexid_Discovered','RemoteIPAddress','ConsumerIPAddress','Email_Address'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := RDP_hygiene(old_s).Summary('Old') + RDP_hygiene(new_s).Summary('New') + RDP_hygiene(PROJECT(Differences(deleted), TRANSFORM(RDP_Layout_RDP, SELF := LEFT.old_rec))).Summary('Deletions') + RDP_hygiene(PROJECT(Differences(added), TRANSFORM(RDP_Layout_RDP, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, RDP_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
