IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Document_RemoveRawDupes() := FUNCTION												
																
 ds_Document_Unique := FLAccidents_Ecrash.Infiles.Document;
 Layout_Document := FLAccidents_Ecrash.Layout_Infiles.Document;
				
 ds_Document_Upd_Out := OUTPUT(ds_Document_Unique ,, Files.Document_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 
 New_Document_Raw := SEQUENTIAL(
                                ds_Document_Upd_Out,
												        STD.File.StartSuperFileTransaction(),
												        STD.File.ClearSuperFile(Files.Document_Raw_SF, FALSE),
												        STD.File.AddSuperFile(Files.Document_Raw_SF, 
																                      Files.Document_Raw_LF('RemoveDupes')),
												        STD.File.FinishSuperFileTransaction()
												       );
 RETURN New_Document_Raw;
END;