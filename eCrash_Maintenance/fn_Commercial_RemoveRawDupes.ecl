IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Commercial_RemoveRawDupes() := FUNCTION												
																
 ds_Commercial := FLAccidents_Ecrash.Infiles.commercl;
 Layout_Commercial := FLAccidents_Ecrash.Layout_Infiles.commercial;
	
 ds_Commercial_Unique := DEDUP(ds_Commercial, ALL);
 					
 ds_Commercial_Upd_Out := OUTPUT(ds_Commercial_Unique ,, Files.Commercial_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 ds_Commercial_Cnt := OUTPUT(COUNT(ds_Commercial), NAMED('Count_Commercial'));
 ds_Commercial_Unique_Cnt := OUTPUT(COUNT(ds_Commercial_Unique), NAMED('Count_Commercial_AfterChange'));
 
 New_Commercial_Raw := SEQUENTIAL(ds_Commercial_Cnt,
                                  ds_Commercial_Upd_Out,
												          STD.File.StartSuperFileTransaction(),
												          STD.File.ClearSuperFile(Files.Commercial_Raw_SF, FALSE),
												          STD.File.AddSuperFile(Files.Commercial_Raw_SF, 
																	                      Files.Commercial_Raw_LF('RemoveDupes')),
												          STD.File.FinishSuperFileTransaction(),
																	ds_Commercial_Unique_Cnt
												         );
 RETURN New_Commercial_Raw;
END;