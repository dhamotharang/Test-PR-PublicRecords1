IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Vehicle_RemoveRawDupes() := FUNCTION												
																
 ds_Vehicle_Unique := FLAccidents_Ecrash.Infiles.vehicl;
 Layout_Vehicle := FLAccidents_Ecrash.Layout_Infiles.vehicl_new;
 
 ds_Vehicle_Upd_Out := OUTPUT(ds_Vehicle_Unique ,, Files.Vehicle_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 
 New_Vehicle_Raw := SEQUENTIAL(
                               ds_Vehicle_Upd_Out,
												       STD.File.StartSuperFileTransaction(),
												       STD.File.ClearSuperFile(Files.Vehicle_Raw_SF, FALSE),
												       STD.File.AddSuperFile(Files.Vehicle_Raw_SF, 
																                     Files.Vehicle_Raw_LF('RemoveDupes')),
												       STD.File.FinishSuperFileTransaction()
												      );
 RETURN New_Vehicle_Raw;
END;