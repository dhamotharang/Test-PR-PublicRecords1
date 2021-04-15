IMPORT STD;

  ToSupressSet := SET(Files_eCrash.DS_BASE_SUPPRESS_INCIDENTS, Incident_ID);
  Incidents := DEDUP(FLAccidents_Ecrash.Infiles.tincident, ALL);
  IncidentsSuppressed := Incidents(~(TRIM(case_identifier, LEFT, RIGHT) IN  FLAccidents_Ecrash.Suppress_Id AND source_id IN ['EA', 'TF']) AND 
                                   (TRIM(report_id, LEFT, RIGHT) NOT IN FLAccidents_Ecrash.Suppress_report_d) AND 
                                   (TRIM(incident_id, LEFT, RIGHT) NOT IN FLAccidents_Ecrash.supress_incident_id) AND
                                   (TRIM(incident_id, LEFT, RIGHT) NOT IN ToSupressSet)
                                  );

  EXPORT IncidentsAfterSuppression := JOIN(IncidentsSuppressed, Files_eCrash.DS_BASE_ECRASH_DELETES, 
                                           TRIM(LEFT.case_identifier, LEFT, RIGHT) = TRIM(RIGHT.case_identifier, LEFT, RIGHT) AND 
                                           TRIM(LEFT.State_Report_Number, LEFT, RIGHT) = TRIM(RIGHT.State_Report_Number, LEFT, RIGHT) AND 
                                           TRIM(LEFT.Source_ID , LEFT, RIGHT)= TRIM(RIGHT.Source_ID, LEFT, RIGHT) AND 
                                           TRIM(LEFT.Loss_State_Abbr, LEFT, RIGHT) = TRIM(RIGHT.Loss_State_Abbr, LEFT, RIGHT) AND 
                                           STD.Str.FilterOut(TRIM(LEFT.Crash_Date, LEFT, RIGHT), '-') = STD.Str.FilterOut(TRIM(RIGHT.Crash_Date, LEFT, RIGHT),'-') AND 
                                           TRIM(LEFT.Agency_ID, LEFT, RIGHT) = TRIM(RIGHT.Agency_ID, LEFT, RIGHT) AND 
                                           TRIM(LEFT.Work_Type_ID , LEFT, RIGHT)= TRIM(RIGHT.Work_Type_ID, LEFT, RIGHT), MANY LOOKUP, LEFT ONLY):PERSIST('~thor_data::persist::eCrash_IncidentsAfterSuppression');
