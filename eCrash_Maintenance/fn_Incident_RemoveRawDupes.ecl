IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Incident_RemoveRawDupes() := FUNCTION												
																
 ds_Incident_Unique := FLAccidents_Ecrash.Infiles.incident;
 Layout_Incident := FLAccidents_Ecrash.Layout_Infiles.incident_new;
 					
 ds_Incident_Upd_Out := OUTPUT(ds_Incident_Unique ,, Files.Incident_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 
 New_Incident_Raw := SEQUENTIAL(
                                ds_Incident_Upd_Out,
												        STD.File.StartSuperFileTransaction(),
												        STD.File.ClearSuperFile(Files.Incident_Raw_SF, FALSE),
												        STD.File.AddSuperFile(Files.Incident_Raw_SF, 
																                      Files.Incident_Raw_LF('RemoveDupes')),
												        STD.File.FinishSuperFileTransaction()
												       );
 RETURN New_Incident_Raw;
END;