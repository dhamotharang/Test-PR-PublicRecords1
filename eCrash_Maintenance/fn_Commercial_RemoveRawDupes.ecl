IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Commercial_RemoveRawDupes() := FUNCTION												
																
 ds_Commercial_Unique := FLAccidents_Ecrash.Infiles.commercl;
 Layout_Commercial := FLAccidents_Ecrash.Layout_Infiles.commercial;
 					
 ds_Commercial_Upd_Out := OUTPUT(ds_Commercial_Unique ,, Files.Commercial_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 
 New_Commercial_Raw := SEQUENTIAL(
                                  ds_Commercial_Upd_Out,
												          STD.File.StartSuperFileTransaction(),
												          STD.File.ClearSuperFile(Files.Commercial_Raw_SF, FALSE),
												          STD.File.AddSuperFile(Files.Commercial_Raw_SF, 
																	                      Files.Commercial_Raw_LF('RemoveDupes')),
												          STD.File.FinishSuperFileTransaction(),
												         );
 RETURN New_Commercial_Raw;
END;