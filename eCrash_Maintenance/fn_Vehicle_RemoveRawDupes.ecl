IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Vehicle_RemoveRawDupes() := FUNCTION												
																
  ds_Vehicle := FLAccidents_Ecrash.Infiles.vehicl;
  Layout_Vehicle := FLAccidents_Ecrash.Layout_Infiles.vehicl_new;
	
 ds_Vehicle_Unique := DEDUP(ds_Vehicle, ALL);
 					
 ds_Vehicle_Upd_Out := OUTPUT(ds_Vehicle_Unique ,, Files.Vehicle_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 ds_Vehicle_Cnt := OUTPUT(COUNT(ds_Vehicle), NAMED('Count_Vehicle'));
 ds_Vehicle_Unique_Cnt := OUTPUT(COUNT(ds_Vehicle_Unique), NAMED('Count_Vehicle_AfterChange'));
 
 New_Vehicle_Raw := SEQUENTIAL(ds_Vehicle_Cnt,
                                  ds_Vehicle_Upd_Out,
												          STD.File.StartSuperFileTransaction(),
												          STD.File.ClearSuperFile(Files.Vehicle_Raw_SF, FALSE),
												          STD.File.AddSuperFile(Files.Vehicle_Raw_SF, 
																	                      Files.Vehicle_Raw_LF('RemoveDupes')),
												          STD.File.FinishSuperFileTransaction(),
																	ds_Vehicle_Unique_Cnt
												         );
 RETURN New_Vehicle_Raw;
END;