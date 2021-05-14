IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Citation_RemoveRawDupes() := FUNCTION												
																
 ds_Citation_Unique := FLAccidents_Ecrash.Infiles.citation;
 Layout_Citation := FLAccidents_Ecrash.Layout_Infiles.citation;
	
 ds_Citation_Upd_Out := OUTPUT(ds_Citation_Unique ,, Files.Citation_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 
 New_Citation_Raw := SEQUENTIAL(ds_Citation_Upd_Out,
												        STD.File.StartSuperFileTransaction(),
												        STD.File.ClearSuperFile(Files.Citation_Raw_SF, FALSE),
												        STD.File.AddSuperFile(Files.Citation_Raw_SF, 
																                      Files.Citation_Raw_LF('RemoveDupes')),
												        STD.File.FinishSuperFileTransaction(),
												       );
 RETURN New_Citation_Raw;
END;