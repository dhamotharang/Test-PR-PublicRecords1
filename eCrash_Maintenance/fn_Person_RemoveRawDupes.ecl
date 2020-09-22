IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Person_RemoveRawDupes() := FUNCTION												
																
  ds_Person := FLAccidents_Ecrash.Infiles.persn;
  Layout_Person := FLAccidents_Ecrash.Layout_Infiles.persn_new;
	
 ds_Person_Unique := DEDUP(ds_Person, ALL);
 					
 ds_Person_Upd_Out := OUTPUT(ds_Person_Unique ,, Files.Person_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 ds_Person_Cnt := OUTPUT(COUNT(ds_Person), NAMED('Count_Person'));
 ds_Person_Unique_Cnt := OUTPUT(COUNT(ds_Person_Unique), NAMED('Count_Person_AfterChange'));
 
 New_Person_Raw := SEQUENTIAL(ds_Person_Cnt,
                                  ds_Person_Upd_Out,
												          STD.File.StartSuperFileTransaction(),
												          STD.File.ClearSuperFile(Files.Person_Raw_SF, FALSE),
												          STD.File.AddSuperFile(Files.Person_Raw_SF, 
																	                      Files.Person_Raw_LF('RemoveDupes')),
												          STD.File.FinishSuperFileTransaction(),
																	ds_Person_Unique_Cnt
												         );
 RETURN New_Person_Raw;
END;