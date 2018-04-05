IMPORT SALT38,STD;
EXPORT incident_Delta(DATASET(incident_Layout_SANCTNKeys)old_s, DATASET(incident_Layout_SANCTNKeys) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['batch_number','incident_number','party_number','record_type','order_number','ag_code','case_number','incident_date','jurisdiction','source_document','additional_info','agency','alleged_amount','estimated_loss','fcr_date','ok_for_fcr','modified_date','load_date','incident_text','incident_date_clean','fcr_date_clean','cln_modified_date','cln_load_date'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := incident_hygiene(old_s).Summary('Old') + incident_hygiene(new_s).Summary('New') + incident_hygiene(PROJECT(Differences(deleted), TRANSFORM(incident_Layout_SANCTNKeys, SELF := LEFT.old_rec))).Summary('Deletions') + incident_hygiene(PROJECT(Differences(added), TRANSFORM(incident_Layout_SANCTNKeys, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SANCTNKeys, incident_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
