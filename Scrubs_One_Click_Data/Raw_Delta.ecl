IMPORT SALT311,STD;
EXPORT Raw_Delta(DATASET(Raw_Layout_One_Click_Data)old_s, DATASET(Raw_Layout_One_Click_Data) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['ssn','firstname','lastname','dob','homeaddress','homecity','homestate','homezip','homephone','mobilephone','emailaddress','workname','workaddress','workcity','workstate','workzip','workphone','ref1firstname','ref1lastname','ref1phone','lastinquirydate','ip'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Raw_hygiene(old_s).Summary('Old') + Raw_hygiene(new_s).Summary('New') + Raw_hygiene(PROJECT(Differences(deleted), TRANSFORM(Raw_Layout_One_Click_Data, SELF := LEFT.old_rec))).Summary('Deletions') + Raw_hygiene(PROJECT(Differences(added), TRANSFORM(Raw_Layout_One_Click_Data, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_One_Click_Data, Raw_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
