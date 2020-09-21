IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Document_RemoveRawDupes() := FUNCTION												
																
 ds_Document := FLAccidents_Ecrash.Infiles.Document;
 Layout_Document := FLAccidents_Ecrash.Layout_Infiles.Document;
	
 ds_Document_Unique := DEDUP(ds_Document, ALL);
 					
 ds_Document_Upd_Out := OUTPUT(ds_Document_Unique ,, Files.Document_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 ds_Document_Cnt := OUTPUT(COUNT(ds_Document), NAMED('Count_Document'));
 ds_Document_Unique_Cnt := OUTPUT(COUNT(ds_Document_Unique), NAMED('Count_Document_AfterChange'));
 
 New_Document_Raw := SEQUENTIAL(ds_Document_Cnt,
                                ds_Document_Upd_Out,
												        STD.File.StartSuperFileTransaction(),
												        STD.File.ClearSuperFile(Files.Document_Raw_SF, FALSE),
												        STD.File.AddSuperFile(Files.Document_Raw_SF, 
																                      Files.Document_Raw_LF('RemoveDupes')),
												        STD.File.FinishSuperFileTransaction(),
																ds_Document_Unique_Cnt
												       );
 RETURN New_Document_Raw;
END;