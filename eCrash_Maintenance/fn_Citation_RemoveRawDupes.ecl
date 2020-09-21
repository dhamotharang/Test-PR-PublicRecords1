IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Citation_RemoveRawDupes() := FUNCTION												
																
  ds_Citation := FLAccidents_Ecrash.Infiles.citation;
  Layout_Citation := FLAccidents_Ecrash.Layout_Infiles.citation;
	
 ds_Citation_Unique := DEDUP(ds_Citation, ALL);
 					
 ds_Citation_Upd_Out := OUTPUT(ds_Citation_Unique ,, Files.Citation_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 ds_Citation_Cnt := OUTPUT(COUNT(ds_Citation), NAMED('Count_Citation'));
 ds_Citation_Unique_Cnt := OUTPUT(COUNT(ds_Citation_Unique), NAMED('Count_Citation_AfterChange'));
 
 New_Citation_Raw := SEQUENTIAL(ds_Citation_Cnt,
                                  ds_Citation_Upd_Out,
												          STD.File.StartSuperFileTransaction(),
												          STD.File.ClearSuperFile(Files.Citation_Raw_SF, FALSE),
												          STD.File.AddSuperFile(Files.Citation_Raw_SF, 
																	                      Files.Citation_Raw_LF('RemoveDupes')),
												          STD.File.FinishSuperFileTransaction(),
																	ds_Citation_Unique_Cnt
												         );
 RETURN New_Citation_Raw;
END;