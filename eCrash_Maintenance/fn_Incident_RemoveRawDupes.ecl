IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Incident_RemoveRawDupes() := FUNCTION												
																
  ds_Incident := FLAccidents_Ecrash.Infiles.incident;
  Layout_Incident := FLAccidents_Ecrash.Layout_Infiles.incident_new;
	
 ds_Incident_Unique := DEDUP(ds_Incident, ALL);
 					
 ds_Incident_Upd_Out := OUTPUT(ds_Incident_Unique ,, Files.Incident_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 ds_Incident_Cnt := OUTPUT(COUNT(ds_Incident), NAMED('Count_Incident'));
 ds_Incident_Unique_Cnt := OUTPUT(COUNT(ds_Incident_Unique), NAMED('Count_Incident_AfterChange'));
 
 New_Incident_Raw := SEQUENTIAL(ds_Incident_Cnt,
                                  ds_Incident_Upd_Out,
												          STD.File.StartSuperFileTransaction(),
												          STD.File.ClearSuperFile(Files.Incident_Raw_SF, FALSE),
												          STD.File.AddSuperFile(Files.Incident_Raw_SF, 
																	                      Files.Incident_Raw_LF('RemoveDupes')),
												          STD.File.FinishSuperFileTransaction(),
																	ds_Incident_Unique_Cnt
												         );
 RETURN New_Incident_Raw;
END;